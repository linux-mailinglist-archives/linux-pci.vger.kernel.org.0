Return-Path: <linux-pci+bounces-1920-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA9A8283AD
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 11:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFED1B22DCD
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 10:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC4436083;
	Tue,  9 Jan 2024 10:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqoKHNVv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E948535EEF;
	Tue,  9 Jan 2024 10:09:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269C2C433C7;
	Tue,  9 Jan 2024 10:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704794951;
	bh=eBy8oO5dbaOO40AD9QACd0yuXbqBpvBDoQ/D7p6+2NY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=TqoKHNVvziTGxP8gXMTfuFv0GATSVJdS+CYh5o+NkywHCTOweS2p+557QhdVJSSQI
	 OCk6EF+fYLM5Ocxx+kqxf7PQeOp07i4kHqKe6IOFd/S3zJsVpDpStEXEdk0Eq0bEQZ
	 a2SccJxwocPW2sgTlslDy8ylrTWU1qIj36wXIqxlQQgUzLZJYKEg2ssZMhutqE57fU
	 USqwn/qG7daG+XVf2YvkvsT2X3zStvrvIoYr+6pW/OHviay/dm9xzDOuYorqqIHxkp
	 lrpHKWdxv9iBcOJ7fAmj2LR7nsLgdP9vSJ8+VDQY1v7wCmRBbOfK4nGrSVqWVLoK98
	 K+dUSgGX337Lg==
From: Kalle Valo <kvalo@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,  Bartosz Golaszewski
 <brgl@bgdev.pl>,  "David S . Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Rob Herring <robh+dt@kernel.org>,  Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley
 <conor+dt@kernel.org>,  Bjorn Andersson <andersson@kernel.org>,  Konrad
 Dybcio <konrad.dybcio@linaro.org>,  Catalin Marinas
 <catalin.marinas@arm.com>,  Will Deacon <will@kernel.org>,  Bjorn Helgaas
 <bhelgaas@google.com>,  Heiko Stuebner <heiko@sntech.de>,  Jernej Skrabec
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
Subject: Re: [RFC 8/9] PCI/pwrseq: add a pwrseq driver for QCA6390
References: <20240104130123.37115-1-brgl@bgdev.pl>
	<20240104130123.37115-9-brgl@bgdev.pl>
	<15443d5d-6544-45d0-afeb-b23e6a041ecf@quicinc.com>
	<87jzoizwz7.fsf@kernel.org>
	<CAGXv+5FhYY+qyyT8wxY5DggvWPibfM2ypHVKQbsJZ30VkZDAkQ@mail.gmail.com>
Date: Tue, 09 Jan 2024 12:09:02 +0200
In-Reply-To: <CAGXv+5FhYY+qyyT8wxY5DggvWPibfM2ypHVKQbsJZ30VkZDAkQ@mail.gmail.com>
	(Chen-Yu Tsai's message of "Tue, 9 Jan 2024 17:34:44 +0800")
Message-ID: <87bk9uzum9.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Chen-Yu Tsai <wenst@chromium.org> writes:

> On Tue, Jan 9, 2024 at 5:18=E2=80=AFPM Kalle Valo <kvalo@kernel.org> wrot=
e:
>
>>
>> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
>>
>> > On 1/4/2024 5:01 AM, Bartosz Golaszewski wrote:
>> >> diff --git a/drivers/pci/pcie/pwrseq/Kconfig b/drivers/pci/pcie/pwrse=
q/Kconfig
>> >> index 010e31f432c9..f9fe555b8506 100644
>> >> --- a/drivers/pci/pcie/pwrseq/Kconfig
>> >> +++ b/drivers/pci/pcie/pwrseq/Kconfig
>> >> @@ -6,3 +6,14 @@ menuconfig PCIE_PWRSEQ
>> >>      help
>> >>        Say yes here to enable support for PCIe power sequencing
>> >>        drivers.
>> >> +
>> >> +if PCIE_PWRSEQ
>> >> +
>> >> +config PCIE_PWRSEQ_QCA6390
>> >> +    tristate "PCIe Power Sequencing driver for QCA6390"
>> >> +    depends on ARCH_QCOM || COMPILE_TEST
>> >> +    help
>> >> +      Enable support for the PCIe power sequencing driver for the
>> >> +      ath11k module of the QCA6390 WLAN/BT chip.
>> >> +
>> >> +endif
>> >
>> > As I mentioned in the 5/9 patch I'm concerned that the current
>> > definition of PCIE_PWRSEQ and PCIE_PWRSEQ_QCA6390 will effectively hide
>> > the fact that QCA6390 may need additional configuration since the menu
>> > item will only show up if you have already enabled PCIE_PWRSEQ.
>> > Yes I see that these are set in the defconfig in 9/9 but I'm concerned
>> > about the more generic case.
>> >
>> > I'm wondering if there should be a separate config QCA6390 within ath1=
1k
>> > which would then select PCIE_PWRSEQ and PCIE_PWRSEQ_QCA6390
>>
>> Or is it possible to provide an optional dependency in Kconfig (I guess
>
> imply PCIE_PWRSEQ
> imply PCIE_PWRSEQ_QCA6390
> ?

Nice, I had forgotten imply altogether. Would 'imply
PCIE_PWRSEQ_QCA6390' in ath11k Kconfig be enough to address Jeff's
concern?

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

