Return-Path: <linux-pci+bounces-9090-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E5A912DEE
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 21:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC2B21C21449
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 19:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B4617B40B;
	Fri, 21 Jun 2024 19:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TUyuZFdn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEC884A32;
	Fri, 21 Jun 2024 19:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718998577; cv=fail; b=fr1Ib5cnpV6Pptg7ligP+lQA59wqn4bM/bE5w2bU3JJtMOY50p0x6U1F5DIii+wTHdPEEJm9VH/KS1ul8HjzMDRJvVxlUXyeTHFsny3F7KOWZM/nv3OCHbrwGd4aSxtwqIoPLJ2BDBaeCIYZ4OqVe5xsvZqwdJL7hMvedl6vovA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718998577; c=relaxed/simple;
	bh=c76phu75WXDESZ17d1De8+vRRbCOSCXGKzMDQrDmsJM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gV+SebN4GCXWBExz1EuBdZpLVO/6KJIIDaM7WLJ9QmF+WzWtko591WSYwClsEbeZJsEhNTN6yHHtiOFglQ+tpTljbEkTUbd8J0LBJT4lMS19j2oGi1p9CEc5ZGWgYJbt7UvZCTgdzxKpD5uL9RP+xa2F61loX3/Wa99TYFBKJ54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TUyuZFdn; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718998575; x=1750534575;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=c76phu75WXDESZ17d1De8+vRRbCOSCXGKzMDQrDmsJM=;
  b=TUyuZFdnmnzDAtSicB/hciyRxNhtPcLIrYnPcE0IPYyMTil6cGgn2GsO
   NjKZdFGaKBQiFoxWyBouJk3WeoQOAbstXaBbLL89mBYr/CQ/ImL4iSq2m
   bIm4oWiszJpWkkjM+uI6H8xKQiC27WC9Psq94+lYb5DR0SStk4dD8GbOS
   CP37/L+pGPdAfoZcB9nPrUz6Wd4FQAnNHkSQOgPyf51np82Cdo7ZMQLlc
   vjUKwjCrBIPh5040z8+luQOZO9PmnIboM7RoqFcku3eUuEzirHlEFqcm5
   l5/UD4ykkO//+pR0tzzTtevy258lNZfAsQKCyZr376MgzdSf98P5u/tNC
   Q==;
X-CSE-ConnectionGUID: 0vuQRU4WRQ6s7URyfdIUPw==
X-CSE-MsgGUID: ksKWd7XtS+KXFvBhKP5Kqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11110"; a="19858848"
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; 
   d="scan'208";a="19858848"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 12:36:14 -0700
