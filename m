Return-Path: <linux-pci+bounces-28420-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 277E8AC44EE
	for <lists+linux-pci@lfdr.de>; Mon, 26 May 2025 23:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 776D13BE209
	for <lists+linux-pci@lfdr.de>; Mon, 26 May 2025 21:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C662224291B;
	Mon, 26 May 2025 21:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CVbD0YWH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D74224166E;
	Mon, 26 May 2025 21:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748295887; cv=fail; b=NzBzgdFi9ZvwDvQFNvzK9devGhuaSZ2IB8vkAT5vaACuMbG3x+9WVqVnXimLebm/Cm+Ot6FIml+qE7Ojsv5OX7Wu2OR0bevndc7Bn+AkN6SSOnCWt1X1LgPGlKEjvwWgP4dEv7Dr++KTsr+hqb6vYvb25KueS05souRGrBjTSEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748295887; c=relaxed/simple;
	bh=FRPts+6pG2/7AOtC9R8EY5tksRTIVR2IO08vyg1H1qM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gjmqGfwO+iFbhxM1xlF4kvkUR5wk+j247QlV8jbWAka7jiLF2nUqzfy0bBidCvrVVe1pnIEUKxuh0qlEwn+437EkIl4zUsqPNs8my8OO4xQstPAqDMkwEcwyn6X+iYupvpho/uGI7UifbDhllmluX6BwVgh/LX50M1Kixjn2op0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CVbD0YWH; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748295886; x=1779831886;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=FRPts+6pG2/7AOtC9R8EY5tksRTIVR2IO08vyg1H1qM=;
  b=CVbD0YWHF6AsQyoS8esb+MH0RhmdGkIOAWWZruFBfykjZwVGZT/re8Xq
   zQodjwHvp7m0QX3xGJdmBwov7K6lYTS6iHgFYf0bRU3EZgStzdvlRqzrd
   EQP+M3v3xdaPfUZvnMseIEBpFPNXeQDapwKAvQ2PwJ/2uiBqYv8CAWA1C
   3PyYUPDHvsIAh+LgkJzoe8+UdgE48fcoNopUaLJ4/KPznOpZB4oytpxLn
   4FvcJ69TRQ06CtmwNPX3N34Lum2xpDyBxJsWtBtT/FgcP+vdsf3VRk4UF
   nNYEpxe4uxMEgere4B8IO2Lrxm+GUb4tgOm7wBYiElFX9v6WJPjiNG5oA
   Q==;
X-CSE-ConnectionGUID: 72MNkytTR+6hFJoY+H7j6w==
X-CSE-MsgGUID: zeH0MjSYRcOovbCVrLSi4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11445"; a="60928260"
X-IronPort-AV: E=Sophos;i="6.15,316,1739865600"; 
   d="scan'208";a="60928260"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2025 14:44:43 -0700
