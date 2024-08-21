Return-Path: <linux-pci+bounces-11916-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4C795954B
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 09:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29EA11C226E1
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 07:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55E4199FAC;
	Wed, 21 Aug 2024 07:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BN3jUQdJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AAD1799D
	for <linux-pci@vger.kernel.org>; Wed, 21 Aug 2024 07:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724223944; cv=none; b=nU7+bjp4QHX90h6E734gyGmBOlsZ01+rrwQCEK2vfwX5QaeFUhdbNeDmXBdNi3Anur2HDCVv3SZ4Qxe8xr4yoAh0d+rXGEfULacBV/Kaz6DKl2f6b0G538sDMWLUY2GXwhWbuOqoGCaThKf0anpKWsmlZ+OjNyj8rmuYQkZozmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724223944; c=relaxed/simple;
	bh=WBuQAtVb63mM0ZpNNAb39xHg3BCkMSsPrrZhk41i6lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQgDxHqfaHN/ngHAPaZQXqvYRVHifaANOVrLnheC9hljPgtPG0tSd4rTfoAZpGhVPZUX9XfWbVwKIkt1s5rrk7Eez3dzkdMG1aCfHEHbhpdaR7Q0xGgSFp082Ngye4mtS+bTzMOE9kyHHDOFnrUAQ+hoTW/+z4ONplGq0VP+9XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BN3jUQdJ; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso355608a12.0
        for <linux-pci@vger.kernel.org>; Wed, 21 Aug 2024 00:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724223941; x=1724828741; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BjeaDQ8CqSlUX+6KQTLvorw0PworcJX4Z9bMHJPFVyo=;
        b=BN3jUQdJHc49e1vQU1QUtN+/ODZqu5T9BxrvGl68ckiw4Y5LlCAKqKVq1sgHFvpKtB
         bD9UK8Gjax8/OOGT+8K4pqXJ2u90prGw4ZJTkmCMkMvXS1sVTjxPXXSYMT7tvaDREz1x
         B6tTw3rPAtW0gGC7ceD8OPHmWgNtSmsGV/cg88yHhKsrPiYyITjv2ub2C9nM2PX3iEfX
         PY6+qdpfFbEf6Bc17d/StIeI7u7Wq0yICyzm/yhCfLskAFqWLkcE/gUp5MFmzt09Wmxb
         0l74MNJnYA3pMBDNmBYjigyhdd8dC11b+U1CSkWza/kfSNtAbcKFqLBuIuH9bCG9gvDi
         MTCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724223941; x=1724828741;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BjeaDQ8CqSlUX+6KQTLvorw0PworcJX4Z9bMHJPFVyo=;
        b=VPGCvQ0ZDQ77alVkEZG/9IIyynsKWnrXeH4QYLadHLp9/rm0dkt0b2ROpM2rTQSz6G
         g6qVZsywXFNgjkJbk+Xgmz16bMbx0U0qC+sk+6vKIihi133APlZpu8eFWn7x5uXc6SA/
         h3/iYSzJumsQDuXYN8Awg/IbTFMqRcGL3eAfyy6nVdc+5cpG2+GOMGf5rPgJqg7nm1/7
         +EVFe9MppqRQW9IMeys/U8usujPIB+Rti01ydc8ay0XZw6JCz2RcYZPsZCHAE3sfWbSR
         9QZ4uIOu+YVkd4oc3AN3sjeMqqglvAK/pa7pr61LyfihcmK/lzmmps+8bo7qZdOHtAMe
         sOAw==
X-Forwarded-Encrypted: i=1; AJvYcCUlQG5IVpZcXhSUNcCLUwkciAbzzUj2dU5dgZPekzLO/Uk3hNdRYLktABSUDFGaAWq0n1DBA2I86+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFcpExQ1Ly29AKc+lEADxLHNVWyUXiabAb2Y8h7xzvA9ohiP23
	kN3EFeNeh3AqPn/tNGv/wXJGntUH5l4OY9Z5HbhSVZHF4e0SEAWFFk+lgnwMcA==
X-Google-Smtp-Source: AGHT+IGTTYXfSAyUkjeZvaungm1XIw/2ET1TYmDIvuu0czZ/vNdPJ8c0pxkRctUuVn27J8snAv+4pg==
X-Received: by 2002:a05:6a20:3b84:b0:1ca:da51:6635 with SMTP id adf61e73a8af0-1cada516753mr1150687637.1.1724223941057;
        Wed, 21 Aug 2024 00:05:41 -0700 (PDT)
Received: from thinkpad ([120.60.137.118])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd8ce64ef3sm360604a12.59.2024.08.21.00.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 00:05:40 -0700 (PDT)
Date: Wed, 21 Aug 2024 12:35:33 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] PCI: rockchip: Simplify reset control handling by
 using reset_control_bulk*() function
