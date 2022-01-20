Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7B38494EAA
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jan 2022 14:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376319AbiATNLb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jan 2022 08:11:31 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:46870 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1359832AbiATNLR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jan 2022 08:11:17 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20K855Xv008384;
        Thu, 20 Jan 2022 05:10:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=GfbXVQ7WwHnNdOgmGG/JaegQgwEd1ff5RfrDyNEK6oM=;
 b=qXKzSjRO88e1Z9ZTzLa9iW9+BOQOugw0xgzNWmad1BwnfbkA/UxXNYMdEqAd0kHq7/ly
 23yc5t89uX60vF7MUHeV/oNWoXmgIS3oQMDSZcdPt9tE3Se1WWKPbpjWVf+y7lmk8U5R
 lTGUkhbd//9x58q13zdGolGNNvdlPL4+L85FGzXBjgwd8oADirQvwnerH7tL3oIGrV9g
 NnHxSyJ8/iXDpzKfdG2xHiBEyZ+fDaBERbu5BWpN/irX7kx/WGWHfc6jYdsIXXOjlN/m
 LiNBj3dROYWGrAohfY0T7c52PbEZL3m5vl5ril+HL97znI1YrzTsax8QO6hoUIG4iIb1 YQ== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3dpxcj1v5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jan 2022 05:10:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8JI2sEYu0sPa+CWxBKDG/8dZ+/To2g0OeJFOcyVtr56lrmOEDlV4KhUv0JlSPiqzOkwHNUil+C6Nak2m00EVNn05kPspo5yP7HZR/kYTyXDdVyOPlWrnJJ4RNa+JQCKRxM5AqDFZjsP/u0dnGYVEZQMYwlwOy63HMZShG5B6b5aZxO0LG92YCIuKDUq9UWfX6Unl0IiRXIgXX7jpWK1JzxDwuM9lIO5BloLbRP4wcEczPpcQnnoowE3kOsvTSI85h9XsyW35icjEoURkAI2r6b7Ri+zzh9s95CIgKAvI1hq/T0IhCH7nBHpW8Watfhu7D1PN8g9S7Dnzh0Ktf9AQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfbXVQ7WwHnNdOgmGG/JaegQgwEd1ff5RfrDyNEK6oM=;
 b=NN5M7MyzlaX+dk9+lIPcLU4gSQkUAdTV4HRb8r/cY1mIEnj6hYvMiqJyJFpfWKKlW7MG5DPYvRkwbcXYDXyMZ/0NqrB1Qrps9X1elMpo3PdT/wu6nkiK5dnoF37ZmFDOzQ8RPIo7Fq3ZD9muIORCScrusZplzQrTwxb/YnvwV9FvGMN1H0fakqSV7gwarhnerqpBVO47z5b6F9TOBDSIkK8pl8cwFQqSFDeaLHvE5KDHHdQi5KwEBlKCUSZckPalBJj5ctH0B1RFKkiwvIkNWkkmrCmSkBe3/oQi7xitQiYYHMcg/9U44IWE2Kg+SPxOKM/FizwJcNe/cWHIy88pTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfbXVQ7WwHnNdOgmGG/JaegQgwEd1ff5RfrDyNEK6oM=;
 b=Snyrq/gVsKEcwHYZgEGoOVDNICc/Xm4tzVO03ZRrf7SdsN784t+DgyCPkwmERM35SfC/4UMdpHqZavE4z9STGPUzdLzr86dKeh8gbQjRBqX1Q6Ln1fsOfDqAdpPMbqo8kTzbleXBgWkqogoajq+ZpStTu470GnH9noVQsWPRorU=
