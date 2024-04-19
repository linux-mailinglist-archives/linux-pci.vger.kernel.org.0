Return-Path: <linux-pci+bounces-6496-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 919D48AB72E
	for <lists+linux-pci@lfdr.de>; Sat, 20 Apr 2024 00:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C12481C20C93
	for <lists+linux-pci@lfdr.de>; Fri, 19 Apr 2024 22:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5E313D28A;
	Fri, 19 Apr 2024 22:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2fgKXHi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E662B9B0;
	Fri, 19 Apr 2024 22:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713565324; cv=none; b=g7tXVgHz1yyDzmd1VJFJ8WBOSDessodDueoUIGh/qda9XzMLwaLrdohY0LZ9PwdSvSBUXLkWT+C3EEzYT9YvYcXVYRdfpaiuowrzXbEm2HOJ30FFcZoyhXZY3F4hAxxBpKTejKBqTxaIbB1uZrs8/oBq42PLKfDiYeltCum5rgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713565324; c=relaxed/simple;
	bh=W93MArkTN2nFQxNyz/XsQyNZSKFRYf+2wns3m/0iJ9k=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=GBtyEj9YE0ZQGiYS1XjTbs2tfB+h/vZRPsEbvLM2ACE55rky3PAc1Loxb3Xv8dbG5SBTWw2TC9huIWCdJms49YdYgGH94jhqYcBAX7/JE7RnRuWxmTd3HDRJWk4dt2vm5mrktbwv5NSN/K0vHAj4pi1ll1RrXwy7gIW3XqlM20M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2fgKXHi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E9CC072AA;
	Fri, 19 Apr 2024 22:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713565324;
	bh=W93MArkTN2nFQxNyz/XsQyNZSKFRYf+2wns3m/0iJ9k=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=m2fgKXHiFy8amOaO1SVc9kiYlQYn5t7O2IUojLh7YNXpZaxiqfPAZ4WLuE/QQY4gF
	 qZqKUlW0izC9UOkGw7qMIvfVfPR2imSHf2nRL0UsA7MdWyANPC7IIorwW5/CR5h++9
	 WO9zlomf5CUir5xVMtWes6wKFQWgNXWda4I1IF3FTzIhnYuU36SCFM/xbYGw8efvLr
	 aXKJL/guX+3Gk+RRY3sl3qXhhWXeznLga8jp/jwJqnOyJtMjA0+Rd2htFnKCIerpME
	 8HcLjspkYW6nCEYIRi07S5Sf6CyprS0rGYsST8aHi00lwrMTLngudTLGNGe6/F5ddi
	 jb1Wsgi6Ah9Dw==
Message-ID: <e938c677de8e8c8742701c7660b84706.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240415182052.374494-3-mr.nuke.me@gmail.com>
References: <20240415182052.374494-1-mr.nuke.me@gmail.com> <20240415182052.374494-3-mr.nuke.me@gmail.com>
Subject: Re: [PATCH v3 2/7] clk: qcom: gcc-ipq9574: Add PCIe pipe clocks
From: Stephen Boyd <sboyd@kernel.org>
Cc: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>, Bjorn Andersson <andersson@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Krzysztof =?utf-8?q?Wilczy=C5=84ski?= <kw@linux.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-phy@lists.infradead.org
Date: Fri, 19 Apr 2024 15:22:01 -0700
User-Agent: alot/0.10

Quoting Alexandru Gagniuc (2024-04-15 11:20:47)
> diff --git a/drivers/clk/qcom/gcc-ipq9574.c b/drivers/clk/qcom/gcc-ipq957=
4.c
> index 0a3f846695b8..c748d2f124f3 100644
> --- a/drivers/clk/qcom/gcc-ipq9574.c
> +++ b/drivers/clk/qcom/gcc-ipq9574.c
> @@ -1569,6 +1569,24 @@ static struct clk_regmap_phy_mux pcie0_pipe_clk_sr=
c =3D {
>         },
>  };
> =20
> +static struct clk_branch gcc_pcie0_pipe_clk =3D {
> +       .halt_reg =3D 0x28044,
> +       .halt_check =3D BRANCH_HALT_DELAY,
> +       .clkr =3D {
> +               .enable_reg =3D 0x28044,
> +               .enable_mask =3D BIT(0),
> +               .hw.init =3D &(struct clk_init_data){
> +                       .name =3D "gcc_pcie0_pipe_clk",
> +                       .parent_hws =3D (const struct clk_hw *[]) {
> +                               &pcie0_pipe_clk_src.clkr.hw
> +                       },
> +                       .num_parents =3D 1,
> +                       .flags =3D CLK_SET_RATE_PARENT,
> +                       .ops =3D &clk_branch2_ops,
> +               },
> +       },
> +};
> +
>  static struct clk_regmap_phy_mux pcie1_pipe_clk_src =3D {
>         .reg =3D 0x29064,
>         .clkr =3D {
> @@ -1583,6 +1601,24 @@ static struct clk_regmap_phy_mux pcie1_pipe_clk_sr=
c =3D {
>         },
>  };
> =20
> +static struct clk_branch gcc_pcie1_pipe_clk =3D {
> +       .halt_reg =3D 0x29044,
> +       .halt_check =3D BRANCH_HALT_DELAY,
> +       .clkr =3D {
> +               .enable_reg =3D 0x29044,
> +               .enable_mask =3D BIT(0),
> +               .hw.init =3D &(struct clk_init_data){

const clk_init_data please.

