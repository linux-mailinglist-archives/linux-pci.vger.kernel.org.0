Return-Path: <linux-pci+bounces-1921-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CCA8283C6
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 11:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E6991F24E30
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 10:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2891436084;
	Tue,  9 Jan 2024 10:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Z4h6tGUu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="swZvUjVR"
X-Original-To: linux-pci@vger.kernel.org
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C90364A3;
	Tue,  9 Jan 2024 10:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailnew.nyi.internal (Postfix) with ESMTP id 4255E58098D;
	Tue,  9 Jan 2024 05:15:05 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 09 Jan 2024 05:15:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1704795305;
	 x=1704802505; bh=GabU/xJKPT7prMOI8ftxVSLypGy/Wo5U52O4xaZUqdU=; b=
	Z4h6tGUutV+LgpasMnunV6k3fxPBKR0pgIFigmfW8zl48tJ1/IvZASco4mODLM0z
	MoWjgQ/+MztBbf0TCCF/aBEF0/zfCgH5OPKEI2bf4gGhhUeekWTNcWFwX4nywkZ3
	jdfL9AVRVxAeXXmvtdsKEX+oxgX0Y5/B0BCa8dQ0IXCgxjQ9Zo+uQmUGqjAx6DnC
	XygT2jR3/5df3dJyKQn4kOCbi63JFLzcCi8r9z240tjLg+ayFQSd6LWPacu4gMx0
	irin0QbqwzWtpbG3182P3Airfbh6nsXxLXWp/AYil49d6d1jnbLVUt1xSvR1Jj5A
	pP2x1T10sygiw8Cj3etJCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1704795305; x=
	1704802505; bh=GabU/xJKPT7prMOI8ftxVSLypGy/Wo5U52O4xaZUqdU=; b=s
	wZvUjVRe0D7N+aiUQHGG3QiIvViin3sLtWwfIdkt7EI0VfJB6zGKieph+wImrD6J
	zBj5YpkGXO4p2gfaXxuw/EDf05gEs8EUZTB3oMQ6ObZg1Z+wpZtyP4IUX2egZW63
	AgvzzlEBJRleiIGvv7drHp+hVqdt0Ndy4yDfdOJSjt+L4siT/IExM5Fn6pjDD8Qv
	duWq9ksk+GoEDg1aK7qwBrZCbsRWc60eFH464gwGb54BhLp9t8YXZXFxNuILoACB
	A07K9fIspS5x0u3Xp+L/j/QdmNeQ8w93tGK11hgyNM9RaPcvzUDPid4Qjmt9V/Zs
	iDK8XZIZByLYfFaieWBuw==
X-ME-Sender: <xms:qBydZR9DtETz_bcvQVIDNmlIKjmvOJOLLL6iK3H3q9KivDSGIh2RfA>
    <xme:qBydZVuKmD9S2pbT4oLRrA87zkKRqCeu8lYXUhBtQ0k-0Mz3WNHa4d6JwEOHOW09r
    sGg6VBOdw-INvdHHQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehledgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:qBydZfAChY1QCOCKocXEOygo63nG2MbRcZJCMZh2DamPOM3hY1AF6A>
    <xmx:qBydZVdMadwW5mTTH9ko2uwX4stlvn66b9_oEBH94j_fHxojp_1OPw>
    <xmx:qBydZWNv44H7I1yuzq-uP6ckUN5jOba2iHrR840F4ao48cIcy42MBw>
    <xmx:qRydZQCJOskKJ1JpIMSSNhulYMBdADX_KU8hfNGAJUaawu3HApF7yg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 6BD14B6008F; Tue,  9 Jan 2024 05:15:04 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1364-ga51d5fd3b7-fm-20231219.001-ga51d5fd3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5904461c-ca3c-4eb1-a44a-876872234545@app.fastmail.com>
In-Reply-To: <87bk9uzum9.fsf@kernel.org>
References: <20240104130123.37115-1-brgl@bgdev.pl>
 <20240104130123.37115-9-brgl@bgdev.pl>
 <15443d5d-6544-45d0-afeb-b23e6a041ecf@quicinc.com>
 <87jzoizwz7.fsf@kernel.org>
 <CAGXv+5FhYY+qyyT8wxY5DggvWPibfM2ypHVKQbsJZ30VkZDAkQ@mail.gmail.com>
 <87bk9uzum9.fsf@kernel.org>
