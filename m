Return-Path: <linux-pci+bounces-13138-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC74C9775E0
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 02:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0DB61C23A49
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 00:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D81A17E;
	Fri, 13 Sep 2024 00:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="agPTTJeh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25ED1173
	for <linux-pci@vger.kernel.org>; Fri, 13 Sep 2024 00:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726185726; cv=fail; b=O1nROvtHnt70BVrSoVfKGaj+I47Tq2Nl0XHG2aONQe3gfkc+zLjDW19UBsBRav/GeptA4PpAstKCwbT69DCujU+82usjNcjAelgcn9U3PUCjFTjRm9NJhVLrbFTD3oRvzeHx7dL9AeTSFFh/LpwjLN9WSI2jn7l2NM/3/PHcCkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726185726; c=relaxed/simple;
	bh=Tky4olmbiVkwqbui/X35c8z74UKXimMKJEF9B6vdVgA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WBt/R35ccWbG/zQYPIITSLvqk8kdmeR7Ap36VVrGbo3EMzWJEQxWr3jPLM3j/C5zMH1TEWwR9LMKQi+cCMaijAIaTOtPwiNrEXSWP6K6Qh5hL3Yy6Y3QPvuTDPyfe8gLGE66EA7hkpVRViQgg7ZvQuvw9o3+lM+7R/Xcsu3oO/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=agPTTJeh; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726185726; x=1757721726;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Tky4olmbiVkwqbui/X35c8z74UKXimMKJEF9B6vdVgA=;
  b=agPTTJeh9TMmevpPaBZ0NnxjhuRRntDyd7HsN945ijctL1vXTRv+LIvV
   rW9IvuRbHIuCdii8LuzNcXRabNUgSnGXIa13viCLu85oG81uQwfVTgHce
   r2nW3Qvgxe/VH+tlnDxVPGT9kbMmaRj/pDY/x+iBrE5KNgZYOJySTn1lK
   7aWujuxPEngl0OGm50cEKadC6rGERjUwRTBNlAVZWCQ9HxvkMRrbEEHX8
   8s5+/hRTQbl+GehrIfe2Dqd6Ub+U0O/vjyGUW3QiLJ6qxAMcKjQsJ33IL
   W3stcuneN1gFwqejqoMWeFXRIRif/jDxTjeAmG0E0VVW7Go5oTijuKoVA
   Q==;
X-CSE-ConnectionGUID: KkrxkwnvRcGbv57Teykb1w==
X-CSE-MsgGUID: IMBMbB0nS8Oi/Nbyu4vxCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="25009972"
X-IronPort-AV: E=Sophos;i="6.10,224,1719903600"; 
   d="scan'208";a="25009972"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 17:02:05 -0700
X-CSE-ConnectionGUID: +2WSjGdiTAGLfp2e3TQDeA==
X-CSE-MsgGUID: 7bBGTdmOTgWVieMi4GgaiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,224,1719903600"; 
   d="scan'208";a="67810704"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2024 17:02:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Sep 2024 17:02:04 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Sep 2024 17:02:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 12 Sep 2024 17:02:03 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Sep 2024 17:02:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xrSpfTXa7U6GFfrijwBnolbg+LGAYbqNaFNNuTcj16CN5BdwRgnBE0ACc973uDiwWJolCsf+FuLgUhXir8in56Ig0vKFxTlJbixsiRZu2flVGKC7RRPlCOKcH+NZojHuZtOBhRWKmVY382LHGxkC/laOcrrHTiZHj3Fh3o3QkYtVvWti6zjP59fc//ylGvPTnGaRwZ7zTxr3x2X9K3SpqJMC4tGfyUN0zD+yV+w8n+h2guNPEzBOv446ST/1plC+nuCMjQgebYKcaZSThY1CLYAAtdgdkyI3Irlt1c/+odz1FvtY2HJ54sWuS5sQgB/TyMksAWPtXoffpKyjrwdSuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=necQC4KEHhmEW5xgHqOwOSTbcEeeVUyNRPAC8L+ZBz0=;
 b=KhuQhd4wJ4XGUXPgTjVDJgQNSMi/tFG/nMmc/3OO5jSVpIBjNNA87XRE2ncVuUY1wAPuWORhuZjV97Vtd7RNOJH4uFKfQMPc3pre8nvZbzfgBkim0gf0JBKDMfHMIUjOxLgsqkMTewQzroVWCp2D5uFmF99z6eoxl+YSkoCdTWFNU2H3m6Qcs8tRhj2ENHmSZs8y7D4n2fgezLamFXxHpEgdYTlztRoLinVNlaSY4YTFd84NWrdp32gyyCqYSZU/BukgEXWi/Ak4fnDJEVS4WvDkY9xlLeRlDXd/OELGlC9WP5UK9SrdA0b8pnmGBu3D27t5rV4ZT0WptkH8Jao9MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7133.namprd11.prod.outlook.com (2603:10b6:930:63::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Fri, 13 Sep
 2024 00:02:00 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%7]) with mapi id 15.20.7939.022; Fri, 13 Sep 2024
 00:02:00 +0000
