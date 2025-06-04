Return-Path: <linux-pci+bounces-28936-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5900ACD790
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 07:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19B9A1895549
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 05:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B55A1CCB40;
	Wed,  4 Jun 2025 05:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TcxkGA1j"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727732581;
	Wed,  4 Jun 2025 05:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749016182; cv=fail; b=D9yoaL9q3v8yGcAB1EEjIc3VY1BtiXFePHlXfqq8WNO8mslWQD3hSbx/JIFYYepjzCJDb/kM2UeJjf6Zx+irIvfTGR9+7VBvby/bYe3jaMMZlMhKod0tEorfixzne+Oj32fHcmAViaaz12Ph6pZBPA+v+gWLJHDr2J5EwD8v3J0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749016182; c=relaxed/simple;
	bh=MGfHq9Ru9AOeqJJeupV7c0z2+vwZ9nVU3g5rD9oqDWo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i+NCqcw3G5CuGEzYiJRjT06Gum55kq6BTbO/c2KSwc5egvd5g0iYZYyMRt5QZA/OIgRRaEY5mhnOe12adklBgxrvvT/5GBRLjsKjXpkuX53ayzabHW5E9dKNObJ6rJfmINw1PCy9AQJhiYx/D8V/LmOR5WTnUV5ubFyZjoxk1Ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TcxkGA1j; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749016181; x=1780552181;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MGfHq9Ru9AOeqJJeupV7c0z2+vwZ9nVU3g5rD9oqDWo=;
  b=TcxkGA1j5F7FY8F+FwkkaX1ajG3XMOiTedF5Ie0J5kahPOy6E71Ki3Zx
   rSSmwjesUkczyd+PFSmryNzjZ6XgoEx4bgOjbsuaOupn+4mLDJ9QDpbn0
   R2LmQ3ogK7V2XqPpYhCMVtd+MrcMGQcm47WUYb8ScJq/47piGb01PqRHP
   H+v+3dPMEtkNSVsyUexCYnPB53+XlXuwwgz5Hb8icO5mc2meaVEUoZ9gM
   YxEVHNA9IcyygSq8uZMz3NhQWfvYkaSnpQzRRO7Te1Qae78H+Fw+EU6uu
   uOZ0tCw5rJbbU/7LOi9srRB3yfS5J90j5fpUhVtk/jHHCZPqrcQw/UL1v
   g==;
X-CSE-ConnectionGUID: iwkPDzPZSPeqxNoojxeRZA==
X-CSE-MsgGUID: tiejWbH/S/qhLQ3TVkEUfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="61346558"
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; 
   d="scan'208";a="61346558"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 22:49:40 -0700
X-CSE-ConnectionGUID: j9S7t2HDTmeJimMnEd8TLA==
X-CSE-MsgGUID: Dj/xnsGkQJy2ZgFMmlN4fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; 
   d="scan'208";a="175942046"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 22:49:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 22:49:38 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 22:49:38 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.85) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 22:49:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XNd5AKM2bcjOqRFh+3OLDAfbyI64YNOwSepIy2YtUdl54JJ8o/5LephtQRe55Tmg2lJc+UkUkDJBr2zAF8FUvXkb86GuDucdo6+2Ssvj2GgIzoZ5/USf/ElYDs8BRq9btnaK0nMr3gs4pn/+sr/cWHLtsmxm1YiO0pEOqsFBggARFt+3YcTEBRvmJ2Iq0orfMuXix8qYNPBchjH3GvMzZYSm/3aobUcLFtOqugYw9AsSl0Ty7OlHn8T8+0RQS/q2tCwkmFWDgFaHS6OPBuVRQY5YtqvOToJe/jOl53ZToV6IWBbCHxxUPLofoGuXZR3TI72gnIQfpS4GuyRyn6fIiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGfHq9Ru9AOeqJJeupV7c0z2+vwZ9nVU3g5rD9oqDWo=;
 b=sicoBtL8crXpKIqD+q7P/twdiQwuU93DABVgM4cdt6htr2jijzI6ZjfVCg/LSxyLP8FbT3z9pLvJpjQc4YDF9pcDjDQeUPYsPggAVyNPxdl7dmqxBCHc+8eOEvAKIbQ9feWrl8Aua0ggMYdreTNXZTwmyPO61SM5NuHDnol+0FEE9JiUbm5jPl8/4Qq8GLlGCboupejeFTGh/+1tX1F7Tj44ZavqQ/g1/+IeYb4O0DqrF6JNMEQJ4X/avstE6lUUx/cBmfRHBnck24XHaG5TGmhP1WOG3271sQJiZoBBiFa1iwBRnC3wMu2g/KUCOV3fvl5jAnNCLLTy7te90QF0qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by CH0PR11MB5267.namprd11.prod.outlook.com (2603:10b6:610:e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.19; Wed, 4 Jun
 2025 05:49:36 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%5]) with mapi id 15.20.8769.025; Wed, 4 Jun 2025
 05:49:36 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, "Rafael J
 . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Schofield, Alison"
	<alison.schofield@intel.com>, "Verma, Vishal L" <vishal.l.verma@intel.com>,
	"Weiny, Ira" <ira.weiny@intel.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
	"Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC: Yazen Ghannam <yazen.ghannam@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH 1/4 v3] ACPI: extlog: Trace CPER Non-standard Section Body
