Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467A8646F95
	for <lists+linux-pci@lfdr.de>; Thu,  8 Dec 2022 13:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiLHM0Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Dec 2022 07:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiLHM0X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Dec 2022 07:26:23 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2109.outbound.protection.outlook.com [40.107.113.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072928B182;
        Thu,  8 Dec 2022 04:26:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vf7voJKILO+7rnV75mQrU8sGWGEZSG5hqvDl0pONZ9kgwKvD1qdTxYb9fc2P99Mtc2BltTyFsz6SirlkIG+Bao8lCCNAliPrd0MZy2q8iYoZdDOcKe8St1kTYTsxzudQxM+4Gyj9PGS2iDPpgST4ueexSLFb/IJ2iOniv4Bm0l/6+xamzFSZ0jY7/q/QqAdB3brWZM6gbiceQdg8rveTYwsn4MD2G+IW4w4b4URpkZP8RQ52DOpmjLEKgSiJX12gN2Tw0TYv89dcqhEjfkjnJHAiz0M+2oqKabPX9h3d+7f2g23eNuBTI3JWhHcKAQkurFjlzDoptxB79fUKSY9lsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qbC9sn4gHaQfFSnkayW8J7qpCtLn5PKdyXRKos2aGo=;
 b=O9VwOOqzLvuLXUmpQbo2wpsGzIcnEBhIe0+kefn31X6mbgbl0KMggEjc6KTxG6pfYt3w6mkXfwGi+4C4dah+wmsnnG9WWiv1ofYMhOhcSbNz13gBuJE2m9r7hsmFIiPCWM6XDi60WStvHCdBILX4N49nl8Qu3ywH+PoPpwKqSclifPn3DugJGBn3XnmUhGoSQyFeSdsffaskWgaqdoFuphLGcZvfPwRICSa6CYa+VtyT9OBk5NyG26i5fo6XNMVcDqCxaJ+CNSdOMjNxqws72Jpzmu2BRM1xqkfn3+H/kVBwQ64gbJtTMPjtFgbMm8PNOYrVG9HkIgYLM+AJOg5gQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qbC9sn4gHaQfFSnkayW8J7qpCtLn5PKdyXRKos2aGo=;
 b=DkdppAfvqA3DAQMZOearP1nV00MWyeSY58kk29zplR9mjwWd6D6uhhPFXm8eW9PJLmLoNj1O0bKRM8urJTIrxR4Ku+jPtC0UZLX0hviTuO/f6ty9iOpu3VPOs/BGQSQrp+pxXCKtJrkgxMJhafxZXj6otlwywF+wbRPx9PzNzwA=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYYPR01MB8168.jpnprd01.prod.outlook.com
 (2603:1096:400:115::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 12:26:18 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::cd89:4a4b:161e:b78d]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::cd89:4a4b:161e:b78d%8]) with mapi id 15.20.5880.016; Thu, 8 Dec 2022
 12:26:18 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "Sergey.Semin@baikalelectronics.ru" 
        <Sergey.Semin@baikalelectronics.ru>
Subject: RE: [PATCH v7 5/9] PCI: dwc: Avoid reading a register to detect
 whether eDMA exists
Thread-Topic: [PATCH v7 5/9] PCI: dwc: Avoid reading a register to detect
 whether eDMA exists
Thread-Index: AQHY/ab1Tv+LcLa0Z0uhVdCr0bfU4q5K+PQAgAiDNgCAACHrwIAAqEAAgAAJ9jCAADx6AIAAiB/AgA7axpA=
Date:   Thu, 8 Dec 2022 12:26:18 +0000
Message-ID: <TYBPR01MB53413E1BE13CCA65307770FDD81D9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20221121124400.1282768-1-yoshihiro.shimoda.uh@renesas.com>
 <20221121124400.1282768-6-yoshihiro.shimoda.uh@renesas.com>
 <20221122135550.GD157542@thinkpad>
 <20221127235532.u7q7oou36wymkpyf@mobilestation>
 <TYBPR01MB5341932B42719E026AA16D40D8139@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20221128115908.awhznkkrelk7h3nm@mobilestation>
 <TYBPR01MB534107A3C2B521BA0D67B4A7D8139@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20221128161114.deacldwbckfnn6ft@mobilestation>
 <TYBPR01MB5341FA664D5F1FCA07294F96D8129@TYBPR01MB5341.jpnprd01.prod.outlook.com>
