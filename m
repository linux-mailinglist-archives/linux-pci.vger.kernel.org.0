Return-Path: <linux-pci+bounces-21225-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6EFA316B2
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 21:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9F003A6ECA
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 20:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D857262D3E;
	Tue, 11 Feb 2025 20:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTdX6qiu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DE0265626;
	Tue, 11 Feb 2025 20:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739306006; cv=none; b=XjUarAgWLuEHH5E3NSjmty+ZqpaMnQsH+1ew0ccMFvpmcY2duv+RVrEPH/HZjEigxlaTMFlykILWDGbCY/cSR40Fstt5j32p0zPnI+xrw8gquujiDRma6hcSslmATh2LClFpt8G7lXmfUUBHmV7Z+2kMtDufHDiz5d5890pFqVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739306006; c=relaxed/simple;
	bh=m6uW5LI+RTAP6gZ7LY7Y5BSyq7TILP8ZnWmH47ViD2g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Mx60pV2h1saoDuigKbhDj4yr0MzUZaZt71OM8DHDyLA74bHQGXpaNQj9MLCHP3o2qxLPe72fhW7HVThRXJ8+lpRsr3NNNtDol1gFCt1d+egiyrDU92ras1I6SqgI3ewpH2TzxWz61l6BFFdjOyH+n1fWhE84aMb+LCEiE9fGZnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTdX6qiu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87328C4CEDD;
	Tue, 11 Feb 2025 20:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739306005;
	bh=m6uW5LI+RTAP6gZ7LY7Y5BSyq7TILP8ZnWmH47ViD2g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YTdX6qiu5L9Qs3vdGhuZHTeLKJ+uNTRPgU7exdn7QBMmY3Qpg5Pj1ddbM9Yc2QIRJ
	 PwbclK47wvCBblffZ5zBpGhqUUioRkitHcw6goGkSoaw0sz/H9VZcARqQns8tp4KT/
	 CCGIfMqiWN4KcwxADPpWeq9mi0/qXZx+KzkMIH/dspacbbgiKf7GurrDfexv6J73ol
	 VOVyqq/3Z4R/lOzgm/YVjAGq7S2tjEPZ10GrQniJ6CW8y0y0eW7DSzHfgyQmZUanyy
	 QQUiqgz6FkHptDJ8xe72SvxEWaJml+MotLbMRYLEtMre02yjeoKjmwd/7LrorrRflZ
	 Bdy5xqiS4MTrg==
Date: Tue, 11 Feb 2025 14:33:24 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Kettenis <kettenis@openbsd.org>, Marc Zyngier <maz@kernel.org>,
	Stan Skowronek <stan@corellium.com>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Janne Grunau <j@jannau.net>, stable@vger.kernel.org
Subject: Re: [PATCH 3/7] PCI: apple: Set only available ports up
Message-ID: <20250211203324.GA54082@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211-pcie-t6-v1-3-b60e6d2501bb@rosenzweig.io>

On Tue, Feb 11, 2025 at 02:54:28PM -0500, Alyssa Rosenzweig wrote:
> From: Janne Grunau <j@jannau.net>
> 
> Fixes "interrupt-map" parsing in of_irq_parse_raw() which takes the
> node's availability into account.
> 
> This became apparent after disabling unused PCIe ports in the Apple
> silicon device trees instead of disabling them.

Is there something missing from this sentence?  "... after disabling
unused ports instead of disabling them" doesn't sound quite complete.

> Link: https://lore.kernel.org/asahi/20230214-apple_dts_pcie_disable_unused-v1-0-5ea0d3ddcde3@jannau.net/
> Link: https://lore.kernel.org/asahi/1ea2107a-bb86-8c22-0bbc-82c453ab08ce@linaro.org/
> Fixes: 1e33888fbe44 ("PCI: apple: Add initial hardware bring-up")
> Cc: stable@vger.kernel.org

Can we have a hint about what makes this "stable" material?  I can't
tell from the commit log what the impact of this change is.

Bjorn

