Return-Path: <linux-pci+bounces-39005-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 591AABFBC7C
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 14:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6B7E1892208
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 12:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB9A341665;
	Wed, 22 Oct 2025 12:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="M84Q4PMr";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="bvVZPIEn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98CB2765ED;
	Wed, 22 Oct 2025 12:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761134902; cv=fail; b=X3nr/troUZNCIxbT3TlIwVVjA1+TOxnHe13NkeqBRPrPIOo4lX6/GeglK6D0pywk5IjBjesXisUZWo3MGSu1SQLFhVZiug2kmRzTyXuW7T9mpKLJ56wXSuuqtXFbnlTBWvWtl/KagnVtOMJ2uS0NR/14NrR5FACVJra+N5X0q8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761134902; c=relaxed/simple;
	bh=S8cHEKVwWhSa+Vb2B4dZqj3xQh2XTzs8nuHUkBthU40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l+EdNbUKxqEiIZEda187pXNaxyWg7h3cTSpt+bPDI6R+Sfvfuq0wX4WB0jpR8sxTE3NTitDE4e1uJh5w54j4KPLr7pTzudQdNWqMqTNTmc/XHnPKBzKmook7TEiDI6cWAbCjZtaxhXA3J3xC+3fVW77QUl3kMV3yc+VJKk7hgiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=M84Q4PMr; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=bvVZPIEn; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59M9vPlv1122453;
	Wed, 22 Oct 2025 05:08:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=824g7+kxEqx7xAjnmQtN+76+ey3iOW5HhTvWkqXiX
	bg=; b=M84Q4PMr8ags5K1NbD9MqOM2J5SdejycIyrdpE94Sw/6fK0kJHR+U4zDc
	e9Ix81Kw+dxTDQOl1lP4QX0C54AcEvt4Z/ZXHNveLFxMh4jovxrqkvJ3Okbj4zmI
	jeevJ3cO8BicAN1L268IXnepfPfoCkvKMdijL7ufz66rbFfLjhulOV0riO+fJwwi
	As1NHPpIgWij8ks4t9a09druqHiTE09fIf6Qxjo25sbrQBesEfJGqurVEbiuhjH3
	uijwUdKDSxCkEyTHt5gbe5Ez+OjFCwQDgTWSxEIRUoqDxnmq3XKcr4iap3HSV/JQ
	VEdqlT8yQfNepoZXONGd0JhFl7FHw==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11020105.outbound.protection.outlook.com [52.101.193.105])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49xw3g887n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 05:08:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eNrXwZSkqU1VhTQMOFmRQifOpG7FHuNzGJQAWZsJ3Y/kxngWKKpBI1WqtVmqtA6wnNo0IyoO2imluR1MZMn6Tux9wwIH+4/TpgIgByjTH8w57gvdrUxkoz3Bft5lsJyEM3QO9BKKEE2/uf2Y4W6wj08jrfwqQgwzoFhmeunXqDXfXpFmq2FPwmLR5/ApnCTX3q1VHhGG6YGfKC4sJrNLCYm/dKnijO9mOjYF3viGQROWTJoR/WrepmJYuiAnO2LJZBiWWZ9GTV8ZUvJNVq62jEKQa2fssxCNVLqtVLQd/qS1bZbIFi5LHsPP8r7/BOSH0/a2UD5ulGzL2Xm8IISK4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=824g7+kxEqx7xAjnmQtN+76+ey3iOW5HhTvWkqXiXbg=;
 b=c9wi67osWkj+pziWFq7FivkcX7QZIqoERdgptHtz2pCHKxxmjiRzkuR/ATwYz/DFuIcLvHlyLOzZw9sHXtsDbXkViashCciauNAHE5ZpJIdYkodo73nfJI0AxQKPEgY5MGp2o97KgbwmI2rGQkh6l8zD4XJQoVay6rNMZMWs4trTSI0pp0w2WNh4M/8qN/5LM8HQmvz1xlW2aOAdO1eZIQx1H2j7uXp7fCY+/c8tF+KMP2XT822EsvB0n94CBQuCBgz6tebg49vuBL+8yMlZyynWAKeqCen+ZfbvbQIRzXcHp4OFvnNMXDNProWbs/6QHD8YiLrWaRhY1DP+nuKUlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=824g7+kxEqx7xAjnmQtN+76+ey3iOW5HhTvWkqXiXbg=;
 b=bvVZPIEnUz5ZSTq3xc/yDh0oHDo40Cflo6McHMHOSbYv2hzq09yoycL1fEZgGHfEgN4LsEsh0htgcj5i6l8qQVfwqY2ElSifcOsByrxZCv0xMwqDBjuLGThz9Ouh1I8O3WjqEWr6LKzBtS09N9eWiO+nkUfDC5J86yyNvEP0Df5rXQcGqgtTLqjVvtBS/sNiwwES5saaBgEb7klDpjhF6gLdA0BFDTj7jvN226AIuM0a66bW1/glcSPtfSeg6/AUdpb+BdSqjPJ1VIRJzeJ6itZhW09jfBphaSSYS30QPILQCROLHVYxTsR/a/BvwY8WUAljjUPwBy963cwFGkLGxw==
