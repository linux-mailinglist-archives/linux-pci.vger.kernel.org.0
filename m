Return-Path: <linux-pci+bounces-27168-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4FDAA988D
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 18:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50BA73BE756
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 16:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD1A26989B;
	Mon,  5 May 2025 16:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="As9c624a"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6509E266F05
	for <linux-pci@vger.kernel.org>; Mon,  5 May 2025 16:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746461691; cv=none; b=cMrb5+xr5qe3biofqmOfNn3ov2HM1W56yfkEjcLwyoZLY1+QFfbIKMyf6Rqk9O7+pZpg7TZZLP4LEfwD0wEUT6fq+kyl+nr0HOcUg19liHH23ry4ZPd80EP/VZJ7WHzNnVQjwVjc7Yyi0iCzVqkIwo+J7QwIUJ4e/ylW1AdFbhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746461691; c=relaxed/simple;
	bh=uLrzbdahsUmod1H0JDtWBWqN4XVQU2rX5062gbNEroo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q51dcEybFI1U2wAbpX4myVDuk79OAPTUgq3I/qfOoQxJEcIy2Vnr9pSH70fEjnvCDg66BMQqohKJh6LeVsOB5C7JEzOTWcfUuFd44me6kJalKunOLtzaeklFrdiC1ZN31I3i9bhxPRSLWydfUk8niRVCPMXRJ+z8Vpdla4KA8c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=As9c624a; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-73972a54919so4307206b3a.3
        for <linux-pci@vger.kernel.org>; Mon, 05 May 2025 09:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746461689; x=1747066489; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SWvry4KDZapMEnULakjmTiQHQSX4k/taW1KwMUhJXLA=;
        b=As9c624aaiMVAKB+VJ4z90aQeuIRSig7YQw6b2NSQ1m+SxpqVnzrzd8tkvAlY0tXEd
         2Lxo9X1X255L2SvYRrsbuRTKZyOjWFoLuBcfFArQKhXwhU5dTOF4Jk/Zwi9U/eZQpxBn
         9Gnwf9zhrL/ot9XyIRUkQpJ5p1d6ecqPhaYONVWUoXr81S6wOB5+AX7C5SWWnwIYhs0z
         V5JyEhexCWicPVKm/vC4Kay72Ubo9AoqKm4J6YF2yyt7rKHApAccXhHd6W5AJif9Gcn1
         RcplOuXeiSYRMDDD7fsRDnY8MNKHTGhthQkgQWNlqt1ZTq+KGtPLuRNBkyWQTdLb3jSm
         wq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746461689; x=1747066489;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SWvry4KDZapMEnULakjmTiQHQSX4k/taW1KwMUhJXLA=;
        b=cN2knxgVm1Ud4FGMGGVgvlYei5evozGwJjW3CXGTZH4sqnJNssA5JeaREDidDA2Ijz
         1Ehoduy4HZsa9h+WeInwACLIXzZMBebQb9Qc5m2ySE4DVNzJ6akYNqZVAEmWtu97hFr4
         +cJIkEbfAn61FZa6ZoQpgHDX83aITS8pdgLJKBzPOD27xzYgtN+YWn/S6W7AlUjjlTMA
         Rk6MMc/Nmier1mEbhSSh4VwL7qciVv/iWzv7wOKXEntwf2UBtoJd3vesisDfnp6gu8hc
         gWLUDbn0V+KPkLV4xhXlYE4UEasWtO5lpGacLMOJDqW+z3/+eINNbWoM9KIIkG2PJYLj
         QQsg==
X-Forwarded-Encrypted: i=1; AJvYcCVLAE5BUTOeDeEpVeWGXEz9LsSXMI7+uP2PhBArIw5QVt9Bt/v/DzcnpozMCsWbth43fB/EkuMWwo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOJa6/bcwz9ksWgBEnTtO5/jmY3B9ovH4GDFJa9Luh4gF7S9m7
	BE3AwjJkZXF/rIO29Q7xSsHiwnpllE+cLQ2IdQJ9jfsN9Go1HtQm7FPir+DA0g==
