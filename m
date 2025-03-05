Return-Path: <linux-pci+bounces-23015-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 538E9A50CA6
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 21:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D8F61882351
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 20:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF15B18E362;
	Wed,  5 Mar 2025 20:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UYDjrKa/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A7A1EA7F7;
	Wed,  5 Mar 2025 20:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741207132; cv=fail; b=BqZ3U4+QcKP3/feTkfBfd5Xy6NZvzo/eUokTOew1kJmoR65kHFXtRzV/9vDtRfi1Ct0M7VyhMciDaT6VPiN0E/Sdy6BM/qICxomgTdMXqBdCqjsU8xizzh4elNeP/Io4jl52uI+kFAery+t6ATPCR/ufD1Ir1XEEUqogLFXYtpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741207132; c=relaxed/simple;
	bh=KliB2jFVQqjCHaLDA2xglEQ5stIGNSkR5RHQkSgzYgk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LunjeptlbOAS7Q/UAHhpVd8MqdTc6rCH2cniQgUnFOqeTTYVAqCLLWiAK7EoF1OCwoxvgHV+l6o+G4ibzATZuid6COv63rcywj/9xFS3dEdzl4U9+bjI6oMAxxvSO2O0OQrZeNhf4E7/+j7vshv4vOsOgS8QU2Xn2MD+AURAWx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UYDjrKa/; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741207131; x=1772743131;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=KliB2jFVQqjCHaLDA2xglEQ5stIGNSkR5RHQkSgzYgk=;
  b=UYDjrKa/hcNvkn2MnCJFIjbzC3IKt8PPV0zgiN4P7mnqftW4oXQCBxa5
   rQiz6hebj1j0W0o8iczszQR8KfFVfJstyiV7SuHbGujkDColN5HR1+YYp
   8gpPcQ+GNvUKYL6eBR7OQsDJvljj1V/V97tCgpDqKAxq7EYwAF0HKfSML
   QNvHRhWfC5l4CkyZpfl70/KJzwpk9x/pi6nxEqVIsTApS+/Tgw0Q6B+8b
   VKlu/9pEq9sS382i0u3LBDJ1rMZOgVyssyTbaU/ZPELaJg9uZxIUNXFa8
   DTuIyn27bwdLgVX+U7b286mWqIb9YWVy23j7l8Se5xxmRYGXAIFv+WPDL
   g==;
X-CSE-ConnectionGUID: 3781E5YDQDWnqz7QW7PRCQ==
X-CSE-MsgGUID: b56nNDQ5RJmDHCrUpv2Zfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="59738793"
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="59738793"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 12:38:50 -0800
X-CSE-ConnectionGUID: CrH2QsmkT9+jlvnKIwVd2w==
X-CSE-MsgGUID: jfkQZMn5SmmTXz7QHTH87Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="118812093"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Mar 2025 12:38:50 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 5 Mar 2025 12:38:49 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 5 Mar 2025 12:38:49 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Mar 2025 12:38:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=erpgMafR6jRzO7ZAia5uzMTNW85BXPnZHkSGTWV1zjlStSmH3HAGuN5RMOyzwUZPs9Ar2KJ2/wlnhtwoRRDQlwShAO+NSiYsTHer2/ekP74M6XrRMmBENmxM5JG4Nq/rthrpr3KIKNEqNM5T1yxZtJf76VB++J3Oxqi5HdbsBs91+9O3xoB/h4nNEx6Hag8mB+Rz0bb+jxRVE43k3dtG1GYIVsaAboaajJ1EIpJnWBwDKu7/pxKqWEtMIbgnhcSHp68i2kIf/Sk3e3KnPDmAptn4agFCfyuRvf/hbTrdRT0R/ewTl5vuhTNVmThcim/BmqecocgrbYAmkpKku1CKfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=myrzDl8838FWgxUD3mbrtPND53oTJFYXFrm/GovBnCM=;
 b=zVcW6aMSNORnjgkaqbemkj1IF6UVTZmE0hrT7LcZ7C+xbLxCweCG5VJqQCd/AZxBrFNl+gZ8Y3haUE0UwUljga+4TgfuUgYwpqQuuB9Q7KQ2MjivV29YL4Wi0w4wDqt6Fl0Hn76E9gQ1+OTqCD9EAaD5TQXKWXMPye5O9NXyXphe2R5WqE1Oy0S1lXnSbC5OOYu1WFJLmiiyFqoDNE9GyN4pyAEPLpknCBp9ZICYpLy7Xj6bnFDBJ32WXvQ0JtcMnt6Hgx5kAm+catR4j+cDzcEj7MOLz4dIWzD9ME/NTVbO7VInnv3WTK1oSkx66UH26TKS0dx+dXfkFZpEp6vlmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB6694.namprd11.prod.outlook.com (2603:10b6:a03:44d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 20:38:47 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8489.028; Wed, 5 Mar 2025
 20:38:47 +0000
Date: Wed, 5 Mar 2025 12:38:44 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Ilpo =?iso-8859-1?Q?J=E4rvinen?=
	<ilpo.jarvinen@linux.intel.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH 1/1] PCI: Add Extended Tag + MRRS quirk for Xeon 6
