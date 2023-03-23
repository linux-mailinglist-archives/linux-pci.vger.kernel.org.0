Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B895D6C65B2
	for <lists+linux-pci@lfdr.de>; Thu, 23 Mar 2023 11:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbjCWKvY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Mar 2023 06:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjCWKvB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Mar 2023 06:51:01 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2128.outbound.protection.outlook.com [40.107.114.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC38E12F04;
        Thu, 23 Mar 2023 03:49:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gy0yZNjuiHmUSa5KbJ4UrMP8+GQ5SNz3NbDfoRthOLLpfyuAqwKenwIxdIlv7MolZcuWRtFW18rIS7UU4dy76F42ck/EvNrtJRawORL2QCELa9x8qRWeoS8hWXaNFUCkgvGisI+uTIjLmJUjXvkAgfBfS/mCAa5rswG5Rqj69AU+tNvdmXIAk+f/JXEtM/zxnvyRnanQJllzOzZ7vw3voAbgXs635/mkprTr0hbunywDGiDIudQHUcJtJCsrFAaN835s0QJgMycG6ikij8gfXG21aWbo8HoX+MLdlXnI3nDc2rgPDxucOVJVgWvc6dfhWlpZQW3bdV3g5fDDvr5sEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWqkg09UurQo1Bw67h/ChRiQBk2gVVLjWRfe5jP/5U4=;
 b=ewzxZAZySvsojZFXZHqLzo6G1WApcQKt7sJvdP1Zesh3YPJo6Hly2Ymy1bZHaZTt1OedM4+R7RUMkio6vOZkbwWsOdzGpWbvIx0B//OOOYdHHbysXRoaHb+HmFzQPRjJVH427O/rYPpN7pbwV77v4Jq4iGd7DnizvudveVFYwq0GDoVog1LgTU/MCRQnEM1F04xMgIR4PxZuHdPtE8f63br+DvBCx4wuU8GYnI8rqqYLUnbMuw1DDXX5BKCxlqYxtlJsQX7yYGmIhxLmRUoE1bEyPuP+UXKlgTMIC9aY353s0bKoa/7PjK0PkKUDUYB+jVY52mmRsaeWVKHJHN1eEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWqkg09UurQo1Bw67h/ChRiQBk2gVVLjWRfe5jP/5U4=;
 b=LCVS67pAE744mbUrloeGz8GnrlYZtZR+7IwgLxZimG7MuKSIstJZQUmnXDqytwbMawS5G1qti2QIzpJxM4L4bp9Z6cv1WUpHGX2NTYhppYxkUT9mB0ifMmabP0qaHXRNudj/IQzrrkLf48Ri63kQj+u8GWTxaB8WB8c//+TIYgM=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYCPR01MB11621.jpnprd01.prod.outlook.com
 (2603:1096:400:3b8::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 10:49:48 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5f2:5ff1:7301:3ff1]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5f2:5ff1:7301:3ff1%5]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 10:49:47 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "Sergey.Semin@baikalelectronics.ru" 
        <Sergey.Semin@baikalelectronics.ru>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v11 08/13] PCI: dwc: Add dw_pcie_num_lanes_setup()
Thread-Topic: [PATCH v11 08/13] PCI: dwc: Add dw_pcie_num_lanes_setup()
Thread-Index: AQHZU0zE+AgX/+ybSEmnizxiH30vUK8GcGeAgAHR9RA=
Date:   Thu, 23 Mar 2023 10:49:47 +0000
Message-ID: <TYBPR01MB53414D322EF1648EAFE40699D8879@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230310123510.675685-1-yoshihiro.shimoda.uh@renesas.com>
 <20230310123510.675685-9-yoshihiro.shimoda.uh@renesas.com>
 <20230322065701.po7owyzwisntalyz@mobilestation>
