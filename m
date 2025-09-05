Return-Path: <linux-pci+bounces-35486-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C8213B44B04
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 02:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 54AF94E19C2
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 00:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DCC39FD9;
	Fri,  5 Sep 2025 00:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XnHRbt0q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615B915C158
	for <linux-pci@vger.kernel.org>; Fri,  5 Sep 2025 00:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757033448; cv=fail; b=EBTD46xmZKd20XuWwKMT6OnODL43sZO7JsH73KFub0c3fePDeEXvsE2WmP2MsHvWQZCnHvJvTBnTTC0Xzk/hvzPf2yImGmZrqtxQ3zwWTzpXJ0oDC7rz3e8KBcTh3kUAcC8lMPCpOKaa/O5q7tShjZaD3G5jQnKC9WjSzLP72S4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757033448; c=relaxed/simple;
	bh=aeT22Da17Uzd4U4cZYRSG+OuyE5wUDC7q6FbE5rDHIw=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=fXr38LBszzyhy0WFzSVGUtPBS5n27Xw5nsHHzaegV+Dm2dAofgB09wYD33quWjHO0yXaiHUsBkTOZrnXK9ESMQakApbZYmapbCgJDBycianK6H0PZI9rjbMVNSQOawg8dYYZlio1T7NIv+bdEapHSqifosgOv//oWO8GXwi2WLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XnHRbt0q; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757033445; x=1788569445;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=aeT22Da17Uzd4U4cZYRSG+OuyE5wUDC7q6FbE5rDHIw=;
  b=XnHRbt0q6lXiiVLTDjDHlIknexs7C3fYTNekFyVgFG8m/+ZyUQL5cGGS
   6JruA1hiM9Ix0r6LdNzB5SIHATqUTWlnPxRQuQwPm2Lmv0T7grWccpS/U
   w7VBSO4KhthJI9Ke54Ppw5l2eevzayOCuIEjU2P4pP4aXzHT/5Ar0xNFV
   jV7/h5t7KX9LT2BW9dAgXNzFv5fovqjrN7EdLBwwpFG9gArexpTDQHuyJ
   fUJTziqw7uQB/fcnjVfwDDPx5LcGIywtpJBNNp1vmjh17A4a4cp9tlBrj
   hzmzB7NY3X36DHLMiuoNeK+/xUF60HFKnysK94KHoZ7wx2xZp6kwPkCFG
   Q==;
X-CSE-ConnectionGUID: rUkgmWi/RVu+9uYHx5XbgQ==
X-CSE-MsgGUID: 2h3DGsjxRhuEBXCqnhtk3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="70001293"
X-IronPort-AV: E=Sophos;i="6.18,239,1751266800"; 
   d="scan'208";a="70001293"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 17:50:44 -0700
