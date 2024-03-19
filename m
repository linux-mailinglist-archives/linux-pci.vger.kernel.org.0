Return-Path: <linux-pci+bounces-4903-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B76F88016F
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 17:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 067881F22A75
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 16:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404BD823BF;
	Tue, 19 Mar 2024 16:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VoUymeaQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2078.outbound.protection.outlook.com [40.107.15.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36E081AC7;
	Tue, 19 Mar 2024 16:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864451; cv=fail; b=BL3KR2iGheslqw8doHmx1odOuRYFhxNvA5us5wa3agCUkLtBEah2d9p671KhTq2rbfAzqIp4uQwmWMlxFAmtRLc8yrTYcbUsCu2fVRJgXuUVNey+28mEWUk1PCGT+DjmAv06aLOustKJZ5ixbh6XyD3uLkkMyi0AIeOk7KblAWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864451; c=relaxed/simple;
	bh=hzGYRhAZl9U+Uvuu6aIidx5j0fhBAx2klPXN/eaV8Q8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=YLsgvS9a3V9hhjO/bYq1/1qWJvbBvk+Si5+Hs3A4TmQhLvvwpO30qes4swjdyuSphJCS5o/g1qti6g0xiuuHtQmb9Ro4V0qYTYOZcY1vsytD4AV/UgIeUIQqP90USPN1zOF185mjBYJEvH86nECyhrv5+uWEP/v7/5uF7a4iL0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=VoUymeaQ; arc=fail smtp.client-ip=40.107.15.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMzXAptE6/7MhPC8Tk5B+C0sCKGufXiZabSQp9FGr7HbJnoEIZ5vLT2IeHJwK/rUAHiLlxXsI13xdMPMEeBr6q1oU0abLDJ7QBbiq/vk63kzKui4wEQvBeVUtNmRkH7AIKZ9X1vH9tPqeEGkbHF8V6gP79qiOP0Fg4XW7Z5lKaoIgpOA0DXXa/hCihHVfXys+X5tDd/aTGAGfQs4zMX52XL3/CrCFeEjpXqCyNVCMkrLy7thMKRIFRDukShrjuHIiNB+VOMEysRB2ddZUZrt8Ngw+TFgs9o9JCLvS8OOgRLMU/05ydAiFVrHeLXo+mQl1USpkBo095pv+VftuyBYHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0z4U3sEC3khiRNkm46MPnkPrIySIybGo6ofqvEZ86Bc=;
 b=iYbW7ydT9J3WSGEQMr4/5eSc7DUdV0ZUTewQblylbyxgBvpDONY47RfI8j/u/tQ6r+7kwGxiblrPjmCO7/4vLhQLHO2QiXy+qGkYUQSYqR4gNMxosAAo6UOh95g0B1a2wtAdo5X6GgicAMrwlOXL8Qk3NSGSfu8cutAX5rFLFf4vTgDrgNKd2VkVBv8A5/nKdpVlh3PdwALUx5Zz+X3RbTtXeN4fNl1da9wO8mZHKkXz/ronhT++b8FuNo3HzndRyLScqv5H5Cg9dMwaYPQfvTMtrIwmhTX0McZ5AOSz6CCfe8wqq+0i0IewUfYSKuskX2flRr60EQrH0h7IpmCUew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0z4U3sEC3khiRNkm46MPnkPrIySIybGo6ofqvEZ86Bc=;
 b=VoUymeaQT3zDPoiEplNBomuntoRlyaXoY9lQU05So8hOMZkNvEO61C/HNd3uEkN1U09yz+GW31Dhyy72jgRcB3wTtL+fRm5nVEMaPrsHcWHHUyEzvZPJlQI2+3iAKJxkfQg5h8zHGom9ZCOwck2KxlDhV6srjpMxdECQzeTJCkg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7772.eurprd04.prod.outlook.com (2603:10a6:10:1e3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Tue, 19 Mar
 2024 16:07:27 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 16:07:27 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 19 Mar 2024 12:07:12 -0400
Subject: [PATCH v5 2/5] PCI: dwc: Consolidate args of
 dw_pcie_prog_outbound_atu() into a structure
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-pme_msg-v5-2-af9ffe57f432@nxp.com>
References: <20240319-pme_msg-v5-0-af9ffe57f432@nxp.com>
In-Reply-To: <20240319-pme_msg-v5-0-af9ffe57f432@nxp.com>
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
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710864436; l=12761;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=HU4ER7vz+HwzR2rHdE/BVWAKQXG5UmDhW10DZ8OHeTA=;
 b=EDn4raAqkbBLG5kX0Lfze5u5jRZioRdAWPq+OiTbLIrEIppBWG0AQTSqvcYGldRUGutP32YA0
 5SZzauTLPhOBr6u1foDXJT1VXLVX++KgXHmGJJ+/u+hgF0ajNCvFc9Q
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR07CA0104.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::45) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7772:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f489feb-20c3-479d-d96d-08dc482eac0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ttfvV+rDnZkQXRX7LSMk7FJF3aJEhNB6aEGO755FFSV6WkfDujd+6/56lMidtzjLzMgdzPiMuWE5lG24Jq3CCnVNTnF+Q0sZ7u8M53FLA682zzyGAl/f1mOt0CWDgmD1MBpRoSfMHSYecBMdhAGlpvrPV0RfpRnA+hMNH31abe7pvwz9jQf6UMye78t0Jp6pxQiT7e4q4RbiqEwTU5+r8w2WyEWX+HsJT2WAPG1VDc8olLZgJuKXurimK/ZCXxf8CkIgJM3XJ2uRpbXiaI059DeIQfqYtNB0ToJCcC8yffRc8BCEK3c1fS2ZKKN3yQBnfOPw8HNizOihzsGujZyXin/4fAgDw/OKuhehBTgNPgvjYg15gwW+FhfkmRNng+w+7+FHEzjTJ/vDYAiG/33gz/o29DStUChjNd9NuJ2WlXxlSJZQ5eBi9auA9igHmAKFnShi5Jmdz7hSXhEz0e3vONUi0Tz2JahDdztqOBm8qNZiCQ3vxuKHifagxqmedgf5kqrsGdHnYnJjPxMXq6NO81wL2fFZxJk71uDPodOKGS3DK+nQc62GGnDVU6ROvHy2WuVzLzZcCUDSB8gbdNaiCV60DWmR0O2OHZb8ldYdq4xShQVatXokNEV4RIPb6nf56LOEm5gUiYmJ/KI4vDAgcXZckJbqo2N9xOMXAK//K2CSp/F7mJPTc2dE8NcN2EBcgsnxXUUApF7xxLiu1GQBQl+zdOh2eu16Xm+41Wp57Ck=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(366007)(1800799015)(7416005)(376005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M29DOGJsY25JajFzNTIvK2JXTythWTQ5bXVoNzl2N3pPOFU2Q0d1L3ExcnY3?=
 =?utf-8?B?S3VvZWRHZCt1UW52amNONjJWbm9iNHhGeEJRVFBzTDdWWm9IYWZDMCt3b3ZY?=
 =?utf-8?B?NmNlOFUvSWlXOTN3M2FUcVNCUHFoU1B0enlVRzl4aWxjbkRUVjVtdnRQN0wr?=
 =?utf-8?B?WnB1VTRXVERZdFY4OGx3YmlJVlNkNVVGKzhVWjZ5c0t4RjB1WXRhd3pKeXhX?=
 =?utf-8?B?RGlJYzllU3o2dS9xaWlnUTdRdmhWVi81aEdEWGFlVyt0ai9UcVhPSS9FdVc1?=
 =?utf-8?B?a3BHVFZlS05rSXVWZ04yZjZnV1ZYbEU5bHN1bzhydnd3ZHhvKzNHR1RnNFFi?=
 =?utf-8?B?NUtZQUFoNHJWQnczQWlDcGJaOVpEbGRlVmIzNWsrNFdmeXpFeTZveUVBZ1JY?=
 =?utf-8?B?Y0krODkzZWZ1V3NGMUtQNXpVbHhObU8rempDS3RLZWkraWg5QWVJYTFDNHJO?=
 =?utf-8?B?Q2ZTZkNvdDEzeVNUeTlNS1ZiSDVLalMvUFU1ZmkyRHdma0ZZK294QW5FcWRR?=
 =?utf-8?B?QS9CYlZPbWVLaWFyN3FWT0d0d3lscng3dXczcFBoVmthNUdLZmg4bTBHZDZy?=
 =?utf-8?B?NytrV21rM2tiemZKanBBUXFCYmhxckYrTmgrVk5wcTl4NHpJcE0ySC9kQzNt?=
 =?utf-8?B?UTFLN3RDZ25JeE9GSjlSWUNBZ1J4cmgrQWo0bnVzUXJUeUdtazJyQkw1bWo4?=
 =?utf-8?B?OUFtelQrOWVNelg1czRUeXZqbTd3RVNhR3NIQWtOdGpKeVQvbVI1S1J1bi9s?=
 =?utf-8?B?WkJLTllYejBoWHBzWXdJOVZLSkRHUVJSSkM2ZHVHQk9yNzRDamNWeDRGaFFV?=
 =?utf-8?B?Y2c1WG11RU8wV2toOVppdVNzd3QwZklPTDdheDduZTVEUXFVYkdwYUdWekYw?=
 =?utf-8?B?Z2IyRWQxU3NzM2ZzMUxURU12VmdjQ0s3MUdMSThVZ2tnaHNQa3lRampORy9s?=
 =?utf-8?B?YjFFQVc4cDdrUFNwazhTV1BUNmt5RmtwTld1Q2Z3WmwveUhNaEdOMldOSTBU?=
 =?utf-8?B?UDJlSjJGaHdoQTRGK0xkVnAwZERXRVpTWURYQ1RiWHcycmlZaW9ZdGVZcWlM?=
 =?utf-8?B?M0NYWmRETXBzSExySTl3dGtTOE00ZW0zQlhPY1JpRXJWUGtEVElmLzVnd1cz?=
 =?utf-8?B?WWI5YUErcmxadk4wUVRpc05zVUpVaHVHR2ZlVERHZmJJb2xZeG5nTSt5cVc3?=
 =?utf-8?B?NVlPSE1RRkF0VXR3WXBBaDFVN3hCdWsvTVFmd016QlZMVHQ2MWVPUDVjSlhZ?=
 =?utf-8?B?eGF1a01LZXE3VjRBS0JMbkEzZ3ZabXZUVWpxSVMyUEcyV3R3QXlodUhaejZw?=
 =?utf-8?B?RmdIRThmYmxoKzc3NDVCOXJRbEsxSUpxSUwxQmMzd0NDa3EyT1RmSi9qS2RJ?=
 =?utf-8?B?VGtXa0w0MFZsdE9GVk0yaXEyNUthTlF4WEdKRzIvK3dONU16dzJad24rOEFU?=
 =?utf-8?B?c1UzeHRsbTZuaGxtRTl2ei81R1VoOTR3ekp4aHJZM1hxS0FTY2FnNkZ4M3Y0?=
 =?utf-8?B?NVlycEZPM3RGc3cwV2FUTGxaTmFaamVXUTFJWkU5d0prRnZ5UVhSRDVpWVpD?=
 =?utf-8?B?Wk1lRWd6UjkwR2d3blYxSnYxQm9uaGUrSG5wMnlJSVZkRnhyd3NtbThKaS9B?=
 =?utf-8?B?RGlPYXo2Q1ZyeHJqSm9Jd0hURGRJdW1FMnlpaFhpUUVqc0dRaXJ3RldTNXda?=
 =?utf-8?B?bTh6dUgwK3Y1RE9ldTQzU1krRFNiN0pRV09tT3BONXVLNnYzYVF4SlBDU21z?=
 =?utf-8?B?U1JVQkN5VTllZEg2b3h6dXZGdHRkb2VaMFBXS2ZKYnZlYUZHYmlmSG1jY2VB?=
 =?utf-8?B?OVBOZHB0YzM3bXpGeFlFa2p3VUo5QmhsdW1KZml2VlUreXZFbHBEUUlBQXp0?=
 =?utf-8?B?aGM2MHY5TXEySi90R1YwYXU1UmFTcG9TNHEwbVZnWHBVOHRnaUtEcktvell2?=
 =?utf-8?B?ZTRMbmE5NXc2cEF4U0hDRG84VVZNRjQrN0VaOWF5NVE5eENGcWdUZWxybTRh?=
 =?utf-8?B?SmlBWUFKdUtuWGdxR2s2UHZRNWxOcWJlNVVvYzNoaXdTdlNxbGJyNXRuTnky?=
 =?utf-8?B?NHpnWlJ3NmVZQTlnam85U3VPQjlQQUJuSkF0TTZLSlg0NUp6YWpuZjNwTmhY?=
 =?utf-8?Q?y+2I6hUQpg86hfSqjuxKU91hk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f489feb-20c3-479d-d96d-08dc482eac0a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 16:07:27.2607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LVByM+84sK7SaSApct6Veh4f5zN1FTCBLQp+Y8jiU3Jj7d7O60aUdF6fuOuwAiFs+3QoT2YL5itXkEl6VFaDWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7772

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This is a preparation before adding the Msg-type outbound iATU
mapping. The respective update will require two more arguments added
to __dw_pcie_prog_outbound_atu(). That will make the already
complicated function prototype even more hard to comprehend accepting
_eight_ arguments. In order to prevent that and keep the code
more-or-less readable all the outbound iATU-related arguments are
moved to the new config-structure: struct dw_pcie_ob_atu_cfg pointer
to which shall be passed to dw_pcie_prog_outbound_atu(). The structure
is supposed to be locally defined and populated with the outbound iATU
settings implied by the caller context.

As a result of the denoted change there is no longer need in having
the two distinctive methods for the Host and End-point outbound iATU
setups since the corresponding code can directly call the
dw_pcie_prog_outbound_atu() method with the config-structure
populated. Thus dw_pcie_prog_ep_outbound_atu() is dropped.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c   | 21 +++++----
 drivers/pci/controller/dwc/pcie-designware-host.c | 52 ++++++++++++++++-------
 drivers/pci/controller/dwc/pcie-designware.c      | 49 ++++++++-------------
 drivers/pci/controller/dwc/pcie-designware.h      | 15 +++++--
 4 files changed, 77 insertions(+), 60 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 5befed2dc02b7..27956b2a73be7 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -159,9 +159,8 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
 	return 0;
 }
 
