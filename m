Return-Path: <linux-pci+bounces-31060-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD516AED5B4
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 09:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E58D47AA04B
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 07:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A406822FF39;
	Mon, 30 Jun 2025 07:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZY6B9QZo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB35221FC0;
	Mon, 30 Jun 2025 07:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751268729; cv=none; b=HlAYRteuu0TylRRJ7gbdUSi5i6H4wBnRAYo8QDcGI1ObqBk2K31F/ChiNHi9W9aRO5FD+AC4WblFo+2jsZQkeNPNDEGBzp452HF3IC8Ntzr9k/j/8gFwelJr5MAUHlfKUVsm6JoeJku1PuRfbwObbfhCPIBNA2kHLzfrJXTkT7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751268729; c=relaxed/simple;
	bh=LjtmnEynmF1tjotg53OHblcoKybFNNuF9mQaAiduAWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UK1HSLTX7d9IxSkq4BN5yrrTgp3D8RSmt94JwQAlrMbHf5tYOCT3+n9VuKA90Q3l8bV3kuQwvlZgcAPmxu9CcsVzxfPTIRKUZ8ofPiAMrFSzEIWqCjWq1zzr0o73Qg4pjmi0gnRZFj/FKQrU6CzfRu44ZIkWu7aaxfuHTUn6z2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZY6B9QZo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AEC3C4CEE3;
	Mon, 30 Jun 2025 07:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751268729;
	bh=LjtmnEynmF1tjotg53OHblcoKybFNNuF9mQaAiduAWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZY6B9QZoJ/pjUbWvL9hI2CkMDM/HTrSNFxLhyenWw4Vl33x59KjgK6NdiNlseVTLh
	 YZGtF9cZhqj5d8Q780GYpZGEx7+R/TNvTnkrY7DTVebYGbSETUg6/0r1ncEDvx5WCh
	 k3ltu27su7eECsVpeo3MMTwFZGLtxvSnLEW2dUsLnXLfe+HsLa6JJmLWnC5T679H/a
	 Y964s/c4jftvRCvzh1qVnC2YWmiXfSrJXxzRehmxBYahhsNQpfHzZ1zZnAw9J8Kz2B
	 H9kW1PpOfoxSVwCvBr8W6G5tY/kTqgpoOo5zReNG5A/dJs7Co5awcA27W9y47G8ke+
	 7Vc3ToaBCONhw==
Date: Mon, 30 Jun 2025 09:32:05 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: hans.zhang@cixtech.com
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	mani@kernel.org, robh@kernel.org, kwilczynski@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, mpillai@cadence.com, fugang.duan@cixtech.com, 
	guoyin.chen@cixtech.com, peter.chen@cixtech.com, cix-kernel-upstream@cixtech.com, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 14/14] arm64: dts: cix: Enable PCIe on the Orion O6
 board
Message-ID: <20250630-stylish-pretty-stoat-bde7f3@krzk-bin>
References: <20250630041601.399921-1-hans.zhang@cixtech.com>
 <20250630041601.399921-15-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250630041601.399921-15-hans.zhang@cixtech.com>

On Mon, Jun 30, 2025 at 12:16:01PM +0800, hans.zhang@cixtech.com wrote:
> From: Hans Zhang <hans.zhang@cixtech.com>
> 
> Add PCIe RC support on Orion O6 board.
> 
> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
> Reviewed-by: Peter Chen <peter.chen@cixtech.com>
> Reviewed-by: Manikandan K Pillai <mpillai@cadence.com>

Where? Please provide lore links. The happened AFTER the SoB, so they
must have been made public, right?

> ---
>  arch/arm64/boot/dts/cix/sky1-orion-o6.dts | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/cix/sky1-orion-o6.dts b/arch/arm64/boot/dts/cix/sky1-orion-o6.dts
> index d74964d53c3b..44710d54ddad 100644
> --- a/arch/arm64/boot/dts/cix/sky1-orion-o6.dts
> +++ b/arch/arm64/boot/dts/cix/sky1-orion-o6.dts
> @@ -37,3 +37,23 @@ linux,cma {
>  &uart2 {
>  	status = "okay";
>  };
> +
> +&pcie_x8_rc {
> +	status = "okay";

And really two people reviewed this trivial changes? Really?

Plus what their review actually checked? This is obviously wrong - not
following DTS coding style, so what such review meant? What did it

Best regards,
Krzysztof


