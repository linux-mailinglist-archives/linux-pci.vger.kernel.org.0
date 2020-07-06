Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5C92151AC
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jul 2020 06:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgGFEfW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jul 2020 00:35:22 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:9151 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgGFEfW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jul 2020 00:35:22 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f02a9fc0000>; Sun, 05 Jul 2020 21:35:08 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sun, 05 Jul 2020 21:35:21 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sun, 05 Jul 2020 21:35:21 -0700
Received: from [10.25.73.54] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 6 Jul
 2020 04:35:09 +0000
Subject: Re: [PATCH 0/2] PCI: dwc: Add support to handle prefetchable memory
 separately
From:   Vidya Sagar <vidyas@nvidia.com>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "amurray@thegoodpenguin.co.uk" <amurray@thegoodpenguin.co.uk>,
        "robh@kernel.org" <robh@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        <alan.mikhak@sifive.com>, <kishon@ti.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kthota@nvidia.com" <kthota@nvidia.com>,
        "mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
        "sagar.tv@gmail.com" <sagar.tv@gmail.com>
References: <20200602100940.10575-1-vidyas@nvidia.com>
 <DM5PR12MB127675E8C053755CB82A54BCDA8B0@DM5PR12MB1276.namprd12.prod.outlook.com>
 <389018aa-79c8-4a1e-5379-8b8e42939859@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <dd32f413-aa1c-b2e6-d76f-9d2897a8cfad@nvidia.com>
Date:   Mon, 6 Jul 2020 10:05:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <389018aa-79c8-4a1e-5379-8b8e42939859@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594010109; bh=ilcKIOkMCzYWF/8cfZbAzhF6F1vsrgC37NSf5Q/f3Ow=;
        h=X-PGP-Universal:Subject:From:To:CC:References:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=X0fwsDDiyBlCd5cOCk4yJqKY6mVt4qKPhYBoe+RqvgC58lv0iUjqDUoki0cARrI5o
         KS/DfZIQ68LfFVCeQHAXWLnRCuXMauBgK5WEubT6mCpA++uAQYjC82pzLdKbSqEZfH
         ChUFhEKmnt0P3d+5GHD175KxZY6kySVHZsKNPvkAE7UiAXMTluZDp81ktz2qFmHVSF
         zF9RsxsCOL5SEDgpW2eZ9XUkcVo2wLzDhf6ipC0Sf6cpCb8I+4RONuP2MtWMqbctTP
         Ho31JfyTQ1ukQVAAKL5O0bOmOlGqqd87BV+9jW6/ctRaUv2teHx5qfG1Ywq7JBfCmV
         FMmH6qxif939Q==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 18-Jun-20 12:26 AM, Vidya Sagar wrote:
>=20
>=20
> On 02-Jun-20 10:37 PM, Gustavo Pimentel wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On Tue, Jun 2, 2020 at 11:9:38, Vidya Sagar <vidyas@nvidia.com> wrote:
>>
>>> In this patch series,
>>> Patch-1
>>> adds required infrastructure to deal with prefetchable memory region
>>> information coming from 'ranges' property of the respective=20
>>> device-tree node
>>> separately from non-prefetchable memory region information.
>>> Patch-2
>>> Adds support to use ATU region-3 for establishing the mapping between=20
>>> CPU
>>> addresses and PCIe bus addresses.
>>> It also changes the logic to determine whether mapping is required or=20
>>> not by
>>> checking both CPU address and PCIe bus address for both prefetchable an=
d
>>> non-prefetchable regions. If the addresses are same, then, it is=20
>>> understood
>>> that 1:1 mapping is in place and there is no need to setup ATU mapping
>>> whereas if the addresses are not the same, then, there is a need to=20
>>> setup ATU
>>> mapping. This is certainly true for Tegra194 and what I heard from=20
>>> our HW
>>> engineers is that it should generally be true for any DWC based=20
>>> implementation
>>> also.
>>> Hence, I request Synopsys folks (Jingoo Han & Gustavo Pimentel ??) to=20
>>> confirm
>>> the same so that this particular patch won't cause any regressions=20
>>> for other
>>> DWC based platforms.
>>
>> Hi Vidya,
>>
>> Unfortunately due to the COVID-19 lockdown, I can't access my developmen=
t
>> prototype setup to test your patch.
>> It might take some while until I get the possibility to get access to it
>> again.
> Hi Gustavo,
> Did you find time to check this?
> Adding Kishon and Alan as well to take a look at this and verify on=20
> their platforms if possible.
Hi Kishon and Alan, did you find time to verify this on your respective=20
platforms?

Thanks,
Vidya Sagar
>=20
> Thanks,
> Vidya Sagar
>=20
>>
>> -Gustavo
>>
>>>
>>> Vidya Sagar (2):
>>> =C2=A0=C2=A0 PCI: dwc: Add support to handle prefetchable memory separa=
tely
>>> =C2=A0=C2=A0 PCI: dwc: Use ATU region to map prefetchable memory region
>>>
>>> =C2=A0 .../pci/controller/dwc/pcie-designware-host.c | 46 +++++++++++++=
+-----
>>> =C2=A0 drivers/pci/controller/dwc/pcie-designware.c=C2=A0 |=C2=A0 6 ++-
>>> =C2=A0 drivers/pci/controller/dwc/pcie-designware.h=C2=A0 |=C2=A0 8 +++=
-
>>> =C2=A0 3 files changed, 45 insertions(+), 15 deletions(-)
>>>
>>> --=20
>>> 2.17.1
>>
>>
