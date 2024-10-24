Return-Path: <linux-pci+bounces-15233-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 603669AEFCC
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 20:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 790731C221CC
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 18:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D86E1FAF08;
	Thu, 24 Oct 2024 18:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVgkk0Yn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1349482EF;
	Thu, 24 Oct 2024 18:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729795611; cv=none; b=HzoLWdzJQxyMAA3FAqzgyRmglf+4NAJh1a7cZxW5siM8qQf95bmOiu9gzvvCH9jNr2IzIG/ku+nv8hdiDf7l8g0c47/ZFkgSTlufbeJp8s/lO4uvw2sROXbsE6mMb0SvDeqHKg7ChI9xy9cZo4HxRalukiV/UPvGNSoZv7v62oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729795611; c=relaxed/simple;
	bh=5FVyEGboaM4rj+GScXdt9qEVYfTNOXNL6tZ7z4VeYFo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qPAcR+bxmJH9dSxnG45S8Zlh9UGG1I7gdfkwdPEy/36EuLuBOxnfmsyHFqE58eFQpQ/naGEGJftjbfKo+Y8jb0WowHuRf9ibxbDnxNg5qdNFsDIHkZa+rTdUYwtn1RfRMRtV1XTOg8FaPEdDRW0T+ChSaqiX4s1mMG84a2pZ3WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVgkk0Yn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6897C4CEC7;
	Thu, 24 Oct 2024 18:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729795611;
	bh=5FVyEGboaM4rj+GScXdt9qEVYfTNOXNL6tZ7z4VeYFo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=UVgkk0YnFNtvfXKZbtHA23X2t0DzDyhu17nPkgpQtV/XewjU9cZpGGRGY29oopDx2
	 jeQ+6pQ+4u/zDsdh7qT2DeFqTOYRwLbzccirvWp0KwT1QLmYLRtHgd0fkVWeblVExC
	 ptAvZ4ntayRZsIdrF24TyQxb9+XtMfvzNOpWwnI0ou2hC+jnNpwzXIa2FyRD2AU8I3
	 WVGSw0VmdPkxxPXwZXl3Ut9E/L35tPM8GmiHUddw6oZKtxdXl6uM9yzBSfgHg5ru3j
	 C7j8ulGmYRuieHdCXHxQMCvBmwA8QSMvawhxjk3jH6Cx4CQIqbgbf+jigVf8XVaEla
	 CwbcKlzONrSOA==
Date: Thu, 24 Oct 2024 13:46:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: linux-pci@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 0/2] PCI: microchip: support using either instance 1
 or 2
Message-ID: <20241024184649.GA967731@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024-gout-kinfolk-0f24b28d41b7@spud>

On Thu, Oct 24, 2024 at 10:38:11AM +0100, Conor Dooley wrote:
> On Wed, Aug 14, 2024 at 09:08:40AM +0100, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> > 
> > The current driver and binding for PolarFire SoC's PCI controller assume
> > that the root port instance in use is instance 1. The second reg
> > property constitutes the region encompassing both "control" and "bridge"
> > registers for both instances. In the driver, a fixed offset is applied to
> > find the base addresses for instance 1's "control" and "bridge"
> > registers. The BeagleV Fire uses root port instance 2, so something must
> > be done so that software can differentiate. This series splits the
> > second reg property in two, with dedicated "control" and "bridge"
> > entries so that either instance can be used.
> 
> Just attempting to bump this patchset. It has gone over 2 months without
> response, and I am afraid it has completely fallen between the cracks.

Thanks for bumping this.  It looks pretty straightforward to me, so if
nobody acts on it soon, I'll pick it up.

Bjorn

