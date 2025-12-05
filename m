Return-Path: <linux-pci+bounces-42706-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAEECA95EB
	for <lists+linux-pci@lfdr.de>; Fri, 05 Dec 2025 22:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0294A3053B11
	for <lists+linux-pci@lfdr.de>; Fri,  5 Dec 2025 21:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF122EBB98;
	Fri,  5 Dec 2025 21:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dzvJyO77"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427AE40855;
	Fri,  5 Dec 2025 21:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764969484; cv=fail; b=uwVE7XMkHjQE+3xFvQEAdBMAcGT73zPfkg57AQfgrdVti3tmyfik0DWLZimOFYvcz5+20i3BvPAOLtEiUvYUtY8hgF50mIIB3/c1rXysXqPaRyymCqFdnIfIk4S68tF5etpAD4mveXSSVnUnYWLqwS8U7Y1cub5KXaVbDIsR57E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764969484; c=relaxed/simple;
	bh=SN2+fbgTQB9vFo9tnIagvAI0HrGmwtesgfGdNzKpIqY=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=JdFj8xBQqGKNBQc2Q/vyBYvneTRAurvJ0IFcCX6C+PB2gJd6JJA+qp7rrV7LVOS/Bdgwfl7pTykA2rd59ovONCLFZg14DvE0D4ZStfgMZrGDOXny5O+wNWSW3RuBuMGhjtGJ5J1+ap6b8aP5hRDz2kBS/flRn1g3z2BcOm3VU2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dzvJyO77; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764969482; x=1796505482;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=SN2+fbgTQB9vFo9tnIagvAI0HrGmwtesgfGdNzKpIqY=;
  b=dzvJyO77XgNBhisExG4bvZjOvSDvxyNm6qcMZIKMMAfhIU5ZOWVKyOaA
   tXvfQQ7D1HaawxdQRU8L+Y14/4eXe5wn+yW9VOSGwdcHay0oHAPfQUeIc
   6DO+5qJbJIT+f1bquloM4wHeJ1u4QMA93VuMflNWu5viyf8n9C13FWogE
   dbVqMpdxNGx9wNHtvTEuLbdINssSps83HO5tQ4w4Jf8MqQQw52sQp/OTl
   yhJHzI4t7Hs6vyVVLtSRDh0RwLbRVJqOW3zE3xi5mNmiYXY7HLpZQ30iS
   Blvcx26BQGZinKExI+w9MtwjRSa5B6HRDY6DngdMakGan4SDOkygJoml2
   g==;
X-CSE-ConnectionGUID: 4t30DHmQQD+sxhCMVyOU1A==
X-CSE-MsgGUID: 5MCxMO4NStWcVXeVVgf/8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11633"; a="77694231"
X-IronPort-AV: E=Sophos;i="6.20,252,1758610800"; 
   d="scan'208";a="77694231"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 13:18:01 -0800
