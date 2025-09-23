Return-Path: <linux-pci+bounces-36806-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BCBB976BB
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 21:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2781178A7A
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 19:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6459279780;
	Tue, 23 Sep 2025 19:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DEtTN/J4"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013030.outbound.protection.outlook.com [52.101.72.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AEB15624D;
	Tue, 23 Sep 2025 19:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758657114; cv=fail; b=Y/CkgqMOXF5buy4enRwgXxOHtUYplrDqPwEj9oJGqywHhEbafYvQDIwuoChkVjCM2zQC3vacVc1X39i+sUuaKzC5yczE6RlRFvKD340XjeuFayu416rzInHZVzMZWO9zRvC89wi+ksUcbBi8+cvSAMabipl36hg+LHanad32JIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758657114; c=relaxed/simple;
	bh=rklk29x8xucgUJSHdZOBNE9tWgEonHkpgHiWpdUCMVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e5mLnV4XymNHOUSJHKKerUWhBwlSu4V14uS7oHT/UAN9pjCnlx86SZArMavuvWCFmPgQe/LLeNoiIr7gs2IQ7f9WLJHiE6cd0koffdjAgGaaJjN9ff+rV1UecHMZKxT/4WbERxWWsrctlLIEiknNStifDnY9Ugwfcf8shHl2nz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DEtTN/J4; arc=fail smtp.client-ip=52.101.72.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jxmvY5KHYhIaA8CPWqfoM/fIthncSuQ+MM/2lqulj6gw8JX6Ke/A9Wqx3O35RA0B4SG4ttSesDNcc6X2ivI91LFxXqI0RtFUFJHN8ZGOAlE52LcLrqBHeO2rlMh9rDvNX23pzgvyOtN+P28CYXGykkiUmIaBsEYb9xkyOx0/LsZDkugM3Fy9PB8sS13H2HYL0chNzijpwfqps/DoG9Bu9raf6ZkRjKBa3UzkX3aGGSbZH5AuqRUBIQPiMP+DA5OXSpSPRbBo0/zurPgiKaKfBAnEYD22FuWQdPyeE0xsj7M6MeOKJ+Bzi5Jf8vv2+xTk7texAaoXhDO8oYXxrHYBdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQq0vSPj3yQnJt1X2HoPnEaAq6S/QV3bD64zYFGMuo0=;
 b=gYqOKEJdEaSpdUaIe7esWwM5PBywsrCnlXWzIzCvw504cL+kCWIggN7651nwtpodgRXs7TaRFNsHBwXJa7eoyx9PSqjtC2+q7BDgCtPiTaMsdsPvL/7fAAbyG+ekVt8esHNE+qEAWpN1JHbnFWNcqbWSzc3v6Lhrk+E0y7PLkRNjOG4p2R+5nFLA6T8TSJDa/buTWbcGlFLkkjqONe9fR3rLqoC2hVZEnE1kIgbTqkYTVsWx5qST1/Cmtz6VCxRbBuFtLlg8ivkSzaMw8txjShDaVHiAH4ppexu1U0Tz0XkzHbs4PmHS2bGE3Uao/89CETWqfDO2fAN/KXW+bRVRaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQq0vSPj3yQnJt1X2HoPnEaAq6S/QV3bD64zYFGMuo0=;
 b=DEtTN/J4NPiYyDm1H/dpf4Eql/aNZJqcPP02262gVZem4D5yr9qT87U4VZQRTCE6UYzXVgRf3lqKuDUpFBc4NuC+QwP/QiA7tAAH7bLtJm9Qa5P7yyYTuJOSudYxQKMm9TTDIewyk5VPjtJxFEvQqggyt45oa/i3HmR6QMRSxaHZ6aJr4HoUsKW+Na3PXAY95VQfRMPqu6pGpVW5WNXgNq5SWuSvSb+KhLImhrHxQAUnM7dF+deieNRfexkNloqfZCm7IZocqaCSpCY2sslZn4Adk6x+1tKiHSwlNeDXMAYDrC0mzs+HIma83FDQbaZtJYBlMlJ501tcIvyBMMqSrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by AM8PR04MB7923.eurprd04.prod.outlook.com (2603:10a6:20b:24b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 19:51:49 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 19:51:49 +0000
Date: Tue, 23 Sep 2025 15:51:41 -0400
From: Frank Li <Frank.li@nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Zhang Qilong <zhangqilong3@huawei.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 1/3] PM: runtime: Add auto-cleanup macros for "resume
 and get" operations
