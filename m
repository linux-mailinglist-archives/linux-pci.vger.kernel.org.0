Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60F464895E
	for <lists+linux-pci@lfdr.de>; Fri,  9 Dec 2022 21:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiLIUEV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Dec 2022 15:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiLIUET (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Dec 2022 15:04:19 -0500
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293143C6FD
        for <linux-pci@vger.kernel.org>; Fri,  9 Dec 2022 12:04:18 -0800 (PST)
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B9HHvcE006073
        for <linux-pci@vger.kernel.org>; Fri, 9 Dec 2022 12:04:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=9VYKX+Q9qGIaJQOc8WKJUEgB15A+XqqxAGjSwV2wcuY=;
 b=Kd7117VzxstM/3IOJWIhEiclQlSZJc1oJjv2H+SjM7YotfoLUxIWAOLAIU0lI4Ybuy/X
 jCBu8yfPit0304C23t+N6SMm7+Pu5k2ogWH6Nrww7fBo7Wu6G371lA8bEYTrOAT7zigq
 14qAt60TdIf2CRQwrCnURTLY2xO7u8Xa2BgNVli89nU7L4M7pYllb5jfDX+wqv4p9pjY
 AHiaBn2jSHRl093wYmjLLZRhoOwraoLLok7VLOMKFj59ttn3NWONtr3HJGlcMe6AAOfr
 a4yuqcODHRBJGSL+hx2wwp6IU5n7sMuWBu/CKIvgqOT24BmHhMRigHSt+nm0eYUV2j4W 6A== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3m86w4f8x5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Fri, 09 Dec 2022 12:04:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ckdVRRhlu3l1kzv8fESg/l9S+FQcYwjvwVtOezfK4Lbt/WWWWVZd0kjCWMs0+jTPc+T+WW7XRNvUKfjZjRrw2sn/xmwHKljsArX8uRYv5by9+b6OkfxleLU+Q0r4KM0Uy+fwFAqCBgTvIHAphK2wcVsBj0QTHksU7P5i9zenQwn+jljXTy2EztHsiCzyJc0eo0S4wdxO7Ora8PPCuV9PY0EiEj6bPvHLohXmOkIdcabockZ4CVmDpuvX7inD3YIjHgEgj9A6B+Xs0RWCtaTQaSF5K+oCCWZVgVrxcV0RYBuaakIlI5MunmUz8mRpHLLAgFqvKDnC3ZLh1/mq6xPZFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VYKX+Q9qGIaJQOc8WKJUEgB15A+XqqxAGjSwV2wcuY=;
 b=E2jPIENOFLVQp84B9ctOhQ1Pm+WyjZ+pL6k5DBF3nrp4mJhrnyuzCJplpZGZKkozqCoUy5W+pn7pu9XDMY/XNFHO0vssNZGvKfTuALc2KwEeZDKbHUHRuhEjsNCtCM7FbioFteS/4tVHASHqBoDYEJqsXAP6yLPRXh5i7E5VQz6ERVMM0sRYB7VpuHmhTlE6Xh3tlE634xuVaHnJ7y0owCdHlMdqEzgUeWQbDGW/4gTqRh6qdv21J7yr3ZsZSH/lW/GRDoK8MlWCzaTEeSqqYUWqdNh34Np3E8iJLATv0I55FiPtLtSBLRZq6nSJFtZmdSYmjFup7tAOCsyyaNVFOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VYKX+Q9qGIaJQOc8WKJUEgB15A+XqqxAGjSwV2wcuY=;
 b=qGFTzBqA40tNNeuh3SpJggvmG2KyaoskdPf+Qq42Vm8tgSDo7pSrerfDps6kMtsVy00mvRsWJCIWIUzKfx5D38J3V4HUZ7UqZYJo2quFwWP181EhFmVsr6tHc/IpV8/9pcWkWExMdBNoGNN809CXyyANKkvuUny/UNQ+pGac0B7PjjnmIQEJXdMRH186sBwbSys4ZGbAJzGuMQf5FUrV10887txz64qxpLhBnT9Dk+0MRSp27UukhG1fpf2GdW3n93spBEcod5IG2GB0xbHpcJWoTmUITP/YrLmk/0OYEZiEXp4oqzQRky6arrGehMOjJ0BAiChqVJk3rSS5PmkrDA==
Received: from BL3PR02MB7986.namprd02.prod.outlook.com (2603:10b6:208:355::19)
 by SJ0PR02MB8846.namprd02.prod.outlook.com (2603:10b6:a03:3e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 20:04:15 +0000
Received: from BL3PR02MB7986.namprd02.prod.outlook.com
 ([fe80::446d:8a7c:9ae1:1b4c]) by BL3PR02MB7986.namprd02.prod.outlook.com
 ([fe80::446d:8a7c:9ae1:1b4c%4]) with mapi id 15.20.5880.016; Fri, 9 Dec 2022
 20:04:15 +0000
From:   "Kallol Biswas [C]" <kallol.biswas@nutanix.com>
To:     "Kallol Biswas [C]" <kallol.biswas@nutanix.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: uefi secureboot vm and IO window overlap
Thread-Topic: uefi secureboot vm and IO window overlap
Thread-Index: AdkL/kAMfOYsiVCGQGy3hYquUACg9wACw5qw
Date:   Fri, 9 Dec 2022 20:04:14 +0000
Message-ID: <BL3PR02MB79865FE0D1362FAD7FD96248FE1C9@BL3PR02MB7986.namprd02.prod.outlook.com>
References: <BL3PR02MB798651506589044302A23DFAFE1C9@BL3PR02MB7986.namprd02.prod.outlook.com>
In-Reply-To: <BL3PR02MB798651506589044302A23DFAFE1C9@BL3PR02MB7986.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR02MB7986:EE_|SJ0PR02MB8846:EE_
x-ms-office365-filtering-correlation-id: 6abb57d2-74af-49d3-56f7-08dada208c12
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FUWIdV2PtCmt4uBAE7oWD9rUzYzhpoew3oQSxAx2JiAKDcCVfQ6raon0MODWLyRRa6a3vYgwIKcrwU3xjb1qOnbZ/4fjChf7Foq0lzdNjgr7fy4jRY+3fm4sl85g4obLEBmW7lkhtauNXR1WKNR4htUXQeyhUFZIMufmk2aJ8iwGRq/WIrpMDQhVPpD+jaOzJ8eBnlLZALPvXT/5Mil/LpfdrE5qsvUrcEvTR42jaaSFd2ChYMHplB7hAbVfh6Wtk0yPc+Hr35KCgXA/MU6Yo09rk/FBG/50GsImI3uSlcd5HEXV3qKrn4zUeVFoWRLkFb0VFjQthLr8GVgvl2C7+chtSED3T+Rg9Eec0wKLN4D+rVreu2sVi83RxbLkIwu3fTJZQrY9IKz7XtMFAPhTm6h3OW+4mZTrGzYuJxmTK1B79Y7VMJRjKno5dREze6jlmaCzZ0pSVNEVD8xiDU7uTZEjXP8EVoIATxtOlXfs95jWhPlHWY+cLeChFP61H6ClZUzGJyDr+m2clxJx4G4+x6GY6KbpaCZp7/6hbnUxEMP2cISA8P4wS2nHgcLQ/QjitjyFUvJFsFtPIViFkOd6uPN9rsId5vbxegTvzbmTAvh6SY0ikIaey9hTU7s7wovih9xIR20iEmODc7a4puVreivr3OyiLBCap7hM85sJsv6Q/Xb1KpSs0cITEhsWrGU5fN078QViFV1L6TXgvvj8/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR02MB7986.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(39860400002)(346002)(396003)(136003)(451199015)(33656002)(40140700001)(38100700002)(8936002)(2906002)(86362001)(52536014)(41300700001)(83380400001)(38070700005)(186003)(5660300002)(66476007)(110136005)(66946007)(316002)(55016003)(26005)(66556008)(122000001)(71200400001)(478600001)(8676002)(7696005)(76116006)(64756008)(66446008)(2940100002)(53546011)(9686003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XrVqOh/9hSMXlsToJmQy3Adj+DlT33hJQZ3hqSheN9cCzHYv3g1QmVSX7M?=
 =?iso-8859-1?Q?TnPEbsSJwqQdremBjqEOtC/VBAEMTImT8R66CvPJy11ib+PSAAp4AvoZXE?=
 =?iso-8859-1?Q?S1dqhms+pK4v/yMDo42KRUL3M1zmNMAMX2LN7ZT0YW+sRnznXutbVhmFP2?=
 =?iso-8859-1?Q?pBL1ydXQKNQmy4m79irVLgkzpz3SzWmLFeJsTsHz/1IoxzKcWbUbTXlaSz?=
 =?iso-8859-1?Q?QR6NUKUz8pKimXMU9pt3gM+/LYkbZRl7PveSnrzGsZV/76oH2nDOO2SZRN?=
 =?iso-8859-1?Q?jBQ2N8R17pC0FVR6l8eKbdHNE/+c3BGoDTkGzrnyEX8YPC+awKd3CvTDQq?=
 =?iso-8859-1?Q?X7B4GmUqipd6UFUxE0TXBNPR4NW8jzHk2uVEhbrqPrOwm6J/uwizBtCqSP?=
 =?iso-8859-1?Q?M1rGucD75D2O43BaSlDMduWxNsbuT1s8JnHXvbjJtR1eKRT4sVM8+SuzWW?=
 =?iso-8859-1?Q?+kK9ziIWr9G1N//7XCZvsXoBvp05JIzFBJ+lGzQkm+XMG0bpG02QO2m0jy?=
 =?iso-8859-1?Q?a40EVtQF7eQUbZiFcxWGxyv8xiWBid//osiPUUMmVuxCbZx0cjvOkWeC1g?=
 =?iso-8859-1?Q?cgtmXecbTgDuOAXa/RBxRFCjiIOHMyc+htcmaVgDaPT0zpZrtDJH5ibgYp?=
 =?iso-8859-1?Q?/CreKkLZVz4qUCP8TI92n5qfBqI5TJgFHfalGAmwdLsHelCpKXlhT176i+?=
 =?iso-8859-1?Q?E77yYlEV2wX/Bz07mQAp2I+bSaieidjWY4nBxNF7sjI/zjlp9hIOTQLHT/?=
 =?iso-8859-1?Q?y8jymwOhBJxpx7ZOFy+9Gnz3zaZRSHBcSoyZ55k9q5csJD2aqH+6p5gxIR?=
 =?iso-8859-1?Q?zHyhBDTKSyDmYajTjLzU9b8klanQtrYNZVLmNCWm6gNNEQ57yl+4Q+Y2Bh?=
 =?iso-8859-1?Q?iNlaeMCwa7fWBw/iKEBg60ndy3pJgBelyjGY1tRJrcLWO0zJYx7LbjYNnp?=
 =?iso-8859-1?Q?/AdZJaBFU2b3usUyibA8UAnx9a1WGMOdyNadqF6+Z7toMkDNbyc/v91ho2?=
 =?iso-8859-1?Q?byDflM/xOM/zEnW6nJMRMGkWbtYHMbXc5fIs7rsbKDgfaPbO7v6liq6HSH?=
 =?iso-8859-1?Q?9DiF6TucsSdEN6EFtsrMPKrbU8jphaPqsVhSEc7YdqfNH4rXZS5nac4Hjd?=
 =?iso-8859-1?Q?JkQPG2CGo3k27QXTP52qs55gmFySrzx4YpzZzzo/wsCYSALZnkLfP6Y7bf?=
 =?iso-8859-1?Q?5dQyJzsQDvHkE6LMfo3ckWmY80Mu0wXlGKgb+f6wyQXLUBUiv4xSFj6xRP?=
 =?iso-8859-1?Q?zxZT0hC4VxZnZbZ0OGcFLRcflCyhPDuWoXLjh7m3fEfpDSQSRbCZiIaVKu?=
 =?iso-8859-1?Q?AGmniHSRCMNJb6IgELuzCCWdHszqEqjNxWUqUh1OTNU7rxSOcdZqSNwri5?=
 =?iso-8859-1?Q?nLV3EM7DBv8hB6U9ej+kuL/6mrD22XG67L2vGmRiVz0rkeBfWanIrc0yxy?=
 =?iso-8859-1?Q?xqgqmQLK/YgCxf0x/V0vmZlHT35KCvgf00h3yZ9L31pyxm59irlKlLwM8z?=
 =?iso-8859-1?Q?eaPaFy9tTSPGYrzh9l82CF+c2HdxOIjOWDZ23bVLZuLINKHWCmRsPKWkDF?=
 =?iso-8859-1?Q?CA05yuzCFm2Hq99j4gZZK/ntCwOIbxK6l7Yzeiayi1+YOj9Xlf79iBl+0o?=
 =?iso-8859-1?Q?8eppbrYRfUoCzlP+rGM40blICGoUnT+DMqoPYLYkIijgE/PPkr1l1l+g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB7986.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6abb57d2-74af-49d3-56f7-08dada208c12
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2022 20:04:14.9854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B6QiGMHY/yue/k/s8Sm18hs13gay2cDanTOEBw6wSXsG5SdFMx/UnEETNMN7fnbzvoNQP5fFPOXFDxAguKN0bxPoUYpVtnpSP93XbfreP/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8846
X-Proofpoint-GUID: m6QYkF__BclfxAhl7fs5cerdxc0sNfhm
X-Proofpoint-ORIG-GUID: m6QYkF__BclfxAhl7fs5cerdxc0sNfhm
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

Reproduced the issue with Q35 machine type and turning off secureboot.
Debugging will be easier now.

-----Original Message-----
From: Kallol Biswas [C] <kallol.biswas@nutanix.com>=20
Sent: Friday, December 9, 2022 10:45 AM
To: linux-pci@vger.kernel.org
Subject: uefi secureboot vm and IO window overlap

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
PciBus: HostBridge->NotifyPhase(AllocateResources) - Success Process Option=
 ROM: BAR Base/Length =3D C1800000/40000
PciBus: Resource Map for Root Bridge PciRoot(0x0) Type =3D =A0 Io16; Base =
=3D 0x6000;=A0 =A0 Length =3D 0x4000;=A0 =A0 Alignment =3D 0xFFF
=A0=A0=A0Base =3D 0x6000;=A0 =A0 Length =3D 0x200;=A0 =A0 Alignment =3D 0xF=
FF;=A0 =A0 Owner =3D PPB [00|02|03:**]
=A0=A0=A0Base =3D 0x7000;=A0 =A0 Length =3D 0x200;=A0 =A0 Alignment =3D 0xF=
FF;=A0 =A0 Owner =3D PPB [00|02|02:**]
=A0=A0=A0Base =3D 0x8000;=A0 =A0 Length =3D 0x200;=A0 =A0 Alignment =3D 0xF=
FF;=A0 =A0 Owner =3D PPB [00|02|01:**]
=A0=A0=A0Base =3D 0x9000;=A0 =A0 Length =3D 0x200;=A0 =A0 Alignment =3D 0xF=
FF;=A0 =A0 Owner =3D PPB [00|02|00:**]
=A0=A0=A0Base =3D 0x9200;=A0 =A0 Length =3D 0x40;=A0 =A0 Alignment =3D 0x3F=
;=A0 =A0 Owner =3D PCI [00|1F|03:20]
=A0=A0=A0Base =3D 0x9240;=A0 =A0 Length =3D 0x20;=A0 =A0 Alignment =3D 0x1F=
;=A0 =A0 Owner =3D PCI [00|1F|02:20]
=A0=A0=A0Base =3D 0x9260;=A0 =A0 Length =3D 0x20;=A0 =A0 Alignment =3D 0x1F=
;=A0 =A0 Owner =3D PCI [00|1D|02:20]
=A0=A0=A0Base =3D 0x9280;=A0 =A0 Length =3D 0x20;=A0 =A0 Alignment =3D 0x1F=
;=A0 =A0 Owner =3D PCI [00|1D|01:20]
=A0=A0=A0Base =3D 0x92A0;=A0 =A0 Length =3D 0x20;=A0 =A0 Alignment =3D 0x1F=
;=A0 =A0 Owner =3D PCI [00|1D|00:20] Type =3D=A0 Mem32; Base =3D 0xC0000000=
;=A0 =A0 Length =3D 0x1900000;=A0 =A0 Alignment =3D 0xFFFFFF
=A0=A0=A0Base =3D 0xC0000000;=A0 =A0 Length =3D 0x1000000;=A0 =A0 Alignment=
 =3D 0xFFFFFF;=A0 =A0 Owner =3D PCI [00|01|00:10]; Type =3D PMem32
=A0=A0=A0Base =3D 0xC1000000;=A0 =A0 Length =3D 0x200000;=A0 =A0 Alignment =
=3D 0x1FFFFF;=A0 =A0 Owner =3D PPB [00|02|03:**]
=A0=A0=A0Base =3D 0xC1200000;=A0 =A0 Length =3D 0x200000;=A0 =A0 Alignment =
=3D 0x1FFFFF;=A0 =A0 Owner =3D PPB [00|02|02:**]
=A0=A0=A0Base =3D 0xC1400000;=A0 =A0 Length =3D 0x200000;=A0 =A0 Alignment =
=3D 0x1FFFFF;=A0 =A0 Owner =3D PPB [00|02|01:**]
=A0=A0=A0Base =3D 0xC1600000;=A0 =A0 Length =3D 0x200000;=A0 =A0 Alignment =
=3D 0x1FFFFF;=A0 =A0 Owner =3D PPB [00|02|00:**]
=A0=A0=A0Base =3D 0xC1800000;=A0 =A0 Length =3D 0x40000;=A0 =A0 Alignment =
=3D 0x3FFFF;=A0 =A0 Owner =3D PCI [00|00|00:00]; Type =3D=A0 OpRom
=A0=A0=A0Base =3D 0xC1840000;=A0 =A0 Length =3D 0x1000;=A0 =A0 Alignment =
=3D 0xFFF;=A0 =A0 Owner =3D PCI [00|1F|02:24]
=A0=A0=A0Base =3D 0xC1841000;=A0 =A0 Length =3D 0x1000;=A0 =A0 Alignment =
=3D 0xFFF;=A0 =A0 Owner =3D PCI [00|1D|07:10]
=A0=A0=A0Base =3D 0xC1842000;=A0 =A0 Length =3D 0x1000;=A0 =A0 Alignment =
=3D 0xFFF;=A0 =A0 Owner =3D PPB [00|02|03:10]
=A0=A0=A0Base =3D 0xC1843000;=A0 =A0 Length =3D 0x1000;=A0 =A0 Alignment =
=3D 0xFFF;=A0 =A0 Owner =3D PPB [00|02|02:10]
=A0=A0=A0Base =3D 0xC1844000;=A0 =A0 Length =3D 0x1000;=A0 =A0 Alignment =
=3D 0xFFF;=A0 =A0 Owner =3D PPB [00|02|01:10]
=A0=A0=A0Base =3D 0xC1845000;=A0 =A0 Length =3D 0x1000;=A0 =A0 Alignment =
=3D 0xFFF;=A0 =A0 Owner =3D PPB [00|02|00:10]
=A0=A0=A0Base =3D 0xC1846000;=A0 =A0 Length =3D 0x1000;=A0 =A0 Alignment =
=3D 0xFFF;=A0 =A0 Owner =3D PCI [00|01|00:18] Type =3D=A0 Mem64; Base =3D 0=
x84000000000;=A0 =A0 Length =3D 0x300000;=A0 =A0 Alignment =3D 0xFFFFF
=A0=A0=A0Base =3D 0x84000000000;=A0 =A0 Length =3D 0x100000;=A0 =A0 Alignme=
nt =3D 0xFFFFF;=A0 =A0 Owner =3D PPB [00|02|00:**]; Type =3D PMem64
=A0=A0=A0Base =3D 0x84000100000;=A0 =A0 Length =3D 0x100000;=A0 =A0 Alignme=
nt =3D 0xFFFFF;=A0 =A0 Owner =3D PPB [00|02|01:**]; Type =3D PMem64
=A0=A0=A0Base =3D 0x84000200000;=A0 =A0 Length =3D 0x100000;=A0 =A0 Alignme=
nt =3D 0xFFFFF;=A0 =A0 Owner =3D PPB [00|02|02:**]; Type =3D PMem64=A0

PciBus: Resource Map for Bridge [00|02|00] Type =3D =A0 Io16; Base =3D 0x90=
00;=A0 =A0 Length =3D 0x200;=A0 =A0 Alignment =3D 0xFFF
=A0=A0=A0Base =3D Padding;=A0 =A0 Length =3D 0x200;=A0 =A0 Alignment =3D 0x=
1FF Type =3D=A0 Mem32; Base =3D 0xC1600000;=A0 =A0 Length =3D 0x200000;=A0 =
=A0 Alignment =3D 0x1FFFFF
=A0=A0=A0Base =3D Padding;=A0 =A0 Length =3D 0x200000;=A0 =A0 Alignment =3D=
 0x1FFFFF
=A0=A0=A0Base =3D 0xC1600000;=A0 =A0 Length =3D 0x1000;=A0 =A0 Alignment =
=3D 0xFFF;=A0 =A0 Owner =3D PCI [01|00|00:14] Type =3D=A0 Mem32; Base =3D 0=
xC1845000;=A0 =A0 Length =3D 0x1000;=A0 =A0 Alignment =3D 0xFFF Type =3D PM=
em64; Base =3D 0x84000000000;=A0 =A0 Length =3D 0x100000;=A0 =A0 Alignment =
=3D 0xFFFFF
=A0=A0=A0Base =3D 0x84000000000;=A0 =A0 Length =3D 0x4000;=A0 =A0 Alignment=
 =3D 0x3FFF;=A0 =A0 Owner =3D PCI [01|00|00:20]=A0

PciBus: Resource Map for Bridge [00|02|01] Type =3D =A0 Io16; Base =3D 0x80=
00;=A0 =A0 Length =3D 0x200;=A0 =A0 Alignment =3D 0xFFF
=A0=A0=A0Base =3D Padding;=A0 =A0 Length =3D 0x200;=A0 =A0 Alignment =3D 0x=
1FF Type =3D=A0 Mem32; Base =3D 0xC1400000;=A0 =A0 Length =3D 0x200000;=A0 =
=A0 Alignment =3D 0x1FFFFF
=A0=A0=A0Base =3D Padding;=A0 =A0 Length =3D 0x200000;=A0 =A0 Alignment =3D=
 0x1FFFFF=20


=A0=A0=A0Base =3D 0xC1400000;=A0 =A0 Length =3D 0x1000;=A0 =A0 Alignment =
=3D 0xFFF;=A0 =A0 Owner =3D PCI [02|00|00:14] Type =3D=A0 Mem32; Base =3D 0=
xC1844000;=A0 =A0 Length =3D 0x1000;=A0 =A0 Alignment =3D 0xFFF Type =3D PM=
em64; Base =3D 0x84000100000;=A0 =A0 Length =3D 0x100000;=A0 =A0 Alignment =
=3D 0xFFFFF
=A0=A0=A0Base =3D 0x84000100000;=A0 =A0 Length =3D 0x4000;=A0 =A0 Alignment=
 =3D 0x3FFF;=A0 =A0 Owner =3D PCI [02|00|00:20]=A0

PciBus: Resource Map for Bridge [00|02|02] Type =3D =A0 Io16; Base =3D 0x70=
00;=A0 =A0 Length =3D 0x200;=A0 =A0 Alignment =3D 0xFFF
=A0=A0=A0Base =3D Padding;=A0 =A0 Length =3D 0x200;=A0 =A0 Alignment =3D 0x=
1FF Type =3D=A0 Mem32; Base =3D 0xC1200000;=A0 =A0 Length =3D 0x200000;=A0 =
=A0 Alignment =3D 0x1FFFFF
=A0=A0=A0Base =3D Padding;=A0 =A0 Length =3D 0x200000;=A0 =A0 Alignment =3D=
 0x1FFFFF Type =3D=A0 Mem32; Base =3D 0xC1843000;=A0 =A0 Length =3D 0x1000;=
=A0 =A0 Alignment =3D 0xFFF Type =3D PMem64; Base =3D 0x84000200000;=A0 =A0=
 Length =3D 0x100000;=A0 =A0 Alignment =3D 0xFFFFF
=A0=A0=A0Base =3D 0x84000200000;=A0 =A0 Length =3D 0x4000;=A0 =A0 Alignment=
 =3D 0x3FFF;=A0 =A0 Owner =3D PCI [03|00|00:20]=A0

PciBus: Resource Map for Bridge [00|02|03] Type =3D =A0 Io16; Base =3D 0x60=
00;=A0 =A0 Length =3D 0x200;=A0 =A0 Alignment =3D 0xFFF
=A0=A0=A0Base =3D Padding;=A0 =A0 Length =3D 0x200;=A0 =A0 Alignment =3D 0x=
1FF Type =3D=A0 Mem32; Base =3D 0xC1000000;=A0 =A0 Length =3D 0x200000;=A0 =
=A0 Alignment =3D 0x1FFFFF
=A0=A0=A0Base =3D Padding;=A0 =A0 Length =3D 0x200000;=A0 =A0 Alignment =3D=
 0x1FFFFF Type =3D=A0 Mem32; Base =3D 0xC1842000;=A0 =A0 Length =3D 0x1000;=
=A0 =A0 Alignment =3D 0x


The bus 1 is off 02:00.0 bridge device.
IO resource for the bridge:
Base =3D 0x9000;=A0 =A0 Length =3D 0x200;=A0 =A0 Alignment =3D 0xFFF;=A0 =
=A0 Owner =3D PPB [00|02|00:**] The alignment is 0xfff, start 0x9000, and l=
ength 0x200. So 0x9000-0x91ff would be sufficient for this, there would be =
no conflict. Linux appears to assign 0x9000-0x9fff to the bridge, resulting=
 in conflicts with subsequent devices.

[root@localhost ~]# dmesg | grep conflict [=A0 =A0 0.426170] pci 0000:00:1d=
.0: can't claim BAR 4 [io=A0 0x92a0-0x92bf]: address conflict with PCI Bus =
0000:01 [io=A0 0x9000-0x9fff] [=A0 =A0 0.426217] pci 0000:00:1d.1: can't cl=
aim BAR 4 [io=A0 0x9280-0x929f]: address conflict with PCI Bus 0000:01 [io=
=A0 0x9000-0x9fff] [=A0 =A0 0.426228] pci 0000:00:1d.2: can't claim BAR 4 [=
io=A0 0x9260-0x927f]: address conflict with PCI Bus 0000:01 [io=A0 0x9000-0=
x9fff] [=A0 =A0 0.426258] pci 0000:00:1f.2: can't claim BAR 4 [io=A0 0x9240=
-0x925f]: address conflict with PCI Bus 0000:01 [io=A0 0x9000-0x9fff] [=A0 =
=A0 0.426270] pci 0000:00:1f.3: can't claim BAR 4 [io=A0 0x9200-0x923f]: ad=
dress conflict with PCI Bus 0000:01 [io=A0 0x9000-0x9fff]
=A0Dmesg output with debug=3D1 "dyndbg=3Dfile *pci* +pfm"
=A0
[ 0.280118] probe:pci_scan_child_bus_extend: pci_bus 0000:01: fixups for bu=
s [ 0.280122] pci 0000:00:02.0: PCI bridge to [bus 01] [ 0.280141] pci 0000=
:00:02.0: bridge window [io 0x9000-0x9fff] [ 0.280158] pci 0000:00:02.0: br=
idge window [mem 0xc1600000-0xc17fffff] [ 0.280191] pci 0000:00:02.0: bridg=
e window [mem 0x8000000000-0x80000fffff 64bit pref] [ 0.280194] probe:pci_s=
can_child_bus_extend: pci_bus 0000:01: bus scan returning with max=3D01


Nucleodyne @ Nutanix
408-718-8164

