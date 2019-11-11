Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7781BF8328
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2019 00:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfKKXB1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Nov 2019 18:01:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:58482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726923AbfKKXB1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Nov 2019 18:01:27 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C07520659;
        Mon, 11 Nov 2019 23:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573513284;
        bh=JFxEFsp8SH9GIQGjEH29Lu9t7CrAzCO21L2Jo49Iqjg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BBAvP0bADluuJ3FY6aFPdNf2HinFuck1j6MxCiaWn9Hc0AkLpiwHcAe7hDPx2yLtd
         +Uq0SXExbe33MPmFOhGfXzjDdV34QO8KN8D3eTZocqf5UYodN5ma61t8W8T0OOxcq1
         5Wt6bKQ9FsU1IuE93N52x6u5/Ly5T9b892aiSeG0=
Date:   Mon, 11 Nov 2019 17:01:22 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     George Cherian <george.cherian@marvell.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shannon.zhao@linux.alibaba.com" <shannon.zhao@linux.alibaba.com>,
        Robert Richter <rrichter@marvell.com>,
        George Cherian <gcherian@marvell.com>
Subject: Re: [PATCH v2] PCI: Enhance the ACS quirk for Cavium devices
Message-ID: <20191111230122.GA59296@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111024243.GA11408@dc5-eodlnx05.marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 11, 2019 at 02:43:03AM +0000, George Cherian wrote:
> Enhance the ACS quirk for Cavium Processors. Add the root port
> vendor ID's for ThunderX2 and ThunderX3 series  of processors.
> 
> Signed-off-by: George Cherian <george.cherian@marvell.com>
> Reviewed-by: Robert Richter <rrichter@marvell.com>

Applied to pci/virtualization for v5.5, thanks!

I added a Fixes: f2ddaf8dfd4a ("PCI: Apply Cavium ThunderX ACS quirk
to more Root Ports") since it refines that patch, and also a stable
tag (like f2ddaf8dfd4a).

> ---
>  drivers/pci/quirks.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 44c4ae1abd00..19821d5d0ef3 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4243,15 +4243,21 @@ static int pci_quirk_amd_sb_acs(struct pci_dev *dev, u16 acs_flags)
>  
>  static bool pci_quirk_cavium_acs_match(struct pci_dev *dev)
>  {
> +	if (!pci_is_pcie(dev) || pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT)
> +		return false;
> +
> +	switch (dev->device) {
>  	/*
> -	 * Effectively selects all downstream ports for whole ThunderX 1
> -	 * family by 0xf800 mask (which represents 8 SoCs), while the lower
> -	 * bits of device ID are used to indicate which subdevice is used
> -	 * within the SoC.
> +	 * Effectively selects all downstream ports for whole ThunderX1
> +	 * (which represents 8 SoCs).
>  	 */
> -	return (pci_is_pcie(dev) &&
> -		(pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) &&
> -		((dev->device & 0xf800) == 0xa000));
> +	case 0xa000 ... 0xa7ff: /* ThunderX1 */
> +	case 0xaf84:  /* ThunderX2 */
> +	case 0xb884:  /* ThunderX3 */
> +		return true;
> +	default:
> +		return false;
> +	}
>  }
>  
>  static int pci_quirk_cavium_acs(struct pci_dev *dev, u16 acs_flags)
> -- 
> 2.17.1
> 
