Return-Path: <linux-pci+bounces-6700-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 732278B40A5
	for <lists+linux-pci@lfdr.de>; Fri, 26 Apr 2024 22:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 968001C22547
	for <lists+linux-pci@lfdr.de>; Fri, 26 Apr 2024 20:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5DF1CD38;
	Fri, 26 Apr 2024 20:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BTtVbdf/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9FD2D03D;
	Fri, 26 Apr 2024 20:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714161824; cv=fail; b=noO6keBXzDorczDFPXg8MnydSd1ZXY/Zms9sT9wlYUTSPOLL9f4N0OyU9optMW4BZ5bSBSJZk4pNoupBf1ifexNFr/nuOf6pbZAEkOKtdnVXbEztZMjvHkotC48kYWAHIJ1MkDambYe+bvPPATmRzn1k96afkuXHNiU3yiqgyck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714161824; c=relaxed/simple;
	bh=LS298wyiiNv77Y/Uyhdi3yCLZ874unA3LUm1XArrA6g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jmn/S+oiBCCxwIGXXXkXffedQ1Mafj6ONF2ldWjnScm1CwxHoiDOK6MB5rPcv5cLJaeUBAnKMLJlp1TdHav06ZbJsFhGh/cNHr8qqro3IUwxsAvUAHtOuSStExBdgzR1YSFhSQmKwxj7xK6EUHIvaweWSXvSv3PeRDlpy6O6+Uo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BTtVbdf/; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714161823; x=1745697823;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LS298wyiiNv77Y/Uyhdi3yCLZ874unA3LUm1XArrA6g=;
  b=BTtVbdf/d/7TtSQW9wQjaqhJs6DgOFDrd08+DL2gksVLEufHOOk9AfVT
   kkV3T1F5H0BCJoXLWb6Q30iou1jmzHCCLH/l9S05Ga8Wfa6F7edV+sk3M
   QIzM/xUMczkzPI0i46BBwk+MPy5jhEbQkN2TOOUlku9OS8Yfp97EN2J9A
   76g1qrupWcsmy40CmM5fmCVtzkYtTIkBY8U7Jc0d0ISNkhvHVkRzGfdeg
   QDPnMG+07vPTRwwQo3NjEQGkjY1N7NTYCbgQoS6IuNSpWYsipI6i4zbkW
   jBlWjoGCYiZtpZHVRLXKfB7ZhN4+bArC0xdupi9C1g2Zb/BlmBMQfkjPA
   A==;
