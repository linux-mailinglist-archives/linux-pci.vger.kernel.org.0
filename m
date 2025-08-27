Return-Path: <linux-pci+bounces-34854-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 957A5B378DD
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 05:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51EC57C1AE6
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 03:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE8C30DEDD;
	Wed, 27 Aug 2025 03:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bOdRLso+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6535430DD1A
	for <linux-pci@vger.kernel.org>; Wed, 27 Aug 2025 03:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756266703; cv=fail; b=nDX0rIEaPtwM6n+MMsbuvAhBEpKbz47lWep32WHtsWPo1OFTWG0TcL3CyC6X7htOAVpCohIkQTicVVyvHF1T8auPTyhPmjuC3xmAn5qKhxiEDmLN3kzF1wTW0Ez0t7+BgaANTpjku3XGoB95xgfqNfC9dzco5T9WsFJgr2sNcHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756266703; c=relaxed/simple;
	bh=nB/CeV2g7e3R46E2yR4WiJH+6IiLwqGneag7/cb8p9c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VR8/AGZ4yjAR5DkLu0e/QIH3iqafg7F8A6DghYVDHKHUbuwXT9Qp3janvHC88PTbfDtyjGw/v+Ve9LBdL6aoDNIpmxu0Yaj/toPW9Hc4gMMI9NO/hv+DBbkoyB4YzAQsQh4sPVbqEykb3N2xf+n3UJ+/AVeSBI5OChdecnSZAo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bOdRLso+; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756266701; x=1787802701;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=nB/CeV2g7e3R46E2yR4WiJH+6IiLwqGneag7/cb8p9c=;
  b=bOdRLso+HqIWpNo4mvYV5+eA9Q83YS9j6tMp+kFz2T0V8kx9CQb9D2X9
   QDObQWRFxtvWKtH4nmrsBtAycSFmOVAtvtQzmlFyBq4WF+iZEgNUg7IU1
   U2b7WPco1RQKpBnliK1dLoPhsqihFHfCZAhyRuIZO9KbFZdbIDl1yHG3E
   R+X9FLzHmbpieSzoGcQffFNFiAM/IfSPqK93AFtJFrzx0WZbr3hSJBXjz
   d9pdhCaWp4i8m9MdNNtzjsHDXW8TqY/wHLW6pIeh4etPbCaHor4eEdSEH
   PCPyZQ/gvubuTSxd8gn1dIAx/Jo5z34O1UfVgE0gozbH/UU2I/e05HRX9
   A==;
X-CSE-ConnectionGUID: lWMzo2qUQS2XPH0TSzAovg==
X-CSE-MsgGUID: E0rS2wdUTY+i9djyMZxx8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="62159167"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="62159167"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 20:51:41 -0700
X-CSE-ConnectionGUID: hzMW0iYvSWeguT0g6wLuZg==
X-CSE-MsgGUID: kqwec5AFTA+y+ptFFhd1Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="169685139"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 20:51:41 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 20:51:40 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 26 Aug 2025 20:51:40 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.46)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 20:51:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cEgfzFIyHSMmUHl4ILc/cVqgYn54OrMkPkxxVkwQrRpcw+Ke1qGTj9/MmnzLA8uypog2MS57yZ9TT0ETpDvo2A5tAuf8OPEMheRT3bXuCbnxLgt4qlBeJjElJPH3UAx/qiklE8ZWj2EH3F0s5O+CypAYcmKm0eAlQW3ZiT6G1aXO4YA3oJH17vn4+owAhGmSpfVJDMlpdzfReUySkHvObRMnQNbRXEQaHtzTLPt83RKodsHwmYF205fMboxsBJB/gCL9KuTcHE1ON8vc17IfXlfY+LyUz91E4sahSUzhWTUdlKkTcrHT6y64Uo/hiB7KntzskfBQhcxZBbLu6q6uKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJ2F9VbYfkthqEFymX4kYTD6HNrIFpvQXy87gT26PqI=;
 b=RyAC78qne0qdn7nAIR+3ZNbYDNdUVsZdK7nEqSsa2ozlo0VX+q7jdjFPdUOA8Rk6BVyytfQ8KZWy5qkmZ8FI/rEhdUiWGleHGbq4N1qCjb0OiE/2TT8d4/97auZO0o1bn6GKZv5r9a8ypE6QTUABfx+L60Wou4S++nrAiS2Zs29H04ajGWxsOccvBCUclaxEiFbd9jUzmO/m7fJ1U+1UUHWCdONbAkfTXa9b3RL/xwwPHHm91iEXoVcGOnXm1a3YDipqDcXK+D0lrtLKcVu3OxCCAqldNeaPCWP+Z4nsWae6Luja3333sFYPvTrimF22eg0o+ZpvSofxVXuyCp+MjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB8335.namprd11.prod.outlook.com (2603:10b6:208:493::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 03:51:37 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 03:51:36 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>, <aik@amd.com>,
	<gregkh@linuxfoundation.org>, Bjorn Helgaas <bhelgaas@google.com>, "Lukas
 Wunner" <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Jonathan
 Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v5 08/10] PCI/IDE: Report available IDE streams
