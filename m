Return-Path: <linux-pci+bounces-1924-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A32782841E
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 11:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 921EF1F24C29
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 10:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF1D364B9;
	Tue,  9 Jan 2024 10:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="kUPRfDa8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gg8iSZcH"
X-Original-To: linux-pci@vger.kernel.org
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37BA36AE0;
	Tue,  9 Jan 2024 10:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailnew.nyi.internal (Postfix) with ESMTP id 84F53580995;
	Tue,  9 Jan 2024 05:39:14 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 09 Jan 2024 05:39:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1704796754;
	 x=1704803954; bh=HzJqeHJSSvwhWPrjR9Fbt9vP85vPdOff53sUkOuNVq0=; b=
	kUPRfDa8eYCtgyf4AmSxljf2NqYRMG1F3bZ+Oe98NlK/Bdlj27ZLUzmeNfo2+PBS
	/KNHuNdsnA69fsyENsXZIifIYFyTC8YAEQ0ioDXm7zmezulOboDG/fd6pGZcAxCD
	2+NXP+UrN25d/DqL5qDYRlzB/MO1oiuWnfz/dXSeSUmSUWDFHDxOT2p6MGp+DoNb
	fLAmxSQTe7b+yFJ9DhRgaBdecM+QH0bDjGpdDsOcsZvoH4UUXi073jgVL+khKfxa
	wKuxVNuLulhqLVwWLNOwjJcLzkUkmYlp/R3wReqzuJV5iZVpqkurYv1E+a/vKAQS
	YJb0+VyrjWfzP5LvAj1tlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1704796754; x=
	1704803954; bh=HzJqeHJSSvwhWPrjR9Fbt9vP85vPdOff53sUkOuNVq0=; b=g
	g8iSZcH/dNzuXP/Xv/Hfm3ka76yYul078pUOJVHhu/i8KJ/omlE7sR3LFwrFvZv3
	XFUyuwppqvHrBfewlOUc50nJ38PsqCwu1Qk5szxprvvO7YQvUZSmnwdzCMyu+D+S
	GAPptH1BJg9JPe9jJGzplhk0PDqFBotgQ5HOMMkeF6mk9L8iXyI8qaIHsrKQ+0bD
	1GiAnSS4e3Pm4uGCxzVBffsQxcnaMi4iEHwrBcoy5ssy8Zf5XZ+SBm7iFud8c/TP
	WYgZWWiKsl5pSDByDD7RhXkRYwVK8gSi4BLrFntBj96kY+4ip2+AMleH1A+LtAd5
	lo4q9h91NT06s+1MoePXw==
X-ME-Sender: <xms:UiKdZRb1EM7JXrvJCWkJPOIOB3eLJgFGnH54EvQhFFOQ3buA3oLhAQ>
    <xme:UiKdZYY6qEVEgonPkBQzX12qcu9Z3PJQZYAk7prK3G3oiWTEsA2Vj-wsjm780g9VW
    BL1qS7r0UTDyjbw_Wg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehledgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:UiKdZT-nHewJelcFdkMzsuc6tJ32kzx-oLScKQJVVU5YZA8wV4MO0A>
    <xmx:UiKdZfo72kFtjawE6s6gD3UJl1vJEalEY_fSKySLUM7s0uLmQ5p_cA>
    <xmx:UiKdZcrpiW7k18W2bkbCybCcrBERyg7a2MlcCeRroVXRINziwgBV3w>
    <xmx:UiKdZY8S2D4l_o4eq2ngxEx2KJlrwjo0HPoMeRC5RHCsn0IxgNrHXg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id EC32CB6008D; Tue,  9 Jan 2024 05:39:13 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1364-ga51d5fd3b7-fm-20231219.001-ga51d5fd3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8f50f1b2-68b0-46bd-9bf8-3ddbbaee249d@app.fastmail.com>
In-Reply-To: 
 <CAGXv+5EHc08sv5+=tnFmoDAQhbD7ZS+XBOyaiSndaiSFhMksAA@mail.gmail.com>
References: <20240104130123.37115-1-brgl@bgdev.pl>
 <20240104130123.37115-9-brgl@bgdev.pl>
 <15443d5d-6544-45d0-afeb-b23e6a041ecf@quicinc.com>
 <87jzoizwz7.fsf@kernel.org>
 <CAGXv+5FhYY+qyyT8wxY5DggvWPibfM2ypHVKQbsJZ30VkZDAkQ@mail.gmail.com>
 <87bk9uzum9.fsf@kernel.org>
 <5904461c-ca3c-4eb1-a44a-876872234545@app.fastmail.com>
 <CAGXv+5EHc08sv5+=tnFmoDAQhbD7ZS+XBOyaiSndaiSFhMksAA@mail.gmail.com>
Date: Tue, 09 Jan 2024 11:38:51 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Chen-Yu Tsai" <wenst@chromium.org>
Cc: "Kalle Valo" <kvalo@kernel.org>,
 "Jeff Johnson" <quic_jjohnson@quicinc.com>,
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

On Tue, Jan 9, 2024, at 11:26, Chen-Yu Tsai wrote:
> On Tue, Jan 9, 2024 at 6:15=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> w=
rote:
>> On Tue, Jan 9, 2024, at 11:09, Kalle Valo wrote:
>> > Chen-Yu Tsai <wenst@chromium.org> writes:
>> >> On Tue, Jan 9, 2024 at 5:18=E2=80=AFPM Kalle Valo <kvalo@kernel.or=
g> wrote:

>> If this is indeed what you want, it's still better to do the
>> equivalent expression in PCIE_PWRSEQ_QCA6390 rather than ATH11K:
>>
>> config PCIE_PWRSEQ_QCA6390
>>       tristate "PCIe Power Sequencing driver for QCA6390"
>>       default ATH11K && ARCH_QCOM
>
> PCIE_PWRSEQ_QCA6390 is also guarded by PCIE_PWRSEQ though. That would
> require the default statement to be duplicated to the PCIE_PWRSEQ opti=
on
> as well.
>
> Presumably we'd get a few more power sequencing drivers, and the list =
of
> default statements for PCIE_PWRSEQ would grow.
>
> If that's acceptable then Arnd's proposal plus duplicating it to
> PCIE_PWRSEQ should work as described.

Does PCIE_PWRSEQ need to be user-visible? If this is a hidden symbol
that gets selected by PCIE_PWRSEQ_QCA6390 and any future ones, it
would still get enabled.

Another possibility would be to have PCIE_PWRSEQ be default-enabled,
but allow it to be turned off in order to hide the other options
when users are sure they don't need it (e.g. when building a
specialized kernel for a particular board).

     Arnd

