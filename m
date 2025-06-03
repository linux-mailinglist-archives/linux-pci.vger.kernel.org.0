Return-Path: <linux-pci+bounces-28910-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A50ACCDD6
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 21:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B04961889ED9
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 19:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D1B21D018;
	Tue,  3 Jun 2025 19:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RxjIR5A5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A96D1DFF8
	for <linux-pci@vger.kernel.org>; Tue,  3 Jun 2025 19:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748980425; cv=fail; b=SwAOYehS6F8SJSEC/PFs7SuTMDbIN21BI0qn2FrJdOJZhZOnmz3tXVOi/ZMsh0PtkmdWp9gbLNJTwtNz3dzAeunNZ49IXmeXMhap7PJvrNyirhk6V4ZsGHk5E5dh2fkwJs9mUvwvDIbmWnfQr/vxA6APJD8cIP7xXmGVXByUXDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748980425; c=relaxed/simple;
	bh=T0db77vx4qNaPYad1S9GXJtrnnt+Jlez1GK3oaRYj/o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jtw2yFPIC1NWHfJxjkDr1hm+Wo9Qiwft/u5Mr8VyF34sAdekcBAblXLBt8K5GLXoTTsln0gT+XPdPIJdsEzTTdKZDiUCnjM6jqW8ftI0FlJJjOoPpjjVLtySX9YKsAY1NA39HkQdutcGtbWC40Nr/yqbhkmZe+AgRBNfvf6a4dY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RxjIR5A5; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748980424; x=1780516424;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=T0db77vx4qNaPYad1S9GXJtrnnt+Jlez1GK3oaRYj/o=;
  b=RxjIR5A5AB7MG6QmDaf2N+LuKx8hryVlUfTEOzBubDMATd7RRPn5fyQ2
   EGB2R6e6ySA09aaJOD+V7QpFu+03DolpGDIk3eCp0G8Ut1cSvXndM2GPp
   N9YupvaHW/S1k5rzVt5FqJ0BtXz9XLhrvhuIwErkyGhsWNCVvxHH6UdKc
   wGFTcwO1lUN6NFQWRAe9Z1gudKrb9NNKPTezpoyASn6l0ZVmTSCyb7yNd
   Kn5luMRjpH+qCWpmmHUnYe0J63cNnfdZlHTeJL7qC0E66cys2oMioM9st
   gOd1Pkat34ctnP3Qn0MbdE76+hXBLcjbrFy5fUyprNm2ThkiDMxfxjfA0
   Q==;