Received: from BYAPR02MB5016.namprd02.prod.outlook.com (2603:10b6:a03:69::27)
 by BL3PR02MB8162.namprd02.prod.outlook.com (2603:10b6:208:35d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 12:07:58 +0000
Received: from BYAPR02MB5016.namprd02.prod.outlook.com
 ([fe80::c759:bef6:2ea6:d47a]) by BYAPR02MB5016.namprd02.prod.outlook.com
 ([fe80::c759:bef6:2ea6:d47a%5]) with mapi id 15.20.9228.016; Wed, 22 Oct 2025
 12:07:58 +0000
From: Vincent Liu <vincent.liu@nutanix.com>
To: gregkh@linuxfoundation.org
Cc: dakr@kernel.org, linux-kernel@vger.kernel.org, rafael@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        vincent.liu@nutanix.com
Subject: [PATCH v3] driver core: Check drivers_autoprobe for all added devices
Date: Wed, 22 Oct 2025 13:07:40 +0100
Message-ID: <20251022120740.2476482-1-vincent.liu@nutanix.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20251001151508.1684592-1-vincent.liu@nutanix.com>
References: <20251001151508.1684592-1-vincent.liu@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0128.namprd11.prod.outlook.com
 (2603:10b6:806:131::13) To BYAPR02MB5016.namprd02.prod.outlook.com
 (2603:10b6:a03:69::27)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB5016:EE_|BL3PR02MB8162:EE_
X-MS-Office365-Filtering-Correlation-Id: 8851c3be-2cfd-4c6c-7a7a-08de1163a3ae
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C+dVoDNYaALOJPRbyYi0Ue4VlXHPmar6h4/A0w2s2PY3BU50cTsM2ZGhsZJg?=
 =?us-ascii?Q?06Jdjdh0vZ7LBQje0wOe6pcDp1SNeGRekASPu/5LuND/ikDN1Wk6CtDM/cIv?=
 =?us-ascii?Q?qBPxkOExdYK2+CUrZMou9IOj4kb9mDq/VlY78q/e26KVgCpHcsTayX2xNUWr?=
 =?us-ascii?Q?JKhGecv7uysLLAEVQhIz5vvVSwYIyqShjm7u8dNZHPUkgrk5rA8iXID/giyv?=
 =?us-ascii?Q?UbadtUrOYyXV0KYBIHlr9xDWoiLQryQI4lI+h10xz2oQdP3fD1NElOREUu+d?=
 =?us-ascii?Q?zL5sp+8Dz9zwY5P7xzX2+QsQUh8sIc7S8wb9uvjr6wHYipom7JKst3cV3oxd?=
 =?us-ascii?Q?oK7nCopgen5oHyC8A/qovJxNLU/iQNx5oD3jEjj4Q7/2246SzYyNLeXMMK92?=
 =?us-ascii?Q?LsI0OzttQpB/Wglpbo8lCS2LmecOGMgXvHH+uoH32QzwjMp1/UIEQAdMa3TW?=
 =?us-ascii?Q?UrAkuTuiWxLbCvxYYi0aZZhOTGuAwUOESbjucrHgIiM6a/uYjh8HAXU+9pKs?=
 =?us-ascii?Q?EXcUorMPdOgShL9+bzB0xOPx83XWvcCtGdT/0BLs6YTTAdfVf4dnp/HHaJeE?=
 =?us-ascii?Q?8NQweWXseCyziYmspZZ2hII466jp6MK2DNAWAYJnp/mTQSwAN0WhijN/bro+?=
 =?us-ascii?Q?abhhigzCvCGlC+ctsK2H1l5cUklbg/m+2QI1fx+2cWka8ix+ZQXPETgdDt6/?=
 =?us-ascii?Q?lncWG9Fd2SsV0260g5t1p1oPQYkHiOV+CrljvRXr1UoBw13MNWD6UNc+i0tp?=
 =?us-ascii?Q?8jW8QKE4Tt8+aLiS4momaCBTt8zx21PB+Mga7gyOqKFUf7ug6khAoh6zCWzt?=
 =?us-ascii?Q?Ub35O+6vA4jkkpGnAnR2AS5FRqwpbWrack1uC/TQmBmAuNFUGcKhkV5TBKnE?=
 =?us-ascii?Q?gY2P2TDcRph1IopB5OpMFabKyqzb8n8SAMGGlqjwo/7+r3VN3WOO/XpvuC2A?=
 =?us-ascii?Q?Bj32pB1CLW8WLj9EyGmY9pqOpoVq0gG/Q4Vg4MAVaee7WlUoffqjPN2OIrmn?=
 =?us-ascii?Q?u1lsmORouol1VPx1BhJuZz0SqfIbpwK0haWqffdLIgB6ZjxQavX36jErl6It?=
 =?us-ascii?Q?2W69S1rPkua3+M3g86Bq5Ssk0aQdmlSEsEQeyyVvvk2ZLz3XgKO3uQGWT6/q?=
 =?us-ascii?Q?V0z6UdIkYYGQzyaz71inRb2LKiA6bjI6BTFZjzr8zgX0xjCVSmfmOzQHepGW?=
 =?us-ascii?Q?ejdtkET/N2I1Sk5a9BB6/IqgjW7fnIiIAeqmaCq3Va1L2wrGUaCHH9Z9QbJ2?=
 =?us-ascii?Q?PSZ0Z5JP5A+okGJ3KQ483eDiiybLbOIPElUDaNp2ggbukp4kmm8fsdJ1IYXu?=
 =?us-ascii?Q?AovdkjTAdZZWef8f9SF2DXkX54bPlQfjr59vlc90lws/x5+hnwugUQK61XFl?=
 =?us-ascii?Q?c0z1vC8/BQHN2G5hHRTiK1EtUXU7FrO1xNT0JRIGq/Dhh3AMwg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5016.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(13003099007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0H6kudVT6x6sS/8IZZoZQetsDg354R5s3YiwMS4VtjISis98SFFYEKuXCvJq?=
 =?us-ascii?Q?0vNmW9n3DqMHGUp/zb8v7k8v5Cwh7DghjLmqgdgLDm09POpIr0liq0soP6dz?=
 =?us-ascii?Q?i6Q8dUkaqHyPXBAaPhDDYjnFnwKPfmDImljBM/yDQwzY00AbFti+Pi6M0MI4?=
 =?us-ascii?Q?pODMhvpInP155fvoRDXfy1LAX+1tzBmgmy83kU7WBK4uIH7BIu3Wi0d2O1Lx?=
 =?us-ascii?Q?/dckLKGpkQ+ibABhFSfo4/mGsGfnJW3MOO41JUx4CPuX14K0ctRBb9GKhwBQ?=
 =?us-ascii?Q?YZkd5wFp5i6D7tFzcLp15ISGCaVAu9yKnW9bFEyrOdsnOjj3yxdZzzxuqMr7?=
 =?us-ascii?Q?EydSDVvFH2KCtjZi6hT+4pMYWzOyOlIcXRuy9KinbJZMB4J0cTYUka8/2RUX?=
 =?us-ascii?Q?dQ8NBuIJHLmKHiB5fwdAVUtzZ3nmKZCNSBa5VbkH/YVkad6Hu94NC8jEsUFT?=
 =?us-ascii?Q?BRX/qBH0t+s820OcK/+dHSWBXyimCePhVcdgicRAatVuFyLAdqy9RV1QTOLX?=
 =?us-ascii?Q?2A8bStyCUzyF3nqm+SHW4XL6nWJyF1d4Qs98oPwuqrwwRxK9LQ3y6mcNW1DP?=
 =?us-ascii?Q?KUvyKZdZ/cj8WGPpZoY7+8cRIcNcQTX1Pymwy1j1iwMT4gKbP0saG5yiJwlP?=
 =?us-ascii?Q?AUJtCFP86ynlaVlW/jIqXbfCyS3zssPAzedc9OV+b56v+2qZ7gG4+3O1YEUI?=
 =?us-ascii?Q?cJdTXx+vT9knlkoHEbCC5I0QMrU6gDhm7R/wG7MZv2x2I5u3Xt57MMLoh82+?=
 =?us-ascii?Q?4jV7JQv0IJlBBJKnBcGu+37s7XtA4V6hAOSWOgnEyDcDKNQoC1+2y9QzBWzA?=
 =?us-ascii?Q?1yIRlANFWOVH2Hn+TfvxZm+69siCw9T0k/PCvUCSocb1gbUZCPjF0hjLy59u?=
 =?us-ascii?Q?AvOadbFyFeNABym2BKn5yhXfGDa01fqE4KtLyWRcB5Ma7VL9Zqse+ozjAKOd?=
 =?us-ascii?Q?yrX8xR4CdU/5jabo0un7c1RLrVLFVy+VpNEtiDS+Fglno1uxzVoKQTs0KDl1?=
 =?us-ascii?Q?1e9QI74ot7oqqLqaYvLPEfC85D9zoSwxs4MlAUrGLD6ItCiujblgSEm8UDlH?=
 =?us-ascii?Q?NQyZwVQKH9WxHKycdcS8XZ0gA0PndcIVLUx76a4oGjm98XvbyLyyc3aT3ST7?=
 =?us-ascii?Q?AwHQ/PO9taCBlF1RjbxRsHrPVQrNrR9bPlUp4SBE/v3w4FMPKrWNA9LxteQE?=
 =?us-ascii?Q?Og2LJX2a+JHNBnMp79eMqLC9rYrl9ztmYSAaAjkt6glMxD78fzmfmwbDuTyu?=
 =?us-ascii?Q?WlXEcBkOzeyUh4hzVYtWJP2lu28yRvncQNqrdms0dG4dusudtDX5AuZSSoh6?=
 =?us-ascii?Q?btUPlDtyRMwUTPh6zoCjZx53R46cnxbv3kmrLTKu9fJa9eWwzWCK7pix7luM?=
 =?us-ascii?Q?LhAyPlfoBrrWmBDlUmuQr/Lu1kzSIaIeficRRBlD32QEk86Ebz2XgubRAvA0?=
 =?us-ascii?Q?j3f1JhEiXxzH6LNsMU4C1m5GgkKVG44XBYVwSsTz3e2QqGJ2Yr8t4u/KqaX2?=
 =?us-ascii?Q?tSZUVBtxDRUb69sWI3Jxm9h/4t1Cboa8isHjcr/xHY98W1GsuwE/X7Spgp0G?=
 =?us-ascii?Q?lxaA4+CnNZM0EpWevaIwJzpF83w76UpkRDZviDBwPFqaWIf2OyqiJFBD6OFe?=
 =?us-ascii?Q?1Q=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8851c3be-2cfd-4c6c-7a7a-08de1163a3ae
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5016.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 12:07:58.0810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0YITZp9DH+JJKaAQhNX75tPQAE2stboM8fJ21th1JLBF6bcOOtU+yyYlQRVMvmcD5qMLL3N85veLsX23WMj5GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8162
X-Proofpoint-ORIG-GUID: KnGEhYWO0EE-S1UbxviRtXZ5E4wevwjt
X-Authority-Analysis: v=2.4 cv=GsZPO01C c=1 sm=1 tr=0 ts=68f8c920 cx=c_pps
 a=XgnhveegYENUCV48Bsxjpw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=64Cc0HZtAAAA:8
 a=UKb-53nmPGg_TUI14_4A:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDA5OSBTYWx0ZWRfX9mwk1ebw8QT9
 tBaiQj4fWLaFFTz9R/c4fiVFYp+xBES1kkc31RDkFP7gV66ePHU/iaPgd6UdPMeQdIuUxY3XJdW
 kU1KlF9EmGaylnTXRs/ObRGI2islWTBrqsTzzxOAbIRCtqEdaOQ24KvnIOl6etuQLm7lDYkMk3G
 LkACcQTqWVv59iMebwYrogdLK18T4xpnxE5/Dyaj7U2CPATR3Q5hGvUy7FCDVM9TRMmDSO5yjMq
 tCXPOqO8/x0cQRud+y2JLUdqPsfzP2LX7HHVUdYu/spqaAVLr+8dlwGUd4r7NPdha5LDkVdKsf5
 q+R4tmAYBazPP/FUBuPJDcUNH79nxxz1FuSaAWdd/zbgHplJGHN8Tpde1Bn+iy+HEK2g4lBHLyY
 viH+8GW/XJ86KQG1H6/kxPFqS6oFig==
X-Proofpoint-GUID: KnGEhYWO0EE-S1UbxviRtXZ5E4wevwjt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe

When a device is hot-plugged, the drivers_autoprobe sysfs attribute is
not checked (at least for PCI devices). This means that
drivers_autoprobe is not working as intended, e.g. hot-plugged PCI
devices will still be autoprobed and bound to drivers even with
drivers_autoprobe disabled.

The problem likely started when device_add() was removed from
pci_bus_add_device() in commit 4f535093cf8f ("PCI: Put pci_dev in device
tree as early as possible") which means that the check for
drivers_autoprobe which used to happen in bus_probe_device() is no
longer present (previously bus_add_device() calls bus_probe_device()).
Conveniently, in commit 91703041697c ("PCI: Allow built-in drivers to
use async initial probing") device_attach() was replaced with
device_initial_probe() which faciliates this change to push the check
for drivers_autoprobe into device_initial_probe().

Make sure all devices check drivers_autoprobe by pushing the
drivers_autoprobe check into device_initial_probe(). This will only
affect devices on the PCI bus for now as device_initial_probe() is only
called by pci_bus_add_device() and bus_probe_device(), but
bus_probe_device() already checks for autoprobe, so callers of
bus_probe_device() should not observe changes on autoprobing.
Note also that pushing this check into device_initial_probe() rather
than device_attach() makes it only affect automatic probing of
drivers (e.g. when a device is hot-plugged), userspace can still choose
to manually bind a driver by writing to drivers_probe sysfs attribute,
even with autoprobe disabled.

Any future callers of device_initial_probe() will respect the
drivers_autoprobe sysfs attribute, which is the intended purpose of
drivers_autoprobe.

Signed-off-by: Vincent Liu <vincent.liu@nutanix.com>

Link: https://lore.kernel.org/20251001151508.1684592-1-vincent.liu@nutanix.com
---
v1->v2: Change commit subject to include driver core (no code change)
	https://lore.kernel.org/20251001151508.1684592-1-vincent.liu@nutanix.com
v2->v3: Updated commit message to use PCI and include history (no code change)
	https://lore.kernel.org/20251013181459.517736-1-vincent.liu@nutanix.com/
---
 drivers/base/bus.c |  3 +--
 drivers/base/dd.c  | 10 +++++++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 5e75e1bce551..320e155c6be7 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -533,8 +533,7 @@ void bus_probe_device(struct device *dev)
 	if (!sp)
 		return;
 
-	if (sp->drivers_autoprobe)
-		device_initial_probe(dev);
+	device_initial_probe(dev);
 
 	mutex_lock(&sp->mutex);
 	list_for_each_entry(sif, &sp->interfaces, node)
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 13ab98e033ea..37fc57e44e54 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -1077,7 +1077,15 @@ EXPORT_SYMBOL_GPL(device_attach);
 
 void device_initial_probe(struct device *dev)
 {
-	__device_attach(dev, true);
+	struct subsys_private *sp = bus_to_subsys(dev->bus);
+
+	if (!sp)
+		return;
+
+	if (sp->drivers_autoprobe)
+		__device_attach(dev, true);
+
+	subsys_put(sp);
 }
 
 /*
-- 
2.43.7


