Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5EF2A6A33
	for <lists+linux-pci@lfdr.de>; Wed,  4 Nov 2020 17:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731377AbgKDQqv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Nov 2020 11:46:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:44112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730987AbgKDQqu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Nov 2020 11:46:50 -0500
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD6A0206CA;
        Wed,  4 Nov 2020 16:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604508410;
        bh=8tGL6oAMB7wNHUqKWEHZkOjh160kXJWJi2X2a6dNbEQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hOgdTjs+nwzvdCfQagJ17N1ywbLm/ip4XjMB5SKjmGVacXB9WGZRdsYe8FHdQyPdf
         vHNpC3mtnuUeXiozagw/6T4SaZxwTQRciQO+0b2ZF+53fkl69gGudVpfAJXdAsClWc
         Tq8xDNYxuU4GSrtmbFC54Frj4gMkh1/H582iOvBw=
Received: by pali.im (Postfix)
        id 56D8A53E; Wed,  4 Nov 2020 17:46:47 +0100 (CET)
Date:   Wed, 4 Nov 2020 17:46:47 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Yinghai Lu <yinghai@kernel.org>
Subject: Re: PCI: Race condition in pci_create_sysfs_dev_files
Message-ID: <20201104164647.pctgyk2cbhjcq65z@pali>
References: <20200909112850.hbtgkvwqy2rlixst@pali>
 <20201006222222.GA3221382@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006222222.GA3221382@bjorn-Precision-5520>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 06 October 2020 17:22:22 Bjorn Helgaas wrote:
> It's not obvious from the code why we need pci_sysfs_init(), but
> Yinghai hinted [1] that we need to create sysfs after assigning
> resources.  I experimented by removing pci_sysfs_init() and skipping
> the ROM BAR sizing.  In that case, we create sysfs files in
> pci_bus_add_device() and later assign space for the ROM BAR, so we
> fail to create the "rom" sysfs file.
> 
> The current solution to that is to delay the sysfs files until
> pci_sysfs_init(), a late_initcall(), which runs after resource
> assignments.  But I think it would be better if we could create the
> sysfs file when we assign the BAR.  Then we could get rid of the
> late_initcall() and that implicit ordering requirement.
> 
> But I haven't tried to code it up, so it's probably more complicated
> than this.  I guess ideally we would assign all the resources before
> pci_bus_add_device().  If we could do that, we could just remove
> pci_sysfs_init() and everything would just work, but I think that's a
> HUGE can of worms.
> 
> [1] https://lore.kernel.org/linux-pci/CAE9FiQWBXHgz-gWCmpWLaBOfQQJwtRZemV6Ut9GVw_KJ-dTGTA@mail.gmail.com/

I found out that pci_sysfs_init() function was introduced in kernel
version 2.6.10 by this historic commit:

https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/commit/?id=f6d553444da20cd1e44f2c4864c2d0c56c934e0a

So it was really due to PCI ROM BAR and accessing it from sysfs.
