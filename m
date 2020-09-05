Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5151225EA9F
	for <lists+linux-pci@lfdr.de>; Sat,  5 Sep 2020 22:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbgIEUog (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Sep 2020 16:44:36 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33745 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728449AbgIEUoV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 5 Sep 2020 16:44:21 -0400
Received: by mail-lj1-f194.google.com with SMTP id r13so11854137ljm.0
        for <linux-pci@vger.kernel.org>; Sat, 05 Sep 2020 13:44:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=671tuV+5QYoJp/HkFJ0gD7Y6tBP+J04Z5kQy3jbSXss=;
        b=SjxboCvBPpNgjxBbU5CMGnYNkSKVITfxBWm999H/IFucLt49dOHZ4QlUzHORuFzctX
         HZbzylloYj6+eGqtutt2J/kAVaKf8o4ypmZYVY1d5uvN7vpsijlfmIkQ6ejepRFNIJMD
         uCzBlyO7bYkYxVUYmnLhY+B507Cn3tog/JLKcFk6ClFAH9d2xxr87Tcz2Coqs56vFxkK
         CDpVhZnX7eqFiXhWG+j3kVNWkzTkDqirFRAT5VtZVd2nmc0nz7DSFLlJAjwYwO+C+JcW
         eh9xxR7VVjV822uPkZvsDnjPyeeJTq3LucRYl2QmsMTDGbyvMjN0mh4T9+HQKU25LQu0
         awBQ==
X-Gm-Message-State: AOAM532qcjAt0HeSgz8ejlIAEUS9LI2cwsIh81gjgUx5JGQgqe2lK4Ph
        ikIZNK+15fKUmSutFF00Td8=
X-Google-Smtp-Source: ABdhPJyXeuw1d2QUIlbDtbaneQ5+q+irrrq0cJRGJd9l8xSoUw78Y1nTihKLCprWlSBu4qdcF15ScA==
X-Received: by 2002:a2e:889a:: with SMTP id k26mr6578454lji.214.1599338658314;
        Sat, 05 Sep 2020 13:44:18 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id x11sm2709379ljh.106.2020.09.05.13.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 13:44:17 -0700 (PDT)
Date:   Sat, 5 Sep 2020 22:44:16 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-rockchip@lists.infradead.org,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Robert Richter <rrichter@marvell.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: Unify ECAM constants in native PCI Express drivers
Message-ID: <20200905204416.GA83847@rocinante>
References: <20200827224938.977757-1-kw@linux.com>
 <20200828100843.0000474e@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200828100843.0000474e@Huawei.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Jonathan,

Thank you for the review!  Also, apologies for late reply.

On 20-08-28 10:08:43, Jonathan Cameron wrote:
[...]
> 
> Might potentially be worth tidying up the masks as well?
> Or potentially drop them given I suspect that there are no cases
> in which the mask is actually doing anything...

Just to confirm - you have the following constants in mind?

drivers/pci/controller/pcie-rockchip.h:

#define PCIE_ECAM_BUS(x)	(((x) & 0xff) << 20)
#define PCIE_ECAM_DEV(x)	(((x) & 0x1f) << 15)
#define PCIE_ECAM_FUNC(x)	(((x) & 0x7) << 12)

drivers/pci/controller/dwc/pcie-al.c:

#define PCIE_ECAM_DEVFN(x)	(((x) & 0xff) << 12)

I can move PCIE_ECAM_BUS, PCIE_ECAM_DEV and PCIE_ECAM_FUNC (as
PCIE_ECAM_FUN) to the linux/pci-ecam.h file, as these seem useful, but
without the masks, and then update other files to use these.  We could
then leverage these, for example:

 	pci_base_addr = (void __iomem *)((uintptr_t)pp->va_cfg0_base +
-					 (busnr_ecam << 20) +
-					 PCIE_ECAM_DEVFN(devfn));
+					 PCIE_ECAM_BUS(busnr_ecam) +
+					 PCIE_ECAM_FUN(devfn));

What do you think?  Bjorn, would that be acceptable?

Krzysztof
