Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792E823420A
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jul 2020 11:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732010AbgGaJIS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Jul 2020 05:08:18 -0400
Received: from mail-eopbgr1300112.outbound.protection.outlook.com ([40.107.130.112]:3296
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728437AbgGaJIR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 Jul 2020 05:08:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SpFvtDHQxCGg7cINZIGnZkvlMAFjKxbESrkPPaKdtJWIF/o3f3PP6OI2FUqhOcRzo8HzpZEpuYJGNU0aavmo2WuBsovtcMdYKpkpjSK8Hgklfzvsf2K2DYguEiWADEvPGC92gPWQOZ0n+O+gUSLoevEU+tovQYloT12DZKmeouGgcw9lqNjbl8w3B9Wr7LbYbOKT/Cshmr+Da6dvv+c9V6pqAu5qK8wnNtGKxYGH+Xrs7/+droE/1KJmarlaKiIeIDXQQqCqoi0u/B2yxVHu87LaLq5OMAXRZ9YbKUchfsmgfu5Ih6ss6wbJnwgzuNhYD2EBwdpYs6EOgunBrzrDYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZe+GeX8gEp3tpKSIQYaiQmaKoTTBNCq9uZ9jj4YTw4=;
 b=bmEYOQyhQcF+T0Nxg/KuF9pHJI3JtQsT/cY7Ne8mDK48GUd/SZDR7HapsrDBxaoXb5hpAn0wTQqnR7lorzQBXw8AmT4SjqFq+gcWKYf0KXAHdoGc7kpnWd/n0mL3xvKFSYubPQPqVuUUomdveILM9kmdXxhFj3cmgUGrDSnTTHlKX8WThV+EgtA7Aooa/Yy/agfKNEPChIB/br428pdezmiYP44xIciGEwqes6MJlMSyqFJbot+Cwb19yOFxHkHh/3Zm2GcpCsl/uPWnJVFdvczkdaFq8pFxjFMaNXL7jyw8F1NqiOR0KhgAY0IOxbWGos4SlUXKX6qPpQILNKbAYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZe+GeX8gEp3tpKSIQYaiQmaKoTTBNCq9uZ9jj4YTw4=;
 b=N62qO5wGMDAZHI0muPlDlawZ6RRHtlBuhCKskfifd/rPxKg2UDdiCXqEZmAiJu010ZvsZiKWqrtP8UMPL+E41PEhOUDyzIWYKmJ0Pl84gH7XuGOR/Ldngv80xDt37bHPhZi3s7zZGdW3YhmrTXnC2qNzKRw+pxR2wiabA7j9EUs=
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com (2603:1096:404:d5::22)
 by TY2PR01MB3515.jpnprd01.prod.outlook.com (2603:1096:404:d6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Fri, 31 Jul
 2020 09:08:12 +0000
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::9083:6001:8090:9f3]) by TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::9083:6001:8090:9f3%6]) with mapi id 15.20.3239.017; Fri, 31 Jul 2020
 09:08:11 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: RE: [PATCH v2][next] PCI: rcar-gen2: Use fallthrough pseudo-keyword
