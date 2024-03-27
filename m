Return-Path: <linux-pci+bounces-5231-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A23F88D91C
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 09:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DE5D1F2BE2A
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 08:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019452D047;
	Wed, 27 Mar 2024 08:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="BRaN3qTi"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com [68.232.151.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B487918C36;
	Wed, 27 Mar 2024 08:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.151.214
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711528122; cv=fail; b=iApUtW6uZcr0ObeDhphvDRBmXsVo47yJJGJTInHVToQmi+SHn/ghSNZR/DtRaShLeU0b7o1XC9edgg7h1KUrbwV+Ptmtgxat2jvsxYb7AOSB3kPlHkTyHHEiUp2VKjfA/KG47NxQukLcqMyTGoAQQj3ujNLr1q99tAVtpjCaTpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711528122; c=relaxed/simple;
	bh=7PuyOie70coJ13uibBKu3ZfZsebqSWGG5Gq7ofZ5uVA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Nl6ZuVgRRxh5cyvY9rIxQQZKvNWXD9QAK3xoBcv8XPjU3kGoOe8mWD7Pgm6+iGdvdCpc6RlFDx2wrvCUeSsQvjaTXwEIkv3NMlfykaRktlHKPv5/4dWPU+LwSf5fvbX4jqYPP5fHmXNtTuFThg39j+B4raJ3DRvEY/Fuq9LFyjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=BRaN3qTi; arc=fail smtp.client-ip=68.232.151.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1711528120; x=1743064120;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7PuyOie70coJ13uibBKu3ZfZsebqSWGG5Gq7ofZ5uVA=;
  b=BRaN3qTigqOE6ZYiFAmHIjpFJ6dIiD/l3Or13YGB3Q0pCn4bsvbdZpVi
   P3k3vEImagTmGA8zpXjcjJ8BNLfXwoLgRiLas7ztFMMIfkz+e7mDdrCpP
   usSJYZh8q10DiE40wjurEbeaYiwKCz4VEqO/iU5uAU0NqnZbU6zz84wYm
   iwsiKlP1+/HTyYCGXFX+y9m1YUndW/KB16lcjD3OpX70R/WlVmrjsJ+G1
   opLyH8WtLkqRkTntmzf1jqasRJQAbgRRX7xpbnbR0dRnEHvOouqBInTFD
   bpa29kiul5TisCoEWLv6F4BLq4UOm7xYmonw6+IDAEyYeRzgt1+kMZJGe
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="28169777"
X-IronPort-AV: E=Sophos;i="6.07,158,1708354800"; 
   d="scan'208";a="28169777"
Received: from mail-japaneastazlp17010000.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.0])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 17:27:26 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbx5xM0wp1lRN/2mtohY+3QVUDutXN7g5DmgMZEX/mdDZuDUGfipha4EIHD3CwhepM/M3A0IIA9REwUKzS9D2pKnCHczcEQ9dTnS7Ciaty/2AToZ2p9PSFINiu/LV5/+wrGp8YFmUOP/D4qLUgx4bGB6uznqhgqZk7yv+8ey59HinYA86LsY+Ap6Lgb5gKPfpyNE5nqLnAGkY53LIYqEtPMSNROI9jlyvhtm46P+plRibRUn2UAIxgV3F2hHEZI7yyARAkKX9xZv2RXIOvpAhfyjhI37NHVeH16+MW8txCSGgn/1HnaJSEtbX7okrD6eyuJLaiSK2szR3JDGFSf3QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7PuyOie70coJ13uibBKu3ZfZsebqSWGG5Gq7ofZ5uVA=;
 b=ipfQycZFqE4gjoqlEmfvHeoviqXKsSs7iceAgwSRMEc8mxlaEvUHug/ULRKyEC+pTNbtDPltAYV5Q9vx1aztas3dtj7SG/8BRs1PnD0nfBKIOn8vnCdNYcLd4wRhap5OFBhRvXcn0hTRXuJ8wUWuY27YxM8SRuMlyzx1egHlEHYhFCZ8UWtCh5nUMykMJH1IbZ8NFLWZ9bnhwcHEe3K3Ug9NO9nfQpZGmqgc+heTnvwY0oBmLAwamaJHk9VIEx0n7XPRPuTt7kSDcHM1+suLpYvvjwYRSySdBKz2s32OU0BsHevSxa3iqPYfxfrPkBpq1BZOXRVKOniYqDCzT8jC7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com (2603:1096:604:141::5)
 by OSRPR01MB11617.jpnprd01.prod.outlook.com (2603:1096:604:22e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 08:27:23 +0000
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::c012:6dff:e4f5:5e1c]) by OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::c012:6dff:e4f5:5e1c%5]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 08:27:23 +0000
From: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>
To: 'Dan Williams' <dan.j.williams@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "mj@ucw.cz"
	<mj@ucw.cz>
