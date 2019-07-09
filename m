Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA17163715
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2019 15:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbfGINi5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jul 2019 09:38:57 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:19608 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfGINi5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jul 2019 09:38:57 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d2498ea0000>; Tue, 09 Jul 2019 06:38:50 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 09 Jul 2019 06:38:55 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 09 Jul 2019 06:38:55 -0700
Received: from [10.25.74.15] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Jul
 2019 13:38:49 +0000
Subject: Re: [PATCH V12 01/12] PCI: Add #defines for some of PCIe spec r4.0
 features
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>
CC:     <lorenzo.pieralisi@arm.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <kishon@ti.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>, <digetx@gmail.com>,
        <mperttunen@nvidia.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20190701124010.7484-1-vidyas@nvidia.com>
 <20190701124010.7484-2-vidyas@nvidia.com>
 <66d8af45-66f5-b597-0ea8-39e8662df5e6@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <841a79fa-24ff-8710-456a-44f081230d8f@nvidia.com>
Date:   Tue, 9 Jul 2019 19:08:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <66d8af45-66f5-b597-0ea8-39e8662df5e6@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1562679530; bh=eH8RfLaPI82FgFhlZTVX588/yBLz0+QCElzGkG7NYFc=;
        h=X-PGP-Universal:Subject:From:To:CC:References:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=aCct5UmybzIIUCobuk1bacIiVcdUMSfBvPPs7i603WYBHXMYK+4IPlmmklNl7qZW8
         xLnxYlBQa4UBG/2FKpWDlz8D4jiAfMEnvmFnl5WkXgbe5xE+Snh4SuwMvnIJ9CJMZT
         HBj+K8d/0O1SSvA796hdO8+UqNh7hpJn7lhDdJetHlY2gdwCpwxW7WLctV7sXbK0+T
         vK1vnceH9Ry6QqWgPZjC57doyvrHAB74TjvW7+dnEykgmD6G361G962nCAZ1VVT01m
         rZGE+4HWfy/0t3O/WuiE2HYqs0PdFkpX5Nu4n9mOzKm7b8UGMbf4+GPpAwCvYgmePr
         LpD7zNfpQEfDQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/5/2019 7:16 PM, Vidya Sagar wrote:
Bjorn,
Apologies for pinging again about this.
Can you please provide Ack for this change so that Lorenzo can pick up this=
 series?

Thanks,
Vidya Sagar

