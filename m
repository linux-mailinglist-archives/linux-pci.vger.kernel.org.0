Return-Path: <linux-pci+bounces-22962-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01967A4FD93
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 12:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32B3616C9C7
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 11:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C0C233702;
	Wed,  5 Mar 2025 11:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pGoccU1V"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91DE21421B;
	Wed,  5 Mar 2025 11:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741173995; cv=none; b=bWFNv37LHnk2ASSBJvJmXtjLir/bzBSSJAZyMSejQZKq3dz0j7TcDng2snx2h4tMP9nFGgAeYDCQKxtTzLyDyWL1QRo9IPdzL/zSvnrR42veNIiwgxaabmKgCJxA1Z5fr+tHEhJNCYXSsvJCO2wOj6zbSpeF9yQ52zS1z0FgMDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741173995; c=relaxed/simple;
	bh=N2D7fb7XnQKLDnYzb9yCDaUeFSMSXdmS3deL4PhIENI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TN5IlecRtH/2EbhCD5HfuQABPXVNUGwQZfyjYdexnQTHg+RkZwwwUwpDCToyU7Ap/t9GvHztv7RXdZ4b/8oe0A+fryrt2vUFhbfde8fwOiizKAVxzj9ENAYVqkXSGdje/L5bgUIgiZZehzP9fpLme5Ok74xlrCUet9eAjLxGcaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pGoccU1V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E288C4CEE2;
	Wed,  5 Mar 2025 11:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741173994;
	bh=N2D7fb7XnQKLDnYzb9yCDaUeFSMSXdmS3deL4PhIENI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pGoccU1VQiZFN3hoWaH7wqy6OBANcCJ9AVT5ejpgyfRG45UYx0sLM7aQQuaLKgNFD
	 g2T6TRUequOiCfz1Jf7M4yPuRBhMOQ1xFCoKk6XvsxSp86Cc7Y1eavfSU9IUiVJrrf
	 r9/QsvISEwwSyFsPBPOT/hKLIsVFiyEC8kp21o32WI2VPZddh2TNmq31chQGdmxmJj
	 /J5hal4bhZWYm2s+k7PY15togb4AfnJCDXil0yqfuP5EKU8RaA/FfgGvpSZxZZPr0z
	 ZdGgAawHnDWxgzrpcQSTUuiOhLd73/djk0/M+Mivfq3/5cZG+TkcSMehTKxM5gMsq6
	 lXsC9rCoAFSiA==
Date: Wed, 5 Mar 2025 12:26:28 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>,
	Lars Persson <lars.persson@axis.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@axis.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH RFC NOT TESTED 0/2] PCI: artpec6: Try to clean up
 artpec6_pcie_cpu_addr_fixup()
Message-ID: <Z8g05CdN4BmlfxHR@ryzen>
References: <20250304-axis-v1-0-ed475ab3a3ed@nxp.com>
 <Z8gxdWaU1N71pyj-@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8gxdWaU1N71pyj-@ryzen>

On Wed, Mar 05, 2025 at 12:18:56PM +0100, Niklas Cassel wrote:
> Hello Frank, all,
> 
> On Tue, Mar 04, 2025 at 12:49:34PM -0500, Frank Li wrote:
> > This patches basic on
> > https://lore.kernel.org/imx/20250128-pci_fixup_addr-v9-0-3c4bb506f665@nxp.com/
> > 
> > I have not hardware to test and there are not axis,artpec7-pcie in kernel
> > tree.
> 
> If you do a simple:
> $ git grep artpec7
> 
> You will see that there are just two drivers that support this SoC:
> drivers/pci/controller/dwc/pcie-artpec6.c
> drivers/crypto/axis/artpec6_crypto.c
> and their matching DT bindings:
> Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
> Documentation/devicetree/bindings/crypto/artpec6-crypto.txt
> 
> I think that at some point in the there was an intent to upstream support
> for the ARTPEC-7 SoC, but now many years later, that hasn't happened,
> as there is not even a artpec7 dtsi.
> 
> I think the nicest thing to the community is to drop artpec7 support from
> these two drivers, and deprecate the artpec7 compatibles in the DT bindings,
> as it is obviously making your life harder when trying to do improvements.
> 
> 
> > 
> > Look for driver owner, who help test this and start move forward to remove
> > cpu_addr_fixup() work.
> 
> While I'm the original author of this PCIe driver, I do no longer have
> access to the hardware and documentation, so I cannot test.
> 
> For anyone interested in the cleanup Frank is doing, see:
> https://lore.kernel.org/linux-pci/Z8d96Qbggv117LlO@lizhi-Precision-Tower-5810/T/#m0ff14edaf871293ba16acd85e7942adacb603c6c
> 
> Looking at your cover-letter for the series above,
> creating a simple-bus with:
> ranges = <0x0 0xc0000000 0x20000000>
> 
> and handling that in PCIe DWC common code does look nicer compared to
> having a .cpu_addr_fixup() callback in each PCIe DWC glue driver.
> 
> Hopefully someone with access to the hardware can test your series +
> this RFC.

Oh, and you should probably send a similar RFC for:
drivers/pci/controller/dwc/pci-dra7xx.c
drivers/pci/controller/dwc/pcie-intel-gw.c
drivers/pci/controller/dwc/pcie-visconti.c

which all make use of the .cpu_addr_fixup() callback.
(IIRC dra7xx was the first driver that introduced this callback.)


Kind regards,
Niklas

