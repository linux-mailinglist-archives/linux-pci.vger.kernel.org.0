Return-Path: <linux-pci+bounces-33838-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A09EB21E58
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 08:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5C8B3AEE1E
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 06:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CFD4315A;
	Tue, 12 Aug 2025 06:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEBiK2bM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6827C311C18;
	Tue, 12 Aug 2025 06:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754980330; cv=none; b=iO+ysfzYjjGr/GACcXd7/CM8V73Esi/pT8y3xodAUnSpHwEvfL9Y5mK3lEEZxqvk45p/ieig35XIwyyhHUlQZ9nWHlSDLIo44djXFxvIea1Z4YbEnCYY9jATtEEJC+kSDLFbuLhw5iEha4Rr+PLEGvw0NIxIh/5RmXo2qMXXZcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754980330; c=relaxed/simple;
	bh=otaBZh9TNVNUn4n+KFk4zIkvpGN9iEpnVss/ZcBnHBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QR4o0jiL0D+hS8edFtIdjvmYVzTzTE8V1J1z7h/reRFEywtYtNpXFZK8L0uwroGetXkSem9CC0Ypr+duPlTiNigYlag42GDzCXPC6VxQf0bV+WqjWCKAVefxJ9087rZyAGCM2jCnk71o6gq9nFMbRNOBCYnAH8aPtdyXlbFodSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEBiK2bM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F55EC4CEF0;
	Tue, 12 Aug 2025 06:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754980330;
	bh=otaBZh9TNVNUn4n+KFk4zIkvpGN9iEpnVss/ZcBnHBM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dEBiK2bMfsD5IpNQj20sm4pOp7cKkzzvO9rSw4Gc4mSvnL/LXBIClBjlBy62c4S7M
	 rfwQdg/BnNkCGdBP3kGdr9AKfczzi+2jHXCQmDZP17F55Y1pNSNbQltkKeSP1idjn4
	 Mz/44PhO+5nt8U3jsM3jW3W07IqePKAdArDZy70bBM92HV6nONtFFedk17iGAHAVIx
	 KvK3rhg/cIVEyjTpRr82UQpTH5O2+4tWhJPTQmil/LFV1jsSS+vRu0Gcq/FuawBsC1
	 SiPbsZ3LBDb8cB8e6Apc5MLF6hlQvArB64uhltW9jZIlumYpHy17P5kdYmjK/tZUeh
	 2yCqq2tPYPW9A==
Message-ID: <4a47b758-5c20-4e30-bc61-206acd48bdd0@kernel.org>
Date: Tue, 12 Aug 2025 08:32:03 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/12] dt-bindings: PCI: Split exynos host into two
 files
To: Shradha Todi <shradha.t@samsung.com>, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org
Cc: mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
 robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
 krzk+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com,
 vkoul@kernel.org, kishon@kernel.org, arnd@arndb.de,
 m.szyprowski@samsung.com, jh80.chung@samsung.com, pankaj.dubey@samsung.com
References: <20250811154638.95732-1-shradha.t@samsung.com>
 <CGME20250811154721epcas5p26c9e2880ca55a470f595d914b4030745@epcas5p2.samsung.com>
 <20250811154638.95732-7-shradha.t@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250811154638.95732-7-shradha.t@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/08/2025 17:46, Shradha Todi wrote:
> The current Exynos PCIe yaml binding file is hard to reuse by
> other Samsung SoCs. Refactoring it by:
>  - Moving common Samsung PCIe properties into samsung,exynos-pcie.yaml
>  - Creating a dedicated samsung,exynos5433-pcie.yaml file for properties
>    and constraints specific to the Exynos5433 SoC
> 
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> ---
>  .../bindings/pci/samsung,exynos-pcie.yaml     | 70 +--------------
>  .../bindings/pci/samsung,exynos5433-pcie.yaml | 89 +++++++++++++++++++
>  2 files changed, 91 insertions(+), 68 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/samsung,exynos5433-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml b/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
> index f20ed7e709f7..fd0b97b30821 100644
> --- a/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
> @@ -11,7 +11,7 @@ maintainers:
>    - Jaehoon Chung <jh80.chung@samsung.com>
>  
>  description: |+
> -  Exynos5433 SoC PCIe host controller is based on the Synopsys DesignWare
> +  Samsung SoCs PCIe host controller is based on the Synopsys DesignWare
>    PCIe IP and thus inherits all the common properties defined in
>    snps,dw-pcie.yaml.
>  
> @@ -19,9 +19,6 @@ allOf:
>    - $ref: /schemas/pci/snps,dw-pcie.yaml#
>  
>  properties:
> -  compatible:
> -    const: samsung,exynos5433-pcie
> -
>    reg:
>      items:
>        - description: Data Bus Interface (DBI) registers.


So the only common part left here is reg and phy? I don't think such
common file brings any value.


Best regards,
Krzysztof

