Return-Path: <linux-pci+bounces-2847-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63148843230
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 01:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF75D1F21181
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 00:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAF5367;
	Wed, 31 Jan 2024 00:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kMgZykTm"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5F94A33;
	Wed, 31 Jan 2024 00:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706661966; cv=fail; b=aVPF9Um6X4LxdJW8+iSED9/u+vIzWPyvh+ER75BrNhG0WzUg0OuRx1RPXERpH8QmAARNJpB0tbGrzBZHcP/uMqcPdd0MNS/SdsJ7pX0qhPLuVtwcxzTX6blILSeSHXqBaXpFA1c13lw0XDOCd4vp+dYcvhB+zOrBJUFuIexC0Pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706661966; c=relaxed/simple;
	bh=hzGYRhAZl9U+Uvuu6aIidx5j0fhBAx2klPXN/eaV8Q8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=JlkNjlRWgLmqao/cK3BxyEgztpCce7gMjekmr2cZN9mjZFbLYQOrV35kTGCwkJH2zJxl8fr0UtKKbZerb/ZBGnHVNe4oiqyGUUYZngror9TF+mcockVjj3euXKTazdY8jTozUs1hAHXbBzJ+b4eTD80K6hJTnkur4mmHw1m/PLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=kMgZykTm; arc=fail smtp.client-ip=40.107.20.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FeXB2E73uUZfoBlnbSmiDKF3tBUG3+ttadmx97mp+wcb3AeoWJta47OFImf0MMXVEqBLJVQJNfL5Od4UUgSp/6Sf57YwZCffruwYY9xqQ21NVix2pXqb6xa8ZShgI2orqcKmikSbYI4gmTRjPWnfitn88Y/cEQIGre1GvwXJTHUibqW88DmenJOI3E67Cdt0TBNGy6IBGWETt0KE1FNAO9TekgRdJ1Gqme0mAXijPeRGCCwcIICGncIkaN7lYRle8TdD1HbvZVXBEaF4L6xg9XM5ARh08p44Hy0mgEEB/WcUdlKAKB3q1l7QRU6M3a68GlDrK9EFdBmeZbmWT1/FYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0z4U3sEC3khiRNkm46MPnkPrIySIybGo6ofqvEZ86Bc=;
 b=KeBlZR0FEuI9kaV2z4RrLUV0KhtIhiOKszIL3Lf48Kz8mf0Zh2AD6PSdibBkW4r8z4jIILLaXrDHLF2tcoNaY2taaAH8qrsHkByDkxEBDnE9rMPtdiGriEPF7edjN/ZB7r1J//v0yHyNMYCJ9O0cMdCBndrD28VNaBfftBPasjfpEfMrbvML52s4PhpoeqJYUTe4FOKfmw9CwQ68bXz3qUdFXGsdYeNMv1qSO0BL5uVpp1L9oOKQx54qLINKEStX9u9+ZNIkzj+JETv3Tsa6OiOumyUFZwGn7QLDIDtxXcjk8hb649L7joWdV+4WwaGEv9zLPlliDVcR9ZRdlh260g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0z4U3sEC3khiRNkm46MPnkPrIySIybGo6ofqvEZ86Bc=;
 b=kMgZykTmZZB1s6ycWGgYccfBI+zzf0jl46gHRAsrfYFowrGdqS94ML5SwHf9vN5kJrMqcMTOP8AJn7kz76tIkClQoLaBCv2blRglIRM1dSNMiBFzcfUilEqIUk9RubX4WbgE03rpmUnnNJrj6aoYI+H0f5DnHaqjDLHs1oXqXZI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB6877.eurprd04.prod.outlook.com (2603:10a6:803:131::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 00:46:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 00:46:01 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 30 Jan 2024 19:45:27 -0500
Subject: [PATCH 2/6] PCI: dwc: Change arguments of
 dw_pcie_prog_outbound_atu()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-pme_msg-v1-2-d52b0add5c7c@nxp.com>
References: <20240130-pme_msg-v1-0-d52b0add5c7c@nxp.com>
In-Reply-To: <20240130-pme_msg-v1-0-d52b0add5c7c@nxp.com>
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
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706661950; l=12761;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=HU4ER7vz+HwzR2rHdE/BVWAKQXG5UmDhW10DZ8OHeTA=;
 b=9CXDVpgObhAZ8p/yaymBx5lNUAbW1i85G12lw7ObrzpFIVj9JgKgHuAjYWs2aidhcK2A6S/Wn
 AolpvJjqQ5pCXUgpiK5k0Hk1KTqt2cmf7WWn0458/gbeXxPAOje+rA6
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0225.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB6877:EE_
X-MS-Office365-Filtering-Correlation-Id: d3154114-670b-43b2-1616-08dc21f5ff43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZCtCCnYf/ON1MLpmUhH8uCaRAvsLZZA28uJo1g+3Q+GfbttHhTNavNpIP3LpqGfAQIRCLJSvNkqX+DGoaYqOHp4UVNco/GKjGoXCW9mGz8CGtEniXqE6ThpSJFaj4kKh+HKwtletCqGgAWofRyYH5fuCOEqpOCrvhqKVmtXXf2HsXkFvuOWB2+tDVTrYFCSaR+y9XvimwhKTEx5rx8tfMC2bPKQvCRThjaAc25kmRHKn8Zb0X+yVCbYLP/dhwkafN943fLEYYMNgPausHZZi7DA1NTBeUcd8hZOoSW4WRMSL8y3j0tt3Vwuuu6NEhRfrECElDvdxim0eWcSSDF4/b8h101Fw2dyh0dTH8q8OPuvOZJ2qsn0K3/3KOifr9lNYBsW1XLLoh5pc/YL9VNnWw0u/upLhWNlbZT6b7muyIqwm/fvdjmvsDT70V5s0X76VTRPf3BYSM7zTiw6GJONWT/14dP4S8TDU0eU7xjQgBb/enqtec7CoMb1j569SLjh/dsogheiqGbj7z88+adV59/672TSQBqIpOJQjNg7c6mdBG5GzGfhGqn4gRsjGzp4tL/CMCOmhSnn/EU/LBBblpF/MbyEY74JwvrfQBQIhETW+vqAOpFNTkf7s/bgFZKJ0RF68ofZYSSP4umhYWZisuQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(376002)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(41300700001)(921011)(26005)(36756003)(316002)(66476007)(38350700005)(6512007)(52116002)(478600001)(83380400001)(2616005)(6666004)(6486002)(6506007)(38100700002)(86362001)(5660300002)(30864003)(7416002)(2906002)(66556008)(54906003)(66946007)(8676002)(8936002)(4326008)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0d0T1RsbEFBaUtESU5tVVpOM1ljdkE4SkM4clVKMDI0a3ZuTlVZWkY4cmtz?=
 =?utf-8?B?d3dRWENMUXNHN1d0NWpjcHI1djFRRUtEdEZBNCtuWm5aNk5jcDEwUUR1NC9Q?=
 =?utf-8?B?bnVra1dTWThxbHRnaU9FdVN5c2EyN2tQaTA3a0s2TlZMTC8rMEU0SFlQOVhQ?=
 =?utf-8?B?clBLc09IemgwQ1FKQm5vWmVxVW4zNDcxTzVwa1RteFdUT2VOWXk4M1k2ZDQ4?=
 =?utf-8?B?RjlDZUlUZHVlUGR1RFJtazduSnVzeFErTlA0TmdZT2FicjkxSTlXWEVpdk9t?=
 =?utf-8?B?Z3BtWko0VzY5WFhnNHZpcjZBZVZhUVhRYlJ4M21HU1ZyYUljcTBnM2FQVUdC?=
 =?utf-8?B?K0NGaUdrcFJ0WGpWdjRkNk5oNW5kZW5hZ3JYVUNjVkN2NkJZMy9BVXptMjFW?=
 =?utf-8?B?UW9EbndJV0dJNGEwRnIwVDI5MzIrVVlyZEwxcWtDb0wwb3dOM2x5SVF0WStT?=
 =?utf-8?B?cU12NktMaUJLTDJBU0ZWMzZGMk9NYTJaMEpoU0szTk5oUERueHJtaG9CRmFR?=
 =?utf-8?B?SkUrOFFKNWJNa1B2emFSdllWZkJFY2NReUxYMlpjY0piUE1qTlVjckY5Tm9B?=
 =?utf-8?B?U2M5c0hjdWdzUXU1SG03ZkR0NG14MzZXcFl2Y2VjcldUVUtqRmh0R3RYcWJt?=
 =?utf-8?B?Z3RPUmFJQ0RSV0ZJdHBYMldGV0NjbitQbWlqUmNvRVA2dVVyWEtka2tHdHF3?=
 =?utf-8?B?K0ZPR3pOeTVQUW9SM1RqOTl5QkszZzdtYXk5WWxwM0crQ2s2OFZJVUd2Q3By?=
 =?utf-8?B?QjZUZzZ1VUJBNjZ6Tm1EZ3NxMXRjZ3ZheGNtTlZXQTYvMGxJOFlYL0hWRHJq?=
 =?utf-8?B?Y3d1NWlxSDh4UGpCeXVIK0hFanFRRGJZUnBNcTRDL0JFa0RaaHpuN2VnMWs2?=
 =?utf-8?B?a09MbWtVOGQwUkMveVpuWC9XVnhWdlpRbE1RZTBiSHhBZ3AwbW9VQ0VmejR2?=
 =?utf-8?B?cjBiVXlUbU12eWF2RkwxMWNFcmRDeHVYZEZ0dEV2UEJpUHcrblBXcGJqNFE2?=
 =?utf-8?B?SGo1bDFXdTlMRGxMWnhjeVBHWWZTMTZjRWhFTzl2VVpVMWZ4cklpYlFheDhV?=
 =?utf-8?B?MDk3b1l0VUxUak5tVFhabE9PYklLdEgzNklDQUxkT1dUQTVmdHFwNS9xUHRx?=
 =?utf-8?B?alFWR1FaN3R5K1RVanAxR0JtUnFBc1JYS0NSZStWV2xMVmwrc2Y3aDVHNHFj?=
 =?utf-8?B?TGNTVXJKNzNoSUJUZ3kzV0F3bWhMdGdmM3lwSGJOZXRsdUVhYmVoaVhRVXM2?=
 =?utf-8?B?dUlmTStsU0FRQ1RFdWhlRndxSGlDcHJxSGJPUXdDUEl5R1VUWktkRzZ2Qk1I?=
 =?utf-8?B?N09JVUtLclIvT3pMQTUrMGtuemhDZEVVMGNPbHpGTDF2REwwOVVWM2lsVlJp?=
 =?utf-8?B?akE4WTk4Vlo3Uk5zUE12VHZuVTRzbU9ZSk9hZ1NaaWJwYU4rWmxiNTQvMmpr?=
 =?utf-8?B?NDRKRGt5TkVlSHU5MVRWbGJzNktvZ3JpTVBNSVZ6K3IvNjBWR1BCRjdlUDFH?=
 =?utf-8?B?MEFvemJhLzRDcTAwYjlPWWZRMzdVUHd5N1dONXlGenRiMXg1Zm42ZGF0ck5W?=
 =?utf-8?B?Wnl2UjFkYTJhRVlQelAxSk5vQlp5akxJRTV0cmlXNGNVdWhHMFNCOWpFby9Z?=
 =?utf-8?B?VlQyWk0rbXd6bjFzbWZBZ1AxTmJGYllkQ0NPK2xrTUYwUmxHMVcyNVBJaVpO?=
 =?utf-8?B?b2RrTE42Q0pEL3VjNUtVTnBXZW9XOHFIekhGckVHY0JLdFZRWTFBQlRCdUl4?=
 =?utf-8?B?OW4yc1FVTENNek5MWlYwWXFDWjlvZTRDeFg1enlPa0Y0L0FaaHkwR296aE9z?=
 =?utf-8?B?NkozWHpLQU5ZSW1TZzVBVitPY1BJTC84RlhyRzZJU0wzcHZRVUxJcWw3T1ky?=
 =?utf-8?B?ckQ4OUdIRXV5QUI0QkNpRmp5UDZLcXNCVDFweU9OZWxxTFB1a2JwRGdNWHpp?=
 =?utf-8?B?Q3pQejlMV2dWcFVXTXZwZVFzeFBpWDdCVzVSRmVVUUg5VWtNWFg2TllTVVQr?=
 =?utf-8?B?WlBiSnFoUHZMV0ZhRjlXbjB2dVNJVW9ZWXd4Mjcvbmw0M0M3T2x6Q1U1Z0pq?=
 =?utf-8?B?RXhjOEVETHFCQkNRYy9iRjRQR0RZaGtTMDgwWlVvY2dvWDB5S3NBODlhZ01I?=
 =?utf-8?Q?sDgDXnx5P/+Ij20uXgroYzqOZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3154114-670b-43b2-1616-08dc21f5ff43
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 00:46:01.4193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vr5MELiB+cTN0i9D/BCKFQuEJhHbVtE09uyaU1M9xqMPc/ApxBgPJyFaS+LtQcSxnzii9fur2sszc9P3DC3aHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6877

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


