Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13027C46E9
	for <lists+linux-pci@lfdr.de>; Wed, 11 Oct 2023 02:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344281AbjJKAzJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Oct 2023 20:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344450AbjJKAzI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Oct 2023 20:55:08 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2114.outbound.protection.outlook.com [40.107.114.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D90D9B;
        Tue, 10 Oct 2023 17:55:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GoKQX0y191OJa8DB1Vq2uDV7wShfKGiJIZxmfnqwF8KCAnLktYHpsiRG8yLu0YriUTg5iRLiZBUtcUJtRVD9GXuFbl7KtkHSINVKrRpzlMuQoJ91ttNMpEMmJbVilp8FEMRGGENh21V6LENbS1Y5tNj0VXfH+zFc8RfZrEyGIxHGUa9iybLFdqNzRdL1OeGwXQmRZeOtOfUQfh8mJvxCwO29gnuV57R8zIOCc3SGGdW47i5CPcTUN8VakCZB+knA70aZoL09HnbXcVXnGJI+A0PLgHx7DshXBRhlDjYMvtWOwcS7wM0X8gfutJXNcq2DczUD2T396/U6XN0j35HpWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4dpAmzRQBB1BRjiEIBN6/003S229I8u8kJDqrkfCcjw=;
 b=iKS87MOPAHNlKfn++F8oKh2DUA/SwBB0BXBjXleu+kjA5DTr/gmhbR7HRTlYVhVBL9WWrpeVWawahBlel34BpDyRKjV4b9c19s7brOhZwGgXFOV193fnLTPHQ+5Ze7n36Fo3+4oFLZhjpU7VSiGCpmsqAJXUywkhoVOXrNc3Ehna/JZe9W9ijIYsP4FxtjQi2F6XBsmMpsJX/wx+UrWQ/aQz7K/meMuwnkpFzeJtWKTawDgiRM8RJ+2FFKq9RaIGY0jqInODLEwAPSB1uDuc4TJ5IAU/rG2mribAs97fTdk0IJaOQzA4IrSDORyowtdrb3oT2zdZ9QorwHK9q7ts8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dpAmzRQBB1BRjiEIBN6/003S229I8u8kJDqrkfCcjw=;
 b=DLoIu5nUZr7K8TYoXNBJHnoEFYxexEU/2gJZTrfpwkTHjyTHII3W/8ygMr/bwTsFFeqkNJjijrmYfp3hoF4ygYVJclDiMOgEKSSEo035d5O7p42/cWAV16gN3c+hH1awYv5hvLCn4IWu5g5rFNRIGxp5eHUJ+stsLLjpm6fm7M4=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYWPR01MB8283.jpnprd01.prod.outlook.com
 (2603:1096:400:164::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.41; Wed, 11 Oct
 2023 00:54:59 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::1dc4:e923:9916:c0f7]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::1dc4:e923:9916:c0f7%7]) with mapi id 15.20.6863.040; Wed, 11 Oct 2023
 00:54:59 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Serge Semin <fancer.lancer@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: RE: [PATCH v21 10/16] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe
 Host
Thread-Topic: [PATCH v21 10/16] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe
 Host
Thread-Index: AQHZ7SGFoZE6qOC2IUCxfemOjTA5u7BC/poAgADgFPA=
Date:   Wed, 11 Oct 2023 00:54:59 +0000
Message-ID: <TYBPR01MB5341AB2F02A1162130DDFC22D8CCA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230922065331.3806925-1-yoshihiro.shimoda.uh@renesas.com>
 <20230922065331.3806925-11-yoshihiro.shimoda.uh@renesas.com>
 <20231010112512.GE4884@thinkpad>
