Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDC4C194EB
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2019 23:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfEIVts (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 May 2019 17:49:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:57678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbfEIVts (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 May 2019 17:49:48 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8827217D7;
        Thu,  9 May 2019 21:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557438588;
        bh=DNYF0XAZHikO5naLw8zwpVh5tp2jK6gYi5MIZybDugA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PCmZHR/425O6CqVM+hAgxbLbc9oj7WysMXnOT9UbzwK5lyeHnNhoKzIBvyh64D6up
         1q1t6fR2sbOVmI72yt8AguPy79F1J0s74LhXOlF/+GAMQ9gRE3Bq9nAuXSAyxdqV0G
         50JDm/jVCaVu+dpBP++a992tsT0k27FR3xyBwHH8=
Date:   Thu, 9 May 2019 16:49:46 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Frederick Lawler <fred@fredlawl.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 00/10] PCI: Log with pci_dev, not pcie_device
Message-ID: <20190509214946.GF235064@google.com>
References: <20190509141456.223614-1-helgaas@kernel.org>
 <CAHp75VdrQgu3Tis1V1j1AgjS=Uvw-7tz5ke4kSxRWM=0DrSjhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdrQgu3Tis1V1j1AgjS=Uvw-7tz5ke4kSxRWM=0DrSjhw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 09, 2019 at 08:49:08PM +0300, Andy Shevchenko wrote:
> On Thu, May 9, 2019 at 5:18 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > From: Bjorn Helgaas <bhelgaas@google.com>
> >
> > This is a collection of updates to Fred's v2 patches from:
> >
> >   https://lore.kernel.org/lkml/20190503035946.23608-1-fred@fredlawl.com
> >
> > and some follow-on discussion.
> >
> 
> For non-commented patches,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> For the commented ones, I hope you will address them, and then my tag
> applies for them as well.

Thanks, Andy and Keith, I really appreciate you taking a look.  Andy,
I added your tag to all except these:

> >   PCI/PME: Replace dev_printk(KERN_DEBUG) with dev_info()
> >   PCI/DPC: Log messages with pci_dev, not pcie_device

because I didn't make the capitalization and other message changes you
pointed out.  I'd totally be fine with those changes, but I don't
think we have time to do a complete job of it for this cycle.

Bjorn
