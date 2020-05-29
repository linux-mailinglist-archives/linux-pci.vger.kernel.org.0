Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A451E7A74
	for <lists+linux-pci@lfdr.de>; Fri, 29 May 2020 12:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgE2KX3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 May 2020 06:23:29 -0400
Received: from foss.arm.com ([217.140.110.172]:34642 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbgE2KX1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 May 2020 06:23:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 161EA1045;
        Fri, 29 May 2020 03:23:26 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 595753F52E;
        Fri, 29 May 2020 03:23:24 -0700 (PDT)
Date:   Fri, 29 May 2020 11:23:17 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Vidya Sagar <vidyas@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: fix runtime pm imbalance on error
Message-ID: <20200529102317.GA12270@e121166-lin.cambridge.arm.com>
References: <20200520163739.GA1100601@bjorn-Precision-5520>
 <e7c967a0-c285-450a-bbad-f6456c661d41@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7c967a0-c285-450a-bbad-f6456c661d41@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 20, 2020 at 11:39:08PM +0530, Vidya Sagar wrote:
> Thanks for pushing a patch to fix it. I've been under the wrong assumption
> that a failing pm_runtime_get_sync() wouldn't increment the usage counter.
> With Thierry's and Bjorn's comments addressed
> 
> Acked-by: Vidya Sagar <vidyas@nvidia.com>

Thierry, Vidya,

are your ACKs applying also to:

https://patchwork.kernel.org/patch/11562109/

Dinghao did not carry them over and I could not understand from this
thread if your ACKs apply to both tegra and tegra194.

Thanks,
Lorenzo

> On 20-May-20 10:07 PM, Bjorn Helgaas wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Wed, May 20, 2020 at 11:59:08AM +0200, Thierry Reding wrote:
> > > On Wed, May 20, 2020 at 04:52:23PM +0800, Dinghao Liu wrote:
> > > > pm_runtime_get_sync() increments the runtime PM usage counter even
> > > > it returns an error code. Thus a pairing decrement is needed on
> > > 
> > > s/even it/even when it/
> > > 
> > > Might also be a good idea to use a different subject prefix because I
> > > was almost not going to look at the other patch, taking this to be a
> > > replacement for it.
> > 
> > Amen.  This would be a good change to start using "PCI: tegra194" or
> > something for pcie-tegra194.c.  Or will there be tegra195, tegra 196,
> > etc added to this driver?
> > 
> > Also, please capitalize the first word and "PM" in the subjects:
> > 
> >    PCI: tegra194: Fix runtime PM imbalance on error
> > 
> > Bjorn
> > 
