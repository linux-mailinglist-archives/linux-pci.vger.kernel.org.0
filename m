Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4106ECB6F
	for <lists+linux-pci@lfdr.de>; Mon, 24 Apr 2023 13:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjDXLhP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Apr 2023 07:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbjDXLhO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Apr 2023 07:37:14 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2123.outbound.protection.outlook.com [40.107.113.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5D8E77;
        Mon, 24 Apr 2023 04:37:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghb/rx+lCLy+MOhzVg0kvwfW22ac/UWno0Fskm5MJJOlPQ1A9j1fcvvzfE51rSPuhm9uJnnYLjxhWxK5wgbrcXOtYuwNYPMg4B7yJGXf5NqI1DETLHQ04DK1KTU4EgizVSWUSUGy2f+2zK2fxDo3CKQ0aWlhBCyHCwDObG4DrSVAF+7JwWNWWv/O+briOyaz4fvIZ6w/JiF2bawvbYM8eEyN71dkQYb3WoXeQS9Vu3crhsYXhyL+i/lgdZjrYfyrXG8Hnp0XqQOngF5ke8I2YESxsIiThM1lQw5KHkHEz630Lsm8pGEhDY73ix0KULnNZt1hcgBLW5w5mlCN0x/MIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/87YMCQxi5Xnj1TnbBmAUO6oTb5rClOQcqLDfcYCA8=;
 b=bX2isY9dmlsq8JfgKxCfNNofY62QFS+BF6JsGzZ4kRXX1UdzsjhQssf7uK8tx5SuZeriV5sYQ9guns3JlCfiFInXsPtI4qZPdTovovC13DN7hdP6qtSh64w+Ds994tdMw/uSA9ofttXsORIDYQx1iYfM+DrOwe6+OqxhJ+NsM3+2ktzyX8sedCJGg/6DZ04zo8xGlmzXeaLjSD0PaJ4R0So+y3dtS0I2O1+dNBaVBFrGArjJrSGHK90sy3KaVtKvQYrmPhAx1K5v/AEarH7hT6324recuy4l0XmBjw1TmsdBmB7FLbcRJuxewlRTWZ5JqY+UU8YhUHLZDlbO/nL8qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/87YMCQxi5Xnj1TnbBmAUO6oTb5rClOQcqLDfcYCA8=;
 b=phT7DHg/V3Wd+vIBRtmvC3G3RaNvE7q5Z6fWi+bfmYK6k48Wc0w4aMULMMUYPCoT+hwP1eFg1ElcuEjRcHQUAuy2s1GnhlEN5zDl6X9gmLeeyq5cgm2cuzpx9HTPuSoiCnkfTYlEasKynmx6I4qtaXejX1gFXXxTopI2odg0UzE=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYWPR01MB8446.jpnprd01.prod.outlook.com
 (2603:1096:400:175::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 11:37:09 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003%5]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 11:37:09 +0000
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
Subject: RE: [PATCH v13 20/22] PCI: rcar-gen4-ep: Add R-Car Gen4 PCIe Endpoint
 support
Thread-Topic: [PATCH v13 20/22] PCI: rcar-gen4-ep: Add R-Car Gen4 PCIe
 Endpoint support
Thread-Index: AQHZcfCxBKZSVtq36EKDOc0QiWJf8a83bsMAgALu7JA=
Date:   Mon, 24 Apr 2023 11:37:09 +0000
Message-ID: <TYBPR01MB53411A92C3AE26E692B47B11D8679@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230418122403.3178462-1-yoshihiro.shimoda.uh@renesas.com>
 <20230418122403.3178462-21-yoshihiro.shimoda.uh@renesas.com>
 <20230422144712.GQ4769@thinkpad>
In-Reply-To: <20230422144712.GQ4769@thinkpad>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYWPR01MB8446:EE_
x-ms-office365-filtering-correlation-id: ee316dc2-e2f5-4c69-8898-08db44b83d5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TjWixAdXiZsT60+9b7BJ73Isht5xJZ2oXMnFqK80b/Htknb2p1eFDiRG9hRJ1DzU+XQTUbTo5N4BnlApQfOmtimxE0Bcg1Lni/Z6A1hGaufPhhH80XANP2MVGFDP7qDNNz6tK8M203VIvM+J3iXKXrtfRKssFPAnWeVGonKxTojCplXex3C5ibI1Np1tl18LV4iKZn1VIQZiqoLvc1jjdbWvoOLMW9e9G/h+cd4lrnT9Ye52QXBEJPaETrq/HObO/jJYv581JXa4Rv4WX0U20T6kUtjZl+JBLyKl4OnnmetGZBKJaf10YLxmya3UVHP4Eh0lJOKr2d/ZenBeV5PMYxqlY38jO3kZJYHhFMRYpWeHTvZC7Szdjeraq42qLEeVJOfGhslIXXrFfJ5xgHKuv6WDNsoOMhZzR1R/CHBPWzsJf6Pw6jYgyibVVFJvlWz4WOBigNT8V05IW3DwEIMU8clQ6NsFA++pNIkamcqtx7OQNSwyfyEM2YAiJSDuxfrlWocGDv0jBAcn5DrYPTeU4WCuzEdCJrd4Js+IjOWeZ7rYnfxroomS4QIqdTZZZdwBjvKGzZDLAvNB8mj7LO3Pr/FUmt1LsYd5N/DQ5165bGZS6Sp4y9LFDuL19h1yFJ7X
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(451199021)(2906002)(76116006)(64756008)(66446008)(66476007)(66556008)(66946007)(6916009)(316002)(4326008)(52536014)(7416002)(8676002)(8936002)(5660300002)(38070700005)(41300700001)(33656002)(86362001)(55016003)(9686003)(186003)(122000001)(71200400001)(38100700002)(478600001)(7696005)(83380400001)(6506007)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2kvYms1SkZOZEdPQXRsdVd3Vmk0Ym1QeEUwWFl2RkVLWlpKQmNVczF3c0E4?=
 =?utf-8?B?V3Fhd014VTRtN1dvVWY4RzJMS0NkSzVOb2dCaWN0d0xlUjJCcmxSNEpmVnZz?=
 =?utf-8?B?dDd4TWN0QlJvRldyL2JGdEZuS2ZObHpTaGZLVHZQdEt2SVI3RVpVUG93aUR0?=
 =?utf-8?B?ZDZjZ3dpOTU4S3kwSXpxWDA3aWJINzk3aVhPeTNlQ21CNGdodWp5aTkxRGZn?=
 =?utf-8?B?WW9QWHFETUJ2VXNsSklSU3hvcEFrTDdpKzAvbDBQdVF2ZzlqUVZVcUhYdTJ4?=
 =?utf-8?B?ZFpmQ2NEYWtqZDc2UTJ6Uk44NlRkTmlJTmdEeTdMb2JBbkZpbFROTldEUk5w?=
 =?utf-8?B?V2xXenBzVUl5cVUxQlVMWW9pVXQxYmZXVEh2b0RoZG9hbTBxU3ROaldZT01o?=
 =?utf-8?B?MkFwa25UaU5jM09CUCtIbFdHaGZaeHdaSU5waFVxQ2NQVGU5bkkwQ1prcms1?=
 =?utf-8?B?MGJJdExXNFI1bEtkanM4YXF2K3pXQVl5TzRnTXlIRGlNZWtoa1RNRlMzV3M1?=
 =?utf-8?B?bzhsaTI4RVY5Z3M3TWh2ejhLMVJWY3hQTGtKb2R4OEJzL1RnZElSQThIRHN6?=
 =?utf-8?B?d0dzUUVta05BWFAvRCtGYkZRa2hRM0VXWDJ2dWd6cm1lWEY2ZXd4SGlwYTB5?=
 =?utf-8?B?NWNIVC81aXpwcFFLM2pVb2tPaWY1Rll5ZVhwNElzMVdiS2hid3JvT0tVaUdY?=
 =?utf-8?B?T0F6alliOVBlcWpMWVNmWGFvUmdNaFdjbDY5dTJJZlM2UGRybnJRWDRPSVg4?=
 =?utf-8?B?dXBhVFhHOUR0TkhPMmZEV3cra042UEJYbGQrRGtmZkI4RUJ5TkY3ZlFwYWls?=
 =?utf-8?B?cDgzZXVzdUI3L1QrN3NrUmFWS2F5TWR5bVVXc3BqeS9zZW0yMUhSNEdxNk5X?=
 =?utf-8?B?MTlxVysxNGk5WTUzNDBSbzNlUFdaMzBvSkdleXRhRlBUenh3cGIxSm1scnNX?=
 =?utf-8?B?YnFDR2JPL0FxbmxPR1NGa1M5QklUemdOdXJwTHNwelc2Rk9HZEZZMkFMaTBZ?=
 =?utf-8?B?QzRFMG5lSjdxVlBvVmdWQ3dFSU0xSzJXdlVtei9EaUo1L21UYythUlBkM2ly?=
 =?utf-8?B?bU9BV2NoU3ZrV2F6T3F1OThYZlNRSmQ3L2ZaYmhjOFh3U3l3RUNadmlrM3ph?=
 =?utf-8?B?Nyt2WmVUQ1BBcG15dkllTGQyT24yU3lOMHRHOW5WdmVzclFJU2lIL1JGVjZw?=
 =?utf-8?B?MnRGa1VTbUJiaXAwU2tsUENmS1BOZk5NL005d1ErNzVONXNBQ3hOMzk4YXk5?=
 =?utf-8?B?WFgyOFltRCszTk01a3JGZ3dmNFg3U1ZrOUJXUlJtejEvdUxjcStDQWIzRUc3?=
 =?utf-8?B?QjNESGJyNXhLMUtwNkNTamg0YUE3MXVad2JBN1lGc0xWdFA0bXF1WVZXR084?=
 =?utf-8?B?WGlxTmFUVDlxaEFGb0tFY3pwVkhHK1MyQk5XSEw0bkhwZGp1ODJFQ2pxT2Ix?=
 =?utf-8?B?M1RVeUIyalJQNXVDT2hlbTVsZzZNMDA2MDU1Y29RRDRaMjBTeVVWQmJrNk05?=
 =?utf-8?B?S1FoL2FxcGRsY213MjZUMFE1Q2MyVDJlZ2xrVURoTkJqUE42N0x2ZW50am9s?=
 =?utf-8?B?Z1dVVGE4djBXWnd5cElhcjdmZmV4cTR0ZjNTUXdIZU9CRVRjMWxBN0FUYW9E?=
 =?utf-8?B?MWY5cU1MZks4VTdFQm5YRlJIQ0p4b245Si9DcmoyTzNtRy8wblR5QzQ2bDgw?=
 =?utf-8?B?YVUrSVcvYWlwZDAwb2hHajI4cSsrNXlKdEVWSVAvbzNtcFVja2p3WlkyZ2Ew?=
 =?utf-8?B?RW9Rc2J3SzJTVDcxZDVhNmtwZXorZzQwR2JhSHlaaldmdXJoTTYzTXc0eWFz?=
 =?utf-8?B?V1RERm9sWEZ3N3RFR2dNa0VTdmc5dFVsMkpRN1Z4eVdSYVA2b0p3M0pnTk13?=
 =?utf-8?B?TTFrZ1R1RXJ5QXlxejRCVFpoZ3pHaDlYUFZRWjFvTFNCL1JnelNJanduZGVM?=
 =?utf-8?B?dG5PMzJqOFNvS1orcHdqOWRJUHFPZkEwZlhBVTJOUHRDeTI3dnJnMEsvVnMv?=
 =?utf-8?B?aGU1K3VFUFhPUklyN3QrL3VRVHpPcUJnaDJDZTA2aWRCOWVSZGdSTzc3UUx5?=
 =?utf-8?B?R3dUa3E0YllzejR5eGcwVy95VzdkYktMdnNlSFNRZjRJTjRmclVpbFpIZmFt?=
 =?utf-8?B?NTZvakN0Q3B4UTEwRTZLbW5rMS9WZk5leGZmMFRHeG5wTmM4OWQxWWVxQjNt?=
 =?utf-8?B?MFB2SnhaTCsvelJVYjJNcUFHcm5SdHo3TTlzUFpMTkw2SEpYQlg1QzM5OWg5?=
 =?utf-8?B?TWsyOVl1WnMzMkdVSnJJRnNROFJ3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee316dc2-e2f5-4c69-8898-08db44b83d5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2023 11:37:09.7247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 87Nr4MHZXDgLJ2YUmhPQgZObePfsQNrUuJyXjqQeIc4GC9hVVtl/PJgCMy/KiNaWDhqprEP+38IgBylngxKDNjCcPKaJsSd8xrLLEkfXMbUh6cJ7PtsVQHOm/WE30OUp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8446
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
dHVyZGF5LCBBcHJpbCAyMiwgMjAyMyAxMTo0NyBQTQ0KPiANCj4gT24gVHVlLCBBcHIgMTgsIDIw
MjMgYXQgMDk6MjQ6MDFQTSArMDkwMCwgWW9zaGloaXJvIFNoaW1vZGEgd3JvdGU6DQo+ID4gQWRk
IFItQ2FyIEdlbjQgUENJZSBFbmRwb2ludCBzdXBwb3J0LiBUaGlzIGNvbnRyb2xsZXIgaXMgYmFz
ZWQgb24NCj4gPiBTeW5vcHN5cyBEZXNpZ25XYXJlIFBDSWUuDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBZb3NoaWhpcm8gU2hpbW9kYSA8eW9zaGloaXJvLnNoaW1vZGEudWhAcmVuZXNhcy5jb20+
DQo+IA0KPiBTbWFsbCBuaXQgYmVsb3cuLi4NCj4gDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvZHdjL0tjb25maWcgICAgICAgICAgICB8ICAgOSArDQo+ID4gIGRyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL01ha2VmaWxlICAgICAgICAgICB8ICAgMiArDQo+ID4gIC4uLi9w
Y2kvY29udHJvbGxlci9kd2MvcGNpZS1yY2FyLWdlbjQtZXAuYyAgICB8IDE2NiArKysrKysrKysr
KysrKysrKysNCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAxNzcgaW5zZXJ0aW9ucygrKQ0KPiA+ICBj
cmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1yY2FyLWdl
bjQtZXAuYw0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdj
L0tjb25maWcgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9LY29uZmlnDQo+ID4gaW5kZXgg
ZWI5MGUyMTE2ZTU5Li4xYjYwY2FkZThhMjAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kv
Y29udHJvbGxlci9kd2MvS2NvbmZpZw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
ZHdjL0tjb25maWcNCj4gPiBAQCAtNDI0LDQgKzQyNCwxMyBAQCBjb25maWcgUENJRV9SQ0FSX0dF
TjQNCj4gPiAgCSAgU2F5IFkgaGVyZSBpZiB5b3Ugd2FudCBQQ0llIGhvc3QgY29udHJvbGxlciBz
dXBwb3J0IG9uIFItQ2FyIEdlbjQgU29Dcy4NCj4gPiAgCSAgVGhpcyB1c2VzIHRoZSBEZXNpZ25X
YXJlIGNvcmUuDQo+ID4NCj4gPiArY29uZmlnIFBDSUVfUkNBUl9HRU40X0VQDQo+ID4gKwl0cmlz
dGF0ZSAiUmVuZXNhcyBSLUNhciBHZW40IFBDSWUgRW5kcG9pbnQgY29udHJvbGxlciINCj4gPiAr
CWRlcGVuZHMgb24gQVJDSF9SRU5FU0FTIHx8IENPTVBJTEVfVEVTVA0KPiA+ICsJZGVwZW5kcyBv
biBQQ0lfRU5EUE9JTlQNCj4gPiArCXNlbGVjdCBQQ0lFX0RXX0VQDQo+ID4gKwloZWxwDQo+ID4g
KwkgIFNheSBZIGhlcmUgaWYgeW91IHdhbnQgUENJZSBlbmRwb2ludCBjb250cm9sbGVyIHN1cHBv
cnQgb24gUi1DYXIgR2VuNA0KPiA+ICsJICBTb0NzLiBUaGlzIHVzZXMgdGhlIERlc2lnbldhcmUg
Y29yZS4NCj4gPiArDQo+ID4gIGVuZG1lbnUNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kv
Y29udHJvbGxlci9kd2MvTWFrZWZpbGUgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9NYWtl
ZmlsZQ0KPiA+IGluZGV4IDQ4NmNmNzA2YjUzZC4uMGZiMGJkZTI2YWM0IDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL01ha2VmaWxlDQo+ID4gKysrIGIvZHJpdmVy
cy9wY2kvY29udHJvbGxlci9kd2MvTWFrZWZpbGUNCj4gPiBAQCAtMjgsNiArMjgsOCBAQCBvYmot
JChDT05GSUdfUENJRV9VTklQSElFUl9FUCkgKz0gcGNpZS11bmlwaGllci1lcC5vDQo+ID4gIG9i
ai0kKENPTkZJR19QQ0lFX1ZJU0NPTlRJX0hPU1QpICs9IHBjaWUtdmlzY29udGkubw0KPiA+ICBw
Y2llLXJjYXItZ2VuNC1ob3N0LWRydi1vYmpzIDo9IHBjaWUtcmNhci1nZW40Lm8gcGNpZS1yY2Fy
LWdlbjQtaG9zdC5vDQo+ID4gIG9iai0kKENPTkZJR19QQ0lFX1JDQVJfR0VONCkgKz0gcGNpZS1y
Y2FyLWdlbjQtaG9zdC1kcnYubw0KPiA+ICtwY2llLXJjYXItZ2VuNC1lcC1kcnYtb2JqcyA6PSBw
Y2llLXJjYXItZ2VuNC5vIHBjaWUtcmNhci1nZW40LWVwLm8NCj4gPiArb2JqLSQoQ09ORklHX1BD
SUVfUkNBUl9HRU40X0VQKSArPSBwY2llLXJjYXItZ2VuNC1lcC1kcnYubw0KPiA+DQo+ID4gICMg
VGhlIGZvbGxvd2luZyBkcml2ZXJzIGFyZSBmb3IgZGV2aWNlcyB0aGF0IHVzZSB0aGUgZ2VuZXJp
YyBBQ1BJDQo+ID4gICMgcGNpX3Jvb3QuYyBkcml2ZXIgYnV0IGRvbid0IHN1cHBvcnQgc3RhbmRh
cmQgRUNBTSBjb25maWcgYWNjZXNzLg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL2R3Yy9wY2llLXJjYXItZ2VuNC1lcC5jIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9k
d2MvcGNpZS1yY2FyLWdlbjQtZXAuYw0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5k
ZXggMDAwMDAwMDAwMDAwLi5lYjRiMjljOTQ4ZDUNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysr
IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1yY2FyLWdlbjQtZXAuYw0KPiA+IEBA
IC0wLDAgKzEsMTY2IEBADQo+ID4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4w
LW9ubHkNCj4gPiArLyoNCj4gPiArICogUENJZSBFbmRwb2ludCBkcml2ZXIgZm9yIFJlbmVzYXMg
Ui1DYXIgR2VuNCBTZXJpZXMgU29Dcw0KPiA+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMjItMjAyMyBS
ZW5lc2FzIEVsZWN0cm9uaWNzIENvcnBvcmF0aW9uDQo+ID4gKyAqLw0KPiA+ICsNCj4gPiArI2lu
Y2x1ZGUgPGxpbnV4L2ludGVycnVwdC5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+
DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9vZl9kZXZpY2UuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4
L3BjaS5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+ID4gKw0K
PiA+ICsjaW5jbHVkZSAicGNpZS1yY2FyLWdlbjQuaCINCj4gPiArI2luY2x1ZGUgInBjaWUtZGVz
aWdud2FyZS5oIg0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQgcmNhcl9nZW40X3BjaWVfZXBfcHJl
X2luaXQoc3RydWN0IGR3X3BjaWVfZXAgKmVwKQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgZHdfcGNp
ZSAqZHcgPSB0b19kd19wY2llX2Zyb21fZXAoZXApOw0KPiA+ICsJc3RydWN0IHJjYXJfZ2VuNF9w
Y2llICpyY2FyID0gdG9fcmNhcl9nZW40X3BjaWUoZHcpOw0KPiA+ICsJdTggdmFsOw0KPiA+ICsN
Cj4gPiArCXJjYXJfZ2VuNF9wY2llX3NldF9kZXZpY2VfdHlwZShyY2FyLCBmYWxzZSwgZHctPm51
bV9sYW5lcyk7DQo+ID4gKw0KPiA+ICsJZHdfcGNpZV9kYmlfcm9fd3JfZW4oZHcpOw0KPiA+ICsN
Cj4gPiArCS8qIFNpbmdsZSBmdW5jdGlvbiAqLw0KPiA+ICsJdmFsID0gZHdfcGNpZV9yZWFkYl9k
YmkoZHcsIFBDSV9IRUFERVJfVFlQRSk7DQo+ID4gKwl2YWwgJj0gflBDSV9IRUFERVJfVFlQRV9N
VUxUSV9GVU5DOw0KPiA+ICsJZHdfcGNpZV93cml0ZWJfZGJpKGR3LCBQQ0lfSEVBREVSX1RZUEUs
IHZhbCk7DQo+ID4gKw0KPiA+ICsJZHdfcGNpZV9kYmlfcm9fd3JfZGlzKGR3KTsNCj4gPiArDQo+
ID4gKwl3cml0ZWwoUENJRURNQUlOVFNUU0VOX0lOSVQsIHJjYXItPmJhc2UgKyBQQ0lFRE1BSU5U
U1RTRU4pOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9pZCByY2FyX2dlbjRfcGNpZV9l
cF9kZWluaXQoc3RydWN0IGR3X3BjaWVfZXAgKmVwKQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgZHdf
cGNpZSAqZHcgPSB0b19kd19wY2llX2Zyb21fZXAoZXApOw0KPiA+ICsJc3RydWN0IHJjYXJfZ2Vu
NF9wY2llICpyY2FyID0gdG9fcmNhcl9nZW40X3BjaWUoZHcpOw0KPiA+ICsNCj4gPiArCXdyaXRl
bCgwLCByY2FyLT5iYXNlICsgUENJRURNQUlOVFNUU0VOKTsNCj4gPiArfQ0KPiA+ICsNCj4gPiAr
c3RhdGljIGludCByY2FyX2dlbjRfcGNpZV9lcF9yYWlzZV9pcnEoc3RydWN0IGR3X3BjaWVfZXAg
KmVwLCB1OCBmdW5jX25vLA0KPiA+ICsJCQkJICAgICAgIGVudW0gcGNpX2VwY19pcnFfdHlwZSB0
eXBlLA0KPiA+ICsJCQkJICAgICAgIHUxNiBpbnRlcnJ1cHRfbnVtKQ0KPiA+ICt7DQo+ID4gKwlz
dHJ1Y3QgZHdfcGNpZSAqZHcgPSB0b19kd19wY2llX2Zyb21fZXAoZXApOw0KPiA+ICsNCj4gPiAr
CXN3aXRjaCAodHlwZSkgew0KPiA+ICsJY2FzZSBQQ0lfRVBDX0lSUV9JTlRYOg0KPiA+ICsJCXJl
dHVybiBkd19wY2llX2VwX3JhaXNlX2ludHhfaXJxKGVwLCBmdW5jX25vKTsNCj4gPiArCWNhc2Ug
UENJX0VQQ19JUlFfTVNJOg0KPiA+ICsJCXJldHVybiBkd19wY2llX2VwX3JhaXNlX21zaV9pcnEo
ZXAsIGZ1bmNfbm8sIGludGVycnVwdF9udW0pOw0KPiA+ICsJZGVmYXVsdDoNCj4gPiArCQlkZXZf
ZXJyKGR3LT5kZXYsICJVTktOT1dOIElSUSB0eXBlXG4iKTsNCj4gDQo+IFVua25vd24NCg0KSSBn
b3QgaXQuIEknbGwgZml4IGl0IG9uIHYxMy4NCg0KPiA+ICsJCXJldHVybiAtRUlOVkFMOw0KPiA+
ICsJfQ0KPiA+ICsNCj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMg
Y29uc3Qgc3RydWN0IHBjaV9lcGNfZmVhdHVyZXMgcmNhcl9nZW40X3BjaWVfZXBjX2ZlYXR1cmVz
ID0gew0KPiA+ICsJLmxpbmt1cF9ub3RpZmllciA9IGZhbHNlLA0KPiA+ICsJLm1zaV9jYXBhYmxl
ID0gdHJ1ZSwNCj4gPiArCS5tc2l4X2NhcGFibGUgPSBmYWxzZSwNCj4gPiArCS5yZXNlcnZlZF9i
YXIgPSAxIDw8IEJBUl81LA0KPiA+ICsJLmFsaWduID0gU1pfMU0sDQo+ID4gK307DQo+ID4gKw0K
PiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IHBjaV9lcGNfZmVhdHVyZXMqDQo+ID4gK3JjYXJfZ2Vu
NF9wY2llX2VwX2dldF9mZWF0dXJlcyhzdHJ1Y3QgZHdfcGNpZV9lcCAqZXApDQo+ID4gK3sNCj4g
PiArCXJldHVybiAmcmNhcl9nZW40X3BjaWVfZXBjX2ZlYXR1cmVzOw0KPiA+ICt9DQo+ID4gKw0K
PiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGR3X3BjaWVfZXBfb3BzIHBjaWVfZXBfb3BzID0gew0K
PiA+ICsJLmVwX3ByZV9pbml0ID0gcmNhcl9nZW40X3BjaWVfZXBfcHJlX2luaXQsDQo+ID4gKwku
ZXBfZGVpbml0ID0gcmNhcl9nZW40X3BjaWVfZXBfZGVpbml0LA0KPiA+ICsJLnJhaXNlX2lycSA9
IHJjYXJfZ2VuNF9wY2llX2VwX3JhaXNlX2lycSwNCj4gPiArCS5nZXRfZmVhdHVyZXMgPSByY2Fy
X2dlbjRfcGNpZV9lcF9nZXRfZmVhdHVyZXMsDQo+ID4gK307DQo+ID4gKw0KPiA+ICtzdGF0aWMg
aW50IHJjYXJfZ2VuNF9hZGRfcGNpZV9lcChzdHJ1Y3QgcmNhcl9nZW40X3BjaWUgKnJjYXIsDQo+
ID4gKwkJCQkgc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiArew0KPiA+ICsJc3Ry
dWN0IGR3X3BjaWVfZXAgKmVwID0gJnJjYXItPmR3LmVwOw0KPiA+ICsJaW50IHJldDsNCj4gPiAr
DQo+ID4gKwllcC0+b3BzID0gJnBjaWVfZXBfb3BzOw0KPiA+ICsNCj4gPiArCXJldCA9IGR3X3Bj
aWVfZXBfaW5pdChlcCk7DQo+ID4gKwlpZiAocmV0KSB7DQo+ID4gKwkJZGV2X2VycigmcGRldi0+
ZGV2LCAiZmFpbGVkIHRvIGluaXRpYWxpemUgZW5kcG9pbnRcbiIpOw0KPiA+ICsJCXJldHVybiBy
ZXQ7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+ID4g
K3N0YXRpYyB2b2lkIHJjYXJfZ2VuNF9yZW1vdmVfcGNpZV9lcChzdHJ1Y3QgcmNhcl9nZW40X3Bj
aWUgKnJjYXIpDQo+ID4gK3sNCj4gPiArCWR3X3BjaWVfZXBfZXhpdCgmcmNhci0+ZHcuZXApOw0K
PiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IHJjYXJfZ2VuNF9wY2llX2VwX3Byb2JlKHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBkZXZpY2Ug
KmRldiA9ICZwZGV2LT5kZXY7DQo+ID4gKwlzdHJ1Y3QgcmNhcl9nZW40X3BjaWUgKnJjYXI7DQo+
ID4gKwlpbnQgZXJyOw0KPiA+ICsNCj4gPiArCXJjYXIgPSByY2FyX2dlbjRfcGNpZV9kZXZtX2Fs
bG9jKGRldik7DQo+ID4gKwlpZiAoIXJjYXIpDQo+ID4gKwkJcmV0dXJuIC1FTk9NRU07DQo+ID4g
Kw0KPiA+ICsJZXJyID0gcmNhcl9nZW40X3BjaWVfZ2V0X3Jlc291cmNlcyhyY2FyLCBwZGV2KTsN
Cj4gPiArCWlmIChlcnIgPCAwKSB7DQo+ID4gKwkJZGV2X2VycihkZXYsICJGYWlsZWQgdG8gcmVx
dWVzdCByZXNvdXJjZTogJWRcbiIsIGVycik7DQo+ID4gKwkJcmV0dXJuIGVycjsNCj4gPiArCX0N
Cj4gDQo+IE5vIG5lZWQgdG8gYXNzZXJ0L2RlYXNzZXJ0IHJlc2V0Pw0KDQpJIGFzc3VtZWQgbm8g
bmVlZCB0byBhc3NlcnQgcmVzZXQsIGFuZCBkZWFzc2VydGluZyB3aWxsIGJlIGlzc3VlZCBvbg0K
cmNhcl9nZW40X3BjaWVfc2V0X2RldmljZV90eXBlKCkgZnJvbSByY2FyX2dlbjRfcGNpZV9lcF9w
cmVfaW5pdCgpLg0KDQpCZXN0IHJlZ2FyZHMsDQpZb3NoaWhpcm8gU2hpbW9kYQ0KDQo+IC0gTWFu
aQ0KPiANCj4gLS0NCj4g4K6u4K6j4K6/4K614K6j4K+N4K6j4K6p4K+NIOCumuCupOCuvuCumuCu
v+CuteCuruCvjQ0K
