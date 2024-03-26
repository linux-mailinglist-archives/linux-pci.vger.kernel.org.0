Return-Path: <linux-pci+bounces-5187-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B61088C66D
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 16:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CAFC1C2E59C
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 15:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CEA13C696;
	Tue, 26 Mar 2024 15:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OnsBfmYQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF32762F7;
	Tue, 26 Mar 2024 15:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711465969; cv=none; b=laRkC1630F4hMHLH7/SamR0l5EP4a2epN23kHVbt4FkxGS7B9TA+qX0Er5pEUo5o0/RNnB9DtdXQxnAB/bjANHYS0yHGKTISTh4fTykok/hI70wZw9lNPVJZ2k75NCj0nV1L8Mf54fpWS1ZzxBvsL9PSI5EtDO/jSKBV/mcNTIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711465969; c=relaxed/simple;
	bh=ikOFR/1UVd3fugnFnAzk4C55A/EtnmPKtVt0ZnsoBy4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=AfPN7K5GX/FTcqwqobMo2TcFe0ai5goSoTaREoo8l1zfC6TiXKya/sWsnrMlB9fRRECjAecw2f1HSyFXLxU80L70Mwkdq2Jpn/Yg5eGOTNvomGn2QXMorma3br4hy6WvDe74kgYVC49HfXCCGFAROJwV4TJ7K+X45ikoVkXj4m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OnsBfmYQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B32C433C7;
	Tue, 26 Mar 2024 15:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711465968;
	bh=ikOFR/1UVd3fugnFnAzk4C55A/EtnmPKtVt0ZnsoBy4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=OnsBfmYQ3kUcVfwdwLlABczD8xqZdTvhAxEk92k45DN6zQl3R3V8BxEPB52RsIOJU
	 stjQT1G1rdii90U9qXs98IyMNHaaDTCEQRCjheQiJfv7GsfcP7WTfAP4YJC9bTC3E2
	 U4oFUkXDi460w83MY86vMBZHhUlFJ0pfP1iQycDWwr8EXMRByqPpmCcdVUZhE/Einj
	 E6YlO5SgsJNklcUdUcS8LDVPeYonQPsEUDpnoUl37oHfn/onPcn2ao3QZ3HiUzlsRv
	 MzSCIzTfANfgo2cPdqYHxv5qhQzfesdvGwwYarZJxx3Kfgylj7B1kLIkeyxpS7QNck
	 r6RdCdboYcXKQ==
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
 <bartosz.golaszewski@linaro.org>,  ath11k@lists.infradead.org,  Johan
 Hovold <johan@kernel.org>
Subject: Re: [PATCH v6 04/16] dt-bindings: net: wireless: qcom,ath11k:
 describe the ath11k on QCA6390
References: <20240325131624.26023-1-brgl@bgdev.pl>
	<20240325131624.26023-5-brgl@bgdev.pl> <87r0fy8lde.fsf@kernel.org>
	<CAMRc=Mc2Tc8oHr5NVo=aHAADkJtGCDAVvJs+7V-19m2zGi-vbw@mail.gmail.com>
	<87frwe8jiu.fsf@kernel.org>
	<CAMRc=MdCv+vTMZML-wzRQqZZavquV3DABYM4KYw-HwqS47sTyw@mail.gmail.com>
Date: Tue, 26 Mar 2024 17:12:40 +0200
In-Reply-To: <CAMRc=MdCv+vTMZML-wzRQqZZavquV3DABYM4KYw-HwqS47sTyw@mail.gmail.com>
	(Bartosz Golaszewski's message of "Mon, 25 Mar 2024 17:23:35 +0100")
Message-ID: <874jct10yf.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bartosz Golaszewski <brgl@bgdev.pl> writes:

>> >> I don't know DT well enough to know what the "required:" above means,
>> >> but does this take into account that there are normal "plug&play" type
>> >> of QCA6390 boards as well which don't need any DT settings?
>> >
>> > Do they require a DT node though for some reason?
>>
>> You can attach the device to any PCI slot, connect the WLAN antenna and
>> it just works without DT nodes. I'm trying to make sure here that basic
>> setup still works.
>>
>
> Sure, definitely. I there's no DT node, then the binding doesn't apply
> and the driver (the platform part of it) will not probe.
>
>> Adding also Johan and ath11k list. For example, I don't know what's the
>> plan with Lenovo X13s, will it use this framework? I guess in theory we
>> could have devices which use qcom,ath11k-calibration-variant from DT but
>> not any of these supply properties?
>>
>
> Good point. I will receive the X13s in a month from now. I do plan on
> upstreaming correct support for WLAN and BT for it as well.
>
> I guess we can always relax the requirements once a valid use-case appears?

I think we have such cases already now:

$ git grep ath11k-calibration-variant -- arch
arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts:     qcom,ath11k-calibration-variant = "Fairphone_5";
arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts:                     qcom,ath11k-calibration-variant = "LE_X13S";

But please do check that. I'm no DT expert :)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

