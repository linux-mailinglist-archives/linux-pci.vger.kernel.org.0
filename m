Return-Path: <linux-pci+bounces-13745-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E7A98E93A
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 06:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 814E21C21EEA
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 04:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5434443AD9;
	Thu,  3 Oct 2024 04:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OXdBAGnL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFDB3AC2B
	for <linux-pci@vger.kernel.org>; Thu,  3 Oct 2024 04:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727931436; cv=none; b=VBIaVNnLLmXxSMs0tiBczQaqVuZk/YgcweGt16fJT5rAEHPtIKXzgOxKrfFvc+FnN4z35ie2OLXVuKMWMEh9Wc8/dUGEdn0j4+bv4MbamxiI/iWVBWYCk8vgnkqCRgu+/6lL0J3/Q7H50vNeg9PwpyGdRyFxKZCh8r1rgZrSXAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727931436; c=relaxed/simple;
	bh=qEnoBtsvZoh+9PLGVc+C4bgF5PV/jjkeM8XAPFbyTgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYL2Cde6vIvF4rbbxkw9VF3TsEm/As3IwiComCjkkQo/UF3yQwITpCWBQq7qTQr4Dbrx3O5LusfT6tGq20RoYMZQbrG+lVCmb/X4v/WYiDYLiSua/uyGH8pi1Ooz0yfLoqBCLJG2htmBGE3Rvb3VCJX/YSp8lAb+zd9S9S1aqJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OXdBAGnL; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-656d8b346d2so297393a12.2
        for <linux-pci@vger.kernel.org>; Wed, 02 Oct 2024 21:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727931432; x=1728536232; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8dDNfw+NjJwfHr3rs4t9p6Uot6ve0GGTnKxlXQV+iZE=;
        b=OXdBAGnLfMtY2FG4okmsu4wV8dNTqdhfnpviGhMMVOKbCrgWWqKFZ8LGDIEFj/ayO4
         rUo/emhztLLyVcBX152jP7IaXzYQOvqGp2/W3ZuwrmjUPZfi2FlnDgzAus1KJJkIv0ay
         GRjBcCHjGKRIHfAmZWvmrDpYB+UomMWsIaIZJeGuINNVpaDcWyGttnHnURW0w5JzaTVX
         5HK/i+F1MXPgDFBBr0BdIB99Vq6myj13yfukLVR4+0+p8Y3C9CVHnr/zNoU5v3dBKD6p
         t6u2MXYRyAkkLnNTqytpqD/A4AN8/bnw6ARRIYeqdjsJanEtjFCD6IYwWz343FmzLUl9
         TKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727931432; x=1728536232;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8dDNfw+NjJwfHr3rs4t9p6Uot6ve0GGTnKxlXQV+iZE=;
        b=bCHTeSLp7Xj8bqgnwFk92gCWNF16edYP3jEDwZnXBE6FCRNyCkCUOMf0eFLQ2kb/64
         7qHYq+QxuWPegwujJfVVsbKEOMhVB8QAuxlfwYxJHuH2kht7C573RJYFSMe0o5LO+9s9
         TVuV+KfMCqo1FIrdfjCgeV1neihfN9N1uxHy1NQx38hVkeI+/Fo3jllDMrS3P1+C/Oh6
         syf0Wy9Qx06R8mFEjh0boy+nLCmTrsEXwsHv+tgDOyKmSIP8IxrWMJXzZRIYiNwjgMES
         vGk9st6+yErQj7aJPwpi0WznykGqkzt4t8eM1jRA3yqdudBpizv3JOf+t9dJzJPGv4H4
         Wafw==
X-Forwarded-Encrypted: i=1; AJvYcCUiZMLYOzt/1UYxsl5leWPCNSCaTWWSJu6fBY+/Z74pbEkCxClB6B0a8YVFPmPIjX96cZP0IJAEfHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwSVExWE+KTgKkfQVRDvBcEudKkW7S80qBEvuV+5QU/3ixh3Sk
	nF//SERFVihWDX5cMhI/OGkdzaS9/neoU+t/4gKuJzk/Uf+etv1omtf9zmEQaA==
X-Google-Smtp-Source: AGHT+IH6h3pPAfdiE/OAeLgcL5M9L/V1oC+Dm1QHf9XghZuR3HLE9GJaHmWNiuj0yQDfqrO7gF3icw==
X-Received: by 2002:a05:6a21:6e41:b0:1d4:fc66:30e8 with SMTP id adf61e73a8af0-1d5db163d65mr8252358637.10.1727931432531;
        Wed, 02 Oct 2024 21:57:12 -0700 (PDT)
Received: from thinkpad ([36.255.17.222])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9dbfee44dsm2588a12.64.2024.10.02.21.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 21:57:12 -0700 (PDT)
Date: Thu, 3 Oct 2024 10:27:07 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_qianyu@quicinc.com, Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH] PCI: qcom: Enable MSI interrupts together with Link up
 if global IRQ is supported
Message-ID: <20241003045707.gy3zemtxrheuipr7@thinkpad>
References: <20241001042055.ivf4zspq4fqmaxth@thinkpad>
 <20241001211957.GA227250@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241001211957.GA227250@bhelgaas>

