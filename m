Return-Path: <linux-pci+bounces-31196-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E53F6AF018D
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 19:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D02B4A1792
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 17:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C3A27E071;
	Tue,  1 Jul 2025 17:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+7aGu9g"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9624027978C;
	Tue,  1 Jul 2025 17:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751390206; cv=none; b=P6SGfrNw8qbfOOhQ5s4uVzHSJdpNWo4sqdZ5C9pxTDSRBqIrGsITWxzg7FFqh9r7wwxgzOFK5iDGHk8SuigqzoKz/lDHL2lYiB/Mjvf0Yw6bTfcZI626ZCRA1O9YVelWJS6Dept5fO7lkbCGRV6HEUuy4yDYe5NRFfRl9VZyS7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751390206; c=relaxed/simple;
	bh=IHpoblBzuvpr+bD38aHPPj2yibJOlQN5z3Zq9NJFVjw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Vl7mI72TsT6BYGOIIBEPInlLxpVX+BZ2+9Uxbb57s4+KDWFL5zXxFcNSQ5uuFwWV7fjccLI9aUdUjDSzs5YozqgJagC94J4DkkvQdRbKae6XLEhwKl7XJbf1AqohKqTs63X/zKveRdrTcEthWodUd4/VsVR4OC3qqegRYGNFUDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+7aGu9g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B0BC4CEEB;
	Tue,  1 Jul 2025 17:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751390206;
	bh=IHpoblBzuvpr+bD38aHPPj2yibJOlQN5z3Zq9NJFVjw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=R+7aGu9gGq1zndHEsz0rJcIVhpQTD5rgNkasa2YilgAe4wwaMjiKujUoB0kF5k6uH
	 SNweTnElvr0PTCLs3uObcEfiPJsP7l9DKaNUF0+/m9pkCZ8hTKeEFST3A9GL0cLK/h
	 Gq7XfGmJGwj+MMzr0Z8oPYDhwyn0zFAqChFKUIsz0FxR+vd4YB5G0WceGNuYs+lmRb
	 tBr9M+RziKoYiayXRcNIyx97ZbuzBgz6ULScHWmhVSEJh9zVlnJInmO3Cy5QHAQjxr
	 G1C68U3c/AvPcV3W0D2QsKOYHB5UuVGOBqnH3fLx+XM/jBzu3HHBUzcXun0wo8OAq1
	 5dlyOmRNwjuwg==
Date: Tue, 1 Jul 2025 12:16:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-fsd@tesla.com, mani@kernel.org,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, jingoohan1@gmail.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, alim.akhtar@samsung.com, vkoul@kernel.org,
	kishon@kernel.org, arnd@arndb.de, m.szyprowski@samsung.com,
	jh80.chung@samsung.com, pankaj.dubey@samsung.com
Subject: Re: [PATCH v2 06/10] dt-bindings: PCI: Add bindings support for
 Tesla FSD SoC
Message-ID: <20250701171644.GA1839997@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02b201dbea7b$fbaf5390$f30dfab0$@samsung.com>

On Tue, Jul 01, 2025 at 05:03:31PM +0530, Shradha Todi wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: 27 June 2025 22:00

> > On Wed, Jun 25, 2025 at 10:22:25PM +0530, Shradha Todi wrote:
> > > Document the PCIe controller device tree bindings for Tesla FSD
> > > SoC for both RC and EP.

> > > +++ b/Documentation/devicetree/bindings/pci/tesla,fsd-pcie-ep.yaml
> > 
> > I'm not sure about the "tesla,fsd-pcie-ep.yaml" filename.  I see that
> > it currently only describes a tesla endpoint, but it seems like maybe
> > this should be parallel to the "samsung,exynos-pcie.yaml" host
> > controller binding.
> 
> Actually there is no support for Exynos5433 in EP mode. Initially I
> named the binding file "samsung,exynos-pcie-ep.yaml" to make it
> parallel to the host controller bindings. But I received a comment
> that file names should match the compatible strings which makes
> sense so I changed it to this.

Certainly makes sense to match the compatible strings, although
samsung,exynos-pcie.yaml now includes both:

  samsung,exynos5433-pcie
  tesla,fsd-pcie

Exynos5433 may not support EP mode, but I assume the underlying IP for
the Tesla FSD in EP mode is still Samsung, and I assume some Exynos
device may someday support EP mode.

But I see Krzysztof's suggestion that the filename match compatible
and also Rob's observation that there's not much shared between
samsung,exynos5433-pcie and tesla,fsd-pcie.

Maybe that means both the RC and EP bindings should be named
"tesla,fsd..."  It seems a little weird that the same hardware would
be named described by either "samsung-exynos" or "tesla,fsd" just
depending on a mode switch.

Bjorn

