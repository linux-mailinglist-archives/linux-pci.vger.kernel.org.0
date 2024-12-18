Return-Path: <linux-pci+bounces-18734-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 807269F708A
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 00:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB22016BC3C
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 23:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6ED21FE44B;
	Wed, 18 Dec 2024 23:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AawwPuAp"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1D41FDE26;
	Wed, 18 Dec 2024 23:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734563373; cv=fail; b=a6Ur655h4kbs1pQiXrniShJNYnm55Ea89LEbnFsueGtOfGHA8jxXKsRczLoFr3dgVLU615EfHxqgh6OM3FM/CguX/W2uDBd/Yt4KDBLqnSQrg6Olz5TSls+Pgy9BZRCrsC0f6X+y5c7kaeD3XWvSgExjDogEvYdQKAWbZlVCJPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734563373; c=relaxed/simple;
	bh=cLEkpOzWDRZk+G7yo89vdyDGtgAmLrqYZZa7SH+fYhc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=hu00kSBjBzWOHJK/39jGVtk1fEFGmmoWqcMz5TnWiZOMXeWqkQhJNewGDltG5a6HS2Vu0JuwRrbMfkNuUsp0a9l5Za5jB5n6P2DfkghVCftewIs0qw6wOccPXXknSpT4b/ggat0G3+VNt9gSYEJ0tg/b1Ll8XYQ8B0bpY4kE7Po=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AawwPuAp; arc=fail smtp.client-ip=40.107.22.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vaYdJ2wLjmmJV3xWTQ8LC8cMRSHIDOjOHgQ5HlkQe+zW3kDlIxQJFsLKwWI8PrMea9n8zz3H3twsXrlNkRB3IxwrTBIg6oFZM8GjsfR18P6PYqVHA71FB3QKs/TqFZw7khg3kXUmxNuReMTQtKoQCE0HswuFxz/2OC6s5orWwUktSWxeC8lHawd4dUjFbtfZZdtJtY2uSSxXe3ks0RVmYOk+28YLfChK4mfkhyX70C7/hwGfx7NBtGST7y62QpKwd4rV9OGNeo41696qfALSZWny/E/0kHgLfat3/c5MFHWWDetzWC+c0FxOgj9gSHJOaVkDe4E6Xno102kw85mmYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUqKjyu4iesfDGdWp0mMyRh8NSm81pkKsC7XKJ0FTec=;
 b=UURrI0chQfJArJL1IErtC8IbdXJ3c7wMvSP2wlLlw/Q/D29QTpxUpN02SanAbT59wf4O9CRCjOfyTEIXrtQlLVHBXRN/a1OyoCIL/keIPxrsDb/U/E3QIwhvDOudv3b89OVG0HEZ7d9s1E6J3FGrzTnRhAB5n3xDQak+URGwsKZ2UZmX8BAtE9qQLEc2o4oZZJK0IJSqJ255YsTi6uKYJsXnRdMX82Irf6X/fg6JfHZLXgCKD94R6DCOIYt0ezMIZaab6zGbSvhbrinwjWWI4psovysClr+j9lzB4+0Cd8RUopHzO3+9S9b/Acqb96gIlvRmJKbmc9Wm3xy0OzOCdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUqKjyu4iesfDGdWp0mMyRh8NSm81pkKsC7XKJ0FTec=;
 b=AawwPuApiA6uOnkKJqWoVxQ8cHqw23si70805NWj1NBOd2CvyfMbki2liJflVOjpCYXPSytBYfpHc9UifOrl9oiAVKHaq0stRlDteSqM6liOcdJ9lgGJC830EEgiGtfyaSqEryVOvGg3rsUAUsaNJRByDw2GwTBVBvg1CRCJR2TOPdnqPlxiMMBoCa6osaiZ/z3CvkpjnOXiOxXmaOFrh63HAXuww3s+wNXn70vb7rbK5XOiYCTh64zUKEQibypoYxbzAyjLt80ToZaAnqHyzP9s/sYsmHHg2oXdebvex0J9R7YeG4PYCBnu9P+vP731VP2midcj7GztDwxjwj9vEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9939.eurprd04.prod.outlook.com (2603:10a6:10:4c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Wed, 18 Dec
 2024 23:09:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 23:09:29 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 18 Dec 2024 18:08:41 -0500
Subject: [PATCH v13 6/9] PCI: endpoint: Add pci_epf_align_inbound_addr()
 helper for address alignment
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241218-ep-msi-v13-6-646e2192dc24@nxp.com>
References: <20241218-ep-msi-v13-0-646e2192dc24@nxp.com>
In-Reply-To: <20241218-ep-msi-v13-0-646e2192dc24@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <apatel@ventanamicro.com>, 
 Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, 
 jdmason@kudzu.us, linux-arm-kernel@lists.infradead.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734563338; l=3395;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=cLEkpOzWDRZk+G7yo89vdyDGtgAmLrqYZZa7SH+fYhc=;
 b=C39v0uNfyK10Ox21VMlwGjoNNXDHIVqO9nFn6qXIlEJ4FhDDAx0w1lHOIx1kZDrH0K0e+RvDW
 Tdt4ZQexwqeBMGreNN3l86QwaiI06sPW+ihlXrc3oc3ZsXyXezkdsCb
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0075.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9939:EE_
X-MS-Office365-Filtering-Correlation-Id: 966937db-8ef7-4e65-38a1-08dd1fb906b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U2FiVm1SdGM5VE5lS2xSK01qc0JMckVCcWFTYUJxa0dhRHVZbWp5OFRYSXBG?=
 =?utf-8?B?NjMxck1QVEhTcE1jTG5RQk1weFBNQjNtRkNmNnhjSUcrOGlycVgzYU9va0ZO?=
 =?utf-8?B?SmQzN2hRQkFsUVEwdHc2cDcyTFl5YXdJMEFyRzlFVjdhL2hzOHZ3L1lpQ3ZE?=
 =?utf-8?B?M1hzaDJyT0NJbUpwWWY5aXFHK0RPV1F4OGlpTXljUW0ya2tSVjRDSzErUHJJ?=
 =?utf-8?B?a0k3YUh3UWtQbWZmN3R6STBUVmoxOE03TkhJcXBiend0amVxa2dQanBUSEVp?=
 =?utf-8?B?NGpkZmdya25panFJbjJjc0xWNmk0TU9DV0dFMmFpbkpVL3Z5aHlmdmRoNjNt?=
 =?utf-8?B?N01TZ1U4Vjk2RlhBS2RFN0JEUUxtS3Q2Tk9uRXEyajVGT2F4K0Q0VlpwWk5y?=
 =?utf-8?B?TXBiR3VyTTdxOG04RWVKWmpOL2NLeUtnUVhIc3RpNHpaME1ybXBVSkxmenBu?=
 =?utf-8?B?d0ZObVMvK0VFSmVTeXJsL1Bxb2xTSXU0aklncVEvdXVaQmgxSjhWVGpCRG5z?=
 =?utf-8?B?eU85V2VwQ2c5M2ZyTWttdTJ2eE1VdTlyU0pQc0RYd2RNWG82N3orY3VMc3or?=
 =?utf-8?B?WlBTY2I2ejlTWnNXbi9FVlBDeTBPRmtJWkZpOENyQWovMXo2eUV2b1NOeTFE?=
 =?utf-8?B?RERhYUNoMDM5TlFmQ2tZaW55ZFBaa3ovK2pFcnpPbWdocWFJckd4RHAzbUto?=
 =?utf-8?B?TzRtVmN2Z0hOdVBqMVBVL01aRmdmakF2dThpYzhUaThhbUo5WkhtUmlXb3hO?=
 =?utf-8?B?SG1jalJJV2JPdmFPNW1XYnVhcU5oaUFVUTVLd2hSOXQ4Q1FEcXBjOVB6Sk54?=
 =?utf-8?B?NDAzaThjeFVHenYwZS9CdkJoS1BScngxdDR5cFpicUdXbk4rOHRLKzlZb2Rx?=
 =?utf-8?B?cXBkMEFOekhoR2p4c3Z2a0FyQWowOGFubTlDeGFaa0kvR3J3bzM2a211dkkz?=
 =?utf-8?B?Qy9MMjJXdkxRb01yUWN2MWVDYkFNWFJOblhSbVJldDJ2WkhoR2tGTTc1SjJP?=
 =?utf-8?B?K1pHVHBhRVh1aGd4ZWM3OXg3NGtkcmNrRkFNeWZhYVFQdjA4aXZUbVNOTmdi?=
 =?utf-8?B?dUlkRllHdFFQV0E4bUxwSlFteWVxNS90YjhsazU4ZGZxS0RNenB4TGk4YmVK?=
 =?utf-8?B?Q2dHV2F1c1ZiczVsSUJ5b3pwcXVYOTF2N2xBR2JKYWQ0WXYyMmVLL2pWS3My?=
 =?utf-8?B?RE9ySWF6ME1aSlZWc2dUTVVTMm56Sk9udDlHVmFRU0wvbVhqcVpKTjlDVW1V?=
 =?utf-8?B?TWc5NzBxNDJjQVdsOGpNbVBUWFREQ3BEOTBGblFOUGFVRk1yZjJLeHU1V0I4?=
 =?utf-8?B?VG1iZ3N4dWVBV21NMG9zRno4VldaL0FkM3JtY1RyVzc1UmVLKzlMVVJmMFpT?=
 =?utf-8?B?eGZ6eDh1bHlsNExiQUlzMnZRL0I1MEtUQWlQZjM0a1BnVzMyQm9sTmoyRUZw?=
 =?utf-8?B?NWFqL3BHTkdqdFFwTGRIbmY4cGJFNmRZRS9nSUREdktVMFlwaUd2eDVaWGZh?=
 =?utf-8?B?UUduUFV4TTU2cmFDYnRCRGVob0Iwcm1naTFic1A3S2hpR1k3MEYvdzdjcDlt?=
 =?utf-8?B?SXRjQzIxdng3TjZGTDJDUW1IU3dZeUNGbEpBSUhaTEJZSW9pejU2NXh3RGY4?=
 =?utf-8?B?eVNtUk04bzFESlBMSm1JMURHYWswaEJEVjFrSzE3cEN2bENlaXZ6RkxpZ3Jl?=
 =?utf-8?B?S21maERLUFg4NGRpZ0REN1NINlNicDU0OWY4RXk4b2M3Rm1hOVRNWHZKenV4?=
 =?utf-8?B?eGpneWs4ZGFPcGZxNmlqVG9mTXVLa2tXb2J2a3d4VzBERjB4Vk52YjBWVVdM?=
 =?utf-8?B?a29ETWx2dW0zeEp1T2t2Z3F4QVBCUVNIaEZ2ek5QdUFla0hJRnQwbnF5TXF3?=
 =?utf-8?B?eEhwM3AybEFvR3grQVZSMERvTmZKa1dPV21zdERMNHBnOXVFcC9tSVZSWG5O?=
 =?utf-8?B?YWh6OG1jNzgvZmRxT0xpdXZ6RmpWcE41ZnRORlB5R2dXWlUxZzZrbTRWUXNy?=
 =?utf-8?B?ZEt1Z1dZd0lBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHVGMDYyS0U0OFA1UC9GS1FGanVIZ1RpamJVSmxaelhxNTE4dGp3UlRDZFlz?=
 =?utf-8?B?Mm5RbjZ0UFJsS2FXa2hSazdFd0R5SlMzaWc5aFoyTDdkZGkvOWsvOW93alFU?=
 =?utf-8?B?QnFsZHVGTXRqNi8xYmE3RjVPWGRWUDJML044dmJYY25FRVZiNU96T1doVUFp?=
 =?utf-8?B?aGhCdi8vS2hydVlYZmZqRkNraWpYcTh4c2wwYWFGMjhqT3Nhb1pUL3NCc0gx?=
 =?utf-8?B?aEtlcDQyQlB2NUVuckFIekxaWFd5QXAvS3pIMWZxNVVMZHAwRkV0OFE0dDFs?=
 =?utf-8?B?Y3FIY2F1VmJxc3V0d1dzS1d6NGMrM0lEcDJnUnc1b3JIbllFTlFWSmlaWTFk?=
 =?utf-8?B?TnhWblJqL0p0ZGpndnlaQTJwbFIyeVg1TzJFQzdBYWRmTGJFRitwZGNORVRq?=
 =?utf-8?B?Q0hBRjJFYUJNOVNQTG1FcUs1NGhUZ1VGMDVIMFZ2YjdrUUdwT1hTR1luRTc3?=
 =?utf-8?B?enpqZVBmQm9sRzJnbjdRbWFDT2k5VTJmWnd2aS94UEhVS3NRdENreDFoMnhx?=
 =?utf-8?B?Ui82MjRsaHE2eG9IUTJ1OU1JQ2VDS0hWTTZyems2a1Ria09jbkJLem1WbkdF?=
 =?utf-8?B?WU1oMk13MWdnT1JsN2I3VFdLNWk2dllWVkh2L0d5bmkrY01OUmpTYnRlR0R1?=
 =?utf-8?B?emIzR2VDa0M1aFJaYThZN2hwazlMUUhWMHpwSjVpK21rQTJTTStZRTNvejhs?=
 =?utf-8?B?V28yUDhBNld0N0k3TytSWFF5REhPSnRJNU42NzVwWml2My9EM0VUVDlXQ29V?=
 =?utf-8?B?Y24yODRqeW14OEwvekI2enVBVlZIclVhQysxSW5BQVI2dkYxSVFobERDbE1M?=
 =?utf-8?B?cnRDNUZLM1NTU2Z1SGFPZ0lCd2pjUTZMVkh4SnZOWWVPN2R5dCtqMVBSUER4?=
 =?utf-8?B?ZnB2YloxSWVkUEdVSDVEcjBKeFVEaExza0xpNDZQQXpvTWlxbmVYMHBuUXo2?=
 =?utf-8?B?SXdXb2w1N0Q4TFBzWWlXQ1Rrd0ZJR01tNFdrU2M5ZzdTeU83RHdDTjZxSFVV?=
 =?utf-8?B?SStTdmczVTZkK0tVcVpML2F5UTA1SFBWVGtyZDh0eDNnREJsMkNINXY0Sktn?=
 =?utf-8?B?em9ZNER2aW9hdUV3L1cxZlY3S09WT0FXck9qdXF0VlFzVUR6czRLajByRnhL?=
 =?utf-8?B?UGxQY0NwTlN0Q0Q3MFhqdzNiRXpWUkhoUnd5NG9yTUo2MWNsUmlIUklZRzJ2?=
 =?utf-8?B?TnZvQlhXR1UxNzI5Yzc3WVZZTXNhd3JBODZqV3pCQ05WSnlCQXdkeFVJNGNp?=
 =?utf-8?B?UkxzSmVWNW9RbTJpV3lhNjN0aGR3bWRCdnJZblRXMDBTc3dKemNneU1RMlJQ?=
 =?utf-8?B?eVJsOXBOSWludjhscjdxb0Qrd1lsazI1ejFOcWFDMUg3NGJqWXVwS0dPdWEv?=
 =?utf-8?B?cTRuVHpyMWRIWjB2Y1gvQ2RFQkdkREFPYkpZZWJFU3FBam9rRVN6aklNWEZN?=
 =?utf-8?B?TEhsM3M3UGUyOWtULzZsOU12dnByMW1uQ1FUS2dGVWwxcEoyREluVEhJb3hz?=
 =?utf-8?B?N1ZzMlF1SWd0bjdzRUJKekFFWlNoeXBzUUxINUloZkNsa2s4R1FrVC9CYU9E?=
 =?utf-8?B?TmJiRFYycG5mRHU2QVJROWR6V2NHUWZPU2cranE2UWE0MjdrV0loNDJ1QUR3?=
 =?utf-8?B?ajlibUx1Y2loVk8zMDN5aHBHSEF0aytRTFNPbW5SeVB6dUM2dUxRbE1MTzJy?=
 =?utf-8?B?NEUzNFI4ckI0MkdJcXhjejVVZEM4R0U1SUhudHgzY2hWa1pHM3g4TEhHc1Vx?=
 =?utf-8?B?dHlNRGVWMGtRSkZ6UW9DNGtHbnIwNDVEMWt6ekJhMGJzUFExTGFZVW9LQ0M4?=
 =?utf-8?B?VFptckErMXQrTTc4RTIrNnZkNk1vUlZJbkxDdmtpMGtYdUxWUy9qVTFBSDV3?=
 =?utf-8?B?V1lOWGlFRHVrV0V2a3NWTGo5L0dwQzRJdU0wbzFRK2QrZ3ZTL0p4eU9vNTlI?=
 =?utf-8?B?WW1Ic2J6V242eGpnREN5ZjlKRWxVNGI3N2cvWUx3TXJBOWZMMEtLNnRDWUh0?=
 =?utf-8?B?cVhxKzludFNuNzVQdlB5Uk1NcjZqbVdwbVV2YzhTem9HaXJiVStjblpvM205?=
 =?utf-8?B?RWlzS090dURBejRnUmFoa3J0d1p4U1Z1ZFBhakt0V0tNZlZpZ0Y5MElMWkdj?=
 =?utf-8?Q?8Gp7HEyY7lA59oLMqwQmd3W7c?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 966937db-8ef7-4e65-38a1-08dd1fb906b9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 23:09:29.9448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pNFM1dkWl2D1MGuJKqPtZTtWgtPbH5IosXzkz4hAfm8HN7kmhSVRRPLMC/3eXZh/GGewrvPTUUFI/3tew6dzTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9939

Introduce the helper function pci_epf_align_inbound_addr() to adjust
addresses according to PCI BAR alignment requirements, converting addresses
into base and offset values.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change form v9 to v13
- none

change from v8 to v9
- pci_epf_align_inbound_addr(), base and off must be not NULL
- rm pci_epf_align_inbound_addr_lo_hi()

change from v7 to v8
- change name to pci_epf_align_inbound_addr()
- update comment said only need for memory, which not allocated by
pci_epf_alloc_space().

change from v6 to v7
- new patch
---
 drivers/pci/endpoint/pci-epf-core.c | 44 +++++++++++++++++++++++++++++++++++++
 include/linux/pci-epf.h             |  3 +++
 2 files changed, 47 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 8fa2797d4169a..d7a80f9c1e661 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -464,6 +464,50 @@ struct pci_epf *pci_epf_create(const char *name)
 }
 EXPORT_SYMBOL_GPL(pci_epf_create);
 
