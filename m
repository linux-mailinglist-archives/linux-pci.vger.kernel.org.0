Return-Path: <linux-pci+bounces-20660-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC2FA25F31
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2025 16:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A32F218835D5
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2025 15:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35338209F4C;
	Mon,  3 Feb 2025 15:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSPnAqZP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2A6209F45;
	Mon,  3 Feb 2025 15:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738597709; cv=none; b=cqhZ0X+ktx65uvfS+2djJb/kN9+a4qfvRDhtFjXqK7tDpobQptr0kVgNAsCLO+V0GKz1wgZeZ+etgYhOCnyi8Byptd0F+3JA9woZqwfoumJJdY4pZZQ/+Wbb+WNrngliZqsdyQnU4LArpa/cm3PEgvEN55ELGunFSVBnC3d56OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738597709; c=relaxed/simple;
	bh=1OgMuxc7gKEROef+ogVknMkjRlEH06LnKp3/YyHOBbY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=f/xDVVzrAVDytGYe831qctmioGf5G9lNaV0Byvzalxc52/VH8ggX30Xq6qsuE97LebrkVY134pY5QsMwCveXZtMO7f/HK5EhaoRxK33gyECE/kwBwW1gYQ40hqWdbHE9n3glq796+mDdOluWDMPDU41IKoo4h0a8eeeOR4Je0Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSPnAqZP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37FF4C4CED2;
	Mon,  3 Feb 2025 15:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738597708;
	bh=1OgMuxc7gKEROef+ogVknMkjRlEH06LnKp3/YyHOBbY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=lSPnAqZPYQLW4YqHUW4PmEsx4qGHGoUCu+FIjzjA/Gpsb0g2HDaOaznfbJqwVk7Mm
	 +ROdVtzW0/mCSwfeAXKcv3PntTouCICb3vVLy0icNKM7qFygNZepTa1IvKZ9l/A9Q2
	 wWEa1SINZ2O8Bl/co7cOldV7ecNISWNHC4ICy6gO//pdX6IOYVuorGsuQcEU6IHLS5
	 D6LnETfpLuCbtlw1QjnpCkRIKxiAXXxGlN/SCePE6lgmXNkwV3WRcDDM8N7oOdnWkB
	 h9BEJHAgj2LCqVFLU9g9qlrnKOZM2i3WOD51qU4lVonJJO/pLRPEFrvpmDaql895ro
	 Oxb37GZTJcDkg==
Date: Mon, 3 Feb 2025 09:48:26 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manikandan Karunakaran Pillai <mpillai@cadence.com>
Cc: "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pci: cdns : Function to read controller architecture
Message-ID: <20250203154826.GA785589@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PPF4D26F8E1C25BF05614F8C8293EECDA2F52@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>

On Mon, Feb 03, 2025 at 02:04:17PM +0000, Manikandan Karunakaran Pillai wrote:
> Would like to change the design to get the architecture value from
> dts, using a bool hpa And store this value in the is_hpa field in
> the struct as given.
> 
> There would be support for legacy and High performance architecture
> in different files And the difference would be basically the
> registers they write and the offsets of these registers. The
> function names would almost be similar with the tag hpa, embedded in
> the function name. 
> 
> Would this be an acceptable design for support of these new PCIe
> cadence controllers ? 

Look around at other drivers that handle similar issues and use a
similar solution.  drivers/pci/controller/dwc/pcie-qcom.c is one
example, but most drivers support variants with minor differences.

Usual Linux email style is for responses to include only relevant
parts with replies interleaved:
https://people.kernel.org/tglx/notes-about-netiquette

Bjorn

