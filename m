Return-Path: <linux-pci+bounces-14582-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 898D899F721
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 21:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A40511C238CF
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 19:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C8C201029;
	Tue, 15 Oct 2024 19:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kD6QIQGE"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2084.outbound.protection.outlook.com [40.107.103.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EF9201016;
	Tue, 15 Oct 2024 19:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019874; cv=fail; b=bpRmyPjBUZii4avRkF+1Oqihq/J+Kz1WOLRA9zHB688Ge5iB+2W/SraCID4aaV4RzgSdzH4b07apaUOEmiJYcvbQNN0fw5tB1AY5tg3drVoO3xhQQTxutToQAhbtUBws+Cxqv6fqcAzvVpQC0Babve4dgR9xr+/cUlMFdHurK1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019874; c=relaxed/simple;
	bh=mxnXQtsQ9r/Ji6o5AXb2owHgaiMSnmyNmFBnlNFd3kM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=hpeCvHO6MIM4h5xnmlRP5fn0hFByfuOsggi+xUgvw15eTZK3xU2tb6h8LEPltf32bHZTGezzUd6eGEl+8B58VcKetQk+WAIdthNrzmj6uQsjr3fc88Mb2lMbP+AL+nXofqxTMPG3Vry5vQSB4MWj4J/1yQw4QtRqmnTiaWN9zFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kD6QIQGE; arc=fail smtp.client-ip=40.107.103.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vM8R+d/LfoZGuLYyngUyDupJ3aO/O4wV8vmVEtu83yOvevgg+P9Ltp1ds3e4/a3Q/bE3+cmtg8DzbvWplwsJUMLCEUAx5puhLuxrR9hRV6zWW4GeErW6Qa1xiWZiRaepLAMCdeew2tC9wqvnwzg2F824Bu9k7UDr63UgEXVKW0BjVZhDD/UERtYkq+FnvxXqOJFV0QGcCOa+nx6IXPuaUdgqMoJTcN/wxyt9xNOGG4EEvkacth1eNnJlbO0vX/+b4wLi6/6K+Lsv7IKLgVwh/XTvMOch8mmNHNpvwuJVTz3eNy5jJYtn+WVD2xmuN2ztqeP64Rf+oOACZT8fMYxd3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fL3UKGvdWP+KFjAwQhRXw53UwJq+kOcQRY6+VijyXiM=;
 b=k4VEdOcQNdZwvInN5iIFh469wpD5CL7Xbq/yvZdtBHmD59ebkKmsEjb7/1tTyDDt7Mzu02Soi0PNvVdLBMMb1Sel0Q2aFapEvcN6yfj6pGwdTkT9+6HJVQt13cmAxCd10N4lVtKFF+LRWlPk1fu7XCNGW1gclvlIV2ypcyLe7oiduW7a1BwUbTvKwK2rx/kPPEGh9xyeApQQkQ3oB6Hjx9M3MvyLPurWD6v/99dvAULohSvuEvSoAJOnAziGfoS+HpphZidu3mw9l7U8EdND2fC2MLsirsj9Mveh+3b/OUsydYlxMf48Py3UuOyxeMTXkCRjgTQFqu97HZQAFja4sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fL3UKGvdWP+KFjAwQhRXw53UwJq+kOcQRY6+VijyXiM=;
 b=kD6QIQGE6DhlVjt7VzLe8SYXFu1/rbs/BIOd1a7ryeKgMklakfEt5Vv6YQse0UlHOjO+dmLXDfF+T2IwK+7zykFhN/p1r+XISr7/dgYssNQjl6QQUJKMcixplAStf7Blr0SNN0+YdNb5xNKsp2oLyPG5ZLnbU7rQVJlyZdIbQiyEgBpTuHbcwAp4hBYwgiMgY850r4GiZJLUAJsBYsCBGdiiWDlXtZl3Fp2q8plY/3cCmglSoPNv2ABCy2mrkfw2cuSbjeUDJqeAZ08+a4OEtMX7eE0RqVbkbRi4745SyRbezhbMP3M/zJgj1lJlalu5vxF18LOOJmHwT6Qmkp0VIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI2PR04MB11002.eurprd04.prod.outlook.com (2603:10a6:800:280::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 19:17:49 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Tue, 15 Oct 2024
 19:17:49 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 15 Oct 2024 15:17:18 -0400
Subject: [PATCH v5 2/3] PCI: dwc: Using parent_bus_addr in of_range to
 eliminate cpu_addr_fixup()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241015-pci_fixup_addr-v5-2-ced556c85270@nxp.com>
References: <20241015-pci_fixup_addr-v5-0-ced556c85270@nxp.com>
In-Reply-To: <20241015-pci_fixup_addr-v5-0-ced556c85270@nxp.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729019855; l=6561;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=mxnXQtsQ9r/Ji6o5AXb2owHgaiMSnmyNmFBnlNFd3kM=;
 b=hCXFkStAglAgicEerZg0T9vjbjZOfT2D6EApXOSIqlVLvUcP9FLTbnekzA8GqCTVnl6JiHKeh
 93wW59KQVo5AvoqIVG0mHxDp4xZOBJdwVOFC0RUTEyiZBKNbGLA9Q9V
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0117.namprd05.prod.outlook.com
 (2603:10b6:a03:334::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI2PR04MB11002:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a7990a5-dbca-4741-e6b6-08dced4e0eef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|7416014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RW9PWmFVVE1GaWRuMWtmeE0yQkVmd0xrQmErYVppT3dZSXp6dkdkOGpwZGZ5?=
 =?utf-8?B?VWRPWkJUNDdFVjl3WWR0M3V5VTR6WnpyWnRBbjNDaENSeGJ6UklWdWpjU3RL?=
 =?utf-8?B?Y3lZN2hyZkVXbEhuc0RPcEtUT0F1NDVGSXBVVzdVVG5iQU5OSmxEMnFsS1FH?=
 =?utf-8?B?cmVxa0tVd05IQTc0bUNCRHk1QjJ1dVFUUzhDVFpZVlNQVjNsNWZydkpiRFI3?=
 =?utf-8?B?dW1jTDViMEtKeTdYMks1UWNOelVPT0J4eWxnM21OOFovWGd1cm9ZVmI4Q2NB?=
 =?utf-8?B?dWo3djR5VFhnZWpzOWlWS3FQZ1FnN2JCcThvYmZYNXc2clpZMXpZdWMxZ2U5?=
 =?utf-8?B?ajFrbTdBeUVueUdKNkQ1Rnl0dUl3RUVMSU9mR1EySTVOZTZqYnZvZUxJZ3Bi?=
 =?utf-8?B?OGh2ZGxuYmw5Tis1R3VsZWRYMkxEWS9JUjR3aGtNYithWVIvZnJRc2pIaXhF?=
 =?utf-8?B?ak1ZUWptUlVQU3ExUHNpd3RaUEpCb1VUUzlTOXMwQjNPdm5uUXUvYzdLQjN0?=
 =?utf-8?B?MXh5Ymp0clN4RmpwdG1iZXp4eWpRZnQ0TllKQlJsTCtkZFEvOUxPODVNWHlY?=
 =?utf-8?B?bUJuSW5VNlZNVE00NkV1UGQ1WjZRcXlmbUtUTkxyTUg0U3dhbllrKzBHMDJn?=
 =?utf-8?B?aTFJczMvd0pwT3ZocGtVcndvUVhKbzRwNEFSQUNndHp2azhGTHZUTlpzQ0lz?=
 =?utf-8?B?ZWd3MlJvTVd3YVhDZlZ2OEY5dThxSUx2Q3ltUTRtWko0UmlsaEZTa1VwNWRq?=
 =?utf-8?B?QW5EQlpsdW1CYlppQ1VkNFhwOVJDQ1QwL294TTBjUXhBOEsxc0lKSEZwa28w?=
 =?utf-8?B?SFNleHJLaDdIQzhvYTQ5ZGRrR2xITXhLV1NxSmVTMTYwUmhEUWtmOExGeVRu?=
 =?utf-8?B?b20yWEM5S2pncXBKYWRsQUwvQ2VLK3Nnd0d6UGI4cUNKbTN0eDA1Q0NCYkZF?=
 =?utf-8?B?UmRpU0ZNUElzSlVlaXhZYlZEUCtTR3BvQm93UG5tQnN4aWY3ZmxQZ1QrZGhI?=
 =?utf-8?B?VGxOVEpEdGx4SjlOSG5PcVAyOCt4SGVEWWZMakZNUGpGOWhnVWNaZXZTU2Fm?=
 =?utf-8?B?V0tWZS9mYkRzeGI4QjQ5YUM0bkVKc0Q3UHZVREErVFZGMjE2QzNOTDVCZFhV?=
 =?utf-8?B?NjgreTlsOWxjRGFWeEVyVjcwRWhxZWxJSUVzbzdZL3AxQzR4OXFLQVlvNHVa?=
 =?utf-8?B?MlFYbStJVTE0NWZiVm9URjIvcjRFRkRSdmcxUFRZeldpb1Z0aGJHZDdkUVlh?=
 =?utf-8?B?bTBvTXdRZ0I0aGZjWlZvZ2labHk2ZnVxUUtnc1M2UWcxZTR3aVBIQ3ZxNWU5?=
 =?utf-8?B?VkU5eDZQcEp6OGR0OU9kc3Q0bldHdURCcXlvWnBZc2VudXJyMTF3Z1I4STk3?=
 =?utf-8?B?TGNGeUtMNXg2eGdaUVN6Y1R3V1grV3Rjc1ZQRWM0aFNVem5jazlKamJsQko2?=
 =?utf-8?B?VDhCRHZBeWQ5QzVUcVpxRndyRTh3U3Jrc0h3M1NRWnBVWDhRclpha1RBMEx3?=
 =?utf-8?B?Zk5wUkFiV1dzL3FqQTBhZzJLdWNDRGUrMlVyUGl2WUc0M2NZREluVE0rU0hU?=
 =?utf-8?B?eU1nSHVXVTdMckpsenFBMGpYWmJNMkJtV3VtZDEvbVBBaU1ZVXorWGNyQTd2?=
 =?utf-8?B?M3FWV0I5TjAvekNQeFR6TXdmaGR3UUR4NERSYWZJYXlVUllWWjlJUEFjUGdx?=
 =?utf-8?B?NE1xUUJFcWVlaHJJRGJRdUYvZXFEckVNbGc1NTRJSTEyaHNXUGQxWWV6alk3?=
 =?utf-8?B?VnROZ29ZVFhxcVVNZXAzZCtNcGpldnBWTVVxZTVlRjRzOWNvd0dvY1BoOTd4?=
 =?utf-8?Q?Vs0AQAVyGJ4PPMVUncf/c3+i4bDSlcY0uuWEA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(7416014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NG5seDJyMkNCbGdlREM0RUhHdzZEb2VwempnRTdlNXA2K2pkU01ob3pYK3Ju?=
 =?utf-8?B?aTgvMy9VLzQ0dVJ1SlplRktQb3lvSkhQMHBYNFRkU0U3c2hMUDBIVUlSR2tG?=
 =?utf-8?B?eUkrMStscmJlL094SldWc0s2dVhPNWl5Z2F3QmprZlcrdXBQaTZsbzJGc2pH?=
 =?utf-8?B?SGJQUkhTeTVpd0RZMEhSQVRiaGtBYXRUYU8xRjM1R2o4Y1R0aS95dXI4Tndt?=
 =?utf-8?B?OUI5OFRFemdLQVozVkd0YkgycjhQRGtMTmp3NFl3M1pkVS84aGpLR1FyY01x?=
 =?utf-8?B?Nm8rQWNlcDI2NFpxOGVydjNjMWhrQkdoNlRQVXZhUnFCYVBtOWhHSC9TbU1E?=
 =?utf-8?B?VWZ5MXRrUTd1ZjY1YlNNWkFqYXhOTTU1RUd1QlMvUXQvVm9yT2NFL0ZwMUNz?=
 =?utf-8?B?T0NidUhvVzBuN0RMWndUMXJ4WkdNWTYzbXBYM0lwSWgxZG9nNEp0QmlPOU03?=
 =?utf-8?B?YnArRTV3V0dvbVJPWXNyTmU2NUpWQmhESXp3eVJVVXpCdTg0bE41ZTRPa2J1?=
 =?utf-8?B?RFNRbXF4S01xV0F0bEF3Z2tMZnNvT1lUWVdRQ3pYY3hpYkF3NWNvOGZiQ0Np?=
 =?utf-8?B?Z0xIL2lZbEpSelRLOGcxeUdaRjEzTVlHcXpUUWwyNnpaMElDeE1Jc3BKdkRV?=
 =?utf-8?B?aGRxL1NqcW5xbTg2dG9EUHUrMDB4ak95cGJLSWM5eFRrNXJRdVVOaDJFSDQv?=
 =?utf-8?B?OHlYdnBNT05wb3ArbEVmTGd4SWZpWHhTUGowb05tUyt5MDBWeGhaaEN2ZFRU?=
 =?utf-8?B?THByb05oeFV4SFVybUQ1ZTU5S2t0Q0Fadi9ONXlFMHFxakNOVUVDUFMvY3Zx?=
 =?utf-8?B?WStOMUgxZVAzRTNHMzBJbnRvK2xRVldoSDBUVGpZUmtlTUpvZFF4M3d5MnpT?=
 =?utf-8?B?TnAzeGQ3UWNQdU1Ca2FpdHN2YlhYd2VhWVF5ZVBaYnNVVEN5NUR3cXBPbGpI?=
 =?utf-8?B?SHNuMWZlaHFGSGZtOUVmTUxlaVUwTmcxcUxwK2NYekRYOVJ4aE9wODl5SEIx?=
 =?utf-8?B?TW9FcWdvbnQxbHpFcE9KdCtoQjZIazFJOTNIbzFzQ0U3V3FvNEhYbzh5QXdU?=
 =?utf-8?B?UU94U09sVGs5SlNoL3lpckxkdlFKTnpmT0U4bUUveVJKM0FRRjUzNHIyMXVn?=
 =?utf-8?B?d2pUUlhITnhLNlg0RlQ3NVRTWFYyVkRuQ2IzZUhCejFPNkE4UEdOcVowY2Q4?=
 =?utf-8?B?Z01QVUFhdWNiL1BNUWJvcklYR3IvY09semhvWXZyNjFNMmltOUdQakx2dHlM?=
 =?utf-8?B?Z2tVdXV6S0JFb1BrQnYzVityY0NtMVcrVUhrU0REdkpkWFhycDdKK2EwRFBL?=
 =?utf-8?B?QWl5RzFZRWQzbWpUdXpldjNMa3F0KzlPYldhOW5yZkZVUUtMZVdMaU5ka2kx?=
 =?utf-8?B?SS9GRVcrZHNVa2dIVW03Y2lPMDQvaGtDQkZHMzQ3TnE4SWluUHpCblNSQ0I1?=
 =?utf-8?B?ZzlZMUFqSnh2aC9jL1ByQXNCcWdENkF2TEtMZ0h1UU1WeUJRWDdHOFp6K24z?=
 =?utf-8?B?d3VsbEE3cVFsem5BNXBvL1Q4SUNMZ0ltOW4vSWFRbW9Ua1huKzd0Y3dGMmtS?=
 =?utf-8?B?NlYvbkVrbmJnRkpBUU5NaUhvV0c2dVZDNzhlLzVjZG95cFg4Y1hLT1dIcEJa?=
 =?utf-8?B?UnNzMEE3aktxcXcwTzNHUzA0dVlNMWQ1UUFMTUMvSG5BSWs2d1Z3S1Fvczlr?=
 =?utf-8?B?K0owZXpNdmNVVEVFNWJKUENvSW03YVQ1N2ZldEpicFFVT2JJNURqL3cvb2d6?=
 =?utf-8?B?UjhTSUo4NUkzVmhMSnVjVlZiMlFHZFdMT1RYaEhnSWRsa3VsTmpIM2ZrZE41?=
 =?utf-8?B?OHgra2ZjOW5pNEtTTmF2cE0wVGFvUDB3TTY4Z3BxSEVKcDNwSUplNzNBYi9q?=
 =?utf-8?B?M2FlODJUc1RZZUZEbVhra1NJRXR0TkVQR2crQjVHNkJkd3pLajdTOVk3SG80?=
 =?utf-8?B?RWtUK0Z3UHNXRGFRS0Z5cnNZWUVKdmdQbm9vMlNjVEFXNDZaY2VQWFFLZ1ZB?=
 =?utf-8?B?TWZBOUZldE1MWm0zUmZFNzNyL2ZKcnZDNkRuczRMMWorQUxpUGNVRG9kbUVB?=
 =?utf-8?B?dHhwR3ZQdlFnZDYzb0U0dHdPaWc3Y3d4MFdEUitsSWtabFhOam94dm9PcXkx?=
 =?utf-8?Q?Stbs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a7990a5-dbca-4741-e6b6-08dced4e0eef
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 19:17:49.4657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NduNIf2tDf0Rls1GonXUCjvlSzQyN/oWuMJ+6eRhxvTkhsk/CS0PKj+hTH9oJeR4M0R/AOuoqP1/LgkuV5WpWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11002

parent_bus_addr in struct of_range can indicate address information just
ahead of PCIe controller. Most system's bus fabric use 1:1 map between
input and output address. but some hardware like i.MX8QXP doesn't use 1:1
map. See below diagram:

            ┌─────────┐                    ┌────────────┐
 ┌─────┐    │         │ IA: 0x8ff8_0000    │            │
 │ CPU ├───►│   ┌────►├─────────────────┐  │ PCI        │
 └─────┘    │   │     │ IA: 0x8ff0_0000 │  │            │
  CPU Addr  │   │  ┌─►├─────────────┐   │  │ Controller │
0x7ff8_0000─┼───┘  │  │             │   │  │            │
            │      │  │             │   │  │            │   PCI Addr
0x7ff0_0000─┼──────┘  │             │   └──► IOSpace   ─┼────────────►
            │         │             │      │            │    0
0x7000_0000─┼────────►├─────────┐   │      │            │
            └─────────┘         │   └──────► CfgSpace  ─┼────────────►
             BUS Fabric         │          │            │    0
                                │          │            │
                                └──────────► MemSpace  ─┼────────────►
                        IA: 0x8000_0000    │            │  0x8000_0000
                                           └────────────┘

bus@5f000000 {
	compatible = "simple-bus";
	#address-cells = <1>;
	#size-cells = <1>;
	ranges = <0x80000000 0x0 0x70000000 0x10000000>;

	pcie@5f010000 {
		compatible = "fsl,imx8q-pcie";
		reg = <0x5f010000 0x10000>, <0x8ff00000 0x80000>;
		reg-names = "dbi", "config";
		#address-cells = <3>;
		#size-cells = <2>;
		device_type = "pci";
		bus-range = <0x00 0xff>;
		ranges = <0x81000000 0 0x00000000 0x8ff80000 0 0x00010000>,
			 <0x82000000 0 0x80000000 0x80000000 0 0x0ff00000>;
	...
	};
};

Term internal address (IA) here means the address just before PCIe
controller. After ATU use this IA instead CPU address, cpu_addr_fixup() can
be removed.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v4 to v5
- remove confused 0x5f00_0000 range in sample dts.
- reorder address at above diagram.

Change from v3 to v4
- none

Change from v2 to v3
- %s/cpu_untranslate_addr/parent_bus_addr/g
- update diagram.
- improve commit message.

Change from v1 to v2
- update because patch1 change get untranslate address method.
- add using_dtbus_info in case break back compatibility for exited platform.
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 42 +++++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h      |  8 +++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 3e41865c72904..823ff42c2e2c9 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -418,6 +418,34 @@ static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
 	}
 }
 
+static int dw_pcie_get_untranslate_addr(struct dw_pcie *pci, resource_size_t pci_addr,
+					resource_size_t *i_addr)
+{
+	struct device *dev = pci->dev;
+	struct device_node *np = dev->of_node;
+	struct of_range_parser parser;
+	struct of_range range;
+	int ret;
+
+	if (!pci->using_dtbus_info) {
+		*i_addr = pci_addr;
+		return 0;
+	}
+
+	ret = of_range_parser_init(&parser, np);
+	if (ret)
+		return ret;
+
+	for_each_of_pci_range(&parser, &range) {
+		if (pci_addr == range.bus_addr) {
+			*i_addr = range.parent_bus_addr;
+			break;
+		}
+	}
+
+	return 0;
+}
+
 int dw_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -427,6 +455,7 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	struct resource_entry *win;
 	struct pci_host_bridge *bridge;
 	struct resource *res;
+	int index;
 	int ret;
 
 	raw_spin_lock_init(&pp->lock);
@@ -440,6 +469,13 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 		pp->cfg0_size = resource_size(res);
 		pp->cfg0_base = res->start;
 
+		if (pci->using_dtbus_info) {
+			index = of_property_match_string(np, "reg-names", "config");
+			if (index < 0)
+				return -EINVAL;
+			of_property_read_reg(np, index, &pp->cfg0_base, NULL);
+		}
+
 		pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
 		if (IS_ERR(pp->va_cfg0_base))
 			return PTR_ERR(pp->va_cfg0_base);
@@ -462,6 +498,9 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 		pp->io_base = pci_pio_to_address(win->res->start);
 	}
 
