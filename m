Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F575AC8BA
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 04:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbiIECOG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 4 Sep 2022 22:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiIECOE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 4 Sep 2022 22:14:04 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2051.outbound.protection.outlook.com [40.107.22.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3F424955;
        Sun,  4 Sep 2022 19:14:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQJlFrxe1TGFNLtRjNQ9rmLmMhIJYTGzdqA822/1PxQ/9OhYALGosnmn/FMVGpnE2WPp2RhRLKUMI8bpiAtd6jx85dhtPxNGHdfI1DnTHgWSJAiI+46D90B9mlUfV3V6B4lQuiZpOORXapbuGKgOXNn4N/DY0Qk7VTMIgOVkvRej++P9vyOz0noUYFM07A5ZqnBAPMJGFGAP/wrXZ54Uon4L8cRU11IR3VRQDC0lQocBp2gf7v4ztnMFvJUCWHyrq0RPgNti40S5FvC/7vX41H4hhK0ZnRZ0JuqXSSfFkBvbkZ/Fwr2HLx0m4W26HbvSy5ORxMFnKmO9uBS1LuMX5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1Twd8i9zILxInLgMr386AWa3DuciwUY+HyzGLklbEs=;
 b=mFmIN3EnMcSSKCBNmyKy5QxZjEKVgDB0CMYp0z8qnhrw72qEYuXIUaaHqg7Ld0+uEnE5Vn3R5MFKno3Afj7vpfJmdDIRnRKXGGldcGfPhV4WeItr2pTuBVkIBtSnDAPtGmg2yQvxrzLHwaMgsDEArfOHNVTsqzMYaJcvbdYd1mbIcPXveH/Bnat8lZZVGG/IZOGWkDGubH96mXGDIh6/jDEokt/JCGbKyDnOZsa5Zl/zL3ZayZaUv3VPJoMlSE4XMxgnhbCjX4rYQDXSlJqPYgehjiZLajIg+a8m2W2THrxKzCdDdDoa4qkzF04z+IkBtj7FkXv2t+JW6/l5W8P/8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1Twd8i9zILxInLgMr386AWa3DuciwUY+HyzGLklbEs=;
 b=T543/fxljjM57lTcDkABZC2Np1mGoEq9HRUjFYiI+NUnvXbscgy+hWlbAC0+iJXg8VjY91Ym+T5XqzIKGMF0MyHHf0IPAwI2hjQuv/pj8CeeqCSVjuLORQQcRaDY9Qcv8SB0BEFmsD1gei5uIBX8m/0hVb8rn+DiqlB7ya7IUF0=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PAXPR04MB8319.eurprd04.prod.outlook.com (2603:10a6:102:1c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.16; Mon, 5 Sep
 2022 02:14:00 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::8574:efa7:38c8:3c05]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::8574:efa7:38c8:3c05%5]) with mapi id 15.20.5588.018; Mon, 5 Sep 2022
 02:14:00 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v2] phy: freescale: imx8m-pcie: Fix the wrong order of
 phy_init() and phy_power_on()
Thread-Topic: [PATCH v2] phy: freescale: imx8m-pcie: Fix the wrong order of
 phy_init() and phy_power_on()
Thread-Index: AQHYvQkyuEqLoGGxhkmFgmcnusCb6q3MYiWAgAO628A=
Date:   Mon, 5 Sep 2022 02:14:00 +0000
Message-ID: <AS8PR04MB86764686EC7F5F4D5BA55B6E8C7F9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1661928956-12727-1-git-send-email-hongxing.zhu@nxp.com>
 <20220902170449.GA354728@bhelgaas>
