Return-Path: <linux-pci+bounces-30370-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DF8AE3E5F
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 13:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDA7C188E422
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 11:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C33244698;
	Mon, 23 Jun 2025 11:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qe/gJaUS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4258523ED68;
	Mon, 23 Jun 2025 11:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750679103; cv=none; b=B1gtLh2oQvIG2kV20Gre8E6Kn5pGJ3waWQE6E6I2p0KDw3VY17596QWsoLo4E8yLk7OjAWRiZcOicFlFus950+wb5DXkx+5czwh0SDmRZMqiV+hOy5QYnKmU2sQNxuzojaS05mkJACyPqRcZKxIdi+HcD4if5oxYZssLjVDwZvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750679103; c=relaxed/simple;
	bh=+WpuDoAuYuRG1CsXK5FRjwuw1xqgocAhC0J1GZbol5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GycvjKDpBhoK0JOeHWW5Q2XGJhwZYlQE81wfOxfUYwKTY+j6PAhfFtn13IJkyrKFBIz/w9a4OR0xJRLZvkYmERNpUqRmrmJXUK/PBrSTfXTiYkiEo/OkiN8QrnfjZ1wEvNI6ZZn2oSpXh0JTjXTF292bOhQLq1uclX1zuyE+W+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qe/gJaUS; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-742c7a52e97so3172811b3a.3;
        Mon, 23 Jun 2025 04:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750679101; x=1751283901; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JUxN5m7hXm2b0M+zJP/i0W46Be3d9ie1H1mdsQ0bmnA=;
        b=Qe/gJaUS+Otpr7MsieWDLKPXsBy56yoGvzlsStzYVTN3jva4o3eVH1qio9patF/7Ej
         pvhKfywRHgJQQ1iSIkyFOV8y3KWFnY7a6VDN0RhyEW/z4LGjWAffpVlteQONJeCWIyP6
         RphEI4OfrZKpC7VkR+WVM9rCwxyl6MiYRE9lrMDQ6ZASTfWxgMJjgQbd8wFG/fWz+chm
         87WWpHDnpnlMXjj6KvBgZZ1DzvLTF86egvudCof4krXDERzcK/he9X+iIvh8+hytArla
         4Y0KgSEXM6l+4n/IRQPAjVpz2hkrxyopFY7tOgP78C4vsI4uzRtCr0a2dukMMbJUNS7R
         k3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750679101; x=1751283901;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JUxN5m7hXm2b0M+zJP/i0W46Be3d9ie1H1mdsQ0bmnA=;
        b=dqDf96imZm5RKgl1bok4jlPOlaTvTV7/gfh+k+KtPMSqL0ZA5fPdVA5TjDdnfdPyuj
         KtNi1FbWsI6TqSfiRXL/4SS9eNGDTUk55ZQpQu4smj09IR2H0c3IzgLfTeUsDiSXVA1Z
         sElb45MwqbKzZfgIHFajjaHV0HEu1Ib56OQ5bNDM7eQomByw3EeFcTtgtFpi22Frpsbk
         DvzhxS3o7Kkt/qvbd18C9SssKqPB0IqlGg/S2T+Z5wYquEBEWsj2dBibNiffJykHDbpX
         AB5Ma79rMaPjOnd0ccw/+oU6TWlyYFmz2p29/BJq+SpLbJYSUIGzCudXkKwk3jjgW1bf
         InxQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1mVZCXMOiYrlxFvnyazSph21C7mak+YUULwQcfT8dX+rO3HF+kP1YHDtlVbdAjJGWcbI+pVc2dbBU@vger.kernel.org, AJvYcCVL+mwoWiYVOXaQ5rZDuZyBnQKmJG9huPROnu98sDLNlyBRDrqiIS3wB5rGcDboZaQblEusaOJr+JvqT68=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGi2c/0crXh+KOhIoXTlXd/bcBpH3i++/JCIHln2Zd1UkhzkPU
	h1qaLFSVw5mT8enVs8DpVw3Uvxk/Iu5xoC7CSXbqFQ9oQso8wEi7lsAhovgHpcmv
X-Gm-Gg: ASbGncuJ5lUMGhb03VkTszBZoX1nKoDJSRPEbZD2T6jTgH8mYF1qYotoGIamFS1Z2FE
	IvN0kzl3KmJu9sw/OhXGj3KCBHoAmr4RnV0XKXCi/vSyC7NzMXfKxWWIr+8xRxKQqyQSQbvxTtL
	+dT6tHZi2DcBPXWLnCe3VOKKLeAyVYTBvxBL+NabtJyBM2DaYfSZtgM44jQ0EzjdyHdgq/koZMD
	alKstduWBEtA/crblB1gGndup0G17tUagDBpDJFN+q4SSA/zSHzKX2utmV4NVNKKxuznAR+cdib
	dPcc+I4hON4u3E++GljFoY3L2KwMn7BSNLvTAO4Ym4ETr7F5cg==
