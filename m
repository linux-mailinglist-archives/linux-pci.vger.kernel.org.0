Return-Path: <linux-pci+bounces-1922-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 482798283FC
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 11:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5E1AB23B51
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 10:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F21364C5;
	Tue,  9 Jan 2024 10:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VhkYgAMh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76123364C4
	for <linux-pci@vger.kernel.org>; Tue,  9 Jan 2024 10:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2cc7b9281d1so36042441fa.1
        for <linux-pci@vger.kernel.org>; Tue, 09 Jan 2024 02:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704796019; x=1705400819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KqCs7xVcoH/Y335TS6+AvlQypI4PD3ESEDIAEMa+9Hk=;
        b=VhkYgAMhO7m5TnvRWFXeaN2j+exrFFMz8//NhnccrsQpqArRU14OviQGQvA1MwKXnr
         gqFoaFUaj9/R/5kFHRT9SnSjTWEHKis1grFmiExoXzBomhK7+m3JA9oqUkfR37s+MekT
         ECIdVndwnRfI3TwD8B17VCb07O2FKUDlDBf2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704796019; x=1705400819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KqCs7xVcoH/Y335TS6+AvlQypI4PD3ESEDIAEMa+9Hk=;
        b=Es1BKXYugSb8qqnergn5GZDjLaUAHbszzjNset83rYaLxZdFXUTtn8L2M7BsQS1EjT
         7FGOrGzlcfWSE7TNvMaFKXEKhicfm3hov6MHGuyWMDmAXpqG7eY0yfEggAE9aw5St/Du
         PwxUYz9ApIe9G71gTBO9iDlZANVPkRa1y8gmbQtpWpEDEY8qoN3RoQjTEPBul97eaZk5
         Vg7oYA6fHcgJN2znbcV4GhEbzym4ryK8LTQacc78z7b2TMAqcOOupJOWFDQmMLXUYPOO
         y/OThVK3m5BCbua29fEEa9dYX8/Zb79gmZmn9jHznuX0UJ0WuFEqqgp8L1BwWaELVTwp
         lhmA==
X-Gm-Message-State: AOJu0YwTRIz697B7RTLGkynrN5+4UjS9t7RRl6woPZ1o7xOTaF3lbGF2
	UJ8xBd1jtZUPhs68khqOMhx6e9dqf5XGoWS764tejLF0Uehf
X-Google-Smtp-Source: AGHT+IGQso15KMjS2y4XlmEYUeEkRxHzMQ28n8NcqMI0p1GE1exj8UpVAFn8ANEkOOkgRsxqhphrTsJBnkvvGkjEwO8=
X-Received: by 2002:a2e:c42:0:b0:2cc:9882:4cb5 with SMTP id
 o2-20020a2e0c42000000b002cc98824cb5mr2242827ljd.45.1704796019352; Tue, 09 Jan
 2024 02:26:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104130123.37115-1-brgl@bgdev.pl> <20240104130123.37115-9-brgl@bgdev.pl>
 <15443d5d-6544-45d0-afeb-b23e6a041ecf@quicinc.com> <87jzoizwz7.fsf@kernel.org>
 <CAGXv+5FhYY+qyyT8wxY5DggvWPibfM2ypHVKQbsJZ30VkZDAkQ@mail.gmail.com>
 <87bk9uzum9.fsf@kernel.org> <5904461c-ca3c-4eb1-a44a-876872234545@app.fastmail.com>
In-Reply-To: <5904461c-ca3c-4eb1-a44a-876872234545@app.fastmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 9 Jan 2024 18:26:48 +0800
Message-ID: <CAGXv+5EHc08sv5+=tnFmoDAQhbD7ZS+XBOyaiSndaiSFhMksAA@mail.gmail.com>
Subject: Re: [RFC 8/9] PCI/pwrseq: add a pwrseq driver for QCA6390
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Chris Morgan <macromorgan@hotmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Neil Armstrong <neil.armstrong@linaro.org>, 
	=?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
	Robert Richter <rrichter@amd.com>, Dan Williams <dan.j.williams@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Terry Bowman <terry.bowman@amd.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Alex Elder <elder@linaro.org>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-wireless@vger.kernel.org, 
	Netdev <netdev@vger.kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 6:15=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Jan 9, 2024, at 11:09, Kalle Valo wrote:
> > Chen-Yu Tsai <wenst@chromium.org> writes:
> >> On Tue, Jan 9, 2024 at 5:18=E2=80=AFPM Kalle Valo <kvalo@kernel.org> w=
rote:
> >>> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
> >>>
> >>> > On 1/4/2024 5:01 AM, Bartosz Golaszewski wrote:
> >>> >> diff --git a/drivers/pci/pcie/pwrseq/Kconfig b/drivers/pci/pcie/pw=
rseq/Kconfig
> >>> >> index 010e31f432c9..f9fe555b8506 100644
> >>> >> --- a/drivers/pci/pcie/pwrseq/Kconfig
> >>> >> +++ b/drivers/pci/pcie/pwrseq/Kconfig
> >>> >> @@ -6,3 +6,14 @@ menuconfig PCIE_PWRSEQ
> >>> >>      help
> >>> >>        Say yes here to enable support for PCIe power sequencing
> >>> >>        drivers.
> >>> >> +
> >>> >> +if PCIE_PWRSEQ
> >>> >> +
> >>> >> +config PCIE_PWRSEQ_QCA6390
> >>> >> +    tristate "PCIe Power Sequencing driver for QCA6390"
> >>> >> +    depends on ARCH_QCOM || COMPILE_TEST
> >>> >> +    help
> >>> >> +      Enable support for the PCIe power sequencing driver for the
> >>> >> +      ath11k module of the QCA6390 WLAN/BT chip.
> >>> >> +
> >>> >> +endif
> >>> >
> >>> > As I mentioned in the 5/9 patch I'm concerned that the current
> >>> > definition of PCIE_PWRSEQ and PCIE_PWRSEQ_QCA6390 will effectively =
hide
> >>> > the fact that QCA6390 may need additional configuration since the m=
enu
> >>> > item will only show up if you have already enabled PCIE_PWRSEQ.
> >>> > Yes I see that these are set in the defconfig in 9/9 but I'm concer=
ned
> >>> > about the more generic case.
> >>> >
> >>> > I'm wondering if there should be a separate config QCA6390 within a=
th11k
> >>> > which would then select PCIE_PWRSEQ and PCIE_PWRSEQ_QCA6390
> >>>
> >>> Or is it possible to provide an optional dependency in Kconfig (I gue=
ss
> >>
> >> imply PCIE_PWRSEQ
> >> imply PCIE_PWRSEQ_QCA6390
> >> ?
> >
> > Nice, I had forgotten imply altogether. Would 'imply
> > PCIE_PWRSEQ_QCA6390' in ath11k Kconfig be enough to address Jeff's
> > concern?
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

PCIE_PWRSEQ_QCA6390 is also guarded by PCIE_PWRSEQ though. That would
require the default statement to be duplicated to the PCIE_PWRSEQ option
as well.

Presumably we'd get a few more power sequencing drivers, and the list of
default statements for PCIE_PWRSEQ would grow.

If that's acceptable then Arnd's proposal plus duplicating it to
PCIE_PWRSEQ should work as described.

ChenYu

