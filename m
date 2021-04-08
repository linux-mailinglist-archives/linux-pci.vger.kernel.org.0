Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4486F35885C
	for <lists+linux-pci@lfdr.de>; Thu,  8 Apr 2021 17:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbhDHP15 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Apr 2021 11:27:57 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:35435 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbhDHP14 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Apr 2021 11:27:56 -0400
Received: by mail-ot1-f44.google.com with SMTP id v24-20020a9d69d80000b02901b9aec33371so2685155oto.2;
        Thu, 08 Apr 2021 08:27:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rdZfDLUXaMwgcMUkGetCIhlvH4deTfYYyOQSzUBFId8=;
        b=PAMTCbw7HkURnCdl0LKlcpuI375UwnRjIvZZfVEegpOI687CdBF2CGfK2MfFtHia7f
         5y+jDWSHbk1oJKudcOhi+KLS+O2FrWTl0i089PLKFzaoii9RS8m+DtzS7v0tIpP9I9eu
         V8y6bVGCYEg3SFkvzblxhohPKwjlyE7fDJmkcwaN3GJP+OrYWzTOz6asetwmU0gb+6vu
         jET/7LVAvnXXRPhFKIL/7mZ7kh5cog6MhI40gjxGdvjG0wdmx8cZSqMjjeJxiLoWjDBX
         8xhXz8uyKgA8IYDeZigWsaa4Gtc6ch9mV9CxDqPgq1Rh2I4jQy40dVAtCNa2d/WByW1v
         LXYw==
X-Gm-Message-State: AOAM531kosk5QrhsQG2LHp4IWZycczlKEwkN75oVd/S9A3B8PQ560y3Q
        LfSyH6P/7Klg/ZprcJydeg==
X-Google-Smtp-Source: ABdhPJx+CB57VJt5MT3qSNg+O2bSCTTG4lZKqRMJVQNbU1/SJ53npzyNH/Jh8yb4te5/vIqEC6CGww==
X-Received: by 2002:a9d:70cf:: with SMTP id w15mr8438401otj.283.1617895664765;
        Thu, 08 Apr 2021 08:27:44 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n12sm6389560otq.42.2021.04.08.08.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 08:27:44 -0700 (PDT)
Received: (nullmailer pid 1515862 invoked by uid 1000);
        Thu, 08 Apr 2021 15:27:42 -0000
Date:   Thu, 8 Apr 2021 10:27:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Greentime Hu <greentime.hu@sifive.com>
Cc:     paul.walmsley@sifive.com, hes@sifive.com, erik.danie@sifive.com,
        zong.li@sifive.com, bhelgaas@google.com, aou@eecs.berkeley.edu,
        mturquette@baylibre.com, sboyd@kernel.org,
        lorenzo.pieralisi@arm.com, p.zabel@pengutronix.de,
        alex.dewar90@gmail.com, khilman@baylibre.com,
        hayashi.kunihiko@socionext.com, vidyas@nvidia.com,
        jh80.chung@samsung.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        helgaas@kernel.org
Subject: Re: [PATCH v5 5/6] PCI: fu740: Add SiFive FU740 PCIe host controller
 driver
Message-ID: <20210408152742.GA1510069@robh.at.kernel.org>
References: <20210406092634.50465-1-greentime.hu@sifive.com>
 <20210406092634.50465-6-greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406092634.50465-6-greentime.hu@sifive.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 06, 2021 at 05:26:33PM +0800, Greentime Hu wrote:
> From: Paul Walmsley <paul.walmsley@sifive.com>
> 
> Add driver for the SiFive FU740 PCIe host controller.
> This controller is based on the DesignWare PCIe core.
> 
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Co-developed-by: Henry Styles <hes@sifive.com>
> Signed-off-by: Henry Styles <hes@sifive.com>
> Co-developed-by: Erik Danie <erik.danie@sifive.com>
> Signed-off-by: Erik Danie <erik.danie@sifive.com>
> Co-developed-by: Greentime Hu <greentime.hu@sifive.com>
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> ---
>  drivers/pci/controller/dwc/Kconfig      |   9 +
>  drivers/pci/controller/dwc/Makefile     |   1 +
>  drivers/pci/controller/dwc/pcie-fu740.c | 308 ++++++++++++++++++++++++
>  3 files changed, 318 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-fu740.c

Reviewed-by: Rob Herring <robh@kernel.org>
