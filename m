Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF6C716A8C
	for <lists+linux-pci@lfdr.de>; Tue, 30 May 2023 19:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjE3RMu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 May 2023 13:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjE3RMs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 May 2023 13:12:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0121CEA;
        Tue, 30 May 2023 10:12:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83F8E61A4E;
        Tue, 30 May 2023 17:12:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF91C433D2;
        Tue, 30 May 2023 17:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685466766;
        bh=oMDauuBphE6JUcQ+uIrJvX7TM2de128E6fd+crN090A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bMNUevF8N4FowswMCFCB2xmyLAJMN7oa1AM+Z9xuaCrabO5PZThXqULzQiKg7insW
         YWV11lnmkWgOTUqczvVFVBYUoR+O+92fLauUU6GOttBn8oqXG+sSqQs9rj9hpaH0zj
         t7UN6bqshf0tdp8JnPsPhKZlj/WAlIPfKngglGgloBvxB3XjC5LR1KWtGd/JfNSWNr
         S0VzJUdoRyYgzhFlOK2mJ5m9w1iNbb2B3BYCNlI93zBLueqPBUbBddVL63ksAgIOzm
         zcaKtXF02lBCtn6ySqJHH/pvbIl08uoPA6Zeh6epk4t2E4oOMMrjlkU4DHJCM2e6i4
         K6t6OVHg3wNAA==
Date:   Tue, 30 May 2023 12:12:44 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Igor Mammedov <imammedo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, mst@redhat.com, rafael@kernel.org,
        lenb@kernel.org, bhelgaas@google.com, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, mika.westerberg@linux.intel.com
Subject: Re: [PATCH v2] PCI: acpiphp: Reassign resources on bridge if
 necessary
Message-ID: <ZHYujEM3o6iWIB1B@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424191557.2464760-1-imammedo@redhat.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 24, 2023 at 09:15:57PM +0200, Igor Mammedov wrote:
> When using ACPI PCI hotplug, hotplugging a device with
> large BARs may fail if bridge windows programmed by
> firmware are not large enough.
> 
> Reproducer:
>   $ qemu-kvm -monitor stdio -M q35  -m 4G \
>       -global ICH9-LPC.acpi-pci-hotplug-with-bridge-support=on \
>       -device id=rp1,pcie-root-port,bus=pcie.0,chassis=4 \
>       disk_image
> 
>  wait till linux guest boots, then hotplug device
>    (qemu) device_add qxl,bus=rp1
> 
>  hotplug on guest side fails with:
>    pci 0000:01:00.0: [1b36:0100] type 00 class 0x038000
>    pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x03ffffff]
>    pci 0000:01:00.0: reg 0x14: [mem 0x00000000-0x03ffffff]
>    pci 0000:01:00.0: reg 0x18: [mem 0x00000000-0x00001fff]
>    pci 0000:01:00.0: reg 0x1c: [io  0x0000-0x001f]
>    pci 0000:01:00.0: BAR 0: no space for [mem size 0x04000000]
>    pci 0000:01:00.0: BAR 0: failed to assign [mem size 0x04000000]
>    pci 0000:01:00.0: BAR 1: no space for [mem size 0x04000000]
>    pci 0000:01:00.0: BAR 1: failed to assign [mem size 0x04000000]
>    pci 0000:01:00.0: BAR 2: assigned [mem 0xfe800000-0xfe801fff]
>    pci 0000:01:00.0: BAR 3: assigned [io  0x1000-0x101f]
>    qxl 0000:01:00.0: enabling device (0000 -> 0003)

Ugh, I just noticed that we turned on PCI_COMMAND_MEMORY even though
BARs 0 and 1 haven't been assigned.  How did that happen?  It looks
like pci_enable_resources() checks for that, but there must be a hole
somewhere.

>    Unable to create vram_mapping
>    qxl: probe of 0000:01:00.0 failed with error -12
