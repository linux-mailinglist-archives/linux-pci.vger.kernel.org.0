Return-Path: <linux-pci+bounces-13206-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D507A978E0B
	for <lists+linux-pci@lfdr.de>; Sat, 14 Sep 2024 07:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F2F31F22598
	for <lists+linux-pci@lfdr.de>; Sat, 14 Sep 2024 05:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C65A17996;
	Sat, 14 Sep 2024 05:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zp6c3gUJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303E41758E;
	Sat, 14 Sep 2024 05:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726291992; cv=fail; b=s3VGI6eodaUHG+X0iGCmuw2amXRUCI3W7WDkeGL4JARG0KYLg24SmP+Fl4wBR1ZxGaVZkhP0aFgPGCWSAR1+UzSb+AA/DHKBGiXtY/DhSGm0qm1eoI4UmJR8cP8Wpc15SwW76o+Z3kpy6Yhlrk8lZ05iNK1eWecBaQJdv+UlxKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726291992; c=relaxed/simple;
	bh=Mmm39/nWHfUDYw4sZqFZNeFGYJus4k2HA/kIuYGImBA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FJFo4wSUMZrnprxzoriEpactrv+f68H+H6EhRXDUvHTUeVgNtZB4PIhc+XEELC18WXdvbqsn9EXAZV6PPIA+I34edwuGQzxm42dw3zeTJg6GGxE3IvBxoigM89SquAscPjg9osd7Chz9SPH8JE0RdqBuAhO6tM9zKX/SWk7T8QA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zp6c3gUJ; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726291990; x=1757827990;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Mmm39/nWHfUDYw4sZqFZNeFGYJus4k2HA/kIuYGImBA=;
  b=Zp6c3gUJlxbs66hFl8Fvcbtkh77P7xCpM6ZoZtyxigL+X2fR6j1QC2Sz
   AI8FCFQHcNZz3z8Fzb2rOlwogdoceR5oVuPSPkd8nwITvC5eQbG8xNBRz
   1QhpIQ9tNWDy3ZWEdKMZ0NM0YjI8lUpF3TKlKlumaNbF3bgLMVcG+5Wss
   XDSDX+M3JzsrvbnoSI/jXaxMfF9yYuSRpsAe2VcwPvYEvpGB/j1vHg532
   Ui9kEyaWUTDumHG7VlD73vArNnGvyj73H1ncVUmo4UIF9OV6IoLmA0O2D
   +Z8gFnxWOhSqXysk0/jaTKNVl7DKyrVDgVjKGHw1bOJsffaYOLeCHVVt2
   w==;
X-CSE-ConnectionGUID: 3xXYAWw0Rh+mizQV511wjw==
X-CSE-MsgGUID: 45S/G7Z+QySkm+tsTmvDKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="35784282"
X-IronPort-AV: E=Sophos;i="6.10,228,1719903600"; 
   d="scan'208";a="35784282"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 22:33:10 -0700
