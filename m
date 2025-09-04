Return-Path: <linux-pci+bounces-35449-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF7AB43CE9
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 15:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EC9D1C27967
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 13:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB93D1AA7A6;
	Thu,  4 Sep 2025 13:18:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8BB14A09C
	for <linux-pci@vger.kernel.org>; Thu,  4 Sep 2025 13:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756991934; cv=none; b=cwhG/APaQHTxCGGKODTkVboH9gBD5/+H8hnmJal4PzbQuVdAEOJc3QzoLgnr+0C6/J0F73HnXYVWMsE4HpaKHw/TdNo9z82PY/iu4d5LV58IqqG2fKIWGAhH2yqKgSpmibyxBCBn+ZBq6mI/pgprLRmP11EyUrBfbiSQvBP5EXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756991934; c=relaxed/simple;
	bh=d+rQQSyh8vj+YqtJr3kqnnWjk1+tY0I/9RcBj+IL++k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u78lZzdYu+IFjCayI+ZEu4jqB0U2gs5LqyJ+dUJyVeaSrXuJLwzIVwh1v+GbnV55IiYmb4ZwKdTgyB9yELpO3lr4IgOyB5sy2NChBUc5XhfixUeb7hZ6wqQ9oTxgglNb84bkfrOH0VTbYaJ3V2/ePJukw/hXoxyTgXBTQMR0b6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id F09FC2C051D9;
	Thu,  4 Sep 2025 15:18:50 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id C360A36B940; Thu,  4 Sep 2025 15:18:50 +0200 (CEST)
Date: Thu, 4 Sep 2025 15:18:50 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Crystal Wood <crwood@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Attila Fazekas <afazekas@redhat.com>, linux-pci@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] PCI/AER: Use IRQF_NO_THREAD on aer_irq
Message-ID: <aLmRujcci7hoY57r@wunner.de>
References: <20250902224441.368483-1-crwood@redhat.com>
 <20250904073024.YsLeZqK_@linutronix.de>
 <aLmKlVaKSBurRys1@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLmKlVaKSBurRys1@wunner.de>

On Thu, Sep 04, 2025 at 02:48:21PM +0200, Lukas Wunner wrote:
> On Thu, Sep 04, 2025 at 09:30:24AM +0200, Sebastian Andrzej Siewior wrote:
> > On 2025-09-02 17:44:41 [-0500], Crystal Wood wrote:
> > > +++ b/drivers/pci/pcie/aer.c
> > > @@ -1671,7 +1671,8 @@ static int aer_probe(struct pcie_device *dev)
> > >  	set_service_data(dev, rpc);
> > >  
> > >  	status = devm_request_threaded_irq(device, dev->irq, aer_irq, aer_isr,
> > > -					   IRQF_SHARED, "aerdrv", dev);
> > > +					   IRQF_NO_THREAD | IRQF_SHARED,
> > > +					   "aerdrv", dev);
> > 
> > I'm not sure if this works with IRQF_SHARED. Your primary handler is
> > IRQF_SHARED + IRQF_NO_THREAD and another shared handler which is
> > forced-threaded will have IRQF_SHARED + IRQF_ONESHOT. 
> > If the core does not complain, all good. Worst case might be the shared
> > ONESHOT lets your primary handler starve. It would be nice if you could
> > check if you have shared handler here (I have no aer I three boxes I
> > checked).
> 
> Yes, interrupt sharing can happen if the Root Port uses legacy INTx
> interrupts.  In that case other port services such as hotplug,
> bandwidth control, PME or DPC may use the same interrupt.

I should add that none of these other port service drivers use
IRQF_ONESHOT.  They're all IRQF_SHARED only.

Thanks,

Lukas

