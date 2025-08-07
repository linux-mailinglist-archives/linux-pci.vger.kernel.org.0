Return-Path: <linux-pci+bounces-33511-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 586D3B1D1B7
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 06:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFF077A1113
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 04:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161581DB546;
	Thu,  7 Aug 2025 04:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b="EFDZDiX4"
X-Original-To: linux-pci@vger.kernel.org
Received: from server-vie001.gnuweeb.org (server-vie001.gnuweeb.org [89.58.62.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7283872622;
	Thu,  7 Aug 2025 04:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.62.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754542470; cv=none; b=G0dT2wPxJ6aYcuo+QZWCTijd3oaHnQwlDvvUMAwgmna80SRTNzEHJvYcnRAtfOSoGEs4t6mLAujgThAE8R25Z27sNgnLvAAKtVh/Hog8mdvpEhzLVHdwcVGpwTQPaMHRs/hyYT1zjdmm6EuV18aXJYhwUGcA5PIeO8o6uZXMGWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754542470; c=relaxed/simple;
	bh=aksqcCuXyY8s+uU3hc7YFNe8clTDfj3aWkoQJFuh39c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gr4VXXe3eVa9MINpJdurvJiK4nQ/MVy6d9hO98axOwKmgmcG8QLus+4liFvwsYh9VSTYq9Xrh7o43gBnnXu/ZDOWMIa5eBJRfMmazBfsHOMp3/ow/L6k5BpZwiam8Fq3xmvtxtn2lJcQPcvE//igA+FUakOj5BDD0uYHfyxc9zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org; spf=pass smtp.mailfrom=gnuweeb.org; dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b=EFDZDiX4; arc=none smtp.client-ip=89.58.62.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnuweeb.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
	s=new2025; t=1754542466;
	bh=aksqcCuXyY8s+uU3hc7YFNe8clTDfj3aWkoQJFuh39c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Message-ID:Date:From:Reply-To:Subject:To:
	 Cc:In-Reply-To:References:Resent-Date:Resent-From:Resent-To:
	 Resent-Cc:User-Agent:Content-Type:Content-Transfer-Encoding;
	b=EFDZDiX4rrGolKCYgSBF4qs9DSrW8PftnbS/tfobzxSAsN1fty0L0/pFyMF4c/2JO
	 uYdIeVNJjF8lQvDOj5ldgc7vsHOIwY98YvZidLpOeVphKfnASMAMKT2PsRqf/fV2rD
	 abpS6CiBqLG8ZhIzpItdywSTCkPmNf/CZhRaJcY3nBuBRjw3AJcQHeeHdRIRrOCszX
	 pf10RvHNVjbglOM0Dlj1YB98UoxymkM2mNNMkFExBzqcQUHstvQiI4GO/EMGGm9q0q
	 7kc2Gl1qUFnY+vbrm5fOxIs8koZ3h3Iu7MYUmAF3uEAV7PnC1nqX6PgioD4vIvUfOy
	 YZkrS1zsjqqxw==
Received: from linux.gnuweeb.org (unknown [36.72.212.139])
	by server-vie001.gnuweeb.org (Postfix) with ESMTPSA id 8CC953127C80;
	Thu,  7 Aug 2025 04:54:21 +0000 (UTC)
X-Gw-Bpl: wU/cy49Bu1yAPm0bW2qiliFUIEVf+EkEatAboK6pk2H2LSy2bfWlPAiP3YIeQ5aElNkQEhTV9Q==
Date: Thu, 7 Aug 2025 11:54:12 +0700
From: Ammar Faizi <ammarfaizi2@gnuweeb.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Nam Cao <namcao@linutronix.de>, Bjorn Helgaas <helgaas@kernel.org>,
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
Message-ID: <aJQxdBxcx6pdz8VO@linux.gnuweeb.org>
References: <20250801142254.GA3496192@bhelgaas>
 <175408424863.4088284.13236765550439476565.pr-tracker-bot@kernel.org>
 <ed53280ed15d1140700b96cca2734bf327ee92539e5eb68e80f5bbbf0f01@linux.gnuweeb.org>
 <aJQi3RN6WX6ZiQ5i@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJQi3RN6WX6ZiQ5i@wunner.de>
X-Machine-Hash: hUx9VaHkTWcLO7S8CQCslj6OzqBx2hfLChRz45nPESx5VSB/xuJQVOKOB1zSXE3yc9ntP27bV1M1

On Thu, Aug 07, 2025 at 05:51:57AM +0200, Lukas Wunner wrote:
> Kenneth reports early-stage reboots caused by d7d8ab87e3e
> ("PCI: vmd: Switch to msi_create_parent_irq_domain()"):
> 
> https://lore.kernel.org/all/dfa40e48-8840-4e61-9fda-25cdb3ad81c1@panix.com/
> 
> Perhaps you're witnessing the same issue?

Confirmed, reverting that commit works on my machine. I'll try to
further diagnose it and report more details.

-- 
Ammar Faizi


