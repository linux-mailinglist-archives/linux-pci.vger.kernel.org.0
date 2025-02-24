Return-Path: <linux-pci+bounces-22198-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29203A42009
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 14:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C6787A23C5
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 13:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E91623BD03;
	Mon, 24 Feb 2025 13:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c94feaQF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A738523BCF3
	for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2025 13:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740402744; cv=none; b=DWWJO5W24RLLk9NgsSJXaj5213NybKp3u+lwD6ntcz4Y67R/ryekcJTEX7e8k3Nf304lFnZSsTUW0vwS46i+qRexVluF/ltPv0gatOPPrsA2epgNBM1bExejQ5DwgLUSXxRi7T2Zu95ihBpAYkn1CKaos5AL4KlCQCyS14s3Uks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740402744; c=relaxed/simple;
	bh=4JJCr+hzIcHgx1zZ7pN1MHsI83h/HIKz+kxxuG1tyKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdHgy7LWRNsfrN3RVJ8A8OnSN2B5g48yfFnvWBc42bY3XfjIPXir7OwfMtBCbhF3UI1sw2k3ltYVeTFMvL9Kv/PP5+3AgAPmVZfAmlyA0UcMusCL456EJwBK0VA2Q/A6THwhB+zK/6S6Iv1v3azdOy+H14y4VmNfcqBZz3fIFno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c94feaQF; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2212a930001so3646105ad.0
        for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2025 05:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740402742; x=1741007542; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6xivWvjfsx4I7sb2/boiuXVtJjYaejU6ywHPFZw0QHc=;
        b=c94feaQFf8WwknSRZs0SmPCTm/VOOOW9D+Ic8JV/6P4SnqGxc4FZG8fgj+dH0WaBmh
         2k/gYF1a++k8zp4qcsQBVZy24KSbMZLAvaMRQugEoNtdlNjCD3zsYQ6A1zr1wHKCis6r
         z5TprjXkctYCeafDE3CUGPCGdfW11DFH/CX1CRpTLmJ2HQVjnS1eSK+1AajN60wqXLyD
         M9nwImEBgheuYIUzcLAR+nX3kuvIaOhtbTeCuj8puWTxnTCukUfc83SjbnCk4vWOGGcH
         xHaiFugFyL4QSWdBQFw6uCCF0TCAHUgfLrQAuLlfEutoDpVB2ifhUSSjRryeYu14lTMI
         HMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740402742; x=1741007542;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6xivWvjfsx4I7sb2/boiuXVtJjYaejU6ywHPFZw0QHc=;
        b=Pj//lXBhj+rQkorTrgMMFogY9yI8RlB1R3nr5xTiCzsCGcucANmAvY3fxhYs043ja3
         fdamgnPiBE2uxNjeTfuSB6MaDiFeaM4a4xRsVjvi7iwJlY/gpZgH+C54zkU1DhPrW4Nv
         zJBiUTcWLfaZUV844gR6BY3Wnd3nl/2pDwuUSCyYXJPQKNNOsCM1pAjJDAC8ijb4EGe8
         3Avq4mq2ls6lTkOOL7Gc0751PvEdTImJMMOpyclDAGGGXIw5w2BS5X1/CgHTEzJIdVGl
         0oWsl7AxlzqTx6gCFEz+4QkcSTBJ/rwJFSKqWcGUpYQ8U51TCnOvXSFptpzt9RisZ/7r
         +Pmg==
X-Forwarded-Encrypted: i=1; AJvYcCXRXoCW2YQIlCPyT+PFT0pcZSs9yLHcTxqnmpOcV8MakxD50p6yicGKAv1Ut/oJag4PHv6I/AZjJq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQEBsT7ed80qGfZAzWIMOiV3qAyMIPL+GRsVchk6DKEtHh48Qz
	A9fyGtCXYiY1GARIjP4g4/4afVPHwCcJni0LAA6O5TCNGkgjiCGv7B/iSHg5hA==
X-Gm-Gg: ASbGncuV+XoJo/Y83IQHCZW9VgQSIjQ24N0Ki7ZZ8cxrpyAeytJRWvK+RBr285kSItU
	Y6OEPFPZJOpgjaNgZmVqcUKjkPqF4PUrhAVtdPSprE774VvjWO3XLJUXLa9iQtLaVN/+uPzjj/d
	GqQQk6ZwhcfCyhp6x+Pay3GhXGIFKjAKimJiGEOvCxXooUARFaCch9t00Q90whLICdIYl5SGjx0
	4JjOC8q5Evt6Cahzk81nopoPrEtG4geYsFwH8/pxJML5Wp/2JPEm5CB988KBper/HTqy2Cu7Y8l
	RlYY56iMUa1wxlfUZ5yWvEW5S6uOcS3BGvav
