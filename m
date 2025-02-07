Return-Path: <linux-pci+bounces-20923-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8D2A2CA84
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 18:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59FF63A718B
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 17:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4F8199EAD;
	Fri,  7 Feb 2025 17:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="etM+490N"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF67191F62
	for <linux-pci@vger.kernel.org>; Fri,  7 Feb 2025 17:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738950591; cv=none; b=TOe+IZGZeOaY87ewYu4BPeRBuDnN1si9BUadeE0kikgw9vfqk5FIpLqB0ZKlCtjAu0PtLWrO8uIuT6/X65Djrm9ANKxXw8TLrJffvK4PwFV12EckEyO00p0V/He1i//b8u5his/trpTYha5hMHJeaAu2TwVuynj66AaepWs4r8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738950591; c=relaxed/simple;
	bh=OjHf0/La6zmx4FAbdAnxgighWHZDuLFxwPxDymnae2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FoFqmvmMhFi/Ollp1QU4FPs2oAzZhdc2VAo+fMFYkac3AYkRR8CqA5nJKCDiygfDyr5sQXzbtxijbiKM7R3FanNAxIp3QNZqjNALkfYF12Ihs+mU6NKeyXUIQ0uVZ+9UQseiDLGTLxrJyTyzjQQSc2QBvDfNykL3CNpvYgt6PCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=etM+490N; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21c2f1b610dso58755685ad.0
        for <linux-pci@vger.kernel.org>; Fri, 07 Feb 2025 09:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738950589; x=1739555389; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7ueL8uhdRjf52HSBhlGadO+O+QftLnA6FgREnqVSmz0=;
        b=etM+490NN9p12nFXzw29ymoF8JE8Y9ga99SBrjuc+HxWrBjTdXgU/BsjShDJp84shc
         BIMWmjJXva7ruuH478MI7cTkj6bv3E7h0n5e2kvbfwcTonEAn2QvwWOjNsMvoTVTvxgB
         w+HHHBySYTz61U2sRPnhtaSp25AJXNtQkpZ2Yvgr0h8IJejP0yXLpXYiVYCS+plIlHKi
         PUZcVGI819TxTEpjdwJld0ciq/8wyhuiCIP8GpI2aYEklghJSm46QeQEOijYAxWQFOKe
         w6Ykmbvfr5MDQMHDjNVtkGrNPSiQKyeldLSojG67HoSJN8uvJfMY6t+GcPxfJ2HsSsJ2
         OAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738950589; x=1739555389;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ueL8uhdRjf52HSBhlGadO+O+QftLnA6FgREnqVSmz0=;
        b=lltrn+fNkzs+UHK3CXz/FqdL/z5PTnPXmdLEul4bXeECwwfmqUi+/+k2CCfBxtPPFz
         8T762H1o4aKQmfVuZKMOrfzV93h75zBcjb669gfJgMdhSD89BJ+N/hYWvwzUeaST37hO
         IgM49psxGU7k5mzpD9pa/yZauOhzf2e4FtQFs9G+cFyqCWyrfHkiDfvXnTJ7/3kMi7KS
         t9NV2+cI5mHPX2xL0to0mNpdXMBXNxNA0qDN/LKso4jdjRD1uERNk05Aquus3pjd35qW
         /NL4pUIGgjCTUOggmcuwTETP9VILGGH7nUDah5YgJDW7IAJv2a8CcB9IY0nuIGB+C61Y
         qtBA==
X-Forwarded-Encrypted: i=1; AJvYcCVObqrbOzt5OLQ8dGdxEBsMifUbXGh3t9DWpDUIqwD2Cbtld7M416lN6uZbIfeSPMtO+5qL5me0jeA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya+fuzokBkBbjzzMYTzGFgsN5NJePc+Ax/GMiVLKfk/lSodSH8
	+JLWls2KNH+D5ll/JccHrl4pI01/chpkA6vOF/lkaNtoPe0OJnDwP3nFYtfw8Q==
X-Gm-Gg: ASbGnctSHTh+5pjoyEBh3HvaSztYzY9aG7+6LckL1SkKGqBZmveUCtRTd/8HSTmr4SQ
	UAY3yae1aSKZaF4z0zscK8/FE+wKhz1zHaMkaiexMQtP3YOGHNOrE6HCGrqAN3KXMO6ysxxNKM+
	tBF1KUCUHxnWpSXl78U3njXFSUfHiRVlAiiX7LeoV5Par4qjJTicSP4M28Rhu9qTumRg4rP/uVi
	PrSkM5ADwXmcChTmpsQb88lXMa6yyIGRITyAxnwOyLlbgnujEXsoKScTY+bbZjFIdq+bY5v2fyB
	hG372ux+pHEe2v64pChXcrxnmA==
X-Google-Smtp-Source: AGHT+IE6OgQOwi69kOmyTP+cvlnuvv/NziCa4NqzRul258V7kLWTeAlJ+6B/WB+eU+A9dOCwtErZPw==
X-Received: by 2002:a17:902:e74a:b0:216:4064:53ad with SMTP id d9443c01a7336-21f4e7ed222mr70009195ad.48.1738950587991;
        Fri, 07 Feb 2025 09:49:47 -0800 (PST)
