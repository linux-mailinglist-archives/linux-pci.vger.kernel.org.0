Return-Path: <linux-pci+bounces-6009-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E91E689F12A
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 13:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13FE71C21186
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 11:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EBC1494D6;
	Wed, 10 Apr 2024 11:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e003a1HV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B095815AACF;
	Wed, 10 Apr 2024 11:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712749691; cv=fail; b=DBDggG3KByDiXeGC+SAp52jobiIW1hCFi6e+dd5NbvlwOxsTTHQ45qg6y0Jvkf6+H09Upkq31NwUltvqDvpalWn8BT8FHogakb2jeIaWgrfL7N6gLm3Eos/YtJV5663meQyQZQ3ot/4OCHSek7ynDTDLcMRgFu6fv+CiDuBXz8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712749691; c=relaxed/simple;
	bh=R3D678VAx4yaziqzcLcDSGqF6Q4a3oMj5oJYC1yjCpQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cOpEsnpeX0LcH+hcxF0V+eP/eQEsSsl3j1m05mbJzocgQrQTmJO1PPPf0qsJdZm7sYtyzfAm7okCf7vwiYV4z23gQ4g1fVb3LlDAfrm50Jzvbz4AaSpR47ZCvOOYNkC0gqo/paDFcKrIj7nfJm0MZbIsAbIe3SMAEsUSgfWJJs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e003a1HV; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712749689; x=1744285689;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R3D678VAx4yaziqzcLcDSGqF6Q4a3oMj5oJYC1yjCpQ=;
  b=e003a1HV89WGSJdf40A828Un0qGhNEwvZi2Loh39xC6u1yvlpeCNqmV8
   lrVL3sMK7KrsMLAECYTqX6bhsREGWFU64Y+ipU4LY/hPe/1Bl6iFGUg+A
   AZbWj4lrZuDc9zVl7a3SY1Uk6K0j5pXXVv5Ca2g3/543UQgUCMrTqS3dC
   mZiNd8wdKNrgnFLr7xUZu/sKJLceSPtUF4+8VcwdKc350/QBb2XrwR3Z3
   zXMIIdB2AaEX8blbD6hLHGH1W0sTHP2bl5Qzc2jKTojZwnZJRHmOQQMXM
   4zt/KlaovMsskwvDSNlsDDa1OZCH5WCEP6fzeZuvnHGwtlJ4tXUm9w8nv
   Q==;
