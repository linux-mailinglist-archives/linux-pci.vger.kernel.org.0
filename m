Return-Path: <linux-pci+bounces-33665-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0103B1F4BB
	for <lists+linux-pci@lfdr.de>; Sat,  9 Aug 2025 15:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69330626A8E
	for <lists+linux-pci@lfdr.de>; Sat,  9 Aug 2025 13:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CC527FD5A;
	Sat,  9 Aug 2025 13:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b="AHXQNRTc"
X-Original-To: linux-pci@vger.kernel.org
Received: from server-vie001.gnuweeb.org (server-vie001.gnuweeb.org [89.58.62.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B6623C4FA;
	Sat,  9 Aug 2025 13:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.62.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754746135; cv=none; b=GzH4NFvOi5qQUEvGIqw2OKbjuFE5TVCOQZgMrXaINnuULtrYIHmphGspJKzs0yOLd/WTBRkf1seYn6Uc2wHHhbOV8sqEHRYLdMiVrimDFEI6p4buTXlLA/ZmEfVFSRlpwQHtQztz5SZLD7e/i2v3pW+coI4xINl4/1LoNj7Vvx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754746135; c=relaxed/simple;
	bh=TRSaDjzbvtdu1i28FtkDB5I4os3zzzmPa28t2zf3BKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6GiklgVe8Dk1dFr+i7QlTFezyqbT3NORQgU4dKSjOkVDmkeLxwISD4JAT05LXY8YZQwikFjIIhyrVYajhnYGYMYKhMUuhq4xRfQiuYpBv+KVivn2l/7WYwk9IjjiKhF0FcZWCGCQwtSzRp+tNqvbmLKA/fZIQ1KRTmntjrJJOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org; spf=pass smtp.mailfrom=gnuweeb.org; dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b=AHXQNRTc; arc=none smtp.client-ip=89.58.62.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnuweeb.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
	s=new2025; t=1754746125;
	bh=TRSaDjzbvtdu1i28FtkDB5I4os3zzzmPa28t2zf3BKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Message-ID:Date:From:Reply-To:Subject:To:
	 Cc:In-Reply-To:References:Resent-Date:Resent-From:Resent-To:
	 Resent-Cc:User-Agent:Content-Type:Content-Transfer-Encoding;
	b=AHXQNRTc9vIj2nij1HLyG1mCZACXTF7AyoUYN8GmMp6bx/i3nFYMZl1R9rTHimUlm
	 bgnUcQGFQxwmcTKsN0g6rvMMl5aqByM+94pRy54hxIOjfZb4iJLpcEPsTZ9XsR8B7R
	 2i3VDzAvXgA8Le0kNdaMgbANaeF3DOf+ni6Pp7MbqsGK0V/HR6tR1LPCLUWP2cZuXs
	 TaRyLo0RVtIKNYTcC/2qYm2LWkhl2aYMlA6gvI/T14KWgytwbkSu1/Xm+CZVgLFloS
	 hJVRNPNXdqBe2RD/k8MC54zqGhTyLz9OMSX37geI+wfb6VYMiGdTp6eHo8JbIbJQ1+
	 sBCqtDRek/gDg==
Received: from linux.gnuweeb.org (unknown [182.253.126.185])
	by server-vie001.gnuweeb.org (Postfix) with ESMTPSA id 7E12F3127CAF;
	Sat,  9 Aug 2025 13:28:42 +0000 (UTC)
X-Gw-Bpl: wU/cy49Bu1yAPm0bW2qiliFUIEVf+EkEatAboK6pk2H2LSy2bfWlPAiP3YIeQ5aElNkQEhTV9Q==
Date: Sat, 9 Aug 2025 20:28:39 +0700
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
Message-ID: <aJdNB8zITrkZ3n6r@linux.gnuweeb.org>
References: <ed53280ed15d1140700b96cca2734bf327ee92539e5eb68e80f5bbbf0f01@linux.gnuweeb.org>
 <aJQi3RN6WX6ZiQ5i@wunner.de>
 <aJQxdBxcx6pdz8VO@linux.gnuweeb.org>
 <20250807050350.FyWHwsig@linutronix.de>
 <aJQ19UvTviTNbNk4@linux.gnuweeb.org>
 <aJXYhfc/6DfcqfqF@linux.gnuweeb.org>
 <aJXdMPW4uQm6Tmyx@linux.gnuweeb.org>
 <87ectlr8l4.fsf@yellow.woof>
 <aJZ/rum9bZqZInr+@biznet-home.integral.gnuweeb.org>
 <20250809043409.wLu40x1p@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250809043409.wLu40x1p@linutronix.de>
X-Gw-Outgoing-Server-Hash: 01afd303c8b96d0c1d5e80aa96a4ee40ec69888f786fa24107c0862c0644af79

On Sat, Aug 09, 2025 at 06:34:29AM +0200, Nam Cao wrote:
> On Sat, Aug 09, 2025 at 07:52:30AM +0900, Ammar Faizi wrote:
> > I can do that. Send me a git diff. I'll test it and back with the dmesg
> > output.
> 
> That would be very helpful, thanks!
> 
> Please bear with me, this may take a few iterations.
> 
> Let's first try the below.

I just got home from a family outing. A bit slow response.

Here's the result:

  https://gist.github.com/ammarfaizi2/ef5f98123ed3868f8d64ed41662edd63#file-dmesg_pci_debug_001-txt-L853

-- 
Ammar Faizi


