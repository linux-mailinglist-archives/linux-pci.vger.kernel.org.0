Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAEA105760
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2019 17:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfKUQrM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Nov 2019 11:47:12 -0500
Received: from foss.arm.com ([217.140.110.172]:59202 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbfKUQrM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Nov 2019 11:47:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7F8F328;
        Thu, 21 Nov 2019 08:47:11 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A30043F52E;
        Thu, 21 Nov 2019 08:47:10 -0800 (PST)
Date:   Thu, 21 Nov 2019 16:47:05 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 2/2] PCI: uniphier: Add checking whether PERST# is
 deasserted
Message-ID: <20191121164705.GA14229@e121166-lin.cambridge.arm.com>
References: <20191107205239.65C1.4A936039@socionext.com>
 <20191107124617.GA43905@e119886-lin.cambridge.arm.com>
 <20191108163026.0DFB.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108163026.0DFB.4A936039@socionext.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 08, 2019 at 04:30:27PM +0900, Kunihiko Hayashi wrote:
> > However, If I understand correctly, doesn't your solution only work some
> > of the time? What happens if you boot both machines at the same time,
> > and PERST# isn't asserted prior to the kernel booting?
> 
> I think it contains an annoying problem.
> 
> If PERST# isn't toggled prior to the kernel booting, PERST# remains asserted
> and the RC driver can't access PCI bus.
> 
> As a result, this patch works and deasserts PERST# (and EP configuration will
> be lost). So boot sequence needs to include deasserting PERST#.

I am sorry but I have lost you. Can you explain to us why checking
that PERST# is deasserted guarantees you that:

- The EP has bootstrapped
- It is safe not to toggle it again (and also skip
  uniphier_pcie_ltssm_enable())

Please provide details of the HW configuration so that we understand
what's actually supposed to happen and why this patch fixes the
issue you are facing.

Thanks,
Lorenzo
