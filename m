Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF2D1485629
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jan 2022 16:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241662AbiAEPql (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jan 2022 10:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241650AbiAEPqi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jan 2022 10:46:38 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB76C061245
        for <linux-pci@vger.kernel.org>; Wed,  5 Jan 2022 07:46:38 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id ie13so1529995pjb.1
        for <linux-pci@vger.kernel.org>; Wed, 05 Jan 2022 07:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BO4MKFLszBxA/+XnWNMkG0RXich2+azqhtQOR+2Uh0c=;
        b=DSEYKKgX5YNLw9OUMAB8yNEaEe8rqD2B+7MSBTORxbM2HfGjva/+0wfvb6eF2SWq1A
         kNjZxcOpdd6RuOlkDTRERTvhWfrGH+YSWCV5tIaswTPX8uNjys0a9DRusJN4BSmcs8wy
         LPAPwMozZnr6w8OM+H1XEOUwjt9ICpe4yeo+LSESFS4eLFVvTYqRA6CFiKgbVa363c4y
         4qyiENcj8M73RA976j5hsnxcudc+5LWev7mYdNMuDk47nkMWGROxUtkyZwop3Ojv7KxD
         aTqgfrsubXribjNuMYQTrcwcLwEPM+lhT4XqGGCPIYd7z8xm5EozHRJp3PRuvO/0lWde
         p/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BO4MKFLszBxA/+XnWNMkG0RXich2+azqhtQOR+2Uh0c=;
        b=SoV5GA5qppnaosgTv7IKrjLyf5fE0Krbw4ZK519oFXyD7jbGkwCd1ezGXVlfUx9xdz
         Aig2lOVbfMA9Pr7cX1hj+LD/ZI2pcJbFExEPwflmcwPfGdax+seL+7UWpXJDdIkwi0jN
         PFVRM2MF250/TLp43TCSdYkba/LGZGZQeERv3mlsOfk6nTy1ZcmhBmvSTy2VWFb64zj/
         kGgX8eDdig1zofNR6VWEvf8/4UhPHTzMKiKv5/u81q5DC+x5QpT9KKMEvBp+ilaXKyiz
         eIpuUCkm4Skev1byIMwfOmUSyHJw/QS4JXmRNHDbZ2j9V+tbzwJCSX4rdE8o5+UniA/X
         l1vQ==
X-Gm-Message-State: AOAM532Kgt7o8wctXYLCaKmXloDbwVqm3XRO5Kc27mbHmAc7zCtUOLGI
        KbLtz2C3WMs7ThZYGqJrNB3c
X-Google-Smtp-Source: ABdhPJyXyrXUpbxniR3dhFa50tna6SKdX2WaanacMxYeZaBMwGbiORMPj2dV0IOorDIYPHJcBYp5WQ==
X-Received: by 2002:a17:903:244f:b0:149:ea09:730d with SMTP id l15-20020a170903244f00b00149ea09730dmr106309pls.62.1641397597703;
        Wed, 05 Jan 2022 07:46:37 -0800 (PST)
Received: from thinkpad ([117.193.213.149])
        by smtp.gmail.com with ESMTPSA id q9sm30449679pgi.12.2022.01.05.07.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 07:46:37 -0800 (PST)
Date:   Wed, 5 Jan 2022 21:16:31 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        Om Prakash Singh <omp@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: designware-ep: Fix the access to DBI/iATU
 registers before enabling controller
Message-ID: <20220105154631.GA26098@thinkpad>
References: <1630473361-27198-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1630473361-27198-3-git-send-email-hayashi.kunihiko@socionext.com>
 <576457dd-3e66-a3b9-f51c-ea94bc267fdb@ti.com>
 <20211206112335.GA18520@lpieralisi>
 <f4037b9c-9957-8d4c-d2e0-63bb53d5e7ee@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4037b9c-9957-8d4c-d2e0-63bb53d5e7ee@socionext.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 05, 2022 at 07:43:04PM +0900, Kunihiko Hayashi wrote:
> Hi Kishon, Lorenzo,
> 
> Thank you and sorry for late reply.
> 
> On 2021/12/06 20:23, Lorenzo Pieralisi wrote:
> > On Fri, Dec 03, 2021 at 10:36:00AM +0530, Kishon Vijay Abraham I wrote:
> > > Hi Kunihiko,
> > > 
> > > On 01/09/21 10:46 am, Kunihiko Hayashi wrote:
> > > > The driver using core_init_notifier, e.g. pcie-tegra194.c, runs
> > according
> > > > to the following sequence:
> > > > 
> > > >      probe()
> > > >          dw_pcie_ep_init()
> > > > 
> > > >      bind()
> > > >          dw_pcie_ep_start()
> > > >              enable_irq()
> > > > 
> > > >      (interrupt occurred)
> > > >      handler()
> > > >          [enable controller]
> > > >          dw_pcie_ep_init_complete()
> > > >          dw_pcie_ep_init_notify()
> > > > 
> > > > After receiving an interrupt from RC, the handler enables the
> > controller
> > > > and the controller registers can be accessed.
> > > > So accessing the registers should do in dw_pcie_ep_init_complete().
> > > > 
> > > > Currently dw_pcie_ep_init() has functions dw_iatu_detect() and
> > > > dw_pcie_ep_find_capability() that include accesses to DWC registers.
> > > > As a result, accessing the registers before enabling the controller,
> > > > the access will fail.
> > > > 
> > > > The function dw_pcie_ep_init() shouldn't have any access to DWC
> > registers
> > > > if the controller is enabled after calling bind(). This moves access
> > codes
> > > > to DBI/iATU registers and depending variables from dw_pcie_ep_init()
> > to
> > > > dw_pcie_ep_init_complete().
> > > 
> > > Ideally pci_epc_create() should be the last step by the controller
> > > driver before handing the control to the core EPC framework. Since
> > > after this step the EPC framework can start invoking the epc_ops.
> > > 
> > > Here more stuff is being added to dw_pcie_ep_init_complete() which is
> > > required for epc_ops and this could result in aborts for platforms
> > > which does not add core_init_notifier.
> > 
> > This patch needs rework, I will mark the series as "Changes requested".
> 
> I understand that relocation of dwc register accesses isn't appropriate,
> but I couldn't think of any other rework to dwc, and I confirmed
> pcie-qcom-ep driver using core_init_notifier.
> 
> In pcie-qcom-ep driver, probe() enables clock and deasserts reset first,
> and when PERST# interrupt arrives, the handler enables clock and deasserts
> reset again. So, dw_pcie_ep_init() can access DBI registers.
> 

Yes, only since dw_pcie_ep_init() carries out the DBI accesses, we have enabled
clocks and PHY. Moving the DBI accesses to init_complete() removes the need of
enabling the resources redundantly.

Thanks,
Mani

> In pcie-tegra194 driver, I think the issue will be solved if probe() also
> handles clock and reset control. However, the driver has other register
> access between core_clk, core_apb_rst, and core_rst controls.
> I think that it's appropriate to leave this fix to the developer at this
> point.
> 
> As this patch series, I'll resend 1/2 patch only and expect pcie-tegra194
> driver to be fixed.
> 
> Thank you,
> 
> ---
> Best Regards
> Kunihiko Hayashi
