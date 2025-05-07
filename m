Return-Path: <linux-pci+bounces-27393-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AEFAAE90A
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 20:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 995344E2A9F
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 18:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B597428DF41;
	Wed,  7 May 2025 18:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BpK94+vx"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D185728DF1B;
	Wed,  7 May 2025 18:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746642525; cv=fail; b=hg10sAYo5xa8+5g7H4ExZkSmnkiLgZ3MO+a56053/JOV4c78HM1KWUjyaCXGrAhu0W7XtCsdOD/OIyu7/d7D+raOYDpOKPDuua+QE6GPCXAfrx3/79d8cFpgetjF1w41lNBxUm36u7Q7Q5dFOlh6S2TaKiUrI9FEDfOBIScE44o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746642525; c=relaxed/simple;
	bh=GrYKKKi7sXldNz6XT99oBEVQNiPHaIuFqByLDt1c9a4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E4ZEBdzJd+Zcf4MwfpCu7sgjKVAdLn8CORFshhCoAu/dtLx2uu4NTIedmd0PbFVQn3KsELmaHljt0qVJ5XhCt8BOL8IV9yqs9xjc7E357PXwK86mXjYEWYW58DjmMDljhR1MFefpwBZkI4ShPwwb4QdqWhexZDMdnINHSbTkXEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BpK94+vx; arc=fail smtp.client-ip=40.107.93.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=soUiFUSWv+F1oYxXwNjhIRTwH08B4cc4zRi5qNoiiOAjYQpJZK3aoGVtG6Jpc2miRrUc007iuhc71B7fhz8CW4E+GWE+f6dQPMdX6LOPF+em+gLaeAd4SmwXydjzsvDzGuGK+LlFzlUbnrIKL2yPF1B6S8OLmV3jwoZPrN8chPO4dPqjM96rAtb+8eQV6WRmJdPKzWtCGIjBiLGZoYQwhXFLyggoc7SynCrpFCD6RbtYcIsnpmBB5GyVegtXVKjWLsOGwRsjPRiro6rYHxIc08IZtYyUPpIvkD4QkDZ6H0ZJ5d3K3EV79CQEH+7qcIZyrSnxJnddO3GB9K5907rP6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GrYKKKi7sXldNz6XT99oBEVQNiPHaIuFqByLDt1c9a4=;
 b=o5XFuc5USem33kziT/OQdvtq4xoB1BhY6bZN2gY+blz9yA0OMaBVRMXBY7VAk7oFiQ+SnrRnIINLLbVyP+a/QGlcIEllI2mMTdiTpbGJP8CVgB/H7qxhXWjXSJXZtnyY/DGVR9nKVyJR/BUS6iK7Kx2Db5qT8Uk/QGsTyBf7GM1Ay8nFtZROvG2VSEmUm7H4d3HusOgK/22YC04Q+El/E+mDSU9u/ZWFuMYZYDisrg1f3ORf7TsqYhnTVgRASZ02NX6ZRbK7aLx0JyitBjaYxzRSmM5T6rzxlEQRqDVX9GPE0xl7FdFwumHt75uuFbs9bNWUV4cy+N+TYd3YokfNqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrYKKKi7sXldNz6XT99oBEVQNiPHaIuFqByLDt1c9a4=;
 b=BpK94+vxbbxYqII+bm+H6jCdZXZayR8lgeqoKSShLFRHhTYNGViVXzjDWfIYs5CwiN9bfYiVvISOeiyHhSLCAMXCTfbtbNptsioyeO+nQUmJyjb14Dq3y7cqvRNqRuewQVm0CKXunWeDoSf6p7cKHORvuMDK7FAKNfgM2agsMKs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 CY5PR12MB6106.namprd12.prod.outlook.com (2603:10b6:930:29::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.26; Wed, 7 May 2025 18:28:37 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8699.019; Wed, 7 May 2025
 18:28:36 +0000
Message-ID: <003143c8-6dd2-4484-a641-7418f686c388@amd.com>
Date: Wed, 7 May 2025 13:28:32 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/16] Enable CXL PCIe port protocol error handling and
 logging
To: Gregory Price <gourry@gourry.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
References: <20250327014717.2988633-1-terry.bowman@amd.com>
 <aBqV9UCF6dQFtcyP@gourry-fedora-PF4VCD3F>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <aBqV9UCF6dQFtcyP@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0230.namprd04.prod.outlook.com
 (2603:10b6:806:127::25) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|CY5PR12MB6106:EE_
