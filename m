Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C78505854D
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2019 17:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfF0PLp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jun 2019 11:11:45 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:8802 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbfF0PLp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Jun 2019 11:11:45 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d14dcae0000>; Thu, 27 Jun 2019 08:11:42 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 27 Jun 2019 08:11:44 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 27 Jun 2019 08:11:44 -0700
Received: from [10.25.73.176] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 27 Jun
 2019 15:11:41 +0000
Subject: Re: [PATCH] PCI: tegra: Enable Relaxed Ordering only for Tegra20 &
 Tegra30
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <bhelgaas@google.com>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20190618073810.30270-1-vidyas@nvidia.com>
 <20190627100616.GA30071@e121166-lin.cambridge.arm.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <716ad7c9-08bb-b885-69bd-a442d6f9b2eb@nvidia.com>
Date:   Thu, 27 Jun 2019 20:41:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190627100616.GA30071@e121166-lin.cambridge.arm.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1561648302; bh=wcVRQtlrl6XY12hL+MvBFH8xk//05ZdMh8n6dyB273A=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=LFUAx5r73m9LAmbGYe07Y2jx546m/KibD029jhLkcmNz0ZeouylfdamLPLfAikUW9
         Nkadf6zYj0V7mAg6C2Pop9iq6zNQsmkXMf9SZOmp3qh2SmMbeel8qJqfKJsOvJMxDJ
         j6Y/zGJgmwmTUbaxxnrlV4G2HXL5GljRT3y6gcx2Le5P4WxxoBf3aXHauQtXxjZH6x
         H+hB5T0honHhBT8iVrGGswIT8ghDmFnnoaLfRDHxBLbmQqFAn0ayNED6WrtR2bUQ8W
         4ld7d5TsU97Z/KZFNdvrvS7P3en9nj1pXLNVBoDfQeDHKAxXQay8GFl1vY8xwbSHFb
         d7fdlvq/zGmcg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/27/2019 3:36 PM, Lorenzo Pieralisi wrote:
> On Tue, Jun 18, 2019 at 01:08:10PM +0530, Vidya Sagar wrote:
>> Currently Relaxed Ordering bit in the configuration space is enabled for
>> all devices whereas it should be enabled only for root ports for Tegra20
>> and Tegra30 chips to avoid deadlock in hardware.
> 
> This is a fix so I think you had better add a Fixes: tag and if the
> erratum is a public document it would be good to add it to the log
> to explain what the problem is.
> 
> Thanks,
> Lorenzo
This has been there from the beginning. I mean, if I have to give a tag as part
of Fixes: , then I should give the tag that adds this driver itself. Is that fine?
I can quote the following document section 31.1 for Tegra20, but the same information
is not mentioned in Tegra30 specific public document.
https://www.chiark.greenend.org.uk/~theom/riscos/docs/Tegra2_TRM_DP04508001v01p.pdf
Is it fine to just quote only this document?

Thanks,
Vidya Sagar
> 
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>>   drivers/pci/controller/pci-tegra.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
>> index 464ba2538d52..bc7be369c1b3 100644
>> --- a/drivers/pci/controller/pci-tegra.c
>> +++ b/drivers/pci/controller/pci-tegra.c
>> @@ -545,12 +545,15 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0bf1, tegra_pcie_fixup_class);
>>   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0e1c, tegra_pcie_fixup_class);
>>   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0e1d, tegra_pcie_fixup_class);
>>   
>> -/* Tegra PCIE requires relaxed ordering */
>> +/* Tegra20 and Tegra30 PCIE requires relaxed ordering */
>>   static void tegra_pcie_relax_enable(struct pci_dev *dev)
>>   {
>>   	pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_RELAX_EN);
>>   }
>> -DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, tegra_pcie_relax_enable);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0bf0, tegra_pcie_relax_enable);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0bf1, tegra_pcie_relax_enable);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0e1c, tegra_pcie_relax_enable);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0e1d, tegra_pcie_relax_enable);
>>   
>>   static int tegra_pcie_request_resources(struct tegra_pcie *pcie)
>>   {
>> -- 
>> 2.17.1
>>

