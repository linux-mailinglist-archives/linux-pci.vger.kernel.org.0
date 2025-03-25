Return-Path: <linux-pci+bounces-24656-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3FBA6EE36
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 11:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31138189680E
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 10:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7426925522B;
	Tue, 25 Mar 2025 10:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="Wc5JySZC"
X-Original-To: linux-pci@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9891149E13
	for <linux-pci@vger.kernel.org>; Tue, 25 Mar 2025 10:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742899891; cv=none; b=Sn0eHDZLKTAfjlKdNj8Svv8sJE6y8OuSbrgtmwEJKCfSuHqxviTEV0fliTwpYEtmr2ew6PFb1idXOQU7VpGPpuewHCyT6mlX2XK3Z0gw8pkUrxfwhzVM0+3WwFQEPTrIlbMLm5Wo/kMI7C6yR/vdqdkRRoKGaDDAexuNlB/qWIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742899891; c=relaxed/simple;
	bh=xR6GirIfBrozq2AC8xJgD5xQeiggRPE3lvdwGa5aGWI=;
	h=Date:Message-Id:From:To:Cc:In-Reply-To:Subject:References; b=dtuPNjKlxTSHaeX6qDKFgcVS4m7BdVdvSKBCWZGLQV1vrQgdv0H6OChO/Iw116PfnZy4npYlapdXPDL+xHL6E0cncxRVEZJwyLSCB7ylmkiZ/vE6SnPS2YfTuGrtKG017qPLmrThzTKQKcV1OwrPlN8cC6dUq8DcwNMdvhHN+DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=Wc5JySZC; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: 146499bc-0967-11f0-beb8-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 146499bc-0967-11f0-beb8-005056992ed3;
	Tue, 25 Mar 2025 11:51:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=subject:to:from:message-id:date;
	bh=tODqhCRdwq1cXWRXmGhiNHHjhfHswwchnkKRsOhE6J0=;
	b=Wc5JySZCXx1MoNhRPEol3otsbzxXiEBELwGp7X2PEUTfqxvTNxIPDD0sfLfyl0NeaUkIi7gzXy8FR
	 KnQTZuTfL96nU0c44qXfitXB/O1Mx9xSjgwecqJuqpY51zRsPY4QggzHfAuWUjehyRbHm994X8yCN9
	 zjiY6UzfMSIV7Tywf+AHZm2sg5/QULfmhVe6KegEJXm5SHT0UU9PHs0qB4ZJVfGHQ3R2Wvz1RHuc4+
	 jM9qUCZKzxc/XXG5M7RspIsCw+1H9AU0p83poYAV0sBKIiZjdGu17zjZ+Kacqb0MTyRPFs5nnVG0HC
	 ODy5JrZ1eOoVZy19zYJQ7ZqL6M2UHyQ==
X-KPN-MID: 33|X3ePmqrigeow21+0/RPmUN0r8S697D3GBHNH5gAjYHVFKlylKuLbV/4XqHXfbBN
 GYGKjtylp6D5XCh1zPvZARfdEblG5wmYxCvWkfqAaXEg=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|u5ACCmXoKrCtlfyO6JwQmRDfOR8RTr9QZHb3C3pFSCHXZmmCrngvMhskrSsADpq
 Hn53REoUx9NWcVO7nuoMzvQ==
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net [80.61.163.207])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id f0fd1fad-0966-11f0-99e4-00505699772e;
	Tue, 25 Mar 2025 11:50:19 +0100 (CET)
Date: Tue, 25 Mar 2025 11:50:18 +0100
Message-Id: <87iknx75at.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev, alyssa@rosenzweig.io, j@jannau.net,
	marcan@marcan.st, sven@svenpeter.dev, bhelgaas@google.com,
	lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org
In-Reply-To: <20250325102610.2073863-2-maz@kernel.org> (message from Marc
	Zyngier on Tue, 25 Mar 2025 10:25:58 +0000)
Subject: Re: [PATCH v2 01/13] dt-bindings: pci: apple,pcie: Add t6020 compatible string
References: <20250325102610.2073863-1-maz@kernel.org> <20250325102610.2073863-2-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Marc Zyngier <maz@kernel.org>
> Date: Tue, 25 Mar 2025 10:25:58 +0000

Hi Marc,

Sorry for not spotting this in the earlier versions, but:

> From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> 
> t6020 adds some register ranges compared to t8103, so requires
> a new compatible as well as the new PHY registers themselves.
> 
> Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> [maz: added PHY registers]
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  Documentation/devicetree/bindings/pci/apple,pcie.yaml | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/apple,pcie.yaml b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
> index c8775f9cb0713..77554899b9420 100644
> --- a/Documentation/devicetree/bindings/pci/apple,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
> @@ -17,6 +17,10 @@ description: |
>    implements its root ports.  But the ATU found on most DesignWare
>    PCIe host bridges is absent.
>  
> +  On systems derived from T602x, the PHY registers are in a region
> +  separate from the port registers. In that case, there is one PHY
> +  register range per port register range.
> +
>    All root ports share a single ECAM space, but separate GPIOs are
>    used to take the PCI devices on those ports out of reset.  Therefore
>    the standard "reset-gpios" and "max-link-speed" properties appear on
> @@ -35,11 +39,12 @@ properties:
>            - apple,t8103-pcie
>            - apple,t8112-pcie
>            - apple,t6000-pcie
> +          - apple,t6020-pcie
>        - const: apple,pcie

Since the T602x PCIe controller has a different register layout, it
isn't compatible with the others, so it should not include the
"apple,pcie" compatible.  The "downstream" device trees for
T602x-based devices do indeed not list "apple,pcie" as a compatible.
So I think this needs to be written as:

  compatible:
    oneOf:
      - items:
          - enum:
              - apple,t8103-pcie
              - apple,t8112-pcie
              - apple,t6000-pcie
          - const: apple,pcie
      - const: apple,t6020-pcie

>  
>    reg:
>      minItems: 3
> -    maxItems: 6
> +    maxItems: 10
>  
>    reg-names:
>      minItems: 3
> @@ -50,6 +55,10 @@ properties:
>        - const: port1
>        - const: port2
>        - const: port3
> +      - const: phy0
> +      - const: phy1
> +      - const: phy2
> +      - const: phy3
>  
>    ranges:
>      minItems: 2
> -- 
> 2.39.2
> 
> 
> 

