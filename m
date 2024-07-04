Return-Path: <linux-pci+bounces-9782-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6987C9270BE
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 09:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F1421F248E3
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 07:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7179F17082C;
	Thu,  4 Jul 2024 07:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSDh0a8Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C8214A624;
	Thu,  4 Jul 2024 07:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720078750; cv=none; b=coVUKulTDjVAIKULKQInNZRhyZ0kB6LjiiCFSnGChJqMPLbHd+VswN5C9wLP53Ot/SgDr25HKUvOWOMiexM+NtdvR0RMaD2GOtL3S163HpponxWmioPqcdGfbhK8Xh2vS7zNBE6TRmKX3JmZ0I9rqSJAUajedAg7lgQR3H2tLr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720078750; c=relaxed/simple;
	bh=SH1InqgjQCt3Rxrp6YwQLbrSn27Wjwp5zfeISaPz7rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFq4+n94DhEndpVp7zb5EzSim31wr5nnXJs2Cc1fAIeXuNf0s90g8vZsJG2YBhMfAFFhTwqcCsakwdl1MxmqMcyLAlztPLDGRySW0Ei93/XX6FS0uLcAGw3aPaPjFi3QcfVrnQrspSNpdXUY3VZSq5NeRPmoEiii96iDO/p6C8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSDh0a8Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB02C3277B;
	Thu,  4 Jul 2024 07:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720078750;
	bh=SH1InqgjQCt3Rxrp6YwQLbrSn27Wjwp5zfeISaPz7rc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hSDh0a8Qq/cYWpXvCZaDTMxrEVKQbEWeHygrhrFaIF2QPtiTdgJPlf4Tv+MC0Srul
	 eE5auaBmYlwlcS4SjDPlYHyLunPNn04LW45KcEzHR+iXn9zIWcHoTgzMxgZIhJfc7T
	 AEqU6kh7FwZzQgAwcWwoyUmxrkJLNEjduwuM3r6JINVKQsH+18muXJtLVeATOAQBwH
	 FdkrMFWD/5IDQaV8plL/zdVTQTHgglsP7O7WGaliNPJW0bjKaa0Q0LlvK6dvd7Do2H
	 7A1xFQZf/Luvjc66ZRG1DCWRQC/4y9sxFHAeFmU71vAYMLuMxxYm1E7Se0N/r2L3LA
	 kl3KiMMEBfieA==
Date: Thu, 4 Jul 2024 16:39:08 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: kernel test robot <lkp@intel.com>, Abel Vesa <abel.vesa@linaro.org>,
	oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [pci:dt-bindings 10/11]
 arch/arm64/boot/dts/qcom/x1e80100-crd.dtb: pci@1bf8000: reg: [[0, 29327360,
 0, 12288], [0, 1879048192, 0, 3869], [0, 1879052064, 0, 168], [0,
 1879052288, 0, 4096], [0, 1880096768, 0, 1048576]] is too short
Message-ID: <20240704073908.GA2877677@rocinante>
References: <202407041154.pTMBERxA-lkp@intel.com>
 <20240704072006.GA2768618@rocinante>
 <bd96c9e5-9342-41b8-aa14-2db4828e37f3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd96c9e5-9342-41b8-aa14-2db4828e37f3@kernel.org>

[...]
> > I removed this patch from the dt-bindings branch for the time being.
> 
> 
> These reports are useless. I suggest ignore all of them...

I see.  Just a lot of noise then...

	Krzysztof