X-CSE-ConnectionGUID: AN/1IsBeSXaCKTT6xFgZpA==
X-CSE-MsgGUID: C8xaBD8TSt+OePOMDyHP1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,228,1719903600"; 
   d="scan'208";a="68819845"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2024 22:33:09 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 22:33:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 22:33:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 13 Sep 2024 22:33:08 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 13 Sep 2024 22:32:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s5b0bqVKaMFRz2Rm9qIGh55eo6RR/Wx4O13uFbDS09Al3L/2Aj75Iai4it0sS8FiAAiELqJWseQuiGtctZosIgg8wKrHYsiALQ/pzjYCVt4goZKdlcmZmhoFqBrGN6q2BiRTQww0utMhiMffZrShrn0CdRKqdWTFNWQehBgehI8YO5eu9f/QZ0al1TkkQDkYQWiHbvjTTUwjDz0aY5XjZrE2XlUjk3eXxM+5rdiuOeWaUA0Iqx13D1P61QTLHcZQyHAJRQVxjSQnUjBxx38Qec2gSFmVhHZM9S7DcCg0zbHd9EzB/aKtD1yy7HiCw/HA4FeVx/NLxSG3WI0c160H+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+RxhBEGwrcpoj38vn9uywIhx5yC10enhPWA9a1ZXKs=;
 b=nVSLB5TEtHGqPOxtp2uYtJFnKw1uh3mKiUWQxeERhN40X6x58lYUG0A4unVAe1781Wb68wuQisMmWl3by0U5b7Yw7wUBh31e2yIrcA4ib0iljxIdD5qXuUWWvgPRf1FOpQp/JHvlkbUUbTS7L6hCLUiqWELDxqLjzIbHcojz0fJQcnNp0QvztOs99y2e+8D2+33MzRrkCS+Ue83oJ0HLs2D9nCbdRELiJRDqdqfaLlAMZ9QJL/cWvVZSzCc7b+MZnB9VQtP1DC+0THlZrO/5XZPvhaZkuJbEgrljCSf0ul49+4FxWfgQGp/pF78mCWrdEH8EyTDYRmF64lclrDrBsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM6PR11MB4611.namprd11.prod.outlook.com (2603:10b6:5:2a5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.21; Sat, 14 Sep
 2024 05:32:55 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%7]) with mapi id 15.20.7939.029; Sat, 14 Sep 2024
 05:32:54 +0000
