Return-Path: <linux-pci+bounces-7735-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F21D98CB86F
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2024 03:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F7D8B26657
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2024 01:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102D65221;
	Wed, 22 May 2024 01:19:23 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2120.outbound.protection.partner.outlook.cn [139.219.146.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06A34C6D;
	Wed, 22 May 2024 01:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716340762; cv=fail; b=j6wb8M2ZTQuEa9491uNHxgNuDbEzZ8rh2ENP0Hmn05YbG+kJgxDIyu5psrEf6mXeGcM2aJ+RByCHI10F7qA6iDZfii7rgbNRQfjO7e/J4pKMWJ1zKS+l1Ij0rHqGU9+tY478JkL1sacypsEv8JKRox5T3HVjk/J9S1V1UieymgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716340762; c=relaxed/simple;
	bh=fszV9JOzggVN7+ckiW7JVmiP7/n/aznPEBnVghYtApo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=irahjs40Ym8nXW8FUggP2xrxLMMphPRusv7rt4i14IR/7lAxBh3Oide6hdsFznK7W2HOntu3pR9q/8AbXOxzhcpPkzM51cRO0PlFibLc2V25z4rSyq/U6OhrFnHyNjTVlUFfF7ns+RBqtZ6rdiO1S2BzftOSR5+xIdADLKYGHX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bX+zpL/Z9HoM20eDJYioNT/1FgdqP3EIELzGzpRvWVucFq2GFOn5iTnnvGlZvgR7DlJ3AAG4SM/2sa70ZLRv2gI9IyyQBeQqaNYyuBRdJBrTedz3lnrR2IQDJ+sApvpf2PEpgWIKJ8q5z/QfDLWc3ZqAheblm+m7fTfbHIy5RPV6fAqgOlbXGZhqyGcBdOBykR59ZhoWU9MtuJbwDkaz8swIP4BV9O/qfr3Oivjjh6Iv28Gpsu8bOLwQENKNWXHxL8uJFrc1Q64okBAUx+uGMffGy0RfDEVf7dMJvnNSqqMje0B2z4fTcMWIu4vUrWo5NBfqnEnQlg+53zeaEgH6Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tcj0nV0QKTR6KYMKm5D5jAyIT43iPeTTe0tlkJpe7xc=;
 b=eMm9cMLi+XIimhMazDq2EEvRI+Gsi0ZG6HJEBorgZuPHVVOW9JM8lEBSW328XLVJpxQ72BsA4KT3xGeFWXogD8vbo/Vg8uiP82utwIdQEmfyEW2nz75TSxzeY8ij4vXSszNYa/YK3FXoUFtLDUWzcHhIqLm2FyBFLgYP9YJIKx8Sh7XzpHpP6JaUpjmZZ900Z3SwlfaMwMf18aSKj9xWc5jnsPWVkaXhKKs4SXCx53pFLzJk4QNAwVPxooACZvbzp5hm5LdbKAPWEl2E947eGLfkLVrr6dU46TRIFhxBgCgpDghdRSrVqqGrBJzo/+mscyfwyDaZjmIka8J1WgyoIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550::13) by ZQ0PR01MB0951.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.37; Wed, 22 May
 2024 01:19:10 +0000
Received: from ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn
 ([fe80::a350:34aa:a63c:287f]) by
 ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn ([fe80::a350:34aa:a63c:287f%6])
 with mapi id 15.20.7587.028; Wed, 22 May 2024 01:19:10 +0000
From: Kevin Xie <kevin.xie@starfivetech.com>
To: Minda Chen <minda.chen@starfivetech.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Conor Dooley <conor@kernel.org>,
	=?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, Rob Herring
	<robh+dt@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner
	<tglx@linutronix.de>, Daire McNamara <daire.mcnamara@microchip.com>, Emil
 Renner Berthing <emil.renner.berthing@canonical.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Philipp Zabel <p.zabel@pengutronix.de>, Mason Huo
	<mason.huo@starfivetech.com>, Leyfoon Tan <leyfoon.tan@starfivetech.com>
Subject: Re: [PATCH v16 19/22] dt-bindings: PCI: Add StarFive JH7110 PCIe
 controller
