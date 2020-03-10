Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4D751805AD
	for <lists+linux-pci@lfdr.de>; Tue, 10 Mar 2020 18:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgCJR6l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Mar 2020 13:58:41 -0400
Received: from foss.arm.com ([217.140.110.172]:40532 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbgCJR6k (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Mar 2020 13:58:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D482A30E;
        Tue, 10 Mar 2020 10:58:39 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D70C93F534;
        Tue, 10 Mar 2020 10:58:37 -0700 (PDT)
Date:   Tue, 10 Mar 2020 17:58:28 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, andrew.murray@arm.com, kishon@ti.com,
        gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V4 0/5] Add support for PCIe endpoint mode in Tegra194
Message-ID: <20200310175820.GA13909@e121166-lin.cambridge.arm.com>
References: <20200303105418.2840-1-vidyas@nvidia.com>
 <20200303170103.GA9641@e121166-lin.cambridge.arm.com>
 <d1e3a42f-c179-fd03-fac0-7cd449580e5b@nvidia.com>
 <b47de9cd-be18-1672-d72c-de4169fb90e5@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b47de9cd-be18-1672-d72c-de4169fb90e5@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 10, 2020 at 11:12:35PM +0530, Vidya Sagar wrote:
> 
> 
> On 3/3/2020 11:43 PM, Vidya Sagar wrote:
> > 
> > 
> > On 3/3/2020 10:31 PM, Lorenzo Pieralisi wrote:
> > > External email: Use caution opening links or attachments
> > > 
> > > 
> > > On Tue, Mar 03, 2020 at 04:24:13PM +0530, Vidya Sagar wrote:
> > > > Tegra194 has three (C0, C4 & C5) dual mode PCIe controllers that
> > > > can operate
> > > > either in root port mode or in end point mode but only in one
> > > > mode at a time.
> > > > Platform P2972-0000 supports enabling endpoint mode for C5
> > > > controller. This
> > > > patch series adds support for PCIe endpoint mode in both the
> > > > driver as well as
> > > > in DT.
> > > > This patch series depends on the changes made for Synopsys
> > > > DesignWare endpoint
> > > > mode subsystem that are recently accepted.
> > > > @ https://patchwork.kernel.org/project/linux-pci/list/?series=202211
> > > > which in turn depends on the patch made by Kishon
> > > > @ https://patchwork.kernel.org/patch/10975123/
> > > > which is also under review.
> > > > 
> > > > V4:
> > > > * Started using threaded irqs instead of kthreads
> > > 
> > > Hi Vidya,
> > > 
> > > sorry for the bother, may I ask you to rebase the series (after
> > > answering Thierry's query) on top of my pci/endpoint branch please ?
> > > 
> > > Please resend it and I will merge patches {1,2,5} then.
> > Sure.
> > I just sent V5 series rebasing patches on top of your pci/endpoint branch.
> Hi,
> Sorry to bother you again.
> Could you please take a look at V5 series?

I will merge it tomorrow, apologies.

Thanks,
Lorenzo
