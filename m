Return-Path: <linux-pci+bounces-36729-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F0BB9411A
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 05:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6F1C447F09
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 03:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BD223ABBF;
	Tue, 23 Sep 2025 03:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="k8t/AqBZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011042.outbound.protection.outlook.com [40.107.130.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BFF23D7D9;
	Tue, 23 Sep 2025 03:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758596965; cv=fail; b=W7XrQhBL7r/u5IuEElXljkEcr+kmL8zCKqiuBSigWHMUFF+N59xaqnoPkMfQeUF9STlBXOXKVldJubBnhGnzIBRBn8NcB+5YpDz2lg+aXhBibxdfL577et0QX+hiS61AzhrC0dSW2GoQ9LTkS3ygLwqb0EQawn3Ry0sashvS/64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758596965; c=relaxed/simple;
	bh=w1KO7xW8vNX667kV+QZl/Aju/o3fwASif38w9j9DeG8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JMD+ntCiBcQU+5BDrb3OKOpdfgpANA3eeJ83SVN5XugLJ0cU8e6Q8EvlFsfoKWD2fBTEqQXC9nghwF5eiucqqsmGxW/je3QueE/LOfZVl6J44o7cOQ+umOjLPJ30tpzNlCx7mbSFn6YgTn/m7tnJj5eU5RFzuBGWK6dbgXop7Oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=k8t/AqBZ; arc=fail smtp.client-ip=40.107.130.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eq4Rlkibk1xXWz9OR5ynI7SI0eD77Mi7fMK+2UY91qAFjYdDb15efQIM41vUu0OIdtQl/I3UlHF/KzgFhfu9ydDKw+UAAaBuTnlmWhZLEN4XHXSRiwINJNnu695zhioXdLx9PbjDzwTPiIS8V9KTpbuVXv+dlpsPti64Q3+F4W7WieIx4wc+A8D8mZdpkFCR3fEbR1KB35ON4ltoF3JmLVlBoDENt9okAmmIpxbG5AFWrSA8xOQ1jauF2ETSSPhaxXxF/nhE/wkhYC1AntUAxCt19+HXArxJq2vIRLx8PiUvWaZ18aVFxKgk1gAwA8+2/PK901f478o1PRRhwEb37A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1KO7xW8vNX667kV+QZl/Aju/o3fwASif38w9j9DeG8=;
 b=SpqOOZla4C6uL0oevC2GwkOBwGHfQ1TkfWzPHXizN8ydOMspx1xDP3wQ46TeyudbahfsOHZ6LG1XHHpj7pG54Q8Tc/fs76gR1dez08LEHFM0Lic7JjvLpUiej49QwBKOuj+vjjSqyNRbqhY0vBlxAe/ZMQkPvxClH17zsEupAf1hliSA3/n340n7H32OrwGJmkcLFMDT/sgGIVqD9AguwOvRJVKbh4CVbhxpPS3wTWQFsy0m5/LMZ6aenpJ60jUn8cDskJHKZ/G3vB8RAdBifp8ZW+JkqCIncgMa9010HC1xX5aetbHh9zz9Sf5hTVxZEpOOBDY7PTk0lm8RCP2k9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1KO7xW8vNX667kV+QZl/Aju/o3fwASif38w9j9DeG8=;
 b=k8t/AqBZBwxUfA0ujR0ukoMslVci2mhi+GZTxl/HBtmenYJ3OwZWOX0zmoOi9nwqtvNQP9qpY5CoqoHdi1IO8QEI/QBRK64aVdH4Ofyc01GAg1CaAkj7xsEA3RiyFARs7VDf9B8+Kyglxq2vYjEZDLJ1UJ/t0TTU+2tN+hetMCRJQwk6UeSjx0Mz4RGHX/qaW8akMNAYUqwp1uDK1olR3xxNqME/cLu+FfPvL401EE0rV/nQr7kmiv+SyHM+UaGcHxvc6sVS5DvHybtApu4y4vNhLMOx2PYCrqQJcZZI4P88hYWt3frXS74Lp+FRKdyks8vapaleJUz7nIZ2ycGIkw==
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by AS8PR04MB9064.eurprd04.prod.outlook.com (2603:10a6:20b:447::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 03:09:19 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 03:09:19 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "jingoohan1@gmail.com" <jingoohan1@gmail.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 2/3] PCI: imx6: Rename imx8mm_pcie_enable_ref_clk() as
 imx8mm_pcie_clkreq_override()
