Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE05F4391EA
	for <lists+linux-pci@lfdr.de>; Mon, 25 Oct 2021 11:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbhJYJF0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Oct 2021 05:05:26 -0400
Received: from mx0a-00622301.pphosted.com ([205.220.163.205]:65454 "EHLO
        mx0a-00622301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230146AbhJYJFZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Oct 2021 05:05:25 -0400
Received: from pps.filterd (m0241924.ppops.net [127.0.0.1])
        by mx0a-00622301.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19P8oigD029504;
        Mon, 25 Oct 2021 02:02:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=com20210415pp;
 bh=33g7pA3C16JsVjPhxKrqHeH8mXiEc41WelDVi5rrR4Q=;
 b=GWpPr4+8jQhEGRag4PQDxIQtLaUhtxMkzEiWw9k7evjrOtWys3HL4xLD86wkIvNjMomK
 cPhamdoFW5lL5A3wyqZFeDNKD9pgOjwmNekRaxkGi2Y35vqq22POezCvWk64Icd9WplQ
 QZRBvfXmPE1FuYHhQEla4mAhufRRGwJ3m2Riu7k8dtKRpKwCZUSSTh+U1cWXsC57Ex2u
 /ODBvbU1tHCDzXdF61Yo/PSua87QvQuYS2EukjhFOSPq+L/+q8SU9+NGhtaB8VXA2A+S
 x2T+6r88oyXDD7meApT1/LOjRBq41eIwwHXAcLyzRDs0VPEaBr95megHwX63CkFGIf5s 4A== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2049.outbound.protection.outlook.com [104.47.73.49])
        by mx0a-00622301.pphosted.com with ESMTP id 3bwcnug8n4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Oct 2021 02:02:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R6+MHelItfSx3iwQ1h/CPLrF2GoWY7hi4jmiVePa2VTaRrBC/EvpF4f1f8UvDkkpN/L6BC7O+H/e3cxeqBqp7uP+0xajQRykOe2wbu2MEMBbpCKfdIIX5oz3s5pwckHfF7BFG/f5cwS3BHNC0SB0mWjdY2Aou6c9zXI+5upxP1dseB18Mrh7cEhOALa+On/ROv3i0+LsUjBMwLemaXeEug1hfrjdwMdUX5MU6KldJJK8wU9qiy3nqTv76YYwvD7HeUfW+v9bKEnBZGIglrtxYDoj2f7CFHAh4QI4hF1bPlD8xk9tWB/jjXIA98aegf1lRAVgIXSkQz5lNe0BLoTl6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BIAUnFGTcHxzbv0lPcYdhdvUd88Wjh8O/fHresyQ0z4=;
 b=LMV92oun40kDWBYRdgkaUeg1KPNhR6d5Lqv0098fYFF3JdmpcEp1RTc4pzozTo7Q0ZKyW+6UrIK2xB1t6FQ/wSMrtcM/gApv5SnGILxCZHRo9z0CVezyaoN/SHUErkB2pvFezsUf+4U3JvYywxhPPh+UEE4hQUKIoINgjrj0tNADSQzpLJIcsFIjQjahaECsPSl/I5oSknS4ge12mrUO+XCNBGEJHQpmEheL2QzfpVfJDiCml71eDoXQitOcwHnBD4UHfpWyUvcLqZaNKxo0DAO/m3495uL513TIwKccIAkH9TI+1Lpuj06p5W0b3wazEaYGHO/97gl0ORAtpLZXjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ambarella.com; dmarc=pass action=none
 header.from=ambarella.com; dkim=pass header.d=ambarella.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ambarella.onmicrosoft.com; s=selector1-ambarella-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BIAUnFGTcHxzbv0lPcYdhdvUd88Wjh8O/fHresyQ0z4=;
 b=HeCFE+SL+tRKtSnoG2o60vxECTA5wJ30JcKre6/410TsfuOslAwZP+xAekehJs3djEyd04iFEC9s8bditiVAHM97hMT+SEPlVYjaTKWcuJNt/Zzob/ZIhmE10dTjsseCr3q5eN/0mg7buCjgCEuvTsgITdtRh0oHQKL7UFqnwPI=
