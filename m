Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144762E95A7
	for <lists+linux-pci@lfdr.de>; Mon,  4 Jan 2021 14:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbhADNN4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Jan 2021 08:13:56 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35252 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbhADNNz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jan 2021 08:13:55 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 104DD2hh108940;
        Mon, 4 Jan 2021 07:13:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1609765982;
        bh=PniDc9QWWr+VJ0de9ADs3ktmUYpcGrHXEordESznxd8=;
        h=From:Subject:To:CC:References:Date:In-Reply-To;
        b=AeSxBlvH+CO76UEm/uFeQBDGOEOW3/LMnpglLZBKb2IRH/Hl2uFVnr8YZJJmiQutx
         fOSY936VSiRI8aKbKsx+KDfrnu1Kx4HeETNPq+3swsuKxZcG6RgMbba1vGLqi/4/aU
         OPkhzCdnR5P9l6my/QlQfSIoj93PWbgHbTnUgMjA=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 104DD2Gd042173
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Jan 2021 07:13:02 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 4 Jan
 2021 07:13:01 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 4 Jan 2021 07:13:01 -0600
Received: from [10.250.235.36] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 104DCuxB085196;
        Mon, 4 Jan 2021 07:12:57 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v8 11/18] PCI: cadence: Implement ->msi_map_irq() ops
To:     Rob Herring <robh@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        PCI <linux-pci@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <linux-ntb@googlegroups.com>
References: <20201111153559.19050-1-kishon@ti.com>
 <20201111153559.19050-12-kishon@ti.com>
 <CAL_Jsq+iUU0aR950fvQ7+uenBT5MVbCEU9cDg+vfyO=VugpTZA@mail.gmail.com>
Message-ID: <992b5423-89a2-a03b-539d-a9b2822f598a@ti.com>
Date:   Mon, 4 Jan 2021 18:42:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+iUU0aR950fvQ7+uenBT5MVbCEU9cDg+vfyO=VugpTZA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On 15/12/20 9:31 pm, Rob Herring wrote:
> On Wed, Nov 11, 2020 at 9:37 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>
>> Implement ->msi_map_irq() ops in order to map physical address to
>> MSI address and return MSI data.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  .../pci/controller/cadence/pcie-cadence-ep.c  | 53 +++++++++++++++++++
>>  1 file changed, 53 insertions(+)
>>
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
>> index 84cc58dc8512..1fe6b8baca97 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
>> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
>> @@ -382,6 +382,57 @@ static int cdns_pcie_ep_send_msi_irq(struct cdns_pcie_ep *ep, u8 fn,
>>         return 0;
>>  }
>>
>> +static int cdns_pcie_ep_map_msi_irq(struct pci_epc *epc, u8 fn,
>> +                                   phys_addr_t addr, u8 interrupt_num,
>> +                                   u32 entry_size, u32 *msi_data,
>> +                                   u32 *msi_addr_offset)
>> +{
>> +       struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
>> +       u32 cap = CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET;
>> +       struct cdns_pcie *pcie = &ep->pcie;
>> +       u64 pci_addr, pci_addr_mask = 0xff;
>> +       u16 flags, mme, data, data_mask;
>> +       u8 msi_count;
>> +       int ret;
>> +       int i;
>> +
> 
> 
>> +       /* Check whether the MSI feature has been enabled by the PCI host. */
>> +       flags = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSI_FLAGS);
>> +       if (!(flags & PCI_MSI_FLAGS_ENABLE))
>> +               return -EINVAL;
>> +
>> +       /* Get the number of enabled MSIs */
>> +       mme = (flags & PCI_MSI_FLAGS_QSIZE) >> 4;
>> +       msi_count = 1 << mme;
>> +       if (!interrupt_num || interrupt_num > msi_count)
>> +               return -EINVAL;
>> +
>> +       /* Compute the data value to be written. */
>> +       data_mask = msi_count - 1;
>> +       data = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSI_DATA_64);
>> +       data = data & ~data_mask;
>> +
>> +       /* Get the PCI address where to write the data into. */
>> +       pci_addr = cdns_pcie_ep_fn_readl(pcie, fn, cap + PCI_MSI_ADDRESS_HI);
>> +       pci_addr <<= 32;
>> +       pci_addr |= cdns_pcie_ep_fn_readl(pcie, fn, cap + PCI_MSI_ADDRESS_LO);
>> +       pci_addr &= GENMASK_ULL(63, 2);
> 
> Wouldn't all of the above be the same code for any endpoint driver? We
> just need endpoint config space accessors for the same 32-bit only
> access issues. Not asking for that in this series, but if that's the
> direction we should go.

Do you mean "endpoint" variant of pci_generic_config_read() which takes
function number and capability offset? That could be done but we have to
add support to traverse the linked list of capabilities though the
capabilities are going to be at a fixed location for a given IP.

Also in some cases, the writes are to a different register than the
configuration space registers like vendor_id in Cadence EP should be
written to Local Management register instead of the configuration space
register.

Thank You,
Kishon
