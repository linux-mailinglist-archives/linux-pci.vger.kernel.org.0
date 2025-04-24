Return-Path: <linux-pci+bounces-26642-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B20A99F17
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 05:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B888816DD37
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 03:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9BB7E0E4;
	Thu, 24 Apr 2025 03:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gPFWv+Dv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B96E4C98;
	Thu, 24 Apr 2025 03:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745463674; cv=fail; b=WIZQHa0nTeGhLXkJSP2CSiz0pzwwNQohb2y6t/8Ej6cedwuudR8tPxJ1DYCdkXZa3bWuePei9pxI7QGho3FIMDvhrX3wrcfoPxkHbXOv9hD7kwMfx3P3Z3jvkFn0BdoRjTzw7ElMk/uYFQYyJYq0+Q+gtOW0RsTdEc2xjeg2m/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745463674; c=relaxed/simple;
	bh=qrdLH2nQVWEOI2xSI6PScHXV1PLQZR60cpPiQZnbMWM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uUppeaNrAvaAc1QGQaV7cx4SKUUkABE5IF2asmv63kwx8i86xjOxvL/bCLqdHNf5eCE303LhqMaZ8pA3Jk7zwKTS9nfnXnj7V6QKm8zgIjXlb7EY3+rnCD79Bzytcqxn4ixNmlr2jEO5lGBj4SBLLHFSRvNqUt3DtXXAhrCZ3FY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gPFWv+Dv; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745463672; x=1776999672;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qrdLH2nQVWEOI2xSI6PScHXV1PLQZR60cpPiQZnbMWM=;
  b=gPFWv+Dv5WM9Z1beC+U9ez9Q1S/kbn79KoCxM5EgkJ6+mT1LTNqwA1I1
   Pw8sofnBrd29T03UTM1kXEJgGVy3EAZh70/DAgDMtvrWm7sndzcNIycgp
   TT1sFDz0zGWSqZl4FWrp9xHPE+mQSllIdLfSn7vrEewoomFY4ZS1RG2Fk
   WolGRowaQ5K6AFiKP0zRPOxBioC0smtIh/IGjmACGjVEUVPTJ5gfSenbO
   7MT2DHh95AStKRRE/uuCZQlakIBhwD0vEd2+aEYkV3LgnJdmnnl6HbhXf
   2colVnJ6bD/rB0FSzgDGUVdNIOsHcCM/fVC97VV2VbUhQmolZk/JhAwq0
   w==;
