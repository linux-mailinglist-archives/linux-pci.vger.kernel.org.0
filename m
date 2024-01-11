Return-Path: <linux-pci+bounces-2059-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E99BE82B143
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 16:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92E5B1F23BC2
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 15:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB374B5BA;
	Thu, 11 Jan 2024 15:02:13 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AEA4A987;
	Thu, 11 Jan 2024 15:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 9E573300000BE;
	Thu, 11 Jan 2024 16:02:01 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 8FBBBDAB62; Thu, 11 Jan 2024 16:02:01 +0100 (CET)
Date: Thu, 11 Jan 2024 16:02:01 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kalle Valo <kvalo@kernel.org>, "David S . Miller" <davem@davemloft.net>,
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
Message-ID: <20240111150201.GA28409@wunner.de>
References: <20240104130123.37115-1-brgl@bgdev.pl>
 <20240104130123.37115-4-brgl@bgdev.pl>
 <20240109144327.GA10780@wunner.de>
 <CAMRc=MdXO6c6asvRSn_Z8-oFS48hroT+dazGKB6WWY1_Zu7f1Q@mail.gmail.com>
 <20240110132853.GA6860@wunner.de>
 <CAMRc=MdBSAb_kEO2r7r-vwLuRAEv7pMODOMtZoCCRAd=zsQb_w@mail.gmail.com>
 <20240110164105.GA13451@wunner.de>
 <CAMRc=MdQKPN8UbagmswjFx7_JvmJuBeuq8+9=z-+GBNUmdpWEA@mail.gmail.com>
 <20240111104211.GA32504@wunner.de>
 <CAMRc=MfT_VLo7++K4M89iYrciqWSrX_JyS1LX5kaGTNDNVQiOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MfT_VLo7++K4M89iYrciqWSrX_JyS1LX5kaGTNDNVQiOg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Jan 11, 2024 at 05:09:09AM -0600, Bartosz Golaszewski wrote:
> On Thu, 11 Jan 2024 11:42:11 +0100, Lukas Wunner <lukas@wunner.de> said:
> > On Wed, Jan 10, 2024 at 02:18:30PM -0600, Bartosz Golaszewski wrote:
> >> On Wed, 10 Jan 2024 17:41:05 +0100, Lukas Wunner <lukas@wunner.de> said:
> >> > On Wed, Jan 10, 2024 at 05:26:52PM +0100, Bartosz Golaszewski wrote:
> >> > > Seems like the following must be true but isn't in my case (from
> >> > > pci_bus_add_device()):
> >> > >
> >> > >     if (pci_is_bridge(dev))
> >> > >         of_pci_make_dev_node(dev);
> >> > >
> >> > > Shouldn't it evaluate to true for ports?
> >> >
> >> > It should.
> >> >
> >> > What does "lspci -vvvvxxxx -s BB:DD.F" say for the port in question?
> 
> # lspci -vvvvxxxx -s 0000:00:00
> 0000:00:00.0 PCI bridge: Qualcomm Technologies, Inc Device 010b
> (prog-if 00 [Normal decode])
> 	Device tree node: /sys/firmware/devicetree/base/soc@0/pcie@1c00000/pcie@0
[...]
> 00: cb 17 0b 01 07 05 10 00 00 00 04 06 00 00 01 00
                                                ^^
The Header Type in config space is 0x1, i.e. PCI_HEADER_TYPE_BRIDGE.

So pci_is_bridge(dev) does return true (unlike what you write above)
and control flow enters of_pci_make_dev_node().

But perhaps of_pci_make_dev_node() returns immediately because:

	/*
	 * If there is already a device tree node linked to this device,
	 * return immediately.
	 */
	if (pci_device_to_OF_node(pdev))
		return;

...and lspci does list a devicetree node for that Root Port.

In any case, of_pci_make_dev_node() is the right place to add
the call to of_platform_populate().  Just make sure it's called
even if there is already a DT node for the Root Port itself.

Thanks,

Lukas