Message-ID: <aNL6TQ4vHtfoNE2d@lizhi-Precision-Tower-5810>
References: <12763087.O9o76ZdvQC@rafael.j.wysocki>
 <2399578.ElGaqSPkdT@rafael.j.wysocki>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2399578.ElGaqSPkdT@rafael.j.wysocki>
X-ClientProxiedBy: BY5PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::40) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|AM8PR04MB7923:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ee80dac-52c0-4315-65f4-08ddfadaa21a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|19092799006|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Vs1RkYZVXBD+gEiLtLn5j6EbBrcsN6fXDy74qxRGISLWX7y0pwp+4S3cVpU3?=
 =?us-ascii?Q?zgot6eIGONZBdiRv+O3pdSPwjn479TEHXCS0Rgixa4qKWwEYLTmHpADXEFCC?=
 =?us-ascii?Q?EUkOl7Vc60Uz9TAHVJPC0OvMRvRklPqOwXv9zvN5qPQ6mn41/kwHIRaa2JVg?=
 =?us-ascii?Q?oVg5wm0MA03RaAWZCMM1ZLJIV0JuC9ILLDgWw6lzyQBi4brdDnkq5D/wUEjy?=
 =?us-ascii?Q?wJfO537C6jKd1JBccvB19n7BOL1NCEuIhe7SHs9sxPzWf91obeUzduFkaiAN?=
 =?us-ascii?Q?0t9Ic/DDMJFeh29NxPjGoWyIbFaGO/ZiXS5p7MZEEPH9VN8L2iHheruPO4qg?=
 =?us-ascii?Q?j3mnfbwrEQ6GAk6odXJEQgJDYw4mO1ABBsGwGRDiEUGHd7fa/ouK9ubjbaa9?=
 =?us-ascii?Q?ZuwKCcPQeg9Hy950nENcKCeH5EfXWNw7JoaN8Abp6RPUipv5xKX5foPrX+xY?=
 =?us-ascii?Q?A384Fvc8EFmAPB8u2Sa+Mf9IYMhEgDuMk3DIeezkNYt99VqSnYBwsH/xhnHj?=
 =?us-ascii?Q?ccYwKmazUbdPJtj6T7VAznH6Vk2wWk7TCoWe9K/L6MYTc/mPStGkmyozkl+G?=
 =?us-ascii?Q?R+lA9T4di8LSgopl9Obw6MGZaSW3T/zIjjC+Gow8JE8tVc4WicGG68PJ1afy?=
 =?us-ascii?Q?5nkEUIF+/7sVEo7HsitN8DBdoRT2hEyQmrmNY1XxxNyOI4xJvFYdCoptX/Mf?=
 =?us-ascii?Q?SkTYnS6OgfKBR0fv0qDa6uldTjlyY5JDHZiEVoxLZunuQOnVJYXrLSa6PbIa?=
 =?us-ascii?Q?lBbnz+Hyw5SszevFFM73/2ehX9Wi84GaB2oadL4oSlzTtQnVohvKEtkrvl5P?=
 =?us-ascii?Q?/fTck71W44zOLuSm/iEnQuBv8mCRpYEcAl7HR9y9kORf4OC3MBht+HY61Abr?=
 =?us-ascii?Q?y6AVenH1MRoQgIHQ7cOBZfyyLnla8r76QYQ83nL8HCAhLdBOr/+BSSRfF7aX?=
 =?us-ascii?Q?qOkAFvZ3mH45e3w0ZrPWWELLl7k5C5qCG6VwWgqTrFeGyO1RJ6CoebEVadHs?=
 =?us-ascii?Q?pibWJuTWFGB22wfNBSqf51Xvaqx2oB10GA55HIdNyaPaSN9Mf54Sk7ATHrZ7?=
 =?us-ascii?Q?eyOqNDPqAocNw7Zev/JibO6CXET9LUkbYGkJIonNvD9nIESrIJclB0Z5iHSh?=
 =?us-ascii?Q?yRp6dajPjACrqXo7E7CKTQf3Y+2/pL21kU+42vx1fL1/W8SC0pQhgDTHNMpK?=
 =?us-ascii?Q?QqCAu975/U1OqaQdNk1GhUWzQK6vQSPG8ymdlfe7kqWrF3GZDjcgbAMBSz9V?=
 =?us-ascii?Q?PD6ZugZvE9LOyrAgcTF3idkwJx/rufrrIb1mTquFRA69WyAM7p8G+kkTlm8V?=
 =?us-ascii?Q?GgdrKehQaIzpdIforrT5K5f9Ga6xRwAv0+XrcHZFMPR6jRtcJPdpPAqvoNiI?=
 =?us-ascii?Q?jskaXtcpJdZPZjyu7Q8b16fqfzt57m0WvfNXMsiTItWa5K6tWUD5PGB3lTll?=
 =?us-ascii?Q?Zdoirx1jvDN5A2030vXRnrKErly0nVWJl5vpuMSc6u3XdzCYg4Yow1yjaKJn?=
 =?us-ascii?Q?HQav5qm0SvoGaME=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(19092799006)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9fdTZJ6hifDZ/ClfE22H/2zcV7tmtCp1tJ/CiZFINV642R5/1w6M73NLYWju?=
 =?us-ascii?Q?UgiSAITWboS6Z/6giLu3RZhHktzYFdoe41XvkQD14Dbu6lpinB2sDVe2c+yi?=
 =?us-ascii?Q?0GxIWU3KC9+7mlECM4VDQPsMxWVKSCPGNT7tTAm0mEzBBBdOsTNWByYKPoHx?=
 =?us-ascii?Q?sCnfjBVohgHSFQ7LDWXAbdGqwdG+tsqIbQCLeYlwfW9T6WpsISBwJY8iYi1D?=
 =?us-ascii?Q?anMqaLiMQwsVwDnHD1Lvz43SO7Rw9HSOIqs/PnKCTdfQq6XpKKqOpV86mBre?=
 =?us-ascii?Q?GFw8MDcmjLGCF0vNeC7pzaV8G04DCqIjdviWuJs9DdaieJgjTGupJD+Giqxb?=
 =?us-ascii?Q?zlk+L+CIPHTOIVgwOLj8vksXaCTIy2irS4fmrfw8O+pwnZWZJA5ZH6jFwOpp?=
 =?us-ascii?Q?DNdpiXmS8KQfDucX07XAt5iKI1kehUT6PEJiKGLttoIctdNa0gf1NOmX3A3B?=
 =?us-ascii?Q?mlAeElymwK3kb1nkp/xeQGAfmo+LhCHzfNR6943+Vm6FDBDLvc+K0nKRstIA?=
 =?us-ascii?Q?+bTDgvx50c6yAw8nbvo34JbNY92D85G2egDcbXvIebf27H/DUiKr7Z/ao1lK?=
 =?us-ascii?Q?qiZAjq/+BwQ1d9xy2bHE8o4r3sE9HH9f7tIba/M8MRFIbnAP/Pp5IFWyIKV9?=
 =?us-ascii?Q?t42RkThjkBPuLWKHqCwRuxmhBRskHgq8Un1VUWW25PLj3zpKRzpAgKsG9CCI?=
 =?us-ascii?Q?2usnsrbscmLjXxa00VsBnmk3MdGo68+8DF3+SEfKU7G7NHC0Wt1+bqC9nlE3?=
 =?us-ascii?Q?0gtc3lesvpzECqo1iuVyQJuO+ZsQF13TcW1FkeUUqVOZR2wObL6YcqECR8sM?=
 =?us-ascii?Q?J0DRGj8cLOeJ0q/qjU7dw84HeWOAbK0jRX0dXWKw3fKLtAUMpLNQikDxLYO4?=
 =?us-ascii?Q?hjbM1HGZqHMPQCDwWQIRV5HPYT7mHt/owp6wkJdEx1k+ibsuUkyHbIMoBFcV?=
 =?us-ascii?Q?q3Z2vzWO9Ywj+Tp+oha+SIdujFqSkj53ah9WfC4vHFMKz9tQ2Cp6FBUMmLVV?=
 =?us-ascii?Q?eyx3S2JIwIUagbAhUmSfiXHvgiki2RGK69pQ9UVHhWZRdfpZTe7CeltNwo81?=
 =?us-ascii?Q?FBn7+1gEvRre2YsFgOOptMSX+0VAS+N9YC5aWSON2fqX9TMgdc34Lvg727G3?=
 =?us-ascii?Q?6v6KwvI2s858ezNPWkmQkDGtfb0uhXZQZhYcE1kKrxvd1up5rqwQVcLfF+3c?=
 =?us-ascii?Q?t29nT4JDMoQYVvEiB+JVggEt2A0fmaqf0a5nDFKaqxuAs/A/NZAzjbkdtq60?=
 =?us-ascii?Q?k88Yuv/xnac1e92R8aDzuprPY05HL+/C40RdeiMB+W66+21QM/wLGp0ndTTt?=
 =?us-ascii?Q?tvrdYP+r8jXRXiRusuBIgVlf0NYe21x2zAj56hQVyDm5LdXx60KhePChws8A?=
 =?us-ascii?Q?SbCTQ91xaxVbe96//Vn+C1gW8Oz5dPlaurb3+HBOXRwZrEhNpKcf9Za6OV5q?=
 =?us-ascii?Q?FLFNFusm+t//R0TYBmbC5nV4bZxB1F8Cqs6k1WgZ1bZqr1e9f+KMQGEJyGce?=
 =?us-ascii?Q?6ISDaQFJs+ZpXgMS5poK2dTJ5W2YE+7ANNQcjIMlcgY9O8uVGNA44ap5B1Kf?=
 =?us-ascii?Q?wUMRh8Mx29nl7nvGCqpyjZRBtATZs+rdyN9h56Yc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee80dac-52c0-4315-65f4-08ddfadaa21a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 19:51:48.8812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oF6OmVNfHlfjAS/z/XX256tBOdF+5GPnZ0gqC2kYXXSf8jyeTCtFqpEmp9F35sxi1mFZL5OBfl3L2niUOO92Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7923

