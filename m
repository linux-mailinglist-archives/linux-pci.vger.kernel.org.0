Return-Path: <linux-pci+bounces-20920-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A265A2CA38
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 18:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B5353A145E
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 17:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19817193429;
	Fri,  7 Feb 2025 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DbpT7yJY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FC915E5B8
	for <linux-pci@vger.kernel.org>; Fri,  7 Feb 2025 17:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738949630; cv=none; b=K5PDfMLRaHM3ID8w2eS6XfTdvItKl6rGQ2ERoUhgCeLHNYs7540MD8UdnUzqyJx7isSy6EvrZmKYqP0bc1a6IitgAQGSRDhMxl78GKyTW4uVmu6BHxp9J88Em+/Wz9uRdwp8XTs+20HIrshb/3BJm8r5yGQ9eraTM3Bmn2Spg8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738949630; c=relaxed/simple;
	bh=heKwUZUbcmyVtVPlyLMpMkb+c7yJ6iwb4h2qAwrn0GM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YspDJradkV08bCPQqvC3kgVO7YL4HtnaZnSlO3anpTkts3OStTmFiphoiwoCJWbUnbuviAwt4jhJphkMv4ST9NRfkKH7N1VMxFIw7ChdoUfXXK5vStS9kyzgNniPxo/ZBz+WoU0G53qAf5FrqNYXYtCY6E2BLD4sdZ+QMMca2IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DbpT7yJY; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21f6022c2c3so7869795ad.0
        for <linux-pci@vger.kernel.org>; Fri, 07 Feb 2025 09:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738949627; x=1739554427; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b6DSgMi12Y1DTWXSxB1u+L8gWNg8zLGbTo3gPZs3j0U=;
        b=DbpT7yJYRz9SQNTxCL+wl8s+6SLB6Y1380v4uJ74Fyci/v2Dd7M1XOm/gm66OWIwFt
         Zdax0CP873T/CyZmTFBO7+cotKmoU6PHjRNSjw700LXUMk3p09VAFdI1eYVNoWM8AB6+
         rK7SGJFf+u8nc1+zpEHf/g9+dhratuH5qqpjtM0IDxWuOx83YQu33Ew0whbUc2BP94n6
         m7VzkS/zA/Y48CnVmrgQAKboLsMjyN/8ATNMf5hGbt1H1fEzF8MQrU4V+31pLrWPxVEE
         bi1NmvGRJ8LlOStXgh0AbHBZhZ8urdlheTk6Fkq1kfcp+GhqGuCj7SSiCgjFABHmMj+K
         cWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738949627; x=1739554427;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b6DSgMi12Y1DTWXSxB1u+L8gWNg8zLGbTo3gPZs3j0U=;
        b=UxIhDqA5TP1Y+saTZg+26aQKY0CfXYzs8ol95oarLritEsyVLGitHKMNtLBz3VmsFh
         yW+uiJs1hhcAAMPum71bHie6SgS7hUTo1/m308Ekg/cJ58x2z2H3kCS+zpGKCksOaEax
         seF7rlFP24YOTWE/W2xdONobr36gULdn2qxizMPH1fjigS99MrOJV5ZG0f0E3kr1Qx2x
         2A7Kiuu+d2kMgS4uos+JWtDszPrFWeC0LbLPatVxZVa+PY7Kcyk/+R7ZZSVW9aV5504j
         5UwhaMlmxFB9TU7t49twqAkk9SB7fe1w38IZtftTR2ytp6jLIz/oyD2grcD59StFdtA/
         NJOw==
X-Forwarded-Encrypted: i=1; AJvYcCXVuLzwrz1eBvI726XwVtdp1qZ8wg6xorydmJUfU4SzywylngwTswwrehm47huuVJT/cAoWpcb7WAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaUyoyse4YYE6OATHHPghl2JAIeYrqH47I4MZgBT4rz6Movi/s
	xWw2UzfKoa90f/bclWfFSysqPc7aObq8OrqtCrzkJX5XSn0N+I58tVZidD39Kg==
