Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 183F6355A74
	for <lists+linux-pci@lfdr.de>; Tue,  6 Apr 2021 19:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244742AbhDFReN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Apr 2021 13:34:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:56182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244730AbhDFReM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Apr 2021 13:34:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0DAA5613DE;
        Tue,  6 Apr 2021 17:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617730444;
        bh=2BJ3z9VA1NfEv8PmUpsTWkMzbB7AVDenNhbsdlNeaCY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SZ/Tz1UKqbmmrOtLho4pKYHy9TMyYfQdmgAdSFfoP11mLiQEkw6N9KA7Mvk41pBjU
         3gTSCyFZJja9Vr2QeO5/n7OZtwNyKekgHQttYPIyIoqd51Haf5kR9WbkyXdvfB/Xtp
         I3bw4PwY1feFSiUR7xtayBFHq+eqnmeduEhl4tW0=
Date:   Tue, 6 Apr 2021 19:34:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v11 0/4] misc: Add Synopsys DesignWare xData IP driver
Message-ID: <YGybivASLNlAymk0@kroah.com>
References: <cover.1617729785.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1617729785.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 06, 2021 at 07:26:45PM +0200, Gustavo Pimentel wrote:
> This patch series adds a new driver called xData-pcie for the Synopsys
> DesignWare PCIe prototype.
> 
> The driver configures and enables the Synopsys DesignWare PCIe traffic
> generator IP inside of prototype Endpoint which will generate upstream
> and downstream PCIe traffic. This allows to quickly test the PCIe link
> throughput speed and check is the prototype solution has some limitation
> or not.
> 
> Changes:
>  V2: Rework driver according to Greg Kroah-Hartman' feedback
>      - Replace module parameter by sysfs use.
>      - Replace bit fields structure with macros and masks use.
>      - Removed SET() and GET() macros by the writel() and readl().
>      - Removed some noisy info messages.
>  V3: Fixed issues detected while running on 64 bits platforms
>      Rebased patches on top of v5.11-rc1 version
>  V4: Rework driver according to Greg Kroah-Hartman' feedback
>      - Add the ABI doc related to the sysfs implemented on this driver
>  V5: Rework driver accordingly to Leon Romanovsky' feedback
>      - Removed "default n" on Kconfig
>      Rework driver accordingly to Krzysztof Wilczyński' feedback
>      - Added some explanatory comments for some steps
>      - Added some bit defines instead of magic numbers
>  V6: Rework driver according to Greg Kroah-Hartman' feedback
>      - Squashed patches #2 and #3
>      - Removed units (MB/s) on the sys file
>      - Reduced mutex scope on the functions called by sysfs
>      Rework driver accordingly to Krzysztof Wilczyński' feedback
>      - Fix typo "DesignWare"
>  V7: Rework driver according to Greg Kroah-Hartman' feedback
>      - Created a sub device (misc device) that will be associated with the PCI driver
>      - sysfs group is now associated with the misc drivers instead of the PCI driver
>  V8: Rework driver according to Greg Kroah-Hartman' feedback
>      - Added more detail to the version changes on the cover letter
>      - Squashed patches #1 and #2
>      - Removed struct device from the dw_xdata_pcie structure
>      - Replaced the pci_*() use by dev_*()
>      - Added free call for the misc driver name allocation
>      - Added reference counting
>      - Removed snps_edda_data structure and their usage
>      Rebased patches on top of v5.12-rc4 version
>  V9: Squashed temporary development patch #5 into the driver patch #1
>  V10: Reworked the write_store() and read_store() to validate the input using kstrtobool()
>      Removed stop_store()
>      Update ABI documentation accordingly
>  V11: Fixed the documentation based on the warnings detected by Stephen Rothwell

As mentioned on the other thread, I can't take these as I took your v10
into my public tree.  Please send fixes on top of that.

thanks,

greg k-h