In-Reply-To: <20231010112512.GE4884@thinkpad>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYWPR01MB8283:EE_
x-ms-office365-filtering-correlation-id: 470c1264-945c-4898-8832-08dbc9f4b1f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ldnvvc6QKEZde6rvYA+MuIicQdHSfuZ+mcE9+RU+Jrd4T7sc/QHHad6qxp6UYAu/qGvjkU/nDOGB+3GCyqLVowY0NTGpJNsTC1e0AhD/3znFg9GuEo/Ad++IzEkl7DRSdnnG/j3gx6IDP9HhKPUzjgAS0h3EV7Zb1M0pjT4v5KHwiPQPCnFrpGprwQsyFCi3OikxyK83iB8sh6yO1Bw5IQyh38p1gff2SOPAF9Zo2JsVToiyoKGbqTMdwXVap5UJhPdPEM3vDCTnl8CTxDcJQpaBZ8DMRi9sxol1e84mL1ofewx6mdDxg6pk5meb0+7Z7MgkU1DpQCJKBksHS1eWBMKwHQLpy1cRYOf+QdYnZLERE4G9MZccY+ebo9yQo7jS9SdzMQBI7ukKZam3bNzERcklrRFxkaSIWu6VTSpo1xq5J4ckRw2Q5EAWjZYCGZq4++wckVehpau8GAV5HgGkphUJBCNT6dhT1CdzgdRdryhqgbCkp94rfZg/w/TR4EWbGDQs303RwWy/prFCussoClO2S11ST5F5uZYTqqaYJjzmbnQzo91xReqGP8MRqoONfzSYcfKlEtvFTLZV6uuVNlgaNtwGQpCCky69CJOjQ10YXJRlN5HM9Zl4Kp9EAqlh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(366004)(346002)(39860400002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(83380400001)(66446008)(8936002)(55016003)(64756008)(38070700005)(53546011)(38100700002)(122000001)(9686003)(2906002)(316002)(41300700001)(86362001)(52536014)(6916009)(66476007)(66556008)(66946007)(76116006)(5660300002)(54906003)(7416002)(4326008)(8676002)(7696005)(6506007)(71200400001)(33656002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGhUdkVidGdteExwVnBUejJVQjlhYkdNcEdYWndxOWVvNHl0NFBDR1dQbzRa?=
 =?utf-8?B?RnZtanBtcW5tMlpydGg1anlOYXA4ZFhLRVRYQ2p0d2dYd3BqdjNqWUlWMmVT?=
 =?utf-8?B?Y0lWOEdDdVRDOGNuTHVmcG1aRzRWaHNQTkw0NTh3bHI3R2p1TjFWek5LV2NO?=
 =?utf-8?B?UDZWUmw4d3NmbU5qRlpwaUxDUVg5U3dzcUNadERDclBKeHk4d21GMGF4UVhD?=
 =?utf-8?B?Q0I5T0JGYWxxS0twVkpJaU1WQzZOWUl2QzdvbXBudkZEeGlUcUUvRUJXMXZy?=
 =?utf-8?B?UTFnZTM5WnM5Y284S0xCc0ZyZkhCODV0WTlsWk92eWk4cDM3bnhYRENCK1pt?=
 =?utf-8?B?RWJ4NmlLbFk4SFg3UTg1NXR4TDYvMlZlcTJubTAyM0VMVG1VeDIwRkRaWDlT?=
 =?utf-8?B?Sks5K3N2aUo5Q05JeTQyWERBajRCOWJwa290ck92L00wbGgrUWdoRkg4VndD?=
 =?utf-8?B?OXc3OTdEYmY4OFBlYUV2T3BFWVBYM1BPOFhvTkZvMHAyVDNBY0dGOXpZZ3RY?=
 =?utf-8?B?dmkrRTNZcFZqUnlUbkRGUVNITCtBUU4zbHRkVUlubSt1RjFKRkdEUGZLNG16?=
 =?utf-8?B?a3pjZVg1YUhrSk03dVNWMThhNXNZelFTSGJrb2ZoNEpZYnZrWGhZc0ZHR3Mr?=
 =?utf-8?B?UEJRQXYwb1RDUk95ZmtNWFV0R2dBa2ZiNjNrc1dJL2czWGdLUzZ5QmY1Z3Z4?=
 =?utf-8?B?VG5Lb2xPRk5KYVpsdTJtKzdNOThnWEYzcWdSRE5HWEQyYnR2YlE0Y0hWcVBo?=
 =?utf-8?B?T3dSYWVEdS9kUFRsZFZWYzN5d0JWNWY5ZG5MUEt4MGx2Si9JcXZPdUNrUyt3?=
 =?utf-8?B?NVgxNGhGam56TUorVTF0eUNBci9ZM2VBQjl5cldLMlhPajhPSWVNcWMxYmJU?=
 =?utf-8?B?ZEtaMloyMzByS003N3JNQk9mMlBrS0tqYzZXNkkrcnJhUEV5OGlPY1poUE9Y?=
 =?utf-8?B?bGRpT3JlT0M2Zk0wZ1Z2ZHhJRHd0aEhtYU9hVWswTG1hMVk0VGZibThsZHhU?=
 =?utf-8?B?c082RzdMVWFieWo2RHBmZlpsZEx5THdnT2RWNGVoeVJ5WHVsbXlXdG5OWWhO?=
 =?utf-8?B?TWhkNUVoMEZ6V2xpOXlPY2lESCtnUklrNkNsN1FtZVlaODZBN1FVdCtFL3BL?=
 =?utf-8?B?NnlEUkZWTVhjcXlEN2pZUnRLQUNBdXp1bXRiL2dzZzNjVURYQXdWMENIZHp5?=
 =?utf-8?B?Qi9xMU5rRDJOOGhNV2xoWG5SMDNXTCtreE1VcGgrM29vL3E3Y1hWL3N0NnZN?=
 =?utf-8?B?eWpFdHlORWZNa216TUNvaS9mK3NOWG1ZTG94ODMvTFJMcTdMaWZ0L0VONkhU?=
 =?utf-8?B?UTUyY3ZzZlRzTHB3MkNuYjBMMExVYTdkaU9qK2cvY3hhcjhzd0pUbTRURUdL?=
 =?utf-8?B?ZmRqcm01bXlFclQ2b0craXBrREErVWxqRDk4am5PUDdZNEVKdXRKNzFrVnlQ?=
 =?utf-8?B?bFIxNXNNZUpvbEZ1WEdUSEUwRWhVUlFJdXRCOEo4SDVFb09KRDl2cHIzMEkx?=
 =?utf-8?B?Z0VBd0FCeTMydmJ6YzJMTHpkblI0WC9FZ0M0dXY0RmxSN2lCb1ZGcndhVXhs?=
 =?utf-8?B?WkhvOHdUejBUeUpReGNWdC93b29QajVMV09RK3NTeWNobFNwTU9GNXloRG5P?=
 =?utf-8?B?dDRINVJPbDFZVWRpb2pmejNiNVdMekxWL0d6bXBzSmZrcG5OQWNwelNVSFV4?=
 =?utf-8?B?Z2gvT2RLRmxXL1J5M2hwQk1DZW9XU0N3dEFyeHpGSDlRZTdmd2g1aFBmNjFk?=
 =?utf-8?B?Y3V3elY5MysyUEdxVWVEWnBDcG5rcFU2ZFRmS3N4YWVhdk5ob1FnQzR3Smdv?=
 =?utf-8?B?ZGtCSVpsSzkrMTJxUWExQkdwWm9ESDdUN1p5TGgxM0VFRnJiK1RRWjV3cXNi?=
 =?utf-8?B?cTlGTUJMbU1ka3F3N2ZPbE50QzNSTTIyNjhiYk5TRWQwQjFqWFZLS0pFbHRL?=
 =?utf-8?B?SzFoQ0pXN3NwYnU4azVrMGxtcHdicmtBeUphWHlJdStzaGdBSncraVpRMWpj?=
 =?utf-8?B?NzJ1TjhZTGdiYSszTDRsMVFIdzl1TVVlRnNKOERtY2ZGZi9vdFBlenBoVkZO?=
 =?utf-8?B?MTY3NDdvRHROVjA2dEErTUZLYTZTaC80RWdJb21YV3k2bzVCNnpodm1NSWI4?=
 =?utf-8?B?L2JQK2RsL0c0Yko3bFVYR1krWDN6aXlwaUVDVWVHU3VCNmFBS2FsOHUyN0dt?=
 =?utf-8?B?a2Z2cEhITDlYSkJBd3JBU2dJdUUzTXN2Ky9EOER5S3grSzB4MUY3ejRZNTVD?=
 =?utf-8?B?Yk8yZWxzbGU2UHFiblo2Y2E0Y3lBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 470c1264-945c-4898-8832-08dbc9f4b1f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2023 00:54:59.7528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RktMFVpc36Qe9JZMap0KkX4JLRM3kQPcEh/MeWUnnuo47+2K6YKDFwKU6hIlNXHF68vQc25dzZ3U4R1ynoPWYbpXLrrdS4ZOMh7wTabw17FTYk2d4iWRFHTLIQy5oFOr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8283
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGVsbG8gTWFuaXZhbm5hbiwNCg0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2YW0sIFNlbnQ6
IFR1ZXNkYXksIE9jdG9iZXIgMTAsIDIwMjMgODoyNSBQTQ0KPiBUbzogWW9zaGloaXJvIFNoaW1v
ZGEgPHlvc2hpaGlyby5zaGltb2RhLnVoQHJlbmVzYXMuY29tPg0KPiBDYzogbHBpZXJhbGlzaUBr
ZXJuZWwub3JnOyBrd0BsaW51eC5jb207IHJvYmhAa2VybmVsLm9yZzsgYmhlbGdhYXNAZ29vZ2xl
LmNvbTsga3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnOw0KPiBjb25vcitkdEBrZXJu
ZWwub3JnOyBqaW5nb29oYW4xQGdtYWlsLmNvbTsgZ3VzdGF2by5waW1lbnRlbEBzeW5vcHN5cy5j
b207IG1hcmVrLnZhc3V0K3JlbmVzYXNAZ21haWwuY29tOw0KPiBsaW51eC1wY2lAdmdlci5rZXJu
ZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtcmVuZXNhcy1zb2NAdmdl
ci5rZXJuZWwub3JnOyBHZWVydCBVeXR0ZXJob2V2ZW4NCj4gPGdlZXJ0K3JlbmVzYXNAZ2xpZGVy
LmJlPjsgU2VyZ2UgU2VtaW4gPGZhbmNlci5sYW5jZXJAZ21haWwuY29tPjsgQ29ub3IgRG9vbGV5
IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MjEg
MTAvMTZdIGR0LWJpbmRpbmdzOiBQQ0k6IHJlbmVzYXM6IEFkZCBSLUNhciBHZW40IFBDSWUgSG9z
dA0KPiANCj4gT24gRnJpLCBTZXAgMjIsIDIwMjMgYXQgMDM6NTM6MjVQTSArMDkwMCwgWW9zaGlo
aXJvIFNoaW1vZGEgd3JvdGU6DQo+ID4gRG9jdW1lbnQgYmluZGluZ3MgZm9yIFJlbmVzYXMgUi1D
YXIgR2VuNCBhbmQgUi1DYXIgUzQtOCAoUjhBNzc5RjApDQo+ID4gUENJZSBob3N0IG1vZHVsZS4N
Cj4gPg0KPiA+IExpbms6DQo8c25pcCBVUkw+DQo+ID4gTGluazoNCjxzbmlwIFVSTD4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBZb3NoaWhpcm8gU2hpbW9kYSA8eW9zaGloaXJvLnNoaW1vZGEudWhAcmVu
ZXNhcy5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogS3J6eXN6dG9mIFdpbGN6ecWEc2tpIDxrd2ls
Y3p5bnNraUBrZXJuZWwub3JnPg0KPiA+IFJldmlld2VkLWJ5OiBHZWVydCBVeXR0ZXJob2V2ZW4g
PGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPg0KPiA+IFJldmlld2VkLWJ5OiBSb2IgSGVycmluZyA8
cm9iaEBrZXJuZWwub3JnPg0KPiA+IFJldmlld2VkLWJ5OiBTZXJnZSBTZW1pbiA8ZmFuY2VyLmxh
bmNlckBnbWFpbC5jb20+DQo+ID4gQWNrZWQtYnk6IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5
QG1pY3JvY2hpcC5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9iaW5kaW5ncy9wY2kvcmNhci1nZW40
LXBjaS1ob3N0LnlhbWwgICAgICB8IDEyNyArKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxl
IGNoYW5nZWQsIDEyNyBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL3JjYXItZ2VuNC1wY2ktaG9zdC55YW1s
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3BjaS9yY2FyLWdlbjQtcGNpLWhvc3QueWFtbA0KPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9wY2kvcmNhci1nZW40LXBjaS1ob3N0LnlhbWwNCj4gPiBuZXcgZmlsZSBtb2Rl
IDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uZmZiMzQzMzliNjM3DQo+ID4gLS0tIC9k
ZXYvbnVsbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kv
cmNhci1nZW40LXBjaS1ob3N0LnlhbWwNCj4gPiBAQCAtMCwwICsxLDEyNyBAQA0KPiA+ICsjIFNQ
RFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4g
PiArIyBDb3B5cmlnaHQgKEMpIDIwMjItMjAyMyBSZW5lc2FzIEVsZWN0cm9uaWNzIENvcnAuDQo+
ID4gKyVZQU1MIDEuMg0KPiA+ICstLS0NCj4gPiArJGlkOg0KPHNuaXAgVVJMPg0KPiA+ICskc2No
ZW1hOg0KPHNuaXAgVVJMPg0KPiA+ICsNCj4gPiArdGl0bGU6IFJlbmVzYXMgUi1DYXIgR2VuNCBQ
Q0llIEhvc3QNCj4gPiArDQo+ID4gK21haW50YWluZXJzOg0KPiA+ICsgIC0gWW9zaGloaXJvIFNo
aW1vZGEgPHlvc2hpaGlyby5zaGltb2RhLnVoQHJlbmVzYXMuY29tPg0KPiA+ICsNCj4gPiArYWxs
T2Y6DQo+ID4gKyAgLSAkcmVmOiBzbnBzLGR3LXBjaWUueWFtbCMNCj4gPiArDQo+ID4gK3Byb3Bl
cnRpZXM6DQo+ID4gKyAgY29tcGF0aWJsZToNCj4gPiArICAgIGl0ZW1zOg0KPiA+ICsgICAgICAt
IGNvbnN0OiByZW5lc2FzLHI4YTc3OWYwLXBjaWUgICAjIFItQ2FyIFM0LTgNCj4gPiArICAgICAg
LSBjb25zdDogcmVuZXNhcyxyY2FyLWdlbjQtcGNpZSAgIyBSLUNhciBHZW40DQo+ID4gKw0KPiA+
ICsgIHJlZzoNCj4gPiArICAgIG1heEl0ZW1zOiA3DQo+ID4gKw0KPiA+ICsgIHJlZy1uYW1lczoN
Cj4gPiArICAgIGl0ZW1zOg0KPiA+ICsgICAgICAtIGNvbnN0OiBkYmkNCj4gPiArICAgICAgLSBj
b25zdDogZGJpMg0KPiA+ICsgICAgICAtIGNvbnN0OiBhdHUNCj4gPiArICAgICAgLSBjb25zdDog
ZG1hDQo+ID4gKyAgICAgIC0gY29uc3Q6IGFwcA0KPiA+ICsgICAgICAtIGNvbnN0OiBwaHkNCj4g
PiArICAgICAgLSBjb25zdDogY29uZmlnDQo+ID4gKw0KPiA+ICsgIGludGVycnVwdHM6DQo+ID4g
KyAgICBtYXhJdGVtczogNA0KPiA+ICsNCj4gPiArICBpbnRlcnJ1cHQtbmFtZXM6DQo+ID4gKyAg
ICBpdGVtczoNCj4gPiArICAgICAgLSBjb25zdDogbXNpDQo+ID4gKyAgICAgIC0gY29uc3Q6IGRt
YQ0KPiA+ICsgICAgICAtIGNvbnN0OiBzZnRfY2UNCj4gPiArICAgICAgLSBjb25zdDogYXBwDQo+
ID4gKw0KPiA+ICsgIGNsb2NrczoNCj4gPiArICAgIG1heEl0ZW1zOiAyDQo+ID4gKw0KPiA+ICsg
IGNsb2NrLW5hbWVzOg0KPiA+ICsgICAgaXRlbXM6DQo+ID4gKyAgICAgIC0gY29uc3Q6IGNvcmUN
Cj4gPiArICAgICAgLSBjb25zdDogcmVmDQo+ID4gKw0KPiA+ICsgIHBvd2VyLWRvbWFpbnM6DQo+
ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiArICByZXNldHM6DQo+ID4gKyAgICBtYXhJ
dGVtczogMQ0KPiA+ICsNCj4gPiArICByZXNldC1uYW1lczoNCj4gPiArICAgIGl0ZW1zOg0KPiA+
ICsgICAgICAtIGNvbnN0OiBwd3INCj4gPiArDQo+ID4gKyAgbWF4LWxpbmstc3BlZWQ6DQo+ID4g
KyAgICBtYXhpbXVtOiA0DQo+ID4gKw0KPiA+ICsgIG51bS1sYW5lczoNCj4gPiArICAgIG1heGlt
dW06IDQNCj4gPiArDQo+ID4gK3JlcXVpcmVkOg0KPiA+ICsgIC0gY29tcGF0aWJsZQ0KPiA+ICsg
IC0gcmVnDQo+ID4gKyAgLSByZWctbmFtZXMNCj4gPiArICAtIGludGVycnVwdHMNCj4gPiArICAt
IGludGVycnVwdC1uYW1lcw0KPiA+ICsgIC0gY2xvY2tzDQo+ID4gKyAgLSBjbG9jay1uYW1lcw0K
PiA+ICsgIC0gcG93ZXItZG9tYWlucw0KPiA+ICsgIC0gcmVzZXRzDQo+ID4gKyAgLSByZXNldC1u
YW1lcw0KPiA+ICsNCj4gPiArdW5ldmFsdWF0ZWRQcm9wZXJ0aWVzOiBmYWxzZQ0KPiA+ICsNCj4g
PiArZXhhbXBsZXM6DQo+ID4gKyAgLSB8DQo+ID4gKyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3Mv
Y2xvY2svcjhhNzc5ZjAtY3BnLW1zc3IuaD4NCj4gPiArICAgICNpbmNsdWRlIDxkdC1iaW5kaW5n
cy9pbnRlcnJ1cHQtY29udHJvbGxlci9hcm0tZ2ljLmg+DQo+ID4gKyAgICAjaW5jbHVkZSA8ZHQt
YmluZGluZ3MvcG93ZXIvcjhhNzc5ZjAtc3lzYy5oPg0KPiA+ICsNCj4gPiArICAgIHNvYyB7DQo+
ID4gKyAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8Mj47DQo+ID4gKyAgICAgICAgI3NpemUtY2Vs
bHMgPSA8Mj47DQo+ID4gKw0KPiA+ICsgICAgICAgIHBjaWU6IHBjaWVAZTY1ZDAwMDAgew0KPiA+
ICsgICAgICAgICAgICBjb21wYXRpYmxlID0gInJlbmVzYXMscjhhNzc5ZjAtcGNpZSIsICJyZW5l
c2FzLHJjYXItZ2VuNC1wY2llIjsNCj4gPiArICAgICAgICAgICAgcmVnID0gPDAgMHhlNjVkMDAw
MCAwIDB4MTAwMD4sIDwwIDB4ZTY1ZDIwMDAgMCAweDA4MDA+LA0KPiA+ICsgICAgICAgICAgICAg
ICAgICA8MCAweGU2NWQzMDAwIDAgMHgyMDAwPiwgPDAgMHhlNjVkNTAwMCAwIDB4MTIwMD4sDQo+
ID4gKyAgICAgICAgICAgICAgICAgIDwwIDB4ZTY1ZDYyMDAgMCAweDBlMDA+LCA8MCAweGU2NWQ3
MDAwIDAgMHgwNDAwPiwNCj4gPiArICAgICAgICAgICAgICAgICAgPDAgMHhmZTAwMDAwMCAwIDB4
NDAwMDAwPjsNCj4gPiArICAgICAgICAgICAgcmVnLW5hbWVzID0gImRiaSIsICJkYmkyIiwgImF0
dSIsICJkbWEiLCAiYXBwIiwgInBoeSIsICJjb25maWciOw0KPiA+ICsgICAgICAgICAgICBpbnRl
cnJ1cHRzID0gPEdJQ19TUEkgNDE2IElSUV9UWVBFX0xFVkVMX0hJR0g+LA0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgPEdJQ19TUEkgNDE3IElSUV9UWVBFX0xFVkVMX0hJR0g+LA0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgPEdJQ19TUEkgNDE4IElSUV9UWVBFX0xFVkVMX0hJ
R0g+LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgPEdJQ19TUEkgNDIyIElSUV9UWVBF
X0xFVkVMX0hJR0g+Ow0KPiA+ICsgICAgICAgICAgICBpbnRlcnJ1cHQtbmFtZXMgPSAibXNpIiwg
ImRtYSIsICJzZnRfY2UiLCAiYXBwIjsNCj4gPiArICAgICAgICAgICAgY2xvY2tzID0gPCZjcGcg
Q1BHX01PRCA2MjQ+LCA8JnBjaWUwX2Nsa3JlZj47DQo+ID4gKyAgICAgICAgICAgIGNsb2NrLW5h
bWVzID0gImNvcmUiLCAicmVmIjsNCj4gPiArICAgICAgICAgICAgcG93ZXItZG9tYWlucyA9IDwm
c3lzYyBSOEE3NzlGMF9QRF9BTFdBWVNfT04+Ow0KPiA+ICsgICAgICAgICAgICByZXNldHMgPSA8
JmNwZyA2MjQ+Ow0KPiA+ICsgICAgICAgICAgICByZXNldC1uYW1lcyA9ICJwd3IiOw0KPiA+ICsg
ICAgICAgICAgICBtYXgtbGluay1zcGVlZCA9IDw0PjsNCj4gPiArICAgICAgICAgICAgbnVtLWxh
bmVzID0gPDI+Ow0KPiA+ICsgICAgICAgICAgICAjYWRkcmVzcy1jZWxscyA9IDwzPjsNCj4gPiAr
ICAgICAgICAgICAgI3NpemUtY2VsbHMgPSA8Mj47DQo+ID4gKyAgICAgICAgICAgIGJ1cy1yYW5n
ZSA9IDwweDAwIDB4ZmY+Ow0KPiA+ICsgICAgICAgICAgICBkZXZpY2VfdHlwZSA9ICJwY2kiOw0K
PiA+ICsgICAgICAgICAgICByYW5nZXMgPSA8MHgwMTAwMDAwMCAwIDB4MDAwMDAwMDAgMCAweGZl
MDAwMDAwIDAgMHgwMDQwMDAwMD4sDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIDwweDAyMDAw
MDAwIDAgMHgzMDAwMDAwMCAwIDB4MzAwMDAwMDAgMCAweDEwMDAwMDAwPjsNCj4gPiArICAgICAg
ICAgICAgZG1hLXJhbmdlcyA9IDwweDQyMDAwMDAwIDAgMHgwMDAwMDAwMCAwIDB4MDAwMDAwMDAg
MSAweDAwMDAwMDAwPjsNCj4gPiArICAgICAgICAgICAgI2ludGVycnVwdC1jZWxscyA9IDwxPjsN
Cj4gPiArICAgICAgICAgICAgaW50ZXJydXB0LW1hcC1tYXNrID0gPDAgMCAwIDc+Ow0KPiA+ICsg
ICAgICAgICAgICBpbnRlcnJ1cHQtbWFwID0gPDAgMCAwIDEgJmdpYyBHSUNfU1BJIDQxNiBJUlFf
VFlQRV9MRVZFTF9ISUdIPiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwwIDAg
MCAyICZnaWMgR0lDX1NQSSA0MTYgSVJRX1RZUEVfTEVWRUxfSElHSD4sDQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICA8MCAwIDAgMyAmZ2ljIEdJQ19TUEkgNDE2IElSUV9UWVBFX0xF
VkVMX0hJR0g+LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgPDAgMCAwIDQgJmdp
YyBHSUNfU1BJIDQxNiBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCj4gDQo+IEkgYmVsaWV2ZSB0aGVz
ZSBhcmUgZm9yIGxlZ2FjeSBJTlR4IGludGVycnVwdHMuIEJ1dCB5b3UgYXJlIHVzaW5nIHRoZSBz
YW1lIElSUQ0KPiBudW1iZXIgdXNlZCBmb3IgTVNJIGFib3ZlLiBDYW4geW91IGNsYXJpZnk/DQoN
Ck9uIHRoZSBTb0MgKFItQ2FyIFM0LTgpLCB0aGUgc2FtZSBJUlEgbnVtYmVyIGlzIHVzZWQgZm9y
IGJvdGggTVNJIGFuZCBsZWdhY3kgSU5UeA0KaW50ZXJydXB0cy4uLg0KDQpCZXN0IHJlZ2FyZHMs
DQpZb3NoaWhpcm8gU2hpbW9kYQ0KDQo+IC0gTWFuaQ0KPiANCj4gPiArICAgICAgICAgICAgc25w
cyxlbmFibGUtY2RtLWNoZWNrOw0KPiA+ICsgICAgICAgIH07DQo+ID4gKyAgICB9Ow0KPiA+IC0t
DQo+ID4gMi4yNS4xDQo+ID4NCj4gDQo+IC0tDQo+IOCuruCuo+Cuv+CuteCuo+CvjeCuo+CuqeCv
jSDgrprgrqTgrr7grprgrr/grrXgrq7gr40NCg==
