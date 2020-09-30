Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307C527F0A2
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 19:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725355AbgI3Rhs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 13:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731335AbgI3Rhr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Sep 2020 13:37:47 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75431C0613D1
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2020 10:37:47 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id w3so2319239ljo.5
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2020 10:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=nbODIVmtMlo+oLH9Hrd8YGZI1ZfekrJ3et3L9IP3emw=;
        b=XMWwh4Nz6o2C7++lYVkhjkwC5h4Fg1CtBXKYaVfnuMN0DhI1MS18W9JzZHWGJ190qC
         3Yn6DG46RbfYlASND+TtT+IOlnxrJmcLcxSLeHwbkQyZdViuFmTwIWAZBeD8IoS0NgJU
         9/iu6348F5EBEQr0YdW3SqexfZcYhbP+g0Ce9IocdnoKHCkTPkissYZFeY5D/HkbZaUV
         s9mlzqY4RyugivLGjSCtbpu4TEyGPKucmg/Kefjoa7DrChvJ+I+QfArOGA35WACDbwal
         gY6BbBKRqovl/O0BCwOEWFasJnokCoS90w4YSuXv4Xd+jcRUCcQt1litY3yaF4F5TaZU
         Qiug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nbODIVmtMlo+oLH9Hrd8YGZI1ZfekrJ3et3L9IP3emw=;
        b=Z6sD+lprTW+PRe43tu+BL10eiS4EJnHV3pznMKbbvcSg7fZ0ha3nzSJZAFgOYdF5oc
         3ZHSQANiaqj0X7DqgFASnqlq8gR3HlRVRP/ccARpGQ3+bHI+dPHyUyA3CVhJm5LRdfsC
         XnS6PANlUCDddnc/SLELHmw/k6SaNHEDhFGfNaEeZw8Ql4k4i9t3YlSloIbaYsKSfaun
         7vFatPl4CuNSh9etXhDyfvNhIlvEnRYmL2IDM6FQDrKPHO82jInCLXN12J0NdB2rPKl1
         82GCcFN+MIpAkKlGxLuq6jiSt+Rj9f2cw+i5qmyeJQ6gmHzv4I8f6Zb4uXQyF40yEjIP
         relg==
X-Gm-Message-State: AOAM533eayRvyNedXFyAQSHws0Dr8uoLZn+YPxkYo/H5QmH3+MMcxzUh
        j8fdoZNgrhtvK6NJkFKNCH2nPw==
X-Google-Smtp-Source: ABdhPJyqDCDXp1ZYRf9156ssXFOuXiNaysi5BzWkXQEbMYcWMwfcZgmysMuz722U1SrRArZ4ULE7OA==
X-Received: by 2002:a2e:89ca:: with SMTP id c10mr1263859ljk.223.1601487465710;
        Wed, 30 Sep 2020 10:37:45 -0700 (PDT)
Received: from localhost (h-209-203.A463.priv.bahnhof.se. [155.4.209.203])
        by smtp.gmail.com with ESMTPSA id 77sm261464lfg.199.2020.09.30.10.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 10:37:45 -0700 (PDT)
Date:   Wed, 30 Sep 2020 19:37:44 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Marc Zyngier <maz@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, kernel-team@android.com,
        samuel@dionne-riel.com
Subject: Re: [PATCH v2] of: address: Work around missing device_type property
 in pcie nodes
Message-ID: <20200930173744.GG1516931@oden.dyn.berto.se>
References: <20200819094255.474565-1-maz@kernel.org>
 <20200930162722.GF1516931@oden.dyn.berto.se>
 <977f60f07a4cb5c59f0e5f8a9dfb3993@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <977f60f07a4cb5c59f0e5f8a9dfb3993@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marc,

On 2020-09-30 18:23:21 +0100, Marc Zyngier wrote:
> Hi Niklas,
> 
> [+ Samuel]
> 
> On 2020-09-30 17:27, Niklas Söderlund wrote:
> > Hi Marc,
> > 
> > I'm afraid this commit breaks booting my rk3399 device.
> > 
> > I bisected the problem to this patch merged as [1]. I'm testing on a
> > Scarlet device and I'm using the unmodified upstream
> > rk3399-gru-scarlet-inx.dtb for my tests.
> > 
> > The problem I'm experience is a black screen after the bootloader and
> > the device is none responsive over the network. I have no serial console
> > to this device so I'm afraid I can't tell you if there is anything
> > useful on to aid debugging there.
> > 
> > If I try to test one commit earlier [2] the system boots as expected and
> > everything works as it did for me in v5.8 and earlier. I have worked
> > little with this device and have no clue about what is really on the PCI
> > buss. But running from [2] I have this info about PCI if it's helpful,
> > please ask if somethings missing.
> 
> Please see the thread at [1]. The problem was reported a few weeks back
> by Samuel, and I was expecting Rob and Lorenzo to push a fix for this.

Thanks for providing a solution.

> 
> Rob, Lorenzo, any update on this?
> 
>         M.
> 
> [1]
> https://lore.kernel.org/linux-devicetree/20200829164920.7d28e01a@DUFFMAN/
> -- 
> Jazz is not dead. It just smells funny...

-- 
Regards,
Niklas Söderlund
