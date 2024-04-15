Return-Path: <linux-pci+bounces-6289-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5618C8A5AA9
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 21:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D41EE283DB4
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 19:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DF3156981;
	Mon, 15 Apr 2024 19:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JaqcmocJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2070.outbound.protection.outlook.com [40.107.21.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6B9156991;
	Mon, 15 Apr 2024 19:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713209645; cv=fail; b=XgLdo5Ns0E0w4qE0fl+8ob8iha2v4EJ/YYJjH9G9Ge6lUVKpQDsv6r7wsPXp36dZlq+vUT6U6dmI3Ql5VR6jSvqVfSJcLK8nVsJS8faLM6lthp6/AaoXFEuVPkXlx4p+7m/FjvlhHSTnnqwocKNlW0T83JCh4F77XfI99H/Bf7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713209645; c=relaxed/simple;
	bh=Z1R7qi1P8tpG+wqfBqFnd3RzZIQbkAXoWFjXpkLP86U=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=r+Ico0jRozJcxAzuW7Pf0roO8MVXnUjCz7fIevp+Hl1C9HYuGN0pNX5kQCgYnXCyximImggCeDoYiLTvTGL+7FgdQ+rzp6mtAEOKmOjdRnczq60XIf0XJU2RMDCkIJ9HU+CFIY/dWeRxLtmIY6i/BY3DSyHKhn7aezS4b6EykiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=JaqcmocJ; arc=fail smtp.client-ip=40.107.21.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RA23cmABrytDi/qec6vsTrOcZCRBB+nS2PpGZ3oPzSoPciSpB0j+BSzaEacML2uguN7eC2hRL7x/b+oCfW7CQvFHh6rNXlEss3TeZRamjayRLglsnNUweY9QRiQUtRQCRrfFdQdmVS9V8gvrYzoquiKtTDCabeMjDVmMpgg1MqscAulxBDYrPglr5rdHZ1KoYjEQBe0SzgsWFd3VKjrUPODXoFfa6Uw+DyXMLFjCnw2uHVWL1eW9pFB2+n608dzWdK74+bCMX+zeRIeJkv3UEjy9eyHhCu1cMWVgQAMfFbnaI2GTB94lqIQITk4UtN1QYRKzUJ+t+GcApCqYd+Egmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HpPzzDR2t0W4uJFD/pHJufCGdd3ZJ8oAc5V/JrUqpWM=;
 b=nAGCG7OuSagh3LqH2fv/dhHoVEfgiXypMink/2fhTGmy7XxLADhBgNDvCkvwEaDiSgreNrHzkDDS4tP9R54CTYUvYDbEG+X3TFKoDfGM+FyaiuQkjQ/HJBLA0x7VlDcMnnaG1mAhr7nk/pQbbqtzZbNfDC6Q1Q6La+bE0FH/p2gdh+/NjYbE2IXZjoCuBRyyH3EvMqOTXUU8qo4dq2Gxx91qE5VyVI69SP8+UlJp3KgC2GCEcq/Z9gZ3HIuhRr7ufJhj1qZwV/fvdv0pAKJLOpSMdAyG7ABA2dQb09zexUt/Gq4GMdUo7W9qAKvjXil4gLB44FYuhEtcXcwerS1AWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpPzzDR2t0W4uJFD/pHJufCGdd3ZJ8oAc5V/JrUqpWM=;
 b=JaqcmocJlmfOj4+nOcKB16CB2Wn8VTzoET2STQ+Zc16XAO2NJfzf7cuaH2VWoCx/msfByDSlNALFNEFqqZtRae0zlCwR8siuRgqdDmB04lOzJ9YICA99VM8ARkVfKDKUoZoXOnPI3N5H7KVrQCvcQ8qV9SYSGzSxqYGxtBxq8DE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA2PR04MB10279.eurprd04.prod.outlook.com (2603:10a6:102:406::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.43; Mon, 15 Apr
 2024 19:34:00 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 19:34:00 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 15 Apr 2024 15:33:26 -0400
Subject: [PATCH v6 2/5] PCI: dwc: Consolidate args of
 dw_pcie_prog_outbound_atu() into a structure
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240415-pme_msg-v6-2-56dad968ad3a@nxp.com>
References: <20240415-pme_msg-v6-0-56dad968ad3a@nxp.com>
In-Reply-To: <20240415-pme_msg-v6-0-56dad968ad3a@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713209628; l=12761;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Ub0sCY9OqWzN3Pm6SPBEwtB2z80F4sah7lj6v7E5fbk=;
 b=IMucpbwS2yB9CafnZVfYbCrnG7B01VejAoMGA0RXTSKbLreTtmHlf2x0At7S+8NQx5JXhxg3F
 HbSpsyUCyThBnT+1DJlOXQLVypJGH7LwNU8mtP/GnCfexDokKTk4Mzd
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0102.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA2PR04MB10279:EE_
X-MS-Office365-Filtering-Correlation-Id: 19686bfe-f121-435c-d7cd-08dc5d83001c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dz5eYh2v9qoesCsu7TFPOm2yjObp2MXFbVUZdG7BbSZtVU42SPw90PZedCUcsf5XXorRnzZpW7IUQBfIzG4I5j7FEI5oNmnbT9nMmO15DBgRGWt24y9k3OBtdj/Wwp0mF41af7C0wHTd5OVT67HN/GXgMf5tWZ/b6x2uHEAfwbCAXU9/m5XryeSq2WYgN00kcCB8SBv4bC39B4rg5wmOj0SQohPDPVVowOydLkWoN31fLrSsrmsFQ3IiAA+ZIm2A4HvKzw7U7qIVUPSxTeUohct39Cm5NsS3DFbm50zyvJrAHtkSWWvwduw2j6HV6lJVmKO1hY1TY7I2gDu3DE1yeTW0j/8FHOaBD1wvKfnZ+SyKWc61DCAwpxREU4IZ6WHpUrMDuKQeOOUVcVaAay+PNWhW6jaJM/T1IcA2Yoag38u1nXY/itVbXZFkTrOkN8EhC+tK7AsdNez39Qf8HwMAiHfjhVZ7Y7pbuSL5EGs6WIKHmS4iAMi49TsznNQ6hCRHsypxAgpqFht17RJYt+r7amw25QF1QTzjItN5ebcIMOiu0ZW8lk1kW3TyJQlt6vmBZWg4lOSbH/xZEdG5DDcappS3kNzWkMjsCJUwIKwBOQf7ILa2tay1GTcujFveAPjqkOOerX3QjfTnq2yziusf5J4FbiXvfK/0orGfWTwHN5TIAsbWuLj6nzxjhHiSRS/ABiERBFJTeAVBfdmioZj3LM4bOdubMslMEjaFc1H8sKs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005)(52116005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGVPLzFxUHZrTHVDbHFTWHk1ajR5VmVOalMveURvaFRZdy8xYzhYSFhDZVFE?=
 =?utf-8?B?bjZiWVFWOGV0RVZMWGVya2t6blhGbi9pd2RqdlQ5L3NiTExtamZCQjZlK0pY?=
 =?utf-8?B?bEdWVWJCbitDMUh6bld6Z0w0OWtMeURYalJKOEtnMVhoazArNURLY0hGRGVk?=
 =?utf-8?B?R1gyRFNoSGxJSDBKME9jdU5nUHpFcXlsaU1VY3lSOEdHZnVxaDd5ak9tTU8v?=
 =?utf-8?B?YUJDVUZCS2hHRko5eW5pSmxRUDNRU0hRWGFTUUk3cytKMVU3Qzc1YWdvWWRM?=
 =?utf-8?B?MmkrdU5jVTl5VzVPV2VWOFZicUllZ2tRUm9yeVBBY01tRjVabGMxTW9DWjli?=
 =?utf-8?B?bDUvVGZseDRJdm5KOTAvak42cUVOell0a00zbDF2ZE9OV0l4bGZweWwwZXpR?=
 =?utf-8?B?aFpnQXlibFM3NVp5V3duc3JQNDFYT1V2OVpzTDlwanlkOHNtL3RJb2ZHVmJl?=
 =?utf-8?B?QTR3d3BBbFRZN3JBd0hlN3o4Z05HZXJjL2JCMGMrdnhYdDV6WWxpRXYxNENM?=
 =?utf-8?B?TngxVWJ4anZucnNmMnpkbWhFbTJ6U01VRzZPS0dyemxYZzFMWEd6bExtQUUx?=
 =?utf-8?B?NTJmTGZ6cGV0K09XOTk1ckhjZ1FyTEFKeW9TM3VmQWVpSG1rN2hvM1NYM0pJ?=
 =?utf-8?B?cHFPc3NtWFhZUnVQaEVnV0ZhbmRlcDRGcXY0VDJYYUVBbkIramJVUnAxOHJU?=
 =?utf-8?B?bzFUUGxtK2VwaEoxUTFKRk8vWC8yNGdUbUxrOTExcjh5YklXMTVOeWxpT3R5?=
 =?utf-8?B?bjZCRDhNZm83eFhGMUZuRjlBTkpQK3VNWk9JRkdiRFlPNHFsUUN6WmtYcDll?=
 =?utf-8?B?R0RhYVBhRjl5Y1QxN1hXVmN3OGhsNTRXUkJ0UTBPaWJpQ0tnakx4dklGUEV5?=
 =?utf-8?B?SUNJaUlKU09IQkJZNWRtUVRGazVHZFpOMFRsMGNnbVdid2R5a2x5c1RQWDE1?=
 =?utf-8?B?MzdvalhKaWdYVGlxV0lLdFAxUmN5TUZuTVh5dmcyUjRwWWZxUmNkbzl0MW13?=
 =?utf-8?B?bktobkdGUHZTQ09DdFJpU2NoMXptS3c0OFh2cHpaU2RVYnp2NERiRTZwbnNw?=
 =?utf-8?B?VjNJQjJqSGZ4N1h5WU1hc1VLeWRLN1kzUlZOeHFiSzM2MFlNYU1uVFc3Z2d4?=
 =?utf-8?B?WFlSZnlUSk9nY1FOVXBoM0lmRGZMbkxDR2ZjN1ZNZ2Y1ZWtvSytRdVhEU1pv?=
 =?utf-8?B?UE00aGx3MVFlMytLYnlqV2tGelZySGVkYzNzNVFXaWh5SUR3RURCVEY0VzZn?=
 =?utf-8?B?THFQYnc0cnBGa1B1TXpVcUJ3K2VrcFJ3MGpNYVEyZzlnTXJBSnVCSHdNVm5o?=
 =?utf-8?B?T1Qyc3QvKzlLbDZYU2NwaHRmMlQvYlpqUlJPSGpEemRiLytpY096ODVkQUhx?=
 =?utf-8?B?U0JUWHg3NHdJK21hWW9tTGtERlhMUThwV0ZnaWR3Zmg4ZWxpODZqazI5M2Zh?=
 =?utf-8?B?alordTdDTVN3bk1sM08zK2MraFNIdkhEblZXaE52dnZieTNQM3ZrQ1ZBUERS?=
 =?utf-8?B?OTNhOHk0OTdCWng3M2NZT3JZdjlOQStXVlZiNFpXRGFpeGJtRi95Ynd1K0xo?=
 =?utf-8?B?RGNsemdNS2QraUE1UXV2SngzR2RDbzFzaWtFWENIbml6cW1DQ2htdyt5M1U0?=
 =?utf-8?B?anNvKzlNeFVWRURIYVp6enIwN1BXZ1dLSnd4NGpEWnBGQTlsVDFVaUUyTWVJ?=
 =?utf-8?B?ekZORUMwZFFSL05XNm9xdVJWT3FFeElTdEcrd1dqT0IxMkloaGRWa0hFdzl3?=
 =?utf-8?B?dVMzdDN6OGo4MERYNTN5RkwwTVpkSmVvbDhWQmx5b3VialVMR2Nzd0FZa016?=
 =?utf-8?B?ZnRJOFRrZ1ZieUxXQWRtS3JEckxJT0xxd2FWUTZBVDRWNWJXbit6bVdyVXY2?=
 =?utf-8?B?VDQrUlFUdTFwQUQ5L2lhclFuazlyTDBtWU9FOFl4Q29jNFNxM1B2Ty93bE45?=
 =?utf-8?B?V1cvZ0wvNVhBY2pUdzB0TUFOZnVLUEZheXZpMisxWTdDQkdYV0paamVIa0I5?=
 =?utf-8?B?Kyt3S2prUDRDSUNEei8zdEppK0J6QkZrU2RsQzY1YkZZbTczemQ2UlI5YkZG?=
 =?utf-8?B?WEszV1NtUktpQ3VaUzBHTk5PUlI3MENzcnNQaTEybWIwQnVucUJOZVNXdFph?=
 =?utf-8?Q?75qs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19686bfe-f121-435c-d7cd-08dc5d83001c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 19:34:00.4844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jgSqw2FCQbEiTQnh2SMBYE7Vqq3F1tsyxpKrN5OfkBRcOMKB/0JD75a4fV14MGy3mnOO6NxAjhMd6wioshtFxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10279

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
index 746a11dcb67f1..9dd6a2edc7ae5 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -160,9 +160,8 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
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
@@ -174,13 +173,13 @@ static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, u8 func_no,
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
@@ -280,8 +279,14 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
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
index d15a5c2d5b480..3a9cb4be22ab2 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -554,6 +554,7 @@ static void __iomem *dw_pcie_other_conf_map_bus(struct pci_bus *bus,
 {
 	struct dw_pcie_rp *pp = bus->sysdata;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct dw_pcie_ob_atu_cfg atu = { 0 };
 	int type, ret;
 	u32 busdev;
 
@@ -576,8 +577,12 @@ static void __iomem *dw_pcie_other_conf_map_bus(struct pci_bus *bus,
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
 
@@ -589,6 +594,7 @@ static int dw_pcie_rd_other_conf(struct pci_bus *bus, unsigned int devfn,
 {
 	struct dw_pcie_rp *pp = bus->sysdata;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct dw_pcie_ob_atu_cfg atu = { 0 };
 	int ret;
 
 	ret = pci_generic_config_read(bus, devfn, where, size, val);
@@ -596,9 +602,12 @@ static int dw_pcie_rd_other_conf(struct pci_bus *bus, unsigned int devfn,
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
@@ -611,6 +620,7 @@ static int dw_pcie_wr_other_conf(struct pci_bus *bus, unsigned int devfn,
 {
 	struct dw_pcie_rp *pp = bus->sysdata;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct dw_pcie_ob_atu_cfg atu = { 0 };
 	int ret;
 
 	ret = pci_generic_config_write(bus, devfn, where, size, val);
@@ -618,9 +628,12 @@ static int dw_pcie_wr_other_conf(struct pci_bus *bus, unsigned int devfn,
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
@@ -655,6 +668,7 @@ static struct pci_ops dw_pcie_ops = {
 static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct dw_pcie_ob_atu_cfg atu = { 0 };
 	struct resource_entry *entry;
 	int i, ret;
 
@@ -682,10 +696,13 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
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
@@ -695,10 +712,13 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 
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


