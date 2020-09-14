Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5D42697DC
	for <lists+linux-pci@lfdr.de>; Mon, 14 Sep 2020 23:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgINVmx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 17:42:53 -0400
Received: from kernel.crashing.org ([76.164.61.194]:36594 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgINVmv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2020 17:42:51 -0400
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 08ELfn7G004136
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 14 Sep 2020 16:41:53 -0500
Message-ID: <2162790a078034604779afd49bb84ef3e21d9ba4.camel@kernel.crashing.org>
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Jason Gunthorpe <jgg@nvidia.com>, Clint Sbisa <csbisa@amazon.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        linux-arm-kernel@lists.infradead.org, will@kernel.org,
        catalin.marinas@arm.com, Leon Romanovsky <leon@kernel.org>
Date:   Tue, 15 Sep 2020 07:41:48 +1000
In-Reply-To: <20200914141726.GA904879@nvidia.com>
References: <20200903110844.GB11284@e121166-lin.cambridge.arm.com>
         <28d333afc73bd854390f8c39691a735040ba5b39.camel@kernel.crashing.org>
         <20200910094600.GA22840@e121166-lin.cambridge.arm.com>
         <20200910123758.GC904879@nvidia.com>
         <20200910151721.GA25809@e121166-lin.cambridge.arm.com>
         <20200910171033.GG904879@nvidia.com>
         <44acc22377958a57c738f5139c5b5df2841c2544.camel@kernel.crashing.org>
         <20200910232938.GJ904879@nvidia.com>
         <3110e00a1f4df7b7359ba4f2b7f86a35aa47405e.camel@kernel.crashing.org>
         <20200911214225.hml2wbbq2rofn4re@amazon.com>
         <20200914141726.GA904879@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2020-09-14 at 11:17 -0300, Jason Gunthorpe wrote:
> On Fri, Sep 11, 2020 at 09:42:25PM +0000, Clint Sbisa wrote:
> 
> > There's no DMA involved with this BAR-- the driver writes a portion
> > of the
> > packet contents in addition to the descriptors, which generally
> > increases the
> > number of TLPs if write-combine isn't used. Furthermore, this BAR
> > is only used
> > for writes and never for reads.
> 
> You use DPDK without DMA? How does receive work?
> 
> > As Jason noted in the other reply to this email, the Linux ENA
> > driver makes use
> > of WC by using devm_ioremap_wc().
> 
> As Ben noted we don't have kernel accessors to make this portable or
> safe :(

Well.. to be frank it does work "well enough" for simple cases like
frame buffers :-)

Cheers
Ben.


