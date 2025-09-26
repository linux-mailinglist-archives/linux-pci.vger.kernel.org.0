Return-Path: <linux-pci+bounces-37139-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A699BA52F8
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 23:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A38A73A770C
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 21:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B4225F98E;
	Fri, 26 Sep 2025 21:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDN1MGZl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4AA2A1CA;
	Fri, 26 Sep 2025 21:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758921324; cv=none; b=ct0eQTGPw8Lo+w/PuTrz4myyA9l1xpTNcsRmfzf5I5790trAaLQ1Sw5IHbvy4QrrsoggSQzR8nplVTdwok1Of06IEycbkhcDXqQPu+gAElmiWQQcjsIAcADIARA3m1SkXMEZo68hjoxzHTvDa1eZeFSFxQ9B8CscKNf35Epk1ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758921324; c=relaxed/simple;
	bh=Yt5ah+ukL8YQL9amE2ctvppRu5edmQMR6fjalQAWkqw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=H7YaSJwj2SpOSep9T9rZF2DZskAU+pY6can9TQAfeselJjBAHdhsE+XTBpNVbLAeb2PjKBGriV8HmfldrL674yGoN1fHLiVYy0/kaHYyrZvtUd8qOsYZ1c6Yx0aod+Ybf0s3tBZJxddlNV+X52Rf56H40Q/8p3XAp5QugpzhbCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDN1MGZl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CDDAC4CEF4;
	Fri, 26 Sep 2025 21:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758921324;
	bh=Yt5ah+ukL8YQL9amE2ctvppRu5edmQMR6fjalQAWkqw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gDN1MGZl4IN1IyRowVPsIts6jmFM0cezDT03rNKZRaMFqCOuO/oUyzbJnSK4GpM3L
	 kiqgC1Tf+R7XrhowXWG8RYVOvBYcAWCP9rDvNcPgVdSGeUm+YSop5kMU3uBiws+5J+
	 byzljg6y3jwd/Hg2/EJD58kPE9sEb3mkKqPhhg2/ul/fX9pXjlhckM8xWPCSbq+bQ9
	 zLnMpdRlRBnwV7nNf70Z5EaSkS9OnpcCTj6jAjOgOD/2mlAk36LjyyZsRCPV1/tC50
	 KGI+ksNzkclHrGw3G+6dvom4KAbtHfrawBrZ47e+76Nu8E9yOGkc4Q1B12/FmftjtP
	 r6AWpOly8hFcA==
Date: Fri, 26 Sep 2025 16:15:22 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andersson@kernel.org,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: qcom,pcie-x1e80100: Set clocks
 minItems for the fifth Glymur PCIe Controller
Message-ID: <20250926211522.GA2268583@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919142325.1090059-1-pankaj.patil@oss.qualcomm.com>

On Fri, Sep 19, 2025 at 07:53:25PM +0530, Pankaj Patil wrote:
> From: Qiang Yu <qiang.yu@oss.qualcomm.com>
> 
> On the Qualcomm Glymur platform, the fifth PCIe host is compatible with
> the DWC controller present on the X1E80100 platform, but does not have
> cnoc_sf_axi clock. Hence, set minItems of clocks and clock-names to six.
> 
> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>

Applied with Rob's ack to pci/dt-binding for v6.18, thanks!

> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
> index 257068a18264..61581ffbfb24 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
> @@ -32,10 +32,11 @@ properties:
>        - const: mhi # MHI registers
>  
>    clocks:
> -    minItems: 7
> +    minItems: 6
>      maxItems: 7
>  
>    clock-names:
> +    minItems: 6
>      items:
>        - const: aux # Auxiliary clock
>        - const: cfg # Configuration clock
> -- 
> 2.34.1
> 

