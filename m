Return-Path: <linux-pci+bounces-1470-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AE281F186
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 20:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E11C51C22591
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 19:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E1A46B88;
	Wed, 27 Dec 2023 19:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5TSRvAA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F96046B87;
	Wed, 27 Dec 2023 19:08:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4118FC433C7;
	Wed, 27 Dec 2023 19:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703704095;
	bh=ATu15DdJu3KphR7LFYKeEXCMXYokrV8F6bk6Aa0fZc4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=F5TSRvAADaGRV2HGx2D8sugO90Z38C23ezQdcbj1FEmLF7yydZRoQ7gLUjrUxqJXS
	 YlMF0p4wMPtmIXqNH3X52dm5iFwSujhlJ0qk6m6/UFaeax70WR+jE2CJq4XioV28fT
	 HTWpu9uvSn/bZMt1tn2YKYqmV2jHOCyh96lm/qfaEZwRFsfTkHqnpta//0R+3eJrJT
	 v7mZqkGHrgCW0rov70FInyDP90P3Yn/S5dPWJ+531cfLshH4RdInaEKHfqqUxqUdXo
	 e74d5UuX9nTFcm8ZrltAKVoBrXYubi1XgzT7IZvQfYConmO1R9m1hcXTO3Z1/1uOvO
	 41IlJFs3gH6ow==
Date: Wed, 27 Dec 2023 13:08:13 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Conor Dooley <conor@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
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
Message-ID: <20231227190813.GA1508471@bhelgaas>
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

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/pci.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
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