Message-ID: <67c8b654bcd79_24b6429457@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250304135108.2599-1-ilpo.jarvinen@linux.intel.com>
 <20250304211428.GA258044@bhelgaas>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250304211428.GA258044@bhelgaas>
X-ClientProxiedBy: MW4PR03CA0064.namprd03.prod.outlook.com
 (2603:10b6:303:b6::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB6694:EE_
X-MS-Office365-Filtering-Correlation-Id: a450566b-aafc-426d-d804-08dd5c25ba81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?LWZ1VyQQkPR8K+7XxxcCDGTFw+6/kiCejI3ubobPXaonFAhx1ioZfa3XFU?=
 =?iso-8859-1?Q?HW4CVBP5uU031tiNZQx7EJdRUWVLGWlpmWbbongvK7nE2Pi1ZiGqiuhgAb?=
 =?iso-8859-1?Q?nhA2jAy3gQOz1kZQDetWHO06OdUWA5g6OGolru3SSa4k91cusGvKGmTg15?=
 =?iso-8859-1?Q?NsUw9yYPZxnG3qfXRHz2zSO0U2+tkF5kVPLyh4bPZAE389+QnuFYg2Wp11?=
 =?iso-8859-1?Q?SBYyJwziDT62HNVxhcLt+tzr9ZD/ILpfmCoU/vTu4W5wSypLMXlaefs2mY?=
 =?iso-8859-1?Q?Dsk9uYhey9YkCmm65c4L9x2rrtGDM18cVd5mfvhaCQUC3g25kJ/Q0O5L8U?=
 =?iso-8859-1?Q?wJ/yIfr3LIryhbmVz4cVi9DtNYIwg5gcFibqbosuHLJCKfDWMjF8d1BvJx?=
 =?iso-8859-1?Q?MV4+dbeXszxVRjWfCVpEvCtu+QCTGb1DmA3ZCB0IMoG1HEPnEML9MlkM6T?=
 =?iso-8859-1?Q?oauv+QFQcVrCZg8CKa2TynF5JJKQFj8s1aljlCus7nSF9RqlaO25mnwhru?=
 =?iso-8859-1?Q?5AQ0ftUOhkSdnmmY+phDu8lCU+MIjcE6n+y6QaVYHx04iJXZTyTT4ZqHin?=
 =?iso-8859-1?Q?jsxrcqQTXERe2IP1AKSn1wyABYzHkFF/s7xtzO8q+LdtnnBdHPvesiFKxB?=
 =?iso-8859-1?Q?kpPKiqCi064kjtVnartJXGrT6kzjcNRl3KvF65KL5gSOQCLO1rKjNk6cco?=
 =?iso-8859-1?Q?HPfq4spMgi6SD3R+7KfTezdhwH8U/07nqDKJ6zFjwLfg/41M1QTcU0p4Rk?=
 =?iso-8859-1?Q?RiDWOaBm2GPjIUM/7bwnL4a8qa9LS90G2io6ExPTQt6ZQ/cVducWeVuzTr?=
 =?iso-8859-1?Q?V9BHtP2RWtwpbBInW42cbJr9Z/PwFbu6ePH7Hl4LJJMMuXnq6EKdaFgK8S?=
 =?iso-8859-1?Q?IPlfNjT2A5tBE2ZOqqw18ad8Xte7gvFuZpve8Kuotp1JqeBA03BqVV9edr?=
 =?iso-8859-1?Q?qz3usHbxk0oi1mPC3AVEYEFVX1GUWuhfwQEfoI315U/sgYHx1NAkxw6A+0?=
 =?iso-8859-1?Q?ioI+hXo4lBWTGai9irGO4ZB++7ioCU5b11zepK/wW5In4QleiDnGiiHEcg?=
 =?iso-8859-1?Q?zytX/UHov1n52jpjbo07KYA9d+prUfq8VFu8fjHl2WrVbTTkPVaAQtqaU6?=
 =?iso-8859-1?Q?+m3FOBE+a+u4EiGNgqc2gPRx4Iz8vMewGA9enTrdfXbxhztycMShhxmjiv?=
 =?iso-8859-1?Q?R6g7cfhiD/dKQfFIreYUJ0l6pU0GQXNzxlf2RVgEWpqkU2D5w3ON5vvyHe?=
 =?iso-8859-1?Q?kjx69zMF72REd/Nxgaq7CE7ZWCO72UldiLlWRoPfcCEG3tjuB0x857q9Qg?=
 =?iso-8859-1?Q?eKQclOR/pQ7RSE0VNOnfRus4i/5swVtYA60amAfwCBlloS8X4smCbSX5e3?=
 =?iso-8859-1?Q?/KBmPwLxQ8OjEhb/oGdSEI3qlN8LEaFA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?hcI1H5LtcDZx4NsQd6VQG5q0TwXosgZjaHX7rgT9tL+cG/it9YfztGZAwv?=
 =?iso-8859-1?Q?QgdwgAPQ5QgEBZFRVd/OP/DAW6X5mM/poPIMjxgybzkh2GVtAJUy/nId+9?=
 =?iso-8859-1?Q?6EIclgxlrHgZTMsFuXfr4JJQHwwIntEjZV6auaoKACnKx58b+UwSRMH+G6?=
 =?iso-8859-1?Q?dbhjSPQg1Fl91s+wXHI0N8hDjqs49djDY8wwo/bk7gFMQ3Pvjua/vimpGD?=
 =?iso-8859-1?Q?qTAx07YrnzrGBly4+sLyi+1erIE7Sr0pOmvbnCgDLqSJ8Wgu7tVnASPJM7?=
 =?iso-8859-1?Q?0r6jhNNOmmO//rQBRirpQvbzoiT8NdtKdNKCQLVt/1/vm3PNur5RFmWnAU?=
 =?iso-8859-1?Q?4JkykGRbX9+h5nfAd5OjmLyUPpv1Dk7SyiYLPObyYhf5FGk348UgHbSWwi?=
 =?iso-8859-1?Q?kogs6SUsajxXbe6HXNAdkoMtJjTy0v4j1/Iuf2LPwUw7aG44xEjLnwMzk+?=
 =?iso-8859-1?Q?eeZzJCA/vXG2RipR3dLrIBCse+eVlxfeT9XH8n73Zw6dxJGmqTtlj7mkhx?=
 =?iso-8859-1?Q?rgM04xHNQlnT7vhBK+08dotUIDpugfzx0mTlQ8qyRKqiLCmda7b+7TQojl?=
 =?iso-8859-1?Q?20tByHKxr/+Gu6aZ8aQPfkRDD5Png4wnGZxR/V0s7HgZDu3Ekd7MlRAGT9?=
 =?iso-8859-1?Q?6RFrRNQMDtJildHZx+0kfLvusbfHke4vrqWBjhpcVtWGUwvqEccnjh1k2p?=
 =?iso-8859-1?Q?V3j7rZHQKSBuoZzGYhJ+0t774jUCF3J2/zTxSn+6YvnACQzljtJ66UG/VA?=
 =?iso-8859-1?Q?r9gAZXZvqSNImx+dhEYfPIGRip6Kps1pyPl91hTYlUuXnJbLtrYV6iS2QQ?=
 =?iso-8859-1?Q?IaM5qkMOkNAlqqxJ7gHFRGm+f1Hwaksyf8acrx82muQNNFuamC4TxarzLS?=
 =?iso-8859-1?Q?MY1shFmnqq8vNn8fF3p1DkE609qqpVJcEwaE097v0BVX5YEVE7apQ6reTM?=
 =?iso-8859-1?Q?Co39qkEuP6DQSeOU2LUjdcVxLLeNYrCNOkYLdUJjvGbg162sn7s3108ZIW?=
 =?iso-8859-1?Q?T6Gz92i1bcEvvBoN0nJMHNwUqScm/vBuN2Tm6I5gWZjEUYX0U59eEc1Uev?=
 =?iso-8859-1?Q?wqR8DiU7sW/hk5TWbIFaYwjwHwLRafKS5uSOqLkaDCl7UW0QayNi7GmI4y?=
 =?iso-8859-1?Q?+Przz83y3EVMTDflrIqNdAonzo8eCePS6rRn4S8w3IPLgCVvlwFpQnN0Ks?=
 =?iso-8859-1?Q?oftXS/xIf7Ry4Dqpy7bt7XOQQF+WH/itxAsLVrmUpjR9HPB1aL3zz0Q9UW?=
 =?iso-8859-1?Q?blhI16FtjKwNca7lJ1MSYzRUPrVBEnTcZbCRpBzMLlsb0fXJuwzTqgzmDM?=
 =?iso-8859-1?Q?Np4ZGoS9Idz+rO8etHi/ZMSGLBY45ZQ0XNA8IVUkNy2rDq7KX8+xJMQauM?=
 =?iso-8859-1?Q?l1Do95pyIPR0b/0L3SPu44HOyBWhAfHDXa9f1gjJq5FYAvq8Ta8THceUFe?=
 =?iso-8859-1?Q?53rJoeyKJ2/YdBzR/leBtd+1y9BcIRKfVQVxkgmms2tasBSr3bgmn7nT4D?=
 =?iso-8859-1?Q?mB9tb6G38JhGA1LWcvJwuoiob/dBL29qJg/7W4BfX7n8r0su4wJ0MP7bQV?=
 =?iso-8859-1?Q?O4qw4lmtOQk3l0RB0dD8bg/Lj8t23SM//vpMeB3ILI30v0a8i2r4J5P/Gw?=
 =?iso-8859-1?Q?gULz5IpLVdyaCze5auZJj1qcilouWvT5SGYzyYXdcOs4kEVrox4uRjWA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a450566b-aafc-426d-d804-08dd5c25ba81
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 20:38:47.0572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8rntPS5Dg4YsRz+2i6ocuU2ktyqEV7sPcZ9S7HF2dpvFkEdVU04/AhUTFUEsQno7lkbXUXLzbSV/KGEziXI1mtO8dtn7qTzf5UP9T6W+PLU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6694
X-OriginatorOrg: intel.com

Bjorn Helgaas wrote:
> On Tue, Mar 04, 2025 at 03:51:08PM +0200, Ilpo Järvinen wrote:
> > Disallow Extended Tags and Max Read Request Size (MRRS) larger than
> > 128B for devices under Xeon 6 Root Ports if the Root Port is bifurcated
> > to x2. Also, 10-Bit Tag Requester should be disallowed for device
> > underneath these Root Ports but there is currently no 10-Bit Tag
> > support in the kernel.
> > 
> > The normal path that writes MRRS is through
> > pcie_bus_configure_settings() -> pcie_bus_configure_set() ->
> > pcie_write_mrrs() and contains a few early returns that are based on
> > the value of pcie_bus_config. Overriding such checks with the host
> > bridge flag check on each level seems messy. Thus, simply ensure MRRS
> > is always written in pci_configure_device() if a device requiring the
> > quirk is detected.
> 
> This is kind of weird.  It's apparently not an erratum in the sense
> that something doesn't *work*, just something for "optimized PCIe
> performance"?

Another way of saying that large requests surprisingly perform
worse than small requests.

> What are we supposed to do with this?  Add similar quirks for every
> random PCI controller?  Scratching my head about what this means for
> the future.

Ideally when the platform knows about these corner cases the BIOS
deploys the setting and the OS knows to leave it alone.

> What bad things happen if we *don't* do this?  Is this something we
> could/should rely on BIOS to configure for us?

Reduced performance, and yes only the BIOS has a chance to know about
these niche corner cases ahead of time. The problem, as always, is when
to know when to step in and change what look to be default values, and
when the default values are deliberate choices by platform firmware that
knows a one-off detail.

So I agree with you that while this quirk meets the letter of this
specific recommendation, it portends a future of a steady stream of odd
host PCI controller quirks. Is there a path to empower platform firmware
to convey, "don't touch this value for 'reasons'"?

This reminds me of your observation about _HPX.
http://lore.kernel.org/20240715214529.GA447149@bhelgaas

I.e. potentially a path for Linux to double check that what it thinks is
a good value is countermanded by an _HPX record. Maybe that is overkill
and a more tightly scoped, "don't touch root port PCIe performance
settings" flag variable in ACPI would suffice? So I see this quirk as a
conversation starter that can be applied or held out until the
conversation resolves.

