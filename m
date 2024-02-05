Return-Path: <linux-pci+bounces-3078-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B68FB8494E0
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 08:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32EF9B24498
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 07:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BAA10A2A;
	Mon,  5 Feb 2024 07:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hags1JZq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E323910A2B
	for <linux-pci@vger.kernel.org>; Mon,  5 Feb 2024 07:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707119523; cv=none; b=QwxHpmri4pJ4FpADpqoiVnx3U5T+1UBwwnRYoKfGjuScX6dGUsRK5UzPmdhMP/e5Cz4bMfxeNJi10IPxc238VNfHlv9TpSL/ndJVmaiDXDoHM5dHLhkVN5KRUFlH2D1iw16A5lO8LF3dvmKpkHhWKu/vDeCDZbMkDK9db+qys8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707119523; c=relaxed/simple;
	bh=zp4GqDHGT8nUHBN4eXADAEfGX8Am+5KzGCSdKTbzNdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kRgbP4vMXIUx1oRLmsNMgaDoA1QkmFRoVEwv0DkAn9pWP4UiVyIM3LeV6VuJtO3DdOdY/6oWrFSRR7oXL2LWFA5NuA/F4dIB4C2z3REla07hYv67tuwcWFtYMlbjA4QHpwyty9QEsEVqvuhEWSpdqGJa6s1LrcJUQfCwbfqTZtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hags1JZq; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d040a62a76so43965901fa.0
        for <linux-pci@vger.kernel.org>; Sun, 04 Feb 2024 23:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707119519; x=1707724319; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=if6SXw+42RrN81nI/q5GVghKnM7qlBjQGDKhkDWIZDs=;
        b=hags1JZq962y03/6+T/uYm3ZE+29JWYRNCUdQd/HtP0ZMpBF3npgVXZsIi17+5daXC
         OLIh8a3hQqXA0P+gU5Jef/UZLPckrMiAhZOVrm2asWO4axRYnZzcMOhkZ1wD3H3FMJkC
         /AKe+HNNt17lNu05IhPZmOR3fbipz/9kv/HxgcjJod1/JU7TUylaluyQYcChFKbV+jia
         5ee85TOuAtiFatxi9p/RRTfRPHKpEQtvke/c7IS1R7Ju4o7rcmjX+OKDreAkbnL1ftuW
         GV3glIoqFzNpNRgWLhkvIqQIcLeis8qDYRJZXDpDpFVNaTb4BxCGdwKY37vLW4kBQLNB
         eXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707119519; x=1707724319;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=if6SXw+42RrN81nI/q5GVghKnM7qlBjQGDKhkDWIZDs=;
        b=ozxuzqqjoc0DnDuQ+Sn4LPAjoBfrA7/+ZZETmHJP11xplXTuNu4Xb5PGRvUAoNDrCU
         JHYzZmkyUjaL0kFMzsUwrMmWqa2t9q+NJ4kWwk1UqJNSh3B7j7aF5la5GrFURBnX9z6I
         tdAWRWmkIvuFRNLRVeYC6JoVPSg742ceneLbCk1t0h1+IRcBeQbQfnkFwbtH/xMDfzp8
         kCVpvq/UAiILfyfwtzU7BO+MS6lpny92hzRhE8WAgdmPStYRp+XJe0sRDeDAhEtf8T20
         t19W8Jc5GjW6S2VB3bMETs35/gmW/jAgWZg7yZZ43XD3BdE7iwFGRFhzZpyV8ot0gU+a
         wJ4Q==
X-Gm-Message-State: AOJu0YxAWr2L67aqIaegidQEOuvKCBM8wk+k4yGuXIw0M4+6wI7PQo1U
	1f5LldzxUIJkNYfvC8knhcGhMoK3ONsZJJ8W0nYfFIwxBtO+R38RR6vsiSPp51E=
X-Google-Smtp-Source: AGHT+IG946jLrw1/DKwahjEj2Aya38dWbTbCJCIYFaPX8Ke+8yIFHo4mHk77lpsmksfXQF9313WDPw==
X-Received: by 2002:a05:651c:169a:b0:2d0:4935:2f5d with SMTP id bd26-20020a05651c169a00b002d049352f5dmr5403070ljb.21.1707119518953;
        Sun, 04 Feb 2024 23:51:58 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWxmyr/IPYwsj505YkXjPFiec88BJiratulkdEAaACCId7V2QjkjzrGdYgKfmV7yUjgQNq578Hg6ILAp7d8hc30sRDaHAU7ZiIIPyxpFZdm74UXsuB42ar109eW/MOX6G4pEMCRgW8Ekp5DMK9RIms3VMik+/y9rDNshiiDFYUA5zmwQJ86XcJ8LzOHaD9ZbLVTE4+k8wnG/hKSYR4BT1Ek9sdLT1F9la5x0dLhS3OlpWuQ1Oa2WZCjbinb49lx3jyxIYWXe1x1AvRtvv6QvsnAH2xS606tn0UbkNZtlyY4eBgau3eQ8VXisbEeOH9qRuLcZa/Rzun4/USJ8jZte+RaNskBWPBj4qYTmYcT5lMKyhtO9Y+TPwc7ho+hbLalujGhFBRLcOX/klmTa+bYjEuxbxOB4/xz6GaOdYVSxbYxS8nzeU2kqsfzVYYRqImPsc6ydpFOJIaM79csulwegVEntBU9QFbJsVnRIEuvr2C268Jmk3v1XjUnIZyjW8NqCcIc+nuY++IDg1mjU5Y9AZG0tBMDIPykzu+Dey+dc2edO6C1HQ3ZNN1H6kQNn69L+PiIu6zmfYlwkuMxso4/Ii/ZZ9n1Kper3Whq1vMYnt8J8AmlmoURtsLDCGFYzAxwPMrNjcqWZbtGMQTIBp9HlL1gZSHVdYK0mqXIoBYrq3Vq8xte/5Jj9l5lQTTOEBzmfoeDyAN63Fgw4I9VfMsl8AQGO/F3V7gOQJdaxmEoWw==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id i23-20020a056402055700b0055fba4996d9sm3610777edx.71.2024.02.04.23.51.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Feb 2024 23:51:58 -0800 (PST)
Message-ID: <d9052d43-2629-49d2-9274-ca6cf1e8dd80@linaro.org>
Date: Mon, 5 Feb 2024 08:51:56 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/9] arm64: dts: qcom: qrb5165-rb5: model the PMU of the
 QCA6391
Content-Language: en-US
To: Bartosz Golaszewski <brgl@bgdev.pl>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Alex Elder <elder@linaro.org>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Abel Vesa <abel.vesa@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-pci@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20240201155532.49707-1-brgl@bgdev.pl>
 <20240201155532.49707-3-brgl@bgdev.pl>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240201155532.49707-3-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/02/2024 16:55, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add a node for the PMU module of the QCA6391 present on the RB5 board.
> Assign its LDO power outputs to the existing Bluetooth module. Add a
> node for the PCIe port to sm8250.dtsi and define the WLAN node on it in
> the board's .dts and also make it consume the power outputs of the PMU.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 128 +++++++++++++++++++++--
>  arch/arm64/boot/dts/qcom/sm8250.dtsi     |  10 ++
>  2 files changed, 127 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> index cd0db4f31d4a..fab5bebafbad 100644
> --- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> +++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> @@ -108,6 +108,87 @@ lt9611_3v3: lt9611-3v3 {
>  		regulator-always-on;
>  	};
>  
> +	qca6390_pmu: pmu@0 {

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

Best regards,
Krzysztof


