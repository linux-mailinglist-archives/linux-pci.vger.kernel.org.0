Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8446176B9
	for <lists+linux-pci@lfdr.de>; Thu,  3 Nov 2022 07:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiKCG0i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Nov 2022 02:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKCG0h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Nov 2022 02:26:37 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2089.outbound.protection.outlook.com [40.107.20.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D8BBF7;
        Wed,  2 Nov 2022 23:26:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUKUMj/prB4Kimk+hjG2RfKwz7F2ujSVt15lDPV6wXGOBjwvxSO1w7zvhctYkCSdoeZmJTBpJuBQiB60WI4rR5EQ6R5M0bAHbp/t9ylAlJzGDKf6Dt5vynXK3FyLgdhkfBnfUY+m1vgt8Ee8J+GlHpXYad7MFxQFuKKVhdb4+HuYg3vG2O/EnVLUoT26VnMrRyRuQfkYnmA38RbQnVAzYgeNmOm/qwiUHxUD9CrZ13RgCFHNpkgpFGnsixbVgrA5RMqoUEa7+A3gmVUQmU9UTW2uULrJqqxaHQfFZDjpA3oNzTMh7QlkbVk/13z/qjFfJ7I/rGip8ZgB/oDcmjqzBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oa5NKTuZKCNBNvQoyKiWjD55+Sok8CFxseIcnQHHEI4=;
 b=exedG5B1IqxJ4PvD0/LJjg6ivypmXxPBrLNmcU8rSe+/Q42jPNR22dY7NL0EkDAsBrkYXwpUa8UdlumEIdPqE6ppLtfmfB9kz8FDh6sF9KY41HcYZRfugaE9WcTrjv0U4tWji2jWle3s9nigrh06BPZXkzp9TgMTgY5AIEZeorImGruG/76nnpJR9v4/j7GihtLDgjk+qwbRqUz9esd0qgoFJjSN8Uan1R62Zm4ygMOIeG5nHmj6YUyOWNWSz/hQYo4HSe99mvz61ImbEmRggUuxrfCT4Hrarjjlg0A3+EoZJRgCB5Saa2OUTW6rONGjnXzvjIMjiwnvsqfC/jMgUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oa5NKTuZKCNBNvQoyKiWjD55+Sok8CFxseIcnQHHEI4=;
 b=kI8QGdElGZdky9lT4l2GEKqd5NzkJ0y19OR9rFbdwU9DY86dahoV53dsQwzpTLSG5K2zBgdqurHach+fQ9JJ99A52XJ741iMc8m/tXYIMhjOZBVQJ725YCqTAKKhwMK03Q/SXnc7ytKfS4VAvbY71rNwXeDNczK5VGF7iLKxIoI=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by VI1PR04MB6783.eurprd04.prod.outlook.com (2603:10a6:803:130::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 3 Nov
 2022 06:26:33 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::f135:ec2c:8528:d866]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::f135:ec2c:8528:d866%9]) with mapi id 15.20.5769.021; Thu, 3 Nov 2022
 06:26:33 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v1] PCI: imx6: Set MSI enable bit of RC in resume
Thread-Topic: [PATCH v1] PCI: imx6: Set MSI enable bit of RC in resume
Thread-Index: AQHY7crVp6JPT10pBkes7VgrUc48l64sRQyAgABtMsA=
Date:   Thu, 3 Nov 2022 06:26:33 +0000
Message-ID: <AS8PR04MB86769FFF542FF025047221C18C389@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1667289595-12440-1-git-send-email-hongxing.zhu@nxp.com>
 <20221102231037.GA6902@bhelgaas>
