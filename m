Return-Path: <linux-pci+bounces-6820-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B4A8B6732
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 03:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77440284FE6
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 01:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CA617F5;
	Tue, 30 Apr 2024 01:10:49 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2104.outbound.protection.partner.outlook.cn [139.219.146.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138E010E4;
	Tue, 30 Apr 2024 01:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714439449; cv=fail; b=chx3A+zsisfJmbniWaPG+AbZvOThgX6cSdtDZUVUgtDTYT+6Odq5tlSn+KD5YPo9oo9XAy+QBKHA0iIN912axN69f9zbx0Fv8Tgh3h3fZEuAEZ7fLce52nzVD89YGN96Cr3AwaWMu7T/7YSJpv7UF62OfaXpAsG20QxP1iKuNl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714439449; c=relaxed/simple;
	bh=mqf9zux01Mp8IjUDLV4bg7yEYl+cGwg5NsgWFLH2FHg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KtRgdAAoB/q8/hImbKT0tE2kNqpK7Nkxsr58VnYQ2KgVGZn9Q8+qJcEAFIpOWsK6RSRnJz1oV+Z5D1ZkA2CDk5nnJVreTCPgNSSBQiClYfvlWbDGVPkjyR1sfLTNz2vUFAZ+hvNMD7Tbju0XB69my7GF39zislLsJbz95Nbod4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFJPu9KXn2nPXyJT1AhlgP1P1LU9Syn0ry2yx+zc5O3q6ZuJE3Lj7yvOTwqxkiezCMx7bBJSVyvvDCaBi/myiP9i1GY0O0bnNjmt+pKLu73mIPcJxQ3w2OR/iHnL7BUQUBxmVLzz2jh9p3OjOflEMtPa1VmXpfXnz/s93Y3dsdJVB8y6FsNEtdg8PmRXC3VWSam9zqVqak1oJXIU6MZVUW17EQdJ92c6fkWQVHs0PRv9k20+ceg1ltW8rkKb5SQxKgEuw3w7pHe0EKXLaqrPMYMWXryJ0EJLpYMIpMj4if5WlpEc/UwdFnRaZVfGMP4jU4MML4MDg2KlZyIDgZge4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNJdvvCVrz/WikenykXT18UHNn39k+4YiiKHS7QNvZM=;
 b=k/GkJwAtoqwGzHHJWQhUbMXrBIF5xQ0ucYgYlYC3m2PwQ4+koD3/PnFrxM94xIWvZZdR8hdXPPo569FUbQAliJpgdh1qeFh+oFjTl1wQ/6SzoIH1e1c/HK+hzIAdt/89bXh47NWidSaJH3vtGPQ9MASYQm/0u7yUt+nneZdYLaAOM4TSJ/22zNM5NU3SGoCdXRDOh9FlNMP2IUlmQfYud4u0G06rGiAGM3mFqdFBHNcHuClvCGric13b2+MJtflV+9pnJbjJreElTlwHGTut/gK/Tab/Hs1irX9zJ2OAVIZhlbbsVYA11yQORywMyq3LuAkA4jDPSx5GeZ4qmsFcmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0501.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:16::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 30 Apr
 2024 01:10:37 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::3e54:57b5:e3e3:7f09]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::3e54:57b5:e3e3:7f09%6])
 with mapi id 15.20.7472.044; Tue, 30 Apr 2024 01:10:37 +0000
From: Minda Chen <minda.chen@starfivetech.com>
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
	<mason.huo@starfivetech.com>, Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: [PATCH v16 15/22] PCI: microchip: Add event irqchip field to host
 port and add PLDA irqchip
Thread-Topic: [PATCH v16 15/22] PCI: microchip: Add event irqchip field to
 host port and add PLDA irqchip
Thread-Index: AQHagPD3nzNr5zgHs0qxspgsCqWuULGALtGggAAFt/A=
Date: Tue, 30 Apr 2024 01:10:37 +0000
Message-ID:
 <BJXPR01MB0855EFC06D44A450CB56E3E2E61AA@BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn>
References: <20240328091835.14797-1-minda.chen@starfivetech.com>
 <20240328091835.14797-16-minda.chen@starfivetech.com>
 <BJXPR01MB0855B876D2B73F33E8A39460E61AA@BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn>
