Return-Path: <linux-pci+bounces-35587-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0ACB46839
	for <lists+linux-pci@lfdr.de>; Sat,  6 Sep 2025 04:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F08816DB10
	for <lists+linux-pci@lfdr.de>; Sat,  6 Sep 2025 02:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E451EBA14;
	Sat,  6 Sep 2025 02:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FkbzxnEk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586121E0B9C
	for <linux-pci@vger.kernel.org>; Sat,  6 Sep 2025 02:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757124008; cv=fail; b=YJe3KfOK2ePlN5Lju7koLACng1WBqiPLScZQ3FgMr+oNfKu+s/Pk7Cb/h0T9WRtqLRE8WHZxE7fvxH34JdsvedITt4T/9RSRWk1mczm0A3DSWbIQR0/K8kvkr9oSS2eXFC2oQbUZ6mR3U4DXwZxIfhDe7BjYIyd0+F8yYxiUu4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757124008; c=relaxed/simple;
	bh=lIffY03dbA1nN0HEEHNf0HxbJGMGkvJ4DSQyfjHHtgM=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=EYiTptNShLPyBB5V9y+3oGHoa07Q9dsRO1vqrx3z8mePXhiR5ImA7CQNH6gaFsQubtDuBt/XEjYPFEaOa1xlWW8PielJqehFDrgM3bkSENhJHH/HK0N2gXA0u5L5YcM/YBMydtUDwxa/H0pwF+Dg/bpQbKhn+e9IgHmnv7uTZY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FkbzxnEk; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757124005; x=1788660005;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=lIffY03dbA1nN0HEEHNf0HxbJGMGkvJ4DSQyfjHHtgM=;
  b=FkbzxnEks36HO4LUfubmNbfmQVS5/he1SBGWTpQUjBhdAbK503mdhDKO
   KQ/79t3cesoIjTgXbqJeb/vl/JCWXTCTlfvmp4QBi0BNCNoYnr6qmZ0Wh
   OPABHFeqO5pei8ToweaI5Kcdi722zhoXwCFgKYeh9i55I114ypucWp1TA
   B7eQz/FJNzF/OazxbGTwmbzrnrvKxuQ1JZd+Mq7iFaUKpkNZrlepMO9r2
   8ydPzkjd5GidWroT0MgNL/qNbN0JY2eBGYBgA8U3+KdJnacuShqdVVStG
   YubSagAqYN2M3UafFc3KM0HKB6NW74Mv3hSE4W5FWyy7/2OGd/8fj4tvS
   A==;