Thread-Topic: [PATCH v16 19/22] dt-bindings: PCI: Add StarFive JH7110 PCIe
 controller
Thread-Index: AQHagPD6N6etUUNV8EKahT86V8hnLbGiyjZw
Date: Wed, 22 May 2024 01:19:10 +0000
Message-ID:
 <ZQ0PR01MB09818F373ACAA70B3C9F39E282EB2@ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn>
References: <20240328091835.14797-1-minda.chen@starfivetech.com>
 <20240328091835.14797-20-minda.chen@starfivetech.com>
In-Reply-To: <20240328091835.14797-20-minda.chen@starfivetech.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ0PR01MB0981:EE_|ZQ0PR01MB0951:EE_
x-ms-office365-filtering-correlation-id: dd824be0-73d8-45f8-c363-08dc79fd2f2c
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230031|366007|7416005|1800799015|921011|38070700009;
x-microsoft-antispam-message-info:
 BI6GmKmB/BdY3XeJTG8rMpk+DxpdX+JkNj3NDmC4Uu19e/zcY0zhHtygyXWUK3O40coTq9oTzeZDzD0jlg5jP0bevoobz0nQD23lF8Gyy7+wYw3SYcFdDIPB4SMBl7UHpcFHQ/usoLS3Y0PBK2kK261KzPQeSOfkiRtHhBA3KSnwT19unjJCnPcCqtkuLaOd3xqd+MxbDsZr3kn9yGVINShIkrAeHx6gUsUfesozbUc/YxwcQETelIuq2pMznA9dcFSIRWgzMpWTPHSZDuQx5T/TwQhERlGZ6DnLc7QBEBe/+bW7juTR98n4kk3LfUglsrkbr6iRvUn9oZ+Enrw+KNkGhKf6k8vHrA4QPYdcxUCFdFiRrg2bUxaGl1ZXWPzai9QG6bUm/WSeBEwAdzi0oXXLmQrh4tqn3wnBoEPW0i5vM+e6knxACYOfRI6n99fyWuUVU5MyWwHE6tQyEAoL6CLbY3PJuSS2ISoZ0Ly5FCNIfHagdMzP4l0Zx0/XyZsWom4kJ9/4WyY8yyKVJZouI78FyueEqI9P2uyjDIWNUJwD+W4PIie4grY0Wsz3LogRiGLoYTXgy3Pm6JVz3Dq/G/91ETWVgYIYzgCcWWkVznXLqry+arx8LcrZ1LLxTnS52LN+plJ1DN71K7IWWh2XLQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(921011)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?FJ7RwoJOAlihYMalqyQ01lVDLRNtxp0r4wz47A0dNRnmRVZ7ES4cWttOwn?=
 =?iso-8859-2?Q?Pvai5Pwv9JpYwWDYT6MUfNQb8oos/PuPszjtxexXEHfFJk5INtjN/W5yO6?=
 =?iso-8859-2?Q?CiTyMAEkAO+boNqn+IdT01z1qAVL/geruCrfrc5RquwHD82LQIjhtpdCCE?=
 =?iso-8859-2?Q?d4kljn1+MSp1yQy50AjkIwnkHnY5cfAlC6nzReq9SJD+x/5L8H34biZw1+?=
 =?iso-8859-2?Q?HdmVyfiGF5WShSSS7LQ/pQ/xz0z+CjNPxcbC/8xT2MAvQxbQfzS0QZZG61?=
 =?iso-8859-2?Q?aV/91ZGx2Md8w9PG7hbENKdROcmCflAKI5tAnqSLEtbVmMkJKh+Acoy3O0?=
 =?iso-8859-2?Q?r+GGQlQOhOK7U0js+w5kAQW5GfntT1HOx+3CeC2tQ8r120t22dqLQ5XR+6?=
 =?iso-8859-2?Q?niDBb2RMQWzVPLXs0eo08Rkk3ri8z08MlOkIE5UxiHc+iMs736FKEF7Cwu?=
 =?iso-8859-2?Q?K9HhcW3cZ4Mfx4t4bmPP48OBA7DaXce9pmQ9maGpSOsxQGxY8SugQnv21H?=
 =?iso-8859-2?Q?CNKgu0wMOnE/DP6Qn/Cv/2JLLwpikCrsTqWv43M4GnvBeh5TjdjG/YgmVe?=
 =?iso-8859-2?Q?5eqJWa6GfpqXa/d1D+yunL2YGT0comMlqarStamXf+qgqVm/zOfoAjYNNZ?=
 =?iso-8859-2?Q?ytIx66nwtp3S6QUZT5nLtktI1ZscvopkzfXOSDvVIz8rpwaUayKFe7fOYn?=
 =?iso-8859-2?Q?13WTZ6nSTm6f8K1eeyIQ4nbdxLILSxEbfGptf/QB6VWuHI/e7KiJRaUr00?=
 =?iso-8859-2?Q?e+iBaaVgg9a44uiuVBrwvHfK7Hs+GJyTOIqQJmip4VfVPwjkOznNkCFzr1?=
 =?iso-8859-2?Q?Ugf+Bt0R17keX8NWRUoGdbncA+m4w/7CP2oQW58vcpYXjyNP5y+V/vhi4U?=
 =?iso-8859-2?Q?0SA7QCpYbQMQvajN5m6NqshJVJlgkZC+yP0FPMYC100hray/WNb3MNVcyS?=
 =?iso-8859-2?Q?5l1zQ2O48fmFp5FhzqsMT99q2voSz8y4F4ZzfFrY4jT9kjsEI9qBi66cif?=
 =?iso-8859-2?Q?iAE9alDF2f54XdgdRJkarC70D76kjt1h0utJ+XoB8HM1/kZwMeNmCSkf4t?=
 =?iso-8859-2?Q?oW7VR6TvD/lzMuZn9omtyY2wn58ah5gXI0YlFrb5ZY057PNzaUJPENTTgu?=
 =?iso-8859-2?Q?6Dm1o40c7MuK9Eg7PrZ+RrdacioCZPQoABwMQE4z8siXZ4kWHCzABVvFF0?=
 =?iso-8859-2?Q?n56DyeJNvZkQcgDgOPPgMrDSAOu4V9mnFuu0kPTjfBC+USH3BDKBzHw8gD?=
 =?iso-8859-2?Q?rJb2Hmo3mo4UPWEjthq01lgi9BIkSIjWClnDpjyz5mjDAABzSZFy6Bhhm6?=
 =?iso-8859-2?Q?fUDM5/NrWqD14zpyuJMBjNnxNJgqVCRNEt8ifPbUbtaaenOTMfDXsB6O5M?=
 =?iso-8859-2?Q?ZLe+pnWZIe6xvtyogEdAizL0kpdinlQWUptbNtR/MMFCSI500864hmvj27?=
 =?iso-8859-2?Q?tfEjiphQBfuyiSMTwRg0/RDFuN+O08rLI/Y+jnTgmJCzZjcOOtAvfBWNL6?=
 =?iso-8859-2?Q?fgAGk15NxClf/kiIDwaUuFIJZBGdLf5hS3QmX9RWN3TB2bt+jllm31iwSN?=
 =?iso-8859-2?Q?qwYYDhb60bbW1ELDOHU03P+Vvm+FTBRTR7L4TUsZTvhWlwadcvq09zb7LR?=
 =?iso-8859-2?Q?0fhauX0ciEpm7YTJ0g0nNX4BK2z1QYkIjn?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: dd824be0-73d8-45f8-c363-08dc79fd2f2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 01:19:10.4776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: whPvcV45kSnhi6q2Vvh+Qi6o/6c1K2Q7LP/SoJquu5SZQrkEcM4aHONHTDcs/TF2V+92tRWLcQ81Y1EcZwGtzGbxw10RJ4MvqXp3eNA0dJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB0951

> Add StarFive JH7110 SoC PCIe controller dt-bindings. JH7110 using PLDA
> XpressRICH PCIe host controller IP.
>=20
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Kevin Xie <kevin.xie@starfivetech.com>
> ---
>  .../bindings/pci/starfive,jh7110-pcie.yaml    | 120 ++++++++++++++++++
>  MAINTAINERS                                   |   6 +
>  2 files changed, 126 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml

