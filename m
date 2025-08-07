Return-Path: <linux-pci+bounces-33512-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14872B1D1D5
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 07:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E983F18C5580
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 05:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5821B85FD;
	Thu,  7 Aug 2025 05:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G5tiEBYx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V/7op6CT"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8473208;
	Thu,  7 Aug 2025 05:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754543038; cv=none; b=S/mXwNUbzIcA1pC3Sb+5knzP+Aei6aOX+8eos4ZcM4ILGlqp7jrl2IlAeLVkl/TwvPMk1BK8vtSuP6dMF8tsLHG9vWpy3uENGLbcfhRfqTCQzUzqg9A0Xz1dt72IFcyb1HNpU4jLqjKTIKOS2QAELnpd+uA49tyb2kUpejsfE3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754543038; c=relaxed/simple;
	bh=0q9cO/alk/trhYgceBWOPeTcWDdCn9delaZfQ2o5O+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2e9wCJ5cZ3DpO0i4MePHIVg7hhvaTWd5EbdZncdbWpfZrifGblWS/Nw9uJiibJzCWqzrnobs8gzd7YZ51t1pKiAPP9pQqWPJm1MGP6xA1xBJn/v/upQIGQFGRsFtbEVaKTCrfrg2ggAm27OTMKLRLbV0iAQICO/M36pjbpjeWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G5tiEBYx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V/7op6CT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 7 Aug 2025 07:03:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754543035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zXrQVRIdd7zZfKXZgOCzm4TnwtW/ih2Oep05XxnBgWY=;
	b=G5tiEBYx0lgflvflWOSrh8YLZ+IopxZI6roi8nq+09St+U0F2OGX7bhK1j4tiLwiCwcbYP
	5qd35Rvj9uho248zIsilGoGVMneLNZBNhQqTRaGclo4opvzTxmoNEnKU0jtt3GEvYId1+H
	4JvNoONadWkJ6espJyE3oNNizyh+3bawdCMEslqBfIZZGjklw/4YbnuR637qYpk8LIEZxy
	85i9BW3E/+aE03sbd87fEd6Ll5dBttn1leL2czf3HmtzHV3qhFmjgH/L3YI+bncgLP0ZGZ
	2yLGBB7gF/OBVUHZdvDZgbJJUsDUgeaZXwVIdAntwZFJNHHEfhE8iMu5s0bHNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754543035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zXrQVRIdd7zZfKXZgOCzm4TnwtW/ih2Oep05XxnBgWY=;
	b=V/7op6CTN27/9gFjMez3Xr3ht3XqOPJsfmWKYfpJMd9L4v60SRV+/OVlblvmSonlRJdEGJ
	isjyUsiJlTXaz8DQ==
From: Nam Cao <namcao@linutronix.de>
To: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux PCI Mailing List <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Rob Herring <robh@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof Wilczynski <kwilczynski@kernel.org>,
	Armando Budianto <sprite@gnuweeb.org>,
	Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
	gwml@vger.gnuweeb.org
Subject: Re: [GIT PULL v2] PCI changes for v6.17
Message-ID: <20250807050350.FyWHwsig@linutronix.de>
References: <20250801142254.GA3496192@bhelgaas>
 <175408424863.4088284.13236765550439476565.pr-tracker-bot@kernel.org>
 <ed53280ed15d1140700b96cca2734bf327ee92539e5eb68e80f5bbbf0f01@linux.gnuweeb.org>
 <aJQi3RN6WX6ZiQ5i@wunner.de>
 <aJQxdBxcx6pdz8VO@linux.gnuweeb.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJQxdBxcx6pdz8VO@linux.gnuweeb.org>

On Thu, Aug 07, 2025 at 11:54:12AM +0700, Ammar Faizi wrote:
> On Thu, Aug 07, 2025 at 05:51:57AM +0200, Lukas Wunner wrote:
> > Kenneth reports early-stage reboots caused by d7d8ab87e3e
> > ("PCI: vmd: Switch to msi_create_parent_irq_domain()"):
> > 
> > https://lore.kernel.org/all/dfa40e48-8840-4e61-9fda-25cdb3ad81c1@panix.com/
> > 
> > Perhaps you're witnessing the same issue?
> 
> Confirmed, reverting that commit works on my machine. I'll try to
> further diagnose it and report more details.

Does the diff below help?

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 9bbb0ff4cc15..b679c7f28f51 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -280,10 +280,12 @@ static int vmd_msi_alloc(struct irq_domain *domain, unsigned int virq,
 static void vmd_msi_free(struct irq_domain *domain, unsigned int virq,
 			 unsigned int nr_irqs)
 {
+	struct irq_data *irq_data;
 	struct vmd_irq *vmdirq;
 
 	for (int i = 0; i < nr_irqs; ++i) {
-		vmdirq = irq_get_chip_data(virq + i);
+		irq_data = irq_domain_get_irq_data(domain, virq + i);
+		vmdirq = irq_data->chip_data;
 
 		synchronize_srcu(&vmdirq->irq->srcu);
 

