Return-Path: <linux-pci+bounces-13307-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9821697CF24
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2024 00:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C42F4B23D62
	for <lists+linux-pci@lfdr.de>; Thu, 19 Sep 2024 22:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49781B2EE1;
	Thu, 19 Sep 2024 22:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fBerPRkJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011044.outbound.protection.outlook.com [52.101.65.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C871B3743;
	Thu, 19 Sep 2024 22:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726783469; cv=fail; b=FVeWvSs2NWikAOpyMR2RIstWlVE/fW3WSpfnFc9estqcStZoa7ViIyYNdTy5I/iYM95sseyu5vzXQRiAAD7BNk2EwlZ6dRFj/sPeJnm4EnUzjzJY0JlN/wH3m/aubxB6bxt3OMNxc3bJD0qCyqcVInuCBCgtGpnFU/7sOSBHzg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726783469; c=relaxed/simple;
	bh=dDCIqEiGeYvyy7IOr9TuFKqg1ZZuhKUnDbXG/Msug68=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=M3bS8tRF78Y/78Veqm08xTdfL1wZJN5ppWSOH2tOODN1wJO5t0NfH3OMVn9NKQPwrTWmZW/7xYyJQHIlzE90+btXTtPiUUUsDErtt70ZdZY/T8LhcJPHkIttXapdsmACDi0Duo9Qbiy9juha1ohomSA/Iuhu/YJMSEXbJ8wezmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fBerPRkJ; arc=fail smtp.client-ip=52.101.65.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SsPJjtb43qFkJbxlrdG7mWfShFVv94F9l8B93i/U6h5EhR0yT1s82q7DWvNh/VFGPDkpyAqWvbHwb3kNzw5osYvzDhjpUjaxOlVjdtBmaPfSWpfScdxMaTlCo8hHTQPbk5sTbGTZRdDxq7rn5k3ZkwzcnpCF3dU7DUy4meIZMiWG8CPHjinLiKu5kfHPb6TSJ3022TpmLANvsgP2ZadBAIK8x2oN3vUljh2OFaYcRmjhbYY9JLsXnJt1wYhadEP10haVBt9FrtIbe+P4X7ismHlqFr+LKNbD0AZZrVTh3+yS2OrKjZZg8mHmpdoZTAz7iXjNma6ZCd8nXhYUyri6kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wuX1Jv44F0T7Lrz9ExIWNFVs/gpRUetjCUAmSbU5G+M=;
 b=cjkblkemwF/jG0qLrED49SeURvSRKOyfNmFKPMJpiII+AwIyb9LGqBNqUZsChph6gdnkTRav3ReBFEFbKnGuUeBjDlH44dhBfxXRDd7hQbLiW6iF/RQ7UK+6op9UXZyXeaeMu8fXVWayFCqHricRx0PEDUY2HHYi5bD1CtYBHswZar0fkyKTggxxitwapS8+CUy8TtDarP0Pn3WoX27FbcxE9Gdg86Y1J4s/vVB63FiZ9RIUgIznGe04MhhFOhyG3AAoUQYxsQeFwcDomZ88i/bt4L0qZ15lUaMpC3N33Uq1utjAExMsfRGRXWujlG/UAqbphaHpHWgXqxRzmOIfuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wuX1Jv44F0T7Lrz9ExIWNFVs/gpRUetjCUAmSbU5G+M=;
 b=fBerPRkJnMcJ5loSduPsBhFwbUavmWFlQXatSSo2YSI5Qm9CUpKaU77sc0clVOyQeDsySxSWJZLFGKYhEUoDm4XG8JW/D1jT9ddstmTXdfXtwSE+zOIKUaovVOIV9E0+Chpa2UoZXRCzQNU3lrTG7wEXlu9hIEWsCyWtBSNgRxnGzs1kkt9BtmxWaAVlkkF8bO7TUMRBypaV2uDVjyQ4D23e/QMv+E1b3g3TaX54U02S0KRFj14rOnw4lpnfc96Xc0qNCC0brYXTaHJ4jdpb0pJeRCHxOhudRXG/Jo3XY1+DtK9XIpLR3MVrPxP5gTSJmLvSVu53WAxTAon1sLUT3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB9849.eurprd04.prod.outlook.com (2603:10a6:150:112::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Thu, 19 Sep
 2024 22:04:25 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 22:04:25 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 19 Sep 2024 18:03:08 -0400
Subject: [PATCH 8/9] PCI: imx6: Pass correct sub mode when calling
 phy_set_mode_ext()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-pcie_ep_range-v1-8-b3e9d62780b7@nxp.com>
References: <20240919-pcie_ep_range-v1-0-b3e9d62780b7@nxp.com>
In-Reply-To: <20240919-pcie_ep_range-v1-0-b3e9d62780b7@nxp.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>, 
 Saravana Kannan <saravanak@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Jesper Nilsson <jesper.nilsson@axis.com>, 
 Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726783409; l=1068;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=dDCIqEiGeYvyy7IOr9TuFKqg1ZZuhKUnDbXG/Msug68=;
 b=a+2uWRpQ6JztJf2z7lwr76pcyuFB2hb3FkIRbnnPH+cJPKS2VS92W0XyvHpd87n4N22XS6UA7
 O/kVJSZWcPCCRwshdp/DVO9y1xdL+Lng7iYFmi4fG6o1tAHohBYtVRC
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0057.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB9849:EE_
X-MS-Office365-Filtering-Correlation-Id: fb61c298-efea-4806-99ed-08dcd8f70625
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFhDYVUzdTJLejhTMUJ5Y1RBVDZBMDRMblQ5WDVxNzM1aFVMMUJTeTMzQmpD?=
 =?utf-8?B?c0RINWhkVThSRGNjTXEyZmJMVHQzSC90YjJEempyMzk3TWlJU3J3clIyUFF1?=
 =?utf-8?B?ZWJxSE0xV3NLdnl3YzlEQWVybXkwK0F0L3ZGR2l0Y1AyREQ1UmlRK2NDbjRi?=
 =?utf-8?B?RDBYWE9GUytNVGpsTHI3dUpiaVplRFRLb3g5bElwNWw0OC96THZ3RzFQUzc4?=
 =?utf-8?B?L1JiTmFSbFg3SzNYV1dQZWpJaUpRSEcycWxiUlZBVXFCZDNzamxmOG9TS2Y2?=
 =?utf-8?B?WmxZK3hFeG1pVVpJOHRLRnV4Q3hmbnRZRXhWY2U0TkpzYi8vZGlCa3Vqcjlh?=
 =?utf-8?B?V0p2M3JkWXhiWnNGbzRmNkY2VGhZRWYzaTUrRmFhYkJUMEd2NXhVOHNZeVdv?=
 =?utf-8?B?Nmk1enNzL1B0THkvaGM1amd1RnI2L1pxa1dCeFpZcFdtbThiYTlwaWpITXk5?=
 =?utf-8?B?S1VwdnYzbEZyeXNCZ2NNd01RdVVzeVpzd09lbkh1VmtVTmlJNUVoaStDWmh2?=
 =?utf-8?B?eis4aTFjSXFIOUtZZEZjOXZDWXJqbmhydzJVdlJqRFFnc0dlc1ltR3RNMm1r?=
 =?utf-8?B?TEVrY0RpUHZ6d2NJQTluTSsyZ3IxeVdzZ1pHcFFuMFJ1RDVSTnV1azhHVFJB?=
 =?utf-8?B?TGFxYXpwTnNjakExWlgwQ2RNZnJseTdKSStTT2xBQ29RYTNwWlNXODZoZkxS?=
 =?utf-8?B?Ykh5d2xRZVV2OG1sdThrbWhHNTJDelo1amdiOEg3dXhUcWdDOElaY2pWWThJ?=
 =?utf-8?B?NzAzdlEzYUVoVnAwVzMzd1N3UmVYWW1FcXB2SmgwcE9sQnNOTkYrV1pVU0Zv?=
 =?utf-8?B?RVJtbEVXYzBZWXRBdjVXNGRLOXBqMFAwazR4dE1BaUEwbUJrai9mT0xsdENM?=
 =?utf-8?B?RHF0dDVXaWJJd045WVZWcTZEcW40NTltNndxMk9qbmZpNVljczFVK2xuaTNQ?=
 =?utf-8?B?Z3R3eCtVaEZoN0ovYzJJNjhlQzZRWWd5YXczY0crTHhPRnhSUkZvTFRKNTFl?=
 =?utf-8?B?UlIxWkFOSDlTekExSmJENktDUVhFdFJua0RqZ2R2NTh5enZZWGxLY29vT1hM?=
 =?utf-8?B?VGlnNWl6NjFpRk01eW1mWE1hTkVGWklkaUZrcVdXbG92MDRtYSsxa0JTQ0I2?=
 =?utf-8?B?WXFTOVBEeFNELytoWnlhM2Q2L1BRLzBlU0Fla1hiRGZhMDdKdVpodlRGZmRU?=
 =?utf-8?B?Y0hKaC9lY2N2ZmFENHNXQ1N3YnNtZGlDMVp2bWpqajZOOSs2UDF0bzVUaDE0?=
 =?utf-8?B?cGsvemhFUElyT3cyQXNIdXBzMU9DZHNQUVhvMDFIZTlINjhSUmI1UVN5Qmgy?=
 =?utf-8?B?VFhWQnNzZ2I1ejloL3loOEVPdm1rS0hibEJRaVVzRzlLSmhxOWZLMVdaZ2M1?=
 =?utf-8?B?KzFGOGFzbmlRaHZFRGZqbXptT2ptMVhaL3BDUjBvaVNLby82a1RhVHROUFRP?=
 =?utf-8?B?cFBNQmFUL0hJbkZuOGFKWmg0azhxemhRbDhDV1FtY3RVdWlVdGp2QkNNTVc2?=
 =?utf-8?B?VTN5U3pneFoyMGNQUGIySHJiL29EWW9ER2hGQUo3SW5LT25BU1RzZGtEaWk5?=
 =?utf-8?B?YVVya3pWZUVnRENMN1FLOGR1bEtXMEI0YlRDQUh5eEpqVWIrUzRQOFlRQWJ6?=
 =?utf-8?B?MnhpTE5aNSt0MU9Hdm9FUllhbUpoUUkxNm1TaDFpU3YrUUtQZnlkMmRvSU1w?=
 =?utf-8?B?YUlRT3QxMklNOTBRRWhOcDNSSWR2QzFrQUZRd0N0aDhlRGdkUzFTd21aTGVy?=
 =?utf-8?B?WnNmN3V3eE1EbUFiMlBZeC9DVERSaXJsNWEveUJyZGl0amxaSlpCY09YeWFL?=
 =?utf-8?B?ek91ZWQzODJOcTZtNytTOGJ5YWxEZDBRRWlDd3poYnc0bVBkT0lTRWU3ZzdM?=
 =?utf-8?B?WlI5VjJjb21oT1l1Vk9Kam1STk5XNi9DSFdNMndKUVM3Vm9JazRyNDBpTkVh?=
 =?utf-8?Q?7m3PYd/s9lQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXByTXRHdk95cXE5ampXNFVwUTU3RHZvWU5WeTN4OWRZOEI1NWoydVdvMzMw?=
 =?utf-8?B?NkRGSkJreEhMSW9kR1Y0R25Nc3RJL1Nxb0hybVI1dUJXaG9EczI4NnJCZEFF?=
 =?utf-8?B?RHJCYlduTFlkWC9jWTlXYklVWG9ibkwrdjZqVnRoeFhlVkVnRVVycEhhT25m?=
 =?utf-8?B?ekc1QyswYzFWU0llL1ZnRnZwdWxnNFNRbEJBL1g3Wnc2TGdpK0FuY29zeGxm?=
 =?utf-8?B?Vk15dWZncGtRUXJDcUJ5TVBCblYzZThGdmhwakx2eUhiTVozNEUya2xGTEV1?=
 =?utf-8?B?WEZ0OTk0Y1JncEF1aGxYT1l6TFROY0NDQlI4QU9vMUJUenlaNTJYNFZSMWw0?=
 =?utf-8?B?RGhtNGMwK0VMNEdBemU2Nk5kaURSUEdPekhLNURPYzl4VnV2OTFueURWMjZG?=
 =?utf-8?B?V3Q5a3ltY0x1bWtiVkphSk1PU1luQzlMNTFuTmlGNGgxdEFMSlkrbjJ1RUNh?=
 =?utf-8?B?YU82VXpYOGNiYXU4K1NmOHZlYVVDZ3RQWFlQSURyVGhuN3JnVVh3WjhVL2RW?=
 =?utf-8?B?SEVla2ZnL0d2RytoaXR1MnVQZ2Q2ZUJMTHpoRHJCNE1sVFUzN04xdFY1MjVY?=
 =?utf-8?B?ZGNhb0ZLUU0ybU5ydlVOK0llU2xrL0x1d1dJUERNMmt6M2RaTDc1b3c1bkI1?=
 =?utf-8?B?K2RXcDhsRUlmRVMyQXRhV081R2kyVzk5K05VN2UxYnBSNGtYRUFWblZnSlg2?=
 =?utf-8?B?NUZLNVVicmh4S1RtOFI2ZktFRWpvMHpqMmNLTlFDTUl0WnN1V3M0aXc0azVW?=
 =?utf-8?B?blRIKy9nUkExS1ZQeDg5ZzIweDV6bG9IQlNHTGtQRE02TWJjdi9abVdTZWhh?=
 =?utf-8?B?MmtYd05Sb1FvUE40RHNFUk9zMDhsUHpiNmh1dlpuTThJUzY5azRoOXd0R2NZ?=
 =?utf-8?B?WSs2RjUvVDRWS3NoMkFOSGpoWUJSMWQyRkJlallOTGJDQ05YVk16c3RlUjN5?=
 =?utf-8?B?cHRvZTkyUEcrRXJ5ckNzRThuZ3IzbFVVWjVqNnVONW9hQXgwU09hblMvaVZI?=
 =?utf-8?B?cmo0Y1BjeGhBRWVxNnhlV2dDTEFXY0FJZnNiclZUWkhjTzBpSkxQZFgyQVRk?=
 =?utf-8?B?OGJNSjV1TVAySXBsZ1IxN1NpMzhBYytiY2huK2NlbUF5ekRLc1NlUmRLU3V5?=
 =?utf-8?B?bzhRR2JPenc1cVJXVS81Y0xaQ2JwQzE5VlRod00ycjZrYlp0RVN2emcyd1lo?=
 =?utf-8?B?Z2tUOUVRcWR1WjgzQVdsdnM1SkxNRitLdjFrb3ZiaUxWVURublVBbi9OMHJp?=
 =?utf-8?B?OUN5QmtZWHhwMm8wVFVHQjlkeCtGalhqbEJlTGFDdjFDMitEZytxaUdLOGVN?=
 =?utf-8?B?aVZjc2NtTElLVXVORC9aVEZYbmF0UWhHcjhyeDN0ZVYyT1QzWFZwdmxjbzFz?=
 =?utf-8?B?a2pXQ1RKL0ltaXI0RjJ0MTFZdCsvRzFXb24vc3RqTGZaUDhXc1NJS2J1YTBP?=
 =?utf-8?B?bDdMOVM0cURxZng5VDBCZ28vMW95cUJmbk9pZTZwT3YxTE5SamFGSnUzZXB1?=
 =?utf-8?B?RVMrVVM0cGYvWUk2bWJJMGlBa3Y4VVY2RkpmbkNZSFVtZ1BmajlzK2k4ZC91?=
 =?utf-8?B?MlFDdzV4YW1UMHJXbUxSQlovbGZuTURYSFVVMFEyZEtWWndqUlllaWQ0SENN?=
 =?utf-8?B?UUhXMUhvcitMekhmeHMrbjRVTWNkOEZmRDB1dHBWVC9nRStncUd0ODdiYlEy?=
 =?utf-8?B?TDRPV3VqeFFFeWZ6YkVHWlBtTEN1WHNNUEtUT3J0eWkyejBqY2JTdVlnZ3Zx?=
 =?utf-8?B?M1BWdU51VGlLeTFzV1Q4ajI5MHRHZmJvSG01NHkwOXdPdGVnWkpuMWlPZ1Q4?=
 =?utf-8?B?NVdGMXlYaEc2L1RsZlBsbS9PZndGNURhU1dEek91OFBnWVBNeGo0enhZbUND?=
 =?utf-8?B?bFdUUUVSRGdibXRzQm8wZUwzR2laNTRHVGdyRDI5UExPYXdFY1ZrWG5seDk2?=
 =?utf-8?B?dGRSNzJLNm5JY05HVjZiSEVZMERub2x0WExXbVd0d1c0WmpzNms2Q3RNMEk3?=
 =?utf-8?B?Y3M1VGxKUVdEVENua3BKYTU1c3Z0RG9QbERFb2sxL0VjR0tITUpnZzdha0dQ?=
 =?utf-8?B?UmUwakQzOFgwMDBmQkI3b3BTL2E5K3BwSUgySkFZRVRNN3hQNTVHZGlNMTFS?=
 =?utf-8?Q?tvJ6/WaK04GqWkjJb5R7v+9MD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb61c298-efea-4806-99ed-08dcd8f70625
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 22:04:25.2825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d565yjf2HuV5LZjq6td/BzUaGM3rJHPlWCLlBs0wb+76AoDwVCroeagkiMbJr+AwV0DugW981+Y213Yg5qrlkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9849

Fix hardcoding to Root Complex (RC) mode by adding a drvdata mode check.
Pass PHY_MODE_PCIE_EP if the PCI controller operates in Endpoint (EP) mode.

Fixes: 8026f2d8e8a9 ("PCI: imx6: Call common PHY API to set mode, speed, and submode")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 808d1f1054173..bdc2b372e6c13 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -961,7 +961,9 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 			goto err_clk_disable;
 		}
 
-		ret = phy_set_mode_ext(imx_pcie->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
+		ret = phy_set_mode_ext(imx_pcie->phy, PHY_MODE_PCIE,
+				       imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE ?
+						PHY_MODE_PCIE_EP : PHY_MODE_PCIE_RC);
 		if (ret) {
 			dev_err(dev, "unable to set PCIe PHY mode\n");
 			goto err_phy_exit;

-- 
2.34.1


