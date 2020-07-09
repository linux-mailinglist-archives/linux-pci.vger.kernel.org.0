Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F41121A9E3
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jul 2020 23:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgGIVr4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jul 2020 17:47:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:40458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726311AbgGIVrz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Jul 2020 17:47:55 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28DD120774;
        Thu,  9 Jul 2020 21:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594331275;
        bh=X/RbrgmMEAFhpcmxsuI6o1tnFCIhreoKEGLJxGBir+Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CC1DYYJ0Qp8fQyyYG0iTL+iHk9v+HDV/NOxDKOponp+fivZeaH5qbba0fotKAbVg9
         IjU/ByjOBcdBt4EjnEeMXDcrlVQTYFMpaWbOUUaIv1sbvODUtwfpy76kxk/280Me/O
         m6v0yEl0tMRMbtum6CorvGRvwpzt6BteA+AFq3WQ=
Date:   Thu, 9 Jul 2020 16:47:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Marc Zyngier <maz@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org,
        Sushma Kalakota <sushmax.kalakota@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] irqdomain/treewide: Keep firmware node unconditionally
 allocated
Message-ID: <20200709214753.GA20422@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873661qakd.fsf@nanos.tec.linutronix.de>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 09, 2020 at 11:53:06AM +0200, Thomas Gleixner wrote:
> Quite some non OF/ACPI users of irqdomains allocate firmware nodes of type
> IRQCHIP_FWNODE_NAMED or IRQCHIP_FWNODE_NAMED_ID and free them right after
> creating the irqdomain. The only purpose of these FW nodes is to convey
> name information. When this was introduced the core code did not store the
> pointer to the node in the irqdomain. A recent change stored the firmware
> node pointer in irqdomain for other reasons and missed to notice that the
> usage sites which do the alloc_fwnode/create_domain/free_fwnode sequence
> are broken by this. Storing a dangling pointer is dangerous itself, but in
> case that the domain is destroyed later on this leads to a double free.
> 
> Remove the freeing of the firmware node after creating the irqdomain from
> all affected call sites to cure this.
> 
> Fixes: 711419e504eb ("irqdomain: Add the missing assignment of domain->fwnode for named fwnode")
> Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: stable@vger.kernel.org

Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# drivers/pci/
