Return-Path: <linux-pci+bounces-22483-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7E5A4708E
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 01:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEF071887967
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 00:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E05270042;
	Thu, 27 Feb 2025 00:53:41 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBECB2B9B7
	for <linux-pci@vger.kernel.org>; Thu, 27 Feb 2025 00:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740617621; cv=none; b=MfRyqNczeGkpEVmQN0IpCqoioW8TQGbJmx3C94UfCzVxQJuSbIq/D9n4UPVPlFGpBneQ9JOOGRKqBnQ2u0kjfudV9R2/VtwkoIF0P1Oumd3HDDaEBZbtCGtWcTjTOpZTTvuAdrzFei2MKsmVH7jGgJSZyy+0iERnwgrEAozNWOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740617621; c=relaxed/simple;
	bh=FIiVtcNHJYrmZ+Yz2YVjUiAkhpAPHWrX1l2qB64oxFE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=kRcT8ppdthPS6vq1McwfjY5BJwwSnH00zqQ53VCWIefF3FFMBHpd03ftnxAXI2HmniIFMslRbOH4IJvDnND5urKcT76Z1zSNEw+cmlIdRusH1TkHOmr++86Dlx2ATkEwHM812Coq3nwrU3qCdusPKNwqxRgwMXNMVeL0dXfqykg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1740617616-086e23601815e460001-0c9NHn
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx1.zhaoxin.com with ESMTP id 8yvCXWFBLrBPZIwW (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Thu, 27 Feb 2025 08:53:36 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXSHMBX2.zhaoxin.com (10.28.252.164) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Thu, 27 Feb
 2025 08:38:34 +0800
Received: from ZXSHMBX2.zhaoxin.com ([fe80::4dfc:4f6a:c0cf:4298]) by
 ZXSHMBX2.zhaoxin.com ([fe80::4dfc:4f6a:c0cf:4298%4]) with mapi id
 15.01.2507.044; Thu, 27 Feb 2025 08:38:34 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from [10.32.64.4] (10.32.64.4) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Wed, 26 Feb
 2025 17:41:12 +0800
Message-ID: <1cb4d7de-ee6d-4ce7-bb4a-86ef5a986dba@zhaoxin.com>
Date: Wed, 26 Feb 2025 17:41:10 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: LeoLiu-oc <leoliu-oc@zhaoxin.com>
Subject: Re: [PATCH v4 3/3] PCI/ACPI: Add pci_acpi_program_hest_aer_params()
To: Yazen Ghannam <yazen.ghannam@amd.com>
X-ASG-Orig-Subj: Re: [PATCH v4 3/3] PCI/ACPI: Add pci_acpi_program_hest_aer_params()
CC: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <bhelgaas@google.com>,
	<robert.moore@intel.com>, <avadhut.naik@amd.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<CobeChen@zhaoxin.com>, <TonyWWang@zhaoxin.com>, <ErosZhang@zhaoxin.com>
References: <20241205114048.60291-1-LeoLiu-oc@zhaoxin.com>
 <20241205114048.60291-4-LeoLiu-oc@zhaoxin.com>
 <20241211194735.GB1960478@yaz-khff2.amd.com>
In-Reply-To: <20241211194735.GB1960478@yaz-khff2.amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Moderation-Data: 2/27/2025 8:38:32 AM
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1740617616
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 7645
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -1.52
X-Barracuda-Spam-Status: No, SCORE=-1.52 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=BSF_SC0_SA983
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.137757
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.50 BSF_SC0_SA983          Custom Rule BSF_SC0_SA983



=E5=9C=A8 2024/12/12 3:47, Yazen Ghannam =E5=86=99=E9=81=93:
>=20
>=20
> [=E8=BF=99=E5=B0=81=E9=82=AE=E4=BB=B6=E6=9D=A5=E8=87=AA=E5=A4=96=E9=83=A8=
=E5=8F=91=E4=BB=B6=E4=BA=BA =E8=B0=A8=E9=98=B2=E9=A3=8E=E9=99=A9]
>=20
> On Thu, Dec 05, 2024 at 07:40:48PM +0800, LeoLiu-oc wrote:
>> From: LeoLiuoc <LeoLiu-oc@zhaoxin.com>
>>
>> Call the func pci_acpi_program_hest_aer_params() for every PCIe device,
>> the purpose of this function is to extract register value from HEST PCIe
>> AER structures and program them into AER Capabilities. This function
>> applies to all hardware platforms that has a PCI Express AER structure
>> in HEST.
>>
>> Signed-off-by: LeoLiuoc <LeoLiu-oc@zhaoxin.com>
>> ---
>>   drivers/pci/pci-acpi.c | 103 +++++++++++++++++++++++++++++++++++++++++
>>   drivers/pci/pci.h      |   9 ++++
>>   drivers/pci/probe.c    |   1 +
>>   3 files changed, 113 insertions(+)
>>
>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>> index af370628e583..6e29af8e6cc4 100644
>> --- a/drivers/pci/pci-acpi.c
>> +++ b/drivers/pci/pci-acpi.c
>> @@ -19,6 +19,7 @@
>>   #include <linux/pm_runtime.h>
>>   #include <linux/pm_qos.h>
>>   #include <linux/rwsem.h>
>> +#include <acpi/apei.h>
>>   #include "pci.h"
>>
>>   /*
>> @@ -806,6 +807,108 @@ int pci_acpi_program_hp_params(struct pci_dev *dev=
)
>>        return -ENODEV;
>>   }
>>
>> +#ifdef CONFIG_ACPI_APEI
>> +/*
>> + * program_hest_aer_common() - configure AER common registers for Root =
Ports,
>> + * Endpoints and PCIe to PCI/PCI-X bridges
>> + */
>> +static void program_hest_aer_common(struct acpi_hest_aer_common aer_com=
mon,
>> +                                 struct pci_dev *dev, int pos)
>> +{
>> +     u32 uncor_mask;
>> +     u32 uncor_severity;
>> +     u32 cor_mask;
>> +     u32 adv_cap;
>> +
>> +     uncor_mask =3D aer_common.uncorrectable_mask;
>> +     uncor_severity =3D aer_common.uncorrectable_severity;
>> +     cor_mask =3D aer_common.correctable_mask;
>> +     adv_cap =3D aer_common.advanced_capabilities;
>> +
>=20
> These can be done at the same time as the declarations. Same for the
> remaining functions.
>=20
These functions are called only in this pci-acpi.c file and should not=20
require additional declarations.

>> +     pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, uncor_mask);
>> +     pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, uncor_sever=
ity);
>> +     pci_write_config_dword(dev, pos + PCI_ERR_COR_MASK, cor_mask);
>> +     pci_write_config_dword(dev, pos + PCI_ERR_CAP, adv_cap);
>> +}
>> +
>> +static void program_hest_aer_root(struct acpi_hest_aer_root *aer_root,
>> +                               struct pci_dev *dev, int pos)
>> +{
>> +     u32 root_err_cmd;
>> +
>> +     root_err_cmd =3D aer_root->root_error_command;
>> +
>> +     pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, root_err_c=
md);
>> +}
>> +
>> +static void program_hest_aer_bridge(struct acpi_hest_aer_bridge *hest_a=
er_bridge,
>> +                                 struct pci_dev *dev, int pos)
>> +{
>> +     u32 uncor_mask2;
>> +     u32 uncor_severity2;
>> +     u32 adv_cap2;
>> +
>> +     uncor_mask2 =3D hest_aer_bridge->uncorrectable_mask2;
>> +     uncor_severity2 =3D hest_aer_bridge->uncorrectable_severity2;
>> +     adv_cap2 =3D hest_aer_bridge->advanced_capabilities2;
>> +
>> +     pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_MASK2, uncor_mask2=
);
>> +     pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER2, uncor_seve=
rity2);
>> +     pci_write_config_dword(dev, pos + PCI_ERR_CAP2, adv_cap2);
>> +}
>> +
>> +static void program_hest_aer_params(struct hest_parse_aer_info info)
>> +{
>> +     struct pci_dev *dev;
>> +     int port_type;
>> +     int pos;
>> +     struct acpi_hest_aer_root *hest_aer_root;
>> +     struct acpi_hest_aer *hest_aer_endpoint;
>> +     struct acpi_hest_aer_bridge *hest_aer_bridge;
>> +
>> +     dev =3D info.pci_dev;
>> +     port_type =3D pci_pcie_type(dev);
>> +     pos =3D pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
>> +     if (!pos)
>> +             return;
>> +
>> +     switch (port_type) {
>> +     case PCI_EXP_TYPE_ROOT_PORT:
>> +             hest_aer_root =3D info.hest_aer_root_port;
>> +             program_hest_aer_common(hest_aer_root->aer, dev, pos);
>> +             program_hest_aer_root(hest_aer_root, dev, pos);
>> +     break;
>> +     case PCI_EXP_TYPE_ENDPOINT:
>> +             hest_aer_endpoint =3D info.hest_aer_endpoint;
>> +             program_hest_aer_common(hest_aer_endpoint->aer, dev, pos);
>> +     break;
>> +     case PCI_EXP_TYPE_PCI_BRIDGE:
>> +             hest_aer_bridge =3D info.hest_aer_bridge;
>> +             program_hest_aer_common(hest_aer_bridge->aer, dev, pos);
>> +             program_hest_aer_bridge(hest_aer_bridge, dev, pos);
>> +     break;
>> +     default:
>> +             return;
>> +     break;
>> +     }
>> +}
>> +
>> +int pci_acpi_program_hest_aer_params(struct pci_dev *dev)
>> +{
>> +     struct hest_parse_aer_info info =3D {
>> +             .pci_dev =3D dev
>> +     };
>> +
>> +     if (!pci_is_pcie(dev))
>> +             return -ENODEV;
>> +
>> +     if (apei_hest_parse(hest_parse_pcie_aer, &info) =3D=3D 1)
>=20
> Don't need the "=3D=3D 1".
>=20
The apei_hest_parse function may return an error value, data are written=20
to the aer registers only if the device in hest_parse_pcie_aer() matches=20
the correct hest aer structure information. It is necessary to check=20
whether the return value of the apei_hest_parse function is equal to 1.

>> +             program_hest_aer_params(info);
>> +
>> +     return 0;
>> +}
>> +#endif
>> +
>>   /**
>>    * pciehp_is_native - Check whether a hotplug port is handled by the O=
S
>>    * @bridge: Hotplug port to check
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 2e40fc63ba31..78bdc121c905 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -897,6 +897,15 @@ static inline void pci_save_aer_state(struct pci_de=
v *dev) { }
>>   static inline void pci_restore_aer_state(struct pci_dev *dev) { }
>>   #endif
>>
>> +#ifdef CONFIG_ACPI_APEI
>> +int pci_acpi_program_hest_aer_params(struct pci_dev *dev);
>=20
> The return value is never checked, so this can return void.
>=20
Ok, I agree with you, I will modify it in the next version.

>> +#else
>> +static inline int pci_acpi_program_hest_aer_params(struct pci_dev *dev)
>> +{
>> +     return 0;
>> +}
>> +#endif
>> +
>>   #ifdef CONFIG_ACPI
>>   bool pci_acpi_preserve_config(struct pci_host_bridge *bridge);
>>   int pci_acpi_program_hp_params(struct pci_dev *dev);
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 2e81ab0f5a25..33b8b46ca554 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -2304,6 +2304,7 @@ static void pci_configure_device(struct pci_dev *d=
ev)
>>        pci_configure_serr(dev);
>>
>>        pci_acpi_program_hp_params(dev);
>> +     pci_acpi_program_hest_aer_params(dev);
>=20
> This should not be called here unconditionally.
>=20
> OS should only write AER registers if granted permission through
> _OSC.
>=20
> It would be more appropriate to call this from pci_aer_init().
>=20
> Thanks,
> Yazen
The question about whether OS has control of AER to write the=20
information in the HEST AER structure to the AER register of the=20
corresponding device has been discussed, see the link for more details:=20
https://lore.kernel.org/all/a3a603ef-b813-4798-bb54-62076d53bd3a@zhaoxin.co=
m/

It is inappropriate to add the pci_acpi_program_hest_aer_params function=20
to the pci_aer_init function=EF=BC=8CThe reason for this is that no involve=
ment=20
of the AER driver.

Leoliu-oc
Best Regards