Date: Tue, 26 Aug 2025 20:51:24 -0700
Message-ID: <20250827035126.1356683-9-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250827035126.1356683-1-dan.j.williams@intel.com>
References: <20250827035126.1356683-1-dan.j.williams@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0038.namprd16.prod.outlook.com
 (2603:10b6:907:1::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB8335:EE_
X-MS-Office365-Filtering-Correlation-Id: ee750abf-91b1-4aae-ae98-08dde51d0528
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OQ3EbdQXljVnLIJ3blxo0XNpq7ZwUD+4q7JZegu92WoCetwJ4ujFyl4RbGhR?=
 =?us-ascii?Q?I4YRgRyKRTGH887+KsH1zWmNhOM6rSnNIQCWXNFbkN7W2rRAruPb19phpy7/?=
 =?us-ascii?Q?ZM1msCBzoQHBI8ezM+dvXmqQIgJPNRtZotXxQ4uZAGqzgRpQSANDO4vdDKGw?=
 =?us-ascii?Q?9wTOYeVsuEouHYArQ50rbiyXSCk3iEJRDZOGZ8xms0aPTR3eBT8XaJwLL263?=
 =?us-ascii?Q?LdveIsxc1UL8TSHuOtlQETwCxK78odEIWLtW7W5w9SThcB5ZCkGinQApycGd?=
 =?us-ascii?Q?OqT9yWCA1W4b93EXkyn30jgxdsNY5ATjgqsydDWytIywepshs7yjHghMZGha?=
 =?us-ascii?Q?ErCm0s3ACKxTCRzC1TCBA1SFOxkNrQXQTta9fgHfwNrZHAvfqMfrN1nhR3fN?=
 =?us-ascii?Q?ptLxNfz1JPw0LFGFlG4jF05yWRE+6pFYakR69qbp4O2zyhfcdLZyXsQ2Gobi?=
 =?us-ascii?Q?Y18bI0hXe8nyg+2RF2oBX2B/OggezqVUZUAs7Vb2QDEu4QJcxYsfDEgr1Dar?=
 =?us-ascii?Q?c50eSmK+eXsbpGUUmHZpsVqKfljCWrE436N5CESRxPqTF4bUtHvYhNvYHSgF?=
 =?us-ascii?Q?dYow6ScPupamWG0ThuBBoo8hYvQ95/2sNqto98j34XMp2wt30P/ndR1gea4l?=
 =?us-ascii?Q?RrIbR7HAwEYPQuyavOn62VCBiWLshV1Vbtq48irMVkeHtu2YdLZsWZOZ8/xi?=
 =?us-ascii?Q?yIgW6YLo+XyPcvnKjoYvW+0+Zz7pmHzfnDTuB23p63ewfBEEiNjlB2QtiI7l?=
 =?us-ascii?Q?ADdW0tmK1Gh2PlBny8d+L3HU6wgzd42vaC8qK88nwlQQsgc5QQKkI8zKpi5N?=
 =?us-ascii?Q?4UGpqZynkFeSXn6VXRnjMVj91wvLYTPPRdM5pUakDQF08D+mrHmGzv7hxBpo?=
 =?us-ascii?Q?gKzrxBCT+O1bsf3roRRC6y0YDJbq52sVsxpnjkLFjQIDM9Ol0W3iV/EGwrY7?=
 =?us-ascii?Q?dRrbJ+jUQThVEBkNEUGrxUB9Q79uK67zSma7eYkzKYFZN3F8v56HCP/Hl8WM?=
 =?us-ascii?Q?OZWiRglvBAugwPdjXsg2dIgPcDJQ4mEMzwzZ/ixbvAnwObgOjEeuI9PDy33B?=
 =?us-ascii?Q?oP121Ivj+Wt6awGHsbfoBQOHvNrHYr3JJ7rRXH5qUDVdcOz9XecCaqvGQEz+?=
 =?us-ascii?Q?FLZMZIFmIKFxqpZ+2222OYgJASIF6Z6/ArBAhdnvQkNuwmvWEkchnV4EacW5?=
 =?us-ascii?Q?1jNA6Ov6E+kIy93a1W49Ei7AN2BCheQ6eeVejuRM7IoJIhfKFiJ7AfQC9k1y?=
 =?us-ascii?Q?rplj682AEq2Ax3ikjneBB+mTt0SWKvAIjDfZW7Jo5JMhRxMrersjJBn/vJUe?=
 =?us-ascii?Q?bwoME1kG1q6PqFZgbGxDMvmkXYCLtIXIyqtp7E9vWb8eb7jpzefQVglu+D8Y?=
 =?us-ascii?Q?qINbpwwSRY/ars+RIiekpoktki1FWoRlx+v5Jc765dBI23oS9HA6MbtWUx+u?=
 =?us-ascii?Q?itKcNApRPt8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FAncLOvsS2Oc2BtXgI5xcIW6xCpforSzuEBcDmGTC26sxsrVwYuav/js996a?=
 =?us-ascii?Q?fnrAcrXqSmpmZQoafdnAnGOfOTe60Td8a+CjXTO44A5Nr7AYV/6olQE8m7LY?=
 =?us-ascii?Q?HXT2r9qcklZk3bcqGc2UKxH3++oiMY9CPEnzc4CrX9naj6M09G0yvhCURcqu?=
 =?us-ascii?Q?73weREdjivKqQHWr+CgK+JxLMXvOlDaV5/z6Y3gDKqhOcJb7vNtKv1K9S4u5?=
 =?us-ascii?Q?nEdzaDADveQcKyIfHWJmRnDqVnWzPAVOYumr12IQLAuxQjFfKKexDzEiVjSE?=
 =?us-ascii?Q?bNj6DNCBJotSvcW1w0Ifva5OfCcat3fz4tAjhJb++EJ0ftnVbRqXJAAtSt9c?=
 =?us-ascii?Q?gApulz03OG+FWTQLsGXSljqXITDNDbFr/TkGNRrzIhcDlX67nUCeNfwakYBe?=
 =?us-ascii?Q?0VBsCoxqAaS7+oKWnIbMHxx4gHOa/gD3vb6cuqW6HhAuijs2Q/0WbneMkF9l?=
 =?us-ascii?Q?mJFp4NEn+c9tYVZ5djyq1QPcPs4PHcHvwQA+5ad1MBuRUZNpyCdph3WzOgt4?=
 =?us-ascii?Q?x+ay6+c+IeibhGR2BqAcqxKe7LP2rqPmhLYYAuVyx0RW9EeLH/77g3zploNU?=
 =?us-ascii?Q?LFfSoVjrkD4fV6v25qnmVLj8q5C4o100v4OmPZdO1gCPG+RXOB0UB6U9twEv?=
 =?us-ascii?Q?pjfFejZ6vbi45fkjrsx4Cl4RTBBFTNwiG6rg0JTCN9JGQ8fniLkv6Kqyg/5S?=
 =?us-ascii?Q?VTBsqhuMBGgnkYGzq2PRcDTE02zTxXuzgKfTHh+bVc3y+1kAb97F/VxLLEQK?=
 =?us-ascii?Q?pAg5So7O8KZWMBYvpZuxt79J5erwQI8vMYvaW3P8AwB5wNsx+M5O7RaZQCJX?=
 =?us-ascii?Q?IHG3MUtm3FpqaHKHFpNF8YCoOfskdYMRlBNo2pVcgZ5Ni4BcaT+lQKMnvb4O?=
 =?us-ascii?Q?wlzr4blYq+q3bJv2MAKSC/aq6c2VU3jN5yE7HORjsou8m9fCh8tlj2nVBchX?=
 =?us-ascii?Q?s5qwWyBvcOAsuX+hmtnAyrhUl9SVYNS1xZj7dYu4ox96X0W8mESUXEf4hVzn?=
 =?us-ascii?Q?kBfXsxaKpD6bsfD9by0UwbPbV7SZNKahtbmOaEUY1/ZYKaspDgKH5FHwHQSK?=
 =?us-ascii?Q?eBY11oZPdYlNEqv5DGY8YlnGmeslcXHPWI96D9hkxzyoRr9vnLpdBhrnIHbx?=
 =?us-ascii?Q?v5tH60Fdob1mig8SGePYPfVUt7g7WERg0kQ4zpr6yhHPLBSpSz4ATDg7cp3Q?=
 =?us-ascii?Q?1VWbPJknHAh4ESl5Xt2twdsGQINRs2jzCS35QvpoW47srXPvpcpWJ2nKkJLW?=
 =?us-ascii?Q?lrqTQ6db6TE6JlzN92mGB2VA8u7PlmNDMQ+iuI1VvilfzIWdRyUXRYmy+lEC?=
 =?us-ascii?Q?wUMdNXSBO4KMJLDR6cZOgOMf+ftycUIWhf5NTttwI8Y2Y86H6QGzsaV8lFQp?=
 =?us-ascii?Q?19A03/67dGlSET8Oiou3JKlAt8fYlL77m5o1+lSBUWsSFlNEIABrqmll9pxw?=
 =?us-ascii?Q?vE3+MyVUBeM2EVjTUiXPkrcft8LEfxp3yYY1+3VGUV8dRBtpfc1H2U1W0/R5?=
 =?us-ascii?Q?qEhNYUf6lygj0YjAifHZaSnRVKNBRsUBhU+PhykTypOblV1NZSvRq4mBO4Ly?=
 =?us-ascii?Q?WLaus8TxJXAO2+0930Zs21GJrhS3tPmoN3GqkaRVjtjqBjrUn7Ls4fKJ2O7c?=
 =?us-ascii?Q?5Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ee750abf-91b1-4aae-ae98-08dde51d0528
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 03:51:36.1550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /XoiHKYnVFby9L2SLKAa9kXLk1QvZlMTqGAw9UVnsJXa2e6rsMJin9X746Minxtr/a018FLywPS1Xv6kmU7Pk60LxxJMVocULU9zQUseu50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8335
X-OriginatorOrg: intel.com

The limited number of link-encryption (IDE) streams that a given set of
host bridges supports is a platform specific detail. Provide
pci_ide_init_nr_streams() as a generic facility for either platform TSM
drivers, or PCI core native IDE, to report the number available streams.
After invoking pci_ide_init_nr_streams() an "available_secure_streams"
attribute appears in PCI host bridge sysfs to convey that count.

Introduce a device-type, @pci_host_bridge_type, now that both a release
method and sysfs attribute groups are being specified for all 'struct
pci_host_bridge' instances.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Samuel Ortiz <sameo@rivosinc.com>
Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 .../ABI/testing/sysfs-devices-pci-host-bridge | 12 ++++
 drivers/pci/ide.c                             | 59 +++++++++++++++++++
 drivers/pci/pci.h                             |  3 +
 drivers/pci/probe.c                           | 12 +++-
 include/linux/pci.h                           |  8 +++
 5 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
index 2c66e5bb2bf8..b91ec3450811 100644
--- a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
+++ b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
@@ -31,3 +31,15 @@ Description:
 		platform specific pool of stream resources shared by the Root
 		Ports in a host bridge. See /sys/devices/pciDDDD:BB entry for
 		details about the DDDD:BB format.
+
+What:		pciDDDD:BB/available_secure_streams
+Contact:	linux-pci@vger.kernel.org
+Description:
+		(RO) When a host bridge has Root Ports that support PCIe IDE
+		(link encryption and integrity protection) there may be a
+		limited number of Selective IDE Streams that can be used for
+		establishing new end-to-end secure links. This attribute
+		decrements upon secure link setup, and increments upon secure
+		link teardown. The in-use stream count is determined by counting
+		stream symlinks. See /sys/devices/pciDDDD:BB entry for details
+		about the DDDD:BB format.
diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
index 4f5aa42e05ef..7383ee542972 100644
--- a/drivers/pci/ide.c
+++ b/drivers/pci/ide.c
@@ -517,3 +517,62 @@ void pci_ide_stream_disable(struct pci_dev *pdev, struct pci_ide *ide)
 	settings->enable = 0;
 }
 EXPORT_SYMBOL_GPL(pci_ide_stream_disable);
