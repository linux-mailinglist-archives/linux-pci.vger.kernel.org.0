Return-Path: <linux-pci+bounces-40438-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DE895C386DE
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 01:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A9FAF4E4C87
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 00:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AB418D65C;
	Thu,  6 Nov 2025 00:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxzfXxvY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B0B28E5;
	Thu,  6 Nov 2025 00:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762387255; cv=none; b=tslizQsCG+fg+gRZVOEm3lWetuqOaSTWUj/ByViW5Wu7P2IuzPT6d2lGXD3544SrNM4wu3sP57z5UnWHATqkpkKYv2QqeR/gKboLufKRBCgC+ezVbGDCmqWA35Sq7KOX/t45ABTPRyKP0oKlNTfVzureqPaQkM2Nov5gVm027QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762387255; c=relaxed/simple;
	bh=5IK5qZfBjMO/Z5358IGhBKuigXyQuAzqcpc4dXrDunc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rL+kgMfQmf7fWSOmKv3cuDvAJ3i/2DFw1w5k5j8QslRBuUGkEPk/hBcz59HTrL7ucc+WrBz4cluH6T3BxiHS9tZ4wmCg4x2k/UBJrf8FEvHSXMsVx4A5Zs5Bxaelq9u1YLwkg4TfNtpGo29tbj1ijNZOJVNu8ON/DEpwEwdW+sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxzfXxvY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E245C4CEFB;
	Thu,  6 Nov 2025 00:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762387254;
	bh=5IK5qZfBjMO/Z5358IGhBKuigXyQuAzqcpc4dXrDunc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YxzfXxvYcR3RlTH0HKRVAzhkpjaPTcY/o1R3VVPf0UDf9p98OQn6a8kwF2rBRUg/Z
	 HDFXzEPvIQuJGaVqj5zZTOsjyoaMkE4Rbw4EbNNXBjD4BpATBd/1kEVBd2HWlNXfmt
	 550GLlqGovaCwYjgyHDcJE/P9Y/tTxnkaERkmJC0QStvxFv5jt32c886hIvOHSg24e
	 J1BpC/EMdz0I1adY1GhrxAjp3KbGRgWy0GukHujC4+/tlXgPedslb2LZY5sHSGpbiM
	 z7jDzyZ1Kp6BkWE4LdzL3eH9Kcp8o5n+nSQ8VYHUUcBjbdk54ZX5Y0rmKQOphcqb71
	 nLB0vd/F7h05A==
Date: Wed, 5 Nov 2025 18:00:53 -0600
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
Subject: Re: [PATCH 1/4 v3] dt-bindings: PCI: s32g: Add NXP PCIe controller
Message-ID: <20251106000053.GA1932421@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022174309.1180931-2-vincent.guittot@linaro.org>

On Wed, Oct 22, 2025 at 07:43:06PM +0200, Vincent Guittot wrote:
> Describe the PCIe host controller available on the S32G platforms.

> +            reg = <0x00 0x40400000 0x0 0x00001000>,   /* dbi registers */
> +                  <0x00 0x40420000 0x0 0x00001000>,   /* dbi2 registers */
> +                  <0x00 0x40460000 0x0 0x00001000>,   /* atu registers */
> +                  <0x00 0x40470000 0x0 0x00001000>,   /* dma registers */
> +                  <0x00 0x40481000 0x0 0x000000f8>,   /* ctrl registers */
> +                  <0x5f 0xffffe000 0x0 0x00002000>;  /* config space */

Fix comment alignment.

