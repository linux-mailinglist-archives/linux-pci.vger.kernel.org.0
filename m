Return-Path: <linux-pci+bounces-20062-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37347A152FB
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 16:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E2021885CAC
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 15:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F32195FE5;
	Fri, 17 Jan 2025 15:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nv26VgES"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011046.outbound.protection.outlook.com [52.101.65.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EB633062;
	Fri, 17 Jan 2025 15:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737128568; cv=fail; b=ACfWwdWBrbiSodfKuAXadoVjUPy3o9AyADQLvl8y5631AEjNbxFu17RZjpb0tUBH1yZ61rRD3kpWoSK8+LUitPH+r9h+AOeYYhpcboVE5j4c8+qB2aLPSa58GuenkBA8mwsoQkaRAx57wfb0OACHzDbo0Igo/X1oXOgNnnD8RtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737128568; c=relaxed/simple;
	bh=MHWpbiJJOP73+FkmjgBuVw573bachy2reaioWFqfSEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ht3x2/KAME028Xtknue47pgbW214oaEXhjD0Cex8HAJIUrrt8xOklYlgvAJ/3MwY6v/g+g3sdqmFfdfzq/c68qKl9q6MzdsjXb3LLjjkJAVxeyv1JtS/Y9L2fDANBdvPhiQmagBfoyApp6KmSIBEnBkM/hnNpLG2yugqcAA2grA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nv26VgES; arc=fail smtp.client-ip=52.101.65.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aFB5rHijcAC2wuYwNIRkfeMgVWtqU6lTJ66AxXvjKdq6lArpwcJqk1puBz/T8yQP3VNIQ4ORx5GGCFMBbYb8Lboe5EZV2F9bqSEWE0FN8Qnv55g/cK/0E/nKLX45ZCwB+VMwIAsMPT5bjNaGj00EYachidrgbwb38je4ZynTfx1Ps/chhgOF6IZS3pyvjRnqNzRT1mWVmgs3Samj4o2LKxx9LgNmlUgyQkNp3fwmR8VPFJCSCr6t8JuhmLOaE4pNxooX+g3ouWUYBBotHsj+TIjY9P8Jst9NBQq+PSkRVbJK8vVuI0alYi6MtVWZE0Z0HAmFv9D55iiofgmy8z+RSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/QmAL9bw4B8uafla0Q8DvvVspPKS447bQtwCX/mYjY=;
 b=deOFf6DNwpGw7UJRVp+pFPPJU3pmLNf4mQtR9y/zXvmhKMXSzFRxmypOnp3BoX32JlVDxjB1JCsYDrob+try3gieM4r6qiMkBsUdkIPVydz5A+dDsAhLetdPE+3lqn+5j1aN/Wl7XG7KuqUuu9TLWU4Aj+94SjefavwxdFsafKgzgCi7DeLeHLtH9EMdjXoLEP1YeMRUuM18az6dpZj6iHeqknyTOGjw2dcuzrMzNN+dmO+JanoK+mx78S0HApEgmzfNMd4LqKj7WZHMRFaiEMCTDH6b+iZAsy/mSrllQ9+WqpEWTvM187jIzjoLCpplGKezQdJsiIIiEUK2DElOYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/QmAL9bw4B8uafla0Q8DvvVspPKS447bQtwCX/mYjY=;
 b=nv26VgESTU1KEecFR4OpT4Jq6fwWfKiSWMlURj+qV43/gk8rQ0DkwPWeu9VSTZyCBZXjAdKkP/6ZYmoWYKcocHXkCkDr3eIBuEzjkMXtV8B6QNcf7fMpgpVFudaFA5DC/6PwMQOP98AtV3ZKtRohsTanovr+7KH6IVDkLqTsbIci6ehYj/Si3C0VKEove6qvtrtFw60d7gOM2RHCvdhxGkAgLD1RCVLnEpZXjpEXbJVK0NZltVVUeuIJve4H3L2rBQsSTkzTRAAAUx4NUL/83VeEHqULNP+6TWghAEPXVhXzfM2n4tAaYILucezE8iv+c+u4m+q27lUgdp54nLz8Sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAWPR04MB9987.eurprd04.prod.outlook.com (2603:10a6:102:387::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Fri, 17 Jan
 2025 15:42:44 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 15:42:44 +0000
Date: Fri, 17 Jan 2025 10:42:37 -0500
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH v8 2/7] PCI: dwc: Use devicetree 'ranges' property to get
 rid of cpu_addr_fixup() callback
