Return-Path: <linux-pci+bounces-24540-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B1DA6DF2B
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 16:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 096321885E04
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 15:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAB326156D;
	Mon, 24 Mar 2025 15:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FyvntDDI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F15825F983;
	Mon, 24 Mar 2025 15:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742831968; cv=none; b=SjpKxu2ceSVQkGcP9Y4hFT+O4vVMcKa5lQDRoKcm6tsAEV9vEdymKot9IadEMXT92VKuXpEV1y5iZW4iNrsQPhmrlK3tKQgZdZQro+NTMHUOL+9916d2Ly1xV2is5DGhbvhkc1CIZP+TML5PqGuR8elksPMPE4Gxlhk2AipA7Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742831968; c=relaxed/simple;
	bh=tlgS3Tr291j1384T3PsF6bF4b76t3xHeHTIlkL6k15s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s1a5X1M6vg9OYSkuMPq2gLIrx24dml4K5kwBbGzi2EzgyZvya95KxqkLJLge3PPTp1PGZUesA+/FFPcoh7eejFQTFNZvWf+1ndzdYWsmN/WfWzPTN7/iVyPsZ85517QhUiexpbUHM3864mRDf2XljTdvWiOQ0vTk1w+U4caAQMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FyvntDDI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD1DAC4CEDD;
	Mon, 24 Mar 2025 15:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742831968;
	bh=tlgS3Tr291j1384T3PsF6bF4b76t3xHeHTIlkL6k15s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FyvntDDIRSzieJY2zWJyH2bq+gWXQShVyU6pjErO1KC5EK9b/Ee15fQyKSV9M2kRf
	 fOQqNrQQEYvYTP6UeG4v0ESSDc0BVZ3gbLsllL69s/jUzX9HAWTJo3AVoPxVMl4Eyj
	 r+sqgPDj7Q8rkVfWE2qcTgyHeh/RogJ3CPmHVtS5KTuKse6tqKDM/XOybLH2+22Q8+
	 LpJejncNo7kLRzehO648XVbLI4Emc33kQbTPz+HpEa6+dNpDgpPdNf5EjYaDiNkaX0
	 8uN6JG8lcjvulvrMCkGtEMUeq4PySVdzMwJhk0M7xZxJuP+A92TsL1V1wHuWf6CM78
	 SYZpXamN9H5cQ==
Message-ID: <60af2ed4-91a9-434b-b1f6-a87218aba381@kernel.org>
Date: Mon, 24 Mar 2025 16:59:21 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: pci: cadence: Add property "hpa" for
 PCIe controllers
To: Manikandan Karunakaran Pillai <mpillai@cadence.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>, "kw@linux.com" <kw@linux.com>,
 "robh@kernel.org" <robh@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20250324082335.2566055-1-mpillai@cadence.com>
 <CH2PPF4D26F8E1CE4E18E9CC5B8DAF724DCA2A42@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <CH2PPF4D26F8E1CE4E18E9CC5B8DAF724DCA2A42@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/03/2025 10:08, Manikandan Karunakaran Pillai wrote:
> Document the newly added property "hpa" for Cadence PCIe controllers in Documentation/devicetree/bindings/pci/ for Root Port and Endpoint configurations

Drop the path, pointless.

> 

Please run scripts/checkpatch.pl on the patches and fix reported
warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
patches and (probably) fix more warnings. Some warnings can be ignored,
especially from --strict run, but the code here looks like it needs a
fix. Feel free to get in touch if the warning is not clear.

<form letter>
Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC (and consider --no-git-fallback argument, so you will
not CC people just because they made one commit years ago). It might
happen, that command when run on an older kernel, gives you outdated
entries. Therefore please be sure you base your patches on recent Linux
kernel.

Tools like b4 or scripts/get_maintainer.pl provide you proper list of
people, so fix your workflow. Tools might also fail if you work on some
ancient tree (don't, instead use mainline) or work on fork of kernel
(don't, instead use mainline). Just use b4 and everything should be
fine, although remember about `b4 prep --auto-to-cc` if you added new
patches to the patchset.
</form letter>

> Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
> ---
>  .../devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml         | 4 ++++
>  .../devicetree/bindings/pci/cdns,cdns-pcie-host.yaml       | 7 +++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
> index 98651ab22103..4e839fa90b23 100644
> --- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
> @@ -24,6 +24,10 @@ properties:
>        - const: reg
>        - const: mem
>  
> +  hpa:
> +    description: If present PCI controller is high performance architecture

compatible defines this.

> +    type: boolean
> +
>  required:
>    - reg
>    - reg-names
> diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
> index a8190d9b100f..c219fe15c879 100644
> --- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
> @@ -9,8 +9,11 @@ title: Cadence PCIe host controller
>  maintainers:
>    - Tom Joseph <tjoseph@cadence.com>
>  
> +select: false

No clue what you wanted to achieve here, no explanation in commit msg
and this makes not much sense.

> +
>  allOf:
>    - $ref: cdns-pcie-host.yaml#
> +  - $ref: cdns-pcie.yaml#

Why?

>  
>  properties:
>    compatible:
> @@ -24,6 +27,10 @@ properties:
>        - const: reg
>        - const: cfg
>  
> +  hpa:

Again, compatible defines this.

Anyway, follow standard DT binding rules (see writing bindings, numerous
talks or guides).

Best regards,
Krzysztof

