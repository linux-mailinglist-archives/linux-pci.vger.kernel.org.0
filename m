Return-Path: <linux-pci+bounces-11597-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 188AB94F235
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2024 17:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6847AB24EA7
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2024 15:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BB0186295;
	Mon, 12 Aug 2024 15:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZlunOgqB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7632184559
	for <linux-pci@vger.kernel.org>; Mon, 12 Aug 2024 15:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723478278; cv=none; b=hsuzyO2kCmEdQPQnt8XgnqqbFL0uDTwsyzNUHHc1g0b5gMhB0ThWI16J8KDca0VHBIC2JYwBGz3AN8SvJkBf6W6VDib91ObwF/CIMmdmDagnoPnrslTMia7pCcKTmcoM4PLOMxDI0D/V9E3YY1cK5VtcSQp9dhMhX7BFrOPLESQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723478278; c=relaxed/simple;
	bh=7g6kE6XAl7HWzVew9VexULl4c9j+VJp8ngaJ3bYlAew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JY3jl0qZW/x1cZSZicrf5fvrdWf6PHBZOt6iUQGRXLL69cqZt8mwEpmyv6XRqtY6Sf9OMDO4/ssv3zANiVMmgcQzZ/98FeT4GLAdwK2Qx8hAvtnwpOZ9Oc86lQV1dLo4ezPax3jbOuBVayuWBQzEXzcR+/8IUW0avMNvFYZJ7Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZlunOgqB; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fc4fcbb131so34073425ad.3
        for <linux-pci@vger.kernel.org>; Mon, 12 Aug 2024 08:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723478276; x=1724083076; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R7G5lXJ8+mpxTpxMVd0PsQcEoG84K7UrtkS21/lEGPI=;
        b=ZlunOgqBSEAFKY+AzUH7V37KdzTO104xEnp5zbCqvJ4pjpqw2gN9vD3wtKErFtojVL
         30G/AnMNi8K/QC5Kfzkp9rbszr2brWhY2n47OYA5GBh7FygDkbo/3hAMqImjwWdcI9o+
         exYnDHEZNfToebB9MBWgJqiRUb+SyhnNy6CoAygYrTCOnRz9/OFQvyiDUdvKhwOVTv4W
         KVX4pLEiPCFH8jZwl35uMDPikdN2w0sXoKCTdrntCubHKniGAZgPOOimTU4K52g3V4sq
         rOtPQwbboT2x37lQ3hd7XggXPFgQS+6q3D2JySbKFKLdvXys/6WazGbJPwF3vVIt3OZj
         QYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723478276; x=1724083076;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R7G5lXJ8+mpxTpxMVd0PsQcEoG84K7UrtkS21/lEGPI=;
        b=UwrDdzDLJhDBDZDv/ueIQcQZg/XC+9libJX9ZlXOi+jHjt6c/Nl7+Vuve+kvVKinbr
         H4rxY/QPRiwUU5K8rs0g73o68lVE9TlPrn9U79sPIQGzEHfQbwn2RqQUwJBXUoQMe0H0
         GoZD7MF76Gk4voAfZKp9AcYuhIJpp8BZkuhuGGN9NNcAff/CvOqbIQDd/L8CMGmVGxsE
         pdcz5kdVLrLW5SZXSA3yze4I7AdcnGzBrUyfTVHirOaj8/G68Xb/n82HNddgSPnJDhRl
         TKeobbd3jHJcv5zJx3pqZwvWWU3O7HB3TL32Vc31DN0u7lj2wSIxhQ2swCvenZy7ix47
         P/RQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKTjELiX+AI76km3niitLu9HbUUWAnDK2nn10So7Q3KCxI6IuMp7nQNU2/9Ev8wCGgEMqREvnvzzUO0LjbUrZxD9F4j+scKING
X-Gm-Message-State: AOJu0YydCKqL2cCcDjfql4abg+UojthmOiLu/xEsfVtu+lcZBScIjo3l
	OJRv1POeBMVj+WD9ivyhJDV0qUx8wltKZDG7kSIAFOhg5/scM4xuQwWPY3VSig==
X-Google-Smtp-Source: AGHT+IEEj6btaDgOaSWDOrp+QplOLF1Pkma236uqOawQUH1HjeR+8/1+9MHkiVLvKalQKMrFDrGubg==
X-Received: by 2002:a17:903:230f:b0:1fa:8f64:8b0d with SMTP id d9443c01a7336-201ca1219e9mr8738555ad.4.1723478276032;
        Mon, 12 Aug 2024 08:57:56 -0700 (PDT)
