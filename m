Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2487037000C
	for <lists+linux-pci@lfdr.de>; Fri, 30 Apr 2021 19:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhD3R6O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Apr 2021 13:58:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:43078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229954AbhD3R6N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Apr 2021 13:58:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE6B161458;
        Fri, 30 Apr 2021 17:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619805445;
        bh=8YXfNjJ7588UGJ+nN1d9RL6GvR7HNPZ2oTdqIiPqTY8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=WtA4Eu579NK4WcKptJrnzD4VmwL6U9+GtBi6UNnkn7Yh9UvA3JY/4rvyNR6dkOt44
         ds1PEwUm17+TS75J1sLIoEMkPW5FLLjymGLpEbkHeAfH+wS7agT9eMSX34msbRJ4Og
         m4CMJIFEUmQTEFSCgkr8gK1fcu+KcjDL1m5H9BqS2I3qAMc/opm0VbLCUdH5+fP7Bd
         Eiqx2fW/hPyLTFAuwkOJ543CI7KYI/9ZTrx5IBJpSUSWEiyQgXmGTxvcrwPsFm6+EI
         qEeIs0PK4J57wzdksPkKhV1nQs/qZg7b96C9es5Sx1GcXCytFMgOTVfSXwXwQ1K5br
         XcscIoyJfDO0g==
Date:   Fri, 30 Apr 2021 12:57:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Prike Liang <Prike.Liang@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rajat Jain <rajatja@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: fix unused variable warning
Message-ID: <20210430175723.GA664165@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421140436.3882411-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 21, 2021 at 04:04:20PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The function was introduced with a variable that is never referenced:
> 
> drivers/pci/quirks.c: In function 'quirk_amd_nvme_fixup':
> drivers/pci/quirks.c:312:25: warning: unused variable 'rdev' [-Wunused-variable]
> 
> Fixes: 9597624ef606 ("nvme: put some AMD PCIE downstream NVME device to simple suspend/resume path")

I guess this refers to https://lore.kernel.org/linux-nvme/1618458725-17164-1-git-send-email-Prike.Liang@amd.com/

But I don't know what the SHA1 means; I can't find it in linux-next or
my tree.

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/pci/quirks.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 2e24dced699a..c86ede081534 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -309,8 +309,6 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_8151_0,	quirk_nopci
>  
>  static void quirk_amd_nvme_fixup(struct pci_dev *dev)
>  {
> -	struct pci_dev *rdev;
> -
>  	dev->dev_flags |= PCI_DEV_FLAGS_AMD_NVME_SIMPLE_SUSPEND;
>  	pci_info(dev, "AMD simple suspend opt enabled\n");
>  
> -- 
> 2.29.2
> 
