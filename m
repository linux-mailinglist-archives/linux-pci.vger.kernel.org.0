Return-Path: <linux-pci+bounces-44875-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A4ED217E7
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 23:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 32CCE3002850
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 22:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57A73B5303;
	Wed, 14 Jan 2026 22:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DYsthY4X"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01953ACF0D;
	Wed, 14 Jan 2026 22:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768428487; cv=fail; b=sc15NgkMUPyDvV06SMsrl6eWzzg3/zXchxJNraq8UZFKJv/PQyPaeI+SYadasjIK/Se0+C/I4YNPnDcg5j6WMKP53OnnfGPlimNOKsam7ji3AFkK/5WQRmzA05701oXObzPRIGsIam7YX3OEZZVbOV/dgD6v94dh5jXuDwntMwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768428487; c=relaxed/simple;
	bh=GKaTkag6Tedyb400usR03iHd+6jDq6rYPosxB3NQsLg=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=DeMTqaiQZWs8zD9u06PrZXvSB5bphC+Pzmp6o36senfuRMuNjqBubsoIcdLQTemC91yjgfjUNVkrmS7xBt3VSyk3AGOwcuiVu53LueYqz0BPXEjvlDq+oa/92FrNx/h4laYiAOLAY0gH2vdU13r+iCQW6WEb2o+hnFL9yIr5L/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DYsthY4X; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768428474; x=1799964474;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=GKaTkag6Tedyb400usR03iHd+6jDq6rYPosxB3NQsLg=;
  b=DYsthY4XCPfi0D/jGrR3hUNpphPd0cn7xQVH7iUrIK+5sQqfEWgLSWsu
   /u/jxFUmZVi/zMjBjsM/aMUxDaRZARHTxtVOFRezLn72C919f86Cz0g+K
   EfrANYrgBU5HKXO9uiduwBY9UeSGhTokgXOnS+6lI9RwqmDSLRhyptFVb
   ZInGvdRaD3cQYRC7c/rgBV/9OdhIslDJjjYsj9iZUH5XtgYV6dixybm3f
   DDvBGU1zeKt4p1wHOSz6O174knduuXLfu6pKtBNa5gnQ8PkmQfzosY9KG
   QMixdUVN4XEEyEboD/kku6nV65+lO65tQ29KM/7wpla2dKs9LllMzi7mf
   Q==;
