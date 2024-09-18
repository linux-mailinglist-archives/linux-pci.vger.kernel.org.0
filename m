Return-Path: <linux-pci+bounces-13280-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F52597B9FE
	for <lists+linux-pci@lfdr.de>; Wed, 18 Sep 2024 11:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A3BE285411
	for <lists+linux-pci@lfdr.de>; Wed, 18 Sep 2024 09:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B66916EB7C;
	Wed, 18 Sep 2024 09:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZmLy7zG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1601304BA;
	Wed, 18 Sep 2024 09:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726650708; cv=none; b=oMuTeXS/1yyunBebzbzYWCP03Hr1sHNxz0VVnp06jRmVrUc6GJCfGIImJVR7/82oz730G8FCNpB+LHgLwkRedffZspMsZmgBS398wIW9u6pLnu+/b+wFbSrIY9VbSzCP6aefTSy+oaEAyFCqlDk47Nx6VfVYBBsjF97TyYSK3cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726650708; c=relaxed/simple;
	bh=0ijlviExnt3f+hLMD0CMjM7Y8g6fw5+mcJmUJWlUdiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EagyAf6TrGK3q1NitEKz3zhNJHM6lepRICMDUb9p7sfWkFpcj9zqT8+/j1QyOw+Z4yLzosAhOPQVlKuXhLXymbPMJIkocxCjDcfd8dq7L5F9uIQWu16gOvwPPwEIH5qy27bFL/ZcTvt3EnbsVdj8O/HzvQ9vjp1Otobmz5/70jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZmLy7zG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F31E9C4CEC3;
	Wed, 18 Sep 2024 09:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726650707;
	bh=0ijlviExnt3f+hLMD0CMjM7Y8g6fw5+mcJmUJWlUdiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iZmLy7zGUI3CzLlWYB+bnhv4F/f7eaDqfSoBXjEb7ARm/Dh6aFsXhlKUFJxSZWkGe
	 LVgU5Voavzwbeist7WEjpiVwHFKr7IrX3QKS9Hdxp7aft3qxYzuV8Ftk/9535pdKTu
	 86uZfzGgFwaqPVUEcjZ3OhVQfvZzKbbDKbujyfZlG7I6ZWfryJ4ZumF6rKBHirJr7w
	 51osgRDH24SRFaQLG4qAPsKH/Dqnkmypkd0xP6r17hatutaOK9EU62MpwuX0evT09/
	 pTKHRCvvc0TZpqrdYQsvVCsHirisXtOUkrJUQVI1aq/C6Df3v+OE3YpeSM+1esqq3D
	 pSJ8MUfN4mA2Q==
Date: Wed, 18 Sep 2024 11:11:44 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Bao Cheng Su <baocheng.su@siemens.com>, 
	Hua Qian Li <huaqian.li@siemens.com>, Diogo Ivo <diogo.ivo@siemens.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v6 2/7] dt-bindings: PCI: ti,am65: Extend for use with PVU
Message-ID: <7qybwyvcjratnxvumvrjk7kjm6aiki27f2lymqaon5e6jljv4w@gqqzygmsprnp>
References: <cover.1725901439.git.jan.kiszka@siemens.com>
 <de3465dc41f8a8f584a1302f99777cf5d6a8a05d.1725901439.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <de3465dc41f8a8f584a1302f99777cf5d6a8a05d.1725901439.git.jan.kiszka@siemens.com>

On Mon, Sep 09, 2024 at 07:03:55PM +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> The PVU on the AM65 SoC is capable of restricting DMA from PCIe devices
> to specific regions of host memory. Add the optional property
> "memory-regions" to point to such regions of memory when PVU is used.
> 
> Since the PVU deals with system physical addresses, utilizing the PVU
> with PCIe devices also requires setting up the VMAP registers to map the
> Requester ID of the PCIe device to the CBA Virtual ID, which in turn is
> mapped to the system physical address. Hence, describe the VMAP
> registers which are optional unless the PVU shall be used for PCIe.
 
> +  memory-region:
> +    maxItems: 1
> +    description: |
> +      phandle to a restricted DMA pool to be used for all devices behind
> +      this controller. The regions should be defined according to
> +      reserved-memory/shared-dma-pool.yaml.
> +      Note that enforcement via the PVU will only be available to
> +      ti,am654-pcie-rc devices.
> +
>  required:
>    - compatible
>    - reg
> @@ -89,6 +102,13 @@ then:
>      - power-domains
>      - msi-map
>      - num-viewport

You could add here schema expressing dependency, e.g.
if:
  properties:
    required:
      - memory-region
then:
  properties:
    reg:
      minItems: 6
    reg-names:
      minItems: 6

If I got your commit msg correctly.

Anyway, it's fine as is.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


