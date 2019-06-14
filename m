Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B23BE45BB6
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2019 13:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbfFNLu7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jun 2019 07:50:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:60770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727434AbfFNLu6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Jun 2019 07:50:58 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B5F32168B;
        Fri, 14 Jun 2019 11:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560513058;
        bh=uMLCxfgCikGdC+QC7VrDvh04xE8Slxir3W8oO9YHF+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nCk2pYF4Yk+dVb3EOoGZy1Nzord7PDDyF8WuKXGqkFjwO7KYjTDQGUyKUVhj6Lzri
         C3/zEhik78cxTA7iaBE8s7ThRfSUtdxaZZaz9FnUwjhYC0ivWoL1zDXlWtdFKJsoMG
         u3tGG3e6A7cxIZ+5Gp9hiEBJpTV+KaTaMAofQUuU=
Date:   Fri, 14 Jun 2019 06:50:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     lorenzo.pieralisi@arm.com, arnd@arndb.de,
        linux-pci@vger.kernel.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org, will.deacon@arm.com,
        wangkefeng.wang@huawei.com, linuxarm@huawei.com,
        andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com
Subject: Re: [PATCH v4 1/3] lib: logic_pio: Use logical PIO low-level
 accessors for !CONFIG_INDIRECT_PIO
Message-ID: <20190614115056.GP13533@google.com>
References: <1560262374-67875-1-git-send-email-john.garry@huawei.com>
 <1560262374-67875-2-git-send-email-john.garry@huawei.com>
 <20190613023947.GD13533@google.com>
 <8ef228f8-97cb-e40e-ea6b-410b80a845cf@huawei.com>
 <20190613200932.GJ13533@google.com>
 <7495dcab-f293-4b2a-4740-2249f61351f7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7495dcab-f293-4b2a-4740-2249f61351f7@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 14, 2019 at 10:02:52AM +0100, John Garry wrote:
> On 13/06/2019 21:09, Bjorn Helgaas wrote:
> > On Thu, Jun 13, 2019 at 10:39:12AM +0100, John Garry wrote:
> > > On 13/06/2019 03:39, Bjorn Helgaas wrote:
> > > > I'm not sure it's even safe, because CONFIG_INDIRECT_PIO depends on
> > > > ARM64,  but PCI_IOBASE is defined on most arches via asm-generic/io.h,
> > > > so this potentially affects arches other than ARM64.
> > > 
> > > It would do. It would affect any arch which defines PCI_IOBASE and
> > > does not have arch-specific definition of inb et all.
> 
> > What's the reason for testing PCI_IOBASE instead of
> > CONFIG_INDIRECT_PIO?  If there's a reason it's needed, that's fine,
> > but it does make this much more complicated to review.
> 
> For ARM64, we have PCI_IOBASE defined but may not have
> CONFIG_INDIRECT_PIO defined. Currently CONFIG_INDIRECT_PIO is only
> selected by CONFIG_HISILICON_LPC.
> 
> As such, we should make this change also for when
> CONFIG_INDIRECT_PIO is not defined.

OK.  This is all very important for the commit log -- we need to
understand what arches are affected and the reason they need it.

Since the goal of this series is to fix an ARM64-specific issue, and
the typical port I/O model is for each arch to #define its own inb(),
maybe it would make sense to move the "#define inb logic_inb" from
linux/logic_pio.h to arm64/include/asm/io.h?

The "#ifndef inb" arrangement gets pretty complicated when it occurs
more than one place (asm-generic/io.h and logic_pio.h) and we have to
start worrying about the ordering of #includes.

Bjorn
