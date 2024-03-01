Return-Path: <linux-pci+bounces-4332-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D24E086E589
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 17:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BCE31F21BAF
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 16:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC1B71B30;
	Fri,  1 Mar 2024 16:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iHPL4Apa"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2080.outbound.protection.outlook.com [40.107.22.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B018570CAA;
	Fri,  1 Mar 2024 16:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709310482; cv=fail; b=XYahCHaGFPIn5vRQRAkLjpT7P1asmwgMLzIVDsyFT3EGfrM/dky22JHyYWLpJQW1KGE6uRmggmfOvGTY0fHyi1R09tTTXA5Scgcz/+B8MzbglYP7knIZdPcsGCj+vTHnoIfDT9fZ2Pnb6cmiCuz2JiyxHRyB5+pRgaRVcMWy/h4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709310482; c=relaxed/simple;
	bh=UKayiteSBj872tr84nTlkOU4HEjO5X+s+GNxqqtZrQg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=iXXaOPY1eJJWEJExJyKbWm923ilwmKkho0HDHipebKuc/wLgkC8tzD6bUZESEszu8N5MN3JHA1Ww6mqPaHwLsP/+hAE1pVIVtfxCdMtYlSmhzLpErHa9Es6NppiSI34wL9+BQG/bNne38leVQRCZo8YSJZhp+7bhs7XNaK6/qz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=iHPL4Apa; arc=fail smtp.client-ip=40.107.22.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOoPKWwcFR8ohozPhJmfqdOJIbLLA5pSVGbbBaqZHPvejEllPHcMPhRjTWzsEsdmNdJwlr2LnaJjEyPgBW0K4rTr/cy0h0oTyXLSqqo9E61QMLwLSz0YOLGV+vDnBtEO4TiUW5zKrxdjDGXNtXfbTbQ8vamY0D2zhQNvVDXoQZaHcTUH4C8rj5rnD8xU/0f1DzlI6BoSUuaGsd3wInIQ8pPSdmvW9xFSPCTjq+q/hQlfLJwM+UE8ZjxO+k08aGiUxdhgG44Y+t9ZSKlO0ATOHqHSl+7e/94K+c6omHPch1MQZDU6yvIqiRX3uYBPMhu+90V05I8MtoOvb+PdFc3/FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7iWazDG5c61RWvR/a9e8yHAfHl1qq5jrYCJHVQ+1A6Q=;
 b=dOBuwOsnsGoZ8Jcart315k8OT15DN9/iwRoGVBRU3sUTOyo1xjujyq7pf5mdt8wfk83OQ46E/8w0aPNy5QryntOl/VdLSB8aDBjWdzFa0Fr7+gVa/BLJ8IwBOBfS4IGwlGmDRo5PqC08ANoU9s85/toopKr+aO+H1mVEF1il7opCtJ+pjSpUdNUqxezTrWUSEJ4xwePaBsaJECtgwjleXB/IcaCS67TuwwlasJ28Ep4/BLG/5kkvSftOnq9VQ2T1oaaDqmtYtWXeIcCohHe7QyC+YXg1iAgwB05eO7z+2QbQqb69fxNt5YpQcU0/tBL7voM00lmJmbs/39x0iLiSMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7iWazDG5c61RWvR/a9e8yHAfHl1qq5jrYCJHVQ+1A6Q=;
 b=iHPL4ApaoR2joCRGa7VzbHmsWOqu3GmVHtlPx6FhuV6vS6isf1UUQ31rplZlqXQy9GJ6pYqSRH+0Qx/V46SXGasEheidU4D6Mp8EW+/m+rDzATwEqhkImyvBSNNIGt6BVgjgKYma6Q+Rp5FmrejtoQcy7JRE+lPSJa8lFBcE47U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DUZPR04MB9846.eurprd04.prod.outlook.com (2603:10a6:10:4db::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 16:27:58 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Fri, 1 Mar 2024
 16:27:57 +0000
From: Frank Li <Frank.Li@nxp.com>
To: conor@kernel.org
Cc: Frank.Li@nxp.com,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	helgaas@kernel.org,
	imx@lists.linux.dev,
	krzysztof.kozlowski+dt@linaro.org,
	kw@linux.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	robh@kernel.org
Subject: [PATCH v6 0/3] dt-bindings: pci: layerscape-pci: Convert to yaml format
Date: Fri,  1 Mar 2024 11:27:38 -0500
Message-Id: <20240301162741.765524-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0388.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DUZPR04MB9846:EE_
X-MS-Office365-Filtering-Correlation-Id: 8464298d-99eb-43d4-4685-08dc3a0c8e04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wwZXhNklvzA/zSZ4P/SF39lOtCwRuhKFzPR1i+9iy2VNsmT7oumxu3lNfdkSx+0WgK7EwQnKeZ4OA2sWfS/OEn0Wa7wMsaXOezcIBjlvlOfOH88v9SjntCu20Lu87eTmd5bLs65v1gogrBIdhjijhNW3x9ztnhpfvrTT1aKoRN/oXJC8S0g+00Fjm4N/vqZZZwjIASBGrgR1mzI9R9EkK/9wDJokO+WPmagXTV8ZQOqcMglHDZnTkw+LlOwixS8xB85KAT1u3cQyFHTaLfpta+SA76s+wv2sEm3VwRck6ONsNZEiAAEDakUeTPbvcurJ3DpDpf4KiFrZTUESi2mIQ6fn6K7NipfeyOR3G08DG2kOEO6NZYwxYIxgE2cnsrcYIN+XFOjvc/3zm0yczwmisxiN5ut0N/gmpY5igQEmthbVgDkttcpGTFzRwd8ozNY8ekbETaGzCTj7elbj/wMonss9fsSbJOYbO1C3RmN+fQKImsSpNwotfazEgzgm5I41qBQWYJF2Vbcdpp7TLzCJQdsDfmNoCcxs2W6yT6ZhlI05EEBpB/LxxAfB+6Y8R2cEgkp0qRTPv4l7+Ojcrqyew9YSSJ2DFVGvXDj/HFGPymioVa/DNx0JSUTY9skmj6IHn04nWumP7RfNYNhYAVqYM99T56pEeMLJAilKtLRPyYd/PNHbb3YzN8I5U50wcNzC4M9POMbKLW87JqLKNxwKzhVfRlahuW+BimLaA6lVtW8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ia17MY0vzdWipmMLQ0J10gzVFRam748lobbUm6BDAnyJGwfKtvJvhDgzHy5V?=
 =?us-ascii?Q?o/TvaaquUxq+YC+ngGiommJY37QYnVh18xx3yDBxArGIUCfL1pfqG4uSRdWe?=
 =?us-ascii?Q?9ht9tskGB3q5YT9pPn2GYHVlU5rQbjPTWDlhO0UsnBUx+ZdLQE+os7+IVbyI?=
 =?us-ascii?Q?1aGGeNfPi84IqgTCgNHOKbjh0Hks5L0Tw2KF7369OhFx3Ekzavrh/kHjMnUS?=
 =?us-ascii?Q?tQbz13h7H9EJ0EnQdac6sXWX1pXIKZlKnuDSKeaWkxhhYybvpZmOTwblGFP2?=
 =?us-ascii?Q?S0AKe3oS66o5xu15IEMS/b/aOKW4Xj+i7q/TY5IrD3nMnv+c0A028RhvKOYN?=
 =?us-ascii?Q?T3GCFdCq2ZU37NqzlGwMtWUES7NOzQ3YV9TP2330dnQwpNAYfq4OkK1K8RU9?=
 =?us-ascii?Q?UW9o91quGsyAU4m8ONgRiox+32ad2Adi24afA3tMfMuJc5OXaxp2tNL71QNW?=
 =?us-ascii?Q?y5Z1dZiPz76C8vm7PPzd2RgDwyCmp8/w/sXRzZf29QM8u1OwwKekuu084gEb?=
 =?us-ascii?Q?mqpzzOjXz6Gi1Yjl6h+VFjT+yshFrwIK3zEPHqkWTGlbdVfsndV9JNEmca7r?=
 =?us-ascii?Q?s/LhyfGrrUEm7TPzI22KkkDi5y5fg3nP0WvEtzX+24ou5VtrwyQnF8AoGNlO?=
 =?us-ascii?Q?SL0m/TjNYBB5W+gsbhbUut/kA112cW0EJHdz56YmZKym2tbvWBEZNH4mcRBz?=
 =?us-ascii?Q?Y5/3wLGM5GiFumzHMc0TVrzAw9ooGDZi8ZG/JGbnbmQFmGNYZAaqWxOY7MUu?=
 =?us-ascii?Q?AgHcqJPu6jne5hpjlUoWEwefCTaW1NtmcP1O+sa4lqZs/X46dly/pKwtCyoN?=
 =?us-ascii?Q?9cpnPBcpIE5BiqIQD47g71ZnW1TQQX8aecEXPS6ISmnsOQaD6UNttkcuqpl2?=
 =?us-ascii?Q?RzFi9emaHfGxLs5QnJ2O7kXToLaXmMsqQzIw41Ct7B4UDEPPccXNnqOPT06X?=
 =?us-ascii?Q?i4LG4mbeXY8/kvMARdU62rtHkwoSeKRVMWlux6YOh2Uk8JOfw4ja6ma4kUAT?=
 =?us-ascii?Q?WV1SxzxmpWohrCwjIOjQO/aULLv5va2mDpIGiJTEBA1gIeXE06if0N/wwi5s?=
 =?us-ascii?Q?14+szLA0mAWm/RdwxTOR+J0JxN7mqsle+FFlInpM0Tg+uj3X1Hk8e7vTxAZH?=
 =?us-ascii?Q?dwnCvTTVbgoi1YOEGpVkhNz3a6ReaH2iIZvFA4iLopYURrPeo2l42NC8cFGF?=
 =?us-ascii?Q?cePteTPceUECbSakdDhpfgd5pHTeKF3cyz2EI2s0KLKnZZyVSheXp8BP0f9x?=
 =?us-ascii?Q?IrUNryOdIvkWq3Ko9v/td5ZsTph0H8t3M/a4w2SpMn7PveAfSj5CuBo6h3gZ?=
 =?us-ascii?Q?uHupxyobT5FIwO+rRYQGrVAEmiolHho6yRdOD7ieWFWQj8OBoJwZvCp0TMGC?=
 =?us-ascii?Q?fNX7bAvotgM6we6l8nEUDM25f89Lwi+IhQbhgby1CbSDcSP+Q7JVDfXL7cUw?=
 =?us-ascii?Q?EDxzyuYcW2K2KzwHiNfY2QYntUnY0UO+PaKSbxPX1CUXShDq9JiVG/XvTrdM?=
 =?us-ascii?Q?6XaZNqfCIiTAVHcw7Y8giny/tQz+0qQU/NDa/z3RE/ZZ7U+u/Dka+xB2losl?=
 =?us-ascii?Q?CQJT+kkA108h0NbA4/Clco3m0f8mzo6rY72uHOLT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8464298d-99eb-43d4-4685-08dc3a0c8e04
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 16:27:57.7731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eoChgMCJQvtQC9CbGooswjx6eHwRmsl9HlTYwXpBAAGCIOoGTFRbsNElmzPyTgX3JtsWaG6LP7L1yURlmz/v2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9846

Change from
    Change from v5 to v6
    - Rob require every commit pass dtb_check, so first commit included
nesssary change. and list change at commit message.
    - Reduce to 3 patches.

    Change from v4 to v5
    - split 5 patch.
    - create one base patch, which the same as original txt.
    - two patch fix for RC.
    - two patch fix for EP.

    Change from v3 to v4
    - remove ep label
    - remove status="disabled"
    - remove deprecated property
    - fixed irq max-numbers
    - because dts still use "reg" instead "dbi", to avoid dtb check warning,
    not referernece to snps,dwc-pcie yet.

    Change from v2 to v3
    - update commit message, show change compare txt file
    - add failback compatible fsl,ls-pcie-ep.
    - add commit message about 'addr_space' and 'config'.

    Change from v1 to v2
    - remove '|-'
    - dma-coherent: true
    - add interrupts and interrupt-names at before Allof
    - remove ref to snps,pcie*.yaml, some reg-names are not aligned with in
    drivers
    - Add an example for pcie-ep

Frank Li (3):
  dt-bindings: pci: layerscape-pci: Convert to yaml format
  dt-bindings: pci: layerscape-pci: Add snps,dw-pcie.yaml reference
  dt-bindings: pci: layerscape-pci-ep: Add snps,dw-pcie-ep.yaml
    reference

 .../bindings/pci/fsl,layerscape-pcie-ep.yaml  |  91 +++++++++
 .../bindings/pci/fsl,layerscape-pcie.yaml     | 173 ++++++++++++++++++
 .../bindings/pci/layerscape-pci.txt           |  79 --------
 3 files changed, 264 insertions(+), 79 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/layerscape-pci.txt

-- 
2.34.1