-static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, u8 func_no,
-				   phys_addr_t phys_addr,
-				   u64 pci_addr, size_t size)
+static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep,
+				   struct dw_pcie_ob_atu_cfg *atu)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	u32 free_win;
@@ -173,13 +172,13 @@ static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, u8 func_no,
 		return -EINVAL;
 	}
 
-	ret = dw_pcie_prog_ep_outbound_atu(pci, func_no, free_win, PCIE_ATU_TYPE_MEM,
-					   phys_addr, pci_addr, size);
+	atu->index = free_win;
+	ret = dw_pcie_prog_outbound_atu(pci, atu);
 	if (ret)
 		return ret;
 
 	set_bit(free_win, ep->ob_window_map);
-	ep->outbound_addr[free_win] = phys_addr;
+	ep->outbound_addr[free_win] = atu->cpu_addr;
 
 	return 0;
 }
@@ -279,8 +278,14 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	int ret;
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
-
-	ret = dw_pcie_ep_outbound_atu(ep, func_no, addr, pci_addr, size);
+	struct dw_pcie_ob_atu_cfg atu = { 0 };
+
+	atu.func_no = func_no;
+	atu.type = PCIE_ATU_TYPE_MEM;
+	atu.cpu_addr = addr;
+	atu.pci_addr = pci_addr;
+	atu.size = size;
+	ret = dw_pcie_ep_outbound_atu(ep, &atu);
 	if (ret) {
 		dev_err(pci->dev, "Failed to enable address\n");
 		return ret;
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index d5fc31f8345f7..267687ab33cbc 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -549,6 +549,7 @@ static void __iomem *dw_pcie_other_conf_map_bus(struct pci_bus *bus,
 {
 	struct dw_pcie_rp *pp = bus->sysdata;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct dw_pcie_ob_atu_cfg atu = { 0 };
 	int type, ret;
 	u32 busdev;
 
@@ -571,8 +572,12 @@ static void __iomem *dw_pcie_other_conf_map_bus(struct pci_bus *bus,
 	else
 		type = PCIE_ATU_TYPE_CFG1;
 
-	ret = dw_pcie_prog_outbound_atu(pci, 0, type, pp->cfg0_base, busdev,
-					pp->cfg0_size);
+	atu.type = type;
+	atu.cpu_addr = pp->cfg0_base;
+	atu.pci_addr = busdev;
+	atu.size = pp->cfg0_size;
+
+	ret = dw_pcie_prog_outbound_atu(pci, &atu);
 	if (ret)
 		return NULL;
 
@@ -584,6 +589,7 @@ static int dw_pcie_rd_other_conf(struct pci_bus *bus, unsigned int devfn,
 {
 	struct dw_pcie_rp *pp = bus->sysdata;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct dw_pcie_ob_atu_cfg atu = { 0 };
 	int ret;
 
 	ret = pci_generic_config_read(bus, devfn, where, size, val);
@@ -591,9 +597,12 @@ static int dw_pcie_rd_other_conf(struct pci_bus *bus, unsigned int devfn,
 		return ret;
 
 	if (pp->cfg0_io_shared) {
-		ret = dw_pcie_prog_outbound_atu(pci, 0, PCIE_ATU_TYPE_IO,
-						pp->io_base, pp->io_bus_addr,
-						pp->io_size);
+		atu.type = PCIE_ATU_TYPE_IO;
+		atu.cpu_addr = pp->io_base;
+		atu.pci_addr = pp->io_bus_addr;
+		atu.size = pp->io_size;
+
+		ret = dw_pcie_prog_outbound_atu(pci, &atu);
 		if (ret)
 			return PCIBIOS_SET_FAILED;
 	}
@@ -606,6 +615,7 @@ static int dw_pcie_wr_other_conf(struct pci_bus *bus, unsigned int devfn,
 {
 	struct dw_pcie_rp *pp = bus->sysdata;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct dw_pcie_ob_atu_cfg atu = { 0 };
 	int ret;
 
 	ret = pci_generic_config_write(bus, devfn, where, size, val);
@@ -613,9 +623,12 @@ static int dw_pcie_wr_other_conf(struct pci_bus *bus, unsigned int devfn,
 		return ret;
 
 	if (pp->cfg0_io_shared) {
-		ret = dw_pcie_prog_outbound_atu(pci, 0, PCIE_ATU_TYPE_IO,
-						pp->io_base, pp->io_bus_addr,
-						pp->io_size);
+		atu.type = PCIE_ATU_TYPE_IO;
+		atu.cpu_addr = pp->io_base;
+		atu.pci_addr = pp->io_bus_addr;
+		atu.size = pp->io_size;
+
+		ret = dw_pcie_prog_outbound_atu(pci, &atu);
 		if (ret)
 			return PCIBIOS_SET_FAILED;
 	}
@@ -650,6 +663,7 @@ static struct pci_ops dw_pcie_ops = {
 static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct dw_pcie_ob_atu_cfg atu = { 0 };
 	struct resource_entry *entry;
 	int i, ret;
 
@@ -677,10 +691,13 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 		if (pci->num_ob_windows <= ++i)
 			break;
 
-		ret = dw_pcie_prog_outbound_atu(pci, i, PCIE_ATU_TYPE_MEM,
-						entry->res->start,
-						entry->res->start - entry->offset,
-						resource_size(entry->res));
+		atu.index = i;
+		atu.type = PCIE_ATU_TYPE_MEM;
+		atu.cpu_addr = entry->res->start;
+		atu.pci_addr = entry->res->start - entry->offset;
+		atu.size = resource_size(entry->res);
+
+		ret = dw_pcie_prog_outbound_atu(pci, &atu);
 		if (ret) {
 			dev_err(pci->dev, "Failed to set MEM range %pr\n",
 				entry->res);
@@ -690,10 +707,13 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 
 	if (pp->io_size) {
 		if (pci->num_ob_windows > ++i) {
-			ret = dw_pcie_prog_outbound_atu(pci, i, PCIE_ATU_TYPE_IO,
-							pp->io_base,
-							pp->io_bus_addr,
-							pp->io_size);
+			atu.index = i;
+			atu.type = PCIE_ATU_TYPE_IO;
+			atu.cpu_addr = pp->io_base;
+			atu.pci_addr = pp->io_bus_addr;
+			atu.size = pp->io_size;
+
+			ret = dw_pcie_prog_outbound_atu(pci, &atu);
 			if (ret) {
 				dev_err(pci->dev, "Failed to set IO range %pr\n",
 					entry->res);
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 250cf7f40b858..df2575ec5f44c 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -465,56 +465,56 @@ static inline u32 dw_pcie_enable_ecrc(u32 val)
 	return val | PCIE_ATU_TD;
 }
 
-static int __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
-				       int index, int type, u64 cpu_addr,
-				       u64 pci_addr, u64 size)
+int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
+			      const struct dw_pcie_ob_atu_cfg *atu)
 {
+	u64 cpu_addr = atu->cpu_addr;
 	u32 retries, val;
 	u64 limit_addr;
 
 	if (pci->ops && pci->ops->cpu_addr_fixup)
 		cpu_addr = pci->ops->cpu_addr_fixup(pci, cpu_addr);
 
-	limit_addr = cpu_addr + size - 1;
+	limit_addr = cpu_addr + atu->size - 1;
 
 	if ((limit_addr & ~pci->region_limit) != (cpu_addr & ~pci->region_limit) ||
 	    !IS_ALIGNED(cpu_addr, pci->region_align) ||
-	    !IS_ALIGNED(pci_addr, pci->region_align) || !size) {
+	    !IS_ALIGNED(atu->pci_addr, pci->region_align) || !atu->size) {
 		return -EINVAL;
 	}
 
-	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LOWER_BASE,
+	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LOWER_BASE,
 			      lower_32_bits(cpu_addr));
-	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_BASE,
+	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_BASE,
 			      upper_32_bits(cpu_addr));
 
-	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LIMIT,
+	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LIMIT,
 			      lower_32_bits(limit_addr));
 	if (dw_pcie_ver_is_ge(pci, 460A))
-		dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_LIMIT,
+		dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_LIMIT,
 				      upper_32_bits(limit_addr));
 
-	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LOWER_TARGET,
-			      lower_32_bits(pci_addr));
-	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_TARGET,
-			      upper_32_bits(pci_addr));
+	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LOWER_TARGET,
+			      lower_32_bits(atu->pci_addr));
+	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_TARGET,
+			      upper_32_bits(atu->pci_addr));
 
-	val = type | PCIE_ATU_FUNC_NUM(func_no);
+	val = atu->type | PCIE_ATU_FUNC_NUM(atu->func_no);
 	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr) &&
 	    dw_pcie_ver_is_ge(pci, 460A))
 		val |= PCIE_ATU_INCREASE_REGION_SIZE;
 	if (dw_pcie_ver_is(pci, 490A))
 		val = dw_pcie_enable_ecrc(val);
-	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_REGION_CTRL1, val);
+	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
 
-	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_REGION_CTRL2, PCIE_ATU_ENABLE);
+	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, PCIE_ATU_ENABLE);
 
 	/*
 	 * Make sure ATU enable takes effect before any subsequent config
 	 * and I/O accesses.
 	 */
 	for (retries = 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries++) {
-		val = dw_pcie_readl_atu_ob(pci, index, PCIE_ATU_REGION_CTRL2);
+		val = dw_pcie_readl_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2);
 		if (val & PCIE_ATU_ENABLE)
 			return 0;
 
