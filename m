Return-Path: <linux-pci+bounces-6885-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 262418B76D4
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 15:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 496C21C21D5F
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 13:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA09617167B;
	Tue, 30 Apr 2024 13:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="MJzXmC6S"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2089.outbound.protection.outlook.com [40.107.14.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B66171669
	for <linux-pci@vger.kernel.org>; Tue, 30 Apr 2024 13:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714483196; cv=fail; b=ENUppd5oQz6e+8WBM9aSupAaHj0Wwv4JEtE4FriobX6ZdfrKtipL5qLU93tpZTpTIyMQDl+LkJslkdP4ZGHXNZoPVoV/MbZ3G4gKgfrQesM5cXFkIirUl+MCRN+wcDYxZMcL5qybqHnfJkyLtFzppBf3IRAOA7ZjGYCTs4ZJ1cI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714483196; c=relaxed/simple;
	bh=k1Aaml1h45s5E95RbOUHwoJ+iB36Yz+Qr93p2RmPO40=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FeM8I5ZV9GJlg8xmpKUq0hHkB5eoiy37+xNNA461dIk66vYZO2cMpbKQj5I9L/V/r0ImQSvd6qv3/zQj+9l+B25xcU3R7z1YDs7Dc0SpFzaTXd1Ux5JF2T7NV7piHO3HNFiqa26VEPo3yOOVfZ8dnwkPKR34Z0KglvPNaEeK2lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=MJzXmC6S; arc=fail smtp.client-ip=40.107.14.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YxNpLVzVRlJ9jP/zb8CJlyUrh2ApUaiNds/ErGN6ZZY7PQ4ctlNjt/KtA18/y6eftdtBZvXxOgn9vf2gu22QZM+yrz20Ns6V5fePGl1hqB38eqgE4MkAC23tKxsOfoK3Ejbu2ck35znhuZrXfL1gFmQrsfJ1VPRIJNCVKOBFD0hzc2ZtqI88hTDGeVXHRVN5dXQNrZAlY9n7W/fFeziRRF140S7T0Ho4NCE+wOjXao1cKrwxjSlluAx6P5mW9iyxEkwGv4d4GaX6z+U3xc19doW82kZmQfelUE8D+ekMmVDRQ1QWChWXt+pnFOKEEm4a4KcuM3VUWDjCAWHzvkhr8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4G9jHLDLHEy8L0Mi3zeeCbznHWE7p7AJXuiHstb3guk=;
 b=IYSQnA/NRGdhjDfX+dMxFm/+z47z9QYbR6jXFlT/7YHR3xsYfzTg4AWo27h53fRelsASK0dUNl8mel/Zvs6vqBu3IYGwrGEQyv6XUcW1c47LqCxVH4cDkmwKcHJUtps8FUgPbm1394DuOEg8F0Svl9oY0En0S04rFbrnEwh1IFMcPdLBFQLw/j2HpPr8PxFyYa8dmSR2KDHCo6sPmR0na+erDkcJ5CW8/VobM9bQqXFsu4YGSFQ9izdKMaxSrXsKqAGers4JIvikrASCHkBmMM9nxTunCkxSE0OxvpnbsVhH6sVaZBwqW+89BMF3431xBX/qp0hjO104JXcxzNv8HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=google.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4G9jHLDLHEy8L0Mi3zeeCbznHWE7p7AJXuiHstb3guk=;
 b=MJzXmC6S0z3g32IgISVn9HCiAyhbopphPQDuygARxS5o3PKcJDtzAK6IjX2+tIqdNE6cmZOT3RIkKrnfXerplh8OBjid5AdnwwV39wFaqopNZqwy4sXYWvujGeTeza6+ZN8rLUjqo/OAiUjIz+rj7l4zcuoQ7wP5SRfVZcSwAz8=
Received: from AM6P192CA0012.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:83::25)
 by PA4PR02MB6543.eurprd02.prod.outlook.com (2603:10a6:102:fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Tue, 30 Apr
 2024 13:19:51 +0000
Received: from AMS0EPF000001B7.eurprd05.prod.outlook.com
 (2603:10a6:209:83:cafe::f5) by AM6P192CA0012.outlook.office365.com
 (2603:10a6:209:83::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36 via Frontend
 Transport; Tue, 30 Apr 2024 13:19:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF000001B7.mail.protection.outlook.com (10.167.16.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 13:19:50 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 30 Apr
 2024 15:19:50 +0200
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 30 Apr 2024 15:19:50 +0200
Received: from pc36611-1939.se.axis.com (pc36611-1939.se.axis.com [10.88.125.175])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 4F9CD2444;
	Tue, 30 Apr 2024 15:19:50 +0200 (CEST)
Received: by pc36611-1939.se.axis.com (Postfix, from userid 363)
	id 487C162936; Tue, 30 Apr 2024 15:19:50 +0200 (CEST)
Date: Tue, 30 Apr 2024 15:19:50 +0200
From: Jesper Nilsson <jesper.nilsson@axis.com>
To: Niklas Cassel <cassel@kernel.org>
CC: Jesper Nilsson <jesper.nilsson@axis.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
	<kw@linux.com>, Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-arm-kernel@axis.com>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/2] PCI: artpec6: Fix cpu_addr_fixup parameter name
Message-ID: <20240430131950.GT8743@axis.com>
References: <20240430071054.248008-3-cassel@kernel.org>
 <20240430071054.248008-4-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240430071054.248008-4-cassel@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B7:EE_|PA4PR02MB6543:EE_
X-MS-Office365-Filtering-Correlation-Id: 32d3ef9c-3a12-4ad2-0a79-08dc69183750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400014|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?91nfHEgCw0ltK01ltTJFpppH57p0QSp35W3rfhKvcgNUJCA3R2dFtq+rvWwW?=
 =?us-ascii?Q?vi/r1/58SUdwot3FYtDwvjFs/riZUwV5CXbEydLr3ZmJVnPba2C0MrOYScTw?=
 =?us-ascii?Q?52GbzG784MGKH9a3QHvkXh8kSZhFRk69p9ovz3WryMS59Eacf0UU/7wtCaFg?=
 =?us-ascii?Q?32cl3g8RvlvVqvc2xvbisyqP/+Ij7j5v4Gg1m8jefJ8GkCa7HnFek0QdnBQc?=
 =?us-ascii?Q?3i09vZxVkAC1FrsPMJSRyQPwlL8e/mu2NVojl8cDZ6h1Wf0DUbmc7Omq4SfJ?=
 =?us-ascii?Q?vZl6RKheeys2cziv7f7Z4NyD/9icw257ZXu/LOaKS9t0/J50ROrgM5M/obDt?=
 =?us-ascii?Q?vsFk1e+ZT7SFFA4wN6XQpY/aozxPTQtzqJ2CGoTmW4yEQhU+OY3237uT63Bj?=
 =?us-ascii?Q?+0zwCBeOzAYJV0wCq9MNNyFe+1tJbXT2oxCgwG9rb1xNkL+ojE1QbAfibt/7?=
 =?us-ascii?Q?0/YGeO4ozfMbQvHaE1rJRir8qKc1wLoDRkJNNoIH71d7KxIbvjYpAiyDrYVJ?=
 =?us-ascii?Q?2pH7vAuGYG51/YBYhc/TxndEsU0H/mCudovH2abQGmW1Ea4AlA4+l43whqOk?=
 =?us-ascii?Q?iQsLCZz0r7WvIYniI5aXCqD01aTCYYNMhunB0K2Hqr9srAidyhUAo8CcsE0R?=
 =?us-ascii?Q?4kvoy8GuV66Ca4BYIXsK06lS/Lx5YUa6UcwY1Q4SN5yZ1m0WqtCqlRXgggKW?=
 =?us-ascii?Q?PdQMkJ6DOkrAIZIYCFCW9TaE1a+SqcgUXlG40eM4bIfwfzXKIMdL12uUjDCw?=
 =?us-ascii?Q?lEg8BIiP+Do4FqFa7JLm+j+W0kRD0EdDl/TdydirP+r4mIDRIHTHjbJ1I5s0?=
 =?us-ascii?Q?344x9bA6VnHOZtXsxYQuRWppa6vKlvnZb6E9nAnKpjbA3GCyxeLdeJC4eSfa?=
 =?us-ascii?Q?L2TS00bSgbmovpu00hhsuSa/LpZ8ajoVXLio1ivDkePPnfdv+y7YmAqhhNWn?=
 =?us-ascii?Q?iiTilz3yA1z5mPOVYVPeqbFM7+tOPZmJJC24LViZaDzScW9Rts5z5ohkLf06?=
 =?us-ascii?Q?U7XhbqbkUIMIBoEAhFdN73cPLSpPU5rYvczRTrKf+jQqNrpNqncwJ86jWMAh?=
 =?us-ascii?Q?3VsHPp4qZm5NjCRMIbcpOJ3rZvd5KdaBsCwnLiYFc5j/2kaT9aEjzC2BfiA3?=
 =?us-ascii?Q?lSfYGtWtUeKKy3n7Q8yTVOr62bbTosPTtT/kzDcqZazgGwVvT0Be/N1weqOm?=
 =?us-ascii?Q?hEfe3b3BTGexl4kLVcConuEcch7Z+KzlQOCzZa3njJIc5uud5Z9zQSVXGhuQ?=
 =?us-ascii?Q?vXYPrrK/qRAs5RTAN7SPbQqsc6kby9PRF3zNuO4ktlajyVvBolIs7UX991Sx?=
 =?us-ascii?Q?YbQQlKjsazqxsSssvjejUNLz2AJNJ/sIMwtXprjFoB7fAoD1e4wucQERtKCf?=
 =?us-ascii?Q?yQrisEih+JHc43eg43CZDQG7DDM5?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 13:19:50.7423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d3ef9c-3a12-4ad2-0a79-08dc69183750
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B7.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB6543

On Tue, Apr 30, 2024 at 09:10:56AM +0200, Niklas Cassel wrote:
> The function pointer declaration for the cpu_addr_fixup() callback uses
> "cpu_addr" as parameter name.
> 
> Likewise, the argument that is supplied to the function pointer when the
> function is actually called is "cpu_addr".
> 
> Rename the cpu_addr_fixup parameter name to match reality.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com

