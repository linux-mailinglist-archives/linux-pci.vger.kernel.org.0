Return-Path: <linux-pci+bounces-17316-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2F49D92A4
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 08:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9D7A166D37
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 07:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C43194AF9;
	Tue, 26 Nov 2024 07:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PwHkt2df"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2047.outbound.protection.outlook.com [40.107.22.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329D9194137;
	Tue, 26 Nov 2024 07:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732606805; cv=fail; b=RcbjMzNh641R1tTQq9RKKHe3DrmIrI6ZMJeGdPXhjb1yPClKstsCh4+07ugmmGd6i7RjRHR940kATVMAaptSDGV5KBDuympBIshawk9GQtjCOlGs8m0wGIcT8zpmt/Zu5rCfItlakoY+1oIcqexgU1EBX/kBmPSIcXxc3AAYwCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732606805; c=relaxed/simple;
	bh=oyX9g52A+PIwKlVInKhyePqOC+LgAltjHOhK3oTFgio=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=jDb27g1VXJjEsGuCF3lWAB/2ym1aT1tL9xHaDAhfWrfaTJgjDxJGL90c4R+GazHF7dQV0mLDTXtQn35KnLztfOr//ZcLRSClD0bS/hlPorqI+6Xa+E9Gx+2qhiBfCOr06sXfkUqFdBJNMZpYd9fyK1vmYvuyDj5IGTbxvX2ALe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PwHkt2df; arc=fail smtp.client-ip=40.107.22.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x0PW+jRznfoUYEtv3+pJVb4jWb28Sebriv93sU3LkLdF0JAba34FRbdT/2DEojcGmNr8gkJJD9XZCjjY1ISVYnrgLZpunleRMXozobLQzmDTTJ0A0eApVMgirccmLgWqD/epQMZ/OptHdvSwOHTGSRO84cmRXt1tYEgbnY/mzxmbkEqXTSIEZ11WKkoFN4ZS4Vjjt0S8/EB9zf+xrH4lKsmTIt+C8zVEVRnofl12J/R4b5GRyR413MRE6jZdhOmkRICCiS7/1G4SvwZuj6JBk8X27n8NXX3tfQn6A/xwI6AdRa9JuRZyPntu8CizkBsjM9llP2IoMyVK6sqDMpy8cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRVG4UEGZf9hhMXWbDT7zUWr4NVjpS7IqJnUBICDnSk=;
 b=aFkVP0q4z4M+ZGAGTnbwXFHuRepyn3TJNzXIK5qxiWC/Eg8aYM/X4qxKzPOriyYTFAsDQbJACCMvAiwSaaiKHJkTdSrr1nh0eXKerkP1DbNjR7rtVNF8uDdmKlOsiM9bqAcY/9n3wP8figV2CzUxZguc9NfnRy9DSyijne5sgZmuoWsdipPxlFFQ2QN97Lof0hmN9jiekYwUEs7mWMv3dBUTm+zCcFW2BhIo4K49yEDQM+Gqgn7PHAtTKj04+Fea6AhKLvs2o0KTnFFdJAZqKzXx6FSSLs8XlproNDSOMSpHirPy4P7g1csgCLbWHlkTgd9AiMKxc4gxBQDtXufB0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRVG4UEGZf9hhMXWbDT7zUWr4NVjpS7IqJnUBICDnSk=;
 b=PwHkt2dfgvC6SIb0rUgz++iSjd4WEbpok1NyIcYUs38ojHGunS46Brek1+IToz/ZkBnyQiUn6T/qdRphJkNYmzP+OGsLkLu3MvchEFv/S2LSRxaabK3Q8w8STQ5Vpo/e2sDU3MUyKiS3o9uXWEDE2HN53n4H6VLuetQIlvl6QBzTc+IOPoOOi5S0CdP/huOK4U9ROeKnh05cNUBFt0O5nIoF0cRVP9wljJj8MM1QDGAxhHkkDloladgsiVqN34nRLkMdqjVORjxBrS44QjJLze7YWR3ytxHhXoNLYGYWszAPHKfedriRanD330D5DJiSmik+wnuFkcbnKYYIrelVJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PAWPR04MB9813.eurprd04.prod.outlook.com (2603:10a6:102:391::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Tue, 26 Nov
 2024 07:39:59 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 07:39:59 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: jingoohan1@gmail.com,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	frank.li@nxp.com,
	quic_krichai@quicinc.com
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v5] PCI: dwc: Clean up some unnecessary codes in dw_pcie_suspend_noirq()
Date: Tue, 26 Nov 2024 15:39:09 +0800
Message-Id: <20241126073909.4058733-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0156.apcprd04.prod.outlook.com (2603:1096:4::18)
 To AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|PAWPR04MB9813:EE_
