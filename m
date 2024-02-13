Return-Path: <linux-pci+bounces-3417-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD63853DA2
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 22:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F9291F2A6DF
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 21:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D4F61691;
	Tue, 13 Feb 2024 21:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TltNZaNm"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2070.outbound.protection.outlook.com [40.107.8.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7BA627F1;
	Tue, 13 Feb 2024 21:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861090; cv=fail; b=jbmy1pK4ApmLT5svEsyOyURbkBx7yvrA2evTMTI9mJQPkhZrG1YjbwUD1u/gp0poBBbnELM1IF6Zu4dkI73MRJLRssTJxLQ4eYuf8wWS3+Vbx3+GyEQyUgIhxTfNZGwo/4MyddBtjBueQt0mFxv/KJSgyHCr1Rh+BzPytotmieQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861090; c=relaxed/simple;
	bh=ze2L3Nl6ITdmvSqJ46+wd69F0Sc18FLzWocNjgTx/8s=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=RwUkKM8gBK6okMb3kV8SCDbTy+iLqHBE0Nn40Fdf0zQUNF+ne7AC+vKBOSg0hJqW2LQ7CGguIvSxf07lF8SC84CVL984DZIGfi7WMPhMoKeS89RRHqBajokkEWXHfmSmaU8rlcJ6/FBkypH+ZVl5i7fzaxim4HX9AJ8sTaJvTSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=TltNZaNm; arc=fail smtp.client-ip=40.107.8.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCYFg0HxmyHaOLDkforCtKgxKOiFismyZvPsoOtx5Zy4qe6Kc0+2HSGNLf6DkUJ/u6Nq00u4DztW+D1JWS26yZ2hiMhBJUjghSlaQjvo8CCupse5JgqYfHQrj3xgtceH488TnYGbUrCPPtD6XrmfHJdka/MfvpVrMqdNvDe1V/quDZNDslLd/AHeguRzz0qYThptg2mhsRKcR7NpipuZ+kO5WQqW+rk6h/2k+XunT4EkYm11hcobcuEPvoJKuj6Dm65juc5VK9NwfkxJTZZD6lFfb5zX8AGJ+AF4xTo9L7R6xXJkIrOQu4LusLUCjO8eIRp2U4naVhiRjDNHVX9kYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCa+JiPEcnah1R3m5WeFYRmyUijTCb6SN5/1c3JFNUU=;
 b=D/CUiyIq+Y4urWCeqRMucgagTIbZrzKEs4mokzWHTDZfOn7aDlygwA13OxQVy+dy1+GXBUxAwyHIvJSZipFqO1Kkz7gqzWRvkiz6QMXvJZ9yiKOigEm9xTW1Ch4SrZOfIh9u7cO7Q3J4IzXSzneqC8LtBCymehNYfQnCQVarq8bhFDhbp4MZ8WjPQOVL96sa7DMiYZ7B4b492GOe/L5Zf6NNU+Expty8JHZP6s7aACGmkd9i+7OHUvQw8h39z+RuTzWAl0NB1lmwBp4J5vt3e2gZ7ohN5lSC2Q6N6xu7w/y92lTBVePiypILb37xtI2WO5d+3BuI67IDX7NFNu+fOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCa+JiPEcnah1R3m5WeFYRmyUijTCb6SN5/1c3JFNUU=;
 b=TltNZaNmqJvMwd9UDUWIpdV9JblNnviSu+C0OTunYsyzJJ9RjFZ8YtKzEOYF+/i0mDEnU7zwgOE/Pou7pl+Vm+26tvi6H6D3w6MpYtFEBV5LLUMbfpONYc7g1AYBxypYz9myJaDuC6SQbW/nJvpZr45ZJnHLfO5S4OSo6DqGJ9M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8837.eurprd04.prod.outlook.com (2603:10a6:10:2e0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.44; Tue, 13 Feb
 2024 21:51:25 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7270.025; Tue, 13 Feb 2024
 21:51:25 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 13 Feb 2024 16:50:25 -0500
Subject: [PATCH v4 4/5] PCI: Add PCIE_MSG_CODE_PME_TURN_OFF message macro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240213-pme_msg-v4-4-e2acd4d7a292@nxp.com>
References: <20240213-pme_msg-v4-0-e2acd4d7a292@nxp.com>
In-Reply-To: <20240213-pme_msg-v4-0-e2acd4d7a292@nxp.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707861067; l=608;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ze2L3Nl6ITdmvSqJ46+wd69F0Sc18FLzWocNjgTx/8s=;
 b=Z/RgbiQhswM47weTVGioNScneJnv0QZYjcxYdeLFqt5EruPoy63WOdJ3AWWl5bvO6QTSFDPyc
 jAqRE1Q9YgWDHXKkbwIUjKHb8DIaS1qF+vClK6oZJ+KHc6E+oq5s2Sf
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0211.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8837:EE_
X-MS-Office365-Filtering-Correlation-Id: 112420db-3045-4861-cfd1-08dc2cdded16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aAnVjoyE/N3dYW3DTkNdVh66zaJ7GdDrcU2/Ek8t9h5XRWWh7fJgzSA2hQH1q3772KlxtHESNQ18mOYVAzRCFbjwQ5rLOSHeQ5ZqWykdijqlHBMEBoyQciDj0Cr8+RmPsM0WX2tAKOOq3barTg7KGE8Syxt9AGtTAf7G4FH70GZClHNGj2OHYIb/RMz3lxOC6G3BkSK2IHtl/e0z2uJRTdLQmy7Z/Sny7fSGNF4GrOamPy8OR8OCcTro85qAUlAY8vVUTXlJdQtar5ezRqZaNYKdAtzOppsECmCSLuu9V7hFJKhDZqnBAjd+4UW9sUTI0dw009agnqYhwX2sZzWFI1STeuqC3fWJHba7yThRo8sfgjORatfZGkzSCv2Kc2YOqDZQHYuAdAglSBg4OM/NkpmsWGm8ewYrZsbiGrc0FAS4mWhLcdVs2GY4LGzNlkgeryn8vqU4arKGD7hbQKk9wtdi0mEG+0iyax3TcUU6qfpdrGUpoZxYWXqoqI9TVjM+PSh2rg2nR9P/ocSwjfTybC7xD1g4Fo+wF4z26f85h9gSLVJqHPlDzFnYxvs62O5QbHuaXxOO3d+z/Uv7oFUWXOcbykktqK8vErWDED5gn8gggyMTRMMEQhsnjpZE7GI5mzQJ7bVTeB6EG2+ZY0ClCQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(396003)(136003)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(83380400001)(2616005)(6486002)(478600001)(6512007)(6506007)(52116002)(7416002)(4744005)(26005)(316002)(110136005)(66946007)(66556008)(66476007)(8676002)(4326008)(38350700005)(8936002)(5660300002)(15650500001)(2906002)(36756003)(921011)(86362001)(38100700002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TU8vb1IvS0k3UDJDdE5ROEdvQ3hYVlk5RXl3ZXNDNStkY1hhQThTWTlucyta?=
 =?utf-8?B?VW9UUnp3SVlZbXhaTjRCcm0ydW5ZdnhzZlo0aVYvZjBMUjZUWTQ3VVgxUC9i?=
 =?utf-8?B?RUhtaENlRTh0L2FxRm8zVHN3N0JrQ3FsMVYvemsrSlQrOUtkMk1tLy9uSmF2?=
 =?utf-8?B?cERWKzlMNlYvaGRmNGhwaXNRQlFCQmIyckhlanNTYTVBb3ZmMHpwdTU3cG1C?=
 =?utf-8?B?bjFkRnU0b1hscXkvQjNkOTFrYmd3ckY5V0NpNUUxdkJrb2w0REFjeitrdVRM?=
 =?utf-8?B?NWhZVDY0STA4M1BqVWdaOHRlekxKdCtrSUYxL0hWbVdWL2xqYUxoVFB5amJ5?=
 =?utf-8?B?NUU4NkN3VllEMGFCMHZjMVM2UDFqM3NKRTNZc0xoRDJJKzhuS1l0YUFRWHp0?=
 =?utf-8?B?d3R0UUQzTW1IWEcwRHQwZWRoOVFVV3VFUzdGSVFOVm5hRU4zWjgxcUduWTNq?=
 =?utf-8?B?VzRkQUVHblFzc1ZZNksyWXFzTkpIdTMyYkhOUE0vYTU1YWx1d3ZlMGp3a051?=
 =?utf-8?B?bFU4UFRYb2F2WGNpNzRDUk5lb2J0Qytlb1JVb3hzdTR4ODkxOUxiMmRWaVNV?=
 =?utf-8?B?NUFKWi81eXJTd2VwdXY0ZE9GM3lyQlI5cmR6R1Y0bWx5NUlSSEVVWXFBS0xx?=
 =?utf-8?B?TTNLOE9tSG5kY0sydjlYOU1CU293SThjai83WEVZYWwyZ29VNzE0WCtUVG1H?=
 =?utf-8?B?eGtzNlgvcG4wbXRTcjlCanRMOHVPUEVCaksrdGlSWThKazVTbE5SYnJQd3pK?=
 =?utf-8?B?OG91c3Y3TGt4WGRXNzhFVGFGZkNOWUpwTzNGR3JQeU5hWDQ1VldMc3dQcUdU?=
 =?utf-8?B?Z2l3d2c5RDAvaC9OemxPazRjTklsTm92N2Y1dHdxYzFtUW5tOWRlU1NROS94?=
 =?utf-8?B?NURXSG9QRlk3QnhIemlEcmNHRURFVzMwbzBSU2FNcDk5aEVPblA5Q1BET1lF?=
 =?utf-8?B?U0hUR1dFRjZlKzZZSm8wYUtWWXFJRzJ5dlh6NW1IcnJwTy9QbTVxN1c1a0dt?=
 =?utf-8?B?ai9lOTA0T3RNSjJjeDNGNjc3R1J6Z1EybXJXS2V2ZEdOc3VhRURWbmFTODFa?=
 =?utf-8?B?MngyeUNlbkh2VFI5L0FxUXJqZHBGMy9lSXRKbmRZMGt4Tk9DYzBmcDBWZE1L?=
 =?utf-8?B?dlNBL3RDNlJ1Mzk3cytUd3MwdWdvZlpuVkMxaU9kN0JpWk9hMjVXUHlEeTAw?=
 =?utf-8?B?ZUJNUXVRN0hUTzFpQWRhenVVU0FFQm1WVUdmekZBRC9SbVhXTkdYck9DK2Qy?=
 =?utf-8?B?bWNlUElSa2RTYmp2RFlmMytoNVJKRVFuSjg3ZU1IM2lka3VaWEFaT0lEMWRV?=
 =?utf-8?B?UHJhS25pMWJEMlphbVdidUJPdFJpNjNTZW1aMFdiL2wwenhlTk4rczc4b3ds?=
 =?utf-8?B?UCs5WmlSYVVWZU9Qd2xVOW5sWDdlSU9WNUFSWUVPS1JWZ1hraWhVZElEWHB5?=
 =?utf-8?B?bTErMGxrVG5tb3lkMFpoekNIbTVaV3U1TGxJTkZPLzM2K0xobEp1WDFKY0FE?=
 =?utf-8?B?SEhpUFdWM0NrdEl1U0hEQklwUFp3VjI3M0E1NVJ3YTNSeForV2N0ak9uazJH?=
 =?utf-8?B?TjB1OVVEeklHQ0NIV3Y2VlhnSWRrKzl3T3ByV0Z5czIyeHQyYWdjeTR5bkF6?=
 =?utf-8?B?elFPOTIxc3MrZTlzVFhLNjNHejdIeloxVDcwTGdBZTBKUTR5RjlkdWoyUzg3?=
 =?utf-8?B?cTRPb3hNWjlzOHdqWGF1cXV0R1BlOU9RcSt1VEM4MXNtUy92N0JiODVJMVZF?=
 =?utf-8?B?ajE0bUErMUw4MkZYYUl3ZkM0TDd0dFBZUUJDNHVDTFBYb0VIY0pBZ01iWlRE?=
 =?utf-8?B?UVEzY1dVei9YWVlacmhpdjBHQ2hRL2kyTTdaME5RcHB3ckVtdVNDSFJmQkhM?=
 =?utf-8?B?TFB2N0lBZzNhYjN6dmNXTzk2dFppWmZHSlFNRWlQMDZ0WS9wTWlldDhQN3BW?=
 =?utf-8?B?Qnd5S3BWNkpyMUx2di9CNUxKanMwSkNGeVowWkNNeGI1SFk0VTE5ekdGVlJH?=
 =?utf-8?B?UUdXd1B5UHhiSEpkelowNW5CVVZxKzJ3bFFweHllVzkzckxBdmxiRHByMFN5?=
 =?utf-8?B?QmtZVXQ1YThsdjJNdC9xbC9jdTkreVVOTThMUG9XVVdZR29qZ05TZzk1enVT?=
 =?utf-8?Q?iWMX2OH02WkuQke7X304ySoe+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 112420db-3045-4861-cfd1-08dc2cdded16
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 21:51:25.8060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rCagIClXn7zKg86vDXP7Dfa15KJsA5xhUlbEZblJtMm+l13nlLLrUWCOuwzRsbjERNJ+iZr+13LMSTe5o97QHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8837

Add PCIE_MSG_CODE_PME_TURN_OFF macros to enable a PCIe host driver to send
PME_Turn_Off messages.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/pci.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ffd066c15f3bb..989681a0d6057 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -40,6 +40,8 @@
 #define PCIE_MSG_CODE_DEASSERT_INTC	0x26
 #define PCIE_MSG_CODE_DEASSERT_INTD	0x27
 
+#define PCIE_MSG_CODE_PME_TURN_OFF	0x19
+
 extern const unsigned char pcie_link_speed[];
 extern bool pci_early_dump;
 

-- 
2.34.1


