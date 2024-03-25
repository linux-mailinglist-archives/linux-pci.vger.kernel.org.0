Return-Path: <linux-pci+bounces-5105-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC21788B50C
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 00:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB69CC439E5
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 16:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7694313C9B2;
	Mon, 25 Mar 2024 13:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xl/hE/zs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B80284D33;
	Mon, 25 Mar 2024 13:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711375063; cv=none; b=Wqc2L3+1NjOdoi9de+hY3+eZo6NlvoETtdwpcLQbZ61NVzNlEybntI+3mvxcM4g/4YWzbrBsK7pK03lTYrg3shd8gfmi9JXIWsrX7B4SiI9Q5khjPD6kx6Ns4GnjJwyEsAKdP1O4iho4Xzj6M3kXO7VQ8HhrxaVLV2Y95GuD1pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711375063; c=relaxed/simple;
	bh=0IIk7fdt/ij7Y30RYxIc4VnrAUsxe7XFLjeK+gaFxHc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=t/TU1UMryzQj19zrZU+2Y8RpMt1V0+ApAkudlbCJZo6YGG8H4BEfFtJDG0PX8o3yIM8Jt0CqwvILbV2goJP2vjTXr695ifJCZgfhURDrMr3t9CQXkIJqVDtRr99Mk+pEwEIBpEytjWfs2o9MYDgusB5GX+Fb2JFuoemVFCOVhfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xl/hE/zs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5954C433F1;
	Mon, 25 Mar 2024 13:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711375062;
	bh=0IIk7fdt/ij7Y30RYxIc4VnrAUsxe7XFLjeK+gaFxHc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Xl/hE/zsFcn+ly77x4fZ3ZW5Fcq/0aXBJM4eWJY7Soms+8FR0uHNz51ckpxVOF84p
	 XROI8xNa4rDlaggLK+yGMSwjivxoa7IL293/w3IBlduPatwoyIzsiCY+o31fKTCTf7
	 LdsZtzzLHEsGhtGiDNrpCBnUwdKhDUagvU2KAQbB/of3CkNv/XRwhhcnpzdGBwhbx7
	 YVk/AnxOuf0W1U1b3ScunsyArv4+T7QDY/8OVTTSIKI71d7el/27SmZM1IzlRUp1wC
	 kCV8SVX+NJS5erHEexMcfI/snqTblbuWstFTOT9d2ZHpnCKT3ITU2NwnhhGX46rico
	 CKbAyFpjQJBAA==
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
Subject: Re: [PATCH v6 04/16] dt-bindings: net: wireless: qcom,ath11k:
 describe the ath11k on QCA6390
References: <20240325131624.26023-1-brgl@bgdev.pl>
	<20240325131624.26023-5-brgl@bgdev.pl>
Date: Mon, 25 Mar 2024 15:57:33 +0200
In-Reply-To: <20240325131624.26023-5-brgl@bgdev.pl> (Bartosz Golaszewski's
	message of "Mon, 25 Mar 2024 14:16:12 +0100")
Message-ID: <87r0fy8lde.fsf@kernel.org>
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
> Add a PCI compatible for the ATH11K module on QCA6390 and describe the
> power inputs from the PMU that it consumes.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

[...]

> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: pci17cb,1101
> +    then:
> +      required:
> +        - vddrfacmn-supply
> +        - vddaon-supply
> +        - vddwlcx-supply
> +        - vddwlmx-supply
> +        - vddrfa0p8-supply
> +        - vddrfa1p2-supply
> +        - vddrfa1p7-supply
> +        - vddpcie0p9-supply
> +        - vddpcie1p8-supply

I don't know DT well enough to know what the "required:" above means,
but does this take into account that there are normal "plug&play" type
of QCA6390 boards as well which don't need any DT settings?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

