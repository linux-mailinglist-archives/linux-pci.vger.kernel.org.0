Return-Path: <linux-pci+bounces-932-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 418698126D1
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 06:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E13731F219EB
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 05:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276476110;
	Thu, 14 Dec 2023 05:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nKrYKE8U"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955C2F5
	for <linux-pci@vger.kernel.org>; Wed, 13 Dec 2023 21:13:39 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-203061bbf3aso1774169fac.3
        for <linux-pci@vger.kernel.org>; Wed, 13 Dec 2023 21:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702530819; x=1703135619; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tGvsJDQAMzLezaJvKe+SydOVs1hJQDGaynKlMwoskT4=;
        b=nKrYKE8Uf3UL7w0vaBWQi2gBRLEIiBZfJH50f9E2d5qKLJtbbyBWNCsvC7qT6W3sYC
         eg4yaoNsac3k94gxt8H68ThiL6xthPpgbr+nh//+oT2HH2H+spOBXkmISH07n0cA9p7/
         /1ziGdf/L0PhBDcbxGVoYpbMwEbqei+sw/J5ture6HUUTcm0X4LeFRSP+E2eOuQ50y2x
         tnn0Q5GjEoER16bjBZnjF4d3tJEjXKOXWXyaBtrg9ogrF75kpYAfYXZA+/cC75BsyfC6
         MFEGGSUHwwsmUpwVK3HZ9V+BjwNle9f19nykV42O5F+FGwL8Fqvfx2P05CXl3I9eA2rx
         OXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702530819; x=1703135619;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tGvsJDQAMzLezaJvKe+SydOVs1hJQDGaynKlMwoskT4=;
        b=hpmKGidVYrD0WwkQliWIpMgt/uW9GfTqF7HM+TDAuMafeiJhTM8LsG71EUIdV+hX6f
         ii0I4M6VhcBY9DiofWn4fQZQbAIBdx1RCfb8Gi4LznJeibg21k/QLpYYp3i6eSn6ALLp
         EP00pxXkBaAnqRVcRKLAVl1CZyaKr3hs2vfObyM8paNCPKDqi/aOYYc4bsLSXXT7r7fB
         eUawty3rhnz3uaDa3704J66LRIOIRBPfkw+ZWAKT1kwlmZakP5mmiDEtm+/fhO87jo+z
         8aEcYJN5ymM2PDfPGLSj19NTdikFE56CcVdBywx7bKy+x2N48N95NMlDgXWJcPJMhiFW
         irjQ==
X-Gm-Message-State: AOJu0YzhC5g6Hd7SoxjMsW/n5HtNzvg++KYhwZRyDua8e+agA2pyHDMv
	/9oQGRfmrULbhmMrsZicpo9t
X-Google-Smtp-Source: AGHT+IF7Jn4S+prGJxVJcS2oGK9Fh6M9OUtE75CGnfrjrN6KWZmfHgWTJpIwPzVP3dRI2hzJ3wX4Jw==
X-Received: by 2002:a05:6870:4987:b0:1fb:75a:778f with SMTP id ho7-20020a056870498700b001fb075a778fmr10833283oab.64.1702530818876;
        Wed, 13 Dec 2023 21:13:38 -0800 (PST)
Received: from thinkpad ([117.213.102.12])
        by smtp.gmail.com with ESMTPSA id n2-20020a170902d2c200b001bf044dc1a6sm11413219plc.39.2023.12.13.21.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 21:13:38 -0800 (PST)
Date: Thu, 14 Dec 2023 10:43:28 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: hongxing.zhu@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-imx@nxp.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/4] PCI: imx6: Add pci host wakeup support
Message-ID: <20231214051328.GD2938@thinkpad>
References: <20231213092850.1706042-1-sherry.sun@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231213092850.1706042-1-sherry.sun@nxp.com>

On Wed, Dec 13, 2023 at 05:28:46PM +0800, Sherry Sun wrote:
> Add pci host wakeup feature for imx platforms. The host wake pin is a
> standard feature in the PCIe bus specification, so we can add this
> property under PCI dts node to support the host gpio wakeup feature.
> 
> Example of configuring the corresponding dts property under the PCI node:
>     wake-gpios = <&gpio5 21 GPIO_ACTIVE_LOW>;
> 

As you mentioned, WAKE# is a standard sideband signal defined in the PCI spec.
So the support for handling it has to be in the PCI core layer, not in the
host controller drivers.

There is already a series floating to add support for WAKE# in PCI core. Please
take a look:

https://lore.kernel.org/linux-pci/20230208111645.3863534-1-mmaddireddy@nvidia.com/

- Mani

> ---
> changes in V2:
> 1. Rename host-wake-gpio property to wake-gpios.
> 2. Improve the wake-gpios property description in the dt-binding doc to avoid
> confusion.
> 3. Remove unnecessary debugging info in host_wake_irq_handler().
> 4. Remove unnecessary imx6_pcie->host_wake_irq = -1 resetting in error paths.
> 5. Use dev_err_probe() to simplify error path code.
> ---
> 
> Sherry Sun (4):
>   PCI: imx6: Add pci host wakeup support on imx platforms.
>   dt-bindings: imx6q-pcie: Add wake-gpios property
>   arm64: dts: imx8mp-evk: add wake-gpios property for pci bus
>   arm64: dts: imx8mq-evk: add wake-gpios property for pci bus
> 
>  .../bindings/pci/fsl,imx6q-pcie.yaml          |  6 ++
>  arch/arm64/boot/dts/freescale/imx8mp-evk.dts  |  2 +
>  arch/arm64/boot/dts/freescale/imx8mq-evk.dts  |  2 +
>  drivers/pci/controller/dwc/pci-imx6.c         | 60 +++++++++++++++++++
>  4 files changed, 70 insertions(+)
> 
> -- 
> 2.34.1
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

