Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFED830BAED
	for <lists+linux-pci@lfdr.de>; Tue,  2 Feb 2021 10:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbhBBJ2g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Feb 2021 04:28:36 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:25566 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232310AbhBBJ2c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Feb 2021 04:28:32 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1129KLr4024105;
        Tue, 2 Feb 2021 01:27:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=Q2Fa2GgrdAdrh6LI4duji5XrRC6SrsldLcZmLuEShJk=;
 b=hMWMPXQHHS0a16PwtNW1o3Hf9lgcYV/RZvch/t1/GGaS6dfvIdAJyEUByMWhV9X4UMY5
 e1I5RJjU9bdOp0SeY8MhqQsLcR6pFaoDisH98HYAco3h4iSOpm4O0EOXPUJhecB4+tjf
 Us8eOyjmcdFFIuVLXXzavY7nEgmL4WnTXDMCIqpsoTS3Q3mV5tDTlsB9Sjf1tfVO5iLi
 aIkgcUDrwopInMAFnYvvbaq8B+PC/EVwW2ItjfAEqXXANoHxMl8eMGhG39kxOsoVHWN8
 PxJAQLFs2oj1biFdKhNql9j3Ku1CgTpQklik9QVorWN1suEy63C+8YpvOClda/HxUlb9 aw== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by mx0b-0014ca01.pphosted.com with ESMTP id 36d3x3g5c1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Feb 2021 01:27:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UOG4TvmsA7YjSFcaZ06qNdR4IxsTr/e5KeOv7HrMNyUjeDLNeLQSSaeho2hvCYxDj3Q61zd4Z35mIjewu7yWuOMN93pZvWLHMi4HqoOipHRAh4cUHHvx3bwpgErTrJ4yoiUdQcTbLE7GIIaC0Z3+we/mqI0J4qfJohwzOl4be0l7/pbYd72COK28gL713Dmj5Y/fyIjQQw0jI0llv+pRKteoX250SWwnVZHH9NzgskxJ7yvWbRty0qAWf8VIsLlnYa/GMyGSaZFRnSwmRH+bpPzL9rb+SXiWEy7dfZNHbcOA6mX/JmL/bZa0sV4Csg+aFm85XEizyz5kCADm8WH6Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2Fa2GgrdAdrh6LI4duji5XrRC6SrsldLcZmLuEShJk=;
 b=XNXe3zWeuVlFq9z9inZAR06dc5dxDa5xInPzjIqUJnX/C3r8jrgBeWAChln3eT7Ep4H1Rhoq7zZ+tc9Nr9T1h/ZMvoFAot56ALe5N7Cpfv1Qf36S35+g3Ij63sfL/7BtUMA+kt+cwmHgIQu4Ct2I2Ywr497pIBDBonCeKyjVKBXn+k9i/4weReHt0vSiaiF8MxqqM8W17dBzAFAeloHrXDx2pVJwfpItxqCn+8X4lczHBLWfMmkSZKTjewRdz1A6794ezbKjl/y9RckQsnJChPb5s+sJuacGEnXSDr2y9SzHBm9TM5VoJeWlykKee/fXBI4Bo2hoXGq6KU8wTSSpJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2Fa2GgrdAdrh6LI4duji5XrRC6SrsldLcZmLuEShJk=;
 b=orI2rPMl8nmfj6COx8qBlXMbnPn76e1JCSCdZMDffdPggQWWCM+9UutBIsdFmg3BXiAqu6M8bo5nKcaUxBAkEW4SmzqsYM9nyBnpSv9QM8wX51sH2EUA/6xyZtnXL23CQNxF7cnb0Nf2kbkMunDSgxbl8YPBzznP028HwHGYzGM=
