Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE8D2A5E8B
	for <lists+linux-pci@lfdr.de>; Wed,  4 Nov 2020 08:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbgKDHFV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Nov 2020 02:05:21 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:9984 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728784AbgKDHFV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Nov 2020 02:05:21 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa252b30001>; Tue, 03 Nov 2020 23:05:23 -0800
Received: from [10.40.203.207] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 4 Nov
 2020 07:05:01 +0000
Subject: Re: [PATCH] PCI/ASPM: Save/restore ASPM-L1SS controls for
 suspend/resume
To:     <bhelgaas@google.com>, <hkallweit1@gmail.com>,
        <wangxiongfeng2@huawei.com>, <mika.westerberg@linux.intel.com>,
        <kai.heng.feng@canonical.com>, <chris.packham@alliedtelesis.co.nz>,
        <yangyicong@hisilicon.com>, <lorenzo.pieralisi@arm.com>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20201024190442.871-1-vidyas@nvidia.com>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <86571610-b6ce-0f20-5a9f-99d6c427333a@nvidia.com>
Date:   Wed, 4 Nov 2020 12:34:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201024190442.871-1-vidyas@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604473523; bh=mxrv/GFcUzxOEqhqbn1Xb27HCl4eCXJNNUewo06n4cY=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=oeE9u2Isat8FGOwqifDCpZGqTkua3CS8xLPYp9KV+YQufScJ0ZTbCPikMk6JX1Yng
         XMiLzD45Z7FgNU4HZqJaX2BpbNN0+2R+S/39O30jMmb20/D2z0hE9tyWjsneM66p25
         Z2qezFv5uhj6a9uX1ZjuAXlwVAwXCHVqOO9oaiEI1qQTLbREOYr4XlBFcwtQ52YBc6
         2tngoQMzpUtTgxRxmqKGtMKxkWXhGq3bagolIyP4u7kRxWI+MzjA/08811Fq2ova81
         TldDERN1LlMezU6xg/hsJWvbVAJhVyYwNzDxJLLUUAONHSbgpBNZc8RVOZH0DP8dDh
         9m1auDhMt8BgQ==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn / Lorenzo,
Could you please review this change?

Thanks,
Vidya Sagar

On 10/25/2020 12:34 AM, Vidya Sagar wrote:
> Previously ASPM L1-Sub-States control registers (CTL1 and CTL2) weren't
> saved and restored during suspend/resume leading to ASPM-L1SS
> configuration being lost post resume.
> 
> Save the ASPM-L1SS control registers so that the configuration is retained
> post resume.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> v1:
> * It would be really good if someone can verify it on a non tegra194 platform
> 
>   drivers/pci/pci.c       |  7 +++++++
>   drivers/pci/pci.h       |  4 ++++
>   drivers/pci/pcie/aspm.c | 41 +++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 52 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index a458c46d7e39..034497264bde 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1551,6 +1551,7 @@ int pci_save_state(struct pci_dev *dev)
>   		return i;
>   
>   	pci_save_ltr_state(dev);
> +	pci_save_aspm_l1ss_state(dev);
>   	pci_save_dpc_state(dev);
>   	pci_save_aer_state(dev);
>   	return pci_save_vc_state(dev);
> @@ -1656,6 +1657,7 @@ void pci_restore_state(struct pci_dev *dev)
>   	 * LTR itself (in the PCIe capability).
>   	 */
>   	pci_restore_ltr_state(dev);
> +	pci_restore_aspm_l1ss_state(dev);
>   
>   	pci_restore_pcie_state(dev);
>   	pci_restore_pasid_state(dev);
> @@ -3319,6 +3321,11 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
>   	if (error)
>   		pci_err(dev, "unable to allocate suspend buffer for LTR\n");
>   
> +	error = pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_L1SS,
> +					    2 * sizeof(u32));
> +	if (error)
> +		pci_err(dev, "unable to allocate suspend buffer for ASPM-L1SS\n");
> +
>   	pci_allocate_vc_save_buffers(dev);
>   }
>   
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index fa12f7cbc1a0..8d2135f61e36 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -565,11 +565,15 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev);
>   void pcie_aspm_exit_link_state(struct pci_dev *pdev);
>   void pcie_aspm_pm_state_change(struct pci_dev *pdev);
>   void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
> +void pci_save_aspm_l1ss_state(struct pci_dev *dev);
> +void pci_restore_aspm_l1ss_state(struct pci_dev *dev);
>   #else
>   static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
>   static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
>   static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
>   static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
> +static inline void pci_save_aspm_l1ss_state(struct pci_dev *dev) { }
> +static inline void pci_restore_aspm_l1ss_state(struct pci_dev *dev) { }
>   #endif
>   
>   #ifdef CONFIG_PCIE_ECRC
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 253c30cc1967..d965bbc563ed 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -742,6 +742,47 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
>   				PCI_L1SS_CTL1_L1SS_MASK, val);
>   }
>   
> +void pci_save_aspm_l1ss_state(struct pci_dev *dev)
> +{
> +	struct pci_cap_saved_state *save_state;
> +	int aspm_l1ss;
> +	u32 *cap;
> +
> +	if (!pci_is_pcie(dev))
> +		return;
> +
> +	aspm_l1ss = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS);
> +	if (!aspm_l1ss)
> +		return;
> +
> +	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
> +	if (!save_state)
> +		return;
> +
> +	cap = (u32 *)&save_state->cap.data[0];
> +	pci_read_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, cap++);
> +	pci_read_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, cap++);
> +}
> +
> +void pci_restore_aspm_l1ss_state(struct pci_dev *dev)
> +{
> +	struct pci_cap_saved_state *save_state;
> +	int aspm_l1ss;
> +	u32 *cap;
> +
> +	if (!pci_is_pcie(dev))
> +		return;
> +
> +	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
> +	aspm_l1ss = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS);
> +	if (!save_state || !aspm_l1ss)
> +		return;
> +
> +	cap = (u32 *)&save_state->cap.data[0];
> +	pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, *cap++);
> +	pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, *cap++);
> +}
> +
>   static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
>   {
>   	pcie_capability_clear_and_set_word(pdev, PCI_EXP_LNKCTL,
> 
