Return-Path: <linux-pci+bounces-33515-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA12B1D1E8
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 07:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF8833B7D3C
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 05:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AAE1D7995;
	Thu,  7 Aug 2025 05:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UgEZa+SV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9jECH44t"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CCA1DB546
	for <linux-pci@vger.kernel.org>; Thu,  7 Aug 2025 05:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754543777; cv=none; b=F4L430HXrll3hsQcnsmW++Yg8ugyc6JftySswZMOo42v8aAsWAI6ysDPWFLwIhgMl85FeD0ZZsxkhe9zvDOo4m6bVeWQVStB3e/+vmQeQ5gd3WD+gyWGs5+trLJuBGppWKMiTrZvu98kKjIhNh2MXRHOYDUNMAPoDezXPDlw+OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754543777; c=relaxed/simple;
	bh=WFlHnzcTE7lwS4aksaP3AZV+IIN4vrzrDqKqt1Qc7mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jo8ZhPN8oRtLM2O5bSf2GpwTiA6yOSc+FzLDlRmA8AT7dHCYhtJgdur5HE8/2B56X9ugnwPArVIqD6vU4Z+0eQY1TDOd0an4HsxCjSdyPKU9wupURgqTa3dOTcqiDcSTCi7pJ7Na5CUau0xQsxvnFARzYjE2HmPPClbJiS+hmcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UgEZa+SV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9jECH44t; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 7 Aug 2025 07:16:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754543774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+nLKafRJSjND6TOvvqadUr6SQ00vyQHsB8OdT018nMU=;
	b=UgEZa+SVgeq5OOf6Vgspk94Za1GqVtOGhB2cmXzGk3uGXlqeQH4zu7fF2a0WWXjhOZ+udg
	fFsA2LxeP4/21mKZD4U9NLBhqkkNmTuWqXvgjDAqdeXo+R71zbc9EFYyoFX84zyMkaV9pL
	P2Ab/va/cKNX5Cx8KdQ5Qnr23wAxESqTYM6pRMl29afBuKbPTcWJORudISGC6AUgxI+rlE
	Wh4kfThbODN790Jm2FhzcPEFfBXQ7+tSu9U3WhcewHBWgEOWRmGJGcItPGs/Bt93x7GltE
	4QsUcQDnFri9num/LowiVbwgkrgIsgEA/m++PHMyAhlRBYNaTl7CFRn9xn2w7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754543774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+nLKafRJSjND6TOvvqadUr6SQ00vyQHsB8OdT018nMU=;
	b=9jECH44tsYTolpeq1GuQ4FkBGAqhqPpurg007wFSOMcE2qIuPSYuMa8MmBiNb0smXMMWSj
	HVqg4nazR5l24fBQ==
From: Nam Cao <namcao@linutronix.de>
To: Kenneth Crudup <kenny@panix.com>
Cc: mani@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Subject: Re: Commit d7d8ab87e3e ("PCI: vmd: Switch to
 msi_create_parent_irq_domain()") causes early-stage reboots on my Dell
 XPS-9320
Message-ID: <20250807051608.ExhI9r1T@linutronix.de>
References: <dfa40e48-8840-4e61-9fda-25cdb3ad81c1@panix.com>
 <87v7mzn3ta.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v7mzn3ta.fsf@yellow.woof>

On Thu, Aug 07, 2025 at 06:39:13AM +0200, Nam Cao wrote:
> Kenneth Crudup <kenny@panix.com> writes:
> 
> > I'm running Linus' master (as of today, cca7a0aae8958c9b1).
> >
> > If I revert the named commit, I can boot OK. Unfortunately there's no 
> > real output before the machine reboots, to help identify the problem.
> >
> > I have a(n enabled) VMD in my Alderlake machine:
> >
> > [    0.141952] [      T1] smpboot: CPU0: 12th Gen Intel(R) Core(TM) 
> > i7-1280P (family: 0x6, model: 0x9a, stepping: 0x3)
> >
> > If there's something else I can try, let me know.
> 
> Thanks for the report. It is unfortunate that there is no output to work
> with :(
> 
> Let me stare at the commit again..

Another person reported problem with this commit, and that was resolved
with the diff below.

Does it fix your case too?

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
 

