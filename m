Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4EB34D7DB
	for <lists+linux-pci@lfdr.de>; Mon, 29 Mar 2021 21:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbhC2TMV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Mar 2021 15:12:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:55094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231725AbhC2TMJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Mar 2021 15:12:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 55B8261981;
        Mon, 29 Mar 2021 19:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617045129;
        bh=Vc2qS5hN4gZcx9XVb4kiJ5C2Wd27YQis4mRFE/m1Yi0=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=fV1LNkzXGn9Mc3Fw6yeG1RGnwBl2WsKC+w4QRKp7Y6UuilQaL/ElEbExswvzSGKcF
         XRpur9mkXWS2+CYUagZyNrfQoHv2HvQPw84Zsxdd5ZHn9HQt3XgA0MtcWEKcdwxovS
         O9Ax0FSHhjwRz0OzabCYph24IIRRdY1UwvWt6kNzP31rEm1H2FnotG6oP92K3FUrZU
         PGRpPxvQfJ1HD4ik8UADPr+WNu9lEcCwGoBKXAm8buLNa17z3wFfO3By+hSjWmmDXI
         Hz7476i8jjwwRMvblxSGWQqp6y4TwfJ4/kFYZbLX4VRpTfxykg+llkwvg6WMKXPXci
         /yEQMAOLlKh6w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <cover.1615954045.git.greentime.hu@sifive.com>
References: <cover.1615954045.git.greentime.hu@sifive.com>
Subject: Re: [PATCH v2 0/6] Add SiFive FU740 PCIe host controller driver support
From:   Stephen Boyd <sboyd@kernel.org>
To:     alex.dewar90@gmail.com, aou@eecs.berkeley.edu, bhelgaas@google.com,
        devicetree@vger.kernel.org, erik.danie@sifive.com,
        greentime.hu@sifive.com, hayashi.kunihiko@socionext.com,
        helgaas@kernel.org, hes@sifive.com, jh80.chung@samsung.com,
        khilman@baylibre.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-riscv@lists.infradead.org, lorenzo.pieralisi@arm.com,
        mturquette@baylibre.com, p.zabel@pengutronix.de,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        vidyas@nvidia.com, zong.li@sifive.com
Date:   Mon, 29 Mar 2021 12:12:08 -0700
Message-ID: <161704512808.3012082.7539298875497991635@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Quoting Greentime Hu (2021-03-17 23:08:07)
> This patchset includes SiFive FU740 PCIe host controller driver. We also
> add pcie_aux clock and pcie_power_on_reset controller to prci driver for
> PCIe driver to use it.
>=20
> This is tested with e1000e: Intel(R) PRO/1000 Network Card, AMD Radeon R5
> 230 graphics card and SP M.2 PCIe Gen 3 SSD in SiFive Unmatched based on
> v5.11 Linux kernel.

Can I merge the clk patches to clk-next? Or is the dts patch going to be
sent in for the merge window? I'd like to merge the clk patches if the
other patches are going to miss the next merge window.

>=20
> Changes in v2:
>  - Refine codes based on reviewers' feedback
>  - Remove define and use the common one
