Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637F256790C
	for <lists+linux-pci@lfdr.de>; Tue,  5 Jul 2022 23:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbiGEVAq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Jul 2022 17:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiGEVAp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jul 2022 17:00:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15D52B4;
        Tue,  5 Jul 2022 14:00:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B5A1B818C4;
        Tue,  5 Jul 2022 21:00:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB39C341C7;
        Tue,  5 Jul 2022 21:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657054841;
        bh=56171/zMAvKt/GzCahKiPiXHcNQKraW9NSn03Sn+fo4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=d+LcPPY8Bm0NBRBmmDopgyc+qC00TiSH8KqspIwnGeRyGuo+7ln8DcxgDUNyIIF3o
         beEEWpXx5XLJTP6KGi58PT1cKrN94D3GyC5nH/KT6EXh1Doa74Zdy1FnixceemhJIv
         mAktbSBEO1+dzlJ9qzTOrAMPVSoqscNfcMyEaezAQlz0GKDMeYovEXk4Qgq4SjgKbG
         k+fg/5JwVFyXRweCCHxpGg0F1gAYiM0YInDn2KbE+JX+oCb3Wmj/joMHm6KNNkhyeQ
         PEA2euHAeoWV/SAzTLnRMaquQ8vUZskaInIN3TgGElb1qD2w/ytoJ4DPmezWJ5b5V+
         gRtd2WjKp/vgQ==
Date:   Tue, 5 Jul 2022 16:00:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Clear PCI_STATUS when setting up the device
Message-ID: <20220705210040.GA84047@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517043738.2308499-1-kai.heng.feng@canonical.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Applied to pci/err for v5.20, thanks!

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
