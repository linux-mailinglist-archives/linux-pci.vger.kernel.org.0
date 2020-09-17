Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84D7826E1D4
	for <lists+linux-pci@lfdr.de>; Thu, 17 Sep 2020 19:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgIQRJs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Sep 2020 13:09:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:55348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727037AbgIQRJh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Sep 2020 13:09:37 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68CB2221EC;
        Thu, 17 Sep 2020 17:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600362576;
        bh=nciZRCdNYJT5LRSin2ZAx5m8XyoA9EAOhiwakEqj6jQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SyiIfpHuIoW9U8P/nV2+0jm0bcVB6Hze+sQfLOfLnkLaijZwE9rxcNcykSSJazMY3
         DLBGkjGNT7matV4WJxZ/nbNtbVuAXSE7fbQJTPhE50BXB9jJHwE9CbkTUGZnwMr7pj
         h4y9H/qTr5CLR/UWtwFLkgmTJ1bOCCGpu9WZs8WU=
Date:   Thu, 17 Sep 2020 12:09:35 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Clint Sbisa <csbisa@amazon.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Jiri Kosina <trivial@kernel.org>,
        Benjamin Herrenschmidt <benh@amazon.com>,
        Ali Saidi <alisaidi@amazon.com>,
        David Woodhouse <dwmw@amazon.co.uk>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Trivial comment fixup for PCI mmap ifdefs
Message-ID: <20200917170935.GA1710267@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821155121.nzxjeeoze4h5pone@amazon.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 21, 2020 at 03:51:21PM +0000, Clint Sbisa wrote:
> The else/endif comments for pci_{create,remove}_resource_files were
> not updated in commit f719582435afe9c7985206e42d804ea6aa315d33 ("PCI:
> Add pci_mmap_resource_range() and use it for ARM64").
> 
> Signed-off-by: Clint Sbisa <csbisa@amazon.com>

Applied to pci/misc for v5.10, thanks!

> ---
>  drivers/pci/pci-sysfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 6d78df981d41..cfc67b208616 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1196,10 +1196,10 @@ static int pci_create_resource_files(struct pci_dev *pdev)
>  	}
>  	return 0;
>  }
> -#else /* !HAVE_PCI_MMAP */
> +#else /* ! (defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)) */
>  int __weak pci_create_resource_files(struct pci_dev *dev) { return 0; }
>  void __weak pci_remove_resource_files(struct pci_dev *dev) { return; }
> -#endif /* HAVE_PCI_MMAP */
> +#endif /* defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE) */
>  
>  /**
>   * pci_write_rom - used to enable access to the PCI ROM display
> -- 
> 2.23.3
> 