Received: from MN2PR07MB6208.namprd07.prod.outlook.com (2603:10b6:208:111::32)
 by MN2PR07MB6046.namprd07.prod.outlook.com (2603:10b6:208:105::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Thu, 20 Jan
 2022 13:10:54 +0000
Received: from MN2PR07MB6208.namprd07.prod.outlook.com
 ([fe80::907b:2b5d:7de:ea15]) by MN2PR07MB6208.namprd07.prod.outlook.com
 ([fe80::907b:2b5d:7de:ea15%7]) with mapi id 15.20.4909.010; Thu, 20 Jan 2022
 13:10:54 +0000
From:   Tom Joseph <tjoseph@cadence.com>
To:     Li Chen <lchen@ambarella.com>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Why does cdns_pcie_ep_set_bar use sz > SZ_2G for is_64bits in
 pcie-cadence-ep.c?
Thread-Topic: Why does cdns_pcie_ep_set_bar use sz > SZ_2G for is_64bits in
 pcie-cadence-ep.c?
Thread-Index: AdgNFhFdLIAJoUumRauHA5pdsoTIFwA1O41w
Date:   Thu, 20 Jan 2022 13:10:54 +0000
Message-ID: <MN2PR07MB62084589DE98AD2611C55FFDA15A9@MN2PR07MB6208.namprd07.prod.outlook.com>
References: <PH7PR19MB55626CD5D22EABDEC879EF41A0599@PH7PR19MB5562.namprd19.prod.outlook.com>
In-Reply-To: <PH7PR19MB55626CD5D22EABDEC879EF41A0599@PH7PR19MB5562.namprd19.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcdGpvc2VwaFxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLTY0YzlmNmQyLTc5ZjItMTFlYy04OTY2LTUwN2I5ZDg0NGVhMlxhbWUtdGVzdFw2NGM5ZjZkMy03OWYyLTExZWMtODk2Ni01MDdiOWQ4NDRlYTJib2R5LnR4dCIgc3o9IjI3MDIiIHQ9IjEzMjg3MTU3ODUzMjAwNDY3MCIgaD0ieC9FSGVydW1FL2xJbWlJMlRlZFdTNEQ2K0Z3PSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c72d303-4281-44e2-755f-08d9dc164a6f
x-ms-traffictypediagnostic: MN2PR07MB6046:EE_
x-microsoft-antispam-prvs: <MN2PR07MB6046587EC621672C0A783DC5A15A9@MN2PR07MB6046.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zCk1fMjbA9oZ4fKL+86FpVLphLZz+CMR+E+VCZvv+GROIG6Phplnk3UqVMBLtt8LF1T5TDxGN2NGslLSdgZaspo6W1r032EgM31IsD5RrkLJIh8x43jznHEXsvFdNDUgj5iAx+iv2wrjdi4XqRwg5wRCV0iLNnVm6LwlalVS/NrH91cc7P9IgvJyGQC0Im0d6NLFWS7NrJWjWKkRI5CzBpztiVFaB6pthy05tAL0HdS9esmTmo36ghqsnM41bz+ZkIkvj64GygFlfTEmh1pTaHYyQ7m6FXJCwbSPgBmUPQY5x5vAlDkvJ1rvEsJVxNFlSa5BfUyzeCGyb0Kjs6kJDd0eqtnAjhDhecmuXcE5nwpFTsxsftk/FxFIeDxG2pa9EpLHxHoL0rs7xGyltidPBtX2CCqaYG8YdSbXcDi/defzuEEvgQv+cAJ09xRFt/LpKaqI+1EkblmTZcbmJ0jf79uP1uU8615jnJuZNLqLyO8g4WDfPGxlbzfYBWK2bAKFyfC07Qom4ldwTfXhasmxOveiOmFOKNmG5bxzynT5GAHi4VdMtlRs/MivWP9hp+1nZ8T8JZkeqUhUPbVolSIRv9IXa8zUzHok4Ch26DyKuVJrl5OL6X94ZTcxmmmZrZ6Hd/9G/7YKE2gTmGMfRFHXLoVppfHnereWmtuabhsYNNf9l71btuu42ZMIu8xJioLMIFI5sq8fBVbuHlE53rLxi46AAyvAVfZ9aa2iIbMg3lmWERJ+Efx+VKXPQOTpVFTV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR07MB6208.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36092001)(2906002)(55016003)(66574015)(8936002)(6916009)(8676002)(508600001)(33656002)(38070700005)(83380400001)(6506007)(53546011)(186003)(26005)(9686003)(316002)(7696005)(52536014)(66476007)(66556008)(64756008)(66446008)(71200400001)(66946007)(76116006)(122000001)(54906003)(86362001)(38100700002)(5660300002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?rRBajN25GvcdOlsGToBmZWyF/zx7nq+0KRqVmX1p1gj9t6K4bzG7+1OlnQ?=
 =?iso-8859-2?Q?uexUc8r5P3xDwe2uEFvqKD3hyU19NBRl0fQB5ikBmK8BlCm/tmMRj+GY/V?=
 =?iso-8859-2?Q?HRzbqGYBt6w6bglxhaFqjVKa8n0avQEAeHa6A38sC6K2qhW5VpsX6EjThO?=
 =?iso-8859-2?Q?7GiNYBPqyplcdO1nv6ctdR1iyiMqwhkFNPB5wZDgpt98vWMVExgb7C3Ukc?=
 =?iso-8859-2?Q?tO93gKOIr8BbgZhOgdNn9yMEvqamDB2hC6PASbE4P9St4qM7Hrvz5kUZts?=
 =?iso-8859-2?Q?d9X5TGyTOxG4P7h+1Jtm3lYNUPgygHOvus5NogQSQK6zyLphlh835GlloA?=
 =?iso-8859-2?Q?nduKdz2l6kbT0VxTrFYc0/YAPm1bbI5Hog0IIvBxuA1qNjwWh4raZKmjBT?=
 =?iso-8859-2?Q?2zRYrRQYXMlxpZ9Y38JxYvA1K5lXmUQuTZGgJWkHdcMPHBxWzWtJ9sO5rV?=
 =?iso-8859-2?Q?ydgID2Ih4YEtiTyLPQ/6vPB/xAh+RqphWO4Oo9c4o5x5Mr4QugVklJnZTA?=
 =?iso-8859-2?Q?mwTk3oLXrvvyPxON/Aiin9rCNHKkoclA1cg4cXA9RG8v3FUWZ5xtikz1LW?=
 =?iso-8859-2?Q?L1vgsB3hD18VsnnHQy4ew+/ZLeWR1j1M2rls6bbQvdm50rDFMfde+X2xua?=
 =?iso-8859-2?Q?ViU0Fkh6KaSCsd2DboNm34JRoEotlRxWDGFvaqw2c4B2BGYznLkuVL0yd6?=
 =?iso-8859-2?Q?dMIlqrqfj54isdElEUs9nstK1bvV4FQrJ4zPO/12JMxo/XJIkG0rMWFoNX?=
 =?iso-8859-2?Q?BJq/B951oB+z1vwWBx0ZsRDrzBQXq6T3NZol3WGjBPkYgcFGGLRsLTxv3E?=
 =?iso-8859-2?Q?gMngPZ/e1LGKo8s5Uoam8Cao+bI8vwsdOXg1BGdxPxuPI3AGY4JaGoT7QN?=
 =?iso-8859-2?Q?wJkNQO0d1St6EXmiL1jAypnGpGKCVXQVlzza5mJQkCTAjJ121U1ZCpwCwc?=
 =?iso-8859-2?Q?O0ZTa0fX3Uj6Dx6yo4Y+wgctfbZgF+xIdTyPhIlvZgODxTIOuusxevblFs?=
 =?iso-8859-2?Q?h6AM3ThF8j9yhMQtv4wsoPAVITPMowTgJGHvuhoFKeimDpCsmkQFKg9Qif?=
 =?iso-8859-2?Q?h9XXyzpLql/JMfuzid5hpeGOFQ2iVXtZa4HgIyf3Ggl7IcSzYqlbMeVit3?=
 =?iso-8859-2?Q?BIvI7DxVM1d7HRO2zVnBV5xQzmQgw30OhfhFDCW9oYlJs/ldO4KCDXI2lg?=
 =?iso-8859-2?Q?yZQBd5m5q2vU/yNgIqBcKMrzZixiTg7/7gkRIuGTKF8jLHsM2BMv6H5Q+W?=
 =?iso-8859-2?Q?TvNfon9srhgV8Q7DQpSFQsN/RaqZHkMKS6lulPvoPAYiN7PoVuXpA4vCuB?=
 =?iso-8859-2?Q?JXder6xutjuV28rnKwgIJQF8LMVVV4XzxMTy7jXXZk2daopq0P4p856dCa?=
 =?iso-8859-2?Q?uVU4uhs1ly9OXx9BtzNfo6XgZbR8tOxoJzu/ELMVM5Q1NDRrDuiNsL5MPW?=
 =?iso-8859-2?Q?OPmJhQlEKlj1uxfyxkYw0363WqwKDyJDb6dlnbc69arTalFa2wKTdA9ttq?=
 =?iso-8859-2?Q?mLG8GuE7dFAkJTz12z4467wz3Raz2QmwsvOMb2HKzG7SeohYLZGn5xQlE1?=
 =?iso-8859-2?Q?ocCBULfyb5nfg2htoEadSZeP1DmFU84pfmqfYPseA9FHzjCII9nNd1wFZ8?=
 =?iso-8859-2?Q?dm3KWWMQksT1bQYsc1XDMcXRr3OmH6QzS708ycZ519GazgBSequZsWWtbn?=
 =?iso-8859-2?Q?OYymJY43hZluDNUCLCf/OjsQzWd+vA5Gkmyuj8SsaveyiyYTYFPnnVhc2n?=
 =?iso-8859-2?Q?0D2Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR07MB6208.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c72d303-4281-44e2-755f-08d9dc164a6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2022 13:10:54.4439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fQhjD/QNNHqGDibzXjjm9fv9ppecEZEFyxQbMEU/rgQaizuS8HMUBthEMTEOXCwIMj4G0/bxzOpHC7YjsLfzCvaTSDCOT0PdDBxcw1pr7Gs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB6046
X-Proofpoint-GUID: pnk3psiNmUvnxdJnfEN45xp2Qdz2-Ls_
X-Proofpoint-ORIG-GUID: pnk3psiNmUvnxdJnfEN45xp2Qdz2-Ls_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-20_04,2022-01-20_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 phishscore=0 impostorscore=0
 mlxlogscore=851 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201200069
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Li,

 For 64_bits ,  all the odd bars (BAR1, 3 ,5) will be disabled ( so as to u=
se as upper bits).
I see that the code is assuming 32_bits if size < 2G , so all bars could be=
 enabled.

As I understand, you have a use case where you want to set the bar as 64 bi=
t, actually use small size.
Is it possible to describe bit more about this use case (just curious)?

Thanks,
Tom =20

> -----Original Message-----
> From: Li Chen <lchen@ambarella.com>
> Sent: 19 January 2022 09:28
> To: Tom Joseph <tjoseph@cadence.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>; Rob Herring
> <robh@kernel.org>; Krzysztof Wilczy=F1ski <kw@linux.com>; Bjorn Helgaas
> <bhelgaas@google.com>; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Why does cdns_pcie_ep_set_bar use sz > SZ_2G for is_64bits in
> pcie-cadence-ep.c?
>=20
> EXTERNAL MAIL
>=20
>=20
> Hi, Tom
>=20
> From these function:
> static int cdns_pcie_ep_set_bar(struct pci_epc *epc, u8 fn, u8 vfn,
> 				struct pci_epf_bar *epf_bar)
> {
> 	......
> 	if ((flags & PCI_BASE_ADDRESS_SPACE) =3D=3D
> PCI_BASE_ADDRESS_SPACE_IO) {
> 		ctrl =3D CDNS_PCIE_LM_BAR_CFG_CTRL_IO_32BITS;
> 	} else {
> 		bool is_prefetch =3D !!(flags &
> PCI_BASE_ADDRESS_MEM_PREFETCH);
> 		bool is_64bits =3D sz > SZ_2G;
> 		if (is_64bits && (bar & 1))
> 			return -EINVAL;
> 		if (is_64bits && !(flags &
> PCI_BASE_ADDRESS_MEM_TYPE_64))
> 			epf_bar->flags |=3D
> PCI_BASE_ADDRESS_MEM_TYPE_64;
>=20
> 		if (is_64bits && is_prefetch)
> 			ctrl =3D
> CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS;
> 		else if (is_prefetch)
> 			ctrl =3D
> CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_32BITS;
> 		else if (is_64bits)
> 			ctrl =3D CDNS_PCIE_LM_BAR_CFG_CTRL_MEM_64BITS;
> 		else
> 			ctrl =3D CDNS_PCIE_LM_BAR_CFG_CTRL_MEM_32BITS;
> 	}
>=20
> 	......
> }
>=20
>=20
> I don't understand why should sz > SZ_2G be taken into account for 64_bit=
s.
> From my personal practice, there is no problem to use
> CDNS_PCIE_LM_BAR_CFG_CTRL_MEM_64BITS or
> CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS when sz < SZ_2G.
>=20
>=20
> Regards,
> Li
>=20
> **********************************************************
> ************
> This email and attachments contain Ambarella Proprietary and/or
> Confidential Information and is intended solely for the use of the
> individual(s) to whom it is addressed. Any unauthorized review, use,
> disclosure, distribute, copy, or print is prohibited. If you are not an i=
ntended
> recipient, please contact the sender by reply email and destroy all copie=
s of
> the original message. Thank you.