X-Gm-Gg: ASbGncukdi/K9MvY9IoHUf/Z4zpbh70jhUVbLnSsUZjW66/eCrL//DnvdncFFBKa6e9
	2aUzfIPsBgwe25PRAqMElJCsBwKGdwLAIkDqgM+lODRF5zH67FCLhaHeVJvFNxQU9i6db4eedVL
	mPea/KMtjPXSNEW+cvuA8uwDtSVfgWT98E+3pQXI0NtBPuC16JVnm5VsZZcygZQ69vsfn96j1tv
	YcEeiTJgpHr/Z+MEEAeMOxilWFUt2R4PVMAknafBV2VAHm/7MA960fouO+SkyNFkdnbi04zwHpj
	Idi9JYYwHujw7kQISWYy2Is5A13tVKnC2Sk2eO8eekkMiaXcHUM=
X-Google-Smtp-Source: AGHT+IGDlihVIhUXhK0fIymH88F2X8FV0rkQuFidNrc3Roi5FkXvbM1MtssO/KpT/pJrJT2EqnO02g==
X-Received: by 2002:a05:6a00:9095:b0:732:5164:3cc with SMTP id d2e1a72fcca58-7406f17ac90mr10027660b3a.19.1746461688655;
        Mon, 05 May 2025 09:14:48 -0700 (PDT)
Received: from thinkpad ([120.60.48.235])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-740590a1c09sm6964138b3a.168.2025.05.05.09.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 09:14:48 -0700 (PDT)
Date: Mon, 5 May 2025 21:44:38 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Zhou Wang <wangzhou1@hisilicon.com>, 
	Will Deacon <will@kernel.org>, Robert Richter <rric@kernel.org>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Marc Zyngier <maz@kernel.org>, 
	Conor Dooley <conor.dooley@microchip.com>, Daire McNamara <daire.mcnamara@microchip.com>, 
	dingwei@marvell.com, Lukas Wunner <lukas@wunner.de>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, wilfred.mallawa@wdc.com
Subject: Re: [PATCH v3 5/5] PCI: qcom: Add support for resetting the slot due
 to link down event
Message-ID: <tflie6ncttih5jxn5xg3zvktidqv5jaqsnsuryy56qfq7pghxd@ippj4lhsdqme>
References: <20250417-pcie-reset-slot-v3-0-59a10811c962@linaro.org>
 <20250417-pcie-reset-slot-v3-5-59a10811c962@linaro.org>
 <aBjTpglI5_P2Q3Aa@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aBjTpglI5_P2Q3Aa@ryzen>

On Mon, May 05, 2025 at 05:05:10PM +0200, Niklas Cassel wrote:
> Hello Mani,
> 
> On Thu, Apr 17, 2025 at 10:46:31PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > @@ -1571,6 +1652,9 @@ static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
> >  		pci_unlock_rescan_remove();
> >  
> >  		qcom_pcie_icc_opp_update(pcie);
> > +	} else if (FIELD_GET(PARF_INT_ALL_LINK_DOWN, status)) {
> > +		dev_dbg(dev, "Received Link down event\n");
> > +		pci_host_handle_link_down(pp->bridge);
> >  	} else {
> >  		dev_WARN_ONCE(dev, 1, "Received unknown event. INT_STATUS: 0x%08x\n",
> >  			      status);
> 
> From debugging an unrelated problem, I noticed that dw-rockchip can
> sometimes have both "link up" bit and "hot reset or link down" bit set
> at the same time, when reading the status register.
> 

That's a good catch. It is quite possible that both fields could be set at once,
so 'if..else' is indeed a bad idea.

> Perhaps the link went down very quickly and then was established again
> by the time the threaded IRQ handler gets to run.
> 
> Your code seems to do an if + else if.
> 
> Without knowing how the events work for your platforms, I would guess
> that it should also be possible to have multiple events set.
> 

I agree.

> 
> In you code, if both LINK UP and hot reset/link down are set,
> I would assume that you driver will not do the right thing.
> 
> Perhaps you want to swap the order? So that link down is handled first,
> and then link up is handled. (If you convert to "if + if "instead of
> "if + else if" that is.)
> 

Makes sense. I'll incorporate this change in v5, thanks!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

