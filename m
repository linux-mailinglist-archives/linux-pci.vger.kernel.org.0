Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B69787B51
	for <lists+linux-pci@lfdr.de>; Fri, 25 Aug 2023 00:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243826AbjHXWQL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Aug 2023 18:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243856AbjHXWQF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2023 18:16:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287A31BEB;
        Thu, 24 Aug 2023 15:16:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9779614BC;
        Thu, 24 Aug 2023 22:16:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDAC2C433C8;
        Thu, 24 Aug 2023 22:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692915363;
        bh=p/moKQjZMNODvvy2GHX9hSPQkLTq66Zh2rENIHnBAUk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NRhbiPj0YA4I0UrGSAiCeV0JIBTGlxv942sx9EVGCkjQ3HIf95PjUrVcftjIcGOTv
         5bXqZphv31KIL6tNyTuBAm4Lsc05qYFIDOvJ/+kEZVthuqZv4w+qdnnQaQ/z0yz1ti
         PIdqKQcNjybbdGv1fwNzs/pvL3XkbaFYc7EdT+E5a5uT9Oh1zkuVONeXu2lLI7OQ1a
         uiBziLiAzhTxoAJfvlmK38DU/hnwuKqAZ0/jrf7D1WeHVlKurngqgFxyAjiVrtNznV
         +8RS8b4aJXeGE9UM0Axg2ljRbHh/LT7KjOqd6C1kc1gHLlWKUj+fsBme2BVtM6FXwa
         Ma+MxUY1VEJYw==
Date:   Thu, 24 Aug 2023 17:16:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ingo Rohloff <lundril@gmx.de>
Cc:     Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] wifi: mt76: mt7921e: Support MT7992 IP in Xiaomi
 Redmibook 15 Pro (2023)
Message-ID: <20230824221601.GA604994@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824135232.5000-1-lundril@gmx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 24, 2023 at 03:52:32PM +0200, Ingo Rohloff wrote:
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

> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2126,6 +2126,7 @@
>  #define PCI_VENDOR_ID_MYRICOM		0x14c1
> 
>  #define PCI_VENDOR_ID_MEDIATEK		0x14c3
> +#define PCI_VENDOR_ID_ITTIM		0x0b48

Please add this in the correct place so the file remains sorted by
numeric Vendor ID and Device ID.  If you look at other PCI_VENDOR_ID_*
definitions, you'll see the pattern.

>  #define PCI_DEVICE_ID_MEDIATEK_7629	0x7629
> 
>  #define PCI_VENDOR_ID_TITAN		0x14D2
> --
> 2.25.1
> 