X-Gm-Gg: ASbGncvEpXKzmBLV+aiIS/yz76RE8Ze476nn2WdMV8ifesc0OUNg/4w/sa5CeaubtEw
	yZuRBsH11Ujqt9ButDUEghNoYuVNRSqrFrBtVDvQKXC0WvW6VFoVWPUNlhfECX453N9w9thrxY0
	0H8ABntBIatGrrTADvdQniF3Ngz/GDeF9zeQt/ouC0AE8EfLUtq7eYx5eQ4tvDKRv79H8JOv2GK
	uD2Ghsbejy8SUFSxBVoVXqYjLuxN/9hYYEnfKTggufQLye0creXufwy8io5QOr9GKZ4sl0Vil45
	fJ/8bJpUkmeP4rg+nhr9IYwrEQ==
X-Google-Smtp-Source: AGHT+IF/6HJMivCoSnQWmuUQfnYzeYmJJ18uAMqp9K/Rr+W3BGx4zE82YztHxZQyN+t5mKrGChZ44g==
X-Received: by 2002:a05:6a20:2d07:b0:1e1:b105:158f with SMTP id adf61e73a8af0-1edf36f3822mr13144747637.19.1738949627535;
        Fri, 07 Feb 2025 09:33:47 -0800 (PST)
Received: from thinkpad ([120.60.76.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad51aee5bb1sm3342184a12.38.2025.02.07.09.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 09:33:46 -0800 (PST)
Date: Fri, 7 Feb 2025 23:03:41 +0530
From: "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>
To: Wilson Ding <dingwei@marvell.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Sanghoon Lee <salee@marvell.com>
Subject: Re: [PATCH 1/1] PCI: armada8k: Disable LTSSM on link down interrupts
Message-ID: <20250207173341.anqw7ybp7vn6md4s@thinkpad>
References: <20241112064241.749493-1-jpatel2@marvell.com>
 <20241112214337.GA1861873@bhelgaas>
 <BY3PR18MB4673E2698A6F465FEB56B5A2A7EB2@BY3PR18MB4673.namprd18.prod.outlook.com>
 <BY3PR18MB467343D941D2F7706FD88FCBA7EB2@BY3PR18MB4673.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BY3PR18MB467343D941D2F7706FD88FCBA7EB2@BY3PR18MB4673.namprd18.prod.outlook.com>

On Sat, Feb 01, 2025 at 12:57:56AM +0000, Wilson Ding wrote:
> I am writing to follow up on this serious of PCIe patches submitted by Jenish.
> Unfortunately, he has since left the company, and some comments on these
>  patches were not addressed in a timely manner. I apologize for the delay
> and any inconvenience this may have caused. I have reviewed the feedback
> provided and am now taking over this work. I appreciate the time and effort
> you have put into reviewing the patch and providing valuable comments.
> I will ensure that the necessary changes are made and resubmit the patch
> in the proper manner, as it was not initially submitted as a series.
> 
> > > When a PCI link down condition is detected, the link training state
> > > machine must be disabled immediately.
> > 
> > Why?
> > 
> > "Immediately" has no meaning here.  Arbitrary delays are possible and must
> > not break anything.
> 
> Yes, I agree. A delay cannot be avoided. The issue we encountered is that
> the RC may not be aware of the link down when it happens. In this case,
> any access to the PCI config space may hang up PCI bus. The only thing we
> can do is to rely on this link down interrupt. By disabling APP_LTSSM_EN,
> RC will bypass all device accesses with returning all ones (for read).
> 

Ok. One comment below.

> > > Signed-off-by: Jenishkumar Maheshbhai Patel
> > > <mailto:jpatel2@marvell.com>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-armada8k.c | 38
> > > ++++++++++++++++++++++
> > >  1 file changed, 38 insertions(+)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c
> > > b/drivers/pci/controller/dwc/pcie-armada8k.c
> > > index b5c599ccaacf..07775539b321 100644
> > > --- a/drivers/pci/controller/dwc/pcie-armada8k.c
> > > +++ b/drivers/pci/controller/dwc/pcie-armada8k.c
> > > @@ -53,6 +53,10 @@ struct armada8k_pcie {
> > >  #define PCIE_INT_C_ASSERT_MASK		BIT(11)
> > >  #define PCIE_INT_D_ASSERT_MASK		BIT(12)
> > >
> > > +#define PCIE_GLOBAL_INT_CAUSE2_REG	(PCIE_VENDOR_REGS_OFFSET
> > + 0x24)
> > > +#define PCIE_GLOBAL_INT_MASK2_REG	(PCIE_VENDOR_REGS_OFFSET
> > + 0x28)
> > > +#define PCIE_INT2_PHY_RST_LINK_DOWN	BIT(1)
> > > +
> > >  #define PCIE_ARCACHE_TRC_REG		(PCIE_VENDOR_REGS_OFFSET
> > + 0x50)
> > >  #define PCIE_AWCACHE_TRC_REG		(PCIE_VENDOR_REGS_OFFSET
> > + 0x54)
> > >  #define PCIE_ARUSER_REG			(PCIE_VENDOR_REGS_OFFSET
> > + 0x5C)
> > > @@ -204,6 +208,11 @@ static int armada8k_pcie_host_init(struct
> > dw_pcie_rp *pp)
> > >  	       PCIE_INT_C_ASSERT_MASK | PCIE_INT_D_ASSERT_MASK;
> > >  	dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_MASK1_REG, reg);
> > >
> > > +	/* Also enable link down interrupts */
> > > +	reg = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_INT_MASK2_REG);
> > > +	reg |= PCIE_INT2_PHY_RST_LINK_DOWN;
> > > +	dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_MASK2_REG, reg);
> > > +
> > >  	return 0;
> > >  }
> > >
> > > @@ -221,6 +230,35 @@ static irqreturn_t armada8k_pcie_irq_handler(int
> > irq, void *arg)
> > >  	val = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_INT_CAUSE1_REG);
> > >  	dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_CAUSE1_REG, val);
> > >
> > > +	val = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_INT_CAUSE2_REG);
> > > +
> > > +	if (PCIE_INT2_PHY_RST_LINK_DOWN & val) {
> > > +		u32 ctrl_reg = dw_pcie_readl_dbi(pci,
> > PCIE_GLOBAL_CONTROL_REG);
> > 
> > Add blank line.
> > 
> > > +		/*
> > > +		 * The link went down. Disable LTSSM immediately. This
> > > +		 * unlocks the root complex config registers. Downstream
> > > +		 * device accesses will return all-Fs
> > > +		 */
> > > +		ctrl_reg &= ~(PCIE_APP_LTSSM_EN);
> > > +		dw_pcie_writel_dbi(pci, PCIE_GLOBAL_CONTROL_REG,
> > ctrl_reg);
> > 
> > And here.
> > 
> > > +		/*
> > > +		 * Mask link down interrupts. They can be re-enabled once
> > > +		 * the link is retrained.
> > > +		 */
> > > +		ctrl_reg = dw_pcie_readl_dbi(pci,
> > PCIE_GLOBAL_INT_MASK2_REG);
> > > +		ctrl_reg &= ~PCIE_INT2_PHY_RST_LINK_DOWN;
> > > +		dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_MASK2_REG,
> > ctrl_reg);
> > 
> > And here.  Follow existing coding style in this file.
> > 
> > > +		/*
> > > +		 * At this point a worker thread can be triggered to
> > > +		 * initiate a link retrain. If link retrains were
> > > +		 * possible, that is.
> > > +		 */

Who is supposed to retrain the link? Where is the worker thread?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