Message-ID: <Z4p6bekWQ7t7ZDS8@lizhi-Precision-Tower-5810>
References: <20250116231358.GA616783@bhelgaas>
 <20250116232916.GA617353@bhelgaas>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250116232916.GA617353@bhelgaas>
X-ClientProxiedBy: SN7PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:806:f2::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAWPR04MB9987:EE_
X-MS-Office365-Filtering-Correlation-Id: 77b6c782-9bda-489f-a5c7-08dd370d954f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WDVUZ041SUZTTExvdUhjN0lDZktiWlhBcWU1NTRlamJObXJUMDZUeUpNbG9V?=
 =?utf-8?B?RE0xdFp2Y3JYVytXaVoyTS9tUS9IYVVzeUNZRGhaZFRSRlhrbWhOQ2tNNlQw?=
 =?utf-8?B?UWpSMnVzUERyQmNmbktwT0Z5TDlsbitMdXV4cnl2OEZVOWxQZEZ0eGxOWE04?=
 =?utf-8?B?SkhEaHZrUjlOR1NVVi9BNEQ0cE9PZGpneTVueDJFYkVlaVBWWXlWaUd4a3J5?=
 =?utf-8?B?cWNRV1F4OG9HZVpndUNNZFJ0TktraTZNNWIvZnFRSWJlYXFSckRZb1Jkcllq?=
 =?utf-8?B?TC9ya0J3c1VCbW13bHYvSk5kL0Fja1dsV0hpemJuN1hWVGJRYmEzTWphek9D?=
 =?utf-8?B?MWtNcXY3aEZrWDlUZDIyQnBYV05aS2hsSlViMU95ampZN1FoYkphSzhoWjFq?=
 =?utf-8?B?cE4ybVVPNVNOSWFBTFY2SVpKY3lXc00zK3dFL0FqMHhweCtBTnlKc25iZHpI?=
 =?utf-8?B?dHdGWkt5dm1adVBNL09rNXhLTjhoV3cvbTNuZWdwT05JdENMai80VHdUWTRE?=
 =?utf-8?B?WFE1Y3VQOE43c1dNSi9ZNGZubEV6cmlsMWY3c2NHSDZOelNjYlhGZlA4S1dG?=
 =?utf-8?B?WUJ0WXhteTRwdGVuRUxidjNFd1NmZEhuQVYreUs2NFFUbWYzcEpHdmJlZ2hz?=
 =?utf-8?B?Ym1DVUxuZkRlTm56VStCaUVyUkRWQ1c2SXN2Rno1OXEwUHhhZ1F6NGlZWWNR?=
 =?utf-8?B?eU5rNjNHUmgzS2drc1phNnVNOCtTaWdsa3pBNTFjL00rdzAyUzVhWCs5MW9E?=
 =?utf-8?B?QlBsNmtBMlI4U0d4RnN2bU5LOEtBaVZhK0NzWXhqZkdnSWkzWlFlZTJTQzNz?=
 =?utf-8?B?YmgrYXhYQmliQmZYMEEyNHlHZmVQcVZsa3JjeGdWbStZalBkR3RVVnVxMWVD?=
 =?utf-8?B?VmU1dEh2U3N3K0xUZ1NCVWk5d2s1VjFENEhYbXVwVy91U01uclk5T1JjMVFR?=
 =?utf-8?B?WWVrZklTWlZKelFDaWlYUUFGKzQralAzQUZicUtBRG5Yd0piZkVVVlcwU0o0?=
 =?utf-8?B?TSt3RDAyQjFocVc5eUNKVDdlcnA3bjJ5VkNoV052a1lKcnFMcHZuZjdoeVBW?=
 =?utf-8?B?Zm1mKzJKaVRKME5YM3BEVC9HMWk0QS82cyt0VDdXYWZrVVFoQTZKZGJxMTdI?=
 =?utf-8?B?dFJBUjduaEY3UlYyWFhVbnRIVGlmV0FTVjdQdktwRi9CVTA4L3JWQ3pjSk03?=
 =?utf-8?B?T1RVdVE3UitwRDFUdjRQaXIrdko2SmphUlhuOCtXS1laUlpuQjB6dFJkRGlK?=
 =?utf-8?B?dnlmSzJWVVROQmt0ZUxGdWpjTDE2TGhGMjB5THNzaVpxR010U2hqQkJZelZ4?=
 =?utf-8?B?amdRNUtza3hoNEJTa0dxdHJJSmt5Tmpic1FycVNZeXZEOCt1Yks3aW1EaDBF?=
 =?utf-8?B?L0dpQVRBWHgxT3F2R0NhSEptWHV0aW9EcHBlVXhuMkE1YlliK09FVmJURGZF?=
 =?utf-8?B?SXdCVVMzZWRzc0I2a3RUQS96RDdWRm0wZENHZmNvek9nOCs5WjdXRnZTL3h6?=
 =?utf-8?B?WHpMSlRULzBNMlZjNUpydi9TMngzSFEwcWEwdWJyTnZMaWVVVFRoSzc1ZjJE?=
 =?utf-8?B?Y25nZkpRcTRJSFBvejJkWHRRekttMjMzTDBBVXVyTm5TTmNhaEtmeEhlZXE2?=
 =?utf-8?B?Nk5xNzlQOTZxWXhiWTJRenBWbExWSEl0MUtVYi9EQ002Tm1SMXk3TmdrWTVR?=
 =?utf-8?B?WXY5NGtmblNqUnZHcngzb3ZHZjduMHBhb055L0wzNDE0c1FKQlA1Y1NUWXk2?=
 =?utf-8?B?R0o1L2N0dWJrMGIyaG1yckEvUmF4aFE0dGJlb2VpVHppQ1ZIdGx3NmRxNmhI?=
 =?utf-8?B?U2EwQStTUVR5ZWlrbUhFSEMyNjlpdFZRQXNPREY3M3VLQXhTL21LUXBLc3lS?=
 =?utf-8?B?MDNweXd2eTBYL21jY01FdDJzcGFxZlJaeFlZbVY4cVMvQ2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ym44Mk55MWVMZVlXeFdiSUFXQTVNcVo1Vjl3M3l2WjY0U3lhZnFiRjJldDdn?=
 =?utf-8?B?OGhMWVBpeWtudjNOUlhCYXhEWFhPdTZuVE4rNWtOSkNrdlM4OStOK1owQkdF?=
 =?utf-8?B?TEI3b3dPTnVVZEQ1Y1ZhbXpOYy85c2IvZEhJR3cwMFhYUGhjeERYbHdncWk5?=
 =?utf-8?B?Q0xoY3RMYlFFY1BTUEZRRkxFZG1FdnNTaEhELzJVOS9ZblNVai95T1dKUzBC?=
 =?utf-8?B?RnN2RzhSQW9wdGRyT1UzQ3Y3VlRRdVNpNlRWVVVpQXA1WkdYMkMzeWY1RkZr?=
 =?utf-8?B?WTNaRHpMTGhtYXRLVHUvQWxDaitvemNJQ1o2c3Z1bmp6ZXBQT3pOR0t2cHht?=
 =?utf-8?B?VG5nZjFCVU91OEZOR1hZMEF3dnREaEpsd0k3RlNFZDJ6dnd4OFplU0pTS3Q3?=
 =?utf-8?B?WlpDcjlKcC9PeWpFYnNEYmo5UUxIM2FPNTJYOFNDaDJuMnU5RWtDeTJEbTBO?=
 =?utf-8?B?YzlHQ3pzU0tnOGVmSXNJbXVNVzJDT2lKSWR3NGNGNktJMndnYkJsb0tOYktH?=
 =?utf-8?B?T2tyQlVBK0p5ZDBraXdQQjJuNlRISFord2RCWWwvK2o3Zml2WUpkL1VvRjlo?=
 =?utf-8?B?NzFaZ1Noc1A2aDBhMzA0Q2JGa2kxNU5tU2tZeW5OUTh1OFlJVk1yTUhwV2xz?=
 =?utf-8?B?RjF5bGxKUWExRFRzM0ZLb2ZCYmZGRFhHdTZoMTIzdlZNNFVSYlRnRVRBbkh1?=
 =?utf-8?B?TVNpK0g4akd4amQ0Z3BBTnpiNDdHK2w3QXFYUkdDU1hRSWQxL09tVW9qTlhV?=
 =?utf-8?B?VW9OM1ZybnJDUmtsTVBQS0h4Rm1XeHo1YXBLWUJKQm15Q3N4d2t2a0cxME9N?=
 =?utf-8?B?eUhjSjR0c1hlRi9ETHE3eG1WdytQWjEvVHA0Y01iZ1VTblV4dEptR3hFM0Q3?=
 =?utf-8?B?TlZBZDZaOGk0RCsxeUxqZThNTElQZWIvWGtDQzRCNmk5VGVnWERmcEpVOEJG?=
 =?utf-8?B?TmNDbkVaS2VyaVBteFVFUitOTURSNG1RYmI4R2c1ZDZxUndKdVRRc2FlRkhX?=
 =?utf-8?B?RGhJTFVQcW5EdkFBVS9IVFFmL2RKSlNtcE5IYjFhRVFZd0xhcVc2K1Ric2tV?=
 =?utf-8?B?QjZScUZNZ0VDUkF1eFZZRUZFN1lJVFJCNzBGVGhuQjNtQ1paVHBTOFN3THdk?=
 =?utf-8?B?d2pNemFoWlZtSlNwbFlqbXFZVHJVYjVkNHVLVTdhVjNNS3ozVVk3RlFJbVhr?=
 =?utf-8?B?ZlFBK0VKVnppaUw2QmR4V2hjS3FOSDc5aUxXM1J0alVVenROTXo4dDBjaHBo?=
 =?utf-8?B?SW1TQzRpcUU3TFJLSTV3eStCd3pvWXFOcGVxSUtUbmkvN2NDMHBFdktqSFNM?=
 =?utf-8?B?S2x4SjdRR2pCMk5tNHFwc2MxMlNjWG5PRWo3d0N5dDYvYUFJTFVrTWdjSVBa?=
 =?utf-8?B?RWM1b3lZKy9JTGhEZ3RUS2xGS1hzQ0pFdkF3K0NVTCtpQUI0OXg1YjIwaTdL?=
 =?utf-8?B?TDNXSU0zVlowVlEvLzI4U2NnbWtKdGFKUExUTXdoN2RmRDR2bGlkbHNIV1cw?=
 =?utf-8?B?U0NjOVNoeG5aVnBIWDZ5L3NBQkViUVhlZDRiN0Z1UTVSUXRNK0N6c1JUcnlO?=
 =?utf-8?B?dC83Tk5teDJIZUVpU2czTkwwOUozWEFNUFVIakVDdy9NZ0FGOVFpMTBNTDNk?=
 =?utf-8?B?QS9FZjZVYjViOHhSK1o1MlVPc3poUytYMzRhNEdzUE9VdmlmUkNNOUN1NmdG?=
 =?utf-8?B?SVR2ZXJ4YjI0R01mMkJyMjRkZ0laSlVsVmxGMnByT3o5MHJxMW4zOVRacVlh?=
 =?utf-8?B?RFMxWUkzS3RuUVowUkt3R3RxNFg2cEYzMDl1RFg4dTRNamU3NzRnZXhmRXVX?=
 =?utf-8?B?anB0ekJMSDdQQXlVbzZVMURQVlVxSFk1VUczTk9VaUlPYjM1dGtGcU1UZ0ps?=
 =?utf-8?B?THJxbmZGNUVvaEVjMjFFSmhXNWJoUW9CdDRUMTZaT3dqR3NURlo4UFo5b3Aw?=
 =?utf-8?B?cDNCdUxGQWozVnNoMlhJY2UyNytGd010RzMvdEI5R0x3SXdwUjlhMythdC82?=
 =?utf-8?B?SWJCbG4xZG1KSXJiMWk3Wk9BcXZkVGlPUCt2RWlGWkZKcmFzcStDSUthYkgx?=
 =?utf-8?B?NVkxZnJEUnJ0RUFPWjZwM2pLdmU0blhuNVF5YW9sOXV1ZFlYdmRzUWpEMm52?=
 =?utf-8?Q?EKM5WOg1xoKfAYsdHUQYh5Yz7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b6c782-9bda-489f-a5c7-08dd370d954f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 15:42:43.8670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6PJz1ORMUtxN5lWoaWhhC6fuia4ptkNXaV53pyLrk4dSp+kazIfbUH86oqQnn1su2o6pAp9JwqL0s+M6yD8HKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9987

