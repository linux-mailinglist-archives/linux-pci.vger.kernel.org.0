Return-Path: <linux-pci+bounces-279-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9967FED95
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 12:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 555C41C20B53
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 11:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183963C085;
	Thu, 30 Nov 2023 11:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pci@vger.kernel.org
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC1810D0;
	Thu, 30 Nov 2023 03:13:12 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
	by ex01.ufhost.com (Postfix) with ESMTP id 45F9524E052;
	Thu, 30 Nov 2023 19:13:05 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 30 Nov
 2023 19:13:05 +0800
Received: from [192.168.125.136] (113.72.145.176) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 30 Nov
 2023 19:13:04 +0800
Message-ID: <78255041-47a3-4f52-97cd-83347c5813bd@starfivetech.com>
Date: Thu, 30 Nov 2023 19:13:05 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PCI: Add PCIE_CONFIG_REQUEST_WAIT_MS waiting time
 value
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mason.huo@starfivetech.com>,
	<leyfoon.tan@starfivetech.com>, <minda.chen@starfivetech.com>
References: <20231129232219.GA444277@bhelgaas>
From: Kevin Xie <kevin.xie@starfivetech.com>
In-Reply-To: <20231129232219.GA444277@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag



On 2023/11/30 7:22, Bjorn Helgaas wrote:
> On Fri, Nov 24, 2023 at 09:45:08AM +0800, Kevin Xie wrote:
>> Add the PCIE_CONFIG_REQUEST_WAIT_MS marco to define the minimum waiting
>> time between sending the first configuration request to the device and
>> exit from a conventional reset (or after link training completes).
>> 
>> As described in the conventional reset rules of PCI specifications,
>> there are two different use cases of the value:
>> 
>>    - With a downstream port that supports link speeds <= 5.0 GT/s,
>>      the waiting is following exit from a conventional reset.
>> 
>>    - With a downstream port that supports link speeds > 5.0 GT/s,
>>      the waiting is after link training completes.
>> 
>> Signed-off-by: Kevin Xie <kevin.xie@starfivetech.com>
>> Reviewed-by: Mason Huo <mason.huo@starfivetech.com>
>> ---
>>  drivers/pci/pci.h | 7 +++++++
>>  1 file changed, 7 insertions(+)
>> 
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 5ecbcf041179..4ca8766e546e 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -22,6 +22,13 @@
>>   */
>>  #define PCIE_PME_TO_L2_TIMEOUT_US	10000
>>  
>> +/*
>> + * PCIe r6.0, sec 6.6.1, <Conventional Reset>
>> + * Requires a minimum waiting of 100ms before sending a configuration
>> + * request to the device.
>> + */
>> +#define PCIE_CONFIG_REQUEST_WAIT_MS	100
> 
> Oh, and I think this name should include something about "reset"
> because that's the common scenario and that's the spec section where
> the value is mentioned.

Agree, how about PCIE_RESET_CONFIG_DEVICE_WAIT_MS?

