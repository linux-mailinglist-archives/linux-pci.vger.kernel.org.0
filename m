Return-Path: <linux-pci+bounces-15377-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3BF9B1206
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 23:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73579283313
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 21:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F120C1865FC;
	Fri, 25 Oct 2024 21:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JujiVBGk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E7E217F57;
	Fri, 25 Oct 2024 21:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729893306; cv=none; b=D44+yYoJSssr480/uSajsglWUujp7WHnTu8uvhhJSQJ2QYrOiDuatKj0QnRx5RDOXdwKuTyjQPG65UIBUcjyJST7tfWZajZWJE989Tz+3OpvVb/iHRhwLHKZKcxIH0sXV9xS27wy+QPdifG8a50LJ2lhy1knzU4kv5ZjtUIyaBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729893306; c=relaxed/simple;
	bh=Qj3RrgeMczvK9hKxZ+77DcpwktRtCnGKCeQKnq3m7ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPHGuXa360HbE8N9VWZk8nuo1QiVfOei10x4GrxF16m/lzxhP5MBRFmBNg3UPO+xysI2ctSOzpaOr/GJFfvV6gnz5dIA3EnRnOp2G0QXTMOAb+zcq9079HlRcU08JFlKU6UaK0D5vPODCb450dPoeQJJKPXrIlgowgGljgTzJ14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JujiVBGk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10538C4CECD;
	Fri, 25 Oct 2024 21:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729893306;
	bh=Qj3RrgeMczvK9hKxZ+77DcpwktRtCnGKCeQKnq3m7ls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JujiVBGkzsjq7A8DOvqTbu4LsmbDl04bXl0ne7aE2WCYbgrUdkXGCi2401YpTRA2v
	 SjEIutJmoB2hczNOYz+z9l5iQdx9nWYZC5zjeMdl3EC6hkFvfJi1CVDmtYJXZrrZsC
	 jDv1Q1nJklEy/+oWqSw8lVFNO+FlLT/M+cnDp9ZrONDYODG62y5uUUDF2Ebjx7I48B
	 7WxSJu4pJHkzUCrLNH5IsmdJjQ4QreYGRZLUm/7mHUMZdjcM0ma6+9wzZbrDMHAhc6
	 cur2qWWxE0qLQtvef1foLGaYi3xK9z3uWsRn8Krgl+953SGJSCSQ0lp0vZxY4Bl0E8
	 6dgETIQFaiZAQ==
Date: Fri, 25 Oct 2024 16:55:04 -0500
From: Rob Herring <robh@kernel.org>
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Andrea della Porta <andrea.porta@suse.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>
Subject: Re: [PATCH v4 02/10] dt-bindings: PCI: brcmstb: Update bindings for
 PCIe on bcm2712
Message-ID: <20241025215504.GA945212-robh@kernel.org>
References: <20241025124515.14066-1-svarbanov@suse.de>
 <20241025124515.14066-3-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025124515.14066-3-svarbanov@suse.de>

On Fri, Oct 25, 2024 at 03:45:07PM +0300, Stanimir Varbanov wrote:
> Update brcmstb PCIe controller bindings with bcm2712 compatible
> and add new resets.
> 
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> ---
> v3 -> v4:
>  - Dropped Reviewed-by and Acked-by tags because I have to re-work the patch
>    in order to fix newly produced  DTB warnings on the .dts files.
>  - Account the number of resets for bcm2712 which are differs from bcm7712.
> 
>  .../bindings/pci/brcm,stb-pcie.yaml           | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> index 0925c520195a..df9eeaef93cd 100644
> --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> @@ -14,6 +14,7 @@ properties:
>      items:
>        - enum:
>            - brcm,bcm2711-pcie # The Raspberry Pi 4
> +          - brcm,bcm2712-pcie # Raspberry Pi 5
>            - brcm,bcm4908-pcie
>            - brcm,bcm7211-pcie # Broadcom STB version of RPi4
>            - brcm,bcm7216-pcie # Broadcom 7216 Arm
> @@ -175,6 +176,26 @@ allOf:
>          - resets
>          - reset-names
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: brcm,bcm2712-pcie
> +    then:
> +      properties:
> +        resets:
> +          minItems: 2
> +          maxItems: 2
> +
> +        reset-names:
> +          items:
> +            - const: bridge
> +            - const: rescal

Sigh. Why the opposite order of the existing bindings?

I would make the top level:

minItems: 1
items:
  - enum: [perst, rescal]
  - const: bridge
  - const: swinit

Rob

