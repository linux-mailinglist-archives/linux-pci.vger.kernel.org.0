Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE9B25B71C
	for <lists+linux-pci@lfdr.de>; Thu,  3 Sep 2020 01:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgIBXI2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Sep 2020 19:08:28 -0400
Received: from kernel.crashing.org ([76.164.61.194]:53506 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgIBXI1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Sep 2020 19:08:27 -0400
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 082N87Jl005474
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 2 Sep 2020 18:08:11 -0500
Message-ID: <32538f9d35a4adefde02acb0e37c2447d67fd349.camel@kernel.crashing.org>
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Clint Sbisa <csbisa@amazon.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-arm-kernel@lists.infradead.org, will@kernel.org
Date:   Thu, 03 Sep 2020 09:08:06 +1000
In-Reply-To: <20200902172156.GD16673@gaia>
References: <20200831151827.pumm2p54fyj7fz5s@amazon.com>
         <20200902113207.GA27676@e121166-lin.cambridge.arm.com>
         <20200902142922.xc4x6m33unkzewuh@amazon.com>
         <20200902164702.GA30611@e121166-lin.cambridge.arm.com>
         <20200902172156.GD16673@gaia>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2020-09-02 at 18:21 +0100, Catalin Marinas wrote:
> > I understand we do want weak ordering for prefetchable BAR mappings
> > but my worry is that by exposing the resources as WC to user space
> > we are giving user space the impression that those mappings mirror
> > x86 WC mappings behaviour that is not true on ARM64.
> 
> Would Device_GRE be close to the x86 WC better? It won't allow
> unaligned
> accesses and that can be problematic for the user. OTOH, it doesn't
> speculate reads, so it's safer from the hardware perspective.

Its accepted generally that prefetchable BARs can allow speculative
accesses, write combining, re-ordering even etc... and it's also
commonly be the target of unaligned accesses.

In reality, in PCI land, it really means "no side effects".

Cheers,
Ben.