X-CSE-ConnectionGUID: bjoYPzM2SfKvbTtUGWnD2A==
X-CSE-MsgGUID: L3/PHyJBRYOgl5+7ruCZ9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,316,1739865600"; 
   d="scan'208";a="147766332"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2025 14:44:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 26 May 2025 14:44:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 26 May 2025 14:44:42 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.72)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 26 May 2025 14:44:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pVQvykzeMWMsnGXF8cyYMOdM9bR9zxy82cIuOdluLu2JRKk6URvqG6oLi23WbBjfEWnZCl+0UN5TDTpCosSvixmEjLKXj8RZN2HWZ1c3ZgwLKAq0dXyXsI5SmiTJio9oCH7OT+hWgow4jdNBRig7PQoKJQqRcPOLmCeJdFazD7zCjr8SQCaTi+azyDpA9M/tLry23ck4I78R+YBARNne+3dLv9F779DZ6r8HrSgI2Q/AwZDA3lIOaPCJV6DwFM/7MKY4Dh4XnkTeobt4ACAJVFhs7gct3WlX9sGGKmZ0wa6QKST7YU6uW6T1azsjbxlTkrDpbj4s+OALNyYwTMebiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixep4eJlhCMk9yc8frMZ9p290cJQWZc3JIq19ytZIKw=;
 b=hZhhEEJ0YlXfRNAGlrdmJZyN64zfigPaWvQBw3mA+maXpEawye2VR1GHMV1FpQPv3sHkGtElwB414iDinjecjNBOx8VVHCJzcmSb1ADcFPPcgdIayCF5bML8UpvWu8BCkPJDqmzs7qPstG6wphe/6zUxJjZplgCon6/NSTLlABJJ7cQqedFM9JqZ3n6eShQe0EIHADYyW6g0Uf1ATwN89AQOGtldD6CH5InHf8IVNm+XpcJxpet8wfX5QVsSepyv6mBmlfO7j0FuqCPTWPR7fygb/15QGUw26VATzV7mKUcllRyF6pzunYsK31WE86hKre3EtcvU32UCJ3jMAZuxRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5373.namprd11.prod.outlook.com (2603:10b6:5:394::7) by
 DM4PR11MB5279.namprd11.prod.outlook.com (2603:10b6:5:38a::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.24; Mon, 26 May 2025 21:44:25 +0000
Received: from DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::927a:9c08:26f7:5b39]) by DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::927a:9c08:26f7:5b39%5]) with mapi id 15.20.8769.025; Mon, 26 May 2025
 21:44:25 +0000
From: =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>
To: <linux-pci@vger.kernel.org>, <intel-xe@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "Bjorn
 Helgaas" <bhelgaas@google.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
	<christian.koenig@amd.com>, =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=
	<kw@linux.com>, =?UTF-8?q?Ilpo=20J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>
CC: Rodrigo Vivi <rodrigo.vivi@intel.com>, Michal Wajdeczko
	<michal.wajdeczko@intel.com>, Lucas De Marchi <lucas.demarchi@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Matt Roper
	<matthew.d.roper@intel.com>, =?UTF-8?q?Micha=C5=82=20Winiarski?=
	<michal.winiarski@intel.com>