@@ -526,21 +526,6 @@ static int __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
 	return -ETIMEDOUT;
 }
 
-int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
-			      u64 cpu_addr, u64 pci_addr, u64 size)
-{
-	return __dw_pcie_prog_outbound_atu(pci, 0, index, type,
-					   cpu_addr, pci_addr, size);
-}
-
-int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
-				 int type, u64 cpu_addr, u64 pci_addr,
-				 u64 size)
-{
-	return __dw_pcie_prog_outbound_atu(pci, func_no, index, type,
-					   cpu_addr, pci_addr, size);
-}
-
 static inline u32 dw_pcie_readl_atu_ib(struct dw_pcie *pci, u32 index, u32 reg)
 {
 	return dw_pcie_readl_atu(pci, PCIE_ATU_REGION_DIR_IB, index, reg);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 26dae48374627..d21db82e586d5 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -299,6 +299,15 @@ enum dw_pcie_ltssm {
 	DW_PCIE_LTSSM_UNKNOWN = 0xFFFFFFFF,
 };
 
+struct dw_pcie_ob_atu_cfg {
+	int index;
+	int type;
+	u8 func_no;
+	u64 cpu_addr;
+	u64 pci_addr;
+	u64 size;
+};
+
 struct dw_pcie_host_ops {
 	int (*init)(struct dw_pcie_rp *pp);
 	void (*deinit)(struct dw_pcie_rp *pp);
@@ -434,10 +443,8 @@ void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
 int dw_pcie_link_up(struct dw_pcie *pci);
 void dw_pcie_upconfig_setup(struct dw_pcie *pci);
 int dw_pcie_wait_for_link(struct dw_pcie *pci);
-int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
-			      u64 cpu_addr, u64 pci_addr, u64 size);
-int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
-				 int type, u64 cpu_addr, u64 pci_addr, u64 size);
+int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
+			      const struct dw_pcie_ob_atu_cfg *atu);
 int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
 			     u64 cpu_addr, u64 pci_addr, u64 size);
 int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,

-- 
2.34.1


