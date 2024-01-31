Return-Path: <linux-pci+bounces-2890-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA161844395
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 17:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A5A41F24E58
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 16:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC7B12A166;
	Wed, 31 Jan 2024 16:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+Rsnmas"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F73112A15A;
	Wed, 31 Jan 2024 16:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706716899; cv=none; b=BJBCDRtRNDEFAoaWmLIK1kH5aman1l289Yp6DkKcfzcivu6S5ba8avU6pW9dggj2BQBJoogujU02MozBajmp23ELgPryfrWnd9WafSXQhlT1GNuPjjrOy4A+gKLM4s4Kj4QqQodqjAKZ8XbewWgkCAuKIp7tf5Jr8aWsXDGZ5AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706716899; c=relaxed/simple;
	bh=rUVEsg7BzjLNm9d+zQc8VFaM5E+OuehU/xWapW5CtVU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=f51wBD8EvZhwFqaUwB8eiOxl1XZ8KzXPmaZzmek4UrZ9dyabZICWNRAMblQlI1nK2mMlAu4YXbJ3QsYz7Dp+SIHqxdxycKFMMz6ZEjwLs3BskNZC57VwyPoXCClgSPaCJeHAuFu8FbAhVmhC3W+xbYsrNua6gppp3r0lkUYzS/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+Rsnmas; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F74BC433C7;
	Wed, 31 Jan 2024 16:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706716898;
	bh=rUVEsg7BzjLNm9d+zQc8VFaM5E+OuehU/xWapW5CtVU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=M+RsnmasBM/VPvEJEhXmK9xl61LTZfnAQ1KU46EHQcXDYWIMNM35fxJ6p8nsDePU+
	 PijmxzPl95OGe9XHL4Zr0HejOTPBzgNObxrt/ulkhF/HYmlS033VoIO33PltUN/a1O
	 bCM73ozm2EqHBmjRPa480xl3Q9X/QXOtfJeSFSGlcE6UqU9saShGyJtWKuY5vk4vUg
	 NfhUaUeWWGisViba+j7IX3zUWS48APAV9Z0Q8eEOYtSsSSQw+QZYuLnr4C8utjMuDH
	 TXiPeM/Kf00NsrwYz1d/cKvztM2pecbFDFY6Vagg8CnxlmnkysW+6kEz3w0Um0bWeV
	 IbWWVBBbWqGxw==
Date: Wed, 31 Jan 2024 10:01:36 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 5/6] dt-bindings: PCI: dwc: Add 'msg" register region
Message-ID: <20240131160136.GA587669@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130-pme_msg-v1-5-d52b0add5c7c@nxp.com>

Super nit: use matching quotes in subject.

On Tue, Jan 30, 2024 at 07:45:30PM -0500, Frank Li wrote:
> Add a outbound iATU-capable memory-region which will be use to send PCI
> message (such as pme-turn-off) to peripheral. So all platforms can use
> common method to send out pme-turn-off message by using one outbound iATU.

s/Add a outbound/Add an outbound/
s/will be use/will be used/ (also below)
s/PCI/PCIe/ (also below)
s/pme-turn-off/PME_Turn_Off/ to make it more searchable in spec (also below)

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> index 022055edbf9e6..e27d81b6a131c 100644
> --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> @@ -101,6 +101,10 @@ properties:
>              Outbound iATU-capable memory-region which will be used to access
>              the peripheral PCIe devices configuration space.
>            const: config
> +        - description:
> +            Outbound iATU-capable memory-region which will be use to send
> +            PCI message (such as pme-turn-off) to peripheral.
> +          const: msg
>          - description:
>              Vendor-specific CSR names. Consider using the generic names above
>              for new bindings.
> 
> -- 
> 2.34.1
> 

