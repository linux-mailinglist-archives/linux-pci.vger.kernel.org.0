Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEDF32B4404
	for <lists+linux-pci@lfdr.de>; Mon, 16 Nov 2020 13:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgKPMus (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Nov 2020 07:50:48 -0500
Received: from mga06.intel.com ([134.134.136.31]:53938 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgKPMus (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Nov 2020 07:50:48 -0500
IronPort-SDR: RBIuWte6u/jJtvuXJLAh4MS1aHuXA2973tglz7BTxbixHdD/y4PVFNlWzZnU5Yj1h4BdnIBqgd
 PB69dAaS8ryg==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="232356595"
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="232356595"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 04:50:41 -0800
IronPort-SDR: pjbCtcfsqxuDEzk4ztyIKCUi9dy3iW0ILklBigT8tTdytW+E8PG9A1yk/KJqKaM1OE+uXZe2oq
 gFgJn9gqbffg==
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="358453174"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.59]) ([10.254.215.59])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 04:50:38 -0800
Cc:     baolu.lu@linux.intel.com, Itay Aveksis <itayav@nvidia.com>,
        Ziyad Atiyyeh <ziyadat@nvidia.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Moshe Shemesh <moshe@nvidia.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Marc Zyngier <maz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: iommu/vt-d: Cure VF irqdomain hickup
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200826111628.794979401@linutronix.de>
 <20201112125531.GA873287@nvidia.com> <87mtzmmzk6.fsf@nanos.tec.linutronix.de>
 <87k0uqmwn4.fsf@nanos.tec.linutronix.de>
 <87d00imlop.fsf@nanos.tec.linutronix.de>
 <CAMuHMdXA7wfJovmfSH2nbAhN0cPyCiFHodTvg4a8Hm9rx5Dj-w@mail.gmail.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <686f0416-e408-7e6b-0fc1-8cddcd479bb6@linux.intel.com>
Date:   Mon, 16 Nov 2020 20:50:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXA7wfJovmfSH2nbAhN0cPyCiFHodTvg4a8Hm9rx5Dj-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020/11/16 17:47, Geert Uytterhoeven wrote:
> Hi Thomas,
> 
> On Thu, Nov 12, 2020 at 8:16 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>> The recent changes to store the MSI irqdomain pointer in struct device
>> missed that Intel DMAR does not register virtual function devices.  Due to
>> that a VF device gets the plain PCI-MSI domain assigned and then issues
>> compat MSI messages which get caught by the interrupt remapping unit.
>>
>> Cure that by inheriting the irq domain from the physical function
>> device.
>>
>> That's a temporary workaround. The correct fix is to inherit the irq domain
>> from the bus, but that's a larger effort which needs quite some other
>> changes to the way how x86 manages PCI and MSI domains.
>>
>> Fixes: 85a8dfc57a0b ("iommm/vt-d: Store irq domain in struct device")
>> Reported-by: Jason Gunthorpe <jgg@nvidia.com>
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> ---
>>   drivers/iommu/intel/dmar.c |   19 ++++++++++++++++++-
>>   1 file changed, 18 insertions(+), 1 deletion(-)
>>
>> --- a/drivers/iommu/intel/dmar.c
>> +++ b/drivers/iommu/intel/dmar.c
>> @@ -333,6 +333,11 @@ static void  dmar_pci_bus_del_dev(struct
>>          dmar_iommu_notify_scope_dev(info);
>>   }
>>
>> +static inline void vf_inherit_msi_domain(struct pci_dev *pdev)
>> +{
>> +       dev_set_msi_domain(&pdev->dev, dev_get_msi_domain(&pdev->physfn->dev));
> 
> If CONFIG_PCI_ATS is not set:
> 
>      error: 'struct pci_dev' has no member named 'physfn'
> 
> http://kisskb.ellerman.id.au/kisskb/buildresult/14400927/

Maybe pci_physfn() helper should be used here.

Best regards,
baolu
