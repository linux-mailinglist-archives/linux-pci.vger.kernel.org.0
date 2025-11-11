Return-Path: <linux-pci+bounces-40841-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F8FC4C3CE
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 09:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 806281881255
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 08:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B436299950;
	Tue, 11 Nov 2025 08:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JFwDVDur"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013020.outbound.protection.outlook.com [52.101.72.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8520C28469A;
	Tue, 11 Nov 2025 08:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762848161; cv=fail; b=DFRU+bKmzDb7YU5acWKJeIWOQ17WF6bXhTjx5deqSCyYgaJ2sxJICZSGDp8N0F7kqL3hFxpJkFVnAwfRA6N6J3z1GlNPDTAyOHyN5go350xKR1FV2tHlfQ3eICGUcMcu5siZRdwTCp1/QIRn/um2BIpAS/jevm8OqY+XvlIShp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762848161; c=relaxed/simple;
	bh=hjslwg003PkoKKkIUwUamLh3KyWSt/2/L9cLvvKYRXo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WDHQ0lVo31dSL7XCPcP/yrgx9L6RbSLAGyF6tYlAu51nXuiVlbL+hJMfmAshE5V4LGAu2iE/jWsOAOzKAL8ac3gFwdZI0gMr+2hfmxP/6kSz8wTuOfWfxwjUejH6iEisFmPkuz/cuYGH9ukLJnotVTNLFjETYl4/UMC96lHxhIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JFwDVDur; arc=fail smtp.client-ip=52.101.72.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y0IGtQI3VKMbrBEqMfjone+xwbp3vajFaKMMqqACQ92c2a1TrlWyDubVLo5dlR34bED8BzCIehf7oDf+CFsZgDTBQd3hJfw6wvLd+9cntNYZHRFfEGrmHG5qo8xKXpE+qrp3MDvTDrAknzBHptIj1nH+7cH0Q3f65f3KvQum95R0BDD5n+JG0c41kOTdgPJ9ESolzbCAEKYvBkmBFo8sfU/JxZ0A8sRY4O79pcu6TWxy2iuPo2Ge9Se5VeaKu1scOApT77QIJU2KsZzRc+SFMKVFjbG5MEy3vx/bcSLIMOI1Zb5/DYK4IP5QGEfL0c6nHLqmpu+Kku4JEOhHB6xBEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjslwg003PkoKKkIUwUamLh3KyWSt/2/L9cLvvKYRXo=;
 b=qIPeIZ+lUbVj3YdWiBsuawieRA/VZFJSaWZU3wys/XrIGdlhpsM292giqqXQ7t5lOBgS6/bxNX8EW3e8IlqVcjbzstPEA5gPqJPhTD4Q/sX6Gzw9/kceE+kSWLfrNKFRzRM1AV0YC+8k/khzEXrHruKQfc2/XjUncxdTVguBqZ7kfYMZb2yKE5guNAanOCfuIn0tr80kVTtzNMsSYD57Stg/DR0bqwXGNX3WJXM0QpzdtT3Gcshon7LGF8j98Chdz0HBw7CHwN6Ixl9VREfvwKumzpkRv+/x5WL5NW1kPxlXbOdXVmXc2DfZnIUx6xek9Gw0XUgKFd40w1vGTKzgnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjslwg003PkoKKkIUwUamLh3KyWSt/2/L9cLvvKYRXo=;
 b=JFwDVDurVPWITyWewmNHRw6o4IUryTkzJS4A03oMGh2dbHVnPddUfiAoFJMwwg001qZnKMZqRRuY00RhbqRjmwGLbGwz3dKKxl393c65T12INemilHPYvzMoS3wyJJlvVsZdeciIVWKOzevO6wW1P+kmXHXtcc/arZ+D4mI9DworIWgUk0MqcmERCrg52QTuPr7kDQ1pn4bC7MDGdYFj2usQ8lmtd6JqiyShnNV4q0Cfw8vVWIp4XOtk+v8VSwzGyUwqi7m6id82gsAmDt0QhZXuFIkWUWa5kOdqT0L33IX/l1Z3lrDuzQ5JTV0iC+dCT1wgpSO2pXidlIScmvjjNw==
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by VI0PR04MB10878.eurprd04.prod.outlook.com (2603:10a6:800:259::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 08:02:36 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%7]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 08:02:35 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Shawn Guo <shawnguo2@yeah.net>
CC: Frank Li <frank.li@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 01/11] arm64: dts: imx95-15x15-evk: Add supports-clkreq
 property to PCIe M.2 port
