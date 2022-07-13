Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9346B573405
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jul 2022 12:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbiGMKVb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jul 2022 06:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiGMKVa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2022 06:21:30 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70053.outbound.protection.outlook.com [40.107.7.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8997F6B93
        for <linux-pci@vger.kernel.org>; Wed, 13 Jul 2022 03:21:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CNX338dMJAeHjO5Pf4DUpTg/7v+qplpdlaDE6c4y+zas+gA/Afu1/G+fYWXFdahkZvqD4x99LakRowbv3ZOxpiYila4PD+IjFqJptFzlJ5pwLuTStjnTW5y7CxWYApJAylH1ZSs2Q+vNA8BFHqe8VJzyBwjyrCVF9jAoho+ULedCYk7+f+pzLx4sVu41xdW8RdU92U20zJmdZ5/iTGEVImqm9pFu61wFV/TWY/NrscqSdmYg4LC9nPi0CRynNyfgCL8wpyLBf32D2JoLsSTI6qQjcT/e2wLw1N/51gfnMgsN6/8gLlt0J3J+00YfEfWzOzfMf+qaGzAYJqsH7JolPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5cbdhkWCeuhIsdm4dDH84BtpazSlo1qJuc/6TuJnU4=;
 b=E61EQm5s+P2cxvqtF4JuzAzB72B1z4xmzwtb477J42Fe0HYXnjnbld7TGOQc6sZTryi5fWlUL056yhn4PCVvmj2ggWefg8csusX91EQTm3EDrHAn+Y+OGsKkQ6A8ZBXu59jj8b/GlHWi+GeApAwHi3Yckg9AL1VUuoG737ew4rVsA0xnv897W7F/7Jiz2BFPck6r8yY88+EisCJObhmNhkBbxaVc3HInUo930i7lByGbrMzdPqjkCZ3IvsT0Fnlc3dy2B6dFiSNK/nVSI49z6cWkXF/mgFKql3WoJYYx9NWYX9h8Bj++D3eqmktpkSlX3WG7oDlXDqOP5OOlFpLUUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5cbdhkWCeuhIsdm4dDH84BtpazSlo1qJuc/6TuJnU4=;
 b=CoVPhBLp/rk1oCxQtt/Tlv3xRAnKU/NvlVbmaL6fJ0QkxwrM8+6uGetoSB2rbEA4dCP7J8rRhmSH+NZvXycjb3vXBqibIlX5keBBNa9M8CmyA7pA+F7qKfnCcRl/SLW72spHd7v4ZEiVJcVbEHwBKri9ZXxbh6dPjuxFFoeseHw=
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com (2603:10a6:10:370::16)
 by AM6PR04MB5126.eurprd04.prod.outlook.com (2603:10a6:20b:4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Wed, 13 Jul
 2022 10:21:26 +0000
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::5d42:d3a1:441e:bba0]) by DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::5d42:d3a1:441e:bba0%5]) with mapi id 15.20.5438.012; Wed, 13 Jul 2022
 10:21:26 +0000
From:   "Z.Q. Hou" <zhiqiang.hou@nxp.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
CC:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>
Subject: RE: [PATCH] PCI: Align MPS to upstream bridge for SAFE and
 PERFORMANCE mode
Thread-Topic: [PATCH] PCI: Align MPS to upstream bridge for SAFE and
 PERFORMANCE mode
