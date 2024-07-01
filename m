Return-Path: <linux-pci+bounces-9533-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEA791E981
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 22:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2576E1F22678
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 20:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C34616F265;
	Mon,  1 Jul 2024 20:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ji6vGm9X"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DA216D9C9;
	Mon,  1 Jul 2024 20:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719865319; cv=none; b=nP5oI7yxejiWJp7ZwgZi3YpDl9lapXeFXAcanrpTXPkuvubja7m7YcpqUPWuVaUxITqyPPOLwWwIIsgsKtRX7dw/6+Qzn2C7gQiQclzyNEWsFMDgkrVE3f5XCJ2N1d+SS273PH/D02/nuFnrqqvsNn4EYEH5TUmklfEVUnArdfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719865319; c=relaxed/simple;
	bh=pCuFXbF5W+x+VbGJfQJ3DgTrZxGZJSFeamHAW781fVg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QY+YCsMTe/crCj2nVoYBtaWstRixLgiG1zNYDeNTRwnQV3rJfNPxBrX7buLpkw1xcr6YN3QdBNeT/g79Huq7sNROepNEI+xV90Gorq8sKj/60Q/i+iu+ZX/HMUZ6ohHoxtNSg7IBFH9s46xgl8pHiVhp/d7crsf9ZQnR1srcybo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ji6vGm9X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B37C116B1;
	Mon,  1 Jul 2024 20:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719865319;
	bh=pCuFXbF5W+x+VbGJfQJ3DgTrZxGZJSFeamHAW781fVg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ji6vGm9XokU6rGwJfWNicX/kd1H8X+tuZXzdCteLvSAi/yec6vI6pJeC7pzUtZZqH
	 UndP7YHWcwvMvyo2wc8txQ0L4cjZmighNMwzhGkjr2RmoOGKusJR+S3P7w6awGgaoK
	 usxoQmRBEgsL5OS77aKeCpg0X40F+bmfBwmijvJ8WcWuI8Yo4K7/iV8zAguJlWBGub
	 l9LN2buBKtasPMIrV4tdqH230ZnYA2HA1tr2PuhBcxQK31mgD67GPS6pzX552Scfcy
	 I4zppGDlG5Z62Rm+MaIJoMpZRV1mqUVSrqM2Bnwweb707FikGRuPSS280yK1lAa/Sm
	 YETdLqoc9P1pQ==
Date: Mon, 1 Jul 2024 15:21:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-pci@vger.kernel.org, ryder.lee@mediatek.com,
	jianjun.wang@mediatek.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com,
	linux-mediatek@lists.infradead.org, lorenzo.bianconi83@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
	nbd@nbd.name, dd@embedd.com, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com
Subject: Re: [PATCH v3 4/4] PCI: mediatek-gen3: Add Airoha EN7581 support
Message-ID: <20240701202156.GA15356@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27d28fabbf761e7a38bc6c8371234bf6a6462473.1719668763.git.lorenzo@kernel.org>

On Sat, Jun 29, 2024 at 03:51:54PM +0200, Lorenzo Bianconi wrote:
> Introduce support for Airoha EN7581 PCIe controller to mediatek-gen3
> PCIe controller driver.

> +/* PCIe reset line delay in ms */
> +#define PCIE_RESET_TIME_MS		100

Is this something required by the PCIe base spec, or is it specific to
EN7581?  Either way it would be nice to have a citation to the spec
(revision and section number).  If it's generic to PCIe, it should be
in drivers/pci/pci.h so other drivers can use the same thing.

