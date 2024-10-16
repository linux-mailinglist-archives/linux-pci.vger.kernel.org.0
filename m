Return-Path: <linux-pci+bounces-14660-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0346C9A0F7F
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 18:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFF28284CB7
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 16:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3831245008;
	Wed, 16 Oct 2024 16:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="f4KaJ1We"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011010.outbound.protection.outlook.com [52.101.70.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1293020E015;
	Wed, 16 Oct 2024 16:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729095637; cv=fail; b=ak0Y7CcFoCJut0DEuWmoU8xSMV6a5alMJSVjm9cPz5B3aWoFCGRim6S8YNJZ2hraeJa7qvK7QevpaNEId/UUX4N84JVvo4rAf8hNxPy6iC4iqCoZU6SkLqmn7cEEBW8AmBhU+X46yCRBX31dofUdZcd3+/fVKADGwLgDiCpcpIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729095637; c=relaxed/simple;
	bh=Y6T+Ygkilarz5KrHvAorX7vh7WPif8WFYE6G10KLWZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qv7Vd/yOngZdl68vKDGTIwEBdk2JLNwr9kXFoNpGbzDZ+Tn967kXmbJEGVDrSGdWZOaMA5js2zyPwUot3kP+LJRvCy/T0D491r+JXKt4DDIibizP3Hktw754hAao2RM0DKjapsrtXsesuhfnjpGM2nR9A4e6TtvcZ2D55dvacEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=f4KaJ1We; arc=fail smtp.client-ip=52.101.70.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQHqYS7qJyS9JfBGXuvdb0PAtt0gy2WrDIVAOnej2HgdSqHz6cCK4yodDOFzBu+draWzjuMpJBYxvQdOYxFLSQIu6bo6pluQIsIubX2ybBZoRGGZoAWLw6f0psIUpaLQa2J+ycE6uE3I1mblAZBETZwPXN/bFD4r6ZCa/RcXb4Gk7QGL1ik75CV84Lwh0ESk2Yk/ml8EdEbOmX3rXIiex8qoXWaQD/oaG3RB7wMiJs29ozGJMG3SCjcTA+zNGRcrucBLu2yjlRBbJlh+ftMqWjSgxB5tn0mcMQjvjHQDQAyc53i1TZ5tmPGROO7aYzHh41qnKjzNLdbg0fCQjDmiCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDcdDu9YJX1gAzaIYFQnVCt3XQrdkqp8dhdlpvCKKRk=;
 b=uPLpJGPjNDvrQmOIkMHTk5ddt6Rpfams9hZNdoJ/t00RB7qMWU2DduFYF6P9nVUJfINc4XLOpb1T21jRiORfvCdeAhv2k9Pil5/gw7vnNN9jJNQoYpN9Ok8WOhZQi4OIWJ+Ufperf7LLDZCohGMjgr+5qD3xtqlQT483FxasBxW6RP9FSnC3XPUiW7PqVvFqIZUwdByWmdBZo/G+s4CAzbgMoTV51wG1vjdkAFkjTxV0g+n1G1hrOgFIh0JSGCUPL5ZepBKbgxgyQ5xm1SOMSeErP82CPgcaKrl+d1w/bR5l0JWIDr/lNEPvyTmchqpVbhIOSwWw5cwHbslTi+wpqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDcdDu9YJX1gAzaIYFQnVCt3XQrdkqp8dhdlpvCKKRk=;
 b=f4KaJ1We4a6uo5GUCQl2zcnS4HG55f3nI/JDIkq9P3m/CaeBmz+mmodJQdtJdG4FCtIQZq+JAX5SO+Q0eYpwW7UgdiYdt/3ia61PnEQ2l+2JhcUwBZmEFIYdAzn6EPGm1Dckz2xChi2rO/WYZHlkIgb1E5SMaIYPEbTG5bJl3DNccBy0ZbVeD63RAR+B8Iyls0WQBUVS8/8zIQZOcJ1HdnmFSnLXUDBC5FoZtviyVjVdCEaig8yGB355KZdAyqC/ZlpxTZG1kWgqsPUByH83lALxUc2NSycfdZloOZud3XM/Dx0AFbrcQoTPrN9bJhTcHJ2/+4dxrlrMZmpz+FkeYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DU2PR04MB9145.eurprd04.prod.outlook.com (2603:10a6:10:2f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Wed, 16 Oct
 2024 16:20:31 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%3]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 16:20:31 +0000
Date: Wed, 16 Oct 2024 12:20:22 -0400
From: Frank Li <Frank.li@nxp.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [PATCH v2 0/4] PCI: ep: dwc/imx6: Add bus address support for
 PCI endpoint devices
Message-ID: <Zw/nxpGpETbILBXX@lizhi-Precision-Tower-5810>
References: <20240923-pcie_ep_range-v2-0-78d2ea434d9f@nxp.com>
 <ZwBPBSHnnz2e7YJK@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZwBPBSHnnz2e7YJK@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: SJ0PR13CA0027.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::32) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DU2PR04MB9145:EE_