Received: from thinkpad ([120.60.76.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f36541c36sm33757455ad.63.2025.02.07.09.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 09:49:47 -0800 (PST)
Date: Fri, 7 Feb 2025 23:19:39 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Chen Wang <unicorn_wang@outlook.com>, Chen Wang <unicornxw@gmail.com>,
	kw@linux.com, u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu,
	arnd@arndb.de, bhelgaas@google.com, conor+dt@kernel.org,
	guoren@kernel.org, inochiama@outlook.com, krzk+dt@kernel.org,
	lee@kernel.org, lpieralisi@kernel.org, palmer@dabbelt.com,
	paul.walmsley@sifive.com, pbrobinson@gmail.com, robh@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com, xiaoguang.xing@sophgo.com,
	fengchun.li@sophgo.com, helgaas@kernel.org
Subject: Re: [PATCH v3 2/5] PCI: sg2042: Add Sophgo SG2042 PCIe driver
Message-ID: <20250207174939.w2e2bdvvcmqojlse@thinkpad>
References: <cover.1736923025.git.unicorn_wang@outlook.com>
 <ddedd8f76f83fea2c6d3887132d2fe6f2a6a02c1.1736923025.git.unicorn_wang@outlook.com>
 <20250119122353.v3tzitthmu5tu3dg@thinkpad>
 <BM1PR01MB254540560C1281CE9898A5A0FEE12@BM1PR01MB2545.INDPRD01.PROD.OUTLOOK.COM>
 <20250122173451.5c7pdchnyee7iy6t@thinkpad>
 <86msfhviek.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86msfhviek.wl-maz@kernel.org>

On Thu, Jan 23, 2025 at 12:12:03PM +0000, Marc Zyngier wrote:
> On Wed, 22 Jan 2025 17:34:51 +0000,
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> > 
> > + Marc (for the IRQCHIP implementation review)
> > 
> > On Wed, Jan 22, 2025 at 09:28:12PM +0800, Chen Wang wrote:
> > > 
> > > > > +static int sg2042_pcie_setup_msi(struct sg2042_pcie *pcie,
> > > > > +				 struct device_node *msi_node)
> > > > > +{
> > > > > +	struct device *dev = pcie->cdns_pcie->dev;
> > > > > +	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
> > > > > +	struct irq_domain *parent_domain;
> > > > > +	int ret = 0;
> > > > > +
> > > > > +	if (!of_property_read_bool(msi_node, "msi-controller"))
> > > > > +		return -ENODEV;
> > > > > +
> > > > > +	ret = of_irq_get_byname(msi_node, "msi");
> > > > > +	if (ret <= 0) {
> > > > > +		dev_err(dev, "%pOF: failed to get MSI irq\n", msi_node);
> > > > > +		return ret;
> > > > > +	}
> > > > > +	pcie->msi_irq = ret;
> > > > > +
> > > > > +	irq_set_chained_handler_and_data(pcie->msi_irq,
> > > > > +					 sg2042_pcie_msi_chained_isr, pcie);
> > > > > +
> > > > > +	parent_domain = irq_domain_create_linear(fwnode, MSI_DEF_NUM_VECTORS,
> > > > > +						 &sg2042_pcie_msi_domain_ops, pcie);
> > > > > +	if (!parent_domain) {
> > > > > +		dev_err(dev, "%pfw: Failed to create IRQ domain\n", fwnode);
> > > > > +		return -ENOMEM;
> > > > > +	}
> > > > > +	irq_domain_update_bus_token(parent_domain, DOMAIN_BUS_NEXUS);
> > > > > +
> > > > The MSI controller is wired to PLIC isn't it? If so, why can't you use
> > > > hierarchial MSI domain implementation as like other controller drivers?
> > > 
> > > The method used here is somewhat similar to dw_pcie_allocate_domains() in
> > > drivers/pci/controller/dwc/pcie-designware-host.c. This MSI controller is
> > > about Method A, the PCIe controller implements an MSI interrupt controller
> > > inside, and connect to PLIC upward through only ONE interrupt line. Because
> > > MSI to PLIC is multiple to one, I use linear mode here and use chained ISR
> > > to handle the interrupts.
> > > 
> > 
> > Hmm, ok. I'm not an IRQCHIP expert, but I'll defer to Marc to review the IRQCHIP
> > implementation part.
> 
> I don't offer this service anymore, I'm afraid.
> 
> As for the "I create my own non-hierarchical IRQ domain", this is
> something that happens for all completely mis-designed interrupt
> controllers, MSI or not, that multiplex interrupts.
> 
> These implementations are stuck in the previous century, and seeing
> this on modern designs, for a "server SoC", is really pathetic.
> 
> maybe you now understand why I don't offer this sort of reviewing
> service anymore.
> 

Ok, I can understand your pain as a maintainer. I'll try my best to review these
implementations as I have no other choice :)

- Mani

-- 
மணிவண்ணன் சதாசிவம்

