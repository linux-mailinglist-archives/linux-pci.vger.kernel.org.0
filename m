Return-Path: <linux-pci+bounces-912-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C6B811F92
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 20:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA80CB20ADE
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 19:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5CC6828A;
	Wed, 13 Dec 2023 19:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/X7bD8J"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAEE5FF18;
	Wed, 13 Dec 2023 19:57:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F1EAC433C8;
	Wed, 13 Dec 2023 19:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702497465;
	bh=nI+LIVGF1GW7NDDMlrV2VjRUQx18LLMDaUCPSY9bsk4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=T/X7bD8Jdh2xNZJR9uEBE9z06LT3goHniJiJc9mJdPPiqHfM0zJc7/DNwrRy9wZiH
	 8rhNzHcJ6SZLYAP9uK2URisV21Mii3Zpo+2Z0FjpDu9HhrSvP+lxHe8o440jLyHuuR
	 6YTkIpYoySP0HztG3rLgKwr0gsOxJrlf8QCUDD6YsNFwrInY6yiM3VHhBCqmm4cy70
	 OtFEl4RuQNBLI4qB5J/QPoRjSiuaFAkRYXGSb2+fCZ+vximrVbCW00AGuHpZYMaBEZ
	 j4+mT9CVm4BeHJ4rojA7e6HpiGKA/78QeRW5Jh8UR/EHwgSdNhYs/wkwLFCzbDhGok
	 kqw5LVzRREbkQ==
Date: Wed, 13 Dec 2023 13:57:43 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: hongxing.zhu@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-imx@nxp.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/4] PCI: imx6: Add pci host wakeup support on imx
 platforms.
Message-ID: <20231213195743.GA1055303@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213092850.1706042-2-sherry.sun@nxp.com>

Drop period at the end of subject line.  It only adds the possibility
of unnecessary line wrapping in git log.

On Wed, Dec 13, 2023 at 05:28:47PM +0800, Sherry Sun wrote:
> Add pci host wakeup feature for imx platforms.

s/pci/PCI/
s/imx/i.MX/ (based on how nxp.com web pages refer to it)

> Example of configuring the corresponding dts property under the PCI
> node:
> wake-gpios = <&gpio5 21 GPIO_ACTIVE_LOW>;

Add newline between paragraphs or wrap into a single paragraph.

> +		/* host wakeup support */
> +		imx6_pcie->host_wake_irq = -1;

AFAIK, 0 is an invalid IRQ value.  So why not drop this assignment
since imx6_pcie->host_wake_irq is 0 by default since it was allocated
with devm_kzalloc(), and test like this elsewhere:

  if (imx6_pcie->host_wake_irq) {
    enable_irq_wake(imx6_pcie->host_wake_irq)

> +		host_wake_gpio = devm_gpiod_get_optional(dev, "wake", GPIOD_IN);
> +		if (IS_ERR(host_wake_gpio))
> +			return PTR_ERR(host_wake_gpio);
> +
> +		if (host_wake_gpio != NULL) {

  if (host_wake_gpio)

Bjorn

