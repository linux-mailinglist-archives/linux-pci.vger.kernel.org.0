Return-Path: <linux-pci+bounces-3415-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB9A853D9C
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 22:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CA60286780
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 21:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A1B62160;
	Tue, 13 Feb 2024 21:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="tBO9ffhA"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2084.outbound.protection.outlook.com [40.107.8.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5836217E;
	Tue, 13 Feb 2024 21:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861084; cv=fail; b=Nc+r/IAWykF3pBTLH2ggF8EpLwk+fPc1QJ623CHO//Ft19geMp3M1OUih0pIiQNgJW+Fq2pEBxcshxRylFBwCWglprNjQzquJJZBvKk4K6HSl/67VsWB+0JprZYblHV7dl/H33zsu1rm1JcHLI4Jba70hHMZYYA4vhv+6G/o2go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861084; c=relaxed/simple;
	bh=hzGYRhAZl9U+Uvuu6aIidx5j0fhBAx2klPXN/eaV8Q8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=KG1MtAxmz4R64j7w3lKFmBRwcUCGPOTaqg8DMSfAbplkyLqnmwbfueIW/GSjDQ5Asvw3KEj+5rGpwWHB9z2BajWTHSRgQ+4ANsd1deA+5pV3bmjYXL9w4kLYcXRBjwNsRwcPMOdOwwpPTAUYAvFPKbrblhgyOFGUUomAXEhcJj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=tBO9ffhA; arc=fail smtp.client-ip=40.107.8.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLFQzVqWIX7YzUAxx0QVHmldb6JtNrE08Ansb/1fZTAKjJdyDcmEvPcbPmn7mnZ+63shz2qZTzd4orMoaP5N12XkJJSdmgh8zOZRC6RktBPJIHMq0kuwA8xAKSl/05EYen1LrQwF8dhzrWLRgzCFqMvBwMRqZ+wmEko/Ju/dIkFveyk5qAe/1FVft96mZTUT9zLrFjaGEobj2XNyP+xKUZRbK7yNySY2pAm80JSZWdm4oFrJKj6wV5cQKD47mK0tGH2Pj/JhOHJmDw/IPfihzo1cKky9C2wRMYdRfHn7u7dUMAbdr+1G/ILwwERB0eN4uDi+WCL/FS7vPy973aBXYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0z4U3sEC3khiRNkm46MPnkPrIySIybGo6ofqvEZ86Bc=;
 b=W1RfWi/Qc1n8lp04x2c5PXqzBl6yr7BG8g2WTNwbsvEkUxNJO4QFP4iVa2LmQLQLQ43+ILp1Qbx5SOm0dlrayB3boFe+IK9GcO9LD9tSOtPTwcl0rAiNNLjWKTdRzMadiLBzeL60EW8XtJ+Cy2hrViThMBVL5feaqmslX3nkumXihy/pxtvbJFuYpjS6ZHoa18hANnTgeICwLyQWGf7D4MZ522ScyClaxKNXAq+yEq7piBNTjHsmfT1P1gjpHzQ1QHdQPiBMxzklQx2kxrefDY6/06l+FxPvPcVNvbo0Lss6/jS8vqbPFUJC6FFtcYEQYwf37nAt63IXjTd0nsAUbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0z4U3sEC3khiRNkm46MPnkPrIySIybGo6ofqvEZ86Bc=;
 b=tBO9ffhAYGUX8SA5b6IVt3bXBeZUt517vzuGxuRkvh4CFaBY6VG3O0H3sVKYob+9Fa4b4RNVo6krGLR+wztEdY5MXFMtxc9p9YHDqSOb96AF4+yF3bR2ROZxm8UmfePm+4dj5Vl3nFMgwHXf21PysthiKQzsaFuS3tj85qJak2k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8837.eurprd04.prod.outlook.com (2603:10a6:10:2e0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.44; Tue, 13 Feb
 2024 21:51:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7270.025; Tue, 13 Feb 2024
 21:51:18 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 13 Feb 2024 16:50:23 -0500
Subject: [PATCH v4 2/5] PCI: dwc: Consolidate args of
 dw_pcie_prog_outbound_atu() into a structure
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240213-pme_msg-v4-2-e2acd4d7a292@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707861067; l=12761;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=HU4ER7vz+HwzR2rHdE/BVWAKQXG5UmDhW10DZ8OHeTA=;
 b=oc+RI153Gd2qc4TGAFCYpI/jwXmFceGa70boCb3gGymEKW24MtGkEbsEAkDZHuQtslQ6hryTg
 aD05FtWAW+1BosJhmVqeRKvqKtAlMJvlpPuXEfFKLJZ0fL/WDDikR59
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
X-MS-Office365-Filtering-Correlation-Id: 791f9713-b07b-4ae5-eb6d-08dc2cdde8cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CVBKBW2I2Fd1veSSIT5JPDzSM3utnPXZU8L/FBSuAB7ARHUgXr1C3yQx7OCc2kKRoDn+f/x4OKrhH9/TLbWnp/1aBXJez8jaPUvk7scX9j9K+7FY0bt8HlPDIuad/5bd8raMGOCHKuHsmYsWdVGC1kCBxka//j/SavmaAYnNBm1xtUtpNezjyGxOHshbn8hYOvl1/AU2MxznKZn8YPOqnrdnG3AJdnfeZkAjmtvjhWPz2kGqHWza4BL6IAuIHlXU/CK2ydK1mPvLi5DxTCoE5wZMM3ImEvEgwqM7MVy4OBMiwtGi7Vkg2eZnqtasjFPqFWXTI656TDNou/JzkQbX9OeabpaRCzG5QUukTP3A7uY0H3JoWQSDacls9Ek+LNR/RDwjCwAQjH8eUmSpmvK77vb5TB6GFcqULGnrL7vZd8TDf2dn48CyHpAVa7LA73uAleHBIzF4u+3BHfACfFWq9bnxG2URcxfrQIVSsB1DL3avzCDffb9Wm0ayFCR7c/LdKpCZkU9KlUX1UzZl82/KeUWiVE4i4+Uv3UpVx+qnpo6D69o7fZqNylJkf5Fi/OsWLwHh0BvKC8jOyjuGFJQqetJp787i8XHxNZqmYKFqU43iuq9ExcFZUtQucCANpHQ5WmaM+W+kGkBGmboqzJvHig==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(396003)(136003)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(83380400001)(2616005)(6486002)(478600001)(6512007)(6506007)(52116002)(30864003)(7416002)(26005)(316002)(54906003)(110136005)(66946007)(6666004)(66556008)(66476007)(8676002)(4326008)(38350700005)(8936002)(5660300002)(2906002)(36756003)(921011)(86362001)(38100700002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmRUSWMvc2twTGdWV21JY2pUQngzWGsrVkhGRktjbkZsMmxoLy9lZzYybVRp?=
 =?utf-8?B?bzhEUjBweWUrUXJYNFhZZFJ3dGlPbU5RMFZqbG1Zd0ovWVNOemlrc1orcTNl?=
 =?utf-8?B?aHNBNi9kOUtMYlRMcUwzOWtxalhwRFI0SThleWlPbUdXRUM2cU9VMEJhNi9u?=
 =?utf-8?B?ekU4MlY3ZjJIYkszZlRNVWEvaEJQaW1LeDJVQTVTL2ZQcEtEcWJwWWdwYmts?=
 =?utf-8?B?dFY4SThucGpOREw0dVRKaGdhUzFFSXhmeXdmSlpmQ2R6RjNyTUVEa1NGVzdx?=
 =?utf-8?B?cnlsbUszV01kWHBWb3FhejJuNnlpMTZFL3M5R1h5UGRMUFc3amI4WlFKaHZt?=
 =?utf-8?B?N0trOExHcUFDUmVWYmw0ZlBNNmNieGM3WDUxWmpDMVdXdzJxZlIvS0lCTUxv?=
 =?utf-8?B?dTF4MnBZOTlIVHZ4R3QrZUYxSENOeU1rK2xqMVRCeWI2QjNWQld2N1dhSXhw?=
 =?utf-8?B?amV0ellxT2RyQ3BnUWVqSkdCQjlhYUNjZzArQU5sYkJmWUNrU3AwUnNhOUpE?=
 =?utf-8?B?WjB4VjFDY090d0g5ek44cVpDZzA3ZDN0dVRjT1hLT0JvUFlLNVJsRGdTMTh4?=
 =?utf-8?B?bjlHVEtCZ0pFazJmNkswNG1RVndZV3BRMm1PUlR6dDhKZERhdWFSdU02Z1Bm?=
 =?utf-8?B?VUROVzgvMmpodXF0YVF5ejBMdDlzS3FGRE9NWkhiR1Y4Z2NOVkdwRSszUGJj?=
 =?utf-8?B?RWYwTEcvMXdraDFucU50azZ2SHNJTHlYbEp6akVHN2xuaVdVeTU4eDdRTUh1?=
 =?utf-8?B?d3JpVFUwdS9hdlpWZUU5TVI1cW1mT0xhdHBGbFlmR1VFb2MyTG12R0dTdWZL?=
 =?utf-8?B?MnY2ZkNiaTY0RzVSWUdUaGcvaW9Sd1VMUGZqcytBRHZWaVBwejk0QUFINWxo?=
 =?utf-8?B?dmxlRUJpWk0rdC9ONHF2VWNMK0FqNlIyVWZReHdWOUlRa2c0SEZwOGt0NDd0?=
 =?utf-8?B?NU5CYzlhbHJwUzNSZWlGY2hhNkxHZW1kWkp4YkFCd0thSXMzSHhJS2wrbm9U?=
 =?utf-8?B?cFNQdXJRc3NjM045RUFQOFZKdlhKVUJ5QWovci9wTGlXOU1XRmVOUnpIV0pv?=
 =?utf-8?B?S3R0Ym1kRDAvdk9Zb2llSDhtbFkxak5qYlM1MVRXa05lVFRJRkRvOWlRSldB?=
 =?utf-8?B?RE11RzNuaHhjeHpBR283MXlOUlVXSjlld01NU1BWN3Ezb3dnY010R1E5NTlI?=
 =?utf-8?B?NkpGUGxMb0JWMVovZGYvWGxpV2ZrSHpvdWU3bjZEMFJqL0p2VmVTSnNYNHZ1?=
 =?utf-8?B?MHAzYVdsd0swMUx4S01zbzlHdzhVWjh1Lys3VHJFLzNyalBFS2kzeGtXZDYy?=
 =?utf-8?B?cWlmS0ZWdHVEVktRYmVjSDZ0SjR5dzNwamtac0t3MmRuR0JrVHJoMVMzWElp?=
 =?utf-8?B?Y1kvbU43cm9QRStVd1lPaDFYNGhRRE9lY1RCVkZqSlpwR2wxbDZTNFdwRUov?=
 =?utf-8?B?RTY0QTJJZSsySTFZcDJKYUJYNWdqZjVVUTc2Mll4aWxlOVpuMjhyS25ybWxK?=
 =?utf-8?B?SkZBUlFyM29zQmtCWTZUSEFpZGYxSURreEdwdjlkcjlMeFRSbXI0d0VLM3dD?=
 =?utf-8?B?NUlHd0VnVjcxUU8rbGZodDB1T0lLNEhkRmN0cGJwQjI0SmRjUHpBS1FGZlFZ?=
 =?utf-8?B?b3J5dlFXdThuMHFOcVdaMithVmFEbHNWUUF0b1FrckZvVmZVcFNDY0FJVnZr?=
 =?utf-8?B?cXVXaHhSdkxDd3hoV0QrR1FIeGNDb1c5eHF3YlB0TWJxL0h3Sno2dk5PWTJp?=
 =?utf-8?B?cEhvUUN0T1phZk5GY1ZiNm1QOG1kNVQ4cENKT0poWnNXV1dWUVhlNWN3OUtv?=
 =?utf-8?B?dk5CbEN5M3ZpaEU5Qlg5ZjJGZlBBUm1VcC81Kzd3dTZxZDh3dk5pTmt6NWNp?=
 =?utf-8?B?TU81Um5MR3Q3azA2dExRZVFVc1hzKzk4MGo5TWppSCtUbUNUajFWa3RlUGlY?=
 =?utf-8?B?Z1BCejl3Z2FOSzdNT2kwak9IV0VvdWJobkQ1K3ErWGhWd1dYWTdhdmd5ZElS?=
 =?utf-8?B?R1JhdEJxd3FGMXBEUTJtUzR6bzRGamdMUjMzamJnRXNoUU9XcDJWa2c3V3VP?=
 =?utf-8?B?c1h1WnB4N1lYTmpDWkdzUjZSV2pPYVQ4NE0rZHNsVjg0cE1kaUpQZHB5Rnkz?=
 =?utf-8?Q?TJkwE5OxXHwMmRCsCu5RLzsqX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 791f9713-b07b-4ae5-eb6d-08dc2cdde8cd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 21:51:18.5894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kwxe1jZtSFfXNHWRBwSblMnfYLyJHMW8eRtfpJyKqpnF4x4lSYewAlNtkuq4YEzZI0tyFzCusfWFIBqK/Dc1+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8837

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


