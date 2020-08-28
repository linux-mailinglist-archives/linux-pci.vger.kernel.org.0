Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 656AD255E8E
	for <lists+linux-pci@lfdr.de>; Fri, 28 Aug 2020 18:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbgH1QGn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Aug 2020 12:06:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:55418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgH1QGm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Aug 2020 12:06:42 -0400
Received: from localhost (104.sub-72-107-126.myvzw.com [72.107.126.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CDA4207DF;
        Fri, 28 Aug 2020 16:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598630802;
        bh=/3gSV9ysNOhKu5Rxr8hZn78+P9f8wdHrqqKnVUJ8rQo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BxgKXgQy0/CCb1+zCcf/H2VMOLP+Xy6cJet12cMAVLgo2drpj1JCUMKs2sA4bxtKM
         K06M3C46MHUAfH/ivv/HWSOo9tp/IoVNhhaEhuyJj/5wPn4Lybfe9sEsM7+tDRWHlb
         fbwS6TieKh1AYzyb/F62bIvdG0Fknn7UOjbBBkrs=
Date:   Fri, 28 Aug 2020 11:06:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, guohanjun@huawei.com,
        George Cherian <george.cherian@marvell.com>
Subject: Re: [PATCH 0/2] fix memleak when using pci_iounmap()
Message-ID: <20200828160640.GA2157785@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828063403.3995421-1-yangyingliang@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc George]

On Fri, Aug 28, 2020 at 02:34:01PM +0800, Yang Yingliang wrote:
> config GENERIC_IOMAP is not selected on some arch, pci_iounmap()
> don't implement, when we using pci_iomap/pci_iounmap, it will
> lead to memory leak.
> This patch set moves the implemention of pci_iounmap() to
> lib/pci_iomap.c to fix this.
> 
> Yang Yingliang (2):
>   iomap: move some definitions to include/linux/io.h
>   pci: fix memleak when calling pci_iomap/unmap()
> 
>  include/asm-generic/pci_iomap.h |  2 ++
>  include/linux/io.h              | 36 ++++++++++++++++++++++++++
>  lib/iomap.c                     | 46 ---------------------------------
>  lib/pci_iomap.c                 |  8 ++++++
>  4 files changed, 46 insertions(+), 46 deletions(-)

I haven't looked at this yet (and won't because of the build issues),
but please note George's previous similar work:

https://lore.kernel.org/linux-pci/20200824132046.3114383-1-george.cherian@marvell.com/

I haven't compared them, so just FYI that we'll have to integrate them
somehow.

If/when you repost this, please run "git log --oneline" and match the
subject styles.  And add blank lines between paragraphs.  Use "()"
consistently after function names.  And please cc: George, of course.

Bjorn
