Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2F14BA86
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2019 15:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfFSNwO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jun 2019 09:52:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:47096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbfFSNwO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Jun 2019 09:52:14 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5804121670;
        Wed, 19 Jun 2019 13:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560952333;
        bh=hclDymaNDOsDIbtMIl2LJFfnJSsWaLYy2U58GCdGL90=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B3jizonAV2P/nKMYqbPEgPAL9k/qW8ysXT3xel3+pdhOYp0ed6QM+M43NYXIgDS4R
         TJwpRuRfyoYWC2o6XWzDHvFF1BZojHDXeUNX9GB+zXKfS/3M2bZW6qfeZgiw1jGLr+
         ne2uDEFhd+dqrxNPw95QMPUZSaRWDeBIuK7jqKjw=
Date:   Wed, 19 Jun 2019 08:52:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Daniel Drake <drake@endlessm.com>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Keith Busch <keith.busch@gmail.com>, linux-ide@vger.kernel.org,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Keith Busch <kbusch@kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] PCI: Add Intel remapped NVMe device support
Message-ID: <20190619135212.GB143205@google.com>
References: <20190610074456.2761-1-drake@endlessm.com>
 <CAOSXXT7OFzHeTxNqZ1sS6giRxhDcrUUnVjURWBiFUc5T_8p=MA@mail.gmail.com>
 <CAD8Lp45djPU_Ur8uCO2Y5Sbek_5N9QKkxLXdKNVcvkr6rFPLUQ@mail.gmail.com>
 <CAOSXXT7H6HxY-za66Tr9ybRQyHsTdwwAgk9O2F=xK42MT8HsuA@mail.gmail.com>
 <20190613085402.GC13442@lst.de>
 <CAD8Lp47Vu=w+Lj77_vL05JYV1WMog9WX3FHGE+TseFrhcLoTuA@mail.gmail.com>
 <06c38b3e-603b-5bae-4959-9965ab40db62@suse.de>
 <CAD8Lp44rqGh3nmUOFhwq+SSxpJGuWvLFJ8sKtM0q1GeY0j4v9A@mail.gmail.com>
 <1f56c881-9005-f8ad-1557-5efd6e0ef535@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f56c881-9005-f8ad-1557-5efd6e0ef535@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 18, 2019 at 05:15:52PM +0200, Hannes Reinecke wrote:
> On 6/18/19 10:06 AM, Daniel Drake wrote:

> > We can probably also use these registers for MSI support. I
> > started to experiment, doesn't quite work but I'll keep poking.
> > The doc suggests there is a single MSI-X vector for the AHCI SATA
> > device, and AHCI MSI-X Starting Vector (AMXV) has value 0x140 on
> > this platform. No idea how to interpret that value. From
> > experimentation, the AHCI SATA disk generates interrupts on vector
> > 0.
> > 
> The 0x140 is probably the offset into the PCI config space where the
> AHCI MSI-X vector table can be found ...

An MSI-X vector table is in memory space, not config space.  You'd
have to look at PCI_MSIX_TABLE_BIR to find which BAR maps it, and then
add PCI_MSIX_TABLE_OFFSET to the BAR value.

Bjorn
