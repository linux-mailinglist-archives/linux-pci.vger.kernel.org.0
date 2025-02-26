Return-Path: <linux-pci+bounces-22521-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 369F9A474FD
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 06:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C47816F8A1
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 05:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C498F1F5831;
	Thu, 27 Feb 2025 05:00:03 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616041EB5C6
	for <linux-pci@vger.kernel.org>; Thu, 27 Feb 2025 05:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740632403; cv=none; b=dC4zFEyU3syy2gSZtc032t4PEvPOcB9RX1T/4+Bb5HB7yIQd4XmqhyKajuecEZ4CiU7B7bGmBOFT68fyOohifcF2exNmloPX3dzWvMyooddqcpcS7yh1FFJXmyAwQoXGRiVuKLF2E372bqmc6ptp/ezs/Q73eeBNY3/pBlTiSj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740632403; c=relaxed/simple;
	bh=9wKlRlfh6+hqaiNsar4uUlJBFTr/ICWvyAUWcrw+Tm4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=rxMYv9tPngAWAZkoPjsnRwUiuEpCVS1HdQPu9fgGHQPD26vrYD/yl/tBY3Hm6xaIW+ZJw+1EgOPdXszbqXyCUyEq73WgoG+nqGZxZavT4voSxZokH0bD5LpK+r9kyXc9xMdRMDHd82jGgSGIj9zhpsrc6NyXDk0kWPfIEYMFe48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1740632384-086e23601915ff00001-0c9NHn
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx1.zhaoxin.com with ESMTP id D1GWUQnXWUTW6gOV (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Thu, 27 Feb 2025 12:59:44 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXSHMBX2.zhaoxin.com (10.28.252.164) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Thu, 27 Feb
 2025 12:59:44 +0800
Received: from ZXSHMBX2.zhaoxin.com ([fe80::4dfc:4f6a:c0cf:4298]) by
 ZXSHMBX2.zhaoxin.com ([fe80::4dfc:4f6a:c0cf:4298%4]) with mapi id
 15.01.2507.044; Thu, 27 Feb 2025 12:59:44 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from [10.32.64.4] (10.32.64.4) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Wed, 26 Feb
 2025 17:40:02 +0800
Message-ID: <ab631e27-ee35-47b9-879b-2b8d6a245512@zhaoxin.com>
Date: Wed, 26 Feb 2025 17:39:48 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: LeoLiu-oc <leoliu-oc@zhaoxin.com>
Subject: Re: [PATCH v4 1/3] ACPI/APEI: Add hest_parse_pcie_aer()
To: Yazen Ghannam <yazen.ghannam@amd.com>
X-ASG-Orig-Subj: Re: [PATCH v4 1/3] ACPI/APEI: Add hest_parse_pcie_aer()
CC: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <bhelgaas@google.com>,
	<robert.moore@intel.com>, <avadhut.naik@amd.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<CobeChen@zhaoxin.com>, <TonyWWang@zhaoxin.com>, <ErosZhang@zhaoxin.com>
References: <20241205114048.60291-1-LeoLiu-oc@zhaoxin.com>
 <20241205114048.60291-2-LeoLiu-oc@zhaoxin.com>
 <20241211192048.GA1960478@yaz-khff2.amd.com>
In-Reply-To: <20241211192048.GA1960478@yaz-khff2.amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Moderation-Data: 2/27/2025 12:59:43 PM
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1740632384
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 6440
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.137764
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------



=E5=9C=A8 2024/12/12 3:20, Yazen Ghannam =E5=86=99=E9=81=93:
>=20
>=20
> [=E8=BF=99=E5=B0=81=E9=82=AE=E4=BB=B6=E6=9D=A5=E8=87=AA=E5=A4=96=E9=83=A8=
=E5=8F=91=E4=BB=B6=E4=BA=BA =E8=B0=A8=E9=98=B2=E9=A3=8E=E9=99=A9]
>=20
> On Thu, Dec 05, 2024 at 07:40:46PM +0800, LeoLiu-oc wrote:
>> From: LeoLiuoc <LeoLiu-oc@zhaoxin.com>
>>
>> The purpose of the function apei_hest_parse_aer() is used to parse and
>> extract register value from HEST PCIe AER structures. This applies to
>> all hardware platforms that has a PCI Express AER structure in HEST.
>>
>> Signed-off-by: LeoLiuoc <LeoLiu-oc@zhaoxin.com>
>> ---
>>   drivers/acpi/apei/hest.c | 77 ++++++++++++++++++++++++++++++++++++++--
>>   include/acpi/apei.h      | 17 +++++++++
>>   2 files changed, 92 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
>> index 20d757687e3d..13075f5aea25 100644
>> --- a/drivers/acpi/apei/hest.c
>> +++ b/drivers/acpi/apei/hest.c
>> @@ -22,6 +22,7 @@
>>   #include <linux/kdebug.h>
>>   #include <linux/highmem.h>
>>   #include <linux/io.h>
>> +#include <linux/pci.h>
>>   #include <linux/platform_device.h>
>>   #include <acpi/apei.h>
>>   #include <acpi/ghes.h>
>> @@ -132,9 +133,81 @@ static bool is_ghes_assist_struct(struct acpi_hest_=
header *hest_hdr)
>>        return false;
>>   }
>>
>> -typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void=
 *data);
