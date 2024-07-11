Return-Path: <linux-pci+bounces-10156-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D6192EA1E
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 16:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C91F41C20BC2
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 14:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028F014BFA2;
	Thu, 11 Jul 2024 14:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hOsgDY5v"
X-Original-To: linux-pci@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBBC148FE8
	for <linux-pci@vger.kernel.org>; Thu, 11 Jul 2024 14:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720706596; cv=none; b=hQcHmANslBwjqh6OGAOHTymtVNGsI/qMJq8ljd9DQisr6fDhweLBMp1JJfKsF3D+Hja/yrM4otWffIMTFNaMRgojdlokC/nY37/ACHOG+uQmZBJiwxVSXfqwaxRDIdRUPeHQgVtolxbAyHfAFCVa0BtowDRGroI6HkoXQWGm7Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720706596; c=relaxed/simple;
	bh=t+XITPWlygAIT+7eWE+kZgGUFe7VMs1vnO+2v5/XTNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CPByJJwpTCn9wAZqhLBNjI0ikcjd8z0vtRg5acdPbPlxxdID/jsYbK+PG2+caG/YUbk2HdTr9XoUzvYodm0s1O8mx1XgNRE2zppSmBi7r75c9nOFia8NVAh9knR7Y/6E6HHOiiYSSTSGTvloPRhUuc0p19OooGrIbqlpBLq7gXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hOsgDY5v; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=cMgynrlmHnZndNkRrupm9f56CiHUS2Zhy0sYBOJLELs=; b=hO
	sgDY5vhDyj9GKcuTYqWC4Wh7cYgPSu5bVXeSoIyO+Hk3Pw7+VyAxpH7XPYCkliwWU97iSRKTlW5Wu
	BU+5Ydd1Wi2nbGWcCFSCgVVDdmDABTXpJskjjXE2PxJ4ueXcga4lDoWnmOWhC0ixiKH+4cTF2/LpQ
	LPPh1xyBBkn+2eg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sRuO1-002K2h-Qm; Thu, 11 Jul 2024 16:03:05 +0200
Date: Thu, 11 Jul 2024 16:03:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v2] PCI: mvebu: Dispose INTx IRQs before to removing INTx
 domain
Message-ID: <584912d9-96a5-4c29-b881-ecea4d97f516@lunn.ch>
References: <20240711132544.9048-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240711132544.9048-1-kabel@kernel.org>

On Thu, Jul 11, 2024 at 03:25:44PM +0200, Marek Behún wrote:
> From: Pali Rohár <pali@kernel.org>
> 
> The documentation for the irq_domain_remove() function says that all
> mappings within the IRQ domain must be disposed before the domain is
> removed.
> 
> Currently, the INTx IRQs are not disposed in pci-mvebu driver .remove()
> method, which causes the kernel to crash when unloading the driver and
> then reading /sys/kernel/debug/irq/irqs/<num> or /proc/interrupts.
> 
> Unmapping of the IRQs at this point of the .remove() method is safe,
> since the PCIe bus is already unregistered, and all its devices are
> unbound from their drivers and removed. If there was indeed any
> remaining use of PCIe resources, then it would mean that PCIe hotplug
> code is broken, and we have bigger problems.
> 
> Fixes: ec075262648f ("PCI: mvebu: Implement support for legacy INTx interrupts")
> Reported-by: Hajo Noerenberg <hajo-linux-bugzilla@noerenberg.de>
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Reviewed-by: Marek Behún <kabel@kernel.org>
> [ Marek: refactored a little, added more explanation to commit message ]
> Signed-off-by: Marek Behún <kabel@kernel.org>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

