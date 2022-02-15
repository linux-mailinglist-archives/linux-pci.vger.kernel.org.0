Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B124B6BDF
	for <lists+linux-pci@lfdr.de>; Tue, 15 Feb 2022 13:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237571AbiBOMS0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Feb 2022 07:18:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236906AbiBOMSZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Feb 2022 07:18:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA141074E1
        for <linux-pci@vger.kernel.org>; Tue, 15 Feb 2022 04:18:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EFD4CB818C6
        for <linux-pci@vger.kernel.org>; Tue, 15 Feb 2022 12:18:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04622C340EB;
        Tue, 15 Feb 2022 12:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644927493;
        bh=gRY8rXTw6LdFGVplSzgN5uxJqKQ9cAjk0BvUr8Dxssg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K2pOV6jv43BnBcrjYba3EydOysbhqC51uDPtDwOq+NnTSYjhkH1oDvIazjE4WoKtr
         hA2mFmtBdn1psYav/CkEMI12QBLfiByq+yXi3FiBNaEaXJs+9lysZJJRLT5c0VtrsP
         6kxNFj4pEmJEHGa9M8vM9jnwG2E71YZSX2yke59pEBH+FMLkhuyGVNryMBzNwH8KlY
         onRMqUOPDPVDLPFz3+hRQed33vUkojKYJUakk6N6zaxc9M8uRDJ/pk8Ry3VGfhud4S
         +FXw5JgaQ6VwlBlFfunDHl4kt+SC6aXsMMcsEeGMhZFQE29889kTgOEp9YBKXDSQ1V
         rcn8O7d4JNGuw==
Date:   Tue, 15 Feb 2022 14:18:09 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Sunil Goutham <sgoutham@marvell.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        sunil.goutham@gmail.com
Subject: Re: [PATCH] PCI: Add Marvell Octeon devices to PCI IDs
Message-ID: <YguaAbHelW0/l9lm@unreal>
References: <1644841510-14512-1-git-send-email-sgoutham@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644841510-14512-1-git-send-email-sgoutham@marvell.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 14, 2022 at 05:55:10PM +0530, Sunil Goutham wrote:
> Add Marvell (Cavium) OcteonTx2 and CN10K devices
> to PCI ID database.
> 
> Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
> ---
>  include/linux/pci_ids.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index aad54c6..5fd187b 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2357,6 +2357,21 @@
>  #define PCI_DEVICE_ID_ALTIMA_AC1003	0x03eb
>  
>  #define PCI_VENDOR_ID_CAVIUM		0x177d
> +#define PCI_DEVICE_ID_OCTEONTX2_PTP	0xA00C
> +#define PCI_DEVICE_ID_CN10K_PTP		0xA09E
> +#define PCI_DEVICE_ID_OCTEONTX2_CGX	0xA059
> +#define PCI_DEVICE_ID_CN10K_RPM		0xA060
> +#define PCI_DEVICE_ID_OCTEONTX2_CPTPF	0xA0FD
> +#define PCI_DEVICE_ID_OCTEONTX2_CPTVF	0xA0FE
> +#define PCI_DEVICE_ID_CN10K_CPTPF	0xA0F2
> +#define PCI_DEVICE_ID_CN10K_CPTVF	0xA0F3
> +#define PCI_DEVICE_ID_OCTEONTX2_RVUAF	0xA065
> +#define PCI_DEVICE_ID_OCTEONTX2_RVUPF	0xA063
> +#define PCI_DEVICE_ID_OCTEONTX2_RVUVF	0xA064
> +#define PCI_DEVICE_ID_OCTEONTX2_LBK	0xA061
> +#define PCI_DEVICE_ID_OCTEONTX2_LBKVF	0xA0F8
> +#define PCI_DEVICE_ID_OCTEONTX2_SDPPF	0xA0F6
> +#define PCI_DEVICE_ID_OCTEONTX2_SDPVF	0xA0F7

If I recall correctly, this file is for device IDs that are used in more
than one subsystem. It is not supposed to be updated for every octeon device.

Thanks

>  
>  #define PCI_VENDOR_ID_TECHWELL		0x1797
>  #define PCI_DEVICE_ID_TECHWELL_6800	0x6800
> -- 
> 2.7.4
> 