X-CSE-ConnectionGUID: bY6sjF22Qna98KdlK6hIdQ==
X-CSE-MsgGUID: 38MZu3ErSKa5KzHm4ItS8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="69903792"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="69903792"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 14:07:48 -0800
X-CSE-ConnectionGUID: +4JEtvYkR6CGdKDMZrUE4A==
X-CSE-MsgGUID: ggzGFvHeT3+m3fgHuH+nxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="205058640"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 14:07:47 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 14 Jan 2026 14:07:47 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 14 Jan 2026 14:07:47 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.71) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 14 Jan 2026 14:07:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WgcxCZ3aclzw0dX/H4V2z2ywchL8aCq3rcST8cr9djDPxtt9YQvRLOqNiReOLIURpQ77Ea7KHOSE2JusTKNXySZ8+ZRBXI1kgrUZBg4bRk0g/dFZ1pQMMMccqmO8iyBzUVGzWP+T7aTcy2LTUnDVjsIKTYrLI03n5zgRiBNMQSkcR7m3NVZLeF9DJNsOhqPilk3+VPPlPwd+4GWpYllHaP3XJ9EBEBKoKXeDCnp+8xIryCE1WNYhYdDoT/zHSItnCuWV1bCkuivVg1PoIsLb5H/6Li3G/DtoD4vSLWlkG1zZ+HCcyoK6UKf9Uj+uc3cK3iy01tE999oz3T+TAdWL/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dppZwxDGYPdrGzkfoIdldzCasJfs9Hhd2TC2HLLumOo=;
 b=V11q25FdpgAd9Cz9bbu70vtKHnZH4H4y0yPk9mPhlqRQO1k9poAluXlONc0SM2p8Zso1NExSwWfatJjrXAvDiOo7yqgWISB7Y3LLTUQXGG0ohWAKBfQWaI8lg+ZKWysW71sAweNEcWzodGFCVw0NJKNwKmoqW+UmJcjL30UgfqkbxrCjhYFua98Pb49NeZIuUbzlRNIXZVHOd98MbEf3Qnw2Pu1zyil0bOMydRKZwijufO7ku3apsUv0GCQ9iAOKOCCCdlM5t3FBl25aNSXjFMCONG2OwgpHd0ftTHIhrKzethiRhYnV98zmBFTZtYbcUAmSuEtP+zXY9Kf3bq739Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB8708.namprd11.prod.outlook.com (2603:10b6:610:1be::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 22:07:43 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9499.005; Wed, 14 Jan 2026
 22:07:43 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 14 Jan 2026 14:07:42 -0800
To: Terry Bowman <terry.bowman@amd.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<lukas@wunner.de>, <Benjamin.Cheatham@amd.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<vishal.l.verma@intel.com>, <alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Message-ID: <696813ae1d175_34d2a1001a@dwillia2-mobl4.notmuch>
In-Reply-To: <20260114182055.46029-33-terry.bowman@amd.com>
References: <20260114182055.46029-1-terry.bowman@amd.com>
 <20260114182055.46029-33-terry.bowman@amd.com>
Subject: Re: [PATCH v14 32/34] cxl: Update Endpoint uncorrectable protocol
 error handling
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0262.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB8708:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fc88a12-c97a-4885-506b-08de53b95783
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V2NGOTdzSHNBS0RndVpSZVltZWpZVHNVcmYzdUJyTUtTcVN4L2dPREk1NG54?=
 =?utf-8?B?SVNzdFd5MjlpVXlEcXhsUXJORXZLSnV5bmlCQXRJcktGK3FrUXFrUE54dEVz?=
 =?utf-8?B?d3FmQldORkJTZUdCekZNQjBINmREMnlKOCs0Nk15TXE4RWN3dTZibXkvdDIz?=
 =?utf-8?B?ZUxWWWd5QWw4Q0d4UTdJTmZNMDRMUGlSVGlYNjdYdWUvcFlkMjhoN3Q5YkVS?=
 =?utf-8?B?Q3ViZTRzN1ZISTROMUt3TzZJNklXVGRSa1dJMkdPNitzNnQ4b1hWZzlJcURy?=
 =?utf-8?B?aGZVVlNxazBqUlB4ZlZicmxua3RwVHNRUlFCNnh5V1AvQytsT05vYVhqVUp3?=
 =?utf-8?B?VnZwMjhnWEZDQmhxRnNBS0RBN1dtOUFvckp6NXc1dFlRNEJlS0luWlkvTW5O?=
 =?utf-8?B?aWZvem1US25DMkpjRVgxa2FtaXNGd25HTmxhYjlWRFk5YUszTGdYOXVWcEJv?=
 =?utf-8?B?S3MyUWpldnFuWUNZSnk4VnU4NXpsK0tpL0Qwd0ZRNFptWEVyOTk5OUhHdlpG?=
 =?utf-8?B?NDFWd1J1aVMrOGYrb3RVSUdweCs1azVPN1pxTUQyc0xNTFZFSmlpY1pmQVZQ?=
 =?utf-8?B?QWcrTmptNUFMcWdicWtXMWFaMFQvOG01MHpOS0RQbVZQampkUEdnUEZEZkF2?=
 =?utf-8?B?dHY0blBXdEp5MEh2aXptcTVNbmU4MTZtYnplb0F5U29pU2lEb2NwbC9GdkVE?=
 =?utf-8?B?bmdaVGwwVWVwdnhYbTBrK0h3VXFtWUVJdkt0bm4yWE9ScExFbFN6SkJaamQy?=
 =?utf-8?B?eEFxMXAySGdXa2RoaFdhaGczSEZiUjVMOVl2QkxFc09ibWc2cE5xbklaVHJ5?=
 =?utf-8?B?VWVJUk1IZzh6dXhXN0E4VGtVZ0hiTktjaTRFWjNBRFFuN1M2UDFIL0ZwYlUw?=
 =?utf-8?B?eUh2enAydzAwYWFrc05ORWtHa1BhU2NQdVlWWUN3QkVYdWFQSFBsb216SjRQ?=
 =?utf-8?B?MHBrTnZiUzdkRGFmd0N0WkpDakhuVk5VVVp4dGdGZGQycjllNTZINGNFS3RX?=
 =?utf-8?B?U3pYYlhZcFB6UDJzbEdtN25YTTFuUUE3N25GSEROcnhseGNzLzZJbnlJK0hk?=
 =?utf-8?B?TGJiMFZ6a0J4aEdBbnZMckNhWkFQR1BhbFlBa0hRQzUrMDhGYldSVTZoTkd4?=
 =?utf-8?B?VmQzUzBFTzdEYTZ3Z2lTek1KMXZFWDU0NUUrUTdGT2dqQm11Yi9EZ1RFWEdx?=
 =?utf-8?B?K3ZBUW4zaTRuOG5XYXlWOFk4dEFtRHZiUzF1U1BJWVRRYmVJVE5xYTNPM2VB?=
 =?utf-8?B?ekU3VUdqWU9wc0NTOGR2THJHUEh6cWVvaEpCbElpaHBid3hkZlljbHpmcTNj?=
 =?utf-8?B?WFNINWZLaW1yUEhKZ1A2c0ZMNTgvQVh5QVZNMm9jVWRqeE9VbWZUR3FDdDB1?=
 =?utf-8?B?blZBZWxEekh2ekJZZXpLTXZkeDJlNmxpSDdLV3dkN0ZDQ2QxQjNnZmlPYnE3?=
 =?utf-8?B?cGh2R0RVVjZiSU5LQ2VtbTBRK3I3UXlmMG5lMzVrVGRZT1E4YTBhUFR6NE9S?=
 =?utf-8?B?b20rcHZDbktSakh4SlY5QVdLTkQ3aUpneEpGVVNPelUvUmxvQ0hIUCsyaXc1?=
 =?utf-8?B?ZGNLTHlrMmFwN3FMZWFVVmY0NGJrUUlOVjM4RzdsU2JqdjJvWmJ6VUphUDJ2?=
 =?utf-8?B?aGFad0ZnK09CTzkzbHR6bThralJCakl2SUZYRnVtQVNwVnBWNFowSmwwS0Y1?=
 =?utf-8?B?TTN0QWppWENKQjcrMnlYcHJ4UlluL2NsOE14RVl3WDZRSndQTkZzN09ZN0tr?=
 =?utf-8?B?UDJxaTJUME9URGRvQTBJZnQrMGlnOGd0N01CZVRGeW9KOE83NkhTUkZqcnJt?=
 =?utf-8?B?UkdqVTNabS9uQzJVQVBaQlZoKzVtSmozNkpGZzFGcXZaY0lxZ3BCdDI0bVZG?=
 =?utf-8?B?UHNUM3BsVERIOEQ2ZkNHN2twZ3RTNjZnZE5Hc3BKMmF1ZkpFbWRiUkV3VXYv?=
 =?utf-8?B?OGlPQmhpa3Q1TktDcG02K2ZqWkxJVEtkV1JuSG1jY09VNDBsVVdBUlNTYnBU?=
 =?utf-8?B?aTBFMFhuZHJ3QU0wQXVObGRKdCsrczE4Nyt2alR6bGgwSkd1aFhZUE9mZVBR?=
 =?utf-8?B?ajJNUzFhb2tNQkIrM3cyNEdLVG1vbndMUEhucFIxRGlhdGVHSW9BcUhqU3A3?=
 =?utf-8?B?bUI1dzBLU2N3OHd1NUhKU2RqSDVMSk5ud3lZbzM5RTVyZGVBRFU3VWJRdWFE?=
 =?utf-8?B?amc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blpxNngxS1hOMGhKcjdHbVA1b3VQY3UzRnRqdUs3ODhxOWNPRzZ6VFlkVDVn?=
 =?utf-8?B?UisvUGt1aXNpK3FrREl3RlY4SmVObTVxVDVTd3NIMW5Wb3NCTEhsNC9zb01P?=
 =?utf-8?B?UG5YclRab3FFbHk4UkdnQ210YzVjLy94Zlo4Z0NPQVNpUnVYZTYwb250eE1J?=
 =?utf-8?B?cEEyOENKM1BYZWRlMHJISDAvSFBaeXl4SHdaam9VVkNTNUsvVXVtYUh4WUFt?=
 =?utf-8?B?cjN1ME5scE9yNlJMUjk1eVR3SkprOWpOQWpCNFJzQVVJUjFWSzQ3UG5DNVRh?=
 =?utf-8?B?dzFDQ1NIVThRZFZSa29PSHVxaFFuWk5UWWZVKzhLb2xETzJjSHM0SENZQ1d0?=
 =?utf-8?B?WUVXV0RobGpueVQvajBnQVkwU0xDOUczZW1hU0JyVDY1blJSeHZHOCtqSXhK?=
 =?utf-8?B?b25KQWthOFIvWUhMZUdSWGFsT1piYkZvSlMwYkpYN0ZuMVpIUVdvK1hBTXMv?=
 =?utf-8?B?WFl6bnMzNzlSODFhSDFYTGNxaUhJN2RSaUw5QW9hV2hRa3ZXWHhycDg0NVRE?=
 =?utf-8?B?UmY2NzNxcGR3TnlhWTVJenFUWTB5clFHS3FsU0ltUXN4N2pXM2lvQ01wTEdt?=
 =?utf-8?B?MzErdXRCUi9OdlBwTGZtV0lNcnRDRUNDMHhDLy9SRjM3cDlPZVdyeXlyYjB3?=
 =?utf-8?B?d1RjZ2hrM0gxa081MVVpYW94bmZNSWhNZUFOWW5MNkxzUnR3QUxaRy9zeTgv?=
 =?utf-8?B?R2RSSGdlNGMvQzYzLzE5MTJ6VDJVcXVRTWw2VEtLR21URk8wMXVYN1Jpcm5m?=
 =?utf-8?B?azJveVM1VVlTMFVVaS9ldG1hVWdVOFRiWGVUUzNqV2JXSFZENUlHbmhZRU53?=
 =?utf-8?B?cDBicmI5VjEwSmkrZlR1TEVtOCtEUTI0ZUlHUTNPelRUOWhKSEJiTEI4NHZM?=
 =?utf-8?B?eFR0QzRlblUxWlZJNHdyVDNwWFF0Wmt1WXI1ZkdFMEY2UEZBbktYTVYxWFJv?=
 =?utf-8?B?OU1Sd2U2ZS82VUhZc1F2VitWU3ZyM2dTVjAxQUlqbUMwbVhaNDhBeDBzRzMy?=
 =?utf-8?B?a2syeFp4VW9sa1RSeExuTy9wclk0QjZBRHlqT3R6VnZUQWdqU0x1Ukx3YkEx?=
 =?utf-8?B?dkFtR0VoVjFTbTBOc2c3WisybDJ6eFpqd01uRUhqM05NOG9sbURlRVdaZ0kz?=
 =?utf-8?B?T3NtbmlldHB5bVF6dGJ2ZkFVT1VTa3A4SnJYbDlCUlJ1aUsxTjFNV1JESllT?=
 =?utf-8?B?NzBjQkNNZS8xbC8vc2xIcWk3WDhEYU5SR3kveEUwR1Fqdjl0bTFrRzdXUUdM?=
 =?utf-8?B?VkN0NDZtclg0TjVTTHV5UXpoclRrTEEydUdnUjRHMnR0cWFpWEgxeUNDekQx?=
 =?utf-8?B?ckU4UDkvTDVJZ2x2Y1VtaUxRZi9ITlpGdldVSDBEVVJQQVBwdG5SK2tpZEJ1?=
 =?utf-8?B?QWM5TnhpQjFTTjV2R1R4a1Z0dlpTWUJya1NtU3FjL2lDWEE3VjB5U0xyUDJ0?=
 =?utf-8?B?aFV4d1ppeDA5MEhLTWRtNDRsT0tWcXZ0ODAxRXdMeExDOHRzSWxLeW11OHYy?=
 =?utf-8?B?Wk92M2NtMmJXY0ZnUDlzd081YXZSWjRFSS9OTWFlVzBHYmI4QUI4UXovUWo1?=
 =?utf-8?B?SHRxOEgxODZyOElkN3p0anAzdEF0Mkt0cmRhdnNjZTA0T25WU281RENqL09P?=
 =?utf-8?B?QStEU0owNXRuUk1yVVlBWFFwZUM5K1lDWEFQR2NickEvOVh4a0NPMkN3dUcr?=
 =?utf-8?B?Z3ZWczluQ2lIV0xnQVZjRVFYTFllZHcybERnemt0N2tjZUx3a1dqb2xIRHFY?=
 =?utf-8?B?b1FJdWtQYk5TUDg2STZqSVN2eDRHL0lGSHIvZ2JnWHYwdzVPWHpvcWN5aGx3?=
 =?utf-8?B?Y3laQ1ZUbnhVK1J6UVZxZkJKOHFEQkdNQ2FXdmRvQWhtU2d0UzZjRHRVMlJi?=
 =?utf-8?B?Q0hEUEVjUjh3RUQ2VDhwb3dkQjJhdUgrY0lUTW5mTzE3YnVUL2Z6alFLTlBx?=
 =?utf-8?B?My9NVCtlYnFSMkZzOUFTY21PdnBwT3VockpHUXpCOWRHb2JMeStjb2RVZlNa?=
 =?utf-8?B?dWpXeHBXTWhyd1FreFlGbVlUL1RzREhMZUlxaERKZkhLcXpSS1BOcUJWWXFW?=
 =?utf-8?B?MTVyYktOTEhJV0tqOEdxdkRTRnB0NWtleUF4b3YxUTFKL2N0bE41bW42dVlr?=
 =?utf-8?B?WjVvOG1tWkpaSm9ici83c3dUNGNFUjZhMmErU2RRVWlLTG1OcWF0aW9FV0Nq?=
 =?utf-8?B?d0xFWHNyOWhLTlRVaGZRaTZ0S0g2cTlSSkJxcERVRmZMRDlNYWpEaENFZkpI?=
 =?utf-8?B?d3MyUWp5NTkyVjhOM0VLVTB0SkgzbmorNGRWUDFRNVhEWGpEZ0pDUGRpRkJK?=
 =?utf-8?B?ZElFb1h0M3NlT1J4TDhObCtQMitFZU9FOGRUT24xM0pobHVvZHRiZ050TWdM?=
 =?utf-8?Q?ns2HAkinoRhrO0g8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc88a12-c97a-4885-506b-08de53b95783
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 22:07:43.7317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZomUV+pe1+7wkM0+blBy+aDKXAHKtfa0dmOy1ZfCtyr9JpE0QTHMLkxObojzDump8J1ILG27tqx4GiObpG4DUpIyBvA0pxC6jSygYTndW3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8708
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> The CXL drivers must support handling Endpoint CXL and PCI uncorrectable
> (UCE) protocol errors. Update the drivers to support both.
> 
> Introduce cxl_pci_error_detected() to handle PCI correctable errors,
> replacing cxl_error_detected(). Implement this new function to call
> the existing CXL Port uncorrectable handler, cxl_port_error_detected().
> 
> Update cxl_port_error_detected() for Endpoint handling. Take the CXL
> memory device lock, check for a valid driver, and handle restricted
> CXL device (RCH) if needed. This is the same sequence initially in
> cxl_error_detected(). But, the UCE handler's logic for the returned
> result errors is simplified because recovery will not be tried and
> instead UCE's will result in the CXL driver invoking system panic.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
> ---
> 
> Changes in v13->v14:
> - Update commit headline (Bjorn)
> - Rename pci_error_detected()/pci_cor_error_detected() ->
>   cxl_pci_error_detected/cxl_pci_cor_error_detected() (Jonathan)
> - Remove now-invalid comment in cxl_error_detected() (Jonathan)
> - Split into separate patches for UCE and CE (Terry)
> 
> Changes in v12->v13:
> - Update commit messaqge (Terry)
> - Updated all the implementation and commit message. (Terry)
> - Refactored cxl_cor_error_detected()/cxl_error_detected() to remove
>   pdev (Dave Jiang)
> 
> Changes in v11->v12:
> - None
> 
> Changes in v10->v11:
> - cxl_error_detected() - Change handlers' scoped_guard() to guard() (Jonathan)
> - cxl_error_detected() - Remove extra line (Shiju)
> - Changes moved to core/ras.c (Terry)
> - cxl_error_detected(), remove 'ue' and return with function call. (Jonathan)
> - Remove extra space in documentation for PCI_ERS_RESULT_PANIC definition
> - Move #include "pci.h from cxl.h to core.h (Terry)
> - Remove unnecessary includes of cxl.h and core.h in mem.c (Terry)
[..]
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 96ce85cc0a46..dc6e02d64821 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
[..]
> @@ -373,55 +399,21 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
>  
> -pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
> -				    pci_channel_state_t state)
> +pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
> +					pci_channel_state_t error)
>  {
> -	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> -	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> -	struct device *dev = &cxlmd->dev;
> -	bool ue;
> +	struct cxl_port *port __free(put_cxl_port) = get_cxl_port(pdev);
> +	pci_ers_result_t rc;
>  
> -	guard(device)(dev);
> +	guard(device)(&port->dev);
>  
> -	if (!dev->driver) {
> -		dev_warn(&pdev->dev,
> -			 "%s: memdev disabled, abort error handling\n",
> -			 dev_name(dev));
> -		return PCI_ERS_RESULT_DISCONNECT;
> -	}
> +	rc = cxl_port_error_detected(&pdev->dev);
> +	if (rc == PCI_ERS_RESULT_PANIC)
> +		panic("CXL cachemem error.");
[..]
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index acb0eb2a13c3..ff741adc7c7f 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1051,8 +1051,8 @@ static void cxl_reset_done(struct pci_dev *pdev)
>  	}
>  }
>  
> -static const struct pci_error_handlers cxl_error_handlers = {
> -	.error_detected	= cxl_error_detected,
> +static const struct pci_error_handlers pci_error_handlers = {
> +	.error_detected	= cxl_pci_error_detected,

I still feel like we are disconnected on the fundamental question of who
is responsible for invoking CXL protocol error handling.

To be clear, all of this:

  cxl/port: Remove "enumerate dports" helpers
  cxl/port: Fix devm resource leaks around with dport management
  cxl/port: Move dport operations to a driver event
  cxl/port: Move dport RAS reporting to a port resource
  cxl/port: Move endpoint component register management to cxl_port
  cxl/port: Unify endpoint and switch port lookup

Was with the intent that cxl_pci and any other driver that creates a
cxl_memdev never needs to worry about CXL protocol error handling. It
comes "for free" by registering a "struct cxl_memdev".

This is the rationale for "struct pci_dev" to grow an "is_cxl"
attribute, and for the PCI core to learn how to forward PCIE internal
errors on CXL devices to the CXL core.

The only errors that cxl_pci needs to worry about are non-internal /
native PCI errors. All CXL errors will have already been routed to the
CXL core for generic handling based on a port lookup.

So the end state I am looking for is no call to
cxl_port_error_detected() from any 'struct pci_error_handlers'
implementation. Untangle that ambiguity in the AER core and do not
inflict it on every CXL driver that comes after.

I think we are close to that outcome if not already there by simply
deleting this last cxl_pci_error_detected() -> cxl_port_error_detected()
"false dependency".

Now, if an endpoint driver ever thinks it can do anything sane with CXL
protocol error beyond what the core is already handling, then we can
think about complications like passing a cxl_port error handler
template. I struggle to think of a case like that.

