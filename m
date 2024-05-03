Return-Path: <linux-pci+bounces-7045-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B924E8BAEF3
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 16:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F03C1F222F9
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 14:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B25D18C3D;
	Fri,  3 May 2024 14:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pW3Z1Jp4"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2083.outbound.protection.outlook.com [40.107.8.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FE2153BCB;
	Fri,  3 May 2024 14:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714746211; cv=fail; b=O2T0ZWwHT7w9r4gOXCPvTOG7qlnGLgRTrYwe/z+YasX2T+sm7sMFJNbqke9/AE1ITYjmWT37Zg2c/io25nQgsdldjaozJCm4/s4XGv2PeLGSfS3SIT3nXz0Zqj4MNO08683WqzSSdDxoI++3DuL9t567Lax7Paxm9MpKj2b13Cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714746211; c=relaxed/simple;
	bh=o3FI2JNORJhwTu25QqxZqT+25/m8adh4+vVcUKvNElQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z/JFJs42VFbZOvJln5QHEw+Xl88K8XGHSrG36oVuqkm+mrkszhsxJCWt2afpM1NhyPWYUJ66P4KaB17oVJ+BYmi1I2wk+vWXZfzNNL6GbATEZ9blQQg9cmowU3AA2gkVRCU7zwreCjFM/kSylUZOLBJW/vlu/4PRDWYxavbpVlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=pW3Z1Jp4; arc=fail smtp.client-ip=40.107.8.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8L5CwjOY7GMdha25dGdnLRorU9hOwshrSsBpFxK4Gk8uz17tEtD8R6bV5lES+h0J4iMG1jQPQFHDCe1Zjkta7LCQ0JQjlxnIfqFLX/GKvs/+uXv+ucv9UQmURTkIUrtxyye2lBcdUA84vxodDx3IRoeQ9pZ5KbP9j6lrQpdwV8KGBTDGd/Qb6SRd6n8VdokwjlmfvLmVtyvOItMgcr4N0D65+rov9XLu9b66JuqohERe5hvcV4XbyD2tO5cUIZZgNLrRFy2X+m/gItv3wbtSqv3uwukmSIByzr61a0JrnslUIql28nIQtLpHGafqVmqwAEzlrLc3LXh4IgdyhUjfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7OaUs/wNko7fYbnQkbF4PXJ8Ql2tyREoqxS5qEwbmm4=;
 b=D2fgJjA9+nuoUXSVt+nCn/4JU4R/gO2zgrm7mPpUiRjuDUJI0bDrZiNsAnA7MCESuzuzu/KCwzRgBl/YL1qI5LBqh/4ttzEDayfyQw6zmWVxToKNJfPaG52DSkbcfedY3mVtozADSIllYou52mgU/EkykZqEJHxSnLHPIvown3VCj7Js8OYZIGcsvgvaSSHNnDYuhLhkLlywdLPSpXFmfIPa5Ho37YLPt4PnL+VVXfEiuAe222VmE9JNyPTMLik+mvnA8R0YRx6ohMau0V9IBX/JAk0RHQK2+Wax4Jg+Ms6CJalotRsI69fl48QF53/YpGlmM72sgMG0UcGv5coTuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OaUs/wNko7fYbnQkbF4PXJ8Ql2tyREoqxS5qEwbmm4=;
 b=pW3Z1Jp4um5uk4Pp+XbRrpH7bb644Sh42/Jh1qi042/xC3KuYugtU7fBBngUmUExA9gqkdD8kb4MrEqOSDvR6JkvkXfk41XNP1TcSslXyM6ZURZms5SSQF4kIfzT3NvLWVNHYzOIO56oYtT4MhoX7BNYnWw2cGlw3d2RRxPV+BU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB10050.eurprd04.prod.outlook.com (2603:10a6:800:1db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.26; Fri, 3 May
 2024 14:23:25 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 14:23:25 +0000
Date: Fri, 3 May 2024 10:23:16 -0400
From: Frank Li <Frank.li@nxp.com>
To: cassel@kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: bhelgaas@google.com, gustavo.pimentel@synopsys.com, helgaas@kernel.org,
	imx@lists.linux.dev, jdmason@kudzu.us, jingoohan1@gmail.com,
	kw@linux.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, lpieralisi@kernel.org, mani@kernel.org,
	robh@kernel.org
Subject: Re: [PATCH v4 1/1] PCI: dwc: Fix index 0 incorrectly being
 interpreted as a free ATU slot
Message-ID: <ZjTzVNWAkNDJC3cs@lizhi-Precision-Tower-5810>
References: <20240412160841.925927-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240412160841.925927-1-Frank.Li@nxp.com>
X-ClientProxiedBy: BY3PR05CA0049.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB10050:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f3904d9-6e77-46fa-8108-08dc6b7c97f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|52116005|7416005|366007|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjhVaDZnd1lqcTZ5dWljOUE5VjlFSjRoK1BnL1NaeFh2UG0zc1ZkRUUvOHhB?=
 =?utf-8?B?bStHdmx2aDdzdzJxTUIrdFpWU1EyaW1Xc1hWbXBnMWR1U0Q1ODRlenZ3Vi9w?=
 =?utf-8?B?TlZTbXdFYWFldmhxR1hLSG9ZbEhqeHhDdGVyYVBrYzBRR2xGWkVvZUkyZGpl?=
 =?utf-8?B?TFF0RlU3d2doWU8zb2NVTDdLNjZwMWYyWFRPOFl1WkFhMHVoeVB0bW9vR09I?=
 =?utf-8?B?UG1Rek9NMXd4UjIvT3NaNlZCdGl6aFdSMVhmUVVaUjhLdkVQY0VCWnRaY0xE?=
 =?utf-8?B?Qkhnb2JObnlyQ3Q4b0t2cjdPd2RiY1hjMW5wZWRBaDVNVk1iUkVNZGpESkps?=
 =?utf-8?B?ZTk1TXVFTGNQTWdTeFYrdFROeTc3eThRVWF5T05VazlZei9LVmYyR2pyWEZ3?=
 =?utf-8?B?N3IyZ3BIbEowdGRDZlRtMHRRcHVtYm42SS8rWjlPVEs4cW9PRS9jekZ2bHpj?=
 =?utf-8?B?Nm9KMWQzN2R0a2ZQbzVuS21manJXdjFiTkRzK3JhQUpBU3l6NjVHeERIZGM2?=
 =?utf-8?B?RjBpendJWUMwdStKc3JpVmYvU2duU241K1A0eUkzM1FrNGc1UEtPZ3NDczJM?=
 =?utf-8?B?V2JncWRtQ1hJeEhpOGxXcng5VHRsNWVydWQydWw4S21laHNxYVo0UWRVdURq?=
 =?utf-8?B?RVJhbHpMdXo3cGk3YTIzU1kzSW13VjNOYUZTbXFRdGZ6d1BZNjhLVGdsN2pa?=
 =?utf-8?B?S3dZRVQ2RmhVazlYeUk2Y1hGa1IraDV4UmJsY2czY2ZzUzFkZVB5c012WmJo?=
 =?utf-8?B?QVBSTmtUQ1FqbisvUHdIUlFUeTZPMW02OWFuTHJmQk51RE4wVHZTZ1hvYU1H?=
 =?utf-8?B?ekdMVWpMSWEvazY1RGNyWEtNMCtTT0Ezcm5KYnNaSGpnSDkzb2ZHWFhQTmJI?=
 =?utf-8?B?Z3d6ays5Zis3dk5yeUZpWEozSzMvM0N4S04xVTh3Z3dPMzJZZGNtY25xVUx5?=
 =?utf-8?B?eWRjWnJUbUFBS2xlS3BwdCtsajFJRXdDcTJrc1VvcllYYXZoR05WMXpHQTd4?=
 =?utf-8?B?TzBKbDBRZTdIb05zSUxmanlDczhiZHFQd0w0ZnBsK3VCU2U4SUxpTi9OUXV5?=
 =?utf-8?B?K3d0Vkd4UzZyOG5pcWdQWVdjTzdHbWE0b0VnZ041SFdmdXNraGVvaTJLc0V6?=
 =?utf-8?B?UHEwbUJaaTAyT1FlRmJONDV1L2tnb2RzOUQrRHhJUXAwMTdXTmVCT1h1bHh5?=
 =?utf-8?B?bDRiR2Fud1FJelEydUluZWNiQ1NOcWxGM09uZzhOejFlL05yUEtsNGg5K3kz?=
 =?utf-8?B?RUJJaFRpUnoyNng4RGc0YnpMaktwU0tsQ1NySmFFajNoQThQRmZtcUtoWWJJ?=
 =?utf-8?B?TXQ5bVpSWWNJaTJwbDZNTmQ3SU5FRE5OVzNERmM0bnA1V2Z4MmtXeko2alcr?=
 =?utf-8?B?V3F6S3dxdFZkTEpZYkRzaG1Oc1ZSeE43S1I2MHpVc2lVc0tkQUl2b09uYTRN?=
 =?utf-8?B?NjV6dlpLZkEvUzMveWl3elI0NS83amZPS0xaR2Ztc2M3YnFOV2ptdThSbUsx?=
 =?utf-8?B?OEorRWtFMXdJdGpUR3ZXQkU3TzdWT250VkZDLzUycGtxY1JDNFRKWW9HakI4?=
 =?utf-8?B?OVhNVjM0d3FWa0tHSERuemdtSlIxMGFoVzRhdmNpUnVRWml1QXdkRlZtQkpr?=
 =?utf-8?B?QkJUaWxJMDZSRGllaVVrM1VkbGVIQVB1UUY0SitZYjVCZjN5MTU5Q1c5VWVW?=
 =?utf-8?B?QkRWdTdKNzQ1c0ZBVHZPeEFRMUJ6Qm5oRHQ1cE4rRTdCVlI5d0RWejBRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(366007)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzhMa2o3aktrQ2l2NFZEMlZnS1pTY3VQYllSTDgxVHcybzZSYi9URnF2REtE?=
 =?utf-8?B?K0VDZkJJUVRNOVl4S0V6cSs4U3p0VnZVQmR2SUJWWjRHVzdIbm45djVxR3Ax?=
 =?utf-8?B?WlpaYS95RGFaOVEyUGJQcmRzWUZkKzdUc3M3cldMYlFTaWxNRDRpWnh0NmZ5?=
 =?utf-8?B?d1ducTFLdVNUMzNabFhkL2t2cEF6c2Vtd3ZLN29mbnkzU2wzRXVvSUp2U0Mr?=
 =?utf-8?B?QXQ1TGtzRy9rRm9zNG55NTMxMVlVeVVwaWFEeVp5VmMzOHVuc0ttTHk3ckRS?=
 =?utf-8?B?Y1hFSTVyUFliNEwxcUZnMUZjR2RSdWtLNTlONmEvZVM5K0FGdWVxTnRMQW9Q?=
 =?utf-8?B?czdrQ3J4OEZEb2J1ZGNUbzZib1BiWnhoSkVpRFQyK0dJd0w4VzZnZGFObjlz?=
 =?utf-8?B?UldXSCtQbGxNRjh3TkJabGUxcXU0VDBXNk5CalpJVWsxNkZDWEFteWhEd051?=
 =?utf-8?B?RkYyOEtCT3k1V3YwaVNQVUVQY3N4bnBwaTFWTkZ2emYxTjJJOFoxa2dnMi81?=
 =?utf-8?B?OXJYMWpiZ25LbTFHc1drMnloWW5qTFJWR0NpSGU1YXdIWm03N3JYa2xMVzdy?=
 =?utf-8?B?VDBKQVREODFrZWtUNzNqZlg4WGlnV3hpM0dFN2xoYVBYRTBZckpGVGdJTER6?=
 =?utf-8?B?K0R1Z3FROFFHTWxpcjI1RkM1dncyajBpRmdXRVlBNkJKaXpqM3dZSEpoVW13?=
 =?utf-8?B?bURuV1ZKdkQ0dFRzMXB1eE5pY2VERDdUV3JYK1l5UmxaNWtuOGlKdzMxZTNs?=
 =?utf-8?B?YWNraUlxU3J5U2t6NDR2amI5dU9JR29wTVhOeDFHYTV5TDNrMkFiSDEwN1V6?=
 =?utf-8?B?bUlZWDV5Qm9jcEhvUEZnWUs3NkxsaEdFdzF5NmRrOTNQY3BmdlowdW5Mb2pE?=
 =?utf-8?B?UEVrV1FYeEk0d2R1dkg5TTdsL0hPWnpnQ1hNVUFKbUphbFJ3dzh0TmJHa2dz?=
 =?utf-8?B?cnYyY2Z0TDh2Y2xjazVpbitudWJFZXVic2pJenV2RTB0TUFwZlNHVFlkbnZ1?=
 =?utf-8?B?aWFXSjRESktSam9qNloydUhNZ1U2c2l4V21Xd245dlpHbTNjY00xLzBBb3pa?=
 =?utf-8?B?cllBQnkvZDRwNlRvdWMzNUdnQTIxY3FaeDc5bXlJYzl6MWIrS2tpVEdYMHRn?=
 =?utf-8?B?RHdRSnFqRDlvSkRhYjlmaDhoaDRXV040YXFNN3dYMjlDUmxoVVRHT3E3U3Rl?=
 =?utf-8?B?SEcvUExmL2lmMFN2NTFwYkRSRHJkMWhGUWtLdFZ1cW9GQTNoTHBjS2gzL0tE?=
 =?utf-8?B?cVEzM01XZVAvUmdLYmpzQktJWE4wT3h1bmU2YjlNaHRjQjBqcytjTDJWdVIv?=
 =?utf-8?B?UU5NT2hoQkFjSjc1MlM2NTBYa3p1QXVqYjg4Slk4cTNJT3ppVEZCQ2pNUDFp?=
 =?utf-8?B?SkpuMExSMXJDU1lsSEJ1b2VqK0F5REVvNmhPZXNaNW5kYVhqbzdyTHlFSUdE?=
 =?utf-8?B?QjAveVZFalpkTGlKUVZoVVlZdEx2MmlzZGVoZlQrTHllbGZ0cDB2R1UwWHVN?=
 =?utf-8?B?OUpFenpPTCt1WUFVaVFSNENoQ2FVZ3RRSkZpU3kxbVRvbmpUYmc4WEcrZE96?=
 =?utf-8?B?SW1ub0FudHBPdzhZbHM3MHkzMmZrNnk1ckc1STZwcjlWNnMvM3hJWmp3WWRQ?=
 =?utf-8?B?U2RYVEdlRVpLSklvaDVYa3NPSE1wMTlWTzlpRjBjU0V1bWZEcGlDOXZNQ1V0?=
 =?utf-8?B?L1pkSnQyYzBwV2lCckVOUE1HZkk3WHlGNStqemlrdkxuNElnVUdxVEZiemdC?=
 =?utf-8?B?dHB0cCtiWmNZOFl2YUNsczNYYTErUko1UjNDYldxcE4ybDM5d1ZRdFJuR3lH?=
 =?utf-8?B?NjcvbS9jUDlHL29OK3BlSGNReWVoZVgxdkdML2hkditWRmF1djhOaDNQK2o0?=
 =?utf-8?B?QXlyZEhSQ1dqaGtwN3RBRGRkYzJVOWtUS1ZVMFBTVVZSRnJINE1zYUpISFV5?=
 =?utf-8?B?QmdTT3Y4clFiOHphRCtielIwcStKR2ZBbkNycWJGS3hLbGFxWVc1VWluWld0?=
 =?utf-8?B?REZXbjdBcEtaZ1U4RCtTdFJVVFYvaDdCcFVPYTZrWVBCU3JJQ3p5cUhUbkxX?=
 =?utf-8?B?bEZwMzZNZzJLK090L2JrRUx5a1lIMDlRNHQvVnFENkpCTmt1UXlxVmlSdjdH?=
 =?utf-8?Q?LBt33CGufP8HPNb9YySBcI/nS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f3904d9-6e77-46fa-8108-08dc6b7c97f3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 14:23:25.0984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uj9ZnYv82AAzfrwZkqPXlvJy9XLrtnk9bwZp7QZYp/aUtRGnh7cTy0pPeK35AkhOnFk6IC+oz0ABmQ1vygHKoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10050

On Fri, Apr 12, 2024 at 12:08:41PM -0400, Frank Li wrote:
> When PERST# assert and deassert happens on the PERST# supported platforms,
> the both iATU0 and iATU6 will map inbound window to BAR0. DMA will access
> to the area that was previously allocated (iATU0) for BAR0, instead of the
> new area (iATU6) for BAR0.
> 
> Right now, we dodge the bullet because both iATU0 and iATU6 should
> currently translate inbound accesses to BAR0 to the same allocated memory
> area. However, having two separate inbound mappings for the same BAR is a
> disaster waiting to happen.
> 
> The mapping between PCI BAR and iATU inbound window are maintained in the
> dw_pcie_ep::bar_to_atu[] array. While allocating a new inbound iATU map for
> a BAR, dw_pcie_ep_inbound_atu() API will first check for the availability
> of the existing mapping in the array and if it is not found (i.e., value in
> the array indexed by the BAR is found to be 0), then it will allocate a new
> map value using find_first_zero_bit().
> 
> The issue here is, the existing logic failed to consider the fact that the
> map value '0' is a valid value for BAR0. Because, find_first_zero_bit()
> will return '0' as the map value for BAR0 (note that it returns the first
> zero bit position).
> 
> Due to this, when PERST# assert + deassert happens on the PERST# supported
> platforms, the inbound window allocation restarts from BAR0 and the
> existing logic to find the BAR mapping will return '6' for BAR0 instead of
> '0' due to the fact that it considers '0' as an invalid map value.
> 
> So fix this issue by always incrementing the map value before assigning to
> bar_to_atu[] array and then decrementing it while fetching. This will make
> sure that the map value '0' always represents the invalid mapping."
> 
> Reported-by: Niklas Cassel <Niklas.Cassel@wdc.com>
> Closes: https://lore.kernel.org/linux-pci/ZXsRp+Lzg3x%2Fnhk3@x1-carbon/
> Tested-by: Niklas Cassel <niklas.cassel@wdc.com>
> Fixes: 4284c88fff0e ("PCI: designware-ep: Allow pci_epc_set_bar() update inbound map address")
> Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

Anyone take care this patch? Krzysztof Wilczyński, Lorenzo?

Frank

> 
> Notes:
>     Change from v3 to v4
>     - commit message add "Right now, we dodge..."
>     - Add Reviewed-by: Manivannan Sadhasivam
>     
>     Change from v2 to v3
>     - Add impact in commit message
>     - Add mani's detail description
>     - Fix Closes link
>     
>     Change from v1 to v2
>     - update subject
>     - use free_win + 1 solution
>     - still leave MAX_IATU_IN as 256. I am not sure if there are platfrom have
>     256 ATU. Suppose it only use max 6 in current EP framework.
>     - @Niklas, can you help test it. My platform become unstable today.
> 
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 5befed2dc02b7..ba932bafdb230 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -139,7 +139,7 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
>  	if (!ep->bar_to_atu[bar])
>  		free_win = find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows);
>  	else
> -		free_win = ep->bar_to_atu[bar];
> +		free_win = ep->bar_to_atu[bar] - 1;
>  
>  	if (free_win >= pci->num_ib_windows) {
>  		dev_err(pci->dev, "No free inbound window\n");
> @@ -153,7 +153,11 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
>  		return ret;
>  	}
>  
> -	ep->bar_to_atu[bar] = free_win;
> +	/*
> +	 * Always increment free_win before assignment, since value 0 is used to identify
> +	 * unallocated mapping.
> +	 */
> +	ep->bar_to_atu[bar] = free_win + 1;
>  	set_bit(free_win, ep->ib_window_map);
>  
>  	return 0;
> @@ -190,7 +194,10 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	enum pci_barno bar = epf_bar->barno;
> -	u32 atu_index = ep->bar_to_atu[bar];
> +	u32 atu_index = ep->bar_to_atu[bar] - 1;
> +
> +	if (!ep->bar_to_atu[bar])
> +		return;
>  
>  	__dw_pcie_ep_reset_bar(pci, func_no, bar, epf_bar->flags);
>  
> -- 
> 2.34.1
> 

