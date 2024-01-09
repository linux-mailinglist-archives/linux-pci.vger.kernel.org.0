Return-Path: <linux-pci+bounces-1936-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDFD828A49
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 17:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63EDB1C246C0
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 16:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326F03A28E;
	Tue,  9 Jan 2024 16:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="VyaeIcjt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zMey0KZ1"
X-Original-To: linux-pci@vger.kernel.org
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1D33A1D4;
	Tue,  9 Jan 2024 16:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailnew.nyi.internal (Postfix) with ESMTP id 41E42580933;
	Tue,  9 Jan 2024 11:46:27 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 09 Jan 2024 11:46:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704818787; x=1704825987; bh=K+8Wy1yAZf
	vzApUYsoKLUmFMzPbqlojtP1IkaCbKgfI=; b=VyaeIcjtDpEW47hLyV9G+DBj9k
	HG/mtiqQbFsH1eRArSMdod8WPjm1GjlPTFPsC2yYEafy/nW+ssHQKN2xTjbFXfpI
	ypDviyglCkWZDG5Mw2UQfrrdHIUqxeJPvMLlxAL6/psSoA1CnerjSb3Rv97vkGk1
	QwrsOZ9nDxKKUSCNd1xIf4IO3aYxMhpODCRI1xf1MzajVea+o6HoI14qbae15gW3
	POLaeYl+l3qNeKsI+7vOMjmLMXiJHd7r3g9Vr5fz3xYp520eLcJV0o3zvxfTFhSh
	aPSpuzuV8EQJhyYEGbYv4AUA+86+Dx7QaKeCku00HLsw2mi/C9oCuYEsq5MA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704818787; x=1704825987; bh=K+8Wy1yAZfvzApUYsoKLUmFMzPbq
	lojtP1IkaCbKgfI=; b=zMey0KZ1NMHzMjkGYizpN9ueFSUqMj79vquTd4VEgRKn
	rEQ0MfzQGiOOTSs3qj63YUdiMOKwBSkepqUNeds13SqEj+w/Dm3Q3PMe6U0Xn1tP
	qNpaCAoKC/MYucYxYvL64pLgafOTWsHvVOpkqJ7LboqU+9eooA8yGyeWc59xmebv
	jrb4WgZz0NSi50+hRMPyvndGxsAovnN5Us9bJG4iRhmoYZ1fniZ02Cy58VPzOYiS
	gG5LxtmtCsqhXUTBm/fFdeVlDc4bhrrI1N+PM5ZEQIlaGE7c7MHh52GOplPcvhjO
	D/6/yWEUc3HvV5DDwolEB3XVHlf3UuFey9IVhoY0EA==
X-ME-Sender: <xms:YHidZWwXxCs0BNw-jN_XU-9eK8zaqKSCw7D8QyHK_Q9aRH_ZETUqng>
    <xme:YHidZSQdD1c5ccCAimIb6Dsy1jviMDF4tG1AiTig4kudIS_o7LdkCmvxEP0d_Z7Kt
    DKHKI_r5SZdnMSmzdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehledgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:YHidZYUYLrLk8L1MUZljRLK9L29wd0ixRqxCprN_HIBA_wJH9nL0LA>
    <xmx:YHidZchaJ303hNGYonHCLtZ9daJOcVKQUkt30mk08WrMozi7P_OrPQ>
    <xmx:YHidZYAb9QGB6jaZr_TLwhZnpSrwWA7ddbDvRQH6eShmkmDablHDgQ>
    <xmx:Y3idZVU8vFz4Xjvj8h-Ozx7C1awdnweF5b71NNbJigmjHymjox90sQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 897C8B6008D; Tue,  9 Jan 2024 11:46:24 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1364-ga51d5fd3b7-fm-20231219.001-ga51d5fd3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <477477cd-a35e-4964-b8b3-8040255c3bf1@app.fastmail.com>
In-Reply-To: <87y1cycv9h.fsf@kernel.org>
References: <20240104130123.37115-1-brgl@bgdev.pl>
 <20240104130123.37115-9-brgl@bgdev.pl>
 <15443d5d-6544-45d0-afeb-b23e6a041ecf@quicinc.com>
 <87jzoizwz7.fsf@kernel.org>
 <CAGXv+5FhYY+qyyT8wxY5DggvWPibfM2ypHVKQbsJZ30VkZDAkQ@mail.gmail.com>
 <87bk9uzum9.fsf@kernel.org>
 <5904461c-ca3c-4eb1-a44a-876872234545@app.fastmail.com>
 <87y1cycv9h.fsf@kernel.org>
Date: Tue, 09 Jan 2024 17:46:03 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Kalle Valo" <kvalo@kernel.org>
Cc: "Chen-Yu Tsai" <wenst@chromium.org>,
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
Content-Type: text/plain

On Tue, Jan 9, 2024, at 17:43, Kalle Valo wrote:
> "Arnd Bergmann" <arnd@arndb.de> writes:
>> On Tue, Jan 9, 2024, at 11:09, Kalle Valo wrote:
>>
>> If this is indeed what you want, it's still better to do the
>> equivalent expression in PCIE_PWRSEQ_QCA6390 rather than ATH11K:
>>
>> config PCIE_PWRSEQ_QCA6390
>>       tristate "PCIe Power Sequencing driver for QCA6390"
>>       default ATH11K && ARCH_QCOM
>
> Sounds good to me but should it be 'default ATH11K_PCI && ARCH_QCOM'? My
> understanding is that we don't need PWRSEQ for ATH11K_AHB devices.

Right, that is better.

    Arnd

