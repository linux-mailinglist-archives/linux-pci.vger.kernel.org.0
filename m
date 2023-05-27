Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BFC71322B
	for <lists+linux-pci@lfdr.de>; Sat, 27 May 2023 05:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjE0DeT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 May 2023 23:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjE0DeS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 May 2023 23:34:18 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2052.outbound.protection.outlook.com [40.107.7.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C633E4;
        Fri, 26 May 2023 20:34:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dcRbi0vmZ75sV/F0jFAcjmBs8Eaqw4CGWv3aw1SVavHWX7h+0Y8hzR1B4wGzMI4aooTaeAVYPc+IZ/5Ipdi8XvzuZyX99pDDvITw/g8+Mp+6YkdOpf/SGnpLoIFc2WpxVSt+BvR3yTQPx9/T27GWwUZkhk7zEJyTK2Th4Q8vRVqodwxn4CtJVePzsYI8uQkvvo3zoExM3TaMwI5JO36FG366FYTUhgO+wTKhz7+GZrDAAoF6ZtLxexWT73sE2PbxFhUSwdhXjfs6lv/DIWmM/kYzmsrdU7luolcfPd+H1FIzmfUqNdbVPBNjVv+pYA1FT6nRNZGqASTS7FKlN+eWww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TxAPEbIyuE0VUOUw++LWAtQZWfVKjCZx+7QzYEhKMkI=;
 b=nTxjW2Yabk7ePOVfG2Nzx7v5NgmWuLam6qOB1yFyjmH06ACPtvXsn0UC774L69hzlx+yxHX91atrOhQeNm1wHjCYLklsVeMq9hNYGgjtZ2EnTn8sSeMqEv3SEY0SS5LCPo6VnpvNeyRG/iHyZJjJG6y6lgDbQ9xjK747WHoFJ5jB3BCUnAUdh8LyK5UfHb9MMoy/TilyXkbTEeFHt/QqBIs+QKNvTWMB81VLFvdh4sxPAUZm0Q/1ZohNmysWFEV0EHgxNWKMYP/lnfLJDzy4L7zSFX82BdpCGhAU2EBgc3k6eWOD+W5dWaDKMgpTWbMoMSkPwSoceEptA1A8sH0KWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TxAPEbIyuE0VUOUw++LWAtQZWfVKjCZx+7QzYEhKMkI=;
 b=M0XNs8iFQHL1BVt2bHziFB7+6/s5hz28JXEUHnNuhIk9eWxeblO2sfprfKlUHG7g/r+Djo1oU0YbEhpwM+zfIRgrntJ775/uLepwzOHAKWSU5Jcd6Fk73F3hooDH/N7ZE7ZWj7fXRRVqCe0arS7SQ9irh+4RLQkYzbx2necz7aA=
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM9PR04MB7604.eurprd04.prod.outlook.com (2603:10a6:20b:287::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.19; Sat, 27 May
 2023 03:34:11 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%6]) with mapi id 15.20.6433.018; Sat, 27 May 2023
 03:34:11 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
Subject: RE: [EXT] [PATCH v4 4/7] PCI: endpoint: Add BME notifier support
Thread-Topic: [EXT] [PATCH v4 4/7] PCI: endpoint: Add BME notifier support
Thread-Index: AQHZimA1/HTZGCCvNkeTHIvD7zgRf69h5tGggAuIVQCAABOnAA==
Date:   Sat, 27 May 2023 03:34:11 +0000
Message-ID: <AM6PR04MB4838F01DC8E0A94ACCBE08FE88449@AM6PR04MB4838.eurprd04.prod.outlook.com>
References: <20230519144215.25167-1-manivannan.sadhasivam@linaro.org>
 <20230519144215.25167-5-manivannan.sadhasivam@linaro.org>
 <AM6PR04MB483845CDCBDF5962C3F9D8F2887C9@AM6PR04MB4838.eurprd04.prod.outlook.com>
 <20230527022132.GA2814@thinkpad>