Date: Fri, 13 Sep 2024 22:32:28 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Gregory Price <gourry@gourry.net>, <linux-pci@vger.kernel.org>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bhelgaas@google.com>, <dan.j.williams@intel.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <linux-pci@vger.kernel.org>, <lukas@wunner.de>
Subject: Re: [PATCH] pci/doe: add a 1 second retry window to pci_doe
Message-ID: <66e51febbab99_ae212949d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240913183241.17320-1-gourry@gourry.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240913183241.17320-1-gourry@gourry.net>
X-ClientProxiedBy: MW3PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:303:2b::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM6PR11MB4611:EE_
X-MS-Office365-Filtering-Correlation-Id: fd3bf189-65dd-499d-8960-08dcd47eae89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kW/fq5Hv4v/e+Gl7h5WIw0Frlcfzb/5kJtPhx2IlQ1y0m5DaFGp08H/u6e6a?=
 =?us-ascii?Q?u75UAkcm515QTnJ+SwUs4eDZD5p/ptx4H3GfRlhRfI52ZGGdCE2Ri8/QekMQ?=
 =?us-ascii?Q?oWeqO6cJu8v/Nda/QAwSbGnTUYt/lPxqqjqqqHT6AfP08I0FEIlD/lmMAfh4?=
 =?us-ascii?Q?1xkzUBvBv8PMwt2asi0GEUyvqi+y03eRGKPPoU8eWMpoX/TOJMtAUu4AsRMJ?=
 =?us-ascii?Q?o3rABWhWzGypeWhbPYzGK+UfdgAaPQ+/RJplQdMOReS6ipWYRxrlDbkes4aM?=
 =?us-ascii?Q?m2bGSf1N411qPZNpRl//pFMbokyfVUzApx6K3PnC9ThZWLLwuoyWtnuihItM?=
 =?us-ascii?Q?7GaFqquoKB3mkjNQvhNCCcp2+Khsf9faVcZzK02UONPa5tlHki4gZU82klHt?=
 =?us-ascii?Q?uZgEM4ECOzWuNqvpYHE3BTiTXmEzh8l+ACKOgpZhQwgWq/R9HDu1PurRhRbV?=
 =?us-ascii?Q?ppmfV9qCOubXBjKarobfD+4UNjvxtd19u03rIS6fhJW+Cs5HVOK19piHvm5O?=
 =?us-ascii?Q?VRr221BkrrX1435zdJ+GbT+oIpQtYRtrBfEDA76fHxUxnA5cI6vqYjGtmO4w?=
 =?us-ascii?Q?S1MIPzQFAHPpUEPEPhihCleSr7UEYuA39SWCkJy9gQQAkewbSyPafOBPpXR/?=
 =?us-ascii?Q?XpNFHXnD3HzrbJHtQkHKd4AG+rvbwiFr56lydZHX/wNP2SGMtLhn0cccDIDO?=
 =?us-ascii?Q?YcZlnSGVnMrJzDxRC9JHzsAUp/+8NeXsaQTcJCuOeAf3js1ftPxaTWzJPg6Q?=
 =?us-ascii?Q?l9qkbDoiJXJJCVJP5vXr8nL/xHvX/9BQybxFi1aYuHbXbGzHYkQMr9yafi0b?=
 =?us-ascii?Q?yNAMyu9WrTICuQFHUe8imbumF1y9+6AWcASGcoGViixRbXDFWN2Mn1fj2t6Y?=
 =?us-ascii?Q?rudD34VZ0m6hsPN3zHcWERg2heRejWp6z3aR8yl+MuLjhKLXaAI6fUQbJQrz?=
 =?us-ascii?Q?9eDFVP1DGDaCg4YuW8w7V0qd9+D8vxk0KL+cNkMdeQNybT7zP5k9rpi064/x?=
 =?us-ascii?Q?phJXbRV7OeEn+6Cn0NaK1miRnEVeGtQgbRHf27NB1omEmpplCB/e01A2BswA?=
 =?us-ascii?Q?oA2hUlTM10QYe04oMCPDWKnBq9pY5qDLAARUiO0hVR2fabDXW+Nxsi22vjpX?=
 =?us-ascii?Q?0W4JuYLNF3paLtEu9Cy5EL5BLx9CD4SgC01PuE5cD8zlPcPpd93QCZdqmbXM?=
 =?us-ascii?Q?5aIVXDzJ1dYYb9BF7g+uXmO1qG7M+K6KV5rWnQDd5YpHhJlm7IRMrQgw7yMW?=
 =?us-ascii?Q?yWj9K5+OcGUCLCPx6XdBfo7vqcw1MUmD9rFF0QC28Jk5dGUBnr6NsW5m1ome?=
 =?us-ascii?Q?htc04NkaRXJhNP3oM4XHae5Mx8MDh5kKCls0UUJ7Vd/fsw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YQbU9aj15hNhsK60Gkf1cL2f3rmM3xG4V16uph165pZfh8w4GElSPknLzson?=
 =?us-ascii?Q?nIEoDqtlvAdPnF1PBltEMV3WP05KDWG8NS+9iDfqxP2NIcoBHBpuhEkIi64v?=
 =?us-ascii?Q?5mTvZqXSMHR2P4nNLj8xZq5hEHpW6byZ/NYOH1G40EOifB82TGJerUC1U6BF?=
 =?us-ascii?Q?czeu+MBFmcLiEHa2sGr6ajF9oWnQKyTN7E4uxefmKsyF+9vJvourtrcFV28K?=
 =?us-ascii?Q?9UqECiGTuB8Puwy140dpG10qF6dlBA0xqi35wzbwLGpLann3urMkNwV20JdP?=
 =?us-ascii?Q?g/VROLmrtqrbmUeopZtpC7y7/NqeupZ82hZj++WHkkhhro7jdPwC2czzsf3k?=
 =?us-ascii?Q?j8acO9v6aOG955f7IlrLFWIs2HuKVnxMIi8SY8tLXYsaiqR4bUxoYo+3AEvL?=
 =?us-ascii?Q?wdYuzRjabg6cFqrPMADVeY1PRl+uJye5qEfBPsCrBLOGvZxbGkgIZ0qmII+Q?=
 =?us-ascii?Q?8mp3HFbdraGA8espujbw4IYlMJhj5J2qdC7oblslWY8GYeH+71x53Jo/PbJS?=
 =?us-ascii?Q?LVzo7WTH9XhncfmbAVQCJZIsmc/vlCRjtqOCIM51n/cbkH45sE1aF4e+IWy+?=
 =?us-ascii?Q?GWxvvgWWhznQn/yBQI1SES3fpLgsb1ef9tulQhy7BCsKkPheFDc2/XiXJ8OF?=
 =?us-ascii?Q?2syoWPkNSBHaHjql382sepLBRXYHY9/pmwHe036MTXtA7GOyK4hBvQxajhZt?=
 =?us-ascii?Q?ezN0f09YOkrrSXIil5DhqL4RgjLwfHS270f9+McURbbmyyiMQY75cxsQh12y?=
 =?us-ascii?Q?NR7m8LNHPBW76g4Iu5h+mcIlc0gmRAoDbRWdDi+PUuONCvoQCbU8MCovwP9j?=
 =?us-ascii?Q?zasn5XBLRwylbIhh5/O2Kb35v/X7SjBWdfv50/DJL4R/mBsVxKnSc1jDX2TP?=
 =?us-ascii?Q?xbj6EeWYvbEF49Z3zxQmpYfSO3hIDRYZWa3IjMWlRRqviOYb0rGWtHodCnqW?=
 =?us-ascii?Q?jUnN+Tvgo7twcJKjIWJsIqwKxuj9n0lKi4TNYX94EJX7HFOKBH2M2aq2suHD?=
 =?us-ascii?Q?05AqccS8MQPyOkwzdTDRkaTOpMpdtlTu854SDLAMqlwQDRvcMRaTsJWtCXk2?=
 =?us-ascii?Q?Ig1qbBQgA9rJZCLAmRLw7qbdJhrEfftgzsCjSxrP/HhvLcVQ3nUsuDhG50x7?=
 =?us-ascii?Q?zXKinlP4IHGRF5rRXhGVqWfN7a4mwUXE2Ltklp50J8n+YcsP41EUxIl+/1oL?=
 =?us-ascii?Q?UWJkJkHt2OaQP0ay1QZC/fa6Vip0VR+OD0InQ0Uo0zC6hCZiZtraWVxM5zik?=
 =?us-ascii?Q?HBGVCT9QBbIaP0ixdGNFON4O2wKFtrniwKliucxx642R/lMwaJGZ4P/p6hWC?=
 =?us-ascii?Q?BCUVyPjvfmOx4KV8xZZa0EQ5ysC2qOvXRIjWcquvBXmv/G5OBjmRrOT7yKtV?=
 =?us-ascii?Q?J7RpnEOmsMbl7lgMBoYQT6ZDz2P7yTrFDB0lrC8S6YFJbWeBlQmotN6wF2Pe?=
 =?us-ascii?Q?jZg0/TAhtJwbIXwB3NDXvOI9IXbUHKLJTCVSok9EavzGpEdl+67NwJdc9il8?=
 =?us-ascii?Q?ybhOHxPy9grnutBOU9oKuYsbtl3DV/AU4aqf/ohJyvOU2kbF3rSQFr3VBE1H?=
 =?us-ascii?Q?XPUd5DzfdvEtS9fpefRdbvUePwq3StnFY6quhtpo4pZ2cD1qGJFM2dVW+o2R?=
 =?us-ascii?Q?FA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fd3bf189-65dd-499d-8960-08dcd47eae89
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2024 05:32:54.3913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: znPm9lj+IZ+e77JfBSM4lGK2ap9/89sln82wlrKJsxmGTe8YWykTww1bSSHicSM809Ig7/Bmf4IUGwRsF7h1UqrGNgxPkcMFeR0tKeehR9Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4611
X-OriginatorOrg: intel.com

[ add linux-pci and Lukas ]

Gregory Price wrote:
> Depending on the device, sometimes firmware clears the busy flag
> later than expected.  This can cause the device to appear busy when
> calling multiple commands in quick sucession. Add a 1 second retry
> window to all doe commands that end with -EBUSY.

I would have expected this to be handled as part of finishing off
pci_doe_recv_resp() not retrying on a new submission.

It also occurs to me that instead of warning "another entity is sending conflicting
requests" message, the doe core should just ensure that it is the only
agent using the mailbox. Something like hold the PCI config lock over
DOE transactions. Then it will remove ambiguity of "conflicting agent"
vs "device is slow to clear BUSY".

