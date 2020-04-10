Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDDA1A457C
	for <lists+linux-pci@lfdr.de>; Fri, 10 Apr 2020 13:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgDJLHk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Apr 2020 07:07:40 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35041 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgDJLHk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Apr 2020 07:07:40 -0400
Received: by mail-wm1-f65.google.com with SMTP id r26so2409126wmh.0;
        Fri, 10 Apr 2020 04:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=VjzS9uW/4mzFpGFiK2xCLm+I4dAqpbLmOJp3GnXktwg=;
        b=XowhG9RBP0WyRGId3Q6ohZqzB+zuM4Ys8Fzy6W5ATPU/fZz6ySR0985vQkRPY8BSde
         +XGjyKdDSI0PCulzsS7J4kqV4AYyXsb5sPDeiuMz7np/1J3OAjH19u3/lxZ4NMJ+Ptv3
         XxP66Bok4gXAmlv994lpFdQ68WgBkHYGphqVGlkMfXtsQ7c0/NliLYOOQLmiIhgHpzyR
         1R7IxSvYKi6GE4DSL3oZ+sWgfMS8spLeLd8c4w5IOROPC09w1r7oo01HK2fX3inH2yUV
         tmjBgrU6YnIw/lgmxZLaWcQV4wFvsRi1oI9hcuQqhbr7XEiHSXdtzmCXJEneoGGanCSq
         IxPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=VjzS9uW/4mzFpGFiK2xCLm+I4dAqpbLmOJp3GnXktwg=;
        b=JdgGHSttJ38pQEKDNJuwuwSonSjMjL6KdSKRaqDeUPEQVZ1nkGZDWd+NsV+iPdnofW
         VZGqMpkgT3JBcU97l+kv0qT+KI++zMfAfmtYD3pLaDvSXmrttZwa4+kU084fyfer/zzq
         aEuCtcYdjCnKSbGpNUMae+95Brd0IdYnbl5kTQ64888ehFax1r59BhEPzV0Lr15tsi2I
         V/yUFzJR41Nd/0boR1wnzm2+OLN4XGOGJ794iOO5rXq61GhaOD5up6bxm81yqUowk8Ha
         0LmSdZEoDNvqgGIr5FrBGOqRCRJWm0yTZFdi9sB561LccplFYbiEOgiQ5rWBG5RKmrcl
         oLRA==
X-Gm-Message-State: AGi0PuYwXLBI3ChCwFWVlxDMSm4yuFnMbULs890x2fxq5XTxl25SqS8s
        HQuKQB1WtsY0lePJDxv4yX8=
X-Google-Smtp-Source: APiQypJ4cn6GX7eyEVI/qPrqPRf8DfkFFnLVwed6+Uxm5i3EPBBYP5BzsJmII0VFs/oldwPmIYYE6g==
X-Received: by 2002:a1c:6241:: with SMTP id w62mr4569233wmb.27.1586516856778;
        Fri, 10 Apr 2020 04:07:36 -0700 (PDT)
Received: from AnsuelXPS (host117-205-dynamic.180-80-r.retail.telecomitalia.it. [80.180.205.117])
        by smtp.gmail.com with ESMTPSA id b7sm2150988wrn.67.2020.04.10.04.07.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Apr 2020 04:07:36 -0700 (PDT)
From:   <ansuelsmth@gmail.com>
To:     "'Fabio Estevam'" <festevam@gmail.com>
Cc:     "'open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS'" 
        <devicetree@vger.kernel.org>,
        "'Richard Zhu'" <hongxing.zhu@nxp.com>,
        "'Lucas Stach'" <l.stach@pengutronix.de>,
        "'Bjorn Helgaas'" <bhelgaas@google.com>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Mark Rutland'" <mark.rutland@arm.com>,
        "'Shawn Guo'" <shawnguo@kernel.org>,
        "'Sascha Hauer'" <s.hauer@pengutronix.de>,
        "'Pengutronix Kernel Team'" <kernel@pengutronix.de>,
        "'NXP Linux Team'" <linux-imx@nxp.com>,
        "'Lorenzo Pieralisi'" <lorenzo.pieralisi@arm.com>,
        "'Andrew Murray'" <amurray@thegoodpenguin.co.uk>,
        <linux-pci@vger.kernel.org>,
        "'moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE'" 
        <linux-arm-kernel@lists.infradead.org>,
        "'linux-kernel'" <linux-kernel@vger.kernel.org>
References: <20200410004738.19668-1-ansuelsmth@gmail.com> <20200410004738.19668-3-ansuelsmth@gmail.com> <CAOMZO5AKYO3xLsp4k6_fJCV9qW=rAtRKEGWnxksixU794dOw8A@mail.gmail.com>
In-Reply-To: <CAOMZO5AKYO3xLsp4k6_fJCV9qW=rAtRKEGWnxksixU794dOw8A@mail.gmail.com>
Subject: R: [PATCH 2/4] drivers: pci: dwc: pci-imx6: update binding to generic name
Date:   Fri, 10 Apr 2020 13:07:33 +0200
Message-ID: <003401d60f28$3d045190$b70cf4b0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: it
Thread-Index: AQJxOzeYiZkD8UITQ1/aTwnouqE5vAHrEXcAAuDSQDWnFXqbEA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Hi Ansuel,
> 
> On Thu, Apr 9, 2020 at 9:47 PM Ansuel Smith <ansuelsmth@gmail.com>
> wrote:
> >
> > Rename specific bindings to generic name.
> >
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> b/drivers/pci/controller/dwc/pci-imx6.c
> > index acfbd34032a8..4ac140e007b4 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -1146,28 +1146,28 @@ static int imx6_pcie_probe(struct
> platform_device *pdev)
> >         }
> >
> >         /* Grab PCIe PHY Tx Settings */
> > -       if (of_property_read_u32(node, "fsl,tx-deemph-gen1",
> > +       if (of_property_read_u32(node, "tx-deemph-gen1",
> 
> This breaks compatibility with older dtbs.

so no chance of changing this? 