X-CSE-ConnectionGUID: 8jsjQk93RMCLIdHdgudnlQ==
X-CSE-MsgGUID: JAtFHhVLR3isNER9e4Z/jQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="19254280"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="19254280"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 04:48:08 -0700
X-CSE-ConnectionGUID: Pi3RdlqCRtqMwF7+IZOcyw==
X-CSE-MsgGUID: fHFGc3t2Sn6qmsEbsOR9Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20507588"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Apr 2024 04:48:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 04:48:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Apr 2024 04:48:06 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Apr 2024 04:48:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOjMzqThrBobEy+hFDFBbWV1yQewS0wXC+ZwTsNcdctpdvEmqfSfUL4G+Hm+aLFCTIqSCUVMb1c+qpLTuOCOhSQf93+xa8gFuY35dukTaGj+K55DnLxHsGT5LwjlD8xreYz2BWqezgOH5SMDo9yMVAGmprUArZQt56Mc9WI5Kq3d/IINspmi8MoWuMGCAn7GK8NGx0e187kDSSfuyQ4yMCbkR+HzkMqgEIZBCIEnJHEukY8qWSwRmslFv7q7zzZnyekO9gZCPgAEBFqTLLnmoOy5SibLu5s3tLTwmM8iTiUAlWBRF23zBDUNw06uzTeQXBry/yW+cvDlVIMmK2fCkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzXSdrl3VPEur4zmr6jjOxQnkWifRzwRi6K0KVM+4jY=;
 b=RUU9xLl4fulR1JMcinkCDTx5mkhcLBVRBHUvmh8IrrdGoX43kaSOtigWE0HhYl7e3LhN/bivq+Cz6uW3p69Ick/IVCXYlprQ2hhct5979CWFsm+tFqXmsh/xDkHSyJ5yIp7ChlHUnEyrAl095R+zCHFQxDsRG9Nb+2lng8B2pQl3spvHzqewHJMmcMhPzd/xdugS7kPBRg+2HuPlngA75E7Od7gJQHuGawaFeeQXmeo9U4PEec7LlJeHrhso6dncZKb+B8EoZtCURl/7mVLA9b0VyNEzNtycz3ojcPZXuzGMxeRXXvdGzCkkIAaWVCibwZQ2en8dkPTMTtU9Z4TgrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH7PR11MB6053.namprd11.prod.outlook.com (2603:10b6:510:1d1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Wed, 10 Apr
 2024 11:48:02 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7452.019; Wed, 10 Apr 2024
 11:48:02 +0000
Message-ID: <043179b5-d499-41cc-8d99-3f15b72a27cc@intel.com>
Date: Wed, 10 Apr 2024 13:45:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
To: Jiri Pirko <jiri@resnulli.us>
CC: John Fastabend <john.fastabend@gmail.com>, Alexander Duyck
	<alexander.duyck@gmail.com>, Jason Gunthorpe <jgg@nvidia.com>, Paolo Abeni
	<pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>, <davem@davemloft.net>, "Christoph
 Hellwig" <hch@lst.de>
References: <20240405122646.GA166551@nvidia.com>
 <CAKgT0UeBCBfeq5TxTjND6G_S=CWYZsArxQxVb-2paK_smfcn2w@mail.gmail.com>
 <20240405151703.GF5383@nvidia.com>
 <CAKgT0UeK=KdCJN3BX7+Lvy1vC2hXvucpj5CPs6A0F7ekx59qeg@mail.gmail.com>
 <ZhPaIjlGKe4qcfh_@nanopsycho>
 <CAKgT0UfcK8cr8UPUBmqSCxyLDpEZ60tf1YwTAxoMVFyR1wwdsQ@mail.gmail.com>
 <ZhQgmrH-QGu6HP-k@nanopsycho> <66142a4b402d5_2cb7208ec@john.notmuch>
 <ZhUgH9_beWrKbwwg@nanopsycho>
 <9dd78c52-868e-4955-aba2-36bbaf3e0d88@intel.com>
 <ZhVThhwFSV0HgQ0B@nanopsycho>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <ZhVThhwFSV0HgQ0B@nanopsycho>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0151.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::19) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH7PR11MB6053:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xC2wH6OBARyn1opsvtxwTtD/f03W9fI09w1CTyMWK6PeEZ/ZfBBG+7CB4t3CBj/hYE2dAwDwJx8ADeSNmJX1uIuiPYtp9sFkPLKJkvmDcibPM0m619tw79nJ0CqiAoOjsYLBq2zIrOeyWWjmXqcogmgRxGQWC+JUBUqNUMVVQcE/YhyN1vYGQEVlxW55Ol4mpt0xTeB/iJIn95RKLox0BsNerg6pcfl3qPHM8hvd7YvZ0ApUnnOhZqbaaa1f3bJJHpmTNFys8qe22mIeBb0mINLc0Jls8xFMuORlzZijGPP78U46dmbHGoB+gbgV5ZJrGGpccT8nllCcMDvtmFNB1cbHEzQUSN9GJIojc24q/mYUrcZtH/IfWzOOin5YxhKuJ9rcF2e3B6Io8ewFaFvVdZzMSO3j0RkvxmFnQ5+h8yL43QLfLY+FMlEybw0BVXN3lE5o/u1mCWitt1H6QcWEgg/2nTA8YH/ZJ469RYi7JUQWAWBwIEfya5hfRZoel+jbGLN6htr/WSNp8Ph8PBjmrVRFQoQ4kCzgVQjCVnzPKjvmQpI56avXnYM/zptxCPfb6Zu/b1DG2vAbK86sP3FODGsALSDFEhfo8xtcfrAPt8+VsN4fI6rdgRGhol36Ef8m8OiiJECJK9hWaRgPzRN3CLA6ZHFeabc8fdCe2kP+zyc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWdNWnhuNDhwbEY0WXRlaEowWUIyMFQ1L25JSmN4aEJyZklFS2t4REw1WkYr?=
 =?utf-8?B?MFZQdlBRWktacHpaS3d3bFcvSGR1VndwZzNUalhOUzBWcGZuQ0F0T3A4RkNM?=
 =?utf-8?B?WUFrTHEyN2xsZk1iKzZzbWVFZklZdmdPbmNhNzlJcy8xWEhzdTB0MHRsY2Fl?=
 =?utf-8?B?STZtbTgrbkoxNkJlcTFHR0xJUVU2UU5xK2c2ZHRjV203YzhKYkFVT3RjWERs?=
 =?utf-8?B?RHlWNmhQN0xHVkZpbHozTHkwRUIvTEVsWVIra0xDVXg1aFFpT0hlcnlCY1Ny?=
 =?utf-8?B?RFNUUnQvc2RKVVB0OE02eUcvRFFRMjViMHlENTZHd0xCcHRLVnhLd1hWOHA2?=
 =?utf-8?B?L2ZGeFJxajRTSUc4OGhvZ3Q1S25qS0lab1QyMG9iaTd1RmpORGJyOW9xeW9F?=
 =?utf-8?B?c1kvU0Z0b0lpNjE4emtERWYwbGdzV3BBQ2N3cW43bzlUelZwN1IyUUNTTkYx?=
 =?utf-8?B?OUFpY1ZGZTcrcXRuaFlKZHBJNEcrbFJoZVg4SVlBbCtPbjdzK0ZJUXl5YmV6?=
 =?utf-8?B?bHhydW9nclRVYXprVTVIeFRNTmxpcnBzY0haRFgyeGtrUXhLdDBVcGNrTU9R?=
 =?utf-8?B?bVJVVTBIbWZSbWtkUFpZZGRMb0lqcWZOdU0vYUVyd1BSZ09NTFJCcGhTWDRD?=
 =?utf-8?B?YlhRQzR0eUoxREZyV3FJcmpneldTYXRqQ0Nnd05laUYzUkE1L0RRM2s5bnBt?=
 =?utf-8?B?dUdEWmt0SmpZdGY3KzVabkFld0YyY01NclFCSUJhampSbE00amVRZnpxL3ZP?=
 =?utf-8?B?WjBhcHhmK294UmpzcVcrL1AzZWZYZmhCNlFQVHZSY2FGaVRNNTloTG5vTzJQ?=
 =?utf-8?B?MlJyV1JXMjlTOUplbWROekpFcFdETjJ4eTI2SjVYWFYyOEpVQVk3aHFSL3Bl?=
 =?utf-8?B?ZmliR1pBUnV1MWtJTEFGZjdSZ3ZyVzdCbHptNDN5MDlmVGtXYUxqUEpQVk9N?=
 =?utf-8?B?Tys2azlWQldQRUJYbHJyazRweENBdXBPbG1nOHBZWGN5UHl4Q283d01kQndX?=
 =?utf-8?B?WXdZU0c3UzJRWUswd09hN3dya21BSG1PUkN4T0Z4QXZ4RjhsSzk2MFdJejds?=
 =?utf-8?B?RWRyZzlSL0tvTUIxYldMNVFJUXZjNFJ3NzU3dGFtWlJqRFpNRVQxZEVDRHFD?=
 =?utf-8?B?akVNMFRIRXJYanNYY25GQlg3blg4YTBySHFWV1BlQWVXWnJGN2hreHpycS95?=
 =?utf-8?B?cjNxY0RjMVZqQVlId0FYa1JzYVRuZTV0VldsUDJzelRZZlIrSkxDLzRJbVpr?=
 =?utf-8?B?OXpWK2RyZXM2QzNGM1VyVTNkZGlKK05jQ1hQMkpXbWI0SkNNNy90by8wK0kv?=
 =?utf-8?B?SU1laXNFcnhzeEpMVzc5M1FWdzFzcVdKc2JkSExlczByRkxpYkdoRXh4blVx?=
 =?utf-8?B?V0g3UlRybk1XemhIQjl5UWpXUW8yQmdiODRDV0lZNTJTZktwSU5ZTTQrTU4z?=
 =?utf-8?B?OHBiTGpsK09vKzhxMkxpbUtZQjJ6K2xVUk8xcmgzZGk0QzBTZUxkSitkUVhs?=
 =?utf-8?B?YU5XZ3NwY1UyYmtmRGttc2dtVytJeDFBYXVXanA5a0RIRitSbHVoU3Z3Y1Nh?=
 =?utf-8?B?UFRLb2ZYZGZNMTRBOVk0UWZlK3I4SmIxSVFiOU1nZktGTjVDOUl1bzh2ZGd6?=
 =?utf-8?B?MlBXV01EUStVUTZMNmMxTnJySjRmb3lsUGZieFdzczk3M1ZvWisyQi9UeEJV?=
 =?utf-8?B?Z1lYOHJZcUZPcytmcGJpc0JlUWdKTTFDTmtSREdxYVAxQ1F5QWIxZWlwbUU3?=
 =?utf-8?B?WVJraWJjWUtUcUY3QTZaVzZKb1g1YlNvOXJNaDJpVE1mbVd3MjdtMUgxb2xh?=
 =?utf-8?B?NFVMY2lPZ1hOTERLaXB6V1g4d2FCbmdIUnB6c09pS0FaRWVScmhnR2JnS0dS?=
 =?utf-8?B?M0ZBRnA2Rkc3ZDRUWHJpZ2tOYVVWdDlHRDJEQUJBNmprbnFHTjZ6NUVIdHJ0?=
 =?utf-8?B?cXgxTHNrTC9NVjlQUmlKM0dHWnl2L3lkR0NJRnh3WDBwVkFuQkF4WmI0NC9u?=
 =?utf-8?B?cVdhb0FJMmt6NStwYS8vM2U1QTh5b2hmR1M3aW9ncFdpeHp1Uk81azk0K2tR?=
 =?utf-8?B?UFZvZWxRbzkzYStHL2R5UjBqdU0yamJWTmxqWEdDYjI0cWVIck54NzRwTXFG?=
 =?utf-8?B?bk9XRElRUWthYmpkZU5hVnBKQ0NPNy91L21IQzhhNFdjak9iQ3IyMmEwbHcy?=
 =?utf-8?B?OGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e9aeed73-31ae-4fbd-4712-08dc595413e7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 11:48:02.7143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IOtaxyIqfSFopot4bq+w0daZnv/F3ZMF1E41/tWvSOh4eNudUdzRRvBOu9oximIiyqnaep7VGkZQICdu1bL9TjVEdxaZQ0OtJgAuTeuAoMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6053
