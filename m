Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D51044D0A
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2019 22:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfFMUJf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 16:09:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:46426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbfFMUJf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Jun 2019 16:09:35 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1654420B7C;
        Thu, 13 Jun 2019 20:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560456574;
        bh=eQj63h8OCCsmMvkjVVnO0QbXAh3YrpBesVcLGSyN+1Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JcfxDoqUPK3n5IVChceyR/hB3kr/taJFeMbOnBcOsBePn3MFgnepNEMUZAT6jYLQq
         +JiQAwbZMzg+ag4ZULmUXs2Na6deMkwfO9z9/7//Ny2fX39kYWm4b7zbmxNxOohV61
         j+B5Ew5pIVMqbVQDzvtbpjpfZnab3NfpBwUiINWY=
Date:   Thu, 13 Jun 2019 15:09:32 -0500
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
Message-ID: <20190613200932.GJ13533@google.com>
References: <1560262374-67875-1-git-send-email-john.garry@huawei.com>
 <1560262374-67875-2-git-send-email-john.garry@huawei.com>
 <20190613023947.GD13533@google.com>
 <8ef228f8-97cb-e40e-ea6b-410b80a845cf@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ef228f8-97cb-e40e-ea6b-410b80a845cf@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 13, 2019 at 10:39:12AM +0100, John Garry wrote:
> On 13/06/2019 03:39, Bjorn Helgaas wrote:
> > I'm not sure it's even safe, because CONFIG_INDIRECT_PIO depends on
> > ARM64,  but PCI_IOBASE is defined on most arches via asm-generic/io.h,
> > so this potentially affects arches other than ARM64.
> 
> It would do. It would affect any arch which defines PCI_IOBASE and
> does not have arch-specific definition of inb et all.

What's the reason for testing PCI_IOBASE instead of
CONFIG_INDIRECT_PIO?  If there's a reason it's needed, that's fine,
but it does make this much more complicated to review.

Bjorn
