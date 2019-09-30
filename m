Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36D87C2399
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2019 16:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731471AbfI3OuC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Sep 2019 10:50:02 -0400
Received: from foss.arm.com ([217.140.110.172]:56078 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731459AbfI3OuC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Sep 2019 10:50:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C2F628;
        Mon, 30 Sep 2019 07:50:01 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7DC63F706;
        Mon, 30 Sep 2019 07:50:00 -0700 (PDT)
Date:   Mon, 30 Sep 2019 15:49:59 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Remi Pommarel <repk@triplefau.lt>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: aardvark: Don't rely on jiffies while holding
 spinlock
Message-ID: <20190930144958.GA42880@e119886-lin.cambridge.arm.com>
References: <20190927085502.1758-1-repk@triplefau.lt>
 <20190927114555.193a9d68@windsurf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190927114555.193a9d68@windsurf>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 27, 2019 at 11:45:55AM +0200, Thomas Petazzoni wrote:
> On Fri, 27 Sep 2019 10:55:02 +0200
> Remi Pommarel <repk@triplefau.lt> wrote:
> 
> > advk_pcie_wait_pio() can be called while holding a spinlock (from
> > pci_bus_read_config_dword()), then depends on jiffies in order to
> > timeout while polling on PIO state registers. In the case the PIO
> > transaction failed, the timeout will never happen and will also cause
> > the cpu to stall.
> > 
> > This decrements a variable and wait instead of using jiffies.
> > 
> > Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> 
> Acked-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> 

Reviewed-by: Andrew Murray <andrew.murray@arm.com>

> Thanks!
> 
> Thomas
> -- 
> Thomas Petazzoni, CTO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
