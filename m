Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC176CCECF
	for <lists+linux-pci@lfdr.de>; Wed, 29 Mar 2023 02:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjC2AcO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Mar 2023 20:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjC2AcN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Mar 2023 20:32:13 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2130.outbound.protection.outlook.com [40.107.113.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5495187;
        Tue, 28 Mar 2023 17:32:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9jo7n3p7iyjoLY8pUIlzSxEJwp1mLECcNmW2bbxvwVjFXg01TXotGXv1oK1tmPHsRNtDNlx3kADXosuWdAAyd/uOq0sV2KXcDU6G1hguh3ZCeCbyJoS6Zs5TZHp5L5/PIPZW2t2h4KLYHzakcdksHPFMpJKClGlgxQY+6btOWPwuUhvD2lg6lkov+txchQ3FAm5E8tb+Uba0qyrnhONR2h6+vZ6K/s1zP+rgdbifzw6OTzAIxys+PyzlVL8zkdeWDiiiKW94TvLS0Oq07/O244U0sRwSPvreO4RLsMEqoraoIAP1C3cq1mGHy9jFtYNpEF4wHDYhEv7sl+WVZlhUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qKU/z5virGwwiWL9s+ZX/7/x/kigOlki6jRHBza9nmA=;
 b=Xg0f2jII3DVB1iy9HKjchfYOYMCeAxR+n0olWJ/Hg3VnkMAinm1pV28vQXlnyDoU1ZvnQPubPBmpI99uk+KJDFeGFtms+wEBxjiZWByxnM8aF63VJbnbseUyG7TLpM0qJFQrgOHENF6ASseU8YIFYCv2hzPceiH3Qn6s0As+rNZFZWCO19DXhDvhcVSxAfqKVCwWPoWlb7d3yBhzwhOumL/Yo21AUWnSw30stCZVYrEAkw3ObBeUruycGotrLY4GfV1lqYJb8+pCIi8d9tYK41pV5gNe9LrQRvUGl6CO8mYFKzQGQIVtZ76zMzgkVq+0Ub99Lkva2nosRL43B7D4yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKU/z5virGwwiWL9s+ZX/7/x/kigOlki6jRHBza9nmA=;
 b=R7Sy99VpeziD+vezCSjzqJMtv9GBArRR/zoXCyuaoVjJt4zK/1V2XbmoeZCqFPamIr5NlQH6ph9lgu1tzALXnjT1MHQBTk1s5xdGbD53JuxdbmiemZBQLeXI71MO3L5PQSgmDLqmXjeTS6gD8Y3IvHhltsirpVFjAkttONOmM68=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYCPR01MB9520.jpnprd01.prod.outlook.com
 (2603:1096:400:190::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.34; Wed, 29 Mar
 2023 00:32:09 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::ffc4:2acc:f9ca:1633]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::ffc4:2acc:f9ca:1633%8]) with mapi id 15.20.6222.034; Wed, 29 Mar 2023
 00:32:09 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] PCI: rcar-host: Remove unused static pcie_base and
 pcie_dev
Thread-Topic: [PATCH] PCI: rcar-host: Remove unused static pcie_base and
 pcie_dev
