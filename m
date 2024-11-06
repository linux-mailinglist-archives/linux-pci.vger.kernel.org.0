Return-Path: <linux-pci+bounces-16164-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B64A69BF7B0
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 20:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AE4B282B22
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 19:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1364320820D;
	Wed,  6 Nov 2024 19:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JP895FVy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD88D1BDAA2;
	Wed,  6 Nov 2024 19:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730923151; cv=none; b=DXx/V7kI6yuyl2xziA+uDMy68aygrGLK/rxjzT4PvUeYVL8r96ED4nICJbXJ4Nc6SPKS7G2My/GbUcl8x36m4SpbMtfsZxf7lZSqG/Bh5uL5iC6jsf177GgMjUzDoG+AzUIJOlR59KLSFcrDaWuFcH/Ho3tLc3S0Tad/h3O4PEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730923151; c=relaxed/simple;
	bh=zccja30cjXnwWLrSTpr3HBhNk+6x7exH+l/RKMImnlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IldzeAxUIMeKWp3hUk3ma8EaGhDn6tk45ft+eduBWYVnJ1dABnawK4srjF6zGdLhoQQabpCzVqX/sftRf7/BG0FyQ6jrs+GjGSEzq5ZTo9lIJT3e8G0b28r7KM+XO8Wk4JFl3S5f3ZmH45sz6wRUZjVoINSToNnmffSTAhf3Lts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JP895FVy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29922C4CEC6;
	Wed,  6 Nov 2024 19:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730923150;
	bh=zccja30cjXnwWLrSTpr3HBhNk+6x7exH+l/RKMImnlc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JP895FVyLVQC2lcPlsq+H8PTjGkm/hYmyHmIp6j+Y04O/cuNGwRTXo1lK+mX6GaRs
	 yseK0QuFtgSdlHLS8eWESO08CJT8lpohkWTD1eM56QgUdzutz9og1RwRVT8GvZOAki
	 N0OqbL5vKROiGEihNg22OimQXCbsLVvz7n25eTLHNOqaKQmqxUonqu6MnFaOUHSS4w
	 Opobv0qweUreOMRDR2JMfyr/wJpYh3PpYpHHN+FCj/CheayUldr4MTrKYrSTESo9BT
	 DNyP08xud3LYMT1a9fCOBgP/DJo73o9Sqfnl43Zn4idenSVSCqbrevXvGCu/N7VjAN
	 lnvfXyXE+8vKw==
Date: Thu, 7 Nov 2024 04:59:08 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	Fei Shao <fshao@chromium.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [pci:controller/mediatek 2/2]
 drivers/pci/controller/pcie-mediatek-gen3.c:898:14: error: implicit
 declaration of function 'of_property_read_u31'; did you mean
 'of_property_read_u32'?
Message-ID: <20241106195908.GA174958@rocinante>
References: <202411070226.YqavKDUD-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202411070226.YqavKDUD-lkp@intel.com>

Hello,

>    drivers/pci/controller/pcie-mediatek-gen3.c: In function 'mtk_pcie_parse_port':
> >> drivers/pci/controller/pcie-mediatek-gen3.c:898:14: error: implicit declaration of function 'of_property_read_u31'; did you mean 'of_property_read_u32'? [-Wimplicit-function-declaration]
>      898 |        ret = of_property_read_u31(dev->of_node, "num-lanes", &num_lanes);
>          |              ^~~~~~~~~~~~~~~~~~~~
>          |              of_property_read_u32

Fixed.

	Krzysztof