X-MS-Office365-Filtering-Correlation-Id: 8749f148-fcf2-4c45-b595-08dd0ded876d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ttgUdbPLj5hca3rFYpYWxxo8/WKeUV/D0/qwvHO28+JvyS1RXF4nKVFoJbxT?=
 =?us-ascii?Q?HuC3UO95VUF30KRXmi4QiqhkXKiuftMSYmjHbGZQsuiU5I4cEwABVE/EzsaS?=
 =?us-ascii?Q?o2BGyUD0rIXk5BmIH084Sfi6MaUHni4iXgZux9hLuCdLM5fC3F4SSMdYJSum?=
 =?us-ascii?Q?82SOU/cVk59bY8OXSVp+MVCGf9ozRZFwJQsyhFyIb1m7N/V39PLxos5VnExt?=
 =?us-ascii?Q?jjXkLmQLrNeXo6tFDo89WoOYn6i++0TkqacLe4wTlIPkTECbXVv+ZRVzv4hG?=
 =?us-ascii?Q?ID3KRJPNtBAOum+wJ0EzisDJR2XPd42Rr3zWQmYeE20tpqIoUBxjVca7mvbz?=
 =?us-ascii?Q?tmFw9yTEnZeoJ+Bn0QJ3TMPnhQ41a9R7r0ug59SKc3bvmbrsM46BA8UsaMIp?=
 =?us-ascii?Q?alGIO79eMgTVovYoy3PQULdrEW3lpS1UqHjtrZIuceBKbmpbHCwrRyfAR3T8?=
 =?us-ascii?Q?Il0d6UgXwF0oRzW6zJjqXEwpdY0yTGn+EXZttcIe7HZZ80ySIgBvLWROEbjQ?=
 =?us-ascii?Q?21cNRBlAMSwa1FR2jMHDjgN6wTGWEosU/Ii+RNbA3b4bbIYG91lehTBmtHcs?=
 =?us-ascii?Q?MRJ8XhAOq7ECPgJR+DNS+gDBnsGFUEijaZ14Z7Mh1GWEsQYIfRFwrfLvaxbM?=
 =?us-ascii?Q?lxm5uvcENGBxwE7iczlRusUWEsUKzE688YIVpN80L/TDHYnkzK4JctXKB46s?=
 =?us-ascii?Q?j9Qa1e1kxhVoyBzgNISHgLU55Ckyvlc2wEnStQDxzpbMVmBNTHXR1u+QkoNJ?=
 =?us-ascii?Q?x8iqf8kV/NEpZbp0/DiUr/ziGYN6BLaWNF8TQoIa7uatFMwnfa5CX9MQDLqh?=
 =?us-ascii?Q?EhgMPPB+5249eQP3V4HUgX3wjwWD65zHgnFRa7PJg+YjEzL9l05MZG6nB5Yo?=
 =?us-ascii?Q?gGwo/DFdaWnK3f/fj3Em8XOdXhya/2yQeaLW7KbiizP8wyeff2LmxpCiszp9?=
 =?us-ascii?Q?uJE2pEdjHRW0ct3YCr+dK2Dv9kmr86VEo3oZrX2WWmaOatQ6mF5uVS4Op+ea?=
 =?us-ascii?Q?sKn597ORNMQLEgS/Md1eORRFSezG4Tqr2/rd1syMok/iRyB78EwfaY/e2YGM?=
 =?us-ascii?Q?CHiJoHE+dr6z4JpM5VAgu9dIuSCazBQ+MVJgdzcVLUb0NS8It9mLX+2xT4Jf?=
 =?us-ascii?Q?u+NMh+cI0CCUMVs33EbJB7tkphteF88gNiPN33L646Q+9b5W+N98ybMpHre4?=
 =?us-ascii?Q?EiM/+94ideyO70oMD7RX0ULiL4YnMBjie43JTAiX3o2i+swvQWYqQLFaDBrw?=
 =?us-ascii?Q?8V55jTSDaxmELh1ewIOkSyYz/Mg4mIJYu8MBWdwmUH52BYYFzR1s1PgcU2mG?=
 =?us-ascii?Q?gYdo/ZXhMm81bKyRzLb+DC0B+odzG18NMJqTEeoBMy+usYwcUh9iyKqqL1Xs?=
 =?us-ascii?Q?dFlVO+uIVgN/x7fnyFfUKjmJok6d/QGJYmSK4KQDUCjh0HAWHQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C/iCiPT6huVtlh6/2unRlDW98XzLBwwZydfL5nuOrAEtUI06HM4KAkWUeNWS?=
 =?us-ascii?Q?0YZKT+FuTyE0FXHcarb/hd62c0tkn/tT6kmxdUV5qJ0YTLMODbl+5KmmGAK+?=
 =?us-ascii?Q?5gO/QyImnDFYs9CJaLPu3KUorrWARbfRnTv2y3pAY0E7ydJpE22PtmGZNYo6?=
 =?us-ascii?Q?+ksuQUPd21ii1vuGbdquuJT2Wv3qVYhWm8u+SvRQLGdnBOQfWzqDBt5Jt0cd?=
 =?us-ascii?Q?hiVeS97I5nkvflbj/HV9fSSlt9mm6NygIavxE5bRsHqp2lEv7JvYhZRNlkG9?=
 =?us-ascii?Q?0jjXz2D8MMfm0kM6eA7kALTvrYaSn/RplxhwqC3sF7qM+7JRQsxyuEJ4LzFU?=
 =?us-ascii?Q?paWW51BIVjWVV0YSaMpvqQQycIYUR+ffT5suRXDLXD4RJ7kuv0kn7r5cWeB/?=
 =?us-ascii?Q?94Y1c76Z18E9ZKcoZWF2mRoP7I6uzxT8nWsNNBKgb9sNkwIZFbd0X4/4udd3?=
 =?us-ascii?Q?DxogoB5N6ZZgYC7O8lL9Lzvh+pSZaLcikXvNA35RYfNv3zMA//Lo5OjYMiUz?=
 =?us-ascii?Q?BhNZD2vDaQ5qn0EuZ8QeNq9IUTdhLUiM9fHM0MdGpFedaOJRaRGF6PypqGnJ?=
 =?us-ascii?Q?UL+0MbevTNywdUAk/Ohize7/bGGl4enKr4LyvNg17R3Z8T3zzY+r5oow1dgJ?=
 =?us-ascii?Q?Jyg2ZbqCi63BMY6o2CFa3YJfSbL//ILIGrznXIoU4xW/KMdbEUcQFbk9BJxL?=
 =?us-ascii?Q?Ji6FehpnHszGW75IiE0/+Hu7xmJQcOLaKxCoVn+aTNDBsFD/Si7ioSS7rhsk?=
 =?us-ascii?Q?bvq8aT4WWKu3/JOCInx7MPEDxHXBq1YbGEl2fFzfmPdDEx6MQzHTzNLjpci6?=
 =?us-ascii?Q?7YzZQt8p8Cyez//xtrATRy6VHkFn7rBWPrbxpW07YJwEPTif58WgWnR1fQiJ?=
 =?us-ascii?Q?xo0veMropKU/10YAKDtQjE8xS+zD0M7rZuNYq2Tyz4Rt23hrt42VrPXtaak+?=
 =?us-ascii?Q?TpM5X16KRg5uAr1V0kzWSNp6VjqkPhMxMuY0RbZhlQc+caGgSMqnuNcRzvkA?=
 =?us-ascii?Q?JVFQWF4C9wDgBtU78aS30uM85+leHawbTAesloebw9nSrxFX23JRlN+clkFl?=
 =?us-ascii?Q?s4L1goI2Wl9kwXjettf5n8i4CwsrVQCAV5qxdk5g0SjNUzAAiPZicfi0C9Hs?=
 =?us-ascii?Q?wUumhy7m0Y1CWSiX5kgyDTuBKdGuxbVqEXjSVcUquw5Q0ucwXqImVNzJ44Ig?=
 =?us-ascii?Q?JSTsy7u3QjaFXxk9eyls0qLqwAoo+i2okAfrahHrLdaLsvsZ8nNyUMHXzpP2?=
 =?us-ascii?Q?Epp7Nsog8WnzrkYdLQF4cSdApSw5epiAmGYcVaISy/FAX1Juat/j3yjShhte?=
 =?us-ascii?Q?DLNOaoGdYWhHjYa/Jp8dEyzlfgcdHvyj0OKdSgbtKs0vOqKQRBd9ap+/ZLcz?=
 =?us-ascii?Q?1JcRF0fx20F43sC1NvHxOMz8G23ELpczxxRUEvEdKQFU5wdobucAVYN7zCVo?=
 =?us-ascii?Q?ynKtyz0W8MSAbXM2bO1olw8D7jHihS7afWVFw34kL7GWz7aG8gQvSoiMDhDd?=
 =?us-ascii?Q?EstEtRFkg38327+DJQd7f1xnQp9DwIyjGVoGEWafdWdl5eYhGz0irZpTnmhC?=
 =?us-ascii?Q?bbrbdy7URN6YBT/lSfzSp7T6rJYcs2v0xQGXCku4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8749f148-fcf2-4c45-b595-08dd0ded876d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 07:39:59.0081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: geYO6BD22CSFCQqDKrf0vQGFqhRpnEX9YO/k7/T3RhVq82UkehnQWGV6RBfeuAFJptxOv9gPAlb8MvdWq1XyoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9813

