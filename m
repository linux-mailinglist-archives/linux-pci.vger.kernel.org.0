Return-Path: <linux-pci+bounces-13461-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17558984D15
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 23:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77736281D4A
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 21:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376901474CE;
	Tue, 24 Sep 2024 21:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FGYQGxcQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011033.outbound.protection.outlook.com [52.101.65.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB37080043;
	Tue, 24 Sep 2024 21:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727214885; cv=fail; b=sAsrCN/hcvSTfAyyYwEewyWZy/4smLz0ej822ej0Fu/OjtdWJ1cDT1PYG/Dp5UjCi23XU28PwGh+QFChdHEJxz42Oj2GzxZmKJH+dCFzGHbpzObEhwp+IVUb+NE7yxqU3nJZ/zoNCt7pw8EwDureZhiqGU0ss4JySTGwAA5fXzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727214885; c=relaxed/simple;
	bh=iYHcmJ/RVnmcj4U/N5THcYTiiqChA+jWhJrPcB5jOio=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=g3RPzRa+3ffhOkqBn5m5xNCG7PGFSnAD0egScsrDht5mBTBQuHBwWV4dBjqhsq/e/ahK+pVdPGOGbx1Cpg6mRxlJSSqRhkLeJMNX/QoA/mgohTFIC72UMSZkLtXXMSJuID6VbynBWQmNmKMzWIk7tq3Y56Nj0HEhach8TEpqupA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FGYQGxcQ; arc=fail smtp.client-ip=52.101.65.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CmT2nyR2yEQGE5l/FT02tI6zocfEuYy/ZLxIsC34eU12Eh90M2tBftXxExy4Z3ApxyZA2E28mJvfAGD4m9C/eHOhH29NLFj28kUU3OMkcznOSGPEdJSqVPHg5QwWyQCrDwd//ORFmPQp4s/BKQQLUc+KiKE4RJR4w1l7y5GvVZ/cZA/XrGlk6uu/TMG+uIaDwOsKpr/tlUmOR7c4nE1A0eIUnrOTznUzygwDmUiq8XT5g1587Z4Y+ZqjItCZLM9DyCbFtaxFIH5yTg9+xY5ZruIhYz8Dz7zwXK75JTet92kGIGn+a8oDJmkOE/oxBaWppEI/dVE4uNQnpWpudbNFlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qF5QZhBMKTw6CoP7tWb4b9lE0t7q/1o9hBbcC8aUdj8=;
 b=YSYUXpdbn4MPjHZPqMlU1svjXXLGgS6QfhKcopbVCUI4h607LLizMSHqca8nUTFFirUjPAh1JtBUyMcSfAsdrEPYTAaCy0TZi0BC7uf+8MX2qmBqV6ULfILT+0f8PbKI9XcUsDGIsjQNrkeUbBbqepcUnf6AN1EfijqC0qaVOGupeKb8oZemN7BMssQ7pfy7shdG6hOxv5CbXthwH4egkBjwU00xFZgWokjUNrZUnj7PjB2xJT1SDJCAKiy1jZoNipDxtD7xfE8+taQfI4fUBTVfSOe6zu/NSolfuKE6SaUFvJsyUZiep4C2Id8Ji+ZXw0mSKqp5turJWDKGBVzcuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qF5QZhBMKTw6CoP7tWb4b9lE0t7q/1o9hBbcC8aUdj8=;
 b=FGYQGxcQFGJJ9qRMsGT87K9Zgpw2dcKjCVtKkAcfczYjGf9S70zo+dwgFm8il9tbjDFEMoZQOI1kje4WVH5UaWGoM9fypI+tTm4QkP4vPHSp24ER6VfwlUyDLxGGRABNyj+ZIoedEQLfcDlLyPfT6gJU+emOZjLfcAVRR224faJuu+AxYLIDicgiJh/CfqNkDIg5Qr20xdlYX6cyVQ3mvFzQkGJF65SVImN7z974RSXWXJtnDgl35nNJidRj+td0DiBt/SUl5SDSutXlW2zMsK16i64kCoRV+sxV5nRHI3udkx4Dn9jsfoBkMOIys5KqXalkI7EzSmzh8zW9CofBaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7953.eurprd04.prod.outlook.com (2603:10a6:20b:246::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 21:54:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 21:54:39 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/3] PCI: dwc: opitimaze RC host pci_fixup_addr()
Date: Tue, 24 Sep 2024 17:54:18 -0400
Message-Id: <20240924-pci_fixup_addr-v1-0-57d14a91ec4f@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAs182YC/x2MQQqAIBAAvxJ7TjCzsL4SIZpr7cVEKQLp70nHY
 ZgpkDERZpibAglvynSGCl3bwHaYsCMjVxkEF5JPQrK4kfb0XFEb5xIzahiVn6y1vYQaxYTV/sN
 lfd8PuypEd2AAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727214875; l=4155;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=iYHcmJ/RVnmcj4U/N5THcYTiiqChA+jWhJrPcB5jOio=;
 b=X9Xfuwdk1ak0H/iIzvPIfh07bi10tVWNePFnlRix2i5+sgJDfXQTYQUPxiiHsI8BQ4np30Wca
 AxUTY4kLpfnAcC/LFIFlhq7R00cATY9WQ79ej3Tqw0t6dBRHqG/pJp+
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR20CA0023.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::36) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7953:EE_
X-MS-Office365-Filtering-Correlation-Id: 1adc6612-3d06-4f6b-860f-08dcdce37d25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aU5OTTBiL3F4cXpGdStsa3BvNC9LNUpPMW1VUmRBS1RiVk5JdFZzck5XOHl1?=
 =?utf-8?B?QnEwNFdsaTNDQWFhUXkxMVE5azl4WURtZk1JV1I1U1puaERjTEd0MUtxTENw?=
 =?utf-8?B?YXpHRXJOYlMxajhEQmxLME9MQlJYbzdScXREdjRQRGY2NkVFQ3BUVVV5SzB0?=
 =?utf-8?B?eE5uSXB1Nk1RSUVhVkhjS2FOcUVNaWZFK0VHeFY4NUV0bDJNOGpsV3NQQUJ2?=
 =?utf-8?B?bk5tTkxtTHF1SVJwaDh5U2xBdHhuT3ZGMC9DZDhrand1Q0xVN215TytYTWZx?=
 =?utf-8?B?SHN6eS9TQnUyOEJsLzFCSE13QlBHN2VjTXJJRVBnSWdKQkpOWGRhT3JLUC90?=
 =?utf-8?B?Vm5TNjFLYVBFSlRhS1BzWHlGbllYTmRWa01hZGhrS3lTVWtGdjlSd05mSkZz?=
 =?utf-8?B?eWRaZWNOR2hDejg0YmU1VnpSLzNCZTRPR3h4aUlhS2lCZ255Q1ZIV05TczMr?=
 =?utf-8?B?OFVNSld0SFE0T0E4WGxiWjNkWmQzSmRpbmJhdHRtOFo1TGhrTmtDcVlLcDVR?=
 =?utf-8?B?cGdhbG9sNEhGekQ1NTFxcGkrbWs2WjZsZ3ZyY1luRHlOeWVIVFhuZkszZjgr?=
 =?utf-8?B?emtpaW9xRmczdVp2SG5PaGJMOFQ4TEJUK2N1bzIwSFBUSEZHaXdzM1l2NmVU?=
 =?utf-8?B?bTczVVBhSHg3MXU1TGtHSmk2WlRBcDV4bmxNRnZ0ZjBzdTF3bXN4Nm1menBx?=
 =?utf-8?B?d1NmcHpIOXRvNnlydE56anZNM05LakhYbUU1RzVzSWd3YTBwVEYwV2xtekNI?=
 =?utf-8?B?YUFIRkRHRjlLcVVsbWVmVmUxMktYblNOc0NISE9QRmZHOGVjMGRSNXdhTmcy?=
 =?utf-8?B?UWZ4dmszUWQ4U1lveWpVWkZxdmtKeHV1RTFsWndqZVRRMElWd1g0ZWVkanht?=
 =?utf-8?B?cE1HcDdWRThIa2pJalpJQ2wxbTNkcE8wZEc0RFNJN2JjaVFtbURsaVdSdnhX?=
 =?utf-8?B?c0NMSnZWdkZZRm9FcVROU1dveThBY0xFRld3VTg4YUxZQTJtajJqMU1RVytU?=
 =?utf-8?B?QUhxZmkrczZxeEhIRG1FYlB1c1ZvRmxvd1ZvaUl6dDkrV2pIUHpsMWpaNFRW?=
 =?utf-8?B?aVBVUjh4T3lMeTQ2SnZmRUhKOG5sVlFLOGtXcTBDR0hYRlVid0NObFBGdEpu?=
 =?utf-8?B?RkRzRlpkQWM4bXhjYU5UWEJFbWE1U0I5bEVVTlRwK3NtTmFuYzhvcFpxYW44?=
 =?utf-8?B?RlNEeDVtNG0xZHhwWEdGamFoOU0zSUVlcy9XL1NOK1hSRTZaa290M2w2VzFO?=
 =?utf-8?B?QmxVNnA4dGU5MWlzVFhJaVMrVmJhYVl4VDZ5Y1dnUmhCUzgyMkpQNlVueitt?=
 =?utf-8?B?SlJEQnloanZXL0RKYzlFWUhHNFc0VEZSRDFQMllIbmE1Rys0UWpwd0UvWWZT?=
 =?utf-8?B?VlBCUmt5U2l2d09ydTZDbGpoWms2cjBIZ0ZMVURtRStOYzRCVXYycVMzYklo?=
 =?utf-8?B?S29vSE4xT0thYW9QaUNxQTJTRFFYZFNqRVkxVjladTVyOG9EUFVTQ2xrZ3ZD?=
 =?utf-8?B?eTdMNEsrSVkvZXdIRUJXcGlnZ3ZzS054WGhJakNydGRiMlRZVFZDbUZUVTNm?=
 =?utf-8?B?ZWJJNG9MU0pVVXoyWk9qazM1MDJDOWpLbE1oaUhOOVd3bys4dDR0WExtNnNK?=
 =?utf-8?B?T2p3Z0IrODF6WXZ6V2JMNGd1RTh0VEpma3JkRW1BeFo5WVVTZkpkTldPckx3?=
 =?utf-8?B?eHAyTDZqVTcydjhWTEgxUUhxdkh4TTEyS1BxNjBYZjZHRUhoN3ROSlFWd3p4?=
 =?utf-8?B?UG13LzVDanBhTThNSk0wK0dDT1BVMVB5N3NpdlBaZ2pLdHpaVlhiNm9LVElo?=
 =?utf-8?B?aFpNcEJYS0ZNUTVSbVdaRG9TZktSa0RCaFVlbWIyTkVoV0ttQmtRQldPaVk2?=
 =?utf-8?Q?fKeSsCGH0knpg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHFNWi9QUXc0cHFsSExMdis3VXdjbFRZZlB1SnhzYmFGQmU3M1I0b0s4d3Z1?=
 =?utf-8?B?V0JVdGJROG1LZ29EYzIwWEZSUWFrc2YwNWNMZE9EekFreUNpZm1WY0ZTTW9U?=
 =?utf-8?B?enNPVDd4U3V6WjNYZXl0THJZMlJSWWJ0SFdVS2N4bTBUTTdsYU5UcjdIaGV0?=
 =?utf-8?B?WXg3Yno4eDlaVy9hbVZKMmFoenV4Qm1oVnNoeEZxY0ozTEhsR0o2Mmg4S1J5?=
 =?utf-8?B?TVlYeU5TdGYyM2pSSkZkK0IzanlBSTVpZFFNeGlSUWd5WWZkNlFSTWphMFFx?=
 =?utf-8?B?dDNHWTZoY3Z6R3FYampKdG1XeWIxNDE3TGpvaDBhY044WE1ISzVYYWVGeXgr?=
 =?utf-8?B?MFIyblVoTEJWMWtEekUwdjVmQ1kwSmF2eUYvbWxQdU4vYU45alNrb2xlZ1Ew?=
 =?utf-8?B?OWllOWVtUEtVcWtKbUxoUnhTd1RpUVdlRnJNTkhhUDJqRFRwY1dXcURtZG8z?=
 =?utf-8?B?YlFwTzVOVzd3KzlUcUpmSU9RN2p2MUFSaXBFNFFac29GTGNFdjBUcDJHcFQv?=
 =?utf-8?B?QnFyWDhGMVhkekNmOHFzODB4cm52RWFDVTZac2xOSnFLei9RMTVwdXdYcnND?=
 =?utf-8?B?MWQ2UFhrQndsVkN4VDFNUDJiOHdpMnNJakFrU3NuQ2lwUDE4MWZWTGo3TkFy?=
 =?utf-8?B?ZWZCc0dqNHYzQVNONTFDUXdINzdIOUpvS2ZVSlQ4cmxXS2Zqdlc2UHl5c1pn?=
 =?utf-8?B?eU04aW9BUm53dUx2VXBsNFVrVHV6MDdXcEEzNFpOY0lla0hBQUZmWjQ1QXdr?=
 =?utf-8?B?eUNVYndZakdKZktEWDFUMXBDVXNHd0hzNkhROWRTcVpwS1d3OWlXWS9KbGpQ?=
 =?utf-8?B?WW55Ym5BT3ZKQnFTa25qdDU0SmQzYkp0TG1JMk4wM3FFUWxhVXBreURVYUxQ?=
 =?utf-8?B?WEFkbUNEUk5YT3NxOVNINW9Bb2c5RS9uUXlCc1JwY0MzZUVLS0pHUlpxeXZX?=
 =?utf-8?B?YytQVkxpcEhsZEpudHA5UEMwemoyWWYrUTFTZkVGYTk3VmtERlJqTEdEenFV?=
 =?utf-8?B?TVRFcmduY0RyNEFlMjVuSGN5ZmtHaUcySnpEM1U1cHQybjFtSldRMkp4d3hM?=
 =?utf-8?B?TFMrQVQrMkFLYmJZS2JDNGQ4bXBvOXh1ZllVbk05d2Nka2o5bWtsTmdERSs2?=
 =?utf-8?B?akF0TGZxcFgvSHJKRFdUUk5ya205N3l0NU9Nd1N5ZnNxR3NKd2wyMGY3NnE4?=
 =?utf-8?B?RnpvRE1zSGQ5UzFqcE9ObzI4VGpjbXdjTHZsUkxDTnB2VTBsWHcxU2RzSW9V?=
 =?utf-8?B?cW1hR1pmTFF1T3lIUHg3Szh0bm92WkpINUtyeU9BcHplYUpZT2txeE1Pb0Vu?=
 =?utf-8?B?QTlGb2hsM2l3bm9kRTlyekhlRFR5aVRSZTZLVzAvdXNTZlg3dXRMeTRXdit2?=
 =?utf-8?B?WkZVdlR6YnVWMFQ0VWt1cE5BWU1Ea3UxcHUzSDJTbUpnUEdVVXhxV2N0Q3Zs?=
 =?utf-8?B?ajhyUkZYK3lxOGNWMjlsejlueldnQndMRXFRbGNoNTlpUVBBNlFYUGZsVkk4?=
 =?utf-8?B?eVYwMjIvMy9aVm9MMDAzYkpUcFFTVUd0S2ZmMUNwbDViNDZCNGJBV0lqRGQ3?=
 =?utf-8?B?SC9nNlZ2SUxZWDNZKzVKc2tFNldWc0Vua3k3THNZWThmd2dTSFdReSsyUThL?=
 =?utf-8?B?Ync2VmZMUWcyL3NjN2I1NEc4RGU1ZGZIK2hqSmYvUFk1ajhRUnZhZFJRSi9B?=
 =?utf-8?B?UlZhaXFXMjlyUGh1RThTMCsxRWRISUZ3c1E1VEd3czJEUXZzM3ZkK0hySCtD?=
 =?utf-8?B?ZEtIdXpsWlBPQ1VwaE9hNWMwY0dINitSY0FzK0JyUUVTdG52ditiZkZQQzlT?=
 =?utf-8?B?VTM0Z0ZQUkkrMzlDeHZIZVhKSlFjNzRubndXTm5zeUFRZldkNDJsM2FSTE5P?=
 =?utf-8?B?d2hpdGY1TkxjaU51aFdhZm9LaVhMVjRjRFpaSldsT05EYk9tTHR4VFJlUTMv?=
 =?utf-8?B?SHFaVjZMRTZkaWlyTU1xcTFZcjFCNjY2SUJBTFdlemJoa2ZGZ1dNVWh5QVA5?=
 =?utf-8?B?SmpKUVcwQVVuazUxOVlKV3pjOVdEcGVzQndibWxKRVhqWDhKSVV2QkxhTWZa?=
 =?utf-8?B?NlFFNkx5ZGdBSzNyQXdIUVJQUW1uMHR4NE9JRnNJRnNzOENWVXF3K1R4amZ3?=
 =?utf-8?Q?lrpA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1adc6612-3d06-4f6b-860f-08dcdce37d25
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 21:54:39.6108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JX3U3/Mm5r5RGMiw/2rcwgV1mSTLn5GHhtUekswOTvNEd03fMmFwfe3S6AVZhx1/fHDF/P4zEMLie8EEtmTUMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7953

