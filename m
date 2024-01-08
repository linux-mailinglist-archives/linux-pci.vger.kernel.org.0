Return-Path: <linux-pci+bounces-1833-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A149982782C
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 20:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5574E1F23612
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 19:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6291054F8D;
	Mon,  8 Jan 2024 19:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ha+phNj9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CE454F86;
	Mon,  8 Jan 2024 19:10:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98380C433C8;
	Mon,  8 Jan 2024 19:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704741058;
	bh=WraLqJFI2xWoiB1MhS47d5f1UTVr6ZVdi8PhHonYykA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ha+phNj9Ek3W6jeVKjM5BPYlwMk2c5EA7ancxkpxbvePrLiKrXTAtIHdnidxdrw3y
	 PF8twwQAuLD2uAU8ZsEZZCJs62RNdnUXixgaQZioKvSsaGzJ66Q6XifzH11Dp1ay4J
	 2jHnJvAWbmxnIrsUFpSGa7fWvgAl5f2gyYHso8s3Mel/1Cx4wprLnu6WWR2xS9Igbq
	 Z5gvsc2zRPgReKVL8t6ldX+eR11OxtHJzwviLrPUGsbuzPx4Za/h3lQugjLIFSi3BJ
	 EdcEgqCJIJ3rh9/OoHtsMc2pZxf2yDfdpDa156GjyBSQxSB/WZr4DnIH72FtL57Fv5
	 PvjiEF0+Eng0g==
Received: (nullmailer pid 1897186 invoked by uid 1000);
	Mon, 08 Jan 2024 19:10:52 -0000
Date: Mon, 8 Jan 2024 12:10:52 -0700
From: Rob Herring <robh@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kalle Valo <kvalo@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
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
	Jonathan Cameron <"Jonath an.Cameron"@huawei.com>,
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
Subject: Re: [RFC 6/9] dt-bindings: vendor-prefixes: add a PCI prefix for
 Qualcomm Atheros
Message-ID: <20240108191052.GA1893484-robh@kernel.org>
References: <20240104130123.37115-1-brgl@bgdev.pl>
 <20240104130123.37115-7-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104130123.37115-7-brgl@bgdev.pl>

On Thu, Jan 04, 2024 at 02:01:20PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Document the PCI vendor prefix for Qualcomm Atheros so that we can
> define the QCA PCI devices on device tree.

Why? vendor-prefixes.yaml is only applied to property names. 'qca' 
should be the prefix for those.

Rob

