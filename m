Return-Path: <linux-pci+bounces-23045-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E05DA544D0
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 09:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72AE218895DA
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 08:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFAB204080;
	Thu,  6 Mar 2025 08:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="I1763klR"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2108.outbound.protection.outlook.com [40.107.243.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4413F1FCFE2;
	Thu,  6 Mar 2025 08:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741249550; cv=fail; b=AsFY0hWNLDaL+/yigTQ4kOQ0RbchVuSBTxwumqDnN/mzv4fa2jYD+HZMjMa8TGjS/8ZvIgC/Skd7ip8uyGEAgo+Euu8drxsdq2Ia5SIAKcA4JJVCHKKMIAWyeOx/sGkXZC1Jik8ut51vcuKcT8AIv4763y4H9GNruw9pY0sfPcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741249550; c=relaxed/simple;
	bh=UfQry/B+6wpiNcyOsirULDviaxKEyLeBRg18EpyQpqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K3dS9LIgO+03h+Y2Dfq6yl7qzVGQBkRI/G/eH2U8icL1TlIs6iystJlvL7VQ/7aT8k0YmOjZa6dboCYwqukLT4E2mgmuxHQoDU+CH4BpjTIZoHrRM1KWyUBl1A8ogyc1kTabn7V6gYdYJM0TJ/Beaz/WTZGGPBzH2Mdv9gx2Dis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=nephogine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=I1763klR; arc=fail smtp.client-ip=40.107.243.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nephogine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x7DA6LInxRlRmofIwAYcQSN1eva0pQ5ugK6BsY/YwVTvYPLKxhA8eNwiInd7DRxeU50Z4QXXudcxPwJyrDtPR3F+B4ArpLzDkRNU1rDKLY40BHJIJLEXyTQ/BpD9N1e9k/X4oc+VxQfF2hqg1h6nkokiMX968w78uiX+KjTcOeTjIzOaP7yEVYHSmqQW+DZPJA5qEOBqC5viLDn180dg3bg9oA3DEOZScxTuvuVsFN48AjFB0uI9mbmApksyO5HgY9cI1ruT2mGMPMpHVUzqYVxk6ve7+vulrdXVMlVSWzJCOEsYx20FIxabIeRrJvEZRpVvEIlqFrJ9J3QqbrFiHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0P7NccziBOUUmC2+DaG2gBw5lU5pUc9xnppio5Qvvo=;
 b=ScuUMupcRAuoJHxJEy0XFBOod7b3u6uOpPmjPEV6TCkO4G8xKgCkU6wEthIBdbKki+CTCAf1gEneyJwXrqyMnudhFfeMPqPRS5bz9xqlAaVWEREmR7dg71uBm0lCTOatGdE2g4+XaeaS1t9lDaO0NSA5BVSqF0jDQSPbnfzW0CvVcJT58FVSnF5lmJ3AGiGxQxMyo6rKmAUlFQsd+d9Ohr9Jr3br742rytcN3UZAebQ/NezY2IJI666OoGX4x4PFIqzkue+Jzc80uEWiMH1i77S5E/8soypIbB1drd5JMqJcPJPeWhRPbvcs9Dr7ZwHBrUe5nq9Zy/EIJX9fnpKvww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nephogine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0P7NccziBOUUmC2+DaG2gBw5lU5pUc9xnppio5Qvvo=;
 b=I1763klRL/iDhD+cc2z9H3UTe+Qy9aaCP3zmAQ5Qb5ipaFlspLaxAdeAyFwUGIRfHEZDF98cEXnUXfG1xXz4uzuVd10pNkquyE8jr9786Pak+vjaSTMWQLgSNzAJ4tBAEP4NdWc4qgFbLZu4SWuY3E1gExMPQFFkingLrjndoYQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from SJ2PR13MB6402.namprd13.prod.outlook.com (2603:10b6:a03:556::19)
 by DM4PR13MB5906.namprd13.prod.outlook.com (2603:10b6:8:4c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Thu, 6 Mar
 2025 08:25:46 +0000
Received: from SJ2PR13MB6402.namprd13.prod.outlook.com
 ([fe80::b60f:7bf:db6b:5bba]) by SJ2PR13MB6402.namprd13.prod.outlook.com
 ([fe80::b60f:7bf:db6b:5bba%4]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 08:25:46 +0000
From: Bijie Xu <bijie.xu@corigine.com>
To: helgaas@kernel.org
Cc: bhelgaas@google.com,
	bijie.xu@corigine.com,
	karolina.stolarek@oracle.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	mahesh@linux.ibm.com,
	oohall@gmail.com,
	pandoh@google.com
Subject: Re: [PATCH] PCI/AER: Add kernel.aer_print_skip_mask to control aer log
Date: Thu,  6 Mar 2025 16:25:32 +0800
Message-Id: <20250306082532.92696-1-bijie.xu@corigine.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250304232230.GA264709@bhelgaas>
References: <20250304232230.GA264709@bhelgaas>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0169.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::25) To SJ2PR13MB6402.namprd13.prod.outlook.com
 (2603:10b6:a03:556::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR13MB6402:EE_|DM4PR13MB5906:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f7dd09c-4390-45d0-b16d-08dd5c887e17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xEdReFMKHCpBYwToWPq1ixkAOSEX7tLIwr8ggg2UKuZWa0rmZ/0tWhDKcmYX?=
 =?us-ascii?Q?uKtLO6L/kgklHZu8LrjMZS+WJGzp7w4BnCnm5elblJFElawUfXqWXqzWbLDH?=
 =?us-ascii?Q?zCBoiNN9SFQGrJcuwIKvRe2vVUHEKSYNeORYqoPW4Y4L2z1R8aCgSGDWNMz3?=
 =?us-ascii?Q?UJoXSFUSobl5gat6rtK2Io2uVdoj15LjCAuid0U1NiLbWOA3l3OT8CjmRy3X?=
 =?us-ascii?Q?HOvld6FJjRFZjkFWSTZBQYOozYBqfNn2j42IaymYG6Ta1ogvVy2iop0qgoJS?=
 =?us-ascii?Q?Ujmve4Zu5lOVDASocfhl+HHYwMAbzS9cOc6epeTD0/6AJDTSvtPgp6xQ7T/H?=
 =?us-ascii?Q?taYRy9vrMcmm1DWEJAZACNfkS3RLGKLyQMxzKNgVanMLRwYmJJoHhlyo2l4M?=
 =?us-ascii?Q?qZi4jlckipcoJH68rd26GfgrWqV2zvYghzUPD+kMHjqZfABcZ/UPDopsXtFX?=
 =?us-ascii?Q?Copx4SLLMnyJae8crLqPPDN/ahXj1geLy1jjiYKp+dC17fog2y2mYRIcphkI?=
 =?us-ascii?Q?9EksJ39zFAWBhmjUw/XNt7qe79GAOKzJIQ+nmxQSac8iHwce6KncYvJaZRZ+?=
 =?us-ascii?Q?IUmjFyLOQEvN9JWJNZr64RvvWeLePYOuDPNI5ewIZqd0cG+mvWMJLRANB0+A?=
 =?us-ascii?Q?jLGSEtAiFWMpNU7GuSPpYGBd6PfVT9oujJXvXxLJcoLWUqpY/ljs49/9+/iL?=
 =?us-ascii?Q?+MpPWfJASWorCg5dg4scyn0WatCtb5Q6ave9CMkhPU02ShfhjtsSTHt7HCR6?=
 =?us-ascii?Q?TneaYGrA4O1x0QqjAI2Z1UY09CbOVbfrnRgdAUisfag0xvdwzVdbCf2OQ9jy?=
 =?us-ascii?Q?CVlJYmkggg55DAp+a2PGz3YMeQ+WOTFEktKBIvQnGHum+jOKoXruat8nc5Ve?=
 =?us-ascii?Q?C05ouh5TY9X/EcYncbROSDd1NXvcipg0P8yAFTcvqH8x/7WuPELgob99+/YS?=
 =?us-ascii?Q?O2Yj1v2i8zI3ForbFVyclL0grUMN3uiXIwF8UKWgbgxTGkLAqli3uwpRPWWp?=
 =?us-ascii?Q?cO6Lx2Wg45raJc+FV55FebvWN+ycrk/jOQzPnVGpZ4He/B0ExzOZ6+ez7VAs?=
 =?us-ascii?Q?NAl28x1+rEKi5SzWfPQ45w6XBkSldiKqosMqf5/f2iEu77NUd+wHAWPq5hGC?=
 =?us-ascii?Q?0UnGBHXLDx3TkN7Cz4vpIWQZChsSlvd68W9JrtGqMDrLbAvc/kNcl64wRlYj?=
 =?us-ascii?Q?kw33ryuUTLedlDjoKeRHvjDBSPcPpp7DsH+DsiR+dWUMs6uAYgWbzys9P9n7?=
 =?us-ascii?Q?aYdBEbpjti+L0UAZXi2rRXXT5o+Puobzhd+viWsv1Y3AkZLTnbO9glNvvqks?=
 =?us-ascii?Q?7PNMxX9e0o693SsCvUa3/1eVGYM3YCx2O0AgNGd/u9j0lHNXojnI1MlWeBK/?=
 =?us-ascii?Q?xDyVx+9PQArkCm8rG2mbaUlo0p2VGD2a3qdLOq1KKcsTm16r4WkNJI4i7EJT?=
 =?us-ascii?Q?mwz3yLVZKKjD0cizLnwGQlKNo9S8dv/M?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR13MB6402.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bqpvA4K81NN9hFEugn/0hBn0bP4acUhM5GrXyNeE5PE/ETVZfSpW3/1wm/+N?=
 =?us-ascii?Q?HAeeVcK9GN9XinAWHq+tO+jmCmz8UObWU5ETCgxJvBWHtmd9ZKul/l8P9bWx?=
 =?us-ascii?Q?7gRnqDn2Rl/uSBTu8KnrqZTsfpQo5PzWCOXnrQ0I3NBEYezjBbWjJby6yaT1?=
 =?us-ascii?Q?evdfFo8nlzw4GRc5s1yBErgtBPprgVViPfNng6tO+3QS9CJ3Sq9b92e+UrT/?=
 =?us-ascii?Q?y8eOyDI+yYLcx5Vp1kxjSgFGfuRaFvk1+c1YbGlzwYHqhse1vdwvbhN5gOen?=
 =?us-ascii?Q?i6Kwc/jVjNNWbxruoXjM2dPH2Ujd3V3UKV2XtR/Y7D3jHU1iYYa4TG2K+iSU?=
 =?us-ascii?Q?hbJ/XN1zjG7AS876rVfDm+WGWQPFZfUkTQnV7LDcZfF38qX9wcajWz4bBdt0?=
 =?us-ascii?Q?J6gYRMRVg54HiSTAh3jfupYroFgUqoXDOMEmSv9H4V3SeboZDDpQclZnuCTz?=
 =?us-ascii?Q?HvTbed03I+2Xk+pCuWIHKoAjp8/uP+qCo7xwuzgcRB96LOWMvuWmkd+NJEX6?=
 =?us-ascii?Q?HIHQl0ALm8GANIgE4oV+nvYlrZdfyaTOTyjBSjXmKHJH7FOSJyA/7NRwQGHG?=
 =?us-ascii?Q?zyNkZr2HVw1XXh52RICKMWpEoPzFw3IV2IFHlB/2r1wbu2cD+budPvKouoQ6?=
 =?us-ascii?Q?TM2Y/m8bcnkWPMVMj7znN2i0xeoEsJRLXm55g6sdz3pHFvdMziOdUZz2Vl2o?=
 =?us-ascii?Q?5PeUyUgsO+EdsoGTKEXlze67yFex1eVDeo7vISZvJCAOdKEaKN+1es6n2X1j?=
 =?us-ascii?Q?WjgcI+3VizRbpBBMkWYzd9Misiq2lo9/8Q53y8u+SLBG7uov1uX/CFYIQF0f?=
 =?us-ascii?Q?YLwZA1wv184iLAhsOxYXO12CzwZ0zmEHc8kx3fK2u3TNqxXvs4ZRecKNjZkW?=
 =?us-ascii?Q?+qD0oo68bBRnbVypqdD0AE3TifK5NTG6vhJswWgi8Nqd6e4KzJx/FSIIo0m1?=
 =?us-ascii?Q?KYat84jYT9ceserIVDug99gFIMGDCiyc5vIL0hediTRBmIUEx05N27qd2E9H?=
 =?us-ascii?Q?LjoijLhH70/cNZxg6ISG2DQ4kM1UAQo4rAogqo5u+sLO/8BKjfHr8Uq//FKY?=
 =?us-ascii?Q?VyB0PQ/BDK8yYRZHmjjDytdYqyoLqkYXIlxxv3gIq4whYmwt6IPAyiSB4Vpb?=
 =?us-ascii?Q?H3i1S8oKEXFnI3j5M+ZQ6A/7gLQbwbMAGDwFI57WvgrBnN1tqC2FfAVAfM87?=
 =?us-ascii?Q?wpkHhxuNJMuoiV9D2x6Kc90cwRtHiVbvGVV3iP8P5d9U/J/734LZ55V6nKSh?=
 =?us-ascii?Q?m+bGfnxMaZyxq6Wcd8WWNMOST1dzwgMBVOEq3OVTQrrJ2WSl2GshAzORwJ1b?=
 =?us-ascii?Q?ls1Rx9mFkqL72SFX05XVolDNvt6B31q1dm20YRzgtz9a5aa3AHP3mqFG8FFQ?=
 =?us-ascii?Q?4YWwG7xge7jUyqwiPKZThczbmkQ/a9Q0JQMSU8wpWFGLkchoq+tuQ9FrSKCG?=
 =?us-ascii?Q?UUCEauRVIbQ9PQ9JTvqHQYrd9KbNhoTpbBD8DX1yE3xTPcwkH5rG2vejrSP3?=
 =?us-ascii?Q?a+ACioZ2LEOfmwrJ63c3F92JxNZ35V+URgm3L1E8Ar/fKANpYy7/7Q9Thlfw?=
 =?us-ascii?Q?IKXUvAYrn3iEBxhq5ffkGZQ6ONEj2mz2NvhH6XLs?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f7dd09c-4390-45d0-b16d-08dd5c887e17
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR13MB6402.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 08:25:46.0197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qrg02B/GcQMrsHdMchAT+qs9D78vwAxBh4eQ7UnDy9TlDaXlKn0awe4s5wTXw8z8oFXjKodqSFFY/XMgnyIRSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR13MB5906

On Tue, 4 Mar 2025 17:22:30 -0600, Bjorn Helgaas wrote:
> Can you take a look at this and see if it's going the right direction
> for you, or if it needs extensions to do what you need?
Thanks for your suggestion. I've taken sometime to review that patch you suggested. 
It solves part of the problem. And it can set ratelimit on a single device, which
is good. 

But this patch solves the problem in a different way. 

1. Some users are very nervous to notice this kind of error logs. This patch can
give them an option to disable these logs entirely on the whole system level 
instead of just set a ratelimit on a specific device.

2. The sysctl configuration can be persisted after a system reboot. Users may dislike
these AER logs appearing again after a system reboot.

Regards,
Bijie Xu