Thread-Index: AQHZYX6Q1aA4RJWrp0+wU6uATepxg68Q6G3A
Date:   Wed, 29 Mar 2023 00:32:09 +0000
Message-ID: <TYBPR01MB53411AAB513802B105ACB3DED8899@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <94b369447c38c478c52aef10e493b658a4f755ac.1680011974.git.geert+renesas@glider.be>
In-Reply-To: <94b369447c38c478c52aef10e493b658a4f755ac.1680011974.git.geert+renesas@glider.be>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYCPR01MB9520:EE_
x-ms-office365-filtering-correlation-id: d0e859dd-b244-48fa-e813-08db2fed0815
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ftnaLXrb1zG3lOZPA1gzFetFORV/PaKnp49I+QYv2H+NKJ/INc6lpCiMJbdv/zTaE7SxR2El7br+3Ckly/Aj20bxOsap9voRKqqB5abhhiTnOx/GAAtur4fkvHtsa5k/SM4io/HHlJnXZ3RyJgFR0485wmxd+WQDD59Pi8yJ5mJo4QymWEGB60jcz3hgEI+QPkN3aQssG10rDtyyB6At3Pr9MdQ61WV9sb2X5Kwi3GQtYS+KlZ1a7z5qR0T5owBCp1t+EcKowWriIKq87teAFhNrAetOkzKFdx7xZUw1LWh2DXRWslIUxIrhdlyuU6Hei48l+Z+AJpY8LjmxB9bEJR+gCnITn2s4Jk2z+yN22w88CcmA05wEyVuvhmfjT/1qrRad+1R7FBLBVsMHnsIt+4sC0zbAbmTlciVDGx9CI/wMp+noe0mMmfBRLT7u2DIqyFl5U/uyCx15AfllP789q30FZ/tQoQMcWSKYl0PZMoFxQCx/lec5YW8Tt0bcLscgNuwmgQpiDejVfbscLdwj7IjFq+n0UrB0B+N57+Mk01YxQxd0/ooityapqoWkkO9awaRUJ8ly2ejgLBkOo8l+e6cBfyZdN5+O+5IFh9LO1tYwg0imniYnY1hvKS/lIgB0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(451199021)(186003)(9686003)(6506007)(7696005)(71200400001)(478600001)(76116006)(54906003)(66946007)(110136005)(316002)(122000001)(52536014)(66476007)(64756008)(8676002)(4326008)(66446008)(66556008)(41300700001)(2906002)(8936002)(5660300002)(33656002)(38100700002)(4744005)(38070700005)(86362001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?UsyDXssyjp70zU5AeS7USyJ2j7bkn5AiwknXkY/8sqDZjRGEdkTsncGJ7s?=
 =?iso-8859-2?Q?axkZlB3qKfOvCznVKwNxyiq7Aw4sKyoVC3e5nrm/SN/mkQKCMKhdE2WgdP?=
 =?iso-8859-2?Q?0vTi41eq4gwETKsaQgLthsWXmnzm/SA0uavaaj284uuTsBXhDg8iZjuFon?=
 =?iso-8859-2?Q?DCXAhClgAqNBqCsdaqLrR0Gl3rAqiOEncGMrt/2H/TDGLJWsR1Nvg5xPE/?=
 =?iso-8859-2?Q?+qFCjaKbzrVEM0ybkK8dLzi9utSYOoYQu7nVnzS5rLeZYt4aBdq5IqsCzm?=
 =?iso-8859-2?Q?XlITl8BYaiu0xXNAFF1ugON7LKLA1PT4tj5JOuG892Q9mS+P2iJC7v53OU?=
 =?iso-8859-2?Q?v5S/4ibspeRMj+jR+N9iMBdKRDDaYJCmmshb7tMK/dlsxMfbW2dbe+UhWo?=
 =?iso-8859-2?Q?5aJCgPn3e5TAg/fzkdSP2+m3xx3YAcmIHsog3dPnH00ubLajd4x2PISHmo?=
 =?iso-8859-2?Q?rGj/BVRS3yvoMRfgjIb5BX+zrqJNB0tfGdDR9aMkd3THu5UerwKrZBzobx?=
 =?iso-8859-2?Q?1BALMV24Qre7DYO+hgIyqxZMln0PDEMAjZ/C/Bvhs97SwbWNoQGeIAubVl?=
 =?iso-8859-2?Q?kqm8gAelE3jFKYANdrU74TKrBBrHH3e3rzuOBuzbwAIimFOp5r37U3bAv9?=
 =?iso-8859-2?Q?04UtBe3NBgcOH7WjCAOeOCozlJ03/oMqdIGr+1YulVyhE/WvHWYDM+Galo?=
 =?iso-8859-2?Q?N4WzXMc4nPnB5MFjfRD5AZXZadaHGea6AAICQzoBzvql9Z04ttABurEa2q?=
 =?iso-8859-2?Q?6LSS+x88w/wivMRQS9DHQhyymulRAofCrLV2PTIsjLQCRg8WfoRCPZPl9g?=
 =?iso-8859-2?Q?KTW+2ITlJDiUiIlljHAIfvJjiIqjAhAsaDSyDlVO+/XBRSHstv8I2OvDB9?=
 =?iso-8859-2?Q?ekLVFaLzQXfwLamYW4ab604hKAY+8yhys10VLd69fCwt/mnNA304aB43iU?=
 =?iso-8859-2?Q?RDpcis7584hJ5xgm5XwSrnkZNCAJws6nmIZHHjS7oxorhlLYTyLWQpBn/R?=
 =?iso-8859-2?Q?eIAOQBINhx1Ux7HWHD/HEWpLYKC2gNYvNliGSWKWmsKMsVh6uz6IlVG4/f?=
 =?iso-8859-2?Q?CuO0707SF81/7gO1m7kyXF8Ek8EaEJz0EoIakC5TmmHpMA5QaPZVBbSDSP?=
 =?iso-8859-2?Q?wVOjPDEsocp10Nlkd9XbBTLL+VmGGnPlUtk+DfWwYWL3OhqRYg47HlBLFb?=
 =?iso-8859-2?Q?+JIhpd8NroNz65DtfxJ6PScYUgZ6k+OZdzm/rGIwF7ANzn+1yMKD3AAWoc?=
 =?iso-8859-2?Q?5vbHDY7KZTDul8UeTlDhVLBLWG5kQeX/cKd077MD18Mv4+qKpTPdBSSiUM?=
 =?iso-8859-2?Q?ppNgr7FeLvDkeH1ma5Cbv6JGWHkJXX3w9x5VXhfhZBC0Jxry8a9nD5XpNc?=
 =?iso-8859-2?Q?HxnzrZavJqxTBSqX4HVwbk0gZQTMU+PwYMGrB4m2bqrp3k5dqj7zR62UZ9?=
 =?iso-8859-2?Q?5UW4meK0uanOPI4ISG0AJMYvQnK/LOjJPG85TfB6T1XDASgdIp3WcmypCL?=
 =?iso-8859-2?Q?jm4q2nKvYmXPyh1vxrxqMcSjuyDG58m22E0NNdFe+cpmgzHI8D6fcPRrC0?=
 =?iso-8859-2?Q?h3WuzaIOsE07RwOD8gYoe+35kx/HR1kRohA/W4qAigdRCRHmE+CbvObPyy?=
 =?iso-8859-2?Q?paHjftVaLWEPtwLRBC9823bNmQEMmtc+mdYz1FKuC83dboOd0bjZoSTMa4?=
 =?iso-8859-2?Q?1ixWz83ZUXnUiWlTUIaeU1tfWMbPs98mN6vlTweLuv07ulEIemhC1/PYc8?=
 =?iso-8859-2?Q?bpqw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0e859dd-b244-48fa-e813-08db2fed0815
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2023 00:32:09.2168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2CVqPJuZQscf6yI++nNo6eaU9g0zoJq+KSIc/CCvsLkNjOAv4UXUVGIIsia4JkSCPtwukXuvDCVWiJR3gpJ2FKJsqVipSmfev9hum/8hc+tOky7BfSnC2N4MebTb5FFh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9520
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Geert-san,

> From: Geert Uytterhoeven, Sent: Tuesday, March 28, 2023 11:03 PM
>=20
> After the L1 link state transition exception handler rework, the static
> copies of the remapped PCIe controller address and the PCIe device
> pointer became unused.  Remove them.
>=20
> Fixes: 6e36203bc14ce147 ("PCI: rcar: Use PCI_SET_ERROR_RESPONSE after rea=
d which triggered an exception")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thank you for the patch!

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

