Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4DC691FCC
	for <lists+linux-pci@lfdr.de>; Fri, 10 Feb 2023 14:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbjBJNd6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 08:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjBJNd5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 08:33:57 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2098.outbound.protection.outlook.com [40.107.255.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9FE1F92C;
        Fri, 10 Feb 2023 05:33:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wc5CEMmwbaRETWqfefzpUVYm7bcKea+rewwqfotrUk6GEwL9KNxE4KxsuWsDgojT4SqpHV3OE1F/XFIy69m620AdSGh//dNw2kEUqEMQrEVPyYVRm4im3W7j8tMvrPyaT1F+DWyOHTQHSWO88g1PNNm+Qh0B6dqdGxCBgZlI6+c7otn+TXQWOCPtp+BnZDQxvW40A38au1d2Y9swTfTqhjj0P/jnsi/DSMS6MBovYUYi6SZE+l9F+9pp0dwSFkti7+XybozsBmhIROkeehic9LU7VBdfwjRhzJNEi24yeGMHwBdc9Ckvv+wiWcC0pjSCutQYVgE/370aDHhsTE55Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4/SfP98gXRjd6ra4ZCUhQ0MtwCpnfuKkxWXtTRT0N0=;
 b=fOcYk1hLdjvSvhGBWultaiIjnv82AGelCjR99YtLyEN3w5RhVQ7PuUffQN9tUf9oYu0AKnTk74CEC/8Wz/5XQLEJJLXDaXoKXJiKV3S6t7bUuCMwiQsLHn2qXRDPhN6JA2AHTGb9bTXIS9XjiEPw5Vnh3oSVGEwIIUKdSQYrCIIhUpR3MxSPrbdG0z2pGZi1MmNsk+ufmTy4Z8w0h4xL79ISuQiAOTnjAop+juoGYd9HaWjVE7bOWQzw+pUaN6uZbMUnVISOLsjx8Jvgv5yzbbYN9d9EX8CZjJ1JU3S6MxGXTxIzmrxRomivr7VMn7u9yWrFEYK+iUkkmLEGkWApYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4/SfP98gXRjd6ra4ZCUhQ0MtwCpnfuKkxWXtTRT0N0=;
 b=Yp0AHOG5nnu8S2gX+PW8rWgaC7Gw0tRnQNnb+TdDvbF+SPzlyw1bc/LKkxeBToIjBWxM96cWVa95aIfbM6zXCEWGgT/xdm+BSjpzqeB/99TB8n5AmpWxJRm0saoBK8YTr85IxrposZXdXw4xQu6VtSSt/g1bGP0C9gw7xmId6Qk=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYTPR01MB10920.jpnprd01.prod.outlook.com
 (2603:1096:400:39f::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Fri, 10 Feb
 2023 13:33:51 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5f2:5ff1:7301:3ff1]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5f2:5ff1:7301:3ff1%4]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 13:33:51 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>
CC:     "Sergey.Semin@baikalelectronics.ru" 
        <Sergey.Semin@baikalelectronics.ru>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v8 0/6] PCI: rcar-gen4: Add R-Car Gen4 PCIe support
