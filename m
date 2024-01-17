Return-Path: <linux-pci+bounces-2302-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3980D83101E
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jan 2024 00:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA70F288CFD
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 23:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EBF2561F;
	Wed, 17 Jan 2024 23:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/monbzG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE94B28DA5;
	Wed, 17 Jan 2024 23:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705534742; cv=none; b=ce/9dmsTbk1sOaVJHOchcZtmd3V29Jx9+dt2RjxkDuwu4Qnkhp3dylQeNp+Va3paJ1HnwnnwwgVua06zVQmy+bEq1fvNHTNb6KFEmYiM6hxUUWGpXlfhF3t2Rya6hv1hoxFmnkUgIzQZN9jRRWydtOJqQkdw25dSI2gnSkGfIFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705534742; c=relaxed/simple;
	bh=GcKMmCstmmaFfeggXxTBt9vMpMX9qJbtMbVXoCROP+E=;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding; b=nsMxsDskOK0FCeiivNr9cU6L6EbfiCeoHAv1toeirCJr3dae/f+cA24THAOH2qMUiaQa4UEYSbWNqOf/6vaoawOWBSFx8SisRcTBS/7DonujZu8xbPQkTMlR29BCOit/gRMLDTnZFffo5cQEKcK1ICogLbhbChHkg4/ASaIopSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/monbzG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CDDAC43394;
	Wed, 17 Jan 2024 23:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705534741;
	bh=GcKMmCstmmaFfeggXxTBt9vMpMX9qJbtMbVXoCROP+E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=P/monbzGlW0++yqPjaDQoZLzVooAp6kReBYDiIz8rAJmq88GF9ce70Vl4VjdzDe2k
	 xkHbL7jN3aYVhUV29HmQCX/xqczOCzb4+sUDWjf6LhGQmLh9ju5jIRmfUVTPU5aGYv
	 rxTicLT86DwaZcO3g1It5KdDccPNbI23bzVM/tLnLGBTEhDxS7xgJJah2/vEZWopPo
	 qyAG9tN4JbGq39q1b6DO+Dd16PUcs616Iken9djORnqWMCl1gn0RcHNl9RaBPLwS5y
	 4PUKFxx29eSO4D4YW7ImRRarUAWTon3QNhmg1wsXFbfX9SgcvlsbPlCUwV8w6ciNqm
	 cvgheWDst5x5Q==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-557ad92cabbso11741034a12.0;
        Wed, 17 Jan 2024 15:39:01 -0800 (PST)
X-Gm-Message-State: AOJu0YyushLXE8lsCDZH+3td8k1q4zoMrKHd7zWHG4FyVVs7S9ZFCU9/
	IsHtFHWyhwSmzFjcEUaNrIfqe4M4tqo97bySPGKCW67XRntqTvplOfh2XzZpcSJTHVBzG9ZrJK3
	E9Jt+UALcyyoFTwzWJa8TWKM4Qg==
X-Google-Smtp-Source: AGHT+IGAM6hRBqMLs5yi9Y3is013ddTHQ1ph27gXuVJmLiXeCWMAxx71b17TbgWWVx/+9qf/qRCmCYAbYBdLEXTaNXo=
X-Received: by 2002:a05:6512:234a:b0:50e:9d91:cfb8 with SMTP id
 p10-20020a056512234a00b0050e9d91cfb8mr2312813lfu.187.1705534719254; Wed, 17
 Jan 2024 15:38:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109144327.GA10780@wunner.de> <CAMRc=MdXO6c6asvRSn_Z8-oFS48hroT+dazGKB6WWY1_Zu7f1Q@mail.gmail.com>
 <20240110132853.GA6860@wunner.de> <CAMRc=MdBSAb_kEO2r7r-vwLuRAEv7pMODOMtZoCCRAd=zsQb_w@mail.gmail.com>
 <20240110164105.GA13451@wunner.de> <CAMRc=MdQKPN8UbagmswjFx7_JvmJuBeuq8+9=z-+GBNUmdpWEA@mail.gmail.com>
 <20240111104211.GA32504@wunner.de> <CAMRc=MfT_VLo7++K4M89iYrciqWSrX_JyS1LX5kaGTNDNVQiOg@mail.gmail.com>
 <20240111150201.GA28409@wunner.de> <CAMRc=Mcngw1vw9q0DXRWLKk4o9FOY+Mzz-niueT-v2THvbS1Dw@mail.gmail.com>
 <20240112094312.GA8704@wunner.de>
In-Reply-To: <20240112094312.GA8704@wunner.de>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 17 Jan 2024 17:38:27 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL=HbCbu3kACEc0_BNXGnapdcGz3J+2-dfXQxjyvBqD6A@mail.gmail.com>
Message-ID: <CAL_JsqL=HbCbu3kACEc0_BNXGnapdcGz3J+2-dfXQxjyvBqD6A@mail.gmail.com>
Subject: Re: [RFC 3/9] PCI/portdrv: create platform devices for child OF nodes
To: Lukas Wunner <lukas@wunner.de>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Kalle Valo <kvalo@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Chris Morgan <macromorgan@hotmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Arnd Bergmann <arnd@arndb.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
	Robert Richter <rrichter@amd.com>, Dan Williams <dan.j.williams@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Terry Bowman <terry.bowman@amd.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 3:43=E2=80=AFAM Lukas Wunner <lukas@wunner.de> wrot=
e:
>
> On Thu, Jan 11, 2024 at 05:16:45PM +0100, Bartosz Golaszewski wrote:
> > On Thu, Jan 11, 2024 at 4:02???PM Lukas Wunner <lukas@wunner.de> wrote:
> > > On Wed, Jan 10, 2024 at 05:26:52PM +0100, Bartosz Golaszewski wrote:
> > > >     if (pci_is_bridge(dev))
> > > >         of_pci_make_dev_node(dev);
> > >
> > > But perhaps of_pci_make_dev_node() returns immediately because:
> >
> > No, it was actually a no-op due to CONFIG_PCI_DYNAMIC_OF_NODES not
> > being set. But this is only available if CONFIG_OF_DYNAMIC is enabled
> > which requires OF_UNITTEST (!).
> >
> > We definitely don't need to enable dynamic OF nodes. We don't want to
> > modify the DT, we want to create devices for existing nodes.
>
> Consider refactoring of_pci_make_dev_node() to suit your needs or
> add a separate function call inside the "if (pci_is_bridge(dev))"
> clause which populates the child OF nodes.

The latter because of_pci_make_dev_node() has absolutely nothing to do
with the issue this series solves. The uses are pretty much mutually
exclusive. If we have a DT node with power related properties, there
is no need to create that node because it already exists.

Rob

