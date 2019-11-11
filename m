Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D393BF6F8B
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2019 09:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfKKIKc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Nov 2019 03:10:32 -0500
Received: from mga01.intel.com ([192.55.52.88]:24265 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726768AbfKKIKc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Nov 2019 03:10:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Nov 2019 00:10:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,291,1569308400"; 
   d="scan'208";a="354710033"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 11 Nov 2019 00:10:31 -0800
Received: from [10.226.39.46] (ekotax-mobl.gar.corp.intel.com [10.226.39.46])
        by linux.intel.com (Postfix) with ESMTP id 31F0A5803A5;
        Mon, 11 Nov 2019 00:10:24 -0800 (PST)
Subject: Re: [PATCH v5 3/3] PCI: artpec6: Configure FTS with dwc helper
 function
To:     Andrew Murray <andrew.murray@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>
Cc:     "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "martin.blumenstingl@googlemail.com" 
        <martin.blumenstingl@googlemail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>,
        "cheol.yong.kim@intel.com" <cheol.yong.kim@intel.com>,
        "chuanhua.lei@linux.intel.com" <chuanhua.lei@linux.intel.com>,
        "qi-ming.wu@intel.com" <qi-ming.wu@intel.com>
References: <cover.1572950559.git.eswara.kota@linux.intel.com>
 <90a64d72a32dbc75c03a58a1813f50e547170ff4.1572950559.git.eswara.kota@linux.intel.com>
 <SL2P216MB010527F9E1C142F0A347ED63AA780@SL2P216MB0105.KORP216.PROD.OUTLOOK.COM>
 <20191108104338.GG43905@e119886-lin.cambridge.arm.com>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <913f3aa2-708e-ceee-217a-5a0a1b1dfca4@linux.intel.com>
Date:   Mon, 11 Nov 2019 16:10:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191108104338.GG43905@e119886-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 11/8/2019 6:43 PM, Andrew Murray wrote:
> On Thu, Nov 07, 2019 at 09:03:46PM +0000, Jingoo Han wrote:
>> On 11/5/19, 10:44 PM, Dilip Kota wrote:
>>> Utilize DesugnWare helper functions to configure Fast Training
>> Nitpicking: Fix typo (DesugnWare --> DesignWare)
>>
>> If possible, how about the following?
>> Utilize DesignWare --> Use DesignWare
>>
>> Best regards,
>> Jingoo Han
>>
>>> Sequence. Drop the respective code in the driver.
>>>
>>> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
> With the changes suggested in this thread, you can add:
>
> Reviewed-by: Andrew Murray <andrew.murray@arm.com>
Sure.

Thanks a lot for reviewing patch and giving inputs,

Regards,
Dilip

>
>>> ---
>>>   drivers/pci/controller/dwc/pcie-artpec6.c | 8 +-------
>>>   1 file changed, 1 insertion(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
>>> index d00252bd8fae..02d93b8c7942 100644
>>> --- a/drivers/pci/controller/dwc/pcie-artpec6.c
>>> +++ b/drivers/pci/controller/dwc/pcie-artpec6.c
>>> @@ -51,9 +51,6 @@ static const struct of_device_id artpec6_pcie_of_match[];
>>>   #define ACK_N_FTS_MASK			GENMASK(15, 8)
>>>   #define ACK_N_FTS(x)			(((x) << 8) & ACK_N_FTS_MASK)
>>>   
>>> -#define FAST_TRAINING_SEQ_MASK		GENMASK(7, 0)
>>> -#define FAST_TRAINING_SEQ(x)		(((x) << 0) & FAST_TRAINING_SEQ_MASK)
>>> -
>>>   /* ARTPEC-6 specific registers */
>>>   #define PCIECFG				0x18
>>>   #define  PCIECFG_DBG_OEN		BIT(24)
>>> @@ -313,10 +310,7 @@ static void artpec6_pcie_set_nfts(struct artpec6_pcie *artpec6_pcie)
>>>   	 * Set the Number of Fast Training Sequences that the core
>>>   	 * advertises as its N_FTS during Gen2 or Gen3 link training.
>>>   	 */
>>> -	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
>>> -	val &= ~FAST_TRAINING_SEQ_MASK;
>>> -	val |= FAST_TRAINING_SEQ(180);
>>> -	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
>>> +	dw_pcie_link_set_n_fts(pci, 180);
>>>   }
>>>
>>>   static void artpec6_pcie_assert_core_reset(struct artpec6_pcie *artpec6_pcie)
>>> -- 
>>> 2.11.0
