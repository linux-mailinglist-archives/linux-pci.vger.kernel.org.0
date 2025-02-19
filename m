Return-Path: <linux-pci+bounces-21823-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BEBA3C6D7
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 18:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D724189C480
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 17:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB89E2144D3;
	Wed, 19 Feb 2025 17:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a44ocDxA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7E11ADC86;
	Wed, 19 Feb 2025 17:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739987867; cv=none; b=VaFV5HPEinBQkS4xAeEjsjVpDar2OmzcGeXnccsgOBr56uQvL/Dd+2r4EyeQi2C8QQi177UJXdKckOWOCRGIWRcGK+EyiFwdjPdmMA+t8R6EdBoa5GU5TbTqImOyZ3Nu3i3xvrX1a5kj2H0hVhMZ7njvJG69+97clGKX6g37Jog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739987867; c=relaxed/simple;
	bh=bNlAhfaAmhX6VaFyFfgt8A57xz33sy1WuFva1LsY4j8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJaLkLSJtaoCKvkavLYJKqUIbyzSa+jqF00deYDyb+a4yYHD6cD6c4xe+3MCw5r/s2PaSlkI/mh2dptWDVEUQ6Rv04uDvp7mKP9EkpQfuP7JMAAclD7OF1tkks9snunbMWfTJriFitf0bzqxbjIvN7KuEY50HsHZ/YdgssHEqyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a44ocDxA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C23C4CED1;
	Wed, 19 Feb 2025 17:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739987867;
	bh=bNlAhfaAmhX6VaFyFfgt8A57xz33sy1WuFva1LsY4j8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a44ocDxACxnXGyjoxzQcz8G/7t/hSKnD6q+yY4uNYd9R/XkNjCO5VpBkUh8uzL8q8
	 7K4C3RNO1rGNm1B1VodEgPZKREmqoW0j1TOdVtogiePmEg5wBMM2gvXjHZp/sllm1Y
	 c/WeL4usFP/oxisjnHLEMszr6mMqPm/CJ7B1Toljm18PLaNTW8TiI0VbLjMbZsEz7g
	 fNp/Yjekg+e77sJZrR+JYlIAaOYQEprh7r+dL6KR8HyMYjgSWIxYNAxEy2F2BVy9A4
	 QbyU4bAVT+KCKw6iWW/0qZOCmhf4M95s/FK1n7NaxJBCgMowosJMuXYlU9vApK5/YA
	 txJlAQEyRLPMA==
Date: Wed, 19 Feb 2025 23:27:35 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Chen Wang <unicorn_wang@outlook.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	maz@kernel.org, Chen Wang <unicornxw@gmail.com>, kw@linux.com,
	u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu, arnd@arndb.de,
	bhelgaas@google.com, conor+dt@kernel.org, guoren@kernel.org,
	inochiama@outlook.com, krzk+dt@kernel.org, lee@kernel.org,
	lpieralisi@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
	pbrobinson@gmail.com, robh@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-riscv@lists.infradead.org, chao.wei@sophgo.com,
	xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com,
	helgaas@kernel.org
Subject: Re: [PATCH v3 2/5] PCI: sg2042: Add Sophgo SG2042 PCIe driver
Message-ID: <20250219175735.ruwt7s5rbwswvsi6@thinkpad>
References: <cover.1736923025.git.unicorn_wang@outlook.com>
 <ddedd8f76f83fea2c6d3887132d2fe6f2a6a02c1.1736923025.git.unicorn_wang@outlook.com>
 <20250119122353.v3tzitthmu5tu3dg@thinkpad>
 <BM1PR01MB254540560C1281CE9898A5A0FEE12@BM1PR01MB2545.INDPRD01.PROD.OUTLOOK.COM>
 <20250122173451.5c7pdchnyee7iy6t@thinkpad>
 <MA0PR01MB56715414B26AA601CFFB54C8FEFB2@MA0PR01MB5671.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MA0PR01MB56715414B26AA601CFFB54C8FEFB2@MA0PR01MB5671.INDPRD01.PROD.OUTLOOK.COM>

On Mon, Feb 17, 2025 at 04:22:08PM +0800, Chen Wang wrote:
> 
> On 2025/1/23 1:34, Manivannan Sadhasivam wrote:
> 
> [......]
> > > > > +/*
> > > > > + * SG2042 PCIe controller supports two ways to report MSI:
> > > > > + *
> > > > > + * - Method A, the PCIe controller implements an MSI interrupt controller
> > > > > + *   inside, and connect to PLIC upward through one interrupt line.
> > > > > + *   Provides memory-mapped MSI address, and by programming the upper 32
> > > > > + *   bits of the address to zero, it can be compatible with old PCIe devices
> > > > > + *   that only support 32-bit MSI address.
> > > > > + *
> > > > > + * - Method B, the PCIe controller connects to PLIC upward through an
> > > > > + *   independent MSI controller "sophgo,sg2042-msi" on the SOC. The MSI
> > > > > + *   controller provides multiple(up to 32) interrupt sources to PLIC.
> > > > > + *   Compared with the first method, the advantage is that the interrupt
> > > > > + *   source is expanded, but because for SG2042, the MSI address provided by
> > > > > + *   the MSI controller is fixed and only supports 64-bit address(> 2^32),
> > > > > + *   it is not compatible with old PCIe devices that only support 32-bit MSI
> > > > > + *   address.
> > > > > + *
> > > > > + * Method A & B can be configured in DTS, default is Method B.
> > > > How to configure them? I can only see "sophgo,sg2042-msi" in the binding.
> > > 
> > > The value of the msi-parent attribute is used in dts to distinguish them,
> > > for example:
> > > 
> > > ```dts
> > > 
> > > msi: msi-controller@7030010300 {
> > >      ......
> > > };
> > > 
> > > pcie_rc0: pcie@7060000000 {
> > >      msi-parent = <&msi>;
> > > };
> > > 
> > > pcie_rc1: pcie@7062000000 {
> > >      ......
> > >      msi-parent = <&msi_pcie>;
> > >      msi_pcie: interrupt-controller {
> > >          ......
> > >      };
> > > };
> > > 
> > > ```
> > > 
> > > Which means:
> > > 
> > > pcie_rc0 uses Method B
> > > 
> > > pcie_rc1 uses Method A.
> > > 
> > Ok. you mentioned 'default method' which is not accurate since the choice
> > obviously depends on DT. Maybe you should say, 'commonly used method'? But both
> > the binding and dts patches make use of in-built MSI controller only (method A).
> 
> "commonly used method" looks ok to me.
> 
> Binding example only shows the case for Method A, due to I think the writing
> of case for Method A  covers the writing of case for Method B.
> 
> DTS patches use both Method A and B. You can see patch 4 of this patchset,
> pcie_rc1 uses Method A, pcie_rc0 & pcie_rc2 use Method B.
> 
> > In general, for MSI implementations inside the PCIe IP, we don't usually add a
> > dedicated devicetree node since the IP is the same. But in your reply to the my
> > question on the bindings patch, you said it is a separate IP. I'm confused now.
> 
> I learned the writing of DTS from "brcm,iproc-pcie", see
> arch/arm/boot/dts/broadcom/bcm-cygnus.dtsi for example. Wouldn't it be
> clearer to embed an msi controller in topo?
> 
> And regarding what you said, "we don't usually add a dedicated devicetree
> node", do you have any example I can refer to?
> 

You can refer all DWC glue drivers under drivers/pci/controller/dwc/ and their
corresponding DT bindings.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

