Return-Path: <linux-pci+bounces-5113-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6729588A97A
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 17:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 991BA1C3A759
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 16:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB68916B440;
	Mon, 25 Mar 2024 14:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIy8Tezf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D6F16B423;
	Mon, 25 Mar 2024 14:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711377460; cv=none; b=sKkYI4skjkOqvZE1eN2nW22fbMGiYsYbI1ujnnU/twklTX5RHNvh98n7TXfJjg1MqtOtL2ex1HyaVQHtpIMBSV6oMA5QiweOaeAgKxRMzhJVkuWOEpNDzuI92OIGmsr6T06Sh7a0f4wFf4BwXQnolyRCsudiEHJ8XKii6vur9+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711377460; c=relaxed/simple;
	bh=onRjf8TNnnxKbpEukinv+PxWlrvYWsRWXbj+9065TiI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=uCcHigVWgVGhPl59jcPSaTBXXojm04V71ivqIb1EyNrPHQBEKdAle2YQJWKLWA2iqVsSRQUf8OoQLIrTuls5afuc6H5tjAs1iATgTJQjyFLpo1g0J8NIFoQsoj+qZlA15Na68z8IBiubMYL3VbP4Utw9rHH89Pn8+kNoHClJ1ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIy8Tezf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD6A9C433F1;
	Mon, 25 Mar 2024 14:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711377460;
	bh=onRjf8TNnnxKbpEukinv+PxWlrvYWsRWXbj+9065TiI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=OIy8Tezfr7vjlKApvzlLdl9x/9IAlZTNi8IbuxVJJEIJDM307bxfAiiFX03rew6jx
	 5Qswry5F75Fkkz1oKNVdx4J2nbKtY4XcShVEcus9lZnicasyTyxnfXw9OI92byUPdZ
	 kF0v2NCysr612g9LLir9A5zKBt51QEg9oZBDQV3hlMP3viCQA5GXhU75VPpoJujI6S
	 ESpukxkN8anYl87WTYPp7yTQePkGw88A8zuZA2dhop/fBxEb/tLaLkpIcqgKOPSJ1p
	 qZFwIUqUMbwmdHYUDAkyEqIu2ia7miGLkZf/y3aVsHiaR1Q5ccUEw5j2up2g+mHEJ3
	 DRt81EfjvJCzQ==
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
 <bartosz.golaszewski@linaro.org>,
    ath11k@lists.infradead.org, Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v6 04/16] dt-bindings: net: wireless: qcom,ath11k:
 describe the ath11k on QCA6390
References: <20240325131624.26023-1-brgl@bgdev.pl>
	<20240325131624.26023-5-brgl@bgdev.pl> <87r0fy8lde.fsf@kernel.org>
	<CAMRc=Mc2Tc8oHr5NVo=aHAADkJtGCDAVvJs+7V-19m2zGi-vbw@mail.gmail.com>
Date: Mon, 25 Mar 2024 16:37:29 +0200
In-Reply-To: <CAMRc=Mc2Tc8oHr5NVo=aHAADkJtGCDAVvJs+7V-19m2zGi-vbw@mail.gmail.com>
	(Bartosz Golaszewski's message of "Mon, 25 Mar 2024 15:09:12 +0100")
Message-ID: <87frwe8jiu.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Bartosz Golaszewski <brgl@bgdev.pl> writes:

> On Mon, Mar 25, 2024 at 2:57=E2=80=AFPM Kalle Valo <kvalo@kernel.org> wro=
te:
>
>>
>> Bartosz Golaszewski <brgl@bgdev.pl> writes:
>>
>> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>> >
>> > Add a PCI compatible for the ATH11K module on QCA6390 and describe the
>> > power inputs from the PMU that it consumes.
>> >
>> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>
>> [...]
>>
>> > +allOf:
>> > +  - if:
>> > +      properties:
>> > +        compatible:
>> > +          contains:
>> > +            const: pci17cb,1101
>> > +    then:
>> > +      required:
>> > +        - vddrfacmn-supply
>> > +        - vddaon-supply
>> > +        - vddwlcx-supply
>> > +        - vddwlmx-supply
>> > +        - vddrfa0p8-supply
>> > +        - vddrfa1p2-supply
>> > +        - vddrfa1p7-supply
>> > +        - vddpcie0p9-supply
>> > +        - vddpcie1p8-supply
>>
>> I don't know DT well enough to know what the "required:" above means,
>> but does this take into account that there are normal "plug&play" type
>> of QCA6390 boards as well which don't need any DT settings?
>
> Do they require a DT node though for some reason?

You can attach the device to any PCI slot, connect the WLAN antenna and
it just works without DT nodes. I'm trying to make sure here that basic
setup still works.

Adding also Johan and ath11k list. For example, I don't know what's the
plan with Lenovo X13s, will it use this framework? I guess in theory we
could have devices which use qcom,ath11k-calibration-variant from DT but
not any of these supply properties?

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

