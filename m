Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD6A350BFD
	for <lists+linux-pci@lfdr.de>; Thu,  1 Apr 2021 03:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbhDABih (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Mar 2021 21:38:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:47392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229959AbhDABih (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 31 Mar 2021 21:38:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C492461076;
        Thu,  1 Apr 2021 01:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617241116;
        bh=WmnubEsAgc8t6clW+YFcx1Vc3k6TSjkIbSo38SNqADM=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=sFB7amG1A3mtTI5lMD99XII7OV6mpML3ucdD+KMKE1srv09XEeU9fqwlS/qXDjL9f
         9aUD5PCz9lFWqEwDVEOL0oa6puSNTYCdHHb+xXqqp8mLiMD0dCt0dEsfGkNaV1vRsW
         VWqGRpJ9e0jFMKyik9XfFVJDb5Q4uGYGVZeGuN8QzabjGn5rbVoaWc/GPRIO898iMD
         UTLZqUsDgS8CYdUnHbBxzYoUgHdK5RnMr65yNOC7Ii+UAHyvIXD5/BCQyHPLOMibDQ
         TDR41gVnx6faoTz6DKjqaq/4ourMOAKbAxA0trvNtozypd3QpybIGtkX0pTHV2zqPm
         0XyBy7MxRzbWQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210331092605.105909-3-greentime.hu@sifive.com>
References: <20210331092605.105909-1-greentime.hu@sifive.com> <20210331092605.105909-3-greentime.hu@sifive.com>
Subject: Re: [PATCH v3 2/6] clk: sifive: Use reset-simple in prci driver for PCIe driver
From:   Stephen Boyd <sboyd@kernel.org>
To:     alex.dewar90@gmail.com, aou@eecs.berkeley.edu, bhelgaas@google.com,
        devicetree@vger.kernel.org, erik.danie@sifive.com,
        greentime.hu@sifive.com, hayashi.kunihiko@socionext.com,
        helgaas@kernel.org, hes@sifive.com, jh80.chung@samsung.com,
        khilman@baylibre.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-riscv@lists.infradead.org, lorenzo.pieralisi@arm.com,
        mturquette@baylibre.com, p.zabel@pengutronix.de,
        paul.walmsley@sifive.com, robh+dt@kernel.org, vidyas@nvidia.com,
        zong.li@sifive.com
Date:   Wed, 31 Mar 2021 18:38:35 -0700
Message-ID: <161724111560.2260335.3440073350706698709@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Quoting Greentime Hu (2021-03-31 02:26:01)
> We use reset-simple in this patch so that pcie driver can use
> devm_reset_control_get() to get this reset data structure and use
> reset_control_deassert() to deassert pcie_power_up_rst_n.
>=20
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