X-MS-Office365-Filtering-Correlation-Id: 759821dc-c870-4c76-ab8f-08dd8d94fb34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c1A0c2FFcnJVMi9tYjdVNVNSMDNpQWpuMklEU1ZwcEZBMEVnVFVid1hyYlFK?=
 =?utf-8?B?bEJYWnBJN0VUMWg3L01TT3lMSnJaTjNVWjhxWk9RTkk5ZFphd1VQNFpqWTJt?=
 =?utf-8?B?ZUVCbkJwZFppUWQvVnZkSGJYT3cyWHBEUzJHbTVKNVlNYXVVTFcvQkJONTZK?=
 =?utf-8?B?RTRqWDZnV2RWR3Q3OVpMNUZZaU1HL0Y1UkdPNnFQaVVVL1FXYTlVWVlSV20w?=
 =?utf-8?B?L01OcW0vU2llK0hycEl3NVZUUlJpa0RHTTlFc1dNQ1FSL2FRczhPVEdXb0tp?=
 =?utf-8?B?TStxRmZQWTlYNEZDcjYrRlFOUnNEZXdQWWtRYjhsY0FoZm5wM3BJVmhpRjR1?=
 =?utf-8?B?UUR4UFBsTTRQZ1paQTNtY3NtZUtaUlBMak9WSVFVejROZ0xpMnByMXBCcTF2?=
 =?utf-8?B?OXY0M0txYzdHc2srb3dXekJjejRYZjdqb3Q5TWtSM2Z5RnBHRnRlSy90N200?=
 =?utf-8?B?bU1IaWg2L21rSGRiaG51SkhpTSs2eEp4aVc3OFNnR0ZwWmZsSWtuVXdac3h0?=
 =?utf-8?B?Q3cyOUhSOEYzV09HVHFDdlpvK3lTRnEwbVlpcHVORVNxYzJYYVlVZHJsNkxU?=
 =?utf-8?B?bVVoOXVNbnpnUU41OFIvblJVdDNQWG1YaHdGazdFZUtDQkdUSC9zUmZrdzRn?=
 =?utf-8?B?QXJOaFkvTitSR2Z1SkoyQVN2QmxwbUVkM0RWV1FxMUR3ODgyTlgrWWhJWmNK?=
 =?utf-8?B?citINkJpSnczTHowaG81RUdHa0pCVHFoM3RUQ0kzdGVnT3NBc1hjK2pPMFZs?=
 =?utf-8?B?WEdveGhTajVkYnc3UHRNKzNPK3N4UjZFRTFLMTlJZzlqSmljVjZPS3QwOHRU?=
 =?utf-8?B?dzZaY2k3YXRjRzN4azNzQ1h2TXdHZkthSFFzdE1OKytJWmNFUkFjeG9TaXVh?=
 =?utf-8?B?QjVDTk96T0JoeXIveS9McEJueW5Ua3h4b0dZaFpqamNuTzR3T0Q1WG5kWUtV?=
 =?utf-8?B?STdoei8wdDV1K2RPdWNBaWtDZ0hIMVUxcWE4eTVGR053cWVIQnBDeTNqK09a?=
 =?utf-8?B?VHBQc01IdFpZamFha3ZCaCtnVzRubkFLZnIvM255ajFtY2oxSnNlN2N3SVB5?=
 =?utf-8?B?WmQrRVVJUnNmNGVmTVZZLzBZV0NvNFl5RksyVmhsTnVoeTJkejBuMDdWMGhD?=
 =?utf-8?B?MGIrT3NXK0ovb3AzUUtGeFV0WlJwMUpZM3NNREFoMEs4Mm9LOXRyQkt4U212?=
 =?utf-8?B?b2lBck5OMVdNZGYyRllqcmE2cDFGVXlxSUd6eVJLMnhZR0lyTmFncElLUFZa?=
 =?utf-8?B?YnM4Uzg1andSMUdlN0wzNGtrblZVVE5WZzNhd2JtU09qVEFHRUIrSlhmZlRj?=
 =?utf-8?B?YndkRXZIaGU2MldjYm9SWlk0OGdVc0pZNDRWRUxwamdiYkJZWHdSKytJR21s?=
 =?utf-8?B?d1VZeHptVnBrU0xrVGt3RWdWbC9kdEo1dnZSZ1k1UklHZy9ZVjI5cDFiTExE?=
 =?utf-8?B?M0VJK29TcElsbTFhdCtWQTZuRktheFo5QWN1K3hVVnRQMithbHlkdWhQS2Fx?=
 =?utf-8?B?bVpERmNDTlZnZjZ4WEVzUWR0TnFwZGpiMjJkOVhJQUpqYkJ4czc3QVVmc3d1?=
 =?utf-8?B?WDFCY1I5V0xyYXl4SmxIenBGQm1XeEVFMC9mcVhGWVJ1YzZxYUhiS1FSMDhU?=
 =?utf-8?B?QU16akFjSzNlRlhRSEdkM2RJRUFhc1RUcUdDYkRSWmFPKzk0OTd3ZWFFSGFQ?=
 =?utf-8?B?T2tmNjUraEFweCtrQ3JkTWhyTnZZZWFZcXpDWS81enNlWS9OaGsrMFZmRXVz?=
 =?utf-8?B?bEFWYncwbWZ0TTFLZzR2QnRtV2ZTUDlNbEpkUHl2NWphVmhQZ054bXZINWdL?=
 =?utf-8?B?RFZyVG9CQnpXODFNTzV0QnI2MFcrUm5PeXhzU3FuRHZpYkFjK3RZMEF1Z3FB?=
 =?utf-8?B?MFhxdCtrRmpVZFRoRmdWbk9tUjdvNFJrdEJwUHMvSUE4UjZGUmtBUVkvWFIv?=
 =?utf-8?Q?gwnkAft6Bmo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXIwRnFEQzl6a3drblpmTjVwSU5wb1RkNWZyMWM5NHd6ZGxkUUFCQTBQeUpZ?=
 =?utf-8?B?ZlJpbUt6YXdiWXpmUDVKUG01SktzVThYTzJQV1NuYlFnWGRzNnR5eGxrYUhz?=
 =?utf-8?B?azRqdkdWQUxyU3lFZGJGblN1UkpZK0dFQVIyY042ZWhGdXVubDJ4dVZvait6?=
 =?utf-8?B?akorRzRuT2gxYk16S2doTDhuTnJyUE5YdDVQUlUwV1JicjY1czZOUkVMdm9l?=
 =?utf-8?B?OFhqL0Q5bzFsNFZPM3BEVlA3NlRNazFldFloYkVsVU5ZSk1HS3cvd0IwOXd3?=
 =?utf-8?B?U1pPNG0ycjZqVHBIUEFsQnBhZmdBRzhzWnNYWXowbWcvV2crMEdVNkIrSUtG?=
 =?utf-8?B?djYxRkxmL2paY2wwNTlHSE1HYzVEMTB2WitvZXhSYm5SRzlscDlYQkVaS094?=
 =?utf-8?B?cGlRYkZyNlg0U25CMnBHUzBOUE1ZT2JVSDM3TUJTV0hhNHpLeWlLcDd2Z2xL?=
 =?utf-8?B?YVRsVTVYek9TTXlqQkw5SG1rUHdNVHVyYmFsV1k1cFBaTUhuSFh3VWRTUjRE?=
 =?utf-8?B?YTBER1dNelppb2NyN2xHTENxQVdYVVk4bC8vRWhVTEJIdXpIMHE1VVZlVVVi?=
 =?utf-8?B?VnRxRGxsZHBzcnBKWjJYa2hzT3JkRG01VWVzdGFmREErdXNwd0lkWlpiZHJZ?=
 =?utf-8?B?ckQ2eS81QStpWmhqVE54WC9zWXhmOHpCQ2ZHc1doWlpwRzFrN1ErcEl3OUhk?=
 =?utf-8?B?RGo0eGxxbUxlOHJwZCtOZHJWNTNpdTh1cU54QWZDZXhldWYyS0x0WFJHcUR3?=
 =?utf-8?B?TlY1blRmUlVDTXdod3JHU210Z0ZzSncrQ2FJdjR1bHdqSXJDdTVoWDhSVS9R?=
 =?utf-8?B?WVV6ckRyZkNlYVExRzI1dHdmT05rblozdGtsc09ycm5YWFJQU0ZBNURmVldo?=
 =?utf-8?B?SUdwQWRyL3lsaDdrUFFJNjBabWRRTHlUcFhCZGVMYkR1TkxrV21vNGEyRFBN?=
 =?utf-8?B?RENJQUlGL2tRWGZWY1RyVmFSbDFwYi8wZnBLMk1ERGh2anNLeVNGTFFHVDdm?=
 =?utf-8?B?eGFzcTg0dnpMajBpNlJNaWM5SFBMUWJtRXIzN0ZBNmhyVWoyakloUTh1Q25F?=
 =?utf-8?B?aHhsWjJESTVZL0dBa1VOTDBXYVlDbmQzd2UyczFocy9JV2ozNU1vK1R0ckFL?=
 =?utf-8?B?ZnU2MUFNYkc4WTBqTG9ISU4zaUNPcnlIUHZGVXhaUDhvZVhaSWJxRVBna1RJ?=
 =?utf-8?B?ZTdhV1cyb1hLTEFrTlRrVGZueDlRenRVU0cwMXllcHFKaGp3NDMybnl3QSs3?=
 =?utf-8?B?eFJITThSVkJ1d3VVUGpodTVLeVJrVFk0NEc1NGlRZ1o0NUM5V28rZkFQN1pS?=
 =?utf-8?B?V1NyTEhrSUtmV3dDallpMW5TRElFbmFRUHByV3hIdDBwNGNxZUdxMnhqbVl1?=
 =?utf-8?B?U21OQmxnQWQ4U1YzT2dRb0FWWlRBSndsSGpzSUhYTEh0WWhzaU5jOUNCcFRV?=
 =?utf-8?B?QU5aanhjZGZXYnB2QTR5YkowRCtKaWUwK29HUGxuU080TyttcTQ4U0ZmRDkr?=
 =?utf-8?B?RXpDNFk5TjVJMnpLRHpSa3dqK2NUS0hOWmhqdlgxK2x5N01QdTJXVE1kQjRV?=
 =?utf-8?B?NXA4b29nQWhQdXdwd1FvN2hrZ1RkUkJlKzd2eDlINU1zNythai9keHpCTTRu?=
 =?utf-8?B?YWxPNVl4R2dFeWZMSHJPdEhPNUdLSnhabkF6TTZDMU5sUmh2TjFYN0tVRGFR?=
 =?utf-8?B?L3JQK2lHMkwxTThObXJNMHVsN2hOeW9XSjM4MzhueGpIR2NsRk9TQThnNGgv?=
 =?utf-8?B?RkFEb1UzUDVjTTdyb1BiQ3NFMEJIRmI3QUY1Q3JwcVZCM3ROSGt5RDRZMUdP?=
 =?utf-8?B?Ny91c1p0aUROTEVyeW0ydXhzSkRzbnJaQko1WHJjbkxtVHhmUTBlVmVrSWxh?=
 =?utf-8?B?MzJwRHVVbU83R3JTTWY5LzMwZml5ZmxGTjJrTmNuNktPSWNaUFEwZHZBU1ly?=
 =?utf-8?B?cDYwOHhTVCtSdWFFNU03dEtGUzlGMnJBSmx3SDFBbDNZQzBxaHRzTHhIckpF?=
 =?utf-8?B?V2g2dStXeHhYNStldlhUWDRLZTJSL0VhcnJkK1hWYVBYTjBZOWVSVGI1ZWhm?=
 =?utf-8?B?UlZ1NjI3N0g1VDBEc2ZNZUFWVnhzMnFZQ0kwTzhKUzA3dWEwNEFmaW1FVWc1?=
 =?utf-8?Q?/VfNeveQ4MXRSJy8E0kRIXAKb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 759821dc-c870-4c76-ab8f-08dd8d94fb34
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 18:28:36.7821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O6eYrPQbjtP8296TSJgjAT6VN06sZDKe5qvXdPXqZlf+sLbHIK5cBZmhKykNg0ps9zjUor/AZyDzi2RlBfphlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6106



On 5/6/2025 6:06 PM, Gregory Price wrote:
> On Wed, Mar 26, 2025 at 08:47:01PM -0500, Terry Bowman wrote:
>> This patchset updates CXL Protocol Error handling for CXL Ports and CXL
>> Endpoints (EP). The reach of this patchset grew from CXL Ports to include
>> EPs as well because updating the handling for all devices is preferable
>> over supporting multiple handling paths.
>>
>> This patchset is a continuation of v7 and can be found here:
>> https://lore.kernel.org/linux-cxl/20250211192444.2292833-1-terry.bowman@amd.com/
>>
> I've been testing this for stability on a fair number of boxes for some
> time - backported to v6.13. Haven't seen any major issues related to
> this set in that time. Outside my normal wheelhouse, but for the sake
> of runtime stability:
>
> Tested-by: Gregory Price <gourry@gourry.net>
>
> Trying to get more explicit testing feedback from RAS folks.
>
> (note: there appears to be some conflicting changes in v6.15-rc4+ that
> a bit outside my current timeline to forward port and test.)
>
> ~Gregory
Thanks Greg.

-Terry

