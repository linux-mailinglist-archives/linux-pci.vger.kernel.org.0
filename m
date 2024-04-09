Return-Path: <linux-pci+bounces-5983-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7089289E5C1
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 00:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBE0D1F2234B
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 22:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104CF158A2B;
	Tue,  9 Apr 2024 22:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a7h7RZAa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59421DFE8;
	Tue,  9 Apr 2024 22:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712703116; cv=fail; b=PvGlEex+yfdeO6m7sJUr14OoquXIoTtNvAmY3W0/ZWE8Gz/9KePLWCeUKhVcZdsydcEcdBm4ScRrgmYq/cXVz747m9CvuSxHlmZqNfIRBJ9CHyGw53/tu6yGkjeol4oH3tyXy7zzBuWlLKjuzk6Kc6B86BmawNvtxiqEmHD3BcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712703116; c=relaxed/simple;
	bh=Dow5RUem8tj7bMPuggsZNcFnYZSaYK7ZRtQXQVdus+0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HNKRYPVfqDHxplgGJRzm0M7v0gSf51Y15H2976EIeFlholftCFB5w1VU5JXMOV8i7TrAWBMKsTlnxgBvkJ7iFq5Uz48pZ4Y6CAM3/ktD2txiO5EqzMQKRSHBvAJf4K4HeMX2PYMeRJzl+ByrBIuNjkrJBLOEuAgLqTwuN/rGrgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a7h7RZAa; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712703114; x=1744239114;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Dow5RUem8tj7bMPuggsZNcFnYZSaYK7ZRtQXQVdus+0=;
  b=a7h7RZAaEnxMVy+MV5IFE3mbpBBsYoCbVz0pwYEhS/Uq+vtDtmtuZZcg
   +8SqjsGCUXwKbd+J8/4Wg5+ndYtqXvEEe15tfkUnxHrDI8RbPAhIj73GO
   2Z0MpvsFFxftSfYH/ptaIffcsCwqG+2HNmjS21hWoaM77+cVfP9l4YgeO
   8c4TY7x7yCPJxMD/Fp3Svzq5lF75zDQsy1AuyYB0iB9jUli0BFFpuKYLe
   NulyDB48CB/NwK4tU+kgDFrIiyPWhCpnI//5KedCYNYx1qanSD4HIIy2q
   8eL9zwdjS+F4SUWMi99UigscCiXrjyke5+DAubDnQFI8lchvPnefbGpJU
   A==;
X-CSE-ConnectionGUID: MPjWJ+NjTiiWIYULq0EKDw==
X-CSE-MsgGUID: HN5OeKdsTOKDGKX833+5Hw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7896553"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="7896553"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 15:51:53 -0700
X-CSE-ConnectionGUID: 9Z5stAhXS0Csqx4f533f1w==
X-CSE-MsgGUID: zMDYhGpETXW/qCzyoDfmtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="25042696"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 15:51:52 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 15:51:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 15:51:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 15:51:51 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 15:51:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkxgq5mpMyUdzfkMvGXNT7MNEhXH+Si2Y+FQ5GFgBC4rlfeEgNioZ5ppWfFOakkcQbL+UNQl10C+vIZ986uofYwzEDkkPTRR++Kjkpf2utmfMCpARnbqq4jNaQZWPLb1be/FvBg8P0TUHt1GqBElMzmNC8FOzTs5BRI/YhiybzIr5DZ+UYgohZo2SxIERc0mHZ+XHNH5kUD2tosJvmtGnzg2ndcrlDUx3F37J6rdGthLiImCleslXBnFRcPYat4fYTX+XHctCbFtewL0Y5shzlM/zyHtvWmeW/7GmBcVY4QdoMrXwt5wRuiD5q97Dxl9Mq4inZGwwDCd8TgoqeOvqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MU8XDXZiHXJUd6lXeY6CXYi2DG2N/f8YN+OBHuzeIL4=;
 b=SmceDgxtrarsR7ki08XhUMv+TTJeFeoMeLKQb3Thum9LJfD0ml4Xw8Aw/C3Bqrk+BiLmr2q0ukHSCryc9TxZpuxxAThJ+ByuP3UgDaI7Ux0In3f1MUoalO9qwRYjPxFGU05to4E+lshyphNcxcKxZPPrvsoBHG42rZ+DB0LE41OKBDoZpYQ9UOyjOkVQ+6tDyfnj64gbUWh1EUVlhBI7F3z487byjb+3GvwemHyP0vtVmfZYxYC8nmvHdQ1JYxZW54ww7rpcpO8ZsaiocINo2uB8kBj7AMfF6qpm0myK976uw9gg8EKXm64GKZslyZFzr84040s0CrtoEM61dPIvzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB5826.namprd11.prod.outlook.com (2603:10b6:806:235::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Tue, 9 Apr
 2024 22:51:47 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7430.045; Tue, 9 Apr 2024
 22:51:46 +0000
Date: Tue, 9 Apr 2024 15:51:44 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <bhelgaas@google.com>,
	<lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v4 1/4] PCI/cxl: Move PCI CXL vendor Id to a common
 location from CXL subsystem
