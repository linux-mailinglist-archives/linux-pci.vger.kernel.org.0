Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13405577598
	for <lists+linux-pci@lfdr.de>; Sun, 17 Jul 2022 11:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiGQJrt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 17 Jul 2022 05:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiGQJrr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 17 Jul 2022 05:47:47 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0279167C1;
        Sun, 17 Jul 2022 02:47:46 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26H6J97Y015003;
        Sun, 17 Jul 2022 02:47:18 -0700
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3hbtpqj28u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 17 Jul 2022 02:47:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ndm/5usNIj6TFuFXifMgHlPFacciisxuDe9WqRGX9WbBklESJiEElyGt5Fnnve9oVou5RR1eMdcnjpzlJb0pk0PczMhixzzsQB9TaQie6DbfMyJxaUWgyptdt7EXp3a5CD2Xc2xBw9vTPob/B921ozi8dIWmiK49yToVRmb6dienE1b6WQ8tZPzsuv1CYBHMM/VCs+U2PDTPlyOrJL77cXF3JEaLDhR4HWeoKbXvWNTtK/RqEPMvDWMpQhTmXzD1id+L+I85tXC24Es8DXCX1kYvlqpASpNU8kpItEVMOi+lVrsNAC8FGh9U31lJJnjqK041kpQ8kk5UCvPKBGw6Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LGuJr4hbAJLJkdVZxnyffaqULdX7jDBdRIKB9MUDK6I=;
 b=l2ZwEuHeAfdsbXp9RF5d85U987tgVGHF2+foiG7HJb2GyfjjchLcvBnf/Qha5S7ZPbF8pDXPcl9Y+V5rrtQfflrMmXaU+PLuyIglf6a4c7uY7Ztj05finMLkKdNB89qBkIp+DSaymeg/kxCnBB8fqemmOHther1nS84EDtARLnM0BujktO8j+AKSMj6aJ3etcAWBHSUfmg+cw6dwDCJtJB8Pafbl5ejqBN9UMEGMhsvWeg7Rp6ykU7IxvpZPrkM7tuDEvfz1i239ooVl/0IpNek2r5WRRkfMfXQCoBdjAHrTQBD/3UQgzW8+4kTCupPL4QZ7jqa+q2yDDKSsX3Y18w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGuJr4hbAJLJkdVZxnyffaqULdX7jDBdRIKB9MUDK6I=;
 b=NwnmL5CrXjR2pyxkayIf85FHeeWuYjJ/CZ+xcqY/61AJ+NFzG6N/UHaU7OAWhJ9hure3FDxS2Mp3UAmyqpiUTUpssBNuIcKSTsizm2yxfBo8/lzM+puw2kjzzyjoMXr+B80PJ1ikharS1gfv9zK4ARRKMFUuBK/aluzsjEut8bA=