X-OriginatorOrg: intel.com

From: Jiri Pirko <jiri@resnulli.us>
Date: Tue, 9 Apr 2024 16:41:10 +0200

> Tue, Apr 09, 2024 at 03:11:21PM CEST, aleksander.lobakin@intel.com wrote:
>> From: Jiri Pirko <jiri@resnulli.us>
>> Date: Tue, 9 Apr 2024 13:01:51 +0200
>>
>>> Mon, Apr 08, 2024 at 07:32:59PM CEST, john.fastabend@gmail.com wrote:
>>>> Jiri Pirko wrote:
>>>>> Mon, Apr 08, 2024 at 05:46:35PM CEST, alexander.duyck@gmail.com wrote:
>>>>>> On Mon, Apr 8, 2024 at 4:51 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>>>>>>
>>>>>>> Fri, Apr 05, 2024 at 08:38:25PM CEST, alexander.duyck@gmail.com wrote:
>>>>>>>> On Fri, Apr 5, 2024 at 8:17 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>>>>>>>>>
>>>>>>>>> On Fri, Apr 05, 2024 at 07:24:32AM -0700, Alexander Duyck wrote:
>>>>>>>>>>> Alex already indicated new features are coming, changes to the core
>>>>>>>>>>> code will be proposed. How should those be evaluated? Hypothetically
>>>>>>>>>>> should fbnic be allowed to be the first implementation of something
>>>>>>>>>>> invasive like Mina's DMABUF work? Google published an open userspace
>>>>>>>>>>> for NCCL that people can (in theory at least) actually run. Meta would
>>>>>>>>>>> not be able to do that. I would say that clearly crosses the line and
>>>>>>>>>>> should not be accepted.
>>>>>>>>>>
>>>>>>>>>> Why not? Just because we are not commercially selling it doesn't mean
>>>>>>>>>> we couldn't look at other solutions such as QEMU. If we were to
>>>>>>>>>> provide a github repo with an emulation of the NIC would that be
>>>>>>>>>> enough to satisfy the "commercial" requirement?
>>>>>>>>>
>>>>>>>>> My test is not "commercial", it is enabling open source ecosystem vs
>>>>>>>>> benefiting only proprietary software.
>>>>>>>>
>>>>>>>> Sorry, that was where this started where Jiri was stating that we had
>>>>>>>> to be selling this.
>>>>>>>
>>>>>>> For the record, I never wrote that. Not sure why you repeat this over
>>>>>>> this thread.
>>>>>>
>>>>>> Because you seem to be implying that the Meta NIC driver shouldn't be
>>>>>> included simply since it isn't going to be available outside of Meta.
>>
>> BTW idpf is also not something you can go and buy in a store, but it's
>> here in the kernel. Anyway, see below.
> 
> IDK, why so many people in this thread are so focused on "buying" nic.
> IDPF device is something I assume one may see on a VM hosted in some
> cloud, isn't it? If yes, it is completely legit to have it in. Do I miss
> something?

