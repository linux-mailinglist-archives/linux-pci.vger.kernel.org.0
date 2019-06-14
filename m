Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D38B45884
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2019 11:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbfFNJXk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jun 2019 05:23:40 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:34117 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfFNJXk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jun 2019 05:23:40 -0400
X-Originating-IP: 88.190.179.123
Received: from localhost (unknown [88.190.179.123])
        (Authenticated sender: repk@triplefau.lt)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 2E5FE240018;
        Fri, 14 Jun 2019 09:23:34 +0000 (UTC)
Date:   Fri, 14 Jun 2019 11:33:21 +0200
From:   Remi Pommarel <repk@triplefau.lt>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ellie Reeves <ellierevves@gmail.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: aardvark: Fix PCI_EXP_RTCTL conf register writing
Message-ID: <20190614093320.GC12859@voidbox.localdomain>
References: <20190614064225.24434-1-repk@triplefau.lt>
 <20190614105854.4c2f270f@windsurf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614105854.4c2f270f@windsurf>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

On Fri, Jun 14, 2019 at 10:58:54AM +0200, Thomas Petazzoni wrote:
> Hello,
> 
> On Fri, 14 Jun 2019 08:42:25 +0200
> Remi Pommarel <repk@triplefau.lt> wrote:
> 
> > PCI_EXP_RTCTL is used to activate PME interrupt only, so writing into it
> > should not modify other interrupts' mask. The ISR mask polarity was also
> > inverted, when PCI_EXP_RTCTL_PMEIE is set PCIE_MSG_PM_PME_MASK mask bit
> > should actually be cleared.
> > 
> > Fixes: 6302bf3ef78d ("PCI: Init PCIe feature bits for managed host bridge alloc")
> 
> Are you sure about this Fixes tag ? This commit seems unrelated.
> 
> The commit introducing this issue is 8a3ebd8de328301aacbe328650a59253be2ac82c.

The 6302bf3ef78d commit fixes PCI bridge's PME flag which introduces the
configuration of PCI_EXP_RTCTL register (which wasn't used before). So,
yes, PCI_EXP_RTCTL conf was flawed since 8a3ebd8de328 but the infinite
interrupt loop happens only since that 6302bf3ef78d has fixed this PME
flag bug.

I chose to use 6302bf3ef78d because it was the one commit triggering
the bug during my bisect process, but yes maybe using the commit that
introduced (even if it was silently) the problem makes more sense.

So if you want I can do a v3 with this Fixes tag modification.

-- 
Remi