X-Google-Smtp-Source: AGHT+IFbrASD277xcSwNBKzxe63luwLbeNcRlZ7w2jxYC/RzfHfwxJaDm5lxfkKKJa088I1hyWqEkA==
X-Received: by 2002:a05:6a20:144f:b0:1f5:97c3:41b9 with SMTP id adf61e73a8af0-22026e6113amr16803387637.5.1750679101260;
        Mon, 23 Jun 2025 04:45:01 -0700 (PDT)
Received: from geday ([2804:7f2:800b:ea8e::dead:c001])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a64d289sm8207591b3a.132.2025.06.23.04.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 04:45:00 -0700 (PDT)
Date: Mon, 23 Jun 2025 08:44:49 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-rockchip@lists.infradead.org,
	Hugh Cole-Baker <sigmaris@gmail.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 2/3] PCI: rockchip-host: Retry link training on
 failure without PERST#
Message-ID: <aFk-MeIWFcBiGBPr@geday>
References: <cover.1749582046.git.geraldogabriel@gmail.com>
 <b7c09279b4a7dbdba92543db9b9af169776bd90c.1749582046.git.geraldogabriel@gmail.com>
 <zuiq3b2rsixymtjr3xzrb26clikvlja62wgj65umnse4kuk75c@x5qan73ispxe>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <zuiq3b2rsixymtjr3xzrb26clikvlja62wgj65umnse4kuk75c@x5qan73ispxe>

On Mon, Jun 23, 2025 at 05:29:46AM -0600, Manivannan Sadhasivam wrote:
> On Tue, Jun 10, 2025 at 04:05:40PM -0300, Geraldo Nascimento wrote:
> > After almost 30 days of battling with RK3399 buggy PCIe on my Rock Pi
> > N10 through trial-and-error debugging, I finally got positive results
> > with enumeration on the PCI bus for both a Realtek 8111E NIC and a
> > Samsung PM981a SSD.
> > 
> > The NIC was connected to a M.2->PCIe x4 riser card and it would get
> > stuck on Polling.Compliance, without breaking electrical idle on the
> > Host RX side. The Samsung PM981a SSD is directly connected to M.2
> > connector and that SSD is known to be quirky (OEM... no support)
> > and non-functional on the RK3399 platform.
> > 
> > The Samsung SSD was even worse than the NIC - it would get stuck on
> > Detect.Active like a bricked card, even though it was fully functional
> > via USB adapter.
> > 
> > It seems both devices benefit from retrying Link Training if - big if
> > here - PERST# is not toggled during retry.
> > 
> > For retry to work, flow must be exactly as handled by present patch,
> > that is, we must cut power, disable the clocks, then re-enable
> > both clocks and power regulators and go through initialization
> > without touching PERST#. Then quirky devices are able to sucessfully
> > enumerate.
> > 
> 
> This sounds weird. PERST# is just an indication to the device that the power and
> refclk are applied or going to be removed. The devices uses PERST# to prepare
> for the power removal during assert and start functioning after deassert.

Hi Mani! Thank you for looking into this.

Yeah, tell me about it, it is beyond weird. I posted RFC Patch in the
hopes someone with access to PCIe Analyzer could have deeper look
at what the heck is going on here - because it does work, but I don't
claim to understand how.

> 
> It looks like the PERST# polarity is inverted in your case. Could you please
> change the 'ep-gpios' polarity to GPIO_ACTIVE_LOW and see if it fixes the issue
> without this patch?
> 
> If that didn't work, could you please drop the 'ep-gpios' property and check?

Sorry to decline your request, but I assure you I have tried many
other combinations before reaching present patch, including your
suggestion. It will do nothing. It won't work, won't make SSD that
refuse to work with RK3399, working. Note that this isn't specific
to my board - RK3399 is infamous for being picky about devices.

> 
> > No functional change intended for already working devices.
> > 
> > Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
> > ---
> >  drivers/pci/controller/pcie-rockchip-host.c | 47 ++++++++++++++++++---
> >  1 file changed, 40 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
> > index 2a1071cd3241..67b3b379d277 100644
> > --- a/drivers/pci/controller/pcie-rockchip-host.c
> > +++ b/drivers/pci/controller/pcie-rockchip-host.c
> > @@ -338,11 +338,14 @@ static int rockchip_pcie_set_vpcie(struct rockchip_pcie *rockchip)
> >  static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
> >  {
> >  	struct device *dev = rockchip->dev;
> > -	int err, i = MAX_LANE_NUM;
> > +	int err, i = MAX_LANE_NUM, is_reinit = 0;
> >  	u32 status;
> >  
> > -	gpiod_set_value_cansleep(rockchip->perst_gpio, 0);
> > +	if (!is_reinit) {
> > +		gpiod_set_value_cansleep(rockchip->perst_gpio, 0);
> > +	}
> >  
> > +reinit:
> 
> So this reinit part only skips the PERST# assert, but calls
> rockchip_pcie_init_port() which resets the Root Port including PHY. I don't
> think it is safe to do it if PERST# is wired.

I don't understand, could you be a bit more verbose on why do you
think this is dangerous?

Thanks,
Geraldo Nascimento

> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்

