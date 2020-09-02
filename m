Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 219D425B721
	for <lists+linux-pci@lfdr.de>; Thu,  3 Sep 2020 01:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgIBXJZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Sep 2020 19:09:25 -0400
Received: from kernel.crashing.org ([76.164.61.194]:53484 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgIBXH0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Sep 2020 19:07:26 -0400
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 082N72VH005449
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 2 Sep 2020 18:07:06 -0500
Message-ID: <edae1eeb0da578d941cfa5ad550eb0a0eda5f98e.camel@kernel.crashing.org>
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Clint Sbisa <csbisa@amazon.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        linux-arm-kernel@lists.infradead.org, will@kernel.org,
        catalin.marinas@arm.com
Date:   Thu, 03 Sep 2020 09:07:00 +1000
In-Reply-To: <20200902164702.GA30611@e121166-lin.cambridge.arm.com>
References: <20200831151827.pumm2p54fyj7fz5s@amazon.com>
         <20200902113207.GA27676@e121166-lin.cambridge.arm.com>
         <20200902142922.xc4x6m33unkzewuh@amazon.com>
         <20200902164702.GA30611@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2020-09-02 at 17:47 +0100, Lorenzo Pieralisi wrote:
> Yes I do and I expressed them.
> 
> The first concern is the WC ambiguity on non-x86 systems, it looks
> like write combinining means everything and nothing at the same time
> on != x86 arches.
> 
> On x86 prefetchable BAR == WC mapping (still conditional on arch
> features ie PAT, not a blanket enable). On ARM64 WC mapping currently
> corresponds to normal NC memory and the PCIe specs allow read
> side-effects BAR to be marked as prefetchable, I need to force PCI
> sig
> to remove the section I mentioned from the specifications because
> there
> is NO way it can be detected if a prefetchable BAR maps to read
> side-effects memory.

Im not sure I understand your sentence. It's been a long accepted rule
in PCI land that "prefetchable" BARs means "no side effects" and in
fact allows much more than just prefetching :-)

> A kernel device driver would (hopefully) know, sysfs code that just
> checks the prefetchable attribute and exports resource_WC does not.
>
> As I mentioned, if the mapping is done in a device specific driver it
> can be vetted and there are not many drivers mapping BARs as
> ioremap_wc().

It's been what other architectures have been doing for mroe than a
decade without significant issues... I don't think you should worry too
much about this.

Cheers,
Ben.


