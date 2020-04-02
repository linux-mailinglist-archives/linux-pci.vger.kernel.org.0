Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84F3C19BB3D
	for <lists+linux-pci@lfdr.de>; Thu,  2 Apr 2020 06:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbgDBE6x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Apr 2020 00:58:53 -0400
Received: from mail-eopbgr1410128.outbound.protection.outlook.com ([40.107.141.128]:46720
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726653AbgDBE6x (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Apr 2020 00:58:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8LOd+IXM8ZLAQDpCZYVZparrCnu7HHgPM6sEqCcoPgyI2Li9kS42VeJZpGEcCtxLWmt/gsXO0VnQFijq29Lk+UKBo6oasO5e/hAbrt+CMTIyTNUuJMRIZCX0QeAZSjnpXpO4MAhxrVuTdA8XG+wxa607HuQp6GjIZFAFrMsDumyiiqyo6XTHoOmu9reh59m8rhO6Tl3teTgSYBLlKaRgJ6ADdAGcRUX+hTn0PiRAX/ratuApe8OAn1YdlJYVyGEoP6mE6BJG341FBLKDrpVFrrrrVjL/OwZRzx0AvzQCgZ41q7dHGy0evL8JglWX05vC2+JkLxVPPRkL/02DXwVFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dpYbaRuCNNlslWeJPYLnmPwl2x18eYpotU+IPWc6BI=;
 b=hmgmRyLjK3Nx2VF3+EsmV5T5PwgPJBlF2WJN1Q6sMnilQrmUl9EjREHovN86Yma4wXG5s6tf46fToEKr/TAs6r4COS2OLCsW43xo9G+CiqWafbKmrmQ6sS1XiZFpmUHkaiZuQsoOiWqDvTz8pYf644Lq4Xr+4p+veqRwT5Wko/HOjQD75/zCSdlWIiwaQz9KzKbsPMkrP5l2I3FxciggiYIbd60/4zp/L+fukfR5rV1UMkI4QMX0g77wIzOBcYHdtngw3PhCdIgTaJp/48FMIcpqKLOBXhKkHdWEMvKNbZX+FqU0Th0j9JoPt8aaXqx8yDxUWUOjtBeelHqdeesbQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dpYbaRuCNNlslWeJPYLnmPwl2x18eYpotU+IPWc6BI=;
 b=L8Qwfx8lkAU782fgONFCxvo7b/AE0TithJQM5Q2h3POqrZVoYaRUA667VILHfO+QLZR7AvabKDsz3SvjozXn+I8D9pplhjCksZctyWtXQuSJbqjarOkFZ9noykbiLlzRiw7punbUnqdnHtEZyBpeZbM5NP2k+JB6tmSMwJoJKR0=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB2941.jpnprd01.prod.outlook.com (20.177.104.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Thu, 2 Apr 2020 04:58:49 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06%4]) with mapi id 15.20.2856.019; Thu, 2 Apr 2020
 04:58:49 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>
Subject: RE: PCIe EPF
Thread-Topic: PCIe EPF
Thread-Index: AQHV/Rm8Pc6E7UbBNUC7Q13GpqZQQKhQ9oaAgAK1PACAA1lugIAA1U4AgAaNB4CAAUQ/AIABb1+AgAATpYCAAAMegIAABzuAgAEWMpCAALlXgIAAgOqAgABzUYCAAAdw4IAAEB0AgAEISrCAAD8owA==
Date:   Thu, 2 Apr 2020 04:58:49 +0000
Message-ID: <TYAPR01MB45442E975AEA3EDD22A3CD3BD8C60@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <CA+V-a8vOwwCjRnFZ_Cxtvep1nLMXd5AjOyJyispg1A1k_ExbSQ@mail.gmail.com>
 <e5570897-0566-6cce-9af2-8be23fb0d3ef@ti.com>
 <CA+V-a8ssdO9R_wHbJM8RinzP5d7YX5KWES20G-TV0XnCx4SUeA@mail.gmail.com>
 <83024641-7bd3-b47f-cd2c-0d831279086d@ti.com>
 <CA+V-a8sBC5+v+BsVSjkfLvYzddPs2jj1roFaDO4Tz4q9CWnGSg@mail.gmail.com>
 <CA+V-a8t15gotL1v-PRO1fGjL0WKTO2fOa69qZ5rctYn08XY=BA@mail.gmail.com>
 <CA+V-a8sNcdC8SO6pXGUH3TkM7B6dX-xxcqtZjRZ_496qyG1h+Q@mail.gmail.com>
 <60deaab7-fe56-0f30-a8bd-fbeea9224b11@ti.com>
 <CA+V-a8uxAD5-BovZPrKi_a6DPJVJPpez4V45C7YY-Rh3QjN8ag@mail.gmail.com>
 <e34a54f2-af3a-b760-c7d2-1da836e8fb4d@ti.com>
 <CA+V-a8t6WuBsMaW4WTCDHihUFv69WpwqJgOYH+rL7ndJ2NhrDQ@mail.gmail.com>
 <TYAPR01MB45446ABD97A846045FD2B896D8C80@TYAPR01MB4544.jpnprd01.prod.outlook.com>
 <CA+V-a8sn-qv+MEtWOoBqNh9xwSj4kzo6m_SHtQ-DHr+_0hJ4UA@mail.gmail.com>
 <TYAPR01MB4544F0435DB48E168EF41B90D8C90@TYAPR01MB4544.jpnprd01.prod.outlook.com>
 <CA+V-a8vK36es7Q6AB-t2wkyF-DNJa6GP5HZ41YgJG-PopxuHfw@mail.gmail.com>
 <TYAPR01MB4544972970249F317DEBE5AAD8C90@TYAPR01MB4544.jpnprd01.prod.outlook.com>
 <CA+V-a8vCKRtWxfB1u-XZxVeioi76Fdhb_gOWMC9TtSEmyFersg@mail.gmail.com>
 <TYAPR01MB4544C9091D4E2186FD7A0A37D8C60@TYAPR01MB4544.jpnprd01.prod.outlook.com>
In-Reply-To: <TYAPR01MB4544C9091D4E2186FD7A0A37D8C60@TYAPR01MB4544.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9d30df37-1365-4752-fbf7-08d7d6c2884d
x-ms-traffictypediagnostic: TYAPR01MB2941:|TYAPR01MB2941:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB2941F58E56D0FF7BA6AF4F94D8C60@TYAPR01MB2941.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:374;
x-forefront-prvs: 0361212EA8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(64756008)(8936002)(66556008)(52536014)(81156014)(66946007)(2940100002)(33656002)(2906002)(86362001)(66446008)(9686003)(5660300002)(66476007)(81166006)(76116006)(316002)(4744005)(55236004)(8676002)(7116003)(3480700007)(6916009)(55016002)(26005)(7696005)(186003)(71200400001)(4326008)(478600001)(6506007)(54906003);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SPdBnHaToQDRAEYOuYnHk8ExwhLgB+rps1hohsuRk61UD1pXgtZwttDFSDNBtuuuneh0WZnH5//Sgdb12iHwhtcNaxoUrWD+T3cyXlN00mUUlzNWRI84Jfj1aTaHJqRCjQBwkdKCebId5U+7BB1bFIQsK65GxnnK1KvLQGWQwRBdl9KTByS702yJjkvvHF+wm1f++Wjb95xNNi9Y2WGvPQ6PGq2dASkXov3gX/CQNcDNv30+ouNktro82/Rw9hLckC3/0JjC+ffuuYqeZtTHm2h7CQn4UkiS2JbDdqeXDiIHIOxbtnHkgG//6l2JHnibZTL15F4toAkhUBtoZAcTcP/XIiWisQfzKpEgJWdysD7RHvMVk5UuVboV7lUGNP9zAuh2hs9FCocdKdJOUeqtdTg1AaFcOEbTpb5L2IN/TgATOkkHfAghSyuirYFQfLH7
x-ms-exchange-antispam-messagedata: GIbVuZCO4kDK1AuKq6mAXSw0/YBuWDFBhjY9uzEuOVhCjoH1uwlRc4RKRZH7Javi1I2EbQH2D3qiB/3LNCKE4Eg+7LpJ+PB9ouqQFoQB/ToS6VDs3DzoE8Q4pGPgiigPS3ytY7uih8A7iFtMewz5nw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d30df37-1365-4752-fbf7-08d7d6c2884d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2020 04:58:49.3706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zgsyaV0EZnj3WDfuE++7jV7oeM4Citt71zF721AtgtSvD+G4GZYohfqv5PLDCq3Ird69Ix2eeVrtB+GJF5vL0RGytbqM/n0LMLntl36UQLkr/Bd2uuHQY3HxqqurxFwY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2941
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgUHJhYmhha2FyLXNhbiwNCg0KPiBGcm9tOiBZb3NoaWhpcm8gU2hpbW9kYSwgU2VudDogVGh1
cnNkYXksIEFwcmlsIDIsIDIwMjAgMTA6MjMgQU0NCjxzbmlwPg0KPiBCeSB0aGUgd2F5LCBhY2Nv
cmRpbmcgdG8gcHJldmlvdXMgeW91ciByZXBvcnQsIHlvdSBhcmUgdXNpbmcgcGNpL25leHQgYnJh
bmNoDQo+IGFuZCB0aGUgYnJhbmNoIGlzIGJhc2VkIG9uIHY1LjYtcmMxLiBUaGVyZSBpcyBubyBl
dmlkZW5jZSB0aG91Z2gsDQo+IEknZCBsaWtlIHRvIHVzZSBuZXh0LTIwMjAwNDAxIHRhZyBmcm9t
IGxpbnV4LW5leHQgcmVwbyB0byB1c2UgdjUuNiBiYXNlZCBrZXJuZWwNCj4gd2hldGhlciB0aGUg
c3RyYW5nZSBpc3N1ZSBoYXBwZW5zIG9uIHRoZSBsYXRlc3QgdjUuNiBrZXJuZWwgY29kZSBvciBu
b3QuDQo+IE5vdGUgdGhhdCBJIGNvbmZpcm1lZCB0aGUgbmV4dC0yMDIwMDQwMSB0YWcgaGFzIGEg
Y29tbWl0IGQyOTMyMzc3Mzk0MTRkDQo+ICgibWlzYzogcGNpX2VuZHBvaW50X3Rlc3Q6IFVzZSBz
dHJlYW1pbmcgRE1BIEFQSXMgZm9yIGJ1ZmZlciBhbGxvY2F0aW9uIikuDQoNCkknbSBhZnJhaWQg
YnV0IEknZCBsaWtlIHRvIHJlY2FsbCB0aGlzIGJlY2F1c2UgbmV4dC0yMDIwMDQwMSBzZWVtcyB1
bnN0YWJsZSBvbg0KUi1DYXIgR2VuMyBlbnZpcm9ubWVudCAoYSBsb3Qgb2YgV0FSSU5HIGhhcHBl
bnMpLiBTbywgcGVyaGFwcyB1c2luZyBsaW51eCBtYWlubGluZQ0KdjUuNiArIG1lcmdpbmcgcGNp
L25leHQgYnJhbmNoIGlzIGJldHRlci4NCg0KQmVzdCByZWdhcmRzLA0KWW9zaGloaXJvIFNoaW1v
ZGENCg0KPiBCZXN0IHJlZ2FyZHMsDQo+IFlvc2hpaGlybyBTaGltb2RhDQoNCg==
