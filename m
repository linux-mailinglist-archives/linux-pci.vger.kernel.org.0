Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9026B7B3CD1
	for <lists+linux-pci@lfdr.de>; Sat, 30 Sep 2023 00:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjI2W54 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Sep 2023 18:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbjI2W54 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Sep 2023 18:57:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E87CDD;
        Fri, 29 Sep 2023 15:57:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9DBEC433CA;
        Fri, 29 Sep 2023 22:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696028274;
        bh=meAmfIZh4pVZAbrgCrY8UlN/iLhYwcGcAVNrSFyN0tI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=lBHegamYcFx4guTEnL7zSfBO1bzwJlewb3dkCPWmn9NyHE9HWn4+/U3LR4pyG4ULg
         pfqlGJ9G6rXR5o356YpxUps3XhcZEXmIPa7S6CSxjjLZH2ReMkJ8Thl0hNSYOvhWvo
         +/dqUj8TWsA09Ou2VvzgYbDtMr0ziHmr/i6yE41bq0PXi+ZegLJ9AFT8dMjwI8CwPC
         y8gKrLLWqqNKmwVf7YAGwkxCj9QkHKn+MXZtvxD/8xIGX4Nkts1PthtL3NYD05HtnS
         leh9/PqSHSfGzwqEhIIW0dtS3/5ebrld8oRo/R60u5EfffS+hjIC0bGKpmsKPH6g/I
         j53VShVxGGwiw==
Date:   Fri, 29 Sep 2023 17:57:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ingo Rohloff <lundril@gmx.de>
Cc:     Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] wifi: mt76: mt7921e: Support MT7992 IP in Xiaomi
 Redmibook 15 Pro (2023)
Message-ID: <20230929225752.GA560382@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230826200241.5077-1-lundril@gmx.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Aug 26, 2023 at 10:02:41PM +0200, Ingo Rohloff wrote:
> In the Xiaomi Redmibook 15 Pro (2023) laptop I have got, a wifi chip is
> used, which according to its PCI Vendor ID is from "ITTIM Technology".
> 
> This chip works flawlessly with the mt7921e module.  The driver doesn't
> bind to this PCI device, because the Vendor ID from "ITTIM Technology" is
> not recognized.
> 
> This patch adds the PCI Vendor ID from "ITTIM Technology" to the list of
> PCI Vendor IDs and lets the mt7921e driver bind to the mentioned wifi
> chip.
> 
> Signed-off-by: Ingo Rohloff <lundril@gmx.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# pci_ids.h

> ---
> Changes in v2:
> As requested, move the definition of the PCI Vendor ID for
> ITTIM Technology to the (hopefully) right place in pci_ids.h
> ---
>  drivers/net/wireless/mediatek/mt76/mt7921/pci.c | 2 ++
>  include/linux/pci_ids.h                         | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> index 95610a117d2f..ed5a220763ce 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> @@ -17,6 +17,8 @@ static const struct pci_device_id mt7921_pci_device_table[] = {
>  		.driver_data = (kernel_ulong_t)MT7921_FIRMWARE_WM },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7922),
>  		.driver_data = (kernel_ulong_t)MT7922_FIRMWARE_WM },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_ITTIM, 0x7922),
> +		.driver_data = (kernel_ulong_t)MT7922_FIRMWARE_WM },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x0608),
>  		.driver_data = (kernel_ulong_t)MT7921_FIRMWARE_WM },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x0616),
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 2dc75df1437f..6ae1803bcd2f 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -180,6 +180,8 @@
>  #define PCI_DEVICE_ID_BERKOM_A4T		0xffa4
>  #define PCI_DEVICE_ID_BERKOM_SCITEL_QUADRO	0xffa8
> 
> +#define PCI_VENDOR_ID_ITTIM		0x0b48
> +
>  #define PCI_VENDOR_ID_COMPAQ		0x0e11
>  #define PCI_DEVICE_ID_COMPAQ_TOKENRING	0x0508
>  #define PCI_DEVICE_ID_COMPAQ_TACHYON	0xa0fc
> --
> 2.30.2
> 
