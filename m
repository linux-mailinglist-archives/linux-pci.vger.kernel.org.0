Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFA941D2B1
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 07:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347973AbhI3Fbo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 01:31:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:59486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347737AbhI3Fbo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Sep 2021 01:31:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F99D6140F;
        Thu, 30 Sep 2021 05:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632979802;
        bh=+7QSpekLgP3fgEqKNoZ4CEMvOwLvPzU+OwbALsEuWZM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=qdZsfqrPpW7FR3COMQkj2nFr1YZw7479Jws2we5MNM9szdfYvBnlcvg5EX7rrvW21
         Z7UA04BqEQ55z59zbk0LerS8OmS5TKCm5Lcr9V3gVMh5td9bA/v9oGxXUjCpIiRzCJ
         O98CPIOfKLma3JQNeDe72kq6SPs6RYD8fow6Wn9vLY/WovBLZEmPmF2WtRfnN4xL9U
         WHDXfeCSjBtMWfVN3dm/nnHk2AD+89DIFStZv6PXlgXcx+Ax1HeHQee7BdGalCuPCw
         3UssumQ9xU3CVweB+fiqaLvcnkpOg+26O6d0Ot0QEgE3mMu9Hq+pohdws65SAAYQKD
         cDcobiP0M8KpQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210907144512.5238-1-marek.vasut@gmail.com>
References: <20210907144512.5238-1-marek.vasut@gmail.com>
Subject: Re: [PATCH] PCI: rcar: Add missing COMMON_CLK dependency
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
To:     linux-pci@vger.kernel.org, marek.vasut@gmail.com,
        linux-clk@vger.kernel.org
Date:   Wed, 29 Sep 2021 22:30:00 -0700
Message-ID: <163297980091.358640.10064724088378840378@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+linux-clk as I don't regularly read my inbox :/

Quoting marek.vasut@gmail.com (2021-09-07 07:45:12)
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>=20
> Add COMMON_CLK dependency, otherwise the following build error occurs:
>   arm-linux-gnueabi-ld: drivers/pci/controller/pcie-rcar-host.o: in funct=
ion `rcar_pcie_aarch32_abort_handler':
>   pcie-rcar-host.c:(.text+0xdd0): undefined reference to `__clk_is_enable=
d'
> This should be OK, since all platforms shipping this controller also
> need COMMON_CLK enabled for their clock driver.
>=20
> Fixes: a115b1bd3af0 ("PCI: rcar: Add L1 link state fix into data abort ho=
ok")
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: linux-renesas-soc@vger.kernel.org
> ---
> +CC Stephen, please double-check whether this is the right approach or
>     whether there is some better option

Stop using __clk_is_enabled()? I don't quite understand what's going on in
the code but __clk_is_enabled() should really go away. I thought we were
close to doing that but now I see a handful of calls have come up. The
API should be replaced by clk_hw_is_enabled() and then removed. We move
it to clk_hw API so that only clk providers can look at it.

Sigh!

Anyway, fixing the dependency is "ok" but really the long term fix would
be to not use a "is this clk enabled" sort of API. If I'm reading the
code correctly, this is some sort of fault handler that's trying to
avoid hanging the bus while handling the fault so it tries to make sure
the clk is enabled first? Is it a problem if the clk is not actually
enabled here? Would runtime PM enable state of the device work just as
well?