X-CSE-ConnectionGUID: BCNfGV57T4udTAzEaGsRyA==
X-CSE-MsgGUID: ZlspUmneTqmrx3Y4CML9MA==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="68475119"
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="68475119"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 12:53:42 -0700
X-CSE-ConnectionGUID: kol9kvEURVqYcW/lrpNsuw==
X-CSE-MsgGUID: sJx1wBzoRmmmmis83jdytg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="150111941"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 12:53:40 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 12:53:40 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 12:53:40 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.53)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 12:53:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BH3VWnZxzFj0wAJqiREiz7AcidVT7Eih9c+WPHGsVLiOIV1R7utLB7Fjh/4VEODDg1NjO0qcFankGL0PZkvjGQGv1tg+xUlOtnsCiQqz1lEMrmAgFR8UhALdhYqo/eftIOv9KrFCQoU4H/VJ1YFLHkx3GQ/zxVJP6ZASpHdOVKXbLfe1f/IrWDxDwuQwfJi8025gjlh+ntRXwVJQp4dpnCMhRykelGJfOySLq+sv9TKTQmpJ0SSYSddHAKAYKVYpR8utQINybAdWhlbqJ7XVEl2qw8tevS9hEY1eI9a1YA/CGJ0V/dJE+2NcIaOn8yQjZPguuR8sR6bhQBQNiu+G9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vg+5J0avmSBBt+1+50+gvVaOd21Az0kQSd+L+Q5qUow=;
 b=mrizsN/Bc/jg21t4LQgjMYN3sga3T6/YPgBeb3slI4hfWlXFvIwlVd7phsEbp6EC0kh/hGpfbBFWy2gwKNfuMTiCVJfr9MkD1J0AgjM7eCzxSuJnZqd1fg/C9MOdsqgFrIsWlB1XaRa9vKFc+V2ZZNVcjEJuMYwycKPQ+tCYSoYOe3dphieGfsHtQaosdABXgkrFUtMFFWHjH5mYxu+m9/TH+wnuKfw2Oc7Tmi6N45hOqRdjgTOM7MUuQKJhbkxLH8IT/uFRljn7kk19qnUWE3ulXL9YKogEhIsKiUVOJLoURmpNBvl8S1KigFKg4qwaVBsvQzIIOL9PjQRYw7MXrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM3PPF7468F7991.namprd11.prod.outlook.com (2603:10b6:f:fc00::f2d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Tue, 3 Jun
 2025 19:53:24 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8769.031; Tue, 3 Jun 2025
 19:53:24 +0000
Date: Tue, 3 Jun 2025 12:53:21 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Aneesh Kumar K.V <aneesh.kumar@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <lukas@wunner.de>, <suzuki.poulose@arm.com>,
	<sameo@rivosinc.com>, <aik@amd.com>, <jgg@nvidia.com>, <zhiw@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [PATCH v3 03/13] PCI/TSM: Authenticate devices via platform TSM
Message-ID: <683f52b1aa2be_1626e100b1@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-4-dan.j.williams@intel.com>
 <yq5ajz6a3rp4.fsf@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <yq5ajz6a3rp4.fsf@kernel.org>
X-ClientProxiedBy: SJ0PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM3PPF7468F7991:EE_
X-MS-Office365-Filtering-Correlation-Id: 35812913-41f9-4ad0-d701-08dda2d84cbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?93Mid7GuYgNAciltoO8cbGjZ+chKSbUDgTS6zZ4Mjn1SAkJv/voZlxiVWQAJ?=
 =?us-ascii?Q?aVRrjktnYGS+KJGMM3DUwvriEkVnUm6CbVfzwReoah6Pccar3QyuotexQzdz?=
 =?us-ascii?Q?INdXvTYBWb2mahe1XnO7nnk4z10tIvlFZM6HLiF+5Aa6SWoRItaMkzOm8KlK?=
 =?us-ascii?Q?5gD02LCYylhzDyrdzrfBcSVDOaAiuAgOkEL2ttp+7EpCbQ6L1DPuI7o/mcbP?=
 =?us-ascii?Q?kLH8qXnywP1kuikxiBVo1p4WmzdkcwOTdooymszgO1H9rHs2Hl++G6I65GuA?=
 =?us-ascii?Q?8q3iwvC2wrmr86XAY7vnOSM/2GGvSKrjAvEGFRZQ+gR1+gFEi3LyPdhQZeHK?=
 =?us-ascii?Q?iC5acVDLJiDVIi7UL6kd21TEg3fBOEUYOzJGhX5JwUzWaMcToecfh7WMzaVO?=
 =?us-ascii?Q?vKJBRyT7lemmawiF4fWPOr8+qWPiXgiavcEKNIDig/XYCGTy1xVPYJET4yDv?=
 =?us-ascii?Q?GyVZjdQxNls/fExqBtkIQZz2J8jkdAI8HX2c0A9mjA9JPDwyXps6ohZAjRwC?=
 =?us-ascii?Q?g/rrKnUMmNCVBl8yfYDGzi9+kqNUlZhsKvSQzo9O+F2quUUUtQyq5O3omv4P?=
 =?us-ascii?Q?pd93NoL55cwnENaFIs41pSG6X1pw3ofBhy33pS64+GRluankvIt6NBuW1Whh?=
 =?us-ascii?Q?Pi2ze1sPB4cGDULiBRVeUniakgdhaRICPVWxXAwrMc3Q2UqfriDvysWhh3qr?=
 =?us-ascii?Q?2NtvZiaBbbs/tuYuqUBS6hCnu/qMEM/D44VYGyOUAktnGX27DFR+xVS5iKm0?=
 =?us-ascii?Q?GlKoexOC4JJTdPH/f3LHI8E2ZrotXkJANAy4e0T+fZZcT+oSbAjGEMlS9/o0?=
 =?us-ascii?Q?+1QbdAlC1rB3rS2XV+dzMaXTD7RiorqprZc2Nm0xgzEWiAr+tXscTn6Gt5Wk?=
 =?us-ascii?Q?GpMEzhD1lybg+tbGwfgLo4PTtOWlevsfn8XlvuaNRHKs0OzNJArkeScQ6EDe?=
 =?us-ascii?Q?3LJKqwglNJJMgme8jm+ejPbvWwmhIfjzVOhK3l5vA8CrqxuvVlT93I3KyUBm?=
 =?us-ascii?Q?43L4WXTxgcqHsqUwuCDlQst/MWRkR284GZZ2VIVoI38w5xM8jq8M6dzpkZvw?=
 =?us-ascii?Q?0nzN4ZGB57HtiU010fDt2CFJuY5dfX5j+GuTk6fJxYa8b4+EO2gHT2zG8W/r?=
 =?us-ascii?Q?uy3e31+rFr3ubaPDBnMk46MogiiWxSasSJltDhr3t1S8sDFzPM9H81BIFvxi?=
 =?us-ascii?Q?cPFK393Tl2q6eUW9SOZvXJK2xbTUH9L8/LeIWEkHMHJo5zB5KwE34eShUsSt?=
 =?us-ascii?Q?4IEtoqGDZYjlhAdt6o1WexzjymTSrEIunZl9S001lQOncaMlWJu97a5pMZvR?=
 =?us-ascii?Q?lmlJ3Joz7X2QinqgOAynKMUw4WX8j71FCPHxckUGPD2F8HU2EM8kTwTuZSmk?=
 =?us-ascii?Q?OrlxPXQC1yOXC2aepvcz9TscIHGvVpwomodxM8hFbDFSRMF6ZeL/aCU0e6DS?=
 =?us-ascii?Q?P/xEc0TWXJM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NICkjOiSW0Hm7lBLLw7Fcb7kgEP1Cn2MOryWvUlSYUoN7fxtCgvfLmgbQaaP?=
 =?us-ascii?Q?AJPqiKmI7fIWzH/dXqQhdhTIyuhyic3Nwua9GszSbj/VDXZRrl12r3KFEibk?=
 =?us-ascii?Q?yTSZBjUc8+e/AxWn020yBZCQNlaSopagED7+tzvkXRMM78SYJo9ErO5xLVdA?=
 =?us-ascii?Q?UOHasES3W1KMBX84gKkh8DGJ/tD9FeseBtHicrn6oF1AXb0PQiK5ApLg84Mg?=
 =?us-ascii?Q?/+s9yuRYfGzmCNrhy7iB+kt+7LmvAYcl6SWMonsjkfBKju/ITra/NfT7qikZ?=
 =?us-ascii?Q?YLiTgu4EUjymm9crphLeGWrAQFCCr0LrybmhfIGiRtOdwk2tAyRenjnBiHyH?=
 =?us-ascii?Q?/Q/Y076s0TAOp5jZeH32CZC6i6crqnnPv1/xYDZgnS6T3nz2WD9fiYbGTRF7?=
 =?us-ascii?Q?g1e4wrzc2JYHzGZSQPyfQzYzjR+0XR3LLRPHYUffQ7jZybbzE/hj5p3hGVZc?=
 =?us-ascii?Q?TjL0eey8gQmGLKptOyJk0UVDNsEMjmxXeGxKeJw7Xx4YpAKaxQAkQTl4G/RL?=
 =?us-ascii?Q?lsSPT8Klop/ZI+VuAfoPFTOjqsJK4+lJhq0KFAX6dJdvUtrhJFUUsTDUpqPd?=
 =?us-ascii?Q?Yyc6CK/P/K8+u2s84G0BXftJIrGrt+cxl8aWSxNku2mjWfJhLdQs/z66zgzz?=
 =?us-ascii?Q?us5rlIRgdXejcKNiRLZ/NHnAwUdJ+5jonGK2SrSjUUs2vWOKH1omRN6N1C/L?=
 =?us-ascii?Q?oZgeKa6DQHXBu2hAJudpM1yuHEeKmYpGbHDxrzdgk++jjef52dztoJqAaBKZ?=
 =?us-ascii?Q?ZwOji21QvfJmxlnbL8ZGKIfnUKuZyljswB30yRRUJ+CzUfteXK1EnBSlcdB4?=
 =?us-ascii?Q?vOi9ZqCR5JF1UbX7AJ/eWMVk6NpoMDKtmj3rpx0lhbpsdXP6CFjkb7ssNVTg?=
 =?us-ascii?Q?jK62ryDTUfds70YF9OhsZHuvFjv5bo+39dbyCY/+DcRIPWCHowDWhmHCuNLo?=
 =?us-ascii?Q?8/OPn3jRzoiziUjm9PeOySyGHHJj7JniB5v6tw12DsBXCrWJKb22/Nyt8hoY?=
 =?us-ascii?Q?7BAH+J96fEeMDkyvDdwdkBlATUJZX57jyBtIn1Eog+HRcGNsYCNm0k9MDpdt?=
 =?us-ascii?Q?YefEXwxe+/HZxmuOdgW98j6QXgYpjkI9GGdgbyU2UC9UMlqB916nhU4QCzEJ?=
 =?us-ascii?Q?5LI05z/6qG8xen7qd3Zii2AdAVXHju9y6n6EhT4TDto6lO4wB/tXym0scFBp?=
 =?us-ascii?Q?Y4WC6DHbQOrVw/4zAfE/eR490BNhUz3cWPH96/jnTh1Frs2iC0/3dN++t3/m?=
 =?us-ascii?Q?gGujfEXQJQy2x+l7barFJKe/aThUjcwHJNQgmQc9BvqxclqtgPDuHZ/EL0ST?=
 =?us-ascii?Q?5ZNSTotfLQx7CVyL4Dh4YkXjZV3eD1ikZUbDN87R4+gXkGL/xD0fbD82kVla?=
 =?us-ascii?Q?Bl0j8V26gY9l+lBDu0T4VTiJ1thdxGMs/Vz/a2b/JH45x/D2NlaNj9XxUUIi?=
 =?us-ascii?Q?BDxmNNdGO/t+TANeJsQ9rQeqL8dM+EXY6GG5FPsVCzJkHfRIRqnf4N11CI/P?=
 =?us-ascii?Q?jIpSmA9mEvUxau/meQHIO6g4qStQ3j2YpOJq65iN3g25SCmdofAURcUfBPkJ?=
 =?us-ascii?Q?MnpqK8BDPBN9Q+meevs8UJrI4vtuLPVeQqK44toz6PDrQ15sr3Ai/CQnBet4?=
 =?us-ascii?Q?oA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 35812913-41f9-4ad0-d701-08dda2d84cbf
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 19:53:24.2422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Locl1Fj6+7ZrB79afavw1BjN8kvjg8+zl4zE3/3/b7cHGQkbkN6CevcjWSwx5Rl8sDot9JU4uMz5tO1YVhLjbTwShRF5XAaIhJZz0yW+O1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF7468F7991
X-OriginatorOrg: intel.com

Aneesh Kumar K.V wrote:
> Dan Williams <dan.j.williams@intel.com> writes:
> 
> ....
> 
> > +static void pci_tsm_pf0_init(struct pci_dev *pdev)
> > +{
> > +	bool tee_cap;
> > +
> > +	tee_cap = pdev->devcap & PCI_EXP_DEVCAP_TEE;
> > +
> > +	if (!(pdev->ide_cap || tee_cap))
> > +		return;
> >
> 
> If we expect to use pci_tsm_pf0_init and is_pci_tsm_pf0() from the
> guest, can we have the ide_cap and tee_cap check here? Will that be true
> for all devices assigned to the guest?

I do not expect this path to be taken for a guest device. IDE is not
relevant for TDIs in the guest and function0 is not a requirement guest
BDFs. I still need to add this to samples/devsec/, but the expectation
is that in "TVM mode" the presence of PCI_EXP_DEVCAP_TEE is sufficient
to route any PCI function to tsm_ops->probe().

