Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384156EC4E8
	for <lists+linux-pci@lfdr.de>; Mon, 24 Apr 2023 07:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjDXFfY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Apr 2023 01:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjDXFfW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Apr 2023 01:35:22 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2139.outbound.protection.outlook.com [40.107.113.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D28D35AF;
        Sun, 23 Apr 2023 22:34:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ha44iaVYiKsWFV4FF2uF0da7lA/sRI0WeNA0sdrWYh+Wrogg5jQ0FMSiHgl9RK52YK3kImqNjPaDaGUNjutska92KI6iacTxrny70BK63yHOJis1E/t2oYIHPfPsI9wroPMF7xwG8GHh8iDtAl07OyYumY3eSAictpHGE/rI38brMqJgTioGzdg65YoXqMIjDMyt8tsN2X3YyKI4VXM+d+5kpO5XsTtwmBKGwXPE5QjJ09OMqIBvGM3sRXbWulKbsbbNWhpWmWHNiYbUmIGiaoxZNApMJV5OvVazMdYiiQVJLMFDaBEe8txg+Lo4OsrXC9j481xSym6OLeGbVQs6DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KoPP5iNa3UcXY308a9TkzQFc3oZQLINqSieIoFXxPWQ=;
 b=YS4npbkSrryLuj2kJir/CrjovSeyuWaBj8PHUzuc/t5sGStZUvx/1Ch8s1xH0QRC8bVVQ6nT2OnMVQ7X8yQtW/nGDvjxSUnSNwDF84GYpatRbmkkD3IBae5AEEhOiEbZ+zZIgNBOrM+5lhBH/UGReyOWsyVcJaQnr27Tt26ApBFVWwK+Zmw3VU3zvhPEjrIAWZfFzVGp4dl+tyVTLIqBzXfU1UfCZN8CL+DV6nxL7tj3t4Msi54Vh5I8S/95hQRv7G546IFtHDffTAU3J1ZK12W+qkla4hLa7Yqc5hoa4Ij/eEbzNX9qxfI5whtPRs9j6sCu+vyc1o+NWzXWqvi49g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KoPP5iNa3UcXY308a9TkzQFc3oZQLINqSieIoFXxPWQ=;
 b=B+8+3VzEiCU6L9gSeG9FHhK+bEg2tMfdr8o8kMXyEUALJZrGZCRWq4r7X1aRPx7wd5IzYwXDJ51AJ1XjbYDhpbcIZdA8gYmcF7B6sE9VIHayEyGyS2A/qUH1xs5d0Eq5yf5OylDnRRE4IFeJIZ5myuIbtOM6BS9L06G2djV58K8=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYCPR01MB11578.jpnprd01.prod.outlook.com
 (2603:1096:400:37e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 05:34:34 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003%5]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 05:34:34 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v13 12/22] PCI: dwc: Add dw_pcie_link_set_max_cap_width()
Thread-Topic: [PATCH v13 12/22] PCI: dwc: Add dw_pcie_link_set_max_cap_width()
Thread-Index: AQHZcfCx37u7yUlg60SC65fW6uNkoa83Xp0AgAKYgeA=
Date:   Mon, 24 Apr 2023 05:34:34 +0000
Message-ID: <TYBPR01MB53416036D67D3AF9956CC43DD8679@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230418122403.3178462-1-yoshihiro.shimoda.uh@renesas.com>
 <20230418122403.3178462-13-yoshihiro.shimoda.uh@renesas.com>
 <20230422134924.GI4769@thinkpad>
