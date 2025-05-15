Return-Path: <linux-pci+bounces-27805-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4A1AB88C6
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 16:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE1CF1888C0E
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 14:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0EE72623;
	Thu, 15 May 2025 14:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nz70mEL9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED7842C0B;
	Thu, 15 May 2025 14:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747317637; cv=none; b=Nw5CEr+t+xTM7QKjTda5S1pIaRxS1IsWO5P3L7Y4JEJsgtVoekNz60gDjTrmqx6bf7q1Ldlvv7U/fyrVI4YVg9P26sT72wu2mq60i6AeF4jWYWh/8j++HhXv/VUsuxQP/eH6kWvfLjQTqxon2Vc5iablCJGFaBgToeBXEVBwcM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747317637; c=relaxed/simple;
	bh=9cVRHoRN/FrnNoWySk3piyOU4+OkMbJBJ5DrHky7+/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hghY9A3SQUO2aPsWuTuHwNj/Q4sC5kzZKTfiFUG8f++Omo55KrN3t4Bd8tPJgthkLpkNLBJ/Mm8xltQk1TXVgymsrgGTXefeykdDf1N5yhP286M2JhunhuQg1x7nCvYvCEIxFDtWu3bHbNXKuQBsFNYJivQErgu5glYA2Ug4zmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nz70mEL9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6154EC4CEE7;
	Thu, 15 May 2025 14:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747317636;
	bh=9cVRHoRN/FrnNoWySk3piyOU4+OkMbJBJ5DrHky7+/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nz70mEL9PtihqeV0OBw+bFKdG3eWXIZyGg04I4PiroVKRuVt+L1oveS6bP92kG0bv
	 9UxedZRKQC4VssCMieZG6wma1kDOsmF0PEnwYTzRdYJZ820ZThPc96Z47aDbouIsXX
	 geQq5kYXCKunMxzSn7XlsuGXJDXM85oOgdLfpmgHtrghFmDBfuxjS84sWEYpCxl+5M
	 w4WRGAf8BAxwQxMeALPOgTGATjyUxlLr69C4JpvMBufc9rZgV3AZTTISNb9LsF+0Gf
	 gfXlm1cQVFpT45bXevdjDFw7eA2LDA5UGGGtMK1htHLHtzRq539AzJsoDgbR8srIdz
	 GL/QDYc29Ze4w==
Date: Thu, 15 May 2025 23:00:34 +0900
From: Krzysztof Wilczy??ski <kwilczynski@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, linux-pci@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] PCI/bwctrl: Remove also pcie_bwctrl_lbms_rwsem
Message-ID: <20250515140034.GC3596832@rocinante>
References: <20250508090036.1528-1-ilpo.jarvinen@linux.intel.com>
 <174724335628.23991.985637450230528945.b4-ty@kernel.org>
 <aCTyFtJJcgorjzDv@wunner.de>
 <20250515084346.GA51912@rocinante>
 <aCXZdfOA8bme-qra@wunner.de>
 <98fa31e7-db86-35f0-a71c-a1ebf27f93f0@linux.intel.com>
 <aCXe_SMq6vsAIAin@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCXe_SMq6vsAIAin@wunner.de>

Hello,

> > I'm a bit hesitant to mark "Accepted" state though, I did it this time 
> > but in general I feel I might be overstepping my authority even if I know 
> > some patches have been accepted.
> 
> Bjorn has encouraged submitters to mark their own patches as "Superseded":
> 
>    "If you're really gung-ho, you can go to Patchwork [2] and mark
>     your superseded patches as "Superseded" so I don't have to do that
>     myself."
> 
>     https://lore.kernel.org/r/20171026223701.GA25649@bhelgaas-glaptop.roam.corp.google.com/
> 
> ... and I was assuming that also applies to marking one's own patches
> as "Accepted", but I might be jumping to the wrong conclusion.

Between Bjorn, Lorenzo, Mani and I, we are getting better as leveraging
Patchwork for a little bit of tracking and "project management", so to
speak.

But, any help with the housekeeping always appreciated. :)

Thank you!

	Krzysztof