Message-ID: <6615c68041144_2459629498@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240409160256.94184-1-dave.jiang@intel.com>
 <20240409160256.94184-2-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240409160256.94184-2-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR03CA0207.namprd03.prod.outlook.com
 (2603:10b6:303:b8::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB5826:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6hlV8OpcwTjax5Rdce6zEG8dqpeKTnuUkimOwQDI1HvCVqwI6E10P9aOBiu92k6DDFbNADnlbCrGPKVtD7BK8DW6Mz4QqaCjvxqtTda7JFs3zlBzmW+4wmgDwcB3O4UO0+kt67smRHTpWfWCSryma3RFpVx+ddbHdt7OVpU7NAUo0sqOxlRDXjU1gi8qpgxd7rm27YTGS4dM1QsCo77fyVC2/6iM3BMQlx1d9KZY9k6MapmMOzhaBAGCzem4M4b6y2bP2qwOUJip+G0NCWUPYi0/qIf8XRlTl+/CPKUVwnAhM75mIOz8wNDs0MTKXtVivrQspCZT3m9/+K5AE0HLzrFCwqxGPloYC/Mg/RZ5rf/NEd9mNQvg0ypHl1763g42aVGatKH/QXxaF3tcuaZKH6+PrIuzfm2MTfFZym4rpFZNXm4qrZoH30i9Kg/QjFPCSJRNtRAD+BPQCiHGaAItVkZhINWuha5sQ7nP5wptDklx/XyShHeRNo4Q7nHwpnBGBR9E8kysrfjeCmjBcDRoqZ9PyGgY8vdxwEWt9GdqTQ5yvYhlAkl36e9lRdeHUwioaFRqlf3WzVzBsERTm3fV9rNRDJiN2nrdsgxqkXnZBwgeNi3IRfCBS61xeZkHlA1c/jPtdplady9IPa44lS8eFZrIPOd9ED/Q4u2Tjiv8ZTA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cuFY++by0xrdR43X/FX4FTJyhigGSKjiDDc5sVPEmXoJo0lu/MGWFGoNjb9W?=
 =?us-ascii?Q?UOuXchTkuwt4bfzTSMqNv2G+AKr+DFbKdGJHK/cegIcDlZqQzSuUS46/s0Cy?=
 =?us-ascii?Q?Fk3NCmMQ/yf5fVQOzarugwXHB5IEVQ0FPcnHzSnRKvOr0Rv4E3TGyR24vQ8r?=
 =?us-ascii?Q?NlajTRJ0i0pNnLjseS2Hj7lti5mWZbLxR2gJnZdYSAyUGgoGLnH6fmByLUfc?=
 =?us-ascii?Q?s5/wulOmcT32Dff/YJeREsKiq3o4OFFYEBRT/J7t+dLtqJPdQNApuZL+wIYB?=
 =?us-ascii?Q?Jv5jAoiw4aPx5bYWSkCIYcYJIHVTP3Ei7nLw+7rjj6NyS+KIwroAI99lbSsI?=
 =?us-ascii?Q?w1+x/cmellcQLoWF5ZBqZLhkbsb9JFzrk98OqvpytLHwgBBNH6aRmcjM3IQ7?=
 =?us-ascii?Q?ouieSMTMbgHtfhgFUT/YVHZz6W3P6lcU4OaPcbp7N4PGzHyjzEKVvX456pQ/?=
 =?us-ascii?Q?eqzMs4i/nP2moU6AWZ2WjENm8n5IpP4W6tRLMCc2PE49DxbikJkr33hKA/vQ?=
 =?us-ascii?Q?JgXQcl9j4faWkWBK4/FmhaPjnS4o3D6qp8e57lOPt7ZtfdATFgAUxorU1+dn?=
 =?us-ascii?Q?q22OkBJyuVfu6xPSLMKMY+HOcvC67zES1vCPJBVteFY0HOokv96L2vXnd47+?=
 =?us-ascii?Q?mHXxFtnpOLNthevVLoEQmZ2fzFjB6P6aoOW7RBgJ3q/0stkX3Veo+B/cXkJj?=
 =?us-ascii?Q?1+KyTC+ieft5JUTYNbnUrrXd5mGRw5uxsualmtRaM0XN7/iAmYJHGaB4JzIO?=
 =?us-ascii?Q?Pv/Qr2fkwTKYOioWJh/v4v8U3sN5BwQHeI/sJ3pqw3rGMh1fmQgH9M9iKter?=
 =?us-ascii?Q?RiA4R4g5/TmnKheeMwCFnB8K2RfF8MRfPG6F4re2yUxxg9MNeBFzHzKMZpGN?=
 =?us-ascii?Q?HBZII4bci7tz2VvtGDiSrC+9eGTYCqZzBMK5WdWztxP0GIXKCiIOGLVRlg7Y?=
 =?us-ascii?Q?RltMf/uK24eJErusA815TK+LIFNXFX69se9sq3OgMe1s8aBOpLAbFaUK6c/K?=
 =?us-ascii?Q?SFeU9fi8FPJXOh/oUYAUfMRuh3toqKImZI0Tbh/99tDbR3yODvhAjzP92tCW?=
 =?us-ascii?Q?4+fXKC1AKWbefqksVLasT3oPDXGWa8x1f3HF0kcQndxaRIvqZK2lf8kucn6m?=
 =?us-ascii?Q?WVU9WCNzqEnpHaimFn4vhcvNFxz/8bHtJ4dzpd6637InmdEIaEUUJQV4Nqd3?=
 =?us-ascii?Q?yNdT6FtuhTCTKyTDfnHgt0BPMJ9ZyO+bprpWFJZg7PWwHbhbqWJeTzIIMbtn?=
 =?us-ascii?Q?/CHJTFtg+dBiUm/RXe6xw9VPQW8HlHiG92t/lwddIRgaEQ8MIsJg0dwrBSA+?=
 =?us-ascii?Q?N2rFYCdkYvVmv+DTpK2m5hfFBEqkgeVMvwNHjP3BUR5L0HD4xSA7JMkTkBLb?=
 =?us-ascii?Q?3TGaOcUaPaKYaW3wTLOZO/tH3SMkaaeEQ5BJ2t408KnjN85/UGI7plTP6Ilc?=
 =?us-ascii?Q?PeTofNK0T+Ap1gZMj8j4v4ANFgXOqefwUm4Ja4q3m//zjf3RL7SvM7f/Y1Gi?=
 =?us-ascii?Q?attKYR5YvjH9CJy9aL3vr5cO2/akIznlWh/88kn72E9DN2QWoTG2L3gdMDO2?=
 =?us-ascii?Q?0vXKrSCL66EGoXX+rnw4RSt0yacdiGbO/Ipr9NgpZDPYXxVageu2lwyAoPvH?=
 =?us-ascii?Q?Sw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e7068d96-b93a-4e36-e2cd-08dc58e7a275
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 22:51:46.7378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3NfQhOvy1+2Mj65twdk5wGFzotJXHgVXbWUUL76/7jQR3DnQAQjAVFgwP+gQB//CyS5rjX5P8Q7kN2g8agoPuGe+LTV7YmzR3AjD0qromGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5826
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Move PCI_DVSEC_VENDOR_ID_CXL in CXL private code to PCI_VENDOR_ID_CXL in
> pci_ids.h in order to be utilized in PCI subsystem.
> 
> The response Bjorn received from the PCI SIG was "1E98h is not a VID in our
> system, but 1E98 has already been reserved by CXL." He suggested "we should
> add '#define PCI_VENDOR_ID_CXL 0x1e98' so that if we ever *do* see such an
> assignment, we'll be more likely to flag it as an issue.

Perhaps indent these as quotes, the second quote is missing a trailing
double-quote.

...but maybe even better to justify this change rather than the reaction
to the change. Something like:

--
When uplevelling PCI_DVSEC_VENDOR_ID_CXL to a common location Bjorn
suggested making it a proper PCI_VENDOR_ID_* define in
include/linux/pci_ids.h. While it is not in the PCI IDs database it is a
reserved value and Linux treats it as a 'vendor id' for all intents and
purposes [1].
---

...where that footnote can link back to the conversation for the
background.

Other than that, you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

