Return-Path: <linux-pci+bounces-39232-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC98C04397
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 05:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7FFC44F569A
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 03:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958002609C5;
	Fri, 24 Oct 2025 03:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="P7E6kpal"
X-Original-To: linux-pci@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013027.outbound.protection.outlook.com [52.101.83.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3571924BBEC
	for <linux-pci@vger.kernel.org>; Fri, 24 Oct 2025 03:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761275399; cv=fail; b=ACpI5gUJSokxuWjHC/sDAOGP8JwTxF39wmomkf7OXqdWiLneS56kH8F9bdkj0jaqcEBlrhcquUva0iuobofexW0+U7Llti874bh6K8YmH9Q1R6bUbihIMWCnNf2nfqVgPj9X9RvaBQSEdPLNvIKiGXoCOxqwqKtZ+hjvFU+Rh+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761275399; c=relaxed/simple;
	bh=Md7cQp2F7ZGxqJ1VDsAELMg5iHZ51rYrF9q0joYCJME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t9/pgS6vqCS4UthQSwIoEoETy1DKXFUH6hPmAPrm97/Jd95sPc4wxAok3rfU9ne3I5XzTKH82dgutNHQDeMAleQE1gAB5Z0RWv69/2qtYEy1MPwrJd9g0vT3A3S9URWhf5bEVgSUAhB8pwNRNUeM+geMdTxN0aBr8RY/yeVfT78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=P7E6kpal; arc=fail smtp.client-ip=52.101.83.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FIT9B3m4snFwHaoAg9HeSDpFl0NtPgp09b2yrhbTjdtwcfaanv1DzQU1SjfubqO1il+EsVQfQMNXdn0dCwwBFfGOD/pOIRsXHNxozO2mNJnPqdw93NGKFz6KGohjAtm1BM9Is/U96Zr4uXuPJKoEafBm7rKNXwI/rkFrY/JsY0RrkHDy5IC6eQdMLsexSUj7vIeDytGIDfhidqmxNt48nph4CEb221Yd9TC/R6WwW/11sH6FfUyKnhHKXko9AnZ/2lSzNn+//4iXn+TzuWDF8ieJTogDhImyRyjMDXhRHI9Us7jouxyUgCO99t91qt4Xz96euy5swBQ9IxEVbm7gdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lxwmJBb3/19ruQgQs8zNQ3ETdDFXe8uFNk96RNtT0/Q=;
 b=UFk+Ajf0mcdq1HGWS5w3L/ecyUdfvyKVG/rzm7ADOJEqOKSNntBm1NNH1uOOgbJm2dL8+IvoBwklvdZd/sFRtnkkWE9ySdFHuZIswMWCP9J4GqA5SiADMRJMvl/gtS/Wz13FRJkuDjplgGmys7zNyqg3Ki9ow3P3wkFWB2+E5vpEhjC6cOThO5QSUS98dAB0CEuZma3d1bEKdRWzndCgn5y7q5tNmWQ9cf2NdkZFdopyyovOV+BGY7aQc5ajB2ZB9Rv2Y047H+9Di1kA88oddPtr080Sq5KsGQfj8KNqkFHUR1LGSVb+d7M3jP7WW0PCB+uF2OBFrmIa74E4jKzYig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxwmJBb3/19ruQgQs8zNQ3ETdDFXe8uFNk96RNtT0/Q=;
 b=P7E6kpalcazcZQ0l0IDg7pH24iDCBL9uyrukTYGoGfTKQ2P7zGFGwIyDsSRtpr4jLlO40MlvNApkisvnPKjxxA1FB/d+xbWhg3Ui7Iu71BxlGPOeggE+uW73qD8nLlKUUXQVS1NQ6hAbv8EhD3BU5/ejzpu8+R0cZyPpoIS4UcXyjmmZ1tNloYSzwD2QHVePuJOT7LebUafBXcIEJZmBL5e+fLtWyKS0pFXqHDstmHnEsTzMJ77xoWGejM0cE4Q9zMPnbittNcNCdGj3R5Q+S/AM9XB21hz39mzhuGrm3l59MC/1OdqbAMQCTHDG7gd9EvWFT4PwRHDscZwD9GwMPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DU2PR04MB9020.eurprd04.prod.outlook.com (2603:10a6:10:2e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 03:09:54 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 03:09:53 +0000
Date: Thu, 23 Oct 2025 23:09:48 -0400
From: Frank Li <Frank.li@nxp.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-rockchip@lists.infradead.org,
	Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 1/2] PCI: dw-rockchip: Configure L1sub support
Message-ID: <aPrt/H4lF+DrF4Ej@lizhi-Precision-Tower-5810>
References: <1761187883-150120-1-git-send-email-shawn.lin@rock-chips.com>
 <aPpN2NX7IkAEU9Rh@lizhi-Precision-Tower-5810>
 <de9371a6-654c-4360-a34d-7f8a20848a6a@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de9371a6-654c-4360-a34d-7f8a20848a6a@rock-chips.com>
X-ClientProxiedBy: CH0PR04CA0075.namprd04.prod.outlook.com
 (2603:10b6:610:74::20) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DU2PR04MB9020:EE_
X-MS-Office365-Filtering-Correlation-Id: cb58eba2-1e7d-49b8-4f44-08de12aacda6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|376014|1800799024|13003099007|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ajVoZExEcC9QcXVYUkFEa0ZrQXA1V1MrMGZIWS9wL1MzQ0pQcFpWSWpaOG9n?=
 =?utf-8?B?QW1wdWUvWk05cU5SYTdwN1F5WjM4czBScjBvRXVPVWNCcnF0ODQ0eFZaQmto?=
 =?utf-8?B?d2Z5OWlnOTd5QzRVY20zMEJ3aDdwSzdmN3J0M2Q4aGxLTU50STJPdWlZQTgr?=
 =?utf-8?B?eTBiVGNZNkoraWVJazFHRThWSmtTVHZkRGlxVFoxbHFRQVNFMjVHb05BTzcv?=
 =?utf-8?B?WkozWDZuM0FBdy9KS1U4Qk4rb2FFd3graDNVNWtZR3BrMGk5aWh5T0lCNXJ3?=
 =?utf-8?B?YlFNbDJXbm1janovNnBPdUd5NXZMaE95ekk2RjR0TDdjVlVNNVMrSGZYZEdP?=
 =?utf-8?B?SW1TeWpCUVErSDE2VUdvWXJzaDh6aEE5Qkt5cUhSMkQvYllRWFlueXNWaE05?=
 =?utf-8?B?YUV0bnpITzRieW85dTNHZ21ITDMwOEJ3ZTZaNTErSEhSQi8zSzBGeVNDOW4x?=
 =?utf-8?B?aDhTM1Nid3dyMG5mVmI4b1h5SnkyY2lidHpzTVdWUStPL3FHLzkzSW84dHlz?=
 =?utf-8?B?d2dCWFVORXJQSzVXdW12ZjI0dmNuU2NTR3F1SUpEYlFXWWQ0REhIeDJJZjVC?=
 =?utf-8?B?LzMvQzdUSnZsWVgwYXFvelU3L0FZNlI4QU04WmIyZ21NRnMzMGR6VlFDVHZN?=
 =?utf-8?B?WFZvZlVMYWlVWkFpbWNWTkdXL1B4cDFyVlZTa1UwV2VJdjF1emYyNU53citL?=
 =?utf-8?B?Q21DY0k3aERWejBHMmFadnhmMDJpSHNDSEZDKzc4elpMNzNOblU3TnM5ektx?=
 =?utf-8?B?REpFbWZocXA3bDlVSy9RdVV6Zi83bnB6ajZCZWtKOXNOWVBESVFmKzJnMk9k?=
 =?utf-8?B?RGhaTWFYL29QdnNqSGI0dE50UXNVSWlEMFB4MldpR1gxT01aTmxNSkdOc1Z5?=
 =?utf-8?B?MjZYSmd0dTZpQkxlYWoyQithc2NteTg3MURnMzMzZ1Y1UnJqMXdUcXVNazFU?=
 =?utf-8?B?NktERmdqSHUxU0s4aHBTalA3MTFWcEwwWTIreUhwcDVBTWFQb2hIN0thUnRK?=
 =?utf-8?B?SUp3SkZwMXZ2NkVNYTdGcWZYQ21uYmRQOE9vNWZQMmxkVWY0TXI1eUFBM3VG?=
 =?utf-8?B?bEcxeWlTV2UxZ2FPRGd4YkdrZmJmUjlhNWRQbmdwcTVvc243aEtjS0tROURh?=
 =?utf-8?B?KzZiVDBnZGxIKys3bWJsYW9JZU4xQXdRWXQ4SmtKNTdPN1J6bG5LMGJXcW9n?=
 =?utf-8?B?RnVSVVZ0YWpjelpwMzRCNHdYUWNZUzVLSWFoUEw5eld2Uzgvd3BaSithYzNx?=
 =?utf-8?B?b0s4aCsrOHFrTU81aVREQVc0SXZQd2lJbVB2cXQwRlZ6NGVvUW52Z1JpUXA0?=
 =?utf-8?B?N0c2bm9xY29VRm1yNllYREJ3WWduK1QyaFdINXVRQnVKOU9FOXkrMFRzeCtz?=
 =?utf-8?B?b3cvS0xFZnNJNjhZQkRyY1U3WVh1MStxOVpla1Y2U0tBL2lOS0R5K3NSd1FW?=
 =?utf-8?B?RUcva2JvVVlLbXJCM2MxS3VOVWpkOU5yOE9zL2FPRDI0YmJRWnhiT3ZBZHRE?=
 =?utf-8?B?RjRGb05VeWVqZ1RqVURkTFIrWjlZNi9xV1ROSnB1OUJDTXBZOWtCdFM5VExq?=
 =?utf-8?B?S2IxeXR1dmp2dHJsVkRCSUpDQTRkKzNxeFJld2J5bjQxc1pXdFNFdS9tZG5k?=
 =?utf-8?B?YnJ4S21ubE05ZTd0SmFrbFpXTjI2SHMya2kvVG50eCtUSHVzQlgvVFc4bndk?=
 =?utf-8?B?UGcyandWamFZUUVwVngvSEkxZ3ZScWR5b2FHYjYxK2UySUNiK1ZHZEVRODhC?=
 =?utf-8?B?bE5rSGk2RkgzS2JxU053a0NuTE1hSU5icDNTd1BkQkFoZHdoNUF0YkRmbHln?=
 =?utf-8?B?cCtjeVIxSzdFbnRlYyt1OTRPT3YyVi92bE5rSGNPdHdlREk4QmZKdEJiVnNY?=
 =?utf-8?B?ekErYkdDdWFQWnlpTzJxVlhBVGtXbDMyS0Z1SmxCd1pUK2dOS0Z6Vmc4YlBm?=
 =?utf-8?B?OE84eUpicDY1Umkxdms2Q2JMcW4wdEpmclFmUjN4OFk3TU4yR2pKZ1Awc1FB?=
 =?utf-8?B?Q2JvZ3lCeEFHdzMrZWpxd3JnQm9RQnNKZXlJVTgvQTkzYWhxYk14MzRZMEVO?=
 =?utf-8?Q?Mz1VBv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(376014)(1800799024)(13003099007)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUdnYmhJTzMvRmVORU02ZTFsLytvalFFYjRLUSs2NXpTTmtJKy82d2MyV2VR?=
 =?utf-8?B?NXduM0p1T3ZrU1c5UXVtZzlPOU1jNjdDSGdXUTQ4dWF4dzIxa3UvUnYyU1Z2?=
 =?utf-8?B?MldEcGJBTHZoeXJ6NGUwMExxN3ByOE1QVjBCWGpubGl4RkNrdzZZYlJFVnRN?=
 =?utf-8?B?KzNxWHk4czRYQy9zL0piUitXU0lmaW91MTZjQWhYcmVOOEVPKytXMGJHNHNG?=
 =?utf-8?B?RXB2Rmt1d0tUOFA5U28yS29MZVFYbHh3R2dCYTNTTVUway9aSHE2ZFIvRWFL?=
 =?utf-8?B?TW5qTXJ2QTR2STdlaWdrRzkzZHhXWFFrbU1wREdrQU1yWERScHZDWmdBbS9a?=
 =?utf-8?B?cWM0VG1DaG8vN3R3L0k1ZCtSTVJwZmhWRnY5R2dtckxZMjdxL2pjWnhwalVn?=
 =?utf-8?B?Y0VKUnk2SmNqT0FnUStIOG9xVGhkREZDMUMwck54anozYm9VL2lBc05TSmdt?=
 =?utf-8?B?ZFpwTFlZRGFVKzJTMWNVQUtNYWJER1dtVS9KTnMzUnV3Z1I4eWhuUndpN2dl?=
 =?utf-8?B?Z0RLdkV3MTBpMi96VHBZNFdpa0RRVVJvbWEyVTZxQ1pmY083WkhPNU5nUEN2?=
 =?utf-8?B?MDVwNEM5RzgxRkF4VjkxendUWDF0eXl1TTVobnlvUTRIVG5uVi9GaGlKUkV1?=
 =?utf-8?B?UytSU2xJWHMyU0RuN1hRdjBQZDI5Q3VUQlNDenZYdGFOcXljZlJwQWFLb0hY?=
 =?utf-8?B?MmdjZjUxeXJJNnh1Y05XT2IySTlWbW4rVlhQbnQ2d1VRdHZtcFZZbzN2UExa?=
 =?utf-8?B?aUZXQkViell6U0NzWUUxMnlCSTZseEtySHVaa3k0YTFSNW4rYlNqTXRCYVlQ?=
 =?utf-8?B?WWdQUkdJOHpDZHdmY0MzNHZUMEtRZDNOSHkxcjB6eUJ6VkJFcndDVFZUeWFi?=
 =?utf-8?B?akxHV1NwTmtUTFl1NE1LVUVyWTNYSTJxTHArN1Q1Y2t0L0dpUXgrWld0c2ZS?=
 =?utf-8?B?QWlEZ1YwN1hxdFVtSk81bExXdTFFZjd2MVJWVU1icWRIZk9Za29JcWJwZktI?=
 =?utf-8?B?cUZrZks3bjN4YldQSjVrQ3U0d0hQeFJzemZWS3pIRTMzdnhyUmtxcCtKNHFz?=
 =?utf-8?B?RVUwZlhhWURLMzhBZUY1eHEyRHB5WTlvaWl0QldpRmlpWk9NT0VhSC9UR1Ew?=
 =?utf-8?B?T05LMG9NdjNiNVNWTnRkVXVoNEltTGlnY3MxeHVGclV2ZUxjR3JQQlUzZUVy?=
 =?utf-8?B?RStEb1BXU0F5L210eTZ6Z29RdnE2c3VCMmpIeTBpRklLWWR2RGFibE1oaXFm?=
 =?utf-8?B?M1JDNk1YY3FrY3hBZkROZW94dzJvdnlqMVN1eUo3dEg5aFRiVm83TnBSVU1x?=
 =?utf-8?B?MThZb3h1d2M4bjJ1NEJJbzVRWGpxYmhYelRxd082U3I3Y1hJU2xSQU41V2hv?=
 =?utf-8?B?cFZwUkV4Q1NmcW94Q0lobmRwUTJLblNxOTRPM3I0emkxeG5YMlc4UkdqQ3VZ?=
 =?utf-8?B?VXc3bTA4NzhGWEFZbktJazQyVnhLN2I5NnRubnV0ckRUT0k0aXc5Uzg1d2Nh?=
 =?utf-8?B?Nm9RQVdSNndCRU1JaEZLZHVwTGwwKzJvSVg1MFF2VXZHY0ZBUU1FRjlReTRV?=
 =?utf-8?B?amsxeWZuUFpuVDVJSmlCeHJjWG9STWFCMENTZDVuRldQbnpOcXdjUzR3RDN2?=
 =?utf-8?B?QitsbDRQai9VMXl5cjhEUnlDbEtQcW1tVnhDQUxrSnhYemlReU9jZTFJNTdD?=
 =?utf-8?B?TVM2bXBNbmJaY2FibmVLeUhhOUJLTGdkY2hsVGF3dkNCNW1XOTNkc21kMFRD?=
 =?utf-8?B?cW5KaUNBT0FreS9kQ3phUnY4SnNqSHlrUnNwcjU1YW9uSXlhdk0razJnYkIy?=
 =?utf-8?B?Vnc2WkhnQUUrcmFPUW1xd2g0OVRBT2Y3RmlsRnpxcVJzWHJ0alhHOWR0Zmww?=
 =?utf-8?B?TElXdVZ6UFMxT2RJTUREbVRLS0sxUWRUQ2dsN0pReXV0STFkNGp5QStYVGFt?=
 =?utf-8?B?dHdJMmVBcGZyRGIyN3JzOGhhQW1YWnJjMEdRTFNmMTgzN1ZnNk9KbVlIaWgy?=
 =?utf-8?B?VC8wWWpMYmxVOWJRckNJOWgzS0R4eFFOeGVONXkybDFMREhubDUxMzBmVnpr?=
 =?utf-8?B?U25iVFdiVWU0aW9FWWxHbmYvcjU4SGszZm9iNXJHeVR6ZXl1U2R1eERXMWRG?=
 =?utf-8?Q?J+54=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb58eba2-1e7d-49b8-4f44-08de12aacda6
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 03:09:53.8499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NCopjBhnlDXMlwMvTwzX2O/eJuNG+6Zdm9P202QrtVlUVa7OG2xZKFmvAI9uK91Y0ysOUuZyauoeF+zP0soqxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9020

On Fri, Oct 24, 2025 at 08:43:28AM +0800, Shawn Lin wrote:
> 在 2025/10/23 星期四 23:46, Frank Li 写道:
> > On Thu, Oct 23, 2025 at 10:51:22AM +0800, Shawn Lin wrote:
> > > L1 PM Substates for RC mode require support in the dw-rockchip driver
> > > including proper handling of the CLKREQ# sideband signal. It is mostly
> > > handled by hardware, but software still needs to set the clkreq fields
> > > in the PCIE_CLIENT_POWER_CON register to match the hardware implementation.
> > >
> > > For more details, see section '18.6.6.4 L1 Substate' in the RK3658 TRM 1.1
> > > Part 2, or section '11.6.6.4 L1 Substate' in the RK3588 TRM 1.0 Part2.
> > >
> > > Meanwhile, for the EP mode, we haven't prepared enough to actually support
> > > L1 PM Substates yet. So disable it now until proper support is added later.
> > >
> > > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> > >
> > > ---
> > >
> > > Changes in v3:
> > > - rephrease the changelog
> > > - use FIELD_PREP_WM16
> > > - rename to rockchip_pcie_configure_l1sub
> > > - disable L1ss for EP mode
> > >
> > > Changes in v2:
> > > - drop of_pci_clkreq_presnt API
> > > - drop dependency of Niklas's patch
> > >
> > >   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 43 +++++++++++++++++++++++++++
> > >   1 file changed, 43 insertions(+)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > > index 3e2752c..25d2474 100644
> > > --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > > +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > > @@ -62,6 +62,12 @@
> > >   /* Interrupt Mask Register Related to Miscellaneous Operation */
> > >   #define PCIE_CLIENT_INTR_MASK_MISC	0x24
> > >
> > > +/* Power Management Control Register */
> > > +#define PCIE_CLIENT_POWER_CON		0x2c
> > > +#define  PCIE_CLKREQ_READY		FIELD_PREP_WM16(BIT(0), 1)
> > > +#define  PCIE_CLKREQ_NOT_READY		FIELD_PREP_WM16(BIT(0), 0)
> > > +#define  PCIE_CLKREQ_PULL_DOWN		FIELD_PREP_WM16(GENMASK(13, 12), 1)
> > > +
> > >   /* Hot Reset Control Register */
> > >   #define PCIE_CLIENT_HOT_RESET_CTRL	0x180
> > >   #define  PCIE_LTSSM_APP_DLY2_EN		BIT(1)
> > > @@ -85,6 +91,7 @@ struct rockchip_pcie {
> > >   	struct regulator *vpcie3v3;
> > >   	struct irq_domain *irq_domain;
> > >   	const struct rockchip_pcie_of_data *data;
> > > +	bool supports_clkreq;
> > >   };
> > >
> > >   struct rockchip_pcie_of_data {
> > > @@ -200,6 +207,37 @@ static bool rockchip_pcie_link_up(struct dw_pcie *pci)
> > >   	return FIELD_GET(PCIE_LINKUP_MASK, val) == PCIE_LINKUP;
> > >   }
> > >
> > > +/*
> > > + * See e.g. section '11.6.6.4 L1 Substate' in the RK3588 TRM V1.0 for the steps
> > > + * needed to support L1 substates. Currently, just enable L1 substates for RC
> > > + * mode if CLKREQ# is properly connected and supports-clkreq is present in DT.
> > > + * For EP mode, there are more things should be done to actually save power in
> > > + * L1 substates, so disable L1 substates until there is proper support.
> > > + */
> > > +static void rockchip_pcie_configure_l1sub(struct dw_pcie *pci)
> > > +{
> > > +	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
> > > +	u32 cap, l1subcap;
> > > +
> > > +	/* Enable L1 substates if CLKREQ# is properly connected */
> > > +	if (rockchip->supports_clkreq && rockchip->data->mode == DW_PCIE_RC_TYPE ) {
> > > +		rockchip_pcie_writel_apb(rockchip, PCIE_CLKREQ_READY, PCIE_CLIENT_POWER_CON);
> > > +		return;
> > > +	}
> > > +
> > > +	/* Otherwise, pull down CLKREQ# and disable L1 PM substates */
> > > +	rockchip_pcie_writel_apb(rockchip, PCIE_CLKREQ_PULL_DOWN | PCIE_CLKREQ_NOT_READY,
> > > +				 PCIE_CLIENT_POWER_CON);
> >
> > Looks like you force pull down clkreq should be enough, needn't disable
> > L1SS. when RC force clkreq is low, Ref CLK always on even if L1SS enabled.
> >
> > Of course it depend on hardware implementation, But I think FULL_DOWN have
> > high priority to force clkreq to low then PCI_L1SS control.
> >
>
> Hi Frank,
>
> Thanks for your review. TBH, the basic idea here I think is not to
> advertise a capability if the HW as whole hasn't been well prepared to
> support it yet. So I'd prefer to keep it as-is.
>

If that, I prefer do it at dwc common driver or provide helper function to
avoid other vendor to copy same logic.

Frank

> > Frank
> >
> > > +	cap = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_L1SS);
> > > +	if (cap) {
> > > +		l1subcap = dw_pcie_readl_dbi(pci, cap + PCI_L1SS_CAP);
> > > +		l1subcap &= ~(PCI_L1SS_CAP_L1_PM_SS | PCI_L1SS_CAP_ASPM_L1_1 |
> > > +			      PCI_L1SS_CAP_ASPM_L1_2 | PCI_L1SS_CAP_PCIPM_L1_1 |
> > > +			      PCI_L1SS_CAP_PCIPM_L1_2);
> > > +		dw_pcie_writel_dbi(pci, cap + PCI_L1SS_CAP, l1subcap);
> > > +	}
> > > +}
> > > +
> > >   static void rockchip_pcie_enable_l0s(struct dw_pcie *pci)
> > >   {
> > >   	u32 cap, lnkcap;
> > > @@ -264,6 +302,7 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
> > >   	irq_set_chained_handler_and_data(irq, rockchip_pcie_intx_handler,
> > >   					 rockchip);
> > >
> > > +	rockchip_pcie_configure_l1sub(pci);
> > >   	rockchip_pcie_enable_l0s(pci);
> > >
> > >   	return 0;
> > > @@ -301,6 +340,7 @@ static void rockchip_pcie_ep_init(struct dw_pcie_ep *ep)
> > >   	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > >   	enum pci_barno bar;
> > >
> > > +	rockchip_pcie_configure_l1sub(pci);
> > >   	rockchip_pcie_enable_l0s(pci);
> > >   	rockchip_pcie_ep_hide_broken_ats_cap_rk3588(ep);
> > >
> > > @@ -412,6 +452,9 @@ static int rockchip_pcie_resource_get(struct platform_device *pdev,
> > >   		return dev_err_probe(&pdev->dev, PTR_ERR(rockchip->rst),
> > >   				     "failed to get reset lines\n");
> > >
> > > +	rockchip->supports_clkreq = of_property_read_bool(pdev->dev.of_node,
> > > +							  "supports-clkreq");
> > > +
> > >   	return 0;
> > >   }
> > >
> > > --
> > > 2.7.4
> > >
> > >
> > > _______________________________________________
> > > Linux-rockchip mailing list
> > > Linux-rockchip@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-rockchip
> >
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

