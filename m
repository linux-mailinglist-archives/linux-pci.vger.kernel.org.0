Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42672A5BE5
	for <lists+linux-pci@lfdr.de>; Wed,  4 Nov 2020 02:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbgKDB3B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Nov 2020 20:29:01 -0500
Received: from mail-eopbgr1310112.outbound.protection.outlook.com ([40.107.131.112]:49408
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725769AbgKDB3A (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Nov 2020 20:29:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LOOQ6PUo3LLmzFFfEHQ2mJfH+UDudprdMgJxvcN8EtR2j/zPcz6UzkrQ52lxZHSKwQA6x1uAb/f+MBq9jcj1kDjvh3TC2NT3BP2u4lIZQSVDKKHVTfk71j9/Q8lJDDuL2vxJpWA9nArrotwESmo8FEaWytnhN1tgp+EC0Fc7rOEF9Oy5WFq8Qq2fDm5kZAg/oBx0Ek6xbNKtghE46tRyfYxFcC06cvKNZ+Ji8GECJCwQpSLpMlxK4Xwp3KxWnypqyvI1vuB1nwHHzsK3sOnOZpAsG7kZe/3xGwhh7dNSkrwDigDPFgZsFCId50gWEoYkpv1D2hwhLWyC/0DbgCj9vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2HwTiNADNDEmsJDSmXFMXW8BMhtyUy8XB3DH5v236Vs=;
 b=ZKWMcMeD6suK5ZV+S9ACszmIdyhgFgjysEzQ3eDNS09YiQMOjbYXYsinPk3Ar0vTGRr2tCq5Q7g0d3pVcpxuzkJGMFBQdmZSzXrE+CE1ecshJ69bdYkKxvtsKdgmXrYnXSS6q0Nou/xleCJB5OR42xp+HQxMaAFSj2QHY7BV+1y9nKGMro/p+KbyFWIeEeQ7xLZQb+XgYQqG8ASk6RPN2BtaQeDbtrV+vvWgra4MtLdc6sXXCSJrQZf7wfC9we56x1HkisCVjl4AQuitHYuN0zLEN/tKXbVYsyy8H3eSXon3SxWuf83iDe6U5PhYssMlOXtDrK0+iY2V2xcB9bS03A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2HwTiNADNDEmsJDSmXFMXW8BMhtyUy8XB3DH5v236Vs=;
 b=nLuDFEybflRfwdnR5WMUNsZS6a6BKv/4B3HeJS8hHXiVltGWS2uiMFQa2nb5VfKFWvGpGho0qoD1QWbgW4K260rAF0CiaumA7QKb9gmpdQYf6bIUQKWSeigVbUIhff0zWQZkZe3Y7e+dB9vuflKz8e06TC+SfbwI1g0ZL+Qajfw=
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com (2603:1096:404:d5::22)
 by TY2PR01MB4297.jpnprd01.prod.outlook.com (2603:1096:404:111::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Wed, 4 Nov
 2020 01:28:53 +0000
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::bcba:dccf:7d4c:c883]) by TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::bcba:dccf:7d4c:c883%4]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 01:28:53 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2 0/3] dt-bindings: pci: rcar-pci-host: convert bindings
 to json-schema
Thread-Topic: [PATCH v2 0/3] dt-bindings: pci: rcar-pci-host: convert bindings
 to json-schema