In-Reply-To:
 <BJXPR01MB0855B876D2B73F33E8A39460E61AA@BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BJXPR01MB0855:EE_|BJXPR01MB0501:EE_
x-ms-office365-filtering-correlation-id: a4cc33a9-d7c9-4b10-f30c-08dc68b25814
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 T4MWod096/QYO3yPxIO2rvxEJLi6qsrepcF/6q3e/rMhOitPdGxixuF/epdQVAYsR00Tdad429Y2gdCsRNzMd5bvFdNdIwaAeuGpLwwvqgU/Qw3FjwZ9L0osQ1e5n4Zjx3xg1Du4oxfbTKLZR7ILZjgrvlna40kUFVzCSS3gPYF8qOFQotZw43sN7qxezOeAg15mXzAKAloJzgkttrrfXQ8j530+hkeXAYRJmSNLudxtW9PHv4sJ6jzqHnHQVljoNWldLwfCoPPk9y7zePIA32ir18xRUkb+QCBnu/DBenbvrXb+xur51WnPSKSwIXZfsmIp+b3ZBhrlbg2q8UWqpVzefalgUjyyFm2/INOdiF1/cP6rc7UCVHCf0df98Hs+VUHHulwTXZrOUxjK7VGIWg/xSm75gZRckOapP2tUZ9PL0iKNNA78mzlTVl6Eh2qRe4EsY7oVb8uFCrtAIl7lV4F7eDwLS5bXLRrueKsCbQ4GPWy2ppN3Z5BILpnN+4l9Q29lJwzqDKit04yhwFzXgh2ziOfbVO6Ex2wb0jenOj0nexQwK4Ic8BqpCFtWs6arC5H4Gat+7rPkYsIOWYafWAAUM69i7zGqjM1ZMYmBT9BI/KZ1yrTFOHnVb/4ih8SJbItGm6oB5QYweYYg1VeOWg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(38070700009)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?C1Avjy5xylDwZXCqJCSuglhaPi5i2rhxE5Cl60kAvYOf2BQslZ4A7bY0FK?=
 =?iso-8859-2?Q?2POVlPk71/t3w2llK7aiSO/Qub9UrcsHAW7BuT4k2+xUcJnb6Vb1ATzf4O?=
 =?iso-8859-2?Q?/OtHxsaYaA4TXwrekNVpsl1TK1TpmkYRxrqzYira+k2Vh2tTCiuLsr+li2?=
 =?iso-8859-2?Q?iXRUqnMNEyH+rPSGkkpbAc1xToAd3vDT5RdapHJ3+0azV6zOESWgbyy/Am?=
 =?iso-8859-2?Q?yEkdctAKqQXGPe4xppoGvSAXoE+jsOZZRxjBaYVl7ZBPSG00pnS2MPBXPw?=
 =?iso-8859-2?Q?blOeqN0/Gf4EXi7fKja/4SptJhJ0F1NyT+iIB2C0RFanNl8vDySzRZzQKe?=
 =?iso-8859-2?Q?Z/0Dn9v81VwCYOw++qTLKH+ZkHQAk6JqgK773uNkT0BT86VeBbI06X6fPF?=
 =?iso-8859-2?Q?S9pSjbJLOOj/9Q3xsz84+Fx/PnUQKnhMLlG1IJ7CmK3WH39noY2kL2xTBc?=
 =?iso-8859-2?Q?6R5REkHk+rBoJWHdIFXmw6+2lasPFJByUDWfW1bj4W0PMIbUbgtRYgb0iF?=
 =?iso-8859-2?Q?0uhiekyN7kSk+k8AlgNrp5SFMw/fh/mzQphhDWB3Z/Wcjjvr0mBaSxjKJ0?=
 =?iso-8859-2?Q?D1HuNCQyHvLLGM1zvLBwnKTLNSzh+ejdwqm9ada9HWY2xY9WTs4dNKNP2c?=
 =?iso-8859-2?Q?AnEzVhLqrsqz4e/57HZlelKsIqZVja5r8Zx7iRMkhl8Ydub2s/IMHjRJqG?=
 =?iso-8859-2?Q?Zy2QCQ8laWmNhyvRMD9EZ8RHUqynf3OXDNL6/LpKzhnOxW4BXlyd3N5Y8Z?=
 =?iso-8859-2?Q?QqtTaORXE0gYSukxBMKahyPrUi4i08/cODLHs087050W2+8Xk4ENh0kTzq?=
 =?iso-8859-2?Q?bXXSE6RWwC4Zre5KG2YAfPT63PjRtDUPk7gyz/qbDR6dR4a8meuta6lLPb?=
 =?iso-8859-2?Q?CPilpNnW7R9/GCDbhQmiR7hKpywzhkumuuoh1nWD2rryVTUa50eR92XYCi?=
 =?iso-8859-2?Q?wKshUJc7w+RarVY+73Ts72FpEFqTr1LDhyem4e3K7dlWvEG6HBfk8e/E4q?=
 =?iso-8859-2?Q?4zRTfu20H3Fl5Z8pMc3ANy2/69aaIfC0OIP/IK3xhsTY2zZRifd+EkVkCW?=
 =?iso-8859-2?Q?EPhREdRqBtrKXOhoUyrFb+UWJHuF7xM0Gez0YhVKFZRrQBlTbHIKWJsl6P?=
 =?iso-8859-2?Q?OXZ3igcTlIWuxCYfKIT+mllYnNSHMiISTZ0OyRcWbbOZaR7izC/BlcuzkF?=
 =?iso-8859-2?Q?4gUkdkx8xf926CpzlWW7Un/4YujgUD0HPGZk8b51HcS0D7PnMQ1/3Ckbok?=
 =?iso-8859-2?Q?UT3A7x9sWRAsgEsdB91AQUmpxx/eH2fEIkRHPOL30MLiXD91kiEPuSlEDz?=
 =?iso-8859-2?Q?pPIiF1Fa9P8t6VMp2Wiy6030itdjMxgLhJUuw18MawmDiA3yCd4aRQxCrt?=
 =?iso-8859-2?Q?mDv79iTsw/wEjmBSSirHTxY+6Z3mFTekU0n4+UWfm1S6HTAhM8dXBIWuFq?=
 =?iso-8859-2?Q?YHLPfyulNUAJuTBZKHy3v8UrdhVt3xL0FumQnCKvfP89nsxnJ+tZRepmSu?=
 =?iso-8859-2?Q?zjMLdWLiPI922PvkmMUV8H84zpBCR5+PJqWq9IyORw7GNpifpIMEY3V112?=
 =?iso-8859-2?Q?EVn+q9bjS4hPwLDlihfBqRyTTB02/EYkCT0iTYslN5y/1HVp4r6UrsZh69?=
 =?iso-8859-2?Q?aR/CybEz/B5UtQkznb638zm/V6QFpfRSBS?=
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
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: a4cc33a9-d7c9-4b10-f30c-08dc68b25814
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 01:10:37.0643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bkF5KlMgYlUd/hCsxoP0+4BIwhFszB6HiS0Djf1PF3dU55mBEyVbzdDM7TIXH9/sd3H2pbHXhMbWSizovW5LtHqHbqEEinZHREmKtGU/vUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0501


