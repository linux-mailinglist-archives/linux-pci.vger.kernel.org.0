Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53BF32CCE2A
	for <lists+linux-pci@lfdr.de>; Thu,  3 Dec 2020 06:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgLCFA4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Dec 2020 00:00:56 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:2585 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgLCFA4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Dec 2020 00:00:56 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc870df0000>; Wed, 02 Dec 2020 21:00:15 -0800
Received: from [10.25.75.116] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Dec
 2020 05:00:09 +0000
Subject: Re: [PATCH V2] PCI/MSI: Set device flag indicating only 32-bit MSI
 support
To:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20201117145728.4516-1-vidyas@nvidia.com>
 <20201124105035.24573-1-vidyas@nvidia.com>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <70d5309b-331e-b2e5-2786-57915382e1d1@nvidia.com>
Date:   Thu, 3 Dec 2020 10:30:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20201124105035.24573-1-vidyas@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606971615; bh=NaqYMrewzDBSWv4b2kjcoHYtxDnlc/xS2Lkoc7cGcKY=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=eri3OkUCRgxvyNxV2pxlsQ+INwudskvHev8fx77R+IzpurcZloEN1wgk4yYT/JZVp
         S2ZCQc3i2AVDUsu95xse9CwOjCmrI+6m+toM9CihmRVVuQJ7ACdiX2nXeIk06oOr/0
         zriyn9uttMnDl/ynksoQZ8IyzriV97E4IsMYnvhlt8bPxr/LEbzxcil3cwxk39TMbt
         oOqfBy+qh0QN93mAMpB/MevEf4RK7Lo37t/Z2DEp6/+1V/vvwcI979cCUa2/JS7zYO
         mP6DHS28d+zMgOiig+TZC0/EtQP1ag98GYIxAA7457IUCVpyWyoLcW77EYlNfJvQUV
         Yf3qILGn+pfig==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,
Do you have any further comments for this patch?

Thanks,
Vidya Sagar

On 11/24/2020 4:20 PM, Vidya Sagar wrote:
> There are devices (Ex:- Marvell SATA controller) that don't support
> 64-bit MSIs and the same is advertised through their MSI capability
> register. Set no_64bit_msi flag explicitly for such devices in the
> MSI setup code so that the msi_verify_entries() API would catch
> if the MSI arch code tries to use 64-bit MSI.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V2:
> * Addressed Bjorn's comment and changed the error message
> 
>   drivers/pci/msi.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index d52d118979a6..8de5ba6b4a59 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -581,10 +581,12 @@ msi_setup_entry(struct pci_dev *dev, int nvec, struct irq_affinity *affd)
>   	entry->msi_attrib.multi_cap	= (control & PCI_MSI_FLAGS_QMASK) >> 1;
>   	entry->msi_attrib.multiple	= ilog2(__roundup_pow_of_two(nvec));
>   
> -	if (control & PCI_MSI_FLAGS_64BIT)
> +	if (control & PCI_MSI_FLAGS_64BIT) {
>   		entry->mask_pos = dev->msi_cap + PCI_MSI_MASK_64;
> -	else
> +	} else {
>   		entry->mask_pos = dev->msi_cap + PCI_MSI_MASK_32;
> +		dev->no_64bit_msi = 1;
> +	}
>   
>   	/* Save the initial mask status */
>   	if (entry->msi_attrib.maskbit)
> @@ -602,8 +604,9 @@ static int msi_verify_entries(struct pci_dev *dev)
>   	for_each_pci_msi_entry(entry, dev) {
>   		if (!dev->no_64bit_msi || !entry->msg.address_hi)
>   			continue;
> -		pci_err(dev, "Device has broken 64-bit MSI but arch"
> -			" tried to assign one above 4G\n");
> +		pci_err(dev, "Device has either broken 64-bit MSI or "
> +			"only 32-bit MSI support but "
> +			"arch tried to assign one above 4G\n");
>   		return -EIO;
>   	}
>   	return 0;
> 