In-Reply-To: <20230527022132.GA2814@thinkpad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB4838:EE_|AM9PR04MB7604:EE_
x-ms-office365-filtering-correlation-id: 37c12415-b883-48a5-9659-08db5e633c7d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pOFbmWxadupbTyYBcH8OMsnDe/hwbutBKICqal6XdNk+f/cDpRvSqJaL9RqgzDsGGfSuSxScImEkbWA76f6HoIcdCwMxz1n99Rx+Ni+is0FhAp5Lt44W5iY05JRzBblj3F1ed2uxUa/XVWinqzX9WvN6CfN2BuWVxiaoI345nriZ2acgq9ikASesNJFxyJPy/rBR0UQO7HjHA+SLK6iQuJkRHa/F90C0JRV8fH9RF/nBNEgWeFu/77mHYuvlQQ3BahLmYUZfRnb8h4PVuvvyuTqk1OfQnc/9d71GvbXl3fueEih2mMWvrVZ4GteH/oS0VaDMaoz2CW0UyrQx4yt3FElmqqu/Hmtw4DptmZ2BohMsy3HQbk7iMww8LO3CS9GXZMBo5VEuUb89TgiSJHwXG428wS813efXLF4ryo9QqYXmkohGyc4vCJ1wgCiock8dDx8Q10ljp370B2qIhQbWHL3BFrphE6X7NsWWbE89nHsSM/BV7aENEZw+p0opfThVzR+8And9AV70VQHmCMKMM4MmGX781oVT44e1bWiao7/qM7MkN7CKP1tUes335lbFZbgBQ0ZQEbB+W+JowH0gqo8GYjvXu2D0IYOzkgya7Z8vd3Jj+fGy5KcMdrpfh1wJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(451199021)(66899021)(66556008)(66476007)(66446008)(64756008)(6916009)(478600001)(76116006)(4326008)(66946007)(54906003)(33656002)(55016003)(186003)(55236004)(9686003)(6506007)(122000001)(38100700002)(83380400001)(8936002)(8676002)(71200400001)(7696005)(316002)(86362001)(38070700005)(4744005)(2906002)(5660300002)(52536014)(41300700001)(44832011)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wnl5YWlRcitYTGcveHVFTXlGWWVFeUJVU1BET2lnNXJVejlDd3BRTUdUbjlk?=
 =?utf-8?B?YXFTQjJmQ1lVeDVvdHhWU3hPYnhKbWU2SytWU2pUU2FCZmxvTk8rRGFGWEVR?=
 =?utf-8?B?MEpVbFc0VUtyZG5VbFRKNml3R1FzZ2E4OGJROEVYaE5zR0hoU2lsZVpseldQ?=
 =?utf-8?B?Qjh3b2ZBYnl6NUJjQ1BpdEt4ZXVXdS8rQ21RcFN6T0lLVGRnT2RiTGFRWjFs?=
 =?utf-8?B?Zk0ySVMyaDluOFNCYmxXVVY3bjMvNmtrY1o2RE5YZ3dxYkFPbWd1Z2JUU3JH?=
 =?utf-8?B?SkkrV08reFVxSGxEQkpIYktzQjcrQWI5TzduMDU3OG1xZ2xSNTI1Q1Qwdnh3?=
 =?utf-8?B?aERucWJSWHlaSVI4dE53RERyS2tFVERSY2xLSVg5NjdmUEFock1DYmQ0SmVm?=
 =?utf-8?B?a1pjTEdTY3o1SlcyL3o4VGNzZmNzVXFiMlY1M3UxSDlwZDF2MmVKcUQ4eFN0?=
 =?utf-8?B?ZkNva3pwSDU2MDNMRlBSb0JZckxwSDE1dTBtSndDR2VoSEQ4UWtDQjRJVlgy?=
 =?utf-8?B?MEo0VXl6TWNNR0F1YWRYL1MyNHcvRjlRMjVIS3d2QXZMVE9ITmNQdlNabFFv?=
 =?utf-8?B?Vnk0cnVYY2s5bys1ZmR5cnpSZDVLbHpETzNkRkg4eVYxMi9QQkc0a1lSMmhT?=
 =?utf-8?B?bWdJaEY1MG1pbHUwUzhXRVpENTVpVlZ6WXgvdUxNYkU5SWJUVEkreHRRV1Rz?=
 =?utf-8?B?Zi9QSFU2VzJOS2U4TEttSkJJYnNNRjg1WW5yL3ZEdEJIVTVpUlptNE44NGti?=
 =?utf-8?B?NTAreFFGK0cyKytDMi8ycnFXemZ0TWkyd2o1ZnhrSU85dkU2NVh1bkpEZ3g5?=
 =?utf-8?B?dXMzb1BLcmhDT0pZZU5DcEVid3Jycy8vTjZFZ09KWC9PczRSWFVCREgyaTAv?=
 =?utf-8?B?R01zMDNRWjIxbnhod0I1RTBrYTdFY1NzbVBGcjV4UHRCVEc0NFNXUjYrZTIv?=
 =?utf-8?B?dVU4UWVrbjJMdXBHb2FOc1B6TDY1K2tlNTBrbXBHNEwrYTZ6YnR0T2I2OTV6?=
 =?utf-8?B?ZkVNUUpCMEc0UDErdzhvaDdNck9aNXJmc3lQcXRKb0NkbW0rc05KcDZxbTZQ?=
 =?utf-8?B?T0VxR0RvdTBTR3JEcC9qb0NDV3M2NzV0Z0VsK2o5TlRQdmozaDNUKy9rQ1cr?=
 =?utf-8?B?SFZQa2cvTll0MkpndEZESFZmb2ZpS3p4RldzNVRaazAwL1pBNFdtRU1iTUJM?=
 =?utf-8?B?UDJUaVk2bktzVDQ1ZXhRTWJKYWwrUHNMN2RDK01FSHJyR3VDZzRjVC9WMGhh?=
 =?utf-8?B?bFBkZ0Y1WjhxMVROUUNSY0t0T1ZxblF0S29pVm9ZQklTNlBYak51cXoxM2lQ?=
 =?utf-8?B?b0s2U1NKa2VVeGQraC8xaE96QzFqV1ZmdlExZGR4UENEeGVTZW1BZzUzbEhj?=
 =?utf-8?B?SFNQQjFoWjIxQTNsWXVJVElZN09yYmlCS2RFUUhnSmRkVjZDR3Nod0hUSUxJ?=
 =?utf-8?B?R3UxSGdFUENsTkpLYmlyMndkb3EzTktReGFVamRMcVZwazkrZTVZdmlSZ3VB?=
 =?utf-8?B?WFN0Q3NnaHpiRzdTRTVpTEZJdDUrc1MySlIrN2FDUVMzbTRETWV1M2g4K3hj?=
 =?utf-8?B?dCtkRXlZdmYzWHhTd01YQ0I3eGQxdzhYUE9ISFlmTWszRU8yZnBjVkMya0Nj?=
 =?utf-8?B?cjVXeHQxWUZyejdEOTBzOGZDWEYzaFYySmZzc2xTYUdvRk85aEtLN29ocjE2?=
 =?utf-8?B?UlBkM1JibTB2TkNoRnVKV1pDU09PbHY3NXIzYmE3RUs0TFlCS3V6bjVVblZl?=
 =?utf-8?B?L0hqd1NVTHlyMkx3c2tsUEE0bXFaVGFMZ052Y2ZEL045QUtVOEF1ZXhEemIv?=
 =?utf-8?B?VjNmc0VwQVZxT3hnMWRHbFh5YmtWME5VZ1BrWUVPUi8vcldDM1JDaG1OQ3hJ?=
 =?utf-8?B?ck1KelBJMS9wK3hqWnFiR2NEbmNIWTYvczFFdE4xUm9lT3VhSytmWW5mcGRh?=
 =?utf-8?B?NzEyRXNWc2VOdHM0RHJYSGVhNnJ5clg2cTFFVlJmT1ZpdUJEcUJjMVpyRzFO?=
 =?utf-8?B?enBHcjVJUVptYTdzc0dUYW94djMxdlhoY0MyQlhhckVUeC9mNmlUMW9MMGdx?=
 =?utf-8?B?cGRSNUlYV3UyMndWNXJrUlcyR3oyd29vMzFDbzVvWkxocVkyMlR4YmlRM2d3?=
 =?utf-8?Q?E2Y0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c12415-b883-48a5-9659-08db5e633c7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2023 03:34:11.2238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NSO0aFy8fbFw+OzmuN14yr4+7GvutN93HLnnTlhWw8ffHyk1LnqYf2cPqdogLXSuaJadwTEpzx//X4Zaw/1m5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7604
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiA+DQo+ID4gQ2FuIHdlIGNvbnNpZGVyIGNvbnNvbGlkYXRlIHRoZXNlIG5vdGlmaWNhdGlvbiB0
byBvbmUgZnVuY3Rpb24gYW5kDQo+IGRpc3Rpbmd1aXNoZWQgYnkNCj4gPiBFVkVOVF9JRCBpbiBm
dXR1cmU/DQo+ID4NCj4gDQo+IE15IHByZWZlcmVuY2UgaXMgdG8ga2VlcCBhIHNlcGFyYXRlIGNh
bGxiYWNrIGZvciBlYWNoIGV2ZW50IGFzIGl0IG1ha2VzIHRoZQ0KPiBjb2RlDQo+IGxvb2sgYmV0
dGVyIGluc3RlYWQgb2YgY2x1YmJpbmcgZXZlcnl0aGluZyBpbiBhIHNpbmdsZSBjYWxsYmFjayBz
ZXBhcmF0ZWQgYnkgYQ0KPiBzd2l0Y2ggY2FzZS4NCj4gDQoNCk9rYXksIHRoYXQgaXMgbm90IGJp
ZyBkZWFsLiBJIGhvcGUgdGhlc2UgY2FuIGJlIG1lcmdlZCBpbnRvIHBjaSB0cmVlIHNvb24uIA0K
U28gSSBjYW4gYWRkIG1vcmUgbm90aWZpY2F0aW9uIGF0IGxheWVyc2NhcGUgcGxhdGZvcm0uDQoN
Cj4gLSBNYW5pDQo+IA0KPiA+IEJlc3QgcmVnYXJkcw0KPiA+IEZyYW5rIExpDQo+ID4NCj4gPiA+
ICB9Ow0KPiA+ID4NCj4gPiA+ICAvKioNCj4gPiA+IC0tDQo+ID4gPiAyLjI1LjENCj4gPg0KPiAN
Cj4gLS0NCj4g4K6u4K6j4K6/4K614K6j4K+N4K6j4K6p4K+NIOCumuCupOCuvuCumuCuv+CuteCu
ruCvjQ0K
