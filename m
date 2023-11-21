Return-Path: <linux-pci+bounces-5-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C567D7F22F9
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 02:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ED55281E77
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 01:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B28D5CAF;
	Tue, 21 Nov 2023 01:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pci@vger.kernel.org
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Nov 2023 17:16:40 PST
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id E7449A2;
	Mon, 20 Nov 2023 17:16:40 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 21 Nov 2023 10:15:36 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 3CD002059053;
	Tue, 21 Nov 2023 10:15:36 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Tue, 21 Nov 2023 10:15:36 +0900
Received: from [10.212.246.227] (unknown [10.212.246.227])
	by kinkan2.css.socionext.com (Postfix) with ESMTP id 2D2B6B6325;
	Tue, 21 Nov 2023 10:15:34 +0900 (JST)
Message-ID: <285420df-7dcf-f828-7e72-12ed85fba030@socionext.com>
Date: Tue, 21 Nov 2023 10:15:35 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/6] PCI: dwc: Drop host prefix from struct
 dw_pcie_host_ops
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com,
 jingoohan1@gmail.com, gustavo.pimentel@synopsys.com, mani@kernel.org
Cc: linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Richard Zhu <hongxing.zhu@nxp.com>,
 Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Minghuan Lian <minghuan.Lian@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
 Roy Zang <roy.zang@nxp.com>, Yue Wang <yue.wang@Amlogic.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jonathan Chocron <jonnyc@amazon.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Jesper Nilsson <jesper.nilsson@axis.com>, Heiko Stuebner <heiko@sntech.de>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Greentime Hu <greentime.hu@sifive.com>,
 Chuanhua Lei <lchuanhua@maxlinear.com>,
 Xiaowei Song <songxiaowei@hisilicon.com>,
 Binghui Wang <wangbinghui@hisilicon.com>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Marek Vasut <marek.vasut+renesas@gmail.com>,
 Pratyush Anand <pratyush.anand@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20231114055456.2231990-1-yoshihiro.shimoda.uh@renesas.com>
 <20231114055456.2231990-2-yoshihiro.shimoda.uh@renesas.com>
Content-Language: en-US
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <20231114055456.2231990-2-yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Shimoda-san,

On 2023/11/14 14:54, Yoshihiro Shimoda wrote:
> Since the name of dw_pcie_host_ops indicates that it's for host
> obviously, drop host prefix from the struct.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---

>   drivers/pci/controller/dwc/pcie-uniphier.c    |  2 +-

For uniphier:

Acked-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Thank you,

---
Best Regards
Kunihiko Hayashi

