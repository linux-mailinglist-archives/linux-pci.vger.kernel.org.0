Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 424501F5239
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jun 2020 12:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgFJK15 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 10 Jun 2020 06:27:57 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:49669 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgFJK15 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Jun 2020 06:27:57 -0400
Received: from windsurf.home (lfbn-tou-1-915-109.w86-210.abo.wanadoo.fr [86.210.146.109])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 12554200008;
        Wed, 10 Jun 2020 10:27:50 +0000 (UTC)
Date:   Wed, 10 Jun 2020 12:27:50 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     "Shmuel H." <sh@tkos.co.il>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Marek =?UTF-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        Baruch Siach <baruch@tkos.co.il>,
        Chris ackham <chris.packham@alliedtelesis.co.nz>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH] pci: pci-mvebu: setup BAR0 to internal-regs
Message-ID: <20200610122750.389c990f@windsurf.home>
In-Reply-To: <df64c0b9-cba7-c92e-c32d-804a75796f83@tkos.co.il>
References: <20200608144024.1161237-1-sh@tkos.co.il>
        <20200608214335.156baaaa@windsurf>
        <df64c0b9-cba7-c92e-c32d-804a75796f83@tkos.co.il>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

On Tue, 9 Jun 2020 14:21:07 +0300
"Shmuel H." <sh@tkos.co.il> wrote:

> Unfortunately, there is almost no documentation about the purpose of
> this register apart from this cryptic sentence:
> 
>      "BAR0 is dedicated to internal register access" (Marvell a38x
> functional docs, section 19.8).
> 
> I can only assume that only specific devices trigger the need for the
> PCIe controller to access the SoC's internal registers and therefore
> will fail to operate properly.

In fact, section 10.2.6 of the Armada XP datasheet, about MSI/MSI-X
support gives a hint: in order for the device to do a write to the MSI
doorbell address, it needs to write to a register in the "internal
registers" space". So it makes a lot of sense that this BAR0 has to be
configured.

Could you try to boot your system without your patch, and with the
pci=nomsi argument on the kernel command line ? This will prevent the
driver from using MSI, so it should fallback to legacy IRQs. If that
works, then we have the confirmation the issue is MSI related. This
will be useful just to have a good commit message that explains the
problem, because otherwise I am fine with your patch.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