Date: Tue, 09 Jan 2024 11:14:43 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Kalle Valo" <kvalo@kernel.org>, "Chen-Yu Tsai" <wenst@chromium.org>
Cc: "Jeff Johnson" <quic_jjohnson@quicinc.com>,
 "Bartosz Golaszewski" <brgl@bgdev.pl>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Rob Herring" <robh+dt@kernel.org>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
 "Conor Dooley" <conor+dt@kernel.org>,
 "Bjorn Andersson" <andersson@kernel.org>,
 "Konrad Dybcio" <konrad.dybcio@linaro.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Will Deacon" <will@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>,
 "Chris Morgan" <macromorgan@hotmail.com>,
 "Linus Walleij" <linus.walleij@linaro.org>,
 "Geert Uytterhoeven" <geert+renesas@glider.be>,
 "Neil Armstrong" <neil.armstrong@linaro.org>,
 =?UTF-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>,
 "Marek Szyprowski" <m.szyprowski@samsung.com>,
 "Peng Fan" <peng.fan@nxp.com>, "Robert Richter" <rrichter@amd.com>,
 "Dan Williams" <dan.j.williams@intel.com>,
 "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
 "Terry Bowman" <terry.bowman@amd.com>,
 "Kuppuswamy Sathyanarayanan"
 <sathyanarayanan.kuppuswamy@linux.intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Huacai Chen" <chenhuacai@kernel.org>, "Alex Elder" <elder@linaro.org>,
 "Srinivas Kandagatla" <srinivas.kandagatla@linaro.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 linux-wireless@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org,
 "Bartosz Golaszewski" <bartosz.golaszewski@linaro.org>
Subject: Re: [RFC 8/9] PCI/pwrseq: add a pwrseq driver for QCA6390
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024, at 11:09, Kalle Valo wrote:
> Chen-Yu Tsai <wenst@chromium.org> writes:
>> On Tue, Jan 9, 2024 at 5:18=E2=80=AFPM Kalle Valo <kvalo@kernel.org> =
wrote:
>>> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
>>>
>>> > On 1/4/2024 5:01 AM, Bartosz Golaszewski wrote:
>>> >> diff --git a/drivers/pci/pcie/pwrseq/Kconfig b/drivers/pci/pcie/p=
wrseq/Kconfig
>>> >> index 010e31f432c9..f9fe555b8506 100644
>>> >> --- a/drivers/pci/pcie/pwrseq/Kconfig
>>> >> +++ b/drivers/pci/pcie/pwrseq/Kconfig
>>> >> @@ -6,3 +6,14 @@ menuconfig PCIE_PWRSEQ
>>> >>      help
>>> >>        Say yes here to enable support for PCIe power sequencing
>>> >>        drivers.
>>> >> +
>>> >> +if PCIE_PWRSEQ
>>> >> +
>>> >> +config PCIE_PWRSEQ_QCA6390
>>> >> +    tristate "PCIe Power Sequencing driver for QCA6390"
>>> >> +    depends on ARCH_QCOM || COMPILE_TEST
>>> >> +    help
>>> >> +      Enable support for the PCIe power sequencing driver for the
>>> >> +      ath11k module of the QCA6390 WLAN/BT chip.
>>> >> +
>>> >> +endif
>>> >
>>> > As I mentioned in the 5/9 patch I'm concerned that the current
>>> > definition of PCIE_PWRSEQ and PCIE_PWRSEQ_QCA6390 will effectively=
 hide
>>> > the fact that QCA6390 may need additional configuration since the =
menu
>>> > item will only show up if you have already enabled PCIE_PWRSEQ.
>>> > Yes I see that these are set in the defconfig in 9/9 but I'm conce=
rned
>>> > about the more generic case.
>>> >
>>> > I'm wondering if there should be a separate config QCA6390 within =
ath11k
>>> > which would then select PCIE_PWRSEQ and PCIE_PWRSEQ_QCA6390
>>>
>>> Or is it possible to provide an optional dependency in Kconfig (I gu=
ess
>>
>> imply PCIE_PWRSEQ
>> imply PCIE_PWRSEQ_QCA6390
>> ?
>
> Nice, I had forgotten imply altogether. Would 'imply
> PCIE_PWRSEQ_QCA6390' in ath11k Kconfig be enough to address Jeff's
> concern?

Please don't use imply (ever), it doesn't normally do
what you want. In this case, the only effect the
'imply' has is to change the default of the PCIE_PWRSEQ_QCA6390
option when a defconfig contains QCA6390.

If this is indeed what you want, it's still better to do the
equivalent expression in PCIE_PWRSEQ_QCA6390 rather than ATH11K:

config PCIE_PWRSEQ_QCA6390
      tristate "PCIe Power Sequencing driver for QCA6390"
      default ATH11K && ARCH_QCOM

      Arnd

