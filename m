Return-Path: <linux-pci+bounces-33635-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F48B1E952
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 15:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DB63A059F1
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 13:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0C027A900;
	Fri,  8 Aug 2025 13:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b="fqlhB4DQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from server-vie001.gnuweeb.org (server-vie001.gnuweeb.org [89.58.62.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96469219311;
	Fri,  8 Aug 2025 13:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.62.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754660079; cv=none; b=njexczeu3U4HYIHMVftMSF+6981f2TutHv64bXmKmA5OpID/+WJ14URfQIwS9RCZZqVhTOAmbcgX49o6BnmQ0ok7Piy9xvcSxvrbEiE+2Fhq1xPxIYMirKTtIBVpgL3wACATiPsYqyAbGhlpdR0DcI1SIxreRaW5cgLLOtsFQg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754660079; c=relaxed/simple;
	bh=FhRZ3giE7cy9srIz3kiAgRkrIILznjoxxss1HdK3v2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPb7FVOS4D7xMG6zB/mm3hNwdxu1XMATb1M42SFoPkNeuhIPn8Pvq1JgtuePIbTtAbVfdGdmZIIUweiRqs1bCceSCzK2p9YWL5kC6yh+FoT+5+XzE1dp9KQ/2k3gb4VPaVxYnjzeqNrTKEdBIAYkh1VufLtECyyI4rq/HwZTxWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org; spf=pass smtp.mailfrom=gnuweeb.org; dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b=fqlhB4DQ; arc=none smtp.client-ip=89.58.62.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnuweeb.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
	s=new2025; t=1754660075;
	bh=FhRZ3giE7cy9srIz3kiAgRkrIILznjoxxss1HdK3v2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Message-ID:Date:From:Reply-To:Subject:To:
	 Cc:In-Reply-To:References:Resent-Date:Resent-From:Resent-To:
	 Resent-Cc:User-Agent:Content-Type:Content-Transfer-Encoding;
	b=fqlhB4DQ9ySHEypAF9w9jIvWZWkaZfz1clpotBjvy0HVe8bHomf22VlMjYSxrCyeq
	 DCr+8jXYy4u3b/ERNfSCHfRhmcXDsjDODd0G9Fk3nR9j2dQRd+y6s6ei4rfiyHc/zs
	 490lwuut75rirnn8rhz4osA0T7Eyc7R5/FJCP9oIni074gmWkE+2Bu7g0Uu+rBRu83
	 2DsZJumgsqAUQV+FIlakQaWmvJ4cey+AbHYLlYENfM96HirZmpgMRXi5rplOE7Axyb
	 3yUb85lNIZ2bxmDkZr+oeOcEjKDxEbPpWRo3kivThNvnfTg5JRzMtu1pP4GxruYvTd
	 Sl6FNxO9V5XVQ==
Received: from linux.gnuweeb.org (unknown [182.253.126.185])
	by server-vie001.gnuweeb.org (Postfix) with ESMTPSA id AB8BE3127DAC;
	Fri,  8 Aug 2025 13:34:32 +0000 (UTC)
X-Gw-Bpl: wU/cy49Bu1yAPm0bW2qiliFUIEVf+EkEatAboK6pk2H2LSy2bfWlPAiP3YIeQ5aElNkQEhTV9Q==
Date: Fri, 8 Aug 2025 20:34:29 +0700
From: Ammar Faizi <ammarfaizi2@gnuweeb.org>
To: Nam Cao <namcao@linutronix.de>
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
Message-ID: <aJX85RPzsW/TmNeS@linux.gnuweeb.org>
References: <20250801142254.GA3496192@bhelgaas>
 <175408424863.4088284.13236765550439476565.pr-tracker-bot@kernel.org>
 <ed53280ed15d1140700b96cca2734bf327ee92539e5eb68e80f5bbbf0f01@linux.gnuweeb.org>
 <aJQi3RN6WX6ZiQ5i@wunner.de>
 <aJQxdBxcx6pdz8VO@linux.gnuweeb.org>
 <20250807050350.FyWHwsig@linutronix.de>
 <aJQ19UvTviTNbNk4@linux.gnuweeb.org>
 <aJXYhfc/6DfcqfqF@linux.gnuweeb.org>
 <aJXdMPW4uQm6Tmyx@linux.gnuweeb.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJXdMPW4uQm6Tmyx@linux.gnuweeb.org>
X-Machine-Hash: hUx9VaHkTWcLO7S8CQCslj6OzqBx2hfLChRz45nPESx5VSB/xuJQVOKOB1zSXE3yc9ntP27bV1M1

On Fri, Aug 08, 2025 at 06:19:18PM +0700, Ammar Faizi wrote:
> It'll be a bit tricky to bisect this one. Because if I step back to
> a bad commit post:
> 
>    d7d8ab87e3e ("PCI: vmd: Switch to msi_create_parent_irq_domain()")
> 
> I won't be able to boot to reach this new splat :/
> 
> I guess I need to apply the fix dirty for each bisection step. But I'll
> also need to make sure the current step has the d7d8ab87e3e commit
> anchestor before applying.

Unfortunately, it turns out I don't have time to bisect it at the moment.
But if you have something for me to test, I'll give it a try.

I can continue bisecting it later, maybe after rc1 is out if the fix is
still pending.

For now, I revert the PCI merge entirely in my local tree and it
resolves the issue.

  0bd0a41a5120 ("Merge tag 'pci-v6.17-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/pci/pc")

  git revert -m 1 -s 0bd0a41a5120;

This is an interesting case for me because it is my first time reverting
a merge commit :-)

I'll probably need to revert that revert-commit later when the PCI fix
actually arrives in mainline before syncing.

Happy weekend!

-- 
Ammar Faizi


