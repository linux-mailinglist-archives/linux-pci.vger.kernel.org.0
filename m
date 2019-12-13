Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBD311EC7C
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2019 22:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfLMVFv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Dec 2019 16:05:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:44980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbfLMVFv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Dec 2019 16:05:51 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B28224671;
        Fri, 13 Dec 2019 21:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576271149;
        bh=ZCTmFmuP+82kP0bAev+K+tiRBMnz5wbfX+OG3ptUObg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=t6Qhei1TMSW87H73J95fJMqQBovt4qooCGfJGpcIzyU6OrTNzFdPK5sz5RkZx7Vt4
         00J5X3JMBq7/onLPOtw2q+9IqsQrccVRsxGpHr2L2fs5Q3bP2UAL7V5F0rnyxMJeFI
         TwW0/sTOhJR6QYfk9Ygc9R6KuX6savNbQppuGcQ8=
Date:   Fri, 13 Dec 2019 15:05:48 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lad Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Murray <andrew.murray@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Simon Horman <horms@verge.net.au>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [v2 3/6] of: address: add support to parse PCI outbound-ranges
Message-ID: <20191213201944.GA190383@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213084748.11210-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 13, 2019 at 08:47:45AM +0000, Lad Prabhakar wrote:
> From: "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>

$ git log --oneline drivers/of/address.c
951d48855d86 of: Make of_dma_get_range() work on bus nodes
645c138636de of/address: Fix of_pci_range_parser_one translation of DMA addresses
81db12ee15cb of/address: Translate 'dma-ranges' for parent nodes missing 'dma-ranges'
b68ac8dc22eb of: Factor out #{addr,size}-cells parsing
c60bf3eb888a of: address: Follow DMA parent for "dma-coherent"
862ab5578f75 of/address: Introduce of_get_next_dma_parent() helper

Make yours match.  There are a few "of: address: " subjects, but the
ones from Rob (the maintainer) use "of/address: ", so I'd use that.

> this patch adds support to parse PCI outbound-ranges, the
> outbound-regions are similar to pci ranges except it doesn't
> have pci address, below is the format for bar-ranges:

s/pci/PCI/
Capitalize sentences.

Is "bar-range" an actual DT property?  If it's supposed to be a
generic description, "BAR range" would be better.

> outbound-ranges = <flags upper32_cpuaddr lower32_cpuaddr
>                    upper32_size lower32_size>;
