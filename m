Return-Path: <linux-pci+bounces-3416-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B74853DA0
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 22:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BF011F2A134
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 21:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F99626D2;
	Tue, 13 Feb 2024 21:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CawbRRHb"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2084.outbound.protection.outlook.com [40.107.8.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550DB626B4;
	Tue, 13 Feb 2024 21:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861086; cv=fail; b=gU2LatpU+EmftmUvbFys29i4I4nv93wJHdmDviz9mzZfKpzWF0SAw0W2Hoxa/rVJQYMRbz2iDeoXT9LErJfGQoa57aWhNLB5odiaCk75jSipAMho3xukUHupx9aKk26wvxgKdOH7Xvak91vTQHLmEoFyJ/AnDT/zfNeYe5mGoGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861086; c=relaxed/simple;
	bh=iaMVhIlaxnDKrjo/B86UwmBA4lUHgRwjSU/hHDluay0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=crK81RnjwMgAraRRgRh5wniljvFj56lU78MFuoStdHHD6vd7Zlq2g5E8/MAYNZZcSJp6Tp5KY3K7RNu3pknhuaNnkxQJh5nHxfwAz/BUn0/ExyYbAN93G3UORff+RkE/KlSkcaZVAq9N3ujdSixjdXICaHA0M6qt1/jKc+rzYSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=CawbRRHb; arc=fail smtp.client-ip=40.107.8.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ji1Hd1E7wP/jzj44BCTftqZcOsH8WP6y/N8ZZ7GnsPRCOcjcdMMrINH0bITyC2hIYLOC1+1rShqJvxjkrouM+pP2C5npwkKowy2Kq/Z/5iFXtpUVf9027/xfSSM5hZ0/T+8BPG1NcN/d7IchdW00xgCqjPToId7LMGlGfn1soDLgUacpCB0gFBIzVQeEw9Vtu63Q9S+2fWWCbM+BcZBtBnbhXFN0OL+/9H15K49nvXd8kuPbXLq2f/+FBUsyzXUOJae6DIncauXamJax3tTNE2my5mQkPGaB/GP9PzFDkLXb70eboNIhktK3uR0DzmVeaw5NWONflAh1OE8YeN8lLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqraZNkbMXJ8bdVBUWBtPeGCWP+ilAu0pVj9SSD+e7E=;
 b=hFUuDJPt+yGEEHl+PoH9Wa4756uyjw1c7OgVSCBT+zj6TOq4jVuDI8+sQyGiQVceIXnQI6VdkWgJeALiMX/0ybz1zIGSUBtliyTyXyN1nB/JY6N2dGaCwqtI7GMXgZyhlJ1r/rnk+RlpKoLjMq49LRDyp+rFbrg/4/0+PurHeVwJSuW9mQg/80AgmN7sJqZczcl4hAFYcEmTJPgpLnvFQZ75fGhrhm79Wn+7IuISJgE03XVy0Kc6Bc57fTrMzN0aM8rKkGPYh3QLl947iYCADQswOAgeIktSwm28oSdzTRKRgeDsMPu7z2So6VChCeUq0ArEvz4zjO+Yca6sBjP+1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqraZNkbMXJ8bdVBUWBtPeGCWP+ilAu0pVj9SSD+e7E=;
 b=CawbRRHb8zRV2pqQcHrEyMSTtP9e3S019OKMnAq7HN/Yy2FC8YfksETnYx7+Ie+2rlu8Q7FvmmZFcbjri4Vvhtkx5CT0gJXT6JsA0rqKAcHRxXa1fIMnzZcT55R95/q3cuP0LLdV3s4K+Dpd9xO/4FAT4pJ6B0P9HOAe7MZhxrk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8837.eurprd04.prod.outlook.com (2603:10a6:10:2e0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.44; Tue, 13 Feb
 2024 21:51:22 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7270.025; Tue, 13 Feb 2024
 21:51:22 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 13 Feb 2024 16:50:24 -0500
Subject: [PATCH v4 3/5] PCI: dwc: Add outbound MSG TLPs support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240213-pme_msg-v4-3-e2acd4d7a292@nxp.com>
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
 devicetree@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Serge Semin <fancer.lancer@gmail.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707861067; l=2940;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Vx141tscxeq3VO/J2v1vu73YFB2QjcNfIuChtPapKMY=;
 b=n4flEqJcvJfIefYWRaPHpfbduAdXCrX2UnSNlEAG8iQ+oUmcnpqZk80SlWHfu39NWRQQBmCCl
 YAuBpb+ymDVBGcnzL/aIKvMT3IkpdmRxukPNy6oDVOfmm/uOikKkwYc
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
X-MS-Office365-Filtering-Correlation-Id: 11940b29-59e8-44b4-ae2a-08dc2cddeb13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xAUCkaaSvfLWKFZkVRkRigtdwT0rvJ/9z4hjwwq0QWwmKagJc2hQw8FqnaokC21rKSJQv8pntq6z6Ek0c50E8WKsRdsO00G76KX+B48kWFrw64q5F0mz3CusfeF0LvVBzsIPT0wgMwJX+7wNyZWgy7e6TBpSktK4xlWxi3pM9XU18XqO83l8JMlvgBzhCIGRrXUSuORvx1nTx5NveqSgRH32GDiEV55c3SvIzeLbpxgf5zHcBrJ/7oRbfW6ZJpnoUilU9HGSMJSLFgtsQiXhLob9TjpWAO+i6Is3siAcZqpM6/FUiCFwGPn91lTClxBuWmLSW668BA8Q8Zu+ZQkBa2Dr+texewXqKECVK5PoEBSvM118QbB1dcqcHszXssOupOL7PGG2R2jKttapYpOGXGwE1I15X42OkirQE1a1ph0xAgMZXHILttFzHxm+xIkZh7wfpU3JAyL2Ot8VClLDqPmTs0+H+TvAF7/IVV0iH11oMbciukbPy31eIVXYZVmsf9P5AVOW54Jt3TGeyRhz+OIoTQ3PTFrEtWMy3CAxaU0FNAPnyOLVdCnclZ5hUE0c7NiqekZbHR+D8q+d4H83VJUs0J8Noo53Hl5cBpjCe+k4m79+9QDP09JrKe7Q37SGbOLxrrAgABORAYNFDHD+Tw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(396003)(136003)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(83380400001)(2616005)(6486002)(478600001)(6512007)(6506007)(52116002)(7416002)(26005)(316002)(54906003)(110136005)(66946007)(66556008)(66476007)(8676002)(4326008)(38350700005)(8936002)(5660300002)(2906002)(36756003)(921011)(86362001)(38100700002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVR4UTdFK0UxYjBYWG9nd21iSGNJYTIvS290cjQ2alcvTVI3SlJqMk5GaXdi?=
 =?utf-8?B?K05RNTZORWhXYkp0V0FaTy9IbnNxWXMyNTlYNlordTRteU5BV1lFVHBKWmR5?=
 =?utf-8?B?a1U4Mm9ka0puRTNPQzNCMFY0aGw1L3NabWlOZFlWeUs4RUl2aktrSFhiTGRP?=
 =?utf-8?B?Ui9TNmlaVFdDQWNnaS9HNi91NU9MeHJ6VFJCN1M4T0E0bHc2Q1ovd3dCWkVI?=
 =?utf-8?B?YlpWNy92RWVUVkVYR0pxQnUzZUlad2FyajNVZEJ6UlNWVUVieSt4S2FUU2FX?=
 =?utf-8?B?dVhUYi95c2JTalJDV0pSMmROcFlKQTFIYU8rR0hjY2NIMEJyNmdvb1BmVXJN?=
 =?utf-8?B?QkwzUmRWUnBud1YwUTNSNjV2aW1EdHh6SkU5MElLU2FwcjdZZ0hlOW1TTGxF?=
 =?utf-8?B?Z3krMGV3dlRUcmlKTFBrcGNzbUFQQWozbUM0SXRIOS9TUDlaek84UGhYMGtS?=
 =?utf-8?B?c2poOWM0cnNSK0NkSUsyREM1VG5VVGFXeWVRMTlCazJ1RmQ4aWNnZEFWSlJH?=
 =?utf-8?B?eHA2VFdVeE9SUTM5aGUrMGdaME1zY1VEU2Vyek1Tc2sxYkxPclVZMmdkRDNu?=
 =?utf-8?B?QVdkM3kzTWIxeUpYdVdTOTZvdDVBTEgvZkdVZ3BTRGRPdE1YcXNiWVJpT2Z5?=
 =?utf-8?B?aDZJclA1RWxvcDNtSE1KeGw4VGE3ME81ZEFFWXBLNHBoaVpWbHZtWVZYQXJx?=
 =?utf-8?B?WENTUTM3c0gvd3J3dmtuUzZOTlRYWmZFbzE2b0Zjd0dRYlpRYy93MzN6ZVF1?=
 =?utf-8?B?aHNRc1BKNWZZdlhsSHlvanUrZllDMWFHU2ZmV29wVTlBaXVoRzNrdXVnVFJm?=
 =?utf-8?B?a0F1WWNlVGNZajdnZy9QSDlMR1cwWXFlMkc2N0xNclp5bXVMVnFyVDUrMms0?=
 =?utf-8?B?MmJUdURlV1JsTk9NQzEyZHk2bTZ6TzgrU2NMRXZ0MSt1K0JMRkxtb0NDWGEz?=
 =?utf-8?B?Q1hUS0dnZUxtdHpmYVNFa0JPZUQzSmZzMDA1SzVMUE9SWC9WTzFUR2FiNXdo?=
 =?utf-8?B?K1k4bk1aaUQzSE9PY2hpUUlnT3lhcTVHbVlKbEMrS0N5K3JMbW9pTGF4alpx?=
 =?utf-8?B?SW5IT1phUyt4dnRWNFlhOFIwNzVhTFd1OG5SWlYxY1phUnFSd2xLbmlta0hM?=
 =?utf-8?B?bUh2M24xTGtOT1pBTWFXZ0JIRXlwT2JJeUVjQm42TWZxeUd6MUZmc2NmUFRH?=
 =?utf-8?B?K2pDcUI4QlRRUXVnN0NOMTV3eGdFRE1XWEI5WC9TdE5KYXNwZEQ2TnUvRE1V?=
 =?utf-8?B?UVgrdnhFQkhudnB0V0N6VG53b21qcnpaSHpPcWNJV0tyaE03b3RTdmlzZkNF?=
 =?utf-8?B?a2QzN1FaNlNNUERZTW5lZjJPWmJINW5TWlk4dWRDOFdSU2pBY1U2OHBFVDlW?=
 =?utf-8?B?M3FWNkduWHFmK3FwNnBPYS83dVg3YVA5RUk0TzJQLzRpSlZmcHZ6Rk11Qkth?=
 =?utf-8?B?SWorYmJ0SGRaUFo3WkN5Zm1Cd3FtZ1FxK0VNLytwTUJBY1ZGSktEMEZ5NXVO?=
 =?utf-8?B?OW9SNXhFQVlzNUtpUE1rVktYLzBRcUtMdEp0eVJnL0VqNFl5RTZPcWxPekhw?=
 =?utf-8?B?L0Y4RCtPMjN5KzdLZ2NlZUxBcTAxVE1SUDZpRnBXekcva3doU3lQcUUwZ29R?=
 =?utf-8?B?Z1BXTS9zcEVvOUZFUVUyNmg0UVpMd2NlaXpJQmkrUFVhREpJTGx6NVJ5WG1Z?=
 =?utf-8?B?ci9mZElZcndsNlQwc2tkM1phaEkycGZVcFhuV1BtcXdwWHNMMlMxVW9JN24w?=
 =?utf-8?B?R3ZFMDhyNDVyTkpiTjNtYmViQTEzSndNcHNpU0ZvN2JUcFFLQkt0SFdpeVhB?=
 =?utf-8?B?M3ZlVHpUclplRkFILzgyMXZuWFFCL1M5eGZPQmlnTkpQYXV3UC9iWkZSNGFq?=
 =?utf-8?B?bjZFOFh0bkx0NFZzdzFRQUhyUDZJbXZFaWZWUVB2TnJVRThNbEJDaFBsbVUz?=
 =?utf-8?B?TDFIRlpZMW15c3FFWVdNbmllZkV6OC9SS0VoWHBMR1RPZ29qeTR0RWhnTlg0?=
 =?utf-8?B?U09wY3NmV2hmTXhKSlp6Ym5meDM1ZmdjZS93TFVqUTVyK3BQVUtaTFBKbmxE?=
 =?utf-8?B?UTVGK2JualgveHVHNEVqMkFGWTdXakQ5UXl6NEMxUHFBTElINnF1V2Z1MDFI?=
 =?utf-8?Q?hi5tT5jZatGVolB2QYjA0S7WQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11940b29-59e8-44b4-ae2a-08dc2cddeb13
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 21:51:22.3824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VjzVrnooN4dygRTKG7sEad0z7jPsfLQrzmWsxNA8nwNGzB1olfFfHYlPKwHlmQ7LmSuHk10hLrDmw4XfSFGPVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8837

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Add "code" and "routing" into struct dw_pcie_ob_atu_cfg for triggering
INTx IRQs by iATU in the PCIe endpoint mode in near the future.
PCIE_ATU_INHIBIT_PAYLOAD is set to issue TLP type of Msg instead of
MsgD. So, this implementation supports the data-less messages only
for now.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 9 +++++++--
 drivers/pci/controller/dwc/pcie-designware.h | 4 ++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index df2575ec5f44c..ba909fade9db1 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -499,7 +499,7 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_TARGET,
 			      upper_32_bits(atu->pci_addr));
 
-	val = atu->type | PCIE_ATU_FUNC_NUM(atu->func_no);
+	val = atu->type | atu->routing | PCIE_ATU_FUNC_NUM(atu->func_no);
 	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr) &&
 	    dw_pcie_ver_is_ge(pci, 460A))
 		val |= PCIE_ATU_INCREASE_REGION_SIZE;
