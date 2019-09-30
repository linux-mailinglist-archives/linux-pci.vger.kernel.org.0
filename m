Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA8BBC26D0
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2019 22:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfI3Uky (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Sep 2019 16:40:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:35636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729180AbfI3Uky (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Sep 2019 16:40:54 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D12E224D2;
        Mon, 30 Sep 2019 20:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569875651;
        bh=Ia/sE7OsRwGmDutroMOdVbd3eXtqQ6ome2j9iwgAtQM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=W8TiKyqeBZc6pJ4n/x3zNcBQ+zNVfG5Jqyt7GuWexVjswNJ94IS4AZhlWNK6HpKgZ
         hmJOu7FoPUwtNXAkVc6swG5WbDsCADl2YqGyc0VeWk4EYwJ43MW0EUgjrMfxUZhkUR
         c7xsmMQIRDIEynQWykeEtOGczMovqRvvNWA8y03E=
Date:   Mon, 30 Sep 2019 15:34:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     George Cherian <george.cherian@marvell.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shannon.zhao@linux.alibaba.com" <shannon.zhao@linux.alibaba.com>,
        Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
        George Cherian <gcherian@marvell.com>,
        Vadim Lomovtsev <Vadim.Lomovtsev@marvell.com>,
        Manish Jaggi <mjaggi@caviumnetworks.com>
Subject: Re: [PATCH] PCI: Enhance the ACS quirk for Cavium devices
Message-ID: <20190930203409.GA195851@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919024319.GA8792@dc5-eodlnx05.marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Vadim, Manish]

On Thu, Sep 19, 2019 at 02:43:34AM +0000, George Cherian wrote:
> Enhance the ACS quirk for Cavium Processors. Add the root port
> vendor ID's in an array and use the same in match function.
> For newer devices add the vendor ID's in the array so that the
> match function is simpler.
> 
> Signed-off-by: George Cherian <george.cherian@marvell.com>
> ---
>  drivers/pci/quirks.c | 28 +++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 44c4ae1abd00..64deeaddd51c 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4241,17 +4241,27 @@ static int pci_quirk_amd_sb_acs(struct pci_dev *dev, u16 acs_flags)
>  #endif
>  }
>  
> +static const u16 pci_quirk_cavium_acs_ids[] = {
> +	/* CN88xx family of devices */
> +	0xa180, 0xa170,
> +	/* CN99xx family of devices */
> +	0xaf84,
> +	/* CN11xxx family of devices */
> +	0xb884,
> +};
> +
>  static bool pci_quirk_cavium_acs_match(struct pci_dev *dev)
>  {
> -	/*
> -	 * Effectively selects all downstream ports for whole ThunderX 1
> -	 * family by 0xf800 mask (which represents 8 SoCs), while the lower
> -	 * bits of device ID are used to indicate which subdevice is used
> -	 * within the SoC.
> -	 */
> -	return (pci_is_pcie(dev) &&
> -		(pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) &&
> -		((dev->device & 0xf800) == 0xa000));
> +	int i;
> +
> +	if (!pci_is_pcie(dev) || pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT)
> +		return false;
> +
> +	for (i = 0; i < ARRAY_SIZE(pci_quirk_cavium_acs_ids); i++)
> +		if (pci_quirk_cavium_acs_ids[i] == dev->device)

I'm a little skeptical of this because the previous test:

  (dev->device & 0xf800) == 0xa000

could match *many* devices, but of those, the new code only matches two
(0xa180, 0xa170).

And the comment says the new code matches the CN99xx and CN11xxx
*families*, but it only matches a single device ID for each, which
makes me think there may be more devices to come.

Maybe this is all what you want, but please confirm.

The commit log should be explicit that this adds CN99xx and CN11xxx,
which previously were not matched.

This looks like stable material?

> +			return true;
> +
> +	return false;
>  }
>  
>  static int pci_quirk_cavium_acs(struct pci_dev *dev, u16 acs_flags)
> -- 
> 2.17.1
> 
