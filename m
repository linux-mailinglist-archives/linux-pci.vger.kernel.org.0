Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEF76A23F
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2019 08:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbfGPGcJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Jul 2019 02:32:09 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:56979 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729995AbfGPGcJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Jul 2019 02:32:09 -0400
Received: from windsurf (alyon-656-1-672-152.w92-137.abo.wanadoo.fr [92.137.69.152])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id C292024000A;
        Tue, 16 Jul 2019 06:32:05 +0000 (UTC)
Date:   Tue, 16 Jul 2019 08:32:04 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Grzegorz Jaszczyk <jaz@semihalf.com>, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mw@semihalf.com
Subject: Re: [PATCH] PCI: aardvark: fix big endian support
Message-ID: <20190716083204.375afc1e@windsurf>
In-Reply-To: <20190715151016.6amymuikizmmmsph@shell.armlinux.org.uk>
References: <1563200122-8323-1-git-send-email-jaz@semihalf.com>
        <20190715170840.326acd73@windsurf>
        <20190715151016.6amymuikizmmmsph@shell.armlinux.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

On Mon, 15 Jul 2019 16:10:16 +0100
Russell King - ARM Linux admin <linux@armlinux.org.uk> wrote:

> > Also, the advk_pci_bridge_emul_pcie_conf_read() and
> > advk_pci_bridge_emul_pcie_conf_write() return values that are in the
> > CPU endianness.
> > 
> > Am I missing something ?  
> 
> Getting the types correct and then using Sparse to validate the code
> will help to identify issues exactly like this.

Yes, I absolutely agree with your recommendation on the other thread.

In fact, I am wondering if it really makes sense to store the "fake"
config space in LE, since anyway the read/write accessors should return
values in the CPU endianness.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
