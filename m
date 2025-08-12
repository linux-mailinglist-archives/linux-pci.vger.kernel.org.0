Return-Path: <linux-pci+bounces-33883-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA878B2390B
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 21:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 598CA1AA7BBF
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 19:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4A727D780;
	Tue, 12 Aug 2025 19:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X9w1/5mr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rM3MM1Vn"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05EE244660;
	Tue, 12 Aug 2025 19:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755027156; cv=none; b=LOl6TmJ+6/Qd58YCOqLpIah/HLcVbXRx8kDQV7NqwbFCm4JQixPuaz2KRwwC0ZsiwZ7mIJpewTuxEPwPJQgrFXtot3FUdyOqJZGBlAq16LuxZ7Qqhj69BxGVsPfEP1KSTatujEBoI8f5+UZZ+yLtLUBW0+W5qRK81sykN4w7Pmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755027156; c=relaxed/simple;
	bh=3cvO8hjq6YpgO7S22HAORkzKx2wKSr/uxkMNB8M2uP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFAIdqVcdAcpFDm8S+Hwf91R+K9lOBEjvAL+AXRz0N2O7T/6diiiAZ187b8JNGqCMfK9QAD0KIHoVa16q9faHkpSTVnsz5jYogvRTWAVkACVBEo7+zfcVJ9hUvNKRxeQZIHJ0D17DFFP0IqeAjvY/vhgTO2KFeCS5GwwWff3TVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X9w1/5mr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rM3MM1Vn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 12 Aug 2025 21:32:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755027152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qYD+GkbgVB+ErRzMJKT5gL8WfFw1lW76rnM8mlxL/o8=;
	b=X9w1/5mrVKx4VnVotNducu33l1BWfuMOZ2hkJ4jI2ND71noDBnPiT1Y8RjcFPc8yarKYIr
	Kq+qiAf/PE6ewvgPQBfPaJ+Z6dFaNzkowEC9+mSdG9Ve69EETbsTWAPB7qpfe4g8z7Xpbc
	m9fd6dPmIFSFqNpTaDSzzC5NRzTCBzshIl679cwAt57k7mf8Hqih1oJjYh6QhUJx6Z/rEF
	oV5EHdUI8lXjSbAQh9eQcFL8rZeTYrqtba9OdsYPIMYd2WZZDUZqUwOWXHpKQMs4Bre3YQ
	AF6reBppWJYRsI9fdxYVPlv/TCj/G6fStBe4+jE2jToVdO2TGfgR73JiQNpn0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755027152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qYD+GkbgVB+ErRzMJKT5gL8WfFw1lW76rnM8mlxL/o8=;
	b=rM3MM1VnH1nkJevwo60HAwk89AKBhakTdc330pvFKZa3PVsodG87qNN9NYT2BNbqInXCeX
	4YXzuofq/fx1gmDA==
From: Nam Cao <namcao@linutronix.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?iso-8859-1?Q?Wilczy=B4nski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re: [PATCH] PCI: vmd: Remove MSI-X check on child devices
Message-ID: <20250812193219.9E_pRwle@linutronix.de>
References: <20250812182209.c31roKpC@linutronix.de>
 <20250812190036.GA199875@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812190036.GA199875@bhelgaas>

On Tue, Aug 12, 2025 at 02:00:36PM -0500, Bjorn Helgaas wrote:
> On Tue, Aug 12, 2025 at 08:22:09PM +0200, Nam Cao wrote:
> > Minor correction, it is not just an unnecessary WARN_ON, but child devices'
> > drivers couldn't enable MSI at all.
> > 
> > So perhaps something like "Remove the sanity check to allow child devices
> > which only support MSI".
> 
> Thanks, updated.

Sorry for the extra work I have been putting on you this cycle. I trust you
understand it is for good reason.

It is unfortunate that I do not have hardware for most patches I sent. The
best I could do was staring at the patches until I think "yeah, that
probably isn't broken". That obviously isn't good enough to remove all
bugs. I wish that I could do better, but oh well...

Thanks Ammar as well, for helping me tracking down this bug.

I hope this one is the last regression report that we will see.

Nam