Thread-Topic: [PATCH 1/4 v3] ACPI: extlog: Trace CPER Non-standard Section
 Body
Thread-Index: AQHb1KAq+emGYyIGfEm+FV/Y7leed7Pyf1wg
Date: Wed, 4 Jun 2025 05:49:36 +0000
Message-ID: <CY8PR11MB7134D38181BA7267812B7435896CA@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250603155536.577493-1-fabio.m.de.francesco@linux.intel.com>
 <20250603155536.577493-2-fabio.m.de.francesco@linux.intel.com>
In-Reply-To: <20250603155536.577493-2-fabio.m.de.francesco@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|CH0PR11MB5267:EE_
x-ms-office365-filtering-correlation-id: 0ba50192-b781-48a1-966f-08dda32b96cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|921020|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?66rjAYrETV91PxPbn2/Ja8b5L/yJaETNh3jE3Xq3YdVOepvhhibY7C9DR2XC?=
 =?us-ascii?Q?6gtBdF5OH3TBT7hRVdI4Iw8vE0aYTk+WwASn8Y4XOS0ruqqIimk0OBLN4zAC?=
 =?us-ascii?Q?B3T4pyQQAF4p1pcmQo04keFIBuiQWVNy4IFPFsECoeCZYE3WiRhUnTJK2v8e?=
 =?us-ascii?Q?KGb/VRTffLP/H0swACX8OSKXmt3FJe1lIlR0KNA9RPb0K4SoQkFp/iDGkfGz?=
 =?us-ascii?Q?Is+vL0Gpu6jWu3TLgXPxMILHJbmcjNABNXqdtIttUWCKF/aXmRWdBG+cV0DW?=
 =?us-ascii?Q?dwLW81Zu1Bor/Fl9t3Q7eOGZsJhRFH37agPk4TbTKj8etAVhsJ0wKKLLs7uF?=
 =?us-ascii?Q?rWq6VPCtou6X3uYbPFx2NpEGsKo0h7jmy2yiEpfiSH+Zb5P/zI11YOTfkKW3?=
 =?us-ascii?Q?Rf+f9ZKFwneeSYYg5XWSPkaP/lKugjsRqDmSkqmXMKOthx2ZFDUE/o13rSea?=
 =?us-ascii?Q?3FBKa6Okgdiob+aJ/OSvw9EoR1LuRJZKwNHh3FVhZYMUOgbXEP9US3bhv+nN?=
 =?us-ascii?Q?Lb4vHDDmKu8HZuH12dQ2Lg+G7lCXSq3uub04v1LNl65u+xSeK9RrTzKBzn1y?=
 =?us-ascii?Q?CYqsWxS2oHCLKpKFd8UQ1V0pSVWWyfk1k4vlfX+fG0DzOyuBiq6PVuL+H7Su?=
 =?us-ascii?Q?e13xwNz5JLSTouq62fdXeq5gtUW9b8dID59DowEWmuk02KqnOgBE4hd7UY6V?=
 =?us-ascii?Q?nsCeXcR1CoPSIqEp6Hkyve8ZbOEslE8uqfM0zFBQeo7h/GsighZCfpRzfR9K?=
 =?us-ascii?Q?lnwFFAU7V0B+goCZwiaL2FTUQH0ly7rZzQvFUrey8Wr9GYjA9BmM4UG/7z3q?=
 =?us-ascii?Q?AsglqTCmra9zvbNTQVEzNPER1D+TniLoXTihHzBoCOtfAh90d0OUOBbFMXFj?=
 =?us-ascii?Q?+/MAuhIUsJzpuhMYhRc6HGWWjAM4yx3elrsdo/uJVgKWnHG1MTP4NQOV0iNT?=
 =?us-ascii?Q?qQuiqNcKO4YZ4zV4eCtvhDAhmZpiF71vKKdPQHgNOPqQBlpIo/0EbimyuvCM?=
 =?us-ascii?Q?PmZjatsFN6YKduYFTNWZGoDqlNvXWUmarAHBSOP53TRnfDhmIDkSQRsPfmNr?=
 =?us-ascii?Q?WUejsmEyCCvOQfHTl7nHgNnATKjxTbYZxqtokO8PItZ2sfFER2HIWos/WJHl?=
 =?us-ascii?Q?f6HFrFW1a9Zb7aLT88vdx0s6TiEZ3G/meOwaNtT6jteecPHL+sTxqwLpKbjv?=
 =?us-ascii?Q?qz8afKj6hWWU8lac5XQ/oZqz8ceF3lpLPniMvZtJAZ5RcR2DZgk2JlhYzI/G?=
 =?us-ascii?Q?R8is/dOp17+vzGiQQggQlrRGQDGRaobriYBjfKcocxXNbJ3edG/ZnMscWS1o?=
 =?us-ascii?Q?yzmV45VrBUZRQuYkiYlnSoUaP6FHrInbNxwgVmYuZ5IzYEUVFSEtVFPfUpFB?=
 =?us-ascii?Q?BHf6wwPN78YKLFi8/ZCb9nt0okL1VzMAZX1sykMONJ4rC5Z7BpMmHMqVSg6e?=
 =?us-ascii?Q?pCMBMG0NebfcV3m5K06xTEdqPRDZLk57+8z1E9qisrGzT8oGfQpbbhlq3vg3?=
 =?us-ascii?Q?t3bQMTJZJrS3cPk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6RfB/0+9cC7pXVYZvgtWQz9l9/d3e9hxGSCn9GXxNMqjr+IpAbInZKUJIMY4?=
 =?us-ascii?Q?E7eMJIgptDd0wGuq7osNDcMKkOjndqnViMsOggQZHC+lSt7gN0RaSt48NvKv?=
 =?us-ascii?Q?DRZslrDsR6huyMcAOjEEg8OlWW6r4rUqL8In/Grewf/GlbMk+mWKp9+3OHdX?=
 =?us-ascii?Q?ivPNv0tOjNqB7FsIPsL/DO8NrW0yQplwfTlasP+CN4gyn4JVOapqEm2HQNEd?=
 =?us-ascii?Q?aQOUujYYjmUGWIQHfIkaq7zdTzQTYSgi+MQ4nSZB07n2G80dElDG1e4Qnx+U?=
 =?us-ascii?Q?uWgTphZqczh1Sbz8cRfRd4PdOiSqoWveCUafFoiDmH9qUDhsgvqKoLz3rtOk?=
 =?us-ascii?Q?+7WoQ5oatebPm7uw5c1aolFV+uPTbO9uRKgDMYU4AHN665gGbDwxUNuArei0?=
 =?us-ascii?Q?DNOPGkZtDbrKLBMaro+Rb1JhyUqNZkGrqSntyzE2HOGZUBQMP9A6Xa9haH2y?=
 =?us-ascii?Q?9qMeDz5mEUSNRmiLHF5vThihprw5bNWMMeWyIiIWKaLMfAOpNGQoTd5MJbYe?=
 =?us-ascii?Q?SmvHt9dlnyMbEiGCipfHLG0fKATxfvg6MPc36Dp0n2O5Bq156tADuuVnBQuX?=
 =?us-ascii?Q?C/QNyhDY/5QtC/lKa5FdVBY1vnjxJoVBmdAtPrwfGsN/ukJQJpOsRH1ruH8Q?=
 =?us-ascii?Q?NPRlKclUWUS3Rfoc/3c98g7M0vTfQpJhxSTxdqXst+XV4qeXd/03zOTGDSM7?=
 =?us-ascii?Q?GOPNSM7FFhMy2yTlsft78NyYhEEMAdJib2IZ7QpQVPE5IETGjExcdKhTcGi8?=
 =?us-ascii?Q?Nn52AuL8Kzs+397ifXC2pO6bJJp3gl+XuecF6NPvFlsvOYKa4x849YlNxcGX?=
 =?us-ascii?Q?I1HrxTqZjLotn1jX/zJnA3N1H4P2Dzc3i5q5cgtVxrQ7Qw0vnpDVp9pvkFH7?=
 =?us-ascii?Q?AqsXVO48V7daMq9oyWPzkU6p6mw8x9ebacqGXjqJu/3ff1ohCfqSx2OXjKnf?=
 =?us-ascii?Q?IqkqQSAufdwbVv1L987LmsWbooIST0fXIYkBE+5dnjwSd5SKp+XxkKY1qNHi?=
 =?us-ascii?Q?IJPh4M3iQ1exVS6VophrE4tJH7xUzKqEbZ/u12tJDBOIpwjfYkKoNn1Jn+oC?=
 =?us-ascii?Q?QIi5TmvNdnwD6bm0NEwzK7ZgHYG3pFRfDs40Pjhscy8OIHWXqwOqx9aFniGh?=
 =?us-ascii?Q?fqBjDPzaJGXKIuNnD4ahZi7kuEqFSNyE3AnMsdjTPabLCkBkM6oZ7l72b5xb?=
 =?us-ascii?Q?PsTHqISmbWL9o8mTcQfCKy/WLvdp1FBA/iYYQCuNESzn2guBL+ec/WGIytzC?=
 =?us-ascii?Q?13mtzdX7sPSLmWSCXKzPw/AV48+SemZCHo7LbWoK59cbNy4m11T2XmX8LUmE?=
 =?us-ascii?Q?koSJTe7y1do2aeZmv+hNH2H0uROGxVmIjuKzijC3i65+xys3x7uw8lID/hJH?=
 =?us-ascii?Q?cgw/6IbA5E7JFeteMkRD/bmj9yet3WsHfmbl3ewbmeFhsl6ABpdMf6o3vYj6?=
 =?us-ascii?Q?gAD2t9cOeCQQ6P1JXerv0/qNHHPgM+76iu0/r7+Q4Q675YeYhVvApl0UnCKv?=
 =?us-ascii?Q?W0xM8N3SKNLtpSIYZA4W4LhxKOK0LXTv1lUfUQwxlE7nDHVwkSc3AsdYQDgv?=
 =?us-ascii?Q?ITevUlE53uzI+Pk2aQpNcHnBUxR47TaXsAuq9v5P?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba50192-b781-48a1-966f-08dda32b96cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 05:49:36.4776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Bsz5s4RzbIb3Vjb2QS7aiHlyQ4rBw7zU7tfWgZFP6ZV1INSnci8YCpJUXbjEfVVXrQ1KehmOm5lIIT5c8p2jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5267
X-OriginatorOrg: intel.com

> From: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> [...]
> Subject: [PATCH 1/4 v3] ACPI: extlog: Trace CPER Non-standard Section Bod=
y
>=20
> ghes_do_proc() has a catch-all for unknown or unhandled CPER formats (UEF=
I
> v2.10 Appendix N 2.3), extlog_print() does not. This gap was noticed by a=
 RAS
> test that injected CXL protocol errors which were notified to extlog_prin=
t() via
> the IOMCA (I/O Machine Check
> Architecture) mechanism. Bring parity to the extlog_print() path by inclu=
ding a
> similar log_non_standard_event().
>=20
> Cc: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Fabio M. De Francesco
> <fabio.m.de.francesco@linux.intel.com>

Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>


