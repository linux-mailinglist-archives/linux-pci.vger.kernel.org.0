Return-Path: <linux-pci+bounces-5106-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D369488A884
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 17:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A88C1F2D5A7
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 16:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163021422D7;
	Mon, 25 Mar 2024 14:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbuS3/n5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C750412DDB2;
	Mon, 25 Mar 2024 14:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711375304; cv=none; b=ZRtXmcciNCS6rTE4+Dp2hAWOhgP6aO8dKR4eY9xnVLqK6Oikp0p9l1QPt9F2tFUq9lxFb1brKYmTSGjGpcDFapCyKCjFbwJD18UbF0BHu8NwXCtSXSrTkucXkmykacDx68nF9j5PR29H/ztert6NV+jOfCPY2ljTvw/mO8wSqmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711375304; c=relaxed/simple;
	bh=DO7jBH35/9WDTi4g3mhk+XjVvY8I/yCvQNhtDF49C3Y=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=BW4lmgHytmqsEvliqe6HJC15ItSC8JJA89rZ4J0fksHMaWc2uMTWKFFNpqBjFsgVKeD/KOCjL7HsdeeP06V/VfySFjv4g8ZD4JJQ65acUQeU+l5sR8vlCVsrQZSOI5p+s/GeJeq5FUpLi+LTfcSEcFTCcFVIHyJKDMMh1EJvRiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbuS3/n5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90712C433C7;
	Mon, 25 Mar 2024 14:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711375303;
	bh=DO7jBH35/9WDTi4g3mhk+XjVvY8I/yCvQNhtDF49C3Y=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=NbuS3/n5VaJ3t+uqiUn8hjAphJOP6TrrhjpklOG7s+HEHCvy+brGcrw7drMMfhZyH
	 3NGmYhv2ffnscuPpXBo2fsDUb03qsxtnR1/FQ6wb0zgJfel0YhFBQ+JF9R7SOnU6EP
	 rhJZtHgrpC+fOTyOCGBhe67ss7mHyEk2OlLi+PsonIHbkbrFvjFYP1dGy8JeuSe86Z
	 geJjzBaFG0ReAmT1PJGivL5pbXtJwPjdTNwxlAc2Dpx1oksqaeXxkDFCyzQCn6hc8C
	 9OrnK3dCRXAjTI010gcSTZoSSRkD68anC+i37dBeW7KnyCoIepm8mkxtLZlnt6GAht
	 xBjBjIDOXz4MQ==
From: Kalle Valo <kvalo@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Marcel Holtmann <marcel@holtmann.org>,  Luiz Augusto von Dentz
 <luiz.dentz@gmail.com>,  "David S . Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Rob Herring <robh@kernel.org>,  Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley
 <conor+dt@kernel.org>,  Bjorn Andersson <andersson@kernel.org>,  Konrad
 Dybcio <konrad.dybcio@linaro.org>,  Liam Girdwood <lgirdwood@gmail.com>,
  Mark Brown <broonie@kernel.org>,  Catalin Marinas
 <catalin.marinas@arm.com>,  Will Deacon <will@kernel.org>,  Bjorn Helgaas
 <bhelgaas@google.com>,  Saravana Kannan <saravanak@google.com>,  Geert
 Uytterhoeven <geert+renesas@glider.be>,  Arnd Bergmann <arnd@arndb.de>,
  Neil Armstrong <neil.armstrong@linaro.org>,  Marek Szyprowski
 <m.szyprowski@samsung.com>,  Alex Elder <elder@linaro.org>,  Srini
 Kandagatla <srinivas.kandagatla@linaro.org>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  Abel Vesa <abel.vesa@linaro.org>,
  Manivannan Sadhasivam <mani@kernel.org>,  Lukas Wunner <lukas@wunner.de>,
  Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
  linux-bluetooth@vger.kernel.org,  netdev@vger.kernel.org,
  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-wireless@vger.kernel.org,  linux-arm-msm@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org,  linux-pci@vger.kernel.org,
  linux-pm@vger.kernel.org,  Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v6 05/16] dt-bindings: net: wireless: describe the
 ath12k PCI module
References: <20240325131624.26023-1-brgl@bgdev.pl>
	<20240325131624.26023-6-brgl@bgdev.pl>
Date: Mon, 25 Mar 2024 16:01:33 +0200
In-Reply-To: <20240325131624.26023-6-brgl@bgdev.pl> (Bartosz Golaszewski's
	message of "Mon, 25 Mar 2024 14:16:13 +0100")
Message-ID: <87msqm8l6q.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bartosz Golaszewski <brgl@bgdev.pl> writes:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Add device-tree bindings for the ATH12K module found in the WCN7850
> package.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  .../bindings/net/wireless/qcom,ath12k.yaml    | 100 ++++++++++++++++++
>  1 file changed, 100 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
>
> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
> new file mode 100644
> index 000000000000..c0aad4815953
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
> @@ -0,0 +1,100 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (c) 2024 Linaro Limited
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/wireless/qcom,ath12k.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies ath12k wireless devices (PCIe)
> +
> +maintainers:
> +  - Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

IMHO it would be better to have just driver maintainers listed here.

> +  - Jeff Johnson <quic_jjohnson@quicinc.com>
> +  - Kalle Valo <kvalo@kernel.org>
> +
> +description:
> +  Qualcomm Technologies IEEE 802.11ax PCIe devices.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - pci17cb,1107  # WCN7850
> +
> +  reg:
> +    maxItems: 1
> +
> +  vddaon-supply:
> +    description: VDD_AON supply regulator handle
> +
> +  vddwlcx-supply:
> +    description: VDD_WLCX supply regulator handle
> +
> +  vddwlmx-supply:
> +    description: VDD_WLMX supply regulator handle
> +
> +  vddrfacmn-supply:
> +    description: VDD_RFA_CMN supply regulator handle
> +
> +  vddrfa0p8-supply:
> +    description: VDD_RFA_0P8 supply regulator handle
> +
> +  vddrfa1p2-supply:
> +    description: VDD_RFA_1P2 supply regulator handle
> +
> +  vddrfa1p8-supply:
> +    description: VDD_RFA_1P8 supply regulator handle
> +
> +  vddpcie0p9-supply:
> +    description: VDD_PCIE_0P9 supply regulator handle
> +
> +  vddpcie1p8-supply:
> +    description: VDD_PCIE_1P8 supply regulator handle
> +
> +required:
> +  - compatible
> +  - reg
> +  - vddaon-supply
> +  - vddwlcx-supply
> +  - vddwlmx-supply
> +  - vddrfacmn-supply
> +  - vddrfa0p8-supply
> +  - vddrfa1p2-supply
> +  - vddrfa1p8-supply
> +  - vddpcie0p9-supply
> +  - vddpcie1p8-supply

Same comment here as in patch 4. There are also ath12k PCI devices which
don't need DT at all. I don't know if that should be reflected in the
bindings doc but I want to point out this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