Received: from MN2PR07MB6208.namprd07.prod.outlook.com (2603:10b6:208:111::32)
 by MN2PR07MB5839.namprd07.prod.outlook.com (2603:10b6:208:aa::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.24; Tue, 2 Feb
 2021 09:27:08 +0000
Received: from MN2PR07MB6208.namprd07.prod.outlook.com
 ([fe80::70a3:6266:bf7f:31b5]) by MN2PR07MB6208.namprd07.prod.outlook.com
 ([fe80::70a3:6266:bf7f:31b5%3]) with mapi id 15.20.3805.024; Tue, 2 Feb 2021
 09:27:08 +0000
From:   Tom Joseph <tjoseph@cadence.com>
To:     Athani Nadeem Ladkhan <nadeem@cadence.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Athani Nadeem Ladkhan <nadeem@cadence.com>,
        Milind Parab <mparab@cadence.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        Parshuram Raju Thombare <pthombar@cadence.com>
Subject: RE: [PATCH v7 0/2] PCI: cadence: Retrain Link to work around Gen2
Thread-Topic: [PATCH v7 0/2] PCI: cadence: Retrain Link to work around Gen2
Thread-Index: AQHW3qQObHKrtBsGq0KOFW8Vb2wTk6pEy6Jg
Date:   Tue, 2 Feb 2021 09:27:08 +0000
Message-ID: <MN2PR07MB6208ECBE13DFCA8A43A28902A1B59@MN2PR07MB6208.namprd07.prod.outlook.com>
References: <20201230120515.2348-1-nadeem@cadence.com>
In-Reply-To: <20201230120515.2348-1-nadeem@cadence.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcdGpvc2VwaFxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLWQwMzg4ZDY5LTY1MzgtMTFlYi04OTNlLTUwN2I5ZDg0NGVhMlxhbWUtdGVzdFxkMDM4OGQ2Yi02NTM4LTExZWItODkzZS01MDdiOWQ4NDRlYTJib2R5LnR4dCIgc3o9IjIzNzgiIHQ9IjEzMjU2NzMxNjI2MTIxNzU4MCIgaD0iamlaM29qTDBQYUl0cktBTGVqZitvZ1I1MVhvPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5301bc7-79d0-4af3-17bf-08d8c75cb68c
x-ms-traffictypediagnostic: MN2PR07MB5839:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR07MB5839E71D98066C90369F1F15A1B59@MN2PR07MB5839.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HBVX7wNsaw+haB16ztZkwUCVcq5jyMudnsnUBgFuOE8Mkpscs2WjHL1kPHwHZKQtJgruzf+HoPDzA4fkFoKo1tdXNMmQ6wFylh5DXfWJYXTkV8TWGPEx1cVzwXNPGtpC8q1T0lg0TevnO2KCZL4h05G5lXG8Xh2UBgIOt+YQZdKuaJfR74UICh1AIUX7v4EtjJBDMmb1FodL5PhHbTFeHcIAPgNVVaARE6fSLODGac3xzIsrtaTTPhwUQ80y/AmqJGZypw4dy82NZEhgSHdFnQrZv2w4DiLmU22xzzN6chjOA99vMNw62Ptk7VD8JmcEzUMNXxPUqgfYMFKs5ARs5C+wRVjLNVpl87XnMQdVs6ihk54POqVfZkUo8jSil1eVDr/i7thUkgP1BC08pDMVQcLKtCteX1qQumFJ1mCDIct1WAjrZwGNixC6yf76W86nRUMkl755OY5WKlmP8aBMs4isnODLfVZm8PZs7NQyf3IX/IXd/cluzeNv5EvMgFUr18iJ+NMNH0CREdHnU7/AGuezuPG0I278GR7T0YLBtFDUcErUH8Vo5xQivbEnY9B1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR07MB6208.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(36092001)(26005)(55016002)(186003)(107886003)(66446008)(76116006)(66476007)(478600001)(52536014)(86362001)(5660300002)(66556008)(66946007)(8676002)(110136005)(54906003)(71200400001)(64756008)(6506007)(316002)(9686003)(33656002)(8936002)(53546011)(7696005)(4326008)(2906002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?1/cb/guxozzEyUOBl6sRtAmXnpMTif/scAsm20+3MhpmxKjNhY3OVEbWQPag?=
 =?us-ascii?Q?Du//yGYHSHFTfr8PNhT8G3hzYpxa7dUV2jysft2hlSe/LwSzsjO/6IkMyxeM?=
 =?us-ascii?Q?u3yjEKqZzrIGBh7cEs2BSHEKnJVWF8yid4b2JN75rzq8FlYo3eQ0z/f3cBoN?=
 =?us-ascii?Q?HsJ1sBeSf8QM0TKKskybVO+2uHfWIFpkFmPZqJtjuCNCOccdyYHl/X7rwP/J?=
 =?us-ascii?Q?TbenjISK/Fz9oBzEHflb4UBpG8dl9T/0eAtDnNf9F97KgAk5bxHuny1cP+J8?=
 =?us-ascii?Q?M2Pu4KAPUnAobW8YuDVSaSm0DFX1yLkTEDV2Lv6Wi2HW3tcXXFk1udHWsrp5?=
 =?us-ascii?Q?ryM9WSRz1hd6CU4R5EeTUX49VS221gRU1M+9yneCEQ9yThatno5uT8kq5sat?=
 =?us-ascii?Q?AJb98CQf+q4mXYXwv8x/CN6UTSKiL8tYgYHMfpHprQN+P9R5uTaUHbj8Ch4J?=
 =?us-ascii?Q?7QcPRTuxgKdaFcoZe/saREb1eQqt6auNGAcydCmtrNiR9N3tldYTBkq05kWh?=
 =?us-ascii?Q?0Wbu36hDkzEhfAAvKyU0SGltL5WtYMU5Yu3fsEMBspewbbxr4uNOnxhM//81?=
 =?us-ascii?Q?XiMDgcAmMKcuqeV/Ib6IDipOll/SQS645JbRb55dSlp1sr4PRCA4sVThiSg7?=
 =?us-ascii?Q?KT2mGLzF22PBE4wUcOysNSpLMG6xTElwheais3YJn2PfPltzfUH9bdpKgTmI?=
 =?us-ascii?Q?6KJpKJJafEK8qgTHYQIrI313uowGUbIz9bT7gUM793qJcyZy/V5OYQr49KHS?=
 =?us-ascii?Q?d/iITZ8dDxWqT5136X5MAiDwgR72Rt1kOFYQJiFNHPQND7WoReTeBAyvWFoy?=
 =?us-ascii?Q?tld7LT7zxjaGHvXQHAWlf9zAlNAKOmO7JNOc9h2hTbyM4LF3qCJScDgcpaYL?=
 =?us-ascii?Q?rpjdJvLa8nJc7yJ1f5JuuFZ9lhXJwmM8hyOe9EbQtKsnTTlBYhmETUINGYs9?=
 =?us-ascii?Q?fwzQhVVNLG/3mm7j5T+hC0CRjIt9WNblM0SyJK8frgIZIzD7h8XxGjX1DB8+?=
 =?us-ascii?Q?dyarj2ENBq0NPvPv73RgDHkMCxCx5ZTnMQlQAaFYVd6K/OOYkvJ3O1Fir5hu?=
 =?us-ascii?Q?QQtIycQ6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR07MB6208.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5301bc7-79d0-4af3-17bf-08d8c75cb68c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 09:27:08.4739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RDtwzQ5w5LydAX0XPJClG3Md/nc+Sb/681PIoZug4rzEbr3GVwQmGmSyh40p2nr7hsO7u9cfSAe8RiU7LMSRMl9X/TluIHMW+ODXEdBpe4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB5839
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-02_05:2021-01-29,2021-02-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 mlxscore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 mlxlogscore=999 clxscore=1011 lowpriorityscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102020065
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Nadeem Athani <nadeem@cadence.com>
> Sent: 30 December 2020 12:05
> To: Tom Joseph <tjoseph@cadence.com>; lorenzo.pieralisi@arm.com;
> robh@kernel.org; bhelgaas@google.com; kishon@ti.com; linux-
> omap@vger.kernel.org; linux-pci@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Cc: Athani Nadeem Ladkhan <nadeem@cadence.com>; Milind Parab
> <mparab@cadence.com>; Swapnil Kashinath Jakhade
> <sjakhade@cadence.com>; Parshuram Raju Thombare
> <pthombar@cadence.com>
> Subject: [PATCH v7 0/2] PCI: cadence: Retrain Link to work around Gen2
>=20
> Cadence controller will not initiate autonomous speed change if strapped
> as Gen2. The Retrain Link bit is set as quirk to enable this speed change=
.
> Adding a quirk flag for defective IP. In future IP revisions this will no=
t
> be applicable.
>=20
> Version history:
> Changes in v7:
> - Changing the commit title of patch 1 in this series.
> - Added a return value for function cdns_pcie_retrain().
> Changes in v6:
> - Move the position of function cdns_pcie_host_wait_for_link to remove
>   compilation error. No changes in code. Separate patch for this.
> Changes in v5:
> - Remove the compatible string based setting of quirk flag.
> - Removed additional Link Up Check
> - Removed quirk from pcie-cadence-plat.c and added in pci-j721e.c
> Changes in v4:
> - Added a quirk flag based on a new compatible string.
> - Change of api for link up: cdns_pcie_host_wait_for_link().
> Changes in v3:
> - To set retrain link bit,checking device capability & link status.
> - 32bit read in place of 8bit.
> - Minor correction in patch comment.
> - Change in variable & macro name.
> Changes in v2:
> - 16bit read in place of 8bit.
>=20
> Nadeem Athani (2):
>   PCI: cadence: Shifting of a function to support new code.
>   PCI: cadence: Retrain Link to work around Gen2 training defect.
>=20
>  drivers/pci/controller/cadence/pci-j721e.c         |  3 +
>  drivers/pci/controller/cadence/pcie-cadence-host.c | 70
> ++++++++++++++++------
>  drivers/pci/controller/cadence/pcie-cadence.h      | 11 +++-
>  3 files changed, 65 insertions(+), 19 deletions(-)

Reviewed-by: Tom Joseph <tjoseph@cadence.com>


Thanks,
Tom
