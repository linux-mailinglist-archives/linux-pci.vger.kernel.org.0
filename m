Return-Path: <linux-pci+bounces-33671-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB799B1F555
	for <lists+linux-pci@lfdr.de>; Sat,  9 Aug 2025 18:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B105118C4C7E
	for <lists+linux-pci@lfdr.de>; Sat,  9 Aug 2025 16:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8772E2367CE;
	Sat,  9 Aug 2025 16:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b="h+V6mZ+S"
X-Original-To: linux-pci@vger.kernel.org
Received: from server-vie001.gnuweeb.org (server-vie001.gnuweeb.org [89.58.62.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0994F84A35;
	Sat,  9 Aug 2025 16:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.62.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754755425; cv=none; b=l6cdrbKpMgn+8giEdwi/Bxf5QSLxrLko8N8wyO4S34+y50p86M68Vvti/UlBekQe9F4oYsQEt+Nk7B+leWqr6tnBxCA2iIJazPSdt5gjUNxsnxECn+p9ULQorN/SxdLS818eIEElDyrs+k00fQoeDsmSidJrRhVhpgBalWKQOQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754755425; c=relaxed/simple;
	bh=EypI9G8Vr/nQW0k5/vP9i30wLp/EuxAkr8epbMXEq+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CxofH9g4hCOrtk+j+FIBjVnYYkhmo7cUCtsdvuPpc6AOCNIoLcfXd//2qVF/CnGBqzQNCByTO/pkEylK+Xa1W5rzwmDthGHBrr9ShyXgONWcC1rNFJT7canAqy6dhH7WjnL2Y8f+fYdXIo8Y0aca70T7EZaHXkjhMX9Ayp3Mr7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org; spf=pass smtp.mailfrom=gnuweeb.org; dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b=h+V6mZ+S; arc=none smtp.client-ip=89.58.62.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnuweeb.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
	s=new2025; t=1754755422;
	bh=EypI9G8Vr/nQW0k5/vP9i30wLp/EuxAkr8epbMXEq+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Message-ID:Date:From:Reply-To:Subject:To:
	 Cc:In-Reply-To:References:Resent-Date:Resent-From:Resent-To:
	 Resent-Cc:User-Agent:Content-Type:Content-Transfer-Encoding;
	b=h+V6mZ+SgWAby2j9+p+g30xLkGtTcRMllYCkbr9s7YwmujbweFCOznJxvtij8NUrb
	 1+8cpsF+rMvuZEWDRHrKG1ufVKLgKCkIqFOICDZhc07OFrFecwvhUK3DDh4US7u0FO
	 hvh7PlGtAEH8XM7bgzP8T/D8k0NuI98wyc2QBE4QEdvMjhQa1IHwXbWoleomnkRJu2
	 oSmmOuqxf3pa32No444zkW3Nmz2lfasTrrNS0VhcKV1YkOyNdjSPNF9/V5y4lftc8C
	 1JEBRUwTxEEy2aOfTTWvUtGe55Ys1xUjhXFWoOLJu4xHXr8aXTCzBnAty7Dc4jVdh7
	 OE1zQ+E+vB2VQ==
Received: from linux.gnuweeb.org (unknown [182.253.126.185])
	by server-vie001.gnuweeb.org (Postfix) with ESMTPSA id B4D083127D72;
	Sat,  9 Aug 2025 16:03:38 +0000 (UTC)
X-Gw-Bpl: wU/cy49Bu1yAPm0bW2qiliFUIEVf+EkEatAboK6pk2H2LSy2bfWlPAiP3YIeQ5aElNkQEhTV9Q==
Date: Sat, 9 Aug 2025 23:03:35 +0700
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
Message-ID: <aJdxVy1i3wGTvU3b@linux.gnuweeb.org>
References: <aJQ19UvTviTNbNk4@linux.gnuweeb.org>
 <aJXYhfc/6DfcqfqF@linux.gnuweeb.org>
 <aJXdMPW4uQm6Tmyx@linux.gnuweeb.org>
 <87ectlr8l4.fsf@yellow.woof>
 <aJZ/rum9bZqZInr+@biznet-home.integral.gnuweeb.org>
 <20250809043409.wLu40x1p@linutronix.de>
 <aJdNB8zITrkZ3n6r@linux.gnuweeb.org>
 <20250809144927.eUbR3MXg@linutronix.de>
 <aJdmGwFU6b9zh1BO@linux.gnuweeb.org>
 <87wm7ch5of.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wm7ch5of.fsf@yellow.woof>
X-Gw-Outgoing-Server-Hash: 01afd303c8b96d0c1d5e80aa96a4ee40ec69888f786fa24107c0862c0644af79

On Sat, Aug 09, 2025 at 05:32:16PM +0200, Nam Cao wrote:
> So unlike what VMD doc says, it actually can have non-MSI-X children devices!

If that's the conclusion, then Intel VMD doc also needs fixing :/

> Please discard the reverts and the diff I sent you, and try the diff
> below. I believe your machine will work now.

Yes, I can confirm it's now clean. Just to verify both sides, here is
the last result:

  https://gist.github.com/ammarfaizi2/72578d2b4cc385fbdb5faee69013d530

If that one fix is final, then:

Tested-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>

Thanks for the debugging work.

It's probably too late to get the fix in mainline before rc1. But if it
can go upstream sooner, that would be great.

-- 
Ammar Faizi


