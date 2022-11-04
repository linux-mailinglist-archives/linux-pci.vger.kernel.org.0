Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F3D619C30
	for <lists+linux-pci@lfdr.de>; Fri,  4 Nov 2022 16:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbiKDPxn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Nov 2022 11:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiKDPxm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Nov 2022 11:53:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7892F037;
        Fri,  4 Nov 2022 08:53:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F1B76226E;
        Fri,  4 Nov 2022 15:53:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D52DAC433D7;
        Fri,  4 Nov 2022 15:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667577221;
        bh=D/kjrbnhZKfEDME4djvX1K9wKrkFOfyBSZWAGGVtnsY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MzSDONcqj6q7b1xz8pbVGGl5Koc3y/dSFR/1iuRTl2mSslZZvJ7os9YGjk0jP+WiH
         khcd4dhlG4oso27eMJeDQuwmPLrE2/GFEoL98vtXUQk9GIjcCo5yC7Buz0KzYWJqXy
         jNOXp78XRGnRDnUY2sC9FIchMaHg3LLDMQUEL2uztgrwuShFB7CDwW/AQVEv40FuLX
         bRfmtumwWrrGsapKUMtpbIOLyidodXNTQyzRGwFslfJF8Ar/ZSAJNup51UqRjUSUCD
         wLyFQnATZQFu0JPVzLdI2ALp4LWZRwlw+A/2q043ZKacp6Rgxge89SeNQs30LnXoeF
         2NbdWZrch7xsQ==
Date:   Fri, 4 Nov 2022 10:53:39 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Christophe Fergeau <cfergeau@redhat.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Clear PCI_STATUS when setting up the device
Message-ID: <20221104155339.GA95864@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517043738.2308499-1-kai.heng.feng@canonical.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 17, 2022 at 12:37:38PM +0800, Kai-Heng Feng wrote:
> We are seeing Master Abort bit is set on Intel I350 ethernet device and its
> root port right after boot, probably happened during BIOS phase:
> 
> 00:06.0 PCI bridge [0604]: Intel Corporation Device [8086:464d] (rev 05) (prog-if 00 [Normal decode])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
> 
> 6e:00.0 Ethernet controller [0200]: Intel Corporation I350 Gigabit Network Connection [8086:1521] (rev 01)
>         Subsystem: Intel Corporation Ethernet Server Adapter I350-T2 [8086:00a2]
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
> 
> 6e:00.1 Ethernet controller [0200]: Intel Corporation I350 Gigabit Network Connection [8086:1521] (rev 01)
>         Subsystem: Intel Corporation Ethernet Server Adapter I350-T2 [8086:00a2]
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
> 
> And the Master Abort bit is cleared after S3.
> 
> Since there's no functional impact found, clear the PCI_STATUS to treat
> it anew at setting up.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=215989
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

This patch appeared in v6.0 as 6cd514e58f12 ("PCI: Clear PCI_STATUS
when setting up device").  Christophe reported in the bugzilla that it
causes boot failures:

> --- Comment #3 from Christophe Fergeau (cfergeau@redhat.com) ---
> This commit
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6c
> d514e58f12b211d638dbf6f791fa18d854f09c
> references this issue.
> This commit causes boot failures when trying to start linux guests with Apple's
> hypervisor framework (for example using https://github.com/evansm7/vftool ).
> After reverting it, I can successfully boot 6.1-rc kernels on my macOS12 x86_64
> macbook. With this commit, the VM fails to start, additional details in
> https://bugzilla.redhat.com/show_bug.cgi?id=2137803


> ---
>  drivers/pci/probe.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 17a969942d370..414f659dc8735 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1890,6 +1890,9 @@ int pci_setup_device(struct pci_dev *dev)
>  
>  	dev->broken_intx_masking = pci_intx_mask_broken(dev);
>  
> +	/* Clear errors left from system firmware */
> +	pci_write_config_word(dev, PCI_STATUS, 0xffff);
> +
>  	switch (dev->hdr_type) {		    /* header type */
>  	case PCI_HEADER_TYPE_NORMAL:		    /* standard header */
>  		if (class == PCI_CLASS_BRIDGE_PCI)
> -- 
> 2.34.1
> 