In-Reply-To: <20230322065701.po7owyzwisntalyz@mobilestation>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYCPR01MB11621:EE_
x-ms-office365-filtering-correlation-id: 3fc386d8-abda-42fd-b1ab-08db2b8c5243
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qIVkM4hYtyM1NuEiZpSYppdHXylYtcpN8WKIaZpRwlOS/81+NdVNwKC+oqUyMKXylj8cht9mPqzjnGt07bX7D3TkW2rQUsz4pWB7+OswCjQQuFVH5zMJuG34nOESbm9tFBhVYWeOGSLbQpqK/QPM2CLBprrr+DCh51/3/Y+p+BxObVcKEA0JLZNTrQmhD1EdytXApGQrQbJM5YIiPE63Ibe1lHM9Z3vMLrMo9BMNbEOH+kII/oh5aOJejBcT7iW6Mn5QFG3QHyYN2tcSW0yP/NWUu+FkcRXQnlR8KIEc08p5rMLuDTr7Io0oQr+nUmd7EeR+L5fQx56d77JAAQdHzLCqAGbfRHNo96FQOG3VnuXmmsyjUay4AbtxviLJpu3TbgALa4unwvzIS6U8I5GLqxreYJNZeMvgU9XG/qF84Fxpl14oLaRoQO8jKV4OCd7PhdNXZe1pTuMMcK2gvRQhXC8DrRPfAPeAx2WUaNtdXNXusEyetDuIKDpuvavGVmAuQEA9BGr3Ia45b7mGu0oiuknABgkSwmcgJ7PE4tgtyDO+EEO4vKWDv1V+7+JuH7sdT5dmIoV2PR8Za2OxCI22wNxv3DEnqM8D2nEbVwHaRahoGNi91lIHNSg5VzVp5hbTbTfsFDvdYuuHe86Yx6EnCkDyt402afGtDg2tbVA5gZZmkHK2xe/CuKZbv2u1AuGlRTQDTl9Tay8Z0XOp+gVAvQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(136003)(396003)(366004)(346002)(451199018)(41300700001)(8676002)(7416002)(66946007)(66446008)(64756008)(6916009)(76116006)(66556008)(2906002)(4326008)(5660300002)(38070700005)(33656002)(86362001)(38100700002)(122000001)(66476007)(6506007)(71200400001)(7696005)(478600001)(316002)(54906003)(52536014)(8936002)(55016003)(83380400001)(9686003)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2hhMGVQVVI0YzlTUzNvN041QXZFRTB6V1ltU05iVGg4U2FDSFBGaHdocy8x?=
 =?utf-8?B?QmtVMkhHRCt4Rzk5US9sT1pmUlJ1akN5NG1GdEJXYUZaaHZ0ZGdjVGdQS25U?=
 =?utf-8?B?dGtSdlo0RUMxR212U21JTWh6a0lBOHBRMzdjdElDd1R4bEQyeC9CeGFwM09m?=
 =?utf-8?B?dUd4S2dRL3JCVnlIa0JuUXkrWXhaem8xOEh3OWs3d0FXL3JPWkM0ejd3ME1V?=
 =?utf-8?B?a2g1ZXR6ak1jU01HQmpSWG5QcWZPYnd3TjgzUjFGaHZ3N1VESDlDZWd3aFJW?=
 =?utf-8?B?b2U2Qzl3U1o2SnRoU0JvR0l0cWREWUZxaCtGaFpxNFg2YmN4TnhVamFZa2xI?=
 =?utf-8?B?eUVkcnNpL3Zwd1RadDUra24vZU1FN3F1MWhLWDdOT3FSNk0wSmd6Q1c4NmpI?=
 =?utf-8?B?d09lWFdvamJCWGRQODhaRUZNTFoxSzNYQSt6cEk1NGRGZVA4dU16S044V3E0?=
 =?utf-8?B?MHVvSEhHSVFZVlFFT1YrMWYzY3hNTFR3WVlGbU1yZGNwbW95MWd0Q2pWSldj?=
 =?utf-8?B?VVU5T24rUTQvYUtXZzlRK2RXNkFydHR1NHlKZFNsU205Rm5kY3R3R1ZycEJW?=
 =?utf-8?B?bHI5NXhoQmJvSTVqSlFEN0doUEkvdWp0NEVMQ2VkZ0hUU3RzVzlEVzkrNWtY?=
 =?utf-8?B?cXl6Wm9DcXdWQmtMQVBFMG9tcURLbDMzMnk3Y3U3NVFsRWNHUzNBK0NJQ2Jk?=
 =?utf-8?B?cXFWQzdpZjRtSlJ3Qmd3d0Q5eVl6SCt0d04zTzZFWk9HNFhLVVd1WEhQME00?=
 =?utf-8?B?c0VwNGdSRmVJS1g4VTlUa2ZybXM4b0J3UzZURjRhcXAxWlQzWWJMVWFTZFo0?=
 =?utf-8?B?dmkzYUpHaVR4aGNDQ2g1Zm9yY1Z5c29oM05hdnAvVS9laXlVUDNvajUva2F2?=
 =?utf-8?B?cHZHQ0xUeTZhRjRtVXZOalJFUFJka3gwMWgzeEErSkJtUHpwWC9IMXlNQ0hP?=
 =?utf-8?B?Q0NXV0RzUEhtOU44TGUrQnk2NDUzamxJS3ZoK3A5bzdWZ0NyNkN6ek84aFNx?=
 =?utf-8?B?T1Z4bitRMGh2aXhEWG1vUldPUWRDUkkwdUFYMU5kMVIwUWxXdWhEcXJqZXFi?=
 =?utf-8?B?cGZyVDNBUGtzelkrQlpIVkcyTGtQMGNtVUpub2Rsd0VGbGtNdW1SRTlkZFlY?=
 =?utf-8?B?alNSMFBZUzJiM2kwZGNQMlJWai9PNlZjU21UUkFVWVo1ZmR6bktJUTFBenAx?=
 =?utf-8?B?RncvRFFmQ1FrbmZlRnlRVThUMzBsYk1DREtEdVc4Y0FzcWNHdlRyUGlDaE9G?=
 =?utf-8?B?eEt3c0xSbFFqRThPRmNHbEk3Y25kaTdUUURGUVV0eFlOY2NNaHJrRUhLWEs1?=
 =?utf-8?B?RGxHVHhabXJ4cHdJTi95QktwR1NkKzR2WEIzbWdhYUZhZEF0S0pvK1NreEs0?=
 =?utf-8?B?aTNkV25TOHlxNm1aakJFanVhZzNxYTU2aG1VWlJweTNMRVNqTlNnNXQrMTRB?=
 =?utf-8?B?dFZaNjBkUlpLaVZTTkI2dnh4UElITERWaVVjbEI3WTJvMTN6bFF1TXVhK0lj?=
 =?utf-8?B?OEJ6RCtFZnRzZ0k1UDdrZ3BEU3liVnNQZ1FtR2szQ3hkUkd3M01YbDhEYXMv?=
 =?utf-8?B?dnRiQzRLMytyQWdKTlM5WXd3aHBTVzNrNUR5VWZnZUdjcjJlYjZZTEVONThX?=
 =?utf-8?B?MG1XcnBOSVdlVytWRWtmYjhXZ2paaXE5UGl1N2RFNVhCTzBYaUxTWDZhNmxJ?=
 =?utf-8?B?ZmgrWEY5VDJJb0lEYmVyaGFQNDEvb25TUk5XSnpMTmlIK200ZVVXYTFiY1Fp?=
 =?utf-8?B?bWU1b3dtNVArQ2VQMnoxVEcyQ2lnNzJ1Q05GRmpxZVRPenRGT3dySW5hMS9a?=
 =?utf-8?B?eThpZlpsTVUxcVM0Zi9LQVFONnJVZFA5SUFUT284czlzSmNzWkdKRy9YWEJo?=
 =?utf-8?B?Y0xrMFpmTVpMaGxjSnFubmNRNTlTSkliZWNqeWJyMUE3MnhrYi96S2ZPNVdP?=
 =?utf-8?B?b3hiQXVXeGtTU3hVanlKSjV6ODRnTFl2ODVvMmw3em04dG1zcGkvMEQ5eWhY?=
 =?utf-8?B?a0NLWCtwZXgxTUtEcEdWOWt0NlF3bHNwTGZkUnVqVUpvb296SWNiRjBDRFhR?=
 =?utf-8?B?OGtiTUUxaktlVkhSaDBGVlZCY29VTFlOWWRRb2UyaTl4cXFMYUg2OVlpK0pp?=
 =?utf-8?B?b1pkM2ZtMkpDcUlyVkVGZ2podG80OCsybEU0WkVUWkJtVU1lbHVYdGlOQUlN?=
 =?utf-8?B?UmE4VVBtWENMTGN2M3JHckFKVE41eGcrZEVaVUlJbXlMVWF1R2dtbjk3VUhQ?=
 =?utf-8?B?eWJXemJsYWNCUXF3U0U4U3hoeEJRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fc386d8-abda-42fd-b1ab-08db2b8c5243
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 10:49:47.8173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GMZu/77lsFF1EGIqNwtXALyIPjvpHeBes/MY1uI85QvuROztJbSifR6nfuejyZZpujdjrSTEjkrmKevm4atSkitlD1q7IxnZTL4hrauFfDwcvKfufeAzF+Ey+pwH89NO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11621
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgU2VyZ2UsDQoNCj4gRnJvbTogU2VyZ2UgU2VtaW4sIFNlbnQ6IFdlZG5lc2RheSwgTWFyY2gg
MjIsIDIwMjMgMzo1NyBQTQ0KPiANCj4gT24gRnJpLCBNYXIgMTAsIDIwMjMgYXQgMDk6MzU6MDVQ
TSArMDkwMCwgWW9zaGloaXJvIFNoaW1vZGEgd3JvdGU6DQo+ID4gQWRkIGR3X3BjaWVfbnVtX2xh
bmVzX3NldHVwKCkgdG8gc2V0dXAgUENJX0VYUF9MTktDQVBfTUxXLg0KPiANCj4gTW9yZSBkZXRh
aWxzIG9mIHdoeSBpdCdzIG5lZWRlZCB3b3VsZCBiZSBuaWNlLiBGb3IgaW5zdGFuY2UsIGluDQo+
IGFjY29yZGFuY2Ugd2l0aCB0aGUgRFcgUENJZSBSQy9FUCBIVyBtYW51YWxzIFsxLDIsMywuLi5d
IGFzaWRlIHdpdGggdGhlDQo+IFBPUlRfTElOS19DVFJMX09GRi5MSU5LX0NBUEFCTEUgYW5kIEdF
TjJfQ1RSTF9PRkYuTlVNX09GX0xBTkVTWzg6MF0NCj4gZmllbGQgdGhlcmUgaXMgYW5vdGhlciBv
bmUgd2hpY2ggbmVlZHMgdG8gYmUgdXBkYXRlLiBJdCdzDQo+IExJTktfQ0FQQUJJTElUSUVTX1JF
Ry5QQ0lFX0NBUF9NQVhfTElOS19XSURUSC4gSWYgaXQgaXNuJ3QgZG9uZSBhdCB0aGUNCj4gdmVy
eSBsZWFzdCB0aGUgbWF4aW11bSBsaW5rLXdpZHRoIGNhcGFiaWxpdHkgQ1NSIHdvbid0IGV4cG9z
ZSB0aGUNCj4gYWN0dWFsIG1heGltdW0gY2FwYWJpbGl0eS4NCg0KVGhhbmsgeW91IGZvciB5b3Vy
IGNvbW1lbnRzISBJJ2xsIGFkZCB0aGVtIGludG8gdGhlIGNvbW1pdCBtZXNzYWdlIG9uIHYxMi4N
Cg0KPiBbMV0gRGVzaWduV2FyZSBDb3JlcyBQQ0kgRXhwcmVzcyBDb250cm9sbGVyIERhdGFib29r
IC0gRFdDIFBDSWUgUm9vdCBQb3J0LA0KPiAgICAgVmVyc2lvbiA0LjYwYSwgTWFyY2ggMjAxNSwg
cC4xMDMyDQo+IFsyXSBEZXNpZ25XYXJlIENvcmVzIFBDSSBFeHByZXNzIENvbnRyb2xsZXIgRGF0
YWJvb2sgLSBEV0MgUENJZSBSb290IFBvcnQsDQo+ICAgICBWZXJzaW9uIDQuNzBhLCBNYXJjaCAy
MDE2LCBwLjEwNjUNCj4gWzNdIERlc2lnbldhcmUgQ29yZXMgUENJIEV4cHJlc3MgQ29udHJvbGxl
ciBEYXRhYm9vayAtIERXQyBQQ0llIFJvb3QgUG9ydCwNCj4gICAgIFZlcnNpb24gNC45MGEsIE1h
cmNoIDIwMTYsIHAuMTA1Nw0KPiAuLi4NCj4gW1hdIERlc2lnbldhcmUgQ29yZXMgUENJIEV4cHJl
c3MgQ29udHJvbGxlciBEYXRhYm9vayAtIERXQyBQQ0llIEVuZHBvaW50LA0KPiAgICAgVmVyc2lv
biA1LjQwYSwgTWFyY2ggMjAxOSwgcC4xMzk2DQo+IFtYKzFdIERlc2lnbldhcmUgQ29yZXMgUENJ
IEV4cHJlc3MgQ29udHJvbGxlciBEYXRhYm9vayAtIERXQyBQQ0llIFJvb3QgUG9ydCwNCj4gICAg
IFZlcnNpb24gNS40MGEsIE1hcmNoIDIwMTksIHAuMTI2Ng0KPiANCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IFlvc2hpaGlybyBTaGltb2RhIDx5b3NoaWhpcm8uc2hpbW9kYS51aEByZW5lc2FzLmNv
bT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253
YXJlLmMgfCAxMiArKysrKysrKysrKysNCj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2Mv
cGNpZS1kZXNpZ253YXJlLmggfCAgMSArDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdj
L3BjaWUtdGVncmExOTQuYyAgIHwgIDUgKy0tLS0NCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAxNCBp
bnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5jIGIvZHJpdmVycy9wY2kvY29u
dHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmMNCj4gPiBpbmRleCA4OWI4ZWMyOWRhN2YuLjQ3
ODYwZGE1NzM4ZSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9w
Y2llLWRlc2lnbndhcmUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3Bj
aWUtZGVzaWdud2FyZS5jDQo+ID4gQEAgLTY5Niw2ICs2OTYsMTggQEAgdm9pZCBkd19wY2llX3Vw
Y29uZmlnX3NldHVwKHN0cnVjdCBkd19wY2llICpwY2kpDQo+ID4gIH0NCj4gPiAgRVhQT1JUX1NZ
TUJPTF9HUEwoZHdfcGNpZV91cGNvbmZpZ19zZXR1cCk7DQo+ID4NCj4gDQo+ID4gK3ZvaWQgZHdf
cGNpZV9udW1fbGFuZXNfc2V0dXAoc3RydWN0IGR3X3BjaWUgKnBjaSwgaW50IG51bV9sYW5lcykN
Cj4gPiArew0KPiA+ICsJdTggY2FwID0gZHdfcGNpZV9maW5kX2NhcGFiaWxpdHkocGNpLCBQQ0lf
Q0FQX0lEX0VYUCk7DQo+ID4gKwl1MzIgdmFsOw0KPiA+ICsNCj4gPiArCXZhbCA9IGR3X3BjaWVf
cmVhZGxfZGJpKHBjaSwgY2FwICsgUENJX0VYUF9MTktDQVApOw0KPiA+ICsJdmFsICY9IH5QQ0lf
RVhQX0xOS0NBUF9NTFc7DQo+ID4gKwl2YWwgfD0gbnVtX2xhbmVzIDw8IFBDSV9FWFBfTE5LU1RB
X05MV19TSElGVDsNCj4gPiArCWR3X3BjaWVfd3JpdGVsX2RiaShwY2ksIGNhcCArIFBDSV9FWFBf
TE5LQ0FQLCB2YWwpOw0KPiA+ICt9DQo+ID4gK0VYUE9SVF9TWU1CT0xfR1BMKGR3X3BjaWVfbnVt
X2xhbmVzX3NldHVwKTsNCj4gDQo+IFRoYXQncyBub3Qgd2hhdCBJIG1lYW50LiBJIG1lYW50IHRv
IGltcGxlbWVudCB0aGF0IGZ1bmN0aW9uYWxpdHkgaW4NCj4gdGhlIGZyYW1ld29yayBvZiBkd19w
Y2llX3NldHVwKCkgZnVuY3Rpb24gYnkgbW92aW5nIGFsbCB0aGUNCj4gbGluay13aWR0aC1yZWxh
dGVkIGluaXRpYWxpemF0aW9ucyBpbnRvIGEgZGVkaWNhdGVkIHN0YXRpYyBmdW5jdGlvbg0KPiBk
d19wY2llX2xpbmtfc2V0X21heF97bGlua31fd2lkdGgoKSAodGh1cyB0aGUgcHJvdG90eXBlIHdv
dWxkIGxvb2sNCj4gbGlrZSB0aGUgZHdfcGNpZV9saW5rX3NldF9tYXhfc3BlZWQoKSkgYW5kIF9j
YWxsaW5nXyBpdCBmcm9tDQo+IGR3X3BjaWVfc2V0dXAoKSBpbiBwbGFjZSB3aGVyZSB0aGUgbnVt
LWxhbmVzIGluaXRpYWxpemF0aW9ucyBpcw0KPiBwZXJmb3JtZWQgaWYgcGNpLT5udW1fbGFuZXMg
aXNuJ3QgemVyby4gQXMgSSBhbHJlYWR5IG1lbnRpb25lZCBpbiBteQ0KPiBjb21tZW50IGFib3Zl
IGluIGFjY29yZGFuY2Ugd2l0aCB0aGUgRFcgUENJZSBIVy1tYW51YWxzIHRoaXMgc2hvdWxkDQo+
IGhhdmUgYmVlbiBkb25lIGZvciBhbGwgRFcgUENJZSBJUC1jb3JlcyBpbiB0aGUgZmlyc3QgcGxh
Y2UuIEkgYWxzbw0KPiBjaGVja2VkIHRoZSBQQ0lFX0NBUF9NQVhfTElOS19XSURUSCBmaWVsZCBh
Y2Nlc3MgYXR0cmlidXRlLiBJdCB0dXJucw0KPiBvdXQgdG8gYmUgdGhlIHNhbWUNCj4g4pagIFdp
cmU6IE5vIGFjY2Vzcy4NCj4g4pagIERiaTogaWYgKERCSV9ST19XUl9FTiA9PSAxKSB0aGVuIFIv
VyBlbHNlIFINCj4gZm9yIGFsbCBJUC1jb3JlcyB3aGljaCBIVyByZWYgbWFudWFscyBJIGhhdmUg
YXQgaGFuZHMgKHY0LjYwYSwgdjQuNzBhLA0KPiB2NC45MGEsIHY1LjIwYSwgdjUuMzBhLCB2NS40
MGEpLg0KPiANCj4gKiBOb3RlIGV2ZW4gdGhvdWdoIHRoZSBkd19wY2llX3NldHVwKCkgbWV0aG9k
IGN1cnJlbnRseSBwZXJtaXRzIHRoZQ0KPiAqIDEsIDIsIDQgYW5kIDggbGFuZXMgb25seSwgaW4g
ZmFjdCB0aGUgeDE2IHNldHVwIGlzIGFsc28gcG9zc2libGUNCj4gKiBqdWRnaW5nIGJ5IHRoZSBD
WF9OTCBEVyBQQ0llIElQLWNvcmUgc3ludGhlc2l6ZSBwYXJhbWV0ZXIuDQo+IA0KPiBJdCB3b3Vs
ZCBhbHNvIGJlIG1vcmUgcmVhZGFibGUgdG8gcGxhY2UgdGhlIGR3X3BjaWVfbGlua19zZXRfbWF4
X3tsaW5rfV93aWR0aCgpDQo+IGZ1bmN0aW9uIGJlbG93IGR3X3BjaWVfbGlua19zZXRfbWF4X3Nw
ZWVkKCkgYXMgcGVyIHRoZSBjYWxsaW5nIG9yZGVyDQo+IGluIHRoZSBmcmFtZXdvcmsgb2YgZHdf
cGNpZV9zZXR1cCgpLg0KPiANCj4gQnkgZG9pbmcgYXMgSSBzdWdnZXN0ZWQgYWJvdmUgeW91IG5v
dCBvbmx5IHdvdWxkIGJlIGFibGUgdG8gaW1wbGVtZW50DQo+IGEgY29ycmVjdCBsaW5rLXdpZHRo
IHNldHVwIHByb2NlZHVyZSBmb3IgYWxsIElQLWNvcmVzIGJ1dCBhbHNvIGNvdWxkDQo+IGdldCBy
aWQgb2YgdGhlIFBBVENIICM1IHNpbmNlIHlvdSdsbCBiZSBtb3ZpbmcgdGhlIHJlc3BlY3RpdmUg
Y29kZQ0KPiBhbnl3YXkgYW5kIGdldCByaWQgb2YgdGhlIGR3X3BjaWVfbnVtX2xhbmVzX3NldHVw
KCkgbWV0aG9kIGludm9jYXRpb24NCj4gZnJvbSB5b3VyIGFuZCBUZWdyYSBnbHVlLWRyaXZlcnMu
DQoNClRoYW5rIHlvdSB2ZXJ5IG11Y2ggZm9yIHlvdXIgZGV0YWlsZWQgZXhwbGFuYXRpb24uIEkg
dW5kZXJzdG9vZCBpdC4NCkknbGwgZml4IHRoaXMgb24gdjEyLg0KDQpCZXN0IHJlZ2FyZHMsDQpZ
b3NoaWhpcm8gU2hpbW9kYQ0KDQo+IC1TZXJnZSh5KQ0KPiANCj4gPiArDQo+ID4gIHN0YXRpYyB2
b2lkIGR3X3BjaWVfbGlua19zZXRfbWF4X3NwZWVkKHN0cnVjdCBkd19wY2llICpwY2ksIHUzMiBs
aW5rX2dlbikNCj4gPiAgew0KPiA+ICAJdTMyIGNhcCwgY3RybDIsIGxpbmtfc3BlZWQ7DQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5o
IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmgNCj4gPiBpbmRl
eCA3OTcxM2NlMDc1Y2MuLjM2ZjNlMmM4MThmZSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3Bj
aS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuaA0KPiA+ICsrKyBiL2RyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5oDQo+ID4gQEAgLTQxNSw2ICs0MTUsNyBA
QCB2b2lkIGR3X3BjaWVfd3JpdGVfZGJpKHN0cnVjdCBkd19wY2llICpwY2ksIHUzMiByZWcsIHNp
emVfdCBzaXplLCB1MzIgdmFsKTsNCj4gPiAgdm9pZCBkd19wY2llX3dyaXRlX2RiaTIoc3RydWN0
IGR3X3BjaWUgKnBjaSwgdTMyIHJlZywgc2l6ZV90IHNpemUsIHUzMiB2YWwpOw0KPiA+ICBpbnQg
ZHdfcGNpZV9saW5rX3VwKHN0cnVjdCBkd19wY2llICpwY2kpOw0KPiA+ICB2b2lkIGR3X3BjaWVf
dXBjb25maWdfc2V0dXAoc3RydWN0IGR3X3BjaWUgKnBjaSk7DQo+ID4gK3ZvaWQgZHdfcGNpZV9u
dW1fbGFuZXNfc2V0dXAoc3RydWN0IGR3X3BjaWUgKnBjaSwgaW50IG51bV9sYW5lcyk7DQo+ID4g
IGludCBkd19wY2llX3dhaXRfZm9yX2xpbmsoc3RydWN0IGR3X3BjaWUgKnBjaSk7DQo+ID4gIGlu
dCBkd19wY2llX3Byb2dfb3V0Ym91bmRfYXR1KHN0cnVjdCBkd19wY2llICpwY2ksIGludCBpbmRl
eCwgaW50IHR5cGUsDQo+ID4gIAkJCSAgICAgIHU2NCBjcHVfYWRkciwgdTY0IHBjaV9hZGRyLCB1
NjQgc2l6ZSk7DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3Bj
aWUtdGVncmExOTQuYyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtdGVncmExOTQu
Yw0KPiA+IGluZGV4IDA5ODI1YjRhMDc1ZS4uYmVmZTE3ZDU3ZTJhIDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtdGVncmExOTQuYw0KPiA+ICsrKyBiL2Ry
aXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtdGVncmExOTQuYw0KPiA+IEBAIC05MDIsMTAg
KzkwMiw3IEBAIHN0YXRpYyBpbnQgdGVncmFfcGNpZV9kd19ob3N0X2luaXQoc3RydWN0IGR3X3Bj
aWVfcnAgKnBwKQ0KPiA+ICAJZHdfcGNpZV93cml0ZWxfZGJpKHBjaSwgUE9SVF9MT0dJQ19BTUJB
X0VSUk9SX1JFU1BPTlNFX0RFRkFVTFQsIHZhbCk7DQo+ID4NCj4gPiAgCS8qIENvbmZpZ3VyZSBN
YXggbGFuZSB3aWR0aCBmcm9tIERUICovDQo+ID4gLQl2YWwgPSBkd19wY2llX3JlYWRsX2RiaShw
Y2ksIHBjaWUtPnBjaWVfY2FwX2Jhc2UgKyBQQ0lfRVhQX0xOS0NBUCk7DQo+ID4gLQl2YWwgJj0g
flBDSV9FWFBfTE5LQ0FQX01MVzsNCj4gPiAtCXZhbCB8PSAocGNpZS0+bnVtX2xhbmVzIDw8IFBD
SV9FWFBfTE5LU1RBX05MV19TSElGVCk7DQo+ID4gLQlkd19wY2llX3dyaXRlbF9kYmkocGNpLCBw
Y2llLT5wY2llX2NhcF9iYXNlICsgUENJX0VYUF9MTktDQVAsIHZhbCk7DQo+ID4gKwlkd19wY2ll
X251bV9sYW5lc19zZXR1cChwY2ksIHBjaWUtPm51bV9sYW5lcyk7DQo+ID4NCj4gPiAgCS8qIENs
ZWFyIFNsb3QgQ2xvY2sgQ29uZmlndXJhdGlvbiBiaXQgaWYgU1JOUyBjb25maWd1cmF0aW9uICov
DQo+ID4gIAlpZiAocGNpZS0+ZW5hYmxlX3NybnMpIHsNCj4gPiAtLQ0KPiA+IDIuMjUuMQ0KPiA+
DQo+ID4NCg==
