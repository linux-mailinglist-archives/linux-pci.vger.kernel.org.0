Return-Path: <linux-pci+bounces-36820-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AABA8B97CA5
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 01:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BF513B0841
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 23:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33BD279DB4;
	Tue, 23 Sep 2025 23:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSjI8deF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26A314EC73;
	Tue, 23 Sep 2025 23:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758669345; cv=none; b=Z2ocxhEaSVk/PHAguCqsCprPfLH3PawUlEH8Ns1/i120tqEu+pZw4Yhc4Kkc/ySp1fBP3GDyPxafjjf1hF15apeeOrglLqldtY50zD8YmJTd+eaf+CJ0NvL7wq69YT4ztZmzmsnKxoq3FZopxAb5ZGj2soZeUtbY1B/9nmqFrXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758669345; c=relaxed/simple;
	bh=pvYfKhTpW3bGdjpAO4fy40xvT7yPgb7fyXYDyfDid0A=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=UxCnKERTBWu8LweGRteuFKcB2rmrAtEoAuf2HXAcYG6TBuvSnfWVQ1+LNJWrMDOrARwaKH7qnIjWK231pkPAbKqeH+ZHcMlVFVFi8b8nP4nfo29ygWYzFA+7vnRQI1ZH5oturURoER92lCg2HM3wTVWJcumq3C8XjqPu1azzTwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSjI8deF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A9AC4CEF5;
	Tue, 23 Sep 2025 23:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758669345;
	bh=pvYfKhTpW3bGdjpAO4fy40xvT7yPgb7fyXYDyfDid0A=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=cSjI8deF/T3Mix8vrvDs9Z9batQCsKLVzSU5rsijTocNND7sNti50XVFJjAh1zS8H
	 dtLgwJuwWxDE3dTC8l0dLRYeAqtwzCHe/KB898BmFRWK74hJZITRdYuy5NTo5bL/C7
	 rV3tRB2OlIjYLo0yY0cnkXFeeHS0FbYbSJY6JewMxjbcvNZNQ2CxzqZoD5W7pvaO6d
	 q3ktcxqi2f+sl1QnqRf2I3SH/gdlsf0nq3RGg7uDqXvwyYh1ScMm/sli1e2WR4zOk/
	 RSVg0S/0ySBriMcnbO+Th7axxEWa8PMA231+9bpQgnc+mpwwU13b0WoB+MgYT/ZwBI
	 q+k+eNHNkzwfw==
Date: Tue, 23 Sep 2025 18:15:44 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org, 
 Stephen Boyd <sboyd@kernel.org>, upstream@airoha.com, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, devicetree@vger.kernel.org, 
 Jianjun Wang <jianjun.wang@mediatek.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <20250923201244.952-2-ansuelsmth@gmail.com>
References: <20250923201244.952-1-ansuelsmth@gmail.com>
 <20250923201244.952-2-ansuelsmth@gmail.com>
Message-Id: <175866934419.400019.15611978179247377029.robh@kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: clock: mediatek: Fix wrong
 compatible list for hifsys YAML


On Tue, 23 Sep 2025 22:12:29 +0200, Christian Marangi wrote:
> While converting the hifsys to YAML schema, the "syscon" compatible was
> dropped for the mt7623 and the mt2701 compatible.
> 
> Add back the compatible to mute DTBs warning on "make dtbs_check" and
> reflect real state of the .dtsi.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../devicetree/bindings/clock/mediatek,mt2701-hifsys.yaml | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/mediatek,mt2701-hifsys.example.dtb: clock-controller@1a000000 (mediatek,mt2701-hifsys): compatible: 'oneOf' conditional failed, one must be fixed:
	['mediatek,mt2701-hifsys'] is too short
	'mediatek,mt7622-hifsys' was expected
	'mediatek,mt2701-hifsys' is not one of ['mediatek,mt7623-hifsys']
	from schema $id: http://devicetree.org/schemas/clock/mediatek,mt2701-hifsys.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250923201244.952-2-ansuelsmth@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


