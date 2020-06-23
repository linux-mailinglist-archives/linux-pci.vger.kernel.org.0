Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595F3204A44
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jun 2020 08:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730703AbgFWG4a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Jun 2020 02:56:30 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:55069 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730583AbgFWG4a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Jun 2020 02:56:30 -0400
X-Originating-IP: 86.210.146.109
Received: from windsurf.home (lfbn-tou-1-915-109.w86-210.abo.wanadoo.fr [86.210.146.109])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 07124FF805;
        Tue, 23 Jun 2020 06:56:22 +0000 (UTC)
Date:   Tue, 23 Jun 2020 08:56:21 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Shmuel Hazan <sh@tkos.co.il>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Marek =?UTF-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        Baruch Siach <baruch@tkos.co.il>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v3] PCI: mvebu: Setup BAR0 in order to fix MSI
Message-ID: <20200623085621.2965e358@windsurf.home>
In-Reply-To: <20200623060334.108444-1-sh@tkos.co.il>
References: <20200623060334.108444-1-sh@tkos.co.il>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 23 Jun 2020 09:03:35 +0300
Shmuel Hazan <sh@tkos.co.il> wrote:

> According to the Armada XP datasheet, section 10.2.6: "in order for
> the device to do a write to the MSI doorbell address, it needs to write
> to a register in the internal registers space".
> 
> As a result of the requirement above, without this patch, MSI won't
> function and therefore some devices won't operate properly without
> pci=nomsi.
> 
> This requirement was not present at the time of writing this driver
> since the vendor u-boot always initializes all PCIe controllers
> (incl. BAR0 initialization) and for some time, the vendor u-boot was
> the only available bootloader for this driver's SoCs (e.g. A38x,A37x,
> etc).
> 
> Tested on an Armada 385 board on mainline u-boot (2020.4), without
> u-boot PCI initialization and the following PCIe devices:
>         - Wilocity Wil6200 rev 2 (wil6210)
>         - Qualcomm Atheros QCA6174 (ath10k_pci)
> 
> Both failed to get a response from the device after loading the
> firmware and seem to operate properly with this patch.
> 
> Signed-off-by: Shmuel Hazan <sh@tkos.co.il>

Acked-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Thanks a lot for the research and the different iterations!

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
