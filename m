Return-Path: <linux-pci+bounces-31073-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 164A0AED9D1
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 12:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C79E9188640E
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 10:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100CD2571DC;
	Mon, 30 Jun 2025 10:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbVvRY2G"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42DF17BB21;
	Mon, 30 Jun 2025 10:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751279340; cv=none; b=qKqd2t20t4LaqIxs8NCPxXxMOqHlzaGgASzLwLs3/voh+Kc/S6YGCXftguPsAh0tkMpuqev42fmajU8hywLttvB+iXA14UDhiITxNdk/K9nudGh3IkwGO7v+m5eHBDtYM2d5OyzrWPhs7592ti3q6WY43INTFZ1F65pwYZE0NHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751279340; c=relaxed/simple;
	bh=ATaedHzFaLN/+2O3C1P+SoxjRMxzUzGj5iNT8sjCNhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJefdWsp6+cWL3ghcO4NzW48ioOYZHsdqZlsbK9Aml/sFCeaGzxudjswq0/eKqcdQudwWf0n2gjw8XAtdK24qRCtS3AHssu7rljqXSB6Gx3BtD62f1V/+jd3EjjCQ6BNr3spo9sOZGEuo21K5ZKRyG94Udo44QtFmV/TrXaC958=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbVvRY2G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87990C4CEE3;
	Mon, 30 Jun 2025 10:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751279339;
	bh=ATaedHzFaLN/+2O3C1P+SoxjRMxzUzGj5iNT8sjCNhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZbVvRY2Gdfu2cXxJRonFxh0nMuilh9REtauZMQ324+3xNJcbJgKx6eM03PXuCTm2N
	 xq1HeHE9rATLsf+7rZQjpSJ/zMUhUO5JL8rsjStZzCSVm1UqUlz20lhwE4a+EwooLf
	 FPM6TJcLyLx40fJZhVztMGbu2U+mk0Gb9FWybVwBA2ak4vBUABiTwLozH9RgU+dltj
	 hs/AL92SmRSKrh7ET5/e4w6d0rrLRsJsByu0loPknOdX1E9Vdoy1kHUAoG+eNLP5sf
	 0xG2PeHMFUId0Ec8fXuAnCeNzxb6NFHZC2+IaeZvKbDUSF0tkCu172MDOKKJt0REjl
	 djNrhnaRoaZ9Q==
Date: Mon, 30 Jun 2025 12:28:55 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: hans.zhang@cixtech.com
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	mani@kernel.org, robh@kernel.org, kwilczynski@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, mpillai@cadence.com, fugang.duan@cixtech.com, 
	guoyin.chen@cixtech.com, peter.chen@cixtech.com, cix-kernel-upstream@cixtech.com, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 02/14] dt-bindings: pci: cadence: Extend compatible
 for new EP configuration
Message-ID: <20250630-inventive-successful-crocodile-28fcff@krzk-bin>
References: <20250630041601.399921-1-hans.zhang@cixtech.com>
 <20250630041601.399921-3-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250630041601.399921-3-hans.zhang@cixtech.com>

On Mon, Jun 30, 2025 at 12:15:49PM +0800, hans.zhang@cixtech.com wrote:
> From: Manikandan K Pillai <mpillai@cadence.com>
> 
> Document the compatible property for HPA (High Performance Architecture)
> PCIe controller EP configuration.

That's the same patch which we already commented on. :/

> 
> Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
> ---
>  .../devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml          | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
> index 8735293962ee..c3f0a620f1c2 100644
> --- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
> @@ -7,14 +7,16 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Cadence PCIe EP Controller
>  
>  maintainers:
> -  - Tom Joseph <tjoseph@cadence.com>
> +  - Manikandan K Pillai <mpillai@cadence.com>

This is not explained in commit msg. You need to say WHY you are doing
such changes.

Best regards,
Krzysztof


