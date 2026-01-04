Return-Path: <linux-pci+bounces-43964-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C497ECF0AA7
	for <lists+linux-pci@lfdr.de>; Sun, 04 Jan 2026 07:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF639300DC8D
	for <lists+linux-pci@lfdr.de>; Sun,  4 Jan 2026 06:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF492D8365;
	Sun,  4 Jan 2026 06:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LpC3yOxv"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010064.outbound.protection.outlook.com [40.93.198.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB73B3FC9;
	Sun,  4 Jan 2026 06:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767508736; cv=fail; b=ElX1N7WvDauGJumw5A+Y8eJJR2CLYMT6mgZ53Bvec29gWPvI250CQ6BC+hVZGspKw72JJAnCcknkCYzndPfSai703RzyQX2YX9Wg6sXS0VchrHUuc613LL5CjrQvf0+QDWGJFuiNG6Vut5WzDbF4mnM5u1LQVFFNqde7dd7qg7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767508736; c=relaxed/simple;
	bh=THnqCmFg0k+fqZlZI7I/okZDAupMvWGhTxJkFJEJ910=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BsBfeB+sf4R6aRE4fiABHZow+3HCorSPUhQwow9icz3nxl8IWMXNTQBNXkkj4XQ0Yf5mLmmsfq5eUieN9h8B91gcEfTGgKW9f2AOR3/OEE+E+s85ElLZ5tcEdKuni8jyOyqYEZgmg1/MbxOZ3EaONKZC8728C7XUj74JEdnJ424=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LpC3yOxv; arc=fail smtp.client-ip=40.93.198.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Of0KJuWriH+S7Px6m7ev40hgb9cyOzXy2TXcJhdOWjojwcDmo9wVazdvR0mWAXxzNaigMQHNYTk3lbDM6VyWW5TIcnMHiWAW5To7HKWye/p4bHs9Qoa8dma5tj8Ir9RVzjhiuFZa9+xwSnFEnYFEVCHO7LsR1jqUNLK3BzDY98vcBpEFVysoDkUfI5rNZ25I/MopSriNVQ1ficpDzk0szCTi0g+ele+SychGVM2bi2QG6aRo86Lvgth2R4Aq2VF9Q1VN8wLs5xxfF0osvt+54L3cfiaRZz3OIDy7REru4yX9UzZp5ImW8cmIKLBt+xBDFr6HtirsVBjinOyl9S7Ajw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JxuIGvruBKd+kpLf5XRYZELfwxfEGpTdNu3Kezfqjos=;
 b=ZzG2c5xfFR2rsPUcU4AqoMNxASwcBmG1D5zynj6OfANTNHxarRdYLoT7WdHPMD1TWxn/iloZiKILZuhA9oL5cdn/PVJMWmkb7Orc+QrgF/fpwuCx803ANlGlXotC49hs1pTbSjOT9hTB8JqRdXPuQUaBRDbiAM9DkRrhzNpnpYjqLtu7SaxBm1UwyaLq+hPzS+f8Dw0Ik4dyiqElh5jEphiVV6wP1nkWzHqPrYeWkHa/Raf/mwySa829+jS+CedgONqwheyBKiViK0D8Dddc/q2ipSRdOFE4NB3gy1ZG8XHOSOBt5FWxB+mC3eZ7+PV1XLKr/TBwHPq9sutgNh4Wsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxuIGvruBKd+kpLf5XRYZELfwxfEGpTdNu3Kezfqjos=;
 b=LpC3yOxv9pnp6ralCOBZ/gBbGUmccMsDqD8UJqvFMmMH4RUIPUH5ppeuyABs03v3GCfqODx4cjYDoNfVSK0iOSwY4fe4Wjj2yLOiK3OLfCNY56fqANgNaD94UBNzSdXuMUF+4bems2dAfsGaeGbZx9II9wNCPyA4SPqYsDNu9k4=
