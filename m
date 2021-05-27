Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE624393900
	for <lists+linux-pci@lfdr.de>; Fri, 28 May 2021 01:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236520AbhE0XO3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 19:14:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236502AbhE0XO3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 May 2021 19:14:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C471613BA;
        Thu, 27 May 2021 23:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622157174;
        bh=LB1JJgO9gxsp6HjNrlPAO9Ff7IIwAeDsXQo4yfs8LlU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=AKNYsIUkZyWWtJH3elcZZ2T6WGQ5vnuBMXec7aOY3Bi/WbZWqErLZ2hu/RcN1bkrW
         Ys40QSCgwWLzLwKwS5JQ58ZVC5JSQS9V0hrMcD83NdPjNAjN3eJhCPHqTDIb2RjxA3
         d0SycV7NmAglMnp2tY5A9Dwc85DbWvAIJnbf6MK2XIC8oMIR+DAw+ZzGQEC7+DAiNY
         rzLfEHkUlKBPp0ROSma444lNcGY+mPI1NhY0dtrWLhkImSEwm1nXykbQpPVOBITabl
         sb2NdC8gJcrpmCIkG5fZUcdc2vTwxHIwyihcnzzuT3qbIXJeC+sUQodazg0anyXN8A
         Z28Hk1na+dpvQ==
Date:   Thu, 27 May 2021 18:12:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, moritzf@google.com,
        Brian Foley <bpfoley@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH RESEND v2] PCI/IOV: Clarify error message for unbound
 devices
Message-ID: <20210527231253.GA1442161@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210327175140.682708-1-mdf@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Mar 27, 2021 at 10:51:40AM -0700, Moritz Fischer wrote:
> Be more verbose to disambiguate the error case when trying to configure
> SRIOV with no driver bound vs. a driver that does not implement the
> SRIOV callback.
> 
> Reported-by: Brian Foley <bpfoley@google.com>
> Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>

Applied to pci/virtualization for v5.14, thanks!

> ---
> Changes from v1:
> - Added Krzysztof's Reviewed-by
> ---
>  drivers/pci/iov.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 4afd4ee4f7f0..f9ecc691daf5 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -304,8 +304,15 @@ static ssize_t sriov_numvfs_store(struct device *dev,
>  	if (num_vfs == pdev->sriov->num_VFs)
>  		goto exit;
>  
> +	/* is PF driver loaded */
> +	if (!pdev->driver) {
> +		pci_info(pdev, "No driver bound to device. Cannot configure SRIOV\n");
> +		ret = -ENOENT;
> +		goto exit;
> +	}
> +
>  	/* is PF driver loaded w/callback */
> -	if (!pdev->driver || !pdev->driver->sriov_configure) {
> +	if (!pdev->driver->sriov_configure) {
>  		pci_info(pdev, "Driver does not support SRIOV configuration via sysfs\n");
>  		ret = -ENOENT;
>  		goto exit;
> -- 
> 2.30.2
> 