Thread-Topic: [PATCH v8 0/6] PCI: rcar-gen4: Add R-Car Gen4 PCIe support
Thread-Index: AQHZNVoyWX2OgSk9CUucrPIPgMQ3Ra7IPZYw
Date:   Fri, 10 Feb 2023 13:33:50 +0000
Message-ID: <TYBPR01MB53414B184A69E800288710A8D8DE9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230131095543.1831875-1-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20230131095543.1831875-1-yoshihiro.shimoda.uh@renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYTPR01MB10920:EE_
x-ms-office365-filtering-correlation-id: 0dde3d6f-e10c-4f9b-3f0f-08db0b6b724b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RUvhh3x/XLCHMPjRcuRPp1LV7xN9Mws2566L6DpuYgusjPEwi8ump4UWvTJjqJ6t6ZzvSipV6qwngFbZO33Zj7hAOS/ENPdisse6fR6IRlg5FQY7qytSumF3qT5w1PXCHK7GgmStfQkqNiOanFpEjbH4EzBwSTDhRTCjwDJgWu6EjHn24+q57e+43hGcoXWVF71Ah1Osvltv0bpH15TqmQZPS+Enae8NhJyUf9ILq0tZ2LRcAXpn73zCZ0BUfWBYaAuBR8nBpE1+Je6V0gZ+jhhKjgAoBelSyJfkwSA4psTaLGW3wGCmlSXDFdrk+iacSZuqkhrf2Y/g1osLExkOedS2gy+lVfsV8CrNXlq84NU/OYDX5DUuMTg3xUIeOm9f+AHcm51tJM0LrSyFM+Juz3e85eeIzjVRA7e8JuLECUodjIMUIsWsYP/qp6En+CMmwYeWrviQf92WL3cOhYg7vX3YLiTuk10pjJxa96cQRDx9Li0rMOfH891+gMtzGVmZyAYrpIUDbLusvqkic9WJfajebg14ccXNQOhVXOAisxFfwz7gcPPEadDewVh2AFvvORLLN3du4DehlqWGcDJI/UrjmvDd/94vEjNxIAjNvBUvTT/T1O7OwEgO4cz5bQQjAab4KMG0XtZvTJXIxVGKp1kS/+8hEFQkr2U9wuojGOEZIG3rvViLL8E+YHXyn1L/mLJNwvyu+pxwlIg+Ot/Siw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(451199018)(38070700005)(38100700002)(83380400001)(7696005)(71200400001)(33656002)(6506007)(41300700001)(9686003)(478600001)(122000001)(76116006)(55016003)(52536014)(2906002)(186003)(26005)(8936002)(110136005)(4326008)(7416002)(86362001)(54906003)(64756008)(4744005)(316002)(66556008)(5660300002)(66446008)(66946007)(66476007)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vAGoypR6jD+dqy2igOKFtYX2hHE1pMsGM/tlhn0hpGPN+96rCvpLjMtAoiHB?=
 =?us-ascii?Q?wBDMaEYafTKqv5FmHCS9SAcl/d+BQR81NmmZ+oUbqmj2GVrMBF8KzX/56rYH?=
 =?us-ascii?Q?jxVAi70CbLJ6GSDcGU45JAEqEoZjjd1X3n6LFqdaEXuF38dBJ8klqrOcYEEu?=
 =?us-ascii?Q?FXXnROqTEvgACQDvfPqMcGm9RleZUp5gFswe0S5Q03tDGAHhRvaxF+EVip0o?=
 =?us-ascii?Q?/EFur7nL8Z4OF/jPliNQJTYJif/JFt2+47u7plsFT+FLFA0I3+uP0IrZjLSt?=
 =?us-ascii?Q?KI09vRgZXuiqINNKG2neYCmsa5bXcou+ZWvRw/433VplcoseOAxIuSI1SGgr?=
 =?us-ascii?Q?elXJogUcQzzO/xajQpIwtdZS5oPHEEZYlZ3fcNSs/bji7zGiiC9Krc6hEooE?=
 =?us-ascii?Q?e3zc0tSJnT2vol51nKs1ZOwXSfr33owQk1ptwRYH+9OecfASwjOysf1UMg4T?=
 =?us-ascii?Q?SBgaCeO+/dq3/JBkkmF/uEX2hxV5P00d5FPF+BUg6BwZW3udGgFWjppX3GTN?=
 =?us-ascii?Q?dTTVQMXaUsw0HyzrULS1PSwro1/9QmIfdnDKz1SNwZL6lDKwXLzrYKUqfd6O?=
 =?us-ascii?Q?QOMzQFYZcXzJ8XNWrY3IDgoaZqVQmvSC0BETHl5n8Dtl7/B3sQnGvU1GREMz?=
 =?us-ascii?Q?Lgh4VnVFPPammv36Q9bxBNKDWWxeHq5OPEb4PQDm69ClLXMXR+fEbphZRA8v?=
 =?us-ascii?Q?Se7ryg1qx2KZoeoLeWgY8Mbu+4rK3Oip3ENriurftM0HoQQsFyTMxQizR/ta?=
 =?us-ascii?Q?zdP3RnwoMgqnNAIAzgnifqAdtUz5EhJbT5Ih8yQQOqRsBnyJKcC7HVWa3aWe?=
 =?us-ascii?Q?Z7VIsKc77VPN8kp5dMA8xa1ZXM014zcavUUjTfDs/mj2VZuKGb3mYFBAryXV?=
 =?us-ascii?Q?09dTBKLWq6GT7liEhmBfy0AstVhC/7BYgVRNGcGUOHnOgSXD/OKM3vsnG0dd?=
 =?us-ascii?Q?ADhp62qT8tdJl2Al7Spbi9kk/DW+83uuQ3FghmlL4SpSUc1sJdE3Q/Mn/KUx?=
 =?us-ascii?Q?nrrsJUFtyJ0LRZSdyuJF0iommNY24EV7vSL4Ce+01tLZPDf/R7zhxsJMcSNb?=
 =?us-ascii?Q?oE2g2aoMCHWdBqiDq5TWKAm8Mb/A44eYpBbDNZ81RRYcEyv+7lpwSFJh5HVt?=
 =?us-ascii?Q?6Ed1vvc/VWP5412Quoh6/LQ++yEvA723/Z49EtoknEsdnwYR8rxeWq9I9dm8?=
 =?us-ascii?Q?yq0SS59Nnle5boiBWX6qHv2EKRfiGwEfWyDB0cIHr7VD/f9K7lBD0gGKQS1j?=
 =?us-ascii?Q?lB4QPGCzW/W3j5tCLRNOUNtEhH99xjiJwcZ+oTqK7B8Kb8nP1QOaqw74KOXm?=
 =?us-ascii?Q?Vj8RArIfzZKiZmykudAkgk7pwisZTOPjlwORFmWRmYoZ/5B3f+mVgOG9twqh?=
 =?us-ascii?Q?rI+ueiJohM5vjhferLApMSiFMPhRb9j0U3m3GfhzvnE5Bez8TztRzAzWemnE?=
 =?us-ascii?Q?kCEwFzXn0OtqaioSN7ixAeTi83svOgztFdTUWm/nG5TeYT+OUhjpxXHyoJLg?=
 =?us-ascii?Q?pwCvDTfAmaasSVszeleX39RUSTjFCd2AgXHlHYS+1PRxzYDyeoJGA15Qtn3p?=
 =?us-ascii?Q?oEJuOypaMStFkoSfRR2AplxUIaHXthjNvGw+omtLUgX6+WJGD0Ff8uG25mGg?=
 =?us-ascii?Q?zQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dde3d6f-e10c-4f9b-3f0f-08db0b6b724b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 13:33:50.9684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NLJpcu0Uj+HJp9J4bLD/6Q5b3SBv4Ewb4EbqjiSynwhkey37lOnKlAFiLI3Xw3iZUkoBlkj3ZeChb4cgmMd9BlAjNiDdH6cSB6Qcg7da5uiPQ1qNrtuE3rxu7Pw6xd1c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTPR01MB10920
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

> From: Yoshihiro Shimoda, Sent: Tuesday, January 31, 2023 6:56 PM
>=20
> Add R-Car S4-8 (R-Car Gen4) PCIe Host and Endpoint support.
> To support them, modify PCIe DesignWare common codes.
>=20
<snip>
>=20
> Yoshihiro Shimoda (6):
>   PCI: Add PCI_EXP_LNKCAP_MLW macros
>   PCI: designware-ep: Expose dw_pcie_ep_exit() to module
>   PCI: dwc: Add support for triggering legacy IRQs
>   PCI: rcar-gen4: Add R-Car Gen4 PCIe Host support
>   PCI: rcar-gen4-ep: Add R-Car Gen4 PCIe Endpoint support
>   MAINTAINERS: Update PCI DRIVER FOR RENESAS R-CAR for R-Car Gen4

I completely forgot to include dt-bindings patches on v8.
So, I'll submit v9 patch soon.

Best regards,
Yoshihiro Shimoda