X-MS-Office365-Filtering-Correlation-Id: 22bdd9e6-f3a1-43b7-ada5-08dcedfe74bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|366016|1800799024|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHNkR2Q4NnBmVk4wd3Y0M1N0NTZTakZ2TjFXOWQ1YWw5cTBTVlVMZHErdEtx?=
 =?utf-8?B?ZFNveFdsMndPajJDdmsrV1NaZWpwai8vVXpSR3h4TEw4ZjhFbUMxVTVyN2VI?=
 =?utf-8?B?ay9lQkxTWFJTTFVESXJBZC9KN0g1R2FpVFpkMG5mamtoT0ZGNytNaXZ4TzZ4?=
 =?utf-8?B?Y2g4cWlqTkdGejNocTBiekxQYjU5WDZHRURqMFE0WlJ4dFlKNWVpUkNsanBw?=
 =?utf-8?B?NXRlYmxvYU5ZN0FvZStWcnRzMHhQanpyNjBhSnZGSXJIcEhDYmVkcndCMFFa?=
 =?utf-8?B?b0JqYlIxSDFNMk83cTFLTlMyd283TmZSQ1Y4M2FBR0QySWwrSUFaRlIwUjJ3?=
 =?utf-8?B?Qk1WeXM5K21aN2RySkptdHZNVG1vem5SQzRmbXNuT2tkYVpCRWpJek9aamcv?=
 =?utf-8?B?MWtEZkdIV3FnekI2WDJBak04TXh1cVZNWXBnZVo0MlQ5ZWEyYzlpSXdaSGE3?=
 =?utf-8?B?LzBkbFlFZ1QreDBRUWZCQTh6eDNuTEtvVWMwUmVQZFRQZFh5NWdRNjVDYVFX?=
 =?utf-8?B?bnBQYkNVRVNqL3FXMUJNWDNVbkxNWThWT3BzaWhrSXd5VkRwaVQxZ29WalJr?=
 =?utf-8?B?bC9aUk9wQkRGSUdaMXFVS2h0QXhxZUtXbDVVS29EMG1uN2E5RkczMWR5a3ZR?=
 =?utf-8?B?SjA2WEhtdXBCc0tFR3JKK2tYNS9pZU51Mzd2Y3g3WUJKSll3ay9UWEFETFpG?=
 =?utf-8?B?UlJiUVYrOUViS3RoeHVubEY0cjM5bTFTbGxuMGdkemt2UHBST1hjcFQwazZV?=
 =?utf-8?B?aUFMSGZlaU4yMzRBSUlDa3g2bm56TlJraE5mZ0FUVnhNWjY0UTludUJFUnhW?=
 =?utf-8?B?U29wMS85d002SHdXS1lDTzVTekFOZ0dNcENPQkh1R0dLakZqL3dLY1Fka0Q4?=
 =?utf-8?B?Y0YrOWVkSXk3U2hGaGtZb2ozN1BWUms5QnZKd21RTy93QmhBcFRxOWVESS8r?=
 =?utf-8?B?dDVVc3JVRjZ2TXNrdC9EZWNzVkdJbWs4a0JUbUpkVnJsMkZKYXI2S2pEdmU1?=
 =?utf-8?B?d2VhaEorN05BNmpaOEt6cjZZdS9nUVIwd0IxejJjc0tSR0hGNTRQeUMydGdI?=
 =?utf-8?B?c1lTV0xiT2hWYkNtTUFUVGxPMU1rOUE5OXk2VGQ1S2tBcldDOXpjRHRLdUlh?=
 =?utf-8?B?WjA1TyswZUs0c0ZQZTZZZWJGbFB3NG84cmJkeFZhY0tHK1g0SkhhcGdVcVB6?=
 =?utf-8?B?Ukl2UjJVZ05MMm42RTVVWG8xNHZ5bmRCb3lXRFFieWRHeXRoMXNnUGNhMmxh?=
 =?utf-8?B?em91Y1FoWFRCemFqQW9xUXhCTFdtenduZXJhMTJiTXRDVm5aRStXRHRVOEx4?=
 =?utf-8?B?V3crRHloQnVBMVZkWlFHdTgwb0FCdEU0NWR5MWh0UFZGMmNNWnVMTERkLzda?=
 =?utf-8?B?cFd2TGRuNE5xWXhiL3BmWU9LSGRodW9CNjBkODhuNWlCOUlYWTI1R3FYZElE?=
 =?utf-8?B?YzBpUEJ0ZEpwbW1tYlZ0VDJCdU8zeG0vUE02OUpxNnlQUmorSVdjbUhpc2hN?=
 =?utf-8?B?ZEpRSHJMZENlM0IrSVhXVHBhNkdPck9HejM3bU4wY3FyaHNTZmdmTkxCaGVJ?=
 =?utf-8?B?WHpMY1ozeU9wREFNelowVzZreEM4RkxENCtJN04yeWxwQldLOTBEQXpLSVRr?=
 =?utf-8?B?SUxxVk4zbHN6QVAvcjBpVnllQ2dxZkROVFlMMDFOUmlUTU83TTZGSmlHM2xi?=
 =?utf-8?B?VmIzSTNETE0ycWRjQVNrTDlKN0owQVpDUks5OEF1aTJQMWlqMmxLYWNNaTI4?=
 =?utf-8?B?M2hkSHU0NlRLZXVIM1FUc1htaCszZTdpY0c2ZkpZYWlwZ2FpQWswRnVPRHBG?=
 =?utf-8?Q?NCI7LvVhBDJw56oNBzCv9sBWc1jKBCefirQ0I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(366016)(1800799024)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmlUcEROWUppU0pUYTk5aTJTTSsyL1RUbXMwQy9aT1NVMVFjenIrVlpHbzc5?=
 =?utf-8?B?TzErQW54ZUtOZmk4aWZXbDRyZ3ZJeTVLcUtXR2xaeDg3Y0F2RWRMSGFVcGk2?=
 =?utf-8?B?MDh2T0dBRHNzcklDaE5RNUJBQ1ZUZ3crdTdwMTJ1TjFyRWNTdEdWSUIxK3Jn?=
 =?utf-8?B?N2JEcU8vdkxsZHV0OVBaTGpidjlPNnVaUmNza1lGcUJuM1dyc3hBa1MxV3BH?=
 =?utf-8?B?Z285NHdmc2FjMHZiVzRHb1BvN1NRMHNOVXdhSTFLOEh2VkpXZHRsVzJWUWFo?=
 =?utf-8?B?cHZJejlDSUFNN2hvYXp2d2lhRXNvU3c2VHlpRm8vUCtOWnBuNlpIR2J5MUF6?=
 =?utf-8?B?MmRxNjZRWlpQUXpDTk5zOGlTZ1g1Y2pTaWJQTEJ6UlI4R0xuRTNZVmxjMUZs?=
 =?utf-8?B?NEpxSG5QbGcwdnUzK09Yc2FFa01wSDJ0b0F3cEpiTGEzRmZvSDdka3RSbHRW?=
 =?utf-8?B?OXVLMVBHVjhuRnZTRXpOL0d5bkpSNXdGZ2xrbzlaVzlMazlQeUFTYkw2ODRY?=
 =?utf-8?B?RzRkNFJUbzhJcy9rejVlbklBQUZUL1U4U3UwSi9IUXg3L0JSdjNXckFZVTNR?=
 =?utf-8?B?WStlT1N1a01sVWw0QnU1YWNWOVJ3VFRBUXkzcU1aSWpoZTg0MjZrbFN1RWhq?=
 =?utf-8?B?a0dyNkZ6MUFldTVOL0tWYm12Mjdac05saUJzTlB4cTJGazJtdTAyK2JSYUFy?=
 =?utf-8?B?VWlXcHdZUkx1WXhBanBoL0VwLy8zUXVmSkEzem1IbzduWnFVTjhOS09MOVFy?=
 =?utf-8?B?U2NjOHFiSU12WDI2TDZzeTI5aGllaVZ4b255SHRKS3FQU1MxeXhKbXVtcVl5?=
 =?utf-8?B?U2FqcFNwVlQrUHZPWERxRzdZK3JtdHpZam9hdHVWN1BjQno0aitCcE1XZWN5?=
 =?utf-8?B?TGpFOENWQjQ3VFpXV0V2V3ZUSUMwYmYxRzQ2VWVkVzljMmwvQWE5djZHWTM4?=
 =?utf-8?B?QkYrVHRONS8zK09pUk9DMDE3TlpMNmNXQnZiVVZGa0poOTlVVndXQzRiR1hH?=
 =?utf-8?B?RGRzdUg2MUd3ZnNOc2JPdFgxSnoxNUdkcFNZNWRrUDlEZzdMNDJiQmJlRE1w?=
 =?utf-8?B?Ykp1bEQwMHdicVVrQjF3WFpFWFIxaDZYbkpsVXRMOXlGY3RFYnhvaGtscWFZ?=
 =?utf-8?B?d1ZOTmtCd3Y5bTNreVNhRWFodWR0K1pWUFVvbmkySm5WazdXMEZLL0hVeGlT?=
 =?utf-8?B?cDVsWldTTkVVK1pObWs3ekIyZDRBc09sQzZXdDN2Snp5VTgvcnZPaXY4L051?=
 =?utf-8?B?YjFwVDg3VjRwMCtFZUpHbjNGU0JBdnZVVXliSlVGd3lZckFRSkp4LzNGb2Jq?=
 =?utf-8?B?Z0lvejQ5WXoxN1NOLzU0WWkrRzNRSkpMcTgwSU1lbWV6L0tQMjQ1djBnNjBm?=
 =?utf-8?B?VEhxVnVhcjdzOE5OY296UGVEVlBZMjVLVVhJSmRNbGNuWVY2MXJwTlNhVnFB?=
 =?utf-8?B?N0N4YWR0T0FEQzQxNjJlWWdzQlZJZ1Q5NXRnOEFQYURlMXlZSHlzU2V0c3BI?=
 =?utf-8?B?MlNaT0UzTmNkcDloQU9XS3BnTE5BMkkya0xjVzE1NEdWYXlQUDczZnc2Uk9u?=
 =?utf-8?B?c3JrN0lVVk85ZnhLZDFBbEdpcjJPYUxsajh5M3pjK2t5dnBFbDJwUUF0U0tj?=
 =?utf-8?B?K0VWZkRFcW5adDd3TlBKRVp3Y2NKbmFJNVlBZzRNMi8rZkUwejJXcmlkOFlQ?=
 =?utf-8?B?bTVaSkwwdDFlMU5uRURIRVpLSFZjN2xObWtPeDVsQmJ3QjFrSlZPWmczMHph?=
 =?utf-8?B?c1FscmoydkF0WU1CalB0QWpPbjlTcloyd2p0NDNzSVFBSTMwWHZWdUc2T3V6?=
 =?utf-8?B?THJSZ1A4Rm1PZVYvbnF3aCswOTQrc2ZKWmJxc2hZTjVzQ05sTVlrejJRY2Mz?=
 =?utf-8?B?RjhBcFQwemd6a1YwQ3RENFMxWUVLVnA0dlQrTnV6SHk5TVZiNkZUaEY0QWJL?=
 =?utf-8?B?d1VKMG1DbnRJU2o2TkpmSnVCZ0Rxa3JFMmpvTGNmd1BZcS9lMi9KOTJSMzFJ?=
 =?utf-8?B?R0JPZjFRWTluNHpuME96WnNzSjE2VzlmQWpTMXFIc2hKSmtLbHhGREhNV0o1?=
 =?utf-8?B?VUczODdtWDFGeHJDMEYxa29OR0xpaHFBME1UL0FVcnpDZmZjb0pkaGxTbVNw?=
 =?utf-8?Q?95nRfx4d4VhiKxSdwcaX5bS8Q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22bdd9e6-f3a1-43b7-ada5-08dcedfe74bb
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 16:20:31.7212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I7O0kYylOuZ9CxK3gvyQOfUajytntXzvD+6RWetrlTQR9aX97VjOlk7OdFzK69TagcuZ4dHlhsAUwFq+ZhsUSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9145

On Fri, Oct 04, 2024 at 04:24:37PM -0400, Frank Li wrote:
> On Mon, Sep 23, 2024 at 02:59:18PM -0400, Frank Li wrote:
> > Endpoint          Root complex
> >                              ┌───────┐        ┌─────────┐
> >                ┌─────┐       │ EP    │        │         │      ┌─────┐
> >                │     │       │ Ctrl  │        │         │      │ CPU │
> >                │ DDR │       │       │        │ ┌────┐  │      └──┬──┘
> >                │     │◄──────┼─ATU ◄─┼────────┼─┤BarN│◄─┼─────────┘
> >                │     │       │       │        │ └────┘  │ Outbound Transfer
> >                └─────┘       │       │        │         │
> >                              │       │        │         │
> >                              │       │        │         │
> >                              │       │        │         │ Inbound Transfer
> >                              │       │        │         │      ┌──▼──┐
> >               ┌───────┐      │       │        │ ┌───────┼─────►│DDR  │
> >               │       │ outbound Transfer*    │ │       │      └─────┘
> >    ┌─────┐    │ Bus   ┼─────►│ ATU  ─┬────────┼─┘       │
> >    │     │    │ Fabric│Bus   │       │ PCI Addr         │
> >    │ CPU ├───►│       │Addr  │       │ 0xA000_0000      │
> >    │     │CPU │       │0x8000_0000   │        │         │
> >    └─────┘Addr└───────┘      │       │        │         │
> >           0x7000_0000        └───────┘        └─────────┘
>
> Manivannan Sadhasivam:
>
> 	Do you have chance to review these patches?