Subject: [PATCH v8 4/6] PCI/IOV: Check that VF BAR fits within the reservation
Date: Mon, 26 May 2025 23:42:55 +0200
Message-ID: <20250526214257.3481760-5-michal.winiarski@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250526214257.3481760-1-michal.winiarski@intel.com>
References: <20250526214257.3481760-1-michal.winiarski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VE1PR08CA0008.eurprd08.prod.outlook.com
 (2603:10a6:803:104::21) To DM4PR11MB5373.namprd11.prod.outlook.com
 (2603:10b6:5:394::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5373:EE_|DM4PR11MB5279:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ecaa50f-b437-4b1d-dd82-08dd9c9e7bee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NG15K2EvU0RDZ2xWbTk5SjVFbzhFeEEzcWZ0SWpud0FEYnYrdGthU1dBN1R4?=
 =?utf-8?B?Z2lBNXA1LzlGQ0gwVlVyQjAweHd0UlI4ZC9VdzhWbDFDM1hmMm9jdmpvUzFW?=
 =?utf-8?B?TFdFYVNYZ1R3OGhPY2s0Z3NvMUo0L2U4RG0zSnRJcUVRZlpVVmd4eHBoc3F0?=
 =?utf-8?B?eHR5T3hud0dNa1RNZUVyTE5IUlNsNTV0QlowQnJnaVVnYXpzVlFVZzY3SU5a?=
 =?utf-8?B?NlBkTVB1T0RkWXozTHRMcXZKTGVXWUhsaEd3b3h2a3EvWDcyV2ZueUpnUkR4?=
 =?utf-8?B?SzFSbVRqN0tGaWM4UnUzeGpVeTVFQTl6NUFwdUZaL1ZzcGxaQjk3T2ZNdXZ0?=
 =?utf-8?B?Wk1xeFcvR1JTeXlwdVZEZzN6dTNFZ0hJcGduWFdwRW1Ga1RFU1Y1Ky85Qi90?=
 =?utf-8?B?elVBU3k0VUlablAwbitwK09sNzBEekpPZ29vRHRhdFN4cEVNWkVnNDJ5Qk9W?=
 =?utf-8?B?R0E3b3BmMUowNDM3c3A4WldzcFozNjlscFgwM2ErbXFzd21RZnVEOHdpdElL?=
 =?utf-8?B?cnY0aHhPNTM2cE1XVmNjSk1pYWRpU1ZaS0ViYzlweTNvUUkvU0RrRHYzSUxi?=
 =?utf-8?B?enVrb0E3RzZITm1jbmt2RmFiTEFmZGM2VUljZ3ZYT3doWW9ySm1uWTJlRHRw?=
 =?utf-8?B?Wm9xRzJKWUUxS3NJdloxYWhJU0s3TXkrNVpsTGg1dnhwWGYxaTNTRGpEUmIx?=
 =?utf-8?B?ZDFkUVFVT3dia3owQUxjeEF2N0YveTdrTE43azlXTmZ0YmtPakVRNlE0L1VV?=
 =?utf-8?B?ZHZib3c1dk1BSkh4V0FlQ3BFbC9MekVaWS93YUNPTk1HdExuM25XQm1hRGND?=
 =?utf-8?B?WDIza20xdjU1LzFFczFhb2UyZFBHaXVHcVZ3eFBDa1NPNlZEUENsVTFWRGJo?=
 =?utf-8?B?WDhIV01OZ1pwUUxwcjNSYjJZdStwTkdTRXM5SXp5QUpMUktiYTFUcWlvVTBV?=
 =?utf-8?B?eHNJdVNKeFU3bExPNjRpR0VJYXBLaDJBMmQ1cmxuWFM0aTFpQUpDK2lZWlRs?=
 =?utf-8?B?dFFjd21UNjQxWkRSb2ZPWEdUdGhwMGkxT2lOdjdYTXBvUDIvU3RyU21lV2JQ?=
 =?utf-8?B?R0FCc3ZRK2ZzdUtnbkg5R1FIejN4bmdYamh4b1FoSnhFTDg0ZUs3K1QzbDNi?=
 =?utf-8?B?bGdtd1RVZ0FWS1pCVVg3NWlCNmU4TEJRek16NDc1Ump1b0JZRlZpNm51bWE1?=
 =?utf-8?B?L1BEaHdmaU1iRU5yLytGbGVITUZLNWhIbFBPWndSckN4RGZ4dk5KdUl4VS9B?=
 =?utf-8?B?UHMzcHh5WFI4RWNLMUt1dThpc1hMZ2J6ZTZ3LzJEaHNmYXVjZWVyOWZLWTFp?=
 =?utf-8?B?bmIrUndHa2xid0plRFRJK01SK2xtbEdIRHR1T2xUTlVwNWc1OE1OL2t3SEd6?=
 =?utf-8?B?V1dmYjlBdTlNVnVYZTZEc2FmME5HTk9zWkNRc2R3bW1la3JHeXIvWGZ4K1hq?=
 =?utf-8?B?SWMrR3FKS00rZ0c1cXQzeTVpOHRZdWdTZzM4V0crcmJxMGZIcHc1U2hqL1Nq?=
 =?utf-8?B?ZHZ0cDR5ZDJ6UWdHWGw5WkVqa2lBbDFBd2paS002MEQ5WWM4cHpDcC9DRTA5?=
 =?utf-8?B?Wllia1dZQnVCT3FuMXRWSUZTREhpbG9iRzJZakNPWHF1WUdKRWlaT21vTmxo?=
 =?utf-8?B?NEVXYnFtbXZ1TzI5NVBXK1dZV3lzSUZVbUwwKzhaWFNVcEhSQmN0RzBvNDNZ?=
 =?utf-8?B?TERsamhUdHJlRDhrRFIwLzJLR3o4dlBlNlE4MHJXT0dyTTJTUEtvR1JpTDl0?=
 =?utf-8?B?MlpjYi9oNkN2Q21RZ2NBQTFBcW8vSGNVNGphVThrOEtEaUpXV3dkQXMvTWlW?=
 =?utf-8?B?cTdybUQvS3B4VTluOHBRc1lJNEQxSEUrbktwdzVERHgrLytFTnRSL2dBbGtx?=
 =?utf-8?B?RUZ3MFExMm1oUDFPWnVVY1NJdXZqRGlmNUgzb0ZkcEhvZW41WDhhSGIwdXRX?=
 =?utf-8?Q?lQEwjnaD3oc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5373.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clZiaURPaHBZemNMeXZuMXJrS3ZFd21jRkU1cmlZMlNmcHRwNHRHbnhRc1BC?=
 =?utf-8?B?T2dHaXMwdGxqaU56Y3RDU0lGSWdMWC9NZUNVYUJEK3pBY0owVkl1bDhPcmR4?=
 =?utf-8?B?cUx2ZytKWXh0OGFqY0U0S3BzWUI0UFBjVCtGbnlIWGV2bzhadGpHZEVqdUEx?=
 =?utf-8?B?N0ZQdEVKSE1VdGN5SytiWW5mTm5YTTFUYVpocU40bk45b2t2RzhHNjg1QU1x?=
 =?utf-8?B?VzNRQU1MRzFvSVFRbG42aWlhOUE5eHc4cVdqRmk0NlVncUJkWDEvMlJiamhD?=
 =?utf-8?B?c1dqcTNnUVdiUDg0dkhNV3RqWjYwQnFqQnFXN3ZGaWtINlBjUkZ2eUwrRTZF?=
 =?utf-8?B?M1ZBZDFWSUhIY29JbVlOVGFIZkFEMm1ONzFWdHlBVGo1TUlycFlRa3huVlgx?=
 =?utf-8?B?SGdtUThQV1FvOFBna0ZrMmh1YlJ4QUExU2gwTjlpeUNBZlBPTTdyNzg5RWdN?=
 =?utf-8?B?dDA3NlpkbzhLUFFYV3puRzFXdDZZUTlEbnBRMXpBc05aVVZaSFBVcUNMYTNo?=
 =?utf-8?B?REx5K21PUXBWMVRPR0FEa2h2ZGJRaVhYS3dneGIzN2dIRU1rMHVpaTVKMlI3?=
 =?utf-8?B?TlZhS0YxVkVlVmhHWGhNaVpIZWp6b1JyUHZrUDZLNlFWSzJ1K2lvOW8vN2tL?=
 =?utf-8?B?Mlp1KzUrNllscmVSOG0wYjY5aWZUTmpEOWw3bzR6VUF3bHZlajVsR1pjOVJG?=
 =?utf-8?B?UEdJNjErZzR5dUlUQ2lyT3BXbmR4OUdHWjZFT3RyYVlOclJaTTYvc1Q0YXhU?=
 =?utf-8?B?N0ROcGNJeDMrSUdKNjV5NGJwVnhMRWMwU3VDcFh5cnNjOWJMK25tUWxsNnpB?=
 =?utf-8?B?aFVFbVZCSG1nWVpxc1JBMXdyRnBXL3VXL1Z6RzVSbDA5WTc2b211U1dpWGVo?=
 =?utf-8?B?NlYxZDRsWEtiZERveGV2ZlJXeWZ0V3VpOXFzSFJnVE1IL1lFVE1pd0ZBcXZG?=
 =?utf-8?B?SUlxeGtoT01CaElrQzlnc1lDdmEwVk1qUm02U2oyRVUrN2VpYWI2VCswNlFM?=
 =?utf-8?B?dFM5TmNKdktkdmNpQlltdUhRSkNwN2RjYW16S1FNd0srVlo4bkFVTURkUXBt?=
 =?utf-8?B?dnFINUxCWFlHVm91OEFJY0RRcHRaZzRLSVRwdkx3TkNDQmRFRUNZbWlPQWtL?=
 =?utf-8?B?eWRXU1hZYTNza3drK3JOOTFBNjlJdlZFUmtmcnZXR2Z6U1p2cWpJUTRvSmNa?=
 =?utf-8?B?THk2T2c4bmpwTFpkdDBuazV3V3hwelorZXdxMjdlc1lhemdLL3pwS29mS2Mz?=
 =?utf-8?B?dDJ1aFpxT0JJN0dIdUNHTEUwTUdTbzd6aUp2Yk1DUE8zb2MzNklSQmZHdlMy?=
 =?utf-8?B?ZFFwMEZ1S0lORGZUZ3lxM0VLUUREcDNiQUtoV1hGdi9TUHFNMzdVTWxLbzVi?=
 =?utf-8?B?ckNONU1ObFdaV2pCMGRkOUNibzI0UVVDVmg0Zm9maU81SWJlKzRFRnAzNDR2?=
 =?utf-8?B?TlR6Vi82eGV5c1VCcUtHTVkyOXZDdVJxNGRzV3BGSXdVMjVMNWRqMW1FZTVi?=
 =?utf-8?B?LzdIdXd6a21sU2lxL3hyVDhOZWs2WjhUcVlaWHhtMDMrNVpyNHlpRTNTN1NY?=
 =?utf-8?B?THBRM3ZDYU1UOEZTdFN4cHpSMW9keFVrRzFKUWdrQUVEMlppektXaWhrSSts?=
 =?utf-8?B?dFU3TjF0dHBLR3pCS1BpNXF3b0VPSHRLcWtXK3BRRUpMWHVheUxLOGpOb1hK?=
 =?utf-8?B?Z1IzN3JwaGphczhFOUs2SnFidnM3eGRvWnA0SUVQSThWM1Q0K3NWemJIU1ly?=
 =?utf-8?B?NDBqOUNuVDdGRXFQUTZobG1kUjdMQ1FRb0FHeUUrQ0dHejY1SFBJSXBWVUFB?=
 =?utf-8?B?bTBQaHNSSW5iSnlyWTZoRWhGTW5naHRtR0V6UzYrQ3kveW1RUFo0ajlaNXF2?=
 =?utf-8?B?WnBwRHpzZUtDTmpoRDE5S1ZoZGpQS0FaaW5NNHVxcDVGUTdHQlBrQ29tNHZT?=
 =?utf-8?B?OWQ0UHlRT0VaYkZ3NVhyOXFOV1NKdVlkSmFZVTM0M2FqZVpRdUVQOWR2ZlpN?=
 =?utf-8?B?ZWxKQXhES29aWEFxWGFYelZ3Z3MwRjk2cjYwdWZuTFJKRWM2WFFjTXYvU0dS?=
 =?utf-8?B?OVFJeTNSL2V2ci8yY3lqa3dHaFM2TTM3V1p5Vyt6bXY3M05PMDRTcWk4SFRV?=
 =?utf-8?B?YUtZUy8xcVNvMjVpNFhWYXgwQnJ3V204cjViV3pRWngzRkg3WEJSbFNUdjF5?=
 =?utf-8?B?UVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ecaa50f-b437-4b1d-dd82-08dd9c9e7bee
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 21:44:25.5709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZGSmmSq4nZn64X1VeaxL4jV+INV3VpkHFA97+cB8HGfkJwzNVslvGHdxFMw0vT+C8+KhRc2UjZ6+umyPb3mXHr/WEAyZOZ+Fb+r57qlElB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5279
X-OriginatorOrg: intel.com

When the resource representing VF MMIO BAR reservation is created, its
size is always large enough to accommodate the BAR of all SR-IOV Virtual
Functions that can potentially be created (total VFs). If for whatever
reason it's not possible to accommodate all VFs - the resource is not
assigned and no VFs can be created.

An upcoming change will allow VF BAR size to be modified by drivers at
a later point in time, which means that the check for resource
assignment is no longer sufficient.

Add an additional check that verifies that VF BAR for all enabled VFs
fits within the underlying reservation resource.

Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/iov.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index fee99e15a943f..2fafbd6a998f0 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -668,9 +668,12 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 	nres = 0;
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
 		int idx = pci_resource_num_from_vf_bar(i);
+		resource_size_t vf_bar_sz = pci_iov_resource_size(dev, idx);
 
 		bars |= (1 << idx);
 		res = &dev->resource[idx];
+		if (vf_bar_sz * nr_virtfn > resource_size(res))
+			continue;
 		if (res->parent)
 			nres++;
 	}
-- 
2.49.0


