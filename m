Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A84E4847D
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2019 15:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfFQNts (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 09:49:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:37866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbfFQNtr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Jun 2019 09:49:47 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA27E2080A;
        Mon, 17 Jun 2019 13:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560779387;
        bh=EBuNzBd/qGbqCnmfVuPFwTpXaSxzUIxXb6DluxKP7J8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bNETxfszQdnVSL+nzOtmSUdViN8LmZW+UtXOeGITcw4s/oAlhvugoLKS7j5Khb562
         ujC7jxrhPQ0foGT3yruPcenz4Lh9LbX7gq7T0NdkMxrjJ57N9FlqzS9mRXSTC0ggck
         1BMJSARhJqATEcz3BeFZOa+K+jYH9mCUA1xxAPjo=
Date:   Mon, 17 Jun 2019 08:49:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Kit Chow <kchow@gigaio.com>, Yinghai Lu <yinghai@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: Re: [PATCH v3 0/2] Fix a pair of setup bus bugs
Message-ID: <20190617134447.GZ13533@google.com>
References: <20190531171216.20532-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531171216.20532-1-logang@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Ben, Nicholas]

On Fri, May 31, 2019 at 11:12:14AM -0600, Logan Gunthorpe wrote:
> Hey,
> 
> This is another resend to get some more attention. Nothing has changed
> since v2.
> 
> For the first patch, there's a lot more information in the original
> thread here[1] including instructions on how to reproduce it in QEMU.
> 
> The second patch fixes an unrelated bug, with similar symptoms, in
> the same code. It was a lot easier to debug and the reasoning should
> hopefully be easier to follow, but I don't think it was reviewed much
> during the first posting due to the nightmare in the first patch.
> 
> Thanks,
> 
> Logan
> 
> [1] https://lore.kernel.org/lkml/de3e34d8-2ac3-e89b-30f1-a18826ce5d7d@deltatee.com/T/#m96ba95de4678146ed46b602e8bfd6ac08a588fa2
> 
> --
> 
> Changes in v3:
> 
> * Rebased onto v5.2-rc2 (no changes)
> 
> Changes in v2:
> 
> * Rebased onto v5.1-rc6 (no changes)
> * Reworked the commit message in the first commit to try and explain
>   it better.
> 
> --
> 
> Logan Gunthorpe (2):
>   PCI: Prevent 64-bit resources from being counted in 32-bit bridge
>     region
>   PCI: Fix disabling of bridge BARs when assigning bus resources
> 
>  drivers/pci/setup-bus.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
> 
> --
> 2.20.1
