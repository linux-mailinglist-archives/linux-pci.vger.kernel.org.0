Return-Path: <linux-pci+bounces-22378-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 137F3A44A93
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 19:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABE55880C86
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 18:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4BC19FA8D;
	Tue, 25 Feb 2025 18:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="csF84LJ3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369F519F462;
	Tue, 25 Feb 2025 18:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740507961; cv=fail; b=Y9TbJvZEexE0333nCBmLwprtpP3uBTBCc1X4nTOed8VoiehuPrv0FtlVSctZvSfFlLtoP4mD5TCxURcMvGGs+y7xgiJnC1IXCzBUGYH7hZwgnfVDc8UPwTCKFpBsJ2rKQ6L2mImN3ndijnNnGiyAvvFIDn553DPGDih5lwPyY9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740507961; c=relaxed/simple;
	bh=65s1gRtfbN0YDM3xecvnhYzU6OTWkdn9GAtiXJWLXiI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ukceLoIeTlAH1qGrxkwvW9ONOmkH2sMl+5QH+SlOprcej05lFlzf7NSdGVT3wOnvGV0o+0hU6Quyf6rVTvT2stjnjNt8O+w7H8p9mWBP+t7zxLGGk2IrQQaNi3CbhFlQtLoVQNpWM51hLj9Y5xqVRQAtXs4P1GyEhGvflMpv5fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=csF84LJ3; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740507959; x=1772043959;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=65s1gRtfbN0YDM3xecvnhYzU6OTWkdn9GAtiXJWLXiI=;
  b=csF84LJ3DLOYUy0XMm20Lw3ePUstels8y4XzGasLPUo8wFepIuEa9w0G
   6zDGo2RLcwHVJW88Svrn5+txAVAv0oWB7jiqj+bUkb4b3j06xoqUmoiqk
   rsRk9HubYQokTlLvvvM8OG5Vh2C70q5fwg3KjhU56lzBgXWsP8j/8OMOH
   pQ5AyuSDl9u7WeCnIBVwxDFuwgsaK/SJzECOxb3dCyFftBBNEz+jtW92l
   3TeC8y2riTxxh+1+J1wKkqNnsHwycWUDB1nEIeZLMDEoNjQmzccZCOev+
   agqWgaQef5JWjXwm76LLO5tduQzQ3jSWFoIVZKS3gB67ZYqGJmFqgz1sT
   A==;
