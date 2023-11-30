Return-Path: <linux-pci+bounces-274-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D057FEC76
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 11:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75CCFB20DC7
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 10:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41B53B1B8;
	Thu, 30 Nov 2023 10:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pci@vger.kernel.org
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3077A10DB;
	Thu, 30 Nov 2023 02:03:59 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
	by fd01.gateway.ufhost.com (Postfix) with ESMTP id D8A9F7F8A;
	Thu, 30 Nov 2023 18:03:55 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 30 Nov
 2023 18:03:55 +0800
Received: from [192.168.125.136] (113.72.145.176) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 30 Nov
 2023 18:03:55 +0800
Message-ID: <f0844a59-7534-4195-b656-eb51586cbff6@starfivetech.com>
Date: Thu, 30 Nov 2023 18:03:55 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PCI: Add PCIE_CONFIG_REQUEST_WAIT_MS waiting time
 value
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mason.huo@starfivetech.com>,
	<leyfoon.tan@starfivetech.com>, <minda.chen@starfivetech.com>
References: <20231129232108.GA444155@bhelgaas>
Content-Language: en-US
From: Kevin Xie <kevin.xie@starfivetech.com>
In-Reply-To: <20231129232108.GA444155@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable



On 2023/11/30 7:21, Bjorn Helgaas wrote:
> On Fri, Nov 24, 2023 at 09:45:08AM +0800, Kevin Xie wrote:
>> Add the PCIE_CONFIG_REQUEST_WAIT_MS marco to define the minimum waitin=
g
>> time between sending the first configuration request to the device and
>> exit from a conventional reset (or after link training completes).
>=20
> s/marco/macro/
>=20
> List the first event before the second one, i.e., the delay is from
> exit from reset to the config request.
>=20

OK=EF=BC=8CI will use "from A to B" instead of "between A and B".

>> As described in the conventional reset rules of PCI specifications,
>> there are two different use cases of the value:
>>=20
>>    - With a downstream port that supports link speeds <=3D 5.0 GT/s,
>>      the waiting is following exit from a conventional reset.
>>=20
>>    - With a downstream port that supports link speeds > 5.0 GT/s,
>>      the waiting is after link training completes.
>=20
> Include the spec citation here as well as in the comment below.
>=20

OK, I will include the spec citation here.

> I assume there are follow-on patches that actually use this?  Can we
> make this the first patch in a series so we know we don't have an
> unused macro lying around?
>=20

Yes, we will use the marco in the next version of our PCIe controller pat=
ches.
Here is the link of current version patch series:
https://lore.kernel.org/lkml/20231115114912.71448-20-minda.chen@starfivet=
ech.com/T/#u=20

Do you mean that I should put this patch back to the above series as one =
of the separate patches?

Thanks for your review.

>> Signed-off-by: Kevin Xie <kevin.xie@starfivetech.com>
>> Reviewed-by: Mason Huo <mason.huo@starfivetech.com>
>> ---
>>  drivers/pci/pci.h | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>=20
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 5ecbcf041179..4ca8766e546e 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -22,6 +22,13 @@
>>   */
>>  #define PCIE_PME_TO_L2_TIMEOUT_US	10000
>> =20
>> +/*
>> + * PCIe r6.0, sec 6.6.1, <Conventional Reset>
>> + * Requires a minimum waiting of 100ms before sending a configuration
>> + * request to the device.
>> + */
>> +#define PCIE_CONFIG_REQUEST_WAIT_MS	100
>> +
>>  extern const unsigned char pcie_link_speed[];
>>  extern bool pci_early_dump;
>> =20
>> --=20
>> 2.25.1
>>=20