Received: from BL1P223CA0044.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::17)
 by PH0PR10MB997641.namprd10.prod.outlook.com (2603:10b6:510:386::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sun, 4 Jan
 2026 06:38:51 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:5b6:cafe::56) by BL1P223CA0044.outlook.office365.com
 (2603:10b6:208:5b6::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Sun, 4
 Jan 2026 06:39:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Sun, 4 Jan 2026 06:38:50 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 4 Jan
 2026 00:38:45 -0600
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 4 Jan
 2026 00:38:45 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 4 Jan 2026 00:38:45 -0600
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6046ce6e3188859;
	Sun, 4 Jan 2026 00:38:41 -0600
Message-ID: <e88b31c6716a80e35952faed9484e6702db5a39f.camel@ti.com>
Subject: Re: [PATCH] PCI: j721e: Add config guards for Cadence Host and
 Endpoint library APIs
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <vigneshr@ti.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <bhelgaas@google.com>, <arnd@arndb.de>,
	<kishon@kernel.org>, <stable@vger.kernel.org>, <linux-omap@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <srk@ti.com>, <s-vadapalli@ti.com>
Date: Sun, 4 Jan 2026 12:09:34 +0530
In-Reply-To: <20251226171919.GA4131469@bhelgaas>
References: <20251226171919.GA4131469@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|PH0PR10MB997641:EE_
X-MS-Office365-Filtering-Correlation-Id: dfd94107-dc97-41dc-4f0d-08de4b5bebfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MERsd1ZxeW5yUUsyMTN6cnlvSER6YzZEUmlWNnBSOVVJTWhWWUdzVUJ6R3Zj?=
 =?utf-8?B?MGdPRkZTd0JXL1E2dzk0akZPN0YvN2NFeTRnWjlnZ1A1c1g3dVQzME9BVGlD?=
 =?utf-8?B?NWlrTFgwOURUOUxtalBRVW92c3FyMDRLK0pGblFBTWRmRVZwK05CbG9xUjVE?=
 =?utf-8?B?di9PbXRJK051SjcxTUFnVUFLT0UxR3BvcUxkZlRkRkNQUytIalJGcHlHSnlW?=
 =?utf-8?B?ckl5MWc5VjFYSkJpYmxwOEZEYkJtR0M4MGZOWVZja3UzWEFsUG9Gc1NFVkRT?=
 =?utf-8?B?OUpKVS9TRmJEejJRQUhzVlNpSHdDaksyWGNWR29ydzVUR1dtNTNBeUZURHls?=
 =?utf-8?B?VGgwalMvSy9xaE0vK0R0QzFRYmYvZFVSVzhFMjZ4dnlNanlrbWF6Ukcvekg2?=
 =?utf-8?B?bGRqMWVmdExqclJwZlFScWlnNTBLTkpZdkZFSW55c3pQSjU2YWZVMzlGL2NG?=
 =?utf-8?B?ZFpiNzUyaDZSMVNFL1JsRW85cm91MTI1cjFKM2dKdnRIOXBLTisxSjR4ZkpW?=
 =?utf-8?B?N0c1V3hGNzlmTy9qdnI4RHVrQXJRK2xQQ3Q0d2hpNW9WclVNRnovcFZZTmNn?=
 =?utf-8?B?S3ZvMEtPK2dqWUFRamwrdDNDNTJuU2JaTEdaUS9OMFYwQjBTMHMrTTVJQXcz?=
 =?utf-8?B?NVBuVUUzeE5TOXVhM0lQQ1Rjekc5ZldFK2JBZjFuOGhiMzFZWiszdTBqN2k0?=
 =?utf-8?B?RmVPK1hlbnZtSkNJYTVJbi9mRVY0eDNNYmZnQUxEOWF6MCtyTTNsQkJtV2xS?=
 =?utf-8?B?aG9EZFFIbklvVnNTSHVmakVuWDhtVmpCZFg5eC9NREdBcHoxZjNWN3hYN0cv?=
 =?utf-8?B?RDBCdEo3QXhycEVHR2F4RU9CbUhteWE0bTQwbjJFNWYwdCt3Tis2QzV6eUVF?=
 =?utf-8?B?OC9rdDgrbEVtQUpTVTF0ejErVTVFMTBEQ2wrK3RES0lzTzEwMWhSYW1wQUl3?=
 =?utf-8?B?WXN1ak1xUXZBSjJtU3ErTnJqL2ttOTYxSEdOamVkaVBJWk9IWi9lSE50czFv?=
 =?utf-8?B?Njd0RThZS1pMTmlkNzVNYU0wbkJWYUw3UC9CVlNjY3N5K2ZaMnYydys1d2dL?=
 =?utf-8?B?ZWFERlpEckp6OHJJWkZrbDVZV2dyY2plUTZ0d0QxTWFnU0YydzU5Mjg3Sjho?=
 =?utf-8?B?K1NvT2gvYW5kek5wL1ZqQm9Mc2l0bUNpWDd0VEdpbjI0QkVaazJNUzJocGZI?=
 =?utf-8?B?MGlqa2syYTNWYXBXNVR5a3BQYUtJYWwxOFpKN1lhMEY5ZEd3UVZoT2V4dGha?=
 =?utf-8?B?aWZ1anB3aW9JNTliU3BKWVVqeUhrdU5ZMlpiWHAxOENUUy84OVNUNWZqdWFw?=
 =?utf-8?B?OEJNWkp5ejdaUGtFWGJPTmtZcFhrcDhMNXdFM2VvNXpjMHcrME0yTjc1NW44?=
 =?utf-8?B?RENYUEhSeHEyZTQ1ZlN0U2c0aFpRVHBhQjhRMUdQMENWUWozRzY1bHQ1RXp2?=
 =?utf-8?B?dFZpaHBlUTYzSjFrcVR3UEFSQlQ3M1BuNDNsR1hJQUpWVkhwb3h1RFY1SnJE?=
 =?utf-8?B?R1YrMjVPckllWmRFUzBaZE5hd1JuLzQ1bVhuTE11Sms2Yk5XdnZOSmpnSzB1?=
 =?utf-8?B?SlpIOG9abmRLbU1wZ3JEMkpETlBjeU0raWZNU3E5eHNCREhSYzFSQkIydkh0?=
 =?utf-8?B?WTVaUHkvdjh1Nk9Wb2VWS2o4bWZ2cnNBWGsxeFpkMUxHVUZYOFpuRTRkY3hr?=
 =?utf-8?B?WWN6ckRISG1uZWNqRzkrekdIQ21Wd05uTmhIeGRzTTBMNDBjMEFQRVJ3YURQ?=
 =?utf-8?B?WVhzSXhvbk14YkwxbnpFZDdsNFRzZlNvaDBsR3UxcnBVSlZqNGVyQ1pPaUJ3?=
 =?utf-8?B?dFdteW1TS0prcURNQmZJQmxONUtHVlBwdjFvU2M0c0JWeEFWVjRHd2pkQTRq?=
 =?utf-8?B?WjNyY0R4TlN1Z1NjL2k4MDFVWEhjR0RFY1lSU3VNMmY3M2drM3VJYVVtT0x2?=
 =?utf-8?B?UEhRYkI3bGcwdnNRdWVOZWZyQkRBQ0E3L2gyNnlsOXZuNW5FZzJjUFlKbExB?=
 =?utf-8?B?ckFSTjh5OGVDRW1pZlg5UDVETGppWnIzODh6K0FhNERJRE9naTdZV1JYNyt2?=
 =?utf-8?B?c0ZNQ0U2VGR6c296ekRJQmdwQlJYOE1jYU1oSU93SlF1TUNNMTI2UEhTQjRK?=
 =?utf-8?Q?kOHjarntR2rC2j+BpZIBbaxYU?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2026 06:38:50.5233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfd94107-dc97-41dc-4f0d-08de4b5bebfb
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB997641

On Fri, 2025-12-26 at 11:19 -0600, Bjorn Helgaas wrote:

Hello Bjorn,

> On Mon, Nov 17, 2025 at 05:02:06PM +0530, Siddharth Vadapalli wrote:
> > Commit under Fixes enabled loadable module support for the driver under
> > the assumption that it shall be the sole user of the Cadence Host and
> > Endpoint library APIs. This assumption guarantees that we won't end up
> > in a case where the driver is built-in and the library support is built
> > as a loadable module.
> >=20
> > With the introduction of [1], this assumption is no longer valid. The
> > SG2042 driver could be built as a loadable module, implying that the
> > Cadence Host library is also selected as a loadable module. However, th=
e
> > pci-j721e.c driver could be built-in as indicated by CONFIG_PCI_J721E=
=3Dy
> > due to which the Cadence Endpoint library is built-in. Despite the
> > library drivers being built as specified by their respective consumers,
> > since the 'pci-j721e.c' driver has references to the Cadence Host
> > library APIs as well, we run into a build error as reported at [0].
> >=20
> > Fix this by adding config guards as a temporary workaround. The proper
> > fix is to split the 'pci-j721e.c' driver into independent Host and
> > Endpoint drivers as aligned at [2].
>=20
> If we know what the proper fix is, why aren't we just doing that
> instead of adding a temporary workaround?

The issue appeared (was discovered) since commit [1] mentioned below. After
the issue was reported, and given the severity of the issue (build failure
[0] below), refactoring the driver in the short time frame (issue was
reported close to the end of the merge window) didn't seem feasible.
Therefore, the temporary workaround was posted to address the issue
quickly. I will be posting a series to refactor the driver in a few weeks.

>=20
> > Fixes: a2790bf81f0f ("PCI: j721e: Add support to build as a loadable mo=
dule")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202511111705.MZ7ls8Hm-lkp=
@intel.com/
> > Cc: <stable@vger.kernel.org>
> > [0]: https://lore.kernel.org/r/202511111705.MZ7ls8Hm-lkp@intel.com/
> > [1]: commit 1c72774df028 ("PCI: sg2042: Add Sophgo SG2042 PCIe driver")
> > [2]: https://lore.kernel.org/r/37f6f8ce-12b2-44ee-a94c-f21b29c98821@app=
.fastmail.com/
> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > ---
> >  drivers/pci/controller/cadence/pci-j721e.c | 43 +++++++++++++---------
> >  1 file changed, 26 insertions(+), 17 deletions(-)

[TRIMMED]

Regards,
Siddharth.

