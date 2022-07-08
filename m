Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53BE56B272
	for <lists+linux-pci@lfdr.de>; Fri,  8 Jul 2022 07:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235705AbiGHF4M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jul 2022 01:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiGHF4M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Jul 2022 01:56:12 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2065.outbound.protection.outlook.com [40.107.212.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54177697E;
        Thu,  7 Jul 2022 22:56:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uoww3A9JKnm29aZeu64blVPH9RNscOIJkjNaNShs//En0GcMNqf508/CzqvC+jji+77ChycUz4I5suTMb/oFwHKZRUDUSncSJ6D9KHRjuguLarDkpBP3OAruAmvVrxfKlGwF5goHjugCiZaTQ/LuUrW05MeNg0GyUzdlpJaxgoRiSmE6g3M1O6glXPajBkRFtI3hLIWXcr/tw9ACuse1D7hvPPYdY/EhYb6XTlf1646BFHs8haVCb8s4sE8BElRubkgXCs8138rGKXig886NwyQDUDqL6t9XDd3FAF6NiRaDcPvJg3d6pOaFvImN0ZQUPdk1tlwKXc3Ibp3mVlJPvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HvG46FnZhZlPODxBkU28pR600eEbkmW4V3CCAyi2RlY=;
 b=nvxlWfgA1VMnx308RDeo6b9e7D6VXK0YkohaOAqx6hF9Yh8mnKoT/ImL4OSeNW6zLlBV6htgBnBZZmLdWVI/oHV+pFSX43S5GbGQztFA7kpNt/rHbZb4vJu9pi+PycsBGZo7ihMPDoVuvaED3Y9p1BzWK6aVB83GqSDuwZFDdlykD7/2uVqGl2c3us4cT6N8xojjCsEgwv8frTtt/YYsPfXqw9QmGfKE13Q1ikLZVF5e9J5871pq/ly31wH4hJQt+V6KvDcmkiKBlSZUk581vHFCKpJ4+Ble1CuayvBgrgeWe9eQ9gbIbRkQkm/WvwmeB5Bqn1vQ52nRejzDYbkiBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HvG46FnZhZlPODxBkU28pR600eEbkmW4V3CCAyi2RlY=;
 b=UDyq/m/VmGg2qwa3ZiFc59s0SWuDUkH2Ru5mYghT0i3PdUkFvKoHHW5YLn0kaLJF2Ab6SqPuLKrNmREyspbJBmlSrFG5bCHnV/q874hv7E643oXNIykQCe1WVEIMCwINC9KW7fwoRYgTUSO1zJ/sAZTi0Vr42oxyuIyLyzutR+I=
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by DM6PR05MB4041.namprd05.prod.outlook.com (2603:10b6:5:89::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.12; Fri, 8 Jul
 2022 05:56:08 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::dc16:cc4c:985a:89ec]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::dc16:cc4c:985a:89ec%9]) with mapi id 15.20.5417.020; Fri, 8 Jul 2022
 05:56:07 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        Nadav Amit <namit@vmware.com>,
        Srivatsa Bhat <srivatsab@vmware.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Anish Swaminathan <anishs@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>,
        "er.ajay.kaher@gmail.com" <er.ajay.kaher@gmail.com>
Subject: Re: [PATCH] MMIO should have more priority then IO
Thread-Topic: [PATCH] MMIO should have more priority then IO
Thread-Index: AQHYiw9MIzjUV7s8202eNjeTozcWMq1lHkCAgA9GoQA=
Date:   Fri, 8 Jul 2022 05:56:07 +0000
Message-ID: <25F843ED-7EB4-4D00-96CB-7DE1AC886460@vmware.com>
References: <1656433761-9163-1-git-send-email-akaher@vmware.com>
 <20220628180919.GA1850423@bhelgaas>
