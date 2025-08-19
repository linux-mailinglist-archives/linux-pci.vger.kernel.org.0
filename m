Return-Path: <linux-pci+bounces-34306-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBDDB2C72D
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 16:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B14EB5E27E0
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 14:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2412773CD;
	Tue, 19 Aug 2025 14:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="okteRz2z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCFD27602E;
	Tue, 19 Aug 2025 14:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755614216; cv=none; b=hIzP39SHTdx2xrqCPzQbKDOqd14d1//B6hmcuT1kPwKORMUvk/gBrkrBxfY73l3BJLXopRTDMVviQ7gRJyHTG9MG1DNMFFtbLRg37zRT9iZGWnEW/OaOlsnYMFjpYiYacGq+KMPTWxjs7iBcqKnJmgpooAzhRv7+yRqBC018k6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755614216; c=relaxed/simple;
	bh=SXLS7/VM3g85Cc5fAbqS3ubAzBGw+wA8lmhQV7doCHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwtWbmIDsUrjkl46JcpeIm/vLNT4EAQ24SIsfP+LeReWo+2O9dGXmkyEtu8nf0w6yLls8Hr3F/KBgJhbNSPtCjw8JXmg0JliuBfvSuBsTA+xqb3xcF2goIEuSbP6LNEjy6p3uj44yrlGxQ5qtbcse0TmADFgUOMYjELWL+k4eZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=okteRz2z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4177AC4CEF1;
	Tue, 19 Aug 2025 14:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755614215;
	bh=SXLS7/VM3g85Cc5fAbqS3ubAzBGw+wA8lmhQV7doCHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=okteRz2zcdDimeS21ApNqq6v+CS/6RMwuhZXKKWR1yuTYcIWMj+qA+H6AwkhhlgqT
	 9kYUVSg+NVWsVfyKKdnQL59/ROppZkfDljgWRv/W2CEePS4A8vAnoqayNz7NdHtDVo
	 D+FQQt0zigCRATb+yXcBKnurX6uJhLUZANrEqP12q6kaluBaylRKGvJFm88p59jd86
	 V8HdL0G69vl+/iyp5TDuDV90jND0y4GyudFOV3hcGuzSgn/HmWGu2Oh6UMNRsThdTo
	 zQbX0fHErNuLswwR/yD+wMiyY1Y6LJQubS1/mD5nKUAr9Sz/nqaexQOOipk3rU70HI
	 +tI2LzmtW9fUw==
Date: Tue, 19 Aug 2025 20:06:45 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	jianjun.wang@mediatek.com, ryder.lee@mediatek.com, bhelgaas@google.com, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, manivannan.sadhasivam@linaro.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com, 
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v2 2/3] dt-bindings: PCI: mediatek-gen3: Add support for
 MT6991/MT8196
Message-ID: <6q3gp2hyg3bzogpg3igjkqzkcnfxvzf5zpid2sssi2nu6mc5er@yi7ewqi2h33i>
References: <20250703120847.121826-1-angelogioacchino.delregno@collabora.com>
 <20250703120847.121826-3-angelogioacchino.delregno@collabora.com>
 <20250707-large-nocturnal-dormouse-c93deb@krzk-bin>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250707-large-nocturnal-dormouse-c93deb@krzk-bin>

On Mon, Jul 07, 2025 at 08:46:16AM GMT, Krzysztof Kozlowski wrote:
> On Thu, Jul 03, 2025 at 02:08:46PM +0200, AngeloGioacchino Del Regno wrote:
> > +    then:
> > +      properties:
> > +        clocks:
> > +          minItems: 6
> > +
> > +        clock-names:
> > +          items:
> > +            - const: pl_250m
> > +            - const: tl_26m
> > +            - const: bus
> > +            - const: low_power
> > +            - const: peri_26m
> > +            - const: peri_mem
> > +
> > +        resets:
> 
> minItems: 2 is needed (that's a change since some time, comparing to
> what was year or earlier)
> 

Will do 's/maxItems/minItems' while applying.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

