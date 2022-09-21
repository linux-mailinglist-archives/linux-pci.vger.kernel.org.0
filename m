Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C86A5D1BCA
	for <lists+linux-pci@lfdr.de>; Wed, 21 Sep 2022 20:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiIUSDo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Sep 2022 14:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiIUSDo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Sep 2022 14:03:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57667E810
        for <linux-pci@vger.kernel.org>; Wed, 21 Sep 2022 11:03:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64118B83267
        for <linux-pci@vger.kernel.org>; Wed, 21 Sep 2022 18:03:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA41C433D6;
        Wed, 21 Sep 2022 18:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663783418;
        bh=ov3BFrcrZNNeoVYUDJvf9y25AHwzf2SCgSVmjckgR4s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=teWoyUWKjhghqSK3ZfMn52y7SCVqHxEde0J3aUfKZtpF2/NBof78a0NUmL1D/tbfW
         /ZUsvOn67ayvXxMpNeQiTgqx5zAr8Fno6tZfHB1yAQkrqe8SjE332f50IB+WmFaH3f
         lWkeMdzvE/YGWvC3M0OLP9jQx4nHMlTzfgObw7FkXXy1hP+KG6JceuTVyV1lFAnOJf
         EsNx/0BMiSiq4huOdLAxoEI8bk64c1ysejPRhPUIhsIOSrHdgU0Kg66LE96EaV1I7Y
         SInXy43911a3Xso17KNgB5Y/GWAJBZ74oRWSh4B9aSXKQIBxCKqoVqblpVvs9QeGQ5
         FcnAU1JyOB64Q==
Date:   Wed, 21 Sep 2022 13:03:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
Cc:     Richard Weinberger <richard@nod.at>, aaron@sigma-star.at
Subject: Re: [bugzilla-daemon@kernel.org: [Bug 216511] New: Spurious
 PCI_EXP_SLTSTA_DLLSC when hot plugging]
Message-ID: <20220921180326.GA1221419@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921114020.GA1191462@bhelgaas>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 21, 2022 at 06:40:20AM -0500, Bjorn Helgaas wrote:
> ----- Forwarded message from bugzilla-daemon@kernel.org -----
> 
> Date: Wed, 21 Sep 2022 11:30:47 +0000
> From: bugzilla-daemon@kernel.org
> To: bjorn@helgaas.com
> Subject: [Bug 216511] New: Spurious PCI_EXP_SLTSTA_DLLSC when hot plugging
> Message-ID: <bug-216511-41252@https.bugzilla.kernel.org/>
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=216511
> 
>             Bug ID: 216511
>            Summary: Spurious PCI_EXP_SLTSTA_DLLSC when hot plugging
> ... 
> A x86_64 machine has a PCI switch (PEX 8747) with four ports, on two of them
> NVMe disks are attachable.
> Using a vendor specific tool I can power on/off each port.
> When I power on both ports, hot plugging a NVMe into any port, it works
> perfectly fine,
> but as soon I plug a second one, *both* ports receive a PCI_EXP_SLTSTA_DLLSC
> event.
> As consequence the previously attached NVMe will be detached and only device
> remains, or the previously attached NVMe gets detached and immediately
> reattached but all IO fails later.
> 
> To me it seems very wrong that both ports see PCI_EXP_SLTSTA_DLLSC.
> 
> The problem can be observed with any kernel so far.
> Could this be a firmware issue? What debug further methods do you suggest?

Relevant devices from lspci:

  0a:00.0 PLX 8748 Upstream Port   to [bus 0b-1b]
  0b:08.0 PLX 8747 Downstream Port to [bus 0c-0f]  # Slot 0
  0c:00.0 NVMe
  0b:09.0 PLX 8747 Downstream Port to [bus 10-13]  # Slot 0-1
  10:00.0 NVMe

From dmesg log, we add 10:00.0 in Slot 0-1 first, then add 0c:00.0 in
Slot 0.  When 0c:00.0 is added, Slot 0-1 gets a PCI_EXP_SLTSTA_DLLSC
interrupt for 10:00.0:

  pcieport 0000:0b:09.0: pciehp: pending interrupts 0x0008 from Slot Status
    presence detect changed                        # Slot 0-1
  pcieport 0000:0b:09.0: pciehp: pending interrupts 0x0100 from Slot Status
    DLL state changed                              # Slot 0-1
  pcieport 0000:0b:09.0: pciehp: pciehp_check_link_status: lnk_status = a023
    PCI_EXP_LNKSTA_LABS
    PCI_EXP_LNKSTA_DLLLA
    PCI_EXP_LNKSTA_NLW_X2
    PCI_EXP_LNKSTA_CLS_8_0GB
  pci 0000:10:00.0: [27d1:5216] type 00 class 0x010802  # NVMe in Slot 0-1

  pcieport 0000:0b:08.0: pciehp: pending interrupts 0x0008 from Slot Status
    presence detect changed                        # Slot 0
  pcieport 0000:0b:09.0: pciehp: pending interrupts 0x0100 from Slot Status
    DLL state changed                              # Slot 0-1 (?)
  pcieport 0000:0b:09.0: pciehp: Slot(0-1): Link Down

Here's the call chain when handling that DLL state change:

  pciehp_ist
    pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &status)
    status &= ... PCI_EXP_SLTSTA_DLLSC
    events |= status
    if (events & PCI_EXP_SLTSTA_DLLSC)
      pciehp_handle_presence_or_link_change
        pciehp_disable_slot
          __pciehp_disable_slot
            remove_board
              pciehp_unconfigure_device
                pci_stop_and_remove_bus_device

Per spec, "software must read the Data Link Layer Link Active bit of
the Link Status Register to determine if the Link is active before
initiating configuration cycles to the hot plugged device" (PCIe r6.0,
sec 7.5.3.11).

It looks like Linux depends on PCI_EXP_SLTSTA_DLLSC but does not
actually read PCI_EXP_LNKSTA in this path, so this looks like a pciehp
defect.

Bjorn
