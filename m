Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7B0344599
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2019 18:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392598AbfFMQpM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 12:45:12 -0400
Received: from gate.crashing.org ([63.228.1.57]:39729 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbfFMGHd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Jun 2019 02:07:33 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5D670eP028868;
        Thu, 13 Jun 2019 01:07:01 -0500
Message-ID: <76795e390d188ccdc6b67f2e00af0cd2d99f4501.camel@kernel.crashing.org>
Subject: PCI resource allocation hell, PCI_PROBE_ONLY, PCI_REASSIGN_ALL_BUS
 etc...
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        linux-mips@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alan Douglas <adouglas@cadence.com>,
        HonghuiZhang <honghui.zhang@mediatek.com>
Date:   Thu, 13 Jun 2019 16:07:00 +1000
In-Reply-To: <4e734c3aab8802b340e06b56803954b3e550157d.camel@kernel.crashing.org>
References: <4e734c3aab8802b340e06b56803954b3e550157d.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Sooo ... I need some feedback from a bunch of people who know about
their arch/platform PCIe controller code :-)

aardvark, mvebu, cadence-host and mediatek and alpha & mips folks...

[Long story short: trying to cleanup and consolidate resource
allocation/assignment accross archs etc... and finding a bunch of
interesting things that I'll need to address (or at least understand)
to be able to move forward, so I need input from the relevant
authors/maintainers. I've CCed a few.]

Please chime in and let me know what you think the intent is so I can
fix these things up.

So first thing: aardvark, mvebu, cadence-host and mediatek, you call
pci_host_probe() directly instead of pci_host_common_probe(), for good
reasons, but that make you miss these:

	of_pci_check_probe_only();

and
	/* Do not reassign resources if probe only */
	if (!pci_has_flag(PCI_PROBE_ONLY))
		pci_add_flags(PCI_REASSIGN_ALL_BUS);

Now, I think probe only should be a platform thing, so it should be
tested always, don't you agree ?

Also, from what I can tell, because you never have it set, you rely
on the generic code always reassigning all resources. That's also where
mips and alpha come in: those archs seem to also rely on all resources
being reallocated when PCI_PROBE_ONLY is not set (well, not 100% sure
about mips yet but alpha for sure).

However they all miss setting PCI_REASSIGN_ALL_BUS. So you will keep
whatever bus numbers were set by FW. I think the generic code is
somewhat smart enough to reassign them if they are completely bogus but
it's still not great... Is that intentional ?

Should we move the above pieces of code to pci_host_probe() instead ?
(That wont help mips and alpha, those would have to get a copy of the
same).

Cheers,
Ben.

