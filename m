Return-Path: <linux-pci+bounces-21157-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8779BA30E4B
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 15:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 262841889DE4
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 14:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6330D24FBF8;
	Tue, 11 Feb 2025 14:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YoJ2VEcn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315C424C675;
	Tue, 11 Feb 2025 14:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739284396; cv=none; b=paWgm330alTTFuUDYQnX98l3sprJduBLhpc8H/TFL8y4TpGpIOKMQ77uVcwZkxA6ZDHCYATtjQdRqBlK3OiknUFcXPpgeICIuygZdnDOxXpchcE9l/wm12FVILBLCiLPR3amzN111dGIRL1Nnf/H5WCDs3XAYbBgfFOnRDOhptU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739284396; c=relaxed/simple;
	bh=nB42p0uhAIHOz78jGbHqRdJ6skXms/+R6HmUoLjFG1g=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OEmjozIUvKBLeMWBVjQPj2jU2Qp/ODGj/ayKy4LT2SpJtyViLJgUg27DPx7mVVNUphCTJLnW+WfXFbHdes0ffF7Fya+n+TvmTqIAPnTTxNptIUtdFXz3vzHgpj/RN/IfDprYv1IWzYRbw14isTwu7QB539Fwrk6yt9EYyLQBTrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YoJ2VEcn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC95C4CEDD;
	Tue, 11 Feb 2025 14:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739284395;
	bh=nB42p0uhAIHOz78jGbHqRdJ6skXms/+R6HmUoLjFG1g=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=YoJ2VEcn7Svz3ID+6ugmHwQfqUGQUmtqOM4U/8SWAUr9JY0TQO1qBrGCytlT4KKxI
	 bfQ1WWeEOfUyC62Ohc6nXRPyL4mHpkZa2Tw7+gNhEQ/OUmvxh5FmKtIv3tzyLMj7u4
	 CA3kbu+0Ult1IHnUNgfJkULfJBmvHAZmH4AWArTMrH+yMBOJyYdM4HPKzCM3A7IR7E
	 6AgcnHNcw3QaTCeVuXJL/yJRCLgZn2jRxJ5EkQ/EEooyghl4w5xUwcGS9UDMJ/8Gub
	 bIFDPwuSBeJrywLKA0+w9jJN69cAlk0XpWPiwb8iDEHxNUpW4iIRVWs/Hwm4dw8593
	 zKxSIEWepOMqQ==
From: Lee Jones <lee@kernel.org>
To: kw@linux.com, u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu, 
 arnd@arndb.de, bhelgaas@google.com, unicorn_wang@outlook.com, 
 conor+dt@kernel.org, guoren@kernel.org, inochiama@outlook.com, 
 krzk+dt@kernel.org, lee@kernel.org, lpieralisi@kernel.org, 
 manivannan.sadhasivam@linaro.org, palmer@dabbelt.com, 
 paul.walmsley@sifive.com, pbrobinson@gmail.com, robh@kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org, 
 chao.wei@sophgo.com, xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com, 
 helgaas@kernel.org, Chen Wang <unicornxw@gmail.com>
In-Reply-To: <a9b213536c5bbc20de649afae69d2898a75924e4.1736923025.git.unicorn_wang@outlook.com>
References: <cover.1736923025.git.unicorn_wang@outlook.com>
 <a9b213536c5bbc20de649afae69d2898a75924e4.1736923025.git.unicorn_wang@outlook.com>
Subject: Re: (subset) [PATCH v3 3/5] dt-bindings: mfd: syscon: Add sg2042
 pcie ctrl compatible
Message-Id: <173928439078.2206727.3592689089610946034.b4-ty@kernel.org>
Date: Tue, 11 Feb 2025 14:33:10 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Wed, 15 Jan 2025 15:07:14 +0800, Chen Wang wrote:
> Document SOPHGO SG2042 compatible for PCIe control registers.
> These registers are shared by PCIe controller nodes.
> 
> 

Applied, thanks!

[3/5] dt-bindings: mfd: syscon: Add sg2042 pcie ctrl compatible
      commit: 28df3b1a6aeced4c77a70adc12b4d7b0b69e2ea6

--
Lee Jones [李琼斯]


