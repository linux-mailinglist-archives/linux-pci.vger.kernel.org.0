Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500BC7903E1
	for <lists+linux-pci@lfdr.de>; Sat,  2 Sep 2023 00:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237598AbjIAW6C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Sep 2023 18:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjIAW6B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Sep 2023 18:58:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FF0133;
        Fri,  1 Sep 2023 15:57:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4404F61C61;
        Fri,  1 Sep 2023 22:57:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54819C433C8;
        Fri,  1 Sep 2023 22:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693609077;
        bh=5eALkIhha7aFeN9hFn3dpehtVKhfx5imtXXtUfBTk+8=;
        h=Date:From:To:Cc:Subject:From;
        b=bc1N5nkpVr1R2an8KFBetbY0kF6kEvqCmq/IRcQwc+STMrrisjOlC9kVlVWoEPC2t
         57vmHGsI7w14kalkQqrs3tMzw6inc8NlNbM6Fwh1OeLZkpjzLJrGYJcYrqVxXUQHrR
         arqlL9k9P3sWlwylBblomh0VwTSyXnwn9dgY4cH7bk35LQZISkWYYrtjJkYqXsfmCE
         phBkgGzI5GsJEAHLHP22MH7y3fOAqxYLo6J3nRZZMV6XAiomPWR58ulgRH+IcHRkfC
         odsrmlUWgxNmr3ybqcb8qBCUBNn5jX2opDKz/v2OJFyoe6aMyJGtahFyMjswUpCcrp
         AbUABVz7D2niA==
Date:   Fri, 1 Sep 2023 17:57:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huang Ying <ying.huang@intel.com>,
        Shiju Jose <shiju.jose@huawei.com>,
        James Morse <james.morse@arm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: GHES/AER synchronization missing?
Message-ID: <20230901225755.GA90053@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

TL;DR: I think ghes_handle_aer() lacks synchronization with
aer_recover_work_func(), so aer_recover_work_func() may use estatus
data after it's been overwritten.

Sorry this is so long; it took me a long time to get this far, and I
might be in the weeds.  Here's the execution path I'm looking at:

  ghes_proc(struct ghes *ghes)
    estatus = ghes->estatus          # linux kernel buffer
    ghes_read_estatus(estatus, &buf_paddr)          # copy fw mem to estatus
    ghes_do_proc(estatus)
      apei_estatus_for_each_section(estatus, gdata)
        if (gdata is CPER_SEC_PCIE)
          ghes_handle_aer(gdata)     # pointer into estatus
            struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata)
            aer_recover_queue(..., pcie_err->aer_info)
              entry.regs = aer_regs  # pointer to struct aer_capability_regs
              kfifo_in(&aer_recover_ring, &entry)   # copy pointer into FIFO
  ...
  aer_recover_work_func
    kfifo_get(&aer_recover_ring, &entry)
    cper_print_aer(entry.regs)       # use aer_capability_regs values

I'm confused because I don't see what ensures that the
aer_capability_regs values, which I think are somewhere in the
ghes->estatus buffer, are preserved until aer_recover_work_func() is
finished with them.

Here's my understanding of the general flow:

  - hest_parse_ghes() adds a GHES platform device for each HEST Error
    Source descriptor of type 9 (Generic Hardware Error Source) or
    type 10 (Generic Hardware Error Source version 2).

  - Each HEST GHES entry has an Error Status Address that tells us
    about some range of firmware reserved memory that will contain
    error status data for the device.

  - ghes_probe() claims each GHES platform device.  It maps the Error
    Status Address once (so I guess the address of the firmware memory
    must be fixed for the life of the system?) and allocates a
    ghes->estatus buffer in kernel memory.

  - When the platform notifies OSPM of a GHES event, ghes_proc()
    copies error status data from the Error Status Address firmware
    memory to the ghes->estatus buffer.

  - The error status data may have multiple sections.  ghes_do_proc()
    iterates through each section in the ghes->estatus buffer.  PCIe
    sections contain a struct aer_capability_regs that has values of
    all the AER Capability registers, and ghes_handle_aer() passes a
    pointer to the struct aer_capability_regs to aer_recover_queue().

  - This struct aer_capability_regs pointer is a pointer into the
    ghes->estatus buffer.  aer_recover_queue() copies that pointer
    into the aer_recover_ring fifo and schedules
    aer_recover_work_func() for later execution.

  - aer_recover_work_func() reads the struct aer_capability_regs data
    at some future time.

  - ghes_proc() does not know when aer_recover_work_func() is finished
    with the struct aer_capability_regs data.

Am I missing a mechanism that prevents a second ghes_proc() invocation
from overwriting ghes->estatus before the first aer_recover_work_func()
is finished?

The ghes_defer_non_standard_event() case added by Shiju and James in
9aa9cf3ee945 ("ACPI / APEI: Add a notifier chain for unknown (vendor)
CPER records") also schedules future work, but it copies the data
needed for that work.  It seems like ghes_handle_aer() maybe should do
something similar?

Bjorn