On Thu, Jan 16, 2025 at 05:29:16PM -0600, Bjorn Helgaas wrote:
> On Thu, Jan 16, 2025 at 05:14:00PM -0600, Bjorn Helgaas wrote:
> > On Tue, Nov 19, 2024 at 02:44:20PM -0500, Frank Li wrote:
> > > parent_bus_addr in struct of_range can indicate address information just
> > > ahead of PCIe controller. Most system's bus fabric use 1:1 map between
> > > input and output address. but some hardware like i.MX8QXP doesn't use 1:1
> > > map. See below diagram:
> > >
> > >             ┌─────────┐                    ┌────────────┐
> > >  ┌─────┐    │         │ IA: 0x8ff8_0000    │            │
> > >  │ CPU ├───►│   ┌────►├─────────────────┐  │ PCI        │
> > >  └─────┘    │   │     │ IA: 0x8ff0_0000 │  │            │
> > >   CPU Addr  │   │  ┌─►├─────────────┐   │  │ Controller │
> > > 0x7ff8_0000─┼───┘  │  │             │   │  │            │
> > >             │      │  │             │   │  │            │   PCI Addr
> > > 0x7ff0_0000─┼──────┘  │             │   └──► IOSpace   ─┼────────────►
> > >             │         │             │      │            │    0
> > > 0x7000_0000─┼────────►├─────────┐   │      │            │
> > >             └─────────┘         │   └──────► CfgSpace  ─┼────────────►
> > >              BUS Fabric         │          │            │    0
> > >                                 │          │            │
> > >                                 └──────────► MemSpace  ─┼────────────►
> > >                         IA: 0x8000_0000    │            │  0x8000_0000
> > >                                            └────────────┘
> > >
> > > bus@5f000000 {
> > > 	compatible = "simple-bus";
> > > 	#address-cells = <1>;
> > > 	#size-cells = <1>;
> > > 	ranges = <0x80000000 0x0 0x70000000 0x10000000>;
> > >
> > > 	pcie@5f010000 {
> > > 		compatible = "fsl,imx8q-pcie";
> > > 		reg = <0x5f010000 0x10000>, <0x8ff00000 0x80000>;
> > > 		reg-names = "dbi", "config";
> > > 		#address-cells = <3>;
> > > 		#size-cells = <2>;
> > > 		device_type = "pci";
> > > 		bus-range = <0x00 0xff>;
> > > 		ranges = <0x81000000 0 0x00000000 0x8ff80000 0 0x00010000>,
> > > 			 <0x82000000 0 0x80000000 0x80000000 0 0x0ff00000>;
> > > 	...
> > > 	};
> > > };
> > >
> > > Term internal address (IA) here means the address just before PCIe
> > > controller. After ATU use this IA instead CPU address, cpu_addr_fixup() can
> > > be removed.
> >
> > > @@ -730,9 +779,15 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> > >
> > >  		atu.index = i;
> > >  		atu.type = PCIE_ATU_TYPE_MEM;
> > > -		atu.cpu_addr = entry->res->start;
> > > +		parent_bus_addr = entry->res->start;
> > >  		atu.pci_addr = entry->res->start - entry->offset;
> > >
> > > +		ret = dw_pcie_get_parent_addr(pci, entry->res->start, &parent_bus_addr);
> > > +		if (ret)
> > > +			return ret;
> > > +
> > > +		atu.cpu_addr = parent_bus_addr;
> >
> > Here you set atu.cpu_addr to the intermediate bus address instead
> > of the CPU physical address before calling
> > dw_pcie_prog_outbound_atu().
> >
> > But what about other callers of dw_pcie_prog_outbound_atu()?  Don't
> > all of them need to use the intermediate bus address?

All should use "intermediate bus address", RC side only call it here. EP

side is here
https://lore.kernel.org/imx/Z4p0fUAK1ONNjLst@lizhi-Precision-Tower-5810/T/#t

>
> Somehow I expected the patch to skip calling ->cpu_addr_fixup() if the
> driver had set 'use_parent_dt_ranges'.  In fact, I think that's a
> requirement.

It's fine to add check to call cpu_addr_fixup() although I think driver
owner should take responsiblity to make cpu_addr_fixup and
use_parent_dt_ranges exclusive.

>
> Since dw_pcie_prog_outbound_atu() is the only dwc caller, maybe the
> parent_bus_addr change should go *there* instead of in the callers?

I am not sure I understand your means.

EP and RC parts need call dw_pcie_prog_outbound_atu(). EP and RC use
difference method to get outbound windows informaiton. So can't move it
into dw_pcie_prog_outbound_atu().

Frank
>
> Bjorn