>=20
>=20
> >
> > As PLDA dts binding doc(Documentation/devicetree/bindings/pci/
> > plda,xpressrich3-axi-common.yaml) showed, PLDA PCIe contains an
> > interrupt controller.
> >
> > Microchip PolarFire PCIE event IRQs includes PLDA interrupts and
> > Polarfire additional interrupts. The interrupt irqchip ops includes
> > ack/mask/unmask interrupt ops, which will write correct registers.
> > Microchip Polarfire PCIe additional interrupts require to write
> > Polarfire SoC self-defined registers. So Microchip PCIe event irqchip o=
ps can
> not be re-used.
> >
> > Microchip Polarfire PCIe additional intrerrupts:
> > (defined in drivers/pci/controller/plda/pcie-microchip-host.c)
> > EVENT_PCIE_L2_EXIT
> > EVENT_PCIE_HOTRST_EXIT
> > EVENT_PCIE_DLUP_EXIT
> > EVENT_SEC_TX_RAM_SEC_ERR
> > EVENT_SEC_RX_RAM_SEC_ERR
> > ....
> >
> > To support PLDA its own event IRQ process, implements PLDA irqchip ops
> > and add event irqchip field to struct pcie_plda_rp.
> >
>Hi Thomas
>   Could you review this patch? Thanks.
>=20
Hi Thomas
  Previous Lorrenzo ask you to review this patch. The PLDA PCIe interrupt r=
egister
can be seen in the patch.

All:
   Sorry to resend this.

Minda

