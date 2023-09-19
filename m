Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0AE17A6792
	for <lists+linux-pci@lfdr.de>; Tue, 19 Sep 2023 17:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbjISPIT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Sep 2023 11:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbjISPIT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Sep 2023 11:08:19 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C14B94
        for <linux-pci@vger.kernel.org>; Tue, 19 Sep 2023 08:08:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTlKSHfPOcwR9sQBDA1MFQYwD+0ckjiJG/5NQJzQEE1qQJEYEEtohSuDZ+DeAYrdT596bhzGLL9aXzCrrSS9CBtFcZvI7f2tvTBEIxwISREB85LQjadvzc90jTadJeNNqtIU/RBCbHUhn0cMd8ujksUJCMK4t4NPOZPqPAt6HVyVOiEpxLZ7cXsiSnF9Z6EjoxQbxsXhZI2OMxM/OvNooZA4/9+izC4tSPBaa8svsmb8mAlXcQ3WUCdXxcvuzEBnSLNmTCn4YPUNa6nypPC7K6LHqhxi1gseVrDDdI44AidwuEGKzYjtUKKkCMwh4rX7u+fgsr2HNJc8+cDTfZIoYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdgWLNGYOoP7RKt0hFpJTcIfaL1dF9xFDd+RoH+/R5Y=;
 b=ef8rq3LwBtjtg9QMT8eKlxGCGqsSA0XvB+744nR9s1Ck0jW9dnIOXHqIQ3fmbTT9Du192teAYv0UrOpP00+tH8jCD51ad39d0QnUWSEBVXXcchsUHUVsP+64YVx4eRpODTI4dwJL1epnqUrI1uMZfKmh7r8LxJ9errLrXzpxeVrR84CpJKLmHz5ueiyUimt8zrK6wXZ+EeZYhQzyJ4pzCzOOMS+Rv+jTCUaKvQgzEghCdeORxciHOs7ptk5kZXkPQDTN14xwvoqDs+t2g2CN2wXKjUvrQMMxPwXn3zj9+gWFl1j1KYlgJSzsm9eoXoyhYCUkihuJz88N0RlDKvxeSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sonifi.com; dmarc=pass action=none header.from=sonifi.com;
 dkim=pass header.d=sonifi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sonifi.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdgWLNGYOoP7RKt0hFpJTcIfaL1dF9xFDd+RoH+/R5Y=;
 b=zs1kFfnRNQKsyG8Nb6ev/8A1JW/kDOmggFyO/97KHQs8jXM0hpj3iFOpjKwvn1wiA3Ld+UacCVkhk64WYcllPhG/zWqML7dfXqO1E/5CXT9lCP8ql+lHAckzG4T+tvWhqeIJbiN7UdtNrILkCqr/HulaEsGl6uXmMCmZAij1XUI=
