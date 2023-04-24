Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABD26EC4A0
	for <lists+linux-pci@lfdr.de>; Mon, 24 Apr 2023 07:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjDXFCX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Apr 2023 01:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjDXFCW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Apr 2023 01:02:22 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2094.outbound.protection.outlook.com [40.107.114.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25F72D70;
        Sun, 23 Apr 2023 22:02:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QT3KNb5ikqbQShiKSEB1S9VM6GRjiY/clmnHt8NKgPoni43wV759ZHhDHMSRRBfCuKmwRLuIzgx4QMVZ64/bXYW7aFONenjTpU0vepATWeFRb4WtnVa5GFC5P+oR9H5n6R4S+pNshnl0D+b2ynXkXGugCCPD2jFqDXT/PfwdDS4uOzYvjgydZhyt6l2xVX9QiuN1AOA2URANT1QUxuGP2Bp70/Ieoxcb/+7rXz0rAV1gShIvGee9j6LWhcqp/busGRgbMIw3ofokDKmC46+LAC2JOj4jpJLjtC3bFhfdWnopf7Tz7W+YQXk6olmyXO6I1qO7np1HgH4bNKOahJafNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=waQOJNDMKKT5h5Tju3qgfYtZiQ9bQUQcgXFxmfLzFmE=;
 b=X5/zyFabQsa7FxZMFpjbXVJe4d+IaYdQFk62ycPQN5vlG1xo84KP4GHlBXPj09hP+ZDSqzYEvtJFzzddqHeVbfi6UIEjYk9iYfHMacLJS+Sb2UYwbofXRXd5hvRAInhpops62taI8EeWbjswG6hr5k7hMTcsJOENPszNsWS2kYR9QdN4L9VLzxvh/erFFeDV2wcngPoMcm8ReEDcz1iOoALQvfFpVe65B9XrYaX/NOJawHmd+r/i6JSLTeijmnXuAUkhn2c3abIRig58xiWKkjdfaeUvG0m9Qk67z20FWfgXoEtXrmBkMm7oLregKjiJMu1yJb2oQucHT6Wbv6Zk/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=waQOJNDMKKT5h5Tju3qgfYtZiQ9bQUQcgXFxmfLzFmE=;
 b=dz87AolwpkS/ioycM1qU0sJjYD8o0Aiil1Q3zhLGD1LVIqSHA7LycRR9xofY9JuPfeEaR3MNp4moBepX7C20H70qTO6r31J9CbuyREeBeM5q9YiX0vXzq+DVzTdU5lAUng3/N9+Tgux+gCER3cnKHe3GPN1wjORSI/ECzAeaYsw=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OSRPR01MB11856.jpnprd01.prod.outlook.com
 (2603:1096:604:232::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 05:02:16 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003%5]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 05:02:16 +0000
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
        <linux-renesas-soc@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: RE: [PATCH v13 05/22] PCI: dwc: Rename with
 dw_pcie_ep_raise_intx_irq()
Thread-Topic: [PATCH v13 05/22] PCI: dwc: Rename with
 dw_pcie_ep_raise_intx_irq()
Thread-Index: AQHZcfCx4ODnvQkkRUGiGIB62UZZGq83L5kAgAK/5EA=
Date:   Mon, 24 Apr 2023 05:02:16 +0000
Message-ID: <TYBPR01MB534120E872D74E62F87809CFD8679@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230418122403.3178462-1-yoshihiro.shimoda.uh@renesas.com>
 <20230418122403.3178462-6-yoshihiro.shimoda.uh@renesas.com>
 <20230422110108.GB4769@thinkpad>
In-Reply-To: <20230422110108.GB4769@thinkpad>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|OSRPR01MB11856:EE_
x-ms-office365-filtering-correlation-id: 924a32ec-016e-4a77-357e-08db4481131e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xz/JDMlSDg4iANQBkYdEohrwC/uPJLtPOeDGiSBuv3+dXrkgtBERDTnDTS+SvOxDj2Q03VYzRWA98rbhaGRQTDkpvlWHYXXaKTuERmEoiPvuttH36C50nxzEyK+wqCt0TdWh5mLmvJuXHh8kzHvkrs3HFJ6kpUaGcHKgFc+y8tmSU6bfrxK4vcGAKADcos6GS7vclWnr8fKSwLE9cU+IIrNg9BPCKJAidlI9wAK0dvdRK2mGfUDqerrV5PVMdkYkurfaAJ+ID35W3cM975WiPg+0W2orAeMGW1IbAibSOCGMNCvHrXZpaNKB/AfyUzmqmIZY1lAW3FQ3D2/RGJ3BcKT+qtkS0+3CEsw2TRbjva7kWyUTnypYEC9aigOWi9WPev1SMzhOHcaH0+zEU2SUevNgOFK5Ce99AwgsSlhXSrUUH5NH4OOXCzt2Debk67MyeoJCFUiJq2hLJyKrjfS/LR34pXS28ZoSq34tbq5dc+iG5XF9sg/UBeFSUsW7IC9UgirYhGqEBw0iFUMYbUu9wlp6u3GPdUiBkmyX53EOgdMO3hRLIr5JT9GeVTOOw5u75Qphuufb8e+4kWKNH8O013mcSqPrjsK5bHOLmnQYt/nDsaOeNnULhNQE1KiVpM9i
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199021)(478600001)(54906003)(86362001)(186003)(7696005)(9686003)(6506007)(55016003)(33656002)(71200400001)(4326008)(6916009)(64756008)(66446008)(66476007)(66556008)(316002)(83380400001)(66946007)(76116006)(2906002)(38100700002)(122000001)(41300700001)(8676002)(8936002)(38070700005)(5660300002)(7416002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1dLMmdobVNQY3BtS29qMHdNamkrL1NDdS9YSCthVGMrcSs4NlRvTzN1dTJo?=
 =?utf-8?B?UXpNcHQ4citFTUZXS0ZDSXUvYjZUYmdKK2pWbGJ0eEJyQVF0RDJiYjA4WDlS?=
 =?utf-8?B?RWVpSTRHU0RWdlE5RTc5YWNOZ01zcE91T0Q2MzVKbEFBSnFMSmtxWjk0NktW?=
 =?utf-8?B?b1ZTQk1QM0pNQmhHMk15UTE2ZjRzaTdUNHRXbGxnT25hQU5DamltTVF3YkU1?=
 =?utf-8?B?SmdiWG9TZUl3aTZaZDVET3ZvemxJcnlLK1dUdDMwMWlEamxsQ0R4Q05tazFI?=
 =?utf-8?B?WERXSTE5Zk5qMWhVQm9aVTNEdUhyWkc2aUF3RzdMSHNKemo3WEwrWW5KcTQ1?=
 =?utf-8?B?UVRCZ0xlakREZHIrTnpmaVNaTkt2S05PT1JVclRDaTk4Y3hlRWJxbnVPSlQr?=
 =?utf-8?B?c1dvUU9mbEZDL01wN3RsSGhCVGdTYnNZaDB1aUdQajA4bHRpZm9PcDlxcjhI?=
 =?utf-8?B?MFlqNTRLd3hVTlp4M2M3QTN1ZkVObnR6N2JjcVE5LzlpRUZTdStVVkZ4M2ls?=
 =?utf-8?B?Q1cwbFdxODRDUERUR2hBbUFERVd0N1F0QnVEVGNBc25Pd1VWbW1NOHlWRnJz?=
 =?utf-8?B?UVJRYzd0cHZsL3Z5OFJ3b0IrcnVkUzY5RnoyNUJkaWZkR2ZxNWw0ZlJQT2JD?=
 =?utf-8?B?cmFmS2E5ditUQkxUbEFKaXFSWm1uNTFHSE9NNVpCWW5DMi9KZWhDWjgwMVIw?=
 =?utf-8?B?VkF0Vm5NVWdrRDBmd0grQmVjTjl0Mk45OStRMFBSdHpzUExBSk4rd1crRjl4?=
 =?utf-8?B?Ynl6a0p3dERZUjRpejk2NjlhVlpoQ0VPeWkzT1kya0NPQ2tJaGJQWUdPbStl?=
 =?utf-8?B?dkovVmhEN1dlNWJXZ0NKbVBuUzRPYlpiNlN2c0ttU0oyaGVRSTlaT0dublVL?=
 =?utf-8?B?a3BWS1o5T3RhUGZoT1pXTmpiaUJBK0ZYczZjbWlhWnMvK1NuWE5wY3QwelNL?=
 =?utf-8?B?anV3WXRRc21oQmRlbjVwRnUyR2hCaHVjSFFMLzZrQmhhU2VwZktWUjZaR1Ew?=
 =?utf-8?B?cWlOQTRVRWRpYWVwNitiakhGa2RtN3hNblphSUpkWkFTcUNTU25BbUNVdFJi?=
 =?utf-8?B?WUlxRFZJRmdpUzBRdFZPNFZPUlRzVXdFQWNSMWcydUFtckxGdVBPNDFYb2Fn?=
 =?utf-8?B?bllVUTQ0RlkyM3JZQ1cwdnlYS1dvdSs4Y3B6ZUo1cUw5QlN0TitMRFdzaVox?=
 =?utf-8?B?RzdkM0dISWd4Smh2Y0oyaUtsaFRPdU0rUU5sWkZkR0lsdWczWjJLMFFkeVJx?=
 =?utf-8?B?eUMyUEM2ZGFiajh5TlZpUlczWm9XU0tyMXRONklIQ0RQSUxtTCszMzRiQStG?=
 =?utf-8?B?YmUrKzBtOFVFaE9zK0dpU2RHWmZHSzNnZW5XcVY4LzI2VTYwWWpYV3R3eTJa?=
 =?utf-8?B?djVnVnhXZ0NWT3hzOUVWRlFQUlJwdTZ2WWpiTkJKZ1BwVzhucjY2aDZXdnNi?=
 =?utf-8?B?cjhsZmIwVXRocnhteFZ4TjEzMndCc1oycmt0QWIreXZTbjZzNmFPaEJJYWd6?=
 =?utf-8?B?MkRrelFtcWdsd1lpWkpMZHdVdVRUZi90QnAzOVI2UnBCZytaTGQ4M2xUNFpN?=
 =?utf-8?B?UTJxM0RnSXMxdGdHNDhPeDFQWmJ6Ykk5V1J6THpERDRCa1RkT2ZYVjNLaTNQ?=
 =?utf-8?B?YXFHVFczZTlHV0thMHA5WElwa1pycTh4Uk5qVVM1cE9xTk9adkQvcDBvUytN?=
 =?utf-8?B?ODgvN3NNYUJVWWNoVjIvRTM1L1Rna0s2cjNwY3Z4czVUTUY5NjMxc0dkdkIx?=
 =?utf-8?B?bHpUSllHalUyWWc2a3pGMUoza2YvVGlOY1M2NGhUbXJjU2JsbFhNNGQwM3dX?=
 =?utf-8?B?ay9Ebk03aTNCc3RTbTJYcXF2c1JMeG9oeFpCLzVqRit0UzVXOGlWQlFBbDA1?=
 =?utf-8?B?Vkg5MWJ3cDVEVjI4UC96L1Zodm5hWlo2OWlZQ2xHQzJwd1Q1a2RrNThNMldp?=
 =?utf-8?B?elNaTDdTM05qYnpGajcvdk5LWVZSdktHNzZMUk5EWnhyS0R1WXFLWERCU1Ro?=
 =?utf-8?B?bUxPWjJscXF3WG16OFRzZUwzbk9Ba0xvVFJyOGg5bjR3U1JCd3R5MXhyRDFa?=
 =?utf-8?B?Um85ZDA4UEdPeUNWVzB3dG0ybS93YUxrTG4xL1RucDdtNDlMblEzQkx3MDc5?=
 =?utf-8?B?Ym1tNmU5S1J0bHV6TFIvSW9pd204bXFHZVB5SVVYUEg2MXNDTUJuTEdKeGlr?=
 =?utf-8?B?K2VpSDUzQStQZTZpT2JTc3NVK25LTytsZmh6SDF0MXJYWnJwZFhVTk5uZmk3?=
 =?utf-8?B?R0lHZUZ4KzY3aUdOdkh3VTVlTC93PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 924a32ec-016e-4a77-357e-08db4481131e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2023 05:02:16.5154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AokePYWpyjWNFQz0ZwTHFWjhOz6ARqIRa0SZeTUUrBKFuAwq+FsBgcTFysJrNiwJqHa8sDdtUpEtU5ncnr/7x+M06j4dVFgskQsgyGTTTHpCitfki6dLykJFN5gzr9u6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11856
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
dHVyZGF5LCBBcHJpbCAyMiwgMjAyMyA4OjAxIFBNDQo+IA0KPiBPbiBUdWUsIEFwciAxOCwgMjAy
MyBhdCAwOToyMzo0NlBNICswOTAwLCBZb3NoaWhpcm8gU2hpbW9kYSB3cm90ZToNCj4gDQo+IFN1
YmplY3Qgc2hvdWxkIGJlOg0KPiANCj4gUENJOiBkd2M6IFJlbmFtZSAibGVnYWN5X2lycSIgdG8g
IklOVHhfaXJxIiBpbiBEV0MgY29yZQ0KPiANCj4gPiBVc2luZyAiSU5UeCIgaW5zdGVhZCBvZiAi
bGVnYWN5IiBpcyBtb3JlIHNwZWNpZmljLiBTbywgcmVuYW1lDQo+ID4gZHdfcGNpZV9lcF9yYWlz
ZV9sZWdhY3lfaXJxKCkgd2l0aCBkd19wY2llX2VwX3JhaXNlX2ludHhfaXJxKCkuDQo+ID4NCj4g
DQo+IHMvd2l0aC90bw0KDQpJJ2xsIGZpeCB0aGVtIG9uIHYxMy4NCg0KPiBUaGVyZSBhcmUgc3Rp
bGwgbWFueSBpbnN0YW5jZXMgb2YgImxlZ2FjeSIgdXNlZCBpbnNpZGUgdGhlIERXQyBkcml2ZXJz
LiBCdXQNCj4gSSBzdXBwb3NlIHRob3NlIGNvdWxkIGJlIGZpeGVkIGJ5IHRoZSByZXNwZWN0aXZl
IGRyaXZlciBtYWludGFpbmVycy4NCg0KSSB0aGluayBzby4NCg0KPiA+IFN1Z2dlc3RlZC1ieTog
Qmpvcm4gSGVsZ2FhcyA8aGVsZ2Fhc0BrZXJuZWwub3JnPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFlv
c2hpaGlybyBTaGltb2RhIDx5b3NoaWhpcm8uc2hpbW9kYS51aEByZW5lc2FzLmNvbT4NCj4gDQo+
IFdpdGggYWJvdmUgY2hhbmdlcywNCj4gDQo+IFJldmlld2VkLWJ5OiBNYW5pdmFubmFuIFNhZGhh
c2l2YW0gPG1hbmlAa2VybmVsLm9yZz4NCg0KVGhhbmsgeW91IGZvciB5b3VyIHJldmlldyENCg0K
QmVzdCByZWdhcmRzLA0KWW9zaGloaXJvIFNoaW1vZGENCg0KPiAtIE1hbmkNCj4gDQo+ID4gLS0t
DQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMgICAgICAgICAgICAg
fCAyICstDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1sYXllcnNjYXBlLWVw
LmMgICAgfCAyICstDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdu
d2FyZS1lcC5jICAgfCA2ICsrKy0tLQ0KPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9w
Y2llLWRlc2lnbndhcmUtcGxhdC5jIHwgMiArLQ0KPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVy
L2R3Yy9wY2llLWRlc2lnbndhcmUuaCAgICAgIHwgNCArKy0tDQo+ID4gIGRyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvZHdjL3BjaWUtcWNvbS1lcC5jICAgICAgICAgfCAyICstDQo+ID4gIDYgZmlsZXMg
Y2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMgYi9kcml2ZXJzL3Bj
aS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gaW5kZXggMWYzOWU3MzNjZTE5Li4wODMx
ZjM5NDcyMjAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNp
LWlteDYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMN
Cj4gPiBAQCAtMTA2Myw3ICsxMDYzLDcgQEAgc3RhdGljIGludCBpbXg2X3BjaWVfZXBfcmFpc2Vf
aXJxKHN0cnVjdCBkd19wY2llX2VwICplcCwgdTggZnVuY19ubywNCj4gPg0KPiA+ICAJc3dpdGNo
ICh0eXBlKSB7DQo+ID4gIAljYXNlIFBDSV9FUENfSVJRX0lOVFg6DQo+ID4gLQkJcmV0dXJuIGR3
X3BjaWVfZXBfcmFpc2VfbGVnYWN5X2lycShlcCwgZnVuY19ubyk7DQo+ID4gKwkJcmV0dXJuIGR3
X3BjaWVfZXBfcmFpc2VfaW50eF9pcnEoZXAsIGZ1bmNfbm8pOw0KPiA+ICAJY2FzZSBQQ0lfRVBD
X0lSUV9NU0k6DQo+ID4gIAkJcmV0dXJuIGR3X3BjaWVfZXBfcmFpc2VfbXNpX2lycShlcCwgZnVu
Y19ubywgaW50ZXJydXB0X251bSk7DQo+ID4gIAljYXNlIFBDSV9FUENfSVJRX01TSVg6DQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1sYXllcnNjYXBlLWVw
LmMgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktbGF5ZXJzY2FwZS1lcC5jDQo+ID4g
aW5kZXggYWIzMzA2ZTIwNmQ4Li4zZDU4ZmMxNjcwYjQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWxheWVyc2NhcGUtZXAuYw0KPiA+ICsrKyBiL2RyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1sYXllcnNjYXBlLWVwLmMNCj4gPiBAQCAtNjYsNyAr
NjYsNyBAQCBzdGF0aWMgaW50IGxzX3BjaWVfZXBfcmFpc2VfaXJxKHN0cnVjdCBkd19wY2llX2Vw
ICplcCwgdTggZnVuY19ubywNCj4gPg0KPiA+ICAJc3dpdGNoICh0eXBlKSB7DQo+ID4gIAljYXNl
IFBDSV9FUENfSVJRX0lOVFg6DQo+ID4gLQkJcmV0dXJuIGR3X3BjaWVfZXBfcmFpc2VfbGVnYWN5
X2lycShlcCwgZnVuY19ubyk7DQo+ID4gKwkJcmV0dXJuIGR3X3BjaWVfZXBfcmFpc2VfaW50eF9p
cnEoZXAsIGZ1bmNfbm8pOw0KPiA+ICAJY2FzZSBQQ0lfRVBDX0lSUV9NU0k6DQo+ID4gIAkJcmV0
dXJuIGR3X3BjaWVfZXBfcmFpc2VfbXNpX2lycShlcCwgZnVuY19ubywgaW50ZXJydXB0X251bSk7
DQo+ID4gIAljYXNlIFBDSV9FUENfSVJRX01TSVg6DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1lcC5jIGIvZHJpdmVycy9wY2kvY29u
dHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWVwLmMNCj4gPiBpbmRleCAyMDViYmNjNmFmMjcu
LmE4MGI5ZmQwMzYzOCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3
Yy9wY2llLWRlc2lnbndhcmUtZXAuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
ZHdjL3BjaWUtZGVzaWdud2FyZS1lcC5jDQo+ID4gQEAgLTQ4MCwxNiArNDgwLDE2IEBAIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgcGNpX2VwY19vcHMgZXBjX29wcyA9IHsNCj4gPiAgCS5nZXRfZmVhdHVy
ZXMJCT0gZHdfcGNpZV9lcF9nZXRfZmVhdHVyZXMsDQo+ID4gIH07DQo+ID4NCj4gPiAtaW50IGR3
X3BjaWVfZXBfcmFpc2VfbGVnYWN5X2lycShzdHJ1Y3QgZHdfcGNpZV9lcCAqZXAsIHU4IGZ1bmNf
bm8pDQo+ID4gK2ludCBkd19wY2llX2VwX3JhaXNlX2ludHhfaXJxKHN0cnVjdCBkd19wY2llX2Vw
ICplcCwgdTggZnVuY19ubykNCj4gPiAgew0KPiA+ICAJc3RydWN0IGR3X3BjaWUgKnBjaSA9IHRv
X2R3X3BjaWVfZnJvbV9lcChlcCk7DQo+ID4gIAlzdHJ1Y3QgZGV2aWNlICpkZXYgPSBwY2ktPmRl
djsNCj4gPg0KPiA+IC0JZGV2X2VycihkZXYsICJFUCBjYW5ub3QgdHJpZ2dlciBsZWdhY3kgSVJR
c1xuIik7DQo+ID4gKwlkZXZfZXJyKGRldiwgIkVQIGNhbm5vdCB0cmlnZ2VyIElOVHggSVJRc1xu
Iik7DQo+ID4NCj4gPiAgCXJldHVybiAtRUlOVkFMOw0KPiA+ICB9DQo+ID4gLUVYUE9SVF9TWU1C
T0xfR1BMKGR3X3BjaWVfZXBfcmFpc2VfbGVnYWN5X2lycSk7DQo+ID4gK0VYUE9SVF9TWU1CT0xf
R1BMKGR3X3BjaWVfZXBfcmFpc2VfaW50eF9pcnEpOw0KPiA+DQo+ID4gIGludCBkd19wY2llX2Vw
X3JhaXNlX21zaV9pcnEoc3RydWN0IGR3X3BjaWVfZXAgKmVwLCB1OCBmdW5jX25vLA0KPiA+ICAJ
CQkgICAgIHU4IGludGVycnVwdF9udW0pDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1wbGF0LmMgYi9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtcGxhdC5jDQo+ID4gaW5kZXggZmMzYjAyOTQ5MjE4Li4y
Njg5ZmY3OTM5ZTQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2Mv
cGNpZS1kZXNpZ253YXJlLXBsYXQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
ZHdjL3BjaWUtZGVzaWdud2FyZS1wbGF0LmMNCj4gPiBAQCAtNDksNyArNDksNyBAQCBzdGF0aWMg
aW50IGR3X3BsYXRfcGNpZV9lcF9yYWlzZV9pcnEoc3RydWN0IGR3X3BjaWVfZXAgKmVwLCB1OCBm
dW5jX25vLA0KPiA+DQo+ID4gIAlzd2l0Y2ggKHR5cGUpIHsNCj4gPiAgCWNhc2UgUENJX0VQQ19J
UlFfSU5UWDoNCj4gPiAtCQlyZXR1cm4gZHdfcGNpZV9lcF9yYWlzZV9sZWdhY3lfaXJxKGVwLCBm
dW5jX25vKTsNCj4gPiArCQlyZXR1cm4gZHdfcGNpZV9lcF9yYWlzZV9pbnR4X2lycShlcCwgZnVu
Y19ubyk7DQo+ID4gIAljYXNlIFBDSV9FUENfSVJRX01TSToNCj4gPiAgCQlyZXR1cm4gZHdfcGNp
ZV9lcF9yYWlzZV9tc2lfaXJxKGVwLCBmdW5jX25vLCBpbnRlcnJ1cHRfbnVtKTsNCj4gPiAgCWNh
c2UgUENJX0VQQ19JUlFfTVNJWDoNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJv
bGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmggYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9w
Y2llLWRlc2lnbndhcmUuaA0KPiA+IGluZGV4IGFkYWQwZWE2MTc5OS4uOWFjZjZjNDBkMjUyIDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2Fy
ZS5oDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJl
LmgNCj4gPiBAQCAtNTUwLDcgKzU1MCw3IEBAIGludCBkd19wY2llX2VwX2luaXQoc3RydWN0IGR3
X3BjaWVfZXAgKmVwKTsNCj4gPiAgaW50IGR3X3BjaWVfZXBfaW5pdF9jb21wbGV0ZShzdHJ1Y3Qg
ZHdfcGNpZV9lcCAqZXApOw0KPiA+ICB2b2lkIGR3X3BjaWVfZXBfaW5pdF9ub3RpZnkoc3RydWN0
IGR3X3BjaWVfZXAgKmVwKTsNCj4gPiAgdm9pZCBkd19wY2llX2VwX2V4aXQoc3RydWN0IGR3X3Bj
aWVfZXAgKmVwKTsNCj4gPiAtaW50IGR3X3BjaWVfZXBfcmFpc2VfbGVnYWN5X2lycShzdHJ1Y3Qg
ZHdfcGNpZV9lcCAqZXAsIHU4IGZ1bmNfbm8pOw0KPiA+ICtpbnQgZHdfcGNpZV9lcF9yYWlzZV9p
bnR4X2lycShzdHJ1Y3QgZHdfcGNpZV9lcCAqZXAsIHU4IGZ1bmNfbm8pOw0KPiA+ICBpbnQgZHdf
cGNpZV9lcF9yYWlzZV9tc2lfaXJxKHN0cnVjdCBkd19wY2llX2VwICplcCwgdTggZnVuY19ubywN
Cj4gPiAgCQkJICAgICB1OCBpbnRlcnJ1cHRfbnVtKTsNCj4gPiAgaW50IGR3X3BjaWVfZXBfcmFp
c2VfbXNpeF9pcnEoc3RydWN0IGR3X3BjaWVfZXAgKmVwLCB1OCBmdW5jX25vLA0KPiA+IEBAIC01
ODMsNyArNTgzLDcgQEAgc3RhdGljIGlubGluZSB2b2lkIGR3X3BjaWVfZXBfZXhpdChzdHJ1Y3Qg
ZHdfcGNpZV9lcCAqZXApDQo+ID4gIHsNCj4gPiAgfQ0KPiA+DQo+ID4gLXN0YXRpYyBpbmxpbmUg
aW50IGR3X3BjaWVfZXBfcmFpc2VfbGVnYWN5X2lycShzdHJ1Y3QgZHdfcGNpZV9lcCAqZXAsIHU4
IGZ1bmNfbm8pDQo+ID4gK3N0YXRpYyBpbmxpbmUgaW50IGR3X3BjaWVfZXBfcmFpc2VfaW50eF9p
cnEoc3RydWN0IGR3X3BjaWVfZXAgKmVwLCB1OCBmdW5jX25vKQ0KPiA+ICB7DQo+ID4gIAlyZXR1
cm4gMDsNCj4gPiAgfQ0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3
Yy9wY2llLXFjb20tZXAuYyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtcWNvbS1l
cC5jDQo+ID4gaW5kZXggMDc3YWZjZTQ4ZDBiLi4zMDYxZTVlMTM0NzYgMTAwNjQ0DQo+ID4gLS0t
IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1xY29tLWVwLmMNCj4gPiArKysgYi9k
cml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLXFjb20tZXAuYw0KPiA+IEBAIC02NTksNyAr
NjU5LDcgQEAgc3RhdGljIGludCBxY29tX3BjaWVfZXBfcmFpc2VfaXJxKHN0cnVjdCBkd19wY2ll
X2VwICplcCwgdTggZnVuY19ubywNCj4gPg0KPiA+ICAJc3dpdGNoICh0eXBlKSB7DQo+ID4gIAlj
YXNlIFBDSV9FUENfSVJRX0lOVFg6DQo+ID4gLQkJcmV0dXJuIGR3X3BjaWVfZXBfcmFpc2VfbGVn
YWN5X2lycShlcCwgZnVuY19ubyk7DQo+ID4gKwkJcmV0dXJuIGR3X3BjaWVfZXBfcmFpc2VfaW50
eF9pcnEoZXAsIGZ1bmNfbm8pOw0KPiA+ICAJY2FzZSBQQ0lfRVBDX0lSUV9NU0k6DQo+ID4gIAkJ
cmV0dXJuIGR3X3BjaWVfZXBfcmFpc2VfbXNpX2lycShlcCwgZnVuY19ubywgaW50ZXJydXB0X251
bSk7DQo+ID4gIAlkZWZhdWx0Og0KPiA+IC0tDQo+ID4gMi4yNS4xDQo+ID4NCj4gDQo+IC0tDQo+
IOCuruCuo+Cuv+CuteCuo+CvjeCuo+CuqeCvjSDgrprgrqTgrr7grprgrr/grrXgrq7gr40NCg==
