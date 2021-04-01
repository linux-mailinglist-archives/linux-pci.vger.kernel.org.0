Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBBD350BFE
	for <lists+linux-pci@lfdr.de>; Thu,  1 Apr 2021 03:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhDABih (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Mar 2021 21:38:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:47276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhDABiX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 31 Mar 2021 21:38:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 35DEF61001;
        Thu,  1 Apr 2021 01:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617241103;
        bh=lXPrmLD8cR13af0zzzzRyCkEh9/F2LOtjr4TPKAihQs=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=r0YN/a+crPqLnr9k3CcPd18eCft+dH+aFjTQw+bB1hAk8yooWEG22xb511q2/z8nl
         rmWlrMwEFb/Ndd0BxBdLQelYlaDLtTWNhfC1LPfAKYwxOBL6Xn44dUD8rugmbfbADu
         udLSYfBDbawC9QLg61U3wJcF6T9iXx8KNfUfX2+1BKdi5lrJy+3/CGp9p5Annu73nf
         q51hNsYQGadMTZSayypg5fjojDLbB6Z6+ya8DzL5uKFdSU7sWYHxww08AxUmrPAza9
         WqIeitQ7nNkNBIZ62d8UugpefyNHcMUfOxo76tIVxYJN9fgwlzPt1N7UE5WCObX+ZK
         sC3apKlqudenQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210331092605.105909-2-greentime.hu@sifive.com>
References: <20210331092605.105909-1-greentime.hu@sifive.com> <20210331092605.105909-2-greentime.hu@sifive.com>
Subject: Re: [PATCH v3 1/6] clk: sifive: Add pcie_aux clock in prci driver for PCIe driver
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
Date:   Wed, 31 Mar 2021 18:38:21 -0700
Message-ID: <161724110197.2260335.12311143415074941643@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Quoting Greentime Hu (2021-03-31 02:26:00)
> We add pcie_aux clock in this patch so that pcie driver can use
> clk_prepare_enable() and clk_disable_unprepare() to enable and disable
> pcie_aux clock.
>=20
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> ---

With robot fix

Acked-by: Stephen Boyd <sboyd@kernel.org>
