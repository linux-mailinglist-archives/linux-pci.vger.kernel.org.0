Return-Path: <linux-pci+bounces-35076-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 27259B3B070
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 03:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C095C4E101E
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 01:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEF31F0E34;
	Fri, 29 Aug 2025 01:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CJEQ6WOh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060123FE7
	for <linux-pci@vger.kernel.org>; Fri, 29 Aug 2025 01:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756430629; cv=fail; b=r2YHMg7ZreyEZ+yCRRBN1KwlEKZ0L5uatKLxDdNDQdJFy7eJr3ItOHsYhrjxCLxVKhCKK9SKU6UmileSBfAOZcAabhgXlsLtdaYMPCretlQx1H5xDqSHqGgbjdvzAl9n6jU8rbq+4ODKAF0WkEqj1pX7S1baxCDi3B49ia0Zugs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756430629; c=relaxed/simple;
	bh=JGATGt6l55MDGivoH18yfTJbImm+H8itSniy7e0wboU=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=oz4u0SUiVwDRuK3C1pTCEAAna0FwUKYKagLsaCqsGZZxb7F6jmyyVc2oQvkwi9l/37zl4zS5QoKp7VhYEPaF6wG7Yeexmr3dpzPiQyZRM2jMqXVlt0U7QY2yByoRgO7B1/vQUHB7gXx2zAeomu9HXnyuUZy/1ev2Q7X8SeE0b3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CJEQ6WOh; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756430628; x=1787966628;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=JGATGt6l55MDGivoH18yfTJbImm+H8itSniy7e0wboU=;
  b=CJEQ6WOhaDZaokrPzU49LlXC0o0EqVnKVceNo4WAvJgirfvzMdIJB9wn
   ArIuaOo2tSCI2jTOwPdECA4dV5AejH9mw10+eTwrx7CJmPxf9w1U7DOEW
   chWk9cHFzCqutIQ+XnIqBlG4seHZeY+iEOw+jrPlSk5VyHgwQHET99kSW
   Q7S6tFJqQsmqsgNcF+/Unnx4wXqMMxlvszRd8a4mMAszWkYl+JftjQdrN
   IlVcTzoP2sDQDXMr5sSNUzZ2gpuy00AA9W72fnp09CDwnVuBF7x2KtWil
   9ghvWvkuR/NNSEhkZaKU/k5R5XV64xqakg8FMyzaZxxPf9q57F67eq/tO
   Q==;
