Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39DCD21C50B
	for <lists+linux-pci@lfdr.de>; Sat, 11 Jul 2020 18:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgGKQKX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Jul 2020 12:10:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:51912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbgGKQKW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 11 Jul 2020 12:10:22 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5195C2075F;
        Sat, 11 Jul 2020 16:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594483822;
        bh=yapXeHMIK9PVmlLcwW6FzKp88IXzSgQ+WQYAL1I8VsE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=IvZswk59GNeV3N7qMo2+D+6TWakET7tA/i6Urd18paPTMN3zaDHd8wutENMDRYh0O
         4iq+oVV8BF68jxGvn8H/dHX11GFYAIxfEeg/hgQuycX8IPBxXj4hcmaPPToDmMIVDm
         6WZWIgm9apLfE2PiLuU1qRrNhyF8U4wV2Nxliutk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1593940680-2363-5-git-send-email-sivaprak@codeaurora.org>
References: <1593940680-2363-1-git-send-email-sivaprak@codeaurora.org> <1593940680-2363-5-git-send-email-sivaprak@codeaurora.org>
Subject: Re: [PATCH 4/9] clk: qcom: ipq8074: Add missing clocks for pcie
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
To:     agross@kernel.org, bhelgaas@google.com, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, kishon@ti.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, mgautam@codeaurora.org,
        mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, sivaprak@codeaurora.org,
        smuthayy@codeaurora.org, svarbanov@mm-sol.com,
        varada@codeaurora.org, vkoul@kernel.org
Date:   Sat, 11 Jul 2020 09:10:21 -0700
Message-ID: <159448382156.1987609.6835614318226972862@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Quoting Sivaprakash Murugesan (2020-07-05 02:17:55)
> diff --git a/drivers/clk/qcom/gcc-ipq8074.c b/drivers/clk/qcom/gcc-ipq807=
4.c
> index e01f5f591d1e..443e28cda8ed 100644
> --- a/drivers/clk/qcom/gcc-ipq8074.c
> +++ b/drivers/clk/qcom/gcc-ipq8074.c
> @@ -4316,6 +4316,62 @@ static struct clk_branch gcc_gp3_clk =3D {
>         },
>  };
> =20
> +struct freq_tbl ftbl_pcie_rchng_clk_src[] =3D {

static const?

> +       F(19200000, P_XO, 1, 0, 0),
> +       F(100000000, P_GPLL0, 8, 0, 0),
> +       { }
> +};
> +