X-CSE-ConnectionGUID: SFbKiKj+TBO7WPzyZBflYA==
X-CSE-MsgGUID: C6hrHPsRQXG8Mr78x+zGlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="46951265"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="46951265"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 20:01:11 -0700
X-CSE-ConnectionGUID: lpWy17VtQc+wVoGynQEVdQ==
X-CSE-MsgGUID: sVVBoj6WTdKXqLAXV3RNBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="132793298"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 20:01:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 23 Apr 2025 20:01:10 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 23 Apr 2025 20:01:10 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 23 Apr 2025 20:01:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QnUVwxTwRt+WhXPTt7tapFgkrdd4iX+4AykelqccoqW6aLVRkTiMRekPTp/LLowKjXtIo1QA5tLYzK4egBkhXM2HvKqxVoviPxQN1LtNEC7I5fs56BnaUvfpNk+C1KSNNKjXY4ofN5kUy9zWJ0tmRLhS7cjqAlU30VO7ZHTyq7wy5vTDMY7wXjqs+aDRxYBwEXj9gOJ1nOoIcfuVYrU4hJIQgxSWVbJiL/9v6eGrteBDnRNsQgW8q4ojHQh5ha9RDuPHtSEvT5xlme/y3F1us5RxlJ++Xxdq9C5cBgikBtg291QWOkVWfeIDTzdwzThWyWcgrw+fz4/R5svWwkWhng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0QVYStlJ+j4C0im4a5yinj7NBRqdSOD8EgjyDNwsi0=;
 b=mk/qNtHRACicf0rGHlAyaM21u2zATwMka+BpauzYN6V+FpVDNa6HGp0hNKtu9M1PHLHB+Vz32gJ9az5A+iekXrgvXWXk/k1XuMqQs0DcQQE85smFwLtDz0aahGEIwhXax9x/VzwDPw/5nA/tYFjz+jzv0nkg59zh/93A8oecNYaYqIUkPMTKiBheRmJwW+Em6cKr9xVUGB+ifvuWvFrDyAGytLjK6Mv6PL9cUFeowAg9TSNvuNhfzyq/QHbkNgKEyoPTi5chbLDtprTbMzS48k6wMYvtSfT0kRDWzxti+5Px6Ap7LTpRL1ZbQYprrRfcXfTDgrK9IrTneZ4NXLMDZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB8519.namprd11.prod.outlook.com (2603:10b6:610:1ba::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 03:01:07 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8655.031; Thu, 24 Apr 2025
 03:01:07 +0000
Date: Wed, 23 Apr 2025 20:01:02 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "David E. Box" <david.e.box@linux.intel.com>, <corbet@lwn.net>,
	<bhelgaas@google.com>, <kuurtb@gmail.com>, <hdegoede@redhat.com>,
	<ilpo.jarvinen@linux.intel.com>, <vkoul@kernel.org>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<sanyog.r.kale@intel.com>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<dakr@kernel.org>, <dan.j.williams@intel.com>,
	<andriy.shevchenko@linux.intel.com>
CC: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
	<Dell.Client.Kernel@dell.com>, <linux-sound@vger.kernel.org>
Subject: Re: [PATCH 6/7] platform/x86/dell: alienware-wmi: update sysfs
 visibility macros
Message-ID: <6809a96e8e5b6_71fe2947b@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250423175040.784680-1-david.e.box@linux.intel.com>
 <20250423175040.784680-7-david.e.box@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250423175040.784680-7-david.e.box@linux.intel.com>
X-ClientProxiedBy: MW2PR2101CA0015.namprd21.prod.outlook.com
 (2603:10b6:302:1::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB8519:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d39855b-affc-45a8-5a9b-08dd82dc41f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lNIjBPlovgjgQXhbg2KYFrmZEKLEYS+ox5NHj5SN1oQqN5+SWUmEIylepZ++?=
 =?us-ascii?Q?TQDnp728cCOKvMhjQPGdC61aKqh8x7KlMhvlj8ADXoYIDcirCimJvJLPz9GE?=
 =?us-ascii?Q?5gn49HQM8qvA65XF1K3mFEj2Q0mqjKUsyFTabpQJrSxM6GkVDTlnO8qC4ND8?=
 =?us-ascii?Q?Ku9DUoxRurvVSmZv32kPdibX/AvhsgZ9HuXg59eoBlP+mTVv3MQGkXqKW+RF?=
 =?us-ascii?Q?W5RGgIg5qKvUEJ15xRzc//x4lkzl48Hm3deYd4G0JVb1X7xY/PW6z4eMKA5V?=
 =?us-ascii?Q?aRgDFMUHPGcwJ69oGEszhqjc2yrF0qUcp/tFHH4vSgFjl6ep8hAX3aGpCKVn?=
 =?us-ascii?Q?r9WmvvdsbAVTC0AVbMtQIUStrm80ddTh4y2f6SPh3EuPxAroUyjpUAyptqFo?=
 =?us-ascii?Q?rwje9CrzxIK5TP2kSpI852Le90M9batPKqwpypCDM5rACXe++u0T+eJq2k4v?=
 =?us-ascii?Q?vP2gPyUQXNbLMsQ1dNqi/l4yB43XzL7ibvzJUiItiB3XcJzbSGN+8CehohCU?=
 =?us-ascii?Q?HDq4vHWGSBHZfJ/zPd+1+xPit6BKhvmh/dQ4hCmZubsFeclRouUdU0mbKFel?=
 =?us-ascii?Q?tblXXDKCMD+ciK7boysxbcMAzyBmgkpHYODcb37spQIkDA2EdwlH79EEO7zm?=
 =?us-ascii?Q?kI8TqjVXCj7l3PwjvKitq51rjvNe06GAheHea0i2GbBail1s8mTnj3xgdzcS?=
 =?us-ascii?Q?rsxDl/4T4n62AW1wJedEBxntiA3LoP83l4Og9WEAQ7OCuijM5M2mWq2DFJTY?=
 =?us-ascii?Q?2EweJFnrw338Bs3RT2NqWbizZsUBVLQ8kybH2a8YwSANBJL7psfdDqjq0sBm?=
 =?us-ascii?Q?AQOMJ/QlP8BpD4i5NTSlIkK6eL6AYIQaBOeo3KGWALvGGy5kXV1Hr+u+FRe5?=
 =?us-ascii?Q?zYKafrkxCoMZTX+0CEoX2aTGlr769amZlv+h4oFdhYw2d/g5MPliBb4pWiQG?=
 =?us-ascii?Q?sUB6gHPgXUL+/3Kfe9dRBzsuBap2L7xJfKqgF4hrRYSgqICvd0zlIZalKpeQ?=
 =?us-ascii?Q?4xNnh1PjsA8/drIgnW9XtllUjcglhnA7U0TzZz+myDsMql5DNgTR74D9ofM4?=
 =?us-ascii?Q?uHt7drgSw0KraSSd4RJLan+c1UhNJ3gaTi8a14KmRIGXz5CPlfMMyT2hpAA+?=
 =?us-ascii?Q?hdMHh8fyI4JmbjPGKXTK7awsFC2n0vPaMfulcfKtwX5HG16Bi9GNbdw5VN3A?=
 =?us-ascii?Q?DYX6XG6M0MzIwEeBwly2hQEOFmtm1JyQw/yURXiyhMau6xFGGtPPSO4QtRGF?=
 =?us-ascii?Q?sF5NUdZv0BvwhK3OqtcMDcPTHbSKMhx7Zu/5EvIIohVV1RjtixDmrK3Wb1Hr?=
 =?us-ascii?Q?7g6M6kCOSRiz28x9nq2jsINN7tD68p3GCpw5zo+BDTmMqmo5Brx1R5Tn07iV?=
 =?us-ascii?Q?CjNRe4IjCgoW+FSp4lnY6rhg1+XeLP3JrXD2+BY0/fhcqFcqbA4768ulnBoA?=
 =?us-ascii?Q?fMGfOv1bOG4M5W57iMYRwd38l/UFihXFo/xYpLXPEjD55WXNLrqvYA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D9M+c079XPSP5o1uPzkRW5JOxiZLErOSON5AXA3PftGgDyJGWmRGm2UVA8Kt?=
 =?us-ascii?Q?7dQtRo9MK0VE3ynygk2Q99shnQTwQVCbG/VrxbnGZ/kbVGDlu3vdsKajp3e1?=
 =?us-ascii?Q?lJ2JfQP9qooUjA5kuJxJkVpjbxmyj8SGiLfPST4hhvC3nUDYveNxceybLijl?=
 =?us-ascii?Q?DamJkXvrVUGYI3nHl1zPvQnA52aYVvjKDQZTeqe5JruhyzktbiEjfARexqci?=
 =?us-ascii?Q?UJhnf32qcPmOiMkwUCY4wEKPkeVY2C0gTiRW/8UXKWd93PgEus7aGLl36Wl2?=
 =?us-ascii?Q?6aPHl/u+0oDC5HJTm8PljoWSPDwb5daSvDjH9x1DghxKUlctJopoZ13941MF?=
 =?us-ascii?Q?szZbLeirhggk4sur33Zc2B4XEqHZx+YkBAs0YPoKm6xXwu6qc+Y2d46G+P/8?=
 =?us-ascii?Q?jrUNTw9Buzj03ei2i9j2BI1YEwXG88Behgd7KQuze1b9ofUwzgsnElfFhw/F?=
 =?us-ascii?Q?bLiV0U0s1Ss+Xb6wObcrnv6IkM5US9N1GBwRaLXcdxbAgk5UiriJ9ScS0gvp?=
 =?us-ascii?Q?ld4GwNcciL5DhSszadpxuXbJfkMX7AkEl46J6mFhQ36dchdrsWkW76bb9OQc?=
 =?us-ascii?Q?jug2nmhdqzPp6KyNN6chVIgw4WsdGFD9p5LZj511zm2DQhNLHInSTz0YE8c6?=
 =?us-ascii?Q?3G0KWVxfjpUN4W9QM3kz/fGBUChNHZFq6Rqecve+ZX7SKrE/QNfLwGY02tZS?=
 =?us-ascii?Q?qCVjzoqDIE4uIdyzxAmwDSVz4Dvsmn8PfUJal57lbRxja7RDzQ1CQjk+z43W?=
 =?us-ascii?Q?VM4Xi/H15rEGA2ZJcLjTtddvJyZsIadd8lMo+ktFSYTOWROuqx6siQK35FnW?=
 =?us-ascii?Q?7J7Ocj+GJvKV/fOU0uxDcH8u0MsMDyfKLi+Fo7XOYsNMxSaXQZOUquY8CyQH?=
 =?us-ascii?Q?BOCrL0o1OHK4AHfUlb6UA2az+LJX2piKjeScW4OWWrv9tb/mvwDHNcP6O6sM?=
 =?us-ascii?Q?dcprbZc5+ErXvci00ymH6yJMpDoUvjUaE8ScQk/l0yQP/bs+s5yL1na1Hdi1?=
 =?us-ascii?Q?lhcZZpb8pdz8z89f+XeHDtUyxkHeY2AWUpzdxpV+7GVvKXnDLBqnJMyHIFvg?=
 =?us-ascii?Q?qmt9Av7l0F+gw6+WmUHe7yt68GXYaJJxqEvbMX2+08zG2p6nODanqTMjw1xc?=
 =?us-ascii?Q?FZdzwW0kQX5NG9PTYrBTN8ZJSoB4/rIyueNYnph5Ajz51oNW4aof4S9NdLOe?=
 =?us-ascii?Q?4rukn5Mr6C0sZ9PvlLe/GXKY9UX7WuGtBVQP1kikwz4HeZ00H3tENUOHq0B1?=
 =?us-ascii?Q?s/v7JA9Z1uT+vn5W+uytySXFtCjT3g/TACm9l8l/Abo+0fIs+SIDFWsx4CqO?=
 =?us-ascii?Q?NioUBLZa3t7lUxmY/Jm7+ZqQEVF0zFD0x3x0SQfT416pN9zVqz9IYrZk9fko?=
 =?us-ascii?Q?fkxxA4wSaI8/6xWdlh04D/3RWnHbg4MZeydtHw2zoX9xlqh0YblCEsKtu+0l?=
 =?us-ascii?Q?rW3Y/WGADvvH1Oq5XAj5F84QdBhLTLM2y+PGq7Pt/ibUJsMwCPhhKb3uGd3F?=
 =?us-ascii?Q?zuGEjicxNP4rbsOyF4y3rVHupXbEflTVdodIfvQ5gzPh23cRCik0I/qIgcBD?=
 =?us-ascii?Q?DVWawznI3NZV7ETSAYOdQEFDpLXyoSm0UAnzeW18Ur4L6GW6B1gAuHDLTsz9?=
 =?us-ascii?Q?VA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d39855b-affc-45a8-5a9b-08dd82dc41f6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 03:01:06.9320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L2+Va4Ch+C62FRPrKrHlJcGm4o3r+p2HFGYIYilbSkRO9iEN7ihN1Lg0ipkwelJPs5MxDMYCiRz1ioPNYZwQDCiv/ehRaxOEf7xX/HHCjxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8519
X-OriginatorOrg: intel.com

David E. Box wrote:
> Replace deprecated visibility macros and align group naming with new API.
> 
> In alienware-wmi-base.c, use NAMED_ATTRIBUTE_GROUP_COMBO_VISIBLE(rgb_zones)
> to define the rgb_zones attribute group concisely. To preserve the existing
> userspace ABI, rename zone_attr_visible and rgb_zones_attr_visible to
> zone_group_visible and rgb_zones_group_visible, respectively, to reflect the
> 'rgb_zones' group.
> 
> In alienware-wmi-wmax.c, replace DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE() with
> the renamed DEFINE_SYSFS_GROUP_VISIBILITY() macro for the hdmi, amplifier,
> and deepsleep attributes to match the updated API.
> 
> While here, add missing sysfs.h include and sort headers alphabetically. No
> functional changes are intended.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  .../platform/x86/dell/alienware-wmi-base.c    | 23 ++++++++-----------
>  .../platform/x86/dell/alienware-wmi-wmax.c    |  7 +++---
>  2 files changed, 13 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/alienware-wmi-base.c b/drivers/platform/x86/dell/alienware-wmi-base.c
> index 64562b92314f..ee41892e562c 100644
> --- a/drivers/platform/x86/dell/alienware-wmi-base.c
> +++ b/drivers/platform/x86/dell/alienware-wmi-base.c
> @@ -10,10 +10,11 @@
>  
>  #include <linux/acpi.h>
>  #include <linux/cleanup.h>
> -#include <linux/module.h>
> -#include <linux/platform_device.h>
>  #include <linux/dmi.h>
>  #include <linux/leds.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/sysfs.h>
>  #include "alienware-wmi.h"
>  
>  MODULE_AUTHOR("Mario Limonciello <mario.limonciello@outlook.com>");
> @@ -326,8 +327,8 @@ static ssize_t lighting_control_state_store(struct device *dev,
>  
>  static DEVICE_ATTR_RW(lighting_control_state);
>  
> -static umode_t zone_attr_visible(struct kobject *kobj,
> -				 struct attribute *attr, int n)
> +static umode_t rgb_zones_attr_visible(struct kobject *kobj,
> +				      struct attribute *attr, int n)
>  {
>  	if (n < alienfx->num_zones + 1)
>  		return attr->mode;
> @@ -335,13 +336,12 @@ static umode_t zone_attr_visible(struct kobject *kobj,
>  	return 0;
>  }
>  
> -static bool zone_group_visible(struct kobject *kobj)
> +static bool rgb_zones_group_visible(struct kobject *kobj)
>  {
>  	return alienfx->num_zones > 0;
>  }
> -DEFINE_SYSFS_GROUP_VISIBLE(zone);
>  
> -static struct attribute *zone_attrs[] = {
> +static struct attribute *rgb_zones_attrs[] = {

Yes, this rename is necessary to fit the scheme.

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

