Return-Path: <linux-pci+bounces-30948-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 301FDAEBD6A
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 18:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 694F96A5E84
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 16:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E076D2EA482;
	Fri, 27 Jun 2025 16:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCOx8pfq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C5881720;
	Fri, 27 Jun 2025 16:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751041784; cv=none; b=AvQ78MCFDBZt/dWDE6W88P0PcTzh/kD3rhtKoX+0e9nZ3ZaX60v5giofAJlROgo3OhXWOaRljE4vlQf/D80qmzCYugnhmpdtjbg6sg2yB0A6nRbzapzd/8CfmNaOghqM8aOoOf824HhN02Jh6p4HCIWJwxlImXuouXk5jAc9y1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751041784; c=relaxed/simple;
	bh=zGKvNo/acvnr6nPN7Y6LvVuEW7FCaqjPXAJFWM3JHYE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mjgIe0bvQDqIsl4fZwFsGohZQn7QV4LQ6bluYFupqg5cPsPZVK7TCQRqSQFrGd4b11xk6L+TzcfgQTzWi/RANtk3zt2+x71eE1ecYxZSx1c3/TtzWfv+7668jTbGAKGWvUxFH35Kjmt8R2bmAJiPiKUn3xdnwWwr2T1VqC0olds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCOx8pfq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E870C4CEE3;
	Fri, 27 Jun 2025 16:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751041784;
	bh=zGKvNo/acvnr6nPN7Y6LvVuEW7FCaqjPXAJFWM3JHYE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VCOx8pfqLEBsRP84PkmQ7ME8WzQwuJ14UPKXVs03rIDyqqzmdYRWD2tC5c0WWUoJH
	 tcmwzY9NtBtXGEOrix6+x3ZzPkjx4EszreKqaFyKrBcqakmcJMV5a10ECJG8HUFT5j
	 rFYqwFHfV+qMZbhcfFz45LTUgND4uaC4l3tYjEZ+ZgOCqwnrguARfZUS5nKSg42F3M
	 XIfUebBDXZz5nbGNVtzxE+9KGOlkBl2idjn9ttMnnMwMzPCNYBU/qMZec4M2TY8qSc
	 yEY12JJ+C9snuifaU2uy0ia6yfFHVSFiJI6jKF5Fwbuc+jqx13GeuGYuX8DV1G6ldE
	 uDg3dxdJWSh4A==
Date: Fri, 27 Jun 2025 11:29:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-fsd@tesla.com,
	manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	jingoohan1@gmail.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	alim.akhtar@samsung.com, vkoul@kernel.org, kishon@kernel.org,
	arnd@arndb.de, m.szyprowski@samsung.com, jh80.chung@samsung.com,
	pankaj.dubey@samsung.com
Subject: Re: [PATCH v2 06/10] dt-bindings: PCI: Add bindings support for
 Tesla FSD SoC
Message-ID: <20250627162943.GA1672296@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625165229.3458-7-shradha.t@samsung.com>

On Wed, Jun 25, 2025 at 10:22:25PM +0530, Shradha Todi wrote:
> Document the PCIe controller device tree bindings for Tesla FSD
> SoC for both RC and EP.

> +++ b/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml

> -  clocks:
> -    items:
> -      - description: PCIe bridge clock
> -      - description: PCIe bus clock

> -  vdd10-supply:
> -    description:
> -      Phandle to a regulator that provides 1.0V power to the PCIe block.
> -
> -  vdd18-supply:
> -    description:
> -      Phandle to a regulator that provides 1.8V power to the PCIe block.

> +            - description: pcie bridge clock
> +            - description: pcie bus clock

Gratuitous "PCIe" capitalization changes here and in supplies below.
This is just plain English text so we can use English conventions.

> +        vdd10-supply:
> +          description:
> +            phandle to a regulator that provides 1.0v power to the pcie block.
> +
> +        vdd18-supply:
> +          description:
> +            phandle to a regulator that provides 1.8v power to the pcie block.

I *would* be OK if you dropped the periods at the end of these, which
would make them match the other descriptions in this binding.

> +++ b/Documentation/devicetree/bindings/pci/tesla,fsd-pcie-ep.yaml

I'm not sure about the "tesla,fsd-pcie-ep.yaml" filename.  I see that
it currently only describes a tesla endpoint, but it seems like maybe
this should be parallel to the "samsung,exynos-pcie.yaml" host
controller binding.

Bjorn

