Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE63727150
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jun 2023 00:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjFGWLW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Jun 2023 18:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjFGWLV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Jun 2023 18:11:21 -0400
X-Greylist: delayed 1755 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 07 Jun 2023 15:11:17 PDT
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7652519AA
        for <linux-pci@vger.kernel.org>; Wed,  7 Jun 2023 15:11:17 -0700 (PDT)
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357F7chn009877;
        Wed, 7 Jun 2023 14:41:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=oUayXbHPdkn7QnmYsp9P3lHfH1Ib7l7+trA+gxlUVSg=;
 b=h1Qb4sx1Pp3EjDYnbgs2h2EewU9fVTxv9ta2ncKaAH4sVSUfwtRxGtXXmkO4C9BlJqyT
 K6RUdPjpvoM15yDy4vZRe6f+OUrDSU3eKG4NlHjP5BAvxVjgNtUVdRF0tH0eq4vScP92
 9TRlQOFqkDb036JX+lQNzlYvUnU03LSVSYp12xar4GYxMMRtgzQLa55pnF9GHXpO4Jb2
 6m2ftRxYu/XUGRKUxqsNQiKDMfp3nZ18esPawpixLBotOIHfW5ep27fXKG/zy0P66ZVo
 izGPBHe2GDlCywd3K98Fr73opID/I9pWHN4vtXmbxMJV27BGPLc7sHxSkAQC7BhduywY 3w== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3r2a88arnj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jun 2023 14:41:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMWZ+yLdSR1NWw7lDs0FCn60Hk4+gfXNbmRxz127IkdDncrZzCZj7DEUJN9mkGzW/mvyTr4Umaov/9mmeV2jvcfTBSLfyR156PQH00i5fJAYl53CnDU1Es+lk5tChE9L6IzKSOfdt2LjMqfK1013Xlc2eJeyvAXwDBqlrwSLUGWV9sbB11dhFPDlbFyGe4rhO0FhAUaMaevNeMzqXOXZT43Nnr74HSRIUTvoLIFPThMOTj2wrRlVXgtBdFcXQ6omg1trJMLYM5zQt4wQ4tFoCULnouOF1DtY3Pl6fsMEqQ3D5AX25HYJVtHa1yrMXYc1nmQAPEyEI0+rzDzh2Cmu5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oUayXbHPdkn7QnmYsp9P3lHfH1Ib7l7+trA+gxlUVSg=;
 b=IZmbMIJOfMZu4yAo2eXdgh4KPGxeZ2PifpNEMcc+ZdVr5vpIciDAq/bY4JIj+yfVo8FVXpXg/BTk3CUxQSZOSWJ9mYSIeOKxpQIMsg0EilCfOevApiWYQ6N+IdO4+MUSg/+RuxDjpdYt1tji7DNOMVR0uRzqvjzPOqYoGHs1Ys9c+qA6Rd+gN12XhUw228qBT7ypGyFKoNNcs1KK9QkmdvqTAtZsS1hMCd6sjdYfS5qjM4rBxFRM1EO13C9A3jFoUI9ya9hRJJ+6lWQvZfe8tSJwFbqvMHAV+8gRsQMiHc5E+onuQ16JgaNsURArL2Kgy548Fheqa4cVmoFa+KPIvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oUayXbHPdkn7QnmYsp9P3lHfH1Ib7l7+trA+gxlUVSg=;
 b=SfPkdWVePG3RiosXtiaw8AyjFtk4aWqjYa5J2fYAuvl9FXq8VM94xsgHlUa1dig6uJD6iRD7tWMuhKV6fNzg1JQopTXONv5VHBERDX9qz8uQsT+qiTnO5wix3pltW0ALu/dZNXFWr6iHTJv1d+y3yRLDM5JZPL/AJMUN8zbMnIX0N8dALYXlgse8WK1p9ruzP1y8efY0et1v/tGYSzn0DCbDBuuKY6eUTXY3qDZUOIABWWdRd4euAo7VJi8ledz6VTLCBsfKKqEKElFrPL190HQsnijYNGLaGUO8QFpY4VDw2UNL1NwbG+FiTZZocFvFcIgpgorKJ0bswXNv7Neb8A==
