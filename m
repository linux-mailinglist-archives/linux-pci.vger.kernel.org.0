Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBFB126988B
	for <lists+linux-pci@lfdr.de>; Tue, 15 Sep 2020 00:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbgINWFy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 18:05:54 -0400
Received: from kernel.crashing.org ([76.164.61.194]:36650 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgINWFy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2020 18:05:54 -0400
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 08EM0SoD004289
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 14 Sep 2020 17:00:32 -0500
Message-ID: <1d6f2ceb8d3538c906a1fdb8cd3d4c74ccffa42e.camel@kernel.crashing.org>
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Jason Gunthorpe <jgg@nvidia.com>, Clint Sbisa <csbisa@amazon.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        linux-arm-kernel@lists.infradead.org, will@kernel.org,
        catalin.marinas@arm.com, Leon Romanovsky <leon@kernel.org>
Date:   Tue, 15 Sep 2020 08:00:27 +1000
In-Reply-To: <375c478593945a416f3180c3773bcb5240d2e36c.camel@kernel.crashing.org>
References: <20200910094600.GA22840@e121166-lin.cambridge.arm.com>
         <20200910123758.GC904879@nvidia.com>
         <20200910151721.GA25809@e121166-lin.cambridge.arm.com>
         <20200910171033.GG904879@nvidia.com>
         <44acc22377958a57c738f5139c5b5df2841c2544.camel@kernel.crashing.org>
         <20200910232938.GJ904879@nvidia.com>
         <3110e00a1f4df7b7359ba4f2b7f86a35aa47405e.camel@kernel.crashing.org>
         <20200911214225.hml2wbbq2rofn4re@amazon.com>
         <20200914141726.GA904879@nvidia.com>
         <20200914142406.k44zrnp2wdsandsp@amazon.com>
         <20200914143819.GC904879@nvidia.com>
         <375c478593945a416f3180c3773bcb5240d2e36c.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2020-09-15 at 07:42 +1000, Benjamin Herrenschmidt wrote:
> 
> > which is back to my original question, how do you do DMA using
> > /sys/xx/resources? Why not use VFIO like everything else?
> 
> Note: All this doesnt' change the fact that sys/xx/resources_wc
> exists
> for other archs and I see no reasons so far not to have it on ARM...

Also... it looks like VFIO also doesn't provide a way to do WC yet
unfortunately :-(

There was a discussion 2 or 3 years ago while I was at IBM about ways
to add that functionality, but it doesn't seem to have resulted in
anything.

Cheers,
Ben.


