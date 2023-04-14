Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293A66E25F0
	for <lists+linux-pci@lfdr.de>; Fri, 14 Apr 2023 16:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjDNOji (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 10:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjDNOjh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 10:39:37 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2087.outbound.protection.outlook.com [40.107.22.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19299C154;
        Fri, 14 Apr 2023 07:39:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PhXttULHTJ8i+M/gAFizUiixCicsNnlIC+41okoc8Z/YXYFHm/b2iJf7OCfdemBLYlJsiEhJfI2+bzgs57B/KqIoGwS5nf9Aw+iJyBKSttkyqinIywBdav9zDNz4D+3OyqMNSdI41yCdVo9t/YxmUDyXkOhk78g+0pWlKiPAqAENcQPn1RxGHm8DyEYJwSdFRiCdyrXThM72lDI10itAuL8yqxU6F7udZfjdfZyNTpdPYu2i3osFwwm2VVPHWGBj5pNZbbsqiH5mbMJTvcum5vXPREB0alzhCl/p/nxIaWCh3ufzEfrAM3bUTT8bicGXkPig/PM88PGiF0Vpzr2aSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rV0fH0Uh0z9oCVaW756B8aVaLDKeirat861QL4kYtRA=;
 b=CvnqWMiy8W/tWHpbhecEq9lr3iWSBW0mHhungSGyF5n0gF4i4kNEDgv4U3X/64Kw2/Ui8ahi6bKZ0w8aUclNWgfmgjWnWY4ffQTXEw2gnvzxniJeI/Jh7AS5G/WuUZ2K5MJsv7Kvw5wEFBBOkxmK1bZPgCfzlin6q45q8wciDBbWHKgyqH5i+rwwk79KpnIYdDsDtZRC2CjI2DqAsc3hQKsJ7QP7TlWS8hCzQwrhMaskm9nr8GnL/XtZ3FVsiTIRCLH7YUfCH9qw7s53s63aYYsk3JisKppZud4M/zh+MilN43FHie/TWXtss0yfvL5SZMrPDhcfytzpNF0h6B335A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rV0fH0Uh0z9oCVaW756B8aVaLDKeirat861QL4kYtRA=;
 b=hsOa2FsDw7H8NK6210YAy6BE/yuAnAs2VbA1nWMY4yXyH1Jp0bs3AUrtejGMs9SBsF8eU+x5t7KY7Ai8Ive/4b3B9SemamZhaajyiiHYTYSqQAwblokeU+WuWhuyPvSS6lNCciGKhLm+DzOymFzJ9qvpXwtidsTm2oSI2lcRDf4=
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM9PR04MB8618.eurprd04.prod.outlook.com (2603:10a6:20b:439::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 14:39:26 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::3b2b:11e9:91b7:465]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::3b2b:11e9:91b7:465%2]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 14:39:26 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Shunsuke Mie <mie@igel.co.jp>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
CC:     =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Jon Mason <jdmason@kudzu.us>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ren Zhijie <renzhijie2@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Subject: RE: [EXT] [RFC PATCH 0/3] Introduce a PCIe endpoint virtio console
Thread-Topic: [EXT] [RFC PATCH 0/3] Introduce a PCIe endpoint virtio console
Thread-Index: AQHZbs4fVljyzbxg6UmbNdb4S+yKZq8q3sJQ
Date:   Fri, 14 Apr 2023 14:39:26 +0000
Message-ID: <AM6PR04MB483871ADC2BA657BBF3A5A4588999@AM6PR04MB4838.eurprd04.prod.outlook.com>
References: <20230414123903.896914-1-mie@igel.co.jp>
In-Reply-To: <20230414123903.896914-1-mie@igel.co.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB4838:EE_|AM9PR04MB8618:EE_
x-ms-office365-filtering-correlation-id: fcad2bd8-8081-4a9a-9ac0-08db3cf60bd0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RYYboIBwCNrTT2oq4IXlRLfYxE2kD88JUB3DC4nqqDYdeOK08bDn7yU5FuRH69bRzcGJ5/ZOUmZUSagohhluNxixWd6YVIuEZKDzLGaMfPhzSn5h3ZUfywwnJgzZRluTACjmD6d/Yg9klVrZWKXKyENvE0c1sr/TIVz8rbPMdbgcwEVFS6UE1fWM3e9F/vP/xJVL36yehZpUXP5/etJe+D0AR8lwdfvVg3kKlrtpDeuNro0LeIBnfiu2oXE8qgQy+1I8T1deZDVNEPa5ob+ao9fxDCyrdLSu6Fno80l6olRpIRZlj3iQbmo4poA+PpLYXcxk7qDg1WtCWQ8plJQK+PVJcNITGLT1YPAIwW2Ff4irE/l2J1pOohhMYNF1d0f3YUgTjDKB4aEWMiSRTi23eEaw52RGg6hoD4gwFZgYP+qriF2eLeYYrzbM9RZ8ETajQtgo4QGIFL+fXWygrBc3yr/zYedalKpAoas13lduevZ9rulRZuT0+rWBJs7vKeEWssMkb/f+uyv9CA3H76Syp3Dtq3URIJ9pinky3/miPthOD9gRSrfYELxpO+76SjeSDyGhrewxq1g2fGDsJ/e+0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(451199021)(316002)(83380400001)(41300700001)(110136005)(54906003)(33656002)(86362001)(45080400002)(38100700002)(122000001)(478600001)(38070700005)(66476007)(7696005)(76116006)(66946007)(71200400001)(8676002)(4326008)(66446008)(64756008)(66556008)(966005)(2906002)(66574015)(66899021)(8936002)(186003)(52536014)(44832011)(26005)(9686003)(55236004)(53546011)(6506007)(55016003)(5660300002)(7416002)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnF0SzQxMDBXdElBek93M0FtR2ZmRG82WndMa2RySk9OMkhpVFlRcmU3aS8v?=
 =?utf-8?B?NEIwWG96TnNpSXNFZkJxeDBoNEN0bjVYWE1ZU2hYVTB4Um11Rm5VRFo0ZmJV?=
 =?utf-8?B?aG00V0NxZ1E3QVlCTStwYmpnY0UxZ0c4S1llWmpPRHNXMjJKUUowbXdOQU1x?=
 =?utf-8?B?ZDhsQzFjZTBsai83TjNMVEdmN1VZM2t0S3hRWlk3a1g4NXF6M2NtSVVBbzZX?=
 =?utf-8?B?dDRhNi96Q25EeCtjY2ZlMVdTUEF2MlZzaUZLUHZaWUFKVVZXN01XZ0xvN1Vh?=
 =?utf-8?B?K1JwUk9WMS95M3Q0alBqam1aRjN4KzlGeWRmTG9HVjQwd05JZElBdDlZN1Fh?=
 =?utf-8?B?U1ZHQWZ4WmZXQS9meFZvM0dLZ0VkNC9QcDd0SVU4TFFObmtCZ3ROSmlDSjQ0?=
 =?utf-8?B?V25HN3dhOFRiVXk0SjJncm5nVFJTS0t0dHYzZmVBbmZXNkNxMTdFSWl6YzhK?=
 =?utf-8?B?Yzk4cnpMbll2Skl2OVp1QU9uL2RHaklsbDRmbHJwVWxEVzJoVjNpT3o3RDRN?=
 =?utf-8?B?NGdmTUdpUzdQeUU2Q3A2R1pJNXdraDhJc09namxlL09Cbm1TZEZUQ0ZzcFVQ?=
 =?utf-8?B?YzVDRTdnVjhuVUNGNWdScFVFcEJLTTRiQitSOHZpWXBJNW5HQXpYcmM3bXFJ?=
 =?utf-8?B?ZlJ6RkNXT1FUN09Pc1YyamxzdGZlejl6bFBjM1cyYnQ0RE1pdWx5R2FPV1R1?=
 =?utf-8?B?bTZ4eXY4akxjcTUvZXNyVjhRSkZmUVRodnYzMjAydFZKYm85a3lzem5CSDdj?=
 =?utf-8?B?djlyQ2xpN3pZU2pKODR6N1pJT3YrVFhUbWdVTDNLNG1oOVFWRGVOcUphZW94?=
 =?utf-8?B?dm1aSERZWktpdDRHQ0pBVFlhQ1IxOUw1VjJlNEhkWEMxcVNnQml5WkMrdWNo?=
 =?utf-8?B?dlA5SnVCYVZJQjQ3VWkwd1d0WUtMUFlVRUx6QUthR005NWpkbnZONzhqVUEv?=
 =?utf-8?B?ZjR5dDFkOThJUEJVS2s1UXdWWEg0YXlsU1ZmZmtSYk12d09lK205R25XRVND?=
 =?utf-8?B?bVpPRkF6aTZzMll3UCsyZ3VpMUxza05QZnBLcTlxOTEyV2pydHp2OEF3d1Zz?=
 =?utf-8?B?bG82TWhQRTRZRTlOb1RJSXVjSndqc1FpNlhaVFFpUkVGek1NM1FEOGVnUjJj?=
 =?utf-8?B?clIyK2lZRU81bVpHeWVQNGlDMWc4d3hxN1M0Y2tuaFVQQnJMVzFVR1J0Z1BF?=
 =?utf-8?B?aTM0MEk5cGI1enJzVjBPdWVZSHpSTWkyUW5ieUs5UCtudzhYOFRQWWt6SkZn?=
 =?utf-8?B?SWQzbDd1NHRTSjNMcDlQOG5Gb3BpTGNadkw5d3RMTFplOWlVcXFLeWhEVitV?=
 =?utf-8?B?TFdOcXh0SitTdHUzMFNRRWZKN3A1TEpIaXJtWTJMbnA1REMrbnNVR24zYVpT?=
 =?utf-8?B?eVJTSDNNa2VNMVF2OWdBOTlTeXJNYTlTeWtsZzcrTW80NitzOTBnSkhFRFZH?=
 =?utf-8?B?SzNpWE9McTJVUHlRZjBYckJMSmVsa3NTbzYvay9MVVZ6ZGJzMTZlaE82eVlJ?=
 =?utf-8?B?dnljV1pwcW1sTWxFQWtNUmFrMWNOSW9Lc29KdnowbGJ2UWxjeW9paXlnSGdU?=
 =?utf-8?B?N1QybHc3RTNyeHVCSHNjYm9vVWlCSzVjbEZhNEFlRFlPMC9IS3JqRm02UnFK?=
 =?utf-8?B?M2RsdHJHNmVJa2JnWGxUWnJqc1hHVTFwK0ZMcnpnYjFvbWdpRHZCaUNtd0xp?=
 =?utf-8?B?d3Y3Y3Jma2hHbmt2WnplU1A2SjYzUkpJdXRhL1JXS0JEazNhUEpFalRGeEdq?=
 =?utf-8?B?WTc2eFdIUk01UlBobzI5RDJZNCszV0J6RHdKNjJORWlFdWdQUThHSUZPb0Fs?=
 =?utf-8?B?MDhvMTZ1aFJ6cnBXeEp5bzJvVTFxb0lId1JLQWpuaHNQWW93QklLUzR5Y0pv?=
 =?utf-8?B?MmhLeUN4WnFVK1JwREl2TzN5RDJMM2JEUThUZkFkWlRaanpEZnUwUGZoQk96?=
 =?utf-8?B?eWltaktaQ3prTDdlTVpwOVl4TktXSnhORll1OGhnckhWNTFEa2VrRC9Vd0pH?=
 =?utf-8?B?amhrU2ZmcnBGWDJaYWpmNEY3NFVaM1BOYjlKcWV5QkdaSUROcm5rUmRkQ0Er?=
 =?utf-8?B?QTFkTGJ4SGpUWmQ3cUNHZTZkeEJLWTF0NEMvT3J4dVFVVWFvQkJRR1dnSXRo?=
 =?utf-8?Q?hVXY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcad2bd8-8081-4a9a-9ac0-08db3cf60bd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2023 14:39:26.0812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a0TO2t2wDuCAwXy7cSGbeoYyvzcEgbx4zb51Geb0G4ADUKaucncbmZmj27ejs6HyT4HAIAR2LZ9B6c3avgXlTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8618
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2h1bnN1a2UgTWllIDxt
aWVAaWdlbC5jby5qcD4NCj4gU2VudDogRnJpZGF5LCBBcHJpbCAxNCwgMjAyMyA3OjM5IEFNDQo+
IFRvOiBMb3JlbnpvIFBpZXJhbGlzaSA8bHBpZXJhbGlzaUBrZXJuZWwub3JnPg0KPiBDYzogS3J6
eXN6dG9mIFdpbGN6ecWEc2tpIDxrd0BsaW51eC5jb20+OyBNYW5pdmFubmFuIFNhZGhhc2l2YW0N
Cj4gPG1hbmlAa2VybmVsLm9yZz47IEtpc2hvbiBWaWpheSBBYnJhaGFtIEkgPGtpc2hvbkBrZXJu
ZWwub3JnPjsgQmpvcm4NCj4gSGVsZ2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT47IE1pY2hhZWwg
Uy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+Ow0KPiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPjsgU2h1bnN1a2UgTWllIDxtaWVAaWdlbC5jby5qcD47DQo+IEZyYW5rIExpIDxmcmFu
ay5saUBueHAuY29tPjsgSm9uIE1hc29uIDxqZG1hc29uQGt1ZHp1LnVzPjsgUmFuZHkNCj4gRHVu
bGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+OyBSZW4gWmhpamllIDxyZW56aGlqaWUyQGh1YXdl
aS5jb20+Ow0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1wY2lAdmdlci5r
ZXJuZWwub3JnOw0KPiB2aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZw0K
PiBTdWJqZWN0OiBbRVhUXSBbUkZDIFBBVENIIDAvM10gSW50cm9kdWNlIGEgUENJZSBlbmRwb2lu
dCB2aXJ0aW8gY29uc29sZQ0KPg0KPiBDYXV0aW9uOiBFWFQgRW1haWwNCj4NCj4gUENJZSBlbmRw
b2ludCBmcmFtZXdvcmsgcHJvdmlkZXMgQVBJcyB0byBpbXBsZW1lbnQgUENJZSBlbmRwb2ludA0K
PiBmdW5jdGlvbi4NCj4gVGhpcyBmcmFtZXdvcmsgYWxsb3dzIGRlZmluaW5nIHZhcmlvdXMgUENJ
ZSBlbmRwb2ludCBmdW5jdGlvbiBiZWhhdmlvcnMgaW4NCj4gc29mdHdhcmUuIFRoaXMgcGF0Y2gg
ZXh0ZW5kIHRoZSBmcmFtZXdvcmsgZm9yIHZpcnRpbyBwY2kgZGV2aWNlLiBUaGUNCj4gdmlydGlv
IGlzIGRlZmluZWQgdG8gY29tbXVuaWNhdGUgZ3Vlc3Qgb24gdmlydHVhbCBtYWNoaW5lIGFuZCBo
b3N0IHNpZGUuDQo+IEFkdmFudGFnZSBvZiB0aGUgdmlydGlvIGlzIHRoZSBlZmZpY2llbmN5IG9m
IGRhdGEgdHJhbnNmZXIgYW5kIHRoZSBjb25jaXNlbmVzcw0KPiBvZiBpbXBsZW1lbnRhdGlvbiBk
ZXZpY2UgdXNpbmcgc29mdHdhcmUuIEl0IGFsc28gYmUgYXBwbGllZCB0byBQQ0llDQo+IGVuZHBv
aW50IGZ1bmN0aW9uLg0KPg0KPiBXZSBkZXNpZ25lZCBhbmQgaW1wbGVtZW50ZWQgYSBQQ0llIEVQ
IHZpcnRpbyBjb25zb2xlIGZ1bmN0aW9uIGRyaXZlciB1c2luZw0KPiB0aGUgZXh0ZW5kZWQgUENJ
ZSBlbmRwb2ludCBmcmFtZXdvcmsgZm9yIHZpcnRpby4gSXQgY2FuIGJlIGNvbW11bmljYXRlDQo+
IGhvc3QgYW5kIGVuZHBvaW50IG92ZXIgdmlydGlvIGFzIGNvbnNvbGUuDQo+DQo+IEFuIGFyY2hp
dGVjdHVyZSBvZiB0aGUgZnVuY3Rpb24gZHJpdmVyIGlzIGZvbGxvd2luZzoNCj4NCj4gIOKUjOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUkCAgICAgICAgIOKUjOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgA0KPiDilIDilIDilIDilIDilIDilIDi
lIDilIDilKzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilJANCj4gIOKUgnZp
cnRpbyAgICAgIOKUgiAgICAgICAgIOKUgiAgICAgICAgICAgICAgICAgICAgICDilIJ2aXJ0aW8g
ICAgICDilIINCj4gIOKUgmNvbnNvbGUgZHJ2IOKUgiAgICAgICAgIOKUnOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUkCAgICAgIOKUgmNvbnNvbGUNCj4gZHJ2
IOKUgg0KPiAg4pSc4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSkICAgICAg
ICAg4pSCKHZpcnRpbyBjb25zb2xl4pSCICAgICAg4pSc4pSA4pSA4pSA4pSA4pSADQo+IOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUpA0KPiAg4pSCIHZpcnRpbyBidXMg4pSCICAgICAgICAg4pSCIGRl
dmljZSkgICAgICAg4pSC4peE4pSA4pSA4pSA4pSA4pa64pSCIHZpcnRpbyBidXMg4pSCDQo+ICDi
lJzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilKQgICAgICAgICDilJwtLS0t
LS0tLS0tLS0tLS3ilKQgICAgICDilJTilIDilIDilIDilIDilIDilIANCj4g4pSA4pSA4pSA4pSA
4pSA4pSA4pSkDQo+ICDilIIgICAgICAgICAgICDilIIgICAgICAgICDilIIgcGNpIGVwIHZpcnRp
byDilIIgICAgICAgICAgICAgICAgICAg4pSCDQo+ICDilIIgIHBjaSBidXMgICDilIIgICAgICAg
ICDilIIgIGNvbnNvbGUgZHJ2ICDilIIgICAgICAgICAgICAgICAgICAg4pSCDQo+ICDilIIgICAg
ICAgICAgICDilIIgIHBjaWUgICDilJzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilKQgICAgICAgICAgICAgICAgICAg4pSCDQo+ICDilIIgICAgICAgICAgICDi
lIIg4peE4pSA4pSA4pSA4pSA4pSA4pa6IOKUgiAgcGNpIGVwIEJ1cyAgIOKUgiAgICAgICAgICAg
ICAgICAgICDilIINCj4gIOKUlOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
mCAgICAgICAgIOKUlOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgA0K
PiDilIDilLTilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilJgNCj4gICAgUENJZSBSb290ICAgICAgICAgICAgICBQQ0llIEVuZHBvaW50DQo+
DQoNCltGcmFuayBMaV0gU29tZSBiYXNpYyBxdWVzdGlvbiwNCkkgc2VlIHlvdSBjYWxsIHJlZ2lz
dGVyX3ZpcnRpb19kZXZpY2UgYXQgZXBmX3Zjb25fc2V0dXBfdmRldiwNCldoeSBjYWxsIGl0IGFz
IHZpcnRpbyBjb25zb2xlPyAgSSBzdXBwb3NlIGl0IHNob3VsZCBiZSB2aXJ0aW9idXMgZGlyZWN0
bHk/DQoNClByZXZpb3VzIHlvdSB1c2UgdmlydGlvLW5ldCwgd2h5IGNoYW5nZSB0byB2aXJ0aW8t
Y29uc29sZSBoZXJlPyAgRG9lcyBpdCBtYXR0ZXI/DQpBbGwgdmlydGlvLVhYWCBzaG91bGQgd29y
az8NCg0KWW91IHJlbW92ZWQgRURNQSBzdXBwb3J0IHRoaXMgdmVyc2lvbj8NCg0KDQo+IEludHJv
ZHVjZWQgZHJpdmVyIGlzIGBwY2kgZXAgdmlydGlvIGNvbnNvbGUgZHJ2YCBpbiB0aGUgZmlndXJl
LiBJdCB3b3Jrcw0KPiBhcyBlcCBmdW5jdGlvbiBmb3IgUENJZSByb290IGFuZCB2aXJ0dWFsIHZp
cnRpbyBjb25zb2xlIGRldmljZSBmb3IgUENJZQ0KPiBlbmRwb2ludC4gRWFjaCBzaWRlIG9mIHZp
cnRpbyBjb25zb2xlIGRyaXZlciBoYXMgdmlydHF1ZXVlLCBhbmQNCj4gaW50cm9kdWNlZCBkcml2
ZXIgdHJhbnNmZXJzIGRhdGEgb24gdGhlIHZpcnRxdWV1ZSB0byBlYWNoIG90aGVyLiBBIGRhdGEN
Cj4gb24gcm9vdCB0eCBxdWV1ZSBpcyB0cmFuc2ZlcmVkIHRvIGVuZHBvaW50IHJ4IHF1ZXVlIGFu
ZCB2aWNlIHZlcnNhLg0KPg0KPiBUaGlzIHBhdGNoc2V0IGlzIGRlcGVuZCBmb2xsd2luZyBwYXRj
aGVzIHdoaWNoIGFyZSB1bmRlciBkaXNjdXNzaW9uLg0KPg0KPiAtIFtSRkMgUEFUQ0ggMC8zXSBE
ZWFsIHdpdGggYWxpZ25tZW50IHJlc3RyaWN0aW9uIG9uIEVQIHNpZGUNCj4gbGluazoNCj4gaHR0
cHM6Ly9sb3JlLmsvDQo+IGVybmVsLm9yZyUyRmxpbnV4LXBjaSUyRjIwMjMwMTEzMDkwMzUwLjEx
MDM0OTQtMS0NCj4gbWllJTQwaWdlbC5jby5qcCUyRiZkYXRhPTA1JTdDMDElN0NGcmFuay5MaSU0
MG54cC5jb20lN0NlYTY1MTNkYmYNCj4gNDA4NGI4MGNlZDIwOGRiM2NlNTQxMzMlN0M2ODZlYTFk
M2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlNw0KPiBDMCU3QzYzODE3MDcyNzU1ODgwMDcy
MCU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHcNCj4gTGpBd01EQWlMQ0pRSWpv
aVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMzAwMCU3Qw0KPiAlN0Ml
N0Mmc2RhdGE9allneSUyQnhrODRaWFpSVmZxbTBHQ1hvUm5DVExNclg0elRmViUyQnM1TW1zdm8N
Cj4gJTNEJnJlc2VydmVkPTANCj4gLSBbUkZDIFBBVENIIHYyIDAvN10gSW50cm9kdWNlIGEgdnJp
bmdoIGFjY2Vzc29yIGZvciBJTyBtZW1vcnkNCj4gbGluazoNCj4gaHR0cHM6Ly9sb3JlLmsvDQo+
IGVybmVsLm9yZyUyRnZpcnR1YWxpemF0aW9uJTJGMjAyMzAyMDIwOTA5MzQuNTQ5NTU2LTEtDQo+
IG1pZSU0MGlnZWwuY28uanAlMkYmZGF0YT0wNSU3QzAxJTdDRnJhbmsuTGklNDBueHAuY29tJTdD
ZWE2NTEzZGJmDQo+IDQwODRiODBjZWQyMDhkYjNjZTU0MTMzJTdDNjg2ZWExZDNiYzJiNGM2ZmE5
MmNkOTljNWMzMDE2MzUlN0MwJTcNCj4gQzAlN0M2MzgxNzA3Mjc1NTg4MDA3MjAlN0NVbmtub3du
JTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3DQo+IExqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxD
SkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzMwMDAlN0MNCj4gJTdDJTdDJnNkYXRhPUs0
RWw3NkdTQUd0c1drTkJYSks1JTJGbjdmbENOMjBlRU1acFpZVFgyV0laMCUzDQo+IEQmcmVzZXJ2
ZWQ9MA0KPg0KPiBGaXJzdCBvZiB0aGlzIHBhdGNoc2V0IGlzIGludHJvZHVjZSBhIGhlbHBlciBm
dW5jdGlvbiB0byByZWFsaXplIHBjaQ0KPiB2aXJ0aW8gZnVuY3Rpb24gdXNpbmcgUENJZSBlbmRw
b2ludCBmcmFtZXdvcmsuIFRoZSBzZWNvbmQgb25lIGlzIGFkZGluZw0KPiBhIG1pc3NpbmcgZGVm
aW5pdGlvbiBmb3IgdmlydGlvIHBjaSBoZWFkZXIuIFRoZSBsYXN0IG9uZSBpcyBmb3IgUENJZQ0K
PiBlbmRwb2ludCB2aXJ0aW8gY29uc29sZSBkcml2ZXIuDQo+DQo+IFRoaXMgaXMgdGVzdGVkIG9u
IGxpbnV4LTIwMjMwNDA2IGFuZCBSQ2FyIFM0IGJvYXJkIGFzIFBDSWUgZW5kcG9pbnQuDQo+DQo+
IFNodW5zdWtlIE1pZSAoMyk6DQo+ICAgUENJOiBlbmRwb2ludDogaW50cm9kdWNlIGEgaGVscGVy
IHRvIGltcGxlbWVudCBwY2kgZXAgdmlydGlvIGZ1bmN0aW9uDQo+ICAgdmlydGlvX3BjaTogYWRk
IGEgZGVmaW5pdGlvbiBvZiBxdWV1ZSBmbGFnIGluIElTUg0KPiAgIFBDSTogZW5kcG9pbnQ6IEFk
ZCBFUCBmdW5jdGlvbiBkcml2ZXIgdG8gcHJvdmlkZSB2aXJ0aW8tY29uc29sZQ0KPiAgICAgZnVu
Y3Rpb25hbGl0eQ0KPg0KPiAgZHJpdmVycy9wY2kvZW5kcG9pbnQvZnVuY3Rpb25zL0tjb25maWcg
ICAgICAgIHwgIDE5ICsNCj4gIGRyaXZlcnMvcGNpL2VuZHBvaW50L2Z1bmN0aW9ucy9NYWtlZmls
ZSAgICAgICB8ICAgMiArDQo+ICBkcml2ZXJzL3BjaS9lbmRwb2ludC9mdW5jdGlvbnMvcGNpLWVw
Zi12Y29uLmMgfCA1NTQgKysrKysrKysrKysrKysrKysrDQo+ICAuLi4vcGNpL2VuZHBvaW50L2Z1
bmN0aW9ucy9wY2ktZXBmLXZpcnRpby5jICAgfCA0NjkgKysrKysrKysrKysrKysrDQo+ICAuLi4v
cGNpL2VuZHBvaW50L2Z1bmN0aW9ucy9wY2ktZXBmLXZpcnRpby5oICAgfCAxMjMgKysrKw0KPiAg
aW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19wY2kuaCAgICAgICAgICAgICAgIHwgICAzICsNCj4g
IDYgZmlsZXMgY2hhbmdlZCwgMTE3MCBpbnNlcnRpb25zKCspDQo+ICBjcmVhdGUgbW9kZSAxMDA2
NDQgZHJpdmVycy9wY2kvZW5kcG9pbnQvZnVuY3Rpb25zL3BjaS1lcGYtdmNvbi5jDQo+ICBjcmVh
dGUgbW9kZSAxMDA2NDQgZHJpdmVycy9wY2kvZW5kcG9pbnQvZnVuY3Rpb25zL3BjaS1lcGYtdmly
dGlvLmMNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3BjaS9lbmRwb2ludC9mdW5jdGlv
bnMvcGNpLWVwZi12aXJ0aW8uaA0KPg0KPiAtLQ0KPiAyLjI1LjENCg0K
