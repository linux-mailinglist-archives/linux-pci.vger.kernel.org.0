Return-Path: <linux-pci+bounces-3658-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DD3858D84
	for <lists+linux-pci@lfdr.de>; Sat, 17 Feb 2024 07:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CA34282B8E
	for <lists+linux-pci@lfdr.de>; Sat, 17 Feb 2024 06:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872CD1BDD8;
	Sat, 17 Feb 2024 06:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUalBi4V"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3974ADF44;
	Sat, 17 Feb 2024 06:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708151702; cv=none; b=KhS9/UYcTPgsyQsttcZeflvpZRfMTc7XhzqnTdsM4ud5G2DEKJYnjX6x2g+UCc5qfRGGZLaVHLqtiZqBoXY9Y6lKpsLqskKcKK/bFVMaMINdMJD7UEjfyjz/77uX6FRTXxg58RLqsM4W/odxt0eTl+rKwLz247lHJ5bWAyKdObQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708151702; c=relaxed/simple;
	bh=P9v5bwlS7CEx0RGF6l5RaEMQEbJkoeMSl0AVCOm8vZY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=HLWqx8eysvc2DJCFXMh1MoLJeAm5dMzVZ2GkAzp4wFfPs5c9177WWC3khY2GDHtWZAYnKk6NpDNLcYDJEwE9SK9gpq3ZyFgczqC4yEHKMlLw1dkuDrcavW8nHdojWzNuqJD1p/KQLLcaM8icd+Scg85RvRSurzAXCbW+VcTesDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUalBi4V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3882C433C7;
	Sat, 17 Feb 2024 06:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708151701;
	bh=P9v5bwlS7CEx0RGF6l5RaEMQEbJkoeMSl0AVCOm8vZY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=PUalBi4VP+acTF5G4CtuSGC3cR8sQbK3vDeWzN46QQLixXZLxuyUXwthX0sl9EHUf
	 LpsdqZzpsOwOxRH2yD+qTppUTUgQpSLvZFiQFDr+s/glNQTDza4ujEzNd4pCrodZnh
	 yDMnaOJgndboanGlyO53uXPVLI/apL+vO6VZAnbNkF1rgdngRR9+5zYFltwnFPJQAr
	 crS5pF1cQ52gePqMPhy9D5jtr4rXQGmB7vDXDyA3i8lj11G0eOdB1QkcvahmudtwA9
	 eJwEXWM05Jxj6HaI3LZpt0woUQjXrhmDdLHa9fJ+XBHqCuiiBz2v5n4PeZbD9mpVXq
	 F7OZs8l+23rhA==
From: Kalle Valo <kvalo@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
    Jeff Johnson <quic_jjohnson@quicinc.com>
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
Subject: Re: [PATCH v5 06/18] dt-bindings: new: wireless: describe the
 ath12k PCI module
References: <20240216203215.40870-1-brgl@bgdev.pl>
	<20240216203215.40870-7-brgl@bgdev.pl>
Date: Sat, 17 Feb 2024 08:34:52 +0200
In-Reply-To: <20240216203215.40870-7-brgl@bgdev.pl> (Bartosz Golaszewski's
	message of "Fri, 16 Feb 2024 21:32:03 +0100")
Message-ID: <87cysvd2er.fsf@kernel.org>
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
>  .../net/wireless/qcom,ath12k-pci.yaml         | 103 ++++++++++++++++++
>  1 file changed, 103 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k-pci.yaml
>
> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-pci.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-pci.yaml
> new file mode 100644
> index 000000000000..063c576b99a0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-pci.yaml
> @@ -0,0 +1,103 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (c) 2024 Linaro Limited
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/wireless/qcom,ath12k-pci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies ath12k wireless devices (PCIe)
> +
> +maintainers:
> +  - Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Jeff and me are the ath12k driver maintainers so shouldn't we listed
here as well?

Jeff, this reminds me that we should add you to qcom,ath10k.yaml,
qcom,ath11k-pci.yaml and qcom,ath11k.yaml as maintainer.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

