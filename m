Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A70CA26CDA4
	for <lists+linux-pci@lfdr.de>; Wed, 16 Sep 2020 23:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgIPVCg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Sep 2020 17:02:36 -0400
Received: from foss.arm.com ([217.140.110.172]:33468 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgIPQPR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Sep 2020 12:15:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66F0114F6;
        Wed, 16 Sep 2020 07:09:22 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30EEB3F68F;
        Wed, 16 Sep 2020 07:09:21 -0700 (PDT)
Date:   Wed, 16 Sep 2020 15:09:14 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Clint Sbisa <csbisa@amazon.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-arm-kernel@lists.infradead.org, will@kernel.org,
        catalin.marinas@arm.com, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
Message-ID: <20200916140914.GA20770@e121166-lin.cambridge.arm.com>
References: <375c478593945a416f3180c3773bcb5240d2e36c.camel@kernel.crashing.org>
 <1d6f2ceb8d3538c906a1fdb8cd3d4c74ccffa42e.camel@kernel.crashing.org>
 <20200914225740.GP904879@nvidia.com>
 <2b539df4c9ec703458e46da2fc879ee3b310b31c.camel@kernel.crashing.org>
 <20200915101831.GA2616@e121166-lin.cambridge.arm.com>
 <20200915110511.GQ904879@nvidia.com>
 <bcb95faafa72734478b942084a9d24a61ae9887f.camel@kernel.crashing.org>
 <20200915234006.GI1573713@nvidia.com>
 <701012f288231d0d0733bf1c2c8fdbd9caa074fd.camel@kernel.crashing.org>
 <20200916121226.GN1573713@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916121226.GN1573713@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 16, 2020 at 09:12:26AM -0300, Jason Gunthorpe wrote:

[...]

> > You mean the driver uses a different path to the HW which ahs that
> > overhead, not that MMIOs have that overhead right ?
> 
> The different path has overhead of doing extra useless MMIOs because
> they don't combine

For my own information, this is IB user space driver code, correct ? It
tries to mmap buffer as WC and if it succeeds write into it in an
optimized fashion (that is just pure overhead on platforms where normal
NC memory - ie WC on arm64 - does not do what the _architecture_ defines
it should).

Lorenzo