Received: from thinkpad ([220.158.156.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bba063f6sm39609315ad.204.2024.08.12.08.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 08:57:55 -0700 (PDT)
Date: Mon, 12 Aug 2024 21:27:47 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: Stanimir Varbanov <svarbanov@suse.de>, linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 05/12] PCI: brcmstb: Use swinit reset if available
Message-ID: <20240812155747.GA6003@thinkpad>
References: <20240731222831.14895-1-james.quinlan@broadcom.com>
 <20240731222831.14895-6-james.quinlan@broadcom.com>
 <57f11aff-95f8-41fd-b35e-a9e5a85c68e3@suse.de>
 <CA+-6iNxd2txYOoeww3yPTPHRvZE_tVT+37Htkq=NUzbtzLkMRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+-6iNxd2txYOoeww3yPTPHRvZE_tVT+37Htkq=NUzbtzLkMRA@mail.gmail.com>

On Mon, Aug 12, 2024 at 09:43:46AM -0400, Jim Quinlan wrote:
> On Fri, Aug 9, 2024 at 5:53 AM Stanimir Varbanov <svarbanov@suse.de> wrote:
> >
> > Hi Jim,
> >
> > On 8/1/24 01:28, Jim Quinlan wrote:
> > > The 7712 SOC adds a software init reset device for the PCIe HW.
> > > If found in the DT node, use it.
> > >
> > > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > > ---
> > >  drivers/pci/controller/pcie-brcmstb.c | 19 +++++++++++++++++++
> > >  1 file changed, 19 insertions(+)
> > >
> > > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> > > index 4d68fe318178..948fd4d176bc 100644
> > > --- a/drivers/pci/controller/pcie-brcmstb.c
> > > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > > @@ -266,6 +266,7 @@ struct brcm_pcie {
> > >       struct reset_control    *rescal;
> > >       struct reset_control    *perst_reset;
> > >       struct reset_control    *bridge_reset;
> > > +     struct reset_control    *swinit_reset;
> > >       int                     num_memc;
> > >       u64                     memc_size[PCIE_BRCM_MAX_MEMC];
> > >       u32                     hw_rev;
> > > @@ -1633,12 +1634,30 @@ static int brcm_pcie_probe(struct platform_device *pdev)
> > >       if (IS_ERR(pcie->bridge_reset))
> > >               return PTR_ERR(pcie->bridge_reset);
> > >
> > > +     pcie->swinit_reset = devm_reset_control_get_optional_exclusive(&pdev->dev, "swinit");
> > > +     if (IS_ERR(pcie->swinit_reset))
> > > +             return PTR_ERR(pcie->swinit_reset);
> > > +
> > >       ret = clk_prepare_enable(pcie->clk);
> > >       if (ret)
> > >               return dev_err_probe(&pdev->dev, ret, "could not enable clock\n");
> > >
> > >       pcie->bridge_sw_init_set(pcie, 0);
> > >
> > > +     if (pcie->swinit_reset) {
> > > +             ret = reset_control_assert(pcie->swinit_reset);
> > > +             if (dev_err_probe(&pdev->dev, ret, "could not assert reset 'swinit'\n"))
> > > +                     goto clk_disable_unprepare;
> > > +
> > > +             /* HW team recommends 1us for proper sync and propagation of reset */
> > > +             udelay(1);
> >
> > Hmm, shouldn't this delay be part of .assert/.deassert reset_control
> > driver?  I think this detail is reset-control hw specific and the
> > consumers does not need to know it.
> 
> This was discussed previously.  I pointed out that we use a reset
> provider that governs dozens of devices.  The only thing that the
> provider could do is to employ a  worst case delay used for all
> resets.  This is unacceptable; we have certain devices that may have
> to invoke
> reset often and require timely action, and we do not want them having
> to wait the same amount of worst case delay as for example, a UART device reset.
> 
> Further, if I do a "grep reset_control_assert -A 10 drivers"  I see
> plenty of existing drivers that use usleep/msleep/udelay after the call to
> reset_control_assert, just as I am doing now.
> 
> As far as my opinion goes (FWIW) I think the delay is more apt to
> be present in the consumer driver and not the provider driver.  To
> ascertain this specific delay I had to consult with the PCIe HW team,
> not the HW team that implemented the reset controller.
> 

Yeah. Often the reset controller won't have any idea about the delay required
between assert + deassert, unless the reset controller is closely tied to the
peripheral. So keeping the delay in consumer drivers is the right thing to do.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