X-CSE-ConnectionGUID: ZmGgaOhWR26Csb0q7klFqA==
X-CSE-MsgGUID: mhrP1hfQSLCYLHLPKJR49w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,239,1751266800"; 
   d="scan'208";a="172850187"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 17:50:44 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 17:50:43 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 4 Sep 2025 17:50:43 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.49)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 17:50:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lfExIV1ftJqMJT1Vnf5tpsGVS6hwf4mR7UmsbjeJgW9xg8rM6cMjnUKbdba2ZKIfSrSWValRaocUOyti/OV2h7FstiFM/0BbqqpB9aWsMZY5E7YP93jLlf2ZFzxWw35h7vwkqpWjEEI/ekgT30yd44Gb4gQyoA203vpcO2l+d7D+vFC3efZe4OvNgieFLGtUXUR9VkAQl6osg1Yec1nMwdzR8Y70CJXqLFi+nQmQ0ueAoADRG3kYV/DSJf2A+P2aLnnF653sg7eu94059mODv/Iafqki5PwHOmDespB79AD2bsZ0hsiU2FYLm1t/e0AMZkLBTM+4AXQAqI9xKNSiNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqPYMDX4TVOUP8DHtzajdiVercbsCUTWVC8jC+wJcnI=;
 b=o166I4ScAAfqO0Wk9C/vYTqBml5oOUyP/CjaUVl5Db/ZbUMqvjkHgQ0SmiLPO2z7XHCyAgBuibWltIHlwVmnpCjh6jIolQfEtN4Rrnf5kvEARwNnhWiA2dLAT20PL9dkkIrTfVeulYGxETRoIfBpWSHbi9IUolJJHDbxcuOHrmS1ZyVWE7gCrp3zepfXjPuaO/dRpfbtQKWOpoqOX1LuEb5A1rCw71Q9xtjWrclNYlGJUtSWGWnrDMlk1J4EVwtvTHc+GaNxp1dWgmo6ar/tiRzUbSY7dHTe/ZzF6MICaMVVchmsUozGqUPvv9G/qmZGS5o1Jram8MWe42wWRcGicw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5783.namprd11.prod.outlook.com (2603:10b6:510:128::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Fri, 5 Sep
 2025 00:50:41 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9073.026; Fri, 5 Sep 2025
 00:50:41 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 4 Sep 2025 17:50:39 -0700
To: Alexey Kardashevskiy <aik@amd.com>, <dan.j.williams@intel.com>,
	<linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>,
	<gregkh@linuxfoundation.org>, Lukas Wunner <lukas@wunner.de>, Samuel Ortiz
	<sameo@rivosinc.com>, Bjorn Helgaas <bhelgaas@google.com>
Message-ID: <68ba33dfac620_75e3100a0@dwillia2-mobl4.notmuch>
In-Reply-To: <a7947c1f-de5a-497d-8aa3-352f6599aaa8@amd.com>
References: <20250827035126.1356683-1-dan.j.williams@intel.com>
 <20250827035126.1356683-5-dan.j.williams@intel.com>
 <c2019b3e-f939-49c8-82e8-400b54a8e71f@amd.com>
 <68b0fd1ac2ade_75db100a3@dwillia2-mobl4.notmuch>
 <a7947c1f-de5a-497d-8aa3-352f6599aaa8@amd.com>
Subject: Re: [PATCH v5 04/10] PCI/TSM: Authenticate devices via platform TSM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0018.namprd07.prod.outlook.com
 (2603:10b6:a03:505::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5783:EE_
X-MS-Office365-Filtering-Correlation-Id: bc05edab-8675-4297-02cf-08ddec163cda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YTdqZEJ2Wnowa2NrNkQ3YUxURGRydUhhaEl2bWpNU096VVNjckdWejMrQ05y?=
 =?utf-8?B?MTgyTW10d0dBUVBZakpqazV2NVBseTNKaGQzblJOcVlaOFg3aFdDNUpqZUNi?=
 =?utf-8?B?L0JhWHJpa3d3MjJxS3FVNEpIN21MTWIyekNsVkIwd2RaSDh1b2xvbk1iUmtD?=
 =?utf-8?B?UzNrNHdPVGNEQk9oZGxubkR5ZXFvWXNkcDRoTjRYQnp0Uncrc0xiWVM5b2dz?=
 =?utf-8?B?VUo0MDBmd3p2YmJ6ZFNVTDZtajVHZVdKSGgwbUNsTmdyV1QydWRzRVRGdDB2?=
 =?utf-8?B?TWhQR2F4MDhKOU9yeEJUWGRWTURMUHJUOWdhNUZiTXZqelFPeGQwWXVoMzZ5?=
 =?utf-8?B?Z0JDVkh1akpSVitVNnNJa0FXSUlGd3JwL1Z4NjJVeS9oV1ArcDZHdndDaERD?=
 =?utf-8?B?UStCRjJuNnpIS3k3MnJrcUJRc2xyY3lBa1MxM0FmUmtCTjB2S09LM3hTbXdL?=
 =?utf-8?B?c2ZGRVBTUzd4TDNrN2dJdS9TVzI2K04ySisyTTQ4dTRsV0tsdjZQajErWjQ4?=
 =?utf-8?B?K0ZuUXBIKyt1UjVucEQwakorRHQwa2pYMXVnM2dpMHRlOTFybG5BQjNsTmhL?=
 =?utf-8?B?ZlNOa0Y1c0NzR0NyclJaZUxwNGVIWmlwd1FBTmhBUmlrak8reXNIbElSc2Zl?=
 =?utf-8?B?WTMybjdZcCtReUkyNW16MEFwMWNIU0R5RlRrWFUrOUZUQXArbUFTNW4xcy91?=
 =?utf-8?B?MmVRbWd2NUxyTktpaWxYZ3pYeE1EZDdLMW9BamRST3M2K2JTUWRnVkNUSnI2?=
 =?utf-8?B?aEJiTnROeXpjMHJnZnFkaW9nMEVPZWJuTGx6OENlc1JJd1JOdjVUQ2xoVmpj?=
 =?utf-8?B?OTZlZWF1OFA2SHZrTERFMEZiVzB3cGdHWGV5ZkRzaTY2a2lSaVpHQVZwNkZt?=
 =?utf-8?B?K1pYS0lWSVloSmxFSDZtaUNEanBENlNGamtGaXVuUjE5d0Q5WXppZzN3NEd3?=
 =?utf-8?B?VDg2OCswT2VIcnMxSEdSbXZVZjdKay9OZGdWOTFpeFpGaTBQbXY4eXo4cGlD?=
 =?utf-8?B?UmdpNWRoRkNZcnFwUEdpSlFOd3VOTUFhMEcvM1RTeGtTanFHdnZiTnVmcVZV?=
 =?utf-8?B?elJkemRTMldESVpWa0p0NHhFSU5WOWpaYUgwczd2dGFqQ1I4aWpLVmFWQmNs?=
 =?utf-8?B?b2tmdkZlMmpWYzlZVUJ1ZXRkbW5VRVlRRjhpM2dPWFZZOENWeThFRkh6Y1Vt?=
 =?utf-8?B?L0tiYXE1QmpuN0FhanNmWFdGOG9XR3AyQThhcEpNbzNGQ003eHRQMEhWTWM5?=
 =?utf-8?B?RGhiOHdmMm0yYU90YkcvcUdZNzdzU1lIVFZrdlhxT2xMbkwxcmVOK005NW5h?=
 =?utf-8?B?Smg3azAzUzNXR2p0eWpjdWdJNk1CM29XV0l0U2tBOGVjSk0rdzFMWnFwdjRu?=
 =?utf-8?B?WGpld252eE5sZ3Y4eUVIZGRtLzZ6ZzM5M3lvSjhvUlh5bVNrQlg3bzBUQjBE?=
 =?utf-8?B?MStXUHJHcmtHaWl4LzV0dEYzQmpucktCM2RlUGpoaTRhQVVHdjgzZDVLYXVw?=
 =?utf-8?B?dW1sSldKeTVaYUIwTi8wbjNNZ3ZIK0VtTGhZZHViNVh4VXVlcFBFUi9lRlhJ?=
 =?utf-8?B?Y1NvVjd3OGdTM1VuamM2aGc0N0RpS2Fkd3VrdTlZSnRzQnZ1c0ExVHVpeSsw?=
 =?utf-8?B?YStUS1k2V3VORmN5VzVNZ011OTZ0SFUzKzA4L1c4TVZxc3luUHVaY0QyN1M2?=
 =?utf-8?B?c21rUDlvN3dJZVFkS0VmYnV1MENRc2RWYVduQVB5dko0MHFiYUFrallLQU5X?=
 =?utf-8?B?MWFKL2wwdUNjOXA3N2tMcFFLOVdQbHUwU21xNUNtNklVandXQWpPTEhzNkVn?=
 =?utf-8?B?cVJmdWkxNkRFN0lXSTJMcDAyQjRWS0FqQ1ErZGd2ZDFYNVRPTnROSFFUMnEx?=
 =?utf-8?Q?er2sxYrJo2XZU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azJYV28xbCtsY3BGeEF0dElXSTE3eFQ5eUQzaUZya0xZVmZObHJ3ejBVanFp?=
 =?utf-8?B?ZkhZVVNiUTgyZ2F0Z242R2NQNU5XZ09JanNzdWRKcnhxTzJaeUlrRFlEMzlp?=
 =?utf-8?B?OUhpLzh5b0ZKa1VGWnN3b1EzOHpHTFdUbDhsZWI0cUlTUlV5UDZYK0xNcXVu?=
 =?utf-8?B?a2lLT0hPSjdOaUlaZXRWR0VKT2tBeThxTFNkMGJVb3oyTG9lL0ZabUdGVXVp?=
 =?utf-8?B?T3lndXU4cjRGU3JEL3YxNFcwblZIU2c3NWtaRXViaWRVUHEvUXdIUTRLeFcz?=
 =?utf-8?B?OVZTRVBQWnpESmRIQU5iUkdFQzZMVCtUWkFXRytZNnlaWElIY2RWZXhyS3pn?=
 =?utf-8?B?aDh6RHcrMHZDMGhvb1VheUFmb3Zxd0lrL3QxT0FudStQeHdJcjZiVVRtVG9q?=
 =?utf-8?B?Q1g2bTBESmlBd1R0N1MrVXZaQlNFaHB0WXNXV2hhNk9aQ3NNYy9ZNVJ4YU5r?=
 =?utf-8?B?TDNtSEc2eWlCTzRYbExNWHJTMmlZMm5DTGJNbHNzd2JYd3JwaFRqSGVHOEVn?=
 =?utf-8?B?YmJOS01MdWpzbDFSMGhuaityV005dlhBU3FqMjczYnp2SFFXNCttd1dhblFa?=
 =?utf-8?B?aHBnQWtFOWFLL0R4YkVIeVFrQjBJYzFhR05zSy9yVG1QbldTNWZxLzA5RHh6?=
 =?utf-8?B?MXk3SDhCaVkxRjNqZ0VHSTF6SHRvQ1VuYUJIZEg0QllsOHZaZXdoQ3ZYMmRH?=
 =?utf-8?B?aHVZVjFJU0RXNmpGNnpDSFBDdC9BZzZGNjVPK3ZucnJ6b1V2cU9WaFdiR1Zk?=
 =?utf-8?B?bmdUbnJ4QzNub0lRcURLTHg5VFFqZ0liaGYwSlhJa29MSncwbTh2NUJncnRq?=
 =?utf-8?B?SjFrOGtzdDBVKzlONlR3YTZFcVQvbFpnZHIvSHpqMXY4bDFBbzNuTld4Qkcw?=
 =?utf-8?B?MVE5ZUVqNWdkR08xRlZKRlVNb2NkbmdVRnBwMG1xMnU2M1BiL21tMnRQblU1?=
 =?utf-8?B?SUJtcFpIY2ZMTjRaeTl4NGtiTWFpT01JNEFIZVd1QU1NZ2k4STVNRjlFcy9C?=
 =?utf-8?B?aFM5YWQyRDVIZnplRDRTTUE1cGZsT0RQMXBwd241ekpHTS9kTm1XMFRQVE94?=
 =?utf-8?B?aERLVndSbEVEWjIwMWJSTVdMYlAxWENwRXR6ZE56S2tVSkFrVWFLTzhKZ0Nv?=
 =?utf-8?B?TXFKN1REbmloUmxWQ2FKZGs0TEZ4aHhUeHhOUjhUMDZLc2RpTS9NZDZmejZS?=
 =?utf-8?B?THg5VlNQNWxZSU1VQ2srTTlYOWpaZ1B2UVE5dWdPWk1XUCtBOSt1WjkrRzRn?=
 =?utf-8?B?eENQM01IcGU0UkN2dmFzcWdxREtqNnhIUEE5QXhTblpNZEtTQkpTdDQ5SlQ0?=
 =?utf-8?B?aUVjMklEN2ZkRTRXWlVTTjZtVXQwQW9uZ0NPbzVqZDFnYnhNaHlieTE4bnpo?=
 =?utf-8?B?dk8xUEdVZ3lkMFhiZVE2OFdqOUhOM1ZXUmlTOW1Ia3dBeWsyR05zSGtHcm1N?=
 =?utf-8?B?SExsd3YxM3lRVnBYVFltR3gwZzQ4anFIaTlrZk1UMDRaTlBEVHVZVVBOaUlz?=
 =?utf-8?B?WGtQTWJhVHRqcENvUlFrNi9PWFpJWXorUmhLbVh6OWRJV0ljM1Q0aThSdFBR?=
 =?utf-8?B?d0NWa3FFMllvMkpsajhHNHJ2SkRYT2dkZ0pXZmk4MWkzb216SytiOEZyYVUz?=
 =?utf-8?B?eXpXQ2dpbThzeWx4Q083c0pnb0gyTmhoTGk3M3p0ekR6RitOcWxFNkpRVFFB?=
 =?utf-8?B?LytZb0RPM1ZJSnA3YmlKc0I4VnVLa3FDRjRFZ29uUjhHMTNDMFZXaVV5dTJw?=
 =?utf-8?B?NjB0Mk1HZ29CM2xXeUYrVmJVNkZhVCs3MThlRDB3MjJoeEpia0pWd2pKTDBx?=
 =?utf-8?B?d09NenNtcUk0SXFVMGJlVzVwQlVqT3RkdXBEdEg1aWN5K0IxY2drN1ZhUzJS?=
 =?utf-8?B?UERhRWVCckl6Nk9nNXdaVEo1b3J0NkxxSkUrby81RWIyYU5pTE51WXFhdlVu?=
 =?utf-8?B?OHlnNkZLTDJlelRSREdNVFc4TzBsWU1XenRkbjg5SlFPcFI0VHpoRkpLZ095?=
 =?utf-8?B?L3pRNTh2WU9sQklRdUpMaWUwajQ2a1BoZDArVWVvckpDN3Y2eloycGNkVFpD?=
 =?utf-8?B?eHNQeElPSkRmeWpQbFQyWUhRS2RFcXhlRDhYeW9JUW55anBpUmNaR1dPQzFJ?=
 =?utf-8?B?dG9aNG5WVEhtMk0yNDNpbzBUcld6b3lqeHpsaG1VMXlDR1pnRGFKeGpBTTl6?=
 =?utf-8?B?dUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc05edab-8675-4297-02cf-08ddec163cda
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 00:50:41.2944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kFdFe1ikPj4W6NecA5+ZlQJ5VytjIOOQ9hCnYiXNmfnm1hRYSGCiCNbJiWlF2MO/y6tIl+npRo0Rg1A5FYkGGKXitTHCG3NPR3r0n2iahds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5783
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
[..]
> >> Looks like this is going to initialize pci_dev::tsm for all VFs under
> >> an IDE (or TEE) capable PF0, even for those VFs which do not have
> >> PCI_EXP_DEVCAP_TEE, which does not seem right.
> > 
> > Maybe, but it limits the flexibility of a DSM for no pressing reason.
> > The spec only talks about that bit being set for Endpoint Upstream Ports
> > and Root Ports. In the guest, QEMU is emulating / mediating, the config
> > space of Endpoint Upstream Ports.
> > 
> > If the DSM accepts that interface-ID for TDISP requests then the bit
> > being set on the SRIOV or downstream interface device does not matter.
> > So the initialization is only to allow future DSM request attempts, it
> > is not making a claim about those DSM attempts being successful.
> > 
> > Effectively, Linux can be robust, liberal in what it accepts, with no
> > significant cost that I can currently see.
> 
> okay, then may be put a comment there so when I forget and will be about to ask this question again - I'll see the comment and stop.

Done.

diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
index 8fa51eb6dd05..c25935a6c059 100644
--- a/drivers/pci/tsm.c
+++ b/drivers/pci/tsm.c
@@ -180,6 +180,12 @@ static int pci_tsm_connect(struct pci_dev *pdev, struct tsm_dev *tsm_dev)
         * dependent functions. Failure to probe a function is not fatal
         * to connect(), it just disables subsequent security operations
         * for that function.
+        *
+        * Note this is done unconditionally, without regard to finding
+        * PCI_EXP_DEVCAP_TEE on the dependent function, for robustness. The DSM
+        * is the ultimate arbiter of security state relative to a given
+        * interface id, and if it says it can manage TDISP state of a function,
+        * let it.
         */
        pci_tsm_walk_fns(pdev, probe_fn, pdev);
        return 0;

> > [..]
> >>> +static ssize_t connect_store(struct device *dev, struct device_attribute *attr,
> >>> +			     const char *buf, size_t len)
> >>> +{
> >>> +	struct pci_dev *pdev = to_pci_dev(dev);
> >>> +	struct tsm_dev *tsm_dev;
> >>> +	int rc, id;
> >>> +
> >>> +	rc = sscanf(buf, "tsm%d\n", &id);
> >>> +	if (rc != 1)
> >>> +		return -EINVAL;
> >>> +
> >>> +	ACQUIRE(rwsem_write_kill, lock)(&pci_tsm_rwsem);
> >>> +	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &lock)))
> >>> +		return rc;
> >>> +
> >>> +	if (pdev->tsm)
> >>> +		return -EBUSY;
> >>> +
> >>> +	tsm_dev = find_tsm_dev(id);
> >>> +	if (!is_link_tsm(tsm_dev))
> >>
> >> There would be no "connect" in sysfs if !is_link_tsm().
> > 
> > Given this implementation makes no restriction on number or type of TSMs
> > the "connect" attribute could theoretically be visible and a
> > "!is_link_tsm()" instance could be requested via this interface.
> 
> But how? There is this pci_tsm_link_count counter which controls whether "connect" is present or not.
> "if (!WARN_ON_ONCE(is_link_tsm(tsm_dev)))" at least.