On Mon, Sep 22, 2025 at 05:30:43PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> It is generally useful to be able to automatically drop a device's
> runtime PM usage counter incremented by runtime PM operations that
> resume a device and bump up its usage counter [1].
>
> To that end, add DEFINE_CLASS() macros allowing pm_runtime_put()
> and pm_runtime_put_autosuspend() to be used for the auto-cleanup in
> those cases.
>
> Simply put, a piece of code like below:
>
> 	pm_runtime_get_sync(dev);
> 	.....
> 	pm_runtime_put(dev);
> 	return 0;
>
> can be transformed with CLASS(pm_runtime_get_sync) like:
>
> 	guard(pm_runtime_get_sync)(dev);
> 	.....
> 	return 0;
>
> (see pm_runtime_put() call is gone).
>
> However, it is better to do proper error handling in the majority of
> cases, so doing something like this instead of the above is recommended:
>
> 	CLASS(pm_runtime_get_active, pm)(dev);
> 	if (IS_ERR(pm))
> 		return PTR_ERR(pm);
> 	.....
> 	return 0;
>
> In all of the cases in which runtime PM is known to be enabled for the
> given device or the device can be regarded as operational (and so it can
> be accessed) with runtime PM disabled, a piece of code like:
>
> 	ret = pm_runtime_resume_and_get(dev);
> 	if (ret < 0)
> 		return ret;
> 	.....
> 	pm_runtime_put(dev);
> 	return 0;
>
> can be simplified with CLASS() like:
>
> 	CLASS(pm_runtime_get_active, pm)(dev);
> 	if (IS_ERR(pm))
> 		return PTR_ERR(pm);
> 	.....
> 	return 0;
>
> (again, see pm_runtime_put() call is gone).
>
> Still, if the device cannot be accessed unless runtime PM has been
> enabled for it, the CLASS(pm_runtime_get_active_enabled) variant
> needs to be used, that is (in the context of the example above):
>
> 	CLASS(pm_runtime_get_active_enabled, pm)(dev);
> 	if (IS_ERR(pm))
> 		return PTR_ERR(pm);
> 	.....
> 	return 0;
>
> When the original code calls pm_runtime_put_autosuspend(), use one
> of the "auto" class variants, CLASS(pm_runtime_get_active_auto) or
> CLASS(pm_runtime_get_active_enabled_auto), so for example, a piece
> of code like:
>
> 	ret = pm_runtime_resume_and_get(dev);
> 	if (ret < 0)
> 		return ret;
> 	.....
> 	pm_runtime_put_autosuspend(dev);
> 	return 0;
>
> will become:
>
> 	CLASS(pm_runtime_get_active_enabled_auto, pm)(dev);
> 	if (IS_ERR(pm))
> 		return PTR_ERR(pm);
> 	.....
> 	return 0;
>
> Note that the cases in which the return value of pm_runtime_get_sync()
> is checked can also be handled with the help of the new class macros.
> For example, a piece of code like:
>
> 	ret = pm_runtime_get_sync(dev);
> 	if (ret < 0) {
> 		pm_runtime_put(dev);
> 		return ret;
> 	}
> 	.....
> 	pm_runtime_put(dev);
> 	return 0;
>
> can be rewritten as:
>
> 	CLASS(pm_runtime_get_active_enabled, pm)(dev);
> 	if (IS_ERR(pm))
> 		return PTR_ERR(pm);
> 	.....
> 	return 0;
>
> or CLASS(pm_runtime_get_active) can be used if transparent handling of
> disabled runtime PM is desirable.
>
> Link: https://lore.kernel.org/linux-pm/878qimv24u.wl-tiwai@suse.de/ [1]
> Co-developed-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Nice feature.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> v2 -> v3:
>    * Two more class definitions for the case in which resume errors can be
>      neglected.
>    * Update of new code comments (for more clarity).
>    * Changelog update.
>
> v1 -> v2:
>    * Rename the new classes and the new static inline helper.
>    * Add two classes for handling disabled runtime PM.
>    * Expand the changelog.
>    * Adjust the subject.
>
> ---
>  drivers/base/power/runtime.c |    2 +
>  include/linux/pm_runtime.h   |   82 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 84 insertions(+)
>
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -796,6 +796,8 @@ static int rpm_resume(struct device *dev
>  		if (dev->power.runtime_status == RPM_ACTIVE &&
>  		    dev->power.last_status == RPM_ACTIVE)
>  			retval = 1;
> +		else if (rpmflags & RPM_TRANSPARENT)
> +			goto out;
>  		else
>  			retval = -EACCES;
>  	}
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -21,6 +21,7 @@
>  #define RPM_GET_PUT		0x04	/* Increment/decrement the
>  					    usage_count */
>  #define RPM_AUTO		0x08	/* Use autosuspend_delay */
> +#define RPM_TRANSPARENT	0x10	/* Succeed if runtime PM is disabled */
>
>  /*
>   * Use this for defining a set of PM operations to be used in all situations
> @@ -533,6 +534,32 @@ static inline int pm_runtime_resume_and_
>  }
>
>  /**
> + * pm_runtime_get_active_dev - Resume a device and bump up its usage counter.
> + * @dev: Target device.
> + * @rpmflags: Additional runtime PM flags to combine with RPM_GET_PUT.
> + *
> + * Resume @dev synchronously and if that is successful, increment its runtime
> + * PM usage counter.
> + *
> + * Return:
> + * * 0 if the runtime PM usage counter of @dev has been incremented.
> + * * Negative error code otherwise.
> + */
> +static inline struct device *pm_runtime_get_active_dev(struct device *dev,
> +						       int rpmflags)
> +{
> +	int ret;
> +
> +	ret = __pm_runtime_resume(dev, RPM_GET_PUT | rpmflags);
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(dev);
> +		return ERR_PTR(ret);
> +	}
> +
> +	return dev;
> +}
> +
> +/**
>   * pm_runtime_put - Drop device usage counter and queue up "idle check" if 0.
>   * @dev: Target device.
>   *
> @@ -606,6 +633,61 @@ static inline int pm_runtime_put_autosus
>  	return __pm_runtime_put_autosuspend(dev);
>  }
>
> +/*
> + * The way to use the classes defined below is to define a class variable and
> + * use it going forward for representing the target device until it goes out of
> + * the scope.  For example:
> + *
> + * CLASS(pm_runtime_get_active, active_dev)(dev);
> + * if (IS_ERR(active_dev))
> + *         return PTR_ERR(active_dev);
> + *
> + * ... do something with active_dev (which is guaranteed to never suspend) ...
> + *
> + * If an error occurs, the runtime PM usage counter of dev will not be
> + * incremented, so using these classes without error handling is not
> + * recommended.
> + */
> +DEFINE_CLASS(pm_runtime_get_active, struct device *,
> +	     if (!IS_ERR_OR_NULL(_T)) pm_runtime_put(_T),
> +	     pm_runtime_get_active_dev(dev, RPM_TRANSPARENT), struct device *dev)
> +
> +DEFINE_CLASS(pm_runtime_get_active_auto, struct device *,
> +	     if (!IS_ERR_OR_NULL(_T)) pm_runtime_put_autosuspend(_T),
> +	     pm_runtime_get_active_dev(dev, RPM_TRANSPARENT), struct device *dev)
> +
> +/*
> + * The following two classes are analogous to the two classes defined above,
> + * respectively, but they produce an error pointer if runtime PM has been
> + * disabled for the given device.
> + *
> + * They should be used only when runtime PM may be disabled for the given device
> + * and if that happens, the device is not regarded as operational and so it
> + * cannot be accessed.  The classes defined above should be used instead in all
> + * of the other cases.
> + */
> +DEFINE_CLASS(pm_runtime_get_active_enabled, struct device *,
> +	     if (!IS_ERR_OR_NULL(_T)) pm_runtime_put(_T),
> +	     pm_runtime_get_active_dev(dev, 0), struct device *dev)
> +
> +DEFINE_CLASS(pm_runtime_get_active_enabled_auto, struct device *,
> +	     if (!IS_ERR_OR_NULL(_T)) pm_runtime_put_autosuspend(_T),
> +	     pm_runtime_get_active_dev(dev, 0), struct device *dev)
> +
> +/*
> + * The following classes may be used instead of the above if resume failures can
> + * be neglected.  However, such cases are not expected to be prevalent, so using
> + * one of these classes should always be regarded as an exception and explained
> + * in an adjacent code comment.
> + */
> +DEFINE_CLASS(pm_runtime_get_sync, struct device *,
> +	     if (_T) pm_runtime_put(_T),
> +	     ({ pm_runtime_get_sync(dev); dev; }), struct device *dev)
> +
> +DEFINE_CLASS(pm_runtime_get_sync_auto, struct device *,
> +	     if (_T) pm_runtime_put_autosuspend(_T),
> +	     ({ pm_runtime_get_sync(dev); dev; }), struct device *dev)
> +
>  /**
>   * pm_runtime_put_sync - Drop device usage counter and run "idle check" if 0.
>   * @dev: Target device.
>
>
>

