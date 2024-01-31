Return-Path: <linux-pci+bounces-2848-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EC1843233
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 01:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35A40B22809
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 00:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A47641;
	Wed, 31 Jan 2024 00:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="I1Qn22H5"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1403BEBF;
	Wed, 31 Jan 2024 00:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706661969; cv=fail; b=SNjGdlNUe/h39P/9EB2vPSPtq9aEjMyz0Aq/MuRgC78l9Abjp9/tCsJD/GKEgHwFbaJUCJ9PapH4WW4nwhq6oUnLJOrU5An6rceerbPD0hJ1EkIs8x6fVHfH1HYuhaM8IYdbeQ2KbFm9SsI68IMQqycjZAR3tOk8HEEXdTaEbyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706661969; c=relaxed/simple;
	bh=CSc9b/7O8Q2ywCcaQSNOAl8wC5iOA4e7Fn1jMqRoyvQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=r/E/Go1RRTthWAU3ihdeoazbEhJPlaAVMayByN/RCTjzWYrtOFrfoW31KsCU5iMV8Do9u/1cDQBcvsrB3YKMCEy4WvQM7qQWTdSikdsE+HrlAevuBoP1UbuP5CSipONk1wDrPS1EL+DdAGOeWBNrby/9VrTWMosmoiVmHBjcu04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=I1Qn22H5; arc=fail smtp.client-ip=40.107.20.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDcTt2E88hUp3NrU6tCM/q2Y4vjZ8tMl3PSC24T6mxC4Kn0p4lPNs23FRnZISgESYfobutVjR95zKNZQRG1xi9yMGtQVACtjcdOYcbyL9ruONhnLvs3FRPiNx/De6n4OtXWiwhTpt259gtaDf129EZcgfqVWy2OxIikt0nBo7AYG6gNI83SN31r+fnhJHtoGhdNZ8uGHvVKNDm+ktclcK1/UVDZhjQ8YJJfHSVq5fH38FuxyLA9eYA5zWjzl2bUq9U4IEve99j/HxzYuIa6O5Moz1cfZq8kJ4F7766ZlLoqFx5fpwkEFtBd+ZTSaZYycTeiI0xPk62rDdy9ma38cZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUvBZb1q4P51HNUpNUrXht5CZNZYfFhNGx2cTy486Ms=;
 b=H7K/dHIwZ5Bt4giZGNqEOnBM2UyKYwCir5WoHOzWgLDnHhtLxwrvA7b4WEyrbHD3NBozesalmsii7+MD5shiEoj6IEzSOUMRXVEnNGP+nRzmJwz8nFmf/pktgz+um2iYvkvx2O/Rjy7MrhotQQPtWqTOZ1pbTJI2s3Gy6Q3tsqhoCSwqo6wug5w5mlpyJTFvwvROp+pt4OzG0lnCabBdJo1X64otNtoOXCYtq8Ip2977pIJLcYG9/Ve8yadDwH59Em2D8Twbl2Oc8Ki0bs17wCFKsxdN0udne/m7YKDRzMqRGwAnUxCORxkkwladYR6BCwIc/9IwbBPmmTWsMGC9+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUvBZb1q4P51HNUpNUrXht5CZNZYfFhNGx2cTy486Ms=;
 b=I1Qn22H5rdAUE+H0QL0Ut2i+qjQhfK+doxT4TPVYLP6uosJQZeMJg4jAjKZtTZQXqsE9Zji+xJeC3SB31xVR8yDMEg3vPq7ZTv4Em0srhGmRKDIwEhgcR3GsFfT/cn16XCSfxFm/zACu47WLs+6/Gddgbn6vZPnm/MhcVY2hKBU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB6877.eurprd04.prod.outlook.com (2603:10a6:803:131::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 00:46:05 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 00:46:05 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 30 Jan 2024 19:45:28 -0500
Subject: [PATCH 3/6] PCI: dwc: Add outbound MSG TLPs support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-pme_msg-v1-3-d52b0add5c7c@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706661950; l=2896;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=HsYYWicc5fOwAhzWsSAplVHxy6sgutdY8ja1Er1MKyk=;
 b=6M71McR98puiDwzSllTMoQVYo2KcrPwBY1JxhAbcnFPfPp7U5VwE8mr3YOr9iyUO9xPSRK+ic
 puKZ23iM6e+DLZaEVWuuA6EEhVtOyKSudc0ZfhQLRSlV4mOvlfdrcXX
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
X-MS-Office365-Filtering-Correlation-Id: 32d440c3-e25a-4898-aeda-08dc21f601b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pMAEPAG8F6P2P1hNFXFEVMA3XOq2LClNx84h2mJsqtXFQq8uGARFmmyVkkxi3zKsvI5RROdaKZkX6J5zL9oyL9jzdo0RodqPmF0rlfky3tDgqJFbAF1UEoKtyfvmHmcrDBsflvJRFfX4FIN/6u1rdJpoysAzGegDyPY2JzRIsD78XsLRRcmnHb9zj1OMnNQCmgyBwxZxS0GWb1JZQKTwl9JYKW7yY8lSrTKYsWg+CoE/dW4bnyRl1uB7g8oiiI/FXp0yz4v9d9zA3bw4iTIOpqTS5f9pTFy9F4NcvBxobrj8r02TNB9Dd17xxDYf/Sg48b3a2EZaaIoVzX9jWCMmMu3daeOn1yl9RB2UUnaC/OLBAqJQP68NTpyhCfAI25ECG2Bv6CGtjpmZKKdNpcE3/m2ZQ5yXVh+KiIO368HBhOYPcIMxqphjG2J2qgCDv8U1wT8TafsLLzYNbX/3/TnKf1MnkSxbIFbJbVxuJxRMTFLA23JXTMpKik+s5jeLWfwtTNC2KhqWvlrUBxLAsJwMUQJN4c79oedpP/Z6ZFOpbiasrQBfKgiNa6PtFXGxK8oaEcv9E/PJaAHT/z2Cjh3UW+vHd8ULs7nNU3rI152C9YbdqeNYGYT2PAW9OKG0yoOWqHaYnuRFGCIHWi7iWpE5rA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(376002)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(41300700001)(921011)(26005)(36756003)(316002)(66476007)(38350700005)(6512007)(52116002)(478600001)(83380400001)(2616005)(6666004)(6486002)(6506007)(38100700002)(86362001)(5660300002)(7416002)(2906002)(66556008)(54906003)(66946007)(8676002)(8936002)(4326008)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OW8yYUFxTlg2S2hwSlFhVWZZOUR5SUxQWTZyUFY1aWlRQUxwbUlqUndlc3g4?=
 =?utf-8?B?V2tmUHlvM0RZdFdwcHg0cEh3a1p4Wnh5bWtIaS90WU1wMkJLT0VTRk1FWlJs?=
 =?utf-8?B?dDhuaHVxYWpEY3kyRVN1S0ZsQ3RGTnBqVkhObjdnY09aV1JadnlWQW9UUEh5?=
 =?utf-8?B?S2VabDlRczVSZXU2WkR1VEhKUDZXdTh6K0RQWkZRK3RXMlZFSktVdUhOVVF6?=
 =?utf-8?B?SXpaeWFsK3VYcENrZ3dyR2I4cG5FaHl1TGJVc1dDMVlUM3lkS2ZsdkdMQkh0?=
 =?utf-8?B?M2tPUjhEYVNrV1hKaWZDOW9MQmVObk41Vk9NNXRnaFVnc3RuR1A2SXNkSjVr?=
 =?utf-8?B?ZHltZWw2NVVic3hXSVlsM280VzQvK2FweFdXcWpoWlFYTEY3OW5CZkdCdi9Y?=
 =?utf-8?B?S0lLYndTTDVuVm1CeElFcE1qM2wzMWh4ank2TEZUNUxCSUlYSFR6YSt6ZUY3?=
 =?utf-8?B?WVgyV0pMUnRLd1pTeXFudTRoRzZITnMvVWpvd3dlRngyeEF0VHlZd0ZaS0JE?=
 =?utf-8?B?NS9ybVFGSDRQekI1UG13UGhuRG9IbUx3QlRPWjJwN1NaZzNTUmY0V2VXbWhM?=
 =?utf-8?B?ck9OUDhNQktoYVBzdmw1cjlFakFVOVBrL09xdXlCbjJaWUdoSGZpUll4SG9y?=
 =?utf-8?B?NmZLQmNVQ3VkMmR2dzZSRFROTmpXS3V5aHdhcWRpUlhQVTU0UThRdzEvUWFm?=
 =?utf-8?B?MUZkRWRVdjA4V1VtYVN4V1FGaE52TkhiUEhtZm9OVkFMMnlNOVdhOGtaUEZ4?=
 =?utf-8?B?WUgzTUcrcGpDQ1ZuTlpPdUZXSllVWWh0czRscjhmRDVwVkkwajlqeElCd2do?=
 =?utf-8?B?dURXS1djcVJBK2UwWGNMR3EyL1Njek9zWkZhSzljdWVrT3pWVFNDUlhBNWdw?=
 =?utf-8?B?bElQSk5LU1J4d0VoeUVJTjg0bjlNVUtSQmdaZENid1kyTFBpSnBZL2dVRFRk?=
 =?utf-8?B?Y3k0MUZwQWdkckFzQ3hSaWlOc2d5SWpBSmVXZ0g2Um83blRlMTJ4Yk51TmNV?=
 =?utf-8?B?amhtWEc4ODErdThiMkxGdExBNDdpRDMrc3BLaHdwenpDVi9EaWZGN1FSTUVl?=
 =?utf-8?B?RTVhaHdtbUdBL0pVeGx3UGJ5eGZVUmsraTdCNmxaNjJuengwcm96R09aeFBy?=
 =?utf-8?B?MG5pMm1wbk9abnRaV29KLzdxSURqWjZ6RDl1WGlybXp6NFJXeldjcnR4MHZQ?=
 =?utf-8?B?aWtHS0pwY3ZCRXhqMzlGNGhDTEltS3JtM1Q0T2k4NVpjdEpzdWxXWGRBMXhG?=
 =?utf-8?B?MWk1a3BNQU1oY1podGd0UEJsS0RUa1BUWVVSZW83ZEVhYzZlbE9KR21qM0ky?=
 =?utf-8?B?ZGhsbkpObXV2UG1vM3dEY3ZmR2QyVVBIWFNWQ0FwZXZGMWhYTk1nYjBMNmU3?=
 =?utf-8?B?clU5STdXazZ0Y2NJYVpSZlBwdDcyKzlneHl4Um5LZ1BKcXRBczRsOTBXMHhs?=
 =?utf-8?B?VWtKY1FDQ1lnenZsU2JURTFMdER6UmYyejJ6Nkg3OUkvWnJNaFNHWW5KaW1C?=
 =?utf-8?B?M2VOWjlkdFdWR1U5YTF1R3ZGVC9KQ1BoSklkbi9ZN2VqZ05BL2JYMUpIYjF5?=
 =?utf-8?B?czYrT1RvR0NFSG9IV2QrWGRFUmNFT0w2VklTT3FFMU1reUlNZTE4RjNxZlFT?=
 =?utf-8?B?SW5JckUzSlpBYlcyNGtjbm5DaW1xajV2RWh6RE94b2NPQlkxMnk0K2M1ZzFu?=
 =?utf-8?B?NUdxNWE2bFIwRWRuL0crUUM5TGxURGQ5cDAvd3RwVW1TYm5kVjRHOVBZZHFC?=
 =?utf-8?B?bVRlbGhSWWRTSktGSEZZQmNDS3B1dU5lNFBSR1E0eHpSYjJiTTZEZWJHNTZY?=
 =?utf-8?B?WStOM0F3dXJ1TlZrUjNmKzlnTnRTR2N6b29qc25UTVhuNXIzZjdMWEFPMlNC?=
 =?utf-8?B?anJZNEhiaXFSbDNlYTRXVDMzNVQ4Y3E5K2w1MHp3cDdpd1dqZzZIYncySVZL?=
 =?utf-8?B?MS9CeXl6VktIWm5xUmp3c3VpbHU5YXRUay9lN2x5RThuWTUzbEhFWWRjQlFR?=
 =?utf-8?B?aWtaTWNaVkttZUJhSHdyNXBhYjMxV1o4cTFvdldUbXpQdXNFSng1VnR5YkFp?=
 =?utf-8?B?UkIrQjZrait4NHQzb0lGbENXR3d0YVU4VU9YRW5QWVFrNGgwK1Jxa0JQNE84?=
 =?utf-8?Q?LpQLoCeYFgGCntgwbrTNZcwSP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d440c3-e25a-4898-aeda-08dc21f601b7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 00:46:05.5321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cCLUSoEvzbp5jd2rR+XZc90H4gwloETCb7YpocwdyKSpYwtnzNLP+oMxAN32oSrRHq2dCiNOWmrgDaI87VvgTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6877

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Add "code" and "routing" into struct dw_pcie_ob_atu_cfg for triggering
INTx IRQs by iATU in the PCIe endpoint mode in near the future.
PCIE_ATU_INHIBIT_PAYLOAD is set to issue TLP type of Msg instead of
MsgD. So, this implementation supports the data-less messages only
for now.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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


