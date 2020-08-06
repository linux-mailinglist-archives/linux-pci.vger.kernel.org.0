Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D5B23E41F
	for <lists+linux-pci@lfdr.de>; Fri,  7 Aug 2020 00:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgHFWkt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Aug 2020 18:40:49 -0400
Received: from mail-eopbgr770090.outbound.protection.outlook.com ([40.107.77.90]:42782
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725927AbgHFWks (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Aug 2020 18:40:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HxrxhyQ13l69M6lspIDYhLmWMcEjYT7DPKkl/47heEuxQnbdQISxjW+pN0otu5ryEQ3Y4I/cl3MluKpX2IRLWgKlY/gUK2j5Qhofv7HskaklKg6eRW+EtiHSGQsFPHcHgYZmbr53kpUd7BJP5CGIpmAKLGXmna3J/I/GMNffEoAaJB95yXjG3AnKpBU32k5TzsQ1Sy71qZEjBKjWFJ9yxmerV0NlXq2I/+btaiKidSOZMvsIJz3gAioLdSBmVLwnEBgwbJ17qgf7JZHbWGpktMPDRoYK7YN15FfNWIJqaMIPWg5f8VePzIfWPkI14AY/SW+VtPXtAkFK40otsMYchA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2KHaNfrghcvk5vvnQTVQ3Bfg0LhKfnpVYv9SfNhol8=;
 b=HhIN4MMuk4AwLxoA/QTeoXBmLxmdcNL09Tm+l/pCjYxiP3s3CCQe/FGnSS+zyPEPTbQVfxf0ozIUL4I3wUksLbtjLm5OoyynFAmpYSqRcaTHtLEb3VL0XPyQqb1/4JFOE5lyqxCGQPWq+mpyYUMipYowsNqUNpeuFHEr9L19qTGOzezudn/gX4tp06C6DFTxpZFFpgqAAfTXQj9dMYZuEzyr8Z8TgE23ytU2COY9vahT82OGlqE5i6hkXVAqXDbLgGSgz0xJ2yWe/NMIawtGW9peTzQ1++vJhxZ4tZK2crjKf5epQ9kbhTVdv+wOY9D3eXcuIj0teb/56KrEUF5/eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2KHaNfrghcvk5vvnQTVQ3Bfg0LhKfnpVYv9SfNhol8=;
 b=92tqIobShmb7lU94RGRp+nxwLlq0nrYNusPyH6HPkYbhWfWKdIxOCWasAsYjmVEsh8vuT+2xfZ8COZw7GsueZEFWSBdljAVMhiu4T3azlXrYu+L42sZaE2JsdtcKFtGK/nlMi9B9mdzpEvl3kW6Nn6wSyOPtdxrx5nfgUtN/6HQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=amperemail.onmicrosoft.com;
Received: from BYAPR01MB4598.prod.exchangelabs.com (2603:10b6:a03:8a::18) by
 BYAPR01MB5576.prod.exchangelabs.com (2603:10b6:a03:126::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.19; Thu, 6 Aug 2020 22:40:44 +0000
Received: from BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::5c26:c6ca:c444:e947]) by BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::5c26:c6ca:c444:e947%3]) with mapi id 15.20.3239.021; Thu, 6 Aug 2020
 22:40:44 +0000
Content-Type: text/plain;
        charset=utf-8
Subject: Re: [PATCH] PCI/ACPI: Add Ampere Altra SOC MCFG quirk
From:   Tuan Phan <tuanphan@amperemail.onmicrosoft.com>
In-Reply-To: <20200806222713.GA704188@bjorn-Precision-5520>
Date:   Thu, 6 Aug 2020 15:40:41 -0700
Cc:     Tuan Phan <tuanphan@os.amperecomputing.com>,
        patches@amperecomputing.com, Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0A228AB4-25C4-40D8-ABA1-CB9C774825B5@amperemail.onmicrosoft.com>
