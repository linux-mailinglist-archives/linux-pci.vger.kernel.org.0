Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4840414648A
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2020 10:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgAWJYi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jan 2020 04:24:38 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:8170 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgAWJYi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jan 2020 04:24:38 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e2966280000>; Thu, 23 Jan 2020 01:23:52 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 23 Jan 2020 01:24:37 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 23 Jan 2020 01:24:37 -0800
Received: from [10.25.73.122] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 23 Jan
 2020 09:24:33 +0000
Subject: Re: [PATCH V2 0/5] Add support to defer core initialization
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <kishon@ti.com>
CC:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <andrew.murray@arm.com>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <Jisheng.Zhang@synaptics.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20200103100736.27627-1-vidyas@nvidia.com>
 <a8678df3-141b-51ab-b0cb-5e88c6ac91b5@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <680a58ec-5d09-3e3b-2fd6-544c32732818@nvidia.com>
Date:   Thu, 23 Jan 2020 14:54:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <a8678df3-141b-51ab-b0cb-5e88c6ac91b5@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1579771432; bh=CJkKxyTcSbvf0mPRyw06IElQEGq2bOcaS4s3pVBON7k=;
        h=X-PGP-Universal:Subject:From:To:CC:References:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Xeh0yuoBkA5QXkhqjM1166Nnm/5vcIjw0ly24p4ffLbyEJyUYcEsKhy/h+Vz6a4XO
         1AvHAR8pI1Z26vBBLapfq7mMAjDBGn2I0uv4uhFx1XLZZvIUo4kHlYMtgoNzUNvdAa
         31K/ZOzGEKS1ykoSPtHhcDkmmBKRE95kUJEa7Ksn/swvZ1bpBxRSoRK3ILxboVGxmK
         ay6bm7CtVZwhUVtTF6r4W2vzouuie2nC9VseU3g8eR8C1STf9cenfbbvFOwTIjUISG
         CZioIIux0Cy938Sau1Dthrq6SEvTDAaKbq1J7+iusMfg8mfVo93+iNlKde1494MZua
         ffUICBmOJLLlw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kishon,
Apologies for pinging again. Could you please review this series?

Thanks,
Vidya Sagar

On 1/11/2020 5:18 PM, Vidya Sagar wrote:
> Hi Kishon,
> Could you please review this series?
>=20
> Also, this series depends on the following change of yours
> http://patchwork.ozlabs.org/patch/1109884/
> Whats the plan to get this merged?
>=20
> Thanks,
> Vidya Sagar
>=20
> On 1/3/20 3:37 PM, Vidya Sagar wrote:
>> EPC/DesignWare core endpoint subsystems assume that the core registers=20
>> are
>> available always for SW to initialize. But, that may not be the case=20
>> always.
>> For example, Tegra194 hardware has the core running on a clock that is=20
>> derived
>> from reference clock that is coming into the endpoint system from host.
>> Hence core is made available asynchronously based on when host system=20
>> is going
>> for enumeration of devices. To accommodate this kind of hardwares,=20
>> support is
>> required to defer the core initialization until the respective=20
>> platform driver
>> informs the EPC/DWC endpoint sub-systems that the core is indeed=20
>> available for
>> initiaization. This patch series is attempting to add precisely that.
>> This series is based on Kishon's patch that adds notification mechanism
>> support from EPC to EPF @ http://patchwork.ozlabs.org/patch/1109884/
>>
>> Vidya Sagar (5):
>> =C2=A0=C2=A0 PCI: endpoint: Add core init notifying feature
>> =C2=A0=C2=A0 PCI: dwc: Refactor core initialization code for EP mode
>> =C2=A0=C2=A0 PCI: endpoint: Add notification for core init completion
>> =C2=A0=C2=A0 PCI: dwc: Add API to notify core initialization completion
>> =C2=A0=C2=A0 PCI: pci-epf-test: Add support to defer core initialization
>>
>> =C2=A0 .../pci/controller/dwc/pcie-designware-ep.c=C2=A0=C2=A0 |=C2=A0 7=
9 +++++++-----
>> =C2=A0 drivers/pci/controller/dwc/pcie-designware.h=C2=A0 |=C2=A0 11 ++
>> =C2=A0 drivers/pci/endpoint/functions/pci-epf-test.c | 118 ++++++++++++-=
-----
>> =C2=A0 drivers/pci/endpoint/pci-epc-core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 19 ++-
>> =C2=A0 include/linux/pci-epc.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
>> =C2=A0 include/linux/pci-epf.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 5 +
>> =C2=A0 6 files changed, 164 insertions(+), 70 deletions(-)
>>
