Return-Path: <linux-pci+bounces-16846-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D399CDB0A
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 10:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95BD2B21E34
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 09:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D8018A959;
	Fri, 15 Nov 2024 09:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="g8lEOdtm"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013006.outbound.protection.outlook.com [40.107.162.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE50189BA2;
	Fri, 15 Nov 2024 09:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731661474; cv=fail; b=pKKDLwE/RRpdma+IMj5iDwG9H6FRngaHOuXOkdlHjzu5YTW0fkv2WoBQajKlxGmFL2ilz9kkDTG3TbYEt7ML2VCOxLhamcU2rbLqyuQkOry7FP/zdHkHuqzbo095wOE0uR0Rkzu6ibnrVypkcTXkmEsZnJl+HuBuQAqoOIDJVvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731661474; c=relaxed/simple;
	bh=aanrKSchLy9r4daDMaV8caaEuWVhDSXxScqVrh9IVIE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PShoFI6ayMAds6UDer0vewzAdULlB0gUO1uoU1OMbQSbUZZ89d0iCAM8Vrhdl9vAnw2lcIWvYHRUx9EIOP1n/PlU5DOMBOBqrczE02R4wP5Ep88unZyE1gZ2F5tik/Bzj5OyVYhbDGGxVa8rvv89nJpoy9pu/IT+i/BhYJgPTYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=g8lEOdtm; arc=fail smtp.client-ip=40.107.162.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xkn7tQf3ShWdxO9WPR+B6IELgZ927CvalkEV2iIKoWESAHwPJ5YLhFPntDzjEcwqCIMoCMoQPbi5hSWdwK/+sG3pIufp7aMLnT3cxSeDMijs1M+u5e1GR+LM8yWNiHBo+XHEMokPPU9+J4k8QBjGxgvzXLpixkvSiBRzMrGr8hikMPH1UtukvDqIxWzQVOLk2OG2ygwq6QYv5+tBIgAgSSCvL/AGYvcjSvlosW2EtvJu5+1iSb3ZvjR2xGRxA4cjHYUHo0GceSm/dzb2cCCT7XzunFKttJS0QpypKgtC8iQbWHNjhZ5Pek6AhvDbBhRs2dBM+HPl47RBvlonqOsCdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PD1cE70lCluhvrIdvwx8JoYXDch2k5OeUyq3IWdhax4=;
 b=Bs+V9U0hurMiuwETu/3Gm/dVaPsepSh8SdVr94q3abn396tMRy9mUuZzuWtc37FOFWlzCXemOW2VrtXaXjDgeY1+HYNgNOZOlD3DiaVlamr+fYucy7QiW2SHNtX63J8sTlS9GtphqlW3HylFpa6fnFBknELuimZEh0rdqXZ1Z5IIaQoNm3NrT10odR2DJCreWqy28pDbCHbohL1/a7RGPv60hSqFay24C27tQNWH5LRSJDONij66VQQe3g9qpOfhW87vArmsz5NMfrlddfaz1Mo/PguKmaw69WCzRi4WGMLfk70q+4LgO6KlBZinwS5YGYwYjbrMdJX+eGQlJZcchQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PD1cE70lCluhvrIdvwx8JoYXDch2k5OeUyq3IWdhax4=;
 b=g8lEOdtmgoQYLW6IYW+bMReEcPnhNTqC3ql4ifDuUtNoqQjWqlxmDmZVehOAjobZLbJLrcTrMoPiw+jatT2HAAOg6jlc8AgSejpjmolrTslgu6TyHGmURLEmSdCoqpYsAW2rOivXf+olqtdevNF8zlCpi6Y74M3eBQVBb2GRB1+fnMm9Ekq5d2sEGr+nYKBPK/H+D7gqQE7McXgzZgG8qHIuFr2D9NHeMGUPGJdIPvglneXmZstzzZ9/FWNkiTkzU91qDrREHTdkk9kQWbFqbAR/AO8l5og+a1ibNcvY9g8VzPSUqxROZXS1a17dF8veLySvMG0hXcvYXSdvuspS1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by VI2PR04MB10980.eurprd04.prod.outlook.com (2603:10a6:800:274::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Fri, 15 Nov
 2024 09:04:29 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%7]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 09:04:28 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: jingoohan1@gmail.com,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	frank.li@nxp.com
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v2] PCI: dwc: Clean up some unnecessary codes in dw_pcie_suspend_noirq()
Date: Fri, 15 Nov 2024 17:03:21 +0800
Message-Id: <20241115090321.527694-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0191.apcprd04.prod.outlook.com
 (2603:1096:4:14::29) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|VI2PR04MB10980:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e80a3b8-66e1-476d-41b2-08dd055482c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FUgybIGg2xFuuJTEsxjCg4CtNuZ5PaX5S8/heqTbEEc4gpC2xSFYjEOQVdVy?=
 =?us-ascii?Q?6yGRxbNzYWO7lypkg2dVljA1UEg8j1hUZvJ091ld1O+2k464A8kGckvXmCdb?=
 =?us-ascii?Q?BR9pSqex5xzPovpIvi2CShLV8RVkk0qFQOMF6ePO+aoljaMT4Xbzxk88g8na?=
 =?us-ascii?Q?zIOTqrIjXRJGEmcQk3hpMBvepHZsjVVbjw5W4ODHKeDJkitCPj+PF5Z5k+yf?=
 =?us-ascii?Q?YVOXEJCteW18oag0VWEFOmFFkG7lWERVoUFvZ4hQcdTS8k8MucUAtrhfTFVh?=
 =?us-ascii?Q?dQ0wm4eUub6V2jIz7UvSWpxaln5eol6PgDrKySxSy1ltEOLCv19rQUpDnjCI?=
 =?us-ascii?Q?KCSeSBYV99HvRvuFU0glacWq1z1HZZKzYadaMNfGdkFKLtpF8MEWkt+2zJYj?=
 =?us-ascii?Q?dpcELFlSGpGOZTRmt4CZxJ1hquFcaQ0ZjODeztaGqcQq4i0vX4jfpLbU2OM6?=
 =?us-ascii?Q?mVfTY1sgatmnZQahL4cQ8aU2hJRETYbwWwLMFqk5nlaMv0vGxH/7t0FANtR5?=
 =?us-ascii?Q?Jz8ZdowMcM2VF5i80otYuU7GTCX9wbylxnfgX7YyjclOcllkkrrX+GLzAQQ1?=
 =?us-ascii?Q?fnPMUoV7f2edXexFOce+Y9Rpb+BoHJA1L2RASm6mhCVwJRq43gs9LbDnBqO4?=
 =?us-ascii?Q?J3DV2m7xG7mlGWOf2AgqanfRcCwlOVMQs6e0MlLxJTW1zfaL88kcs7Mg+1H4?=
 =?us-ascii?Q?pmzqzhmlQ1fQeYXkIZEAYh1qjHm/v4rtmWwWaG6rW9pD3Liq89dmOCjopaiq?=
 =?us-ascii?Q?KuKHiDRJdCGxoXzDqcseKwPPp9+maa+kVJ8+lnoH1l2jFKiBGtpzX/OaoUYl?=
 =?us-ascii?Q?H6YDw6cTtPBD0uPaITTp7NK5EKpsq214I4v56AqWzm/bEAoM5PMTeK2jL62i?=
 =?us-ascii?Q?G5nGjS1dtmuCqO9G9MLepbUxomuRpnOdfHRRVP5poKkgakGrsEVI+4oAgVKr?=
 =?us-ascii?Q?RMNwpaJq91Q2cRwq3KNZTP0XvF3u4WUZxeuE6YQT0hIiTjfB+HDWON7hdEXj?=
 =?us-ascii?Q?OuTVjgK5bF2cTgBjPR7tbipt/r0crPQHQHvf5SfE8OPc1KRUnVxBh0CePYZq?=
 =?us-ascii?Q?ngVJWaOvxcZXsw7y1RrITdyYv69C5rhJh4JGMZ61Ftcyh+qZTho1LqlBp0d+?=
 =?us-ascii?Q?0oPygFJoKszonT4yPcW3l6iOtpfAXHuKlGCh5tyyrDAki+WQY31rS9XU6+vr?=
 =?us-ascii?Q?J5kydniUKJHOlMzbFhROWH+xb2W2IMwJiNQ34Em/glUyDZt8U4JmY0HUrszp?=
 =?us-ascii?Q?NHYSRmp7h+TvrhSwITyzNLCg3vAo4Bg49nxR3rPydIqpfJyCiw5s6rT56tAj?=
 =?us-ascii?Q?vr+GL/C1d1JxJ1TyEkl+YEbr0Zt52MkqQ9Qwujx8ZIV4CqtE28eXFh0frTzo?=
 =?us-ascii?Q?/d0THUI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oUx8SlNCcFoQtvueORXTY8csKLS0kT8gWXJRbYYOp/aDkd8TW4GfKCCBr2sy?=
 =?us-ascii?Q?vt7hAwnEp+qubreGbh+x36CR93owomdI4f2lbpb87CmPmy6ol3esAmjGkqgM?=
 =?us-ascii?Q?MSJTGNmbOiJLGM/6Vk58nG93xdeAM09JAiYm+wOtnOMFN1bHeUZ3+bii4Lfg?=
 =?us-ascii?Q?09nRLG3manahxI9/TC9Z5MzQ2WOtG0yGnIVA/zxDYXvAmAWCkmbGAlqoRw3g?=
 =?us-ascii?Q?S/ByS1Dy61MVXR3B8hfbxksa5oviN7MGzhlTrH7XkrnNTQV4Gko8cnffWwMY?=
 =?us-ascii?Q?uUJll4aKVqHq4vX/Tij1m4kRiBo6+WLdeGGAdwKKGPXoInlSRQ81mHreOP85?=
 =?us-ascii?Q?pLxm7WiEpnJhBGOBIfRDOFdeOzMk76f/Zry8pCFH22HF2AfZutX6dmgRh7ko?=
 =?us-ascii?Q?0VofT7DhbfcsrGnfZrsU8fzBnUBJiQCTSYHx8JsGad4nEhAD9kymtytBdvES?=
 =?us-ascii?Q?HO/D02WB290/KCmZU4mRCd6BY/+FLD2QBtaEgnrIRZfIkpCc+FFRpEWmFa5B?=
 =?us-ascii?Q?q/0HC/dtQ5UQqF3vord6E9CI0WwcDzYQGkf/v0qyaOSnVmJRtygKBdNiUVSu?=
 =?us-ascii?Q?1OvosbiBASUdXuRERTc6JQVZ2tSV72iaMfRu8u/xypdhugw5NmL6nF7RuSbW?=
 =?us-ascii?Q?GHBSUchpMck6aYnCDN+AM/8kedPa67mlwqKU5M9RvX5+Ofjv6FcKDJGLR+lR?=
 =?us-ascii?Q?1gRzhLDWHdKQNGyU56UB6SITywr3R4BaUEMJZFMfVmZDP3T2KpBQMeVZhQ/2?=
 =?us-ascii?Q?7yfFIFoTs98ow1AqW/ArfnyB6Mu5fAmoDKhFTlZX7F/JM9HAGBbuQ4vCFVLw?=
 =?us-ascii?Q?5Byp4SJPPlJ8NsokPRafQCPbi0fE19y2QMcr8wXlZcAI5JkedNxAocrWCSdh?=
 =?us-ascii?Q?H1l2mdRjQMw2SE4UNIpVjbB4GEzYqnthNCzNJMC7H7Zwk0bA5DyCy66GDo1c?=
 =?us-ascii?Q?eduT3ndp2GRfyveV1HyOm5Qa8UbalywJVkViVHV4qIdrnypaC3V4RHudKAKl?=
 =?us-ascii?Q?Ka7DAfFXJLMDkal0yLPtbRLES6WRNGofaPGBQPjKb0Pvsoojcl7ogaopMrwx?=
 =?us-ascii?Q?6ityU5FLw/RlHhjhTA0akpmqSNbK6ZEX1K2+UgNAXztUA2NjAcpi82BAHokB?=
 =?us-ascii?Q?hXgw+F/p7Kd3u7W/ZwZSAg6TvfKw+tV0wMCmXetltFT9NgO7lE44BOEoHH0n?=
 =?us-ascii?Q?hKgD8QKU+FjnztiGIsARiW2kDcFF6PKiBILP7mf4cfDfwY4Alut8zT2KVQ88?=
 =?us-ascii?Q?1aooBdj0Cua5RWiNzsDiKDQAMqcfOETICAtCEWnM6V7HNeBtrEEb426jVrF1?=
 =?us-ascii?Q?85fkYUM/CR6ObA0WT+lHFPwmzZ/gYELX02jgvLraU7Z6I45aPbS9jsVkJvEr?=
 =?us-ascii?Q?+bQialNdvJQLRsNu3aTNSInVl/1WthUiqspRhbUBDTY8XyppeJD4mDeN4q/j?=
 =?us-ascii?Q?iHILwcXAjy/uQ4hlwd4coFazl+HHvc+0tcu5crYzTPT4aZltDxDfwPvtlQhO?=
 =?us-ascii?Q?JMAVZ0vf+4ualAKaIRheANY03ljjZXkWw40XdgUFMSRI8PJSvKk5ITnOBcOw?=
 =?us-ascii?Q?rjRgStvBKrkh3LDf0y4F3NjPhdGTDQymdTr3mlt9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e80a3b8-66e1-476d-41b2-08dd055482c2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 09:04:28.8258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eKdJ0vw9aipupdcxjb9VDSz/lX0OohfUZSK/WZ7rgtg5wuO9xRuMuTDUF7Ns9JvORvQuKpxnIlxao1/TAeGfIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10980