X-Google-Smtp-Source: AGHT+IH66tyyeq6a6srxXBnhCf5MfUJnzgVf0ncZyII3wiL8V1nQJMP3kqGHxIeAsJESjLWajBiwzQ==
X-Received: by 2002:a05:6a00:4b54:b0:732:6217:8c69 with SMTP id d2e1a72fcca58-73426c94ad6mr24845216b3a.3.1740402741835;
        Mon, 24 Feb 2025 05:12:21 -0800 (PST)
Received: from thinkpad ([36.255.17.202])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adcc6fb20f8sm16951931a12.37.2025.02.24.05.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 05:12:21 -0800 (PST)
Date: Mon, 24 Feb 2025 18:42:15 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Simek, Michal" <michal.simek@amd.com>,
	"Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>
Subject: Re: [PATCH v14 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
Message-ID: <20250224131215.slcrh3czyl27zhya@thinkpad>
References: <20250224073117.767210-1-thippeswamy.havalige@amd.com>
 <20250224073117.767210-4-thippeswamy.havalige@amd.com>
 <20250224093024.q4vx2lygrc2swu3h@thinkpad>
 <SN7PR12MB720127D150CABEECA4A436358BC02@SN7PR12MB7201.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN7PR12MB720127D150CABEECA4A436358BC02@SN7PR12MB7201.namprd12.prod.outlook.com>

On Mon, Feb 24, 2025 at 11:05:19AM +0000, Havalige, Thippeswamy wrote:

[...]

> > +#define AMD_MDB_TLP_IR_STATUS_MISC		0x4C0
> > +#define AMD_MDB_TLP_IR_MASK_MISC		0x4C4
> > +#define AMD_MDB_TLP_IR_ENABLE_MISC		0x4C8
> > +#define AMD_MDB_TLP_IR_DISABLE_MISC		0x4CC
> > +
> > +#define AMD_MDB_TLP_PCIE_INTX_MASK	GENMASK(23, 16)
> > +
> > +#define AMD_MDB_PCIE_INTR_INTX_ASSERT(x)	BIT((x) * 2)
> 
> How does these values correspond to the AMD_MDB_TLP_PCIE_INTX_MASK? These values could be: 0, 2, 4, and 6 corresponding to: 0b01010101? Looks wierd.

I don't know if it is your mailer issue or your workflow. Looks like my review
comments are copy pasted here. So it becomes harder to distinguish between my
previous comments and your replies.

Please fix it.

> Thank you for reviewing, Yes in register status/Enable/Disable register bits are laid in this way.
> 
> > +
> > +/* Interrupt registers definitions */
> > +#define AMD_MDB_PCIE_INTR_CMPL_TIMEOUT		15
> > +#define AMD_MDB_PCIE_INTR_INTX			16
> > +#define AMD_MDB_PCIE_INTR_PM_PME_RCVD		24
> 
> 
> > +static inline u32 pcie_read(struct amd_mdb_pcie *pcie, u32 reg) {
> > +	return readl_relaxed(pcie->slcr + reg); }
> 
> I think I already commented on these helpers. Please get rid of them. I don't see any value in this new driver. Moreover, 'inline' keywords are not required.
> Thanks for the review. While I agree to remove the 'inline', I would like pcie_read/pcie_write APIs. Could you please clarify the reason for explicitly removing pcie_read/pcie_write here?
> If I remove the pcie_read/pcie_write, it will require changes in multiple places throughout the code."

What value does the helper really add? It just wraps the {readl/writel}_relaxed
calls. Plus it hides which kind of I/O accessors are used. So I don't see a
value in keeping them.

> 
> > +
> > +static inline void pcie_write(struct amd_mdb_pcie *pcie,
> > +			      u32 val, u32 reg)
> > +{
> > +	writel_relaxed(val, pcie->slcr + reg); }
> > +
> > +static const struct irq_domain_ops amd_intx_domain_ops = {
> > +	.map = amd_mdb_pcie_intx_map,
> > +};
> > +
> > +static irqreturn_t dw_pcie_rp_intx_flow(int irq, void *args)
> 
> What does the _flow suffix mean?
> Thanks for reviewing, The _flow suffix in the function name dw_pcie_rp_intx_flow indicates that the function handles the flow or processing related to interrupt handling for the PCIe root port's INTx interrupts through generic_handle_domain_irq.
> 

(Please wrap your replies to 80 column width)

So it is the regular interrupt handler. I don't see a necessity to add the _flow
suffix.

> > +{
> > +	struct amd_mdb_pcie *pcie = args;
> > +	unsigned long val;
> > +	int i, int_status;
> > +
> > +	val = pcie_read(pcie, AMD_MDB_TLP_IR_STATUS_MISC);
> 
> You don't need port->lock here?
> Thank you for reviewing. In this case, I'm simply reading the status of the INTX register bits without modifying any registers.
> Since no shared resources are being updated or accessed concurrently, there’s no need for a lock here.
> 

What if the handler and mask/unmask functions are executed in different CPUs?
Sharing the same register without lock feels nervous. Locking principle is that
you would lock both read as well as write.

> 
> > +	int_status = FIELD_GET(AMD_MDB_TLP_PCIE_INTX_MASK, val);
> 
> You don't need to ack/clear the IRQ?
> - Thank you for reviewing, Thank you for reviewing. In this case, I am using IRQ domains, and the generic_handle_domain_irq function will invoke the necessary irq_mask and irq_unmask operations internally, which will take care of clearing the IRQ.
> 

Ok.

> > +
> > +	for (i = 0; i < PCI_NUM_INTX; i++) {
> > +		if (int_status & AMD_MDB_PCIE_INTR_INTX_ASSERT(i))
> > +			generic_handle_domain_irq(pcie->intx_domain, i);
> > +	}
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static void amd_mdb_event_irq_mask(struct irq_data *d) {
> > +	struct amd_mdb_pcie *pcie = irq_data_get_irq_chip_data(d);
> > +	struct dw_pcie *pci = &pcie->pci;
> > +	struct dw_pcie_rp *port = &pci->pp;
> > +	u32 val;
> > +
> > +	raw_spin_lock(&port->lock);
> > +	val = pcie_read(pcie, AMD_MDB_TLP_IR_STATUS_MISC);
> 
> This register is accessed in the IRQ handler also. So don't you need raw_spin_lock_irq{save/restore}? 
> - Thank you for reviewing, In handler I am just reading the status & calling this irq_mask/irq_unmask API's I don't need to have save/restore spin_lock_irq's here.
> 

Same as above.

> > +	val &= ~BIT(d->hwirq);
> > +	pcie_write(pcie, val, AMD_MDB_TLP_IR_STATUS_MISC);
> > +	raw_spin_unlock(&port->lock);
> > +}
> > +

[...]

> > +	for (i = 0; i < ARRAY_SIZE(intr_cause); i++) {
> > +		if (!intr_cause[i].str)
> > +			continue;
> > +		irq = irq_create_mapping(pcie->mdb_domain, i);
> > +		if (!irq) {
> > +			dev_err(dev, "Failed to map mdb domain interrupt\n");
> > +			return -ENOMEM;
> > +		}
> > +		err = devm_request_irq(dev, irq, amd_mdb_pcie_intr_handler,
> > +				       IRQF_SHARED | IRQF_NO_THREAD,
> > +				       intr_cause[i].sym, pcie);
> 
> Aren't these IRQs just part of a single IRQ? I'm wondering why do you need to represent them individually instead of having a single IRQ handler.
> 
> Btw, you are not disposing these IRQs anywhere. Especially in error paths.
> Thank you for reviewing. This code is based on the work authored by Marc Zyngier and Bjorn during the development of our CPM drivers, and it follows the same design principles. The individual IRQ handling is consistent with that approach.
> For reference, you can review the driver here: pcie-xilinx-cpm.c. All of your comments have been incorporated into this driver as requested.
> 

Ok for the separate IRQ question. But you still need to dispose the IRQs in
error path.

> > +		if (err) {
> > +			dev_err(dev, "Failed to request IRQ %d\n", irq);
> > +			return err;
> > +		}
> > +	}
> > +
> > +	pcie->intx_irq = irq_create_mapping(pcie->mdb_domain,
> > +					    AMD_MDB_PCIE_INTR_INTX);
> > +	if (!pcie->intx_irq) {
> > +		dev_err(dev, "Failed to map INTx interrupt\n");
> > +		return -ENXIO;
> > +	}
> > +
> > +	err = devm_request_irq(dev, pcie->intx_irq,
> > +			       dw_pcie_rp_intx_flow,
> > +			       IRQF_SHARED | IRQF_NO_THREAD, NULL, pcie);
> > +	if (err) {
> > +		dev_err(dev, "Failed to request INTx IRQ %d\n", irq);
> > +		return err;
> > +	}
> > +
> > +	/* Plug the main event handler */
> > +	err = devm_request_irq(dev, pp->irq, amd_mdb_pcie_event_flow,
> > +			       IRQF_SHARED | IRQF_NO_THREAD, "amd_mdb pcie_irq",
> 
> Why is this a SHARED IRQ?
> Thank you for reviewing. The IRQ is shared because all the events, errors, and INTx interrupts are routed through the same IRQ line, so multiple handlers need to be able to respond to the same interrupt.

IIUC, you have a single handler for this IRQ and that handler is invoking other
handlers (for events, INTx etc...). So I don't see how this IRQ is shared.

Shared IRQ is only required if multiple handlers are sharing the same IRQ line.
But that is not the case here afaics.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

