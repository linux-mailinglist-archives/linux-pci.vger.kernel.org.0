Return-Path: <linux-pci+bounces-23-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0DA7F26D9
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 09:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 495E5281A28
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 08:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC55C38DC6;
	Tue, 21 Nov 2023 08:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Q7TqFAy4"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F3010C;
	Tue, 21 Nov 2023 00:00:27 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 16607C0014;
	Tue, 21 Nov 2023 08:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1700553626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+wVLNzafuuC5OoDemnRoPxDj0X6KicgFt6cs+Glx0bI=;
	b=Q7TqFAy4eXEFuafTGmpluzADtVh3sxCsZnIw0jcOQSIm2VkksDiJKJ6fuhdkc1gdFameiu
	/uQ2+UHVna5FMAhPwy3O9IzGjalOya4EB4URoa5684Iy8PwVPiHLGx02gsiuau3eW55+c3
	1fQ7s+7I+Hj2KqNJfuHovbK2G0Xc6mzOZYKGVjNxI4gs/X38lBNeuSFeW/OxQ9m8jbBkvB
	gjIXyv98z3ztB5Q8Jc0RQy9xnBJHd86bGTB5ui0tU3xIS4ELi7uC/Zs5JsVx5azf4NKHll
	MEWtG1PWVOkLp/kpKW4TWUqPj91GzjZDHk8OukBc2Ke74lPqU7lUUmgLDpZeyg==
Date: Tue, 21 Nov 2023 09:00:19 +0100
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
 bhelgaas@google.com, jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
 mani@kernel.org, linux-pci@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Alim Akhtar
 <alim.akhtar@samsung.com>, Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach
 <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Minghuan Lian
 <minghuan.Lian@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang
 <roy.zang@nxp.com>, Yue Wang <yue.wang@Amlogic.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Jerome
 Brunet <jbrunet@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Jonathan Chocron <jonnyc@amazon.com>,
 Jesper Nilsson <jesper.nilsson@axis.com>, Heiko Stuebner <heiko@sntech.de>,
 Paul Walmsley <paul.walmsley@sifive.com>, Greentime Hu
 <greentime.hu@sifive.com>, Chuanhua Lei <lchuanhua@maxlinear.com>, Xiaowei
 Song <songxiaowei@hisilicon.com>, Binghui Wang <wangbinghui@hisilicon.com>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Marek Vasut
 <marek.vasut+renesas@gmail.com>, Pratyush Anand <pratyush.anand@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter
 <jonathanh@nvidia.com>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Nobuhiro Iwamatsu
 <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [PATCH v2 1/6] PCI: dwc: Drop host prefix from struct
 dw_pcie_host_ops
Message-ID: <20231121090019.0671168b@windsurf>
In-Reply-To: <20231114055456.2231990-2-yoshihiro.shimoda.uh@renesas.com>
References: <20231114055456.2231990-1-yoshihiro.shimoda.uh@renesas.com>
	<20231114055456.2231990-2-yoshihiro.shimoda.uh@renesas.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.petazzoni@bootlin.com

Hello,

On Tue, 14 Nov 2023 14:54:51 +0900
Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com> wrote:

>  drivers/pci/controller/dwc/pcie-armada8k.c    |  2 +-

For the Armada 8K driver:

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Best regards,

Thomas
-- 
Thomas Petazzoni, co-owner and CEO, Bootlin
Embedded Linux and Kernel engineering and training
https://bootlin.com

