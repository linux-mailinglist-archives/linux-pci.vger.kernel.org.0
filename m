Return-Path: <linux-pci+bounces-9016-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C779105A3
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 15:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E68D1C212F4
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 13:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5121AD3E9;
	Thu, 20 Jun 2024 13:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Xl7/Zs35"
X-Original-To: linux-pci@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ED51ACE8A
	for <linux-pci@vger.kernel.org>; Thu, 20 Jun 2024 13:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718889399; cv=none; b=dX7LW6GyltW2OpgtUMfTJKMrN4n/f2zWxNP0aiHsPtmSSld7LtyVjChoDrmirXERaVUWxGwjJrnA5oFSd+icB/I9+NrErPQchza9T5IpP0Rh1nVveHSEHMUue80IFKZQx/RdQHXj48OInzwTxWVwMHgqBD1Nn4c9hmBe5NuRF3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718889399; c=relaxed/simple;
	bh=4EsW15/r7sdZ/gibi4MX2yO17OuqUp9rfY6dl6UKDPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZG9ZgdVWAth6vf5iNOB5ECmB79RGGNhmKcMudiqaj+r5a04o8WB3KfOANZLi01rKb9FuF2QjZigAqJ5R4H4URRjIx0sOAs2mD1QgWWSiUKP2TL0+1HIiGV9CvpWGHFQue/Wvy5SNmNsqJa3uFeU1yv68NxiR/nwqE3gmtELrD4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Xl7/Zs35; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=bTeaeKHd96ZoUhr7YJ41ztaRyl4DnKoTnHVWxvT3dpo=; b=Xl
	7/Zs35hYcRCT3YGuqLvZUREi60pDP6vt2O8LbfA38BqM5YCCBlH6skRoBuNnqtNy/p4xse/zPkPDH
	9JzXPtTZB4BbbqBomPtGI1v3OmGNV0w8d7iozlCY655CeM4GEJPyENFTZl8eyeZ1Xk8tLdbcJhqUG
	LO/mDUY9cYnl5gc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sKHeQ-000ZfA-Ep; Thu, 20 Jun 2024 15:16:30 +0200
Date: Thu, 20 Jun 2024 15:16:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: mvebu: Dispose INTx irqs prior to removing INTx
 domain
Message-ID: <0d8658d2-a5bc-4721-a409-7c0eec55f19f@lunn.ch>
References: <20240619142829.2804-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240619142829.2804-1-kabel@kernel.org>

On Wed, Jun 19, 2024 at 04:28:29PM +0200, Marek Behún wrote:
> From: Pali Rohár <pali@kernel.org>
> 
> Documentation for irq_domain_remove() says that all mapping within the
> domain must be disposed prior to domain remove.
> 
> Currently INTx irqs are not disposed in pci-mvebu.c device unbind callback
> which cause that kernel crashes after unloading driver and trying to read
> /sys/kernel/debug/irq/irqs/<num> or /proc/interrupts.

I was wondering why this is safe. Are there still users? If the users
are being removed first, why are there still mappings. This is
discussed in the old thread:

> I think that in this case for pci-mvebu.c it is safe because: At the
> first step of unbind procedure is called unregistraction of PCIe bus
> with all devices bound on it. This ensures that all PCIe endpoint
> drivers are unbind, devices removed and no new driver or device and
> appear. After that there should not be any remaining usage of PCIe
> resources (if there is then whole PCIe hotplug code is broken and we
> have other and bigger issue...). Next pci-mvebu.c manually disposes
> all remaining legacy interrupts (which PCI core code does not
> because legacy interrupts are shared and it does not know if they
> are used or not).  This is safe because at these stage there are no
> PCI drivers bound, there is no PCI device for that controller
> registered. And after that is removed IRQ domain (which has finally
> disposed all interrupts).

If there is a need to respin, it would be good to include this in the
commit message.

       Andrew