In-Reply-To: <20230422134924.GI4769@thinkpad>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYCPR01MB11578:EE_
x-ms-office365-filtering-correlation-id: 873db408-8618-4c65-aab6-08db4485964c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dbXRcUEBiP90aUl1VZysQ3DGWvUigawmR/6XGzqMzzqnwsaG9/UeaD+DukOygfQtqGp2zcfr7caruACJrZOzU/TJzAEy8ua45ayhu6mmtt2lW+47iAv9QF34iWeJ+8wrEhfrLtJnJh5Jp050saXu+4csgbkKB+iCNhOCp7fGyBVRnHYJ32fwc2CcfWlA8jIoXQS2zH7SKHn0XJNp/hUTLcd0dBSHzPQztv4rsZuYmAIefZOuUji3oNe+XTQgn6sLXyuFvbS4C7da5ahIEgqAe9tmrprjtXSBFbvJM8Va06wW2/DnPUOmsgfjk1UFnTa4karcJfoZeuNzql4EIxKUnYlhw5Mwc6Jde/CvYr9SfMrMiqCexSrwHCKFxmzReFGGYh1QrDPTuxvjEV5Kbdp7DUyK85d4Q4dg69wnf5E9nIFEla4AyRPvaTXnuf3OzpUwiqivWbUk/MkRD3AMntZttspPoG/4DEapd8l4iayfdu1yOV0Pu6yfoIQPu3tVTsl2AFY0bI88PmvuZUIdweW17iExFn2E4kxpT11nK8PkMiaatUQtpNJyEY/ikL0fXI9dcf3MYqc9apC5KSwKReTJSUVm5CZbl3tK60EHk5Mp7nKFgKUG4sXeINUBYW7c+vxz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(451199021)(2906002)(7696005)(71200400001)(55016003)(9686003)(6506007)(186003)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(8936002)(316002)(41300700001)(6916009)(4326008)(478600001)(5660300002)(52536014)(7416002)(54906003)(38070700005)(38100700002)(122000001)(86362001)(33656002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mi8yK3Z0NnBGL21EU0Z3K1lhMFdRYUhTcGVnSGVyR2ZyY0E5WjltTUhVQUZ3?=
 =?utf-8?B?U2ZJY3pDZGhFSm55Z2NSZHVJemNpV1J5TUlnenE5bFBPTWpVV3pPM2xKa3hm?=
 =?utf-8?B?KzVoL0hNbUFvaVlUR2ZTV1RZeXpvZEVmRHNTVi9Ic0xQcHlsQ0FrTDFlUEpq?=
 =?utf-8?B?STBoN3BJelNzOEhEVHhHM0JIQkYyTmpnMENRS1l4NU9wUXhaRmJsMDRVaXRO?=
 =?utf-8?B?VTJWVXJRaGtRQU80S1I5M1BoSFZGajE0QjhnUjBtVkhlVzVXVkt3WFQrVDFW?=
 =?utf-8?B?QVphNmI1dmI3Q3FWQkZyOHcxWEZ2NVJ6N3ZKNVpHS3oycEJDQ1lQdlVScm50?=
 =?utf-8?B?NXBuS3V4REZxUDVoaGFlOU0yUEV6U08wNDM2QStMVllIRFRWTmNDKzRlTGVa?=
 =?utf-8?B?VEpMY0JWRWhWbFNZd2kzVlVQdGM4d0NaQ0NKNVlEb2VGUkpDWTczWHJGSnhi?=
 =?utf-8?B?VU1oSndHYTByVjNMbUE5cGhLZEFLVDkxUVVOeFVGVEdVYXZZRWZvQ21yN2J5?=
 =?utf-8?B?K2J6em5uSjRBcUtsSXFpcFFodi9NNFBMNjJxdkFZbThvVVdoVTI3NzNtckQ1?=
 =?utf-8?B?cVF6QkpjNStHelBKMFhEOWFSM1ByVWpkdUNDakl5WW5wa2xJTzc1Q0tGcWw1?=
 =?utf-8?B?Mi9mdXpadUNKRFVNR3RFUWpqZ1oyakhGTWhwbmlDMGF4a2xyVTA4Y0tBQ0Fn?=
 =?utf-8?B?V1VlMWFEM3hQcVlaTlplSjdKYzZTd2RBalFPSFRZWlBZc0huSEFvN2w3RGt1?=
 =?utf-8?B?TmxqVFJNMVQzU0swVjgyaFdTL1Z1ZzFJTnoxa1lYcWxIWW80NFY2MlFKMWRZ?=
 =?utf-8?B?RjcyTWJpQnRncnpvWkVBV2tLNTZpNVFhNXg4S0pZMFpPSjhCL1JGNUFKbHRL?=
 =?utf-8?B?UEp2ckRzU1BuMmRGMVBkZ0cwSEhNakd1a1ZQMklaOGxGRjc2NmRJMWdkQk9J?=
 =?utf-8?B?Z0RqWE1FZDE3SVhjSnR6TStjKzZoTUVwdW40VTBjcXZPcnkvNUpFaVpjN1cx?=
 =?utf-8?B?QUgyZmJLb3hNWkUvTlN5Vmp3amNMOWczdnd1WDN1TktuV1d1WVhkb0hkN05Y?=
 =?utf-8?B?dE81c20yTVNNSWNudGdsc3J0ZCtsYWZNZHZyUktYc05rejZWU0J5Nmo3WEZw?=
 =?utf-8?B?b3doQmczbDNjdS9vazkxejVkV2p6MTZKM2tFVzV4a3Y3aG5Mdmlnd3E4Yjc5?=
 =?utf-8?B?TmF4Q01mS0sxVXMzMTV6MnVYWTFxYjZjT3c4TFdGTkRCNVo4M0Y3VVl3b25K?=
 =?utf-8?B?YWJwVUVHNnhEYmIwd2JERkl1S2x4K2pQVS9GeFFnVm9IYlh4T204N3NjSGgw?=
 =?utf-8?B?SEhnWEtXVGw3aGpaNTkvdlZ1QVUxT1oxb2dRZzA0RXVSUmVDMVlkZDROZHY4?=
 =?utf-8?B?TllsZ0F6emNXYjdpUyttd01hMVRha0hKTXZHLy82NE4rTnF6d3BpY1NORENt?=
 =?utf-8?B?SFJHRFhWL1l3VXUzbzA0RkduekFhb2owQnRzaytLTjNUL3dRQzY5WjJuWW1L?=
 =?utf-8?B?RXhlMVo4S3h4TTY5eTBLQVJaaDc4MFFFcktOYXNNWXhoWWkzczNaSTJKZGFk?=
 =?utf-8?B?Rk5BUHhGZFo1dDJlODNwVFJOTnRWSGx6Vlk5ckhUV1JwZ3NMS0JJbW02NzdE?=
 =?utf-8?B?L09DYktFbVcvSkdxNjl4ZXA2MmFONHdVckNKYmRnbXhwWjRjWkNYS3FYZXlz?=
 =?utf-8?B?bHI0ZzdsYVd5UW95ZUh5Sys0cVpwQmdhRnJXZUZ2VElKVkNBTk9kNFpPVmhu?=
 =?utf-8?B?WGpZS0xoam1RbHErOU1WR1p2ejZXeE9TckFNN2tQVXRWZ3NQS2w4dDZvZmNq?=
 =?utf-8?B?aWY1YW9ReFI5VFhhWVNMOWQ5M1NNdVR4NnFVdzUwKzh4cEx1aDhTSnQzL2h5?=
 =?utf-8?B?R2drV2Y0andCLytsVi9oK1dvdHg0UjQzRFpISWFLamdETkdrV0hsZ0lmdG50?=
 =?utf-8?B?TFRteVBJeW5NUDZlQXJpUWxtYWxGK0FTeTN6TUVCeVBYOTZaVTFveHc3T2gw?=
 =?utf-8?B?SkZidXYyTkZXTGVUbytOOXpRbXc4M2NTRUVMWTdsdGRMdXNWUStMVEhKd0I5?=
 =?utf-8?B?QS9PSXM1SlV4QkQvSEIxcTNjTyt5eVJXOEpTeU5Jc05JRmlzUUs5Y3JhMzBY?=
 =?utf-8?B?NUpxcUZVTDhFdHVoc0VWaTdQUnV2OHJOc3k3OXk5RGlGalZGTXFZM3lFdjND?=
 =?utf-8?B?UFNVa01PNlJ5cmhnbjlBUmUxTGp1UjRiZnQwUlhRcmVrVW9CRDJXK0s2VnRH?=
 =?utf-8?B?aDBhQ0M2ZEVvTzZyYVNLUmFVU0Z3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 873db408-8618-4c65-aab6-08db4485964c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2023 05:34:34.5461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: An69kGbSeLvYk01PG1K3vSEgrUkf/CqkDcpTQAAFcFr6uAGlnp4+90ET3ktd8r7cm8Q4PToKiGIu4//Sb7Al4+NabyMxz0LvzvwzEeVR00j5lGHWKT16x/YvoFWn9CPk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11578
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTWFuaXZhbm5hbiwNCg0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2YW0sIFNlbnQ6IFNh
dHVyZGF5LCBBcHJpbCAyMiwgMjAyMyAxMDo0OSBQTQ0KPiANCj4gT24gVHVlLCBBcHIgMTgsIDIw
MjMgYXQgMDk6MjM6NTNQTSArMDkwMCwgWW9zaGloaXJvIFNoaW1vZGEgd3JvdGU6DQo+ID4gQWRk
IGR3X3BjaWVfbGlua19zZXRfbWF4X2NhcF93aWR0aCgpIHRvIHNldCBQQ0lfRVhQX0xOS0NBUF9N
TFcuDQo+ID4gSW4gYWNjb3JkYW5jZSB3aXRoIHRoZSBEVyBQQ0llIFJDL0VQIEhXIG1hbnVhbHMg
WzEsMiwzLC4uLl0gYXNpZGUgd2l0aA0KPiA+IHRoZSBQT1JUX0xJTktfQ1RSTF9PRkYuTElOS19D
QVBBQkxFIGFuZCBHRU4yX0NUUkxfT0ZGLk5VTV9PRl9MQU5FU1s4OjBdDQo+ID4gZmllbGQgdGhl
cmUgaXMgYW5vdGhlciBvbmUgd2hpY2ggbmVlZHMgdG8gYmUgdXBkYXRlLiBJdCdzDQo+IA0KPiBz
L3VwZGF0ZS91cGRhdGVkDQoNCk9vcHMuIEknbGwgZml4IGl0Lg0KDQo+ID4gTElOS19DQVBBQklM
SVRJRVNfUkVHLlBDSUVfQ0FQX01BWF9MSU5LX1dJRFRILiBJZiBpdCBpc24ndCBkb25lIGF0DQo+
ID4gdGhlIHZlcnkgbGVhc3QgdGhlIG1heGltdW0gbGluay13aWR0aCBjYXBhYmlsaXR5IENTUiB3
b24ndCBleHBvc2UNCj4gPiB0aGUgYWN0dWFsIG1heGltdW0gY2FwYWJpbGl0eS4NCj4gPg0KPiA+
IFsxXSBEZXNpZ25XYXJlIENvcmVzIFBDSSBFeHByZXNzIENvbnRyb2xsZXIgRGF0YWJvb2sgLSBE
V0MgUENJZSBSb290IFBvcnQsDQo+ID4gICAgIFZlcnNpb24gNC42MGEsIE1hcmNoIDIwMTUsIHAu
MTAzMg0KPiA+IFsyXSBEZXNpZ25XYXJlIENvcmVzIFBDSSBFeHByZXNzIENvbnRyb2xsZXIgRGF0
YWJvb2sgLSBEV0MgUENJZSBSb290IFBvcnQsDQo+ID4gICAgIFZlcnNpb24gNC43MGEsIE1hcmNo
IDIwMTYsIHAuMTA2NQ0KPiA+IFszXSBEZXNpZ25XYXJlIENvcmVzIFBDSSBFeHByZXNzIENvbnRy
b2xsZXIgRGF0YWJvb2sgLSBEV0MgUENJZSBSb290IFBvcnQsDQo+ID4gICAgIFZlcnNpb24gNC45
MGEsIE1hcmNoIDIwMTYsIHAuMTA1Nw0KPiA+IC4uLg0KPiA+IFtYXSBEZXNpZ25XYXJlIENvcmVz
IFBDSSBFeHByZXNzIENvbnRyb2xsZXIgRGF0YWJvb2sgLSBEV0MgUENJZSBFbmRwb2ludCwNCj4g
PiAgICAgVmVyc2lvbiA1LjQwYSwgTWFyY2ggMjAxOSwgcC4xMzk2DQo+ID4gW1grMV0gRGVzaWdu
V2FyZSBDb3JlcyBQQ0kgRXhwcmVzcyBDb250cm9sbGVyIERhdGFib29rIC0gRFdDIFBDSWUgUm9v
dCBQb3J0LA0KPiA+ICAgICAgIFZlcnNpb24gNS40MGEsIE1hcmNoIDIwMTksIHAuMTI2Ng0KPiA+
DQo+ID4gVGhlIGNvbW1pdCBkZXNjcmlwdGlvbiBpcyBzdWdnZXN0ZWQgYnkgU2VyZ2UgU2VtaW4u
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBZb3NoaWhpcm8gU2hpbW9kYSA8eW9zaGloaXJvLnNo
aW1vZGEudWhAcmVuZXNhcy5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5jIHwgMTYgKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZp
bGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5jIGIvZHJpdmVycy9wY2kvY29u
dHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmMNCj4gPiBpbmRleCBjNzZmYTc4YzY0NjguLjI0
MTNjZDM5MzEwYyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9w
Y2llLWRlc2lnbndhcmUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3Bj
aWUtZGVzaWdud2FyZS5jDQo+ID4gQEAgLTczNyw2ICs3MzcsMjEgQEAgc3RhdGljIHZvaWQgZHdf
cGNpZV9saW5rX3NldF9tYXhfc3BlZWQoc3RydWN0IGR3X3BjaWUgKnBjaSwgdTMyIGxpbmtfZ2Vu
KQ0KPiA+ICAJZHdfcGNpZV93cml0ZWxfZGJpKHBjaSwgb2Zmc2V0ICsgUENJX0VYUF9MTktDQVAs
IGNhcCB8IGxpbmtfc3BlZWQpOw0KPiA+ICB9DQo+ID4NCj4gPiArdm9pZCBkd19wY2llX2xpbmtf
c2V0X21heF9jYXBfd2lkdGgoc3RydWN0IGR3X3BjaWUgKnBjaSwgaW50IG51bV9sYW5lcykNCj4g
DQo+IHN0YXRpYz8gT3IgaWYgeW91IHdhbnQgb3RoZXIgZHJpdmVycyB0byBtYWtlIHVzZSBvZiBp
dCwgdGhlbiBkZWZpbmUgaXQgYXMgYQ0KPiBjb21tb24gUENJIGZ1bmN0aW9uIChub3QgZHdjIHNw
ZWNpZmljKSBhbmQgYWxzbyB1cGRhdGUgb25lIHBvdGVudGlhbCB1c2VyDQo+IChwY2ktbXZlYnUu
YykuIEkgdGhpbmsgeW91IG5lZWQgdG8gZG8gdGhlIGxhdGVyLg0KDQpPb3BzLiBUaGlzIHNob3Vs
ZCBiZSBzdGF0aWMuIEJ1dCwgdGhpcyBmdW5jdGlvbiBjYW5ub3QgYmUgZm9yIG90aGVyIHVlc3Jz
IGJlY2F1c2UNCnRoaXMgZnVuY3Rpb24gbmVlZHMgdG8gdXNlIGR3X3BjaWVfe3JlYWQsd3JpdGV9
bCB3aGljaCBhcmUgZm9yIGR3YyBjb250cm9sbGVycy4NCg0KQmVzdCByZWdhcmRzLA0KWW9zaGlo
aXJvIFNoaW1vZGENCg0KPiAtIE1hbmkNCj4gDQo+ID4gK3sNCj4gPiArCXUzMiB2YWw7DQo+ID4g
Kwl1OCBjYXA7DQo+ID4gKw0KPiA+ICsJaWYgKCFudW1fbGFuZXMpDQo+ID4gKwkJcmV0dXJuOw0K
PiA+ICsNCj4gPiArCWNhcCA9IGR3X3BjaWVfZmluZF9jYXBhYmlsaXR5KHBjaSwgUENJX0NBUF9J
RF9FWFApOw0KPiA+ICsJdmFsID0gZHdfcGNpZV9yZWFkbF9kYmkocGNpLCBjYXAgKyBQQ0lfRVhQ
X0xOS0NBUCk7DQo+ID4gKwl2YWwgJj0gflBDSV9FWFBfTE5LQ0FQX01MVzsNCj4gPiArCXZhbCB8
PSBudW1fbGFuZXMgPDwgUENJX0VYUF9MTktTVEFfTkxXX1NISUZUOw0KPiA+ICsJZHdfcGNpZV93
cml0ZWxfZGJpKHBjaSwgY2FwICsgUENJX0VYUF9MTktDQVAsIHZhbCk7DQo+ID4gK30NCj4gPiAr
DQo+ID4gIHN0YXRpYyB2b2lkIGR3X3BjaWVfbGlua19zZXRfbWF4X3dpZHRoKHN0cnVjdCBkd19w
Y2llICpwY2ksIHUzMiBudW1fbGFuZXMpDQo+ID4gIHsNCj4gPiAgCXUzMiB2YWw7DQo+ID4gQEAg
LTEwNzMsNiArMTA4OCw3IEBAIHZvaWQgZHdfcGNpZV9zZXR1cChzdHJ1Y3QgZHdfcGNpZSAqcGNp
KQ0KPiA+ICAJCWR3X3BjaWVfd3JpdGVsX2RiaShwY2ksIFBDSUVfUExfQ0hLX1JFR19DT05UUk9M
X1NUQVRVUywgdmFsKTsNCj4gPiAgCX0NCj4gPg0KPiA+ICsJZHdfcGNpZV9saW5rX3NldF9tYXhf
Y2FwX3dpZHRoKHBjaSwgcGNpLT5udW1fbGFuZXMpOw0KPiA+ICAJZHdfcGNpZV9saW5rX3NldF9t
YXhfd2lkdGgocGNpLCBwY2ktPm51bV9sYW5lcyk7DQo+ID4gIAlkd19wY2llX2xpbmtfc2V0X21h
eF9saW5rX3dpZHRoKHBjaSwgcGNpLT5udW1fbGFuZXMpOw0KPiA+ICB9DQo+ID4gLS0NCj4gPiAy
LjI1LjENCj4gPg0KPiANCj4gLS0NCj4g4K6u4K6j4K6/4K614K6j4K+N4K6j4K6p4K+NIOCumuCu
pOCuvuCumuCuv+CuteCuruCvjQ0K
