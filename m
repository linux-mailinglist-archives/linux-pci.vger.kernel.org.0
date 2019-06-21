Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0D34F101
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2019 01:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbfFUXH7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jun 2019 19:07:59 -0400
Received: from gate.crashing.org ([63.228.1.57]:56019 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbfFUXH6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Jun 2019 19:07:58 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5LN7WPQ028266;
        Fri, 21 Jun 2019 18:07:36 -0500
Message-ID: <b5101b74da1c5b9feba5e95e8ed14ec8ed82bd24.camel@kernel.crashing.org>
Subject: Re: [PATCH 4/4] arm64: pci: acpi: Preserve PCI resources
 configuration when asked by ACPI
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Sinan Kaya <okaya@kernel.org>, Ali Saidi <alisaidi@amazon.com>,
        Zeev Zilberman <zeev@amazon.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Date:   Sat, 22 Jun 2019 09:07:32 +1000
In-Reply-To: <20190621145752.GC21807@e121166-lin.cambridge.arm.com>
References: <20190615002359.29577-1-benh@kernel.crashing.org>
         <20190615002359.29577-4-benh@kernel.crashing.org>
         <20190621145752.GC21807@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 2019-06-21 at 15:57 +0100, Lorenzo Pieralisi wrote:
> >        pci_assign_unassigned_root_bus_resources(bus);
> >   
> >        list_for_each_entry(child, &bus->children, node)
> 
> This is fine as far as we acknowledge that claiming resources
> on a bus is what should be done to make them immutable.

Well, as immuatable as it gets today. It's not perfect but it's a step
in the right direction. With the previous change in the series that
prevents auto-realloc when preserve_config is set, it will be
equivalent, in the current state of the code.

As part of my ongoing rework, I plan to look at making
IORESOURCE_PCI_FIXED more generally useful/robust, in which case we
could add that on top as well. That said, if we go down that path, I'm
keen on also adding a cmdline arg to ignore _DSM #5, if anything as a
test/diag tool when chasing problems caused by buggy BIOSes.

Cheers,
Ben.