+
+static ssize_t available_secure_streams_show(struct device *dev,
+					     struct device_attribute *attr,
+					     char *buf)
+{
+	struct pci_host_bridge *hb = to_pci_host_bridge(dev);
+	int avail;
+
+	if (!hb->nr_ide_streams)
+		return -ENXIO;
+
+	avail = hb->nr_ide_streams -
+		bitmap_weight(hb->ide_stream_map, hb->nr_ide_streams);
+	return sysfs_emit(buf, "%d\n", avail);
+}
+static DEVICE_ATTR_RO(available_secure_streams);
+
+static struct attribute *pci_ide_attrs[] = {
+	&dev_attr_available_secure_streams.attr,
+	NULL
+};
+
+static umode_t pci_ide_attr_visible(struct kobject *kobj, struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct pci_host_bridge *hb = to_pci_host_bridge(dev);
+
+	if (a == &dev_attr_available_secure_streams.attr)
+		if (!hb->nr_ide_streams)
+			return 0;
+
+	return a->mode;
+}
+
+struct attribute_group pci_ide_attr_group = {
+	.attrs = pci_ide_attrs,
+	.is_visible = pci_ide_attr_visible,
+};
+
+/**
+ * pci_ide_init_nr_streams() - sets size of the pool of IDE Stream resources
+ * @hb: host bridge boundary for the stream pool
+ * @nr: number of streams
+ *
+ * Platform PCI init and/or expert test module use only. Enable IDE
+ * Stream establishment by setting the number of stream resources
+ * available at the host bridge. Platform init code must set this before
+ * the first pci_ide_stream_alloc() call.
+ *
+ * The "PCI_IDE" symbol namespace is required because this is typically
+ * a detail that is settled in early PCI init. I.e. this export is not
+ * for endpoint drivers.
+ */
+void pci_ide_init_nr_streams(struct pci_host_bridge *hb, u8 nr)
+{
+	hb->nr_ide_streams = nr;
+	sysfs_update_group(&hb->dev.kobj, &pci_ide_attr_group);
+}
+EXPORT_SYMBOL_NS_GPL(pci_ide_init_nr_streams, "PCI_IDE");
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 0e24262aa4ba..22e0256a10ba 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -521,8 +521,11 @@ static inline void pci_doe_sysfs_teardown(struct pci_dev *pdev) { }
 
 #ifdef CONFIG_PCI_IDE
 void pci_ide_init(struct pci_dev *dev);
