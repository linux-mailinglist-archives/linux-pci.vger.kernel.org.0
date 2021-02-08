Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A803142C2
	for <lists+linux-pci@lfdr.de>; Mon,  8 Feb 2021 23:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbhBHWUo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Feb 2021 17:20:44 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:41497 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbhBHWU1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Feb 2021 17:20:27 -0500
Received: by mail-wr1-f43.google.com with SMTP id n6so6244093wrv.8
        for <linux-pci@vger.kernel.org>; Mon, 08 Feb 2021 14:20:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YlOpw/FJ0voz3T7tDPp2AUxXKXP0XbUl5aH4GyttCzc=;
        b=Uh1vEstk5vvfe1bav6iiOVzgyWidsmFFW20/btYsgS2OF8kfsUuTcKOLkoCYEIy1f3
         LSeZ/BWoi9FWwn3O1vBHxJAtW1Su4SxxPQxeFaO+pz44ce/3yeU+6Nhd1f0sOQJpQLcN
         O+q5i7kr1/4u68tf3q3CXXlPK1BQsIatZxIxIWKy0tNd0iUXWOEKJ0C9kYA3icEElJpg
         hE4Hq2tH3pZMsFB/M0U8+QqjDIUt4RF8hASofpXCiPFsQx2N1E37hxlBCSFFdgIy9Ly6
         pjBkIewdyylit2Ne7EyquyZ6H+kLzs6eZM5i4XWHC+FN+RUhNgdApmvh2j490OS6tf9R
         MOeQ==
X-Gm-Message-State: AOAM5305MvwvsZQmsNboAL2Fb6QLgjuspKsrQkRwsOnLrGljsn3uIfKj
        KIr/N14p+cDq7rZWhooyxlo=
X-Google-Smtp-Source: ABdhPJyvkCUlaByyTn5Pj5govoT0DH87sgPLRqdgy5NM+oXEgMEc32GgMm5mmRIpXHnNmnoOMK4ndg==
X-Received: by 2002:a5d:51cf:: with SMTP id n15mr21531193wrv.303.1612822786197;
        Mon, 08 Feb 2021 14:19:46 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id 17sm950034wmf.32.2021.02.08.14.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 14:19:45 -0800 (PST)
Date:   Mon, 8 Feb 2021 23:19:44 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org
Subject: Re: New Defects reported by Coverity Scan for Linux
Message-ID: <YCG5AHUbK4LjdujQ@rocinante>
References: <6020c2368a549_2dfbcf2b02da5acf501000c7@prd-scan-dashboard-0.mail>
 <20210208162651.GA392069@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210208162651.GA392069@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Fabio]

Hi Bjorn, Lorenzo and Rob,

[...]
> > *** CID 1472841:  Error handling issues  (CHECKED_RETURN)
> > /drivers/pci/controller/dwc/pci-exynos.c: 263 in exynos_pcie_host_init()
> > 257     
> > 258     	pp->bridge->ops = &exynos_pci_ops;
> > 259     
> > 260     	exynos_pcie_assert_core_reset(ep);
> > 261     
> > 262     	phy_reset(ep->phy);
> > >>>     CID 1472841:  Error handling issues  (CHECKED_RETURN)
> > >>>     Calling "phy_power_on" without checking return value (as is done elsewhere 40 out of 50 times).
> > 263     	phy_power_on(ep->phy);
> > 264     	phy_init(ep->phy);
> > 265     
> > 266     	exynos_pcie_deassert_core_reset(ep);
> > 267     	exynos_pcie_enable_irq_pulse(ep);
> > 268     

We also have the following defect detected in the same file, and it's of
an identical nature - lack of error checking.  The reported defect:

263        phy_power_on(ep->phy);
CID 1471267 (#1 of 1): Unchecked return value (CHECKED_RETURN)
2. check_return: Calling phy_init without checking return value (as is done elsewhere 41 out of 49 times).
264        phy_init(ep->phy);

This would also be quite trivial to fix, but I don't know much about
Exons, thus I am not sure if there is anything special it would need
aside of perhaps phy_power_off() and phy_exit(), etc.

Krzysztof
