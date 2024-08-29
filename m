Return-Path: <linux-pci+bounces-12456-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D26964C1E
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 18:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 798D21C23570
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 16:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C36B1B583E;
	Thu, 29 Aug 2024 16:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2KPzdKV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606351B5823;
	Thu, 29 Aug 2024 16:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724950410; cv=none; b=XKGJ8wGFIQ4SS6FgyC2ls3laiB7UxfzDQRE22pAtuJvPyWPuDkw0GfgzwQlNerJ7b9co3wNum7ll+F1bfMzNHm/YMZcH82aPRo4D0PZbzRzK4sQSWoESLl6oA4tcBsivQbabuLrK2PZI4oZboJg8w4+botdYSBXYPlIThknfT8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724950410; c=relaxed/simple;
	bh=7lGLL0XhrxlPC1QZEvRqoSTWUVqnsrXOpUkvm7E/9d4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IdGjtzu5U1xQzCXPQ5wtv6IqOP+/Tv71TQwGaZY8DYHRsY3oYZpcjpDbpjZ+Ujb++oo0xIdVVIZUHkdnEdkNgylIwl+4e1onnpMYBjFHz4ISpoteFDAd9mmHezu7LWVhrWHdKUB7pZlKCJvBeGRt2nbPHQEqOY8lqVshVAwF9z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2KPzdKV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02BEC4CEC1;
	Thu, 29 Aug 2024 16:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724950410;
	bh=7lGLL0XhrxlPC1QZEvRqoSTWUVqnsrXOpUkvm7E/9d4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=P2KPzdKVTqEVMDVIYblA2mTa0t+ZjXsZQy30AWbBeaFdZ8aK21f12ysTr3hIWwd5R
	 4LUmkxL+zEeeGtSHvEtwHIQwyaoWrAoIk0kqN/1qHSR0u5/VnMgtrd6+0plwCh40A5
	 n23ApadZodBHpnro8Qh7i880GGyhHBJnK70Hov1Rt8lCnGmZUKj2jhldiRbjTlXaDj
	 SpSfi2lnsSXebJtxpDtuUlmwWCrysYblN0zzl0sgrDfGP4wVBrlAZC/Dvj0+aQfiy3
	 Kv6mMYGyGKDp5uuWxPly266+GXcp2eqGrHMvooFHIj/iogs1FqxkSewWprUVg8YJHL
	 4GRIKqVAjMmPw==
Date: Thu, 29 Aug 2024 11:53:22 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, vigneshr@ti.com,
	kishon@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH v4 2/2] PCI: j721e: Enable ACSPCIE Refclk if
 "ti,syscon-acspcie-proxy-ctrl" exists
Message-ID: <20240829165322.GA66640@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829105316.1483684-3-s-vadapalli@ti.com>

On Thu, Aug 29, 2024 at 04:23:16PM +0530, Siddharth Vadapalli wrote:
> The ACSPCIE module is capable of driving the reference clock required by
> the PCIe Endpoint device. It is an alternative to on-board and external
> reference clock generators. Enabling the output from the ACSPCIE module's
> PAD IO Buffers requires clearing the "PAD IO disable" bits of the
> ACSPCIE_PROXY_CTRL register in the CTRL_MMR register space.
> 
> Add support to enable the ACSPCIE reference clock output using the optional
> device-tree property "ti,syscon-acspcie-proxy-ctrl".
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Looks good to me, thanks!

> v3:
> https://lore.kernel.org/r/20240827055548.901285-3-s-vadapalli@ti.com/
> Changes since v3:
> - Rebased patch on next-20240829.

Doesn't hurt to do it, but no need to rebase for PCI patches.  We
apply everything to -rc1 anyway.

