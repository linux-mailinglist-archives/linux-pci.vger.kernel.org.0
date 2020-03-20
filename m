Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4792418CAD2
	for <lists+linux-pci@lfdr.de>; Fri, 20 Mar 2020 10:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgCTJwO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Mar 2020 05:52:14 -0400
Received: from foss.arm.com ([217.140.110.172]:46746 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbgCTJwO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Mar 2020 05:52:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45A3D30E;
        Fri, 20 Mar 2020 02:52:13 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 299363F305;
        Fri, 20 Mar 2020 02:52:12 -0700 (PDT)
Date:   Fri, 20 Mar 2020 09:52:04 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] misc: Improvements to pci_endpoint_test driver
Message-ID: <20200320095204.GA21466@e121166-lin.cambridge.arm.com>
References: <20200317100158.4692-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317100158.4692-1-kishon@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 17, 2020 at 03:31:53PM +0530, Kishon Vijay Abraham I wrote:
> This series adds improvements and fixes to pci_endpoint_test driver
> mostly applicable when used with multi-function endpoint (or multiple
> endpoint instances using pci_epf_test).
> 
> *) Using module parameter to determine irqtype would indicate all the
>    pci_endpoint_test device have the same irqtype. Fix it here.
> *) Add ioctl to clear irq so that "cat /proc/interrupts" only lists
>    the entries for the devices that is actually being used.
> *) Creating more than 10 pci-endpoint-test devices results in a kernel
>    error.
> *) Use full pci-endpoint-test name in request irq so that it's easy to
>    profile the interrupt details in "cat /proc/interrupts"
> 
> Changes from v1:
> *) Removed a patch that references J721E device ID (That patch will
>    be added as part of J721E support series)
> *) Removed a patch that always enable legacy interrupt. That should
>    be handled by pci_alloc_irq_vectors()
> 
> Kishon Vijay Abraham I (5):
>   misc: pci_endpoint_test: Avoid using module parameter to determine
>     irqtype
>   misc: pci_endpoint_test: Add ioctl to clear IRQ
>   tools: PCI: Add 'e' to clear IRQ
>   misc: pci_endpoint_test: Fix to support > 10 pci-endpoint-test devices
>   misc: pci_endpoint_test: Use full pci-endpoint-test name in request
>     irq
> 
>  drivers/misc/pci_endpoint_test.c | 49 +++++++++++++++++++++++++-------
>  include/uapi/linux/pcitest.h     |  1 +
>  tools/pci/pcitest.c              | 16 ++++++++++-
>  3 files changed, 55 insertions(+), 11 deletions(-)

Applied to pci/endpoint for v5.7.

Thanks,
Lorenzo