X-CSE-ConnectionGUID: KbUt4BApQN6EU2etihgIUg==
X-CSE-MsgGUID: 3nJDPhqkQP24fHfRb7b0bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,252,1758610800"; 
   d="scan'208";a="232770282"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 13:18:01 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 13:18:00 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 5 Dec 2025 13:18:00 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.49) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 13:18:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s2R9cJZ0FRMMyU1o9PV3YwFA2OYl0aQxSAk1t0xWf4a40cPasKuhkqBgVEnoETrcUUAjI72jmkwF7sLSPVYsmsgeMiW9sWQOyWQI5m7xv4fkBc06MNzXizBUAJ7kYVxjY6oOa2MJGlULiNdKOXJ4ZBLZ6mxPDtuCUSS5NSJK9tADW0ZCV7Usjcm+37ZGCl+NWQood0kiXsUaB79Kwrs5H7gVvyZHEGpJmhu24Auj6rLersWQD9zOn+CNSGwPPhEV8y2ONrrwnIN81iCiHTpGRTbZY3MdhIOFfw+k/Pe8QFMZ9ztoCg0ohpkAYFpz1EuA0MSYFktToBJ+igqNGm60/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUM59ZoFmnN1cd/8+X+0KeaVi+tqNid2dJaDoqI/47A=;
 b=ofybpOesIYDrRa1hnUQwXjvRQnlchchtolttlnxfmKGZzEHRJjcBnIiKN+1RyiPUYXKwBzqSFhr5x0+z4Wnm+dDUEYxbmLFZftMoH6L3/bitEVYvdZIGYfJjRM9v3UZVQHF8yGGJITUw/SWUssUY5hkbba4UfhYaED7LUZkXwpqLSV0Bag4Xcq2Q6mwm1WQQyko7EuTjouGIH8foCNiSsbSjUeoZ1+MPbcsxKywph8PUN7ynsNL6oASn8fmtesM2mKMpnChpaDIpc+UozSiWzneXtQHalrt3P4jGv07fRSJJqLyer0uZC+02EzMZ2vLzhwDwCU2pQ+T39BvIjx5yfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL3PR11MB6457.namprd11.prod.outlook.com (2603:10b6:208:3bc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Fri, 5 Dec
 2025 21:17:57 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9388.011; Fri, 5 Dec 2025
 21:17:57 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 5 Dec 2025 13:17:55 -0800
To: Alejandro Lucero Palau <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, <alison.schofield@intel.com>,
	<terry.bowman@amd.com>, <alejandro.lucero-palau@amd.com>,
	<linux-pci@vger.kernel.org>, <Jonathan.Cameron@huawei.com>, Shiju Jose
	<shiju.jose@huawei.com>
Message-ID: <69334c038705b_1b2e100b5@dwillia2-mobl4.notmuch>
In-Reply-To: <143deecb-aa53-42e6-b7eb-91fb392e7502@amd.com>
References: <20251204022136.2573521-1-dan.j.williams@intel.com>
 <143deecb-aa53-42e6-b7eb-91fb392e7502@amd.com>
Subject: Re: [PATCH 0/6] cxl: Initialization reworks in support Soft Reserve
 Recovery and Accelerator Memory
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL3PR11MB6457:EE_
X-MS-Office365-Filtering-Correlation-Id: 451763fd-e2b1-447e-6acf-08de3443c2f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UWF1aXpHNW1JdHk5VkZ3Z2RvQTFjT21DL3FXUndlTHB6NGVMaXRwamtJSE1p?=
 =?utf-8?B?RGQwYkZaMjZXd2FMelJyZFJ2NzRUU0J3Y3BldXJ2ZmY3UWhVei9Qc05yWmV2?=
 =?utf-8?B?MEpYQWpkbWtST3dyN2laOHZFZGtCQ0kyQmozbnYzZUsxL3VFVDY5SUJBek9I?=
 =?utf-8?B?RVZjUHRHV3Nob25lZWg4R1pDK3cvZ3JMeXB6V2twK0FSMFpDYWJTOXd1czdl?=
 =?utf-8?B?YkxWNFh2WEVlQVlkTFpwY0ZzbW1sZm1DeWlFYU5FUEc3clBNMkRwOVA2WU9F?=
 =?utf-8?B?czNGVVFidXpxRDViT3A3cTBRSWJuVG8xdDJmYzFuanYzejFROTV3QjRkeEdz?=
 =?utf-8?B?cmFYYW5IZkJuUnpkeFBhOGd4djlvL2tiUjVlYXJxbEVlQkNYRUxLMXlrSURI?=
 =?utf-8?B?Sk9jZEZzekN2NFdJVVJxOGFlaCt6b3k0Sm9DMjArbmpmZXhnV29scXJNejFS?=
 =?utf-8?B?WlNjRG12Y3JWb3liZTRCdExyL0pmeTlzM0lFalg5MzlJTkVnM2tKcG0vMXh3?=
 =?utf-8?B?UVg4RUxQVHpOdVRHRXJ4ZlVHOEZNRlpSUnM5RS8vTVZhSDdTb2NxcmlVcU5H?=
 =?utf-8?B?dnlYVDczbWVhMVZ4MVBzSXNUQi9OMnpucWc3ZkhFamJUNDVqYTkwYUdER1Yz?=
 =?utf-8?B?R0YwK2NCVzYwLy9xT21jQWNXajRBL1c2ZDJlTm91ajFSMVVzTUZ1V29neUNZ?=
 =?utf-8?B?eXQ4RTdLanRybFdUK2Y5SzZrS2J1M1BPY1g1N0krakVrTENIdy81M2tpdHNn?=
 =?utf-8?B?N2JUY2k0Z2JVNnMyVVJGNGQ4K0xNRTRFdkNjSk1TMnBaYVkxUlJFbG5zNktY?=
 =?utf-8?B?RDFJY3RyQkVWenlTZmE1ZGN3QW55bHptcDZMMG1meXZFM1dwSGY5dXNDQ2pP?=
 =?utf-8?B?WElSaE1kU1RUd09RRG1YNFpxM0xiUnpRRkpUQ25iVmRpV3hrNzBEREQ3ZTJm?=
 =?utf-8?B?c1laTkVsa2F5aTJlQWNVZXgyWlIrWVJWV3Q5NFZubks4TzdwUFg0SDE0Q2hE?=
 =?utf-8?B?OUc0NFhBeHpWZklQaHJ0ajBSWEJmZndKUmZIS2l3eXdEWnk4aUppQkJPTFhJ?=
 =?utf-8?B?a3pzQXQ2S3FXVU1SNk9DVDZoZ3NHa2I0STdrY3VMVndpV3drOFp3SUNzeGlO?=
 =?utf-8?B?SURzd1lWYUk4OHVMT0xGVU9nQnBHeXBXbTdLWW1FMzVYT1VLSGpXZzRUcnox?=
 =?utf-8?B?RXZCbFJ1R2llbVpMUCtxWHM4SStXNWErVlJsMUpiWUt0czRoVk9HcHVKTmw5?=
 =?utf-8?B?VDhRMUFDZTUyL0ZBOThPdml1aVY3UDZ1SEk4TnlQeVA3MWkydForU1dJdndj?=
 =?utf-8?B?aFdYNEt5V0t3empkSHZnRm5EUW1FN2RqcXduVXVENWl2djRkQlQwYzFmbnFh?=
 =?utf-8?B?aHJQTTMzZzRSSHowZ3BBU0d2VUN4UjVObzY0VkF6bVIyNTE5VHc5Qlc2UENq?=
 =?utf-8?B?MlBlRkQ5eXgwd1J6SXpUb0hNcFJkWmdiSFZ3L2tQcEdlcFRheWMvVHRGT2J2?=
 =?utf-8?B?VDNWcUw3ME1LVEdSUzFrL0xtV3pRM0crS1ZoWFp5UDlXeUY3T29JSWRVM2J4?=
 =?utf-8?B?OEtrOEJZSkUrRTJPbGZpUjIxdms4UDl0aXFqZ092czd4ZWJmR3JaSGVTZlA4?=
 =?utf-8?B?a0VxK2EyaWZFVDhlNzFaU1FiUEsySytpbXNDTXZteUUxQ3R6eHMxVUwzcTZH?=
 =?utf-8?B?b0Z4ekMvSDZnQXVLckxoNHZmdDFUa2l6KzJUV1V4dm9oWXR1ejBlVkd0bVkx?=
 =?utf-8?B?eDREQW5mblNHdERxdGpXMnJQbS94S21GQm5temRENUdFV3h1TkJjRU95b2ZT?=
 =?utf-8?B?RHo1U3JEamQ3amtuaThNeUtEWU00aGlqc1NhbDR4amxPV09BNjhqbnVSd3Iw?=
 =?utf-8?B?M2pkL2FvcWFqQmlnYU5RL25YckEyMmZ4UWVmSU0vdFNlcEhKSFhEZWpOUnB0?=
 =?utf-8?Q?rwgVk2LzzxtCj6+/yXDG3I2dEfXh6aMw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFVvL1VkMWgxK0JoVWhUR3lBTUFITEtkNHhCY05VNnF5TndMNEVndmtxOEV3?=
 =?utf-8?B?RUcxcGh2OXdyUUthcTZIK1k3Q3FISGwremNrVExjZUoxeGZNMzJONnpaYTJZ?=
 =?utf-8?B?NTQzdUUvUGF2NUcwbC9NVHBkdE1qcnJrWW01L2NUeG1pZGZzcHNNeEsvMnZN?=
 =?utf-8?B?cU1vWTdycWYrQ0o3VXFSOWdTeWdET1dvNUNFQlF6eDNPUStaVHVOcFBib3Q2?=
 =?utf-8?B?cHNCYUlrSzRkdVpSSExRdkF3emRJUnFQZkNqbTVBQWEvcGFZK3czVUFQWEFj?=
 =?utf-8?B?NzZTOEVBWHBVS0htV1dCWUx4S3g2SjgvUkYvSy9iQW5xYnFpK1V3dm4rclJJ?=
 =?utf-8?B?WkpZWWlLVmRKbVZzblduL3ZPOGlhYk1NNThLRURyYWYzOHpxQnQyOUM4RGZk?=
 =?utf-8?B?RHA0bFZGR3Q1QmVYR0pLRm55QThaa09GVTg3a3cwdGxnTHlJeVM1RWRnNDdM?=
 =?utf-8?B?d3ZZWnhOcjQwQjJBblEwZlU5enBtWkM5ZjhpVDEwOXZVWVRDeGZwUWxVcFJR?=
 =?utf-8?B?aFRsUnZjWWJRV0hxMnhsdEdtbTk1aGk2VU96UGZiUE92OEpkdlF3MWpOaTlH?=
 =?utf-8?B?RDdNSHAvNlJRQlR3aTJGTnVDMWlxNzZuZHo1MEJRWGsrc000Q2N6dWtld1dW?=
 =?utf-8?B?WDFvNjBoalZBTmFvT0crQ2Z2V2NzQ1VXWXRROW5OYmxGTzNFTTBsZ2RMbXlH?=
 =?utf-8?B?eExxdSttWW5nNHhZQWRUL0I4MTVwZWYrR3hJTVpKUThSVU5ocytvSVVkTG1n?=
 =?utf-8?B?NlV3akJTbG9TUlJYTEhiNU9KT3oyQ0ZPdmRrSlFHejBFdGxPbWdtVFJXZFJx?=
 =?utf-8?B?S1lmRUpNdVYvMU1haThmenJRbnVUVDBXZlBDVDlsQTQ0MkxzSG5PZUs2VWE3?=
 =?utf-8?B?NU10UmNYZEdxdUEydHBxbGkyZ1c3MWNNUVZFc0pLNUdydUJXU25qb0Nzcmor?=
 =?utf-8?B?MHFVQmowZW8yenlpTGlvdXJUcEh2Zk9zQmc0TEwvdW9XSkJnVFRUdmhBUHRh?=
 =?utf-8?B?TWJPQW04OE0xK2Z1cVNlTHBUS1MwdDE5eUdMbkU3WDZNalNQYTJhNlpVWUta?=
 =?utf-8?B?aUNuOEpuSE94eTk3QmJCUmxsYlVRYlFnZ1hzYlRFQVBOdUR0Z0k4NVV4SThD?=
 =?utf-8?B?Z0tDczhOMmJ6MC9ENTBrS2F6ZGVNWWdUMUd4aXVPMjBJRTdjTWNQa2R0S0ZI?=
 =?utf-8?B?NUhTbG5PVk4vVE1pT1FuSUhDWEphcURPa2Zwem1Ya3pqQjZUOSsrUjRJbE9i?=
 =?utf-8?B?SDdpdHFRaVE5b0hMWjBnaEVuNG9LL0diUlRFT3BySGgvU3pGTVEwWDdYTlJV?=
 =?utf-8?B?L3pPSVVFNVloSzJzVjdUZnNRWGNjYXFndWI0K0NhSHM3SkIwNUlIUlVDM2Ni?=
 =?utf-8?B?U0p4b0JUdUY5a0ppdk9sbGdwUEsxU1lORjRLNkJEa0tBZGZMdDRNMlN6eGM2?=
 =?utf-8?B?ZTBmbUJQeXJ4UVU2Q2dKM1FBbk1nbXVNL2FXQTJXSnEwWTFSM24ybWxHRUhZ?=
 =?utf-8?B?Z0o3STFyZ2xKWHlOaVZHQmgyb21sMytwU1Nza1FHaEZaVmRuSmRKalFkOXQw?=
 =?utf-8?B?UEpIS0QwUnRqemdyQ1Z0ajlXd1B6K3lkUmpveHU5ZEl1eTUzUkE1UDJTbGdx?=
 =?utf-8?B?bWVjUERvSzhrWjB0eHBZU3ZnRDFGNlFrejZ6R1lBYzAvaVpxSkdQNkdrSlRj?=
 =?utf-8?B?Nmo1T0ZqOXdYUzJvMDRGUXhGRTVYS2lzRDZMS1U4ZGl5MFJ6QVhKeW9zL3Rn?=
 =?utf-8?B?Vk92Q1kwRy9nUGQ0UzJsOW9XcDNTYW5wQ1JEbWoxbzFGaTIrWGJpMlNyNVlQ?=
 =?utf-8?B?MGxiWE1ad2xaVkI0S21RbkVWV29VcDRDdllscVEySlZJcWJDbURlMXo5L1JQ?=
 =?utf-8?B?bW4vMExIb1o5S2ZMQkxXYU1GMEhIZUJCZklRVGt5a21Lb0VlSmJVcThsc0Q5?=
 =?utf-8?B?alFhVWVmazZxQS9LV2xySVh5Wis0WExPZlFZdmJuWFVBaWJEamExeGNZUzFW?=
 =?utf-8?B?cEhWL2RlKzdZV1VXTUlXVHlOZXVRalIyQ0krUVhHNVJJbEVoeTRCNXVPSS9F?=
 =?utf-8?B?UDV0UjhxdTZFaUVOT052YmVCKzlQREdMYTZZdEFuK0ErZmRnTVcrbGdZOEp3?=
 =?utf-8?B?b2ZMK1dXcmFzclVxRFBvKzVtbzBkeHRKVTNnYW80ZC92aTBNWEEzWm1ya09p?=
 =?utf-8?B?T0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 451763fd-e2b1-447e-6acf-08de3443c2f8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 21:17:57.2856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: flBK3Uz1wnGBlMuwj81WaBmHVkdm33rxnlu8Dq1aId3u3Z/gyBJgLgY6KXhNbXxiEQF2mfwfPfHYnPjV2qPWMQfaY5Gpe/hhg8XqqkhtVgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6457
X-OriginatorOrg: intel.com

Alejandro Lucero Palau wrote:
[..]
> > For "Accelerator Memory", the driver is not cxl_pci, but any potential
> > PCI driver that wants to use the devm_cxl_add_memdev() ABI to attach to
> > the CXL memory domain. Those drivers want to know if the CXL link is
> > live end-to-end (from endpoint, through switches, to the host bridge)
> > and CXL memory operations are enabled. If not, a CXL accelerator may be
> > able to fall back to PCI-only operation. Similar to the "Soft Reserve
> > Memory" it needs to know that the CXL subsystem had a chance to probe
> > the ancestor topology of the device and let that driver make a
> > synchronous decision about CXL operation.
> 
> 
> IMO, this is not the problem with accelerators, because this can not be 
> dynamically done, or not easily.

Hmm, what do you mean can not be dynamically done? The observation is
that a CXL card and its driver have no idea if the card is going to be
plugged into a PCIe only slot.

At runtime the driver only finds out the CXL is not there from the
result of devm_cxl_add_memdev().

> The HW will support CXL or PCI, and if 
> CXL mem is not enabled by the firmware, likely due to a 
> negotiation/linking problem, the driver can keep going with CXL.io.

Right, I think we are in violent agreement.

> Of course, this is from my experience with sfc driver/hardware. Note
> sfc driver added the check for CXL availability based on Terry's v13.

Note that Terry's check for CXL availabilty is purely a hardware
detection, there are still software reasons why cxl_acpi and cxl_mem
can prevent devm_cxl_add_memdev() success.

> But this is useful for solving the problem of module removal which can 
> leave the type2 driver without the base for doing any unwinding. Once a 
> type2 uses code from those other cxl modules explicitly, the problem is 
> avoided. You seem to have forgotten about this problem, what I think it 
> is worth to describe.

What problem exactly? If it needs to be captured in these changelogs or
code comments, let me know.