Manivannan Sadhasivam:

	Do you have chance to review these patches?

Frank

>
> Frank
>
>
> >
> > Add `bus_addr_base` to configure the outbound window address for CPU write.
> > The BUS fabric generally passes the same address to the PCIe EP controller,
> > but some BUS fabrics convert the address before sending it to the PCIe EP
> > controller.
> >
> > Above diagram, CPU write data to outbound windows address 0x7000_0000,
> > Bus fabric convert it to 0x8000_0000. ATU should use BUS address
> > 0x8000_0000 as input address and convert to PCI address 0xA000_0000.
> >
> > Previously, `cpu_addr_fixup()` was used to handle address conversion. Now,
> > the device tree provides this information, preferring a common method.
> >
> > bus@5f000000 {
> > 	compatible = "simple-bus";
> > 	ranges = <0x5f000000 0x0 0x5f000000 0x21000000>,
> > 		 <0x80000000 0x0 0x70000000 0x10000000>;
> >
> > 	pcie-ep@5f010000 {
> > 		reg = <0x5f010000 0x00010000>,
> > 		      <0x80000000 0x10000000>;
> > 		reg-names = "dbi", "addr_space";
> > 		...
> > 	};
> > 	...
> > };
> >
> > 'ranges' in bus@5f000000 descript how address convert from CPU address
> > to BUS address.
> >
> > Use `of_property_read_reg()` to obtain the BUS address and set it to the
> > ATU correctly, eliminating the need for vendor-specific cpu_addr_fixup().
> >
> > The 1st patch implement above method in dwc common driver.
> > The 2nd patch update imx6's binding doc to add fsl,imx8q-pcie-ep.
> > The 3rd patch fix a pci-mx6's a bug
> > The 4th patch enable pci ep function.
> >
> > The imx8q's dts is usptreaming, the pcie-ep part is below.
> >
> > hsio_subsys: bus@5f000000 {
> >         compatible = "simple-bus";
> >         #address-cells = <1>;
> >         #size-cells = <1>;
> >         /* Only supports up to 32bits DMA, map all possible DDR as inbound ranges */
> >         dma-ranges = <0x80000000 0 0x80000000 0x80000000>;
> >         ranges = <0x5f000000 0x0 0x5f000000 0x21000000>,
> >                  <0x80000000 0x0 0x70000000 0x10000000>;
> >
> > 	pcieb_ep: pcie-ep@5f010000 {
> >                 compatible = "fsl,imx8q-pcie-ep";
> >                 reg = <0x5f010000 0x00010000>,
> >                       <0x80000000 0x10000000>;
> >                 reg-names = "dbi", "addr_space";
> >                 num-lanes = <1>;
> >                 interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
> >                 interrupt-names = "dma";
> >                 clocks = <&pcieb_lpcg IMX_LPCG_CLK_6>,
> >                          <&pcieb_lpcg IMX_LPCG_CLK_4>,
> >                          <&pcieb_lpcg IMX_LPCG_CLK_5>;
> >                 clock-names = "dbi", "mstr", "slv";
> >                 power-domains = <&pd IMX_SC_R_PCIE_B>;
> >                 fsl,max-link-speed = <3>;
> >                 num-ib-windows = <6>;
> >                 num-ob-windows = <6>;
> >         };
> > };
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Changes in v2:
> > - Totally rewrite with difference method. 'range' should in bus node
> > instead pcie-ep node because address convert happen at bus fabric. Needn't
> > add 'range' property at pci-ep node.
> > - Link to v1: https://lore.kernel.org/r/20240919-pcie_ep_range-v1-0-b3e9d62780b7@nxp.com
> >
> > ---
> > Frank Li (4):
> >       PCI: dwc: ep: Add bus_addr_base for outbound window
> >       dt-bindings: PCI: fsl,imx6q-pcie-ep: Add compatible string fsl,imx8q-pcie-ep
> >       PCI: imx6: Pass correct sub mode when calling phy_set_mode_ext()
> >       PCI: imx6: Add i.MX8Q PCIe Endpoint (EP) support
> >
> >  .../devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml | 38 +++++++++++++++++++++-
> >  drivers/pci/controller/dwc/pci-imx6.c              | 24 +++++++++++++-
> >  drivers/pci/controller/dwc/pcie-designware-ep.c    | 12 ++++++-
> >  drivers/pci/controller/dwc/pcie-designware.h       |  1 +
> >  4 files changed, 72 insertions(+), 3 deletions(-)
> > ---
> > base-commit: 4ed76e3b7438dd6e3d9b11d6a4cb853a350ec407
> > change-id: 20240918-pcie_ep_range-4c5c5e300e19
> >
> > Best regards,
> > ---
> > Frank Li <Frank.Li@nxp.com>
> >