Received: from BN9PR18MB4251.namprd18.prod.outlook.com (2603:10b6:408:11c::10)
 by CO6PR18MB3905.namprd18.prod.outlook.com (2603:10b6:5:346::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.22; Sun, 17 Jul
 2022 09:47:15 +0000
Received: from BN9PR18MB4251.namprd18.prod.outlook.com
 ([fe80::43f:605a:2b6a:2398]) by BN9PR18MB4251.namprd18.prod.outlook.com
 ([fe80::43f:605a:2b6a:2398%4]) with mapi id 15.20.5438.022; Sun, 17 Jul 2022
 09:47:14 +0000
From:   Elad Nachman <enachman@marvell.com>
To:     =?utf-8?B?UGFsaSBSb2jDoXI=?= <pali@kernel.org>,
        Ratheesh Kannoth <rkannoth@marvell.com>,
        Tanmay Jagdale <tanmay@marvell.com>,
        Shijith Thotton <sthotton@marvell.com>,
        Arun Easi <aeasi@marvell.com>
CC:     =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?utf-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Wojciech Bartczak <wbartczak@marvell.com>
Subject: RE: [EXT] Re: Issues with A3720 PCIe controller driver pci-aardvark.c
Thread-Topic: [EXT] Re: Issues with A3720 PCIe controller driver
 pci-aardvark.c
Thread-Index: AQHYlE8tqYxTxczByUa5aF4fmeUTY62CUk3Q
Date:   Sun, 17 Jul 2022 09:47:14 +0000
Message-ID: <BN9PR18MB425154FE5019DCAF2028A1D5DB8D9@BN9PR18MB4251.namprd18.prod.outlook.com>
References: <20210723221710.wtztsrddudnxeoj3@pali>
 <20220216200940.fwdwk5rcb4zq6dyg@pali> <20220710112108.jegpz4khfsrb4ahd@pali>
In-Reply-To: <20220710112108.jegpz4khfsrb4ahd@pali>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f98910b9-a572-49c9-b09b-08da67d95438
x-ms-traffictypediagnostic: CO6PR18MB3905:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WbAVD+Hi2TZO1iIaba/GJBgYZOUsc6qPfCUbhSueWu9pWE1L28ffoQeZux9cpFuFpsUv9Yi/FQSAaertb28cZPP6pesfRLak8yQqIGiQYDFBS/w45fiEVNwYNRrg7pS/fJA8Om8ZPtn7F2Kel+9ZW1YNJAcdD4+6rzPTcSlPOq5FPkYTOCzhBcp8jB65l8Vj4hp6FbOyI67MyBvETyA2ptpzx5EBvkALwq9yAotCQc8Lcl6tPTMiOEYrqjRakOk7g023Dseluig08iO3v8p9FuBsQONJ6nnJLdJ2IkytnHIZVspEveSfAIsGFE909Mz8auCp4nXJSZNAZKtzjEuH40a+oMPUg1QsRLRFV/JMPTgs0+Ji4qEG4pt+VllBOFPR5KttoQjh9jGT6PwE8Woh8o0Nv1Ue0SDay4S4L0FmJN80Rya3X1Hqy3IxxGDzxgvSdJO/1Zumdjcst77rcYeZd/YR1tlL2w0897mNNns1ADIQwRAUuxUoRSW93Ru7w/SmOH4thDvH+XdafACFdmraLrwN/BdDPFe0nXNHmAJ8oy8ett3ZFehh+cDajTmCjzRn57ISLWCZv9S0XlialajBZnot2UOjMoqYfXLyHbcCQuo0HVYccMcjivmwFeFs4qEpyD6biXFYGXVncHEQAjdQb2BY938099LEH0BSy+RAoSFuT6V1Cy2cFlsMhuhTBKt/FfBnchQnlb4xHVlBBu8fMa0+WVAD4xqzSr32U2UcuIEwqt/1kvYMi8Emy/ku/YzG9hH4e9XmyI6Sl4v7qfcfl5xworac6XAPYYTiWXJ3DxKf7bChuP7gqZx75Y1moGeN7HijKRHpAuMCcgqEGs6doFRVP6ZrwaFmq2m40w2lWl8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR18MB4251.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39850400004)(136003)(396003)(376002)(366004)(4326008)(7416002)(5660300002)(66476007)(66556008)(66946007)(66446008)(8676002)(8936002)(64756008)(54906003)(76116006)(52536014)(33656002)(26005)(55016003)(9686003)(86362001)(122000001)(2906002)(38070700005)(83380400001)(71200400001)(966005)(478600001)(6636002)(19627235002)(186003)(66574015)(316002)(110136005)(107886003)(41300700001)(38100700002)(6506007)(7696005)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U29kMERvaC9saGVHYTBEWU15a2VNUk55Q3ZnMm02V1lWNW1HT0d5eCtEcmdi?=
 =?utf-8?B?NWVzaStZa2svK0lYaHFweDVSWHd6R0dQNTVsN2NlYlNzcXV3RUpqYTdodmVs?=
 =?utf-8?B?Y1V4eWdRV0dMdTBSMWNzVlhqQjJjaUduNVFnMXdyMXJ2NUtEU054V255WXFM?=
 =?utf-8?B?ZHIrYUR2UFRONDhrN2lqMFBWaXVyTmNlYkRtWXY3WjF0VEhpYm9hRURWaWFr?=
 =?utf-8?B?dkk3UHFBbWNaWXIrWDZ2azlhaiszemtmcjBKY2JxcStNTnVDN090bmFMbjV5?=
 =?utf-8?B?Snk3WFdLUXZpdW5SRnlvT3psY242TG5GQXpkOUF5cFpHQWxiZjBGek13ZmpY?=
 =?utf-8?B?Z2JITDVyNlhDeTArWUtWL3pOODZMbWRONExWT01MUkxNQVc4MWEzSXVBVlp3?=
 =?utf-8?B?a0QwNFZTSkQ3NlJ2c0NONktQV3VRNmpRYWQwREpmL3Q1NEREUmg1YkY5QnBy?=
 =?utf-8?B?R2F2WkV3eEVON0p5L09QN3pTQ2NyNnRUZ096UURNYlZYRjV5WVl2c2gxTjVy?=
 =?utf-8?B?VFYzeFN0c2RPY1pidE1ma253N3pKOE1MVUZQS3R1eEJoanRlcGx2allzaEdG?=
 =?utf-8?B?cGJMbHJ6Y2VYdjJGeFpWaytESGZFN1IyMkV3Rlh4QmZnV3JvMTJPM1pVcHRZ?=
 =?utf-8?B?OXQwaWptcnlQNHRkYXpmSElZZk81MGdjcmN2Ly8yTkplMUxCak9rUGpPUGFj?=
 =?utf-8?B?d3o1Vjdic2ltT3ZibUVzSGRLR2tKNGhISVlaMWUwblV1eDFmVFhWdVh2SWxw?=
 =?utf-8?B?MnZ1N2tVNVc3WTZtSXZFbHVJL0xGNDcxd3BEUEZ6dFRUVDQwSHdtZU9WKzBB?=
 =?utf-8?B?cXQ1U0ExaTdIZUp2MXlRMnhFdk5LckRWRVZydkZpdmlCK1FpV3VqazFrblR3?=
 =?utf-8?B?WkRUcmVnbGUvQ2cvMjYwQ2xNU20vQVEzc2tOYlkyZGE4b1BwTmxCZlg1N3NK?=
 =?utf-8?B?VEhFS2tWMUJaZ2l3dVJmYjBBNkdqRUI3bE51aHlNSEswUFptM1EweDZ5c3dz?=
 =?utf-8?B?OFVQcGxPeHYwa2JmSGEwZGFOVnByU1EyazBvc1ZVQnR3eWJ5cFNMcHhJY0Uz?=
 =?utf-8?B?R1p6UWRIWWc4dFA3SHVhMURGbG5YM3MrSVdXTURDMEV1TmRPNGllaFR3V1Rn?=
 =?utf-8?B?UnVacStxYVg1dUdZYVhabFB3KzdwdU16MzkwRE1rUm5IL3BTbklxL0lFTUhz?=
 =?utf-8?B?cmNWVDRZcmRSK1BzbVRoTVJnaGFhQjZ3YVVRL0t3MU43aERybzVJNlFLbHF4?=
 =?utf-8?B?QStPUUpUSTNmWFVVT2szUWVFbFpoZndza2dJK255dGhnb3BDdWFuZnRMNndY?=
 =?utf-8?B?bHozZFV3UElrSVRnNENySTNsY1gxT3Q3ZG5pbjlQdUtYdXJIcVF2cEpKck9t?=
 =?utf-8?B?M1dNM25NVkVseG9OVzdlYzNWb09hbkp2dG9raDY3bTloUTBtbUV0ZVJBU0xo?=
 =?utf-8?B?bVo2WlNjYzQ1NXpLT3RRS0FvU3VwMEJXVm9BVzduMGdqME9VdjViRkphbHl0?=
 =?utf-8?B?Rmg3TGw2ck5LNW11VjlRQXVFNWU3VlEveU1PWEJuZUFEK1B6WmhjSEMyNllo?=
 =?utf-8?B?VUp2RE5DNWlOdk9ydzdNRG90eE9oVkRhV3FtaWp2RjBBRGNIZXlGbDNWTFV0?=
 =?utf-8?B?VXI0Wnc4clZFc0JvZTFVNVAwY2NpcFdhQm5EY1NmVXJnZXYrRCsrcVFDZEU4?=
 =?utf-8?B?T2lmOGV0Vk1FSGZuSllERFdYT0tBcTFYSXpoOUZOMFQ3WFpCNnRzQnNrYUVr?=
 =?utf-8?B?UmVoSDFGZHpFQkdoWXFPTlUxM0lEdzFFSm0rVWxRczgwYngrN1lTRysvVnVE?=
 =?utf-8?B?NDZ0ZHNqM2liNklKaHdWYng2N0NVUmM0MUdyQ2pWNlJaT0xiM0s4TTZiaGxS?=
 =?utf-8?B?aGxOY1cvK2l2RXhYRm1aTm5ya0tTcDBxRXZudDd0aFgvUEZTNjFjMGVMTDBJ?=
 =?utf-8?B?Z29hclo5UFduWHVYbXhWWFhvTFFpS1JORHpOdmdPTkxRWjBYRk96RHc3c3Jn?=
 =?utf-8?B?bUx6RVIrVUxXYmhmUXNUVEJYS09oRW41cXlvUncwdmQ1WG9CKzhOTHFXbm5p?=
 =?utf-8?B?ZnVBcmVoS29CeDU5Skk5c2QwSm9KRUlTNHVoLzh1em5EOGpEdENuRnM1R2l6?=
 =?utf-8?Q?3myKmF/WS1U/l7b/afd+OIOEK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR18MB4251.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f98910b9-a572-49c9-b09b-08da67d95438
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 09:47:14.4443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MdJWXD4s9iKsjnDRCyKYdIrg1taHeFnO/zLtd/U5fnwFPoR9deaoTPmSZHRiY3PtOcykpJz0mlYEvKdhUyQmWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB3905
X-Proofpoint-GUID: a49Z1o97t32WVmXoAEv4QcZ8FIGtbbtZ
X-Proofpoint-ORIG-GUID: a49Z1o97t32WVmXoAEv4QcZ8FIGtbbtZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_06,2022-07-15_01,2022-06-22_01
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgUGFsaSwNCg0KQ2FuIHlvdSBwbGVhc2UgaW5kaWNhdGUgd2hhdCBpcyB0aGUgSFcgc291cmNl
IChlLmcuIHdoaWNoIHJlZ2lzdGVyIGluIHRoZSBQQ0llIGNvbnRyb2xsZXIpIGJpdHMgaXMgdHJh
bnNsYXRlZCB0byB0aGUgZmF0YWwgYWJvcnQ/DQoNClJlZ2FyZGluZyB0aGUgRXJyYXR1bSwgYmFz
aWNhbGx5IHRvIHRoZSBiZXN0IG9mIG15IHVuZGVyc3RhbmRpbmcsIGlmIHRoZSBFbmQgUG9pbnQg
aXMgcG9zdGluZyBhIFBDSWUgd3JpdGUgdG8gdGhlIGhvc3QsIGFuZCB0aGUgaG9zdCBpcyB0cnlp
bmcgdG8gcmVhZCB0aGUgRW5kIFBvaW50IHJlZ2lzdGVycyB2aWEgUENJZSwgQ29tcGxldGlvbiBk
YXRhIGlzIGdlbmVyYXRlZCAuIFdpdGggdGhlIHN0cm9uZyBvcmRlcmVkIG1vZGUsIG9uZSB3b3Vs
ZCBleHBlY3QgdGhhdCBmaXJzdCB0aGUgcG9zdCB3cml0ZSB3aWxsIGZpbmlzaCwgYW5kIG9ubHkg
dGhlbiB0aGUgY29tcGxldGlvbiBkYXRhIHdpbGwgYmUgcHJvY2Vzc2VkLiBUaGUgRXJyYXR1bSBt
ZWFucyB0aGF0IHRoaXMgbW9kZSBpcyBub3Qgc3VwcG9ydGVkLiBUaGUgRElTX09SRF9DSEsgbXVz
dCBiZSBzZXQgdG8gZGlzYWJsZSB0aGlzIGZlYXR1cmUsIHdoaWNoIGlzIG5vdCBzdXBwb3J0ZWQg
YnkgSFcuDQoNClJlZ2FyZGluZyBCam9ybiBjb21tZW50LCBub3QgZW5hYmxpbmcgdGhpcyBiaXQg
d2lsbCBub3QgaGVscCBhcyB0aGUgc3Ryb25nLW9yZGVyIGZlYXR1cmUgaXMgbm90IGltcGxlbWVu
dGVkIGluIEhXLg0KTGVhdmluZyB0aGlzIGJpdCBkaXNhYmxlZCB3aWxsIG5vdCBtYWtlIHRoZSBI
VyBlbmZvcmNlIHN0cm9uZy1vcmRlci4gVGhlcmUgaXMgbm8gZGV0YWlsZWQgZGVzY3JpcHRpb24g
b2YgdGhlIEhXIGJlaGF2aW9yIHdoZW4gdGhlIGJpdCBpcyBkaXNhYmxlZCBwZXIgdGhlIGRlZmF1
bHQsIGJ1dCBhcyBpcyBjbGVhcmx5IGV2aWRlbnQgZnJvbSB0aGUgRXJyYXR1bSBhbmQgZnJvbSB5
b3VyIG93biBleHBlcmllbmNlLCBsZWF2aW5nIHRoaXMgYml0IGRpc2FibGVkIHdvdWxkIG5vdCBj
cmVhdGUgdGhlIGNvcnJlY3QsIGV4cGVjdGVkIGJlaGF2aW9yIGZyb20gdGhlIEhXLCB3aGljaCBp
cyB3aHkgaXQgbXVzdCBiZSBlbmFibGVkIGZvciBjb3JyZWN0IGZ1bmN0aW9uYWxpdHkgb2YgdGhl
IHN5c3RlbSAoYm90aCBoYXJkd2FyZSBhbmQgc29mdHdhcmUpLg0KDQpSZWdhcmRpbmcgdGhlIHBh
dGNoIC0gSSB3b3VsZCBhbHNvIGFkZCBhIGZ1bGwgbWVtb3J5IGJhcnJpZXIgKGlmIHlvdSB1c2Ug
aW50ZXJydXB0cyBvbiB0aGUgaG9zdCB0byBoYW5kbGUgdGhlIHdyaXRlIGNvbXBsZXRpb24gLSB0
aGVuIGluIHRoZSBQQ0llIGRyaXZlciBpbnRlcnJ1cHQgaGFuZGxlciwgb3RoZXJ3aXNlIHRoaXMg
d2lsbCByZXF1aXJlIG1vZGlmeWluZyB0aGUgc3BlY2lmaWMgV0lGSSBkcml2ZXIpIGluIG9yZGVy
IHRvIG1pbmltaXplIHRoZSByaXNrIGZvciB0aGUgcmFjZSBjb25kaXRpb24gZG9jdW1lbnRlZCBp
biB0aGUgRXJyYXR1bSBiZXR3ZWVuIHRoZSBETUEgZG9uZSBzdGF0dXMgcmVhZGluZyBhbmQgdGhl
IGNvbXBsZXRpb24gb2Ygd3JpdGluZyB0byB0aGUgaG9zdCBtZW1vcnkuIFRoaXMgb2YgY291cnNl
IGRvZXMgbm90IGd1YXJhbnRlZSBvcmRlciwgYnV0IGl0IGlzIGJldHRlciB0aGFuIGxlYXZpbmcg
aXQgdGhlIHdheSBpdCBpcy4NCg0KSG9wZWZ1bGx5IHRoaXMgaGVscHMsDQoNCkVsYWQuDQoNCi0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBQYWxpIFJvaMOhciA8cGFsaUBrZXJuZWwu
b3JnPiANClNlbnQ6IFN1bmRheSwgSnVseSAxMCwgMjAyMiAyOjIxIFBNDQpUbzogRWxhZCBOYWNo
bWFuIDxlbmFjaG1hbkBtYXJ2ZWxsLmNvbT47IFJhdGhlZXNoIEthbm5vdGggPHJrYW5ub3RoQG1h
cnZlbGwuY29tPjsgVGFubWF5IEphZ2RhbGUgPHRhbm1heUBtYXJ2ZWxsLmNvbT47IFNoaWppdGgg
VGhvdHRvbiA8c3Rob3R0b25AbWFydmVsbC5jb20+OyBBcnVuIEVhc2kgPGFlYXNpQG1hcnZlbGwu
Y29tPg0KQ2M6IEtyenlzenRvZiBXaWxjennFhHNraSA8a3dAbGludXguY29tPjsgTG9yZW56byBQ
aWVyYWxpc2kgPGxvcmVuem8ucGllcmFsaXNpQGFybS5jb20+OyBUaG9tYXMgUGV0YXp6b25pIDx0
aG9tYXMucGV0YXp6b25pQGJvb3RsaW4uY29tPjsgQmpvcm4gSGVsZ2FhcyA8YmhlbGdhYXNAZ29v
Z2xlLmNvbT47IE1hcmVrIEJlaMO6biA8a2FiZWxAa2VybmVsLm9yZz47IFJlbWkgUG9tbWFyZWwg
PHJlcGtAdHJpcGxlZmF1Lmx0PjsgWG9naXVtIDxjb250YWN0QHhvZ2l1bS5tZT47IGxpbnV4LXBj
aUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgQmhhcmF0IEJodXNoYW4gPGJiaHVzaGFuMkBt
YXJ2ZWxsLmNvbT47IFZlZXJhc2VuYXJlZGR5IEJ1cnJ1IDx2YnVycnVAbWFydmVsbC5jb20+OyBX
b2pjaWVjaCBCYXJ0Y3phayA8d2JhcnRjemFrQG1hcnZlbGwuY29tPg0KU3ViamVjdDogW0VYVF0g
UmU6IElzc3VlcyB3aXRoIEEzNzIwIFBDSWUgY29udHJvbGxlciBkcml2ZXIgcGNpLWFhcmR2YXJr
LmMNCg0KRXh0ZXJuYWwgRW1haWwNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KKyBPdGhlciBwZW9wbGUgZnJv
bSBNYXJ2ZWxsIGFjdGl2ZSBvbiBMS01MLg0KDQpDb3VsZCB5b3UgcGxlYXNlIGxvb2sgYXQgdGhp
cyBpc3N1ZSBhbmQgZ2l2ZSB1cyBzb21lIGNvbW1lbnQ/IEl0IGlzIHJlYWxseSBjcml0aWNhbCBp
c3N1ZSB3aGljaCBuZWVkcyB0byBiZSBzb2x2ZWQuDQoNCk9uIFdlZG5lc2RheSAxNiBGZWJydWFy
eSAyMDIyIDIxOjA5OjQwIFBhbGkgUm9ow6FyIHdyb3RlOg0KPiArIEJoYXJhdCwgVmVlcmFzZW5h
cmVkZHkgYW5kIFdvamNpZWNoIGZyb20gTWFydmVsbA0KPiANCj4gSGVsbG8hIENvdWxkIHlvdSBw
bGVhc2UgbG9vayBhdCB0aGlzIGVtYWlsIGFuZCBoZWxwIHVzIHdpdGggdGhpcyBNYXJ2ZWxsIEhX
IGlzc3VlPw0KPiANCj4gT24gU2F0dXJkYXkgMjQgSnVseSAyMDIxIDAwOjE3OjEwIFBhbGkgUm9o
w6FyIHdyb3RlOg0KPiA+IEhlbGxvIEtvbnN0YW50aW4hDQo+ID4gDQo+ID4gVGhlcmUgYXJlIGlz
c3VlcyB3aXRoIE1hcnZlbGwgQXJtYWRhIDM3MjAgUENJZSBjb250cm9sbGVyIHdoZW4gaGlnaCAN
Cj4gPiBwZXJmb3JtYW5jZSBQQ0llIGNhcmQgKGUuZy4gV2lGaSBBWCkgaXMgY29ubmVjdGVkIHRv
IHRoaXMgU09DLiBVbmRlciANCj4gPiBoZWF2eSBsb2FkIFBDSWUgY29udHJvbGxlciBzZW5kcyBm
YXRhbCBhYm9ydCB0byBDUFUgYW5kIGtlcm5lbCBjcmFzaC4NCj4gPiANCj4gPiBJbiBNYXJ2ZWxs
IEFybWFkYSAzNzAwIEZ1bmN0aW9uYWwgRXJyYXRhLCBHdWlkZWxpbmVzLCBhbmQgDQo+ID4gUmVz
dHJpY3Rpb25zIGRvY3VtZW50IGlzIGRlc2NyaWJlZCBlcnJhdHVtIDMuMTIgUENJZSBDb21wbGV0
aW9uIA0KPiA+IFRpbWVvdXQgKFJlZiAjOiAyNTEpIHdoaWNoIG1heSBiZSByZWxldmFudC4gQnV0
IG5laXRoZXIgQmpvcm4sIA0KPiA+IFRob21hcyBub3IgbWUgd2VyZSBhYmxlIHRvIHVuZGVyc3Rv
b2QgdGV4dCBvZiB0aGlzIGVycmF0dW0uIEFuZCB3ZSANCj4gPiBoYXZlIGFscmVhZHkgc3BlbnQg
bG90IG9mIHRpbWUgb24gdGhpcyBlcnJhdHVtLiBNeSBndWVzcyB0aGF0IGlzIA0KPiA+IHRoYXQg
aW4gZXJyYXR1bSBpdHNlbGYgYXJlIG1pc3Rha2VzIGFuZCB0aGVyZSBhcmUgbWlzc2luZyBzb21l
IG90aGVyIGltcG9ydGFudCBkZXRhaWxzLg0KPiA+IA0KPiA+IEtvbnN0YW50aW4sIGFyZSB5b3Ug
YWJsZSB0byB1bmRlcnN0YW5kIHRoaXMgZXJyYXR1bT8gT3IgZG8geW91IGtub3cgDQo+ID4gc29t
ZWJvZHkgaW4gTWFydmVsbCB3aG8gdW5kZXJzdGFuZCB0aGlzIGVycmF0dW0gYW5kIGNhbiBleHBs
YWluIA0KPiA+IGRldGFpbHMgdG8gdXM/IE9yIGRvIHlvdSBrbm93IHNvbWUgbW9yZSBkZXRhaWxz
IGFib3V0IHRoaXMgZXJyYXR1bT8NCj4gPiANCj4gPiBBbHNvIGl0IHdvdWxkIGJlIHVzZWZ1bCBp
ZiB5b3UgLyBNYXJ2ZWxsIGNvdWxkIHNoYXJlIHRleHQgb2YgdGhpcyANCj4gPiBlcnJhdHVtIHdp
dGggbGludXgtcGNpIHBlb3BsZSBhcyBjdXJyZW50bHkgaXQgaXMgYXZhaWxhYmxlIG9ubHkgb24g
DQo+ID4gTWFydmVsbCBDdXN0b21lciBQb3J0YWwgd2hpY2ggcmVxdWlyZXMgcmVnaXN0cmF0aW9u
IHdpdGggc2lnbmVkIE5EQS4NCj4gPiANCj4gPiBJbiBwYXN0IFRob21hcyB3cm90ZSBwYXRjaCAi
YWNjb3JkaW5nIHRvIHRoaXMgZXJyYXR1bSIgYW5kIEkgaGF2ZSANCj4gPiByZWJhc2VkLCByZXdy
aXR0ZW4gYW5kIHJlc2VudCBpdCB0byBsaW51eC1wY2kgbWFpbGluZyBsaXN0IGZvciByZXZpZXc6
DQo+ID4gaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBzLTNB
X19sb3JlLmtlcm5lbC5vcmcNCj4gPiBfbGludXgtMkRwY2lfMjAyMTA2MjQyMjI2MjEuNDc3Ni0y
RDYtMkRwYWxpLTQwa2VybmVsLm9yZ18mZD1Ed0lEYVEmYw0KPiA+ID1uS2pXZWMyYjZSMG1PeVBh
ejd4dGZRJnI9ZVRlTlRMRUs1LVR4WGN6ak9jS1BoQU5JRnRsQjlwUDRscTlxaGRsRnJ3DQo+ID4g
USZtPW9wWXNRc3Zfc2ZTdlR0QTVvSndjMXBhWnJQQVdNSFZoVHhfOUoxVldCVkRrc0JFVENYVnND
M3JSRGI1ZWpnZy0NCj4gPiAmcz1BS2JFQldPSXhhNEEwUVNGWGlxNkhoS3BCeW4waFBKdVp2Ynhz
dTNtOG9vJmU9DQo+ID4gDQo+ID4gU2ltaWxhciBwYXRjaCBpcyBhdmFpbGFibGUgYWxzbyBpbiBr
ZXJuZWwgd2hpY2ggaXMgcGFydCBvZiBNYXJ2ZWxsIFNESy4NCj4gPiANCj4gPiBCam9ybiBoYXMg
b2JqZWN0aW9ucyBmb3IgdGhpcyBwYXRjaCBhcyBoZSB0aGlua3MgdGhhdCBiaXQgDQo+ID4gRElT
X09SRF9DSEsgaW4gdGhhdCBwYXRjaCBzaG91bGQgYmUgZGlzYWJsZWQuIFNlZW1zIHRoYXQgZW5h
YmxpbmcgDQo+ID4gdGhpcyBiaXQgZWZmZWN0aXZlbHkgZGlzYWJsZXMgUENJZSBzdHJvbmcgb3Jk
ZXJpbmcgbW9kZWwuIFBDSWUgDQo+ID4ga2VybmVsIGRyaXZlcnMgcmVseSBvbiBQQ0llIHN0cm9u
ZyBvcmRlcmluZywgc28gaXQgd291bGQgaW1wbGljYXRlIA0KPiA+IHRoYXQgdGhhdCBiaXQgc2hv
dWxkIG5vdCBiZSBlbmFibGVkLiBXaGljaCBpcyBvcHBvc2l0ZSBvZiB3aGF0IGlzIG1lbnRpb25l
ZCBwYXRjaCBkb2luZy4NCj4gPiANCj4gPiBLb25zdGFudGluLCBjb3VsZCB5b3UgaGVscCB1cyB3
aXRoIHRoaXMgcHJvYmxlbT8NCg==