X-CSE-ConnectionGUID: QgY93q3RQ6yGpX/6u1MaGg==
X-CSE-MsgGUID: ugU8ET3xRI+jGq3obJ7bAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="58565808"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="58565808"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 18:23:35 -0700
X-CSE-ConnectionGUID: QWwwW4hySj2mv+2m9aaJBg==
X-CSE-MsgGUID: AxjNBEpsQ82DWdFDIxcImw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="171054171"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 18:23:34 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 18:23:33 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 18:23:33 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.72)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 18:23:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K9cZTHkywj8D8gmYwn76D8gN6HwuskdNlcQg1gjVO1rbXiTk+BJr3CrDjm3Tyaqxg9f5D3B6c5HcLt2C8cqBUUGYxMusJ9Vw3cMYT2VTHjnAYSLXXxvAq3tWY8+wSkpBQBsoFjzz0wbrNW23LHc9z2DDo92nZG4+Rpmo+kvAx0L1rqXAvGlPmArwJ5Vo0xUxzyIU7IfYn9Ku1XtCo9EIe5w7uBdl1dKxnpATyfqGOir0Cf7S1Sfvh6c+zvSoPs6og7vCX3/XJiVoLQdGrvqVD+ZNyEi2TOMOHr76NiufZizfDlI45vD8folffrRx2U0gNoFETfCAwyBAqFbpTOY8Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kaOvODq9GeACCKYhMBrVWAcqPLMiNQAfPJFg5gjDLoA=;
 b=o+5ySObw16wDoTE8BQkVRwL1qPW8e1jfZZnRQhYJeVJwSW4FW9sUVYJbH6zHa5u6IQ1RF/OfUNt4xg8Nw0vlzydx5Rk7mv50CEJoRg30A2nfMhitWj4+w5h4QwkamJMWcCWCaIhqFwNPdlAu8rJWPQ2YbQrnTSlZq6fs2ZKL4EQEgIWlJ8yugU/PqJB+NS8yQ0lnjc2fH4f00Y0JDLZzo58MhPvFMFsm6mM/5Q+OL8XUKWJdBMDbFOzp6JcEX1hbsprRyzO5N1YdxFSYnZ/gydgi2wAJBennSVvZ7TYdksO3hRWXYpRXNaktCwqcXq+Hms14TvXq2llowwCNUkvk6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB5043.namprd11.prod.outlook.com (2603:10b6:303:96::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Fri, 29 Aug
 2025 01:23:27 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9073.017; Fri, 29 Aug 2025
 01:23:27 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 28 Aug 2025 18:23:25 -0700
To: Alexey Kardashevskiy <aik@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: <yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>,
	<gregkh@linuxfoundation.org>, Lukas Wunner <lukas@wunner.de>, Samuel Ortiz
	<sameo@rivosinc.com>, Bjorn Helgaas <bhelgaas@google.com>
Message-ID: <68b1010dc621c_75db1006e@dwillia2-mobl4.notmuch>
In-Reply-To: <b10c9456-488f-4c92-a855-f086f550d7d5@amd.com>
References: <20250827035126.1356683-1-dan.j.williams@intel.com>
 <20250827035126.1356683-5-dan.j.williams@intel.com>
 <b10c9456-488f-4c92-a855-f086f550d7d5@amd.com>
Subject: Re: [PATCH v5 04/10] PCI/TSM: Authenticate devices via platform TSM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0052.namprd07.prod.outlook.com
 (2603:10b6:a03:60::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB5043:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b6dba58-1479-4ce2-5fd4-08dde69aa7e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z0g3NU5XRG5CcUFxUUMrZ1JDWkxIMVB1WmNhazgzNGdGOGZBWTZJS0l2aUNT?=
 =?utf-8?B?Y3FxNGhhcjV1NVZMZVZFaTFDNlVaMGMvbGlDUFZjNnBhZEN1RE9FRFBoWllt?=
 =?utf-8?B?Vk54Yi9qbytOUlM0MDBIU3E2RWtVeTVxd2pQd2VHYnV3SWxObmJuMzhjOXRW?=
 =?utf-8?B?czlubDRDZ081emdNOURGa2s5Y2R4aTJEZnNCdStlMFFYb0hIbGpybHJLUmZT?=
 =?utf-8?B?NG9MQlg0OEp6ZWtsaTF1eWZFMWdjWVhBUjYxbnpSSHUrRGMwUzhYL1M0QTV1?=
 =?utf-8?B?RVZhRXdHOEtmY2ZJbU5sR05VR0J1bHZ0R1ZyVDA3YmRuRVMvczRRVU1zVC9O?=
 =?utf-8?B?KzBoTU92RmZnNWFXQzJZOHEyK2FQc3pQUEhtbDFjbDBRQXhjb2dVNzlBaXNP?=
 =?utf-8?B?YUk5bG9zckpPSkh6VUFhM2E3NGd3emM0elFHTnZueXI3MTZCREluRS9kUlBR?=
 =?utf-8?B?ZWtrN1FRWWJVaytBMTVTMlM2OW14THRpRmNTVUgwVVpvWkN0dTcxWkwyUFA5?=
 =?utf-8?B?aWpmV1U5STI2QUZyZ1ZsRlhFYzZIbDV2UWJLMTFubDJzdldwSnZNU0lVOGZI?=
 =?utf-8?B?OGJtR3dHK3c4VitsKzdUVjV6MWtDalhCZzBzQmw4Nm9VUnVranNvZ0hNZURq?=
 =?utf-8?B?UG0zR0I5cU82WDVuRENSRUlUeGQ3WEVmNk9jZ1k5Q2tEdE0yQVNHZmV1aENX?=
 =?utf-8?B?TlJxUkVtNEdhdEZJS01kc0dZNExtMnE5RVJoaDFpODZTZnprMTVCUG1CL2J6?=
 =?utf-8?B?cnIxODl6a3dCZ0dRUmEzWjIxM0RiZkhKWlIzV1gwTkh1VjF4WFRySmhtZmJC?=
 =?utf-8?B?eUJhT0FLTHV1MnRQWVBhV21CWlM2T25jSFBhaFdRS1A3ZkJUaC9BdmtFeDVq?=
 =?utf-8?B?VUJ6Ly9EL21BalA3Y21YQjF4S3k3RVBTTDFQWVYvZHJhK2d5Wk9NbDNqc2Y1?=
 =?utf-8?B?MUVSSzNFdTNIU1lKdVJWaXFzK0RCTXA4RTFIWVdwM0FwL3NxbjVuTmdmUzhi?=
 =?utf-8?B?RjVJY2UvVVc4WC80ZWtOR3ErZG5mTGhPam1qeS81a0xvY1NhczJOZDlPVDF6?=
 =?utf-8?B?U0N0TVlqdFZaSTU5VnBLZSt5RERaM2F1K0hQT3VNS25iQXJyWk91cWRmOEJJ?=
 =?utf-8?B?NzlpcXdEVWhndDJ0SGtYT2hEdGREZzVrY2I3R3UzaCtEdHp2TENQQWhPUjBz?=
 =?utf-8?B?WDV6QUdCanhOUE5mL0dydmdMUWQxdFIxYW5qRDM0SFB5MG5aUGpNVy96Vksw?=
 =?utf-8?B?RVBmcGFqK2NCcXVVZllmV0FTYUJRZXNFb2FTTGROL3pRL1NZYys3YVpkMU40?=
 =?utf-8?B?MHBmbG1tcDJzRFdKNUtKWVVabFhjWWFXcHU0YlNwcVNNN0ZaaHhRR2dqLzcy?=
 =?utf-8?B?a3VUZWJUR01pNHlNeVJIajFRYTNaZFpZQSt1MmR2ZitlQ3dJbERhNVRzdDFJ?=
 =?utf-8?B?WnJNeng3YWNmeVNYUy9UMGJ4MTFWT3ZpaEh3bHZiQWVYUjZScjVzQUVReTRF?=
 =?utf-8?B?QTkvTUwxR0MxRUFXQkFUdzIvU01Kai9vM0lsRWFIeGZRSnlPbHhZVHNJWko2?=
 =?utf-8?B?cGFnU3JSL3FtbnUveUJyT2xBdmw1SEREcGJ5U01nd0xqZEY4U3lBcWZab1lZ?=
 =?utf-8?B?Mm1nQ0RqR2JUNk9mYm1EMnhsL0V3d003dk4vSm1LdVdUWXlqSk92K2I4STI4?=
 =?utf-8?B?ZUh6VWdyRktaTHVSd0s4YXBHVzdDeGNkTUJxNWtGWFFYMlZXSktSUG9GVHE5?=
 =?utf-8?B?bk1UbmJjcUQ4c2RXdnJQN2N1dnBWRUNUeHR3VXRVemZHM3cwOXFhUDV3TW1H?=
 =?utf-8?B?WHdJWDVaZjR1Z2I4U0UvYVlDellKS2N6OWl5R2xEeVg3YnFUQTU2aDJEZVRi?=
 =?utf-8?B?YnRkYktDcG5ETjdZNFBYZGRPakwweTJjU3JjTW4zemN0NVRhRDhvWGpKQSth?=
 =?utf-8?Q?qqrAJ6YOxC0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3BFYU5hVXpja0pZZ21SQ2tMWStPOGNPdEpLZFFxcmJSMG5NSmYzVVZQZlBv?=
 =?utf-8?B?MElJYXlxRUpybmQ5L3JjeEVVZUlzd1RId2R6NGI5ZXgxSkRBdi95dTdLaGVR?=
 =?utf-8?B?Qm5tTUpkNUZBV2NDNzhpVW02dStaVkpyVzRjOGxEZXdITlAwdDFKQlB3TFc0?=
 =?utf-8?B?V2Q3L2NIaUNWUk5XcWlWdmZndnZaN1gzZm1rT3hVK08zd0Q2VWk1ck9lQ1Jv?=
 =?utf-8?B?TkFNV245dmtWM0hMVTRKVkFYYmVuZmVtK2JPaXI1cEI4VXJUaVF1eW54QVF0?=
 =?utf-8?B?blFRY2JVK3dlQWtFc0xiWHRNc2tGVzBMS1V1QzZVMzJSWXVDUXhqQWx4Y0JP?=
 =?utf-8?B?U0M2UHFsbHdUaE9LL0tkR0hzbnJPUXl4VDVtUDVXV2ZacEhzRjJkNmZBdW5V?=
 =?utf-8?B?Y0RLQ254akRwT1RnT0s0Q082OTRXK1VFdHh5NytlcVR1eTE0VmVnSnFaSGRX?=
 =?utf-8?B?WjFmc0VaL1l2WE5DVWxzekdUblVGZXRoT1RVM1pveVFIcGZOSThwZ0k4NFZS?=
 =?utf-8?B?RkNjV1VOczBzdUR4SVpJVFErMStra0c3STE4d05NcTJ4K045bHJTK0tCSFRO?=
 =?utf-8?B?TzRBV3dmVXJnTHh1RkNyVkRvaHNsZUhRNFRpQXcyd3phV0o3djE5dlM3dnpJ?=
 =?utf-8?B?UkhuL3VhRGVuQUpvdUhrNGRtSzZRU24wdzExY3BtNUYyMldEMUtRV2ZrRVBV?=
 =?utf-8?B?OExKcERsbGFXOFBMcGNYbWticFBMZ2IzVEZacGxldHFtdzY2bEFnRCtTc1p1?=
 =?utf-8?B?RkhSUEduU3dQcS9rYWowaSswK2hHaDBKOVBtNHRGenJSUm55TzBpaE1GYk45?=
 =?utf-8?B?L2MwdmxoYVIwUEhzQmxCQ0s4bWNwOHdUelRzTVptNElITGVsVVJOd0t1a3Uv?=
 =?utf-8?B?bkJpTTNwOFBRZkw4bmJjSjdMYWFUdExmalJ4dVdYU29QN0FxaVgrcjB2cU1J?=
 =?utf-8?B?RmlCc2dqZ2g1VEVVSEtBaFg1bjVPbUc1QTYvcEc2cm81SGc2a0JRcmt3Ykc1?=
 =?utf-8?B?SnVWekxFRFJHTmFlWUpiTHoxZ29VWG9Hd3pTcFVIYm1RVmRWZm5tN3BLUURy?=
 =?utf-8?B?QUFXaVFodlBMbDJDdXZQUEVLK3I2SUs4RUtCV2lrSHlGNEIzRlh3Lzk1dWt3?=
 =?utf-8?B?WUhXWFRHMFkzaDRmRkFBZ2VKR0R0Wkl3Mk9zTVZUcDlpV2F5ZStrSHcxUTYv?=
 =?utf-8?B?UlVPbFdrVXhUQkpUUTQ3ZnZDTHdQQS9UL0ZZd1laNUJoMnkybm0xNUQvLzEv?=
 =?utf-8?B?cUU3ZTYwQU1rbHU2ZjhBV05WUXBWbWpBYW16c3hqdG9WTHpiMU4vVC9wa3lx?=
 =?utf-8?B?WEJRSW9oS3JBTTIxOHBYRW90cFNjbTJwQUE0Z1Q0RWtPSFk5Qjc2eVY4cnlL?=
 =?utf-8?B?eFpWbDFTTUdpdUZGanpxZHhtRDlQWkpuclFEdHhLQVBrdktPUkQrNHgwaFVV?=
 =?utf-8?B?UGpncWxUcFFZcmd6UWRqVzQ5OHUzUmxZNUdxVzA4dkYwSkkvN2FQWEQ5QVFa?=
 =?utf-8?B?TkI1ekw3d1ZLQ0c0Q3FqTWRBSVN4Ty84RnlPMjNSTlR3b1B3SHdMdVpnVjBB?=
 =?utf-8?B?TGZ2LzFuQWZNZUtZbkFHNnI0YmFEaDdvbXdXSXJ1aWYrWEVCb0RVcERFa2Mz?=
 =?utf-8?B?SlN6UjFaQm9RbGpKemtnVVhHdndLYjRGQzZNcEVkdlk1UlZJb2RtV2NBN1M4?=
 =?utf-8?B?V215V0pJL1J0eGRnck9US0s0VFI1bGRHcFhuUmVJbXFmSGJEdFlqUnM0R0pK?=
 =?utf-8?B?a1NRUnpxWUpKR0Evd0JpUXhneVQ4K2pUWmQzdnBFRHQ5Q25pVHZkTzBpUEpB?=
 =?utf-8?B?aHZaMzlYb1ZQSlBzSXZXRGU0N0FEZXF2VXl3Q0JoWmdmOVRkUnNYdy9BK1k5?=
 =?utf-8?B?TjRjTy80RlZqZUliaHZpZ2JQYW9aalVSR0tmYjRYek14UCtPZVdveGdBYThj?=
 =?utf-8?B?eW5Iby80SVpxVExOc1BxallGSC9YWU85N1ZDMjlQVHdFODB6R0piSTFwRXV4?=
 =?utf-8?B?VWlud2NRUXpoSTAvSk4rNjYwZGNIVUVoVmRYVGRqYVo1bHdtc2RGSE50Zk1n?=
 =?utf-8?B?Z1pDaHFZQjhoUXVJQ2V5V0pYa3JKaFN5MVk0K2V1cnAvLzN2ajlNUDBnaWF5?=
 =?utf-8?B?amtwUGQ2VXRKSDl0RU1TaUxVU3Z6ZDAxUmp4NVhpZkpOQS95ZHpiTkpUckRL?=
 =?utf-8?B?aWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b6dba58-1479-4ce2-5fd4-08dde69aa7e5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 01:23:27.4069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ABySEXs3jP6RFkbU38Rd85YrLwN1UsxgAvetxl19Q9QuOSM2vY5glqG+Zl6pdPw0gVb2ZfjFa3fXPD0TjQT/AIWeM11YwuadFzIPEUMVKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5043
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
[..]
> > +struct pci_tsm_ops {
> > +	/*
> > +	 * struct pci_tsm_link_ops - Manage physical link and the TSM/DSM session
> > +	 * @probe: allocate context (wrap 'struct pci_tsm') for follow-on link
> > +	 *	   operations
> > +	 * @remove: destroy link operations context
> > +	 * @connect: establish / validate a secure connection (e.g. IDE)
> > +	 *	     with the device
> > +	 * @disconnect: teardown the secure link
> > +	 *
> > +	 * Context: @probe, @remove, @connect, and @disconnect run under
> > +	 * pci_tsm_rwsem held for write to sync with TSM unregistration and
> > +	 * mutual exclusion of @connect and @disconnect. @connect and
> > +	 * @disconnect additionally run under the DSM lock (struct
> > +	 * pci_tsm_pf0::lock) as well as @probe and @remove of the subfunctions.
> > +	 */
> > +	struct_group_tagged(pci_tsm_link_ops, link_ops,
> > +		struct pci_tsm *(*probe)(struct pci_dev *pdev);
> 
> 
> struct pci_tsm *(*probe)(struct pci_dev *pdev, struct tsm_dev *tsm)
> 
> as otherwise there is no way to get from pci_dev to tsm_dev (which is sev_device - that thing with request/response buffers for guest requests, etc).

Oh, good point. My sample driver was still stuck in the TSM singleton
universe, indeed this needs to pass the tsm_dev will add, same for
->lock().

> Or add a simple void* to tsm_register() and pci_tsm_ops::probe().

No, let's not give up type-safety unnecessarily.

> Or I can add (which way?) and maintain in my tree. Thanks,

As mentioned in the cover letter for the past few revisions I still have
an open invitation and hope that tsm.git / kernel.org gets to a point
where multiple vendors kernel and VMM trees are unified. So I will spin
an urgent incremental fixup for this, rebase #staging and post a new
devsec-20250828 tag.

I think the shared staging tree will be needed because of the long road
ahead on coming to consensus on all the DMABUF/VFIO/IOMMUFD ABI
concerns. I also want to show 2 vendors merged in that tree before
asking upstream to merge any of this.

If we can get the PCI/TSM core stabilized (2 vendors) and the guest side
encrypted MMIO and DMA details settled (including device-core changes) I
would feel comfortable pushing that upstream while letting the VMM side
ABI discussions continue.