Received: from BL3PR02MB7986.namprd02.prod.outlook.com (2603:10b6:208:355::19)
 by BY5PR02MB7091.namprd02.prod.outlook.com (2603:10b6:a03:21c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 21:41:46 +0000
Received: from BL3PR02MB7986.namprd02.prod.outlook.com
 ([fe80::4df2:adb6:e789:6780]) by BL3PR02MB7986.namprd02.prod.outlook.com
 ([fe80::4df2:adb6:e789:6780%6]) with mapi id 15.20.6455.034; Wed, 7 Jun 2023
 21:41:46 +0000
From:   "Kallol Biswas [C]" <kallol.biswas@nutanix.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: uefi secureboot vm and IO window overlap
Thread-Topic: uefi secureboot vm and IO window overlap
Thread-Index: AdkL/kAMfOYsiVCGQGy3hYquUACg9wAEm5qAACuQL0AAns+TgCKTH92g
Date:   Wed, 7 Jun 2023 21:41:46 +0000
Message-ID: <BL3PR02MB79863556B6F5735AD58D4DB5FE53A@BL3PR02MB7986.namprd02.prod.outlook.com>
References: <BL3PR02MB7986DFD09C363B691D7EF194FE1F9@BL3PR02MB7986.namprd02.prod.outlook.com>
 <20221213213053.GA208909@bhelgaas>
In-Reply-To: <20221213213053.GA208909@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR02MB7986:EE_|BY5PR02MB7091:EE_
x-ms-office365-filtering-correlation-id: f5cd9312-0001-4304-8252-08db679ffe10
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pkRJAW+uzg+hdmXKTinjVpKkfLTsPG98scESKh2DhomJoaEN8+Xd25ECeq24Y9YhKLh9J5rzliF71mbEyXZ7Iyczw6GAXz/HnMCqwqsq0m1vkxgtYsORNSRbIlvkymLOULoCT4vDtWFH3jEKNxJy1FkqD7tpDB0Q/rVPht+TCWXefFbr1/H2GPIJ9TihJe3u9SmIDw7Fs2IQB1xQdpEa1tCtR6oNpACZRXH75bzJpY7fcktxYUkzS1k3/Wn5FU0V6Gk4XAQHTLGyRD/ABSA8v3sKGC2NP5AefKSWMv8vRd/8/OGwEb60rL6wWMeOL0TFwaUMPWPiIhKFmTtUDbCrpRApfmlmT8YYYd82LxFvyqESYN7uHoEoM04qo1okUOQGCd9DhtHGoz+QtcwJ1VvaarDqFIkmje/EjsQZdzOtXgvarnlUNXRh0/4xc7ZW0unLqDL2Oet7sD6ZQA4V+iWhLmYbnLx0eDeJwoXEvY8+OTXwA5ZNf4aZTXTUrnMj71jbg2isyolH6laZHOa4zgu8ME3cYXTrCTzJGxN4uWfdFD5pYHbxD1H05qXhYff0rcvB8jeplc5s0zHAJwwHIPwW3y0CGNm4vxBPwGyAw9MfNo7M8a40QBrhPeKKYVdoatA1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR02MB7986.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(396003)(136003)(39850400004)(346002)(451199021)(66946007)(478600001)(64756008)(76116006)(6916009)(4326008)(8676002)(316002)(2906002)(41300700001)(8936002)(66556008)(66446008)(52536014)(5660300002)(66476007)(7696005)(71200400001)(6506007)(26005)(9686003)(53546011)(186003)(38100700002)(55016003)(83380400001)(33656002)(86362001)(38070700005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NHcCDBAKprZUTJub7coPnlCQBEybZSeMK6jxfIbd2+wZCj3QerGrDRsPcQIi?=
 =?us-ascii?Q?fh/oyeyFVBJjnzFcRXzcleqAKdCALXUZ5avZS1tgwLkBcOjoWIlstNXhjPg1?=
 =?us-ascii?Q?KXdoOzaG0X0apExpoZY8uT1CkumJfbq92DQEnhzim8SJF1ArVwQWJDXjx7yp?=
 =?us-ascii?Q?j3BOfSJ/ls2trcz1Xm2TGNRx/OJwFq2hYq/wzztsPbma6QNRk/Yqd5JMZ0O5?=
 =?us-ascii?Q?EIzK3Na5moh/+GUjNH8QLvLuwCERrwVutVhWHADFB8/gkzx9p0qBJJAmTAt8?=
 =?us-ascii?Q?8ADxeE32+oBwDlG95Mg0bE+KvYUua7YS+oSc5ouDZrEapDDx8RbTL4LeMDwz?=
 =?us-ascii?Q?u/VH8UxZtOGnrgXS1dZ7SSeKEDWyNe7Ion4KydBIbSxr6Iym+7IC2XS7pNQr?=
 =?us-ascii?Q?fn8LW57ktMQQ1BLbLZx+MkTjoXGTVN4aALL1Ndv6CfH90G3cq87vZDOOrqAk?=
 =?us-ascii?Q?4v0LJmjCBfPauwK4lMEYPChtJ5J8PXiAjpwVrVDuDSitoOKxIG/9+WKLuaxv?=
 =?us-ascii?Q?SMD11VS0gksd7BpYKV/bmqeKyjDz2hQjoG3lnuMmvTypExvAMziHVUElGBIN?=
 =?us-ascii?Q?kmrEUjNn9DAf/yYBGiiYsbqTtobjOy4xSuTkbzf2FZExoeaqdazT+Qg+9oB1?=
 =?us-ascii?Q?KI8K8oBknsPKN8q2bjrfDHAPbVkHxmYAhYwguJoo0xy07aqxRzMMp6Gra5pb?=
 =?us-ascii?Q?o9uKciBTWugRcLC/aEn1fR3VMUx5DrS+k6OApRFMLy7yxGz0RH7S1BwAmB0K?=
 =?us-ascii?Q?MJyXJnzCp2YRIcFj7iJz+dfOZWynft/GQxcaE3LyxXh4x+M+VWXTS+/Rhijz?=
 =?us-ascii?Q?MzPx0oUzPKsZp6H6wPpiWYwLRnYwIkntg6SlkjC+G1n0jQSn2+NzL43KoAv/?=
 =?us-ascii?Q?shWTOxJV2xgAE2nLNQlZii59jCtSxix9odX5cw0ckJfDU9vQLK+2GNuPGBRn?=
 =?us-ascii?Q?Tq0iswOsblK6m1szSM0inUY2LLpFZeYM3m9YwsUyYCyZxc1MmBrRU1f7BT4p?=
 =?us-ascii?Q?XE5PN5kr0YoPB9p6+WIsYG/eG4j2wX9JNUJjXuqJNvZbN5C73eqUKONMgZJC?=
 =?us-ascii?Q?G4dN3S37KVR5lMvlumXbSPTPgMvrpGrlloC5atRTDdgYRCf48cmU2aZuU/ze?=
 =?us-ascii?Q?dS+vgt6zayXvsMVZzNRirdnhcTQorsTc2HDaubbKMDpyFQF+IXdUZw7PD2vb?=
 =?us-ascii?Q?o69Z0yaMmmtmtVVsK4Tb5nWKvX+Zm76bOurjlG/kDARDGKNeGjNuTgg6oeaE?=
 =?us-ascii?Q?rz2eZ/7bb0c9wcE1RT59JAeSOaFk3PqPDZ6DyCCGq3rSmTRURoUlfSIla5VY?=
 =?us-ascii?Q?difjpxONDNKlIsmRVb221RBOzlDjGxnqFtmUVo71J8WsTk+ULubo3WRNluej?=
 =?us-ascii?Q?dB+rCxd7ZHB1EnGp9z7W6fOt9ousFT1trfmJAuxu5lu39Vo7siWW1LYBg5K1?=
 =?us-ascii?Q?RTT2XZnhCgSBaiY8rDuqG+CrvmWLwcDol6IPOS12Jw/nu+qoB808c3luSCx4?=
 =?us-ascii?Q?xe9ytkoi3OvaH/qDuWqoRfDqGTOiWPq3fRjQ8ans+3gkvWxOFaLu8/Z4Kzrh?=
 =?us-ascii?Q?NGI4uHv1tSArhhVYhpqCaHSV8CywAk+VkMC6Mje4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB7986.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5cd9312-0001-4304-8252-08db679ffe10
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 21:41:46.2721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fgf5s7Dw6i90z/JnFo+EZHn+gZYiwNtoDxmSh0chh2t3zRjO7wrJQ/ywOau9+mXWt2vR8TxLDHRYaNv3wYH6BdzMJaF3s5x9O/6vAPkrKWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB7091
X-Proofpoint-GUID: pO0YRT0LfCwSJ8vJ36joDiQfIQn8tM-b
X-Proofpoint-ORIG-GUID: pO0YRT0LfCwSJ8vJ36joDiQfIQn8tM-b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_11,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Bjorn,
                            I have reproduced the problem in the 6.3.6 kern=
el and debugged the source of the conflict.

Here is the OVMF log:
PciBus: Resource Map for Root Bridge PciRoot(0x0)^M
Type =3D   Io16; Base =3D 0x6000;   Length =3D 0x3000;        Alignment =3D=
 0xFFF^M
   Base =3D 0x6000;       Length =3D 0x200; Alignment =3D 0xFFF;      Owner=
 =3D PPB [00|02|02:**]^M
   Base =3D 0x7000;       Length =3D 0x200; Alignment =3D 0xFFF;      Owner=
 =3D PPB [00|02|01:**]^M
   Base =3D 0x8000;       Length =3D 0x200; Alignment =3D 0xFFF;      Owner=
 =3D PPB [00|02|00:**]^M
   Base =3D 0x8200;       Length =3D 0x40;  Alignment =3D 0x3F;       Owner=
 =3D PCI [00|1F|03:20]^M
   Base =3D 0x8240;       Length =3D 0x20;  Alignment =3D 0x1F;       Owner=
 =3D PCI [00|1F|02:20]^M
   Base =3D 0x8260;       Length =3D 0x20;  Alignment =3D 0x1F;       Owner=
 =3D PCI [00|1D|02:20]^M
   Base =3D 0x8280;       Length =3D 0x20;  Alignment =3D 0x1F;       Owner=
 =3D PCI [00|1D|01:20]^M
   Base =3D 0x82A0;       Length =3D 0x20;  Alignment =3D 0x1F;       Owner=
 =3D PCI [00|1D|00:20]^M
   Base =3D 0x82C0;       Length =3D 0x20;  Alignment =3D 0x1F;       Owner=
 =3D PCI [00|03|00:10]^M

[nutanix@localhost ~]$ lspci -s 0:2.0 -vvv
00:02.0 PCI bridge: Red Hat, Inc. QEMU PCIe Root port (prog-if 00 [Normal d=
ecode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 22
	Region 0: Memory at c1645000 (32-bit, non-prefetchable) [size=3D4K]
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
	I/O behind bridge: 00008000-00008fff [size=3D4K]
	Memory behind bridge: c1400000-c15fffff [size=3D2M]
	Prefetchable memory behind bridge: 0000084000000000-00000840000fffff [size=
=3D1M]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport
Dmesg log:
[    2.232081] pci 0000:00:02.0: PCI bridge to [bus 01]
[    2.232098] pci_read_bridge_io:base 0x8000 limit 0x8000 io_granulatiry 0=
x1000
[    2.232099] pci 0000:00:02.0:   bridge window [io  0x8000-0x8fff]
[    2.233005] pci 0000:00:02.0:   bridge window [mem 0xc1400000-0xc15fffff=
]
[    2.233034] pci 0000:00:02.0:   bridge window [mem 0x84000000000-0x84000=
0fffff 64bit

Kernel code:
static void pci_read_bridge_io(struct pci_bus *child)
{
        struct pci_dev *dev =3D child->self;
        u8 io_base_lo, io_limit_lo;
        unsigned long io_mask, io_granularity, base, limit;
        struct pci_bus_region region;
        struct resource *res;

        io_mask =3D PCI_IO_RANGE_MASK;
        io_granularity =3D 0x1000;
        if (dev->io_window_1k) {
                /* Support 1K I/O space granularity */
                io_mask =3D PCI_IO_1K_RANGE_MASK;
                io_granularity =3D 0x400;
        }


        printk("pci_read_bridge_io:base 0x%x limit 0x%x io_granulatiry 0x%x=
\n", base, limit, io_granularity);  <=3D my print
        if (base <=3D limit) {
                res->flags =3D (io_base_lo & PCI_IO_RANGE_TYPE_MASK) | IORE=
SOURCE_IO;
                region.start =3D base;
                region.end =3D limit + io_granularity - 1;
                pcibios_bus_to_resource(dev->bus, res, &region);
                pci_info(dev, "  bridge window %pR\n", res);
        }
                      =20

OVMF sets the base for 0:2.0 as 0x8000 and length as 0x200 but kernel io_gr=
anularity is 0x1000
So, the bridge window becomes 0x8000 to 0x8fff, which overlaps the OVMF pro=
grammed IO base
registers for other endpoints.

[    2.996029] pci 0000:00:03.0: can't claim BAR 0 [io  0x82c0-0x82df]: add=
ress conflict with PCI Bus 0000:01 [io  0x8000-0x8fff]
[    2.996049] pci 0000:00:1d.0: can't claim BAR 4 [io  0x82a0-0x82bf]: add=
ress conflict with PCI Bus 0000:01 [io  0x8000-0x8fff]
[    2.996058] pci 0000:00:1d.1: can't claim BAR 4 [io  0x8280-0x829f]: add=
ress conflict with PCI Bus 0000:01 [io  0x8000-0x8fff]
[    2.996068] pci 0000:00:1d.2: can't claim BAR 4 [io  0x8260-0x827f]: add=
ress conflict with PCI Bus 0000:01 [io  0x8000-0x8fff]
[    2.996093] pci 0000:00:1f.2: can't claim BAR 4 [io  0x8240-0x825f]: add=
ress conflict with PCI Bus 0000:01 [io  0x8000-0x8fff]
[    2.996997] pci 0000:00:1f.3: can't claim BAR 4 [io  0x8200-0x823f]: add=
ress conflict with PCI Bus 0000:01 [io  0x8000-0x8fff]

Sorry, did not get time to debug this before.

Question, why does the kernel set IO granularity to 4k?


Kallol

-----Original Message-----
From: Bjorn Helgaas <helgaas@kernel.org>=20
Sent: Tuesday, December 13, 2022 1:31 PM
To: Kallol Biswas [C] <kallol.biswas@nutanix.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: uefi secureboot vm and IO window overlap

On Sat, Dec 10, 2022 at 05:45:50PM +0000, Kallol Biswas [C] wrote:
> The part1 of the dmesg:
>=20
> [    0.000000] Initializing cgroup subsys cpuset
> [    0.000000] Initializing cgroup subsys cpu
> [    0.000000] Initializing cgroup subsys cpuacct
> [    0.000000] Linux version 3.10.0-957.el7.x86_64 (mockbuild@kbuilder.bs=
ys.centos.org) (gcc version 4.8.5 20150623 (Red Hat 4.8.5-36) (GCC) ) #1 SM=
P Thu Nov 8 23:39:32 UTC 2018

Is there any chance you can reproduce the problem on a current kernel?
If it's been fixed by now, maybe we could identify the fix and you could ba=
ckport it?

Bjorn
