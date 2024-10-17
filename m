Return-Path: <linux-pci+bounces-14732-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C1D9A1A28
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 07:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACFFEB20D55
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 05:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B2B146013;
	Thu, 17 Oct 2024 05:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iCi5Pn8k"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877F321E3C1
	for <linux-pci@vger.kernel.org>; Thu, 17 Oct 2024 05:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729142918; cv=none; b=CI2wOvoLFIi9OVhLaU3Et9mjb7ze0UGIXSlEZPngSD5NLr/Ces4wc3rgkzy7yyYfiibq7+9d8cMqCGmezHxpLfdI/1e+g2iMAOAfJdmjxWWtU0GW3qn/2pXcvDwrt7A99m601/K3Owi5UK0naM+LtwtOfym3T80jmhp8uYwNSiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729142918; c=relaxed/simple;
	bh=yYwU9C9vsauTqmDNngG7jcGAdBh99VFX3GQ5w/LjLZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZKu7blRevwHSyDgasOYl85m4EwwMVmEty1ff12DWEJTNOfvJPDCKJcLbtyNE4V+TiwU7yy/g91aDDduLuVHWWzwN2zg3i6NHWjxqg6KaFU3C3A6FaaUNlYZ0F+1lpSoT6yaxePYkf3YUbMYcRxIYiVVKp6CVpLGcVKNPAKs1q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iCi5Pn8k; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20cf6eea3c0so4611875ad.0
        for <linux-pci@vger.kernel.org>; Wed, 16 Oct 2024 22:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729142916; x=1729747716; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6hZjI6fRPqSWRpqD/TBWBTEMnYaD5tTjRkNPtt/tJec=;
        b=iCi5Pn8ksQ0/aQSYFShFEGvgpZ8Wb43nVn2S8Fb1dv4QEzXRE9gAnUuZLJwHTxSnt1
         RCnil/Xn1+0Ch+QWdbPwWmYMAQAxYxToRSk5c4DIkNFoWuiq34WcTX4YSQE3cHnjHVI3
         wGR65oJpzOVMR6d0RfbHMzQD9ZCKW9RByZ5yMJBLo1Ud2IVpMsX0s7DI3Hu6+EWhC6Cu
         vbZ7J+LMzXnSVz/boHDlXcx9zx6jud9FgH6Wb1jAQ5tcK04t8ZpSDS4jKlJ5+01owOU2
         3UYfXKZdoTXBqDYXzaYLw8VolWQKB6A8V/2eOZeLI9johBLdkehuOICTTDoUjv4dsPc0
         cPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729142916; x=1729747716;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6hZjI6fRPqSWRpqD/TBWBTEMnYaD5tTjRkNPtt/tJec=;
        b=Fse0g2FqyfC4n4gXVh83ItwQ11rceI8bc0WmZ4ABekdiW1q7K3mqKBwAM/WcWpS3eb
         N2GE5Ls2Lm6rla4MVfllGvlb2Ax3d6zaUsYJco22juYwPrIz5mIKvahpj05HrHqltYoR
         Ezxru4P9cNQ6At0ZygxPNn9YWqKyBXsArfzOw4AswGPPlTUPClTbBHxTmTLJAFHl5YdN
         Ocak8+7K0MQi5mvx7mOVQUVKrGi9r2C/DgjM5kYWAmgHJOimE8+Xt0ByODypJRRqaO7Z
         6UI680HshhDUHwXA5T+gF1mbLFlubfm9hy0Fb2abiBc4QWPzT5DbytjEPafb80arfW5g
         sIAg==
X-Forwarded-Encrypted: i=1; AJvYcCWB1drFHX4sQVD1vpL5tDyxRH68Ib3zM0xmMdU89bPCNNOysmBov8Io4va/GF8iz3xLNWyR5aNR9v8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX87ADOygjHbvyUtVKCD/8ocQTuwlSpGvklXrFa+jyQEpwnR1e
	dLEbwu5IJYoUAnHQUVO2FM7BzOLYrszyjE8KlmC8D3xyOePMZim5xi+/ioNp6A==
