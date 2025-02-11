Return-Path: <linux-pci+bounces-21240-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC93A3195F
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 00:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 202983A14A8
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 23:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D24F26A095;
	Tue, 11 Feb 2025 23:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bttBPPcj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E940726A08F;
	Tue, 11 Feb 2025 23:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739315809; cv=none; b=qkFIZccYC/Va3QL5lHZq+HSR14Rwog0uSECaZoaXQaCNq+Banu1TubhQhHxoBly1/OvkAHhvHMOJo1xmzP2N98+Qxb4k7u+9OLmRfYfTk/d03QNbulFJ4vUaV7lsrd9E/CcIrj02zF9nH5rbl/PlysZ2mHzOGPJgsl38cxZc+hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739315809; c=relaxed/simple;
	bh=3zTpwPVBu5FhsZX4yiDd5kXq166OpvaNogmElK6aTus=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ja4KmqyQGro7DhUzxizSEdtBgbeY96e+AUG54pGutGaB+QG+ppTdgunfZOhigc+vXQA9Uqay5Ud1EvYwBPu5o6hsgrHWm0XpvIpWOhNJSn8Ay6nnOXn0ZOb1kgacjbmSuUYC7D3Ngode17kaWlA2DDz2AT6MN+60Z1tZs0Pmcxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bttBPPcj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218A4C4CEE2;
	Tue, 11 Feb 2025 23:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739315808;
	bh=3zTpwPVBu5FhsZX4yiDd5kXq166OpvaNogmElK6aTus=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=bttBPPcjLAml4vtqknB3/v0wkFPPoVEK8XZ2S+iaArQyIcmJF8Ai/gxtHPWBlHF3G
	 /7ZI0j7SBZCnw4BO85GshXa2qKk0PRM0mIYpBXsM58GxjFQ3p61g/k1AqIuyXtdZ1w
	 flr6BOMRxeRTC8IjVyv45+6xPabbmlmqEsa8jJtZFXZuLmckds/S/wFbauFftMY9Vs
	 uzKGfSWphT53CgHR7Bn3D6yDJkbxlE1psObKa1cNbjLh4EW/Yfwba9BJLQR/lUPGUO
	 pHz5o5yVMm5YY/foY11CLPaxo19JesEZ9IJCAs3CC9vjBsOvlbP5c1x/G+Htn1Pr94
	 aIcSdF5qBOUwA==
Date: Tue, 11 Feb 2025 17:16:46 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	linux-pci@vger.kernel.org, kernel-janitors@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Michal Simek <michal.simek@amd.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [v8 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
Message-ID: <20250211231646.GA58828@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60c5504d-341f-4ce5-b337-1eca92a9506f@web.de>

On Fri, Feb 07, 2025 at 07:39:03AM +0100, Markus Elfring wrote:
> > I don't *really* like guard() anyway because it's kind of magic in
> > that the unlock doesn't actually appear in the code, and it's kind of
> > hard to unravel what guard() is and how it works.  But I guess that's
> > mostly because it's just a new idiom that takes time to internalize.
>
> How will the circumstances evolve further for growing applications of
> scope-based resource management?

I'm sure it will evolve to become the typical style.  Right now, it's
not quite there yet, as evidenced by the fact that the only reference
to them in Documentation/ is this somewhat ambivalent note:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/maintainer-netdev.rst?id=v6.13#n380

We do already have a few uses of guard() and scoped_guard() in
drivers/pci, and I don't really object to more, including in this
amd-mdb case.  Whatever we do, I *would* want to do it consistently
throughout the file.

Bjorn

