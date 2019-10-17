Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04EDEDA3C1
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2019 04:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406934AbfJQCcS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Oct 2019 22:32:18 -0400
Received: from mail-eopbgr1400137.outbound.protection.outlook.com ([40.107.140.137]:15671
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389860AbfJQCcQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Oct 2019 22:32:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AOLTXdie2jbGcSB8wRzAu/x6RKKt9QIxrB7Pt0U7CzH2iCk3paXhv+uaD48mdtLb0QVRPblRGah7+rL7Aa/rBFIeuCBjx9ZAW+6iSK3HtvzVN9ebo0BuyPkQ1nouYaFjXBzVyAXmjJ3ilr4aHmAdgjhLCLN4MTQMq3c6MH8VM6W+2oplzy87I4cnY6AH2xThUy/0W3o0XiL1RlIa3JK4GlXEZ4bQ2ZJGNMvvN2VY4e+b7xCRS4TypowCB5Hff1IO0sK0GpwDjyTWNqkux4uRPRWMlzv9c/vFoW4SJyN7pCTuh9dCJNqXFtwo+k3cBUL1271xRSnJyz2uUGnSe5ecbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypibnnDy2Tltr6OEbpKVMxiISIXXNKDK5fG1Buhs8VA=;
 b=Z2+r/SQv2XUBkkeGGKk7xiN72fHWNr4lj97mY/HCOoyQ6YJy0MmpsvIkFz20mUoCjU9109B/kvS/1yfNiYeqb7uNHYypJ6QO/U/0D0I0TV2AB7n36FmvcdbNMSsFg4E82m4pId3m0oJ/9LUvJuuEGYVdO59qhY7aMUrgOgJLOuyzLk9iAkdrQGjAENYqS+FZ18zyfp3YecoQoQaEyU0RnnyYgtAuAmZwso73V1+xEPy4jAkMoo9vzuBw++4vJR7WqEFefHOq5gVGGiYuA8eGI8xcK/ucYlH+f0CPIyrbDLJrBa0cbbdOo85d3hzrdIuqI9DKkI92iJr0aBgSRJU+tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypibnnDy2Tltr6OEbpKVMxiISIXXNKDK5fG1Buhs8VA=;
 b=Axfwq3U59lKjdla6fPHs3CCkSmVIkJN3STLx8WdO/ScwSd7hUyq82jkgzyOC1oKQAu4llZ150J9I0zEAbzWLyTqECm8HbJSv//khCGf1lNJ2uEcN59ZGrcOHCzp3/41XnAOqBIhHaHkHa4kJOUTotBoER1NofJKac7CBrONtsHk=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB2960.jpnprd01.prod.outlook.com (20.177.102.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Thu, 17 Oct 2019 02:32:14 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::548:32de:c810:1947]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::548:32de:c810:1947%4]) with mapi id 15.20.2347.023; Thu, 17 Oct 2019
 02:32:14 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Simon Horman <horms@verge.net.au>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] MAINTAINERS: Add Marek and Shimoda-san as R-Car PCIE
 co-maintainers
Thread-Topic: [PATCH] MAINTAINERS: Add Marek and Shimoda-san as R-Car PCIE
 co-maintainers
Thread-Index: AQHVhBm2hDyM+Q9Dm0i41nHHfxWio6deHaEg
Date:   Thu, 17 Oct 2019 02:32:14 +0000
Message-ID: <TYAPR01MB454495E9D84990F00AA9BB3DD86D0@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <20191016120249.16776-1-horms@verge.net.au>
In-Reply-To: <20191016120249.16776-1-horms@verge.net.au>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [150.249.235.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5cb7170-89e3-45c2-5dbd-08d752aa3879
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: TYAPR01MB2960:|TYAPR01MB2960:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB296055C2142DABDD75054425D86D0@TYAPR01MB2960.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01930B2BA8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(189003)(199004)(26005)(186003)(7696005)(86362001)(99286004)(478600001)(76116006)(316002)(52536014)(33656002)(110136005)(4744005)(71190400001)(5660300002)(14454004)(54906003)(25786009)(102836004)(6506007)(71200400001)(66066001)(76176011)(4326008)(486006)(6116002)(3846002)(11346002)(446003)(476003)(229853002)(2906002)(6436002)(256004)(74316002)(7736002)(66556008)(305945005)(6246003)(66446008)(8676002)(8936002)(81166006)(81156014)(55016002)(64756008)(66476007)(66946007)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB2960;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +0QWIFcKDD07O4i856xK2FMaMQSBiC+R7v/8TEREebojkOvsTpPj9+rYvrU3e4cNiRLKOoMjMpnWfQeeVsFIpt2UBE/4mRTBIf683TAFk5D0npc3m8GNChrHv4xThR2vQgUSpus9h1Mp3UNBfMKUY3Lg5kqKz4c5HWQl0x+o13d2QIZdAD/A1gbX7woG7/BFXAVsR0ikPtbcKJXTbrAGyUsvoz7h1/KVbyAIKTruXplkBKYE6Qj1njqZobdEDGlT/0xPoAGNePguTY8+nKBQuKZd4zKc1I7DRgc+vdnWk+f6RNL+84/8DNV7gFWMsAnDU/YdQVIxHpCcp911Jk6xPcXDkV++qQoE4NuQLbvT40Nv5LGzodfbNQOkAfBirTIRAcUpIR0isGtIMb39mbE/DOoEuow6S/EPcnSteklBiQU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5cb7170-89e3-45c2-5dbd-08d752aa3879
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2019 02:32:14.0471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lojHi/RbjhxXkmb6Tepxkf1riaSYtXD0JqbCWVRhtdOH9IyeFum+Nqfb6Gm+zV0KfNVpUshgrdaALBN8P/X+/JQfMNPrB/NFUqflAp2cmCqrweSoFT34GwzAyeLIHq/4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2960
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Simon-san,

> From: Simon Horman, Sent: Wednesday, October 16, 2019 9:03 PM
>=20
> At the end of the v5.3 upstream development cycle I stepped down
> from my role at Renesas.
>=20
> Pass maintainership of the R-Car PCIE to Marek and Shimoda-san.
>=20
> Signed-off-by: Simon Horman <horms@verge.net.au>

Thank you very much for your support until now!

Acked-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