Thread-Index: AQHWrn2ZTuZqlcxICUCkXeL/kgB1lam3Bt8AgAAvj8A=
Date:   Wed, 4 Nov 2020 01:28:52 +0000
Message-ID: <TY2PR01MB3692B8B4DE36B15EC56A6C41D8EF0@TY2PR01MB3692.jpnprd01.prod.outlook.com>
References: <1604035745-22095-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20201103223736.GA271290@bjorn-Precision-5520>
In-Reply-To: <20201103223736.GA271290@bjorn-Precision-5520>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [240f:60:5f3e:1:184:fa7:6262:a02c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1cebf41f-41c8-42ab-ded6-08d88060fd82
x-ms-traffictypediagnostic: TY2PR01MB4297:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB429737C6D756FDFAA1F02BFDD8EF0@TY2PR01MB4297.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PtCkEBgFkC/oeKGXSdAsiCPKUSVLiisDx3HXNkI4TM42NF00zR5YzFOzkyijCXJfDRWmvvhuGbkSqLID2O6l7UhGHv5l4Q9Tw3owl7YzqI2Gs0hLA15zr0p8HBFcPxXSTy20/LSONE+vnZyKNEvkKjImYMqhbNxFHTn5+sTucp9HSctHrAXVES4Z+cwFFaBHvEFfzK2oDNQt/tXd1u3c3Z8NfXIAc/srZlaI4d7lEHthe2lr23IerYylub85z12j9zJ0Sok5v0skqbgb4dNGD2GvzmKvmzdVn8nonQpZWtEXbt/Zq0RiM54LnnVyBczJChxuhDyurAcaHawsGmd/FQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3692.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(2906002)(558084003)(55016002)(9686003)(8936002)(7696005)(54906003)(316002)(71200400001)(33656002)(8676002)(86362001)(5660300002)(52536014)(4326008)(66556008)(478600001)(76116006)(64756008)(66446008)(6916009)(66946007)(186003)(66476007)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: i2cg+d0b67wPMhhVrwh/RAjU4C3u0QIyfVll3TUmir8qOtgGifaqSZrPcxiG1UU/sb2o5WiQ+O44U7la0Ryfq4b2AL8sFtcEzGYYR98AB1fJ5HocSl1cZ/lCe3CYF/ftl7ez8ElZJRFDIpKLaYOzOHRxh76mg4rvOc+ebs3vhch6/iLv/pkQwlJctP2KvRkfIEhVvhRlM1mDMIEQ/ri2d5fMNvfCuM95bW5/GG1wrmmcXvYPvd9Xz1xkx8uMCB0ZabOnBmm5i19L3SQ7kPtliFOAGjuFdlhno0+P7xkMoUpUFOLPTdw6f7c1PjEp4X9/Hz60PXer8q/Q6oqVGkUdqA8wh91GEU3vkJmB1IWRdOTD9U0psu8TIv43pWajq8dzCDCCqANabJbArjoITLiNBPYc/wtuqrTCzlT2+qCgJ0cVIuPMxQ9rh/untoUzmBwd1ddLarNe+iA5bZvKWTbXYJNy7azaVy6R5ZUgKusKGIiBJCUul4b9kTv1fOBjC3HluMgrcNhiUAwVN4R3a1Z5ASPSieaAtk4XHHOTL1hDzMm5NOnlfOVX9ETpQjuCvsp+Cs5+wjZ9ZNIn8ahPFDaVDm3i2oHibQMru4cF1N348aWjl9+KytkuEbL32HnHnk3/MMRAa3exe2hnhQG7B4AhFbl/JtfCkWh7+nipUZED+hiEOl/T68y/7FcmpXMgWAN6
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3692.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cebf41f-41c8-42ab-ded6-08d88060fd82
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2020 01:28:52.9754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gr4auOxRy6mbldilImjoSHyOfs0cofCxJIaLnnJm+ag//9kf7aYmvGD+FwCSxwDuAXc8MGPokOwX+DIe7hPjWFm6ncdmJ0+HQByDZouqH25hwwSFGCfSQ54FOrmdiTOU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4297
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

> From: Bjorn Helgaas, Sent: Wednesday, November 4, 2020 7:38 AM
>=20
> Please follow the subject line convention, e.g.,
>=20
>   dt-bindings: PCI: rcar-pci-host: Convert ...
>   dt-bindings: PCI: rcar-pci-host: Document ...

I got it. I'll fix these subjects.

Best regards,
Yoshihiro Shimoda

