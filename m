Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C79393CB8A4
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jul 2021 16:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbhGPO21 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Jul 2021 10:28:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:58044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232958AbhGPO2X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Jul 2021 10:28:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C7C3060FE7;
        Fri, 16 Jul 2021 14:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626445529;
        bh=dz0aDz4wygX1RXd+1ixps/rHbXJdWNt4QAz8cmbfDG8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=EM2wDTqSFm/omBZOOknm73OwkjoCQvtLrZsblzox3BXsDQa3AqLYb06/KqevhoLb8
         /f+6Z+vzCD72SwkElcsmJkLGE5GVagGrXm87yDaY95djKwEvU3KTNrzzRk0qdbtoZr
         kYMbijQ5S16jkfjWYypPMzlHToB61mDoDKslijYrRSNwublBKjcZFQJ3N583p9KIMQ
         lYy9JWP3+F+Ao3Xospdxk5cps+Im8oYNzu9tbTxx8tngj+aKpZGN4Ro7dXzBonYuDZ
         hFjTiD5hBG/tsiYqsKtZhwrIMGW+acbZsAcaRC7ZgeZ9nvKL/2U6vUeco3uZ2d53hI
         9Z1qnCjA2gyNg==
Date:   Fri, 16 Jul 2021 09:25:27 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Wenchao Hao <haowenchao@huawei.com>
Cc:     Keith Busch <kbusch@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Wu Bo <wubo40@huawei.com>,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>, linfeilong@huawei.com,
        lijinlin3@huawei.com, Matthew Wilcox <willy@infradead.org>
Subject: Re: [question]: Query regarding the PCI addresses
Message-ID: <20210716142527.GA2097477@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d146a3a-199a-3135-331e-b34371d5ec80@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 16, 2021 at 10:04:51PM +0800, Wenchao Hao wrote:
> On 2021/7/15 1:26, Keith Busch wrote:
> > On Wed, Jul 14, 2021 at 11:54:27AM -0500, Bjorn Helgaas wrote:
> > > On Wed, Jul 14, 2021 at 02:33:37PM +0800, Wenchao Hao wrote:
> > > 
> > > > If they are not fixed, then is there anyway I can get a fixed ID
> > > > which can indicate physical connection.
> > > You can look at the "lspci -P" option.  I'm not really familiar with
> > > this, but I think Matthew (cc'd) implemented it.
> > That option shows the parent devices for each listed device, but that
> > may not produce the same output if BDf doesn't always enumerate the
> > same.
> > 
> > I think Wenchao was seeking some invariant device identification that
> > can be used to look up its BDf. There's no PCI level requirement for
> > uniquely identifying a specific device across changing topologies, so I
> > don't think this is generically possible.
> 
> Yes, I want a way to access device which can keep unchanged, a
> direction is according to hardware. If we have anyway which makes
> it possible for software can describe hardware connection would
> satisfy our demand.

I don't know whether this would be useful, but PCI does define an
optional "Device Serial Number" extended capability.  It has issues
like the fact that many devices don't support it at all, and even on
devices that do support it, the serial number may not actually be
unique.  There is minimal support for this in Linux (pci_get_dsn()),
but it is currently not exposed to userspace via sysfs.

Bjorn
