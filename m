Return-Path: <linux-pci+bounces-2087-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE8082BDAC
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 10:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 148F1B211DC
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 09:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D4A57330;
	Fri, 12 Jan 2024 09:47:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E39B6281C;
	Fri, 12 Jan 2024 09:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id D04802800BB60;
	Fri, 12 Jan 2024 10:47:11 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id C31E22C3E0D; Fri, 12 Jan 2024 10:47:11 +0100 (CET)
Date: Fri, 12 Jan 2024 10:47:11 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Kalle Valo <kvalo@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	=?iso-8859-1?Q?N=EDcolas_F_=2E_R_=2E_A_=2E?= Prado <nfraprado@collabora.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Peng Fan <peng.fan@nxp.com>, Robert Richter <rrichter@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Huacai Chen <chenhuacai@kernel.org>, Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RFC 3/9] PCI/portdrv: create platform devices for child OF nodes
Message-ID: <20240112094711.GA17714@wunner.de>
References: <20240110132853.GA6860@wunner.de>
 <CAMRc=MdBSAb_kEO2r7r-vwLuRAEv7pMODOMtZoCCRAd=zsQb_w@mail.gmail.com>
 <20240110164105.GA13451@wunner.de>
 <CAMRc=MdQKPN8UbagmswjFx7_JvmJuBeuq8+9=z-+GBNUmdpWEA@mail.gmail.com>
 <20240111104211.GA32504@wunner.de>
 <CAMRc=MfT_VLo7++K4M89iYrciqWSrX_JyS1LX5kaGTNDNVQiOg@mail.gmail.com>
 <20240111150201.GA28409@wunner.de>
 <CAMRc=Mcngw1vw9q0DXRWLKk4o9FOY+Mzz-niueT-v2THvbS1Dw@mail.gmail.com>
 <CAMuHMdUnB_eGhzyOYRczXLMgb65dfHgwHgnv7eXSWDvOvTEdjQ@mail.gmail.com>
 <CAMRc=MeGsWV_71MzJ-Srm5MnwMfmwac_DLyC9O-8242eekuhNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MeGsWV_71MzJ-Srm5MnwMfmwac_DLyC9O-8242eekuhNg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Jan 12, 2024 at 10:43:04AM +0100, Bartosz Golaszewski wrote:
> Lukas, Terry: am I getting this right - is the port driver supposed to
> go away at some point?

Yes, that's the plan.

> Because I'm not sure I understand what the
> problem is here. To me it seems that when we create a real device for
> the PCIe port, then it's only normal to populate its child devices
> from the port driver.

portdrv is not creating a real device for the PCIe port.
It *binds* to that device.  The device is created much earlier.

NAK for adding this to portdrv.

Thanks,

Lukas