Before sending PME_TURN_OFF, don't test the LTSSM state. Since it's safe
to send PME_TURN_OFF message regardless of whether the link is up or
down. So, there would be no need to test the LTSSM state before sending
PME_TURN_OFF message.

Only print the message when ltssm_stat is not in DETECT and POLL.
In the other words, there isn't an error message when no endpoint is
connected at all.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
v5 changes:
- Remove the redundant check "(val > DW_PCIE_LTSSM_DETECT_WAIT)".
v4 changes:
- Keep error return when L2 entry is failed and the endpoint is
  connected refer to Krishna' comments. Thanks.
v3 changes:
- Refine the commit message refer to Manivannan's comments.
- Regarding Frank's comments, avoid 10ms wait when no link up.
v2 changes:
- Don't remove L2 poll check.
- Add one 1us delay after L2 entry.
- No error return when L2 entry is timeout
- Don't print message when no link up.
---
 .../pci/controller/dwc/pcie-designware-host.c | 38 +++++++++++--------
 drivers/pci/controller/dwc/pcie-designware.h  |  1 +
 2 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 24e89b66b772..bbd0ee862c12 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -927,25 +927,31 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
 		return 0;
 
-	/* Only send out PME_TURN_OFF when PCIE link is up */
-	if (dw_pcie_get_ltssm(pci) > DW_PCIE_LTSSM_DETECT_ACT) {
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
+	ret = read_poll_timeout(dw_pcie_get_ltssm, val,
+				val == DW_PCIE_LTSSM_L2_IDLE ||
+				val <= DW_PCIE_LTSSM_DETECT_WAIT,
+				PCIE_PME_TO_L2_TIMEOUT_US/10,
+				PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
+	if (ret) {
+		/* Only dump message when ltssm_stat isn't in DETECT and POLL */
+		dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
+		return ret;
 	}
 
+	/*
+	 * Refer to r6.0, sec 5.3.3.2.1, software should wait at least
+	 * 100ns after L2/L3 Ready before turning off refclock and
+	 * main power. It's harmless too when no endpoint connected.
+	 */
+	udelay(1);
+
 	dw_pcie_stop_link(pci);
 	if (pci->pp.ops->deinit)
 		pci->pp.ops->deinit(&pci->pp);
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


