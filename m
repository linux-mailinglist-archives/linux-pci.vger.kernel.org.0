Return-Path: <linux-pci+bounces-37010-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3235BBA0BAA
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 19:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B79A1BC4E6B
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 17:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EFA1F1513;
	Thu, 25 Sep 2025 17:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IBNTa5Ts"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011053.outbound.protection.outlook.com [52.101.70.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F4B1DF979;
	Thu, 25 Sep 2025 17:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758819731; cv=fail; b=oMnWrIHNzqIymsLo980qB8oTk93BgXyS0FX+Eoow7zcmesHQk6NES0aA3KS8WmY1G+Bh8dqXJ15UBAXrqH3bMuKicpWArwnme7Oy8imxT1W5X2N3YtP32KX4NvH3N8qQfyQYJ4r1M9UrulHAXO9AUM4deQgmP1bMuo9+UG4+ukA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758819731; c=relaxed/simple;
	bh=/9asE6oZoixuOdCkTbs/vdSnkj3vDPpYK40BPeIvBiM=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=uOPw3qRig0jMDIhf7j8odtQxxtxASROLVq78uboiYNi0/rw6OH+OKlHXwQKhJDS/6qWGbdy4+8P3+VZ/CaOBEgx0UNgMVyk46d44s9dABuW9e4rzwpUxa8eDH2lOl+kAGWS/8Va6wjAYBqyCI6i+nRRN45MQxkoQ9wvDkIzj8dY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IBNTa5Ts; arc=fail smtp.client-ip=52.101.70.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hCbinawcSiWYWlxk3dClAFfHwhOOGBeRVsUXJA/T2NJ1mgZSMaCU1qDIPn6JDhE+ouQuSRad5FVwTRbJpM5MgvD2WoAuGxovLLGOnwkW3EWiIZTt2ms5D7nk80DuTxc1SEWdJ2tGoTHAeuqPkuDVsqUQBHgsZDxavLZf5j/6amHHW3hzCkk+MvBvTaLgFTvfwIPHFUTA95D9H0xDD+bPAc8BzCryQMCBr9OtZlziEBUuvAGYkrz5uO1L38simbjCYLH4uJ28zRQA1Aqxab0bb9RRvkUgapz7PYknY3SPLzr7UTEdcZMFnhe7fpomqQ4nKAH9eWQbq2DLCfUvcDfbmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVhVvayUCEscYwdbddVjR73Szp17cZISdfX0wlkjAb4=;
 b=LxBYkSfooP2tSCQKkWC59y/Hikur59KcyfHLPfKDytFRdZfMx4e16jn2tQRLUo4ej7YQeRxZuaRY6zunVGKaKxGPd5W1JaTGdn5Yqn5eV+sZSvI9RsAxjBYj6xMsxmmBcmYH7llXMGlD2KtkVKSei74WBI+homt9ZWwSLCyFgaCltU7dyAjF4w3vvMYC31O6xVJtKba8ljlnLPaFaVmszc+EaUKtDGTrJ6LQ6a5sRMyvpY2gyJ4YxuTcnL3DsHvROKS4JZhzCyiDOm8T+eV8vsIPD/yF2c2Zm0aJtw4v+k4QBWyA3MHp32IKUy6PFtvcMJj9w99zWQywd9h9ajTT6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVhVvayUCEscYwdbddVjR73Szp17cZISdfX0wlkjAb4=;
 b=IBNTa5TsnpFvlSfvM8u/3TrRoMOU4aVdacjX6H3osxCIFM9Z8Q+V3KnOziUqCtGUYmal76AbkjWqtWOr4U2wWGqV2dNTGXOT4lUGFo3CROck6thinSxhf4pGRw0xV9mFJnkXk8tlYOnDJMcXxLrPquhb3SLN6eUjt4G1mllALE95KrheEWM+bef+5rYgZIsccYm8uvDQ2cfrNdiyZxZaIi3JrYWbSnmvBdWpjAfq0SwBkCHqHRJ0i4DqHi6TREp02QjAur8KvlqHWmtLcf7GvoxyqiFTeckEFVksDCT+OUcNtqP2jFAW1CXbLXa0MsyoCIY54DY3kLSNs6mQtfRuWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM7PR04MB6871.eurprd04.prod.outlook.com (2603:10a6:20b:109::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 17:02:05 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 17:02:05 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v3 0/3] pci: endpoint: vntb: add MSI doorbell support
