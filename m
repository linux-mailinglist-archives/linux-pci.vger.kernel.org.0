Return-Path: <linux-pci+bounces-1935-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBD7828A36
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 17:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF8DD1F2604C
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 16:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1486A3A27B;
	Tue,  9 Jan 2024 16:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4dkcEVL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A3E3A26E;
	Tue,  9 Jan 2024 16:43:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF17C433F1;
	Tue,  9 Jan 2024 16:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704818629;
	bh=yAp04RHGBK3kZbfdthXQtiaJrJ2VNSMii5hP7oiD+zw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=G4dkcEVL0oWynRladsUPhZwHfdDo8UD+5c464yEtzLCtGIVanqhEeQwe1/n5CTgM0
	 B2CqdYV6p+V44I07Mt9gSRhS+Lqvp8DD7HA7Nfj9henMfX/qHATwgT78HqR0qEPClw
	 fgITg/4pAARBbYA4IiAgLsqB+Sy8geWKI67CP4JUDhbWPzB29ctC5MQ13mXgT3Yxme
	 yu852Wes/t5ILUt11tKtONA3zuC+OpYLEeVqZNUTFLDr2VMQkWEZNycM8LihQ1SjXl
	 kl4R6UMi1HH4Vjz/4PCmYe9xSYuEHgM5+QazTkSFUrFew/ZJNUp3fBvlb5T5rMrbLh
	 /qT6qG0+gcEGg==
From: Kalle Valo <kvalo@kernel.org>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Chen-Yu Tsai" <wenst@chromium.org>,  "Jeff Johnson"
 <quic_jjohnson@quicinc.com>,  "Bartosz Golaszewski" <brgl@bgdev.pl>,
  "David S . Miller" <davem@davemloft.net>,  "Eric Dumazet"
 <edumazet@google.com>,  "Jakub Kicinski" <kuba@kernel.org>,  "Paolo Abeni"
 <pabeni@redhat.com>,  "Rob Herring" <robh+dt@kernel.org>,  "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,  "Conor Dooley"
 <conor+dt@kernel.org>,  "Bjorn Andersson" <andersson@kernel.org>,  "Konrad
 Dybcio" <konrad.dybcio@linaro.org>,  "Catalin Marinas"
 <catalin.marinas@arm.com>,  "Will Deacon" <will@kernel.org>,  "Bjorn
 Helgaas" <bhelgaas@google.com>,  Heiko =?utf-8?Q?St=C3=BCbner?=
 <heiko@sntech.de>,  "Jernej
 Skrabec" <jernej.skrabec@gmail.com>,  "Chris Morgan"
 <macromorgan@hotmail.com>,  "Linus Walleij" <linus.walleij@linaro.org>,
  "Geert Uytterhoeven" <geert+renesas@glider.be>,  "Neil Armstrong"
 <neil.armstrong@linaro.org>,  =?utf-8?Q?N=C3=ADcolas?= F. R. A. Prado
 <nfraprado@collabora.com>,  "Marek Szyprowski" <m.szyprowski@samsung.com>,
  "Peng Fan" <peng.fan@nxp.com>,  "Robert Richter" <rrichter@amd.com>,
  "Dan Williams" <dan.j.williams@intel.com>,  "Jonathan Cameron"
 <Jonathan.Cameron@huawei.com>,  "Terry Bowman" <terry.bowman@amd.com>,
  "Kuppuswamy Sathyanarayanan"
 <sathyanarayanan.kuppuswamy@linux.intel.com>,  Ilpo =?utf-8?Q?J=C3=A4rvin?=
 =?utf-8?Q?en?=
 <ilpo.jarvinen@linux.intel.com>,  "Huacai Chen" <chenhuacai@kernel.org>,
  "Alex Elder" <elder@linaro.org>,  "Srinivas Kandagatla"
 <srinivas.kandagatla@linaro.org>,  "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>,  linux-wireless@vger.kernel.org,  Netdev
 <netdev@vger.kernel.org>,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-arm-msm@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org,  linux-pci@vger.kernel.org,
  "Bartosz Golaszewski" <bartosz.golaszewski@linaro.org>
