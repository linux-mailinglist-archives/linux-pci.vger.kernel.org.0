Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2438C396533
	for <lists+linux-pci@lfdr.de>; Mon, 31 May 2021 18:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbhEaQ00 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 May 2021 12:26:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:51452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234704AbhEaQYZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 May 2021 12:24:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F3DC361027;
        Mon, 31 May 2021 16:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622478165;
        bh=eUlDMEvG5nOx5DXWhjFkdrIrGzVK6Ta/bfHobWAG7O0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MaDdjSfvJJbu/3DebyqUnY1cW95RdR7VyjV1H9nrdMzn1BWI2yhTluzJe4c0SpMji
         4uToYSbpytLkAYl4vpgZLbqcW/MnajfawgkieyZ8nyJax4PKVPC4/LBFBfW9rC8vyj
         bK63zLVIK1GLTM/B0yWhDtBTGJn2nMA+lUykE3TqZJHYwdNhtIeTyiDM/ZWZEyNjCO
         Qk+TmkdZpoRs6moyB+U+H1dArWcL5dO318Jtyj00C51f55IeQBch2xDrCH6WYRKltW
         uOrlkA4+gxFEtF4tagj0eXar79RyPOfaVZmW/g3cCBR5/Tm47MHYuwa4M7VdqsOdkP
         CgLV3C86ugAtQ==
Received: by pali.im (Postfix)
        id 9DFE0B84; Mon, 31 May 2021 18:22:42 +0200 (CEST)
Date:   Mon, 31 May 2021 18:22:42 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Luca Ceresoli <luca@lucaceresoli.net>, linux-pci@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2] PCI: dra7xx: Fix reset behaviour
Message-ID: <20210531162242.jm73yzntzmilsvbg@pali>
References: <20210531090540.2663171-1-luca@lucaceresoli.net>
 <20210531133211.llyiq3jcfy25tmz4@pali>
 <8ff1c54f-bb29-1e40-8342-905e34361e1c@lucaceresoli.net>
 <9fdbada4-4902-cec1-f283-0d12e1d4ac64@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9fdbada4-4902-cec1-f283-0d12e1d4ac64@ti.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Kishon!

On Monday 31 May 2021 21:30:30 Kishon Vijay Abraham I wrote:
> I had given the timing mentioned in the specification here
> https://lore.kernel.org/r/023c9b59-70bb-ed8d-a4c0-76eae726b574@ti.com
> 
> The PCI EXPRESS CARD ELECTROMECHANICAL SPECIFICATION defines the Power
> Sequencing and Reset Signal Timings in Table 2-4. Please also refer Figure
> 2-10: Power Up of the CEM.
> 
> ╔═════════════╤══════════════════════════════════════╤═════╤═════╤═══════╗
> ║ Symbol      │ Parameter                            │ Min │ Max │ Units ║
> ╠═════════════╪══════════════════════════════════════╪═════╪═════╪═══════╣
> ║ T PVPERL    │ Power stable to PERST# inactive      │ 100 │     │ ms    ║
> ╟─────────────┼──────────────────────────────────────┼─────┼─────┼───────╢
> ║ T PERST-CLK │ REFCLK stable before PERST# inactive │ 100 │     │ μs    ║
> ╟─────────────┼──────────────────────────────────────┼─────┼─────┼───────╢
> ║ T PERST     │ PERST# active time                   │ 100 │     │ μs    ║
> ╟─────────────┼──────────────────────────────────────┼─────┼─────┼───────╢
> ║ T FAIL      │ Power level invalid to PERST# active │     │ 500 │ ns    ║
> ╟─────────────┼──────────────────────────────────────┼─────┼─────┼───────╢
> ║ T WKRF      │ WAKE# rise – fall time               │     │ 100 │ ns    ║
> ╚═════════════╧══════════════════════════════════════╧═════╧═════╧═══════╝
> 
> The de-assertion of #PERST is w.r.t both power stable and refclk stable.

I think this does not fully answer this problematic question. One thing
is initial power on and second thing is warm reset (when both power and
clock is stable).

On more ARM boards, power is not SW controllable and is automatically
enabled when powering board on. So Tₚᵥₚₑᵣₗ is calculated since
bootloader and therefore not needed to take into account in kernel.

Tₚₑᵣₛₜ₋cₗₖ is only 100 µs and experiments proved that 100 µs not enough
for toggling PERST# GPIO. At least one 1 ms is needed and for some cards
at least 10 ms. Otherwise cards are not detected.

So when you have both power and clock stable and you want to reset card
via PERST# signal, above table does not say how long it is needed to
have PERST# in reset state.

> I'm yet to validate this patch, but IIRC devm_gpiod_get_optional(dev,
> NULL, GPIOD_OUT_HIGH) will already de-assert the PERST line. Please note
> the board here can have various combinations of NOT gate before the gpio
> line is actually connected to the connector.
> 
> Thanks
> Kishon
