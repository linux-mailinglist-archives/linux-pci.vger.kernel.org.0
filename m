Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E430648898
	for <lists+linux-pci@lfdr.de>; Fri,  9 Dec 2022 19:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiLISor (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Dec 2022 13:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiLISoq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Dec 2022 13:44:46 -0500
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B0056542
        for <linux-pci@vger.kernel.org>; Fri,  9 Dec 2022 10:44:45 -0800 (PST)
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B9GjUI3022339
        for <linux-pci@vger.kernel.org>; Fri, 9 Dec 2022 10:44:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=proofpoint20171006;
 bh=zL609ftBT3hRnuuczQl0pstpsj1tqHz5yfa+2sVUjX4=;
 b=QEGQxcR/EOZzyyF+PzMg5nQLL8g26T2Waw2H82/WslJDYm89qMSYxAK2hibQTYErveoo
 YgV2MhWFK8hp18kBt1R1OVVxLk5TiXadI7sIASPKUiaC8bLykCimPsN1FTqFpXl9R6vt
 xbOBKnLHRFCFrve7BJ3KoiMYeUsZsMDcL5V7V69cD01JhiQBlRLAuwruJkybl3/0djIJ
 G3BJFbhYhX/sTpSi2UKfg0CPOAUIkar6o4Mv9lxd4Jp2C2wde6DBI7axwgGxkZ1c8x5U
 52ujrP+VxWgCdfcoXElwwotemWvbRL45hFvldcMdeUxC/ckdt1oCusil8YBgg6ml8Dk3 Vg== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3m838dqb9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Fri, 09 Dec 2022 10:44:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGb/PxM3qXPqIna5SYJbA0iu7V29w7z/W5hLI3AgqNwXiAmnMdpsc5jjD2TS9Gz2rqMqc81i40inBl48DZNzyjeAAwDdxmqNVxk2kEfY4T0lIUDOmKNqG/zjI+brIlI9/rRK4xSm8Qu7VYOHbV4cGWz9RM65+nbmHBfWliFvEX5JX3rfsVdL68K5ksF2jtuEYxjXQGE5xMUhKG7Vodhat6LbxW9ErA2NICusDkyQWKf3dNIMNpIX5av9lLOVmFdRR4bLs8e06DnXtlPS1KGt89elfcB4BvCBcPLBJjk9LPVzkzlLjU5geUXWEK72W4wHyuCEv2q/sE9HK+ouVQxXNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zL609ftBT3hRnuuczQl0pstpsj1tqHz5yfa+2sVUjX4=;
 b=eSn/+KSWNMAdok2N1KwTkrbVxa6PR1pR48UZGBTmkRmHfBsEPIEEOpS5qSiTZpQH2dkhNUfvqypJ3tYacuuiCTpKA68g14D0BlhWqvET13AgghyDsjiJgX08T1bddod/PxAfmjOdIouYgRwu/2NHLKJFjNcinQaS+VHYt6CXzaCoDegoIIDecR0T9V9Mus4ZfteX1ufBcNeTf2G/sIw+UuUbQMuKng05eYl7TAe+tb73Rykse5rsc3aGGFY7Xb/FDWtvO2gNOL9lCihBqdyWyNfaynXjvNk/qzuZmUrXZB3fduuXxfVt+9x0+wYyLVm9HzqtWXFozQwtj+J1fY6P3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zL609ftBT3hRnuuczQl0pstpsj1tqHz5yfa+2sVUjX4=;
 b=wpZd84DE4Ajcex2JRH4tj/GiMbrv4vtYKQaIVZcSjU6dIXkXjA7jxRhnw+aJWJzXkfQ2TMqgGBIw9XwJSHAqOx+1ArOLe6+bP/T5G7Ci57V1sW9HmVHQHJdH9E7wAabbMGqkTn4PbGJKJFhHWlZwA9znsjOV/C0KpO2FbRCHKG65/KmC0L8D1DCud5HoUXZDH1xPUamGYrl1pLZvQRsb9sp10bzhNDJJDhkNCsKCzFicgvssIkjK24+DwNXNTP0238PrdYZD1o+ngMYHw5PU8p847avYS89G/NWH17T7tH6Qz7WveLt6u2ZmT/CML+l7BWQ3nqGB8k36FkITrHKTEA==
Received: from BL3PR02MB7986.namprd02.prod.outlook.com (2603:10b6:208:355::19)
 by IA0PR02MB9464.namprd02.prod.outlook.com (2603:10b6:208:408::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.18; Fri, 9 Dec
 2022 18:44:42 +0000
Received: from BL3PR02MB7986.namprd02.prod.outlook.com
 ([fe80::446d:8a7c:9ae1:1b4c]) by BL3PR02MB7986.namprd02.prod.outlook.com
 ([fe80::446d:8a7c:9ae1:1b4c%4]) with mapi id 15.20.5880.016; Fri, 9 Dec 2022
 18:44:42 +0000
From:   "Kallol Biswas [C]" <kallol.biswas@nutanix.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: uefi secureboot vm and IO window overlap
Thread-Topic: uefi secureboot vm and IO window overlap
Thread-Index: AdkL/kAMfOYsiVCGQGy3hYquUACg9w==
Date:   Fri, 9 Dec 2022 18:44:42 +0000
Message-ID: <BL3PR02MB798651506589044302A23DFAFE1C9@BL3PR02MB7986.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR02MB7986:EE_|IA0PR02MB9464:EE_
x-ms-office365-filtering-correlation-id: ac3257c2-ad06-4807-af35-08dada156f98
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dHg4lkBa+LcHpMUzcT+xZmJsmy61LGvLd1gA1TkKMhPXKCklXyzAslu7e0axrDMrgvbN2Sk9q6A1f3Vxw0rWrAWj+lQ2+0oSgykVV9W+Y24MUQKL7X6gnixKNgAyFOHifagL0G0CvebrItmhzNGsdCxRg7Vo5tkYuXJp+ictc1gQb9I4ksSklcImXFw0eUBc94gMlokv4/UUP4cCABb7QiqyTN1Lli+u+rG+pf/RCEKtKzqYcEM0IKhYkPvO/MrlmbHq06F2BMMNlPuJR8vgu03LM6gb1Y+02vCbLhXDSmPkoJUc77YrZlEd+zjrmtu/kPcWnMIvUaHzU4NRIOXntJsjFh1PtTzo0JzZb+MkvmrKMUSR/RJPd3XQUoVeNbZa9jwd4/f0jpG8dyPAtNjCtIYTjOIYR+8raJprgCCQvPZ9tBwkvTRzwigt4kyaXuZLsp1A8R3VpfqB4YsVPeIyQW6MoT5vnGac8VGG28iiHwB38XTosYmwXw8WxcmJ6EWWpJX37rQhqJaV5ZIhVWmlJiQ5UCN+DTIo+xHuy8yFnWsTn9o1lzcMXQsZmFjVjhILcK2cIbK+dcf/7WRPmm1kXF+LkV7GZzCpLsJZJL+xQTnjwqbC487A+XC1G4Tbt/7blxJJJvNOEFFbFE9egC3A/SvSiqBaZ1ABMbGfMw5/EbGsQMycnzL54VviAf6gL693frXgofQxS0C9FDTBrJ8qiA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR02MB7986.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(366004)(39860400002)(136003)(346002)(451199015)(478600001)(9686003)(26005)(2906002)(6506007)(7696005)(41300700001)(66556008)(66946007)(66476007)(64756008)(86362001)(76116006)(8676002)(38070700005)(66446008)(316002)(6916009)(122000001)(55016003)(71200400001)(5660300002)(33656002)(52536014)(38100700002)(8936002)(40140700001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lHFiV3yIGeSG/K+lU6vM+rVSkCZPZAGldlg1vA06I5ImnQEhTL2H4OVbUA?=
 =?iso-8859-1?Q?1IBCN2KApszpaACsWGfQeV9dLK6clbITKpU67nAze1yFPu+ofDkvKGdw4Q?=
 =?iso-8859-1?Q?MmQjkKrHSqtLb3kFDY3CB2JWFxyxPB8OicqhB3we4GSQ5DJSSm8Eo7yWnp?=
 =?iso-8859-1?Q?ZT98qG4ib/Bb+oV81/rD23OVc1+HtHUXsqo5p4LtELB0RxTmT3DU18jASH?=
 =?iso-8859-1?Q?U4pVKyZxSD/KD3WSbWJ4PNWsXodg1EWYIOahsR2fc9W1O/czJcDcOtxITv?=
 =?iso-8859-1?Q?GhJaSF5lR69y+LTGsRP3Tb+tag1dzhJldgvdbT0UuI/if0PxkKqt20Nr1R?=
 =?iso-8859-1?Q?NPK2GoRyczKyK5iRs5lRIzE/G7dz1HQuq9YoIo3GP4Pi7DnCv3LBtJEYXK?=
 =?iso-8859-1?Q?ObXsIp/VwYmInmre6xuAQPZAhx/P38/HOlcfWEhVD7dTCZRuS+AJhkfqnH?=
 =?iso-8859-1?Q?CWX1zG3AnI4RllW+1Kife76Ck417HjUhABqItMpg0gGdjKKCjv0TPak2Y2?=
 =?iso-8859-1?Q?eRR+MMQeCKf5oiHgBze3aeO9XBoEpT4JxQKixwyv3d0FgxHmOH2t5v2/uV?=
 =?iso-8859-1?Q?0ZvI/jjvBtbJlukyq011cYnOrHXLrx1IOrSY6TQUtsWA5UEqG1i+uW6er3?=
 =?iso-8859-1?Q?DDTdgMc5urFf7uPagWFA/wwAU4ViH+8JOamZrfutYidUwcm0s2MpvQ/0zt?=
 =?iso-8859-1?Q?8WOeQz7nduYtefPlqiUYjSKhbLs4IixQD57lVktLym/y3oXHnmIoiM3fVh?=
 =?iso-8859-1?Q?Nx4ihTJnlFNEjtJ2FNiQWWMwWsEda8sXnidqUJXASHrzRtS9x0zE1Am52r?=
 =?iso-8859-1?Q?YXSILtVPSn7NG+9P6qlC1C6nW7OdNNx6XOSi79wHO3EBtcuPGCE+h6sw6d?=
 =?iso-8859-1?Q?qfu4hz6o6S+R9xoMrcM4/uS/tcutKYt3B1gmhVHmLUyiK/hyBoW376e949?=
 =?iso-8859-1?Q?w1VpzIAI86dbdpQciqvTGXG5QVYo5oMMmJ4RayJlLsdmrjM2v7lDn4mk0W?=
 =?iso-8859-1?Q?X4PH3ic7tqrNfUjmQUcLK5MHUh9dGr9mqRgZ2EoncYvMaCsE3zE4NR9in9?=
 =?iso-8859-1?Q?ERcKimEnc7f2lIrImvL8jSNTSRwagRhvqR+EKAk4N0AMdVk2fIAJ5YiFwW?=
 =?iso-8859-1?Q?wjudYkNglJ7yXLtMuD+LIOw7DE+uSokM1gOChx0+sL1cKEgwQfwTQZ4BPY?=
 =?iso-8859-1?Q?f+qAAaFeJj1CtMZm141cRyihXsnO0Aakpt5JHgi5U3CwOQqhloMyhOk6yD?=
 =?iso-8859-1?Q?vk1mOYLsHFzU4Z/77PbXm7nQYBHRW6ZuTrLdUzK+Nx0hddw0irPXMc39Hk?=
 =?iso-8859-1?Q?xLErRP5RsF3HsLcpmMKSj8ytkrnSeHr0roDLu46+lejlR5lsqcsFxtnBES?=
 =?iso-8859-1?Q?Wb0d1ebOYzLwW3JjXu9sblLfAipbt23Ejdf2vcHHUcICg8VPM8l9yn2g3R?=
 =?iso-8859-1?Q?jBIQEWLSMZBVyPIJ1NzOd2cScIcZHYYLtJEHiIGbzKzh/ANUVUtBKBPET3?=
 =?iso-8859-1?Q?Zo1b5syaKmvXtIgSwhi5k1ddHDAt6V+wDjaeFv0Cb4i2fjwsxffudam0zO?=
 =?iso-8859-1?Q?sSe+k7rFdd6cDNMjxYk7hs7hVpubRo05d0pd3me7F0t+b8y0t0PJB8BxyX?=
 =?iso-8859-1?Q?XS2tLcdpDFHDZTxqIi8DJdkeK7LUlfk+QnBsKUxNsgoEAMqFCy5hVa/A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB7986.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac3257c2-ad06-4807-af35-08dada156f98
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2022 18:44:42.7480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lf192wxc4fSAL/oHsmAfeeKB8PP0sCArZjrTG6YTD0rrEPA/X8sEr6x3VpGFxYAQkSgdU/rHl1jLeGaNStVfKD2SNc/MJeYw3y+zGA0R4Pk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9464
X-Proofpoint-ORIG-GUID: YB9nsVaT5pgHnGOuRtNjq7G3jKWXdiUv
X-Proofpoint-GUID: YB9nsVaT5pgHnGOuRtNjq7G3jKWXdiUv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-09_11,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We are observing an io window overlap issue in a secureboot enabled uefi vm=
.

Linux displays:
pci 0000:00:1d.0: can't claim BAR 4 [io=A0 0x92a0-0x92bf]: address conflict=
 with PCI Bus 0000:01 [io=A0 0x9000-0x9fff]

Eventually conflict gets resolved but we need to understand why get the con=
flict in the first place.

Details:

The VM is a uefi based VM and the issue shows up if secure boot is enabled.=
=A0 We have enabled ovmf log and uefi/ovmf programs a bridge IO window with=
 the range 0x9000-0x91ff, but in Linux we see the same bridge is programmed=
 with 0x9000-0x9fff. This results in an address conflict with subsequent de=
vices.

The PCI tree(lspci -t):
-[0000:00]-+-00.0
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0+-01.0
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0+-02.0-[01]----00.0
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0+-02.1-[02]----00.0
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0+-02.2-[03]----00.0
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0+-02.3-[04]--
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0+-1d.0
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0+-1d.1
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0+-1d.2
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0+-1d.7
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0+-1f.0
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0+-1f.2
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0\-1f.3

[root@localhost ~]# lspci -vvv -s 0:02.0=A0 | grep "I/O"
=A0=A0=A0=A0=A0=A0=A0=A0Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- V=
GASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
=A0=A0=A0=A0=A0=A0=A0=A0I/O behind bridge: 00009000-00009fff [size=3D4K]
=A0lspci -vvv -s 0:1d.0 | grep "I/O"
Region 4: I/O ports at 1040 [size=3D32]

root@localhost ~]# lspci -vvv -s 01:00.0
01:00.0 Ethernet controller: Red Hat, Inc. Virtio network device (rev 01)
=A0=A0=A0=A0=A0=A0=A0=A0Subsystem: Red Hat, Inc. Device 1100
=A0=A0=A0=A0=A0=A0=A0=A0Physical Slot: 0
=A0=A0=A0=A0=A0=A0=A0=A0Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- V=
GASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
=A0=A0=A0=A0=A0=A0=A0=A0Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3D=
fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
=A0=A0=A0=A0=A0=A0=A0=A0Latency: 0
=A0=A0=A0=A0=A0=A0=A0=A0Interrupt: pin A routed to IRQ 22
=A0=A0=A0=A0=A0=A0=A0=A0Region 1: Memory at c1600000 (32-bit, non-prefetcha=
ble) [size=3D4K]
=A0=A0=A0=A0=A0=A0=A0=A0Region 4: Memory at 84000000000 (64-bit, prefetchab=
le) [size=3D16K]
=A0=A0=A0=A0=A0=A0=A0=A0Expansion ROM at c1640000 [disabled] [size=3D256K]
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [dc] MSI-X: Enable+ Count=3D3 Masked-

The uefi/ovmf log:
PciBus: HostBridge->NotifyPhase(AllocateResources) - Success=A0
Process Option ROM: BAR Base/Length =3D C1800000/40000=A0
PciBus: Resource Map for Root Bridge PciRoot(0x0)=A0
Type =3D =A0 Io16; Base =3D 0x6000;=A0 =A0 Length =3D 0x4000;=A0 =A0 Alignm=
ent =3D 0xFFF=A0
=A0=A0=A0Base =3D 0x6000;=A0 =A0 Length =3D 0x200;=A0 =A0 Alignment =3D 0xF=
FF;=A0 =A0 Owner =3D PPB [00|02|03:**]=A0
=A0=A0=A0Base =3D 0x7000;=A0 =A0 Length =3D 0x200;=A0 =A0 Alignment =3D 0xF=
FF;=A0 =A0 Owner =3D PPB [00|02|02:**]=A0
=A0=A0=A0Base =3D 0x8000;=A0 =A0 Length =3D 0x200;=A0 =A0 Alignment =3D 0xF=
FF;=A0 =A0 Owner =3D PPB [00|02|01:**]=A0
=A0=A0=A0Base =3D 0x9000;=A0 =A0 Length =3D 0x200;=A0 =A0 Alignment =3D 0xF=
FF;=A0 =A0 Owner =3D PPB [00|02|00:**]=A0
=A0=A0=A0Base =3D 0x9200;=A0 =A0 Length =3D 0x40;=A0 =A0 Alignment =3D 0x3F=
;=A0 =A0 Owner =3D PCI [00|1F|03:20]=A0
=A0=A0=A0Base =3D 0x9240;=A0 =A0 Length =3D 0x20;=A0 =A0 Alignment =3D 0x1F=
;=A0 =A0 Owner =3D PCI [00|1F|02:20]=A0
=A0=A0=A0Base =3D 0x9260;=A0 =A0 Length =3D 0x20;=A0 =A0 Alignment =3D 0x1F=
;=A0 =A0 Owner =3D PCI [00|1D|02:20]=A0
=A0=A0=A0Base =3D 0x9280;=A0 =A0 Length =3D 0x20;=A0 =A0 Alignment =3D 0x1F=
;=A0 =A0 Owner =3D PCI [00|1D|01:20]=A0
=A0=A0=A0Base =3D 0x92A0;=A0 =A0 Length =3D 0x20;=A0 =A0 Alignment =3D 0x1F=
;=A0 =A0 Owner =3D PCI [00|1D|00:20]=A0
Type =3D=A0 Mem32; Base =3D 0xC0000000;=A0 =A0 Length =3D 0x1900000;=A0 =A0=
 Alignment =3D 0xFFFFFF=A0
=A0=A0=A0Base =3D 0xC0000000;=A0 =A0 Length =3D 0x1000000;=A0 =A0 Alignment=
 =3D 0xFFFFFF;=A0 =A0 Owner =3D PCI [00|01|00:10]; Type =3D PMem32=A0
=A0=A0=A0Base =3D 0xC1000000;=A0 =A0 Length =3D 0x200000;=A0 =A0 Alignment =
=3D 0x1FFFFF;=A0 =A0 Owner =3D PPB [00|02|03:**]=A0
=A0=A0=A0Base =3D 0xC1200000;=A0 =A0 Length =3D 0x200000;=A0 =A0 Alignment =
=3D 0x1FFFFF;=A0 =A0 Owner =3D PPB [00|02|02:**]=A0
=A0=A0=A0Base =3D 0xC1400000;=A0 =A0 Length =3D 0x200000;=A0 =A0 Alignment =
=3D 0x1FFFFF;=A0 =A0 Owner =3D PPB [00|02|01:**]=A0
=A0=A0=A0Base =3D 0xC1600000;=A0 =A0 Length =3D 0x200000;=A0 =A0 Alignment =
=3D 0x1FFFFF;=A0 =A0 Owner =3D PPB [00|02|00:**]=A0
=A0=A0=A0Base =3D 0xC1800000;=A0 =A0 Length =3D 0x40000;=A0 =A0 Alignment =
=3D 0x3FFFF;=A0 =A0 Owner =3D PCI [00|00|00:00]; Type =3D=A0 OpRom=A0
=A0=A0=A0Base =3D 0xC1840000;=A0 =A0 Length =3D 0x1000;=A0 =A0 Alignment =
=3D 0xFFF;=A0 =A0 Owner =3D PCI [00|1F|02:24]=A0
=A0=A0=A0Base =3D 0xC1841000;=A0 =A0 Length =3D 0x1000;=A0 =A0 Alignment =
=3D 0xFFF;=A0 =A0 Owner =3D PCI [00|1D|07:10]=A0
=A0=A0=A0Base =3D 0xC1842000;=A0 =A0 Length =3D 0x1000;=A0 =A0 Alignment =
=3D 0xFFF;=A0 =A0 Owner =3D PPB [00|02|03:10]=A0
=A0=A0=A0Base =3D 0xC1843000;=A0 =A0 Length =3D 0x1000;=A0 =A0 Alignment =
=3D 0xFFF;=A0 =A0 Owner =3D PPB [00|02|02:10]=A0
=A0=A0=A0Base =3D 0xC1844000;=A0 =A0 Length =3D 0x1000;=A0 =A0 Alignment =
=3D 0xFFF;=A0 =A0 Owner =3D PPB [00|02|01:10]=A0
=A0=A0=A0Base =3D 0xC1845000;=A0 =A0 Length =3D 0x1000;=A0 =A0 Alignment =
=3D 0xFFF;=A0 =A0 Owner =3D PPB [00|02|00:10]=A0
=A0=A0=A0Base =3D 0xC1846000;=A0 =A0 Length =3D 0x1000;=A0 =A0 Alignment =
=3D 0xFFF;=A0 =A0 Owner =3D PCI [00|01|00:18]=A0
Type =3D=A0 Mem64; Base =3D 0x84000000000;=A0 =A0 Length =3D 0x300000;=A0 =
=A0 Alignment =3D 0xFFFFF=A0
=A0=A0=A0Base =3D 0x84000000000;=A0 =A0 Length =3D 0x100000;=A0 =A0 Alignme=
nt =3D 0xFFFFF;=A0 =A0 Owner =3D PPB [00|02|00:**]; Type =3D PMem64=A0
=A0=A0=A0Base =3D 0x84000100000;=A0 =A0 Length =3D 0x100000;=A0 =A0 Alignme=
nt =3D 0xFFFFF;=A0 =A0 Owner =3D PPB [00|02|01:**]; Type =3D PMem64=A0
=A0=A0=A0Base =3D 0x84000200000;=A0 =A0 Length =3D 0x100000;=A0 =A0 Alignme=
nt =3D 0xFFFFF;=A0 =A0 Owner =3D PPB [00|02|02:**]; Type =3D PMem64=A0

PciBus: Resource Map for Bridge [00|02|00]=A0
Type =3D =A0 Io16; Base =3D 0x9000;=A0 =A0 Length =3D 0x200;=A0 =A0 Alignme=
nt =3D 0xFFF=A0
=A0=A0=A0Base =3D Padding;=A0 =A0 Length =3D 0x200;=A0 =A0 Alignment =3D 0x=
1FF=A0
Type =3D=A0 Mem32; Base =3D 0xC1600000;=A0 =A0 Length =3D 0x200000;=A0 =A0 =
Alignment =3D 0x1FFFFF=A0
=A0=A0=A0Base =3D Padding;=A0 =A0 Length =3D 0x200000;=A0 =A0 Alignment =3D=
 0x1FFFFF=A0
=A0=A0=A0Base =3D 0xC1600000;=A0 =A0 Length =3D 0x1000;=A0 =A0 Alignment =
=3D 0xFFF;=A0 =A0 Owner =3D PCI [01|00|00:14]=A0
Type =3D=A0 Mem32; Base =3D 0xC1845000;=A0 =A0 Length =3D 0x1000;=A0 =A0 Al=
ignment =3D 0xFFF=A0
Type =3D PMem64; Base =3D 0x84000000000;=A0 =A0 Length =3D 0x100000;=A0 =A0=
 Alignment =3D 0xFFFFF=A0
=A0=A0=A0Base =3D 0x84000000000;=A0 =A0 Length =3D 0x4000;=A0 =A0 Alignment=
 =3D 0x3FFF;=A0 =A0 Owner =3D PCI [01|00|00:20]=A0

PciBus: Resource Map for Bridge [00|02|01]=A0
Type =3D =A0 Io16; Base =3D 0x8000;=A0 =A0 Length =3D 0x200;=A0 =A0 Alignme=
nt =3D 0xFFF=A0
=A0=A0=A0Base =3D Padding;=A0 =A0 Length =3D 0x200;=A0 =A0 Alignment =3D 0x=
1FF=A0
Type =3D=A0 Mem32; Base =3D 0xC1400000;=A0 =A0 Length =3D 0x200000;=A0 =A0 =
Alignment =3D 0x1FFFFF=A0
=A0=A0=A0Base =3D Padding;=A0 =A0 Length =3D 0x200000;=A0 =A0 Alignment =3D=
 0x1FFFFF=20


=A0=A0=A0Base =3D 0xC1400000;=A0 =A0 Length =3D 0x1000;=A0 =A0 Alignment =
=3D 0xFFF;=A0 =A0 Owner =3D PCI [02|00|00:14]=A0
Type =3D=A0 Mem32; Base =3D 0xC1844000;=A0 =A0 Length =3D 0x1000;=A0 =A0 Al=
ignment =3D 0xFFF=A0
Type =3D PMem64; Base =3D 0x84000100000;=A0 =A0 Length =3D 0x100000;=A0 =A0=
 Alignment =3D 0xFFFFF=A0
=A0=A0=A0Base =3D 0x84000100000;=A0 =A0 Length =3D 0x4000;=A0 =A0 Alignment=
 =3D 0x3FFF;=A0 =A0 Owner =3D PCI [02|00|00:20]=A0

PciBus: Resource Map for Bridge [00|02|02]=A0
Type =3D =A0 Io16; Base =3D 0x7000;=A0 =A0 Length =3D 0x200;=A0 =A0 Alignme=
nt =3D 0xFFF=A0
=A0=A0=A0Base =3D Padding;=A0 =A0 Length =3D 0x200;=A0 =A0 Alignment =3D 0x=
1FF=A0
Type =3D=A0 Mem32; Base =3D 0xC1200000;=A0 =A0 Length =3D 0x200000;=A0 =A0 =
Alignment =3D 0x1FFFFF=A0
=A0=A0=A0Base =3D Padding;=A0 =A0 Length =3D 0x200000;=A0 =A0 Alignment =3D=
 0x1FFFFF=A0
Type =3D=A0 Mem32; Base =3D 0xC1843000;=A0 =A0 Length =3D 0x1000;=A0 =A0 Al=
ignment =3D 0xFFF=A0
Type =3D PMem64; Base =3D 0x84000200000;=A0 =A0 Length =3D 0x100000;=A0 =A0=
 Alignment =3D 0xFFFFF=A0
=A0=A0=A0Base =3D 0x84000200000;=A0 =A0 Length =3D 0x4000;=A0 =A0 Alignment=
 =3D 0x3FFF;=A0 =A0 Owner =3D PCI [03|00|00:20]=A0

PciBus: Resource Map for Bridge [00|02|03]=A0
Type =3D =A0 Io16; Base =3D 0x6000;=A0 =A0 Length =3D 0x200;=A0 =A0 Alignme=
nt =3D 0xFFF=A0
=A0=A0=A0Base =3D Padding;=A0 =A0 Length =3D 0x200;=A0 =A0 Alignment =3D 0x=
1FF=A0
Type =3D=A0 Mem32; Base =3D 0xC1000000;=A0 =A0 Length =3D 0x200000;=A0 =A0 =
Alignment =3D 0x1FFFFF=A0
=A0=A0=A0Base =3D Padding;=A0 =A0 Length =3D 0x200000;=A0 =A0 Alignment =3D=
 0x1FFFFF=A0
Type =3D=A0 Mem32; Base =3D 0xC1842000;=A0 =A0 Length =3D 0x1000;=A0 =A0 Al=
ignment =3D 0x


The bus 1 is off 02:00.0 bridge device.
IO resource for the bridge:
Base =3D 0x9000;=A0 =A0 Length =3D 0x200;=A0 =A0 Alignment =3D 0xFFF;=A0 =
=A0 Owner =3D PPB [00|02|00:**]
The alignment is 0xfff, start 0x9000, and length 0x200. So 0x9000-0x91ff wo=
uld be sufficient for this, there would be no conflict. Linux appears to as=
sign 0x9000-0x9fff to the bridge, resulting in conflicts with subsequent de=
vices.

[root@localhost ~]# dmesg | grep conflict
[=A0 =A0 0.426170] pci 0000:00:1d.0: can't claim BAR 4 [io=A0 0x92a0-0x92bf=
]: address conflict with PCI Bus 0000:01 [io=A0 0x9000-0x9fff]
[=A0 =A0 0.426217] pci 0000:00:1d.1: can't claim BAR 4 [io=A0 0x9280-0x929f=
]: address conflict with PCI Bus 0000:01 [io=A0 0x9000-0x9fff]
[=A0 =A0 0.426228] pci 0000:00:1d.2: can't claim BAR 4 [io=A0 0x9260-0x927f=
]: address conflict with PCI Bus 0000:01 [io=A0 0x9000-0x9fff]
[=A0 =A0 0.426258] pci 0000:00:1f.2: can't claim BAR 4 [io=A0 0x9240-0x925f=
]: address conflict with PCI Bus 0000:01 [io=A0 0x9000-0x9fff]
[=A0 =A0 0.426270] pci 0000:00:1f.3: can't claim BAR 4 [io=A0 0x9200-0x923f=
]: address conflict with PCI Bus 0000:01 [io=A0 0x9000-0x9fff]
=A0Dmesg output with debug=3D1 "dyndbg=3Dfile *pci* +pfm"
=A0
[ 0.280118] probe:pci_scan_child_bus_extend: pci_bus 0000:01: fixups for bu=
s=A0
[ 0.280122] pci 0000:00:02.0: PCI bridge to [bus 01]=A0
[ 0.280141] pci 0000:00:02.0: bridge window [io 0x9000-0x9fff]=A0
[ 0.280158] pci 0000:00:02.0: bridge window [mem 0xc1600000-0xc17fffff]=A0
[ 0.280191] pci 0000:00:02.0: bridge window [mem 0x8000000000-0x80000fffff =
64bit pref]=A0
[ 0.280194] probe:pci_scan_child_bus_extend: pci_bus 0000:01: bus scan retu=
rning with max=3D01


Nucleodyne @ Nutanix
408-718-8164

