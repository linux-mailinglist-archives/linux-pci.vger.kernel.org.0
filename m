Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B18219F82
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jul 2020 14:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgGIMBC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jul 2020 08:01:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:49290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbgGIMBC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Jul 2020 08:01:02 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B28E206C3;
        Thu,  9 Jul 2020 12:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594296061;
        bh=G9bmSFELKRxQPZ+NTn/InZnU9Px+G3f6WIIbF0sa7VQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W3B8WlB78HBGwrFnK785PkNtYGqHBvxgmEZjQ6cwZYSKsdt/WKie6QVgUhSwSY17R
         umEt+YyxTxQ/57mWnWm1QNwPOYsuNrwoXnueLtkQFIorEJNiR/AZATrJb8RRL5Gqgx
         t/yEKgISVcv5GEhh8CZqzE+IqhpZY3M3CSeJw9JQ=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jtVEZ-00ANHv-S1; Thu, 09 Jul 2020 13:00:59 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 09 Jul 2020 13:00:59 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org,
        Sushma Kalakota <sushmax.kalakota@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] irqdomain/treewide: Keep firmware node unconditionally
 allocated
In-Reply-To: <873661qakd.fsf@nanos.tec.linutronix.de>
References: <20200706154410.GA117493@bjorn-Precision-5520>
 <873661qakd.fsf@nanos.tec.linutronix.de>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <b90acf9f348f2eb7b7244913c130cbff@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: tglx@linutronix.de, helgaas@kernel.org, andriy.shevchenko@linux.intel.com, jonathan.derrick@intel.com, lorenzo.pieralisi@arm.com, linux-pci@vger.kernel.org, sushmax.kalakota@intel.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thomas,

Catching up on email...

On 2020-07-09 10:53, Thomas Gleixner wrote:
> Quite some non OF/ACPI users of irqdomains allocate firmware nodes of 
> type
> IRQCHIP_FWNODE_NAMED or IRQCHIP_FWNODE_NAMED_ID and free them right 
> after
> creating the irqdomain. The only purpose of these FW nodes is to convey
> name information. When this was introduced the core code did not store 
> the
> pointer to the node in the irqdomain. A recent change stored the 
> firmware
> node pointer in irqdomain for other reasons and missed to notice that 
> the
> usage sites which do the alloc_fwnode/create_domain/free_fwnode 
> sequence
> are broken by this. Storing a dangling pointer is dangerous itself, but 
> in
> case that the domain is destroyed later on this leads to a double free.
> 
> Remove the freeing of the firmware node after creating the irqdomain 
> from
> all affected call sites to cure this.
> 
> Fixes: 711419e504eb ("irqdomain: Add the missing assignment of
> domain->fwnode for named fwnode")
> Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: stable@vger.kernel.org

Urgh, that's pretty disastrous. My bad. Thanks a lot for having
put this patch together.

Acked-by: Marc Zyngier <maz@kernel.org>

If you can take it directly into Linus' tree, that'd be greatly
appreciated.

Thanks again,

         M.
-- 
Jazz is not dead. It just smells funny...
