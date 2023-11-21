Return-Path: <linux-pci+bounces-6-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDEE7F22FB
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 02:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EE80B219A1
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 01:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898E253B1;
	Tue, 21 Nov 2023 01:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pci@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61DFDBC;
	Mon, 20 Nov 2023 17:16:43 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 21 Nov 2023 10:15:40 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
	by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id CD6312059053;
	Tue, 21 Nov 2023 10:15:40 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Tue, 21 Nov 2023 10:15:40 +0900
Received: from [10.212.246.227] (unknown [10.212.246.227])
	by kinkan2.css.socionext.com (Postfix) with ESMTP id 03E02B6325;
	Tue, 21 Nov 2023 10:15:39 +0900 (JST)
Message-ID: <35ae0c18-db8f-c88c-2637-9eed835c13f6@socionext.com>
Date: Tue, 21 Nov 2023 10:15:41 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 2/6] PCI: dwc: Rename to .init in struct dw_pcie_ep_ops
Content-Language: en-US
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com,
 jingoohan1@gmail.com, gustavo.pimentel@synopsys.com, mani@kernel.org
Cc: linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Minghuan Lian <minghuan.Lian@nxp.com>,
 Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
 Jesper Nilsson <jesper.nilsson@axis.com>,
 Srikanth Thokala <srikanth.thokala@intel.com>,
 Masami Hiramatsu <mhiramat@kernel.org>
References: <20231114055456.2231990-1-yoshihiro.shimoda.uh@renesas.com>
 <20231114055456.2231990-3-yoshihiro.shimoda.uh@renesas.com>
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <20231114055456.2231990-3-yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Shimoda-san,

On 2023/11/14 14:54, Yoshihiro Shimoda wrote:
> Since the name of dw_pcie_ep_ops indicates that it's for ep obviously,
> rename a member .ep_init to .init.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---

>   drivers/pci/controller/dwc/pcie-uniphier-ep.c     | 2 +-

For uniphier:

Acked-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Thank you,

---
Best Regards
Kunihiko Hayashi

