Return-Path: <linux-pci+bounces-40526-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B019C3CCCF
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 18:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F31091897463
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 17:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1409734E762;
	Thu,  6 Nov 2025 17:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DgBHopWb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BA52C0F96;
	Thu,  6 Nov 2025 17:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762449794; cv=none; b=iEfRlW4pTQA5+I30xaUjjQ2mJHnyrf3kNi5w+OFCIVymXoFlpiEawVHYPczUau2/y7J7yo9P9ugly60+9OM4lr4znQugx35Du1KZQsUETeS+18+EDMHFnHoxPaVYLEvtrfYQIHvyY/2I1BMawOhtWeMWQ0qa7TE9nyNWegp3Vrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762449794; c=relaxed/simple;
	bh=Gw5TYH30f99oo5GV+N2fvATCCzkEDos8mvZjTzd6Z1o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Q0SrsTeoKCKDRmf+Cpko7nPzBEY+4J5/WoKt1ETKR7DbYxrMK00WkmcNYbVM9mFipCWKhHD5I6mMz+1CK2i8GpZY90Ypr4NiFsnOnTwD/ayqT/rZYVomHYC2BShaaQQEpFF+Af7vN3yw0isVkhVyqpyCjNPLJ1R+yXkLzuUGjFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DgBHopWb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A333C19421;
	Thu,  6 Nov 2025 17:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762449793;
	bh=Gw5TYH30f99oo5GV+N2fvATCCzkEDos8mvZjTzd6Z1o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=DgBHopWbQvz5DFxCGmbgRetww5Af5HfRE44GSZZSbnwqAYR9vOj11uB+6AwWJXMeG
	 pySaPgAmNDjwgKVDaDHOG8AxZ2At0nLbP/aD7jTCOSjwjAwat/fMCvmfhDbYewfmjF
	 CYHeCJZasSERVwFyaClXKVeuuEQkYtvtrEgA4sUYDegmdJIVjFKXPgmGlCsmwk3Efh
	 ke32e3NnzgTNhwqDbwgQoasz4m331sLSlOZaXQRFuDyNum99nwBoaZaCcOIcWMLUuW
	 aTUKcd2MYaedHPbu3+M2tAOvOln/iQlp00SDs+zm+K94uG8PSgjSoySDjG+mfo0IjD
	 ypY8P5nb9rewA==
Date: Thu, 6 Nov 2025 11:23:12 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: chester62515@gmail.com, mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com, s32@nxp.com, bhelgaas@google.com,
	jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com,
	Ghennadi.Procopciuc@nxp.com, ciprianmarian.costea@nxp.com,
	bogdan.hamciuc@nxp.com, Frank.li@nxp.com,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, cassel@kernel.org
Subject: Re: [PATCH 3/4 v3] PCI: s32g: Add initial PCIe support (RC)
Message-ID: <20251106172312.GA1931285@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022174309.1180931-4-vincent.guittot@linaro.org>

On Wed, Oct 22, 2025 at 07:43:08PM +0200, Vincent Guittot wrote:
> Add initial support of the PCIe controller for S32G Soc family. Only
> host mode is supported.

> +config PCIE_NXP_S32G
> +	tristate "NXP S32G PCIe controller (host mode)"
> +	depends on ARCH_S32 || COMPILE_TEST
> +	select PCIE_DW_HOST
> +	help
> +	  Enable support for the PCIe controller in NXP S32G based boards to
> +	  work in Host mode. The controller is based on DesignWare IP and
> +	  can work either as RC or EP. In order to enable host-specific
> +	  features PCIE_S32G must be selected.

Did you mean PCIE_NXP_S32G here?

PCIE_S32G itself doesn't appear in this series.