┌─────────┐                    ┌────────────┐
 ┌─────┐    │         │ IA: 0x8ff0_0000    │            │
 │ CPU ├───►│ BUS     ├─────────────────┐  │ PCI        │
 └─────┘    │         │ IA: 0x8ff8_0000 │  │            │
  CPU Addr  │ Fabric  ├─────────────┐   │  │ Controller │
0x7000_0000 │         │             │   │  │            │
            │         │             │   │  │            │   PCI Addr
            │         │             │   └──► CfgSpace  ─┼────────────►
            │         ├─────────┐   │      │            │    0
            │         │         │   │      │            │
            └─────────┘         │   └──────► IOSpace   ─┼────────────►
                                │          │            │    0
                                │          │            │
                                └──────────► MemSpace  ─┼────────────►
                        IA: 0x8000_0000    │            │  0x8000_0000
                                           └────────────┘

Current dwc implimemnt, pci_fixup_addr() call back is needed when bus
fabric convert cpu address before send to PCIe controller.

    bus@5f000000 {
            compatible = "simple-bus";
            #address-cells = <1>;
            #size-cells = <1>;
            ranges = <0x5f000000 0x0 0x5f000000 0x21000000>,
                     <0x80000000 0x0 0x70000000 0x10000000>;

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

Device tree already can descript all address translate. Some hardware
driver implement fixup function by mask some bits of cpu address. Last
pci-imx6.c are little bit better by fetch memory resource's offset to do
fixup.

static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
{
	...
	entry = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
	return cpu_addr - entry->offset;
}

But it is not good by using IORESOURCE_MEM to fix up io/cfg address map
although address translate is the same as IORESOURCE_MEM.

This patches to fetch untranslate range information for PCIe controller
(pcie@5f010000: ranges). So current config ATU without cpu_fixup_addr().

EP side patch:
https://lore.kernel.org/linux-pci/20240923-pcie_ep_range-v2-0-78d2ea434d9f@nxp.com/T/#mfc73ca113a69ad2c0294a2e629ecee3105b72973

The both pave the road to eliminate ugle cpu_fixup_addr() callback function.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (3):
      of: address: Add helper function to get untranslated 'ranges' information
      PCI: dwc: Using for_each_of_range_untranslate to elminate cpu_addr_fixup()
      PCI: imx6: Remove cpu_addr_fixup()

 drivers/of/address.c                              | 33 ++++++++++++++++-------
 drivers/pci/controller/dwc/pci-imx6.c             | 21 +--------------
 drivers/pci/controller/dwc/pcie-designware-host.c | 33 +++++++++++++++++++++++
 include/linux/of_address.h                        |  9 ++++++-
 4 files changed, 65 insertions(+), 31 deletions(-)
---
base-commit: 69940764dc1c429010d37cded159fadf1347d318
change-id: 20240924-pci_fixup_addr-a8568f9bbb34

Best regards,
---
Frank Li <Frank.Li@nxp.com>


