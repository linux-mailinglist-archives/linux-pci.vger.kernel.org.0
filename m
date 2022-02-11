Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848FC4B1BE3
	for <lists+linux-pci@lfdr.de>; Fri, 11 Feb 2022 03:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347129AbiBKCF2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Feb 2022 21:05:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344360AbiBKCF1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Feb 2022 21:05:27 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2041.outbound.protection.outlook.com [40.107.20.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEE35F9B;
        Thu, 10 Feb 2022 18:05:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DD7SVzwmFB9oQVRbhFmivZgRIz2XVpnLM/OQ0tXGeueXu/xS5VQt6vDacgDAY64lD613VQ3du3r0TQsLgqyS7KfhNHhw4NQq9pKH1WoEnOU1+8DZmjoPFr/OKJRQ1Dbr0BQP9M1nPZn4SrzZeiyvhs6H460zmiGAIoGyIKOXbfCbLMk3GgYAG07KVPQ8wtxUwyIOTknO4tYGYkX3df7O6Wl1MLtYaHp8YqDnqE34JUsEG23hdNniPzVvvbeEEPQwPWfIgt3J4CI9qxAvoB1ZMb354n3w/UkjphPjRvR8f7oHgvNufyqJ/PJtjFW30AnVDahTcuqBv89qJ/2GD9Zmow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4cgMUZqaFg+S3IaBHmnxh5Nnbpprz0i7BolEiHt97g=;
 b=bshaHAZQAbzjFWW9Z5ji41HW9qgxcvdt8hZn8fMm8v1Du8jShzp6BC5Y6yMucG+f2XOVGnctoh+TbBgfbKZCyYT8A8cPPetJYBr+3ZtJPzY6KjjOxoEGECN0yHadUfDkYo0ZI4FNKL8zS/3BPilvnNwPrhYHdJiuHU5OW/EVphfzKPG9P4hfRORPloY3ozzfDkKWJmRZX5ttWLkNlo5ExLVIobMlihEAlHzFGvNxyUsF0bgNrlw+nVOt34uGisG7rYbynrCLHoVRpnl/9Pn6xGGwnRM9qgxkyHoqlaZvpksL3lqf2Vv0mt9cqhV6S9Ml4DgzPduEz7DVxB4PXz7k6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4cgMUZqaFg+S3IaBHmnxh5Nnbpprz0i7BolEiHt97g=;
 b=J9qrbpl5a+RKtI1odk5XiPHlZxMz6SnJ5S4kAammA3hppzX6fsWK83aY7L+2nuKVKHz8WZJf3roCWARgSZyTQPRwJ1OtNuwN4EJiLhIJoEpnYnxbAjJysTNuTfrhSaqZIy+GrjW5wWuB7mGR5KUYXam4RBfjwNCITT43012ikG0=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS1PR04MB9479.eurprd04.prod.outlook.com (2603:10a6:20b:4d7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 02:05:24 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::3d1c:b479:1c58:199]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::3d1c:b479:1c58:199%4]) with mapi id 15.20.4975.011; Fri, 11 Feb 2022
 02:05:24 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [RFC 2/2] PCI: imx6: Enable imx6qp pcie power management support
