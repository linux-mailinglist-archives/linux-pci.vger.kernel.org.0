Return-Path: <linux-pci+bounces-1448-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD81481F003
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 17:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82C1D1F22152
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 16:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5905145BE1;
	Wed, 27 Dec 2023 16:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OabpMPYL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F854597E;
	Wed, 27 Dec 2023 16:03:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0FFC433C8;
	Wed, 27 Dec 2023 16:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703692993;
	bh=w4l0ziBQD5BKenyLSX5hoKKoL4xt66ApvAEEBRXc3BA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OabpMPYLkty7z4VERKGYdiml7+nRnd1s2Oq6cxbcv33SPQHECsKINff03ehGKjEZe
	 F9TAq5gUZRvW3GG7BvGQa8AKOjce5mnk6a0KsUB8Ppx5ey9IyCuvPXMf5InI0XgfTA
	 9+NQ2+SQz/RZITHfcQymP1rQBnVraKxMENCdz8qdXlmStrZ3Mt3NGkH98/2to87PyP
	 GjzueFKy6C3PTpvvg3yzeSDsK2vEFGJMoq94x0cn7CZwE8w8fZ15zpSo1+x+AmUcdx
	 DAvbYa4joxMw9CRw1RvZYyA/UE9esIneiJjMoxgDduFP3zcdHCtKFSUVG0hsNaIy2K
	 l7xreXFt49TtA==
Date: Wed, 27 Dec 2023 17:03:05 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Conor Dooley <conor@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Mason Huo <mason.huo@starfivetech.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: [PATCH v13 19/21] PCI: Add PCIE_RESET_CONFIG_DEVICE_WAIT_MS
 waiting time value
Message-ID: <ZYxKuVs6Pzu7D7lj@lpieralisi>
References: <20231214072839.2367-1-minda.chen@starfivetech.com>
 <20231214072839.2367-20-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214072839.2367-20-minda.chen@starfivetech.com>

On Thu, Dec 14, 2023 at 03:28:37PM +0800, Minda Chen wrote:
> From: Kevin Xie <kevin.xie@starfivetech.com>
> 
> Add the PCIE_RESET_CONFIG_DEVICE_WAIT_MS macro to define the minimum
> waiting time between exit from a conventional reset and sending the
> first configuration request to the device.
> 
> As described in PCI base specification r6.0, section 6.6.1 <Conventional
> Reset>, there are two different use cases of the value:
> 
>    - "With a Downstream Port that does not support Link speeds greater
>      than 5.0 GT/s, software must wait a minimum of 100 ms following exit
>      from a Conventional Reset before sending a Configuration Request to
>      the device immediately below that Port."
> 
>    - "With a Downstream Port that supports Link speeds greater than
>      5.0 GT/s, software must wait a minimum of 100 ms after Link training
>      completes before sending a Configuration Request to the device
>      immediately below that Port."
> 
> Signed-off-by: Kevin Xie <kevin.xie@starfivetech.com>
> Reviewed-by: Mason Huo <mason.huo@starfivetech.com>
> ---
>  drivers/pci/pci.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

This needs Bjorn's ack.

Thanks,
Lorenzo

> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 5ecbcf041179..06f1f1eb878c 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -22,6 +22,22 @@
>   */
>  #define PCIE_PME_TO_L2_TIMEOUT_US	10000
>  
> +/*
> + * As described in PCI base specification r6.0, section 6.6.1 <Conventional
> + * Reset>, there are two different use cases of the value:
> + *
> + * - "With a Downstream Port that does not support Link speeds greater
> + *    than 5.0 GT/s, software must wait a minimum of 100 ms following exit
> + *    from a Conventional Reset before sending a Configuration Request to
> + *    the device immediately below that Port."
> + *
> + * - "With a Downstream Port that supports Link speeds greater than
> + *    5.0 GT/s, software must wait a minimum of 100 ms after Link training
> + *    completes before sending a Configuration Request to the device
> + *    immediately below that Port."
> + */
> +#define PCIE_RESET_CONFIG_DEVICE_WAIT_MS	100
> +
>  extern const unsigned char pcie_link_speed[];
>  extern bool pci_early_dump;
>  
> -- 
> 2.17.1
> 

