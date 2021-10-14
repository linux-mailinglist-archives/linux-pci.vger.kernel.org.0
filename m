Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A17842E2DC
	for <lists+linux-pci@lfdr.de>; Thu, 14 Oct 2021 22:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbhJNUmR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Oct 2021 16:42:17 -0400
Received: from mail-vi1eur05on2064.outbound.protection.outlook.com ([40.107.21.64]:14464
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231534AbhJNUmQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Oct 2021 16:42:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NAGc1FTWpuWDJ4GVwMtSBRrnjSWvWEVioE4SnIOCvguUxCRtAspb88414oXqB+MUZ/TX5Mq3ERp+9p71j9eAYIGkkVRVeVj+fic8zbBRSaw/J9RlB9Cj150vfD8IjE1EY8ovVtaM3PwJHvcdgL7lthncYTzBpBjyspBHbDBV9AemDoJzC4I3Ode0JVFobbwBD/ADmfn8uYU6syWJYZ2+TIoFcyifmfh5d/2BA8gpOd/y2tXSuHGufFajGckUDnCArmjE5y6J+HCMbQOz+eo4Jk6pQsXE57EQJZx+rWyCBlzOi9+rkj7jX7hep5I19/FaGn/WZSGKTJIVGjGJ+MkfWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUqTUlNbctrLmZVNpXPPjC6t1mEe1CfbLxWBa2TG5uw=;
 b=Z9GFpBeg7ycmYGOWcUBdJLhHizMZOnxSr6MuPck3tcJMXoJW4MP7QpeRDCwy8CrvJJw5CVoQiqEVXWreaYAThDILsVtcNoeNUxQ5m8eCjNEPY/gTkAv3zh9tUBUGDMwIfPxJXQ1k/0WDNb5ebN7CTYvKS+rClc6vK04bBIgTCjHmNpXoi/hXyFhYfPJntBhOIcjzX9yEfW+P2Ao/DIE3+/AYcmZVsE8h7cJv8iMrd1bnBb5ItGquxZqQ5djLylBNqa80HdAbgYa3cBsN+SqM0j+WdsAgHWYw1zPAa1JoOtQKYSiu/m76M9wYHQzOWR8kRq9vEZkcDhkbcWRIXJcL7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUqTUlNbctrLmZVNpXPPjC6t1mEe1CfbLxWBa2TG5uw=;
 b=iuWaoBxI+kJ4I7VFah7VB5kbE6n6dvkZQ9j1n5IvsYtAWbRcFDDZI6r+iFa8oYs+3ijEfgxPoOY2vAoVpenNteOL3CSYiDNmkZVWCfSRWew63K6YtJNmlSDvBSJ8+4xnuoJ/EmzxaenOXIgictup6fk3+Ismp6NaKYty6QV1GVk=
Received: from AS8PR04MB8500.eurprd04.prod.outlook.com (2603:10a6:20b:343::14)
 by AS8PR04MB8852.eurprd04.prod.outlook.com (2603:10a6:20b:42f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Thu, 14 Oct
 2021 20:40:09 +0000
Received: from AS8PR04MB8500.eurprd04.prod.outlook.com
 ([fe80::cc48:f7ea:188c:682e]) by AS8PR04MB8500.eurprd04.prod.outlook.com
 ([fe80::cc48:f7ea:188c:682e%3]) with mapi id 15.20.4608.016; Thu, 14 Oct 2021
 20:40:09 +0000
From:   Frank Li <frank.li@nxp.com>
To:     "kishon@ti.com" <kishon@ti.com>, "kw@linux.com" <kw@linux.com>,
        Sherry Sun <sherry.sun@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: Linux PCIe EP NTB function
Thread-Topic: Linux PCIe EP NTB function
Thread-Index: AdfBOZgtLzEoMbYXS6Ol7OT0aw0WZQAAdtXg
Date:   Thu, 14 Oct 2021 20:40:09 +0000
Message-ID: <AS8PR04MB85008E09EAE36DFD6A51F4B588B89@AS8PR04MB8500.eurprd04.prod.outlook.com>
References: <AS8PR04MB850055DFB524C99D64560B6188B89@AS8PR04MB8500.eurprd04.prod.outlook.com>
In-Reply-To: <AS8PR04MB850055DFB524C99D64560B6188B89@AS8PR04MB8500.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 524a0b0e-0e83-48fc-c8ee-08d98f52d048
x-ms-traffictypediagnostic: AS8PR04MB8852:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AS8PR04MB885282F0D4DF906D2C04593C88B89@AS8PR04MB8852.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z6RsrKvzvqVw/8Sog6jF9vUiO+zFcVeF0OlpgCsmhJ/Loc29qe0CCjUjozoqa5EexMJGFNc2+V77yY/sk+yxqVrrJ5vvGvCrO0nNUWUREmBYNFu024PXlD5vtdCJTWaCrAuu28+zUfRcAtBWIu/arXDoFaPncYRUxVMuc2uAHl0OdxuUrcMR4Pw1sRQQdHGNO+yhfeIInH4o5EcR4MR/jxA6UyguO2f29FYut100awAG0gYGYa+lT8TX3G9zxnbZtCtgtX8e8ZXimCuRDI0I0oiVgOxZxHGQF21TC+Q+/EHTFDjbdkwUbczi2SUN5SBf7+JhySJDfsOEsshzYNOnCZsPSznHaeo49TOqebvA/3BY83acuSmVLQyJfYProxY3deDaicgmQF7h9XZyjx1KkyYT4MkC5xzizTNs3t51rB6Rm6KNHL6WCov14xH7e8j8Qn4v/rkfGmopQIEjy22+s+rTdKaktVGCfAI9IBLQr6jnaY2s6etIKh24PQyl1Iseud5Eu78LCo/BPzIhLgD/rP9wgVwtJu5ShNI/PqXaQZzc8MRW1QDCv6Hbg/5USCgOHbf9/2HRuLahndyFBE/ktEp0BNmpfmzn7DWRtRSHXnvx+yYqcC5YHWtx8xfJhLvdqVZTmMcJznzRUw34gDnul/d2yoyMIbq3zZ2r/uO6qzrKF9rFFbpjnU1Co+wnAYVR3/lTszhmJ3GnoaubDUZmBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(122000001)(38100700002)(6636002)(186003)(66446008)(52536014)(66556008)(66946007)(9686003)(2940100002)(55016002)(66476007)(38070700005)(64756008)(76116006)(83380400001)(7696005)(2906002)(4326008)(44832011)(5660300002)(110136005)(8676002)(26005)(71200400001)(4744005)(8936002)(6506007)(53546011)(33656002)(86362001)(316002)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Gy9bp31G2K4xLymtA3l6jozh6gMC0Lq9GNr/0Je/xi3fIlbNzWswS4O3gHi+?=
 =?us-ascii?Q?FV5fM5zVF4PIqtj2pFgUJiOIhOWknd1PzxbVS1C1d7EYKtEYeuNIdn/6SKkZ?=
 =?us-ascii?Q?RpHig6eykcyFDGLLNJP4gdcODHCoo90lTyoOc/zcdTf43RyA0jWOHy1MuK9C?=
 =?us-ascii?Q?eJEQSHqnT+tbdxO6SikFBGnVg2i25a+A8gZ+GxZFRe1dJtJ8hN1Kh6FIUnlv?=
 =?us-ascii?Q?0Oi6HThNt7cJjjZec6N4r8fJTkF3+C3Wv5ZeHfYuVfGtYN0lzvPmYwt42tcN?=
 =?us-ascii?Q?KR97CwL5h0ugEC4pSARzBwex1HxIXJ/rJrJ8smIUcZXsPDbv3y5ObcUzWZEn?=
 =?us-ascii?Q?jQXIkc53AqN9ilDix6BFS9O+4y1Fls4L3aFLB+DPOP8JbtWSvJlPYKyOWci4?=
 =?us-ascii?Q?1e8Edplw71u6vRSqeYxywvFcekPqS6ES2IHf2G6962YcQosPg9hKj4grRLP/?=
 =?us-ascii?Q?rN8fo8NP01ed8qgE8+7dAHlf7nPXsUL/ffMnkesD0EK4V25rNkL9k2jG7Y4y?=
 =?us-ascii?Q?IgsJw/CZ//F7pIGQKRVifpcPezviYOu/1e2i60P77jjxojukfbtkFyATHYU3?=
 =?us-ascii?Q?d6OPXNbqtQpBNl3jpiVK7Bfpq9Ee9kBoLmJq5KLnggR4BkVsrsPuj2DPVJeW?=
 =?us-ascii?Q?oF5aVd6zZRKow+bU9T9zpQWj32mV6cRt0WeEuc7Smu4u4tO5edi9SI2LUm2N?=
 =?us-ascii?Q?/hMIgpJeUN+wsYa7lifuIg/P3pnI3fQbQMAXAIHXgfuSWuEJhSTfWWIiBWB9?=
 =?us-ascii?Q?MoYIpFVewvKpQYQsoRZ7lgoQV6NiYLecDDYxI/NZgCy5hNimubLArxN3N0zX?=
 =?us-ascii?Q?OJyM87L8NqT1c71KZHpjXpKbl2LGmD5qfOq0/4ay2/XOn6Q4C2QngodK7Rcl?=
 =?us-ascii?Q?WN2uknVnkyZJiBlfVWnVA8t+nsx88DIE2AQuNEcyQ/V73RijCXiBBBTdqzPi?=
 =?us-ascii?Q?hvbVRMy5w3jkQ1xzm+ChQ1ykury941L1+uXwm8F1RfxiXTI0rGcMrI8lprAY?=
 =?us-ascii?Q?AfyeYU44uloO190G3uBk+U1ewezraJYQIh7G7P/+Ha1ajT88oELTVPYOzVT+?=
 =?us-ascii?Q?TSwV20dOi59HcgBzCNPjlD/1GHLA37pp+mv7RM4gZm4YsnVm0aVlQ3pDtSMm?=
 =?us-ascii?Q?nDIX4JQwxhMdfgBtudsJ/DObRe3tmMOrmzaGAO0uMzEoxxOCglhIouLFwebP?=
 =?us-ascii?Q?wI1qfzl7em8v6ehA56KuUZ5bkUC/GB5l0X2Hsf4mVxR/VnzeAqnN7rHxn+t2?=
 =?us-ascii?Q?5Mz4omqiiC5dgF2Sj7xuKLMJbiMNs1xOg5wH6AA1n1ZnC2EEFNRVd7t8WuYS?=
 =?us-ascii?Q?cNcIYyNURU+MveV1KpeBYCDZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 524a0b0e-0e83-48fc-c8ee-08d98f52d048
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2021 20:40:09.3360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 38lU3KynhFynUWy64TnI/ULR7lqMZksaAaNSDgdhYwXdi83TimMOcUclwr/+pCTwETN8Q2Ql3sLChAaMPYevfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8852
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Sorry, correct Linux-pci mail list address.

> -----Original Message-----
> From: Frank Li
> Sent: Thursday, October 14, 2021 3:35 PM
> To: kishon@ti.com; kw@linux.com; Sherry Sun <sherry.sun@nxp.com>; Richard
> Zhu <hongxing.zhu@nxp.com>
> Cc: inux-pci@vger.kernel.org
> Subject: Linux PCIe EP NTB function
>=20
> Kishon:
>=20
> 	We use VOP(virtio over PCIe) communication between PCI RC and EP side.
> But VOP already removed and switch into NTB solution.
> 	I saw you submit patch and already accepted by community about pci-
> epf-ntb.
>=20
> 	According to document, whole system work as Device1 (PCI host) -> EP1
> -> EP2 -> Device2(PCI host).
> 	But our user case is Device 1(RC Host) ->  Device 2(EP).
>=20
> 	I am not sure how to apply ntb frame work into this user case.
>=20
> 	I think we can modify pci-epf-ntb to register a ntb devices. But I am
> not sure that this is recommunicate method.  I think this user case is
> quite common. I don't want to implement a local solution.
>=20
> 	Any suggestion?
>=20
>=20
> Best regards
> Frank Li