Date: Thu, 25 Sep 2025 13:01:46 -0400
Message-Id: <20250925-vntb_msi_doorbell-v3-0-ae0b0c93caae@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHp11WgC/22NTQqDMBgFr1KybkoSY6xd9R6liPmrH2giiQSLe
 PdGobhxOQ9m3oKiCWAielwWFEyCCN5lKK4XpLrWfQwGnRkxwkpypwwnN8lmiNBo74M0fY+lJVa
 2SmihK5S9MRgL8958vTN3ECcfvvtFotv6r5UntUQxwQXTVigubS3U083jTfkBba3EDr8+91n2V
 VtRQUpTcM4Pf13XHzOS/k7wAAAA
X-Change-ID: 20250812-vntb_msi_doorbell-bf0fbac6d6d7
To: Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>, 
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 ntb@lists.linux.dev, imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758819722; l=1436;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=/9asE6oZoixuOdCkTbs/vdSnkj3vDPpYK40BPeIvBiM=;
 b=U2EDS0ab+rYzm56UNP22NKMzCVGhnvyMqoxcmYSWQr9MXjvCXQQ7zi4HBSq6h5EKqOvpf4iNv
 T9D9elh7EoQCZz1iK9MlXpMwwLoZVRB8LQiIOV/6g9hy4JlLGf2vU2L
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8P220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:345::12) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AM7PR04MB6871:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cc30ac0-6839-4341-8853-08ddfc55412e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmFnaEcwQXpoZCsvci9oVWNhVUcxU0Q4TmtpT056bUpJeGxhcFB5VzNCaWRH?=
 =?utf-8?B?NjVkS1RISy80d0ZEVWxsNjJ6dUZKaDVPZ1lwLzJZSXkyL2xSN0JMVjc1dFRz?=
 =?utf-8?B?bTZveUVQT0xpcUxKbTVPb3lYdTM1c0R2eGRCRUZndWFtQWwycDNSTFJnd2w2?=
 =?utf-8?B?bm91Y0RWUVBIbFlrdDRPQUlRL2dhZmF1OWtjbVl5RGNVc21nNzN3R3B1YUJR?=
 =?utf-8?B?TTBCS2FZM0pSbk9XSjV6bWJtTFZSbGZqSTFwa0Q1UU5ZYVVkbVNDbzBmVEVo?=
 =?utf-8?B?dk5NeVVRL2Fqak9TN2ZLcjhER1JUMkpVcmt3RHZ0NFVOakpLMFNDUko2dktm?=
 =?utf-8?B?dXpEZU9WUk9jeTNlWW90akdnb0U5MzdpVG1TRHBwUUZpbDJ5c2o1ZjV4SXpp?=
 =?utf-8?B?NUpjbC9KS2hBbmQ1Ry9Pa0ZLTmN3NkptK3FhN1JaaXR4OENTWnorcElTVXdF?=
 =?utf-8?B?a2ZRalZTWi9iUFNxTitJRnppYW44TG84dHFUc1hESW1icVB6WW1CNW04N3Zh?=
 =?utf-8?B?eDlOcmRrVmNVVVJvcEd1blJuMk1raVpERDltWEgrZkVDeWpHblc3QmpsMm1o?=
 =?utf-8?B?eXlDam56ZFN4cFN6QzFqUTI0TFoyR1Bkelo3c1A1ODJVdVpucGw3dGhodFE1?=
 =?utf-8?B?QTAzaVZuYnR0RHBNejJqZTc5VlJpRFBHR1ZJWHoyNFZ2SlFJSTVxejhPOEZz?=
 =?utf-8?B?aEN3OU5sdU1lZVdiQ1oyK2o4Ly9FNUU2WnIwQWdEWWJoVVc3dTcwNXhxMWQ4?=
 =?utf-8?B?NCtiVmVVa0MwSDZ2b21EOGo1R2xHVWhNalBsNmRKb0lqcHg4SGtYTWxwYnZJ?=
 =?utf-8?B?Z1JHdmxPLzc3U2t5ZU9TY3ovcS9ZSlhvd3MrWUxRZXZIWmtjZEtUOGxOTitI?=
 =?utf-8?B?S0p5cmZzdWpFU1NVU21iWVMwNW5WblhUVmREcUppYlNBSFFINlpjZzNvZHFB?=
 =?utf-8?B?emdHamxhcmtmZk1TZ25ZWE0xaVZOSFJ1cVhJR3R4aU9RMVh3b2NvY1laWmFv?=
 =?utf-8?B?bEpLdHgrckhkcjVDbFhXZm94NFZEZDExSENtMU9yMkk4Njl1QVlYOEk5ZHlH?=
 =?utf-8?B?MEZoYmU2MCtQNm9VOWpxWnJCK2xhSm1sbmUvWjZkZVZ6cUFlWSt2cG9SSTky?=
 =?utf-8?B?enlTczZjNGd2YWtXUXJ6NGZ3VlB6L2VuTElXd1JzWkpsREIwaGgwVFp6S3lz?=
 =?utf-8?B?TG5ROTljQndYT0NXSEZ0MjMwNURsTU9PQ2dSRU45QXZHVkllN3hqVmFreXl1?=
 =?utf-8?B?Mk15NnpTamVpbnJZMmV2dVZ1eUhkUnA0a09OQ25HUWxiK1FYRytmaktVYy8x?=
 =?utf-8?B?WVJFZFp3blNzb283ZnM5cktGRXZwZ0c3OFhhWjhtVVVsWVBSb0o0ckxrNVFa?=
 =?utf-8?B?WXpSK1gvMXJhWGVuSVp2WnJOM09aTTdYN2FKY09xSTNZTEdXLzZFN1ZlcHYx?=
 =?utf-8?B?TGx2NWN3ZjJ6RVQ3R2svL2cxZXhiN3I0VDhuN21acUhBUEQ3UFJRV1M4enkv?=
 =?utf-8?B?bFNGYi9PM08vY3NqcnI5bnhNUWtJdVNKOXQyYmJRK3dOUENFU3BueWFIZlpF?=
 =?utf-8?B?L2hSWERiKzJEV3dBVXRhSTZqSEFVUlJjb0J3aDYxT0puSlE3Zll1T2twbU04?=
 =?utf-8?B?M3pEU1ByZFNVb3I1YmVDMEIzZGJlMVJuR2NCZ2FuS1RnZEh5eVJ4UTR4RWFR?=
 =?utf-8?B?NGpoT216UkJTakczcTNSamk2UWlTamNpTUw3RjJxZDVqYmJtV0J2emRqbmhi?=
 =?utf-8?B?aVA4Q2lmMDZyc2t4TlovYTlzbVQ4b2w4NXN6MDY5UzZSMzcvWmxQOTkxeVlq?=
 =?utf-8?B?SDN3a0UyUmRKcFJncFB3SGdFeTUxZlFPWFZ2a1paUGVUVUlsdUcraXdjeWY0?=
 =?utf-8?B?d3pkM0ZaZlRXSm9icTVJRllRQXFGWTg5VDlXTk5CdENjNDhOTHBQUlo2TlBG?=
 =?utf-8?Q?gMJ8d14tA+SVPHOZy28uGo3/TWUd7V4/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUc4RjhOS2FvS29iK1B6R09mbFF6ZXRLbnY4QWNTMUVKSlR0Wi9INWYvcXNl?=
 =?utf-8?B?SUxsM2VocGJPaVpQMTl5RTdja2MyVUxEeEFVcjZ0cHZ5b09wQTJvcmcwZzdi?=
 =?utf-8?B?NmVsWktsemJMKzVvWWxlSUhKK1VKWHpad2NWcytXYWVYMjBwQVVPbjRZYTVw?=
 =?utf-8?B?OUpjU3c5OVFoalNoWlB1bUJ4bnMxR0REbG5NUlhUbGd2MVFvb0R3ZEpCY3py?=
 =?utf-8?B?SDAzenRHQTBidVFha1JNWFBPYVJhMEZPaWUvUXVjck1RQlJEL1UwVXlLOENj?=
 =?utf-8?B?WDFzb3E0ZjVGejZ4N3pxbEpEVWQ3OHRLbFlMTDVZMjZ6UFVKbXNkVGQ1aWpG?=
 =?utf-8?B?bGltbHByaHo0UTlVKzZUNWIyMi9QK05EOGZDWVpKTFY2S0krS0h6ZVpzRVJz?=
 =?utf-8?B?RjhSMlVUQm1IeE5XQ00vUjdiYTdkQUZxdjlSWUdVbFI3MFoySDJscU5WWTlx?=
 =?utf-8?B?OWQ0OGY2alJMTVVnOXNwbEUwSHZpUHpjSzRqU3RLdWRwS1M4MlNaUFZSdk5D?=
 =?utf-8?B?Tm9PUXVCY0NkRm05Yi9INEhTTkpJTmR6TjdNb3hhV2RtRUdEUVhDUmQvTUVX?=
 =?utf-8?B?amJDSFBIWENVTFZacmdjKzNvRWpIYUZOWVdURzlFTHBYVlhXOXo3dkE2UTI1?=
 =?utf-8?B?VzN4Mjd3RkFWMG5oSHVvaXBLYnluTUg1N3EydzhNMWc3Nm01N3hVOXR4UEtE?=
 =?utf-8?B?aGFqNUdJTFhadyt4SGJWWE05ZXlTOWtJVU9MSGV5Wk5LdWtJUU1LVUdMZVZ1?=
 =?utf-8?B?T3plMTUyWURKM1VpYUVWcit1enBoS0tiVEFNem80Znp6TWZqaDdXYWJuMTh2?=
 =?utf-8?B?QnAyeUx5VGFWNjRreEJrNnNoazhRNW9pRjBKSW1ScG54K0tVVWRteENHc3dk?=
 =?utf-8?B?dWptOGlIZUVWNVloSU1qNWQ4MGMwbm5oWHNCUmVyZnVSQ3hoRitZRllMNCty?=
 =?utf-8?B?a3oxd2pLZlY1ZGEyZVF3NmVsdzlQTnZGanYyNzVNLzFhbmRJeFdPdWZmbWRi?=
 =?utf-8?B?REl4NDlDYVptUVlSbVJHV01lZmRKNWl1dVMrVnQ2Uk0rT1BLTDIwdmE1aDFh?=
 =?utf-8?B?c3ltUXFzcU5rK0FwTWc2d3NWWXBxZXk4bjAxQ3FnODdzbCtYb3hhVHFxc2x2?=
 =?utf-8?B?NURkQ09xbmIzRlZWWW1ESGJPMXEzZjFXUW50dmsyUUczRFZjZE9WdXJBYm5p?=
 =?utf-8?B?RFdTVEhEczEvblFaaEtNUzFPVml3dVo5YnN1ZWRjSUUyNlZOM3hsdWs0RGYv?=
 =?utf-8?B?MzYvd1JEZ2xMNVFWc2J4ZXlXWDBNWHJiMFhRZnRtQU9DNUxzREQ4c25za3B1?=
 =?utf-8?B?SE1TUXpaQzlTMDJQWTJFU2U0TWdwZnZvRG03S3BodkNDdHBlcjhoeWZxRXFj?=
 =?utf-8?B?MHRHWXc1SGpDRVN3NDJEYytDcUdEd1hHb1ZYcjRBNEJLbVNxbFpqUXVYREpZ?=
 =?utf-8?B?MXA5a09EbklkWHZsbmRTN3dNbjN3dkVxaXJHTkR3emhRS21zYlVPNnZ3L3Ux?=
 =?utf-8?B?NWw0RlBHOHFrYlVGQzlRTFR0amVkSkt0bVl5S3VvaVRjbjhOdDJ6ZzhEcktS?=
 =?utf-8?B?MERuYWpyVWowQVhNeStWUm9JR0ZMMjFDR2puSi9sQkxTS2NHSkcwYUo3Zm85?=
 =?utf-8?B?eFV6S3BWNnh2dEFaN3JMVTZRODNTblN5N2hadytGOGJWbWdPSzhXVWd5RVN4?=
 =?utf-8?B?c0hycUlzRFlXbHk2Smk3ZC9XU1IrTnNSV3V2eUNZcDZQdTdzT1lISEtOQmdB?=
 =?utf-8?B?NG8vc0NFS21ZVU4yejVPWWtveW8vcFoxSTBIeWRBRHdiWjQzdnExcks2Y3pt?=
 =?utf-8?B?dFRBcVZaZTY0bzJBSHh3b1J3WFlyVWs0U2VMSkMydUJ5TDVVcWJiMjRWSFcz?=
 =?utf-8?B?VEprWi9sRkcwSzVBbTFpMmt3TXZHajJUdytUM1AwMUNCNjJkazhwVlVlZWp1?=
 =?utf-8?B?N1JFVjdjanZDMUhobEp5dDFjWFdMbDluMnZuN1VVM2ZxeFhKcjRreUQrU0VL?=
 =?utf-8?B?Y2JnWVdFS01hbXRlNkk3NFhESzJ1ejdySG5hK3VERzNsZmdTaVJmZGV5YnRC?=
 =?utf-8?B?M282VFBRYjEyZGI3ZkFUQ3hkMmpjM0hQR2tMbmdYbjlreGtvS3lPcmNaR3Jk?=
 =?utf-8?Q?17T/3Hh8M5iJZ0i/cwYfanNMe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cc30ac0-6839-4341-8853-08ddfc55412e
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 17:02:05.4008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vpr6F/QukO0fnWi8bsKC2dIOPvKLdnx/KbCx8RBODjFvEts+rrkBAR/J+Igsd4YfYgIvPo8tGIe4jQ4aCC0PlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6871