Message-ID: <20240821070533.wztutnvlpghzso6v@thinkpad>
References: <20240625104039.48311-1-linux.amoon@gmail.com>
 <20240625104039.48311-2-linux.amoon@gmail.com>
 <20240815162004.GF2562@thinkpad>
 <CANAwSgR-k1x1cBbLZ-OErSiEDcnkqs9uiBy77BEd2tz-CGC3OQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANAwSgR-k1x1cBbLZ-OErSiEDcnkqs9uiBy77BEd2tz-CGC3OQ@mail.gmail.com>

On Sat, Aug 17, 2024 at 06:52:47PM +0530, Anand Moon wrote:
> Hi Manivannan,
> 
> On Thu, 15 Aug 2024 at 21:50, Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Tue, Jun 25, 2024 at 04:10:33PM +0530, Anand Moon wrote:
> > > Refactor the reset control handling in the Rockchip PCIe driver,
> > > introducing a more robust and efficient method for assert and
> > > deassert reset controller using reset_control_bulk*() API. Using the
> > > reset_control_bulk APIs, the reset handling for the core clocks reset
> > > unit becomes much simpler.
> > >
> > > As per rockchip rk3399 TRM SOFTRST_CON8 soft reset controller
> > > have clock reset unit value set to 0x1 for example "pcie_pipe",
> > > "pcie_mgmt_sticky", "pcie_mgmt" and "pci_core", hence group then under
> > > one reset bulk controller.
> > >
> > > Where as "pcie_pm", "presetn_pcie", "aresetn_pcie" have reset value
> > > set to 0x0, hence group them under reset control bulk controller.
> > >
> > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > ---
> > > v4: use dev_err_probe in error path.
> > > v3: Fix typo in commit message, dropped reported by.
> > > v2: Fix compilation error reported by Intel test robot
> > >     fixed checkpatch warning
> > > ---
> > >  drivers/pci/controller/pcie-rockchip.c | 149 +++++--------------------
> > >  drivers/pci/controller/pcie-rockchip.h |  25 +++--
> > >  2 files changed, 47 insertions(+), 127 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
> > > index 804135511528..024308bb6ac8 100644
> > > --- a/drivers/pci/controller/pcie-rockchip.c
> > > +++ b/drivers/pci/controller/pcie-rockchip.c
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
> > > +     err = devm_reset_control_bulk_get_optional_exclusive(dev,
> > > +                                                          ROCKCHIP_NUM_PM_RSTS,
> > > +                                                          rockchip->pm_rsts);
> > > +     if (err)
> > > +             return dev_err_probe(dev, err, "cannot get the reset control\n");
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
> > > +     err = devm_reset_control_bulk_get_optional_exclusive(dev,
> > > +                                                          ROCKCHIP_NUM_CORE_RSTS,
> > > +                                                          rockchip->core_rsts);
> > > +     if (err)
> > > +             return dev_err_probe(dev, err, "cannot get the reset control\n");
> > >
> > >       if (rockchip->is_rc) {
> > >               rockchip->ep_gpio = devm_gpiod_get_optional(dev, "ep",
> > > @@ -150,23 +118,10 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
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
> > > +             return dev_err_probe(dev, err, "reset bulk assert pm reset\n");
> > >
> > >       for (i = 0; i < MAX_LANE_NUM; i++) {
> > >               err = phy_init(rockchip->phys[i]);
> > > @@ -176,47 +131,17 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
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
> > > +             return dev_err_probe(dev, err, "reset bulk assert core reset\n");
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
> > > -     if (err) {
> > > -             dev_err(dev, "deassert aclk_rst err %d\n", err);
> > > -             goto err_exit_phy;
> > > -     }
> > > -
> > > -     err = reset_control_deassert(rockchip->pclk_rst);
> > > +     err = reset_control_bulk_deassert(ROCKCHIP_NUM_PM_RSTS,
> > > +                                       rockchip->pm_rsts);
> > >       if (err) {
> > > -             dev_err(dev, "deassert pclk_rst err %d\n", err);
> > > +             dev_err(dev, "reset bulk deassert pm err %d\n", err);
> > >               goto err_exit_phy;
> > >       }
> > >
> > > @@ -259,31 +184,15 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
> > >        * Please don't reorder the deassert sequence of the following
> > >        * four reset pins.
> > >        */
> >
> > The comment above says that the resets should not be reordered. But you have
> > reordered the resets.
> >
> As per the TRM [1], CRU_SOFTRST_CON8  clock reset unit has two groups
> one with reset value 0x1 and the other 0x0, so this patch groups them
> accordingly.
> 
> [1] https://opensource.rock-chips.com/images/e/ee/Rockchip_RK3399TRM_V1.4_Part1-20170408.pdf
> 
> If I only use reset_control_bulk_assert and
> reset_control_bulk_deassert for all the reset
> I get the below reset warning.
> 

I think you misunderstood what I asked for. The comment says that the 4 resets
(mgmt-sticky, core, mgmt, pipe) should not be reordered. In your new group
rockchip_pci_core_rsts(), you have reordered them. I was just asking you to keep
the 4 resets sorted as per the comment.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

