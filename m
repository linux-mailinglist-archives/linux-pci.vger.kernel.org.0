Return-Path: <linux-pci+bounces-38221-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B9689BDEC74
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 15:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9320E4E1B58
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 13:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E315618BC3D;
	Wed, 15 Oct 2025 13:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pjB9mSa4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9EB16F265
	for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 13:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760535312; cv=none; b=D4QlwJ8mGFjLFCIchBzK0i+APOxqpNcauObhmSVaiwXHGB5IbM4Jnfs5HXKdkFeNtSKmhiYnb5TJvNGT2PdEgKN98IYTWG8qUO5QejCAfquefYjyrgyjnSmUXCq3azlS4uSmwYgrIsQwBbWHBgObUqZ0DP/yQASWs1ES7UgZH68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760535312; c=relaxed/simple;
	bh=SeTF6xVjGeVxwXBro1Jd4xMzM9ZGziYW1KwQTQeZekM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bJhSIm2Tox6mKK6BxZWkYKq1WGvg0xqx7d/nz6QF9APURvuagrX75ytSky1a2BtGkl4Wbm8YGyLLUeYGzlxWjr7C560AInWCblQyROd6HPYOvPpGBu38rb6rvtMQLMOEyoDDVOUsHTfJ8MhY3ehBg1yIdv4dQLMJvCHR8B/Uny8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pjB9mSa4; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 54AE84E410D6;
	Wed, 15 Oct 2025 13:35:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 19FEF606F9;
	Wed, 15 Oct 2025 13:35:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5EE7E102F22CF;
	Wed, 15 Oct 2025 15:34:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760535303; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=oMU9G4Af1cq7AyrrzQ2eG1h+ieGKieI2qQ6GlGAzq4U=;
	b=pjB9mSa45RgZGf+JyVeqvP7qIc/TzHk5GVvUMqgPHqsIv5/DzktXddn8iq8xeExInGbFO5
	wixpOYF6+jQHYhxwcjPd/Igt3ht5HkH8OdmdkXXb45VuNafZbpBkM+FxliSS52eqgNx0NW
	QryRhmGe3Ad5IhLd6KOgwVxa67bPbIHDTs1yPx1ofVCmiqrr6P2qd0m7PD/CIE2OJ3csVn
	fdDTCJxl+E0DiyNu1UXZ8rvLdpopGBBsnUko9D5DOTdh1z3yKofLV0l+qg2Ks/eCQJyooO
	a85e+wE4UeENHtsyoJHJbXIXaYY/Vs1ddszHzzrJqAY1idCLfedZDZawJ2V1BA==
Date: Wed, 15 Oct 2025 15:34:42 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas
 <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>, Manivannan Sadhasivam
 <manivannan.sadhasivam@oss.qualcomm.com>, Ilpo =?UTF-8?B?SsOkcnZpbmVu?=
 <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org, mad skateman
 <madskateman@gmail.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>, Christian
 Zigotzky <info@xenosoft.de>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 hypexed@yahoo.com.au, Darren Stevens <darren@stevens-zone.net>,
 debian-powerpc@lists.debian.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PPC] Boot problems after the pci-v6.18-changes
Message-ID: <20251015153442.423e2278@bootlin.com>
In-Reply-To: <76026544-3472-4953-910A-376DD42BC6D0@xenosoft.de>
References: <20251015145901.3ca9d8a0@bootlin.com>
	<76026544-3472-4953-910A-376DD42BC6D0@xenosoft.de>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Christian,

On Wed, 15 Oct 2025 15:14:28 +0200
Christian Zigotzky <chzigotzky@xenosoft.de> wrote:

> > Am 15 October 2025 at 02:59 pm, Herve Codina <herve.codina@bootlin.com> wrote:
> > 
> > Also when it boots, it is not easy to know about the problem root cause.
> > 
> > In my case, it was not obvious to make the relationship on my side between
> > my ping timings behavior and ASPM.
> > 
> > Of course 'git bisect' helped a lot but can we rely on that for the average
> > user?
> > 
> > Best regards,
> > Hervé  
> 
> I think I will revert these modifications for the RC2.

I don't know what is the future of those modifications but maybe instead
of fully reverting them, maybe you could perform calls to
 - pcie_clkpm_override_default_link_state() and
 - pcie_aspm_override_default_link_state()
only if a new Kconfig symbol is enabled.

Of course this symbols will be disabled by default but if you want some
people to test behavior, it could be interesting to have the code
available in the kernel.

I don't know, this was just an idea.

Of course, reverting the patch is simpler than adding this new Kconfig
symbol.

Best regards,
Hervé