In-Reply-To: <20220902170449.GA354728@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21a2adea-ad06-4dd3-cfd9-08da8ee44c32
x-ms-traffictypediagnostic: PAXPR04MB8319:EE_
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GVTSFKYYs/1RfyaBG9/YranfDtIW4UxdF2qlJdkd23Q6DzqPJMtCIFMkkNRGaBgFYOnQxrdK1UmzUKlZ28X2Kcb0A3/1ERHX8WSgWqEXfy/Xg1eu/cs0BFD6TIchaaR4Oma4ybv1Fpqu7jaDmlZ+HFasLgIYJRu1Gx2xpBNdZAWUeUv5rQMOi67Xs1KfwZ3iazYIjddPbAywlU8hKtpGNqEJkQi5kwKXj0WfxOo9ezDa2Q02ApG4I72NR0D7yLRe7Tdlvmw7X84zRO0UUNhT6sjU2nHbd+AvqZ3DmtGm7wa7CCMzaF4/KsSkGBZjVAzNlPOpwCwmAMi3ETe4dExDrIMvJmm8vHVrBrWM+4i9RO0F5xbOv5sz4P48wvQpO6FvwYBqUoDNfFmCnZv1HYWOStkXSaHUs6qLCfPz7bBagkPjGRSOxelCP0dnlaPKEEfzLi/U8ASbCLm/o9sZi7eDv7Ok8XPaOavun6nFuNICB4123Fd2qd/jsOcAHlQlVnHdZjgOva65k13lnCR0LVO376YnWmaWSAjg1fgLNDUdiOIWxBfUabwou8lRzni7y+LrVRs13j+x2EaoAdB4Rm4faO4omS522L2uUebAjzw67dPO+vsINNGCHwO3s6lHNIlMngt7Ccc4tdMxbdIHBdpA7o0dpFULbmzpVtPv1jAsloeaLrgNylTdYVWCsR1qHgqrZ++CqboVT7gTN4GxIVXt5TP3Kqs0sLAa44TojDq1KTBpbBfZI8gHxGnM/x65hT2GOPSBWj1UQ0lFREaJLLG599sWPi0Ca4FioOW4gjgWf95/hFJYcNFaIsTRQXGNkeQc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(186003)(83380400001)(9686003)(55016003)(5660300002)(7416002)(2906002)(8936002)(52536014)(7696005)(53546011)(44832011)(33656002)(86362001)(26005)(966005)(6506007)(71200400001)(478600001)(41300700001)(38100700002)(122000001)(38070700005)(54906003)(66476007)(4326008)(8676002)(64756008)(66446008)(66946007)(76116006)(316002)(45080400002)(66556008)(6916009)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WU52OFExbndxbGJDbS9nb0E2bzZaTXRTOHc1bXQwYTFtMnNtRUo3cDNqcWRw?=
 =?utf-8?B?dnNmMzNlUjlFeDJUcXEyeHhDMlRRcmtZdlI5VW9CVDlNREtZbWxsVXg3Q1k4?=
 =?utf-8?B?TE9zZWZJdlVVL3BmMUpGdkhxMWxmSzlEeWxQSE5KTVdWaEV2c3drT0NzNVdt?=
 =?utf-8?B?dm9UcHNoVkJDNm5HUXJYQWpqQS9ncVNIaTFGUjU2dWpmeUl4ZXZxMzF3WjJP?=
 =?utf-8?B?ZFVadG9WQU41d3dEai9lZXR3RHpWQktGNENndnk0Ri82MjZ6aGd2VlB2YWFq?=
 =?utf-8?B?LzhRaStXOEIzYkRMdzV2YXZRMjRkN3JDSDRNcm4zbUdYZnRqdkQ4NUlFSXJ0?=
 =?utf-8?B?Uk42Z3cvSlpsOXFlWnJaY1dWWVdvU0VsZExoNGM5ZkJVU3BjWnp0c3dqWE10?=
 =?utf-8?B?Q3hpbnZzYVc1RHBYeVpHTlpWL1RjVVpXYTVaRGR0M3BZd1VHWmI0ZlBZMnNO?=
 =?utf-8?B?S0FJYjYvc0JyTjBKQkVLZUZzdFB4a1hrYWVPRFBPZEh2UHlSZ29qZWtQandw?=
 =?utf-8?B?MTZmVUlFS2QxejlKV3BjSXZwdW9QNzBKTjh2cmQrTW55cHliQm5YTFdPeTJX?=
 =?utf-8?B?VjNmck4vQ0FsQUZQeVZQTHI4NnBhS1krbzBSNmp6QUZTV2hsMXVDZTJvNzVk?=
 =?utf-8?B?K013USsxWDcyWHZPOEx1SG8rSlN6SDFRWnZ6cTMxMXB1bGxxeS9VL3Z1MWF1?=
 =?utf-8?B?UjZPWjdpVzJvWnBWOEYxcCt0NGdPMDJBSnlQZFFpOE1oWUt3L09vQ3pNd3JV?=
 =?utf-8?B?MXZNME9xdThmUHlOSmZqamRxYVUzeGJhZzc0OFQ0TWZlNC9nUnQ0RW1zdm10?=
 =?utf-8?B?NkNKRmR4Zm9vQ3NjM216a2NDWnFIWE5BUkRWdmZneWJzejVkSVBRZlU2TTNX?=
 =?utf-8?B?UUpENTFqV2NDTVhISWVCOXcxRXU0eWR3clBVQ3dJdVdmc1dJZExFUTZYWWh3?=
 =?utf-8?B?Ykxnei81RWVJYkw3SHErSDVwY29IM3NlZGVET081U3M0bWNuS1dlN3NCdS90?=
 =?utf-8?B?eG52ZXVmeEtnVDJ2Zk5PellOK3REVktDanFJZGxOa1RZbWZHZjdHeTQxWDk4?=
 =?utf-8?B?MW5DZHcrUnBVM3BXcDFTWS90ZEhxbWxQdmRpc294MklVbDBGMFJ4SVhVK0cy?=
 =?utf-8?B?cCsraGVINzJtN3g5Vkh0REpJT1VaL3Y0aHNLeENFMVpIWE42T0pwLzcrUlRZ?=
 =?utf-8?B?bmdEYXE5YnVwc0hjbHpwL040c0Y1TVM2OGNSYmdVT0ZMRzV5Y0dUeFNLTFpP?=
 =?utf-8?B?U0ZDQWQ0NW5tcnJvbzBZTG1sS3hqUDU5M3ViTVdrNk50bTJJM2tRZDBzeDc2?=
 =?utf-8?B?YnFQSmVONmpmU3NlV2tDT3NOVUVPQnZrUTJlS3Y2ZnNXNW5RTmFGSkZsUXpT?=
 =?utf-8?B?eUhzZWE1eUxKUFFJNERBMjZJRHd5c2U1NUM3Y0JGUlQvQUlXN0RUTE0xdzFC?=
 =?utf-8?B?dW15UWFVTW9zN3NsTFN1aVRrK0VNelkrZStOYy81end0RlQxS3RkYkNEYlJa?=
 =?utf-8?B?V0xFUzY2SGxnNkFnaDFFMzh4Y3JWR0tzcEM1eWlHL2FVMzVsYmNPUzVoMFM4?=
 =?utf-8?B?ajhYNExPa1djYWN6YjhQdXlCcmtQV0hHQmltL1hNMUdiOEhXSTVYbEU1M3pN?=
 =?utf-8?B?eXlrM1FMSEZTZjBJUVdoa1dMV0hpWWF6OWtMWTEzdEpaWTRyQmVTb0dEbFF6?=
 =?utf-8?B?VjRweXNTc1owK2ZpdGJNUnF6ZmtMNGlTdVBiT29yUXB5R09Pa3R6YStKT3Ay?=
 =?utf-8?B?clJpR1dEYitabyt0dFlFNkszczlBNDhGYXc2S1FIQWlwODBSUjgxVGpzTTRI?=
 =?utf-8?B?SThDZ3hRY2V4WVdWUStLVFhpK1N5VXBNTVhkdlJKREtSdmprVkl1SU1xdDBs?=
 =?utf-8?B?MG9qL21SSjF0V2J6aGZhZDhWUTRYWHBIREljalNyc2prbWdNVzJ6TDVBV2Ri?=
 =?utf-8?B?bXZ3M0pnYWV4NWo4SlArOXBZaWlWdjNjNG04Qkx6dUErRTRoUGdJMUhRK1Rz?=
 =?utf-8?B?VnRTekNYeDdhVlBZRld1dTZiQ05XMWZ0bHA3N2ZPQWlrWDhLMEh6YWRYV0Jn?=
 =?utf-8?B?cHRrUGtCdWh5dUg5OXY1bU1BWStwQWp0akJ0T2tPc3R0Z2dXRDVETmpyNXVT?=
 =?utf-8?Q?5N7fLiiNKl623HtiQEMAKurTH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a2adea-ad06-4dd3-cfd9-08da8ee44c32
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2022 02:14:00.8276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1UE69yRvubYZNmPVIpYcajbB+09JU7zfpcajNDhIoKoTyguC7Si0YIhtXFbhAtCFg/tmOcpnM2ND2/8z/Z5/Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8319
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
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjLlubQ55pyIM+aXpSAxOjA1DQo+IFRvOiBIb25n
eGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiBDYzogYS5mYXRvdW1AcGVuZ3V0cm9u
aXguZGU7IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+IGxv
cmVuem8ucGllcmFsaXNpQGFybS5jb207IHZrb3VsQGtlcm5lbC5vcmc7IE1hcmNlbCBaaXN3aWxl
cg0KPiA8bWFyY2VsLnppc3dpbGVyQHRvcmFkZXguY29tPjsga2lzaG9uQHRpLmNvbTsgbGludXgt
cGh5QGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBkbC1saW51eC1pbXgNCj4gPGxpbnV4
LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBwaHk6IGZyZWVzY2FsZTog
aW14OG0tcGNpZTogRml4IHRoZSB3cm9uZyBvcmRlciBvZg0KPiBwaHlfaW5pdCgpIGFuZCBwaHlf
cG93ZXJfb24oKQ0KPiANCj4gT24gV2VkLCBBdWcgMzEsIDIwMjIgYXQgMDI6NTU6NTZQTSArMDgw
MCwgUmljaGFyZCBaaHUgd3JvdGU6DQo+ID4gUmVmZXIgdG8gcGh5X2NvcmUgZHJpdmVyLCBwaHlf
aW5pdCgpIG11c3QgYmUgY2FsbGVkIGJlZm9yZSBwaHlfcG93ZXJfb24oKS4NCj4gPiBGaXggdGhl
IHdyb25nIG9yZGVyIG9mIHBoeV9pbml0KCkgYW5kIHBoeV9wb3dlcl9vbigpIGhlcmUuDQo+IA0K
PiA+IFNxdWFzaCB0aGUgY2hhbmdlcyBpbnRvIG9uZSBwYXRjaCB0byBhdm9pZCB0aGUgcG9zc2li
bGUgYmktc2VjdGlvbiBob2xlLg0KPiANCj4gQXZvaWRpbmcgYmlzZWN0aW9uIGhvbGVzIGdvZXMg
d2l0aG91dCBzYXlpbmcsIHNvIEkgZG9uJ3QgdGhpbmsgd2UgbmVlZCB0byBldmVuDQo+IG1lbnRp
b24gaXQgOykNCkhpIEJqb3JuOg0KVW5kZXJzdG9vZCDwn5iKLiBUaGFua3MgZm9yIHlvdXIga2lu
ZGx5IGhlbHAgb24gdGhpcyBmaXguDQpGb3IgZWFzZSBvZiBtZXJnaW5nLCBJIHdvdWxkIHJlbW92
ZSB0aGF0IGxpbmUsIGFuZCByZS1zZW5kIHRoZSB2MyB3aXRoIFZpbm9kJ3MNCiBBQ0sgYWRkZWQu
DQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCg0KPiANCj4gPiBGaXhlczogMWFhOTdiMDAy
MjU4ICgicGh5OiBmcmVlc2NhbGU6IHBjaWU6IEluaXRpYWxpemUgdGhlIGlteDggcGNpZQ0KPiA+
IHN0YW5kYWxvbmUgcGh5IGRyaXZlciIpDQo+ID4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBaaHUg
PGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+IFRlc3RlZC1ieTogQWxleGFuZGVyIFN0ZWluIDxh
bGV4YW5kZXIuc3RlaW5AZXcudHEtZ3JvdXAuY29tPg0KPiANCj4gSSBwcm9wb3NlIG1lcmdpbmcg
dGhpcyB2aWEgUENJLCBzaW5jZSBJIHN1c3BlY3QgcGNpLWlteDYuYyBpcyBtb3JlIGFjdGl2ZSB0
aGFuDQo+IHBoeS1mc2wtaW14OG0tcGNpZS5jLg0KPiANCj4gVmlub2QsIGlmIHlvdSBhZ3JlZSwg
SSdtIHN1cmUgTG9yZW56byB3aWxsIGxvb2sgZm9yIHlvdXIgYWNrLg0KPiANCj4gPiAtLS0NCj4g
PiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYyAgICAgIHwgNiArKystLS0N
Cj4gPiAgZHJpdmVycy9waHkvZnJlZXNjYWxlL3BoeS1mc2wtaW14OG0tcGNpZS5jIHwgOCArKysr
LS0tLQ0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMo
LSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2kt
aW14Ni5jDQo+ID4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4g
aW5kZXggNmU1ZGViZGJjNTViLi5iNWYwZGU0NTVhN2IgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiBAQCAtOTM1LDcgKzkzNSw3IEBAIHN0YXRpYyBp
bnQgaW14Nl9wY2llX2hvc3RfaW5pdChzdHJ1Y3QgZHdfcGNpZV9ycA0KPiAqcHApDQo+ID4gIAl9
DQo+ID4NCj4gPiAgCWlmIChpbXg2X3BjaWUtPnBoeSkgew0KPiA+IC0JCXJldCA9IHBoeV9wb3dl
cl9vbihpbXg2X3BjaWUtPnBoeSk7DQo+ID4gKwkJcmV0ID0gcGh5X2luaXQoaW14Nl9wY2llLT5w
aHkpOw0KPiA+ICAJCWlmIChyZXQpIHsNCj4gPiAgCQkJZGV2X2VycihkZXYsICJwY2llIFBIWSBw
b3dlciB1cCBmYWlsZWRcbiIpOw0KPiA+ICAJCQlnb3RvIGVycl9jbGtfZGlzYWJsZTsNCj4gPiBA
QCAtOTQ5LDcgKzk0OSw3IEBAIHN0YXRpYyBpbnQgaW14Nl9wY2llX2hvc3RfaW5pdChzdHJ1Y3Qg
ZHdfcGNpZV9ycA0KPiAqcHApDQo+ID4gIAl9DQo+ID4NCj4gPiAgCWlmIChpbXg2X3BjaWUtPnBo
eSkgew0KPiA+IC0JCXJldCA9IHBoeV9pbml0KGlteDZfcGNpZS0+cGh5KTsNCj4gPiArCQlyZXQg
PSBwaHlfcG93ZXJfb24oaW14Nl9wY2llLT5waHkpOw0KPiA+ICAJCWlmIChyZXQpIHsNCj4gPiAg
CQkJZGV2X2VycihkZXYsICJ3YWl0aW5nIGZvciBQSFkgcmVhZHkgdGltZW91dCFcbiIpOw0KPiA+
ICAJCQlnb3RvIGVycl9waHlfb2ZmOw0KPiA+IEBAIC05NjEsNyArOTYxLDcgQEAgc3RhdGljIGlu
dCBpbXg2X3BjaWVfaG9zdF9pbml0KHN0cnVjdCBkd19wY2llX3JwDQo+ID4gKnBwKQ0KPiA+DQo+
ID4gIGVycl9waHlfb2ZmOg0KPiA+ICAJaWYgKGlteDZfcGNpZS0+cGh5KQ0KPiA+IC0JCXBoeV9w
b3dlcl9vZmYoaW14Nl9wY2llLT5waHkpOw0KPiA+ICsJCXBoeV9leGl0KGlteDZfcGNpZS0+cGh5
KTsNCj4gPiAgZXJyX2Nsa19kaXNhYmxlOg0KPiA+ICAJaW14Nl9wY2llX2Nsa19kaXNhYmxlKGlt
eDZfcGNpZSk7DQo+ID4gIGVycl9yZWdfZGlzYWJsZToNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9waHkvZnJlZXNjYWxlL3BoeS1mc2wtaW14OG0tcGNpZS5jDQo+ID4gYi9kcml2ZXJzL3BoeS9m
cmVlc2NhbGUvcGh5LWZzbC1pbXg4bS1wY2llLmMNCj4gPiBpbmRleCBhZDdkMmVkZmM0MTQuLmM5
MzI4NjQ4M2I0MiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BoeS9mcmVlc2NhbGUvcGh5LWZz
bC1pbXg4bS1wY2llLmMNCj4gPiArKysgYi9kcml2ZXJzL3BoeS9mcmVlc2NhbGUvcGh5LWZzbC1p
bXg4bS1wY2llLmMNCj4gPiBAQCAtNTksNyArNTksNyBAQCBzdHJ1Y3QgaW14OF9wY2llX3BoeSB7
DQo+ID4gIAlib29sCQkJY2xrcmVxX3VudXNlZDsNCj4gPiAgfTsNCj4gPg0KPiA+IC1zdGF0aWMg
aW50IGlteDhfcGNpZV9waHlfaW5pdChzdHJ1Y3QgcGh5ICpwaHkpDQo+ID4gK3N0YXRpYyBpbnQg
aW14OF9wY2llX3BoeV9wb3dlcl9vbihzdHJ1Y3QgcGh5ICpwaHkpDQo+ID4gIHsNCj4gPiAgCWlu
dCByZXQ7DQo+ID4gIAl1MzIgdmFsLCBwYWRfbW9kZTsNCj4gPiBAQCAtMTM3LDE0ICsxMzcsMTQg
QEAgc3RhdGljIGludCBpbXg4X3BjaWVfcGh5X2luaXQoc3RydWN0IHBoeSAqcGh5KQ0KPiA+ICAJ
cmV0dXJuIHJldDsNCj4gPiAgfQ0KPiA+DQo+ID4gLXN0YXRpYyBpbnQgaW14OF9wY2llX3BoeV9w
b3dlcl9vbihzdHJ1Y3QgcGh5ICpwaHkpDQo+ID4gK3N0YXRpYyBpbnQgaW14OF9wY2llX3BoeV9p
bml0KHN0cnVjdCBwaHkgKnBoeSkNCj4gPiAgew0KPiA+ICAJc3RydWN0IGlteDhfcGNpZV9waHkg
KmlteDhfcGh5ID0gcGh5X2dldF9kcnZkYXRhKHBoeSk7DQo+ID4NCj4gPiAgCXJldHVybiBjbGtf
cHJlcGFyZV9lbmFibGUoaW14OF9waHktPmNsayk7DQo+ID4gIH0NCj4gPg0KPiA+IC1zdGF0aWMg
aW50IGlteDhfcGNpZV9waHlfcG93ZXJfb2ZmKHN0cnVjdCBwaHkgKnBoeSkNCj4gPiArc3RhdGlj
IGludCBpbXg4X3BjaWVfcGh5X2V4aXQoc3RydWN0IHBoeSAqcGh5KQ0KPiA+ICB7DQo+ID4gIAlz
dHJ1Y3QgaW14OF9wY2llX3BoeSAqaW14OF9waHkgPSBwaHlfZ2V0X2RydmRhdGEocGh5KTsNCj4g
Pg0KPiA+IEBAIC0xNTUsOCArMTU1LDggQEAgc3RhdGljIGludCBpbXg4X3BjaWVfcGh5X3Bvd2Vy
X29mZihzdHJ1Y3QgcGh5DQo+ID4gKnBoeSkNCj4gPg0KPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0
IHBoeV9vcHMgaW14OF9wY2llX3BoeV9vcHMgPSB7DQo+ID4gIAkuaW5pdAkJPSBpbXg4X3BjaWVf
cGh5X2luaXQsDQo+ID4gKwkuZXhpdAkJPSBpbXg4X3BjaWVfcGh5X2V4aXQsDQo+ID4gIAkucG93
ZXJfb24JPSBpbXg4X3BjaWVfcGh5X3Bvd2VyX29uLA0KPiA+IC0JLnBvd2VyX29mZgk9IGlteDhf
cGNpZV9waHlfcG93ZXJfb2ZmLA0KPiA+ICAJLm93bmVyCQk9IFRISVNfTU9EVUxFLA0KPiA+ICB9
Ow0KPiA+DQo+ID4gLS0NCj4gPiAyLjI1LjENCj4gPg0KPiA+DQo+ID4gLS0NCj4gPiBsaW51eC1w
aHkgbWFpbGluZyBsaXN0DQo+ID4gbGludXgtcGh5QGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gPiBo
dHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMl
M0ElMkYlMkZsaXN0DQo+ID4NCj4gcy5pbmZyYWRlYWQub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZv
JTJGbGludXgtcGh5JmFtcDtkYXRhPTA1JTdDMDElN0MNCj4gaG8NCj4gPg0KPiBuZ3hpbmcuemh1
JTQwbnhwLmNvbSU3Q2I4MTIwMWM4OTk0YzRlMmI4NzEyMDhkYThkMDU0MWExJTdDNjg2ZWENCj4g
MWQzYmMyYg0KPiA+DQo+IDRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2Mzc5NzczNTA5
NzIwMzAyNjUlN0NVbmtub3duJQ0KPiA3Q1RXRnBiR1pzDQo+ID4NCj4gYjNkOGV5SldJam9pTUM0
d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMA0KPiAl
M0QNCj4gPiAlN0MzMDAwJTdDJTdDJTdDJmFtcDtzZGF0YT1nTVV6aGZsUXVFOTJORmxtQVAzR0JL
aWpqdjZsaFFFWnh1DQo+IHh1WUZQZm9zdw0KPiA+ICUzRCZhbXA7cmVzZXJ2ZWQ9MA0K
