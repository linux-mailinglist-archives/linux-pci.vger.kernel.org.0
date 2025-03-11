Return-Path: <linux-pci+bounces-23442-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA03AA5CA1B
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 17:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C87137ADCE5
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 15:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F1B25EFA5;
	Tue, 11 Mar 2025 15:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMB6ULSE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED30F260A31;
	Tue, 11 Mar 2025 15:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741708780; cv=none; b=VZBVLWgjKv1Gi7/KZX+KK4saaQ7gwD8R4mOcM/I8hP3aloctynWSaLhKiiZnM9sbLYw6JA19U+ZNSufCCl2wNVi2zlDdYwgniva9M/PX6/4CH25+L+eEg3Wk0qudEV9WDf2g2deZOWfqIBGccdwz7JyLPzLuejG3avGaxXsjk7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741708780; c=relaxed/simple;
	bh=o1zfNfRzSyzMnHbSnLiwhdNGDDh4V624T1bIqecRWjY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MmOXHAL02+Xb2Hmp74QI2czyGgBl8gbwCpDEO4uvP2GvZNfjtLBOIQtL+prr/Z+EG7GGVyWZBroaTl3AqKSYVuMK14KCC9pI8B6U2g0oe+tXtT4uIgiyy+lC78NAqenZMd20k8T0y3a45VRRztnCzEobuCjgNYOYJvYhXZHksMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMB6ULSE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971A1C4CEE9;
	Tue, 11 Mar 2025 15:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741708779;
	bh=o1zfNfRzSyzMnHbSnLiwhdNGDDh4V624T1bIqecRWjY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YMB6ULSEr1kIy7ktKaoPIaEYVZ0DBfhQj61g+uFWsKtinp6iv9Yi2w6ZR/0iB9Jwv
	 Iwf+R9S9SMrz6n7rO9EtVmaRXkMg4f3GkyAu1t606qFLi8wD/O8cza/7fMWvVMSL/X
	 WxBcmYbtSeRWWCqeLA6j+J9/TbYVsdsOZBYpBsQYt2XyFdkbAxujPLEqshAy5pUs1c
	 h3eVYo5UTncOCi8EhE8a110PjTpMQWYo+E6Sjo0Lgy+4z9JnG8xLaPzRRfNjka3zZU
	 ku2PvZpuNGJTO5A6AIED9OrhVr5HxvAPCPo8DXr/66sSwEFOiM1t/ocgw30Mu8RjTW
	 QG7+7oxH18WLg==
Date: Tue, 11 Mar 2025 10:59:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com, bharat.kumar.gogada@amd.com
Subject: Re: [PATCH v5 3/3] PCI: xilinx-cpm: Add support for Versal Net
 CPM5NC Root Port controller
Message-ID: <20250311155938.GA629931@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310170717.GA556500@bhelgaas>

On Mon, Mar 10, 2025 at 12:07:17PM -0500, Bjorn Helgaas wrote:
> On Mon, Feb 24, 2025 at 09:20:24PM +0530, Thippeswamy Havalige wrote:
> > The Versal Net ACAP (Adaptive Compute Acceleration Platform) devices
> > incorporate the Coherency and PCIe Gen5 Module, specifically the
> > Next-Generation Compact Module (CPM5NC).
> > 
> > The integrated CPM5NC block, along with the built-in bridge, can function
> > as a PCIe Root Port & supports the PCIe Gen5 protocol with data transfer
> > rates of up to 32 GT/s, capable of supporting up to a x16 lane-width
> > configuration.
> > 
> > Bridge errors are managed using a specific interrupt line designed for
> > CPM5N. INTx interrupt support is not available.
> > 
> > Currently in this commit platform specific Bridge errors support is not
> > added.
> 
> > @@ -478,6 +479,9 @@ static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
> >  {
> >  	const struct xilinx_cpm_variant *variant = port->variant;
> >  
> > +	if (variant->version != CPM5NC_HOST)
> > +		return;
> 
> You're adding support for CPM5NC_HOST, but this changes the behavior
> for all the NON-CPM5NC_HOST devices, which looks like a typo.
> 
> Should it be "variant->version == CPM5NC_HOST" instead?

Thanks for your patch that fixes this part.

> Also, this makes it look like CPM5NC_HOST doesn't support any
> interrupts at all.  No INTx, no MSI, no MSI-X.  Is that true?  If so,
> what good is a host controller where interrupts don't work?

Does this controller support interrupts?