On Tue, Oct 01, 2024 at 04:19:57PM -0500, Bjorn Helgaas wrote:
> On Tue, Oct 01, 2024 at 09:50:55AM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Sep 30, 2024 at 12:11:01PM -0500, Bjorn Helgaas wrote:
> > > On Mon, Sep 30, 2024 at 07:14:09PM +0530, Manivannan Sadhasivam wrote:
> > > > Currently, if global IRQ is supported by the platform, only the Link up
> > > > interrupt is enabled in the PARF_INT_ALL_MASK register. But on some Qcom
> > > > platforms like SM8250, and X1E80100, MSIs are getting masked due to this.
> > > > They require enabling the MSI interrupt bits in the register to unmask
> > > > (enable) the MSIs.
> > > 
> > > "global IRQ" is a very generic name.  If that's the official name, it
> > > should at least be capitalized, e.g., "Global IRQ", to show that it is
> > > a proper noun that refers to a specific IRQ.
> > 
> > Sure.
> > 
> > > > Even though the MSI interrupt enable bits in PARF_INT_ALL_MASK are
> > > > described as 'diagnostic' interrupts in the internal documentation,
> > > > disabling them masks MSI on these platforms. Due to this,
> > > 
> > > > MSIs were not
> > > > reported to be received these platforms while supporting global IRQ.
> > > 
> > > I'm trying to parse "while supporting global IRQ."  We basically
> > > support global IRQ by installing qcom_pcie_global_irq_thread(), but of
> > > course the device doesn't see that, so I assume it would be more
> > > informative to say that MSIs are masked by some register setting.
> > 
> > Hmm, this is what I mentioned in the above paragraph referencing
> > PARF_INT_ALL_MASK register. Is that not clear enough?
> 
> It requires the knowledge that the MSI enable bits are set by
> hardware, cleared by 4581403f6792, and set again here.  This will be
> more accessible to non-qcom experts if that information is included
> here.
> 

Okay.

> > > The patch suggests that MSIs are masked internally unless
> > > PARF_INT_MSI_DEV_0_7 is set in PARF_INT_ALL_MASK.
> > > 
> > > Are you saying that prior to 4581403f6792, MSIs did work?  Does that
> > > mean PARF_INT_MSI_DEV_0_7 was set by a bootloader or something, so
> > > MSIs worked?  And then 4581403f6792 came along and implicitly cleared
> > > PARF_INT_MSI_DEV_0_7, so MSIs were then masked?
> > 
> > Yeah. Those bits were enabled by default in hardware, but since they were
> > mentioned as 'diagnostic interrupts' in documentation, commit 4581403f6792
> > intentionally disabled them. But that results in MSIs getting masked in
> > *some* platforms.
> 
> Apparently the "*some* platforms" part is more qcom-expert knowledge?

I already mentioned those platforms in the commit message 'SM8250 and X1E80100'.

> There are other qcom platforms where MSIs are not disabled by
> 4581403f6792?  Information about which platforms are which also sounds
> useful for future maintenance.
> 

Yeah, SM8450 is the one which I know so far. I will mention it explicitly.

- Mani

> > > > So enable the MSI interrupts along with the Link up interrupt in the
> > > > PARF_INT_ALL_MASK register if global IRQ is supported. This ensures that
> > > > the MSIs continue to work and also the driver is able to catch the Link
> > > > up interrupt for enumerating endpoint devices.
> > > > 
> > > > Fixes: 4581403f6792 ("PCI: qcom: Enumerate endpoints based on Link up event in 'global_irq' interrupt")
> > > > Reported-by: Konrad Dybcio <konradybcio@kernel.org>
> > > > Closes: https://lore.kernel.org/linux-pci/9a692c98-eb0a-4d86-b642-ea655981ff53@kernel.org/
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > ---
> > > >  drivers/pci/controller/dwc/pcie-qcom.c | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > index ef44a82be058..2b33d03ed054 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > @@ -133,6 +133,7 @@
> > > >  
> > > >  /* PARF_INT_ALL_{STATUS/CLEAR/MASK} register fields */
> > > >  #define PARF_INT_ALL_LINK_UP			BIT(13)
> > > > +#define PARF_INT_MSI_DEV_0_7			GENMASK(30, 23)
> > > >  
> > > >  /* PARF_NO_SNOOP_OVERIDE register fields */
> > > >  #define WR_NO_SNOOP_OVERIDE_EN			BIT(1)
> > > > @@ -1716,7 +1717,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
> > > >  			goto err_host_deinit;
> > > >  		}
> > > >  
> > > > -		writel_relaxed(PARF_INT_ALL_LINK_UP, pcie->parf + PARF_INT_ALL_MASK);
> > > > +		writel_relaxed(PARF_INT_ALL_LINK_UP | PARF_INT_MSI_DEV_0_7,
> > > > +			       pcie->parf + PARF_INT_ALL_MASK);
> > > >  	}
> > > >  
> > > >  	qcom_pcie_icc_opp_update(pcie);
> > > > -- 
> > > > 2.25.1
> > > > 
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்

