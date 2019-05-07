Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F14A315E9D
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2019 09:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfEGHvZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 May 2019 03:51:25 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:11203 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfEGHvY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 May 2019 03:51:24 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cd138f60000>; Tue, 07 May 2019 00:51:18 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 07 May 2019 00:51:22 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 07 May 2019 00:51:22 -0700
Received: from [10.25.73.250] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 May
 2019 07:51:15 +0000
Subject: Re: [PATCH V5 02/16] PCI/PME: Export pcie_pme_disable_msi() &
 pcie_pme_no_msi() APIs
From:   Vidya Sagar <vidyas@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <kishon@ti.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>, <mperttunen@nvidia.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20190424052004.6270-1-vidyas@nvidia.com>
 <20190424052004.6270-3-vidyas@nvidia.com> <20190503110159.GB32400@ulmo>
 <b8f482f4-8136-07b5-3d68-f45a6fd580ba@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <f550fc06-98b1-0e08-874a-f2fba49d32b5@nvidia.com>
Date:   Tue, 7 May 2019 13:21:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <b8f482f4-8136-07b5-3d68-f45a6fd580ba@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557215478; bh=9MM2Job8LFhpLfYfcy/viLo+D6a9yn3lQWyaaUwWEG4=;
        h=X-PGP-Universal:Subject:From:To:CC:References:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=o0JRNPqYfaCtg1oCXPE4tDy0BvTxjjKUHDRoJ36ll2ac2Tqa56V4pnsNTpCF7TTgc
         hobKxRYWdZMQt2/V5jzADR5cC4I0TLI/gQ8FDAxNqZ02CoxGqx39N+GOflwX9hPkfD
         pFK3IWx2aLZmk+lMSDMqyxUHg+T7U3XXN57Z+j7bL1xxqlREQhqPVU8rhq66NVNTfi
         KRYakrWeVQ5M6XFvZqGg/wjSrZIhG8PcGmF/gmIVppWNcGUH6oh+taEbX4RHSHmVK3
         BFrlgliw26g3JlwrbwBJfLbGA0SgVaNcu1vo8pgYGM2Kiujk9ybT3ZnRW0dBrPOxd5
         VVAI5B4smOhPg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/7/2019 12:40 PM, Vidya Sagar wrote:
> On 5/3/2019 4:31 PM, Thierry Reding wrote:
>> On Wed, Apr 24, 2019 at 10:49:50AM +0530, Vidya Sagar wrote:
>>> Export pcie_pme_disable_msi() & pcie_pme_no_msi() APIs to enable driver=
s
>>> using this API be able to build as loadable modules.
>>>
>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>> ---
>>> Changes from [v4]:
>>> * None
>>>
>>> Changes from [v3]:
>>> * None
>>>
>>> Changes from [v2]:
>>> * Exported pcie_pme_no_msi() API after making pcie_pme_msi_disabled a s=
tatic
>>>
>>> Changes from [v1]:
>>> * This is a new patch in v2 series
>>>
>>> =A0 drivers/pci/pcie/pme.c=A0=A0=A0=A0 | 14 +++++++++++++-
>>> =A0 drivers/pci/pcie/portdrv.h | 16 +++-------------
>>> =A0 2 files changed, 16 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
>>> index 54d593d10396..d5e0ea4a62fc 100644
>>> --- a/drivers/pci/pcie/pme.c
>>> +++ b/drivers/pci/pcie/pme.c
>>> @@ -25,7 +25,19 @@
>>> =A0=A0 * that using MSI for PCIe PME signaling doesn't play well with P=
CIe PME-based
>>> =A0=A0 * wake-up from system sleep states.
>>> =A0=A0 */
>>> -bool pcie_pme_msi_disabled;
>>> +static bool pcie_pme_msi_disabled;
>>> +
>>> +void pcie_pme_disable_msi(void)
>>> +{
>>> +=A0=A0=A0 pcie_pme_msi_disabled =3D true;
>>> +}
>>> +EXPORT_SYMBOL_GPL(pcie_pme_disable_msi);
>>> +
>>> +bool pcie_pme_no_msi(void)
>>> +{
>>> +=A0=A0=A0 return pcie_pme_msi_disabled;
>>> +}
>>> +EXPORT_SYMBOL_GPL(pcie_pme_no_msi);
>>> =A0 static int __init pcie_pme_setup(char *str)
>>> =A0 {
>>> diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
>>> index 1d50dc58ac40..7c8c3da4bd58 100644
>>> --- a/drivers/pci/pcie/portdrv.h
>>> +++ b/drivers/pci/pcie/portdrv.h
>>> @@ -125,22 +125,12 @@ void pcie_port_bus_unregister(void);
>>> =A0 struct pci_dev;
>>> =A0 #ifdef CONFIG_PCIE_PME
>>> -extern bool pcie_pme_msi_disabled;
>>> -
>>> -static inline void pcie_pme_disable_msi(void)
>>> -{
>>> -=A0=A0=A0 pcie_pme_msi_disabled =3D true;
>>> -}
>>> -
>>> -static inline bool pcie_pme_no_msi(void)
>>> -{
>>> -=A0=A0=A0 return pcie_pme_msi_disabled;
>>> -}
>>> -
>>> +void pcie_pme_disable_msi(void);
>>> +bool pcie_pme_no_msi(void);
>>> =A0 void pcie_pme_interrupt_enable(struct pci_dev *dev, bool enable);
>>> =A0 #else /* !CONFIG_PCIE_PME */
>>> =A0 static inline void pcie_pme_disable_msi(void) {}
>>> -static inline bool pcie_pme_no_msi(void) { return false; }
>>> +static inline bool pcie_pme_no_msi(void) {}
>>
>> This looks wrong.
> Can you please give more info on what is wrong in this?
Is missing "return false;" the wrong here or there is more than just this?

>=20
>>
>> Thierry
>>
>=20

