Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0F66C029C
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2019 11:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbfI0Jp6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Sep 2019 05:45:58 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:53461 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfI0Jp6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Sep 2019 05:45:58 -0400
X-Originating-IP: 86.250.200.211
Received: from windsurf (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id DACC9E000D;
        Fri, 27 Sep 2019 09:45:55 +0000 (UTC)
Date:   Fri, 27 Sep 2019 11:45:55 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Remi Pommarel <repk@triplefau.lt>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: aardvark: Don't rely on jiffies while holding
 spinlock
Message-ID: <20190927114555.193a9d68@windsurf>
In-Reply-To: <20190927085502.1758-1-repk@triplefau.lt>
References: <20190927085502.1758-1-repk@triplefau.lt>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 27 Sep 2019 10:55:02 +0200
Remi Pommarel <repk@triplefau.lt> wrote:

> advk_pcie_wait_pio() can be called while holding a spinlock (from
> pci_bus_read_config_dword()), then depends on jiffies in order to
> timeout while polling on PIO state registers. In the case the PIO
> transaction failed, the timeout will never happen and will also cause
> the cpu to stall.
> 
> This decrements a variable and wait instead of using jiffies.
> 
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>

Acked-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