In-Reply-To: <20221102231037.GA6902@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|VI1PR04MB6783:EE_
x-ms-office365-filtering-correlation-id: 13ee7103-c8ee-46a7-10f0-08dabd645a12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Se1rXGHFkc0Cc8O6vReHnqMeYmXnKLAFN3PDhwWL0feFA2x76ZHrLB4ntVuEKIaAYuJGgWRM+YIrrHYOt8nzhehSX0V8kyAU55S6kYwLqxczlsMMDlXdWWeReDcbYYXm+MX0/sc8Er79qr6tCfnMI+yZJXQ++DV6J9IFuUJptEeryGFF6E6xsQqltUKFlrrPpIpw6Gh90qNkBoVdDjBUcNAqQ2PKBOSxYEdXxg/v//CcmDlu/l8u8mOkdVc06OQSuXewM9EScHBoEaSjRIn55QSWsInx0ydS1RKlmRw2VBVuTfcLsg/edNcQWdLIU1W+OjWla0rjgiN01m3yP6hTEu9xQT/xGqmOSnYk1aDY3GSf1WeEixw1UYlw8l/PGGi34Zrkw2Ot50PvDOcpP+QfI8DK1ZOlUTvne2y6l/Fjaf1IkJsCcz7fLIzUQiNDQFqRzSO4QQ3EeZarO2bC1OqQEZGlVWToqCFujFD/4M8eQgsnqKoEbUD/4V8ogZ+0JmsdFDx7vm+o5xB+N8QA7T+xhwQhYzZve3SQJOk7LiK/Im0nVfNVR2l+V8SC/TlVQNoX0jCaeuy5L783mH6mdlRXgpss+b7IN7eAYCpgE8tH3Prn5yvLZKbKaXg76h7hXSt6MRHjiK0MEu5JDtFR00apdyokPkcYKYuO+BkJWckLhcdkvTIkp3cQGtwcJgZ8vi9yoavOZwIBTjE1XCgFdpTOKFZDUqnYMLPcGUVQuzJyWfUQ1rFa2uJUu2bNnAtt7hBUzYIOZValWLYEZDCQ93BVeQbBSQef0Zqe03F9PSZ0nJI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(376002)(366004)(346002)(451199015)(6916009)(54906003)(316002)(71200400001)(45080400002)(8676002)(6506007)(966005)(53546011)(9686003)(26005)(7696005)(55016003)(41300700001)(8936002)(66946007)(66446008)(66476007)(478600001)(52536014)(4326008)(66556008)(64756008)(76116006)(5660300002)(44832011)(33656002)(122000001)(2906002)(86362001)(38100700002)(38070700005)(83380400001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Z1NyUmplZUtJWTBjbW5tLzhpREhwR0gxVG5ucCtHL09zb1ZkeE9odW5kMnRR?=
 =?gb2312?B?eEd1S1NhL25CY2svd3B5OGhXZ1VCRVR0bGtuRjhqOUdER1p6TC91YXpyME1H?=
 =?gb2312?B?WFNOOThxM3BDTWRUS3hRcWJJVndWZ3Q4WE96UDc1QnM2cThHVGNKeWhhQWU2?=
 =?gb2312?B?Vm1jUG4vdVJ3aUdEZXR1a09OSzNEL1gwS2R5RHRmZXdQOEtlcmVzTWxBR3ZR?=
 =?gb2312?B?dGp6WTlFQVMrUHd0TnAyK2FxUm85bXcyL3NQTnBlblRycmk4UFdZR1dlUXdX?=
 =?gb2312?B?MkhqZkJYaldsbVJlRWZLbWhuS0lrTmRNYnJRMy9YWGNPckRSeXpnY0dDdU1y?=
 =?gb2312?B?OWpNSFBXRlVPbzhORksyUFlkZDZSeE4yNWlrK25maHErT2JZRHAxV1VmNTA2?=
 =?gb2312?B?ejlFNEdRVllSL29yeE5qK1pGT2hJSjl6SS9WcXVZLzJNUE9lY2l3djU3Nlo4?=
 =?gb2312?B?TXRKb01KWHFtTDNXZElGelg1ZVZzNzVsR1MvWlZ5THprZVVDSU5LT2lldTZH?=
 =?gb2312?B?SVQrVG0zNk41M2FFNGJUK040djNkclVEdGtBdE9YTmtBbzNsVHhMMzk1YzNP?=
 =?gb2312?B?UUM5aFFHTHF2VFZvYUVSZE1KSFR1NmQ2ODNWKzU3ZnZUUkw0bGpNR0J0N2pI?=
 =?gb2312?B?eThsQkh3eEFiUDBBaGVIZ0xyOURTUnlQZG52Wkc1R29LTjU3Szk2TXFMYkRQ?=
 =?gb2312?B?WlVndTVRMnJtQlZ0bmFBZTUrWjFaUTRlNkx3ZEQ2bGVhY1laamxBcnhDM3Jm?=
 =?gb2312?B?aFlEYVY4UVdjTERldW15SkVlV2MwQk95WjFjSmZtaW5FVDZQcDVYRmxpM0Np?=
 =?gb2312?B?YzgwK2RaS2tEcmx2cEltMzBqOFFRSHd1aWYrUlBKZUU3SXNLSjkrYVZHWDhm?=
 =?gb2312?B?UzdzTFBIa08wallpMHlBcGVUb1Qrazd5YmtnbFdON0s3OGFtTFVnRS92MWVK?=
 =?gb2312?B?V3BtaTZHN2p3ZXRMWDRodW5jV3FUQ042dDNYVitEUGExS096ODcvSXFZc0NF?=
 =?gb2312?B?dnIwVVJMTU5TSmgvYVVrTDJNVk9XQUd6ejJOYWUzSkpwWUVGVXJVRkx1Wklx?=
 =?gb2312?B?R1V2RDJEYlYxWkJkZVB0VnRVRHViT2NFK3AvWlRQSEkzVW5jcm5KeDdxc1Iw?=
 =?gb2312?B?bFduSXZkeG1CWXhXellIRVc5Y25sREIwZGloVmNZWHROS2tGUXZkeXd2K2ha?=
 =?gb2312?B?TjRUYmFYVXQ5MFdjOE1Oc1oxUDlPNlBBRDBBeENmRGttdjhOWGxuVllxODNi?=
 =?gb2312?B?UmdsYmxvY2VzRkJDMlBNS1BkcndEMWF2NHRPd2Q3WDNHR1k1QjFPNW5IZlVF?=
 =?gb2312?B?YmVOY09qOUZLcE9VOG5PK3lud0lFNE5wa0t5aDZPMTl2RDBLYXBVcDVhTFFj?=
 =?gb2312?B?S1c1MlFaOVZPSGo4VktEZzhtTmtFSFN5cm5rZ2FMTGZSR2EwVkZIWDg0blAz?=
 =?gb2312?B?VWk3OG5DN0tqSU10VEs3RTR6MTlnS3B4QnNQa1pyVFpUWWtzM3k0OEhpbVNp?=
 =?gb2312?B?K3pjeFBFNWZ2M1hpWWN6cXIwUDY5QlBqR0tIUExpL3FsamN5aExwVVVwYzlo?=
 =?gb2312?B?bVlwVW1yTTRZWTljWHZGY3FEZFVDQmQ4bGNNa2RkaFFCa1Z5RXdEWDZBaTRB?=
 =?gb2312?B?N243bnBtTFA3QjgxU2RwVkc1RytoZnl2aGZIYjZSbXRtVHQ3ZEFXMHVPS25r?=
 =?gb2312?B?Z0JrNUJ5Y2gzcW1CMElWZUlZazNzU2swM3lFUFJhTFdlczU3M0FlQnI0aWRC?=
 =?gb2312?B?bVhQTit5alRRZTRZOGdoZU9KWmhVWGVHRnlkOGNPMDJBZzhJcVFNYmorVzR0?=
 =?gb2312?B?WFI3dXBYSHlmWmJlOGh3OTFydFBjS0lzWnN1RzhqTzJTYUR0RENWRWtMZENH?=
 =?gb2312?B?MHV4ZFhvdzBUSFJNS2lmSlVaaXU5ZDBFSXpJSVhEbTdRS29Bc3JsMWZGVmtq?=
 =?gb2312?B?R1Z6KzVGTUM5Rm5GcFduaDlMeEhmOHVzRFRHdVRiTDhMOS9OK2lTN0hOaW9u?=
 =?gb2312?B?bDBYY21VLzBrcUJiNC9vd041Vm1FNG00RG9aWGxFWEpvcndQWEtNWUlxNUpr?=
 =?gb2312?B?RVFoeWxYMGM1cUE2OTBnUmpLYUN6UUZEZWd5MTFTWkxBN3hrc1c1QzFlT1Jr?=
 =?gb2312?Q?N1wZtkz2F574+HsOLVBW0XfHI?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13ee7103-c8ee-46a7-10f0-08dabd645a12
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 06:26:33.1702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EmlF0aeoCcYiRqmgqiqbzY+fq+6L0MhNT/qOlV8sssngDiMtX85BzCq32PB8ufnaVYOuHYK09o1mysBrZIssjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6783
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SBL,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxn
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjLE6jEx1MIzyNUgNzoxMQ0KPiBUbzogSG9uZ3hp
bmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IGwuc3RhY2hAcGVuZ3V0cm9uaXgu
ZGU7IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IGxp
bnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4ga2VybmVsQHBlbmd1dHJv
bml4LmRlOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHYxXSBQQ0k6IGlteDY6IFNldCBNU0kgZW5hYmxlIGJpdCBvZiBSQyBpbiByZXN1bWUN
Cj4gDQo+IE9uIFR1ZSwgTm92IDAxLCAyMDIyIGF0IDAzOjU5OjU1UE0gKzA4MDAsIFJpY2hhcmQg
Wmh1IHdyb3RlOg0KPiA+IFRoZSBNU0kgRW5hYmxlIGJpdCBjb250cm9scyBkZWxpdmVyeSBvZiBN
U0kgaW50ZXJydXB0cyBmcm9tIGNvbXBvbmVudHMNCj4gPiBiZWxvdyB0aGUgUm9vdCBQb3J0LiBU
aGlzIGJpdCBtaWdodCBsb3N0IGR1cmluZyB0aGUgc3VzcGVuZCwgc2hvdWxkIGJlDQo+ID4gcmUt
Y29uZmlndXJlZCBkdXJpbmcgcmVzdW1lLg0KPiANCj4gSnVzdCBvdXQgb2YgY3VyaW9zaXR5LCB3
aHkgd291bGQgdGhpcyBiaXQgImdldCBsb3N0IiBkdXJpbmcgc3VzcGVuZD8NCj4gDQo+IERvbid0
IHRoZSBub3JtYWwgc2F2ZSBhbmQgcmVzdG9yZSBpbiB0aGUgc3VzcGVuZC9yZXN1bWUgcGF0aHMg
dGFrZSBjYXJlIG9mDQo+IHRoaXM/ICBBcmUgdGhlcmUgb3RoZXIgYml0cyB0aGF0IG1pZ2h0IGdl
dCBsb3N0Pw0KSGkgQmpvcm46DQpUaGFua3MgZm9yIHlvdXIgY2FyZS4NClRoZSBjb250cm9sbGVy
IG1pZ2h0IGJlIHJlc2V0IHRvIHRoZSBrbm93biBzdGF0IGR1cmluZyB0aGUNCnJlLWluaXRpYWxp
emF0aW9uIGluIHRoZSByZXN1bWUgcGF0aCwgSSB0aGluay4NCg0KZHdfcGNpZV9zZXR1cF9yYygp
IGNvbmZpZ3VyZXMgbW9zdCBvZiB0aGUgY29udHJvbGxlciBzZXR0aW5nIGR1cmluZyByZXN1bWUu
DQpJdCBzZWVtcyB0aGF0IHRoaXMgYml0IGlzIGkuTVggUENJZSBzcGVjaWFsLCBzaG91bGQgYmUg
Y29uZmlndXJlZCBpbiBib3RoIHRoZQ0KIHByb2JlIGFuZCBzdXNwZW5kL3Jlc3VtZS4NCg0KQmVz
dCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KPiANCj4gPiBFbmNhcHN1bGF0ZSB0aGUgTVNJIGVuYWJs
ZSBzZXQgaW50byBhIHN0YW5kYWxvbmUgZnVuY3Rpb24sIGFuZCBpbnZva2UNCj4gPiBpdCBpbiBi
b3RoIHByb2JlIGFuZCByZXN1bWUuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFpo
dSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvZHdjL3BjaS1pbXg2LmMgfCAyNCArKysrKysrKysrKysrKysrKy0tLS0tLS0NCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+
IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+IGluZGV4IDI2MTY1
ODVjYTVmOC4uZGJhMTU1NDYwNzVmIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3
Yy9wY2ktaW14Ni5jDQo+ID4gQEAgLTEwNDEsNiArMTA0MSwyMSBAQCBzdGF0aWMgdm9pZCBpbXg2
X3BjaWVfcG1fdHVybm9mZihzdHJ1Y3QNCj4gaW14Nl9wY2llICppbXg2X3BjaWUpDQo+ID4gIAl1
c2xlZXBfcmFuZ2UoMTAwMCwgMTAwMDApOw0KPiA+ICB9DQo+ID4NCj4gPiArc3RhdGljIHZvaWQg
cGNpX2lteF9zZXRfbXNpX2VuKHN0cnVjdCBkd19wY2llICpwY2kpIHsNCj4gPiArCXU4IG9mZnNl
dDsNCj4gPiArCXUxNiB2YWw7DQo+ID4gKw0KPiA+ICsJaWYgKHBjaV9tc2lfZW5hYmxlZCgpKSB7
DQo+ID4gKwkJb2Zmc2V0ID0gZHdfcGNpZV9maW5kX2NhcGFiaWxpdHkocGNpLCBQQ0lfQ0FQX0lE
X01TSSk7DQo+ID4gKwkJZHdfcGNpZV9kYmlfcm9fd3JfZW4ocGNpKTsNCj4gPiArCQl2YWwgPSBk
d19wY2llX3JlYWR3X2RiaShwY2ksIG9mZnNldCArIFBDSV9NU0lfRkxBR1MpOw0KPiA+ICsJCXZh
bCB8PSBQQ0lfTVNJX0ZMQUdTX0VOQUJMRTsNCj4gPiArCQlkd19wY2llX3dyaXRld19kYmkocGNp
LCBvZmZzZXQgKyBQQ0lfTVNJX0ZMQUdTLCB2YWwpOw0KPiA+ICsJCWR3X3BjaWVfZGJpX3JvX3dy
X2RpcyhwY2kpOw0KPiA+ICsJfQ0KPiA+ICt9DQo+ID4gKw0KPiA+ICBzdGF0aWMgaW50IGlteDZf
cGNpZV9zdXNwZW5kX25vaXJxKHN0cnVjdCBkZXZpY2UgKmRldikgIHsNCj4gPiAgCXN0cnVjdCBp
bXg2X3BjaWUgKmlteDZfcGNpZSA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOyBAQCAtMTA3Myw2DQo+
ID4gKzEwODgsNyBAQCBzdGF0aWMgaW50IGlteDZfcGNpZV9yZXN1bWVfbm9pcnEoc3RydWN0IGRl
dmljZSAqZGV2KQ0KPiA+ICAJaWYgKGlteDZfcGNpZS0+bGlua19pc191cCkNCj4gPiAgCQlpbXg2
X3BjaWVfc3RhcnRfbGluayhpbXg2X3BjaWUtPnBjaSk7DQo+ID4NCj4gPiArCXBjaV9pbXhfc2V0
X21zaV9lbihpbXg2X3BjaWUtPnBjaSk7DQo+ID4gIAlyZXR1cm4gMDsNCj4gPiAgfQ0KPiA+DQo+
ID4gQEAgLTEwOTAsNyArMTEwNiw2IEBAIHN0YXRpYyBpbnQgaW14Nl9wY2llX3Byb2JlKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+ID4gIAlzdHJ1Y3QgcmVzb3VyY2UgKmRiaV9i
YXNlOw0KPiA+ICAJc3RydWN0IGRldmljZV9ub2RlICpub2RlID0gZGV2LT5vZl9ub2RlOw0KPiA+
ICAJaW50IHJldDsNCj4gPiAtCXUxNiB2YWw7DQo+ID4NCj4gPiAgCWlteDZfcGNpZSA9IGRldm1f
a3phbGxvYyhkZXYsIHNpemVvZigqaW14Nl9wY2llKSwgR0ZQX0tFUk5FTCk7DQo+ID4gIAlpZiAo
IWlteDZfcGNpZSkNCj4gPiBAQCAtMTI4MiwxMiArMTI5Nyw3IEBAIHN0YXRpYyBpbnQgaW14Nl9w
Y2llX3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gIAlpZiAocmV0
IDwgMCkNCj4gPiAgCQlyZXR1cm4gcmV0Ow0KPiA+DQo+ID4gLQlpZiAocGNpX21zaV9lbmFibGVk
KCkpIHsNCj4gPiAtCQl1OCBvZmZzZXQgPSBkd19wY2llX2ZpbmRfY2FwYWJpbGl0eShwY2ksIFBD
SV9DQVBfSURfTVNJKTsNCj4gPiAtCQl2YWwgPSBkd19wY2llX3JlYWR3X2RiaShwY2ksIG9mZnNl
dCArIFBDSV9NU0lfRkxBR1MpOw0KPiA+IC0JCXZhbCB8PSBQQ0lfTVNJX0ZMQUdTX0VOQUJMRTsN
Cj4gPiAtCQlkd19wY2llX3dyaXRld19kYmkocGNpLCBvZmZzZXQgKyBQQ0lfTVNJX0ZMQUdTLCB2
YWwpOw0KPiA+IC0JfQ0KPiA+ICsJcGNpX2lteF9zZXRfbXNpX2VuKHBjaSk7DQo+ID4NCj4gPiAg
CXJldHVybiAwOw0KPiA+ICB9DQo+ID4gLS0NCj4gPiAyLjI1LjENCj4gPg0KPiA+DQo+ID4gX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gPiBsaW51eC1h
cm0ta2VybmVsIG1haWxpbmcgbGlzdA0KPiA+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZw0KPiA+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5j
b20vP3VybD1odHRwJTNBJTJGJTJGbGlzdHMNCj4gPiAuaW5mcmFkZWFkLm9yZyUyRm1haWxtYW4l
MkZsaXN0aW5mbyUyRmxpbnV4LWFybS1rZXJuZWwmYW1wO2RhdGE9MDUlNw0KPiBDMA0KPiA+DQo+
IDElN0Nob25neGluZy56aHUlNDBueHAuY29tJTdDNDQ1NGY3ZjVkMWQwNDM4ZDAwOTkwOGRhYmQy
Nzc2N2UlDQo+IDdDNjg2ZWExDQo+ID4NCj4gZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0Mw
JTdDMCU3QzYzODAzMDI3NDQzNzE4NjUxMCU3Q1Vuaw0KPiBub3duJTdDVFcNCj4gPg0KPiBGcGJH
WnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3
aUxDSlhWDQo+IENJNg0KPiA+DQo+IE1uMCUzRCU3QzMwMDAlN0MlN0MlN0MmYW1wO3NkYXRhPWdm
aVBQbGV6U1NvY3lOVHBxMG9Lbms1cnd3bQ0KPiBocG1XQ3N6YUhhDQo+ID4gWVdMaG9JJTNEJmFt
cDtyZXNlcnZlZD0wDQo=
