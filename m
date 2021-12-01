Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3004650C2
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 16:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243791AbhLAPHr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 10:07:47 -0500
Received: from foss.arm.com ([217.140.110.172]:39154 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350294AbhLAPHl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Dec 2021 10:07:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BB3B143B;
        Wed,  1 Dec 2021 07:04:20 -0800 (PST)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5522C3F766;
        Wed,  1 Dec 2021 07:04:18 -0800 (PST)
Date:   Wed, 1 Dec 2021 15:04:12 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, kishon@ti.com
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        Om Prakash Singh <omp@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] PCI: endpoint: Fix core_init_notifier feature
Message-ID: <20211201150412.GA13833@lpieralisi>
References: <1630473361-27198-1-git-send-email-hayashi.kunihiko@socionext.com>
 <74df1b92-60e8-34da-2d39-236bdeea3fc6@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74df1b92-60e8-34da-2d39-236bdeea3fc6@socionext.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 16, 2021 at 08:30:35PM +0900, Kunihiko Hayashi wrote:
> Gentle ping, are there any comments about this series?

Kishon,

can you have a look please ?

Thanks,
Lorenzo

> Thank you,
> 
> On 2021/09/01 14:15, Kunihiko Hayashi wrote:
> > This series has two fixes for core_init_notifier feature.
> > 
> > Fix the bug that the driver can't register its notifier function
> > if core_init_notifier == true and linkup_notifier == false.
> > 
> > If enabling the controller is delayed due to core_init_notifier,
> > accesses to the controller register should be avoided rather than
> > enabling the controller.
> > 
> > Changes since v1:
> > - Add Acked-by and Reviewed-by lines
> > 
> > Kunihiko Hayashi (2):
> >    PCI: endpoint: pci-epf-test: register notifier if only
> >      core_init_notifier is enabled
> >    PCI: designware-ep: Fix the access to DBI/iATU registers before
> >      enabling controller
> > 
> >   drivers/pci/controller/dwc/pcie-designware-ep.c | 81 +++++++++++++------------
> >   drivers/pci/endpoint/functions/pci-epf-test.c   |  2 +-
> >   2 files changed, 42 insertions(+), 41 deletions(-)
> > 
> 
> -- 
> ---
> Best Regards
> Kunihiko Hayashi
