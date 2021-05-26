Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78562390E7D
	for <lists+linux-pci@lfdr.de>; Wed, 26 May 2021 04:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbhEZCvI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 May 2021 22:51:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:43698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230250AbhEZCvI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 May 2021 22:51:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B281561090;
        Wed, 26 May 2021 02:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621997377;
        bh=SfbOqGxm7X5NXp//WakdnkTjJ211zswh8Q9jf4zImwM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hBkCtj5oeFMQdGLiiql6K5nxAJf/2GbOcEwMXlkxOpHuG/0vYdRRE6+YDuRTLYuhe
         qcbWOv27/Vz/RsHDdeI2Vkzw8hdtDZ55sN0jBz3DXFNMSwCXBRwtThP134XNf8ZB0M
         bmf+ViKxg5PujFcgiQMIbz93FjKrJQpVwoKW+B66wfU3sIUf/vVqLRVx7e+0HmJJ9x
         JPc+oStU4FFT0pUd/Bh372QnzIkLejEx7JfY3MYABzKH+kS53nNmxiD/h1fv9Y0Rr4
         xllWKT2DDMDkIEIf67H8KILgIDpri4d1O8/gDuJ0VfUOuMHcZ44R0pGB/TtcMUjNnr
         DAQhbpbVzNcGQ==
Date:   Tue, 25 May 2021 19:49:34 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Koba Ko <koba.ko@canonical.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Henrik Juul Hansen <hjhansen2020@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Avoid to go into d3cold if device can't use
 npss.
Message-ID: <20210526024934.GB3704949@dhcp-10-100-145-180.wdc.com>
References: <20210520033315.490584-1-koba.ko@canonical.com>
 <20210525074426.GA14916@lst.de>
 <CAJB-X+UFi-iAkRBZQUsd6B_P+Bi-TAa_sQjnhJagD0S91WoFUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJB-X+UFi-iAkRBZQUsd6B_P+Bi-TAa_sQjnhJagD0S91WoFUQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 26, 2021 at 10:02:27AM +0800, Koba Ko wrote:
> On Tue, May 25, 2021 at 3:44 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Thu, May 20, 2021 at 11:33:15AM +0800, Koba Ko wrote:
> > > After resume, host can't change power state of the closed controller
> > > from D3cold to D0.
> >
> > Why?
> As per Kai-Heng said, it's a regression introduced by commit
> b97120b15ebd ("nvme-pci:
> use simple suspend when a HMB is enabled"). The affected NVMe is using HMB.

That really doesn't add up. The mentioned commit restores the driver
behavior for HMB drives that existed prior to d916b1be94b6d from kernel
5.3. Is that NVMe device broken in pre-5.3 kernels, too?
