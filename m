Return-Path: <linux-pci+bounces-39503-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F28C13613
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 08:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A76961A22798
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 07:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3088F248898;
	Tue, 28 Oct 2025 07:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJ9GAhwG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EBD86337;
	Tue, 28 Oct 2025 07:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761637986; cv=none; b=mfG/8hNMoCVLPANtaD9/zYxotu/JKzKLJ8ZEXIFm1RR1aFHk9Cf1AFGEhISxVd7BjSaCHxgt0z0YU4ZKZwRyk4ywZAaiF+DVZmw0ffLYnPMUNG9V/iCy3Pc7oCjtWzKQEE+gZqMbAjdrBT8IX3N1KLVF+tI+Z6uQ902j1rUJPNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761637986; c=relaxed/simple;
	bh=yCeW08scrr2ACBo1vbxVy1YcULpnUDlueJqIMQ2qt7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jajI0eYEtX5KSKgj6ZP1GiJmvsR3cPUkLEj5bQplLsjYkULLgfraAgyh+T5YcEtlmhBXtuBQKDmAYddtMe1fG3LvaFaAUQVLQHQOp6GMxpFHtx+jh3f+OS6ImPgRliUGj/24UA71797kSgsHcs+L7neA5/xSEViuEkaJEmZC/kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJ9GAhwG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEAB9C113D0;
	Tue, 28 Oct 2025 07:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761637984;
	bh=yCeW08scrr2ACBo1vbxVy1YcULpnUDlueJqIMQ2qt7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KJ9GAhwGQiUOpcjuOp1NuWsZ3BZtwb4Eri9cttZxeRuZUm14FV9fzvpPkqAD/YJ4R
	 2YsxmfjFSooPJ8j/dKdWTQp9CEysFOjZruputzlsYvAdBjwOi+lJWEIiz+GI8fTmze
	 T8gOxlLywka3cT/6t1L/5aAu3EL+FsjmPEVXF80Y2eZcEdZYK9bTI+UgQmBRwe/RSC
	 p3Sm/0khowvPb07B5bgjZSydbQnzzhWG252l2CkCmzXu6NXTv814h5FfLwhF7lZXbv
	 e0zs3EsjocEpcO7ND3rFjhfG51I/1I7EgOtDRN3NbM4QPCNbT4BTKGaLmISZHWak+p
	 XhqHrydapfx2g==
Date: Tue, 28 Oct 2025 08:53:01 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
	robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	joel@jms.id.au, andrew@codeconstruct.com.au, vkoul@kernel.org, kishon@kernel.org, 
	linus.walleij@linaro.org, p.zabel@pengutronix.de, linux-aspeed@lists.ozlabs.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, openbmc@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 4/9] ARM: dts: aspeed-g6: Add AST2600 PCIe RC PERST#
Message-ID: <20251028-witty-nickel-pig-5bd4bc@kuoka>
References: <20251027095825.181161-1-jacky_chou@aspeedtech.com>
 <20251027095825.181161-5-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251027095825.181161-5-jacky_chou@aspeedtech.com>

On Mon, Oct 27, 2025 at 05:58:20PM +0800, Jacky Chou wrote:
> Add pinctrl support for PCIe RC PERST#.

This is part of PCI commit. Makes no sense on its own.

Best regards,
Krzysztof


