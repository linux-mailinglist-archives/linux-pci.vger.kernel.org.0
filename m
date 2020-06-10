Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B12651F5BE9
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jun 2020 21:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgFJTUm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Jun 2020 15:20:42 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:58339 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgFJTUl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Jun 2020 15:20:41 -0400
Received: from windsurf.home (lfbn-tou-1-915-109.w86-210.abo.wanadoo.fr [86.210.146.109])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id A3EB9200002;
        Wed, 10 Jun 2020 19:20:38 +0000 (UTC)
Date:   Wed, 10 Jun 2020 21:20:37 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     "Shmuel H." <sh@tkos.co.il>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Marek =?UTF-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        Baruch Siach <baruch@tkos.co.il>,
        Chris ackham <chris.packham@alliedtelesis.co.nz>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH] pci: pci-mvebu: setup BAR0 to internal-regs
Message-ID: <20200610212037.7fd32a43@windsurf.home>
In-Reply-To: <ae84b87c-665b-7619-7cb0-a1fd58b17d8f@tkos.co.il>
References: <20200608144024.1161237-1-sh@tkos.co.il>
        <20200608214335.156baaaa@windsurf>
        <ae84b87c-665b-7619-7cb0-a1fd58b17d8f@tkos.co.il>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 10 Jun 2020 17:17:15 +0300
"Shmuel H." <sh@tkos.co.il> wrote:

> Apparently, the PCIe controller is outside of the internal registers space.

No, it is not.

It is outside of the internal-regs node in the DT because it needs more
"ranges" properties, but the PCIe controller registers *are* within the
internal registers window:

                               <0x82000000 0 0x80000 MBUS_ID(0xf0, 0x01) 0x80000 0 0x00002000
                                0x82000000 0 0x40000 MBUS_ID(0xf0, 0x01) 0x40000 0 0x00002000
                                0x82000000 0 0x44000 MBUS_ID(0xf0, 0x01) 0x44000 0 0x00002000
                                0x82000000 0 0x48000 MBUS_ID(0xf0, 0x01) 0x48000 0 0x00002000


> I could try to use a similar code as in
> arch/arm/mach-mvebu/pm.c:mvebu_internal_reg_base or get the first child
> of "internal-regs" and call of_translate_address on it with one zero cell.
> 
> Do you have a better solution?

In mvebu_pcie_map_registers(), we retrieve the address of the PCIe
registers for each port. You can take regs.start, round it down to 1
MB, and you'll get your base address.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