X-Google-Smtp-Source: AGHT+IGUwThnhRwyhg1pkY9QuCIy+m0VwiWq/mvKZ3IRFcJOhMizDDPRXRidvOwcsMQiryJgsZ9LAg==
X-Received: by 2002:a17:902:db0f:b0:20c:f292:3a21 with SMTP id d9443c01a7336-20d27ea856cmr88732655ad.15.1729142915759;
        Wed, 16 Oct 2024 22:28:35 -0700 (PDT)
Received: from thinkpad ([220.158.156.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1804c119sm37110245ad.190.2024.10.16.22.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 22:28:34 -0700 (PDT)
Date: Thu, 17 Oct 2024 10:58:29 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"open list:PCIE DRIVER FOR ROCKCHIP" <linux-pci@vger.kernel.org>,
	"open list:PCIE DRIVER FOR ROCKCHIP" <linux-rockchip@lists.infradead.org>,
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 2/3] PCI: rockchip: Simplify reset control handling by
 using reset_control_bulk*() function
Message-ID: <20241017052829.umil6en3rwsz7dvr@thinkpad>
References: <20241016114915.2823-1-linux.amoon@gmail.com>
 <20241016114915.2823-3-linux.amoon@gmail.com>
 <20241016182343.vocxyi5ry33btw5o@thinkpad>
 <CANAwSgRnd5jaZjoNtCLcq6nRGz3gC-VwjhxsiG7haiowrmZs_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANAwSgRnd5jaZjoNtCLcq6nRGz3gC-VwjhxsiG7haiowrmZs_w@mail.gmail.com>

On Thu, Oct 17, 2024 at 09:17:35AM +0530, Anand Moon wrote:
> Hi Manivannan,
> 
> On Wed, 16 Oct 2024 at 23:53, Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Wed, Oct 16, 2024 at 05:19:07PM +0530, Anand Moon wrote:
> > > Currently, the driver acquires and asserts/deasserts the resets
> > > individually thereby making the driver complex to read. But this
> > > can be simplified by using the reset_control_bulk APIs.
> > > Use devm_reset_control_bulk_get_exclusive() API to acquire all
> > > the resets and use reset_control_bulk_{assert/deassert}() APIs to
> > > assert/deassert them in bulk.
> > >
> > > Following the recommendations in 'Rockchip RK3399 TRM v1.3 Part2':
> > >
> > > 1. Split the reset controls into two groups as per section '17.5.8.1.1 PCIe
> > > as Root Complex'.
> > >
> > > 2. Deassert the 'Pipe, MGMT Sticky, MGMT, Core' resets in groups as per
> > > section '17.5.8.1.1 PCIe as Root Complex'. This is accomplished using the
> > > reset_control_bulk APIs.
> > >
> > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > ---
> > > v9: Improved the commit message and try to fix few review comments.
> >
> > You haven't fixed all of them... Please take a look at all of my comments.
> 
> It is becoming a nightmare for me, my confidence is a the lowest.

Me too. It makes me go crazy if the trivial comments are not addressed in
multiple revisions and it results in waste of time for both of us.

> Can you fix this while applying or I will resend it with the fix?

I don't merge the dwc patches, so I cannot do that. But what's preventing you
from addressing those comments. You cannot put the burden on the maintainers for
your mistake, sorry.

- Mani

> >
> > - Mani
> >
> Thanks
> -Anand
> 
> > > v8: I tried to address reviews and comments from Mani.
> > >     Follow the sequence of De-assert as per the driver code.
> > >     Drop the comment in the driver.
> > >     Improve the commit message with the description of the TMP section.
> > >     Improve the reason for the core functional changes in the commit
> > >     description.
> > >     Improve the error handling messages of the code.
> > > v7: replace devm_reset_control_bulk_get_optional_exclusive()
> > >         with devm_reset_control_bulk_get_exclusive()
> > >     update the functional changes.
> > > V6: Add reason for the split of the RESET pins.
> > > v5: Fix the De-assert reset core as per the TRM
> > >     De-assert the PIPE_RESET_N/MGMT_STICKY_RESET_N/MGMT_RESET_N/RESET_N
> > >     simultaneously.
> > > v4: use dev_err_probe in error path.
> > > v3: Fix typo in commit message, dropped reported by.
> > > v2: Fix compilation error reported by Intel test robot
> > >     fixed checkpatch warning.
> > > ---
> > >  drivers/pci/controller/pcie-rockchip.c | 154 +++++--------------------
> > >  drivers/pci/controller/pcie-rockchip.h |  26 +++--
> > >  2 files changed, 48 insertions(+), 132 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
> > > index 2777ef0cb599..adf11208cc82 100644
> > > --- a/drivers/pci/controller/pcie-rockchip.c
> > > +++ b/drivers/pci/controller/pcie-rockchip.c
> > > @@ -30,7 +30,7 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
> > >       struct platform_device *pdev = to_platform_device(dev);
> > >       struct device_node *node = dev->of_node;
> > >       struct resource *regs;
> > > -     int err;
> > > +     int err, i;
> > >
> > >       if (rockchip->is_rc) {
> > >               regs = platform_get_resource_byname(pdev,
> > > @@ -69,55 +69,23 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
> > >       if (rockchip->link_gen < 0 || rockchip->link_gen > 2)
> > >               rockchip->link_gen = 2;
> > >
> > > -     rockchip->core_rst = devm_reset_control_get_exclusive(dev, "core");
> > > -     if (IS_ERR(rockchip->core_rst)) {
> > > -             if (PTR_ERR(rockchip->core_rst) != -EPROBE_DEFER)
> > > -                     dev_err(dev, "missing core reset property in node\n");
> > > -             return PTR_ERR(rockchip->core_rst);
> > > -     }
> > > -
> > > -     rockchip->mgmt_rst = devm_reset_control_get_exclusive(dev, "mgmt");
> > > -     if (IS_ERR(rockchip->mgmt_rst)) {
> > > -             if (PTR_ERR(rockchip->mgmt_rst) != -EPROBE_DEFER)
> > > -                     dev_err(dev, "missing mgmt reset property in node\n");
> > > -             return PTR_ERR(rockchip->mgmt_rst);
> > > -     }
> > > -
> > > -     rockchip->mgmt_sticky_rst = devm_reset_control_get_exclusive(dev,
> > > -                                                             "mgmt-sticky");
> > > -     if (IS_ERR(rockchip->mgmt_sticky_rst)) {
> > > -             if (PTR_ERR(rockchip->mgmt_sticky_rst) != -EPROBE_DEFER)
> > > -                     dev_err(dev, "missing mgmt-sticky reset property in node\n");
> > > -             return PTR_ERR(rockchip->mgmt_sticky_rst);
> > > -     }
> > > -
> > > -     rockchip->pipe_rst = devm_reset_control_get_exclusive(dev, "pipe");
> > > -     if (IS_ERR(rockchip->pipe_rst)) {
> > > -             if (PTR_ERR(rockchip->pipe_rst) != -EPROBE_DEFER)
> > > -                     dev_err(dev, "missing pipe reset property in node\n");
> > > -             return PTR_ERR(rockchip->pipe_rst);
> > > -     }
> > > +     for (i = 0; i < ROCKCHIP_NUM_PM_RSTS; i++)
> > > +             rockchip->pm_rsts[i].id = rockchip_pci_pm_rsts[i];
> > >
> > > -     rockchip->pm_rst = devm_reset_control_get_exclusive(dev, "pm");
> > > -     if (IS_ERR(rockchip->pm_rst)) {
> > > -             if (PTR_ERR(rockchip->pm_rst) != -EPROBE_DEFER)
> > > -                     dev_err(dev, "missing pm reset property in node\n");
> > > -             return PTR_ERR(rockchip->pm_rst);
> > > -     }
> > > +     err = devm_reset_control_bulk_get_exclusive(dev,
> > > +                                                 ROCKCHIP_NUM_PM_RSTS,
> > > +                                                 rockchip->pm_rsts);
> > > +     if (err)
> > > +             return dev_err_probe(dev, err, "Cannot get the PM reset\n");
> > >
> > > -     rockchip->pclk_rst = devm_reset_control_get_exclusive(dev, "pclk");
> > > -     if (IS_ERR(rockchip->pclk_rst)) {
> > > -             if (PTR_ERR(rockchip->pclk_rst) != -EPROBE_DEFER)
> > > -                     dev_err(dev, "missing pclk reset property in node\n");
> > > -             return PTR_ERR(rockchip->pclk_rst);
> > > -     }
> > > +     for (i = 0; i < ROCKCHIP_NUM_CORE_RSTS; i++)
> > > +             rockchip->core_rsts[i].id = rockchip_pci_core_rsts[i];
> > >
> > > -     rockchip->aclk_rst = devm_reset_control_get_exclusive(dev, "aclk");
> > > -     if (IS_ERR(rockchip->aclk_rst)) {
> > > -             if (PTR_ERR(rockchip->aclk_rst) != -EPROBE_DEFER)
> > > -                     dev_err(dev, "missing aclk reset property in node\n");
> > > -             return PTR_ERR(rockchip->aclk_rst);
> > > -     }
> > > +     err = devm_reset_control_bulk_get_exclusive(dev,
> > > +                                                 ROCKCHIP_NUM_CORE_RSTS,
> > > +                                                 rockchip->core_rsts);
> > > +     if (err)
> > > +             return dev_err_probe(dev, err, "Cannot get the CORE resets\n");
> > >
> > >       if (rockchip->is_rc) {
> > >               rockchip->ep_gpio = devm_gpiod_get_optional(dev, "ep",
> > > @@ -147,23 +115,10 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
> > >       int err, i;
> > >       u32 regs;
> > >
> > > -     err = reset_control_assert(rockchip->aclk_rst);
> > > -     if (err) {
> > > -             dev_err(dev, "assert aclk_rst err %d\n", err);
> > > -             return err;
> > > -     }
> > > -
> > > -     err = reset_control_assert(rockchip->pclk_rst);
> > > -     if (err) {
> > > -             dev_err(dev, "assert pclk_rst err %d\n", err);
> > > -             return err;
> > > -     }
> > > -
> > > -     err = reset_control_assert(rockchip->pm_rst);
> > > -     if (err) {
> > > -             dev_err(dev, "assert pm_rst err %d\n", err);
> > > -             return err;
> > > -     }
> > > +     err = reset_control_bulk_assert(ROCKCHIP_NUM_PM_RSTS,
> > > +                                     rockchip->pm_rsts);
> > > +     if (err)
> > > +             return dev_err_probe(dev, err, "Couldn't assert PM resets\n");
> > >
> > >       for (i = 0; i < MAX_LANE_NUM; i++) {
> > >               err = phy_init(rockchip->phys[i]);
> > > @@ -173,47 +128,17 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
> > >               }
> > >       }
> > >
> > > -     err = reset_control_assert(rockchip->core_rst);
> > > -     if (err) {
> > > -             dev_err(dev, "assert core_rst err %d\n", err);
> > > -             goto err_exit_phy;
> > > -     }
> > > -
> > > -     err = reset_control_assert(rockchip->mgmt_rst);
> > > -     if (err) {
> > > -             dev_err(dev, "assert mgmt_rst err %d\n", err);
> > > -             goto err_exit_phy;
> > > -     }
> > > -
> > > -     err = reset_control_assert(rockchip->mgmt_sticky_rst);
> > > -     if (err) {
> > > -             dev_err(dev, "assert mgmt_sticky_rst err %d\n", err);
> > > -             goto err_exit_phy;
> > > -     }
> > > -
> > > -     err = reset_control_assert(rockchip->pipe_rst);
> > > -     if (err) {
> > > -             dev_err(dev, "assert pipe_rst err %d\n", err);
> > > -             goto err_exit_phy;
> > > -     }
> > > +     err = reset_control_bulk_assert(ROCKCHIP_NUM_CORE_RSTS,
> > > +                                     rockchip->core_rsts);
> > > +     if (err)
> > > +             return dev_err_probe(dev, err, "Couldn't assert Core resets\n");
> > >
> > >       udelay(10);
> > >
> > > -     err = reset_control_deassert(rockchip->pm_rst);
> > > -     if (err) {
> > > -             dev_err(dev, "deassert pm_rst err %d\n", err);
> > > -             goto err_exit_phy;
> > > -     }
> > > -
> > > -     err = reset_control_deassert(rockchip->aclk_rst);
> > > +     err = reset_control_bulk_deassert(ROCKCHIP_NUM_PM_RSTS,
> > > +                                       rockchip->pm_rsts);
> > >       if (err) {
> > > -             dev_err(dev, "deassert aclk_rst err %d\n", err);
> > > -             goto err_exit_phy;
> > > -     }
> > > -
> > > -     err = reset_control_deassert(rockchip->pclk_rst);
> > > -     if (err) {
> > > -             dev_err(dev, "deassert pclk_rst err %d\n", err);
> > > +             dev_err(dev, "Couldn't deassert PM resets %d\n", err);
> > >               goto err_exit_phy;
> > >       }
> > >
> > > @@ -252,31 +177,10 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
> > >               goto err_power_off_phy;
> > >       }
> > >
> > > -     /*
> > > -      * Please don't reorder the deassert sequence of the following
> > > -      * four reset pins.
> > > -      */
> > > -     err = reset_control_deassert(rockchip->mgmt_sticky_rst);
> > > -     if (err) {
> > > -             dev_err(dev, "deassert mgmt_sticky_rst err %d\n", err);
> > > -             goto err_power_off_phy;
> > > -     }
> > > -
> > > -     err = reset_control_deassert(rockchip->core_rst);
> > > -     if (err) {
> > > -             dev_err(dev, "deassert core_rst err %d\n", err);
> > > -             goto err_power_off_phy;
> > > -     }
> > > -
> > > -     err = reset_control_deassert(rockchip->mgmt_rst);
> > > -     if (err) {
> > > -             dev_err(dev, "deassert mgmt_rst err %d\n", err);
> > > -             goto err_power_off_phy;
> > > -     }
> > > -
> > > -     err = reset_control_deassert(rockchip->pipe_rst);
> > > +     err = reset_control_bulk_deassert(ROCKCHIP_NUM_CORE_RSTS,
> > > +                                       rockchip->core_rsts);
> > >       if (err) {
> > > -             dev_err(dev, "deassert pipe_rst err %d\n", err);
> > > +             dev_err(dev, "Couldn't deassert CORE %d\n", err);
> ok, it shipped my review process.
> > >               goto err_power_off_phy;
> > >       }
> > >
> > > diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
> > > index bebab80c9553..cc667c73d42f 100644
> > > --- a/drivers/pci/controller/pcie-rockchip.h
> > > +++ b/drivers/pci/controller/pcie-rockchip.h
> > > @@ -15,6 +15,7 @@
> > >  #include <linux/kernel.h>
> > >  #include <linux/pci.h>
> > >  #include <linux/pci-ecam.h>
> > > +#include <linux/reset.h>
> > >
> > >  /*
> > >   * The upper 16 bits of PCIE_CLIENT_CONFIG are a write mask for the lower 16
> > > @@ -288,18 +289,29 @@
> > >               (((c) << ((b) * 8 + 5)) & \
> > >                ROCKCHIP_PCIE_CORE_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b))
> > >
> > > +#define ROCKCHIP_NUM_PM_RSTS   ARRAY_SIZE(rockchip_pci_pm_rsts)
> > > +#define ROCKCHIP_NUM_CORE_RSTS ARRAY_SIZE(rockchip_pci_core_rsts)
> > > +
> > > +static const char * const rockchip_pci_pm_rsts[] = {
> > > +     "pm",
> > > +     "pclk",
> > > +     "aclk",
> > > +};
> > > +
> > > +static const char * const rockchip_pci_core_rsts[] = {
> > > +     "mgmt-sticky",
> > > +     "core",
> > > +     "mgmt",
> > > +     "pipe",
> > > +};
> > > +
> > >  struct rockchip_pcie {
> > >       void    __iomem *reg_base;              /* DT axi-base */
> > >       void    __iomem *apb_base;              /* DT apb-base */
> > >       bool    legacy_phy;
> > >       struct  phy *phys[MAX_LANE_NUM];
> > > -     struct  reset_control *core_rst;
> > > -     struct  reset_control *mgmt_rst;
> > > -     struct  reset_control *mgmt_sticky_rst;
> > > -     struct  reset_control *pipe_rst;
> > > -     struct  reset_control *pm_rst;
> > > -     struct  reset_control *aclk_rst;
> > > -     struct  reset_control *pclk_rst;
> > > +     struct  reset_control_bulk_data pm_rsts[ROCKCHIP_NUM_PM_RSTS];
> > > +     struct  reset_control_bulk_data core_rsts[ROCKCHIP_NUM_CORE_RSTS];
> > >       struct  clk_bulk_data *clks;
> > >       int     num_clks;
> > >       struct  regulator *vpcie12v; /* 12V power supply */
> > > --
> > > 2.44.0
> > >
> >
> > --
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்

