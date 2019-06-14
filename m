Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F56046895
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2019 22:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725825AbfFNUGC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jun 2019 16:06:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:47812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbfFNUGB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Jun 2019 16:06:01 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DE252173C;
        Fri, 14 Jun 2019 20:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560542761;
        bh=6AW++I2KeuWsGHSu6JA6vMiNYLcuVsi2K4GLEIO/3+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G7iDYR2wO+22rp7C4sRG3HKb8Yvppfd8jh3xhLjUwkILhQmDU7qp3vOaNq41vX2Cp
         4HVkTcnrDTNvvKawNN0V8EVYyXUqmMlx69rFLzuFgXyt1UMU8XGAezwPv22BvU1/0F
         cISsK9vDvwkmVLoQUzYeqmJDwceOSnNJu0aIb5j0=
Date:   Fri, 14 Jun 2019 15:05:57 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Keith Busch <keith.busch@gmail.com>
Cc:     Daniel Drake <drake@endlessm.com>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Keith Busch <kbusch@kernel.org>, linux-ide@vger.kernel.org,
        Linux Upstreaming Team <linux@endlessm.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] PCI: Add Intel remapped NVMe device support
Message-ID: <20190614200557.GS13533@google.com>
References: <20190610074456.2761-1-drake@endlessm.com>
 <CAOSXXT7OFzHeTxNqZ1sS6giRxhDcrUUnVjURWBiFUc5T_8p=MA@mail.gmail.com>
 <CAD8Lp45djPU_Ur8uCO2Y5Sbek_5N9QKkxLXdKNVcvkr6rFPLUQ@mail.gmail.com>
 <CAOSXXT7H6HxY-za66Tr9ybRQyHsTdwwAgk9O2F=xK42MT8HsuA@mail.gmail.com>
 <20190613085402.GC13442@lst.de>
 <CAD8Lp47Vu=w+Lj77_vL05JYV1WMog9WX3FHGE+TseFrhcLoTuA@mail.gmail.com>
 <CAOSXXT4Ba_6xRUyaQBxpq+zdG9_itXDhFJ5EFZPv3CQuJZKHzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOSXXT4Ba_6xRUyaQBxpq+zdG9_itXDhFJ5EFZPv3CQuJZKHzg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 14, 2019 at 01:36:07PM -0600, Keith Busch wrote:

> Even if you wish to forgo the standard features and management
> capabilities, you're still having to deal with legacy IRQ, which has
> IOPs at a fraction of the hardware's true capabilities when using MSI.

> ... your best option is still to set to AHCI mode for Linux
> for this reason alone, and vendors should be providing this option in
> BIOS.

Ugh.  Are you saying the installation instructions for Linux will say
"change the BIOS setting to AHCI"?  That's an unpleasant user
experience, especially if the installation fails if the user hasn't
read the instructions.

Bjorn