> On 7/1/2019 6:09 PM, Vidya Sagar wrote:
> Bjorn,
> Can you please provide Ack for this patch?
>=20
> Thanks,
> Vidya Sagar
>=20
>> Add #defines only for the Data Link Feature and Physical Layer 16.0 GT/s
>> features.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> Reviewed-by: Thierry Reding <treding@nvidia.com>
>> ---
>> Changes since [v11]:
>> * None
>>
>> Changes since [v10]:
>> * None
>>
>> Changes since [v9]:
>> * None
>>
>> Changes since [v8]:
>> * None
>>
>> Changes since [v7]:
>> * None
>>
>> Changes since [v6]:
>> * None
>>
>> Changes since [v5]:
>> * None
>>
>> Changes since [v4]:
>> * None
>>
>> Changes since [v3]:
>> * None
>>
>> Changes since [v2]:
>> * Updated commit message and description to explicitly mention that defi=
nes are
>> =C2=A0=C2=A0 added only for some of the features and not all.
>>
>> Changes since [v1]:
>> * None
>>
>> =C2=A0 include/uapi/linux/pci_regs.h | 22 +++++++++++++++++++++-
>> =C2=A0 1 file changed, 21 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs=
.h
>> index f28e562d7ca8..1c79f6a097d2 100644
>> --- a/include/uapi/linux/pci_regs.h
>> +++ b/include/uapi/linux/pci_regs.h
>> @@ -713,7 +713,9 @@
>> =C2=A0 #define PCI_EXT_CAP_ID_DPC=C2=A0=C2=A0=C2=A0 0x1D=C2=A0=C2=A0=C2=
=A0 /* Downstream Port Containment */
>> =C2=A0 #define PCI_EXT_CAP_ID_L1SS=C2=A0=C2=A0=C2=A0 0x1E=C2=A0=C2=A0=C2=
=A0 /* L1 PM Substates */
>> =C2=A0 #define PCI_EXT_CAP_ID_PTM=C2=A0=C2=A0=C2=A0 0x1F=C2=A0=C2=A0=C2=
=A0 /* Precision Time Measurement */
>> -#define PCI_EXT_CAP_ID_MAX=C2=A0=C2=A0=C2=A0 PCI_EXT_CAP_ID_PTM
>> +#define PCI_EXT_CAP_ID_DLF=C2=A0=C2=A0=C2=A0 0x25=C2=A0=C2=A0=C2=A0 /* =
Data Link Feature */
>> +#define PCI_EXT_CAP_ID_PL=C2=A0=C2=A0=C2=A0 0x26=C2=A0=C2=A0=C2=A0 /* P=
hysical Layer 16.0 GT/s */
>> +#define PCI_EXT_CAP_ID_MAX=C2=A0=C2=A0=C2=A0 PCI_EXT_CAP_ID_PL
>> =C2=A0 #define PCI_EXT_CAP_DSN_SIZEOF=C2=A0=C2=A0=C2=A0 12
>> =C2=A0 #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
>> @@ -1053,4 +1055,22 @@
>> =C2=A0 #define=C2=A0 PCI_L1SS_CTL1_LTR_L12_TH_SCALE=C2=A0=C2=A0=C2=A0 0x=
e0000000=C2=A0 /* LTR_L1.2_THRESHOLD_Scale */
>> =C2=A0 #define PCI_L1SS_CTL2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=
x0c=C2=A0=C2=A0=C2=A0 /* Control 2 Register */
>> +/* Data Link Feature */
>> +#define PCI_DLF_CAP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x04=C2=
=A0=C2=A0=C2=A0 /* Capabilities Register */
>> +#define=C2=A0 PCI_DLF_LOCAL_DLF_SUP_MASK=C2=A0=C2=A0=C2=A0 0x007fffff=
=C2=A0 /* Local Data Link Feature Supported */
>> +#define=C2=A0 PCI_DLF_EXCHANGE_ENABLE=C2=A0=C2=A0=C2=A0 0x80000000=C2=
=A0 /* Data Link Feature Exchange Enable */
>> +#define PCI_DLF_STS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x08=C2=
=A0=C2=A0=C2=A0 /* Status Register */
>> +#define=C2=A0 PCI_DLF_REMOTE_DLF_SUP_MASK=C2=A0=C2=A0=C2=A0 0x007fffff=
=C2=A0 /* Remote Data Link Feature Supported */
>> +#define=C2=A0 PCI_DLF_REMOTE_DLF_SUP_VALID=C2=A0=C2=A0=C2=A0 0x80000000=
=C2=A0 /* Remote Data Link Feature Support Valid */
>> +
>> +/* Physical Layer 16.0 GT/s */
>> +#define PCI_PL_16GT_CAP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x04=
=C2=A0=C2=A0=C2=A0 /* Capabilities Register */
>> +#define PCI_PL_16GT_CTRL=C2=A0=C2=A0=C2=A0 0x08=C2=A0=C2=A0=C2=A0 /* Co=
ntrol Register */
>> +#define PCI_PL_16GT_STS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0c=
=C2=A0=C2=A0=C2=A0 /* Status Register */
>> +#define PCI_PL_16GT_LDPM_STS=C2=A0=C2=A0=C2=A0 0x10=C2=A0=C2=A0=C2=A0 /=
* Local Data Parity Mismatch Status Register */
>> +#define PCI_PL_16GT_FRDPM_STS=C2=A0=C2=A0=C2=A0 0x14=C2=A0=C2=A0=C2=A0 =
/* First Retimer Data Parity Mismatch Status Register */
>> +#define PCI_PL_16GT_SRDPM_STS=C2=A0=C2=A0=C2=A0 0x18=C2=A0=C2=A0=C2=A0 =
/* Second Retimer Data Parity Mismatch Status Register */
>> +#define PCI_PL_16GT_RSVD=C2=A0=C2=A0=C2=A0 0x1C=C2=A0=C2=A0=C2=A0 /* Re=
served */
>> +#define PCI_PL_16GT_LE_CTRL=C2=A0=C2=A0=C2=A0 0x20=C2=A0=C2=A0=C2=A0 /*=
 Lane Equalization Control Register */
>> +
>> =C2=A0 #endif /* LINUX_PCI_REGS_H */
>>
>=20

