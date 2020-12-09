Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9242D396E
	for <lists+linux-pci@lfdr.de>; Wed,  9 Dec 2020 05:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgLIEIw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Dec 2020 23:08:52 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:16259 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgLIEIw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Dec 2020 23:08:52 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fd04dab0000>; Tue, 08 Dec 2020 20:08:11 -0800
Received: from [10.25.97.15] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 9 Dec
 2020 04:08:04 +0000
Subject: Re: [PATCH] PCI: Save/restore L1 PM Substate extended capability
 registers
To:     "David E. Box" <david.e.box@linux.intel.com>,
        <bhelgaas@google.com>, <rafael@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20201208220624.21877-1-david.e.box@linux.intel.com>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <d7708556-40b5-c66c-d0c7-ccfe9999691c@nvidia.com>
Date:   Wed, 9 Dec 2020 09:38:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20201208220624.21877-1-david.e.box@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607486891; bh=tKNGbJ7HdwulcixuNe1lidHwvhj6kJsJOljpK1qtsoI=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=DnSa1mZuCpmEuoQ1WmKpXoVgPVcTFnjYPFp4ho6iHjjTKtxX42y325nNnUqrNdk+d
         ngY6A7SePH1JADN/Dj1n2mk0fi2dUk3TGL7qpwNS4YJtOGmeASmtn/0h1XXLLq2lm6
         yZQc0rzwP7AUJVm4jUoF083Nn5bDt7/lR7MJtDZSOTH0pILa+MhZhDYzIDAxsjO7Po
         yO58ArA97iIumY4dkozGmtlSJy5kVV2HZBQCoEmf713+nYFh986AI0rhF/xKp6unQ+
         g2PHnQRSQM5gBUD/Wn1tDbJXqxOBFlVcNUFja6wu9wmoAevWCbmwMKQbpPBnuhkXRk
         MPEtfeXUL5yCw==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There is a change already available for it in linux-next
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=4257f7e008ea394fcecc050f1569c3503b8bcc15

Thanks,
Vidya Sagar

On 12/9/2020 3:36 AM, David E. Box wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Intel systems that support ACPI Low Power Idle it has been observed
> that the L1 Substate capability can return disabled after a s2idle
> cycle. This causes the loss of L1 Substate support during runtime
> leading to higher power consumption. Add save/restore of the L1SS
> control registers.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>   drivers/pci/pci.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 49 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e578d34095e9..beee3d9952a6 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1539,6 +1539,48 @@ static void pci_restore_ltr_state(struct pci_dev *dev)
>          pci_write_config_word(dev, ltr + PCI_LTR_MAX_NOSNOOP_LAT, *cap++);
>   }
> 
> +static void pci_save_l1ss_state(struct pci_dev *dev)
> +{
> +       int l1ss;
> +       struct pci_cap_saved_state *save_state;
> +       u16 *cap;
> +
> +       if (!pci_is_pcie(dev))
> +               return;
> +
> +       l1ss = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS);
> +       if (!l1ss)
> +               return;
> +
> +       save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
> +       if (!save_state) {
> +               pci_err(dev, "no suspend buffer for L1 Substates\n");
> +               return;
> +       }
> +
> +       cap = (u16 *)&save_state->cap.data[0];
> +       pci_read_config_word(dev, l1ss + PCI_L1SS_CTL1, cap++);
> +       pci_read_config_word(dev, l1ss + PCI_L1SS_CTL1 + 2, cap++);
> +       pci_read_config_word(dev, l1ss + PCI_L1SS_CTL2, cap++);
> +}
> +
> +static void pci_restore_l1ss_state(struct pci_dev *dev)
> +{
> +       struct pci_cap_saved_state *save_state;
> +       int l1ss;
> +       u16 *cap;
> +
> +       save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
> +       l1ss = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS);
> +       if (!save_state || !l1ss)
> +               return;
> +
> +       cap = (u16 *)&save_state->cap.data[0];
> +       pci_write_config_word(dev, l1ss + PCI_L1SS_CTL1, *cap++);
> +       pci_write_config_word(dev, l1ss + PCI_L1SS_CTL1 + 2, *cap++);
> +       pci_write_config_word(dev, l1ss + PCI_L1SS_CTL2, *cap++);
> +}
> +
>   /**
>    * pci_save_state - save the PCI configuration space of a device before
>    *                 suspending
> @@ -1563,6 +1605,7 @@ int pci_save_state(struct pci_dev *dev)
>          if (i != 0)
>                  return i;
> 
> +       pci_save_l1ss_state(dev);
>          pci_save_ltr_state(dev);
>          pci_save_dpc_state(dev);
>          pci_save_aer_state(dev);
> @@ -1670,6 +1713,7 @@ void pci_restore_state(struct pci_dev *dev)
>           */
>          pci_restore_ltr_state(dev);
> 
> +       pci_restore_l1ss_state(dev);
>          pci_restore_pcie_state(dev);
>          pci_restore_pasid_state(dev);
>          pci_restore_pri_state(dev);
> @@ -3332,6 +3376,11 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
>          if (error)
>                  pci_err(dev, "unable to allocate suspend buffer for LTR\n");
> 
> +       error = pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_L1SS,
> +                                           3 * sizeof(u16));
> +       if (error)
> +               pci_err(dev, "unable to allocate suspend buffer for L1 Substates\n");
> +
>          pci_allocate_vc_save_buffers(dev);
>   }
> 
> --
> 2.20.1
> 