In-Reply-To: <TYBPR01MB5341FA664D5F1FCA07294F96D8129@TYBPR01MB5341.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYYPR01MB8168:EE_
x-ms-office365-filtering-correlation-id: df6a3adb-4f50-461e-0790-08dad917685e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PEx6CP7bp0A1OI1mZrU19t503EUSCfoUdbKiRbM8hwzTa0ul2SGyY3+cibEXKg9/YCcX8O3it7YhrY5s0dPoTsBzTkAofOeSBc6pnr+Im2c8q2NaXtH4XBjOECdrTK2JOYoRs4KdI1daHMGpGtou2lJf3vkIXgT/kyvPFs1QMMfRYMtlXYL5hQ2AXRv3GbFf2LCaSr26K0qaL59jsYmErmItaVIXa8NDV7H496c5GHwn+q6niejVE+2w5jWJJPzuGoHoFK7tkKee8zzJi+ugQVZcxfBtLy7TmW7HvOZsZimO/voWTaw9sCWSaQ7CmMRpS/DUF4NImS26tQDO2NHQ9kJQvBWnO+lusJOx1HlSnui1i+XmfJA1Tcv94abMlaApEM+CVJ9JrvfjVzAto7ADMO0YBZsEF2YzCYPP73kcY1UQDIOazo5UZGVCAWrNOdsatpR18ertw4BLToX0RixyyUkk6hdrL6CYbJZfizwNzEpR2QPhg3ROKshVL4Wmv56vGu+chvPO4BhgwuWPBAqSg9vp5unL/4UeqScONy8r0alj2PjAe+5+LsauF7Qy21vkQoq+ur6bY9PrkeSDiCiaQlQeWr6GaZm2w8vVQoNd9n57m+6qjvcRVcfOkCPF68QtWTSMJYvYK14oFpg5cKPOkQOme1lFACv9O8W7dBsaNRtjYjVg41W8yG4th0zdxZx0gVujHny7ZKAdCtiCAV7azw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(396003)(376002)(136003)(451199015)(52536014)(55016003)(71200400001)(7416002)(4326008)(33656002)(2906002)(83380400001)(38070700005)(5660300002)(8936002)(66446008)(38100700002)(76116006)(186003)(478600001)(316002)(66946007)(54906003)(66556008)(122000001)(110136005)(86362001)(64756008)(41300700001)(66476007)(8676002)(7696005)(26005)(9686003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTlkVUYwaHF0TFoycE5XUTNZMGJsMS9Rc25VSTlmdGJVa0lMSVZ0Qm9OU21u?=
 =?utf-8?B?U09ScUF1a2Q3WWdWS3JqdHpPMHllNytEYVNSUEJnSi9HNE5XaUk4L0craXRK?=
 =?utf-8?B?b09UNkxWWUg4WEswZ0FIbkVaMngwYnJVR2VnNElxNHlZZE9PaVlkWis1Zklu?=
 =?utf-8?B?bFBZUktXWTRPdHZjWUhMR295Y1JBQTgwUUdsdGZUY05xSzJPQStQejlIbW5o?=
 =?utf-8?B?RGtUeFFEWFluaHR6cVZjU08xL29MNkwzY3hSMTA0QkEycGZKWnd5YmxGdnB1?=
 =?utf-8?B?VGZsblovamxUOTJQZ0NvenUyOHRuVVBId01kZVZ0RHhmcHV6cy9YUjVKaG40?=
 =?utf-8?B?SUxLMzNkaWJlZnZqc21NT2JQcXRIdVNaRGZ6UUtPOE5hWmM5cGRUdkk1dkUx?=
 =?utf-8?B?bWx0ZU0xbUkxZFd6VGVxQ2FpelhhUFFMQXJ5NnNXQVI1MXFKUzRidmVuS3J6?=
 =?utf-8?B?U2dCRy9LVFpaeUpRSmFLNDRnYlZ2MlFLdGJNTllyVTE1OWRLanRYK2xmOWNJ?=
 =?utf-8?B?dm0xZXVNbWMyY2Q4eGNqa0pMVFczaW5uaXB1L2N6K2FsVDZuL0JXOHk1bDhL?=
 =?utf-8?B?L1RuUk9XbUxyZ3hCS2k0cDNCWXpzczFYMTZicWp3VkJKdVdqWUNLYkRlKzlZ?=
 =?utf-8?B?QXhQU0x1c3dOS1NKK3Fhd3E5d0xNaE9hdUFkcnVtRjdkaXdWZ0ZMRGgwTU5x?=
 =?utf-8?B?YUptc3dGdHlmd0FOalpNUjBkOFRyZXRtN2pCOVV5R2JKZDZMV1ZtQ0EyZHQz?=
 =?utf-8?B?WkpPOW9LMWJXOW1EK0RyWldWc1NMeTlsOU5xRm8wQkpIcnhOZFJpN0xnNHhX?=
 =?utf-8?B?dzhzaGk5eFBDb3lzSHI3bjJCS2JPK3BDMk9uekRoQXB1dVpvOEhQNGI4dmRU?=
 =?utf-8?B?bUprcmlkc3JqWVF4eUlWaGxiZFBoTCt5aE00REJ1dDViNmpuWVh6cEtSVTda?=
 =?utf-8?B?Um5LSWJDOS9XNitsYmJRemt2RytURmtlcDFIamNob1RrN21POGZKZDRNNGJv?=
 =?utf-8?B?c21SRzhacG5qWTBLRExPc1lsYVJ5eXp6T2pFTjd2UGdEZko5ZUloTDlTcXZI?=
 =?utf-8?B?ZGhVYWVXekt0UzdpbGg2Y0hOWmJ5eXRxZGc1OEFqRXhjQ29Ybnl2TE5MSGp2?=
 =?utf-8?B?SmZJTWl3NENaNEsxbnBJWFdLV2xzWXEwcWdlTWVRVUgvVXM1WmgzMDRERkh0?=
 =?utf-8?B?TWlUdGdQd3ZKeDg4MmVIb1JUeGdUN3V0NTJidUpzQmt5QzJ0NWRHWWdDaGh4?=
 =?utf-8?B?SjRkSysyYzh5RDRxUWVVSythbkdkaHFyWUxOKzFUMWMwb0hZOFJIRVVGUTgz?=
 =?utf-8?B?cGJtWS9jRVlFa1dIMUgwS0tGNFRrSnAvWndVRmhHcjkzQStIUTdCSVNKeWRK?=
 =?utf-8?B?WjR5d3pWTS9xMVFPYU1pQnAxSWRrZFU0YnJ6RWEwTEVKYW5mSXBNMTNEbWZn?=
 =?utf-8?B?WGN5ZmFoVTJxWGlvbUE5ak8ydWc2VURlWnhuc0oxaS9FT1ZKd241UUhqZ3BZ?=
 =?utf-8?B?cWZWUFlmNElQQnlHL0FDcFgyMmpuek03MUZubGRHOHhiencyVDZlalFwYUlS?=
 =?utf-8?B?dDlQTmU1dERiWnhaNCtqMXZlMTBkRFhSWG1LQ3JFZVJUNDRlQWcrNFovWU95?=
 =?utf-8?B?L0VjSVQyRXNOd05jVEZlTVhqYWdaM0hnNFNDZUdXaklhNjQyNWhmZ3VoQ0U0?=
 =?utf-8?B?OHl0NDNrSW1sVHNRZk5aUVM4V1hneFFyczJEc0VrS1I4T3FZd1VHYmFKRHk1?=
 =?utf-8?B?bGpoVTBUWUxhNHMyL3AxVWRHTHRMY0VWZmdRcUJLS2dPdFJvZTB0QnJTbTcy?=
 =?utf-8?B?V2N6Mjg1ZnY3QmZvaHRpQXZjMjJuTXFENGs5ektDVkIxT3pVdUxoUHRkSzVr?=
 =?utf-8?B?b2RudVA2d3gycDNaRWI3MmhDRXIwQ0hyZHkwaDkxNXpLckVKZWszM0FCKy9p?=
 =?utf-8?B?dUx2MFdERG53ejdFc0RGcEpoMGRaT0pjc2JaVXptZDNReG96dnRpeGxxWkxY?=
 =?utf-8?B?S04vbEswWW1VczVMeGNxc0MrN0hBbVpnK2NGVjdvRjljRUswOVdWTjliOFRk?=
 =?utf-8?B?eGIrS1BlR2pEQnhjZHIyZ2QyRmxWd21GOHRtelNzOVpmUmVxQXJ5M2NYRlF2?=
 =?utf-8?B?NEVMcUMyY1NKZFl4UkgwcHFpSUJEK2ZldDFMU0F1TXpCUTlTbUlLeFowb1FY?=
 =?utf-8?B?Zmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df6a3adb-4f50-461e-0790-08dad917685e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2022 12:26:18.4189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KRpFO+2itbC4n6PWQ5y80kKFh7lTPnAVNVZhQMtoqFpxrrZSSkBBKqlajMkSTObx5+opIgKiIAox1d37fVCiOc85xtsb+Hdrz+17Zyf5QxSnewMci61DujBYyMWKB1e7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB8168
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgU2VyZ2UsIE1hbml2YW5uYW4sDQoNCj4gRnJvbTogWW9zaGloaXJvIFNoaW1vZGEsIFNlbnQ6
IFR1ZXNkYXksIE5vdmVtYmVyIDI5LCAyMDIyIDk6MjIgQU0NCj4gDQo+ID4gRnJvbTogU2VyZ2Ug
U2VtaW4sIFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDI5LCAyMDIyIDE6MTEgQU0NCj4gPg0KPiA+
IE9uIE1vbiwgTm92IDI4LCAyMDIyIGF0IDEyOjQxOjExUE0gKzAwMDAsIFlvc2hpaGlybyBTaGlt
b2RhIHdyb3RlOg0KPiA+ID4gSGkgU2VyZ2UsDQo+ID4gPg0KPiA+ID4gPiBGcm9tOiBTZXJnZSBT
ZW1pbiwgU2VudDogTW9uZGF5LCBOb3ZlbWJlciAyOCwgMjAyMiA4OjU5IFBNDQo+ID4gPiA+DQo+
ID4gPiA+IE9uIE1vbiwgTm92IDI4LCAyMDIyIGF0IDAyOjUyOjU2QU0gKzAwMDAsIFlvc2hpaGly
byBTaGltb2RhIHdyb3RlOg0KPiA+ID4gPiA+IEhpIFNlcmdlLA0KPiA8c25pcD4NCj4gPiA+ID4g
Tm8sIHRoaXMgc2hvdWxkIGhhdmUgYmVlbiB0aGUgZHdfcGNpZV9yZWFkbF9kYmkoKSBjYWxscyBp
bnN0ZWFkIG9mDQo+ID4gPiA+IGR3X3BjaWVfcmVhZGxfIWRtYSEoKS4gV2hhdCBJIHRyeSB0byB1
bmRlcnN0YW5kIGZyb20gdGhlc2UgdmFsdWVzIGlzDQo+ID4gPiA+IHRoZSByZWFsIHZlcnNpb24g
b2YgeW91ciBjb250cm9sbGVyIChkYmkrMHg4ZjgpIGFuZCB3aGV0aGVyIHRoZSBsZWdhY3kNCj4g
PiA+ID4gZURNQSB2aWV3cG9ydCByZWdpc3RlcnMgcmFuZ2UgZm9sbG93cyB0aGUgZG9jdW1lbnRl
ZCBjb252ZW50aW9uIG9mDQo+ID4gPiA+IGhhdmluZyBGRnMgaW4gdGhlIGRiaSsweDk3OCByZWdp
c3Rlci4gTXkgY3VycmVudCBhc3N1bXB0aW9uIHRoYXQNCj4gPiA+ID4gZWl0aGVyIHlvdXIgSVAt
Y29yZSBpcyBuZXdlciB0aGFuIHY1LjMwYSBvciBoYXMgc29tZSB2ZW5kb3Itc3BlY2lmaWMNCj4g
PiA+ID4gbW9kaWZpY2F0aW9uLiBCdXQgbGV0J3Mgc2VlIHRoZSB2YWx1ZSBmaXJzdC4NCj4gPiA+
DQo+ID4NCj4gPiA+IE9vcHMhIEknbSBzb3JyeSBmb3IgbXkgYmFkIGNvZGUuIEFmdGVyIGZpeGVk
IHRoZSBjb2RlLCB0aGUgdmFsdWVzIGFyZToNCj4gPiA+IC0tLQ0KPiA+ID4gWyAgICAxLjEwODk0
M10gcGNpZS1yY2FyLWdlbjQgZTY1ZDAwMDAucGNpZTogZHdfcGNpZV9lZG1hX2ZpbmRfY2hpcDog
KzB4OGY4ID0gMzUzMjMwMmEsICsweDk3OCA9IDAwMDAwMDAwDQo+ID4gPiAtLS0NCj4gPg0KPiA+
IEBZb3NoaWhpcm8uIEdvdCBpdC4gVGhhbmtzLiBDb3VsZCB5b3UgcGxlYXNlIGNvbmZpcm0gKGRv
dWJsZS1jaGVjaykNCj4gPiB0aGF0IHdoYXQgdGhlIGNvbnRlbnQgb2YgdGhlICsweDk3OCBDU1Ig
d2FzIHJlYWxseSByZWFkIGJ5IG1lYW5zIG9mIHRoZQ0KPiA+IGR3X3BjaWVfcmVhZGxfZGJpKCkg
bWV0aG9kPw0KPiANCj4gWWVzLCBJIHVzZWQgZHdfcGNpZV9yZWFkbF9kYmkoKSBsaWtlIGJlbG93
Lg0KPiANCj4gLS0tLS0tLS0tLS0tLS0tIChzb3JyeSwgdGFicyByZXBsYWNlZCB3aXRoIHNwYWNl
cykgLS0tLS0tLS0tLS0tLS0tDQo+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3Bj
aWUtZGVzaWdud2FyZS5jDQo+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUt
ZGVzaWdud2FyZS5jDQo+IEBAIC04NDMsNiArODQzLDEwIEBAIHN0YXRpYyBpbnQgZHdfcGNpZV9l
ZG1hX2ZpbmRfY2hpcChzdHJ1Y3QgZHdfcGNpZSAqcGNpKQ0KPiAgew0KPiAgICAgICAgIHUzMiB2
YWw7DQo+IA0KPiArICAgICAgIGRldl9pbmZvKHBjaS0+ZGV2LCAiJXM6ICsweDhmOCA9ICUwOHgs
ICsweDk3OCA9ICUwOHhcbiIsIF9fZnVuY19fLA0KPiArICAgICAgICAgICAgICAgZHdfcGNpZV9y
ZWFkbF9kYmkocGNpLCAweDhmOCksDQo+ICsgICAgICAgICAgICAgICBkd19wY2llX3JlYWRsX2Ri
aShwY2ksIDB4OTc4KSk7DQo+ICsNCj4gICAgICAgICBpZiAocGNpLT5lZG1hLnJlZ19iYXNlKSB7
DQo+ICAgICAgICAgICAgICAgICBwY2ktPmVkbWEubWYgPSBFRE1BX01GX0VETUFfVU5ST0xMOw0K
PiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0NCj4gDQo+ID4gQE1hbmksIGNvdWxkIHlvdSBwbGVhc2UgaGF2ZSBhIGxvb2sg
YXQgdGhlIGNvbnRlbnQgb2YgdGhlICsweDhmOCBhbmQNCj4gPiArMHg5NzggQ1NScyBpbiB0aGUg
Q0RNIHNwYWNlIG9mIHRoZSBhdmFpbGFibGUgdG8geW91IGNvbnRyb2xsZXJzPw0KPiA+DQo+ID4g
SSd2ZSByZXByb2R1Y2VkIHRoZSBiZWhhdmlvciB3aGF0IGRpc2NvdmVyZWQgYnkgQFlvc2hpaGly
bywgYnV0IG9uDQo+ID4gdjUuNDBhIElQLWNvcmUgb25seS4gSXQgd2FzIGV4cGVjdGVkIGZvciB0
aGF0IGNvbnRyb2xsZXIgdmVyc2lvbiwgYnV0DQo+ID4gdjUuMjBhIHdhcyBzdXBwb3NlZCB0byBo
YXZlIEZGcyBpbiArMHg5NzggZm9yIHRoZSB1bnJvbGxlZCBpQVRVL2VETUENCj4gPiBzcGFjZS4g
SXQncyBzdHJhbmdlIHRvIHNlZSBpdCBkaWRuJ3QuDQoNClNvLCBzaG91bGQgSSBhZGQgYSBxdWly
ayBmbGFnIGZvciBteSBjb250cm9sbGVyIGxpa2UgYmVsb3c/DQotLS0NCmRpZmYgLS1naXQgYS9k
cml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuYyBiL2RyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5jDQppbmRleCA2OTY2NWE4YTAwMmUuLjM4
NGJkMmMwZWE3NSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUt
ZGVzaWdud2FyZS5jDQorKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2ln
bndhcmUuYw0KQEAgLTg0NCw3ICs4NDQsNyBAQCBzdGF0aWMgaW50IGR3X3BjaWVfZWRtYV9maW5k
X2NoaXAoc3RydWN0IGR3X3BjaWUgKnBjaSkNCiAgICAgICAgdTMyIHZhbDsNCg0KICAgICAgICB2
YWwgPSBkd19wY2llX3JlYWRsX2RiaShwY2ksIFBDSUVfRE1BX1ZJRVdQT1JUX0JBU0UgKyBQQ0lF
X0RNQV9DVFJMKTsNCi0gICAgICAgaWYgKHZhbCA9PSAweEZGRkZGRkZGICYmIHBjaS0+ZWRtYS5y
ZWdfYmFzZSkgew0KKyAgICAgICBpZiAoKHBjaS0+bm9fZG1hX2N0cmxfcmVnIHx8IHZhbCA9PSAw
eEZGRkZGRkZGKSAmJiBwY2ktPmVkbWEucmVnX2Jhc2UpIHsNCiAgICAgICAgICAgICAgICBwY2kt
PmVkbWEubWYgPSBFRE1BX01GX0VETUFfVU5ST0xMOw0KDQogICAgICAgICAgICAgICAgdmFsID0g
ZHdfcGNpZV9yZWFkbF9kbWEocGNpLCBQQ0lFX0RNQV9DVFJMKTsNCi0tLQ0KDQpCZXN0IHJlZ2Fy
ZHMsDQpZb3NoaWhpcm8gU2hpbW9kYQ0KDQo+ID4gLVNlcmdleQ0KPiA+DQo+ID4gPg0KPiA+ID4g
PHNuaXA+DQo+ID4gPiA+ID4gU28sIHNob3VsZCBJIGNoYW5nZSB0aGUgY29uZGl0aW9uIGxpa2Ug
YmVsb3c/DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiAtCWlmICh2YWwgPT0g
MHhGRkZGRkZGRiAmJiBwY2ktPmVkbWEucmVnX2Jhc2UpIHsNCj4gPiA+ID4gPiArCWlmICgodmFs
ID09IDB4RkZGRkZGRkYgfHwgdmFsID09IDB4MDAwMDAwMDApICYmIHBjaS0+ZWRtYS5yZWdfYmFz
ZSkgew0KPiA+ID4gPiA+IC4uLg0KPiA+ID4gPiA+IC0JfSBlbHNlIGlmICh2YWwgIT0gMHhGRkZG
RkZGRikgew0KPiA+ID4gPiA+IC0JfSBlbHNlIGlmICghKHZhbCA9PSAweEZGRkZGRkZGIHx8IHZh
bCA9PSAweDAwMDAwMDAwKSkgew0KPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPg0KPiA+ID4gPiBEZWZp
bml0ZWx5IG5vLiBFdmVuIHRob3VnaCBpdCdzIGltcG9zc2libGUgdG8gaGF2ZSB0aGUgZURNQSBj
b250cm9sbGVyDQo+ID4gPiA+IGNvbmZpZ3VyZWQgd2l0aCB6ZXJvIG51bWJlciBvZiByZWFkIGFu
ZCB3cml0ZSBjaGFubmVscyB3ZSBzaG91bGRuJ3QNCj4gPiA+ID4gYXNzdW1lIHRoYXQgZ2V0dGlu
ZyBhIHplcm8gdmFsdWUgZnJvbSB0aGUgRE1BX0NUUkxfVklFV1BPUlRfT0ZGIG9mZnNldA0KPiA+
ID4gPiBtZWFucyBoYXZpbmcgdGhlIHVucm9sbGVkIGVETUEgQ1NScyBtYXBwaW5nLiBMZXQncyBo
YXZlIGEgbG9vayBhdCB0aGUNCj4gPiA+ID4gY29udGVudCBvZiB0aGUgZGJpKzB4OGY4IGFuZCBk
YmkrMHg5Nzggb2Zmc2V0cyBmaXJzdC4gQmFzZWQgb24gdGhlc2UNCj4gPiA+ID4gdmFsdWVzIHdl
J2xsIGNvbWUgdXAgd2l0aCB3aGF0IHRvIGRvIG5leHQuDQo+ID4gPg0KPiA+ID4gSSBnb3QgaXQu
DQo+ID4gPg0KPiA+ID4gQmVzdCByZWdhcmRzLA0KPiA+ID4gWW9zaGloaXJvIFNoaW1vZGENCj4g
PiA+DQo+ID4gPiA+IC1TZXJnZSh5KQ0KPiA+ID4gPg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gQmVz
dCByZWdhcmRzLA0KPiA+ID4gPiA+IFlvc2hpaGlybyBTaGltb2RhDQo+ID4gPiA+ID4NCj4gPiA+
ID4gPiA+IC1TZXJnZXkNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gIAl9IGVsc2Ugew0K
PiA+ID4gPiA+ID4gPiA+ICAJCXJldHVybiAtRU5PREVWOw0KPiA+ID4gPiA+ID4gPiA+ICAJfQ0K
PiA+ID4gPiA+ID4gPiA+IC0tDQo+ID4gPiA+ID4gPiA+ID4gMi4yNS4xDQo+ID4gPiA+ID4gPiA+
ID4NCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gLS0NCj4gPiA+ID4gPiA+ID4g4K6u4K6j
4K6/4K614K6j4K+N4K6j4K6p4K+NIOCumuCupOCuvuCumuCuv+CuteCuruCvjQ0K
