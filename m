Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8E9495870
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jan 2022 03:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbiAUC4Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jan 2022 21:56:16 -0500
Received: from mx0a-00622301.pphosted.com ([205.220.163.205]:42864 "EHLO
        mx0a-00622301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229523AbiAUC4P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jan 2022 21:56:15 -0500
Received: from pps.filterd (m0241924.ppops.net [127.0.0.1])
        by mx0a-00622301.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20L1ND5h013939;
        Thu, 20 Jan 2022 18:55:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to :
 content-transfer-encoding : mime-version : content-type; s=com20210415pp;
 bh=r8MZvyIyFZ1v0FZ+i4J6NOOp2vOy86EcZR0XxKp6I80=;
 b=WS3guSTGjM4bK+tCuw85vsM2X6hOLq115SqZBq/gJzRbrehUgsV/DMW6idxtKeZWhSeL
 jKSnOU1jDVDahfyZU66h0lsFW8rMkQoFABHMhivsnLGtgFUdscHM+uO9Un6l1Aky2R0v
 ymTl9PAyvo+TP6Dula3FSL8uWPwADrsZCFF5hd5v5cYwCgWKbQnYM2eoFi+pSvEQowwG
 Pxpfe/lmwlC2uAv4oxkzk/g6UN+uNCaZY2qBiuDziclVxzLtLinn5vBBmzrFOh9se7BV
 18FLqWZdAGPBFI48yG63/H6eYAQqIHDhIahXnFg90LwcoF9AZgtxIkHzk8u3QpBS+Hcs rA== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-00622301.pphosted.com (PPS) with ESMTPS id 3dqhy381mq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jan 2022 18:55:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNwBww9sl6ieTXfdfhxdjTeNRwxGiJwXjfa+QAHpjlSF6Dso80kawsdgJYkdGxuQNRViZQo3LsDbGLfSLnH3xN73DXuk6IcGc33ilzVUQK+0KChyFTG2z6tV5hzgwHhgzU7xTO4ZxRvYnMewss7QbG1SiLeuvyyk8gUZgZE1qPCPRJzTampwMrpO4oxLyF5zw3DUJknm6yLNclnRTQTWMsJ/5lL2W8yYMQns1FnWBKThHyf/8UkjGPqg9U+oCWSwfVLia82yotaIq37Sh/pCJEjIuOLEwBWZsvKA9Wil8sDYjuYYVDOM7cLBO+3st4/qSl0W7XNjNGI9s5HPq5beqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UrnNUxVQWz1IqRh4nxkArgwBgaWTZBHeK0mabdd0yUk=;
 b=K2qIl5sK/GY/FlXAmphWyZbaBlvGRBuCismJDHQeIF9wIoCfEUhUrsfxK91IkdSmoSGODFytnO0435PtkEgjUp233JL285VN+BLKwW5HMGRr4nCQjM2pqCjnTCpahk+kjGinfhfyaOag12kdRu50ASJdvt4KmqaSePmXAWeVLxvTxa6tIfxQ2ApEAPtZR8Hoy4CNusfrIog3pxYuJ+cjOos6wrfFf+YqBfBAqiGmDElaWeIeI4wTPlUL5Gxxty1cQ7zaLXcRs+Scchc4k12eF3xhTHA370eqGDJKaL8FyXpuCkHAeqvabxUT26vJ0kjGd9XNaJwpJ8aUXB3sYJLKwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrnNUxVQWz1IqRh4nxkArgwBgaWTZBHeK0mabdd0yUk=;
 b=RFvY9quEyK/y42+vymweYfb4fNdp/dsVPUWSa5TG7l8/UgqobDw2T39/UVyZTZkeR6jQQu/AXM6rNJ/ywiSuEhJOG6sBujVISmeVORwi2EDFY+kYC1biiKoIS/tVJgA4LeGNj9hmVHc+iE2t5NyGMQZeqcEpV0xg2TdC4GVa4VVexMnPB5BjIqefqE7okGcoEVhRlavH6te6i8OHTx5+dV01qaq5EXbBTLWyJ/Hpglc+up+V4Lpr/VEhAsuuzqpS196tkQiXTpGJy4MC59z99kvRPQ4Dx8SfAE4SDGB4QmJvpI6h96ZL3bDLLEApvy31AOThbJXYIRmbS9Lmt7WFVg==
Received: from PH7PR19MB5562.namprd19.prod.outlook.com (2603:10b6:510:132::22)
 by PH0PR19MB5502.namprd19.prod.outlook.com (2603:10b6:510:12b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Fri, 21 Jan
 2022 02:55:51 +0000
Received: from PH7PR19MB5562.namprd19.prod.outlook.com
 ([fe80::8c3a:e80f:9fe7:959]) by PH7PR19MB5562.namprd19.prod.outlook.com
 ([fe80::8c3a:e80f:9fe7:959%7]) with mapi id 15.20.4909.010; Fri, 21 Jan 2022
 02:55:51 +0000
From:   Li Chen <lchen@ambarella.com>
To:     Tom Joseph <tjoseph@cadence.com>
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
Thread-Index: AdgNFhFdLIAJoUumRauHA5pdsoTIFwA1O41wACEoNOA=
Date:   Fri, 21 Jan 2022 02:55:51 +0000
Message-ID: <PH7PR19MB55625B4733F2F45133AA4EACA05B9@PH7PR19MB5562.namprd19.prod.outlook.com>
References: <PH7PR19MB55626CD5D22EABDEC879EF41A0599@PH7PR19MB5562.namprd19.prod.outlook.com>
 <MN2PR07MB62084589DE98AD2611C55FFDA15A9@MN2PR07MB6208.namprd07.prod.outlook.com>
In-Reply-To: <MN2PR07MB62084589DE98AD2611C55FFDA15A9@MN2PR07MB6208.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83041c33-bf01-4c54-c72f-08d9dc8988cf
x-ms-traffictypediagnostic: PH0PR19MB5502:EE_
x-microsoft-antispam-prvs: <PH0PR19MB55027E0AF9FCF4C7AA78AE27A05B9@PH0PR19MB5502.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2FXXunaeeg90Eb3ASpSiOI6gHl79qgdAAfGVh6+xaU/2Nt+QfbS/K1odygPEkWZjoirxBG+SE7FGKtjL2k2ri8YcbBvtoLJL9seO4UZXuJCAidnihuytNrS9+/jGP4Hql27KnmWBhl0Jiy9tgWf3hokIXngjCQGViVWWPYH4En5sZH26N+28U2T1U2/ddiUmWDPenrLKDQjPOtyVg+ol8iWuIZY4mzjY+zrtZitYchRSMIrLHxD7JqJqU548VHZCoerXfMKQKw50o2kdjJ0PkQvlz1BkbhewMDbdG0dS0MkCjfEEJQ+ue4Css8G+NVOhoG0A1ItsrZfQB0emhqcpDXHsTpzdgr+LqHXtstPPA3FdhO2Iwyq6PpmctvSY6NdF6a8Vb6z/PdOCdbmOv0tNLQpWimzjW2alvtPGqZE+BdggArP4xmJwLi1wKBvxXRpA4SWSb0MFkVovcmlRUSHIKxM3vmjPAT2B7VO6coxUNc8EoKKhv4Y1lEDatoGLdhbvjgMo3STKss5YKyS/4EoMbBIFTX/zCB9d6fPI1HJ2Panc/JyfqD4ZBn3wjLkfsWQRPt81xSwQtNnhQyRCaumI8bOGve6qDQLHqyoqC4Hnk/JNyFtyysG4YljFH+zGJqhLsTeVByOilulLBJgTeiEcvI+Gj6FU1F1buNrDK3PQ/KoN5aBjSNatYRfTXoJdu5b1EybxVmqiTJXDpkU7u//HmpFz6aFk+m4rnCackRT75Bs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR19MB5562.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(88996005)(5660300002)(966005)(6506007)(52536014)(6916009)(4326008)(66574015)(71200400001)(53546011)(508600001)(38100700002)(54906003)(26005)(7696005)(45080400002)(122000001)(186003)(2906002)(9686003)(8676002)(64756008)(66556008)(33656002)(66446008)(66476007)(316002)(55016003)(83380400001)(86362001)(8936002)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?fOH2oTEUmP8k1DNgVgOxXdUKIjSSh7ftV+pr8R3/FGMP3Fy+HXWB9uRWeb?=
 =?iso-8859-2?Q?8vVRnBbdoShRV4hrrI2Vl/oT6dv8XYycRqwW9l/V8nsfN8A7yukufWnRFS?=
 =?iso-8859-2?Q?kKDJ9XV2u99+X/dzv7n80AluIJVvoD/Z7ZoQOdxD3fUnCotocOsuIrR7NL?=
 =?iso-8859-2?Q?R2OhX77/UxO5f8qZkNWiqujZjvEX44Ue1AuEfXwrzJjDDe314abO36YLN+?=
 =?iso-8859-2?Q?7lWTPc07UyTSQbRDB1H1Kw6Fs5jcVtsO4fSsMaSaijGEXk/IVIfQH1Ucqi?=
 =?iso-8859-2?Q?IBFTGxwleHA1Z056tfAlPIvmC44p6dcQeua5AMvBG7tyL6LUann4zS3xGd?=
 =?iso-8859-2?Q?M8ed2qepxNzAvoLtOJnrbK7rYiH7pR65CuRZPseKXy4ZUZo9EZg1cjbo3a?=
 =?iso-8859-2?Q?iO3eSzD4VKaDCExAK3u7/pRJcEbtv23G53m++032UkjBZYORFP0UUPrZ03?=
 =?iso-8859-2?Q?wjggJcRQJrKmRjb85OvGc+SFQRvRb0QWJ3qarWkLlVgzZJvm2vIYq+2Tek?=
 =?iso-8859-2?Q?HpptWbKvo+hXyw4yP3Skz/B0tdw11AoRzKgM6C/x7Q45Qwfhci0ngFgoAZ?=
 =?iso-8859-2?Q?y7Z+3VLc+4k2OvG6kcmNUkIH50SJDramisVqnsKoj86xQ3D9LmswlUzT8+?=
 =?iso-8859-2?Q?eyDZ64b37PtfNlkJ2HDoWrR9edM/aev8l/hSKIvIfUQ7peiLGADI3EpM2f?=
 =?iso-8859-2?Q?2e2BCZ7kCKlNUxeKH8qvTPdKfvPK2vPekeG7zDQSujzAc/FrKP0duGu7lV?=
 =?iso-8859-2?Q?HeOZN18KM4tjFrNc5Mt5cqlyc5TPgeuf9sTKjergj9NVF7x9cfBL5REraf?=
 =?iso-8859-2?Q?/USgFdPRh5RjTnWyasZuwHIw+P50pdd/TNKq/n0r6W3X+9VS83ajDLN2NO?=
 =?iso-8859-2?Q?qlLozH1/+RPPtZuQRCs78szOo5+IkkMubItZs7W9ad1OjCU/AVU7JpiWJP?=
 =?iso-8859-2?Q?/Kk8yCbuUrcaNf1De/wWUTHfH2asmShrsMbR2mqqL26WzWe/mkX0NRXo0d?=
 =?iso-8859-2?Q?LJqzRmKoh47rM/RoIlcLgqf2x+lu45ckxjOwqDVkuVWkOGZJS7ilCLX+nH?=
 =?iso-8859-2?Q?Lwfw2DzoNS1d+qVB8wxcVe1Icj/Hqp1UoSFaLJoCx0mgqC0T75nmJutISo?=
 =?iso-8859-2?Q?u7jNbJq6VDB4PD8vjamZ/ly5p8DcV/KiKpA/1mcVlaQ8TQwKhmpM64JYM2?=
 =?iso-8859-2?Q?z7kTLASavDp3DRJDlAOpr82ZDRzSwYEDqurj3M4TFcr7SdRsEIWdK9JXoq?=
 =?iso-8859-2?Q?BEqZLnRQY61fSHY1onf9P4kHEaZfVG23F/MB0KSf0tMvkvHpxs/NbB/3YJ?=
 =?iso-8859-2?Q?WUrGbKeweRUsTvKwc9ydLZmHYfqdoY6EMOnpFJuMA+RQ+y/DH1ZrT8x2en?=
 =?iso-8859-2?Q?b8b4fdVCWZ/hmK+wxk03cwzp1/KOBuHcxB/gCX5fvDJfzUzemihng2Syvu?=
 =?iso-8859-2?Q?U3d/XAZTVpDIcoDtz85U+1nQExOO8YysIuTjlyLI1PQGRhAfzWtsW3aSTk?=
 =?iso-8859-2?Q?gMFOUCJes3Maus7zKYriKvh8t8F1xZituSzBWaATLlVKksJYWtsQB7eyLX?=
 =?iso-8859-2?Q?Z4iiHuEVA6LQUoegukPtXuvFCMOyPg1+ze3PqHzlpvWQQpJG4rbrfi7kTr?=
 =?iso-8859-2?Q?9JmJPfkVo5UsqRMfXqleHULczPfY/peirY7Ivlis33vy8r1pH6nJAFcdmG?=
 =?iso-8859-2?Q?Y8QCNLsvrUTxDs6evVM=3D?=
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ambarella.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR19MB5562.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83041c33-bf01-4c54-c72f-08d9dc8988cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2022 02:55:51.2334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3ccd3c8d-5f7c-4eb4-ae6f-32d8c106402c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KY/Ogmtl+OoV8hX1LKO/+kvOzakzn/XJ8Lj+RqNGZX42WE4+5zHgWxusdCKsIGnzS5A4oi2CvPOvQZvmdxC4mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB5502
X-Proofpoint-GUID: r5DGkJ4yNcozxvvonXKh0_mde0wOYPKe
X-Proofpoint-ORIG-GUID: r5DGkJ4yNcozxvvonXKh0_mde0wOYPKe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-21_01,2022-01-20_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 adultscore=0
 mlxscore=0 phishscore=0 mlxlogscore=813 suspectscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201210017
Content-Type: text/plain; charset="iso-8859-2"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Tom

> -----Original Message-----
> From: Tom Joseph [mailto:tjoseph@cadence.com]
> Sent: Thursday, January 20, 2022 9:11 PM
> To: Li Chen
> Cc: Lorenzo Pieralisi; Rob Herring; Krzysztof Wilczy=F1ski; Bjorn Helgaas=
; linux-
> pci@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [EXT] RE: Why does cdns_pcie_ep_set_bar use sz > SZ_2G for is_64=
bits
> in pcie-cadence-ep.c?
>=20
> Hi Li,
>=20
>  For 64_bits ,  all the odd bars (BAR1, 3 ,5) will be disabled ( so as to=
 use as upper
> bits).

Yes, I get it.=20
> I see that the code is assuming 32_bits if size < 2G , so all bars could =
be enabled.
>=20

Ok, but I still wonder why 2G instead of other sizes like 1G or 512M? IMO i=
f there is no obvious limitation, 64 or 32 bit should be left to the user t=
o decide(like bar_fixed_64bit and bar_fixed_size in pci_epc_features), inst=
ead of hardcode 2G here.

> As I understand, you have a use case where you want to set the bar as 64 =
bit,
> actually use small size.
> Is it possible to describe bit more about this use case (just curious)?

It's because our SoC use 0-64G AMBA address space for our dram(system memor=
y), so if I want to use 32 bit bar like 16M bus address, I must reserve thi=
s 16M area with kernel's reserve-memory, otherwise endpoints like nvme will=
 report unsupported request when it do dma and the dma address is also loca=
ted under this 16M area. More details have been put in this thread: https:/=
/lore.kernel.org/lkml/CH2PR19MB40245BF88CF2F7210DCB1AA4A0669@CH2PR19MB4024.=
namprd19.prod.outlook.com/T/#m0dd09b7e6f868b9692185ec57c1986b3c786e8d3


So, if I don't want to reserve much memory for BAR, I have to use 64-bit ba=
r, and it must be prefetch 64 bit, not non-prefetch in my case, because my =
virtual p2p bridge has three windows: io, mem(32bit), prefetch mem(64 bit, =
because CDNS_PCIE_LM_RC_BAR_CFG_PREFETCH_MEM_64BITS is set), and if the con=
troller running under ep-mode use 64 non-prefetch, this region will fallbac=
k to bridge's 32-bit mem window but I don't(and cannot) reserve so much 32b=
it memory for it).


Regards,
Li

**********************************************************************
This email and attachments contain Ambarella Proprietary and/or Confidentia=
l Information and is intended solely for the use of the individual(s) to wh=
om it is addressed. Any unauthorized review, use, disclosure, distribute, c=
opy, or print is prohibited. If you are not an intended recipient, please c=
ontact the sender by reply email and destroy all copies of the original mes=
sage. Thank you.