>> +#ifdef CONFIG_ACPI_APEI
>=20
> Why is this needed? The entire hest.c file is only built if
> CONFIG_ACPI_APEI is enabled.
>=20
I agree with your point.

>> +static bool hest_match_pci_devfn(struct acpi_hest_aer_common *p,
>> +                              struct pci_dev *dev)
>> +{
>> +     return ACPI_HEST_SEGMENT(p->bus) =3D=3D pci_domain_nr(dev->bus) &&
>> +            ACPI_HEST_BUS(p->bus) =3D=3D dev->bus->number &&
>> +            p->device =3D=3D PCI_SLOT(dev->devfn) &&
>> +            p->function =3D=3D PCI_FUNC(dev->devfn);
>=20
> It may be nice to align all these lines on the "=3D=3D".
>=20
Okay, I will make the changes in the next version

>> +}
>> +
>> +static bool hest_source_is_pcie_aer(struct acpi_hest_header *hest_hdr,
>> +                                 struct pci_dev *dev)
>> +{
>> +     u16 hest_type =3D hest_hdr->type;
>> +     u8 pcie_type =3D pci_pcie_type(dev);
>> +     struct acpi_hest_aer_common *common;
>> +
>> +     common =3D (struct acpi_hest_aer_common *)(hest_hdr + 1);
>> +
>> +     switch (hest_type) {
>> +     case ACPI_HEST_TYPE_AER_ROOT_PORT:
>> +             if (pcie_type !=3D PCI_EXP_TYPE_ROOT_PORT)
>> +                     return false;
>> +     break;
>=20
> The breaks should be indented to the "if". Same for the rest of the
> file.
>=20
I agree with your point of view and will make modifications in the next=20
version.

>> +     case ACPI_HEST_TYPE_AER_ENDPOINT:
>> +             if (pcie_type !=3D PCI_EXP_TYPE_ENDPOINT)
>> +                     return false;
>> +     break;
>> +     case ACPI_HEST_TYPE_AER_BRIDGE:
>> +             if (pcie_type !=3D PCI_EXP_TYPE_PCI_BRIDGE &&
>> +                 pcie_type !=3D PCI_EXP_TYPE_PCIE_BRIDGE)
>> +                     return false;
>> +     break;
>> +     default:
>> +             return false;
>> +     break;
>> +     }
>> +
>> +     if (common->flags & ACPI_HEST_GLOBAL)
>> +             return true;
>> +
>> +     if (hest_match_pci_devfn(common, dev))
>> +             return true;
>> +
>> +     return false;
>> +}
>> +
>> +int hest_parse_pcie_aer(struct acpi_hest_header *hest_hdr, void *data)
>> +{
>> +     struct hest_parse_aer_info *info =3D data;
>> +
>> +     if (!hest_source_is_pcie_aer(hest_hdr, info->pci_dev))
>> +             return 0;
>> +
>> +     switch (hest_hdr->type) {
>> +     case ACPI_HEST_TYPE_AER_ROOT_PORT:
>> +             info->hest_aer_root_port =3D (struct acpi_hest_aer_root *)=
hest_hdr;
>> +             return 1;
>> +     break;
>> +     case ACPI_HEST_TYPE_AER_ENDPOINT:
>> +             info->hest_aer_endpoint =3D (struct acpi_hest_aer *)hest_h=
dr;
>> +             return 1;
>> +     break;
>> +     case ACPI_HEST_TYPE_AER_BRIDGE:
>> +             info->hest_aer_bridge =3D (struct acpi_hest_aer_bridge *)h=
est_hdr;
>> +             return 1;
>> +     break;
>> +     default:
>> +             return 0;
>> +     break;
>> +     }
>> +}
>> +#endif
>>
>> -static int apei_hest_parse(apei_hest_func_t func, void *data)
>> +int apei_hest_parse(apei_hest_func_t func, void *data)
>>   {
>>        struct acpi_hest_header *hest_hdr;
>>        int i, rc, len;
>> diff --git a/include/acpi/apei.h b/include/acpi/apei.h
>> index dc60f7db5524..82d3cdf53e22 100644
>> --- a/include/acpi/apei.h
>> +++ b/include/acpi/apei.h
>> @@ -23,6 +23,15 @@ enum hest_status {
>>        HEST_NOT_FOUND,
>>   };
>>
>> +#ifdef CONFIG_ACPI_APEI
>> +struct hest_parse_aer_info {
>> +     struct pci_dev *pci_dev;
>> +     struct acpi_hest_aer *hest_aer_endpoint;
>> +     struct acpi_hest_aer_root *hest_aer_root_port;
>> +     struct acpi_hest_aer_bridge *hest_aer_bridge;
>=20
> These three pointers are mutually exclusive. Can you save just one
> pointer and then cast it when checking the "port_type" in patch 3?
>=20
>> +};
>> +#endif
>=20
> I think the #ifdef is not needed, because this is not declaring an
> instance of the struct.
>=20
I agree with your point of view and will make modifications in the next=20
version.

>> +
>>   extern int hest_disable;
>>   extern int erst_disable;
>>   #ifdef CONFIG_ACPI_APEI_GHES
>> @@ -33,10 +42,18 @@ void __init acpi_ghes_init(void);
>>   static inline void acpi_ghes_init(void) { }
>>   #endif
>>
>> +typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void=
 *data);
>> +int apei_hest_parse(apei_hest_func_t func, void *data);
>> +
>=20
> Minor nit: this could be done as a separate patch.
>=20
> Patch 1: Move apei_hest_parse() to apei.h
> Patch 2: Add new hest_parse_pcie_aer()
>=20
Ok, your suggestion is very reasonable, I will modify it in the next=20
version.

Leoliu-oc
Best Regards

>>   #ifdef CONFIG_ACPI_APEI
>>   void __init acpi_hest_init(void);
>> +int hest_parse_pcie_aer(struct acpi_hest_header *hest_hdr, void *data);
>>   #else
>>   static inline void acpi_hest_init(void) { }
>> +static inline int hest_parse_pcie_aer(struct acpi_hest_header *hest_hdr=
, void *data)
>> +{
>> +     return 0;
>> +}
>>   #endif
>>
>>   int erst_write(const struct cper_record_header *record);
>> --
>=20
> Thanks,
> Yazen