X-CSE-ConnectionGUID: HS9lb/BCQs2smcIFNTgkig==
X-CSE-MsgGUID: 8SvwS2gjSra0IqrFaV6msQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="20595069"
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="20595069"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 13:03:42 -0700
X-CSE-ConnectionGUID: msSlwC3/TaKtLreTmtWOIA==
X-CSE-MsgGUID: Eul2ouSnR12tzX8H/s9bpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="30318953"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Apr 2024 13:03:42 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Apr 2024 13:03:41 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Apr 2024 13:03:41 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 26 Apr 2024 13:03:41 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Apr 2024 13:03:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W75faip9yanKfGKDtfo++sfstuDa2odP1yV7l6tLKGpn169BHzAM5X1SnCQu/10d0jNfHhlUhMZFCUd7ZMQ+1o4FLnhyf5xBi6jjzNd5O29leQllN4J4QZvch6HEoK7rSuVzeUouU9vIn8KwG7/Rsvqm5pS4YYTS4rOuyrju/oVWERatAK40FXEKLu3BSXrWVtcEsiHSe6sSKmrSBUSt2xtbHSnUirGdrHHix1p4o0Md0VobKv92t6bVCWBEC+AxtwrEwi5MAhKjLuKhohHls9BAHfMv/kLGFRE5hHivAeiFakrcskHjxS7BcNllo8zeM5AWIWvrlvDkOknEI6b0fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hAqJPNQ1oc5YJbbeRjJfez9os5Xjcc+5iPzc1lHbpWs=;
 b=FjS90WVz+LsS+pOw4b2OLjPGRNEzCQWUW4o5D8WbeX5PlB0stqBR/63z1PtpOf3zakCTTqlcfVKKuEqMmPm2eb2+CGy6bUAx1Z3hLCZC/LdZQpRQHXwUq8wxnrfisoshuQVlMZksKKULpMwcMZXmT/57KApzrSjoBhwQp5T0Vr3vItjKXO2AbmyBTpLNaJRrch3VdMxTUalSSfmJV6lSKZh8R69AYj3vNZtOj9fZMAA2hYCPap33hUjW5ZfeCdBbm7jvf2fuiz4uqIespq+4ThqsWlAGHWQls5aFnbze8urhINXLpq3sF/ZMNCKqvRNXjfz79zvuvGNTpjWEru95LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN0PR11MB6010.namprd11.prod.outlook.com (2603:10b6:208:371::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.30; Fri, 26 Apr
 2024 20:03:38 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Fri, 26 Apr 2024
 20:03:38 +0000
Date: Fri, 26 Apr 2024 13:03:35 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <bhelgaas@google.com>,
	<lukas@wunner.de>
Subject: Re: [PATCH v4 4/4] cxl: Add post reset warning if reset results in
 loss of previously committed HDM decoders
Message-ID: <662c0897822f8_b6e0294aa@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240409160256.94184-1-dave.jiang@intel.com>
 <20240409160256.94184-5-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240409160256.94184-5-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR03CA0224.namprd03.prod.outlook.com
 (2603:10b6:303:b9::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN0PR11MB6010:EE_
X-MS-Office365-Filtering-Correlation-Id: c470669c-dc0f-4d2e-1cfe-08dc662bf668
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?H88JISEK2xK18+w+dPjhko/EeQgJGE3R+GIjBoySFElftygyWY+2UH91k0f3?=
 =?us-ascii?Q?bUzU8nJZ4O1QMpx8Cvl3PGhY5taW+YqmHTA9MQQ4/a9ik9SeApUp7DD6wFHD?=
 =?us-ascii?Q?16BePpLzRaKDlN4mjX+mt6gJYiw+V/Qj0WtDQTSbPLj+rUdtjghDaPt5qxUC?=
 =?us-ascii?Q?zJuPFoW8sufQfZoDU/7k1tOCPV3pIHkCdhENv6WGH7gVlWpNZO1YnwDCicIn?=
 =?us-ascii?Q?iWOESonOVqsflOWh7Gv39BofDnEb/xu7QaTMw3P4fA8Z/4NrRNIDrB4oOJ+g?=
 =?us-ascii?Q?KAypNLCQM6N1J49nKpC0IYkrvhaAm25mvDS+3MTSpb0PfpzTOk5OjqoRln0c?=
 =?us-ascii?Q?q/8QTxCCV+e5KMaHngzUA1hfvflnqYOQgGOc/+koXugBzzebR3Nm0M0EkoLP?=
 =?us-ascii?Q?Z8Ss598n3hTFPJPmvsRk3fqZzZwIR8HRNDojVeIcAI08WTC81OtkfBWAhJlz?=
 =?us-ascii?Q?IcUrtzb+4w/K3Lv+lfn+IlBcln6VT9TuhUcrBL3J6ERjOqQAdwYnWKrFUZln?=
 =?us-ascii?Q?RKYTpxb6vDZrUoGd2YXUBPAMty25R96GdlQetCxZolGiWbp8TlVVZSm2qKYj?=
 =?us-ascii?Q?muzuJSDBqMt3j6kC/L+posxg8A5M2x3XE2ZYh7eyMn1/UKbf0QN07qkNrHIO?=
 =?us-ascii?Q?VKJs3WjH3+IHU689jC5pfeBVGXdddvIajrenn0juXiiqF0rwN02u8oSQ/8f+?=
 =?us-ascii?Q?3Nd5f1helL4FrfP2f6u16ZZY4Rqu/SatBhyFywn4GEMYhXs2lrWl70DwT7kb?=
 =?us-ascii?Q?y5RzsHmOQvcpZ6/IDv9THqCz0oSaQUNapx62Us23K1qCPxiIRCy9QRJ62A4g?=
 =?us-ascii?Q?U9VEn3AKjoKdIL5MFL5VEEEXf+pDmrcRbpmfbTX7q2/wEsUnmwk2NuChC1G0?=
 =?us-ascii?Q?c8S16GWkm073iYyXaG057e7zHrvKDcisftxaXWKXvODDzI8ygpOMZH4tPNfQ?=
 =?us-ascii?Q?mhSunCTBBOhzE/sqAHYbQlQhm6Ycd/sODsPNSjyGOb/NFTo9uTBneDY1jJ0+?=
 =?us-ascii?Q?KoMPQQi27QVPmSx2uwVD/WEo+A57OE7PnIMuKPSUBCQT1YoU9YJKdAke9smK?=
 =?us-ascii?Q?60hxn9vjV8ulWstz+BeYSrnkgBRr2XCEApBWxFwejlN9qPFNWYcvp1Uf+ErX?=
 =?us-ascii?Q?vFPT6VzqEyf3RmVH4mgLgPnHQlPH5/mqMwZuiDxnaq6OViScaOnJRhjd2z/m?=
 =?us-ascii?Q?hUjr5PTF5jwhxXID0iVoaPaRsW8wrtbNHQ49sroUXl6TyZDEWrbbPtCybhCI?=
 =?us-ascii?Q?RlEBLgHMyl2lPuzgCutvfFYToMQV0QgPzcjqAupxHg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JxhFFgo4PKFmU/n87HUU5bT7J2dFIu4UF8J5132FYFQMtvQIE+BT0ZFWDzll?=
 =?us-ascii?Q?HtIKEMvZDDQR7msS2bA0yM0KVJs7yHd0ZYpY1K17YGwlVulMzJnnIc8D8RRX?=
 =?us-ascii?Q?5hM3CeLcEidq2rEP3a/HX8dWTjGigCQh31YKsCjvvR7ba637sZcatW6Zakov?=
 =?us-ascii?Q?VM4nHXNikegCNKMAf9N/1937KznMWz9JGCyN6A0Gag73exNjt9XxgM8hLt/n?=
 =?us-ascii?Q?BC2ogmptOZLhguQAXbamjlt0hyQmcLqnVnQO+IONHtnN7A7zqKJD06Z73RV+?=
 =?us-ascii?Q?8RY65xiWZ6J8xuvUMC/7uCUiJMPuyAkBP4tc2SElBtJc4l9nqgfJY02fd5AJ?=
 =?us-ascii?Q?AdpsDdUI9YVYcHINoALlwCcZLQNAJRqh8EEXSF/jLqCjs8RmEjfsA4MkAl6h?=
 =?us-ascii?Q?EiQ0/ZdLguxdFPojKFO0jLgOAZmq1thK0q0WPPYXxMoxyUksTZ4tq5bL7QOr?=
 =?us-ascii?Q?Z2CRluN3UGuyPcAUIAzxM/6D2Oajrh5nv7M6rxETKAMla+zI98HvFQm5ZRSn?=
 =?us-ascii?Q?MDEVYpB1BWYIBWsbkAqu4F1EadTWr47eTaavXXdLQTk5udGiqrJBNGGLxbnw?=
 =?us-ascii?Q?jKQA6yMRLLbLiXrvBa5iYLpgzbNXAHuXE4IHVaS5/Z0hNDJej2N8i2LQX5E8?=
 =?us-ascii?Q?zYrT1e10MOKmFnlRx4oVLt075GNQk09QW+S8ToX+HGLhnNdiUmo38t071g1k?=
 =?us-ascii?Q?MKocAkYKnx8JJ25ShQnNgFy1iwNrRUbj4OP8oSj7+2sylb19pEc6Bwg2K2Qu?=
 =?us-ascii?Q?k4Hzc1d9uLV0EbByZly+beKkqWQk1w0N1RAE1S1ZFOJYWCRLomZo8xYw13A/?=
 =?us-ascii?Q?U/heVJWvsYRzat4GRPEX3syZNPCr+XzMhhFIFtx3YUIZruzfrwzhQBy9HWew?=
 =?us-ascii?Q?qkyGaMPUGB2Mm71xZrelP/RUWHBBtFuPkZJ3R4biph0dinXxjkXq4cVZZSDf?=
 =?us-ascii?Q?rUmJ3mfbWMO2PCqTrSDU1HWa2c1r6BGrsk7nMOc3dDGtqTlXvAqAaR33JRNn?=
 =?us-ascii?Q?D8ByQ2PIh89GDQNSBbt8ivbXLtYrtIsVuAbmTUp79cX9K8znjd5xO6xSCN/O?=
 =?us-ascii?Q?Fkjlz4kp6H1vVhIWcXPBG7j/xYtvQNTzdUbl/1HXDdrS0LoFKHQFZgL4m5Ze?=
 =?us-ascii?Q?3x4muBThUa3HQNg9zmFRylbcIFPcbJOlloVHekNSspmgeciPa6KoYtyKFsEY?=
 =?us-ascii?Q?djlZguc/tqPkhB3K3paOX67kKlmpUbzkcML10Xh82AyZbrYBPhP8hYaBFHU9?=
 =?us-ascii?Q?th+Qdmd0rGTWDChmGybnUBbPfoqh/IhTT8EyQO8SKJpyirS1v0OJ0mefVmtW?=
 =?us-ascii?Q?RkVnLrPKDwi/spRmXBZNp6nDDnpoX/+PObddr7WJ7MtNyGJXks0rbY6VlZvW?=
 =?us-ascii?Q?MJCWGzmDUUku73aBUAsbl3Gi5/8rgl5RQ8A6xwmIo307TvSQW42i0HRu2iM9?=
 =?us-ascii?Q?KnI2m+qrUX4dv+dWdLXqiq1/7OV/Ljw3LEkKBSZZrOcKYkO1Tr8AcAC0otb0?=
 =?us-ascii?Q?WuNNgIzqGgUyukCyWZnGX1FsindIHzR29g82DCw3CN3zcCHMMc6nzE3oQUiQ?=
 =?us-ascii?Q?DB97BX+b7DAVPWliC3tMjXBTQLEyNvq9EFoH55DlTVdpHr9yJTX11UsiuLKI?=
 =?us-ascii?Q?bQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c470669c-dc0f-4d2e-1cfe-08dc662bf668
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 20:03:38.5401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aNduXKAWGb1LPuVrJxVEmcnxGk7oOQ8KP4yKL3/nclTjlXkCx7vNJ9WoVm4NS0wthTHUEv6dYifBbNTa5R/NhaiGChn78X2bwvAmfNfFNUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6010
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> SBR is equivalent to a device been hot removed and inserted again. Doing a
> SBR on a CXL type 3 device is problematic if the exported device memory is
> part of system memory that cannot be offlined. The event is equivalent to
> violently ripping out that range of memory from the kernel. While the
> hardware requires the "Unmask SBR" bit set in the Port Control Extensions
> register and the kernel currently does not unmask it, user can unmask
> this bit via setpci or similar tool.
> 
> The driver does not have a way to detect whether a reset coming from the
> PCI subsystem is a Function Level Reset (FLR) or SBR. The only way to
> detect is to note if a decoder is marked as enabled in software but the
> decoder control register indicates it's not committed.
> 
> A helper function is added to find discrepancy between the decoder
> software state versus the hardware register state.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v4:
> - Update commit subject to clarify. (Jonathan)
> ---
>  drivers/cxl/core/pci.c | 31 +++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h      |  2 ++
>  drivers/cxl/pci.c      | 20 ++++++++++++++++++++
>  3 files changed, 53 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index c496a9710d62..597221f7f19b 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1045,3 +1045,34 @@ long cxl_pci_get_latency(struct pci_dev *pdev)
>  
>  	return cxl_flit_size(pdev) * MEGA / bw;
>  }
> +
> +static int __cxl_endpoint_decoder_reset_detected(struct device *dev, void *data)
> +{
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_port *port = data;
> +	struct cxl_decoder *cxld;
> +	struct cxl_hdm *cxlhdm;
> +	void __iomem *hdm;
> +	u32 ctrl;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	if ((cxled->cxld.flags & CXL_DECODER_F_ENABLE) == 0)
> +		return 0;
> +
> +	cxld = &cxled->cxld;

Nit, if this code is going to use the shortened @cxld, then use it above
too, i.e.:

	cxld = &cxled->cxld;
	if ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)
		return 0;

...in fact, since only the base 'struct cxl_decoder' fields are needed
just go straight to:

	cxld = to_cxl_decoder(dev);

> +	cxlhdm = dev_get_drvdata(&port->dev);
> +	hdm = cxlhdm->regs.hdm_decoder;
> +	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
> +
> +	return !FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl);
> +}
> +
> +bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
> +{
> +	return device_for_each_child(&port->dev, port,
> +				     __cxl_endpoint_decoder_reset_detected);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_reset_detected, CXL);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 534e25e2f0a4..e3c237c50b59 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -895,6 +895,8 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>  			     struct access_coordinate *c1,
>  			     struct access_coordinate *c2);
>  
> +bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
> +
>  /*
>   * Unit test builds overrides this to __weak, find the 'strong' version
>   * of these symbols in tools/testing/cxl/.
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 110478573296..5dc1f28a031d 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -957,11 +957,31 @@ static void cxl_error_resume(struct pci_dev *pdev)
>  		 dev->driver ? "successful" : "failed");
>  }
>  
> +static void cxl_reset_done(struct pci_dev *pdev)
> +{
> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> +	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> +	struct device *dev = &pdev->dev;
> +
> +	/*
> +	 * FLR does not expect to touch the HDM decoders and related registers.
> +	 * SBR however will wipe all device configurations.
> +	 * Issue warning if there was active decoder before reset that no
> +	 * longer exists.
> +	 */
> +	if (cxl_endpoint_decoder_reset_detected(cxlmd->endpoint)) {

This needs to be careful about racing disabled cxlmd, something like:

    guard(device)(&cxlmd->dev);
    if (cxlmd->endpoint && cxl_endpoint_decoder_reset_detected(cxlmd->endpoint)

> +		dev_warn(dev, "SBR happened without memory regions removal.\n");
> +		dev_warn(dev, "System may be unstable if regions hosted system memory.\n");

These should probably be higher than warn, dev_crit() is likely
appropriate.

> +		add_taint(TAINT_USER, LOCKDEP_NOW_UNRELIABLE);

I see no reason to assert that lockdep needs to be turned off. Likely
the kernel is crashing before even getting to this point, but if it
survives lockdep is probably ok.