Thread-Topic: [PATCH v2][next] PCI: rcar-gen2: Use fallthrough pseudo-keyword
Thread-Index: AQHWX9dxg3v+SSLQ3Uetc/hFRqLsz6khdGEw
Date:   Fri, 31 Jul 2020 09:08:10 +0000
Message-ID: <TY2PR01MB369218139A78BB84DB6B2FDAD84E0@TY2PR01MB3692.jpnprd01.prod.outlook.com>
References: <20200722032851.GA4251@embeddedor>
In-Reply-To: <20200722032851.GA4251@embeddedor>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [240f:60:5f3e:1:7d28:3e82:377f:8a0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5d623a29-132d-4257-4963-08d835314034
x-ms-traffictypediagnostic: TY2PR01MB3515:
x-microsoft-antispam-prvs: <TY2PR01MB3515BE6E83C386B42C5EC7D5D84E0@TY2PR01MB3515.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lplCsK/T9b29Boqiod+W7QaesWeguRnsEM8UQWkiaGp6O2GPtOKBDjrRh0IzkJR+NJ+e7qCFyjwKnHhTDCSRT34m1LH98obSQ5VrWetz8LPtdlePDcnLiaHa7wh5mOzLlfCydSQ8Y6GhVZDckTLzSCwF4cJ6tGmUj5pqt75PlgLySMPFZvpPitoN6HwOFw0fYzuyayUTc1JSk98CgJoH4Ftzd6dGauYYfSm8Va+1GhosmAzwzO9P5yQS5I3hPT5HOgiP6SnPOVfe2h9epjoZ9J4fg4f9EdhfVcynhnL5DmDG+9ms/5N9UusLPOVsoleT1DLXn1q4kTos5bxwEKmAn1vYXigBFGL3ut0V88+gt/qoNMYrT96omlDoMdUOEiSfx6uTZXALneDbr8+ZnNvCMA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3692.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(39860400002)(346002)(366004)(136003)(33656002)(86362001)(71200400001)(9686003)(966005)(55016002)(110136005)(5660300002)(4744005)(66946007)(66556008)(66446008)(76116006)(52536014)(478600001)(64756008)(66476007)(8676002)(54906003)(7696005)(2906002)(7416002)(316002)(186003)(8936002)(4326008)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: S0mWKjs+hZjnCkWiQQ+x6uq+rGrVD72haST3vhF/TH0GjfkA9Ckhh8wowOqqIi4lCcWo2h5f22qR6DqU5ywvS90FjMHqcXQqXQOLeXqNs5BVnOTYQJTDr8oILfl5vfaTEQZF0GE/ncra7SKQ5ijkQ+fXJcRaHgwtb6/BOTE9BteUq/QXCssfUJmtL9O+q8vuGJP4IGSSDCjyKN17DegkI3/lYUD/FTatelrQEj8CLr8M+3abKzvPZ1vvRdBXb8x7toIWmpr2NJprqzNcMvhBpZHHcOCirxhcQRqdQDVz5L3kzofLawHECQyCocveeiN6JzGqIuIcf/12scNlp+eUxOJW8llPvmJ0GqSG6NMTQDUSqbdY6k5I2wdfbdLAFhMTmm81PY01defnY6K4YQoTqD4d8UiX6dA7dSDnk6Q/xB9OLwP/4Ks1rLEFK1piHBtb0t/FNtgdMUW9vuTktJ0LSX47R1zqeLKUxERPjLtNr0XXpH6DsPfHZZoRNA3GtdOid8UFR95Lu21waHZF7JnTF5nnHP+pn0isIrQ7yCHetq6Cdu1n5WJ+cL0+XmgsyDngef5e62yskEt4WBhWJdN/k3s9Fih3PoJj421d1yKwA742OJaIHswwGhVc7MenDVxomc1PaKZnm5PE0pcT4htD27CF88VGD1vayZoNkgeAhyJJHKpNY6up1o/x6SPDbIB+RJxR4I2pOVE43tosZ+U0wQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3692.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d623a29-132d-4257-4963-08d835314034
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2020 09:08:11.5036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b55ULJNfF7qYu2VBeYMQMj2W8zH0/gEZHrSMWt+2uEu2HeJEu9OD8KxenVAyGvImVdir2rTcdtSYmnc612W6dVftlFIRIqgKisOXrzuozzCAx5XWx1I1G84kewRruhDE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3515
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

> From: Gustavo A. R. Silva, Sent: Wednesday, July 22, 2020 12:29 PM
>=20
> Replace the existing /* fall through */ comments and its variants with
> the new pseudo-keyword macro fallthrough[1].
>=20
> [1]
> https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=3D=
fallthrough#implicit-switch-case-fall-through
>=20
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thank you for the patch!

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