Thread-Topic: [RFC 2/2] PCI: imx6: Enable imx6qp pcie power management support
Thread-Index: AQHYHYduLICm7+FWyEagAyZved6iF6yLWpYAgACtzBCAAVDwAIAAOJIQ
Date:   Fri, 11 Feb 2022 02:05:24 +0000
Message-ID: <AS8PR04MB8676C19FBD01547BDF80CFC68C309@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <AS8PR04MB867616CDC587BB93772AC8588C2F9@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <20220210220436.GA656671@bhelgaas>
In-Reply-To: <20220210220436.GA656671@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8681f63-b4af-442c-7d65-08d9ed02f753
x-ms-traffictypediagnostic: AS1PR04MB9479:EE_
x-microsoft-antispam-prvs: <AS1PR04MB947976BA092034815793D61E8C309@AS1PR04MB9479.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kviIolP2cqQbtmpGFYbkxqEjEBDJWqziZuOtIM03G+D9ZW1EbCXIUjulj07wyqLuu9JHTau1FbCe4ArUjg0/IJaKNa//jUw7UMnRfk0V5yp7aBxmt0a1PAnF3DjzvX2OZ+3FaRprQSEd+uUvJTU4p1Le8OqqEB12PDRvmv7s/z9UNuKdILv7IUJ/l8ax+kYa5cg/xe6rId0IcQuIuIE9PIBQUqZ2js45pPpu+OfoNoJ1bxGrDPEhBPNAKbl9LJGQkxB5vz6n9sFt/WjIbDfRfNnwTeeLdie9+GxJURGH0eqm1nc2q4jSvsx+SYt2J6njPBlb1g92D8ggkFz9noAJnQGCTS5zYxagRq4I/ZwQD2HOdlXEjbeGeqCcSBySwfLaFiEN80c5T7l0uxWEge0gjXigmI2Nd4Sh4YGrur+UTLJW4fVjGjjJU8wUJ5zzpM1ceoxbxZxTQPytkqIRM1C7Vlq227iWCZfteRAbqPe7w4ITxQCyMwE+/hoRy5Smyu/MDgC9vUKilGmvmyh77LlFn+gTOQmt5gz2SVqj2Da3dVnNJFqAuqpu/eCuzZo5avLi4j4Qm3cJNrDzSYqO9ZNeYcaOFtGFtTpZrgywao4C1wtKebt8+pDXXQpIosv5QSq9bBRMAZLoZogYOZRnCH+b/Vog3M5vn+hRaqABKGvr03JX+G5EohSL7CDH7Vt7M3rpU3NoCccZzHGHUS0lnOWiidCKswFsLE1peES4u0DAbtk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(508600001)(26005)(186003)(4326008)(66476007)(64756008)(66946007)(44832011)(8676002)(66556008)(76116006)(8936002)(5660300002)(66446008)(52536014)(33656002)(7696005)(53546011)(316002)(6506007)(6916009)(86362001)(54906003)(38100700002)(71200400001)(55016003)(9686003)(38070700005)(2906002)(122000001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZElkY3JiaVkzVEs5bHY5c3BmUStla1pUNVhKL0FkVWMvYzA5S2s0NDdFVUgz?=
 =?utf-8?B?d1I2SHpWUjh2emxDUWxKYWMzdkZZVVNzQjJPUTZHZEYxMENHeFRRTktiQ2VN?=
 =?utf-8?B?NG16dnlOdDdtZGdYWklHVnozT25vZVF4bVJOVit1Vkt3Y3h1dVptZ2tiVG1u?=
 =?utf-8?B?ckxhYmlEcVFmaTVmMEs1UnVRcWkrekNqT1M0czU5T1dCSWJGRSt3THFPb1Iz?=
 =?utf-8?B?NUY3SXdpdXpRNE5wOWRUR2t6d2ZJS1VXcXR3U29YM3pmZ0tOSzFCTWppLzFl?=
 =?utf-8?B?TEcwbzRMVmZZcTlQdW02N0VPV0I4TG5udjFxdWVOUEpMZllRZzBLNnc5Z2tO?=
 =?utf-8?B?dmpDeXdCKzBHQ25BcnFScFBubU9OMGZySTNiK1hYNVJHWU9wbnErRmlEK0xu?=
 =?utf-8?B?aEVMVDhJV1ZZZlZLcU9YUjhsNWg4dU1UVDhXeVZmQy9YRG5CM3Uxemh5U3Av?=
 =?utf-8?B?Y3ZRWUFsWFdBaWRGb0hKZTdwVVRMVlgrZkJlUzJMRlloZUR0VlNsK3lSNnRK?=
 =?utf-8?B?ZWNRMkltRHN1N2VHWTdQc0FrTUkrK1VFZjVXRE5YRXNGZis5dnNad0x3UVdL?=
 =?utf-8?B?SzdkSUdwaUVFTTFSdXZnSmQrK1ZXM1JsMk4wVkJaMUJnQzhaMHR3UUFLSnU5?=
 =?utf-8?B?M2JjVXFGN1VBQkxqSUpidXpwNkplQ3dRWkxCOCszZkZIaDlPdzQ3RGZDNkVo?=
 =?utf-8?B?aDlRcW9YeFZRQkF3T0c5UG1jcHI0TVpkUGNnYmFrWi9LcnhBMHpUM2pCZzJS?=
 =?utf-8?B?OEZrMXZlNFNhU1U2ZHBRY0FRaGNBRXAwYlExcnYwY3Nud0pKc0tUekpXTm9H?=
 =?utf-8?B?cTRvME52anJ2VVg0NFVVay9lMWVwSk5FeWc4Nll1OWZHZTZXMHFmRkhzWEZv?=
 =?utf-8?B?SUxpQmZNR2JaMjNDSTYvby9yaE1CNFNudnhEaUphZmtwczhyUkI5R29mRk52?=
 =?utf-8?B?bFRCdEpaWXE1cVhDeDIyWHAyd3haTUduU1NabHhoZUpVclpoVEhvY3lUbEpk?=
 =?utf-8?B?QVBkaVM2NEpCNkRPblJFYWtEZHRBd0Nobm5xSVlCY3hXTEJmUFpjSFBGYjNp?=
 =?utf-8?B?aFR1TFcxSmNRd0t2UHh6R2Nya2pLbldFT3hsYmM4UmFVV3NHckpnMDJRNFd5?=
 =?utf-8?B?dGdBRnB5dmUyNnZ6T3FWck44UlVlTlR3WjVxbnJxS2NSVGtqMnFDRUhsM0th?=
 =?utf-8?B?Qm5udUIxZHNhTUsyZ3ZUMzJrNjI3c1hVdGRqMDAxVGZtOHBQZVl2QjJkeXNv?=
 =?utf-8?B?czFtWEdWSllXWDZvUXFkQTVVT1g1aWdkNExieUhBWmoycmJwa3BQWG9wMzNs?=
 =?utf-8?B?aEdlREhsZTJwMzZFMzgrNCtScEl0MFBWUUgvYUE5dllEOGVRTTJGMGUrT0l0?=
 =?utf-8?B?YzNNcjg0RXI5YktWWEN4VHNiYnRWY3N4aTd3bTZWZjFMclJJeVdDSTcrNDA4?=
 =?utf-8?B?eTA1Zk52NWxsU29KVDFqY1Uwb0NkT2xiMDYrMEY1QUkzMFlPS2MvSUU4NDhZ?=
 =?utf-8?B?QjlrRVhEUjlrUUFOOWMwUkhqeTNxUW91aEJ5QTVZbDFLbTRqY29BQkkwQzlV?=
 =?utf-8?B?OEdDTFZCeXNoOWErVDE0NUhyTlhEMTRIUG80RWZSUklYa1ZuaW45dVVxMEdl?=
 =?utf-8?B?UHNCR2d6VzBsbWZhR21yWGJjRE9yT3A0b1ZlQVUyMmVIVG1TNi9jdFBSWWcy?=
 =?utf-8?B?eDVZL2dwZmZ5ZjcyckU5emZlSE9kT2I5UTJ1b1NPdVZqS1U1ZCtnY2ZWRGMv?=
 =?utf-8?B?VlhEUDBRU3RaM1JJWlRDS2JVTnMxTWE4amFieFBIaEFuWElPNXNDcEZjWlE3?=
 =?utf-8?B?SURVdUVJaTNrbXJHS3BhM1lHWkY5cUxEM1pHUTJYTFp6NXRCM25uUFA4bStF?=
 =?utf-8?B?Q01IZWhCK2FQZXEyUEdTU0hTZ2o5RHBJdDVGdjZLUzdpazdrMGpnNDN3OVlJ?=
 =?utf-8?B?bWN4SE81d0g1c0xpaFVIWTNuaWcveXdHQ0w1NDZPQnlEVWw4akVYbUdubTF0?=
 =?utf-8?B?b1NXZEVob1gvV3VGRlNMTS9tVTcvMGtCdy8zYmN4c0M0dHk1U0FrbU5Gcmpo?=
 =?utf-8?B?c2p2SDNwM1B3aUN1Wk1rQUx6UW5Oenc4MFZyb3lLNmQ0Y3VxaVVzSk1jVlFE?=
 =?utf-8?B?MDI1Vmc2R29vVmtYL09VVmpQUStkVHRMMlh4QUFJcVdDcXRnM29DOU50WHNJ?=
 =?utf-8?B?Ymc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8681f63-b4af-442c-7d65-08d9ed02f753
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 02:05:24.3859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MHUBZ31t4FffvI+hXra7fzHhnYWY2CYUKUnvIkOpAUy2BmSrssun/fR9UKnUf2Msvw2CDrvIm11X/ySXEa/oyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9479
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxn
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjLlubQy5pyIMTHml6UgNjowNQ0KPiBUbzogSG9u
Z3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IGwuc3RhY2hAcGVuZ3V0cm9u
aXguZGU7IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207
IHNoYXduZ3VvQGtlcm5lbC5vcmc7IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBu
eHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1JGQyAyLzJdIFBDSTogaW14NjogRW5hYmxlIGlteDZx
cCBwY2llIHBvd2VyIG1hbmFnZW1lbnQNCj4gc3VwcG9ydA0KPiANCj4gT24gVGh1LCBGZWIgMTAs
IDIwMjIgYXQgMDM6MjM6MTlBTSArMDAwMCwgSG9uZ3hpbmcgWmh1IHdyb3RlOg0KPiA+ID4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IEJqb3JuIEhlbGdhYXMgPGhlbGdh
YXNAa2VybmVsLm9yZz4NCj4gPiA+IFNlbnQ6IDIwMjLlubQy5pyIOeaXpSAyMzozNw0KPiA+ID4g
VG86IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+ID4gPiBDYzogbC5zdGFj
aEBwZW5ndXRyb25peC5kZTsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsNCj4gPiA+IGxvcmVuem8ucGll
cmFsaXNpQGFybS5jb207IHNoYXduZ3VvQGtlcm5lbC5vcmc7DQo+ID4gPiBsaW51eC1wY2lAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+ID4g
PiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGRs
LWxpbnV4LWlteA0KPiA+ID4gPGxpbnV4LWlteEBueHAuY29tPg0KPiA+ID4gU3ViamVjdDogUmU6
IFtSRkMgMi8yXSBQQ0k6IGlteDY6IEVuYWJsZSBpbXg2cXAgcGNpZSBwb3dlcg0KPiA+ID4gbWFu
YWdlbWVudCBzdXBwb3J0DQo+ID4gPg0KPiA+ID4gT24gV2VkLCBGZWIgMDksIDIwMjIgYXQgMDM6
MDI6MzZQTSArMDgwMCwgUmljaGFyZCBaaHUgd3JvdGU6DQo+ID4gPiA+IGkuTVg2UVAgUENJZSBz
dXBwb3J0cyB0aGUgUkVTRVQgbG9naWMsIHRodXMgaXQgY2FuIHN1cHBvcnQgdGhlIEwyDQo+ID4g
PiA+IGV4aXQgYnkgdGhlIHJlc2V0IG1lY2hhbmlzbS4NCj4gPiA+ID4gRW5hYmxlIHRoZSBpLk1Y
NlFQIFBDSWUgc3VzcGVuZC9yZXN1bWUgb3BlcmF0aW9ucyBzdXBwb3J0Lg0KPiANCj4gPiA+IFdo
YXQgZG9lcyAiTDIgZXhpdCBieSByZXNldCBtZWNoYW5pc20iIG1lYW4/ICBJcyB0aGlzIGFuDQo+
ID4gPiBpLk1YNi1zcGVjaWZpYyB0aGluZz8gIElmIG5vdCwgY2FuIHlvdSBwb2ludCBtZSB0byB0
aGUgcmVsZXZhbnQgcGFydA0KPiA+ID4gb2YgdGhlIFBDSWUgc3BlYz8NCj4gPg0KPiA+IE5vLCBp
dCdzIG5vdCBpLk1YNiBzcGVjaWZpYyB0aGluZy4gaS5NWDZRL0RMIGRvZXNuJ3QgaGF2ZSB0aGUN
Cj4gPiBzZWxmLXJlc2V0IG1lY2hhbmlzbS4gIFRodXMsIGl0IGNhbid0IHJlc2V0IGl0c2VsZiB0
byBhbiBpbml0aWFsaXplZA0KPiA+IHN0YXQgd2hlbiBsaW5rIGV4aXQgZnJvbSB0aGUgTDIgb3Ig
TDMgc3RhdHMuICBpLk1YNlFQIFBDSWUgaGFzIHRoZQ0KPiA+IHNlbGYtcmVzZXQgbWVjaGFuaXNt
LCBhbmQgaXQgY2FuIHJlc2V0IGl0c2VsZiB3aGVuIGxpbmsgZXhpdCBmcm9tIEwyDQo+ID4gb3Ig
TDMgc3RhdHMuICBUaGUgY29tbWl0IGRlc2NyaXB0aW9uIG1pZ2h0IG5vdCBhY2N1cmF0ZS4gIEhv
dyBhYm91dA0KPiA+IGNoYW5nZSB0aGVtIHRvICJpLk1YNlFQIFBDSWUgc3VwcG9ydHMgdGhlIFJF
U0VUIGxvZ2ljLCB0aHVzIGl0IGNhbg0KPiA+IHJlc2V0IGl0c2VsZiB0byB0aGUgaW5pdGlhbGl6
ZWQgc3RhdCB3aGVuIGV4aXQgZnJvbSBMMiBvciBMMyBzdGF0cy4iDQo+IA0KPiBzL3N0YXQvc3Rh
dGUvDQpUaGFua3MgZm9yIHlvdXIgcXVpY2tseSByZXBseS4NCkdvdCB0aGF0LCB3b3VsZCBiZSBj
aGFuZ2VkIGxhdGVyLg0KPiANCj4gVWdoLCBJIGhhdmUgYWxsIHNvcnRzIG9mIHF1ZXN0aW9ucyBu
b3csIGJ1dCBJIGRvbid0IHRoaW5rIEkgd2FudCB0byBrbm93IG11Y2gNCj4gbW9yZSBhYm91dCB0
aGlzIDspDQo+IA0KPiBTZWVtcyBsaWtlIHRoaXMgZGV2aWNlIHJlcXVpcmVzIHNvZnR3YXJlIGFz
c2lzdCB3aGVuIGJyaW5naW5nIHRoZSBsaW5rIG91dCBvZiBMMg0KPiBvciBMMy4gIElzIHRoYXQg
YWxsb3dlZCBwZXIgUENJZSBzcGVjLCBvciBpcyB0aGlzIGFuIGVycmF0dW0/DQo+IA0KPiBEb2Vz
IHRoaXMgbWVhbiB0aGUgZHJpdmVyIG5lZWRzIHRvIGJlIGludm9sdmVkIHdoZW4gd2UgdGFrZSBh
IGRldmljZSBvdXQgb2YNCj4gRDMgKHdoZXJlIHRoZSBsaW5rIHdhcyBpbiBMMiBvciBMMyk/DQoN
ClllcywgdGhlIFNXIHNob3VsZCBiZSBpbnZvbHZlZCB3aGVuIGJyaW5naW5nIHRoZSBsaW5rIG91
dCBvZiBMMiBvciBMMy4NCkkgbG9va2VkIHRocm91Z2ggdGhlIFNQRUMsIGRpZG4ndCBmaW5kIHRo
YXQgdGhleSBhcmUgZm9yYmlkZGVuIGJ5IFNQRUMuDQpJdCBtaWdodCBiZSBhIGRlc2lnbiBsaW1p
dGF0aW9uLCBJIHRoaW5rLg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQoNCj4gDQo+IEJq
b3JuDQo=
