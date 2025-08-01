Return-Path: <linux-pci+bounces-33312-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A55B18728
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 20:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA8FF188EF40
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 18:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C908F1C84BB;
	Fri,  1 Aug 2025 18:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iiSLwHpR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBC0188CC9;
	Fri,  1 Aug 2025 18:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754071742; cv=none; b=sgGgOYqANm6b0Ze/FXR3aZaldzBaYEiTmj/2fElm3JpEVrXOo3kUYSsVE34/ujueNf/PBM+/4J807M26x9j1wtj7oPLjk+v9d4SihNphb7QMO13SrjI50BvEj1yMuxojIQqgKKNDlrn+hnm/vC6dFxboFvc3uTZldAz5ViNN8IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754071742; c=relaxed/simple;
	bh=P7L2cubhAgXEB6EZdVMzRyHwCAk6GbODDnnzBqOIslc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jfs/6zLlu+jmjoTPo+Oz8Km9RS8vAPf6qvilwjaZ84ApnouxP5a42eQ/nS3WknzEu3bSIbm5AfFxrowgctznZJWWCOcESAqTnGecmfycvQHlUeV910ceDTJqzgRgjdFsk1Wdr5sxNgcglbbKBWRRpCac2sh6ge9xiUBb6p+wIwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iiSLwHpR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5694C4CEE7;
	Fri,  1 Aug 2025 18:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754071742;
	bh=P7L2cubhAgXEB6EZdVMzRyHwCAk6GbODDnnzBqOIslc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iiSLwHpR4qPaT8zHyzBFYi1+V2nfjEasrfYAJMGFvJttrKti9VG5YGoY0tUXgN/1a
	 64F4vdbR4K5q7R6kBr8QrGtFLoEBUtvkYBQGr+elBhUc6K65aur8CDtHK+ffH3Dugi
	 TXpnN6n+jkZcYcFNt0wO+B3XnRLtD+soDyDY5sitq9klYpPq/BJQduDixJqSXBZLCH
	 FEQ4TZ0amgmU6WBI344SgjOaaQbZXAUXkew2F932ndSI0B/0N8EfLMzPEervm15gER
	 d3pjxhyVdigTuYFPJIG3TC8tuyJoeyeCX+igv+Mj2GCXEuuiFb0cRri8IW0Q9rRj9V
	 SvaBxK2DrSj7Q==
Date: Fri, 1 Aug 2025 12:08:58 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: Gerd Bayer <gbayer@linux.ibm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Hans Zhang <hans.zhang@cixtech.com>,
	Arnd Bergmann <arnd@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	bhelgaas@google.com, Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	jingoohan1@gmail.com,
	Krzysztof =?iso-8859-1?Q?Wilczy=B4nski?= <kwilczynski@kernel.org>,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-next <linux-next@vger.kernel.org>, linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>, geert@linux-m68k.org
Subject: Re: [PATCH] PCI: Fix endianness issues in pci_bus_read_config()
Message-ID: <aI0CupiFvyOvgNQY@kbusch-mbp>
References: <20250731183944.GA3424583@bhelgaas>
 <6e34b4af-dff9-4360-b3da-c95ca7c740c9@app.fastmail.com>
 <vf65usnffqzlkgijm72nuaslxnflwrugc25vw6q6blbn2s2d2s@b35vjkowd6yc>
 <9a155e45-f723-4eec-81d3-2547bfe9a4e9@cixtech.com>
 <ofsbfhor5ah3yzvkc5g5kb4fpjlzoqkkzukctmr3f6ur4vl2e7@7zvudt63ucbk>
 <c8ffdd21-9000-40c2-9f4d-4d6318e730b5@cixtech.com>
 <cu7qdbwmnixqjce4aetr5ldwe3sqoixgq4fuzmzajzphjdywqq@yw6ojbgeqktm>
 <06f16b1a55eede3dc3e0bf31ff14eca89ab6f009.camel@linux.ibm.com>
 <659b8389-16a7-423b-a231-5489c7cc0da9@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <659b8389-16a7-423b-a231-5489c7cc0da9@163.com>

On Sat, Aug 02, 2025 at 12:54:27AM +0800, Hans Zhang wrote:
> As I mentioned in my reply to Mani's email, the data ultimately read here is
> also a forced type conversion.
> 
> #define PCI_OP_READ(size, type, len) \
> int noinline pci_bus_read_config_##size \
> 	(struct pci_bus *bus, unsigned int devfn, int pos, type *value)	\
> {									\
> 	unsigned long flags;						\
> 	u32 data = 0;							\
> 	int res;							\
> 									\
> 	if (PCI_##size##_BAD)						\
> 		return PCIBIOS_BAD_REGISTER_NUMBER;			\
> 									\
> 	pci_lock_config(flags);						\
> 	res = bus->ops->read(bus, devfn, pos, len, &data);		\
> 	if (res)							\
> 		PCI_SET_ERROR_RESPONSE(value);				\
> 	else								\
> 		*value = (type)data;					\
> 	pci_unlock_config(flags);					\
> 									\
> 	return res;							\
> }
> 
> And this function. Could it be that I misunderstood something?

The above macro retains the caller's type for "value". If the caller
passes a "u8 *", the value is deferenced as a u8.

The function below promotes everything to a u32 pointer and deferences
it as such regardless of what type the user passed in.
 
> int pci_generic_config_read(struct pci_bus *bus, unsigned int devfn,
> 			    int where, int size, u32 *val)
> {
> 	void __iomem *addr;
> 
> 	addr = bus->ops->map_bus(bus, devfn, where);
> 	if (!addr)
> 		return PCIBIOS_DEVICE_NOT_FOUND;
> 
> 	if (size == 1)
> 		*val = readb(addr);
> 	else if (size == 2)
> 		*val = readw(addr);
> 	else
> 		*val = readl(addr);
> 
> 	return PCIBIOS_SUCCESSFUL;
> }