@@ -507,7 +507,12 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 		val = dw_pcie_enable_ecrc(val);
 	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
 
-	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, PCIE_ATU_ENABLE);
+	val = PCIE_ATU_ENABLE;
+	if (atu->type == PCIE_ATU_TYPE_MSG) {
+		/* The data-less messages only for now */
+		val |= PCIE_ATU_INHIBIT_PAYLOAD | atu->code;
+	}
+	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, val);
 
 	/*
 	 * Make sure ATU enable takes effect before any subsequent config
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index d21db82e586d5..703b50bc5e0f1 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -148,11 +148,13 @@
 #define PCIE_ATU_TYPE_IO		0x2
 #define PCIE_ATU_TYPE_CFG0		0x4
 #define PCIE_ATU_TYPE_CFG1		0x5
+#define PCIE_ATU_TYPE_MSG		0x10
 #define PCIE_ATU_TD			BIT(8)
 #define PCIE_ATU_FUNC_NUM(pf)           ((pf) << 20)
 #define PCIE_ATU_REGION_CTRL2		0x004
 #define PCIE_ATU_ENABLE			BIT(31)
 #define PCIE_ATU_BAR_MODE_ENABLE	BIT(30)
+#define PCIE_ATU_INHIBIT_PAYLOAD	BIT(22)
 #define PCIE_ATU_FUNC_NUM_MATCH_EN      BIT(19)
 #define PCIE_ATU_LOWER_BASE		0x008
 #define PCIE_ATU_UPPER_BASE		0x00C
@@ -303,6 +305,8 @@ struct dw_pcie_ob_atu_cfg {
 	int index;
 	int type;
 	u8 func_no;
+	u8 code;
+	u8 routing;
 	u64 cpu_addr;
 	u64 pci_addr;
 	u64 size;

-- 
2.34.1