In-Reply-To: <20220628180919.GA1850423@bhelgaas>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.61.22050700
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ea86b01-6499-4511-1fcd-08da60a68d5a
x-ms-traffictypediagnostic: DM6PR05MB4041:EE_
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LkWRMAeqMXkJQ3fWVMSgPPZsyZMaCY6J7AdReSSmGyfRhuLDn0ftdaUIQCucX1hwLSVRWyUlaG95OaLaYqWiCQOrZhGD76qht43kkScL1mR6ZojyF15k+78sFuTtDj+f9b1HBDDKPLtqd805++zCuLRwxf3cM/qoz8xa2DFdrZCuJDdHjQipwYegKCdZgjqiitmZ5UdhadTVneGbQIYjoZHjgchnSBVZBslXLuntxAKFeaVwqMaur9l11ymMlydaBNe1W0qSAm5JeZlNS2R8cQUtygW52JuRgFvl8SXengMwLjMyP7xAsV+fFI+NsjbV1iWGw5PweSpo0k+cUmWIA/RjcunWxdI18L1qt4+3dRpLVAawldS6Q56M71OdNfKjJH/pqiN7nY1dBm9pRx1taTpgmBrcHN+lL7av4M3VPV5Y5wU3P4Ihx7t3gIFIU4MD7tgumn/w0PxD7Qs+SZZTWkbOUeVqXm4+bxNxchxpPtzWg/AmwUNxXi8WZz6MvqVdpm104cWdYUINxwZaeA5dCs7tJ2TxBHp8KgdUWy5wbCLYaMl80BXahbNCU7/eAHAEDK7p28FImd5cpvkQfJzb9F+KVsinUTmYXTwDUzIj144jYNkd7pNyrHj7K3k8ieEjAbWT+pio3Af4GGKNC+fjPywrjb8VsdWKqSX7apyHVy/5F1/X8j0ocfzA/lWv1wsAzFsYdjBNGeiZ/FQ0Ae5b1amxguC1mVJYDFjWeYuFBXPLMbjOLR2lzpGp9U6kNZubFIrh6WIlYSDipZJoeE1uJnL9cd/sEOc5UqJ8rUz71G1vMDwYKb23Dix00p9jwXCNs7PyOr+F3vEoNmOLIarmRoRqTaOZrHVupn22scOLIPo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(6512007)(26005)(66476007)(6506007)(122000001)(55236004)(8676002)(76116006)(4326008)(110136005)(91956017)(64756008)(36756003)(54906003)(316002)(66446008)(38070700005)(66946007)(71200400001)(66556008)(2906002)(478600001)(86362001)(6486002)(83380400001)(38100700002)(41300700001)(33656002)(2616005)(5660300002)(8936002)(186003)(7416002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnI5SmI1MXp3MnZvdnUveGlzY0JFQ3VhV2MzU2YxdVJMN0lOMmRDcGJ3aUNP?=
 =?utf-8?B?NE9VV0hwOUtXL3p2NS9zNElQS05yUHh6elZMVUgvWUhLWlQ0SlVNY2RTbmZ0?=
 =?utf-8?B?RVNnSnhwMEI0bUxLRkU5ZWdUNzdmaUhVRTIvcm5TYk5mTUdVNm5RTmYwd0hs?=
 =?utf-8?B?VHdjb2pqaFlNTG1zaU43QVBMazZRV2Vhcnc5MnhwMUtQWm5mQjFNT2JkbG5t?=
 =?utf-8?B?WEZFdmRMeG1JLzBLbGdZclZ0Mjlvd3ZYdVhOYjM1aEdmQW1lbzZDL3Qrek9J?=
 =?utf-8?B?N0J1QjRUOE11c21ET0Y1VTZDWlhzMnRvenlhNXVpTWw5Z2IvREVhMFV2S1l5?=
 =?utf-8?B?UnE3K2owSFliQkZTWHl1OHI3dkxaV3ljUGVxSnpSckZ4dDExZmJ0OThSSzg1?=
 =?utf-8?B?eVArVnBiR3dVSTRSOC8rK3ZxRm5RTWlNU1hTZDR3Vmd3ZVFjK2xGVTlwbzdr?=
 =?utf-8?B?ZXQwb3ZaWVAzOTNSdG5ZMHdIM2NGVXBXRElIZVNKNmJibTluYVdib2tGbXE3?=
 =?utf-8?B?ZEtYTVdMYXVVOG5oYmZBZlVzd0tGcWQrMldPOGZHdTA0VkV1Qk5PZnFuMVRm?=
 =?utf-8?B?WHVyTFdoY0d3UVhFNzRiZlU0UFpValBmdHhCQ29IdWE1R0YweERZME9WcG5T?=
 =?utf-8?B?YUNuWnJmOGVOV1puWGhtWnh5RUFTSEtWMVVTSG1VcDlpcTFjOFBCdGY1VlZo?=
 =?utf-8?B?WldubWV3YkRjN3F5Yk1DSlFPaXVRVGNCSmRuSGg0b0I4dnlGMklFY3dPajFj?=
 =?utf-8?B?dlF0NU5YbzltdndUZGQyZzlhSUEwUTd0SFU2b1grRW5mQjhwckNtZmpiZnFW?=
 =?utf-8?B?a0J5VEp1cTQ4eklHWGZzSTNNanRxa3pYSU5aU0R0U1c0U3dxT0s1TFVwQWdP?=
 =?utf-8?B?QjgrTDlNL1ZoZDhkZkdMM3lTSk5nZkxaWTNWTzM5QkNYb2xtbDBiTnpsMGdk?=
 =?utf-8?B?TDZmVGV2ZnpiNitHS3krZE53U2lCcE15VVcraFo2YzJlZjJaTWVmMnhvVk9y?=
 =?utf-8?B?WjdVVk9EcTV5RFo2Smh0aEdnNmp4bE9uUUtVZ2RVcVU5Zk4yT2o4V3ZYTEhu?=
 =?utf-8?B?SUxEeCtGODhENitYdThuN2prSVQrQk0zZCszak01ZExQWk9TYTZickZNQldv?=
 =?utf-8?B?R2xTY281Q1JIWU9GVlpyc2VTbDByTXgvNXlHYnlSaTJYdWVxbDVZdzREQU1B?=
 =?utf-8?B?UFE1cncyZXY3OHpNcTlXalVFbVVDTFBPTklYYkp0bjB3elpRM2FLaFJ4ZjZM?=
 =?utf-8?B?c2VYTmxtMkZhb1hLTmRBWUJaMGYzWFRweFhVL2xQSlB4QTZ2ckRONE9lUWcz?=
 =?utf-8?B?UXlRaDk5VC9XOXgzYTdvcklXUHFxMFMrZzJtSG1YV3M5NU5aOE1XU1VEVTk0?=
 =?utf-8?B?ejRtQ2syeEpzTVQxd2JJbklWcWtuVyszWDlQY1gzalZrOXBJRjRpZ3ZBNkVj?=
 =?utf-8?B?anpkRkhiSmtLeGxCTUNoWWF2ZS9yVllvQWdmaFVtZnFJcms3TXNSbWZYeUNO?=
 =?utf-8?B?MEl2dWVGWUZxN0ZYaE9ubE9pUzVMTHVGTU5DYXg3bGYvK3QwZzZNWDNoUnUw?=
 =?utf-8?B?NDdUWkp3eW9ON2JsS0xncFRaQi9ob2lzY0VSTmlPV1BXMFNxeFM5WWM4Qysz?=
 =?utf-8?B?bVJTSEtST3V6d3dlV3FGbldIa1hyNy9oM0xseWFNblQ4VU0vTnFKUGEvRFZ1?=
 =?utf-8?B?V0dCL0IwUEkyMjRtcVJuYTYyaHZYbUVRRlZqdnZKQkxpYTBEVURRWTVXU3VN?=
 =?utf-8?B?NldzL1pJcEZXUldCT2RZMWFpeUlvU1RDVkpBczcrRDZ4bFhJanoyZmRoenUy?=
 =?utf-8?B?dEVBdTJpaWxLcHdLTUR5TmNaVTZZQzRUZyt0REovRGpHQm4yQXVLWFZJR3pW?=
 =?utf-8?B?T2JKRmduWDJ0clhjc3hTQkd1d1lBeGV0ZTJiWHAwMWg4RmEyYjhFSUo1TERP?=
 =?utf-8?B?MjQ3Q3hlV1dBdUs4K0ZabGx3UG1aU1pmRzdCWFJsSVVENFAzMnhTQnU4ZnpS?=
 =?utf-8?B?TlZCVVAwZXFRb2lLWTFRUnYxYkk3TFp1TnVHRXppaWw5MFRIeW8xcjlqSDJu?=
 =?utf-8?B?RFZmT3JvdlJmVDQ2Wnk2RXA0Y3BhcGtneG9FNzAvNE82Nmx1OXk2dXFUQ2NP?=
 =?utf-8?B?UTJuSHlUSEg3Z1JRM2xWMk4xVjNaY0VTWkFHOWhxMzNTTm9hdVhjRGhzdG11?=
 =?utf-8?B?amc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <73B0D8A73F8D1C4A97DB4100509976CF@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea86b01-6499-4511-1fcd-08da60a68d5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 05:56:07.8053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EJyoe+W+aGZrZ9xhzWFJoPkJxDfvJZm/A6xr3TuJSE/8fww5gU82mvk/T/MLcYIit1ahvlIZNZxlqdUk/vdeeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB4041
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQrvu79PbiAyOC8wNi8yMiwgMTE6MzkgUE0sICJCam9ybiBIZWxnYWFzIiA8aGVsZ2Fhc0BrZXJu
ZWwub3JnPiB3cm90ZToNCj4gWytjYyBNYXR0aGV3XQ0KPg0KPiBPbiBUdWUsIEp1biAyOCwgMjAy
MiBhdCAwOTo1OToyMVBNICswNTMwLCBBamF5IEthaGVyIHdyb3RlOg0KPj4gUG9ydCBJTyBpbnN0
cnVjdGlvbnMgKFBJTykgYXJlIGxlc3MgZWZmaWNpZW50IHRoYW4gTU1JTyAobWVtb3J5DQo+PiBt
YXBwZWQgSS9PKS4gVGhleSByZXF1aXJlIHR3aWNlIGFzIG1hbnkgUENJIGFjY2Vzc2VzIGFuZCBQ
SU8NCj4+IGluc3RydWN0aW9ucyBhcmUgc2VyaWFsaXppbmcuIEFzIGEgcmVzdWx0LCBNTUlPIHNo
b3VsZCBiZSBwcmVmZXJyZWQNCj4+IHdoZW4gcG9zc2libGUgb3ZlciBQSU8uDQo+Pg0KPj4gQmFy
ZSBtZXRhbCB0ZXN0IHJlc3VsdA0KPj4gMSBtaWxsaW9uIHJlYWRzIHVzaW5nIHJhd19wY2lfcmVh
ZCgpIHRvb2s6DQo+PiBQSU86IDAuNDMzMTUzIFNlYy4NCj4+IE1NSU86IDAuMjY4NzkyIFNlYy4N
Cj4+DQo+PiBWaXJ0dWFsIE1hY2hpbmUgdGVzdCByZXN1bHQNCj4+IDEgaHVuZHJlZCB0aG91c2Fu
ZCByZWFkcyB1c2luZyByYXdfcGNpX3JlYWQoKSB0b29rOg0KPj4gUElPOiAxMi44MDkgU2VjLg0K
Pj4gTU1JTzogdG9vayA4LjUxNyBTZWMuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQWpheSBLYWhl
ciA8YWthaGVyQHZtd2FyZS5jb20+DQo+PiAtLS0NCj4+ICBhcmNoL3g4Ni9wY2kvY29tbW9uLmMg
ICAgICAgICAgfCAgOCArKysrLS0tLQ0KPj4gIDEgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25z
KCspLCA0IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9wY2kvY29t
bW9uLmMgYi9hcmNoL3g4Ni9wY2kvY29tbW9uLmMNCj4+IGluZGV4IDM1MDdmNDU2Zi4uMGIzMzgz
ZDljIDEwMDY0NA0KPj4gLS0tIGEvYXJjaC94ODYvcGNpL2NvbW1vbi5jDQo+PiArKysgYi9hcmNo
L3g4Ni9wY2kvY29tbW9uLmMNCj4+IEBAIC00MCwyMCArNDAsMjAgQEAgY29uc3Qgc3RydWN0IHBj
aV9yYXdfb3BzICpfX3JlYWRfbW9zdGx5IHJhd19wY2lfZXh0X29wczsNCj4+ICBpbnQgcmF3X3Bj
aV9yZWFkKHVuc2lnbmVkIGludCBkb21haW4sIHVuc2lnbmVkIGludCBidXMsIHVuc2lnbmVkIGlu
dCBkZXZmbiwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBpbnQgcmVnLCBpbnQgbGVuLCB1MzIgKnZhbCkNCj4+ICB7DQo+PiArICAgICBpZiAocmF3X3Bj
aV9leHRfb3BzKQ0KPj4gKyAgICAgICAgICAgICByZXR1cm4gcmF3X3BjaV9leHRfb3BzLT5yZWFk
KGRvbWFpbiwgYnVzLCBkZXZmbiwgcmVnLCBsZW4sIHZhbCk7DQo+PiAgICAgICBpZiAoZG9tYWlu
ID09IDAgJiYgcmVnIDwgMjU2ICYmIHJhd19wY2lfb3BzKQ0KPj4gICAgICAgICAgICAgICByZXR1
cm4gcmF3X3BjaV9vcHMtPnJlYWQoZG9tYWluLCBidXMsIGRldmZuLCByZWcsIGxlbiwgdmFsKTsN
Cj4+IC0gICAgIGlmIChyYXdfcGNpX2V4dF9vcHMpDQo+PiAtICAgICAgICAgICAgIHJldHVybiBy
YXdfcGNpX2V4dF9vcHMtPnJlYWQoZG9tYWluLCBidXMsIGRldmZuLCByZWcsIGxlbiwgdmFsKTsN
Cj4+ICAgICAgIHJldHVybiAtRUlOVkFMOw0KPg0KPiBUaGlzIG9yZ2FuaXphdGlvbiBvZiByYXdf
cGNpX3JlYWQoKSBkYXRlcyB0byBiNmNlMDY4YTEyODUgKCJDaGFuZ2UNCj4gcGNpX3Jhd19vcHMg
dG8gcGNpX3Jhd19yZWFkL3dyaXRlIiksIGJ5IE1hdHRoZXcuICBDYydkIGhpbSBmb3INCj4gY29t
bWVudCwgc2luY2UgSSB0aGluayBoZSBjb25zaWRlcmVkIHRoZSBvcmRlcmluZyBhdCB0aGUgdGlt
ZS4NCg0KVGhhbmtzIEJqb3JuIGZvciBxdWljayByZXNwb25zZS4NCg0KTWF0dGhldywgYjZjZTA2
OGExMjg1IGlzIG9sZCBjb21taXQuIEl0IHdpbGwgYmUgdmVyeSBoZWxwZnVsIGlmIHlvdSBjb3Vs
ZA0KcHJvdmlkZSBzb21lIGRldGFpbCBvbiBvcmRlcmluZyBhcyBCam9ybiBtZW50aW9uZWQgYWJv
dmUuDQoNCi0gQWpheQ0KDQo+PiAgfQ0KPj4NCj4+ICBpbnQgcmF3X3BjaV93cml0ZSh1bnNpZ25l
ZCBpbnQgZG9tYWluLCB1bnNpZ25lZCBpbnQgYnVzLCB1bnNpZ25lZCBpbnQgZGV2Zm4sDQo+PiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50IHJlZywgaW50
IGxlbiwgdTMyIHZhbCkNCj4+ICB7DQo+PiArICAgICBpZiAocmF3X3BjaV9leHRfb3BzKQ0KPj4g
KyAgICAgICAgICAgICByZXR1cm4gcmF3X3BjaV9leHRfb3BzLT53cml0ZShkb21haW4sIGJ1cywg
ZGV2Zm4sIHJlZywgbGVuLCB2YWwpOw0KPj4gICAgICAgaWYgKGRvbWFpbiA9PSAwICYmIHJlZyA8
IDI1NiAmJiByYXdfcGNpX29wcykNCj4+ICAgICAgICAgICAgICAgcmV0dXJuIHJhd19wY2lfb3Bz
LT53cml0ZShkb21haW4sIGJ1cywgZGV2Zm4sIHJlZywgbGVuLCB2YWwpOw0KPj4gLSAgICAgaWYg
KHJhd19wY2lfZXh0X29wcykNCj4+IC0gICAgICAgICAgICAgcmV0dXJuIHJhd19wY2lfZXh0X29w
cy0+d3JpdGUoZG9tYWluLCBidXMsIGRldmZuLCByZWcsIGxlbiwgdmFsKTsNCj4+ICAgICAgIHJl
dHVybiAtRUlOVkFMOw0KPj4gIH0NCj4+DQo+PiAtLQ0KPj4gMi4zMC4wDQo+Pg0KDQoNCg==
