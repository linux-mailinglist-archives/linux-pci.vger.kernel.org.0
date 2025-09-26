Return-Path: <linux-pci+bounces-37119-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84091BA4DBE
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 20:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A873A1C027CE
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 18:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883B42D5C68;
	Fri, 26 Sep 2025 18:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X3I4Cx8L"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E382741AC;
	Fri, 26 Sep 2025 18:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758910434; cv=fail; b=danZq9JA8Tc6wfCIZXPnSyg0t8eQsEGcPi4uJChse7viL6xHfe+owKlFAtQSAehVHaProBIg7PDiHmGbctvRuEkE6AKBRYOkTnkGhMeulG0iDDqSlTwxU++4wpPGWGRr4H3ANtczh/ooXnH7JH9M1VjKlC94VmJeJO25O+HeI3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758910434; c=relaxed/simple;
	bh=wDKTBuceSgs05HHHvFRJUROhP17qOS6qTezAud9sMxk=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=g3PQl7vA5nP+Dfz1Xaexb4ir2PDvSe07kMWlrGlfZlAtrntUcA7it687iZzwm1Ued0Lx77HSvdHR1U8jXlVC1G1ydiyYynxxMshMAYdXwFHL/Pi0U369zOzGMR34ryFiJMhBidGyikxXx3M9xeB+YJrdRbzSeE6s4OIs31rzpc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X3I4Cx8L; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758910433; x=1790446433;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=wDKTBuceSgs05HHHvFRJUROhP17qOS6qTezAud9sMxk=;
  b=X3I4Cx8LSeaZtMJLizTNwdBJ4Xv253+oLrYZuBAFy6d74YoJ5sJIovIi
   fTQHnh+HK5pi+urKMUVQxFLPWbzFB34DZDmUg9mQ1ZS/y8Y8mh10RBBdT
   Qpd0Ur/c858MoJht6z701oLqGHSSWhgcXILX8ChMP3pCGz36macHqGaX9
   jBBHfmib6SkqMWENRB/2pVAHt/NgfcGhLKDswnVJBYZbP5Nd0xJals8Mc
   O2MBbhQt763zuP38pHz8z2pKSUwJ5cNsNkMK89IEX7ZjzHl0SIIxh8ZT+
   SFEk6CZ+n2k36joiEjmBmhNmg5ItWXWNAO4PwtScBzU3gfTimWfd9c6dW
   w==;
