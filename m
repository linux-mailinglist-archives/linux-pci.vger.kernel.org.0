Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6469BDDC5
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2019 14:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391210AbfIYMIH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Sep 2019 08:08:07 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:36361 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388199AbfIYMIH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Sep 2019 08:08:07 -0400
Received: from windsurf (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 080A0240013;
        Wed, 25 Sep 2019 12:08:04 +0000 (UTC)
Date:   Wed, 25 Sep 2019 14:08:04 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Remi Pommarel <repk@triplefau.lt>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ellie Reeves <ellierevves@gmail.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: aardvark: Fix PCI_EXP_RTCTL register
 configuration
Message-ID: <20190925140804.75ccf336@windsurf>
In-Reply-To: <20190614101059.1664-1-repk@triplefau.lt>
References: <20190614101059.1664-1-repk@triplefau.lt>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 14 Jun 2019 12:10:59 +0200
Remi Pommarel <repk@triplefau.lt> wrote:

> PCI_EXP_RTCTL is used to activate PME interrupt only, so writing into it
> should not modify other interrupts' mask. The ISR mask polarity was also
> inverted, when PCI_EXP_RTCTL_PMEIE is set PCIE_MSG_PM_PME_MASK mask bit
> should actually be cleared.
> 
> Fixes: 8a3ebd8de328 ("PCI: aardvark: Implement emulated root PCI bridge config space")
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>

Sorry for the long delay, but:

Acked-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

I did verify that indeed the polarity of the PME interrupt bit is
different between the standard PCI_EXP_RTCTL register and the
Aardvark-specific ISR0 mask register. And obviously, we shouldn't
clobber other bits of the ISR0 mask register when changing the PME
interrupt enable/disable state.

I did a quick test with a E1000E NIC and it worked fine.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
