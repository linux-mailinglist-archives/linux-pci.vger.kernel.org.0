Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACEF2BB8A1
	for <lists+linux-pci@lfdr.de>; Fri, 20 Nov 2020 22:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbgKTV5N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Nov 2020 16:57:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:54146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728039AbgKTV5N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Nov 2020 16:57:13 -0500
Received: from localhost (129.sub-72-107-112.myvzw.com [72.107.112.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 972AF22254;
        Fri, 20 Nov 2020 21:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605909432;
        bh=EyJHD0We1WD+DYetjzdtwyxC7yClq4qfKpddxgRnFP0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=l8Mty+qAlU7C9g5t5MxjDLq+M0w2JXOYxy4O6cEBf9T481CGAuFcaBimpgrJeaU8i
         Frti8zwOeDY3M3nDLCEsoXpCS4wPxiHpL6NeOq9vB/w5tX8FS1TfYMVvqwna2GheM6
         J+kzZMeud15nfXIoyE887+ZvhUkvldStjaZkB8Kk=
Date:   Fri, 20 Nov 2020 15:57:11 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Zhenzhong Duan <zhenzhong.duan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, hch@infradead.org, alex.williamson@redhat.com,
        cohuck@redhat.com
Subject: Re: [PATCH v3 0/2] avoid inserting duplicate IDs in dynids list
Message-ID: <20201120215711.GA281372@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117054409.3428-1-zhenzhong.duan@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 17, 2020 at 01:44:07PM +0800, Zhenzhong Duan wrote:
> vfio-pci and pci-stub use new_id to bind devices. But one can add same IDs
> multiple times, for example:
> 
> # echo "1af4 1041" > /sys/bus/pci/drivers/vfio-pci/new_id
> # echo "1af4 1041" > /sys/bus/pci/drivers/vfio-pci/new_id
> # echo "1af4 1041" > /sys/bus/pci/drivers/vfio-pci/new_id
> # echo "1af4 1041" > /sys/bus/pci/drivers/vfio-pci/remove_id
> # echo "1af4 1041" > /sys/bus/pci/drivers/vfio-pci/remove_id
> # echo "1af4 1041" > /sys/bus/pci/drivers/vfio-pci/remove_id
> # echo "1af4 1041" > /sys/bus/pci/drivers/vfio-pci/remove_id
> -bash: echo: write error: No such device
> 
> This doesn't cause user-visible broken behavior, but not user friendly.
> he has to remove same IDs same times to ensure it's completely gone.
> 
> Changed to only allow one dynamic entry of the same kind, after fix:
> 
> # echo "1af4 1041" > /sys/bus/pci/drivers/vfio-pci/new_id
> # echo "1af4 1041" > /sys/bus/pci/drivers/vfio-pci/new_id
> -bash: echo: write error: File exists
> # echo "1af4 1041" > /sys/bus/pci/drivers/vfio-pci/remove_id
> # echo "1af4 1041" > /sys/bus/pci/drivers/vfio-pci/remove_id
> -bash: echo: write error: No such device
> 
> 
> v3: add a separate patch to process dependency issue per Bjorn
>     make commit log more clear per Bjorn
> v2: revert the export of pci_match_device() per Christoph
>     combind PATCH1 and PATCH2 into one.
> 
> v2 link:https://lkml.org/lkml/2020/10/25/347
> 
> Zhenzhong Duan (2):
>   PCI: move pci_match_device() ahead of new_id_store()
>   PCI: avoid duplicate IDs in dynamic IDs list
> 
>  drivers/pci/pci-driver.c | 146 +++++++++++++++++++++++------------------------
>  1 file changed, 73 insertions(+), 73 deletions(-)
> 
> -- 
> 1.8.3.1
> 
> 
> Zhenzhong Duan (2):
>   PCI: move pci_match_device() ahead of new_id_store()
>   PCI: avoid duplicate IDs in dynamic IDs list
> 
>  drivers/pci/pci-driver.c | 146 +++++++++++++++++++++++------------------------
>  1 file changed, 73 insertions(+), 73 deletions(-)

I corrected the subject lines:

  PCI: Move pci_match_device() ahead of new_id_store()
  PCI: Avoid duplicate IDs in driver dynamic IDs list

and applied both to pci/enumeration for v5.11, thanks!
