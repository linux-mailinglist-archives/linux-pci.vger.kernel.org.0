Return-Path: <linux-pci+bounces-1912-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FB88282C4
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 10:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBC5E1F24555
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 09:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E8F29CE9;
	Tue,  9 Jan 2024 09:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="naGn6h5G"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8822EAF9;
	Tue,  9 Jan 2024 09:14:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13FA4C433F1;
	Tue,  9 Jan 2024 09:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704791644;
	bh=+06NMjLMy7+S0OcYAENUNHQLBwEXKnqYTwCvjFTXoVo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=naGn6h5G/6LHXS86a+lEsUu6Z0GXyfdbelfib8WBnJgW8wCSOppf2X8p2llo/pSnM
	 /c3R7m5/EQyL4cwZNRgIVXFQmvp+KJg5lTHNLqL/ztc359qhvQaHOQeRtUOB311KjO
	 HhQVXTJw3Nhq0BvsCqw7vuEgkGvJfqo7daporh375JTpqat7AX81VZ2ZzVQ3Lan7h8
	 haEwOfoNrZmYNPjQQB9nyKmx/9LDDWJRW/1qjFZAH1XHihrWapFpeQejQx2JrvOxPN
	 NbeoHoMkTkaaIOXgmqDbamqDtjHSxyFeYCWwGTb+k2oxYqoGnLfWAWSJBpBhmIXmrs
	 X/5GNfkYry1hA==
From: Kalle Valo <kvalo@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,  "David S . Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Rob Herring
 <robh+dt@kernel.org>,  Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>,
  Bjorn Andersson <andersson@kernel.org>,  Konrad Dybcio
 <konrad.dybcio@linaro.org>,  Catalin Marinas <catalin.marinas@arm.com>,
  Will Deacon <will@kernel.org>,  Bjorn Helgaas <bhelgaas@google.com>,
  Heiko Stuebner <heiko@sntech.de>,  Jernej Skrabec
 <jernej.skrabec@gmail.com>,  Chris Morgan <macromorgan@hotmail.com>,
  Linus Walleij <linus.walleij@linaro.org>,  Geert Uytterhoeven
 <geert+renesas@glider.be>,  Arnd Bergmann <arnd@arndb.de>,  Neil Armstrong
 <neil.armstrong@linaro.org>,  =?utf-8?Q?N=C3=ADcolas?= F . R . A . Prado
 <nfraprado@collabora.com>,  Marek Szyprowski <m.szyprowski@samsung.com>,
  Peng Fan <peng.fan@nxp.com>,  Robert Richter <rrichter@amd.com>,  Dan
 Williams <dan.j.williams@intel.com>,  Jonathan Cameron
 <Jonathan.Cameron@huawei.com>,  Terry Bowman <terry.bowman@amd.com>,
  Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
  Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,  Huacai
 Chen
 <chenhuacai@kernel.org>,  Alex Elder <elder@linaro.org>,  Srini Kandagatla
 <srinivas.kandagatla@linaro.org>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  linux-wireless@vger.kernel.org,
  netdev@vger.kernel.org,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-arm-msm@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org,  linux-pci@vger.kernel.org,
  Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RFC 7/9] dt-bindings: wireless: ath11k: describe QCA6390
References: <20240104130123.37115-1-brgl@bgdev.pl>
	<20240104130123.37115-8-brgl@bgdev.pl>
	<82a669f5-259d-427c-b290-6fa1470fec79@linaro.org>
Date: Tue, 09 Jan 2024 11:13:54 +0200
In-Reply-To: <82a669f5-259d-427c-b290-6fa1470fec79@linaro.org> (Krzysztof
	Kozlowski's message of "Thu, 4 Jan 2024 16:57:52 +0100")
Message-ID: <87o7duzx65.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:

> On 04/01/2024 14:01, Bartosz Golaszewski wrote:
>
>> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
>> index 817f02a8b481..f584c25f4276 100644
>> --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
>> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
>> @@ -16,6 +16,7 @@ description: |
>>  properties:
>>    compatible:
>>      enum:
>> +      - pci17cb,1101  # QCA6390
>>        - pci17cb,1103  # WCN6855
>>  
>>    reg:
>> @@ -27,6 +28,19 @@ properties:
>>        string to uniquely identify variant of the calibration data for designs
>>        with colliding bus and device ids
>>  
>> +  enable-gpios:
>> +    description: GPIO line enabling the ATH11K module when asserted.
>> +    maxItems: 1
>> +
>> +  vddpmu-supply:
>> +    description: VDD_PMU supply regulator handle
>> +
>> +  vddpcie1-supply:
>> +    description: VDD_PCIE1 supply regulator handle
>> +
>> +  vddpcie2-supply:
>> +    description: VDD_PCIE2 supply regulator handle
>
> Looks like these are valid only for specific variant, so you should have
> allOf:if:then disallowing other properties when not applicable. The same
> applies for existing properties which might not exist on qca6390.

And it would be good to provide more information in the commit log about
the platforms where this is used, otherwise the context might not be
clear. Or maybe document that in the bindings file, not sure.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

