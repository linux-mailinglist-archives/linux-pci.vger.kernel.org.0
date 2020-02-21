Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9B916825C
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2020 16:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgBUPy3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Feb 2020 10:54:29 -0500
Received: from foss.arm.com ([217.140.110.172]:42312 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728441AbgBUPy3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Feb 2020 10:54:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04E8230E;
        Fri, 21 Feb 2020 07:54:29 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF4293F68F;
        Fri, 21 Feb 2020 07:54:27 -0800 (PST)
Date:   Fri, 21 Feb 2020 15:54:20 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Vidya Sagar <vidyas@nvidia.com>,
        Athani Nadeem Ladkhan <nadeem@cadence.com>,
        Tom Joseph <tjoseph@cadence.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] PCI: Endpoint: Miscellaneous improvements
Message-ID: <20200221155258.GA16729@e121166-lin.cambridge.arm.com>
References: <20200212112514.2000-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212112514.2000-1-kishon@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 12, 2020 at 04:55:09PM +0530, Kishon Vijay Abraham I wrote:
> Changes from v1:
> Rebased to Linux 5.6-rc1 and removed dependencies to my other series
> to unblock [1]
> 
> [1] -> http://lore.kernel.org/r/20200103100736.27627-1-vidyas@nvidia.com
> 
> v1 of this patch series can be found @
> http://lore.kernel.org/r/20191231100331.6316-1-kishon@ti.com
> 
> This series adds miscellaneous improvements to PCIe endpoint core.
> 1) Protect concurrent access to memory allocation in pci-epc-mem
> 2) Replace spinlock with mutex in pci-epc-core and also use
>    notification chain mechanism to notify EPC events to EPF driver.
> 3) Since endpoint function device can be created by multiple
>    mechanisms (configfs, devicetree, etc..), allowing each of these
>    mechanisms to assign a function number would result in mutliple
>    endpoint function devices having the same function number. In order
>    to avoid this, let EPC core assign a function number to the
>    endpoint device.

Hi Kishon,

I am about to apply this series but I could not help notice that
some of these patches are fixes rather than improvements, it would
be good to propagate the changes to older kernels too provided
we explain the bugs in the respective logs, in particular for (3)
above it should not be complicated to reproduce a failure.

Thanks,
Lorenzo

> Kishon Vijay Abraham I (5):
>   PCI: endpoint: Use notification chain mechanism to notify EPC events
>     to EPF
>   PCI: endpoint: Replace spinlock with mutex
>   PCI: endpoint: Protect concurrent access to memory allocation with
>     mutex
>   PCI: endpoint: Protect concurrent access to pci_epf_ops with mutex
>   PCI: endpoint: Assign function number for each PF in EPC core
> 
>  drivers/pci/endpoint/functions/pci-epf-test.c |  13 +-
>  drivers/pci/endpoint/pci-ep-cfs.c             |  27 +----
>  drivers/pci/endpoint/pci-epc-core.c           | 113 ++++++++----------
>  drivers/pci/endpoint/pci-epc-mem.c            |  10 +-
>  drivers/pci/endpoint/pci-epf-core.c           |  33 ++---
>  include/linux/pci-epc.h                       |  19 ++-
>  include/linux/pci-epf.h                       |   9 +-
>  7 files changed, 108 insertions(+), 116 deletions(-)
> 
> -- 
> 2.17.1
> 