Received: from CH2PR19MB4024.namprd19.prod.outlook.com (2603:10b6:610:92::22)
 by CH2PR19MB3735.namprd19.prod.outlook.com (2603:10b6:610:9a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 09:02:52 +0000
Received: from CH2PR19MB4024.namprd19.prod.outlook.com
 ([fe80::8143:f3e0:9fd3:a8e7]) by CH2PR19MB4024.namprd19.prod.outlook.com
 ([fe80::8143:f3e0:9fd3:a8e7%5]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 09:02:52 +0000
From:   Li Chen <lchen@ambarella.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: nvme may get timeout from dd when using different non-prefetch
 mmio outbound/ranges
Thread-Topic: nvme may get timeout from dd when using different non-prefetch
 mmio outbound/ranges
Thread-Index: AdfHKUVD4pdAQATdSnyIoo960S9VyQCVObaQ
Date:   Mon, 25 Oct 2021 09:02:52 +0000
Message-ID: <CH2PR19MB4024BF1FB16E9FF9D00058CAA0839@CH2PR19MB4024.namprd19.prod.outlook.com>
References: <CH2PR19MB4024E04EBD0E4958F0BBB2ACA0809@CH2PR19MB4024.namprd19.prod.outlook.com>
In-Reply-To: <CH2PR19MB4024E04EBD0E4958F0BBB2ACA0809@CH2PR19MB4024.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=ambarella.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b5170c1-866f-4340-4141-08d997963a3a
x-ms-traffictypediagnostic: CH2PR19MB3735:
x-microsoft-antispam-prvs: <CH2PR19MB37355AACA0DCA82F1CED58E7A0839@CH2PR19MB3735.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8hvPK7QKoazrOZD9b1mBPb8ZJRyRgoSmdOy6yePttFB+LdxuJH639a4GMj4hZdN6fwIeIOkn7jntyO5vUqc3KLKEv82k9qTW6wNvcsubDXCFxabDfnqSM+y0xy0Gue9gzr0f2k7U+EitqjtluiiPjI5o8EGP3qVMEL6neDBAvOrWzddFlimvBEvDPsUC4yb8UKjJ03swLeZjHoFtLWzbpiD4SWq4WP5LkhC1ZH4UDjj795X/X0CIlth4SeaWr0LJyreW2a95DgclJC3ggqLJgdLI1uT30f464LPHFLVmb9LoVGsitH9rUxQoQIP8EthiIUYL5xX6Z6RBCw3gPL8NNPrdk/HM5PZ7qhULe87AIMhsyluZHEoTsFmCnNrC8JcOiw8dFrf7YLOYNpF99BHzHtOFqSOYljG8TMspSnEouYjGmYPfoDJrgS/hzJwPIJ8gFUSK9eWXtjgqr5O9eN3MlCvLfR8AfXhuyEVY5YNiO3RbauKVjL8bpFgAnIVzbN1vzLA7tkQLAnsfP+DTgNqWvP/MJNnBvfLx4wbbZTtRudgBJJDmS9BQOYDV6Hn92WM+GcfXOi1w+F+mFvfV297abRCQ/xJMXJyepGyLS4n7h2P/ZkRYEp9+YY8K63zZ5ufRdHR+l/wqHIgn1o6gowkweQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB4024.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(55016002)(9686003)(7696005)(54906003)(122000001)(316002)(6506007)(8676002)(88996005)(86362001)(71200400001)(26005)(5660300002)(52536014)(33656002)(66946007)(64756008)(4744005)(508600001)(66476007)(8936002)(186003)(6916009)(4326008)(66446008)(2906002)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fcCVzdf751OKTu/TlFjMN6zWje5/LEa7sCmNsD63jRjZ6WBlq4DPcAmAqTZu?=
 =?us-ascii?Q?ag84LEvUe2QL/Gbj2MrG8aRprvU0les0lo4g06WtHkx4DDriz8Y7qEDCTsLb?=
 =?us-ascii?Q?Fb6n5pDGt/e2vvcWkbF2iZJAI6OgmjtFXjTp1c+mDJjSZFBK05Yd/+W540aM?=
 =?us-ascii?Q?xKwcYqkuI4YXoQ4nnR1ZNIR8ExaSB5urkXfO/vmHulvLmU2xwVDBONrc4HOz?=
 =?us-ascii?Q?sm/18J1MIgzd1qw/uFPXEdQgr3CgxWuRCW60dXJB4BR0iIXOtlxluVMKUFMI?=
 =?us-ascii?Q?JQl0gQvNrzdtETizyLKEbh6mMBSSYxRtasoSoMSklwe8FasrLXVpRIA1MYNa?=
 =?us-ascii?Q?zMgkljYEXorAMdB5EkF+D7c8Zfs8/YaReCVUifyFOvEkfVtdEN4c1VyjY2lZ?=
 =?us-ascii?Q?uOG1McKTx42DcwlTXNqZZ9vOYor+ANF1ZeaT8//hlJR8mbodP9E1NuRsNsei?=
 =?us-ascii?Q?BRWZVSH/qZSMU6aVYWamHdoPbOIR3Y1F4CRUmzByuBvjIIUwqrSYBwrb+CET?=
 =?us-ascii?Q?9OTplY8y7M5bQ6XwNqSg7c1lISb8XqCGUCN40XqArsJYgCnNmRxhszRpuZuu?=
 =?us-ascii?Q?FLDZdsT5HvMHXH8kTEC/RunqKKQF0jvxykYHWgssUxcF3ZsrWivKM1Um2E/+?=
 =?us-ascii?Q?K7E5dWOGv1vYAibV/7Id4Dlxeeo8mlRC4ZRtVQUM/1cewItBcgR7TlCnJL2l?=
 =?us-ascii?Q?lfI6rcJiL/4mvQdvQCSFi+ImkY98XMuGxq0iipoYm+s+WfxxXVfP+/d3jklW?=
 =?us-ascii?Q?zJUiwJ3q/AzeTuLow5UUFqk2UCmr9k0LEJlXLksHTztwCoNGW7cKBHuyk/t7?=
 =?us-ascii?Q?yf9af3sjonIrMtwj26L5xBEmk0XTl+kGlr9FYpiVEZYq+e33HTP3PHrBfPu9?=
 =?us-ascii?Q?zGy0e0K2nWWrOWiWwi1MJ5/ps41dDYKOWSKC3bG+HMd4lfwS/0zDxfG4Yo1F?=
 =?us-ascii?Q?dFsA9Hrh2oF45dlQGELcWJJh/rcB9VPETeLv2/3gsOUN100nbrjoeXRqCcBV?=
 =?us-ascii?Q?T0s3f31ki126s0H+HVYeE8cLBe1UVV1TXowoXnuqDHF2m7cftem/HsRSHMW4?=
 =?us-ascii?Q?iqa85WnI1znteDryJ8u3Nvm1xr346SBe4ZUVlDSO7Y2Dp+7eyEi4gwvtzuKd?=
 =?us-ascii?Q?N8D7OFNoR76cfnd1U1zsnyNZivTsC6K2ErCcY4yjHrfxANM11ritwm8ELV1J?=
 =?us-ascii?Q?B7Yqx25hcPls9ZTIv2ABUV3aiWRTlI5U4YtHfni/QSoxumKwqh22neehNOWb?=
 =?us-ascii?Q?fXZ+SmUx3DrWMZcNIxwRrHnlDNX2AKBGbCUTHc00w+plX2gtZU36sVWkKc/3?=
 =?us-ascii?Q?BCjh4AJCe0k2HUcfvzoYxH0gf1k0RMNijvGlNSvAeqITfy7AFSHeZxY++Yen?=
 =?us-ascii?Q?JqGmQWE1trRJvXkY5vZnJparjB4k0tA2AM7dwjmFEHZJo4Js02j9tRHmTKO0?=
 =?us-ascii?Q?+RRUrDuY/nXqIXX3MpipJCGW+w+3HXptvP3/PJg+kA87MKXJ8Q1yMKo09Zxv?=
 =?us-ascii?Q?d8+LMhwYvYbcWIWrMP0KWa31eBPFW/Z2ak9Bl72gdsxmD7YqfJp2hpKyndt5?=
 =?us-ascii?Q?Gl8cmT2TWr01+I1boOPPCrtTvWA1g246QSXChoR7ECdN5jB+LTogx19ju22w?=
 =?us-ascii?Q?oFfS+5BkAI3LtvU7QOe+Iw0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ambarella.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB4024.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b5170c1-866f-4340-4141-08d997963a3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2021 09:02:52.5399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3ccd3c8d-5f7c-4eb4-ae6f-32d8c106402c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uClhzCeK4MxYY9mAzfAhD0V7G/PalLTJp3fK5AaR7HJQFlQV1htBQUWBWU/6w+DygxIhw4JPcMpqK17zOEbUvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR19MB3735
X-Proofpoint-ORIG-GUID: ZBuJwLGOOoAT4iAOPk1i2xZMlnth5lGJ
X-Proofpoint-GUID: ZBuJwLGOOoAT4iAOPk1i2xZMlnth5lGJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-25_02,2021-10-25_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 clxscore=1015 malwarescore=0 mlxlogscore=340 bulkscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110250053
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> [   81.634065][    T7] nvme nvme0: Shutdown timeout set to 8 seconds
> [   81.674332][    T7] nvme nvme0: 1/0/0 default/read/poll queues
> [  112.168136][  T256] nvme nvme0: I/O 12 QID 1 timeout, disable controll=
er

I/O 12 QID 1 is nvme_cmd_write, reproduce after rebooting and using ftrace:

# dmesg | grep QID
[   99.456260] nvme nvme0: I/O 128 QID 1 timeout, disable controller
# grep "qid=3D1" /sys/kernel/tracing/trace | egrep "cmdid=3D128\b"
    kworker/0:1H-65      [000] ....    68.987492: nvme_setup_cmd: nvme0: di=
sk=3Dnvme0n1, qid=3D1, cmdid=3D128, nsid=3D1, flags=3D0x0, meta=3D0x0, cmd=
=3D(nvme_cmd_write slba=3D216856, len=3D1015, ctrl=3D0x0, dsmgmt=3D0, refta=
g=3D0)
          <idle>-0       [001] ..s1    99.475164: nvme_complete_rq: nvme0: =
disk=3Dnvme0n1, qid=3D1, cmdid=3D128, res=3D0x0, retries=3D1, flags=3D0x1, =
status=3D0x371

Regards,
Li

**********************************************************************
This email and attachments contain Ambarella Proprietary and/or Confidentia=
l Information and is intended solely for the use of the individual(s) to wh=
om it is addressed. Any unauthorized review, use, disclosure, distribute, c=
opy, or print is prohibited. If you are not an intended recipient, please c=
ontact the sender by reply email and destroy all copies of the original mes=
sage. Thank you.