References: <20200806222713.GA704188@bjorn-Precision-5520>
To:     Bjorn Helgaas <helgaas@kernel.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-ClientProxiedBy: CY4PR08CA0040.namprd08.prod.outlook.com
 (2603:10b6:903:151::26) To BYAPR01MB4598.prod.exchangelabs.com
 (2603:10b6:a03:8a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.148] (73.151.56.145) by CY4PR08CA0040.namprd08.prod.outlook.com (2603:10b6:903:151::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18 via Frontend Transport; Thu, 6 Aug 2020 22:40:43 +0000
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Originating-IP: [73.151.56.145]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59f888b6-2db9-4054-77c1-08d83a59c144
X-MS-TrafficTypeDiagnostic: BYAPR01MB5576:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR01MB55768789713DEBA947FED19BE0480@BYAPR01MB5576.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NTqEJlY0IZJElRe87fPX0Syaa3pIDQxQLXgsQV+KMxPmVFnFjV6AZiKF8/Ai/Q7rdmceDBhpIQq1s8mrY49T/ncShuxLLhPZd/u6cCn/zvtFmUehSNqSfUvd2nblzZMesplhKEctT+VUomrEXIMQvjjPDssXwG8hPDgyGGqg0zSiE84qizarDToZqBxf3WCv8m5kkdBBirsc3S+LAU/RQ8JZMTHXfGJ9M8AcOmmnIElgrxn1GXxzfWNBEJyo/XnggUyGv/URMmwKcS67sYkN1NF+Lzpu2SD77xFg6/yeTP3F87n+nwCNDpsrqynmV355jdgAlMgXWVk4J+C9d2NYbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB4598.prod.exchangelabs.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39850400004)(346002)(396003)(376002)(136003)(366004)(53546011)(16576012)(316002)(83380400001)(478600001)(16526019)(42882007)(186003)(5660300002)(8676002)(66556008)(8936002)(6486002)(2616005)(956004)(4326008)(6916009)(26005)(66476007)(54906003)(33656002)(83170400001)(66946007)(52116002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: cGUX5HJ/cQrFfKXGGZDFtRHPJy+qg4V3/9s1JFMH+vRlH47aQt6zLugQkCIVkX9ItY3b6mZO+ne2x9/wENX18gC+kkcjm2pB+MoRMg2JY50if4Md4Ve48RFcsI33/+zb8Ywf2kWjKAUz4dJxQ2SXYy9PAf14NyMAF8XVhrd9kDlLIPaR3fFTpFE2z3lWp2SQY3OqkJvOy9udc7WlCaiGlaiQq9TEtoHA34u/HaDHMRXKw8XxSZUd4DdO3J/drkySdTHF8kt5524gWDkY8llOnfv8x1j6aFwsAr0nISnVe5RvYkN/GTEl79HtfNFcmKOra6YHpfhLCV7sqFGV+8YrtrVfF/UJXWCZJHXgDQQmicoPOpOFRPeEESz18z51ZdLqvPdBIFL0IAk+9vd2rVnJb9xZgbWnhbItbA1YrQCbCifJmUYR1k2VRDIwmyBrA12Oyv0X91pF2S3+UY8sJogWeM8av4GdQmNcgkg69d9qfBw3BWhXIVvnEvuud3bX9HOY4SCYIOztiX14dRBef9J+6nczDk4D5I5qVQT8+smYWpQnC5xZxOqY5Td3MVosHglDwy5R9Y4rQERoGSM4097R4L3I2g92Q55jbGN5jFinqeSQAptyxSdNi8/2wm8/6xD4qb517is9YU5bm7xW7l3Img==
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59f888b6-2db9-4054-77c1-08d83a59c144
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB4598.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2020 22:40:44.4993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SjFzpDPUR0JntYFKI0IQPjUY58QxYA7o+fvSIMVMY8V4VkafG3oEwVUPAKQ+byr3hKQbT7uvHuRppKiRpjzLl4lvbuN4gEFz/9sDYdaquFzGHtGSqqYnwiczQlh3IKSd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB5576
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


> On Aug 6, 2020, at 3:27 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>=20
> On Thu, Aug 06, 2020 at 02:57:34PM -0700, Tuan Phan wrote:
>> Ampere Altra SOC supports only 32-bit ECAM reading. Therefore,
>> add an MCFG quirk for the platform.
>=20
> This is interesting.  So this host bridge supports sub 32-bit config
> *writes*, but not reads?
>=20
> I actually don't know whether that complies with the spec or not.  If
> config registers are not allowed to have side effects on read, this
> *would* be compliant.
>=20
> PCIe r5.0, sec 7.4, doesn't list any register types with read side
> effects, so there shouldn't be any in the registers defined by the
> spec.  But I would think device-specific registers could do whatever
> they wanted, e.g., reading an interrupt status register or something
> could clear it.
>=20
> And I think sec 7.2.2 about ECAM implicitly requires sub 32-bit
> accesses because it mentions the access size and byte enables.
>=20
> Is this a one-off situation where future hardware will allow sub
> 32-bit reads and writes?  We don't want a stream of quirks for future
> devices.

Hi Bjorn,

Actually, this is a silicon bug inside current Altra Soc. Our SOC supports
sub 32-bit reads and writes. But using byte read for some devices like AMD =
graphic
card causing corrupted data due to host controller HW errata.

Future devices will have this issue fixed so this quirk applies only for cu=
rrent Altra
Soc.

So you think I can drop the =E2=80=9Cnon-compliant=E2=80=9D as there are no=
 read side effects
for all registers?

>=20
>> Signed-off-by: Tuan Phan <tuanphan@os.amperecomputing.com>
>> ---
>> drivers/acpi/pci_mcfg.c  | 20 ++++++++++++++++++++
>> drivers/pci/ecam.c       | 10 ++++++++++
>> include/linux/pci-ecam.h |  1 +
>> 3 files changed, 31 insertions(+)
>>=20
>> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
>> index 54b36b7ad47d..e526571e0ebd 100644
>> --- a/drivers/acpi/pci_mcfg.c
>> +++ b/drivers/acpi/pci_mcfg.c
>> @@ -142,6 +142,26 @@ static struct mcfg_fixup mcfg_quirks[] =3D {
>> 	XGENE_V2_ECAM_MCFG(4, 0),
>> 	XGENE_V2_ECAM_MCFG(4, 1),
>> 	XGENE_V2_ECAM_MCFG(4, 2),
>> +
>> +#define ALTRA_ECAM_QUIRK(rev, seg) \
>> +	{ "Ampere", "Altra   ", rev, seg, MCFG_BUS_ANY, &pci_32b_read_ops }
>> +
>> +	ALTRA_ECAM_QUIRK(1, 0),
>> +	ALTRA_ECAM_QUIRK(1, 1),
>> +	ALTRA_ECAM_QUIRK(1, 2),
>> +	ALTRA_ECAM_QUIRK(1, 3),
>> +	ALTRA_ECAM_QUIRK(1, 4),
>> +	ALTRA_ECAM_QUIRK(1, 5),
>> +	ALTRA_ECAM_QUIRK(1, 6),
>> +	ALTRA_ECAM_QUIRK(1, 7),
>> +	ALTRA_ECAM_QUIRK(1, 8),
>> +	ALTRA_ECAM_QUIRK(1, 9),
>> +	ALTRA_ECAM_QUIRK(1, 10),
>> +	ALTRA_ECAM_QUIRK(1, 11),
>> +	ALTRA_ECAM_QUIRK(1, 12),
>> +	ALTRA_ECAM_QUIRK(1, 13),
>> +	ALTRA_ECAM_QUIRK(1, 14),
>> +	ALTRA_ECAM_QUIRK(1, 15),
>> };
>>=20
>> static char mcfg_oem_id[ACPI_OEM_ID_SIZE];
>> diff --git a/drivers/pci/ecam.c b/drivers/pci/ecam.c
>> index 8f065a42fc1a..b54d32a31669 100644
>> --- a/drivers/pci/ecam.c
>> +++ b/drivers/pci/ecam.c
>> @@ -168,4 +168,14 @@ const struct pci_ecam_ops pci_32b_ops =3D {
>> 		.write		=3D pci_generic_config_write32,
>> 	}
>> };
>> +
>> +/* ECAM ops for 32-bit read only (non-compliant) */
>> +const struct pci_ecam_ops pci_32b_read_ops =3D {
>> +	.bus_shift	=3D 20,
>> +	.pci_ops	=3D {
>> +		.map_bus	=3D pci_ecam_map_bus,
>> +		.read		=3D pci_generic_config_read32,
>> +		.write		=3D pci_generic_config_write,
>> +	}
>> +};
>> #endif
>> diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
>> index 1af5cb02ef7f..033ce74f02e8 100644
>> --- a/include/linux/pci-ecam.h
>> +++ b/include/linux/pci-ecam.h
>> @@ -51,6 +51,7 @@ extern const struct pci_ecam_ops pci_generic_ecam_ops;
>>=20
>> #if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
>> extern const struct pci_ecam_ops pci_32b_ops;	/* 32-bit accesses only */
>> +extern const struct pci_ecam_ops pci_32b_read_ops; /* 32-bit read only =
*/
>> extern const struct pci_ecam_ops hisi_pcie_ops;	/* HiSilicon */
>> extern const struct pci_ecam_ops thunder_pem_ecam_ops; /* Cavium Thunder=
X 1.x & 2.x */
>> extern const struct pci_ecam_ops pci_thunder_ecam_ops; /* Cavium Thunder=
X 1.x */
>> --=20
>> 2.18.4
>>=20

