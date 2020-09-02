Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF5325A81F
	for <lists+linux-pci@lfdr.de>; Wed,  2 Sep 2020 10:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgIBI5Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Sep 2020 04:57:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbgIBI5Y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Sep 2020 04:57:24 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C6E52078B;
        Wed,  2 Sep 2020 08:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599037043;
        bh=erLxW7j5o7FSd5rj0NxqCWgy7aHZnjT+0Hthxz+0GSs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2C2LDLZM6uC4k8iSv3Mz8/3quiEVc3q0umMdFmNtQqrnya7FWr16ikqavSfC+T3nt
         dbPBlHZNobA/Jax+WjT66d0sa/2QJTnZKbSh5cRslrhmeQVGDZN/i9pTzihIQtj+CL
         UdkO08lDzzCs7wMkNo64+gRYPs4aDUon7HvDE/qw=
Date:   Wed, 2 Sep 2020 09:57:18 +0100
From:   Will Deacon <will@kernel.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Clint Sbisa <csbisa@amazon.com>, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
Message-ID: <20200902085717.GA5409@willie-the-truck>
References: <20200901183702.GA196025@bjorn-Precision-5520>
 <658051b1ba6533fef92648eba08dfdf240af7a18.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <658051b1ba6533fef92648eba08dfdf240af7a18.camel@kernel.crashing.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 02, 2020 at 09:22:53AM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2020-09-01 at 13:37 -0500, Bjorn Helgaas wrote:
> > On Mon, Aug 31, 2020 at 03:18:27PM +0000, Clint Sbisa wrote:
> > > Using write-combine is crucial for performance of PCI devices where
> > > significant amounts of transactions go over PCI BARs.
> > > 
> > > arm64 supports write-combine PCI mappings, so the appropriate
> > > define
> > > has been added which will expose write-combine mappings under sysfs
> > > for prefetchable PCI resources.
> > > 
> > > Signed-off-by: Clint Sbisa <csbisa@amazon.com>
> > 
> > Fine with me, I assume Will or Catalin will apply this.
> 
> Haha ! Client had sent it to them originally and I told him to resend
> it to linux-pci, yourself and Lorenzo :-)
> 
> So the confusion is on me.
> 
> Will, Catalin, it's all yours. You should have the original patch in
> your mbox already, otherwise:
> 
> https://patchwork.kernel.org/patch/11729875/

Yup, it's not the radar. We don't usually start queuing stuff until -rc3, so
I'm working through the backlog this week. Would like an Ack from Lorenzo,
though.

Will