Subject: RE: [PATCH v3 3/3] Add function to display cxl1.1 device link status
Thread-Topic: [PATCH v3 3/3] Add function to display cxl1.1 device link status
Thread-Index: AQHadFPEocvhHDRYFkS2dWSvCFH3ObFKiSAAgACZwwA=
Date: Wed, 27 Mar 2024 08:27:22 +0000
Message-ID:
 <OSAPR01MB7182C7C9A154F9665A9857EEBA342@OSAPR01MB7182.jpnprd01.prod.outlook.com>
References: <20240312080559.14904-1-kobayashi.da-06@fujitsu.com>
 <20240312080559.14904-4-kobayashi.da-06@fujitsu.com>
 <66032a6fe9e01_4a98a294d7@dwillia2-mobl3.amr.corp.intel.com.notmuch>
In-Reply-To:
 <66032a6fe9e01_4a98a294d7@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9NjRjZTM0NjctMDVhNC00ZTExLWJkNWYtZjQ1ZjA1MjI1?=
 =?utf-8?B?ZDQ5O01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTAzLTI3VDA4OjI2OjQzWjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB7182:EE_|OSRPR01MB11617:EE_
x-ms-office365-filtering-correlation-id: 3cfb617b-2b11-45e2-b455-08dc4e37b9fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 QqHjVkn2tf0lRMU4i+C98lfcMlOSut216c8btc7ZYqOErb3B5nmLgftm/4DWWgDm5H8jl0b/6Z4L46ync1MNYzZoiiws/CPOJ7tMK3pA8+2XgkKKY4ZDYIxs9df616lEhEnkHh8I4YU5R2JUvIp06pUMX4wbIAEeazoPaOi3rAjnabLNzdAcH6DeIrfOcRccEyYf26uwi+o5mmWfGDQN/zV2qHSuD0OlpMICX/7+EsizjqJXC6ym7fwIdV/expcbM+74/pazklH3eeXJm/gfowF+lrbQasxDdsRnYk5ly6vZ9XFXgQOxtC8QJH6ioeedTQOp2lVieZt7jDtwP6u1GdPrD5K5kMr2Q9LO/L/3k6fPIOIDk9zWNKhcNjpnWRNG8LGpIvdGgzKj9GHcFlbnAhytEvDhlu6Bf5Cgmkg1CvdmY/kscKYUGa9c00bT68HqE8CBeWyIwprId0EhABFWoyCC5EJlfs+yShXFFZjfteYSQxaWpGUVPvahKoORZlF2kC8yIfVrQwiV59CulYsiH3/jbt1vKKbAWp+bdeud2sFWTYPPp7MxI/GF9OxTK9xGqUfEk8o//JPzu9cpY9f3198hofH7LB4wPXncK+yeT9ZTS4JfKLvs9NA5022VbBUorkjAyPu6w04ba7JgX+jJOgY9yLlQtaXruK2Sp/EJaHLN1Gn9AbxdVjVj17QrnZ+3
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB7182.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009)(1580799018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WDhmdWlNYkE1M2YxRTdjbkhDQ1JId1RCNzRaQjVaV0tPTENvWGhjNCtDTGJH?=
 =?utf-8?B?WkdCRFFtSi8vTThoazdNczQ0dGxHbFFwNmZBMDYyL3RwLzBxRnNTd2EwaVd2?=
 =?utf-8?B?WWFyeE1EZVhHcnFSL0RBSzBWYnp6RlZBc01NWjIxVnB0Mno1YUJibUNveUVz?=
 =?utf-8?B?cXBqMlRTemMwMmZDYk9QV1JiSWp6RVdMU3Mvcm1hYUhmeUErMWRnNlVlQ254?=
 =?utf-8?B?dFFsSk1kNHJ3ZjJvbnk4VXJvTXRsM2g5NjVkV2FUa3AyUUNqQWVaNTdzeGta?=
 =?utf-8?B?SFdsNzFRMThOTGw5em5Gd0tYUWQ1dzE3US8rOU1KMythclRFUGpKd3RJNmxq?=
 =?utf-8?B?a1kvUkV0UVl1cFYyeXMvVW04ZXk4c2dWTThRZHQwRkdFNmloQ1dDTXlIUWE4?=
 =?utf-8?B?bXNEN0hTL0JlclB5eTN5RVdnNUVleXEzLzBVNVdWNWs3aEZZd3R4RWxyVEVE?=
 =?utf-8?B?NlkyQVcyTVZ4V2xpOHVIWjdKdWdjdTloclMzOEs5emY4Yzl2bVBPT2s5VlVK?=
 =?utf-8?B?NmVacDd6Sm1vaTVjYkdpYldEanVZWVg0b24xeWtNMnhRNlJVRWEzNWpxNFdB?=
 =?utf-8?B?TytjTm84YU5OeE9iVzVFQjh2SHlCSGNsSGZTTXhhcEx3WWlta3YyTk1qc1Mr?=
 =?utf-8?B?WDJ0Y0t6L2JTMlB5a2pTWi9DeHVUb2R2L0I0SVRiYXRFT3hyOERYTTd4blJV?=
 =?utf-8?B?UTJzVWFUL1lLQ2FWb3U4N2JHaDJzb3AyWnhkeFhWVFdGd1Rob3JkbDBNQ2Yw?=
 =?utf-8?B?emNhcDRWT2FCWDdVYmY4Rmo2ZjkyWTl0Y1ZvZ0xTZ0V1dXFEb1JlaDl4TlJ1?=
 =?utf-8?B?VDgxcHVpSmcyNG53TVdQa2R1NGhTUVdubkQ5Y3RhRWtjb2s0Qm1HUTJBbis1?=
 =?utf-8?B?eFNJKzVtUGYrb3hDMXQrWlpLNFNvNDU2SEF1eFlDaXFIdThOSlJwQkRuckhp?=
 =?utf-8?B?dGM3dThzZUljTmtyQStMQzN2U2N1YzZKN2hCZ1B3VENya1B0N212bTRNSi9m?=
 =?utf-8?B?SUFWTmt4a2NFdnRrclBXbGU5ZFJrZDArRlM5N0ZwUTZEQXRySC9pSm5uT3Qv?=
 =?utf-8?B?VWRTWEppVmRuNFVPMzNwdVdwQ2N0ajFmZ0dRWGE5ZnRlQzJQZjhUOG4wWUJG?=
 =?utf-8?B?NVU3WHV6ZVVEYThlVkpUUVh4ekJrMlZpNXptRytXZ2ZyUENWMDZXS0JDdDJP?=
 =?utf-8?B?UVZGN0VOaWJ3dExnUk82WkpnelYxQTFvUFY2R2hiKzNiWE4rNXJpbWIrMjB5?=
 =?utf-8?B?VDMzcmlrVExJR20xeDVwSnVXUXVqV09Vd2g3dE1YRU12a3FsVEF4N241TG9m?=
 =?utf-8?B?OWJoTC9QcTZkWkxVVDhER050VGVWM1kvVXhqWWxSOEtjUzhZLzdVa21YZG02?=
 =?utf-8?B?TkVFRkJ1UmxjV1NjbzA0bDBGcFdCc3RublZuTTBmNXBjWVVhYXk0RnZMd1NF?=
 =?utf-8?B?dVZScGI2VElmZGdHRXNLVFQ2MzFWWkhBdm5OT3ZETzI2TDU3YTZsaGozUUNq?=
 =?utf-8?B?NHdvaGJNV0JhQ0p1Sk03NUpGSjllbEw2ZVlNdjJUQitnVkhzcXVnWUpWUTZz?=
 =?utf-8?B?WWlmR20zb1R4ZjBZczVmWTJFeE1aMmVzb0hKQTFnMm10aDFTTWQrRXA1UW1F?=
 =?utf-8?B?QUFJTFc1YzJtYjFLWW9hOGlmbzFuSEE1VmRUKzZsY1AyTFZlUXN2SitrYU1I?=
 =?utf-8?B?aDUyOXhhcnMrZnhWWlFWM09ZUzRVTENVTWJ2ZEZ1TDJ4cmRocnY5OXN0LzM4?=
 =?utf-8?B?TnlpcHYwVDIzckRjSXlrRmNucVBHYXpvU3ZnaXpMc01yMVNWM0M3ME9xTTZH?=
 =?utf-8?B?M21wNlRuNzRNNjI1R0VKVFV3cWFpQVEwOWRabjVidmV6QmNIbksyS0loTXN6?=
 =?utf-8?B?UzF2SStvY3UreG5Mc0hFdGt5bWtZaVZCUDdKYXBrajdNL0V3K2tKNGRXdGVI?=
 =?utf-8?B?blJzTEMyNXNrU2lHaTluQjBWWjlwVXF3d2pWTEZSVTNhTXpGamlwek5xNTNx?=
 =?utf-8?B?WXo0NStmRnkwcytNNEYySVlVTENjN3piR08zcm04OG9BZkxMZHBEQlNxY2Nr?=
 =?utf-8?B?bFRpQjNiK2JKUElqaDdsTm00TmlndGhOSCtGV0hwb211TW5pN1packc5OHV3?=
 =?utf-8?B?ZE1UNGppaSt1MEhQN2VYSXFOeVpIK3ZxblZzRjViNXdIS25FTmJudTRTQ3N1?=
 =?utf-8?B?elE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	i9JJc9/BATbj56yNxNVFIZEJ7c8+WMPrh84ETRLL8PQeqbn322+d3mhkEkB57EUIJIri/Xvdx+TCOmrYiMD82k75r1ejdcVxJdAvXHA9gp6wvRpaJa3IRPZk8XM18PvcP6NgIdr/mdKtB2LANLe6ho45wRd1pbx5TNZViy+aO5/9RMk2g4wqzqzjujpq6b2pkwIuXptfmjfVj45HW+q9m7WvB8BSacnMU4lD1usPzlEknPb4l6yuX9H/hmYs4NBAlWErBTz9wzc7NDutoO1FFEqJ6FRlQJ5hlhShmou7iS39vFxu3Luk3p/TmcPqfjeajz9tc5bDjb//Vz4mYA122xCFGnGQ//zaYfQM3UXE0lyoPlro8ByatAgJ+00wGGZ10qT6uKDVN6rzPjbe5tP80cDLPn+EgZNUgWtsRx+d5w9Q/sF5jB2i6MWu4Tzgnb4xFpFrPkHC+sPBQJOvnfgV6W3ofN1buWCJ84AuBCj/rvt7ddWWBAnJGJgCiZTg9MTGlwOuY5megIKUW0H0bqFxhHzN6soEfEhtHaYphyPTkhHd1sadqtjSCbGQvYKn9NVRw6YF61ZhFw+OHhyCXD2NPtlmbva81k5P+MjgVZJD0XeW6MiA9kzLeiAH6sRjHDMX
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB7182.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cfb617b-2b11-45e2-b455-08dc4e37b9fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 08:27:22.9979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JS+fYdot5TwEmlzLmpiNSRo9RgMWXMuPvLdRuasApZsiQ237I9H0drGd3XRMX5ztusd1pYIfPI9w6IgqvGWMR48cRs8hwR8QBFeQdmoBwUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11617

RGFuIFdpbGxpYW1zIHdyb3RlOg0KPiBLb2JheWFzaGksRGFpc3VrZSB3cm90ZToNCj4gPiBGcm9t
OiBLb2JheWFzaGlEYWlzdWtlIDxrb2JheWFzaGkuZGEtMDZAZnVqaXRzdS5jb20+DQo+ID4NCj4g
PiBUaGlzIHBhdGNoIGFkZHMgYSBmdW5jdGlvbiB0byBvdXRwdXQgdGhlIGxpbmsgc3RhdHVzIG9m
IHRoZSBDWEwxLjENCj4gPiBkZXZpY2Ugd2hlbiBpdCBpcyBjb25uZWN0ZWQuDQo+ID4NCj4gPiBJ
biBDWEwxLjEsIHRoZSBsaW5rIHN0YXR1cyBvZiB0aGUgZGV2aWNlIGlzIGluY2x1ZGVkIGluIHRo
ZSBSQ1JCDQo+ID4gbWFwcGVkIHRvIHRoZSBtZW1vcnkgbWFwcGVkIHJlZ2lzdGVyIGFyZWEuIFRo
ZSB2YWx1ZSBvZiB0aGF0IHJlZ2lzdGVyDQo+ID4gaXMgb3V0cHV0dGVkIHRvIHN5c2ZzLCBhbmQg
YmFzZWQgb24gdGhhdCwgZGlzcGxheXMgdGhlIGxpbmsgc3RhdHVzIGluZm9ybWF0aW9uLg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogIktvYmF5YXNoaURhaXN1a2UiIDxrb2JheWFzaGkuZGEtMDZA
ZnVqaXRzdS5jb20+DQo+ID4gLS0tDQo+ID4gIGxpYi9hY2Nlc3MuYyB8IDI5ICsrKysrKysrKysr
KysrKysrKysrKw0KPiA+ICBsaWIvcGNpLmggICAgfCAgMiArKw0KPiA+ICBscy1jYXBzLmMgICAg
fCA3Mw0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysN
Cj4gKysrKw0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDEwNCBpbnNlcnRpb25zKCspDQo+IA0KPiBJ
bmNsdWRpbmcgYSB1c2Vyc3BhY2UgcGF0Y2ggaW4gYSBrZXJuZWwgcGF0Y2ggc3VibWlzc2lvbiBi
cmVha3Mga2VybmVsIHBhdGNoDQo+IG1hbmFnZW1lbnQgdG9vbHMgbGlrZSBiNCBzaGF6YW06DQo+
IA0KPiAtLS0NCj4gJCBiNCBzaGF6YW0gMjAyNDAzMTIwODA1NTkuMTQ5MDQtMS1rb2JheWFzaGku
ZGEtMDZAZnVqaXRzdS5jb20NCj4gR3JhYmJpbmcgdGhyZWFkIGZyb20NCj4gbG9yZS5rZXJuZWwu
b3JnL2FsbC8yMDI0MDMxMjA4MDU1OS4xNDkwNC0xLWtvYmF5YXNoaS5kYS0wNkBmdWppdHN1LmNv
bS90Lg0KPiBtYm94Lmd6DQo+IENoZWNraW5nIGZvciBuZXdlciByZXZpc2lvbnMNCj4gR3JhYmJp
bmcgc2VhcmNoIHJlc3VsdHMgZnJvbSBsb3JlLmtlcm5lbC5vcmcgQW5hbHl6aW5nIDggbWVzc2Fn
ZXMgaW4gdGhlDQo+IHRocmVhZCBDaGVja2luZyBhdHRlc3RhdGlvbiBvbiBhbGwgbWVzc2FnZXMs
IG1heSB0YWtlIGEgbW9tZW50Li4uDQo+IC0tLQ0KPiAgIOKckyBbUEFUQ0ggdjMgMS8zXSBBZGQg
c3lzZnMgYXR0cmlidXRlIGZvciBDWEwgMS4xIGRldmljZSBsaW5rIHN0YXR1cw0KPiAgIOKckyBb
UEFUQ0ggdjMgMi8zXSBSZW1vdmUgY29uZGl0aW9uYWwgYnJhbmNoIHRoYXQgaXMgbm90IHN1aXRh
YmxlIGZvciBjeGwxLjENCj4gZGV2aWNlcw0KPiAgIOKckyBbUEFUQ0ggdjMgMy8zXSBBZGQgZnVu
Y3Rpb24gdG8gZGlzcGxheSBjeGwxLjEgZGV2aWNlIGxpbmsgc3RhdHVzDQo+ICAgLS0tDQo+ICAg
4pyTIFNpZ25lZDogREtJTS9mdWppdHN1LmNvbQ0KPiAtLS0NCj4gVG90YWwgcGF0Y2hlczogMw0K
PiAtLS0NCj4gQXBwbHlpbmc6IEFkZCBzeXNmcyBhdHRyaWJ1dGUgZm9yIENYTCAxLjEgZGV2aWNl
IGxpbmsgc3RhdHVzDQo+IEFwcGx5aW5nOiBSZW1vdmUgY29uZGl0aW9uYWwgYnJhbmNoIHRoYXQg
aXMgbm90IHN1aXRhYmxlIGZvciBjeGwxLjEgZGV2aWNlcw0KPiBBcHBseWluZzogQWRkIGZ1bmN0
aW9uIHRvIGRpc3BsYXkgY3hsMS4xIGRldmljZSBsaW5rIHN0YXR1cyBQYXRjaCBmYWlsZWQgYXQg
MDAwMw0KPiBBZGQgZnVuY3Rpb24gdG8gZGlzcGxheSBjeGwxLjEgZGV2aWNlIGxpbmsgc3RhdHVz
IFdoZW4geW91IGhhdmUgcmVzb2x2ZWQgdGhpcw0KPiBwcm9ibGVtLCBydW4gImdpdCBhbSAtLWNv
bnRpbnVlIi4NCj4gSWYgeW91IHByZWZlciB0byBza2lwIHRoaXMgcGF0Y2gsIHJ1biAiZ2l0IGFt
IC0tc2tpcCIgaW5zdGVhZC4NCj4gVG8gcmVzdG9yZSB0aGUgb3JpZ2luYWwgYnJhbmNoIGFuZCBz
dG9wIHBhdGNoaW5nLCBydW4gImdpdCBhbSAtLWFib3J0Ii4NCj4gL2hvbWUvZHdpbGxpYTIvZ2l0
L2xpbnV4Ly5naXQvcmViYXNlLWFwcGx5L3BhdGNoOjExNzogdHJhaWxpbmcgd2hpdGVzcGFjZS4N
Cj4gICAgIHcgPSAodTE2KXN0cnRvdWwoYnVmLCBOVUxMLCAxNik7DQo+IC9ob21lL2R3aWxsaWEy
L2dpdC9saW51eC8uZ2l0L3JlYmFzZS1hcHBseS9wYXRjaDoxMzA6IHRyYWlsaW5nIHdoaXRlc3Bh
Y2UuDQo+ICAgICB3ID0gKHUxNilzdHJ0b3VsKGJ1ZiwgTlVMTCwgMTYpOw0KPiAvaG9tZS9kd2ls
bGlhMi9naXQvbGludXgvLmdpdC9yZWJhc2UtYXBwbHkvcGF0Y2g6MTU4OiB0cmFpbGluZyB3aGl0
ZXNwYWNlLg0KPiANCj4gZXJyb3I6IGxpYi9hY2Nlc3MuYzogZG9lcyBub3QgZXhpc3QgaW4gaW5k
ZXgNCj4gZXJyb3I6IGxpYi9wY2kuaDogZG9lcyBub3QgZXhpc3QgaW4gaW5kZXgNCj4gZXJyb3I6
IGxzLWNhcHMuYzogZG9lcyBub3QgZXhpc3QgaW4gaW5kZXgNCj4gaGludDogVXNlICdnaXQgYW0g
LS1zaG93LWN1cnJlbnQtcGF0Y2g9ZGlmZicgdG8gc2VlIHRoZSBmYWlsZWQgcGF0Y2gNCj4gLS0t
DQo+IA0KPiAuLi5hbmQgdGhpcyBwYXRjaCBzaG91bGQgd2FpdCB1bnRpbCB0aGUga2VybmVsIGNo
YW5nZSBpcyBhY2NlcHRlZCBiZWZvcmUgYmVpbmcNCj4gc3VibWl0dGVkIGRpcmVjdGx5IHRvIHRo
ZSBQQ0kgdXRpbHMgcHJvamVjdCB3aGljaCBkb2VzIG5vdCB3YXRjaCB0aGlzIGxpbnV4LWN4bA0K
PiBtYWlsaW5nIGxpc3QuDQoNClRoYW5rIHlvdSEgSSB3aWxsIHN1Ym1pdCB0aGUgcGF0Y2ggZm9y
IHBjaXV0aWxzIHNlcGFyYXRlbHkuDQo=