Before sending PME_TURN_OFF, don't test the LTSSM stat. Since it's safe
to send PME_TURN_OFF message regardless of whether the link is up or
down. So, there would be no need to test the LTSSM stat before sending
PME_TURN_OFF message.

Only dump the message when ltssm_stat is not in DETECT and POLL.
In the other words, there isn't a notification when no endpoint is
connected at all.

When the endpoint is connected and after PME_TURN_OFF is issued. Just
print out one information instead of an error and exit, if the link
doesn't entry DW_PCIE_LTSSM_L2_IDLE stat. Since the recovery would be
done in the following closely dw_pcie_resume_noirq().

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 .../pci/controller/dwc/pcie-designware-host.c | 37 ++++++++++---------
 drivers/pci/controller/dwc/pcie-designware.h  |  1 +
 2 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index f7ceeb785fb0..c2053555c44b 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -927,23 +927,26 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
 		return 0;
 
-	if (dw_pcie_get_ltssm(pci) > DW_PCIE_LTSSM_DETECT_ACT) {
-		/* Only send out PME_TURN_OFF when PCIE link is up */
-		if (pci->pp.ops->pme_turn_off)
-			pci->pp.ops->pme_turn_off(&pci->pp);
-		else
-			ret = dw_pcie_pme_turn_off(pci);
-
-		if (ret)
-			return ret;
+	if (pci->pp.ops->pme_turn_off)
+		pci->pp.ops->pme_turn_off(&pci->pp);
+	else
+		ret = dw_pcie_pme_turn_off(pci);
+	if (ret)
+		return ret;
 
-		ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
-					PCIE_PME_TO_L2_TIMEOUT_US/10,
-					PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
-		if (ret) {
-			dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
-			return ret;
-		}
+	ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
+				PCIE_PME_TO_L2_TIMEOUT_US/10,
+				PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
+	if (ret && (val > DW_PCIE_LTSSM_DETECT_WAIT))
+		/* Only dump message when ltssm_stat isn't in DETECT and POLL */
+		dev_info(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
+	else
+		/*
+		 * Refer to r6.0, sec 5.3.3.2.1, software should wait at least
+		 * 100ns after L2/L3 Ready before turning off refclock and
+		 * main power. It's harmless too when no endpoint connected.
+		 */
+		udelay(1);
 	}
 
 	dw_pcie_stop_link(pci);
@@ -952,7 +955,7 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 
 	pci->suspended = true;
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(dw_pcie_suspend_noirq);
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 347ab74ac35a..bf036e66717e 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -330,6 +330,7 @@ enum dw_pcie_ltssm {
 	/* Need to align with PCIE_PORT_DEBUG0 bits 0:5 */
 	DW_PCIE_LTSSM_DETECT_QUIET = 0x0,
 	DW_PCIE_LTSSM_DETECT_ACT = 0x1,
+	DW_PCIE_LTSSM_DETECT_WAIT = 0x6,
 	DW_PCIE_LTSSM_L0 = 0x11,
 	DW_PCIE_LTSSM_L2_IDLE = 0x15,
 
-- 
2.37.1