X-CSE-ConnectionGUID: IWe1JlDfQSavXy6rPwM+ZQ==
X-CSE-MsgGUID: TGbDlCY0RBeq0viZQWreRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; 
   d="scan'208";a="42785015"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Jun 2024 12:36:14 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 21 Jun 2024 12:36:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 21 Jun 2024 12:36:13 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 21 Jun 2024 12:36:13 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Jun 2024 12:36:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fo/o5mfSA41vbi+ymeLJSOEUs1wD5HAdQ+b49BQoMM4QH5EG0fVkaVY6kBZ9ROkzd/gbxtoKNnCys8LR0OET5zzHZyhzr1zN6NqV8rw8GLwRtkbvqYVxaPYJDlnrg6mfHYTpVl0Az3npo9SFZtCsw1xqAc3PbAfOy78ckTQ0oKsQN6oi2pWyQfn8nFR0xvr6GGIZhbLudmCPjF2TicLe+1cwbcL42GlVabW1S7rgD3t4cLmR1utsQfNq5CUrP3xy7XqAikGmz0KYcZ/wsSniPbfyhAUmb7bSOfTUuEMjogLfpOsY078mAL35SHZqBdpezGeVt2aE013axcUdCa2K+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJgGxp5jB6tP6LZije2+Qdn5aKbG7ez4st53aXA+Znc=;
 b=dKnY/GVWHmZon9cBY6+BTssFLlGdtFea+T5qh6mUBWyd7SvMIO0Fzsw+RT75/d2Qtx2nQIpsEa1xexqrgyxKxR6duao1EYfv8houTehcQlvwySj5vz5Hdfs4wOcUtHB9Z4Hrk4KK6huCs/tA3yKajDSRp1JhXfUtqav1HssvUOGFdYozVHrdyClOk01t7YUZvW8xYRoBECFGUkIrR1szl7IT/B6qCit/LWUSOUdQwwgpiciPyc5IqUIA4puECrLtngqJrQwJW0Lq64DwMUkacTkGF2mfjMuqk+4ir7vgGshrxvXUC/pfcWHhR4Fy0Fs1UxsS9klEp0DWLzJ1M0alrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB7386.namprd11.prod.outlook.com (2603:10b6:208:422::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.22; Fri, 21 Jun
 2024 19:36:05 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7633.021; Fri, 21 Jun 2024
 19:36:05 +0000
Date: Fri, 21 Jun 2024 12:36:02 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Terry Bowman <terry.bowman@amd.com>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <ming4.li@intel.com>,
	<vishal.l.verma@intel.com>, <jim.harris@samsung.com>,
	<ilpo.jarvinen@linux.intel.com>, <ardb@kernel.org>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Yazen.Ghannam@amd.com>,
	<Robert.Richter@amd.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
Subject: Re: [RFC PATCH 3/9] PCI/portdrv: Update portdrv with an atomic
 notifier for reporting AER internal errors
Message-ID: <6675d622447ac_57ac2942c@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240617200411.1426554-1-terry.bowman@amd.com>
 <20240617200411.1426554-4-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240617200411.1426554-4-terry.bowman@amd.com>
X-ClientProxiedBy: MW4PR04CA0330.namprd04.prod.outlook.com
 (2603:10b6:303:82::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB7386:EE_
X-MS-Office365-Filtering-Correlation-Id: dc1548f7-c893-453a-efbe-08dc92296469
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|7416011|376011|1800799021|921017;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UTkp3Wvj2vgb7++ZgIlkZgg1ES0sVk4YoxwTtB6FcGf5q+nHEegakoMfoJuF?=
 =?us-ascii?Q?Hz8TQFNz9SgRWS7BCxz4OGhWVHWnRFuU9BsyVjQ0qtmhTSpAYjPdUX6frvr7?=
 =?us-ascii?Q?MVHe9x3dAj/+wYsixooEbLLHJHBDG7bCpaRvM2aiNWJd6Xo55JrYgjMIaWv5?=
 =?us-ascii?Q?rnIPJFeNBfU1MqkIjjGNglLYO66Y8uj4xRYyLT1tlU/DYBYQIGP0PTMCg0Pm?=
 =?us-ascii?Q?7k9d3B3LXiQu0rN1JY3YdRiGwy5U2o7o901gDJAKFxkAgV1fxc4HBOEoS/3f?=
 =?us-ascii?Q?lkP6/EuV/i+mMY7WYlxQIeVriNXp6brcG6zyZ59I5x3kY2u5W755GA+3OQi6?=
 =?us-ascii?Q?/ksfIiEBXepyGULlCwd35MEEG3ZJ7HTguzRaPy5/AYOKl4ATvYwYyaiUJGne?=
 =?us-ascii?Q?d5yB9bM75yRqLgLipwbKEHJcsg1P0miF2Je2DWInbRhpFeCYbxKDD1ZwlOYF?=
 =?us-ascii?Q?+Mjt8hMWNiFfLyNUCZPjSnhvpAhbiW1lmhyt3LiGXe6BJ7/gHz9J1QppU71V?=
 =?us-ascii?Q?XsnFwpK+c4Or6DcBEnNeapdPlXOCbS4lDVxg0OJMjifUkkUdxrrYu8IWp13d?=
 =?us-ascii?Q?1elIzkHs29LqSy6o59p0go13l55LmlY9gIx2qmY/3TsUnZm2HD1hQlgiC/EU?=
 =?us-ascii?Q?LHxLcbLrKe4OsHGytjHi7KB+5ZLEPoFjv96jISpcahQ4v5SlMIFofhAv/+2A?=
 =?us-ascii?Q?YNfR1kEXwbKk5MqO7Cq2+CPwd55v5BNIRnCZ9hFOCKRvR+PNy/KLdOBpbRUy?=
 =?us-ascii?Q?V83mUZc/jAm4Dmpx1YguCAC8fRU62jYrhady3MnPbGuhNmrozJxTvlB2n606?=
 =?us-ascii?Q?9Iy2jcH/X0B4/ofTIGE5Eur2v/ey9PZ7e06ky6ckCebhEwtIhnPUW/z9A+wx?=
 =?us-ascii?Q?pI7p/AQBenPPW+Nh7DKQUygYGeRhiaeLiZK+BBtqNDfTwVPhDN3aZz9XJjr9?=
 =?us-ascii?Q?vtgWI9TzOvWUI+ihRIZz0QjBQaM4JCDC41utV5LB/dd0Fa1ndnAqS3NJgyGa?=
 =?us-ascii?Q?Pufrb1Mhg7lIV1Wmy0ZDMrEGmkOeiT6MjylVOMfc7hcFcYL1Suq7cvhaZO/r?=
 =?us-ascii?Q?Ef3viCZN1quNx01TRj1H/UZkzMd7NxSZZEn6NuApzP2gkxTvaDjAwzwwdgPk?=
 =?us-ascii?Q?3/jjV2BeFx6MvOjojHoPyaPY79K5Poid1VZVkKNknYLS+RF7yzfSKcaQz28n?=
 =?us-ascii?Q?l+VwPW54igLpc//aBHhHk0SPtrieJMmlOkHbtyKj++i1DBl8pRCW/Jua5g2a?=
 =?us-ascii?Q?8fsSdX+KaD6MG/4mOyENk7uzfQxBAETlC60vJz7HhsEzeZlY6dMwuNuigmaN?=
 =?us-ascii?Q?gutFMHDxDZakTnqzFV/onM1WYflD/cGOZoYbo3r2fYTfasvPRPKN16RzDoHm?=
 =?us-ascii?Q?+vOps1w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(376011)(1800799021)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q30FVYeUULFU1uBCeGp5vjajx4iGG3KWK3z6h3DZcqTpvU4oiJyxCnTw3zQ2?=
 =?us-ascii?Q?+DZCslybP/oMYfBlzoyzwPxHHxR5fIhyCH21B6mTkM+A68xOIH6V2YH+msyH?=
 =?us-ascii?Q?3mWTN9tXvchmXRc8G3h5HOKXEvTa2qRKZkWv7Huun0U3bv3hKqcONprlEJ2N?=
 =?us-ascii?Q?d4sgOpes0RHdj8H5Q6+sqFqt3hn8zJx2PMdNVOBdn3VlMtTdXErqKG2K1eNH?=
 =?us-ascii?Q?7Xt+1DemnFj4EA+l45cfV6eeLOsPML+mM5erlrW7sz0/0UdEZxpO5DxnfmYN?=
 =?us-ascii?Q?2jsPdUCARMT8JiYrc3XzDhHrDirZUrZd4UpxG4sS+iA5n9IVtLkLus4/MrAt?=
 =?us-ascii?Q?IQW7gwYc4VNWk0kL6XlKtywZksbCLD7GSoYZ2idYVAR/6RS5pcyb6/4cvw15?=
 =?us-ascii?Q?2+mUl5TXwwk9ncH7tP8bzI2+FocWZGsnCTKCmOBPt/67EwdxOqCwxS+b4xI4?=
 =?us-ascii?Q?xsB941AN9WUa0VZtfx/f71o4RxhWYKBkOwGWGLxUIjL0Ygbjjak13I+wFpxi?=
 =?us-ascii?Q?AoXXNxMWmloiSMoBmwgKosjohd8/KdJRM+J8C4Dzf/k2r93/iulwzIXkPeOL?=
 =?us-ascii?Q?4ozE3MPtOVggIjg2eXb0Y0FuRCxmSXPi1f1HsYCrhyOVvizfVDdIOxp7gn1x?=
 =?us-ascii?Q?4A+5+MKN+S0yxruPsNZOISGaDf9L6+ZP6+pvrXUkcvlDflGI7GPcqi8G38fs?=
 =?us-ascii?Q?eoXW1s7d3dwWLy4LnMJN/cx3Ly66nuh05ULAAlRqz+lOO8ltbrt2It4LWxE0?=
 =?us-ascii?Q?Os5UO9GgYgp5+MGihzPYfZSwv9T/Rs0FcPcMWQPUIBc0sYpitZSXJW41vTqB?=
 =?us-ascii?Q?y35JpfT7j/J+THyc3bKYQjHceHQt0n+wqJCVYeh0YyGrKyZPEN8aOE7LSyX6?=
 =?us-ascii?Q?H2OfLmkbb/7aomm+oCbTvU0jFirEFddH6AvXoSDiwgG+E9Mnjvl1YqkDfMiW?=
 =?us-ascii?Q?KA1cxHmC2EH+kI18mo6ZkDjj+bznE9ZE4w4Yift0v+ZsKN6e/yLF2Td93S8O?=
 =?us-ascii?Q?MenNyeFavxn6W7heTEXs9Hn+NInTyMpF5rCIkLpbRd1elZCdsywGdyh8u7VN?=
 =?us-ascii?Q?D8IL9NyxT4Hj3mEjE8H/I612jaE3z4UNsFuOUlQc773f1T8PFA+U+/UoHB+Q?=
 =?us-ascii?Q?pmg2t6U3CfKmH8A+min2JMMDSCWX1cXx0rWZViGgzzePgHhJnXpXLiERo3Qa?=
 =?us-ascii?Q?e159eo6t55qQAjMGLUefO9nf+qMeB/GG2t2ZXTlGzzOxfmltrL9lEQ2RfmQ2?=
 =?us-ascii?Q?44urLihaQ++fzuW03ekk4uGHgDZBqSWkHqxOu2s5x1xPX/DZzMQpVYXqDDv8?=
 =?us-ascii?Q?2HNlUP5WDGt9EVXQQkMft7EmO9KjncFigLAqGL6HumM4hGgo7siYf4uqf9xl?=
 =?us-ascii?Q?AlYHf8dbPdh+3BXtU/OOlbFo/KX2tE4af37ZEXkyPVW0ZujYDhvzjySqBoGq?=
 =?us-ascii?Q?PQ+F4+hNPOB4k81Z8/EdyNhnXKWwayD2qeJbrcEAEcQEfQ5L3U8soZNHgEke?=
 =?us-ascii?Q?7UM2vOPyEp2nF7TkV50Fwjb0lBY9R4YDEcQHNeRvR4wFV+exxVHgBjbupVse?=
 =?us-ascii?Q?Z21o+hX0TFCmhkcCof77fbE+UfdWl+Ut0SGxzLv5Oe7twcFPhxgTXzvWXzxp?=
 =?us-ascii?Q?Eg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dc1548f7-c893-453a-efbe-08dc92296469
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 19:36:05.7208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ze6wF55Pl5NdKtSM4Tl9Yx+TbZCVY/iOgdUSeu3Bx3zzCGrYAfPvIB0o7cB5Xp3Ki4cAmiVRZVqD8lTf0aebA7MXYKBoPrEAsdu4ez9j5sY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7386
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> PCIe port devices are bound to portdrv, the PCIe port bus driver. portdrv
> does not implement an AER correctable handler (CE) but does implement the
> AER uncorrectable error (UCE). The UCE handler is fairly straightforward
> in that it only checks for frozen error state and returns the next step
> for recovery accordingly.
> 
> As a result, port devices relying on AER correctable internal errors (CIE)
> and AER uncorrectable internal errors (UIE) will not be handled. Note,
> the PCIe spec indicates AER CIE/UIE can be used to report implementation
> specific errors.[1]
> 
> CXL root ports, CXL downstream switch ports, and CXL upstream switch ports
> are examples of devices using the AER CIE/UIE for implementation specific
> purposes. These CXL ports use the AER interrupt and AER CIE/UIE status to
> report CXL RAS errors.[2]
> 
> Add an atomic notifier to portdrv's CE/UCE handlers. Use the atomic
> notifier to report CIE/UIE errors to the registered functions. This will
> require adding a CE handler and updating the existing UCE handler.
> 
> For the UCE handler, the CXL spec states UIE errors should return need
> reset: "The only method of recovering from an Uncorrectable Internal Error
> is reset or hardware replacement."[1]
> 
> [1] PCI6.0 - 6.2.10 Internal Errors
> [2] CXL3.1 - 12.2.2 CXL Root Ports, Downstream Switch Ports, and
>              Upstream Switch Ports
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> ---
>  drivers/pci/pcie/portdrv.c | 32 ++++++++++++++++++++++++++++++++
>  drivers/pci/pcie/portdrv.h |  2 ++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index 14a4b89a3b83..86d80e0e9606 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -37,6 +37,9 @@ struct portdrv_service_data {
>  	u32 service;
>  };
>  
> +ATOMIC_NOTIFIER_HEAD(portdrv_aer_internal_err_chain);
> +EXPORT_SYMBOL_GPL(portdrv_aer_internal_err_chain);
> +
>  /**
>   * release_pcie_device - free PCI Express port service device structure
>   * @dev: Port service device to release
> @@ -745,11 +748,39 @@ static void pcie_portdrv_shutdown(struct pci_dev *dev)
>  static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev *dev,
>  					pci_channel_state_t error)
>  {
> +	if (dev->aer_cap) {
> +		u32 status;
> +
> +		pci_read_config_dword(dev, dev->aer_cap + PCI_ERR_UNCOR_STATUS,
> +				      &status);
> +
> +		if (status & PCI_ERR_UNC_INTN) {
> +			atomic_notifier_call_chain(&portdrv_aer_internal_err_chain,
> +						   AER_FATAL, (void *)dev);
> +			return PCI_ERS_RESULT_NEED_RESET;
> +		}
> +	}
> +

Oh, this is a finer grained  / lower-level location than I was
expecting. I was expecting that the notifier was just conveying the port
interrupt notification to a driver that knew how to take the next step.
This pcie_portdrv_error_detected() is a notification that is already
"downstream" of the AER notification.

If PCIe does not care about CIE and UIE then don't make it care, but
redirect the notifications to the CXL side that may care.

Leave the portdrv handlers PCIe native as much as possible.

Now, I have not thought through the full implications of that
suggestion, but for now am reacting to this AER -> PCIe err_handler ->
CXL notfier as potentially more awkward than AER -> CXL notifier. It's a
separate error handling domain that the PCIe side likely does not want
to worry about. PCIe side is only responsible for allowing CXL to
register for the notifications beacuse the AER interrupt is shared.