X-CSE-ConnectionGUID: sZU3XbRLRXGlhCtzgJC/Jg==
X-CSE-MsgGUID: 6YH6sIKOTDC3Nlzm/tCl7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="51966568"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="51966568"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 10:25:58 -0800
X-CSE-ConnectionGUID: IZoD6YlER9akJvAP1MQ2Ww==
X-CSE-MsgGUID: va/7e9rQQqSV+SxmYbLDQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="153643768"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Feb 2025 10:25:55 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 25 Feb 2025 10:25:55 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Feb 2025 10:25:55 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Feb 2025 10:25:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SOW9uZ2YuSUJZpTNHYoNcTUt7ca+Dzq7fYtHnqmLXWWOS4qhsup0+yY4gZj82AtjY6/5oM4J8NxCbdmyovB+V76Thh9Wz61VhVTjTbeD4x2AL7aJ3Z7yG1H93xWJ76aqbfTahVJWv8DnHDPW2Kpkncox2OTIgcff7EhgosZQuRuFlwEJmetsNI93XKmtuk0f+76wdIgFYkTnAGYaZPlldxSQp2YoYAIm7ewl7wQWY1eOo6pUUV1nfbEO2ogpMXIMCGKntohnY7qNOHiMRV3YdTkFvpXyI/8Uamt6OVuDiKyFCHCaHac4QadYS0t6czjDqg0J2o0ki32zkkLCtMH1tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hb9pwY0QFtC7vo5HaP7IaLZXj3JK/fOMBgGfzyqQK8Q=;
 b=bieGZN5vMAxHO6zbheJ2GPdLpxJ1qv1sBPHzdxoLxAOT5L/lw0fsA9qvAKYrQgSD0K5uVWN4/xbVnIbw5o0/+P/dyxiACHBvHG3Zzu398x7NFbDN/tncD2j2lHGjgoNjZ8F0SK/xJe4cqf/x6Ep+sQH2DIoDh29OGosH443PumN8tmWPa6oVIFILxX+lSJPTEsFn/QwzRvSm276JM0Rk+Tb3gXzNlibDloY92nhrgNAD4mwqVoz7+Nz3GWFKG7jvoTxcedluEU3eeDNB3w2uCOG6u4Hv8N2KOz2nUbjr1cfeaEruIHuS9J4nEhuqqDMhzYG7cfSsC1rRQSkUsTNxdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6211.namprd11.prod.outlook.com (2603:10b6:930:25::6)
 by CO1PR11MB4964.namprd11.prod.outlook.com (2603:10b6:303:9e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 18:25:52 +0000
Received: from CY5PR11MB6211.namprd11.prod.outlook.com
 ([fe80::df5a:a32c:8904:15f1]) by CY5PR11MB6211.namprd11.prod.outlook.com
 ([fe80::df5a:a32c:8904:15f1%7]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 18:25:52 +0000
From: "Gupta, Anshuman" <anshuman.gupta@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "rafael@kernel.org"
	<rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "De Marchi, Lucas"
	<lucas.demarchi@intel.com>, "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
	"Nilawar, Badal" <badal.nilawar@intel.com>, "Nasim, Kam"
	<kam.nasim@intel.com>, "Gupta, Varun" <varun.gupta@intel.com>
Subject: RE: [RFC 1/6] PCI/ACPI: Implement PCI FW _DSM method
Thread-Topic: [RFC 1/6] PCI/ACPI: Implement PCI FW _DSM method
Thread-Index: AQHbhtxCdZS+98LIm0mkid9ksDiCTrNW2k6AgAF2R2A=
Date: Tue, 25 Feb 2025 18:25:52 +0000
Message-ID: <CY5PR11MB62113F649A1AF98D33ACE0AC95C32@CY5PR11MB6211.namprd11.prod.outlook.com>
References: <20250224164849.3746751-2-anshuman.gupta@intel.com>
 <20250224194053.GA471229@bhelgaas>
In-Reply-To: <20250224194053.GA471229@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6211:EE_|CO1PR11MB4964:EE_
x-ms-office365-filtering-correlation-id: af8cecb1-95dd-407c-a26b-08dd55c9d5f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Tya3EOb2jgwJt7k+CkpwPMU03c1hjCxJir2bvpsZxbMcVKUSu89yiKrWX3hW?=
 =?us-ascii?Q?a//X6B02QwFPLd1Y6Cf/4DAVH9EwGSMWaQOEGbaxhhIJf7tPjzsbgvEST7Xh?=
 =?us-ascii?Q?eBfPAucs2klMrbedH518hgTVVK6xuXqJCo2kaLaxjZyNbmAGbksSamdDyy7w?=
 =?us-ascii?Q?1phGZ83IXv+jmaxqdqFiIThemkOse+HBu6pKYNG+da66DJoJC/m4BqtjzH5R?=
 =?us-ascii?Q?JHQp8LvKXdQvybkCTu6Qku2pFbtGaNcoIje/tbZY+JWYKOF0tqaQn+tqwojj?=
 =?us-ascii?Q?AUgfUsSFXwZItjrt1/oXWWl36Kq7Cj1hvpg08dPC6WKGfPODpJgjHT2Nsx96?=
 =?us-ascii?Q?aimQcbYh90A4DhGTdQpkycWiK6T5i5CVgaMKWiFlKWlk2jX9K6uQBVSyVbV1?=
 =?us-ascii?Q?8YY9+unnlRXs15eBxsUQGgtyKBRdPlaPIT0Xt9QwPrKdQk6NFxF518V64ONA?=
 =?us-ascii?Q?nsCTNcdjWhtC5IQqD6YEyHAOX5PWVRona+XWCkdcnwm/83o2KSJU3gl46Pz+?=
 =?us-ascii?Q?slyAxXBnVb1jaBD8N4TcD5kxCaKkIgRBq9iuE0R87I3gvLi+9uFx2J8yh5OD?=
 =?us-ascii?Q?68WNie8qNaJWU6ONVmrgSBLCHgXUbJREQoHZcQiCAoXEcVSzr0jKfO/pRkMJ?=
 =?us-ascii?Q?rgms/EudMg/RqKA1jUlFErXm9T7aueykD+jz+JZi7rjDKa6hVIdV+jHRg8TQ?=
 =?us-ascii?Q?JCRS8jb9ehpZIpUAJGgvM/Wo+I2EoJvnszXSZgcIFQSdij1uz1kYS2hojkyo?=
 =?us-ascii?Q?DwTnuhwXmpbLPcT1PTpyCw5wvc7cW0+Tdh1xusL5hU+cZIKCfhA9TSB8xXCk?=
 =?us-ascii?Q?b5c7PjetdIxnlht8nNZOpVbIaSwQeFOR4vkr6EqhccGzZd8TcFONEITjLbgv?=
 =?us-ascii?Q?oxO2A6YZJgVv+jFdukxLz3zMofIryCfrlNeXQy5+26/GO2En92kQyDQlVssS?=
 =?us-ascii?Q?NLOzZP+W5hxVMqFIueVJ0UFxt9+fATTU1YHdNOWEeRV1NmRkfAIElsGO5BnV?=
 =?us-ascii?Q?8gtn4RaqpXWwaIY0H4lMGFza1IOaN9CfDgIiaYosVaRUDHjtMNdn1aTcBfu9?=
 =?us-ascii?Q?19SgZwKL4tXNc57qr3woINoPEfxtkZTvHwDYirqXHZpu+VRrFOKmlXE/APSt?=
 =?us-ascii?Q?gi1WJc+mntBQSjMS6zOe/Bja4sSvj5CkbjwlzlJ0o7rd5n6bX5pJt4/EhNkW?=
 =?us-ascii?Q?pYV37LdPgRnt1c2MrKeME4lOHCYVEtb1K8S8yQhrsTTu9jOKQ5CKzhMhDzck?=
 =?us-ascii?Q?pADshxcgs4OUDkANjBUZqC3uE1+bnF9dekoTrKrsYmZdLssh2cfmtqRKzstu?=
 =?us-ascii?Q?xp3FqfPFykGw/ItPjWwWaKNUVaXI2ey/sqPsKkwBl1Pyb4hBXrRv4j9gk6cg?=
 =?us-ascii?Q?pZI7YY4phksDEflNmuaJ7a91F51pe1NLhWP17Xq8QjgbOX3taoAzOhHwp3wt?=
 =?us-ascii?Q?SJJ4sLWsnDLZGiXcZs4nDPfeC3rCGa6d?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6211.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8AFeNeoEu2UPjKIp94WeyHw1QluLxUsNY+XSMrvW8ujNAaIJCK4YxWW59Hw1?=
 =?us-ascii?Q?9KlUd2M5dndCvOk2bEq3w+tkj+l5FGd1/LxOHBc1BBNTSHotpgBQZIQSBi70?=
 =?us-ascii?Q?DFDo34vagvyuASwVCk2/Z2C1DITn66pt3K2mc/xrrfuPRUfT4qhqH+Z53ZXH?=
 =?us-ascii?Q?4QmAaTqh0E25h+0DBI15QXxj7zpT+faO3AXhPBH8+7JSPDFHhu7jN87pgqIi?=
 =?us-ascii?Q?fSKfvrtvqdWYVjHVbbTNA/fRgXtEe+FmgEsU2llmDyrhJyycOVQNSzVrPVjI?=
 =?us-ascii?Q?nsKVGm/UGVURIEfOIC6sZd80B6dLFaW6elZnBdVVJ9/JfTOt5MbmP6xKEri+?=
 =?us-ascii?Q?OVrcrD8ZrwagtzZaFQIIRNx3GPOBipg2PVvUUtXmpDiv/MwKqpK8jo9jvuXW?=
 =?us-ascii?Q?JAtuYuSvEZEZS6vXoLXM85VLES6t0kvHoowU/b1F3J8aYXIZVdtDAdvK623g?=
 =?us-ascii?Q?eSV1/LFox7trRGojXfUmtZpdsul8gKRmWMi7lkvMfGw9C+vox2d0GPeYqa4/?=
 =?us-ascii?Q?MAqXhTqPYMDVtyS/w3rtJw4ak94p7Ple9DCuKy6F7vTRXxhP0YlBxgR2+LVQ?=
 =?us-ascii?Q?/ScZuLDJyVpREdMqY/PX7xVvgNTRGk/EbAeRwelYUGmGuX7xNCKtZR1mdIVf?=
 =?us-ascii?Q?zvTrzUmj/d1qPjoHoRkHAUI/GOI6Qf1AuvJmrjX1/7FMmwFFpyh9ip+0bha7?=
 =?us-ascii?Q?00d7WGj2ieYO6e3YEuB0bmHa51ZZvD/YwxCBZ+IPVVPM0/OzdV4PfmBCO+YS?=
 =?us-ascii?Q?VgR/sywJpxInBuJ2JcsWUWpwwE3cMUgiwhkVZLc+1LQxgnKMwYsigWrmybTH?=
 =?us-ascii?Q?OSCCer+lGG4i2CB3sMQXlJhOaHjNfxavx3Q95sY4i2fPSGc4kBOJIq3Xcf2B?=
 =?us-ascii?Q?Bd4zYLlXAFox37tMydHpeCQNjAt+xv33EHB2p1bhVzxlKX1C/qcthLUok2/0?=
 =?us-ascii?Q?rwbgC775ohbgYhu7gbGBUj4a2YKdsk3ABtwIKoBk8PwgR9VnxvlErQ75yi4y?=
 =?us-ascii?Q?prQHSGGldhecWCIdyOJAQFhqCQl8SSSF6f6h5VVQsYKTYD2gMrTEm1Ai4+6C?=
 =?us-ascii?Q?kru1uhDgP1P9Lm1nD2iR+cOGfe4mSUAX59OvnQlM+/vyUuyon1OBtIefsqb0?=
 =?us-ascii?Q?M96m8vdHynqcduUhA2f8zEf9AMU0k0x8YAG10izenh/SuDnD459KiIYQeNaM?=
 =?us-ascii?Q?noeyZ1W6dvoXCevQLiqq1s6nauzOnM00oFuRw/+kXgeMCKQePwoMMsoVPIp1?=
 =?us-ascii?Q?dpuO21GQriEaS6K1MpcaADDpdX49XddrOMz1kW1H1ExwgG4DZtw05Xf8HvJc?=
 =?us-ascii?Q?2jiWmmhXSQLOFfIAaZ29LK8AGCatGtPuUDmhIW7MxQUaA3vl8th6Pa7n5+fN?=
 =?us-ascii?Q?qAw3w6OlxjPR6ImwpRjeX9pF71gRFPGZ5A4G1lVK2uU11w9uT+3HeW2BLJ23?=
 =?us-ascii?Q?g6YLNPvkYHXLBe636TA2+z4AnEQ3IJWdBLPIypSkslNEb1+qzCfJ5/EMY7YB?=
 =?us-ascii?Q?fIGxRIbMqOcRJGS840AWbK4eClDRF91+Ho5+z9NIXTw7I0a2WBM5GMTiW1NV?=
 =?us-ascii?Q?xKkmhH2T6fibKiUqICU6E/dtBB2OJV0NEIrqhFxZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6211.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af8cecb1-95dd-407c-a26b-08dd55c9d5f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 18:25:52.2633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PYpFpZj2OSRtF1FgKqRhRmoL0avp8qq2JXdTu+5u0z/GagIloLlXJLAFV5the2HkGtrbJLhiPCPOYcSt5mDTvIfqI67l6IxpodrZv8WUhYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4964
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Tuesday, February 25, 2025 1:11 AM
> To: Gupta, Anshuman <anshuman.gupta@intel.com>
> Cc: intel-xe@lists.freedesktop.org; linux-acpi@vger.kernel.org; linux-
> pci@vger.kernel.org; rafael@kernel.org; lenb@kernel.org;
> bhelgaas@google.com; ilpo.jarvinen@linux.intel.com; De Marchi, Lucas
> <lucas.demarchi@intel.com>; Vivi, Rodrigo <rodrigo.vivi@intel.com>; Nilaw=
ar,
> Badal <badal.nilawar@intel.com>; Nasim, Kam <kam.nasim@intel.com>;
> Gupta, Varun <varun.gupta@intel.com>
> Subject: Re: [RFC 1/6] PCI/ACPI: Implement PCI FW _DSM method
>=20
> On Mon, Feb 24, 2025 at 10:18:44PM +0530, Anshuman Gupta wrote:
> > Implement _DSM method 10 and _DSM Method 11 as per PCI firmware
> specs
> > section 4.6.10 and 4.6.11.
>=20
> Please split into two patches, one for each _DSM.  Include spec citations=
, e.g.,
> PCI Firmware r3.3, sec 4.6.10.  Section numbers are not guaranteed to sta=
y
> consistent across spec revisions, so we need both the revision and sectio=
n
> number.
>=20
> Include some descriptive words about the DSM in each subject line, e.g.,
> "D3cold Aux Power Limit", "PERST# Assertion Delay".
>=20
> > Current assumption is only one PCIe Endpoint driver (XeKMD for
> > Battlemage GPU) will request for Aux Power Limit under a given Root
> > Port but theoretically it is possible that other Non-Intel GPU or
> > Non-GPU PCIe Endpoint driver can also request for Aux Power Limit and
> > request to block the core power removal under same Root Port.
> > That will disrupt the Battlemage GPU VRAM Self Refresh.
>=20
> I guess this is sort of an acknowledgement of the r3.3, sec 4.6.10 spec t=
ext
> about system software being responsible for tracking and aggregating
> requests when there are multiple functions below the Downstream Port?
Thanks for review comment.
AFAIU apart from multiple function below the Downstream Port (from same PCI=
e Card),
there can be possibility of another PCie card connected via a switch to sam=
e root port
like below topology.


			                 |-> PCIe PCIe Downstream Port -> End Point Device =09
Root Port -> PCIe Upstream Port   |-> PCIe PCIe Downstream Port -> End Poin=
t Device=09
			                 |-> PCIe PCIe Downstream Port -> PCIe Upstream Port -> =
 PCIe Downstream Port -> *EndPoint Device =09

*Endpoint Device from different PCIe card can also request to block the cor=
e power removal under same Root Port ?
 How to document such limitation ?

Thanks,
Anshuman
>=20
> If so, remove the Battlemage-specific language and just say something abo=
ut
> the fact that this implementation doesn't do any of that tracking and
> aggregation.
>=20
> > One possible mitigation would be only allowing only first PCIe
> > Non-Bridge Endpoint Function 0 driver to call_DSM method 10.
>=20
> Wrap to fill 75 columns in commit logs.  Add blank lines between paragrap=
hs.
>=20
> > Signed-off-by: Varun Gupta <varun.gupta@intel.com>
> > Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
> > Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
> > ---
> >  drivers/pci/pci-acpi.c   | 123
> +++++++++++++++++++++++++++++++++++++++
> >  include/linux/pci-acpi.h |  13 +++++
> >  2 files changed, 136 insertions(+)
> >
> > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c index
> > af370628e583..806f6d19f46c 100644
> > --- a/drivers/pci/pci-acpi.c
> > +++ b/drivers/pci/pci-acpi.c
> > @@ -1421,6 +1421,129 @@ static void pci_acpi_optimize_delay(struct
> pci_dev *pdev,
> >  	ACPI_FREE(obj);
> >  }
> >
> > +/**
> > + * pci_acpi_request_d3cold_aux_power - Request D3cold auxiliary power
> > +via ACPI DSM
> > + * @dev: PCI device instance
> > + * @requested_power: Requested auxiliary power in milliwatts
> > + *
> > + * This function sends a request to the host BIOS via ACPI _DSM
> > +Function 9 to grant
> > + * the required D3Cold Auxiliary power for the specified PCI device.
> > + * It evaluates the _DSM (Device Specific Method) to request the
> > +Auxiliary power and
> > + * handles the response accordingly.
> > + *
> > + * This function shall be only called by 1st non-bridge Endpoint drive=
r on
> Function 0.
> > + * For a Multi-Function Device, the driver for Function 0 is required
> > +to report an
> > + * aggregate power requirement covering all functions contained within=
 the
> device.
>=20
> Wrap to fit in 80 columns like the rest of the file.
>=20
> > + * Return: Returns 0 on success and errno on failure.
> > + */
> > +int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32
> > +requested_power) {
> > +	union acpi_object in_obj =3D {
> > +		.integer.type =3D ACPI_TYPE_INTEGER,
> > +		.integer.value =3D requested_power,
> > +	};
> > +
> > +	union acpi_object *out_obj;
> > +	acpi_handle handle;
> > +	int result, ret =3D -EINVAL;
> > +
> > +	if (!dev || !ACPI_HANDLE(&dev->dev))
> > +		return -EINVAL;
> > +
> > +	handle =3D ACPI_HANDLE(&dev->dev);
> > +
> > +	out_obj =3D acpi_evaluate_dsm_typed(handle,
> > +					  &pci_acpi_dsm_guid,
> > +					  4,
> > +
> DSM_PCI_D3COLD_AUX_POWER_LIMIT,
> > +					  &in_obj,
> > +					  ACPI_TYPE_INTEGER);
>=20
> Wrap to fill 78-80 columns.
>=20
> > +	if (!out_obj)
> > +		return -EINVAL;
> > +
> > +	result =3D out_obj->integer.value;
> > +
> > +	switch (result) {
> > +	case 0x0:
> > +		dev_dbg(&dev->dev, "D3cold Aux Power request denied.\n");
>=20
> Include requested_power here too, for debugging purposes.
>=20
> > +		break;
> > +	case 0x1:
> > +		dev_info(&dev->dev, "D3cold Aux Power request granted: %u
> mW.\n", requested_power);
> > +		ret =3D 0;
> > +		break;
> > +	case 0x2:
> > +		dev_info(&dev->dev, "D3cold Aux Power: Main power will not
> be
> > +removed.\n");
>=20
> No periods at end of messages.
>=20
> > +		ret =3D -EBUSY;
> > +		break;
> > +	default:
> > +		if (result >=3D 0x11 && result <=3D 0x1F) {
> > +			int retry_interval =3D result & 0xF;
> > +
> > +			dev_warn(&dev->dev,
> > +				 "D3cold Aux Power request needs retry.
> Interval: %d seconds.\n", retry_interval);
> > +			msleep(retry_interval * 1000);
> > +			ret =3D -EAGAIN;
> > +		} else {
> > +			dev_err(&dev->dev, "D3cold Aux Power: Reserved or
> unsupported response: 0x%x.\n", result);
> > +		}
> > +		break;
> > +	}
> > +
> > +	ACPI_FREE(out_obj);
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL(pci_acpi_request_d3cold_aux_power);
> > +
> > +/**
> > + * pci_acpi_add_perst_assertion_delay - Request PERST delay via ACPI
> > +DSM
> > + * @dev: PCI device instance
> > + * @delay_us: Requested delay_us
> > + *
> > + * This function sends a request to the host BIOS via ACPI _DSM to
> > +grant the required
> > + * PERST dealy for the specified PCI device. It evaluates the _DSM
> > +(Device
> > + * Specific Method) to request the PERST delay and handles the respons=
e
> accordingly.
>=20
> s/PERST/PERST#/
> s/dealy/delay/
>=20
> > + * Return: returns 0 on success and errno on failure.
> > + */
> > +int pci_acpi_add_perst_assertion_delay(struct pci_dev *dev, u32
> > +delay_us) {
> > +	union acpi_object in_obj =3D {
> > +		.integer.type =3D ACPI_TYPE_INTEGER,
> > +		.integer.value =3D delay_us,
> > +	};
> > +
> > +	union acpi_object *out_obj;
> > +	acpi_handle handle;
> > +	int result, ret =3D -EINVAL;
> > +
> > +	if (!dev || !ACPI_HANDLE(&dev->dev))
> > +		return -EINVAL;
> > +
> > +	handle =3D ACPI_HANDLE(&dev->dev);
> > +
> > +	out_obj =3D acpi_evaluate_dsm_typed(handle, &pci_acpi_dsm_guid, 4,
> > +					  DSM_PCI_PERST_ASSERTION_DELAY,
> &in_obj, ACPI_TYPE_INTEGER);
>=20
> Wrap to fit in 78-80 columns.
>=20
> > +	if (!out_obj)
> > +		return -EINVAL;
> > +
> > +	result =3D out_obj->integer.value;
> > +
> > +	if (result =3D=3D delay_us) {
> > +		dev_info(&dev->dev, "PERST# Assertion Delay set to %u
> microseconds.\n", delay_us);
> > +		ret =3D 0;
> > +	} else if (result =3D=3D 0) {
> > +		dev_warn(&dev->dev, "PERST# Assertion Delay request failed,
> no previous valid request.\n");
> > +	} else {
> > +		dev_warn(&dev->dev,
> > +			 "PERST# Assertion Delay request failed. Previous valid
> delay: %u microseconds.\n", result);
> > +	}
> > +
> > +	ACPI_FREE(out_obj);
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL(pci_acpi_add_perst_assertion_delay);
> > +
> >  static void pci_acpi_set_external_facing(struct pci_dev *dev)  {
> >  	u8 val;
> > diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h index
> > 078225b514d4..4b7373f91a9a 100644
> > --- a/include/linux/pci-acpi.h
> > +++ b/include/linux/pci-acpi.h
> > @@ -121,6 +121,8 @@ extern const guid_t pci_acpi_dsm_guid;
> >  #define DSM_PCI_DEVICE_NAME			0x07
> >  #define DSM_PCI_POWER_ON_RESET_DELAY		0x08
> >  #define DSM_PCI_DEVICE_READINESS_DURATIONS	0x09
> > +#define DSM_PCI_D3COLD_AUX_POWER_LIMIT		0x0A
> > +#define DSM_PCI_PERST_ASSERTION_DELAY		0x0B
> >
> >  #ifdef CONFIG_PCIE_EDR
> >  void pci_acpi_add_edr_notifier(struct pci_dev *pdev); @@ -132,10
> > +134,21 @@ static inline void pci_acpi_remove_edr_notifier(struct
> > pci_dev *pdev) { }
> >
> >  int pci_acpi_set_companion_lookup_hook(struct acpi_device
> > *(*func)(struct pci_dev *));  void
> > pci_acpi_clear_companion_lookup_hook(void);
> > +int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32
> > +requested_power); int pci_acpi_add_perst_assertion_delay(struct
> > +pci_dev *dev, u32 delay_us);
> >
> >  #else	/* CONFIG_ACPI */
> >  static inline void acpi_pci_add_bus(struct pci_bus *bus) { }  static
> > inline void acpi_pci_remove_bus(struct pci_bus *bus) { }
> > +int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32
> > +requested_power) {
> > +	return -EOPNOTSUPP;
> > +}
> > +
> > +int pci_acpi_add_perst_assertion_delay(struct pci_dev *dev, u32
> > +delay_us) {
> > +	return -EOPNOTSUPP;
> > +}
> >  #endif	/* CONFIG_ACPI */
> >
> >  #endif	/* _PCI_ACPI_H_ */
> > --
> > 2.34.1
> >