Thread-Topic: [PATCH v4 2/3] PCI: imx6: Rename imx8mm_pcie_enable_ref_clk() as
 imx8mm_pcie_clkreq_override()
Thread-Index: AQHcK5pu/IWfE3goPkK2tA5uMroRsLSfSVkAgADMLrA=
Date: Tue, 23 Sep 2025 03:09:19 +0000
Message-ID:
 <AS8PR04MB8833D7196D850657B74193798C1DA@AS8PR04MB8833.eurprd04.prod.outlook.com>
References: <20250922082433.1090066-1-hongxing.zhu@nxp.com>
 <20250922082433.1090066-3-hongxing.zhu@nxp.com>
 <aNFiRny143V0YaAl@lizhi-Precision-Tower-5810>
In-Reply-To: <aNFiRny143V0YaAl@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8833:EE_|AS8PR04MB9064:EE_
x-ms-office365-filtering-correlation-id: e4d8b848-7199-4f61-7ecb-08ddfa4e9675
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|19092799006|1800799024|366016|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?gb2312?B?ZU4zclNqU2h1WHNSMXI2Z3E0bU9qV1lLTEVFS3BacVRobmt1TDF4dFJtQXFS?=
 =?gb2312?B?K3djZmpqeGNOZU0wYzJwMXRQS3hVZWFMSCtreWd1TVk1bmZnRkpMbFIwdFdi?=
 =?gb2312?B?S0N3aGF0SWZmcEZuQ1JSMVBkVmRLbXJxSXFONnI5MGhXdUdva0gwWlJDRU96?=
 =?gb2312?B?WitVbG9sQU5WMWFhT0x4Y3hQZVI3ZC9Pcjc1TUt6NVdwZmpwalFtNHZqRmdJ?=
 =?gb2312?B?T3YvcGtyUmxoNkJXSVRNV2F4WE4xUEo1L3RaQ1F1dEZYTzhRUmhYZzgwNjA3?=
 =?gb2312?B?WkZqQk5PQ0Q3VTRJZ0pRRUlqdG1hdjl1SVNzZCt1ZkFkaU1wZ1pZR04zek1W?=
 =?gb2312?B?elFHWW9wU25FTTBDYzJaay85TE5sb2tWN3Q1UEgvbC9IdW42V0ExeGVUSTlh?=
 =?gb2312?B?OEdmZWNUTmw4SG42WCswRzd0OHlqRGV1SW9wejcxdlNxMlh4ZHRXTWlxUDQy?=
 =?gb2312?B?dDVjYnU3VUcrZXZteHRuK0t3c0lQT1cxRURnMnoxL1J2ek95T1h3d3BrQVl6?=
 =?gb2312?B?S3VhY3lxbHg4Z1M2SWZiRFBrQ05GNnorWktURDN6bnpYd0hRVlY2UEk0K0lO?=
 =?gb2312?B?SUFLTG9SY3JmdkdTd25FK2dzSXZnaStUOSswSnc0dHp4ODJ1U2FIcWN5UVpi?=
 =?gb2312?B?NGNFNEdGZlBYbUdRQ3N6eVVSeittY1BlM3VERVJ4OWlzNFpzQXVRNmw2MVlj?=
 =?gb2312?B?a0g1MmwxdmhCRVBCdlM2TDhiY1BtN0t2YmRKOTYydkU4Q25GbUhCOE1KQ1Zw?=
 =?gb2312?B?M1N4ZXBiYlVweHpCM0RKdXF5ZHJzNHQvaW9OQUtoZTdVWithdWNwS1V5akVP?=
 =?gb2312?B?TWtWQ085QlAvbmtjOURmcEFVMEtwSHBRMFJGMUp4bE12b3N5aEZMcDNXTjZT?=
 =?gb2312?B?RjdyZjNKQUJIaHhuVklsMkpVa3BZZFltMFpySkwzRHZralh2bDZzVy9WQlVF?=
 =?gb2312?B?WXZkWXV3Z2IvT05ReG0yWVhQb2J2TWUxNW5SRE9QOGRibWphUlJ6TDdHY2wx?=
 =?gb2312?B?STVmbmRZeXk5Q0d0anp0dnM4dkxjWERtbmhjeFVaOE1iM2VGU0c1OWFhQmhM?=
 =?gb2312?B?ZUI4dVh2NXpCSW8vWDBqSmRNQ0tSalNNd1BGTFpTN1Jlbnk0dGlpa1UwdDda?=
 =?gb2312?B?TGZ4aUt6K2xmY2I4N2Q2QXJZZ1phakYzVThCWGdMTmlzV2x4bFd1dDIycE5w?=
 =?gb2312?B?aVo1R1N4UnRUTzNUQTJzaEJpSHBjYTE3LytYblVvQVlXeXFHeUlmWDUwWlNu?=
 =?gb2312?B?TUFhRUs0QXVneFpTbTRCdDlYbzBBUTU5NjRubWJQcE4xcjR3eElISW9SM2ZQ?=
 =?gb2312?B?a2ZpZWRWTFFyTEFuVUF5WGk1YmtjdlVmL2IwNzJheG1GL0NoYjZtM1E0ajhB?=
 =?gb2312?B?dFg5V3o2a283L0lCdW9mTFZiVWplSXRtbllEYW52a3VWWG1ya0JvWHpkTmtt?=
 =?gb2312?B?dTQwUWU1SjJTUFNLc3hMdVhMR2lveEdLOEhqeU9hSUVaZ2RTTHVENk9rdE5G?=
 =?gb2312?B?Y1RDTEVZZ3ZLTjRyNmtiYVQ2RE1JcTZSZi9RRStwR2ErMFpMZjdyei9LeVBu?=
 =?gb2312?B?dDJNZC9qaGpYNHFmWGZXZXViSTNmNTJvcXY0TEZaNVFUdWh3K25WTEFKc3Ni?=
 =?gb2312?B?T0dtaFdwT282T3pMME1KcXViOGJqUkhTTTNlS3lVSnRGZmRXaVRZcXppbGxl?=
 =?gb2312?B?aWxTMCtWRjdsQ3RCd3Z0RzIwb3Nyb0d0akREWG1Xa1loc08rQW9GaWQ3MzRP?=
 =?gb2312?B?VHV3cThObTN5bTMxU1paTFp2aWt5UHE4YXN4WkFLdTkzVDRNbnhvcHpJR1hZ?=
 =?gb2312?B?Ly9Bdk05RWZrWXRIMkpXVFd1SWxwSzRVT3IrRkJiRlB0V2w5NjJDdUJ5S2lh?=
 =?gb2312?B?UktQQzN1SlRpU3VVeTF3aTE2anV3Y2xVUGpWVzdtRzZZYm5nbEh1ZHhnWUZS?=
 =?gb2312?B?OG1GbnY2ZVRZR0UySEt6Ly9vRFduaWF5WVBtSnQ1bHpVb1pCa3RoVmdVV0NG?=
 =?gb2312?Q?L9d7uR3m0QdTG26lut6Mxlj8suUQk4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(19092799006)(1800799024)(366016)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?alpUU2xpSWg5MjMyYXJHUXJCK2lJQWdYOGQ5ZW1JeHVWQ2ZaNWtiVFlteTZx?=
 =?gb2312?B?c3V2RnY4Z0ZQUzM3Zzg1RHRSOXZFSU9oeWRjZElieC90NmlzNGsrSVNqTzlM?=
 =?gb2312?B?Mk9YVHdrVGZFeWh0a0pvZmg4K1ByYlBpUWJYR1dueVhwLzFvNW1oTUx4dXVK?=
 =?gb2312?B?ZE1GR21JU2QrVy9KdTdEd3BUMHJ0MURJSkYyTXhnT2JZRVpIU0JCTE9kaEFZ?=
 =?gb2312?B?WjdiLy9kWGJuakYvUWl4ZUVObGpCMW1JS0Y0Y1E0TUdkUUJDSkM2L1hqSkpx?=
 =?gb2312?B?SmhBbnplWmJBSFpxaXlTMG5mSEh2UnBJQ0VUT0VBRlp2eWIwb3ltaFVCeEgr?=
 =?gb2312?B?bzUyeHFsQmRKTVBJWi9FZmhDNmJmRXBwSkFMYWRLVkY5YXpUemRzMlBiQUtG?=
 =?gb2312?B?Znd1RWd0OHN1eDZKL25JVXRQQzJJQnNoTUZYQ0s2SEoxMkNHOUkveXJhYVNB?=
 =?gb2312?B?SG1rVU9mMEJnYStpck1PdTczSWtTczk5WlFZUThtWnJjMGlNcTYzZUxuczZO?=
 =?gb2312?B?cXRla3UyUXFONXRYM1JWbWYxUXREb2E1OUtQVUNTMUlubEkxQi9HbjBhdFZJ?=
 =?gb2312?B?S255aGtMSk91ZStrdG5TbEpBQVhPNDFlVE03cWFvTXFSakZ5RDM2S1FVdTZo?=
 =?gb2312?B?b1QxWFhmVVlOZitMZ0Vvd3Z3OVE5bHQrYmM0eWhwQWRZaVNFNzBPRzlURUNw?=
 =?gb2312?B?bUx0TUNDVmpMVGQwRkNaOXZJRTN4WnlseFVGbnpEdGRmV0Ric2ZGNjY3Nldo?=
 =?gb2312?B?cisvNGdacjVZL1lzUCtzdXAwdGdkVWRMaVVYOFF0bzhnQk11WmVvUlJNS2d1?=
 =?gb2312?B?R2Y1bmNhMHVvK3dzT2lIUllOa3Z6TnQyTFRVOFl6eWkzdFN3bVpPSXgwTHFy?=
 =?gb2312?B?VDJ3VVV5RHdLc0Q5MU9adjJyakVjRzNZNDVQNW9xd2VPZ0JpenhnOWRIbGdX?=
 =?gb2312?B?SllkWElZZitDaTZjbTdBN01WSWQvTmVMdGx3cisrRjlNdnpYT2kxK0txRFp6?=
 =?gb2312?B?dU1HcEwzajNkKzdpWkZ2MXRtN3o5dFMwZWlqY01JRXM2RG0wU0tER2NXcHNF?=
 =?gb2312?B?bUdQL2pTaE9ZYStiSkFSeFdSZXpDOTVKY0lEU2U0RXFYcjBkSE1IVytuYXlH?=
 =?gb2312?B?bFNaMU5tMGNvR3NtV05UNnNVNUJ4QTN4bWdmMTIxRFdwS1hpcEY0MDJ4T2V5?=
 =?gb2312?B?VUp5RTZlUXBPbUZneTBUTTgzVStNME5rRUwvc3lvbElzS2lxL0JjTnNSRHJi?=
 =?gb2312?B?MjRhQ3lSc1V3cUNaWCtLRDM1Q0lkck1rTEpCRVlnY2szRENRWVlJaWJVWWEx?=
 =?gb2312?B?VnV1QU15SEZ6UHg2THlqclk3Y1JjQlNsU3QyWFR6U1kxdUkvdFltQ1ZBM0NI?=
 =?gb2312?B?UmhuQU1WQWtwaTZXRFZ0a1BaN05LZDk4Z3ZYNUs4Wk9TY1ZGZVVzUGpNT0or?=
 =?gb2312?B?N1p4dUdTYUVMdVIwdmtUQWhWelgxdGluRVRNUWxlUmFid1VPSGIyR2hsSUNJ?=
 =?gb2312?B?L0tEanNPTWhVSWVoeGRRTEtidVRtMGJDS2h4TU9XeWk2U3NZNUkwVGdhN3dr?=
 =?gb2312?B?bjZodGNmL3FyL2xWdzhrN0YrSVFRU1dFMVd2QTNGcEpyWDhTcXVqVUVaVzdS?=
 =?gb2312?B?RUsyMkk1aEw4MW9yTDZRa2ZxdzUzaVBWV3JzQUNQNjFOem5qelE4bzRPQ2ln?=
 =?gb2312?B?aEMrZ0JUNWNOOHUyejZUYWt4SFhETDllUzNnbUlQZWRMZ1FkQVdXK204cHFH?=
 =?gb2312?B?TlQ3MWZTV1crMmdsMWpscDhZMC9HZi9oSkR1ZXNRb3NIbzhHQ3ZHZUFjZkM3?=
 =?gb2312?B?bzBmTnpwc0NoTVRxVU5rbG5QZktabTVoWnRoSTIzbmR4UTVLMnVkWnZSU2hr?=
 =?gb2312?B?ckx2dVE0cHRHc1pDQ2xtYUNwT09mSVBwVCtlYzhGSGU0M3cxTXBMNVIyNEpE?=
 =?gb2312?B?eFdqaTZteWFLbzhJYnRHUmtmR01LWWFzVVVndHpBZWsyS1YyK2RJSXdYc25x?=
 =?gb2312?B?WXdZeUwrQjlFaURXcTNEak1LOTdiV1hoUlg5c0MrYlF4TUEvK1F2TmpMbTU0?=
 =?gb2312?B?dUtyODFJaURJTFVzeGFLV2w1OXQxZkJiN2VjRGxIZ0hGWW9mR2ovVEE0Tkg0?=
 =?gb2312?Q?8Fg8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d8b848-7199-4f61-7ecb-08ddfa4e9675
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2025 03:09:19.4905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XPCUuosCvw0GG52jtKRJxIHQ3dpNbtI4T/qF65Jv59NAMqsYLVGrYnPCwuzE0dpf2Z06KVsE+P8eAS2s9mpTXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9064

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuayBMaSA8ZnJhbmsubGlA
bnhwLmNvbT4NCj4gU2VudDogMjAyNcTqOdTCMjLI1SAyMjo1MQ0KPiBUbzogSG9uZ3hpbmcgWmh1
IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IGppbmdvb2hhbjFAZ21haWwuY29tOyBsLnN0
YWNoQHBlbmd1dHJvbml4LmRlOyBscGllcmFsaXNpQGtlcm5lbC5vcmc7DQo+IGt3aWxjenluc2tp
QGtlcm5lbC5vcmc7IG1hbmlAa2VybmVsLm9yZzsgcm9iaEBrZXJuZWwub3JnOw0KPiBiaGVsZ2Fh
c0Bnb29nbGUuY29tOyBzaGF3bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRl
Ow0KPiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsgbGludXgtcGNp
QHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
OyBpbXhAbGlzdHMubGludXguZGV2Ow0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMi8zXSBQQ0k6IGlteDY6IFJlbmFtZSBpbXg4bW1fcGNp
ZV9lbmFibGVfcmVmX2NsaygpDQo+IGFzIGlteDhtbV9wY2llX2Nsa3JlcV9vdmVycmlkZSgpDQo+
IA0KPiBPbiBNb24sIFNlcCAyMiwgMjAyNSBhdCAwNDoyNDozMlBNICswODAwLCBSaWNoYXJkIFpo
dSB3cm90ZToNCj4gPiBUbyBhbGlnbiB0aGUgZnVuY3Rpb24gbmFtZSB3aGVuIGFkZCB0aGUgQ0xL
UkVRIyBvdmVycmlkZSBjbGVhcg0KPiA+IGZ1bmN0aW9uIGxhdGVyLiBSZW5hbWUgaW14OG1tX3Bj
aWVfZW5hYmxlX3JlZl9jbGsoKSBhcw0KPiA+IGlteDhtbV9wY2llX2Nsa3JlcV9vdmVycmlkZSgp
LiBObyBmdW5jdGlvbiBjaGFuZ2VzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBa
aHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3BjaS9jb250
cm9sbGVyL2R3Yy9wY2ktaW14Ni5jIHwgMTQgKysrKysrKy0tLS0tLS0NCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gYi9kcml2ZXJz
L3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gaW5kZXggODBlNDg3NDZiYmFmLi40
MWY5NzE2OTM2OTcgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2Mv
cGNpLWlteDYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2
LmMNCj4gPiBAQCAtNjg1LDcgKzY4NSw3IEBAIHN0YXRpYyBpbnQgaW14NnFfcGNpZV9lbmFibGVf
cmVmX2NsayhzdHJ1Y3QgaW14X3BjaWUNCj4gKmlteF9wY2llLCBib29sIGVuYWJsZSkNCj4gPiAg
CXJldHVybiAwOw0KPiA+ICB9DQo+ID4NCj4gPiAtc3RhdGljIGludCBpbXg4bW1fcGNpZV9lbmFi
bGVfcmVmX2NsayhzdHJ1Y3QgaW14X3BjaWUgKmlteF9wY2llLCBib29sDQo+ID4gZW5hYmxlKQ0K
PiA+ICtzdGF0aWMgaW50IGlteDhtbV9wY2llX2Nsa3JlcV9vdmVycmlkZShzdHJ1Y3QgaW14X3Bj
aWUgKmlteF9wY2llLA0KPiA+ICtib29sIGVuYWJsZSkNCj4gPiAgew0KPiA+ICAJaW50IG9mZnNl
dCA9IGlteF9wY2llX2dycF9vZmZzZXQoaW14X3BjaWUpOw0KPiA+DQo+ID4gQEAgLTE4NzIsNyAr
MTg3Miw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaW14X3BjaWVfZHJ2ZGF0YSBkcnZkYXRhW10g
PSB7DQo+ID4gIAkJLm1vZGVfb2ZmWzFdID0gSU9NVVhDX0dQUjEyLA0KPiA+ICAJCS5tb2RlX21h
c2tbMV0gPSBJTVg4TVFfR1BSMTJfUENJRTJfQ1RSTF9ERVZJQ0VfVFlQRSwNCj4gPiAgCQkuaW5p
dF9waHkgPSBpbXg4bXFfcGNpZV9pbml0X3BoeSwNCj4gPiAtCQkuZW5hYmxlX3JlZl9jbGsgPSBp
bXg4bW1fcGNpZV9lbmFibGVfcmVmX2NsaywNCj4gPiArCQkuZW5hYmxlX3JlZl9jbGsgPSBpbXg4
bW1fcGNpZV9jbGtyZXFfb3ZlcnJpZGUsDQo+IA0KPiBJIHJlbWVtYmVyIGJqb3JuIGxpa2UgY2Fs
bGJhY2sgaW1wbGltZW50IGZ1bmN0aW9uIG5hbWUgc2hvdWxkIGluY2x1ZGUNCj4gY2FsbGJhY2sg
bmFtZSwgaGVyZSBpcyAiZW5hYmxlX3JlZl9jbGsiIHRvIGdyZXAgZWFzaWx5IGxhdGVyLg0KSXMg
aXQgcG9zc2libGUgdG8gYWRkIG9uZSB3cmFwcGVyPyBUaHVzLCB3ZSBjYW4gYWxpZ24gdGhlIGZ1
bmMtbmFtZXMuDQotc3RhdGljIGludCBpbXg4bW1fcGNpZV9lbmFibGVfcmVmX2NsayhzdHJ1Y3Qg
aW14X3BjaWUgKmlteF9wY2llLCBib29sIGVuYWJsZSkNCitzdGF0aWMgaW50IGlteDhtbV9wY2ll
X2Nsa3JlcV9vdmVycmlkZShzdHJ1Y3QgaW14X3BjaWUgKmlteF9wY2llLCBib29sIGVuYWJsZSkN
CiB7DQogICAgICAgIGludCBvZmZzZXQgPSBpbXhfcGNpZV9ncnBfb2Zmc2V0KGlteF9wY2llKTsN
Cg0KQEAgLTY5OCw2ICs2OTgsMTEgQEAgc3RhdGljIGludCBpbXg4bW1fcGNpZV9lbmFibGVfcmVm
X2NsayhzdHJ1Y3QgaW14X3BjaWUgKmlteF9wY2llLCBib29sIGVuYWJsZSkNCiAgICAgICAgcmV0
dXJuIDA7DQogfQ0KDQorc3RhdGljIGludCBpbXg4bW1fcGNpZV9lbmFibGVfcmVmX2NsayhzdHJ1
Y3QgaW14X3BjaWUgKmlteF9wY2llLCBib29sIGVuYWJsZSkNCit7DQorICAgICAgIHJldHVybiBp
bXg4bW1fcGNpZV9jbGtyZXFfb3ZlcnJpZGUoaW14X3BjaWUsIGVuYWJsZSk7DQorfQ0KKw0KDQpC
ZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQo+IA0KPiBGcmFuaw0KPiANCj4gPiAgCX0sDQo+ID4g
IAlbSU1YOE1NXSA9IHsNCj4gPiAgCQkudmFyaWFudCA9IElNWDhNTSwNCj4gPiBAQCAtMTg4Miw3
ICsxODgyLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBpbXhfcGNpZV9kcnZkYXRhIGRydmRhdGFb
XSA9IHsNCj4gPiAgCQkuZ3ByID0gImZzbCxpbXg4bW0taW9tdXhjLWdwciIsDQo+ID4gIAkJLm1v
ZGVfb2ZmWzBdID0gSU9NVVhDX0dQUjEyLA0KPiA+ICAJCS5tb2RlX21hc2tbMF0gPSBJTVg2UV9H
UFIxMl9ERVZJQ0VfVFlQRSwNCj4gPiAtCQkuZW5hYmxlX3JlZl9jbGsgPSBpbXg4bW1fcGNpZV9l
bmFibGVfcmVmX2NsaywNCj4gPiArCQkuZW5hYmxlX3JlZl9jbGsgPSBpbXg4bW1fcGNpZV9jbGty
ZXFfb3ZlcnJpZGUsDQo+ID4gIAl9LA0KPiA+ICAJW0lNWDhNUF0gPSB7DQo+ID4gIAkJLnZhcmlh
bnQgPSBJTVg4TVAsDQo+ID4gQEAgLTE4OTIsNyArMTg5Miw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgaW14X3BjaWVfZHJ2ZGF0YSBkcnZkYXRhW10gPSB7DQo+ID4gIAkJLmdwciA9ICJmc2wsaW14
OG1wLWlvbXV4Yy1ncHIiLA0KPiA+ICAJCS5tb2RlX29mZlswXSA9IElPTVVYQ19HUFIxMiwNCj4g
PiAgCQkubW9kZV9tYXNrWzBdID0gSU1YNlFfR1BSMTJfREVWSUNFX1RZUEUsDQo+ID4gLQkJLmVu
YWJsZV9yZWZfY2xrID0gaW14OG1tX3BjaWVfZW5hYmxlX3JlZl9jbGssDQo+ID4gKwkJLmVuYWJs
ZV9yZWZfY2xrID0gaW14OG1tX3BjaWVfY2xrcmVxX292ZXJyaWRlLA0KPiA+ICAJfSwNCj4gPiAg
CVtJTVg4UV0gPSB7DQo+ID4gIAkJLnZhcmlhbnQgPSBJTVg4USwNCj4gPiBAQCAtMTkyNiw3ICsx
OTI2LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBpbXhfcGNpZV9kcnZkYXRhIGRydmRhdGFbXSA9
IHsNCj4gPiAgCQkubW9kZV9tYXNrWzFdID0gSU1YOE1RX0dQUjEyX1BDSUUyX0NUUkxfREVWSUNF
X1RZUEUsDQo+ID4gIAkJLmVwY19mZWF0dXJlcyA9ICZpbXg4cV9wY2llX2VwY19mZWF0dXJlcywN
Cj4gPiAgCQkuaW5pdF9waHkgPSBpbXg4bXFfcGNpZV9pbml0X3BoeSwNCj4gPiAtCQkuZW5hYmxl
X3JlZl9jbGsgPSBpbXg4bW1fcGNpZV9lbmFibGVfcmVmX2NsaywNCj4gPiArCQkuZW5hYmxlX3Jl
Zl9jbGsgPSBpbXg4bW1fcGNpZV9jbGtyZXFfb3ZlcnJpZGUsDQo+ID4gIAl9LA0KPiA+ICAJW0lN
WDhNTV9FUF0gPSB7DQo+ID4gIAkJLnZhcmlhbnQgPSBJTVg4TU1fRVAsDQo+ID4gQEAgLTE5Mzcs
NyArMTkzNyw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaW14X3BjaWVfZHJ2ZGF0YSBkcnZkYXRh
W10gPSB7DQo+ID4gIAkJLm1vZGVfb2ZmWzBdID0gSU9NVVhDX0dQUjEyLA0KPiA+ICAJCS5tb2Rl
X21hc2tbMF0gPSBJTVg2UV9HUFIxMl9ERVZJQ0VfVFlQRSwNCj4gPiAgCQkuZXBjX2ZlYXR1cmVz
ID0gJmlteDhtX3BjaWVfZXBjX2ZlYXR1cmVzLA0KPiA+IC0JCS5lbmFibGVfcmVmX2NsayA9IGlt
eDhtbV9wY2llX2VuYWJsZV9yZWZfY2xrLA0KPiA+ICsJCS5lbmFibGVfcmVmX2NsayA9IGlteDht
bV9wY2llX2Nsa3JlcV9vdmVycmlkZSwNCj4gPiAgCX0sDQo+ID4gIAlbSU1YOE1QX0VQXSA9IHsN
Cj4gPiAgCQkudmFyaWFudCA9IElNWDhNUF9FUCwNCj4gPiBAQCAtMTk0OCw3ICsxOTQ4LDcgQEAg
c3RhdGljIGNvbnN0IHN0cnVjdCBpbXhfcGNpZV9kcnZkYXRhIGRydmRhdGFbXSA9IHsNCj4gPiAg
CQkubW9kZV9vZmZbMF0gPSBJT01VWENfR1BSMTIsDQo+ID4gIAkJLm1vZGVfbWFza1swXSA9IElN
WDZRX0dQUjEyX0RFVklDRV9UWVBFLA0KPiA+ICAJCS5lcGNfZmVhdHVyZXMgPSAmaW14OG1fcGNp
ZV9lcGNfZmVhdHVyZXMsDQo+ID4gLQkJLmVuYWJsZV9yZWZfY2xrID0gaW14OG1tX3BjaWVfZW5h
YmxlX3JlZl9jbGssDQo+ID4gKwkJLmVuYWJsZV9yZWZfY2xrID0gaW14OG1tX3BjaWVfY2xrcmVx
X292ZXJyaWRlLA0KPiA+ICAJfSwNCj4gPiAgCVtJTVg4UV9FUF0gPSB7DQo+ID4gIAkJLnZhcmlh
bnQgPSBJTVg4UV9FUCwNCj4gPiAtLQ0KPiA+IDIuMzcuMQ0KPiA+DQo=