+/**
+ * pci_epf_align_inbound_addr() - Get base address and offset that match BAR's
+ *			  alignment requirement
+ * @epf: the EPF device
+ * @addr: the address of the memory
+ * @bar: the BAR number corresponding to map addr
+ * @base: return base address, which match BAR's alignment requirement.
+ * @off: return offset.
+ *
+ * Helper function to convert input 'addr' to base and offset, which match
+ * BAR's alignment requirement.
+ *
+ * The pci_epf_alloc_space() function already accounts for alignment. This is
+ * primarily intended for use with other memory regions not allocated by
+ * pci_epf_alloc_space(), such as peripheral register spaces or the trigger
+ * address for a platform MSI controller.
+ */
+int pci_epf_align_inbound_addr(struct pci_epf *epf, enum pci_barno bar,
+			       u64 addr, u64 *base, size_t *off)
+{
+	const struct pci_epc_features *epc_features;
+	u64 align;
+
+	if (!base || !off)
+		return -EINVAL;
+
+	epc_features = pci_epc_get_features(epf->epc, epf->func_no, epf->vfunc_no);
+	if (!epc_features) {
+		dev_err(&epf->dev, "epc_features not implemented\n");
+		return -EOPNOTSUPP;
+	}
+
+	align = epc_features->align;
+	align = align ? align : 128;
+	if (epc_features->bar[bar].type == BAR_FIXED)
+		align = max(epc_features->bar[bar].fixed_size, align);
+
+	*base = round_down(addr, align);
+	*off = addr & (align - 1);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_epf_align_inbound_addr);
+
 static void pci_epf_dev_release(struct device *dev)
 {
 	struct pci_epf *epf = to_pci_epf(dev);
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 5374e6515ffa0..2847d195433bf 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -238,6 +238,9 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 			  enum pci_epc_interface_type type);
 void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
 			enum pci_epc_interface_type type);
+
+int pci_epf_align_inbound_addr(struct pci_epf *epf, enum pci_barno bar,
+			       u64 addr, u64 *base, size_t *off);
 int pci_epf_bind(struct pci_epf *epf);
 void pci_epf_unbind(struct pci_epf *epf);
 int pci_epf_add_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf);

-- 
2.34.1