+	if (dw_pcie_get_untranslate_addr(pci, pp->io_bus_addr, &pp->io_base))
+		return -ENODEV;
+
 	/* Set default bus ops */
 	bridge->ops = &dw_pcie_ops;
 	bridge->child_ops = &dw_child_pcie_ops;
@@ -733,6 +772,9 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 		atu.cpu_addr = entry->res->start;
 		atu.pci_addr = entry->res->start - entry->offset;
 
+		if (dw_pcie_get_untranslate_addr(pci, atu.pci_addr, &atu.cpu_addr))
+			return -EINVAL;
+
 		/* Adjust iATU size if MSG TLP region was allocated before */
 		if (pp->msg_res && pp->msg_res->parent == entry->res)
 			atu.size = resource_size(entry->res) -
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 347ab74ac35aa..f8067393ad35a 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -463,6 +463,14 @@ struct dw_pcie {
 	struct reset_control_bulk_data	core_rsts[DW_PCIE_NUM_CORE_RSTS];
 	struct gpio_desc		*pe_rst;
 	bool			suspended;
+	/*
+	 * Use device tree 'ranges' property of bus node instead using
+	 * cpu_addr_fixup(). Some old platform dts 'ranges' in bus node may not
+	 * reflect real hardware's behavior. In case break these platform back
+	 * compatibility, add below flags. Set it true if dts already correct
+	 * indicate bus fabric address convert.
+	 */
+	bool			using_dtbus_info;
 };
 
 #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)

-- 
2.34.1


