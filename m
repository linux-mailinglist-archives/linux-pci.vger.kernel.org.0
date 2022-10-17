Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4645C60126F
	for <lists+linux-pci@lfdr.de>; Mon, 17 Oct 2022 17:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbiJQPJD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Oct 2022 11:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbiJQPIv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Oct 2022 11:08:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C4F6B66D;
        Mon, 17 Oct 2022 08:08:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48E19B818F3;
        Mon, 17 Oct 2022 15:08:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C1AC433D6;
        Mon, 17 Oct 2022 15:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666019284;
        bh=oiF4vdLS02EOCCj4hUcovK01LgXQJHuTmhDNEmbXky8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=P9mZAWlajuxDhtRYmgVnQqxBaL2uHlR2KfSLKiWnP+Jc6tuC2e4Bh301QJmBSfW33
         mi30HDmw2psgWnIxXucj1E6hMLNHA4GT2VSbmCAkIaWAS0r44eWPWZLw8kLlhpiqIH
         sNR+CQsYY5S8WG6m1O0JnPk6NyCLTnZEDyKLx5KJeL055yvHYiK9AMydSDd42ucIB5
         tBYAdxvrAGOI/sYtvn67Apt4mzTGOS0pSfSMMDqAroVIZdCTqnIWrgGy6hxrh3+Fxy
         rKX1MavsMpAXLzJIm8kxNtX5UO6+LxKy7LxcfWUnbUFmMu2+2uwfasW2zvc4BTnVHQ
         gwD3ksZY2NKxg==
Date:   Mon, 17 Oct 2022 10:08:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christian Gmeiner <christian.gmeiner@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Christian GMEINER <Christian.GMEINER@bachmann.info>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Add Bachmann electronic GmbH vendor ID
Message-ID: <20221017150802.GA3701588@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017142338.1445199-1-christian.gmeiner@gmail.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 17, 2022 at 04:23:37PM +0200, Christian Gmeiner wrote:
> From: Christian GMEINER <Christian.GMEINER@bachmann.info>
> 
> Signed-off-by: Christian GMEINER <Christian.GMEINER@bachmann.info>

I tweaked it to shorten the name in the style of other entries and
sort it by numeric ID.

I assume there's a driver that will use this definition.  If so, you
might want to post this patch (including my ack) along with the driver
so they get merged together.  But let me know if you need me to take
it directly.

Also it will be helpful if you can add the item to the PCI ID database
here: https://pci-ids.ucw.cz/read/PC?restrict=0, which will let lspci
identify devices with this Vendor ID.

Bjorn


commit 2fa819fdbb2b ("PCI: Add Bachmann electronic GmbH vendor ID")
Author: Christian GMEINER <Christian.GMEINER@bachmann.info>
Date:   Mon Oct 17 16:23:37 2022 +0200

    PCI: Add Bachmann electronic GmbH vendor ID
    
    Link: https://lore.kernel.org/r/20221017142338.1445199-1-christian.gmeiner@gmail.com
    Signed-off-by: Christian GMEINER <Christian.GMEINER@bachmann.info>
    Acked-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index b362d90eb9b0..4cc0e9ecd398 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2,7 +2,7 @@
 /*
  *	PCI Class, Vendor and Device IDs
  *
- *	Please keep sorted.
+ *	Please keep sorted by numeric ID.
  *
  *	Do not add new entries to this file unless the definitions
  *	are shared between multiple drivers.
@@ -153,7 +153,7 @@
 
 #define PCI_CLASS_OTHERS		0xff
 
-/* Vendors and devices.  Sort key: vendor first, device next. */
+/* Vendors and devices.  Numeric sort key: vendor first, device next. */
 #define PCI_VENDOR_ID_PCI_SIG		0x0001
 
 #define PCI_VENDOR_ID_LOONGSON		0x0014
@@ -172,6 +172,8 @@
 #define PCI_DEVICE_ID_BERKOM_A4T		0xffa4
 #define PCI_DEVICE_ID_BERKOM_SCITEL_QUADRO	0xffa8
 
+#define PCI_VENDOR_ID_BACHMANN		0x0bae
+
 #define PCI_VENDOR_ID_COMPAQ		0x0e11
 #define PCI_DEVICE_ID_COMPAQ_TOKENRING	0x0508
 #define PCI_DEVICE_ID_COMPAQ_TACHYON	0xa0fc

> ---
>  include/linux/pci_ids.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index b362d90eb9b0..b93a52977d85 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -166,6 +166,8 @@
>  
>  #define PCI_VENDOR_ID_UBIQUITI		0x0777
>  
> +#define PCI_VENDOR_ID_BACHMANN_ELECTRONIC 0x0bae
> +
>  #define PCI_VENDOR_ID_BERKOM			0x0871
>  #define PCI_DEVICE_ID_BERKOM_A1T		0xffa1
>  #define PCI_DEVICE_ID_BERKOM_T_CONCEPT		0xffa2
> -- 
> 2.37.3
> 
