Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA77659150
	for <lists+linux-pci@lfdr.de>; Thu, 29 Dec 2022 20:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbiL2Tz4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Dec 2022 14:55:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbiL2Tzy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Dec 2022 14:55:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98212AE4
        for <linux-pci@vger.kernel.org>; Thu, 29 Dec 2022 11:55:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82FA3617E1
        for <linux-pci@vger.kernel.org>; Thu, 29 Dec 2022 19:55:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A9CC433EF;
        Thu, 29 Dec 2022 19:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672343752;
        bh=kvC8RAtSg5C1f3gFzc3B2kQUNgKJtVYCg8q6q7Uu6l0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=b1x/I3gAYHpQWVJY4xix2AdZz8v4DzkgnTANPmYSv+VFrg62XfP2y3Zx73NA1afFu
         1njH6e8Owb+VJzX7f/f0qHlLa8nCIIXM/v6qHa2b0xyQQ2hUhGI02m+ggdTdM7bowa
         OckNmH2tCvxeJySiY9DTzq3xcf3ReDTxEq1ueUNrKMcAnlPr1fsxCbntON8TKboRui
         uTlhUGlgWb1s3jWfiOIFQLh583OFuIBUtOQ6VitMMVdX11tHZi4TfHoIeWdo51z5BN
         p5mgtAWsNGoJxxNt3BrDWpAEkyp2xWzBu/gG59PfAyiEJ8wR3PQED8tZHU1dYYYf0w
         36XSzy5OFKE3Q==
Date:   Thu, 29 Dec 2022 13:55:51 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: [RESEND PATCH 1/3] Add SolidRun vendor id
Message-ID: <20221229195551.GA626165@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219083511.73205-2-alvaro.karsz@solid-run.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Alvaro,

On Mon, Dec 19, 2022 at 10:35:09AM +0200, Alvaro Karsz wrote:
> The vendor id is used in 2 differrent source files,
> the SNET vdpa driver and pci quirks.

s/id/ID/                   # both in subject and commit log
s/differrent/different/
s/vdpa/vDPA/               # seems to be the conventional style
s/pci/PCI/

Make the commit log say what this patch does.

> Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>

With the above and the sorting fix below:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  include/linux/pci_ids.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index b362d90eb9b..33bbe3160b4 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -3115,4 +3115,6 @@
>  
>  #define PCI_VENDOR_ID_NCUBE		0x10ff
>  
> +#define PCI_VENDOR_ID_SOLIDRUN		0xd063

Move this to the right spot so the file is sorted by vendor ID.
PCI_VENDOR_ID_NCUBE, PCI_VENDOR_ID_OCZ, and PCI_VENDOR_ID_XEN got
added in the wrong place.

>  #endif /* _LINUX_PCI_IDS_H */
> -- 
> 2.32.0
> 
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