Subject: Re: [RFC 8/9] PCI/pwrseq: add a pwrseq driver for QCA6390
References: <20240104130123.37115-1-brgl@bgdev.pl>
	<20240104130123.37115-9-brgl@bgdev.pl>
	<15443d5d-6544-45d0-afeb-b23e6a041ecf@quicinc.com>
	<87jzoizwz7.fsf@kernel.org>
	<CAGXv+5FhYY+qyyT8wxY5DggvWPibfM2ypHVKQbsJZ30VkZDAkQ@mail.gmail.com>
	<87bk9uzum9.fsf@kernel.org>
	<5904461c-ca3c-4eb1-a44a-876872234545@app.fastmail.com>
Date: Tue, 09 Jan 2024 18:43:38 +0200
In-Reply-To: <5904461c-ca3c-4eb1-a44a-876872234545@app.fastmail.com> (Arnd
	Bergmann's message of "Tue, 09 Jan 2024 11:14:43 +0100")
Message-ID: <87y1cycv9h.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Arnd Bergmann" <arnd@arndb.de> writes:

> On Tue, Jan 9, 2024, at 11:09, Kalle Valo wrote:
>
>> Chen-Yu Tsai <wenst@chromium.org> writes:
>>> On Tue, Jan 9, 2024 at 5:18=E2=80=AFPM Kalle Valo <kvalo@kernel.org> wr=
ote:
>>>> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
>>>>
>>>> > On 1/4/2024 5:01 AM, Bartosz Golaszewski wrote:
>>>> >> diff --git a/drivers/pci/pcie/pwrseq/Kconfig b/drivers/pci/pcie/pwr=
seq/Kconfig
>>>> >> index 010e31f432c9..f9fe555b8506 100644
>>>> >> --- a/drivers/pci/pcie/pwrseq/Kconfig
>>>> >> +++ b/drivers/pci/pcie/pwrseq/Kconfig
>>>> >> @@ -6,3 +6,14 @@ menuconfig PCIE_PWRSEQ
>>>> >>      help
>>>> >>        Say yes here to enable support for PCIe power sequencing
>>>> >>        drivers.
>>>> >> +
>>>> >> +if PCIE_PWRSEQ
>>>> >> +
>>>> >> +config PCIE_PWRSEQ_QCA6390
>>>> >> +    tristate "PCIe Power Sequencing driver for QCA6390"
>>>> >> +    depends on ARCH_QCOM || COMPILE_TEST
>>>> >> +    help
>>>> >> +      Enable support for the PCIe power sequencing driver for the
>>>> >> +      ath11k module of the QCA6390 WLAN/BT chip.
>>>> >> +
>>>> >> +endif
>>>> >
>>>> > As I mentioned in the 5/9 patch I'm concerned that the current
>>>> > definition of PCIE_PWRSEQ and PCIE_PWRSEQ_QCA6390 will effectively h=
ide
>>>> > the fact that QCA6390 may need additional configuration since the me=
nu
>>>> > item will only show up if you have already enabled PCIE_PWRSEQ.
>>>> > Yes I see that these are set in the defconfig in 9/9 but I'm concern=
ed
>>>> > about the more generic case.
>>>> >
>>>> > I'm wondering if there should be a separate config QCA6390 within at=
h11k
>>>> > which would then select PCIE_PWRSEQ and PCIE_PWRSEQ_QCA6390
>>>>
>>>> Or is it possible to provide an optional dependency in Kconfig (I guess
>>>
>>> imply PCIE_PWRSEQ
>>> imply PCIE_PWRSEQ_QCA6390
>>> ?
>>
>> Nice, I had forgotten imply altogether. Would 'imply
>> PCIE_PWRSEQ_QCA6390' in ath11k Kconfig be enough to address Jeff's
>> concern?
>
> Please don't use imply (ever), it doesn't normally do
> what you want. In this case, the only effect the
> 'imply' has is to change the default of the PCIE_PWRSEQ_QCA6390
> option when a defconfig contains QCA6390.
>
> If this is indeed what you want, it's still better to do the
> equivalent expression in PCIE_PWRSEQ_QCA6390 rather than ATH11K:
>
> config PCIE_PWRSEQ_QCA6390
>       tristate "PCIe Power Sequencing driver for QCA6390"
>       default ATH11K && ARCH_QCOM

Sounds good to me but should it be 'default ATH11K_PCI && ARCH_QCOM'? My
understanding is that we don't need PWRSEQ for ATH11K_AHB devices.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