+extern struct attribute_group pci_ide_attr_group;
+#define PCI_IDE_ATTR_GROUP (&pci_ide_attr_group)
 #else
 static inline void pci_ide_init(struct pci_dev *dev) { }
+#define PCI_IDE_ATTR_GROUP NULL
 #endif
 
 #ifdef CONFIG_PCI_TSM
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 6e308199001c..cc77020aa021 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -640,6 +640,16 @@ static void pci_release_host_bridge_dev(struct device *dev)
 	kfree(bridge);
 }
 
+static const struct attribute_group *pci_host_bridge_groups[] = {
+	PCI_IDE_ATTR_GROUP,
+	NULL
+};
+
+static const struct device_type pci_host_bridge_type = {
+	.groups = pci_host_bridge_groups,
+	.release = pci_release_host_bridge_dev,
+};
+
 static void pci_init_host_bridge(struct pci_host_bridge *bridge)
 {
 	INIT_LIST_HEAD(&bridge->windows);
@@ -659,6 +669,7 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
 	bridge->native_dpc = 1;
 	bridge->domain_nr = PCI_DOMAIN_NR_NOT_SET;
 	bridge->native_cxl_error = 1;
+	bridge->dev.type = &pci_host_bridge_type;
 
 	device_initialize(&bridge->dev);
 }
@@ -672,7 +683,6 @@ struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
 		return NULL;
 
 	pci_init_host_bridge(bridge);
-	bridge->dev.release = pci_release_host_bridge_dev;
 
 	return bridge;
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 45360ba87538..3a71f30211a5 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -670,6 +670,14 @@ void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
 				 void (*release_fn)(struct pci_host_bridge *),
 				 void *release_data);
 
+#ifdef CONFIG_PCI_IDE
+void pci_ide_init_nr_streams(struct pci_host_bridge *hb, u8 nr);
+#else
+static inline void pci_ide_init_nr_streams(struct pci_host_bridge *hb, u8 nr)
+{
+}
+#endif
+
 int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge);
 
 #define PCI_REGION_FLAG_MASK	0x0fU	/* These bits of resource flags tell us the PCI region flags */
-- 
2.50.1


