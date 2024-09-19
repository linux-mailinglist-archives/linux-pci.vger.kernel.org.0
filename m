Return-Path: <linux-pci+bounces-13304-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E51B097CF1A
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2024 00:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5AAC282C4C
	for <lists+linux-pci@lfdr.de>; Thu, 19 Sep 2024 22:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C811B3B3C;
	Thu, 19 Sep 2024 22:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JygXVzgm"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010046.outbound.protection.outlook.com [52.101.69.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822C91B2EFE;
	Thu, 19 Sep 2024 22:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726783450; cv=fail; b=SsZX5egOESeHPM4ptabAhvh1/OLFLMRBgYSEQwElOOiS3YfiRM+1ePo3vmbRDXinTmJe/9+Y4HD2YqxSlKH46cXXN36mCLLhR8ze/JbfZZe84yFJYN/gC+iiR0Bc8+EDjnc1HuSKZlBlhv6m3rU2+yJqTQClmONb+8xlij8ysSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726783450; c=relaxed/simple;
	bh=xzYn63emtYc+0sKbyvuTFJ9WeodUAKX0K4Fs50oRMQo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=UdEJC0+hYFYzTYbTqwF9nNCIZC5+y67rHtRUWjmAdqFkdkBO4igIfCKMEFAEMCI1PND+J1wkhoL2SZ4k5dxdqbzZxsDwRBUAbmZW1UnvZgutzDYxW+mssbPtRc68lF5FiM3+D0jisba3GnQZ4hF4CCj7QCEpwbI0YgTvrGmlU0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JygXVzgm; arc=fail smtp.client-ip=52.101.69.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cW7bgGOrvjsNPXb4f76//Lw/ySCoHXnltL8v2PundtKtsdAqSjKGpzO9oIxQAveCjH9/05qxRXhoqRs12Y0iwT6eFe8UmCI5AmMrr/ihZlMX1eGCpqOsnyU9H6gNfTbyhtses0d1Q8qfeUseGrxOWdUR6J01YVqd8aWVmR5g5rGZgWO3rZeOydxyMdnDZlv1Rq/ycDMl/FtFneNZ+ea7Ehv82s4HpDxgW4Rf4C/RLrYHdcZTCdRR8xn/g9wjwiDYtnaU7CvQOLOA3DnXpWu5u/CJSQTyU1z9Y9mUVzMS8FSLO1bYb6Dlkz+gqZmOxPc92KFZ0JXVVwr6OQ3ayPWuRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5eUkhJHRxOeEl28v7oWBblbZUiVSwRNPOWGzZMSZ0o=;
 b=HhgghtOVM7kVKEGpyoVHZmTbP41AY4KpMvA6g8mxQoray0kM8qsw7L3Es5ME2G1iuuI8S4QQ/G+GBdqeu5B+EsT1GQg51mjcF6CEVLMirQqrSJxce68yJZmZxuecm6HfiqWpZHBkbYI9PFrx3jg2XcK4xnpfoZ8eVDqWtYFyakBAA3p5kFUtAM2MPxZYTdUgF1lGPqKHJNn+236vm2RWopYNX9vIC+6Kg1DkbyBs+myEiv41mtIDHfCeTt+uOvqoBxlqNoqUjqDgTQArZZRC2kfXvMlI3UMHd8X1XYEYT0bBeFMfssrkDlWe4Oy5MrToTkBNkKtfL618k+28Ff+1iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5eUkhJHRxOeEl28v7oWBblbZUiVSwRNPOWGzZMSZ0o=;
 b=JygXVzgmIqxxdExmaLA9Vu8bCTu3sTv8a3ztsLmPgSyK1WlXc5s3ZiwqffmaGqI7AsamRipmLNAfEGyqfFoQxRd+iZF6gZqlAOcdISI47SKDtjjrjZg08OEuu5XFZu0uSBPZ2FbQdDszeCu5BgamQWPGYO2oHmvGpiwuaq2nByNpma73qrmcmcN0BF28b1hPsK+HxEL6n2G8+HMN1q4Kxq7lBWQBOSETxBqffip3X4BGwPCuLHwu73hE+jPy5ZrQL3W8iB4kFjcKqCxwdPeLFO2iKDAK1BgOt6O4yv0XlXkzABckoL/oaZ3wtCase0PN57Y8ySA+aGsWQQXM9Nf5CQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB9849.eurprd04.prod.outlook.com (2603:10a6:150:112::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Thu, 19 Sep
 2024 22:04:05 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 22:04:05 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 19 Sep 2024 18:03:05 -0400
Subject: [PATCH 5/9] PCI: dwc: ep: Replace phys_base and addr_size with
 range
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-pcie_ep_range-v1-5-b3e9d62780b7@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726783409; l=3076;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=xzYn63emtYc+0sKbyvuTFJ9WeodUAKX0K4Fs50oRMQo=;
 b=F4FFq004pYIQGI3NL8uKoINIVRJvhIbVz198gtigJ7zMRQT9xuttIBNi6AqXVgvdxZnUE30hX
 GRMs1qYsxpLBgLyjTM++wDtdiJXxcoNlmvpr1yq9M00s4qH+memyi2z
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
X-MS-Office365-Filtering-Correlation-Id: 237f8e7b-dc94-4ce0-2695-08dcd8f6fa72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QmUrTWQ4a2MvQlY5akF2ZU5Zb2s0SE0wQVR0aHp0L25QU0FWTE9Cb3p3RmF4?=
 =?utf-8?B?MWJaMW9VVUVHQTVZWll3d1lYNVpZaXlWV0d4b2xmbU1OczZrRzQ4QzIvYW0z?=
 =?utf-8?B?NHc0aXBMcGV6aWdaQkVUOTVDOWlWdUxmbmYxN2ZIdlpxVlV1UmJvMnFhZGxL?=
 =?utf-8?B?SHA2WHdST042MWRrSGp2TFluV0ZaS0lyb3Y0MThTcWNHUlY2RG9RZWFwUmJs?=
 =?utf-8?B?REZCOFhYRFMwdURYZjRxQXlKOCs2ZXhGRlFTY0JNaGRrd2tvVWtkN2pYRmdy?=
 =?utf-8?B?K1ZIcVBxZEdpa2ZDa1Y0SDNVWW9lYW8zQXN4MDlNQ0R5QzFkOVdaakdEVjV1?=
 =?utf-8?B?QVJBcDk4R1VqaVdiV2c0VC9rYm9HaUlZR0tsR0d6aW10VE1LVlJWRm1yT3J2?=
 =?utf-8?B?RlkwMnhDbmw3UWVFQ2dFNWUzc3BaeVlXUlFaUWNjYXZuMG9KNFlFL2N5aFRz?=
 =?utf-8?B?M3hwczZZN0c3aVRhWHM3M3VlYkZYQUsrQlpMS3Avd0w4N213Wmo5Q2R5SjJV?=
 =?utf-8?B?SXZFRTJSVkRhaWFxR2VsVjhMWFVEL3NGWGd3bDlLUzE5NnE5RlJHbjFZbEFz?=
 =?utf-8?B?ajVmYk9HQXJJRWtkSmZnRlpZWHN5WnJiOWNGMys5Q3lLZkhMVVNLNkR6ditv?=
 =?utf-8?B?QVVOK25PaGYzcUtncmJuNjRvdDM3eE4yRm1IV0ZIQ0YzY0JVMEVSYWNuRFRm?=
 =?utf-8?B?Z3VFU200Z2dFM0FiclUvRENZeXA3d2hCRGlSZkx5RUk1VlBpK1dJQ0k4bGJk?=
 =?utf-8?B?ZTNDY3dzN1dnZDJEN2Jma3VOQ0lpZ2FmZlpPaXRUdlEzc09jV0FrNXZmOEtU?=
 =?utf-8?B?NDduNW1zLzBYZVdrcmh4UXZ3VWhjNGZJdnhDTElJaFA4NEZON2phWjEyQmoz?=
 =?utf-8?B?TzA1aXVYRjlmSjZ5ZDdaU3FIL2tXVEw0ZS96NDhmT3pRRGFGeWlvUDZRMk93?=
 =?utf-8?B?N0VITXpKRTdJMXNRb1lURWM2elZJRDRWZ043Rk5VNUMvT1J5VlRQRit4NnBC?=
 =?utf-8?B?VHo4SDR3SFV2RFdUZ3pKb2Z5OTFnR05JZFNGSXZmdTkvcHRhbmdWZ3YrQ1hy?=
 =?utf-8?B?SHBaYUFyQjdzNW1EdWF2ZXRNV3Jxd0tubjF3bGRxUjZNaEJQSHl2bEJPd0dG?=
 =?utf-8?B?VUs4a29aMWJYOHhxN1BFUEZHNXdNdUNqb2puYjV4TXBQMVkybC8rQktWSFlo?=
 =?utf-8?B?aVR4VmlFRjg0eDVJbVFBWm9VWDFMQWx1aHJMOTU3SGpKdHJBc0pjbkt4RERP?=
 =?utf-8?B?b25BdjJ1dFVFMzNkUmYvQXNKL2xWQWhTYzBlK3lOSnZyc1dlR3VKeE9zRWxi?=
 =?utf-8?B?RFhjUDJhWTYyNTF1cDVBSlQ3YWdoRXZpMS9XMHN6NFQwSmNaU0h6UUc5cHRT?=
 =?utf-8?B?NitLQjV2WDRJSkF2a3l3THNEcmNPbWgzdXRKbXIzWGM1STg4TjlkTXdPeHcx?=
 =?utf-8?B?eHA3aUdnYUZMdDlXbGorV3FxcHhPTEs5M2Via1IrWjBmYm1zVHdTdjZyYWhz?=
 =?utf-8?B?M1k5dDVzbWJDUERpS1hrcEhkdmU0a08vdkF2MzRScWlPOEQyTkczY1I1RTE2?=
 =?utf-8?B?OEZqTjdaZ1hxbUoxam5HUmRUYWNlSkFLcEFqWXJ2Qml5Ymo3YURDZWFEaVVH?=
 =?utf-8?B?ODhVeGlkYXJiR014U2hWalRVK0Q2RHdBcXhhKzVoN01WOVN4ZFdxM2VkV3Zo?=
 =?utf-8?B?T2JmQVJaS3ZVQ0ttZmVxSmw2ZDJJZ2k3Y252OHg5ay84UldEQjlBcDVZVFdQ?=
 =?utf-8?B?ZmRnc1NKUTNuckx5d2h1N1grd0s3M1l0eC9ldW5GcmdjVDJjd2tIUXFJQkZk?=
 =?utf-8?B?emExNHl6K0dWM2Vyb2ZzMTN0YVR3MWNvamd1THlnTjZHNFpQWFl4allSb0JR?=
 =?utf-8?B?ZVkxMDhwVm0vSWFDZzhHQmplVE5VVmpDWXpxcExoZTFDUXJjSThKV29PU3hn?=
 =?utf-8?Q?IYxyhOL6qcI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjFIdWtQK0ZvR0tLRGRVMEI1NW9KS2dNYi9oOTVNQUlkeUZselgzWUZlY2ZM?=
 =?utf-8?B?Z2prSytLZ3VIalBoVlNodDN4QW1Wb2svTkQvVHZKUFFQV3ZiRTlDTFNEVFl1?=
 =?utf-8?B?S2NGM21XTmVWV3BGNTVBbHlwYzcyRnFKaHhic0VsM1dTbHIxTGM3Z0twMnVI?=
 =?utf-8?B?YlJ5YWlRdFdzMncrMGRXSHZjeXhlNWxYNHJERkRza2xqbkZPYWN5RHdLQmJw?=
 =?utf-8?B?eWhVNFZVbnE1WWF0NHR4UGZSdUxueFVhdk1sbUtNeExEZHhtemRhbmZkSldk?=
 =?utf-8?B?Y3NxTGx6UCtKUlZ2cU43SG41S05pZFV3QUZDa1Z3SE9MUXlFNU82SERQQWRH?=
 =?utf-8?B?bWxFRWV5djlkZmdhUUVMYXEvUWE0bGFDM3lTODdqNEFwMGJIRjd4K2RIYjRT?=
 =?utf-8?B?L2oxSlVoTXUvUDB1VGZ1UGFML2xzNkJWd1QxeUdjVTR2Yy9QNGIwWGVlQ2ZY?=
 =?utf-8?B?VWxWaUJyaWg2UDkyUzU1cHo0Y0Y5NmlCTUw2UWdmanZla3IyQ0srSnl4Vi9W?=
 =?utf-8?B?UUc3dDhmK1YwcGgrNzBaSlRsSi9UeXowaXRpbDQ1aG5kUWpMMFY0L2xpTnZX?=
 =?utf-8?B?ek8wS2JuNjhRdmdBQjdKZ2tDNlR5eHVxMSs2REZNZVJ6YU9UazgwVlNYWm5F?=
 =?utf-8?B?Tkl5UDhZWE1PRTZtME5YNVhRMHZHRWVjK0ZyK3ppeDE1cWd5eHF3Y3NTS3ZP?=
 =?utf-8?B?elVDTTR0Y0IrWGRsL3BKUVlBY1ZTRjN1QTZRaGRGczQvM29Ddzl6NmI0SHQ0?=
 =?utf-8?B?L2VaTDF2Yy9jVEpaZks0WkJzSHRDWUlWc0xRdEw4OSt4RHRQRmRzVUVEbGkx?=
 =?utf-8?B?Q0xNeEQrYUxianFtam9kYW56bmNMWThLYTBrdGZ3VU5jTTJnSjNmM3B3Ymxq?=
 =?utf-8?B?ZTAzV0VOZSs1N1BUUWxuNnRSTXZDSGxabDZqMkZjQnJlU1M3RG44QXUzZzRk?=
 =?utf-8?B?bjh4K1pQOWgwSHVQb3puYmFqUHhOVXB4aDFsYjByeTJWZnBWWnJ1YXE1NktR?=
 =?utf-8?B?M0crYnJjMzc2Mmx3Z0JPNHpGTEY3SGlhY0tHZTlnR3U1Z1ZxYlRqakZGZkRX?=
 =?utf-8?B?S2taVGh2eDFLRmN2VDNaZHFKSVJSdmZ0dmwzQmJyTDAvcWhTcTl3eVdxL0hN?=
 =?utf-8?B?T3hYOStZRURhUFk4bjlZU2NRdjExMU1ZSlpEMDI3Q0pWZ2tGVFpqbWNuM1FV?=
 =?utf-8?B?Nit2Q2ZSOXUxV2hvK2dLZzBMSFRGcVNBbVBueGxvS0M2cWE1Zzlqbnh2TDUr?=
 =?utf-8?B?d0I1ckNmZTdXSzBzazcyMno4N0g0UEdGMFJSdkpvUmZXcnJTeDQ4QmhWRUdt?=
 =?utf-8?B?QmtMMWFqd00zVEFRaHBzbjU2bnM3MkMvWmhtS0RaeG1NejgvQUtNRGQxRUZZ?=
 =?utf-8?B?OUNmSzhBZVgzMmxlQndaWlJzUnpDQ2gwdE9aZUdXL0hvb0VyaU82OG0vMUc0?=
 =?utf-8?B?YURJZjJ5aHpsWC9rUnlvSHF5NE9RS0c2TWpFc21VVWtDZFMyZHNrRFNLTURW?=
 =?utf-8?B?aTMvb1duVEZvWjRRK2UzRGJGQ2twS1NEbFVmTTFKWmR1dldPcUo2NmlKVklP?=
 =?utf-8?B?aHZHSDdRWmJpNDl6RkdweEdGRUx5NEF1amJzcTBRUkNORUoyS256dDlKRGE1?=
 =?utf-8?B?OS9qbXJBK0F4T3ZxMmRKOHBDZXViSUcwd2dFaUdOODRDQkJpRjV0VEQ5NTN3?=
 =?utf-8?B?OWE3WmRvRXRXYXhkUGs4VXd0dEhqUmRPakQ5R3JMMlFBR0FsUW9ZOW1TSVpw?=
 =?utf-8?B?Y3I0Z2FqYjBtTmZ3dzdvc2lscFpPQ0V2ZUc0QnRHKy8zcVNMZnBaSGY4QXZj?=
 =?utf-8?B?WlA2YXBtNEx1WFFMaDlIOE1MQ0YrdzNMaUNuOGpJOXczRlpZTkNhcWhHZDIw?=
 =?utf-8?B?YmRnMUlDTTJGU2VzSW41d2tsYUtnYmVwamZtU1NJRTJsa0w1akN2TkoxdS9t?=
 =?utf-8?B?Y0FEUDd5SzBvZE00V1JnMkxzNnp1a3EvTm9QbDFCTlYvRCs2eURUMnBoNG9q?=
 =?utf-8?B?RkZUVU9xd3ZHakE2ZmFVQlNsMmNxUzB6cEtrU2VFV05xUWM4b0J4dXZhcyty?=
 =?utf-8?B?TGNLS3VEUHRqNGRlUlpmelI2Nlk0TDBMOGZMTnlsc2xxTTZ4NlcrdzI0a3Zj?=
 =?utf-8?Q?ot2mkKaZLWj+JlTPEB0otuq1/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 237f8e7b-dc94-4ce0-2695-08dcd8f6fa72
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 22:04:05.6174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: htu9MGrbSmcSGZ3l3L8hDTyu9CFBqlZo3+2CTRvRoXA4QiiD2I708/cb+Cb1IDdBMjfzB/gSqv0D0uf/kk+XnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9849

The CPU address and PCI address are the same in most system. But in some
systems such as i.MX8QXP, they are different. Previously, we used the
cpu_addr_fixup() hook function to handle address translation. However, the
device tree can use the common 'ranges' property to indicate how CPU and
PCI addresses are translated.

Replace the fields 'phys_base' and 'addr_size' in struct dw_pcie_ep with
struct of_pci_range 'range'. The of_pci_range already includes cpu_addr
and size information. Prepare to add 'ranges' support.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pcie-artpec6.c       | 2 +-
 drivers/pci/controller/dwc/pcie-designware-ep.c | 6 +++---
 drivers/pci/controller/dwc/pcie-designware.h    | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
index f8e7283dacd47..f93d3c7a980c8 100644
--- a/drivers/pci/controller/dwc/pcie-artpec6.c
+++ b/drivers/pci/controller/dwc/pcie-artpec6.c
@@ -104,7 +104,7 @@ static u64 artpec6_pcie_cpu_addr_fixup(struct dw_pcie *pci, u64 cpu_addr)
 	case DW_PCIE_RC_TYPE:
 		return cpu_addr - pp->cfg0_base;
 	case DW_PCIE_EP_TYPE:
-		return cpu_addr - ep->phys_base;
+		return cpu_addr - ep->range.cpu_addr;
 	default:
 		dev_err(pci->dev, "UNKNOWN device type\n");
 	}
diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 43ba5c6738df1..feac1a435f764 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -872,8 +872,8 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	if (!res)
 		return -EINVAL;
 
-	ep->phys_base = res->start;
-	ep->addr_size = resource_size(res);
+	ep->range.cpu_addr = ep->range.pci_addr = res->start;
+	ep->range.size = resource_size(res);
 
 	if (ep->ops->pre_init)
 		ep->ops->pre_init(ep);
@@ -891,7 +891,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	if (ret < 0)
 		epc->max_functions = 1;
 
-	ret = pci_epc_mem_init(epc, ep->phys_base, ep->addr_size,
+	ret = pci_epc_mem_init(epc, ep->range.cpu_addr, ep->range.size,
 			       ep->page_size);
 	if (ret < 0) {
 		dev_err(dev, "Failed to initialize address space\n");
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 347ab74ac35aa..59109a32b2afc 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -19,6 +19,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/irq.h>
 #include <linux/msi.h>
+#include <linux/of_address.h>
 #include <linux/pci.h>
 #include <linux/reset.h>
 
@@ -409,8 +410,7 @@ struct dw_pcie_ep {
 	struct pci_epc		*epc;
 	struct list_head	func_list;
 	const struct dw_pcie_ep_ops *ops;
-	phys_addr_t		phys_base;
-	size_t			addr_size;
+	struct of_pci_range	range;
 	size_t			page_size;
 	u8			bar_to_atu[PCI_STD_NUM_BARS];
 	phys_addr_t		*outbound_addr;

-- 
2.34.1


