Return-Path: <linux-pci+bounces-33668-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70991B1F523
	for <lists+linux-pci@lfdr.de>; Sat,  9 Aug 2025 17:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AEF0627555
	for <lists+linux-pci@lfdr.de>; Sat,  9 Aug 2025 15:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5C5347C7;
	Sat,  9 Aug 2025 15:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b="UDgyqImB"
X-Original-To: linux-pci@vger.kernel.org
Received: from server-vie001.gnuweeb.org (server-vie001.gnuweeb.org [89.58.62.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7B92E36EE;
	Sat,  9 Aug 2025 15:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.62.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754752549; cv=none; b=kVGKDYe8M3Va/xq64xB0jyoMRCqqp+gkaujfl6YjsEcY6tssJZIvVlNpTgSQolPwatNq0mWa2K6Jroi+mKObUus82Nc+Ud70ZOG+pcMOB6IPD7n9NJqbznx9XS2zWw1x0+1vYFeYC7ZboB7CuHVKicyRG3ZLEzhY3RjW6H3pk7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754752549; c=relaxed/simple;
	bh=vGiupVnReMGz6Yp6fLQUpMFIklLD9xYX9UW2XQVrtWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BsCp4XGfGDHUlNHPeJjhYfpBoFULBRLYKgfLi7JSHJ0MTY0d59a/o42+BYnJiCeM+Ycs7GDd/cocXKUjRmPlE51dTrjY2O7PpqhEKHmk/zwLcL9iDxatGRB4xE7q6hsIOOWlLgHXWvkbxOiGEZ3u6p9HkmHOGmfFeQvQHBpHGMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org; spf=pass smtp.mailfrom=gnuweeb.org; dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b=UDgyqImB; arc=none smtp.client-ip=89.58.62.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnuweeb.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
	s=new2025; t=1754752545;
	bh=vGiupVnReMGz6Yp6fLQUpMFIklLD9xYX9UW2XQVrtWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Message-ID:Date:From:Reply-To:Subject:To:
	 Cc:In-Reply-To:References:Resent-Date:Resent-From:Resent-To:
	 Resent-Cc:User-Agent:Content-Type:Content-Transfer-Encoding;
	b=UDgyqImBve9n2jkA4BUdYHQcdcqiZhYQX/RKMmNgmQXWwHyk6SsAC6p343L4qQP+m
	 o/5vB1bmODOphwKJaBWUEes8u0Y8zS490HEealLqaSdDKZEB77beLiS7MH81HchbqE
	 15i3+9Xl4iurOeILr7UJLleDSjuf0nbnBtCyjNsR7Hp39Bj+778ejUF5wT+z7ixktO
	 jTo7fuZehr7w03Kwlp0Eh/9MO7baeeYBHqalF2t/1gSlMr8JXeOGawbO/FWmxJt4TI
	 di9MBElFsB0IUTFBdJPR7dICmHlD3b2XKwjobexObKAzGNta7SyadcJTTRceimYsLq
	 JhV/MAkXkDjUg==
Received: from linux.gnuweeb.org (unknown [182.253.126.185])
	by server-vie001.gnuweeb.org (Postfix) with ESMTPSA id 9DAE03127CC4;
	Sat,  9 Aug 2025 15:15:42 +0000 (UTC)
X-Gw-Bpl: wU/cy49Bu1yAPm0bW2qiliFUIEVf+EkEatAboK6pk2H2LSy2bfWlPAiP3YIeQ5aElNkQEhTV9Q==
Date: Sat, 9 Aug 2025 22:15:39 +0700
From: Ammar Faizi <ammarfaizi2@gnuweeb.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux PCI Mailing List <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Rob Herring <robh@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof Wilczynski <kwilczynski@kernel.org>,
	Armando Budianto <sprite@gnuweeb.org>,
	Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
	gwml@vger.gnuweeb.org, namcaov@gmail.com
Subject: Re: [GIT PULL v2] PCI changes for v6.17
Message-ID: <aJdmGwFU6b9zh1BO@linux.gnuweeb.org>
References: <aJQxdBxcx6pdz8VO@linux.gnuweeb.org>
 <20250807050350.FyWHwsig@linutronix.de>
 <aJQ19UvTviTNbNk4@linux.gnuweeb.org>
 <aJXYhfc/6DfcqfqF@linux.gnuweeb.org>
 <aJXdMPW4uQm6Tmyx@linux.gnuweeb.org>
 <87ectlr8l4.fsf@yellow.woof>
 <aJZ/rum9bZqZInr+@biznet-home.integral.gnuweeb.org>
 <20250809043409.wLu40x1p@linutronix.de>
 <aJdNB8zITrkZ3n6r@linux.gnuweeb.org>
 <20250809144927.eUbR3MXg@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250809144927.eUbR3MXg@linutronix.de>
X-Gw-Outgoing-Server-Hash: 01afd303c8b96d0c1d5e80aa96a4ee40ec69888f786fa24107c0862c0644af79

On Sat, Aug 09, 2025 at 04:49:27PM +0200, Nam Cao wrote:
> Thanks! Here's the problem:
> 
>     [    1.037223] pcieport 10000:e0:1d.0: __pci_enable_msix_range:840 err=hwsize
> 
> The PCIe port driver enables interrupt, trying MSI-X first. However, the
> device does not support MSI-X, so it tries MSI instead, which triggers
> the WARN_ON() in VMD driver.
> 
> What's strange is that, the VMD doc says:
> 
>     "Intel VMD only supports MSIx Interrupts from child devices and
>     therefore the BIOS must enable PCIe Hot Plug and MSIx interrups"
> 
> Is it lying to us?
> 
> Can you	please try:
> 
>     Revert d5c647b08ee0 ("PCI: vmd: Fix wrong kfree() in vmd_msi_free()")
>     Revert d7d8ab87e3e7 ("PCI: vmd: Switch to msi_create_parent_irq_domain()")
> 
> So that the driver is back to the original state before I touched it.
> 
> And apply the diff below. This will tell us if my commit breaks the driver
> somehow, or VMD has been allowing MSI all this time.

Here's the result after reverting those two commits and applied the diff.

  https://gist.github.com/ammarfaizi2/03c7a9c0fec2a11f206931f1b7790709#file-dmesg_pci_debug_002-txt

Let's see if this one is enough for you to diagnose the problem.

Note that the previous printk() diff has to be discarded to avoid
conflict in the reverts. If that's still needed, send me a fixed
diff after clean reverts.

-- 
Ammar Faizi


