Return-Path: <linux-pci+bounces-31597-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D4CAFAC13
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 08:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CBB6189A516
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 06:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF9C27A931;
	Mon,  7 Jul 2025 06:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iBWDFjlB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26ED27A918;
	Mon,  7 Jul 2025 06:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751870780; cv=none; b=IRZ6S8ITPGEiXhOXZ0wUC2gLClzfEl1Bsa959zONcvgsggo7NbNwaMaEoeGnbak2/Cef9HLfda37TYtcVcvr5GVVtjBBr3sOpThtgpw7N6xu0OipKnYVZ4rzfXuvaWFfarm5q5tYD5q2k40vUfIbrEKSWXfdxKqQ6OMkkiyBKiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751870780; c=relaxed/simple;
	bh=3mMLUGq667LvTYPmJqf0R3Fs9bpeNw58j22K0qFkatw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUKyAqXfYH2Rpn9QQ30YbHsHpWPKxkHPkO9bhWrDItBxhyNv4vCugKKWrqiyDj4neMFuoQpj0URTnqzzxgm92lmy1YEvHmtwz8QdFz2tVh02xLz1UV72vvrXI1qhPFMNqswQcz/esPAnk3DBM1a1EoVGII6e/xZadVLn0wZ9FyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iBWDFjlB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF30BC4CEE3;
	Mon,  7 Jul 2025 06:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751870779;
	bh=3mMLUGq667LvTYPmJqf0R3Fs9bpeNw58j22K0qFkatw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iBWDFjlBJ1XYPU3rdiNgM8Sz93wOwSI2GhNllcVQXRUgUiW2QEbGCmiYBwdiHQd1/
	 jsw0Q8J7um77KQxSCaBIjIdC+a/UKSMaBrIXFFxtwCO18+lgfne/uOkWDS0uWs1Beu
	 RuJUTGziQHbZ6eVOUIIYTCPsYMpaWEnKkEYMNvehWs5TgNyaZDZwRjMivKYBu3KjGy
	 AtdT9vojGAL8kani6hqpd9cNH1vXQcETZdw53+WL0IAth22k15uZF2Jqsz4vcfaS+q
	 2VbBEfdHMIyBGZ73Jo6IRqsJAQU4DeGOYmhmtqG9Pf90X4wnBU2iZjuf2h+sVmMVzi
	 zkJFdUvQhiDhw==
Date: Mon, 7 Jul 2025 08:46:16 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: jianjun.wang@mediatek.com, ryder.lee@mediatek.com, bhelgaas@google.com, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, manivannan.sadhasivam@linaro.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com, 
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v2 2/3] dt-bindings: PCI: mediatek-gen3: Add support for
 MT6991/MT8196
Message-ID: <20250707-large-nocturnal-dormouse-c93deb@krzk-bin>
References: <20250703120847.121826-1-angelogioacchino.delregno@collabora.com>
 <20250703120847.121826-3-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250703120847.121826-3-angelogioacchino.delregno@collabora.com>

On Thu, Jul 03, 2025 at 02:08:46PM +0200, AngeloGioacchino Del Regno wrote:
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 6
> +
> +        clock-names:
> +          items:
> +            - const: pl_250m
> +            - const: tl_26m
> +            - const: bus
> +            - const: low_power
> +            - const: peri_26m
> +            - const: peri_mem
> +
> +        resets:

minItems: 2 is needed (that's a change since some time, comparing to
what was year or earlier)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