Since commit 1c3b002c6bf68 PCI: endpoint: Add RC-to-EP doorbell support
using platform MSI controller, PCI EP can get notification from Host.

VNTB use this feature to reduce ping latency.

The first patch impove epf core API to allow set any MMIO address to specfic
bar.

The second patch add MSI doorbell support.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v3:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v2: https://lore.kernel.org/r/20250915-vntb_msi_doorbell-v2-0-ca71605e3444@nxp.com

Changes in v2:
- add help funciton to get bar's inbounce size
- fix miss x8 when caculate bits
- Link to v1: https://lore.kernel.org/r/20250815-vntb_msi_doorbell-v1-0-32df6c4bf96c@nxp.com

---
Frank Li (3):
      PCI: endpoint: Add helper function pci_epf_get_bar_required_size()
      PCI: endpoint: Add API pci_epf_assign_bar_space()
      PCI: endpoint: pci-epf-vntb: Add MSI doorbell support

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 149 ++++++++++++++++++++---
 drivers/pci/endpoint/pci-epf-core.c           | 168 +++++++++++++++++++++-----
 include/linux/pci-epf.h                       |   6 +
 3 files changed, 275 insertions(+), 48 deletions(-)
---
base-commit: c2a282d1fccc53a989da61a5da4f03c9d67ee99a
change-id: 20250812-vntb_msi_doorbell-bf0fbac6d6d7

Best regards,
--
Frank Li <Frank.Li@nxp.com>


