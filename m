Return-Path: <linux-pci+bounces-16562-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2845F9C5CC0
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 17:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D34B31F23098
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 16:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F250D205AC6;
	Tue, 12 Nov 2024 15:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWvVb36D"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48EC205ABC;
	Tue, 12 Nov 2024 15:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731427194; cv=none; b=GwOMjUaabKcmOktJSfq0GUM4RlsMuO4Q1IbHvRYDU8wpnZbs9o5t3kD3AD3l8CpLUm6OL1UgwmVrcOpP/6SkGkbwg0JV3QcxsTlbwaP6POhNYibyItcRZTTILmOOCP/+eZ4RPMoG2hQpCEOpRviNeWcMqdAwFQqYNXGfr7bFgk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731427194; c=relaxed/simple;
	bh=gBjlmgJ7MyxGZeccQfr/1Hu9wSchf/D5jYM91Po354w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEQ7VWbpPIvKZFeLuJyFI/t9hiMSCkXzTE7GeA9imDT/gjFQUh/bMmJczHL8F30v5tPZrGS0s6IOa7DRHXtckN+WnpcNggrOK17rl4o9hpIN/a0LnrK4ih6c9AtcBV1aphsSqDeuMX2wt4hyuUiKAvHzNnaUBuRd7gKwMpnCnv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWvVb36D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 035E0C4CECD;
	Tue, 12 Nov 2024 15:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731427194;
	bh=gBjlmgJ7MyxGZeccQfr/1Hu9wSchf/D5jYM91Po354w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iWvVb36DyQUc0f490/M+aYYcPJequR1HxJGMbbA0I3/CQq4qbEwlNT2i8sAJuD+hk
	 wBTyCmyMj6nvu8P0e/3LYcunIXU86wXV2X7Z73fUWkyp1fg8F3jcZNXAFdc0mxTH05
	 JpkMAMdBRsy0OFXxr2utdrWh81QPlqEl3FFr53d/8Xz8oAwKLGblMQst2TU32q3bkJ
	 I3AuZusHyoN/TiMcAXo5OKvfE1Ug7Nc7LnMCuM5tjA+pS7qt/nZ0xToOfGde1zK6Zr
	 5FNACUBDtyW83L68lxOPIbCscNeb/uYRAx/RqHE9Cq8oJXXOBPqLHaw41uvvDgxUQ2
	 SztJmfUlN/34Q==
Date: Tue, 12 Nov 2024 09:59:52 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Chen Wang <unicornxw@gmail.com>
Cc: paul.walmsley@sifive.com, inochiama@outlook.com, lpieralisi@kernel.org,
	pbrobinson@gmail.com, guoren@kernel.org, conor+dt@kernel.org,
	chao.wei@sophgo.com, manivannan.sadhasivam@linaro.org,
	linux-pci@vger.kernel.org, lee@kernel.org,
	u.kleine-koenig@baylibre.com, unicorn_wang@outlook.com,
	kw@linux.com, xiaoguang.xing@sophgo.com, bhelgaas@google.com,
	krzk+dt@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu, arnd@arndb.de,
	palmer@dabbelt.com, linux-riscv@lists.infradead.org,
	fengchun.li@sophgo.com
Subject: Re: [PATCH 3/5] dt-bindings: mfd: syscon: Add sg2042 pcie ctrl
 compatible
Message-ID: <173142719146.983081.8984976211275970968.robh@kernel.org>
References: <cover.1731303328.git.unicorn_wang@outlook.com>
 <4f030066767c2a3b3acabe24e3dfbb8d87b42bfe.1731303328.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f030066767c2a3b3acabe24e3dfbb8d87b42bfe.1731303328.git.unicorn_wang@outlook.com>


On Mon, 11 Nov 2024 14:00:15 +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> Document SOPHGO SG2042 compatible for PCIe control registers.
> These registers are shared by pcie controller nodes.
> 
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


