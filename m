Return-Path: <linux-pci+bounces-33623-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E87F0B1E70A
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 13:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B2FD5840C3
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 11:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF63B2236F4;
	Fri,  8 Aug 2025 11:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b="irMnbYA3"
X-Original-To: linux-pci@vger.kernel.org
Received: from server-vie001.gnuweeb.org (server-vie001.gnuweeb.org [89.58.62.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546881D5CDE;
	Fri,  8 Aug 2025 11:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.62.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754651962; cv=none; b=bZsUpU7vCwVp66Z6sV61WNiIBnYTiR8sNB096Ktag+G4zcR6Jx2LfUx569C8Xz4QOXQHte4PZBhGZJYaG0/JB9O8TebJlDqZFrZKptekud3pl4ce/tt9+mAz5jqp4GD7dO+EnSwpZPWr/w5gbUqq+sjtjWUl3SJAf1FcI16wZxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754651962; c=relaxed/simple;
	bh=EHPOAR8DTtu9w2Af/wfaGurTsRHP2TwyamQVwE8bsFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDdHfqyWog2dVdzgnfL43FamILLDKiRa+BOj1+m9klHQKoloxK9GS96wSAMO/tnAQblopU3jYoFhW49//dX93du7rnrAEXLs8xuDWOY3dfrwelFD5jP0kUZNGOcOyOK3PuwSr4ltVF4GZ9TjWOElD2q0dBI5CSKQ87XXdeXyUNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org; spf=pass smtp.mailfrom=gnuweeb.org; dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b=irMnbYA3; arc=none smtp.client-ip=89.58.62.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnuweeb.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
	s=new2025; t=1754651958;
	bh=EHPOAR8DTtu9w2Af/wfaGurTsRHP2TwyamQVwE8bsFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Message-ID:Date:From:Reply-To:Subject:To:
	 Cc:In-Reply-To:References:Resent-Date:Resent-From:Resent-To:
	 Resent-Cc:User-Agent:Content-Type:Content-Transfer-Encoding;
	b=irMnbYA3tYbC8cohCWgGIF4o+cZD5mvDISSTHODIoofIy8JjHUtXuMfTfL065gdxU
	 4lmqgu3uHGR+ZTMZ7pDlQJo31dpJca+mzGiYQESg2NwcyIJ2PP6p33PZqILAXJVANW
	 pMv8w18fx5EbLCrfDp64rDQHGEBc1jacd6Fgl0oX2eD7nXZE5QLa1xbNP2fmlrPzyK
	 XvB/b4zpM5cJAvLDlj0hloj6Y+PmUldaqmmda3w4Y1t93mi9CsXTpGj0fvkkhRmgsO
	 h+lkzbVYlhADS+g3uEj3srKhWfNWp0X0ITf9w3/cEYmusiCbaEjPYrhHT3MILjEpuf
	 AsKpj6QuhSsJQ==
Received: from linux.gnuweeb.org (unknown [182.253.126.185])
	by server-vie001.gnuweeb.org (Postfix) with ESMTPSA id 7B3053127DA6;
	Fri,  8 Aug 2025 11:19:15 +0000 (UTC)
X-Gw-Bpl: wU/cy49Bu1yAPm0bW2qiliFUIEVf+EkEatAboK6pk2H2LSy2bfWlPAiP3YIeQ5aElNkQEhTV9Q==
Date: Fri, 8 Aug 2025 18:19:12 +0700
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
Message-ID: <aJXdMPW4uQm6Tmyx@linux.gnuweeb.org>
References: <20250801142254.GA3496192@bhelgaas>
 <175408424863.4088284.13236765550439476565.pr-tracker-bot@kernel.org>
 <ed53280ed15d1140700b96cca2734bf327ee92539e5eb68e80f5bbbf0f01@linux.gnuweeb.org>
 <aJQi3RN6WX6ZiQ5i@wunner.de>
 <aJQxdBxcx6pdz8VO@linux.gnuweeb.org>
 <20250807050350.FyWHwsig@linutronix.de>
 <aJQ19UvTviTNbNk4@linux.gnuweeb.org>
 <aJXYhfc/6DfcqfqF@linux.gnuweeb.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJXYhfc/6DfcqfqF@linux.gnuweeb.org>
X-Machine-Hash: hUx9VaHkTWcLO7S8CQCslj6OzqBx2hfLChRz45nPESx5VSB/xuJQVOKOB1zSXE3yc9ntP27bV1M1

On Fri, Aug 08, 2025 at 05:59:23PM +0700, Ammar Faizi wrote:
> On Thu, Aug 07, 2025 at 12:13:37PM +0700, Ammar Faizi wrote:
> > On Thu, Aug 07, 2025 at 07:03:50AM +0200, Nam Cao wrote:
> > > Does the diff below help?
> > 
> > Yes, it works.
> 
> So today, I synced with Linus' master branch again:
> 
>   37816488247d ("Merge tag 'net-6.17-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")
> 
> and applied your fix on top of it.
> 
> I can boot, but I get this splat. Looking at the call trace, it seems
> it's still related to pci, but different issue. The call trace is also
> different from the previous one.

It'll be a bit tricky to bisect this one. Because if I step back to
a bad commit post:

   d7d8ab87e3e ("PCI: vmd: Switch to msi_create_parent_irq_domain()")

I won't be able to boot to reach this new splat :/

I guess I need to apply the fix dirty for each bisection step. But I'll
also need to make sure the current step has the d7d8ab87e3e commit
anchestor before applying.

-- 
Ammar Faizi