Date: Thu, 12 Sep 2024 17:01:57 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Nirmal Patel <nirmal.patel@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	<linux-pci@vger.kernel.org>, <paul.m.stillwell.jr@intel.com>
Subject: Re: [PATCH v2] PCI: vmd: Clear PCI_INTERRUPT_LINE for VMD sub-devices
Message-ID: <66e380f5c8a50_3263b294c9@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240820223213.210929-1-nirmal.patel@linux.intel.com>
 <20240822094806.2tg2pe6m75ekuc7g@thinkpad>
 <20240822113010.000059a1@linux.intel.com>
 <20240912143657.sgigcoj2lkedwfu4@thinkpad>
 <66e320bd9c800_3263b29421@dwillia2-xfh.jf.intel.com.notmuch>
 <20240912172534.ma3jc7po3ca2ytlh@thinkpad>
 <66e32e8d5e19a_3263b29452@dwillia2-xfh.jf.intel.com.notmuch>
 <20240912121513.000054b3@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240912121513.000054b3@linux.intel.com>
X-ClientProxiedBy: MW4PR04CA0371.namprd04.prod.outlook.com
 (2603:10b6:303:81::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7133:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dee6eb0-fa60-4fde-0868-08dcd3874a71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FfL+SSI7XNZNcLvYnfEitko8HIaO7VWQLZLPJrJ6pAiQ9IV1T2mcPFjt1529?=
 =?us-ascii?Q?odeVa08Q4xtTZw2CyA8lPa3Zas17Bk6wQm+ZOb4IUbvBrvWBcV14QKtnBaRI?=
 =?us-ascii?Q?mtszxos8dinIkMXlwT1QbF8sM4DieGZ5seKdpANJ9+q5AqM6Qwrx1v4NoYvg?=
 =?us-ascii?Q?RGjW08nTaCLyZUwjrBjSsHP+mBUvg/Gx5r5qOIV0Hd/yOVGo/+FpNq8m3aiF?=
 =?us-ascii?Q?7BpbXu7ocZbwgF8E1UwZxS59j/qyvHc5hKqpYrZ0cczQFobz9tu9CGtoAfTA?=
 =?us-ascii?Q?vBlirNczDz2eRFESJEnb5bdxEuBXoxx4tzi/kCmxj3hIEQUxrlbw1bpYO1Sx?=
 =?us-ascii?Q?gcGjUc2VuW4udXDWoMNPbGggDvnYCqSO1F9Bx7+BnwvLejh2yB1Q2nKpWRYn?=
 =?us-ascii?Q?BJESBJn5CDeqwnhQsu1Oc2psh4RtjW2CTUylIkEY19Pq7F4ehNVF6StwkMgY?=
 =?us-ascii?Q?hxd7i5H0I9XGG5EXwdlpdAnWZCaIxPV2IqaVfWTouqqUX8Tg0i1LGSMmeWxB?=
 =?us-ascii?Q?WrUMQks3mUz9G6ch51tOYybx2wamcM7G264L94jAqYIABDlJcmOnOIi0FjY2?=
 =?us-ascii?Q?WKI5/4uceL89NF78Lj4Rn5nqTgCUyk9udArNUm/Loh6pFhBjiBnC4aXrAldD?=
 =?us-ascii?Q?6n8grZP8YHDH/P/kfbZi7BAnmUCM9cpYFVgfwcvjOR36kdN/aWKCN/YMHRtJ?=
 =?us-ascii?Q?yeCAaiKRUcgNdRtj+1x6yUOvBRiqmaOdhCGnOW53qwCbUDNqj5NQDwsHPOpQ?=
 =?us-ascii?Q?fNneV6a76oj+hZSeBvZuZnRTFqR+i2gIkiUML6g67Fb3QFs/Kw++8Jep45VE?=
 =?us-ascii?Q?wsOD4MPdqUJ1CFhkdntF+RFqi63M9OqyXy6e3Ecwpy9hvoEt6Id6TjG/Dqlt?=
 =?us-ascii?Q?0p28LLFI95zNA21ZtbLvcZ+VyvQWZoFtsD/J56rUb5yI529u57E4jsqQk7mx?=
 =?us-ascii?Q?9FMPsmLZ3xHSSy6jEIH6224r9ixXtuSFCcR9KrMfa/MY+PQo3XJN/WxujojI?=
 =?us-ascii?Q?S4K0WJwFfFbWrJ8SE7xnIoPIYNpgHxT+uqbGK55356PeHQenXJkzL+ARB5k1?=
 =?us-ascii?Q?PcwE8f26SGdzSasoQ0WIXjMqeUlcgFO29xhDRpEuwsch2E7XHld6B5VD2xXX?=
 =?us-ascii?Q?+lFYtuSXYL5puflyuPxkzxjZN00o08YrEPfbkej8Dh8MALINS0s/CgiIYJEn?=
 =?us-ascii?Q?Ysd8c/k3LyEN715N/ctWMKxkQ07yAOVabkiT8g6B/mlFi14I+hYvGNrJF9Eq?=
 =?us-ascii?Q?wdNbGHw3tHIYeR2UZCUBF8slZRK6seHSzGXAR0X9ggax5lJO3IZnO4ELYscq?=
 =?us-ascii?Q?oYIP2T43RVoN4JskbjRzP1XCoz/WTALSZmOeVpag6/rJcQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i2odbZCYQQJqpQT/DNUzOW4YurxgijP4FRGwU/Vn2xRwL8tK2bnRrKj8yx7C?=
 =?us-ascii?Q?JYGzBd5Q+ODIU4NuZaoYGq9UCDfgNwMOU4od98/BKpAuax2HD9rrNnGG8cNt?=
 =?us-ascii?Q?mKQRCgamIgXldzOtOIPOJGGs++VJ5uxEBsA5sD6f9RkCNzaDh8safgvSn+Ie?=
 =?us-ascii?Q?hn/PhEmxh0Hvd3nz5oZkVH5B+mG9tU4c02EOrA8H/SCTqCkpCejGkweNJEtD?=
 =?us-ascii?Q?qZsRjhkgW+WbhypOzBRjQmh2oI/qcxXxdGtbgDEyRriu1r1UJCn/aQ+HhoGN?=
 =?us-ascii?Q?d0nTvACFkZlgFXYIj2WKUpDsbFb+wRuxm8+1X8o7nTObvzcUyKliyhb0LHfh?=
 =?us-ascii?Q?1kNDol0M8GdkSnPt/PIaV66iguV/nRhe7TAsOqRHt+FpIKR/EqePlQr1zVrZ?=
 =?us-ascii?Q?94FzYFSx/kdZVdxzuRS5X1Tlhxuuet6wZzJ/mUarbhNhE2xYd2KWFekjcxTY?=
 =?us-ascii?Q?Ck7mLvwZkEKiIIQU4CG7Zg4b8wm5XBqaSvdWHwphoR4Hbp7RmQL4j+zNanGB?=
 =?us-ascii?Q?NhNV5mreTZ2lbxQ3Q1buxXeKSIZPXCzojJyHQ2ANsws9z45emG/j7I278U3x?=
 =?us-ascii?Q?ajSCdAe/JH9CfPjIlPkzhWRk2lIM7V6j/w9Tjrk2OlpGCH2syDx4KBoWJSgC?=
 =?us-ascii?Q?65sFf9JU0ehdtdL/d6COx3LOlAL8B1xxTL+dHHdG//a3cBr/9NUnPe1c4hHz?=
 =?us-ascii?Q?PD5wOeOFK6X9QDwiVK0g5OIOtrbf2QpnvBdk4uZFW8xCfDVJEGAyDi3kNcRH?=
 =?us-ascii?Q?0MivGohVCz2hU8b+74cKpK8uVz9LssyDxPBDFI9a3Kpl0VcwC2iCkn/9Yv0n?=
 =?us-ascii?Q?/gfeXwc48dlOC8j3OWlkOooKrPjtw4iiEhOINIW66m8g44i4g8uhhiCRsLhs?=
 =?us-ascii?Q?PH+5g26roKSfY4qkW2DO+CD29GgqNUR1Ajb8xPYPCNffIstgRBnfhHgWfqTc?=
 =?us-ascii?Q?hy33bpzUHc4EHEphaU0X3sD6+0MH5Lle92YbjFIdz5Mt+R5XiswrAZvXGny1?=
 =?us-ascii?Q?0Z5TjbZ9Oif6J7c+qgZICKGDbM61j78Ii7uHltcwoKQUDPe7j7Bfss+NhDZc?=
 =?us-ascii?Q?ZbipHKNameVETJX6n85EYMRlhmoST6XWHKXB4FAhbacjPmKgObLTT0d+qAHN?=
 =?us-ascii?Q?xtP0NKTnCV2qp7rXu4nexXAt0PmVRauGjWjubTz9EXHtAesCNyxsvW4dp7tO?=
 =?us-ascii?Q?GkHqDYrTfbVc6Yy/7WHrhOCSIjNSVsPljQ0I9vWNhZI3I5J+syzjrNceDLJD?=
 =?us-ascii?Q?OAudaQsrSl1VLgChFlE44WxQ2EGD8Fg5uEm+/rm8vqlAklFMDltJ6ZfIjhqY?=
 =?us-ascii?Q?tbJoJo+XA7B83U0s/25tUT+kAMZNEq5WSd9MasMpFiwhFzNtqg2wKmqJciVx?=
 =?us-ascii?Q?yCWWffE1vFaaywAW6iY9LrQS9FGhjsmbDGfF9gHFVDjY7Be0w/BE3bTWr+oA?=
 =?us-ascii?Q?zlxaJ0C6zprScnD6YiVI7dIhs+BfxUwS/zG1/xBUwz2h/uSKKmF611z5lXrK?=
 =?us-ascii?Q?cLj3+iV4Hwh6UeiPVars8ESbi61khrCnNCRpKFSsHsoceVUlNlSZKP3l8ivR?=
 =?us-ascii?Q?IyF9phkvCLD997wyK5mj44mMWZ7yvlyzHRSHskIwO592NucFbmlV9TPKsc2d?=
 =?us-ascii?Q?lg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dee6eb0-fa60-4fde-0868-08dcd3874a71
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 00:02:00.4591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bLN4Xv2+QBdulLrkWKV+RnsJ93WY6XdPtqSmXwDJKAepkodsC5qms0T2JE0fhR6gm9dR0kG69QZ/Ea3qKsJQd5ni2WaNB+hwsy8jlQTMLns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7133
X-OriginatorOrg: intel.com

Nirmal Patel wrote:
> On Thu, 12 Sep 2024 11:10:21 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Manivannan Sadhasivam wrote:
> > [..]
> > > I don't think the issue should be constrained to VMD only. Based on
> > > my conversation with Nirmal [1], I understood that it is SPDK that
> > > makes wrong assumption if the device's PCI_INTERRUPT_LINE is
> > > non-zero (and I assumed that other application could do the same).  
> > 
> > I am skeptical one can find an example of an application that gets
> > similarly confused. SPDK is not a typical consumer of PCI device
> > information.
> > 
> > > In that case, how it can be classified as the "idiosyncracy" of
> > > VMD?  
> > 
> > If VMD were a typical PCIe switch, firmware would have already fixed
> > up these values. In fact this problem could likely also be fixed in
> > platform firmware, but the history of VMD is to leak workaround after
> > workaround into the kernel.
> 
> This is not VMD leaking workaround in kernel, rather the patch is
> trying to keep fix limited to VMD driver.

Oh, ok, I see that now, however...

> I tried over 10 different NVMes and only 1 vendor has
> PCI_INTERRUPT_LINE register set to 0xFF.  The platform firmware
> doesn't change that with or without VMD.

...SPDK is still asserting that it wants to be the NVME host driver in
userspace. As part of that it gets to keep all the pieces and must
realize that a device that has MSI/-X enabled is not using INTx
regardless of that register value.

Do not force the kernel to abide by SPDK expectations when the PCI core
/ Linux-NVME driver contract does not need the PCI_INTERRUPT_LINE
cleared. If SPDK is taking over NVME, it gets to take over *all* of it.

