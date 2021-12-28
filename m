Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD727480CCD
	for <lists+linux-pci@lfdr.de>; Tue, 28 Dec 2021 20:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbhL1TiG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Dec 2021 14:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbhL1TiG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Dec 2021 14:38:06 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2904BC061574
        for <linux-pci@vger.kernel.org>; Tue, 28 Dec 2021 11:38:06 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id v11so40163781wrw.10
        for <linux-pci@vger.kernel.org>; Tue, 28 Dec 2021 11:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fBuUeVesUS1PoSZN8nRBKiFEAPI9FGS1xzz++h6eACM=;
        b=LFJkufFgaCdh8BLwxSuPh24+kBGWzf8JE1vtcK+7TdeXeJyF6tMuRRT1sAvvqfn8bQ
         29kfGUC5UycAl6WBKnIhPPoXOtQ1vyMsiSywY7c/fz5dEjp/d7FSFd+Y2Vt2RvKfwhiH
         s12nDuTWq/58V0mWAf/m85eRl7m0NSSK+nLvqvFSWe6OVu2UUvSUEoHo9GsK2ysGTXXM
         +Gy7IWvma+S3X91qs5i/49IZlZvhk/dQ/hcBhyUNtMi0FxHFvxVQJ4oITBcYDgfhBo25
         GGm7we4YN9pFbptIBGq3khvHqOqEG+mcqpVOPyf50XBVZYq4XrANzsv5iSCR0m7dcus8
         QkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fBuUeVesUS1PoSZN8nRBKiFEAPI9FGS1xzz++h6eACM=;
        b=WzkuPxsiuZZcwopK6rfNwAAEPzHRnLpOCCBpDXfqY5lUVRNw8dIKJgyVilQnZZnrTO
         xda4Kx2vKlJ/8ztOi8TvF4BGxAn8m5oP7eXtc3kYPSamAVJZFoq4bj6NdULiqxk7rsDf
         TUSiLETCrTL5MwkT3asF6jy3OW/IOgXR3Crhk3k14LEFKIES1kwL5Jm3FcwdE/GsZZEc
         78W66mYH7xoRXoD4JmfIPGG8VOSvtxIZCTg7Yj1WuUwj+5vd2QiKKqT6wcZC9Vrf+C+G
         ZYMJyU7ygOK4aY6ZKbYcBWnc4UFrSwfPoPCbqAqnpaodNFvRcLfbVCQTnW9Au3O9VSDc
         HxNg==
X-Gm-Message-State: AOAM532DiYQP8qkGvCyFdrWmD+PewnlWKQ3Z2nRGsBRBkRxT4WNAbWS1
        TDMFQOU/yXBajxIZFQNjgHxJOd9udBy/Xg==
X-Google-Smtp-Source: ABdhPJyJ4OEePDIhgYKz0THvI/kJneAnPM6xpDBmrWCnXiVhuuZNH9Ng02WZ0MOjrll7aLZuF2CfAw==
X-Received: by 2002:a5d:6a81:: with SMTP id s1mr18233686wru.36.1640720284617;
        Tue, 28 Dec 2021 11:38:04 -0800 (PST)
Received: from claire-ThinkPad-T470 (ip-109-42-114-192.web.vodafone.de. [109.42.114.192])
        by smtp.gmail.com with ESMTPSA id k6sm18305462wmj.16.2021.12.28.11.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 11:38:04 -0800 (PST)
Date:   Tue, 28 Dec 2021 20:38:01 +0100
From:   Fan Fei <ffclaire1224@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, bjorn@helgaas.com
Subject: Re: [PATCH 00/13] Unify device * to platform_device *
Message-ID: <20211228193801.GA54107@claire-ThinkPad-T470>
References: <cover.1638022048.git.ffclaire1224@gmail.com>
 <20211223004337.GA1222509@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211223004337.GA1222509@bhelgaas>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 22, 2021 at 06:43:37PM -0600, Bjorn Helgaas wrote:
Hi, Bjorn
> On Sat, Nov 27, 2021 at 03:11:08PM +0100, Fan Fei wrote:
> > Some PCI controller structs contain "device *", while others contain
> > "platform_device *". These patches unify "device *dev" to
> > "platform_device *pdev" in 13 controller struct, to make the controller
> > struct more consistent. Consider that PCI controllers interact with
> > platform_device directly, not device, to enumerate the controlled
> > device.
> 
> I went through all the controller drivers using a command like this:
> 
>   git grep -A4 -E "^struct .*_pci.?\> \{$" drivers/pci/controller/
> 
> and found that almost all of them hang onto the "struct device *", not
> the "struct platform_device *".  Many of these are buried inside struct
> dw_pcie and struct cdns_pcie.
>
Do you mean most of these structs contain dw_pcie and cdns_pcie, both of
which contain "sturct device *"? I did realize this is not consistent with
other controller device if we make this change.
> I know I've gone back and forth on this, but I don't think the churn of
> converting some of them to keep the "struct platform_device *" would be
> worthwhile.
> 
I could convert "platform_device *" back to "device *", e.g. in the
pcie-altear.c. What do you think?
> The preceding series that renamed the controller structs made this
> exploration quite a bit easier, so I do plan to apply that series.
> 
> > Fan Fei (13): PCI: xilinx: Replace device * with platform_device * PCI:
> > mediatek: Replace device * with platform_device * PCI: tegra: Replace
> > device * with platform_device * PCI: xegene: Replace device * with
> > platform_device * PCI: microchip: Replace device * with platform_device
> > * PCI: brcmstb: Replace device * with platform_device * PCI:
> > mediatek-gen3: Replace device * with platform_device * PCI: rcar-gen2:
> > Replace device * with platform_device * PCI: ftpci100: Replace device *
> > with platform_device * PCI: v3-semi: Replace device * with
> > platform_device * PCI: ixp4xx: Replace device * with platform_device *
> > PCI: xilinx-nwl: Replace device * with platform_device * PCI: rcar:
> > Replace device * with platform_device *
> > 
> >  drivers/pci/controller/pci-ftpci100.c        |  15 +-
> >  drivers/pci/controller/pci-ixp4xx.c          |  47 ++--
> >  drivers/pci/controller/pci-rcar-gen2.c       |  10 +-
> >  drivers/pci/controller/pci-tegra.c           |  85 +++----
> >  drivers/pci/controller/pci-v3-semi.c         |  19 +-
> >  drivers/pci/controller/pci-xgene.c           | 222 +++++++++----------
> >  drivers/pci/controller/pcie-brcmstb.c        |  35 +--
> >  drivers/pci/controller/pcie-mediatek-gen3.c  |  36 +--
> >  drivers/pci/controller/pcie-mediatek.c       |  31 +--
> >  drivers/pci/controller/pcie-microchip-host.c |  18 +-
> >  drivers/pci/controller/pcie-rcar-ep.c        |  40 ++--
> >  drivers/pci/controller/pcie-rcar-host.c      |  27 +--
> >  drivers/pci/controller/pcie-rcar.h           |   2 +-
> >  drivers/pci/controller/pcie-xilinx-nwl.c     |  28 +--
> >  drivers/pci/controller/pcie-xilinx.c         |  21 +- 15 files
> >  changed, 328 insertions(+), 308 deletions(-)
> > 
> > -- 2.25.1
> > 