X-CSE-ConnectionGUID: OwmzwSHdSN+euii+4Wes9Q==
X-CSE-MsgGUID: dgmALmmdRxSdjEWeAPjf0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61202864"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61202864"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 11:13:52 -0700
X-CSE-ConnectionGUID: 0Nea/e3IRLmS+liPIu7tLg==
X-CSE-MsgGUID: zqjMgFuyTmmGV5f2DexXig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="201369666"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 11:13:51 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 11:13:51 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 26 Sep 2025 11:13:51 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.54) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 11:13:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H5uBx0Jo7kXB++IRWBPYu8GaEEbzteNRhVG4hRAlM3gg/vs/7xbWbnwE6TM99aSUi9mILSF14QCmuZMdS7OiMr7rbdTeD9RHDYS9LTLrCqeCJ8hJeLJlIj0ICza+y1iCkCLnL2HpnMmp0OFp9dkujuAcWIuaOet/PkeA/HWsILaYa12zUjXGfumAZQc4ForHbo2G7hclwHPAT0RPRw6v+oMQGOkudA5wVxIaQHKW/ai3qsjM6awQrC36Mbp4x93eapuqX5VxmECNPtl+lHhBXxhhrxKvopt1XurfXdIHfi591pw8pSWU1rrm6m84rE13lXe3ldIuJ4BhL9XS67EKpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EtlCuFQhZgH8waiCNG51pAOQL/KmXeZIC4+iZKujOlY=;
 b=A5NVlieYgbtfkI6F96Lwp92j07+8JlZtdJuLopIWwoX9JEdzVLWymvo88Dr+eFC1tPfBGMj0mkiJj6HborbrKViRs/ecveaM2isYgTVDOEw426/ScGk3EjpZn7RYNTS+N0iw8c/BAltUZvVMbLZXKZKVTIwDjZxgUkLqdk9yOrJPVnO2+R4JdIFIuy3/PGAt6FYSWOJAzFjlH2WFT8jjTTzL2ke8mPK6C3QLBe8JuKLu75jMgCfSZi0WSOzVMhLNYDBBPngmH9vJJLZLAt3wgcAFpW7pDEdC7YVl+NkhBTkdvcJpMShypCzV4Af6XeZW2DZNl11668bdibMQe35cKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB9480.namprd11.prod.outlook.com (2603:10b6:8:28d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 18:13:49 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 18:13:49 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 26 Sep 2025 11:13:47 -0700
To: "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Cameron
	<jonathan.cameron@huawei.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM
	<linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux PCI
	<linux-pci@vger.kernel.org>, Alex Williamson <alex.williamson@redhat.com>,
	Bjorn Helgaas <helgaas@kernel.org>, Takashi Iwai <tiwai@suse.de>, "Zhang
 Qilong" <zhangqilong3@huawei.com>, Ulf Hansson <ulf.hansson@linaro.org>, "Dan
 Williams" <dan.j.williams@intel.com>
Message-ID: <68d6d7dbd18b4_10520100c8@dwillia2-mobl4.notmuch>
In-Reply-To: <CAJZ5v0gnqoJ8bALZT61ZvTA=chp8y5QBiA7ZpNQ6fFJuQzZUnA@mail.gmail.com>
References: <5049058.31r3eYUQgx@rafael.j.wysocki>
 <2245131.irdbgypaU6@rafael.j.wysocki>
 <20250926144947.00002f75@huawei.com>
 <CAJZ5v0gnqoJ8bALZT61ZvTA=chp8y5QBiA7ZpNQ6fFJuQzZUnA@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] PCI/sysfs: Use PM runtime class macro for auto
 cleanup in reset_method_store()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MW4PR04CA0068.namprd04.prod.outlook.com
 (2603:10b6:303:6b::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB9480:EE_
X-MS-Office365-Filtering-Correlation-Id: f00d9f65-54d9-4686-08c0-08ddfd287103
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R3B4cUhseGNkVVB2ci9jMkR3SStGVXp5cVpIWVUyZk9MTUdKcTd5Ui80azMw?=
 =?utf-8?B?NWlsMFk4RXJwYWppNmVSb05pSVhaQm01Rk1lNVBzVDV6dHEvTUNuWE5oa0d4?=
 =?utf-8?B?RndWRllNazZzWHVJUHdEeXcrVzhXU1ZsZEtDWGVuUUdKMXg0ak1Jdy9TN1VE?=
 =?utf-8?B?RHE1SUxFcFBtMEcxZVJhcytWcW1GOUhRck5sZFFFRnNORzJHQ2gyZ3hXRFV5?=
 =?utf-8?B?VHJiQWZyQUNEUi9saXpETVRTR0lodjF5aTVyRGlyQUZyZ1o5cTNnaVdrNTJJ?=
 =?utf-8?B?WTJma3lhZm5YOEVZV01jOGthT3Q1aThjL0NKTjgzSGU5b0k4TlNxcU1MbjB6?=
 =?utf-8?B?WjFEWXVwdVQ0TkhKbGM2SnpiS3ZZdFdFTjJ0VzVHd25ZZjA0bGY2R2lwSEl3?=
 =?utf-8?B?QlRTc2taQUJmeXVYNDB4cDUyOE9pMk9rZXR6YlBjN05xdFhnZTB1b3lqSmIr?=
 =?utf-8?B?U3l5d29RUlBSVjBHRHZPNC9ocmduU1VhVUQyd0EzRDc4dTdWaStSRnY3OVI2?=
 =?utf-8?B?bEMxZ1hWMW50Z0paVGNsTkI0UVNHbGNoSEQxUjhYRmJmdTlocmJOQkRaUjEy?=
 =?utf-8?B?VmlsWXVvMnBjaWk3cHpXY0wvWUhVcjFVU0JjMUVRK1ZRejFxbnlrN1lxYmVl?=
 =?utf-8?B?cjlSNkJmcVBMbVo5b3ZMSEE2SThFNXMvNkFWempSSURoSHBiTjVMUGZjMVdt?=
 =?utf-8?B?b1pRU05lMjlHeEdFeXpYL0Z1WVpPZUhZaCtMV3pUWklLVjFLUTJYTkJZSHIr?=
 =?utf-8?B?a21QR1RwVGxZbTBQRVIwR3p5ZDZuRDA5aXJYbGg1ZTYxU3JLa1FZSXB3TXFx?=
 =?utf-8?B?amUrdnZoMnB1MkU1WGIwWmREUmY4aXJ2TlZFRHl2cVdLTWtqbFBBN0ZvWlRo?=
 =?utf-8?B?eDVsV1A1NmhaUFFQOFVVd1R5VFRJQXZzRWk2aERLZ3Y0K0xtdG9JeTV6QlN6?=
 =?utf-8?B?NThoYXVUcy9lVGlTSFU2amtNSU1vVE52ZWo0VUxDQ0NZZk1BdkVtRndRNE5H?=
 =?utf-8?B?VXZTNFp4WE9scm4vNm9iendINmhBQzZ4TFBYT3lpaEJIU2pDUTBYTUdrbWRx?=
 =?utf-8?B?R1ozY0FRQmpNbzkza0hhVStMVklTUFJLbjU4dy9rcTdJcW1mRE5wQlA1dlhL?=
 =?utf-8?B?L1VhS0VQdVJJQ01Bd3NWU3NudDFETHJUTmVHTmtnOEIwNTB4akpwbU05NGJU?=
 =?utf-8?B?S1BuNFJsT2dFc2l6TjFCSitRcWRLQ2lybkVpL1duNFg3eGU5eVpaNWFyUjJG?=
 =?utf-8?B?VEMxbmhGNlVNYU12MUhtTHpROXNiaFdpSW90WXk4aWJoUVNROFM0bTNUbXh1?=
 =?utf-8?B?U2hyb3dzWnYrZFdaUUo5OVo0bkYwalF3VW5JUCt0QnE2N0xKeVB1eVQ5M0JC?=
 =?utf-8?B?WVNkSDR5eVVmYlBzcGRkWHpJcmlQS1NwVmZXejJMN2xJaFlMa0xjTHlKRytU?=
 =?utf-8?B?UkpDS2dEWnpKSFR2OUtESlVaeGFMWUt1N3JMT2szZm15T3M2aHQwL09sUGdW?=
 =?utf-8?B?cmtVbWdYN0sxMnUzUkljS1FtZUVlRWFyejU0RzlYdUkyZVI2V094UG5UTVQv?=
 =?utf-8?B?Q2s5bTJXZEp4dndmc1pvZVFKUWN3c3RFZGo5Tm11ZnR0Q0RaZnlvc3ZIem4w?=
 =?utf-8?B?V2JsQ3FKakp3NnVJdlZFMWFXN3RBWk1aeUc5d080ZzNpZUZsanYwcGtwTHZU?=
 =?utf-8?B?eUZ0bE14NmxJQnRxM2dtL2ZjQVFrYi9rdk1BNnEySmx6aytEaDZtcWFvcCtD?=
 =?utf-8?B?UExCbkk5TElnalljVzVPMjJYRDRvWEQ3ZTA4R2FmaGZEbVVsNWtFZGgyMkVh?=
 =?utf-8?B?RzZqQlF0MjFOanJyT3BYMkkwRmVCbGxKR0hSakozMThIZys1NncyUkhiZk9E?=
 =?utf-8?B?UzZPWUxONW1QVFFVRnUvajA4WkJKOFl1VW5ISnV4bzRHYS9wWjhDbXF6eGpo?=
 =?utf-8?B?NVNlUlpQc0lia0hoN0llK2dmUW9obHFZRXhsb1lvVW1BU2x4bXlZaklEZXBu?=
 =?utf-8?B?aElwTDZzbk1RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SllRVjBhUUFCUHJOUGc3b2txWGF3NlplbUNqWmQ1RThRL3IvNFJFYzEwaVRw?=
 =?utf-8?B?SW9wTVMwTmk2TEdxNkgrWkpHTSs0aFJsNG1ZYkxaTXUrTXg4dzU1a2RRSk5S?=
 =?utf-8?B?b1hVOUV0alUyV2RGaGRUOWxpbldNZGkyU1owWmw1VE0zREFJK2ptN1ZCV29k?=
 =?utf-8?B?cnhrbFd4SjBEZlNOVlgrenAxVy9NM1hZZERpSzd4enhNWEJpbW9ZRHJaUXVa?=
 =?utf-8?B?dFdla1JPWTJCdFlCWU5YWGZVeGhYdC9XbS93eFBWK1dadlZzTW9WbkoyVGtO?=
 =?utf-8?B?VGFPYzRRMnV0RVZlVUdiT2VlcmNUbHUyTktwaXQ3eTdhVWJJOFh4NmN5em03?=
 =?utf-8?B?MWRvaE9mSklTZlpDV2NzNmdPdDJEWkRsbGErdG1JWjhJQUgvQUdFNlhmazBu?=
 =?utf-8?B?OXk3OW1qSXpRdzdkeER4NnR6d3VHbTFXSCt0Z3NTNVFhN3d6YzNuemdvWDMx?=
 =?utf-8?B?TVJweVNRS1RDbWNnRFlqaWt2ZXFmZzFLSlFhT1dYdXNaWGpkaDA5U2FPdS9D?=
 =?utf-8?B?d05pZjNKOG1LNlZNOVdtbkgrN0FmWDV0Y1dxUUJtbGkxSnV4TnBOYjVKUmNO?=
 =?utf-8?B?STNjdGJSQ01FOTI1VXRRT2thbUUzOXUxOE5xaW1LdytxcUJKSVhyQjR6ZlMz?=
 =?utf-8?B?aXlxTEZxRGpKV2NmRUVuNHlITmx5Z1ZjMW9Zc0tHQkwvNmo2ZUwrT002SHV6?=
 =?utf-8?B?bmRneElvSDJNem5Ybncyd0Yxeit3YVJvSlR5RHBuVXQ2bEh4Mm51Vi9yMjFX?=
 =?utf-8?B?cXVZQkphakJ6QnMveG10TzBjT3ZKY3o1L3BtQnk5V25uQk1jdXByRzhNRE1v?=
 =?utf-8?B?bElkdHR2WXU4N3JzdlluRlBUZkNud3RlZ3FSUFlrTGNyL1lVb2lJMzEzYWFY?=
 =?utf-8?B?Q0cwNHhsSG5NOFczcTlyRkNjbTVDNm5JQXhpNHJud1I2VEhRa0JrcEN4TVBj?=
 =?utf-8?B?SkdIbXVwNVBWTTB6cWwzNmUwYkJ0Y3JlbTRFSCswVWZid2Q1bTNDWm1jeFZh?=
 =?utf-8?B?enBEdXB0Rm9YUmJZRTVCcWhHb2xoZnBFNzF4SVkzVzdIY1l5TjFzdEswVHR0?=
 =?utf-8?B?T2hxMlFSRk0wbHRGNnlzeWZ0UmdCeFR0OTBrZG1xeXdYSERGbUxWY244MkQ0?=
 =?utf-8?B?SWdXV21ESGxwRUxITmZxOUViU2ZuaGxGeTNxd1J0M1NkZExVRlpBajh4Nlc5?=
 =?utf-8?B?RHVDWDVXQ2lDSjdqU3dGN01Vd0N2TzFsOXVrS1QvWlNLU1NOOUtUbXpmdWg5?=
 =?utf-8?B?SDU2ejNKRXNVcGc0UVVnWHlvUlk0bmpqeEhrcUl0bkZGd1Qxa1Z6ZkZJQ2d5?=
 =?utf-8?B?ci9uWmYyejZCVlpFNVRYZFAyMVk2bHZBbE9EQ2xrclk1bHpvdU1tYmtQY3Nm?=
 =?utf-8?B?cG5HVVc4MVZhSE1CcjZKM1Zxak1ndjNnalZESkdoRVhjRG92Wjd6alQxTDc2?=
 =?utf-8?B?amt4NTNlV1paVWt0WjF0eUZmTXVycUxUUEF4bUMxYVJnS3JwMTVTcnBCcnZp?=
 =?utf-8?B?R3BsY3ZLMWdrQzZYTEFWY0ptc2Q4UXVJdmszcURyeTZmNVhTL0ZIbWJIdDdQ?=
 =?utf-8?B?TXd1Z21UV3RJMzNaOWFDUVd3Vlk0RjBnSDBpMGxwTWtpa1lScTZLdXlrU0Mw?=
 =?utf-8?B?c2pHR1Rody94V0ZVb2ZqM3NyaGFTNTRXa2wyQnBxa0FXMHFqQkZXUXdEWHM2?=
 =?utf-8?B?VWd1VnBKVjdidWF2T1U4QWc0S0dVUVBhZUtwQm95WURWTGtaZjd3YzZzcWtn?=
 =?utf-8?B?M1ZScnk0ZGs1WDhDRHgvaXJBR0NRVFNBYVhCc1VRaEk2ZDlISy9KTXQ5dTc1?=
 =?utf-8?B?UERmaCtwY1Z5SVcrOFBZM0pYNEtHMzF3eHRxSDZVQzRQZTBYbGxZZGxEMHVL?=
 =?utf-8?B?TC9GMGVmeXVxTjBUVnpLMGF3MGc4L1dqTkx0ZFVoZHpnV0JCeTlQWTI3eDZj?=
 =?utf-8?B?WSticlA4OXBjYXBOZ256TllMdGkyNkZObWhEOXZ2Mk1qb2lLaDc2ZUxhMUFS?=
 =?utf-8?B?RmpQOVVseGJTeFRqYnowcENVQ2lFdW91cnpnTXF0U2ZrVW1qdWN5KzZ4QWYz?=
 =?utf-8?B?bkJ0NW5yMVdzcUZtRmFha2laQ0g0MzJsRnZvV09QSUY5WFdtRGJ6cjBKeU8z?=
 =?utf-8?B?VG5ZZ2RQOHowTlRRa1VvVlFqd2VNWHJ2U0JHUWI2dElUbDJVV3BXRUpRUTg2?=
 =?utf-8?B?Znc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f00d9f65-54d9-4686-08c0-08ddfd287103
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 18:13:49.4392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X/SzGMK6vKQXP1aqcqrEqv7/XVmBGKmVwBlDmyhA8sdETo1+gS42GMlGc8iPYYxpYcPvIX35Gwz2kakLBdTcmT9iYxuDCNAaks4uJzl0QKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB9480
X-OriginatorOrg: intel.com

Rafael J. Wysocki wrote:
> On Fri, Sep 26, 2025 at 3:49=E2=80=AFPM Jonathan Cameron
> <jonathan.cameron@huawei.com> wrote:
> >
> > On Fri, 19 Sep 2025 18:38:42 +0200
> > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> >
> > > From: Takashi Iwai <tiwai@suse.de>
> > >
> > > The newly introduced class macro can simplify the code.
> > >
> > > Also, add the proper error handling for the PM runtime get.
> > >
> > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > [ rjw: Adjust subject and error handling ]
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >  drivers/pci/pci-sysfs.c |    5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > --- a/drivers/pci/pci-sysfs.c
> > > +++ b/drivers/pci/pci-sysfs.c
> > > @@ -1475,8 +1475,9 @@ static ssize_t reset_method_store(struct
> > >               return count;
> > >       }
> > >
> > > -     pm_runtime_get_sync(dev);
> > > -     struct device *pmdev __free(pm_runtime_put) =3D dev;
> > > +     CLASS(pm_runtime_resume_and_get, pmdev)(dev);
> > > +     if (IS_ERR(pmdev))
> > > +             return -ENXIO;
> > Hi Rafael,
> >
> > Why this approach rather than treating runtime pm state like a conditio=
nal
> > lock (we use it much like one) and using ACQUIRE() / ACQUIRE_ERR()?
>=20
> Mostly because devices are not locks.
>=20
> > Ultimately that's a wrapper around the same infrastructure but
> > perhaps neater as it removes need to have that explicit magic pmdev.
>=20
> You'll need to have a magic pmdev or similar regardless IIUC.
>=20
> Say there is
>=20
> DEFINE_GUARD(pm_runtime_active, struct device *,
> pm_runtime_get_sync(_T), pm_runtime_put(_T))
> DEFINE_GUARD_COND(pm_runtime_active, _try, pm_runtime_resume_and_get(_T))
>=20
> so the user of this will do
>=20
> ACQUIRE(pm_runtime_active_try, pm)(dev);
> if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
>         return -ENXIO;

FWIW this looks better to me than the open-coded CLASS(). The pattern,
admittedly coding-style bending, we are using in drivers/cxl/ for
compactness and error code fidelity is:

   ACQUIRE(pm_runtime_active_try, pm)(dev);
   if ((ret =3D ACQUIRE_ERR(pm_runtime_active_try, &pm)))
           return ret;

> and there's a "magic" pm though pm is not a struct device pointer.
>=20
> Maybe it's nicer.  I guess people may be more used to dealing with int
> error variables.
>=20
> Let me try this and see how far I can get with this.
>=20
> > +CC Dan as he can probably remember the discussions around ACQUIRE()
> > vs the way you have here better than I can.

Yes, effectively a new open-coded CLASS() prompted the ACQUIRE()
proposal [1]. This pm-active-state reference management indeed looks
more like a guard() of the active state than an object constructor
auto-unwind-on-error case.

[1]: http://lore.kernel.org/20250507072145.3614298-1-dan.j.williams@intel.c=
om=

