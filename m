Return-Path: <linux-pci+bounces-39568-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DA8C16661
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 19:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1BE40502A96
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 18:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3CE34C9A3;
	Tue, 28 Oct 2025 18:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oirpfSwO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1644734C820
	for <linux-pci@vger.kernel.org>; Tue, 28 Oct 2025 18:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761674830; cv=none; b=GK5Ohf+uB4wOHJKdSkQV3Sd18nqIc2ZKJtm8gT7Rpykdz9k9DPbXCTYEvYIDf8pEGJNqSnqx//BTvhmwYYEn5NxIUlCrEn1fr1f1LVi/CgvlccldWdNIjI0Ug5NP8C1wLzB0oZN88yyRKii+bpX6wVYV5CqfMHFol5MPRqifiGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761674830; c=relaxed/simple;
	bh=LXratEfiL3x32tGwxM5r839ooDNd9LrZ9tqLJoaqBXk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gy+lH3H3YH1zonF9ina5PlP1n2YiA2sa7GGWukBi5hMt+d+KfyZi5DvM1cP8YlJ8V3RVJTocfRGEXaTTDc4T/gEHpZ6IMYMYJZQPKRtA2Lu9xUljcvXfRlnEmtj78ecemyMKsKAoXy4+0G4hYRvI3viMmzv+5gm+x9I8Fjji7CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oirpfSwO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1146C4CEE7;
	Tue, 28 Oct 2025 18:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761674829;
	bh=LXratEfiL3x32tGwxM5r839ooDNd9LrZ9tqLJoaqBXk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=oirpfSwOXL91/2Li7VvidEox5vL6AANiq6lZnz7RVZKS7lCHiHLFyAaPixDW+aWYE
	 dOaevOU69Dm2ktveX0cKc1atjenWbyFea2niTP2atQK5oRLGyXzXsblp6XUcvlfBEt
	 5iaip01uXhyENgBJ1D41v6NQbxdBzKgZ/A9O2VNxqUAuIxfl1QPz/g7SB2Izl7+TEp
	 KLlawbhhSHrseoTsq+vKcUCyAgkadGHqNi3jZ72DU6TGrewLfzxtJlmJV58yKdqUbW
	 /sLcgb56beTPkRuDw97fKEt+WlfoNefstOEwMtcAcKdngnrY4aYlMM5WsyVGD18D9r
	 j84hdjEL5Pyqg==
Date: Tue, 28 Oct 2025 13:07:08 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Cyril Brulebois <kibi@debian.org>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v3 0/2] PCI: brcmstb: Add panic/die handler to driver
Message-ID: <20251028180708.GA1523449@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176094292821.11548.4875305934446802597.b4-ty@kernel.org>

[+cc Ilpo]

On Mon, Oct 20, 2025 at 12:18:48PM +0530, Manivannan Sadhasivam wrote:
> On Fri, 03 Oct 2025 15:56:05 -0400, Jim Quinlan wrote:
> > v3 Changes:
> >   -- Commit "Add a way to indicate if PCIe bridge is active"
> >     o Implement Bjorn's V1 suggestion properly (Bjorn, Mani)
> >     o Remove unrelated change in commit (Mani)
> >     o Remove an "inline" directive (Mani)
> >     o s/bridge_on/bridge_in_reset/ (Mani)
> >   -- Commit "Add panic/die handler to driver"
> >     o dev_err(...) message changed from "handling" error (Mani)
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/2] PCI: brcmstb: Add a way to indicate if PCIe bridge is active
>       commit: 7dfe1602f6dc96f228403b930dbe0a93717bc287
> [2/2] PCI: brcmstb: Add panic/die handler to driver
>       commit: 47288064f6a6ce99c3c1fd7b116011b970945273

I deferred these for now because there are some open questions that we
should resolve first:

  https://lore.kernel.org/r/20251020184832.GA1144646@bhelgaas
  https://lore.kernel.org/r/2b0f9620-a105-6e49-f9cb-4bac14e14ce2@linux.intel.com