Received: from DM6PR16MB2844.namprd16.prod.outlook.com (2603:10b6:5:125::22)
 by PH7PR16MB6257.namprd16.prod.outlook.com (2603:10b6:510:30f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Tue, 19 Sep
 2023 15:08:08 +0000
Received: from DM6PR16MB2844.namprd16.prod.outlook.com
 ([fe80::cf1c:eef5:f2ac:14c6]) by DM6PR16MB2844.namprd16.prod.outlook.com
 ([fe80::cf1c:eef5:f2ac:14c6%4]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 15:08:08 +0000
From:   "Schroeder, Chad" <CSchroeder@sonifi.com>
To:     Lukas Wunner <lukas@wunner.de>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Schroeder, Chad" <CSchroeder@sonifi.com>
Subject: RE: PCIe device issue since v6.1.16
Thread-Topic: PCIe device issue since v6.1.16
Thread-Index: AdnrA833YItLbJ18RoeS78Ya55oDogABhDeAAAA8E2A=
Date:   Tue, 19 Sep 2023 15:08:08 +0000
Message-ID: <DM6PR16MB2844AC71B336A5AD50005221B1FAA@DM6PR16MB2844.namprd16.prod.outlook.com>
References: <DM6PR16MB2844903E34CAB910082DF019B1FAA@DM6PR16MB2844.namprd16.prod.outlook.com>
 <20230919145921.GA8609@wunner.de>
In-Reply-To: <20230919145921.GA8609@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sonifi.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR16MB2844:EE_|PH7PR16MB6257:EE_
x-ms-office365-filtering-correlation-id: ab27abf2-46ff-48ed-3440-08dbb9223ba0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zEhqNCrV2AsXL30dPEdIlwmJd4skRgzTilXaNe7qLfBgIXaUB4ihGKSqHEMbm+CSXdIb9I2mWphobNMYg+Kum+ksXIYSWPwt3OGbPftzpF9O+qywx0k//GG4Brrbr84GAm1KJX1AUPZ2foL1xkPudP8iVt3i3UJhzGpsQk5k3YIk1QN+g0mRtfMZryvfLoQzYUztdpepgTgfICec3T810tWIJbSICCKas/MeUx1bE2ChN60Lu1GLot6JK8dn1Yk5W/MV0eRCz4keJwmmPILFosaGbOu67dYwy0Yn78FRyZvEL6ZFCVfvedh5DmCvavjv2n1AkK1PU3jV8XkQYTE9i1QCx2zTT6a73Df5Vdyi4kKOJK9EUYhhKrksRBMVeNYdof6eosDAATF7i7g5hgUgwSk/xYEEuQmge3ShpRv5s/zY2yKWPxETqLhzMPK9hlkZyXKuZxqth+upHVyu4O+4zSsBrMG1wsVmFxbqidZ+9jDMM/69tYNfwxyVINAmzd6fH+i3uqOyFENDlF3eA8mJWoq2jDHh7cuViNpwUMKvdQrOi0aPCEN5GA4wFZAmXWbJcpxoy99WTljMtklEI0EBLVrKt+zaLxAJeBuJYLOu/RpLvRN4JGMdhb3puu2Vk/eH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR16MB2844.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39850400004)(366004)(376002)(396003)(186009)(1800799009)(451199024)(7696005)(6506007)(71200400001)(9686003)(83380400001)(26005)(107886003)(2906002)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(316002)(6916009)(8676002)(52536014)(5660300002)(8936002)(41300700001)(4326008)(86362001)(33656002)(55016003)(122000001)(38100700002)(38070700005)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eJYW4OlZj91NjyTixfRRhljn/lY23ZEzencWCFOYqWL8Oygv//iKEms2oLEK?=
 =?us-ascii?Q?vFsNPhDvCpjRMyg4CsGMRziV3pDGcmEnELISiVBEr2msfOi84toBzYCr3V0v?=
 =?us-ascii?Q?jKOBRtecCMche9UT7L5d+DZOb4tW+a85wwe2E3zTKCrWJfSK4y1xA5s1oKf9?=
 =?us-ascii?Q?YmuiXydhoDmQKJttIdiFFsa6hub2GvmSKVmGkaEhG9QWolRivsvPyyLwj5C7?=
 =?us-ascii?Q?ssYF5WRIQxwWVkYpjzndirc8UHRZ441Sn6IwCR8aB9q9obQHRiRO7hjz0zdo?=
 =?us-ascii?Q?QwPYciTgo5nAR1Jfh3baf0774bUpAo6yV88ru339juf/i9Yh4oG3Wr3ZURZf?=
 =?us-ascii?Q?36F1ffwKaDQ7CSv0KqG6JvSXfkom+TathOyfYepdk+X2VEL+vG8JEK89TFRm?=
 =?us-ascii?Q?1RIuNflaEnFDn6JGek5mGMBWbjo9PFLDMA0bwUpyvWOdLeicBlaMeptnXljt?=
 =?us-ascii?Q?NW/1BMtL0sDv3wGyrKonHNjvPrODeAVRvNvVLv71OV9vHPuaS15qcxinQVq5?=
 =?us-ascii?Q?HMLfvcij157HxUYdjh29ZVX6epMexlUs4K/tYwuOecTra4GdZ6ifdG9LF9gW?=
 =?us-ascii?Q?23V47uE6cHkPvprwUnDdH0vF2LYO8eN+q/8ET20X2LUyY+8ug+uY5OX0SjCw?=
 =?us-ascii?Q?KPOoGRRvKwYvdGDHneN4+tf2Qmq1g2+r8n+p3pzMxmCfoaNZGN+rsCdXtrt1?=
 =?us-ascii?Q?H7IlcAyI8fPkHVzxVip4MMAdNjVOTZFJUTQj7R8wGwAXqrmaTtRK690dDamZ?=
 =?us-ascii?Q?COzttRZmHfBQicvYwtpqj3PsdUadtqI6KsBH6+HxPcp9G8dAbLhyc4ce9ioo?=
 =?us-ascii?Q?UqRVHnM5/YL6uBuES6tpefpshUDbZ++H83QssUe1/SeBvcWLbuiWXyTPcE4K?=
 =?us-ascii?Q?Lvg5Crz1vLvZ+o0+8EMoOqrYRcrwpxrJGxQHtJ/R2ObzDIV8PnUcKWK1Fka9?=
 =?us-ascii?Q?s8nRKb2tX8pfOUeEEW5xJATp/W63X02GRJuYf+OKi/gW0FLvHh0hoFpglvwy?=
 =?us-ascii?Q?KU4bS5WeYMw31m7osoajTyyEjB1xxbz3+WQ45srJa7Hx7dqli7ch+ZRpGown?=
 =?us-ascii?Q?ZbWO9Uc9IZBaW10HxnAvP0XmIpuxof3KbovR6EO+UnAcmqizEid5Mnh97MJW?=
 =?us-ascii?Q?2+Waxrdia+jLuhnimy6dmZAzilIfki8em7/7drb6tLgPFdYhJJnnJL34hVOO?=
 =?us-ascii?Q?dlOG6O0xPGm8uFUjr2rffYSOLg3hJLf0eRZSaBV9mqH+hm2BqlnzgWeBNv7E?=
 =?us-ascii?Q?3ErCjJ//Os+E9x9Pfi9KcXBNzLbyzisgG7TCCwSf0T0lj93iLHiT8rkCUdKM?=
 =?us-ascii?Q?r7tYGfogJFtkxLMbNfJCd2OR5Z6IkGXM/4VKso6QXkimCHiTGFWcyA55G5Vs?=
 =?us-ascii?Q?8QplVeM0xWGPFGISToXfVS4dUMGO0U+8nZ0WbDpSy953alcn37wswyR4OFrV?=
 =?us-ascii?Q?6fEklkJ1KsMkV/0MRTJ6180WEDNmSyN9kX0azdF+j87zxTPDhB04Y6J5tpKx?=
 =?us-ascii?Q?vlQNVj+TmGKgkf8ADGyeS9nUBSWVvaGxMIitHSacuPr/M77bmRmdPc+Hm/Fo?=
 =?us-ascii?Q?cANsj6pMGmD96SccOEMM9KwhfwKUsQ6N7VXiGi8z?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sonifi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR16MB2844.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab27abf2-46ff-48ed-3440-08dbb9223ba0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 15:08:08.3101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d7d50e09-0988-4b46-977a-bbfbd3e792a4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0+6h4kVRFdio4xN7ZHvtQvsQtwMXmPwbIlqx38R5Fmb7bR4LUmdp3DAfmzFWLMvOBcx0IcGGlyldmRK6r05J8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR16MB6257
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lukas,

Thanks for the reply.  Here you go:

$ lspci

0000:64:00.0 PCI bridge: Intel Corporation Sky Lake-E PCI Express Root Port=
 A (rev 07) (prog-if 00 [Normal decode])
	Subsystem: Super Micro Computer Inc Device 0953
	Physical Slot: 2
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 30
	NUMA node: 0
	IOMMU group: 0
	Bus: primary=3D64, secondary=3D65, subordinate=3D65, sec-latency=3D0
	I/O behind bridge: f000-0fff [disabled] [16-bit]
	Memory behind bridge: e0e00000-e0efffff [size=3D1M] [32-bit]
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff [disa=
bled] [64-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort+ <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Subsystem: Super Micro Computer Inc Device 0953
	Capabilities: [60] MSI: Enable+ Count=3D1/2 Maskable+ 64bit-
		Address: fee00038  Data: 0000
		Masking: 00000002  Pending: 00000000
	Capabilities: [90] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0
			ExtTag+ RBE+
		DevCtl:	CorrErr- NonFatalErr- FatalErr+ UnsupReq-
			RlxdOrd- ExtTag+ PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 256 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr+ NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
		LnkCap:	Port #5, Speed 8GT/s, Width x16, ASPM L1, Exit Latency L1 <16us
			ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1
			TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #2, PowerLimit 75W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Off, PwrInd On, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet+ LinkState+
		RootCap: CRSVisible+
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal+ PMEIntEna+ CRSVisible+
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BCD, TimeoutDis+ NROPrPrP- LTR-
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- LN System CLS Not Supported, TPHComp+ ExtTPHComp- ARIFwd+
			 AtomicOpsCap: Routing- 32bit+ 64bit+ 128bitCAS+
		DevCtl2: Completion Timeout: 260ms to 900ms, TimeoutDis- LTR- 10BitTagReq=
- OBFF Disabled, ARIFwd-
			 AtomicOpsCtl: ReqEn- EgressBlck-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers-=
 DRS-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- Compl=
ianceSOS-
			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- Equalizat=
ionPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [e0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [100 v1] Vendor Specific Information: ID=3D0002 Rev=3D0 Len=
=3D00c <?>
	Capabilities: [110 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl=
- DirectTrans-
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl=
- DirectTrans-
	Capabilities: [148 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES+ TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq+ ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+=
 ECRC- UnsupReq- ACSViol-
		CESta:	RxErr+ BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCC=
hkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
		RootCmd: CERptEn- NFERptEn- FERptEn-
		RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
			 FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
		ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
	Capabilities: [1d0 v1] Vendor Specific Information: ID=3D0003 Rev=3D1 Len=
=3D00a <?>
	Capabilities: [250 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: LaneErr at lane: 15
	Capabilities: [280 v1] Vendor Specific Information: ID=3D0005 Rev=3D3 Len=
=3D018 <?>
	Capabilities: [298 v1] Vendor Specific Information: ID=3D0007 Rev=3D0 Len=
=3D024 <?>
	Capabilities: [300 v1] Vendor Specific Information: ID=3D0008 Rev=3D0 Len=
=3D038 <?>
	Kernel driver in use: pcieport
