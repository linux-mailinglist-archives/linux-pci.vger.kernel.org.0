Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE9E2327CA
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jul 2020 01:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgG2XCp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jul 2020 19:02:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:44796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727072AbgG2XCp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Jul 2020 19:02:45 -0400
Received: from localhost (mobile-166-175-62-240.mycingular.net [166.175.62.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96CDA207E8;
        Wed, 29 Jul 2020 23:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596063765;
        bh=kscsnY3uQ831fVjc/Zp/zYqRyQ9g8Kv8tCx4nXLkJ+k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TkCbkgxR1wH73AE2BxkWqKwjWRwwa1eQPDve5qW8Ir5pvdjPJt39qUrVEeF4Nar9U
         HDShixM/o3sl1fHGgf09InfiORLDIFB9ThJhRZNmse0hmRguVZhP8YxLxZksRl/3Nh
         euz1SH9U3gDNDVw+tDlf5PjyK7hEEOwOZEWdWGIk=
Date:   Wed, 29 Jul 2020 18:02:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Donald Dutile <ddutile@redhat.com>
Subject: Re: [PATCH] PCI: Put the IVRS table in AMD ACS quirk handler
Message-ID: <20200729230242.GA1974304@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595411068-15440-1-git-send-email-guohanjun@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Alex, Don]

On Wed, Jul 22, 2020 at 05:44:28PM +0800, Hanjun Guo wrote:
> The acpi_get_table() should be coupled with acpi_put_table() if
> the mapped table is not used at runtime to release the table
> mapping.
> 
> In pci_quirk_amd_sb_acs(), IVRS table is just used for checking
> AMD IOMMU is supported, not used at runtime, put the table after
> using it.
> 
> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>

Applied to pci/virtualization for v5.9, thanks!

I added this:

  Fixes: 15b100dfd1c9 ("PCI: Claim ACS support for AMD southbridge devices")

but I didn't add a stable tag.  Does this cause any issue that would
warrant a stable tag?

> ---
>  drivers/pci/quirks.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 812bfc3..487ed4d 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4409,6 +4409,8 @@ static int pci_quirk_amd_sb_acs(struct pci_dev *dev, u16 acs_flags)
>  	if (ACPI_FAILURE(status))
>  		return -ENODEV;
>  
> +	acpi_put_table(header);
> +
>  	/* Filter out flags not applicable to multifunction */
>  	acs_flags &= (PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC | PCI_ACS_DT);
>  
> -- 
> 1.7.12.4
> 