Thread-Topic: [PATCH v6 01/11] arm64: dts: imx95-15x15-evk: Add
 supports-clkreq property to PCIe M.2 port
Thread-Index: AQHcPYCDOxKc0FmqzkeInGCgNa7B4LTtOboAgAAKf8A=
Date: Tue, 11 Nov 2025 08:02:35 +0000
Message-ID:
 <AS8PR04MB8833D099959C62A97AC8CB868CCFA@AS8PR04MB8833.eurprd04.prod.outlook.com>
References: <20251015030428.2980427-1-hongxing.zhu@nxp.com>
 <20251015030428.2980427-2-hongxing.zhu@nxp.com> <aRLhko0h1OZgvo2o@dragon>
In-Reply-To: <aRLhko0h1OZgvo2o@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8833:EE_|VI0PR04MB10878:EE_
x-ms-office365-filtering-correlation-id: e61c52ef-0de4-4c20-3f87-08de20f8acd1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|376014|7416014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?gb2312?B?aVhoRGlGc0RVaGRXS0pjblZ2c080QXJLSWszRDBKRFhQZ3ZFY295N2p2dmxi?=
 =?gb2312?B?ZWVWOEdQK0FtQ2NCR015SmtBWjEzYnVlSzFYR0RlRWp4cFkrbXo2MmJWdWNH?=
 =?gb2312?B?QndLU2s1WFpOOXYzYUozQkJBUVdPMThXZGtkS0k5eFlBK05LZkxCbnZhZWRr?=
 =?gb2312?B?M08vSDBTSFhyNWM2Y0FYSW5ZY0FHcW5yY3UzWE1rTUZvOUJMZHpvdERBVW55?=
 =?gb2312?B?aUc0dW5hdkp6WFRFNjdlT3d6eVNuMVVJenR4cXNOWEk2Y0RlWHg3cjJvVjVU?=
 =?gb2312?B?MFZMTjN6V3BCbXlYcitlSDZHZHpMMGpDMm5qbjAzT1F3eVNoZzFzOUpkWWU0?=
 =?gb2312?B?Ykh0ODFXQllEOHVMd3dxWEViRkUrdVYwaDNMYnlqYXlxU0dONXBScGphMm9W?=
 =?gb2312?B?OTJJaHFSSXVKYTZRV0V6RUhVbVlpZEVUMVRSTnhoQ2FleWVDRlBUN3ltbDVp?=
 =?gb2312?B?c3ZpRldRZE14K0tuNDZxNXJwTGR2RGtEQnI1OFhkVHNDSWlJUTFlblJ0Zkts?=
 =?gb2312?B?Y1hXTXFLTnp5VE40UWpjVmVsR0YyYlkzYVg2QVBDWU9tdURDVlVheVVWL3JB?=
 =?gb2312?B?aVdFTklUZWRkTGl3UmNLY1NqeWVOUDN1VkJCMkMwR2pYa0JrMlI5bUNuU2V6?=
 =?gb2312?B?NlViSGdKS0VQNTJudVRqSHBlK3pqL3Z6R294R0JDU2UzZnM0VzlFK25xN3dk?=
 =?gb2312?B?UTU0ajA0cWZwdlBhWmZCRjM5bjdRNi8vYWhwZHlvVVVWZFM5ZEFpRHNrZ25W?=
 =?gb2312?B?YnMvUmttNnNXejNkdlQ1b1daYXR6RHJ5V2JZMjFYcXJzRWZCSEtZNjZGcUJL?=
 =?gb2312?B?dDhCdXVDOTJxMStjelFxdWxQZldrYnl5SHgzZllYOUh4NUxhS3dNSDNLamYr?=
 =?gb2312?B?MTJETThHMzUyMHNhdWUwRC84ZE9vYWxyeFFIcDltT0ZHbkRlZWZVbVg0V3cz?=
 =?gb2312?B?UUYrSHU1ZFBCdG9lS25QdXRUTnMyVUtPQmx1Y1plc2hqaFFjRUYxc0IwR3Zk?=
 =?gb2312?B?eXZEOXRqSE9LVmU2cGIxdDNzYUxRdElYaUY3cmpyQjJaZFFaaDY0NVBFWHA4?=
 =?gb2312?B?b1pZQzVKUEttNVZFYkx5MXFVTVR6NWxTT2E4NHhrbnFjRHZBb3lpcG1uM1F5?=
 =?gb2312?B?RlpEdTVYWnJEcWI0UVBoLzJmNHM2UnlyYTBYN0FteHVTUHlOSm9pTTAzelc2?=
 =?gb2312?B?K0RMMS8rc0pnVXQrSlNKRndULytINkNVek1Zam4wbUFFNkRZNm5kK1FyZjE5?=
 =?gb2312?B?blNBQ3g4clMreGNFNy9iaVg3ckFYQW9icEtRV1hMcVQ3T3RBK1plRmpMQk95?=
 =?gb2312?B?UjZyeUlTN1FaRkQyYUpYajdoS2RvMGh1ZHdlVXlSUTdDaHpIaGQzeEJhTXNs?=
 =?gb2312?B?SnhjZG1OTkNEQWdaNGl5RFNBSzY1RFZzZEE0aGJRVkdTMVYzZ2tteTkzSm9s?=
 =?gb2312?B?OVYwTHF2L2lVNzZxRUxJNER0Tjdzb3R6MGhhd0phU0J6dzFiZFZlalo2eE95?=
 =?gb2312?B?dHlMeWRXUS9rVm9VTDZTd1BLVmxWS0hWUmZMVzJaSUtVT2Fjald4TERQZmRl?=
 =?gb2312?B?RU9uQmRlT0FKUDN5WHBBbzVneVVtY3Y3aUkrNUZnbmNGLzFwN01vZGk3bVZu?=
 =?gb2312?B?OVZlM0ZHdE11L1lOQWl5LzRyekJ4azhsdUNNdW9zajhpWWN4Mmd5NWxtbWly?=
 =?gb2312?B?Sm1WQ0xsbjF5NVVoV3VESStjVEJBR3RwZ1ZqcjZnSU9mL3J0V1NDVWRvWG0v?=
 =?gb2312?B?cnRobkdacVF3OWFlVldRMC9hRWwvMUUyTEs0bWtqSWtUcVdjeFhkaTBhQ0cr?=
 =?gb2312?B?VEk4VE80TEprY2p5KzRIK293cmxQWkNTVzFFaHBGU1ROZFZaVVp5T0VTUzZk?=
 =?gb2312?B?RFRRdmgvNnJqemZmQ2dSOFdaSmNyd1FYNzRtM3V5UVhWdFpENGNFN1ZWNWlS?=
 =?gb2312?B?bVNka0Zzd2ZPY0dhUUJpQmtoRFN6eGZEZTFHSW9ZajJvdXdIdDFZSmU1TWx6?=
 =?gb2312?B?Wk9mVmhpWEt5cUZFQWY3MFc5NXd0RG1PYlR2UkpPaStjOHFneFlqWE80QWVo?=
 =?gb2312?Q?5vFTuT?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?K3hobTlmUFdzN3B2Uy94N1VUbGMzQmhJZmpvY3FZZzRkOTJ2ZTBjTzZFR0FC?=
 =?gb2312?B?bTA5VmdJRGFFdWl2elZTQnVpSGlGckRjeVpGbG05WjNTcC9zdjdma0lxOTE2?=
 =?gb2312?B?Z0orTFRqRUlxV1FOMjQxaFpScUluN1cwc2NxZ0NsWkR3MzBuOGtwNWFqeHVI?=
 =?gb2312?B?SFdtbmQyMi9PUjA3VHdoL2tFTzk2N2JYWTJWalRoWTNoRkNMS1FmM0tQVGN4?=
 =?gb2312?B?NlBJK003dkFMTStpN3JaMG5aeW5ZV0VJVTJuMHJzRlBmanluT3pHdlBTN0Y3?=
 =?gb2312?B?MmVyMUc3QUUxUjFBSmx0Z01jcDZ1S1FIMmFKYmlNdXAvNy9BV0VHNE1ZTTR3?=
 =?gb2312?B?cFhEbzJRM2ZENWs5dW5wYUJwMzlRWU5tZXBuU1dKTWU4SXJxWWJ4VVRaMUQ0?=
 =?gb2312?B?dFpMYytYbUx0R3hWOURzSHZOWmZreG5QTkdKQlo5QkhLRVZDNnhiTDFwUkpi?=
 =?gb2312?B?RlRBakRvT0dtUkRrMEtWZDNUYi9YeVFaM0I5YTI2SjJObVg0dnlzNHluTXV2?=
 =?gb2312?B?ZzFuUUJYcmVFaGhvTUhtMytDd1g5K1N0M1ZFamlubXAwRkNROEU1N3RQWGdz?=
 =?gb2312?B?bUpHUkVhSGlhU3hPakUwaHF5bUFYdHdWblRZN1l3am9vcXU2a2VmaXh3UnpR?=
 =?gb2312?B?aU1BdkJaMlhiUWhZMEtmRkFXRzlxS3lMU1ZVSDVKUTRwVlVvVkJDOGdyQUN4?=
 =?gb2312?B?QXhVRGUzcnBTcXl6SWtaLy9SdnJHTXZQY3NtQUhEcnBkSC9Rd3lkQ1FFUzl6?=
 =?gb2312?B?aldOSy9UejdrZjF5Q0ZXZmtPemIwWWVVZEI2dVZycHpqMG9xNHFLSXU2V0Z0?=
 =?gb2312?B?MFBySXZXOXpmUkZrbmVycUVBN2lOYm1YQng3K2NMVThDWUxiRjFGSXFhNWd6?=
 =?gb2312?B?Rk5iYjkwQWVYaFhTamFpNUdyYUc5UytjK21mS2l1c2RYVTFHTlNzZEF5aVgz?=
 =?gb2312?B?dVUzZWNoWFUrWnEzNVh6R3B1T1ppMVorQTIyUEFHZDBCdUlicDZucEQvcjIr?=
 =?gb2312?B?dnMySGhHWmYvVGozZ0ErREYxK3hCVzVGM2tCdlV3SGYxY1RYNUZoSjhsc1lu?=
 =?gb2312?B?SUxISnliUUxmNW1HeXJ6SUhCbGhjZkJEcS9Bb1BKTjZia09qNFR2T1ZlUzlV?=
 =?gb2312?B?Nm5HNTZVd2lXaDU3M0x2OTRlK0JBWkxWNWdDSGxaY1BqQzZCVFdFaUxMbDhx?=
 =?gb2312?B?RG05Q0g2V1dWc25xOWJRZXl3TWVkcWxwOUJ1S2ZZaVliR2xuMzVMUm9scmta?=
 =?gb2312?B?bUo3ajdMRmFscGhvcmFyMWRDK3dsNjF1MCtUeXBoTUIxTjc4d25aZzRBMkFu?=
 =?gb2312?B?d1NBeUw0OXBXSXVabDlxWVd3ZnFtVjY5dzQ4d3h1VkRLazJTOFR2cTF3RW53?=
 =?gb2312?B?WklUT3RiWFFBREI4aGNPSGd6SGxoSTA4RWVNM0pBT09FdldOSk1GOGtmQkR4?=
 =?gb2312?B?YjhQd2daSFVRcXZ1MUovK3R4RkVGanJGN3V2V1Jxa3lPdmJUWlhicVo0RGRw?=
 =?gb2312?B?TmdCUnBvQTNCajdUMkU0VGxxcldEMElBYm9UZVQ4VUttaGhNNzJJcG51aTdW?=
 =?gb2312?B?eXJIQ0paUEw3WjJ1dElMVG8xRmlzK05SUlhWa2Zmb3k3QStQOWNPcFdyVWhu?=
 =?gb2312?B?SkQrL1VwcUNBMnREUzM5TnpTV3lmUGNyWklIdnRzNXFLMk5HczNnWFd3Nk80?=
 =?gb2312?B?VDFacm9qWlpzTGlIOFNkNWZnbHRrcE03S3Q0cFVmTnNlRFp0VEVDOXBrV3RQ?=
 =?gb2312?B?RmZqUGE3aGFNb0EyNm84aW43NkZPcy9TRmkyQVdhbFpqS1hFNGpmT2ZhSU9U?=
 =?gb2312?B?OWJ4NkpoVjBoenZGcTdiM2dtTlB5a3JsR3ZDZWZpUnhFbW5ZSEZ0Mk0vNCtq?=
 =?gb2312?B?M2FIZ3ZBaGltYk52a3NheWIwbXJrNGFoM04yRjV5RjkrVTJSQU9IdFlEeU5a?=
 =?gb2312?B?M0pNVWQ2bThtZW5rM29yNm5yS25kNEFvaTgwQjJnRGx3N2piNWJxTzNTa050?=
 =?gb2312?B?TzV5NkNDVG5KYXJiY0R5MkRYL1dqdFZqemhWRFVxUjlGWTgrUVh6RURobVBS?=
 =?gb2312?B?S1AzV2l0YjY4dW14SS9RYTVnZTZ6NjdXZ09obU9vb0ZGUnFHTUxDZ1JNT2ND?=
 =?gb2312?Q?3cEnz/jxZCy0MA/pKBabtwT0Y?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e61c52ef-0de4-4c20-3f87-08de20f8acd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 08:02:35.6529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wYwOkMJsxL4VAdIez54gYlGRIRwt4SeM+/wchIniFx3idAE3Aily4/iTCz9DRLOym0D0qNZD8X/4qCnfKz5dlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10878

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTaGF3biBHdW8gPHNoYXduZ3Vv
MkB5ZWFoLm5ldD4NCj4gU2VudDogMjAyNcTqMTHUwjExyNUgMTU6MTENCj4gVG86IEhvbmd4aW5n
IFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IENjOiBGcmFuayBMaSA8ZnJhbmsubGlAbnhw
LmNvbT47IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7DQo+IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsg
a3dpbGN6eW5za2lAa2VybmVsLm9yZzsgbWFuaUBrZXJuZWwub3JnOw0KPiByb2JoQGtlcm5lbC5v
cmc7IGtyemsrZHRAa2VybmVsLm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsNCj4gYmhlbGdhYXNA
Z29vZ2xlLmNvbTsgc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsN
Cj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207IGxpbnV4LXBjaUB2
Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsg
ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGlteEBsaXN0cy5saW51eC5kZXY7IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NiAwMS8xMV0g
YXJtNjQ6IGR0czogaW14OTUtMTV4MTUtZXZrOiBBZGQNCj4gc3VwcG9ydHMtY2xrcmVxIHByb3Bl
cnR5IHRvIFBDSWUgTS4yIHBvcnQNCj4gDQo+IE9uIFdlZCwgT2N0IDE1LCAyMDI1IGF0IDExOjA0
OjE4QU0gKzA4MDAsIFJpY2hhcmQgWmh1IHdyb3RlOg0KPiA+IEFjY29yZGluZyB0byBQQ0llIHI2
LjEsIHNlYyA1LjUuMS4NCj4gPg0KPiA+IFRoZSBmb2xsb3dpbmcgcnVsZXMgZGVmaW5lIGhvdyB0
aGUgTDEuMSBhbmQgTDEuMiBzdWJzdGF0ZXMgYXJlIGVudGVyZWQ6DQo+ID4gQm90aCB0aGUgVXBz
dHJlYW0gYW5kIERvd25zdHJlYW0gUG9ydHMgbXVzdCBtb25pdG9yIHRoZSBsb2dpY2FsIHN0YXRl
DQo+ID4gb2YgdGhlIENMS1JFUSMgc2lnbmFsLg0KPiA+DQo+ID4gVHlwaWNhbCBpbXBsZW1lbnQg
aXMgdXNpbmcgb3BlbiBkcmFpbiwgd2hpY2ggY29ubmVjdCBSQydzIGNsa3JlcSMgdG8NCj4gPiBF
UCdzIGNsa3JlcSMgdG9nZXRoZXIgYW5kIHB1bGwgdXAgY2xrcmVxIy4NCj4gPg0KPiA+IGlteDk1
LTE1eDE1LWV2ayBtYXRjaGVzIHRoaXMgcmVxdWlyZW1lbnQsIHNvIGFkZCBzdXBwb3J0cy1jbGty
ZXEgdG8NCj4gPiBhbGxvdyBQQ0llIGRldmljZSBlbnRlciBBU1BNIEwxIFN1Yi1TdGF0ZS4NCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OTUtMTV4MTUt
ZXZrLmR0cyB8IDEgKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg5NS0xNXgx
NS1ldmsuZHRzDQo+ID4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg5NS0xNXgx
NS1ldmsuZHRzDQo+ID4gaW5kZXggMTQ4MjQzNDcwZGQ0YS4uM2VlMDMyYzE1NGZhMyAxMDA2NDQN
Cj4gPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg5NS0xNXgxNS1ldmsu
ZHRzDQo+ID4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OTUtMTV4MTUt
ZXZrLmR0cw0KPiA+IEBAIC01NTYsNiArNTU2LDcgQEAgJnBjaWUwIHsNCj4gPiAgCXBpbmN0cmwt
bmFtZXMgPSAiZGVmYXVsdCI7DQo+ID4gIAlyZXNldC1ncGlvID0gPCZncGlvNSAxMyBHUElPX0FD
VElWRV9MT1c+Ow0KPiA+ICAJdnBjaWUtc3VwcGx5ID0gPCZyZWdfbTJfcHdyPjsNCj4gPiArCXN1
cHBvcnRzLWNsa3JlcTsNCj4gDQo+IElzIGJpbmRpbmcgdXBkYXRlZCBmb3IgdGhpcyBwcm9wZXJ0
eT8NCj4gDQo+IFNoYXduDQo+IA0KSGkgU2hhd246DQpBcyBJIGtub3cgdGhhdCBJdCdzIGEgZG9j
dW1lbnRlZCBiaW5kaW5nIHByb3BlcnR5IGFzIGJlbG93Lg0KLSBzdXBwb3J0cy1jbGtyZXE6DQog
ICBJZiBwcmVzZW50IHRoaXMgcHJvcGVydHkgc3BlY2lmaWVzIHRoYXQgQ0xLUkVRIHNpZ25hbCBy
b3V0aW5nIGV4aXN0cyBmcm9tDQogICByb290IHBvcnQgdG8gZG93bnN0cmVhbSBkZXZpY2UgYW5k
IGhvc3QgYnJpZGdlIGRyaXZlcnMgY2FuIGRvIHByb2dyYW1taW5nDQogICB3aGljaCBkZXBlbmRz
IG9uIENMS1JFUSBzaWduYWwgZXhpc3RlbmNlLiBGb3IgZXhhbXBsZSwgcHJvZ3JhbW1pbmcgcm9v
dCBwb3J0DQogICBub3QgdG8gYWR2ZXJ0aXNlIEFTUE0gTDEgU3ViLVN0YXRlcyBzdXBwb3J0IGlm
IHRoZXJlIGlzIG5vIENMS1JFUSBzaWduYWwuDQouL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9wY2kvcGNpLnR4dA0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQoNCj4gPiAg
CXN0YXR1cyA9ICJva2F5IjsNCj4gPiAgfTsNCj4gPg0KPiA+IC0tDQo+ID4gMi4zNy4xDQo+ID4N
Cg0K

