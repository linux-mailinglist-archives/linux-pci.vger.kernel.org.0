Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31268393E17
	for <lists+linux-pci@lfdr.de>; Fri, 28 May 2021 09:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbhE1Hk5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 May 2021 03:40:57 -0400
Received: from forward104o.mail.yandex.net ([37.140.190.179]:42862 "EHLO
        forward104o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234485AbhE1Hk4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 May 2021 03:40:56 -0400
Received: from iva6-28d2389f22c1.qloud-c.yandex.net (iva6-28d2389f22c1.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:7594:0:640:28d2:389f])
        by forward104o.mail.yandex.net (Yandex) with ESMTP id 40C04942167;
        Fri, 28 May 2021 10:39:17 +0300 (MSK)
Received: from iva5-057a0d1fbbd8.qloud-c.yandex.net (iva5-057a0d1fbbd8.qloud-c.yandex.net [2a02:6b8:c0c:7f1c:0:640:57a:d1f])
        by iva6-28d2389f22c1.qloud-c.yandex.net (mxback/Yandex) with ESMTP id TUkIZJ2F4T-dGK8k8G8;
        Fri, 28 May 2021 10:39:17 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1622187557;
        bh=iYCqAuCC+7TFHLwAOJUlhJ1XcWdQvZcPOUL97Z/4QZs=;
        h=In-Reply-To:Cc:To:From:Subject:Message-ID:References:Date;
        b=fqHJCkpkj8/XvrBbcBEBdY9Py83ZgDtXvxfSqC6XIioYCLFEDRZK4ME+PQL4WyOpH
         /FpOHOH1o5C7MXGKxx9z5aydipAfDL6QZMEx+TYxMMWBDAjisG73CDjytHowqwA2AI
         c8wkhlFYlDtbBtHcYR63qaYUmuuDrt0OGGys7yT8=
Authentication-Results: iva6-28d2389f22c1.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru
Received: by iva5-057a0d1fbbd8.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id njmYoNSXsz-dGLegNH9;
        Fri, 28 May 2021 10:39:16 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Message-ID: <361252784e1a796048b65b2d3ae903a7943b699f.camel@yandex.ru>
Subject: PING: Re: [PATCH v2] PCI: don't call firmware hooks on suspend
 unless it's fw-controlled
From:   Konstantin Kharlamov <hi-angel@yandex.ru>
To:     linux-pci@vger.kernel.org
Cc:     helgaas@kernel.org, lukas@wunner.de, rjw@rjwysocki.net,
        andreas.noever@gmail.com
Date:   Fri, 28 May 2021 10:39:16 +0300
In-Reply-To: <20210520235501.917397-1-Hi-Angel@yandex.ru>
References: <20210520194935.GA348608@bjorn-Precision-5520>
         <20210520235501.917397-1-Hi-Angel@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 2021-05-21 at 02:55 +0300, Konstantin Kharlamov wrote:
> On Macbook 2013 resuming from s2idle resulted in external monitor no
> longer being detected, and dmesg having errors like:
> 
>     pcieport 0000:06:00.0: can't change power state from D3hot to D0 (config
> space inaccessible)
> 
> and a stacktrace. The reason is that in s2idle (and in S1 as noted by
> Rafael) we do not call firmware code to handle suspend, and as result
> while waking up firmware also does not handle resume.
> 
> This means, for the Thunderbolt controller that gets disabled in the
> quirk by calling the firmware methods, there's no one to wake it back up
> on resume.
> 
> To quote Rafael Wysocki:
> 
> > "Passing control to the platform firmware" means letting
> > some native firmware code (like SMM code) run which happens at the end
> > of S2/S3/S4 suspend transitions and it does not happen during S1
> > (standby) and s2idle suspend transitions.
> > 
> > That's why using SXIO/SXFP/SXLF is only valid during S2/S3/S4 suspend
> > transitions and it is not valid during s2idle and S1 suspend
> > transitions (and yes, S1 is also affected, so s2idle is not special in
> > that respect at all).
> 
> Thus, return early from the quirk when suspend mode isn't one that calls
> firmware.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=212767
> Signed-off-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> ---
>  drivers/pci/quirks.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 653660e3ba9e..f86b6388a04a 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -27,6 +27,7 @@
>  #include <linux/nvme.h>
>  #include <linux/platform_data/x86/apple.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/suspend.h>
>  #include <linux/switchtec.h>
>  #include <asm/dma.h>   /* isa_dma_bridge_buggy */
>  #include "pci.h"
> @@ -3646,6 +3647,15 @@ static void quirk_apple_poweroff_thunderbolt(struct
> pci_dev *dev)
>                 return;
>         if (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM)
>                 return;
> +
> +       /*
> +        * SXIO/SXFP/SXLF turns off power to the Thunderbolt controller.  We
> don't
> +        * know how to turn it back on again, but firmware does, so we can
> only use
> +        * SXIO/SXFP/SXLF if we're suspending via firmware.
> +        */
> +       if (!pm_suspend_via_firmware())
> +               return;
> +
>         bridge = ACPI_HANDLE(&dev->dev);
>         if (!bridge)
>                 return;