Thread-Index: AQHYfNofgEASmrYSw0OBa+REYGw7zq18SPYA
Date:   Wed, 13 Jul 2022 10:21:25 +0000
Message-ID: <DB9PR04MB9236E2138DB733AFE1554C0884899@DB9PR04MB9236.eurprd04.prod.outlook.com>
References: <20220610150131.6256-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20220610150131.6256-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df812137-3168-4d61-a3af-08da64b97173
x-ms-traffictypediagnostic: AM6PR04MB5126:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OqWJ4X4FpbwaxLFXyxabMGhNKzMqEBH2ADwen0kd1LPwWFGpPaOrfxFYb2ZPJs9bFsb8cR2iTtpCDZ8G7aeEdgotznPKvS7SOO2bw7DfF0fosc8tDH1toTTkgKASBCUyT9xRsIAvrmv5I7PR4+JmSACuoO8EqnSsFWEQ1+XL6jwt9CduSrYi6DhU/AtMj3ehWjYJK/1KK6J8v5/9bEhRmqh5W4AguJwVyMWLTWMqImt9sJ2PB+OtULcsf58sclW5b8dqIHzQ9xcyiwsprSqD/R0k01dopWCjmfVAdl10SBJ8F6O7bQuyzq+ADfsjgm71IytjL3wjiKdfoknlFazDd4zPZXHhp2ecdJaiZhaUe4xStd22s/7ICOru7EN7DVoNgq95WNX2CfK+pyukWOHzfPGyt9vaeDSnALxThq0WayFEK1SgMvmqt7ZTNYniFgl/Etjxp32J9/worgkR4oU8z1gUa8VrOgFKYfEp717jMFmwW50cSlLrlH4QvPWsiA2FyFWAMYkuXv9GEbKnMbYewkBQT3D74nbuNnGkC5ce5wrySeuoYC+eUeuzoxm9TPX/ir6spGEkLHdOf/ysGikereAbq6ciMBEQeuc0k7UKjN7irudc76fOS6rM9RJfXQZzul8MpKC1P+Sjdb2cDpYdEpxLiY4aqzvecAhAYFO8XEQvAPHAjq0IrJRuAozROprh3bSy+at/Zk5Gf4e6uBs3WZYWI/W4IrI1fS34vlDnvhRZUNy4zO8+gY4Eepna4F5c6EYfQzrYjylzY52simeANb/BU0XNZdl8DeAlE3zqpowTiwK5+otmqb/vz8hYYX/j
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9236.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(346002)(136003)(396003)(376002)(52536014)(8936002)(5660300002)(55016003)(2906002)(38070700005)(83380400001)(122000001)(86362001)(33656002)(76116006)(38100700002)(478600001)(9686003)(71200400001)(110136005)(316002)(66446008)(66946007)(66556008)(4326008)(66476007)(8676002)(186003)(64756008)(7696005)(6506007)(41300700001)(53546011)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?bTRENkhKZmF5MGFTVWFYQUdCYU9SRzg5S0pLZVFaRENybEZWbU1kRzk3ZFpi?=
 =?gb2312?B?Q0oxRmF6eWZTRzhOREl0aytDQmtxckF4YXk0NmJYQlNKeWJJbW82dmp1Qkpr?=
 =?gb2312?B?bHpCVWpVZE1KN0thZUV3d0laUzZDWlNoT3BRdXVDYmd4Tm9FVStuSVhMRlBo?=
 =?gb2312?B?aEtOMFJyNy9oN1dSSzlCcS9KRitzR09sdnd5VVRML0QxdS9MK1RjcTV6bG0z?=
 =?gb2312?B?U0xGVnJtNlpFTS90Z1phK3RXWE56NTNkais1Y2RLeEVqaWR0TCtXbDVsS2RK?=
 =?gb2312?B?bVM1eERMR2p6T0MrVFQrZndLcGtqY05CbkR1YTRQUGhqclJyYm5JUzYrZ2JU?=
 =?gb2312?B?YXVhWFptcE93U2JXYkpoeEZ2cHY2ZXVQL0V4QnZrZER6NGhiVEtYYkxWVjYy?=
 =?gb2312?B?NkpPNTI3ZGw1SUJuSTdqOVJERk8rYnhBUTFXaDMrTk1wUWExRE9JNVhoNzdz?=
 =?gb2312?B?WVBtd1hDRE5mdUdQU3Ewa1ltN0NkWEpBcEV6RTN3c0NNRVFuUTl0bDZLWXp4?=
 =?gb2312?B?YzFrc0ZXUHdVY3k2eE1TVkErdE5EbkFHY0hXRlowSXZzRTlTcnB4c1J6alg5?=
 =?gb2312?B?dGRTRGdoVmJGY1RmRzJ3dnBITXlHUCtBRlhvckM1aFhnWENhaFQ2Zlg2Y2hT?=
 =?gb2312?B?M0ZnSnZwWkJwQ2V0RTNDODJ2aXBpcVBwQ2M5UE9qSkpCMjFJeUZaMVdNVDlw?=
 =?gb2312?B?eGZOU2FlQUR1MEhocS9GNWJmWW1nZGQzSUdZM0MvR3ZjcnJpMUIyMGEzNEZI?=
 =?gb2312?B?SUViNDc2Tk5WaW0rcjc2QURvY2dhQzh1S3FFL2NEdEtJT2pkVlo4dGFzQ3V6?=
 =?gb2312?B?U1RydytCZnZ5M2V2bEx5SnpwZjVvQ21IRVBYaEJRcjJHVlhCQmd4ci9zKzRq?=
 =?gb2312?B?TndhL2tyQlpkTVQ2SFducCtMNC81R011QXlxd0hXZDR4cGltNVBxRnYzRmNH?=
 =?gb2312?B?TUY5SFp6OWZHQWNQNGNLajJWY2pxTFZCT0FLY2tGTGp4NUFka2x1QktxWDZP?=
 =?gb2312?B?aWFDcTlFZ1RWWGRFNWhDby8rSGw5ZTdmOXFLMkIrOFBHRnUxckdIMHdjRTVO?=
 =?gb2312?B?T2syaWxmakhzRXEzY2ZLeDg5RmVIS1NIWHFiV1Q0QVdJSWtjUWtRWnBpNXc2?=
 =?gb2312?B?NlczL3J5UnRJSDBRYnJ2bDRranZnN1ZPUTVVNW05b1EvZUFQVzh2TXdkQ2Vw?=
 =?gb2312?B?NDBmZXpZMXFLa055NUR0ZGNjUDhkc1psT1VYYmJSeVBkd1Q1T25LeEVuMXlQ?=
 =?gb2312?B?Smk3bnByVGY1eVpGMmpFT2ZEcjBWSzNBNzdjRXFGanZpM3M3T21XYXBaYUN5?=
 =?gb2312?B?cHgwSy9vcUhYaVhaazlBK053SGJoWGlLbjRKKzlVWWRyZFdodG0wOThSaDdD?=
 =?gb2312?B?alpPNE5aUS92UktMOU9OUTZrRnJpQTZ2ekl4QVlXTW03NG9JZFpiSnY0VG1C?=
 =?gb2312?B?ODJJL2JPSno0VExjVUEzdmllYzJQNEZRcjVCQ28weXhKZWhiMWo3Zk1mY2NQ?=
 =?gb2312?B?ZlZZS2dORThxYnJseW9FWVd6OHlvMkc4Q1BteHFSSFg0Z1ZkQkY0TkF4QmdX?=
 =?gb2312?B?eVU4aWQyVzhxQzNYb3k2TXZSTFBONzdNdmo3SzQ1SHpMZVNZa1hzUHhvUS9y?=
 =?gb2312?B?Y2phZzVzcHZUS3pxSlliSE40TG1hcWFXdmhIOG0vTXd0RndVMVRBZUYrUGlp?=
 =?gb2312?B?cWdZSlQ2N1IxRUpPTzZReE5tclRnTSt5N0JWenN2LzE1dXBManlsVURQM0pE?=
 =?gb2312?B?RW5xSWRpLzFjelBtaVdNZDRmSWd2cVhQMUkyTEZSWWZuemplQzJYTXp3MHlF?=
 =?gb2312?B?K2M4L2lYMGJKYnVvV1l3d0xRNWFXc2pPdjlsZlJaaW1IdncwNjg0dXZsL3RO?=
 =?gb2312?B?eVJOMUVacHhzZGJUbXU2T1h5UkhBMTlZelA0ZUxISmVHYXJ0WFR1UlUwNnJE?=
 =?gb2312?B?UU9LRFNJTHlaRzZycTNpajdRNXdVN0t1cC9Fb2RrNjZjSEN4ZkJYOTBpR1hL?=
 =?gb2312?B?OCtpZG54OGNQVGVZQnZhU2VZdklLK3lzeDZHMVBQTlh5aXl3alhIV0tZa01i?=
 =?gb2312?B?NzExQlh1ZitneHRKaUxqUXNmeERaN2JocXpwaCtsRnVKd1dXNVRYem5IeWJI?=
 =?gb2312?Q?GS2/uo9N0lvO6SFhCucH8vZFa?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9236.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df812137-3168-4d61-a3af-08da64b97173
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 10:21:26.0852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3vlinTffJjjddhNCEdBT4kj5DtFST0Una4pHcXYG92TEXCAThVwa5yI5dfVtLKb7i84vCoiCBOWqHJ03oquDMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5126
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQmpvcm4gYW5kIExvcmVuem8sDQoNCkFueSBjb21tZW50cyBvbiB0aGlzIGNoYW5nZT8NCg0K
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFouUS4gSG91IDx6aGlxaWFuZy5ob3VA
bnhwLmNvbT4gDQpTZW50OiAyMDIyxOo21MIxMMjVIDIzOjAyDQpUbzogbGludXgtcGNpQHZnZXIu
a2VybmVsLm9yZzsgYmhlbGdhYXNAZ29vZ2xlLmNvbQ0KQ2M6IFouUS4gSG91IDx6aGlxaWFuZy5o
b3VAbnhwLmNvbT4NClN1YmplY3Q6IFtQQVRDSF0gUENJOiBBbGlnbiBNUFMgdG8gdXBzdHJlYW0g
YnJpZGdlIGZvciBTQUZFIGFuZCBQRVJGT1JNQU5DRSBtb2RlDQoNCkZyb206IEhvdSBaaGlxaWFu
ZyA8WmhpcWlhbmcuSG91QG54cC5jb20+DQoNClRoZSBjb21taXQgMjdkODY4YjVlNmNmICgiUENJ
OiBTZXQgTVBTIHRvIG1hdGNoIHVwc3RyZWFtIGJyaWRnZSIpIG1hZGUgdGhlIGRldmljZSdzIE1Q
UyBtYXRjaGVzIHVwc3RyZWFtIGJyaWRnZSBmb3IgUENJRV9CVVNfREVGQVVMVCBtb2RlLCBzbyB0
aGF0IGl0J3MgbW9yZSBsaWtlbHkgdGhhdCBhIGhvdC1hZGRlZCBkZXZpY2Ugd2lsbCB3b3JrIGlu
IGEgc3lzdGVtIHdpdGggYW4gb3B0aW1pemVkIE1QUyBjb25maWd1cmF0aW9uLg0KDQpPYnZpb3Vz
bHksIHRoZSBMaW51eCBpdHNlbGYgb3B0aW1pemVzIHRoZSBNUFMgc2V0dGluZ3MgaW4gdGhlIFBD
SUVfQlVTX1NBRkUgYW5kIFBDSUVfQlVTX1BFUkZPUk1BTkNFIG1vZGUsIHNvIGxldCdzIGRvIHRo
aXMgYWxzbyBmb3IgdGhlc2UgbW9kZXMuDQoNClNpZ25lZC1vZmYtYnk6IEhvdSBaaGlxaWFuZyA8
WmhpcWlhbmcuSG91QG54cC5jb20+DQotLS0NCiBkcml2ZXJzL3BjaS9wcm9iZS5jIHwgNiArKysr
LS0NCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvcHJvYmUuYyBiL2RyaXZlcnMvcGNpL3Byb2JlLmMgaW5k
ZXggMTdhOTY5OTQyZDM3Li4yYzVhMWFlZmQ5Y2IgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3BjaS9w
cm9iZS5jDQorKysgYi9kcml2ZXJzL3BjaS9wcm9iZS5jDQpAQCAtMjAzNCw3ICsyMDM0LDkgQEAg
c3RhdGljIHZvaWQgcGNpX2NvbmZpZ3VyZV9tcHMoc3RydWN0IHBjaV9kZXYgKmRldikNCiAJICog
RmFuY2llciBNUFMgY29uZmlndXJhdGlvbiBpcyBkb25lIGxhdGVyIGJ5DQogCSAqIHBjaWVfYnVz
X2NvbmZpZ3VyZV9zZXR0aW5ncygpDQogCSAqLw0KLQlpZiAocGNpZV9idXNfY29uZmlnICE9IFBD
SUVfQlVTX0RFRkFVTFQpDQorCWlmIChwY2llX2J1c19jb25maWcgIT0gUENJRV9CVVNfREVGQVVM
VCAmJg0KKwkgICAgcGNpZV9idXNfY29uZmlnICE9IFBDSUVfQlVTX1NBRkUgJiYNCisJICAgIHBj
aWVfYnVzX2NvbmZpZyAhPSBQQ0lFX0JVU19QRVJGT1JNQU5DRSkNCiAJCXJldHVybjsNCiANCiAJ
bXBzcyA9IDEyOCA8PCBkZXYtPnBjaWVfbXBzczsNCkBAIC0yMDQ3LDcgKzIwNDksNyBAQCBzdGF0
aWMgdm9pZCBwY2lfY29uZmlndXJlX21wcyhzdHJ1Y3QgcGNpX2RldiAqZGV2KQ0KIA0KIAlyYyA9
IHBjaWVfc2V0X21wcyhkZXYsIHBfbXBzKTsNCiAJaWYgKHJjKSB7DQotCQlwY2lfd2FybihkZXYs
ICJjYW4ndCBzZXQgTWF4IFBheWxvYWQgU2l6ZSB0byAlZDsgaWYgbmVjZXNzYXJ5LCB1c2UgXCJw
Y2k9cGNpZV9idXNfc2FmZVwiIGFuZCByZXBvcnQgYSBidWdcbiIsDQorCQlwY2lfd2FybihkZXYs
ICJjYW4ndCBzZXQgTWF4IFBheWxvYWQgU2l6ZSB0byAlZDsgaWYgbmVjZXNzYXJ5LCB1c2UgDQor
XCJwY2k9cGNpZV9idXNfcGVlcjJwZWVyXCIgYW5kIHJlcG9ydCBhIGJ1Z1xuIiwNCiAJCQkgcF9t
cHMpOw0KIAkJcmV0dXJuOw0KIAl9DQotLQ0KMi4xNy4xDQoNClRoYW5rcywNClpoaXFpYW5nDQoN
Cg==