X-CSE-ConnectionGUID: 04sRnc4uSieI5AZUEfGAvg==
X-CSE-MsgGUID: q4YB/14qQui/6mV0NcXPgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59427360"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59427360"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 19:00:05 -0700
X-CSE-ConnectionGUID: UAiRm0n8TA6jhs3SFrg6Ow==
X-CSE-MsgGUID: jMVLsNe+QISi2zDhB/aV6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,242,1751266800"; 
   d="scan'208";a="172186937"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 19:00:05 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 19:00:04 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Sep 2025 19:00:04 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.48)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 19:00:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vr+2fk8zTRPFpOdjK6LlazInCZgTGyRE+k5naqSUt2xaOVmTYVPoTjCizT94kdD9Xq3xPr50g/SK51w0BPHEVDB1nbPDcxQi3VcA5ouOacdZueySqEL2fGwvfUlIlNWTpZQpq+4BZMpl53h5S8NoRV0vpn+j/xW2BPfekPCErt8Qz45iQgn7pxEOjUUqED5JBkHpTQYeoTjFk/fSaMbdlqUVTLpGuhPbhDxWsA74BKlcZkFsPsXbAbef9mbzEedw4jqwnNlSNZh3+kTZ1NSCOWE3E0H2mU2Bl6snZG4pNPP4bAlyEuFr/54CvL83rWMMtKQXGB+4pOqMBA++QFQFDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jLhXSL3mbTCydPvg+HI/8z9JFgWE9fs4K8gMwNoUMfM=;
 b=IcCKSsLdqPEjUUpWJeYmuXPA+kOp/1N8lbDYhdhzl2uUa/FFjLPXPHxr1p0kbTduwNvcOqTU6HyFFOuCe22Wp0IPipntLh3OwVrIfgg3cZ3GD5Bl0mI7ItUSVpVMHd7+oBFKCOHz5k5zz5kGHF43oLa/76f/HwmnHyk/g2ue9DJZFicfnNRuav9X4WBCxDqr/+5NSmKPJhKkzUzix0oREMDceLMcA2SQR1Rh/2gB+dL3rT/40laLUzNL/qpL1is0yqBko+OUHRPiRlwFfghLvXqMKsrOCfUlJgiEZOAY4OfdHR3JaPHCv/1B1iwnluHcg9nfZjskX4N1L3wOt90U3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB7182.namprd11.prod.outlook.com (2603:10b6:8:112::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Sat, 6 Sep
 2025 02:00:02 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9094.018; Sat, 6 Sep 2025
 02:00:02 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 5 Sep 2025 19:00:00 -0700
To: Alexey Kardashevskiy <aik@amd.com>, <dan.j.williams@intel.com>,
	<linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>,
	<gregkh@linuxfoundation.org>, Bjorn Helgaas <bhelgaas@google.com>, "Lukas
 Wunner" <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>
Message-ID: <68bb95a07043f_75db100bf@dwillia2-mobl4.notmuch>
In-Reply-To: <14144093-c3e3-49a1-96d3-acd527cfe32a@amd.com>
References: <20250827035126.1356683-1-dan.j.williams@intel.com>
 <20250827035126.1356683-8-dan.j.williams@intel.com>
 <eeca3820-01dd-4abc-a437-cf46dc718ab6@amd.com>
 <6608a45f-b789-48c9-9418-5d6c2956975f@amd.com>
 <68ba3f725b284_75e3100a5@dwillia2-mobl4.notmuch>
 <14144093-c3e3-49a1-96d3-acd527cfe32a@amd.com>
Subject: Re: [PATCH v5 07/10] PCI/IDE: Add IDE establishment helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0386.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: cd61ad35-5e99-42e3-cb49-08ddece9173c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U245WnppeFV6ejJFeFNZMXBPQTJEalJrbnNtZ0R3dE5lZ3Q3L0pMMURaZFdL?=
 =?utf-8?B?SktRTjhUUzlEOFYvRm1yMWtJUFgxYW5BNldFOWNDTGpYcDAxMGxoaGtPQUk0?=
 =?utf-8?B?VTZMc2s4VHZISlNzZU9WRW1SeU9HYmh2QTArK2tPeVhpNGZUaHhhanZLRGdN?=
 =?utf-8?B?bDJneHNpSGxjN1IrTEZlOEJlQ280cGJUYjBFQVFoUUtQeHdqakNsTmZ6VXhG?=
 =?utf-8?B?VDRJRHByREM5T3BQUjdxa0VWVFYvbnZTTktIaXE5Q0NzVHh4blg4QkZwUExN?=
 =?utf-8?B?cHV5Z2ZBSDRMcWFZeDVhLzY3a1ZwS1IwSU1vS0Q4dW53bmc1MnV1Qng3OWRq?=
 =?utf-8?B?S2p3ZndIcjdGd0RaRWtHdWVRcWloVDU3TzVxOWNMWGxmME1tZEpjZW4wamFs?=
 =?utf-8?B?S0RIakNkMGhaRjh0UnJrWGcrbnorUHlScDNEWkxIeXMrMEV4WFhoaW5ZTUcw?=
 =?utf-8?B?VmVSTC9uOWpRWlVDTFFMTi9ZTjlFYUw3cktUWlVJUEdMTU9KL1FuMlZOSVpq?=
 =?utf-8?B?aXN5L2t6bVhmM3lYbFdXNFduQ3drekhjaFVnWVUxc2JiSmM4QTRROGo2dlkz?=
 =?utf-8?B?SkVwL0Vsc3NleGFOTWwxdU9zOGU2ZjlGVjFaSnFJK3ZPR1dMVUt4U3lzRUpu?=
 =?utf-8?B?VlBTNU95eVRhd21kSURjellnV3ltRDRDL1lnenRvTmFBWUlXZ29GekYwM2ZM?=
 =?utf-8?B?ekd3UVpKMHlYKzQvbjZhbVNac25uaElwRS8wZEhydlZZdUhoOVVFUis3YUY4?=
 =?utf-8?B?eFpJQ0ttYzZLWHRzSGxLa3FXVDZGQXZCYmN3VUVsay90M1FRTW1oL1l4czlQ?=
 =?utf-8?B?Q04wOW55MW5icXFjeFl2cDZHSFpyQktPV1Z3OHZzYldnaXNTb1liMjVjeFEy?=
 =?utf-8?B?WFZ0TXh4cWY4dWxqbjVLRUdnMHlTZW02RzFmd2U1WnM1TSt3MHZUYmtHY1JP?=
 =?utf-8?B?WUpWd0JseEc0VlpMN3k0TXluL1htM0IzbXlWZmJERDVJSERGR0ZGZCtZazhs?=
 =?utf-8?B?ci9DMWQzRUgwUGE5OUNHWU1uaHFOdzNNdytXQmxYRFpnL1FqSW1hNk90VEpa?=
 =?utf-8?B?WmFwS0V2WUE2b2NWWUQwaFVmK2FlOThCbXpXekhOZm9lak1hZ2FmQjVCT25k?=
 =?utf-8?B?ZWR1QjhRenZkMmpqT0ZTZWUwWE9ySGY5Q3htL3BtRW0vanhpU0FnSDV0WXBX?=
 =?utf-8?B?c0todkhkTVV1cjVYSzZLY201QzE3TzQxTll6aEE2TjR6QlNxak5NNXVibkFD?=
 =?utf-8?B?V0Z1T1JDb1F6dkhWVGU3cVk1SDdOVXpGR29aekZUVGNsc1h4a2N4SWdVOXBE?=
 =?utf-8?B?U3psQjdCQXhVbGZsMC80QXhvcUVKMzhFQ1o0Z29hVlc0ZW1RUFVBblZGM3Nj?=
 =?utf-8?B?Z2pxVXJnTlliaHRYakw5anFyaUV5K0h0WlQyMFNBWmtrcmRIQjdPY202dWFk?=
 =?utf-8?B?d1IybEtvQmxWRzZWbksvcFFjN2w4d0d6ME5tOUYzYTZ3VnNCTUE4L0pPc2NQ?=
 =?utf-8?B?cmhHdUMyMmdDVnk3MjVEVS9CcnpkaUVQeDlqREhOUWRsVTRXNllEYisvNnZD?=
 =?utf-8?B?OWFlZUowbktPNzVEaFJaUTB0Q0Y1YjBxY1phTXJENTdNSXJQYXJ2d2x6R2Qy?=
 =?utf-8?B?N1o0aVg2WDNhNW1jd3BZOXIyVm85VXVoYjZmVngzVEU1bjM2dXlWZkFHZ0w2?=
 =?utf-8?B?cWs1WWt1SHBFRTdxVk12TGxmai9ja0RCWDF2dkJpME4vSmZyRXRNNk9iSTdI?=
 =?utf-8?B?YjNDOC93RzUzTkh3YkhNMFZ1akhIbis4R3cwbTRpV1gzTldsc0laeUJvckRr?=
 =?utf-8?B?ekd5T05VRHBUNytadU9EWGR1UmFORW1jV3RxYUlVb2M5RHFXbTJNWUduS0hV?=
 =?utf-8?B?UE9ieWVVdGJxUWd2U3VSQWhpcjB1SzAzM09ESE53VEtsYkt0eFNjZ3RqdlIv?=
 =?utf-8?Q?Op+WTceelg8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkkvMVdrdWtCMFZLbFduSENqSU5MUEVFQ3F6RGlyL3lXYTdiOEdOUUFoc1p1?=
 =?utf-8?B?dmhMNU1LNlphbW5CN28vdzFXeXJWY28ySGpiaVhsWUd0ZGJIV2htMnp2Nm9M?=
 =?utf-8?B?ZklVSVFQL2FTVG1EaW41UUwrRUdTWit4cVFrc3I2emxkajU2Y0UwMGd3anpn?=
 =?utf-8?B?YzVJL29JSEs1aWYyNDZvb3FhNS91eWpwT0FobUdva2dRVW9KRFFxVEpxcXkx?=
 =?utf-8?B?STZUU1B2RHk5R2RXSGJCQVoxR09xdkhzd2ozUFU2SzFlQ3pRbGJYbm5TMnFF?=
 =?utf-8?B?czZVME5hSzQwL2V5R1dNUGY4cVhNYmIxYnVKMURIYXc2dDdJVnNvaGVibHNw?=
 =?utf-8?B?SVkzMCtUL0phNUN3c0dNQWo1RkR6cTBoLy9YV2E5cVg1TitSc3BYVXkrQlUv?=
 =?utf-8?B?Z3NzcnNnMEp0eVY1dy9HUTRVZ3ZXbGZ5WlpzNklEZEUxZ2hMYjc0Ump4TEhH?=
 =?utf-8?B?ZkREQzJiYnVvSk5DYk1MdSs2a1hNSjBYZkpMVG11SVZpd2NNUS9zOVJiek9N?=
 =?utf-8?B?Y3ltWnkyWm4vWWlza2hyL2lZVUpvb3I1WXFDYmZSVGVDNkxZNGZqYkJrcm94?=
 =?utf-8?B?dm5HUTVHdDNJTktMZjNrYVBPM3lGSmNlK0JLbHNhcEpjMEpPZkF6OW9KcWk5?=
 =?utf-8?B?djlCcEVjTVQxaDRIQ0c3NUlxZnFLRGRQaXJJYlUyNnhCbjRielFKcFNwY3Qy?=
 =?utf-8?B?QlNDYStvQ053WEVMRGd4M0c2ZU05TGFyeFZzbnZVZE54TkVCelJCeDcwWUJt?=
 =?utf-8?B?NDlTamdPMWlaQUNyS3JlSlJJODFldEREL3h4aGFYL0cvRlJtdFkvS1d1MVFS?=
 =?utf-8?B?azZJRWlLdlB0MkxxWm9rekt5NHh6U2tZem5WYXZIMUd3a1EvWE1ieG14WWdF?=
 =?utf-8?B?Z3FQT1JPMjhDRUFqRlRtWFhQU0FGcEdsS0JVVVppTmFmMjhiWGZXL1lmTThn?=
 =?utf-8?B?d1k5TWFOdG5MR0Q3RTV6dnU2TzFhQ3lQSXk0R04ydVlVd3RXSnluRGdJanRl?=
 =?utf-8?B?MVZjTGIvRlg0YnJmVGlRd0krdGxOcFgwYmJsVVBGZlFmc2ZDTmRtN0ZweWxt?=
 =?utf-8?B?VEh3UlV4QWhXUmhkN2FIaHAvR25XNUFwRklWZU02eFVnTTRpWGtQRjJsZytu?=
 =?utf-8?B?NDVOSi9waU1sa0dpTHltS1VOYUhGRWFXSXhUcE1qT3RpTVcvSEN4WmFkTk1V?=
 =?utf-8?B?NEgrNVVMTUI3b2QxTmM5aGlxYVd2WFJyeml0VGFDbkRBczY1OUFnbFMrbytB?=
 =?utf-8?B?cmR2dlhQSEVLTHpwckhQVko1WFpqMG9JM3d3R1dyOVVUQmwweUxyWWF3clZI?=
 =?utf-8?B?bWVRZkJVdEw5MldabkRURzYrRk8yemZ6TWRUdU8xcHljVzlENURWTUhrNFpx?=
 =?utf-8?B?bjYya1hoT2tyVEdpZFpJN0dSQzl4SHNPSnl3L2FMOXZ6cnI1QURka0EveXhl?=
 =?utf-8?B?NjEvY3FTU2VFamp2YnJoWnIrVDFnSDRVMXVuT2R1bFdta1NZMWY1SXRhWmNJ?=
 =?utf-8?B?NHV1S0Z1ckN4QzRnNjBzRnZwMko5dUZrS0VVSlNLM2p6d2FOaUNDdHRvVS9H?=
 =?utf-8?B?WnJpdTFzR3grb3krKzhaYVU0RzJqL3VxbzEvYU5kM2p3dTNvSDZ0bDNoMHM1?=
 =?utf-8?B?dGxXZ1dlZWhYN05xc2ZyZDJyV2RWM3ZQYkU3dnZ5eXhXK1FPS0t3aG5jdUxZ?=
 =?utf-8?B?SVJPbnpacXlZNG9pKzJMR2dwZnZtQUpmMHZMYjliY3dtdG04eUttMnlaallj?=
 =?utf-8?B?SkZtN2diY09GYXhNWXU4eFpkVFFKNzJRUVVkRHd0V2tJMjJBRTFpT2szcUpI?=
 =?utf-8?B?Skw3S1JSNU0wQkxQcnh1NlV4ZEZyOUJFMlhLZHM2TkVzMWVwOUJKWGJHVmdV?=
 =?utf-8?B?YTQxZHYzUi9GRmQ0b0dKNFZEV2ZNUDF6NFo5b2hheE80bUlMeGV5eUs0TmJ0?=
 =?utf-8?B?TzFaRlB1RFdEekhKK1NmcmtkTitQZlVlRnh5WGdScU40ZGtYNDhpUW0rNm5N?=
 =?utf-8?B?T0swUEVCZk8veTc2Z1U5VjIzWm5DTlVETUVhQzFXV3ZmaE84Zi9UVk1Wa1B2?=
 =?utf-8?B?b2RXdEtWcmhPYW9vbHdIbTlFSEtlWEcwYXkyN3AvbzI1MlViSGU3TmJHOHBl?=
 =?utf-8?B?SjZSSysxVDE1WnRhRnhFTEhiWVlJL1VBRk5zOGE1QnJaeXZBZ0EzWVlMcmZQ?=
 =?utf-8?B?c1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd61ad35-5e99-42e3-cb49-08ddece9173c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2025 02:00:01.9750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 412qckab0FSqN5yZVLn1HZV4CdxVbAsT72LH0EjEiUXx0fqecNgUJVUKGe7kLn57DkND38/DGke3RJTAxX2T5DFcQrik2bBp/CpjGl4Uapk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7182
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
[..]
> >>
> >> Ah this is an actual problem, this is not right. The PCIe r6.1 spec says:
> >>
> >> "It is permitted, but strongly not recommended, to Set the Enable bit in the IDE Extended Capability
> >> entry for a Stream prior to the completion of key programming for that Stream".
> > 
> > This ordering is controlled by the TSM driver though...
> 
> yes so pci_ide_stream_enable() should just do what it was asked -
> enable the bit, the PCIe spec says the stream does not have to go to
> the secure state right away.

That is reasonable, I will leave the error detection to the low-level
TSM driver.

> >> And I have a device like that where the links goes secure after the last
> >> key is SET_GO. So it is okay to return an error here but not ok to clear
> >> the Enabled bit.
> > 
> > ...can you not simply wait to call pci_ide_stream_enable() until after the
> > SET_GO?
> Nope, if they keys are programmed without the enabled bit set, the
> stream never goes secure on this device.
> 
> The way to think about it (an AMD hw engineer told me): devices do not
> have extra memory to store all these keys before deciding which stream
> they are for, they really (really) want to write the keys to the PHYs
> (or whatever that hardware piece is called) as they come. And after
> the device reset, say, both link stream #0 and selective stream #0
> have the same streamid=0.

Ah, ok.

> Now, the devices need to know which stream it is - link or selective.
> One way is: enable a stream beforehand and then the device will store
> keys in that streams's slot. The other way is: wait till SET_GO but
> before that every stream on the device needs an unique stream id
> assigned to it.
> 
> I even have this in my tree (to fight another device):
> 
> https://github.com/AMDESE/linux-kvm/commit/ddd1f401665a4f0b6036330eea6662aec566986b

I recall we talked about this before, not liking the lack of tracking of
these placeholder ids which would need to be adjusted later, and not
understanding the need for uniqueness of idle ids.

It is also actively destructive to platform-firmware established IDE
which is possible on Intel platforms and part of the specification of
CXL TSP.

What about something like this (but I think it should be an incremental
patch that details this class of hardware problem that requires system
software to manage idle ids).

-- 8< --
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 0183ca6f6954..2dd90c0703e0 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -125,17 +125,6 @@ config PCI_ATS
 config PCI_IDE
 	bool
 
-config PCI_IDE_STREAM_MAX
-	int "Maximum number of Selective IDE Streams supported per host bridge" if EXPERT
-	depends on PCI_IDE
-	range 1 256
-	default 64
-	help
-	  Set a kernel max for the number of IDE streams the PCI core supports
-	  per device. While the PCI specification max is 256, the hardware
-	  platform capability for the foreseeable future is 4 to 8 streams. Bump
-	  this value up if you have an expert testing need.
-
 config PCI_TSM
 	bool "PCI TSM: Device security protocol support"
 	select PCI_IDE
diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
index 610603865d9e..e8a9c5fd8a36 100644
--- a/drivers/pci/ide.c
+++ b/drivers/pci/ide.c
@@ -36,7 +36,7 @@ static int sel_ide_offset(struct pci_dev *pdev,
 
 void pci_ide_init(struct pci_dev *pdev)
 {
-	u8 nr_link_ide, nr_ide_mem, nr_streams;
+	u8 nr_link_ide, nr_ide_mem, nr_streams, reserved_id;
 	u16 ide_cap;
 	u32 val;
 
@@ -74,14 +74,13 @@ void pci_ide_init(struct pci_dev *pdev)
 		nr_link_ide = 0;
 
 	nr_ide_mem = 0;
-	nr_streams = min(1 + FIELD_GET(PCI_IDE_CAP_SEL_NUM, val),
-			 CONFIG_PCI_IDE_STREAM_MAX);
+	nr_streams = 1 + FIELD_GET(PCI_IDE_CAP_SEL_NUM, val);
 	for (u8 i = 0; i < nr_streams; i++) {
 		int pos = __sel_ide_offset(ide_cap, nr_link_ide, i, nr_ide_mem);
 		int nr_assoc;
 		u32 val;
 
-		pci_read_config_dword(pdev, pos, &val);
+		pci_read_config_dword(pdev, pos + PCI_IDE_SEL_CAP, &val);
 
 		/*
 		 * Let's not entertain streams that do not have a
@@ -95,7 +94,65 @@ void pci_ide_init(struct pci_dev *pdev)
 		}
 
 		nr_ide_mem = nr_assoc;
+
+		/* Reserve stream-ids that are already active on the device */
+		pci_read_config_dword(pdev, pos + PCI_IDE_SEL_CAP, &val);
+		if (val & PCI_IDE_SEL_CTL_EN) {
+			u8 id = FIELD_GET(PCI_IDE_SEL_CTL_ID, val);
+
+			pci_info(pdev, "Selective Stream %d id: %d active at init\n", i, id);
+			set_bit(id, pdev->ide_stream_map);
+		}
+	}
+
+	/* Reserve link stream-ids that are already active on the device */
+	for (int i = 0; i < nr_link_ide; ++i) {
+		int pos = ide_cap + PCI_IDE_LINK_STREAM_0 + i * PCI_IDE_LINK_BLOCK_SIZE;
+
+		pci_read_config_dword(pdev, pos, &val);
+		if (val & PCI_IDE_LINK_CTL_EN) {
+			u8 id = FIELD_GET(PCI_IDE_LINK_CTL_ID, val);
+
+			pci_info(pdev, "Link Stream %d id: %d active at init\n",
+				 i, id);
+			set_bit(id, pdev->ide_stream_map);
+		}
+	}
+
+	/*
+	 * Now that in use ids are known, grab and assign a free id for idle
+	 * streams to remove ambiguity of which key slot is being activated by a
+	 * K_SET_GO event (PCIe r7.0 section 6.33.3 IDE Key Management (IDE_KM))
+	 */
+	reserved_id = find_first_zero_bit(pdev->ide_stream_map, U8_MAX);
+	if (reserved_id == U8_MAX) {
+		pci_info(pdev, "No available Stream IDs, disable IDE\n");
+		return;
+	}
+
+	for (u8 i = 0; i < nr_streams; i++) {
+		int pos = __sel_ide_offset(ide_cap, nr_link_ide, i, nr_ide_mem);
+
+		pci_read_config_dword(pdev, pos + PCI_IDE_SEL_CAP, &val);
+		if (val & PCI_IDE_SEL_CTL_EN)
+			continue;
+		val &= ~PCI_IDE_SEL_CTL_ID;
+		val |= FIELD_PREP(PCI_IDE_SEL_CTL_ID, reserved_id);
+		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, val);
+	}
+
+	for (int i = 0; i < nr_link_ide; ++i) {
+		int pos = ide_cap + PCI_IDE_LINK_STREAM_0 +
+			  i * PCI_IDE_LINK_BLOCK_SIZE;
+
+		pci_read_config_dword(pdev, pos, &val);
+		if (val & PCI_IDE_LINK_CTL_EN)
+			continue;
+		val &= ~PCI_IDE_LINK_CTL_ID;
+		val |= FIELD_PREP(PCI_IDE_LINK_CTL_ID, reserved_id);
+		pci_write_config_dword(pdev, pos, val);
 	}
+	set_bit(reserved_id, pdev->ide_stream_map);
 
 	pdev->ide_cap = ide_cap;
 	pdev->nr_link_ide = nr_link_ide;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 45360ba87538..6d16278e2d94 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -545,7 +545,7 @@ struct pci_dev {
 	u8		nr_ide_mem;	/* Address association resources for streams */
 	u8		nr_link_ide;	/* Link Stream count (Selective Stream offset) */
 	u8		nr_sel_ide;	/* Selective Stream count (register block allocator) */
-	DECLARE_BITMAP(ide_stream_map, CONFIG_PCI_IDE_STREAM_MAX);
+	DECLARE_BITMAP(ide_stream_map, U8_MAX);
 	unsigned int	ide_cfg:1;	/* Config cycles over IDE */
 	unsigned int	ide_tee_limit:1; /* Disallow T=0 traffic over IDE */
 #endif
@@ -617,7 +617,7 @@ struct pci_host_bridge {
 	struct list_head dma_ranges;	/* dma ranges resource list */
 #ifdef CONFIG_PCI_IDE
 	u8 nr_ide_streams; /* Max streams possibly active in @ide_stream_map */
-	DECLARE_BITMAP(ide_stream_map, CONFIG_PCI_IDE_STREAM_MAX);
+	DECLARE_BITMAP(ide_stream_map, U8_MAX);
 #endif
 	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
 	int (*map_irq)(const struct pci_dev *, u8, u8);