In "[PATCH 5/7] PCI/TSM: Add Device Security (TVM Guest) operations
support" [1], it does this:

 static bool pci_tsm_group_visible(struct kobject *kobj)
 {
-       return pci_tsm_link_group_visible(kobj);
+       return pci_tsm_link_group_visible(kobj) ||
+              pci_tsm_devsec_group_visible(kobj);
 }
 DEFINE_SYSFS_GROUP_VISIBLE(pci_tsm);

...which means if both "link" and "devsec" TSMs registered, userspace could
attempt "connect" with a "devsec" TSM.

[1]: http://lore.kernel.org/20250827035259.1356758-6-dan.j.williams@intel.com

This property of being able to register both "link" and "devsec" TSMs at
the same time is useful for testing.

> > This is the case with the sample smoke test:
> > 
> > http://lore.kernel.org/20250827035259.1356758-8-dan.j.williams@intel.com
[..]
> >>> +static void pf0_sysfs_enable(struct pci_dev *pdev)
> >>> +{
> >>> +	bool tee = pdev->devcap & PCI_EXP_DEVCAP_TEE;
> >>
> >> IDE cap, not PCI_EXP_DEVCAP_TEE.
> > 
> > ??
> If there is no "IDE", what do we "connect" then? This is all about PCI now, can we have active TDISP without IDE?

TDISP without IDE still needs to do all of SPDM (Component Measurement and
Authentication), and the TDISP state machine.

> >>> +	pci_dbg(pdev, "Device Security Manager detected (%s%s%s)\n",
> >>> +		pdev->ide_cap ? "IDE" : "", pdev->ide_cap && tee ? " " : "",
> > 
> > IDE cap is checked here.
> 
> "connect" appears regardless IDE presence.
> 
> > IDE is not mandatory for TDISP.
> 
> Is PCI_EXP_DEVCAP_TEE mandatory for IDE? I have seen a multifunction
> device with no SRIOV on PF0 (only IDE) but SRIOV on PF1 (and those VFs
> have PCI_EXP_DEVCAP_TEE). Not sure PF0 has PCI_EXP_DEVCAP_TEE there or
> has to have it.

IDE without TDISP does only needs ide_cap and is_pci_tsm_pf0() says "yes"
if either is set.

> Do you show "connect" in the VM too? There will be PCI_EXP_DEVCAP_TEE but not IDE.

The "connect" attribute only shows if the VM loads a "link" TSM driver.
This should not happen outside of testing, but if it does that is handled
by being explicit about which TSM device is passed to the attribute.

> >>> +int pci_tsm_register(struct tsm_dev *tsm_dev)
> >>> +{
> >>> +	struct pci_dev *pdev = NULL;
> >>> +
> >>> +	if (!tsm_dev)
> >>> +		return -EINVAL;
> >>> +
> >>> +	/*
> >>> +	 * The TSM device must have pci_ops, and only implement one of link_ops
> >>> +	 * or devsec_ops.
> >>> +	 */
> >>> +	if (!tsm_pci_ops(tsm_dev))
> >>> +		return -EINVAL;
> >>
> >> Not needed.
> > 
> > At this point pci_tsm_register() is an exported symbol, it is ok for it
> > to do input validation and document the interface.
> 
> Nah, I meant that the is_link_tsm() and is_devsec_tsm() checks below will fail if ops==NULL.

Oh, yes, deleted.

> 
> > However, given the realization in the other thread about
> > tsm_ide_stream_register() not needing to be exported this too does not
> > need to be exported and can assume that ops are always set by in-kernel
> > callers.
> >   
> >>> +	if (!is_link_tsm(tsm_dev) && !is_devsec_tsm(tsm_dev))
> >>> +		return -EINVAL;
> >>> +
> >>> +	if (is_link_tsm(tsm_dev) && is_devsec_tsm(tsm_dev))
> >>> +		return -EINVAL;
> >>> +
> >>> +	guard(rwsem_write)(&pci_tsm_rwsem);
> >>> +
> >>> +	/* on first enable, update sysfs groups */
> >>> +	if (is_link_tsm(tsm_dev) && pci_tsm_link_count++ == 0) {
> >>> +		for_each_pci_dev(pdev)
> >>> +			if (is_pci_tsm_pf0(pdev))
> >>> +				pf0_sysfs_enable(pdev);
> >>
> >> You could safely run this loop in the guest too, is_pci_tsm_pf0() would not find IDE-capable PF.
> > 
> > I think it burns a reader's time to look at the top-level loop that
> > always runs in the guest and realize only after digging deep that the
> > whole thing is a nop because IDE-capable PF is never set.
> 
> 
> Burns time too to read the code to realize that pci_tsm_register() does
> nothing really for the guest at all - the counter is not used (at least
> here) and other checks are very likely to pass and the function does not
> really register anything even on the host.

This was done with "[PATCH 5/7] PCI/TSM: Add Device Security (TVM Guest) operations
support" in mind. I am happy to move more of that complexity into the later
patch where it makes more sense when two TSM device cases are being handled
in the same path.

> > Also recall that IDE is optional.
> > 
> >>> +	} else if (is_devsec_tsm(tsm_dev)) {
> >>> +		pci_tsm_devsec_count++;
> >>> +	}
> >>
> >> nit: a bunch of is_link_tsm()/is_devsec_tsm() hurts to read.
> >>
> >> Instead of routing calls to pci_tsm_register() via tsm_register() and
> >> doing all these checks here, we could have cleaner
> >> pci_tsm_link_register() and pci_tsm_devsev_register() and call those
> >> directly from where tsm_register() is called as those TSM drivers (or
> >> devsec samples) know what they are.
> > 
> > I am not opposed to a front end for the TSM drivers to have a:
> > 
> > pci_tsm_<type>_register()
> > 
> > ...rather than
> > 
> > tsm_register(..., <type-specific ops>)
> > 
> > ...but that does not really effect the backend where the TSM core
> > interfaces with the PCI core especially because they called at making
> > the "tsm/" sysfs group visible.
> > 
> >> (well, I'd love pci_tsm_{host|guest}_register or pci_tsm_{hv|vm}_register as their roles are distinct...)
> > 
> > I pulled back from "host" / "guest" or "hv/vm" when you and Jason
> > highlighted this non TVM case:
> > 
> > http://lore.kernel.org/926022a3-3985-4971-94bd-05c09e40c404@amd.com
> > 
> > So the names of the facilities should match what they do, not who uses
> > them. A Link TSM manages sessions and physical links details and a
> > Devsec TSM manages security state transitions and acceptance.
> 
> Ah fair point. It is just that when I saw "link", I had a flashback -
> "link" vs "selective". imho "phys" or "bare" would do better but I do not
> insist.

I picked "link" to try to encompass both a physical PCIe link, and a
logical "link" representing the SPDM session. Maybe "transport"... "link"
is still my frontrunner.

[..]
> > Unlike probe/remove which have an alloc/free relationship with each
> > other, connect/disconnect operate on the device. That said I think it is
> > arbitrary and have no real concern about flipping it if you can get
> > Aneesh or Yilun to weigh in as well about their preference.
> It just seems rather useless to have pdev back refs if you still pass pdev everywhere.

The pdev is not passed everywhere, e.g. to_pci_tsm_pf0() (for type
checking) and tsm_remove() (for simplifying cleanup).  I.e. some places
only have 'struct pci_tsm'.

> >>> +	/*
> >>> +	 * struct pci_tsm_security_ops - Manage the security state of the function
> >>> +	 * @lock: probe and initialize the device in the LOCKED state
> >>> +	 * @unlock: destroy TSM context and return device to UNLOCKED state
> >>> +	 *
> >>> +	 * Context: @lock and @unlock run under pci_tsm_rwsem held for write to
> >>> +	 * sync with TSM unregistration and each other
> >>> +	 */
> >>> +	struct_group_tagged(pci_tsm_security_ops, devsec_ops,
> >>
> >> Why not pci_tsm_tdi_ops? Or even pci_tdi_ops? pci_tsm_link_ops::connect is also about security.
> > 
> > On some of this feedback I can not tell if you are asking for
> > understanding and asking for code changes and find the current naming
> > unacceptable.
> It is "both" pretty much always.
> 
> > In this case for a major concept I want a name and not an acronym. I am
> > open to better names if you have suggestions, but please lets not use
> > acronyms for something fundamental like the split between TSM
> > personalities.
> 
> pci_tsm_devsec_ops seems more reasonable then.

Changed.

[..]