Anyhow, we want the upstream Linux kernel to work out of box on most
systems. Rejecting this driver basically encourages to still prefer
OOT/proprietary crap.

> 
> 
>>
>>>>>> The fact is Meta employs a number of kernel developers and as a result
>>>>>> of that there will be a number of kernel developers that will have
>>>>>> access to this NIC and likely do development on systems containing it.
>>
>> [...]
>>
>>>> Vendors would happily spin up a NIC if a DC with scale like this
>>>> would pay for it. They just don't advertise it in patch 0/X,
>>>> "adding device for cloud provider foo".
>>>>
>>>> There is no difference here. We gain developers, we gain insights,
>>>> learnings and Linux and OSS drivers are running on another big
>>>> DC. They improve things and find bugs they upstream them its a win.
>>>>
>>>> The opposite is also true if we exclude a driver/NIC HW that is
>>>> running on major DCs we lose a lot of insight, experience, value.
>>>
>>> Could you please describe in details and examples what exactly is we
>>> are about to loose? I don't see it.
>>
>> As long as driver A introduces new features / improvements / API /
>> whatever to the core kernel, we benefit from this no matter whether I'm
>> actually able to run this driver on my system.
>>
>> Some drivers even give us benefit by that they are of good quality (I
>> don't speak for this driver, just some hypothetical) and/or have
>> interesting design / code / API / etc. choices. The drivers I work on
>> did gain a lot just from that I was reading new commits / lore threads
>> and look at changes in other drivers.
>>
>> I saw enough situations when driver A started using/doing something the
>> way it wasn't ever done anywhere before, and then more and more drivers
>> stated doing the same thing and at the end it became sorta standard.
> 
> So bottom line is, the unused driver *may* introduce some features and
> *may* provide as an example of how to do things for other people.
> Is this really that beneficial for the community that it overweights
> the obvious cons (not going to repeat them)?
> 
> Like with any other patch/set we merge in, we always look at the cons
> and pros. I'm honestly surprised that so many people here
> want to make exception for Meta's internal toy project.

It's not me who wants to make an exception. I haven't ever seen a driver
rejected due to "it can be used only somewhere where I can't go", so
looks like it's you who wants to make an exception :>

Thanks,
Olek

