Return-Path: <linux-pci+bounces-6802-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DA28B606A
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 19:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FA2A1C21600
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 17:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D898127E10;
	Mon, 29 Apr 2024 17:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HaFK0Y1Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA161272D3;
	Mon, 29 Apr 2024 17:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714412873; cv=fail; b=JWZ+PJANtDYX4O/9CQsasJ8dy3VciZ4SbtDs2n+JYXPDgNeya+IGMaOb2nVK3ehUqkJH28mAPOczfuaZvns0iBoh05ywWARFSqdFNWerfk8B5p0FsL7vIe1vmOYUVuLpRKXGbPjIVtqiQByu6M/uITJwJLDkDqp7UY4iW7v/MHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714412873; c=relaxed/simple;
	bh=crqSivJfwxJJdDcTKdP8sNRaPSo28XSvoP6LOfqu4cE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MtBuf7DpHY5+whZ06sDv+gdG01hhuUF2oSSDmnK+EPYrIUXaEXtFKQADjZ9sYMSlLLxLoK+0XVcCNCsj0WWdbhitHsEZQSXAbQ43uEkxyhz1w8RvTiXjyFZFjNlbWAD6bJPatIc2gDov2VYBM/S0FeAbeGr7ih31kN1wstFr098=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HaFK0Y1Z; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714412873; x=1745948873;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=crqSivJfwxJJdDcTKdP8sNRaPSo28XSvoP6LOfqu4cE=;
  b=HaFK0Y1ZWIY0l5q+ldBjyqV8seJ8/uLOTw0FqEOPSk6CWdFrXq8gVnx4
   YMhRseEAcGbXPb9AhK/GztYQU7jk8MabrgfQkBkIPBlVJc63pJR6RkVGx
   TxO3DmyJ0dEsRYlTfs56Qg6v73VZP4KhsOfIRdkskuSL9LXiadzQKWa6h
   zH93Mgz6KNJGbe4c4Tk4RDLYh8GzmngEiPnfT/qiB/so6xFL8tijV30za
   DE6ZMiqICIh2n2uZWgcdS0citsrBRUZfyz7QhIoyAyStTuqRqm8t1IlCX
   3PmV+R5h87rJGhwu4ofWIEAyaa9aEJ+mvbPhRe0ctiFPowqt64SHK6JCC
   g==;
X-CSE-ConnectionGUID: 3bBF2WnJS4y9IhQx8+rJMg==
X-CSE-MsgGUID: 6Yj4EguSSNKggBRHtFAiWA==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="9947740"
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="9947740"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 10:47:52 -0700
X-CSE-ConnectionGUID: lVQK2oQTRX2igWt8tl3KaQ==
X-CSE-MsgGUID: PEN5xEOVRnWdj1vjSkqcvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="30984752"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Apr 2024 10:47:53 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 10:47:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 10:47:51 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 10:47:51 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 10:47:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NCMDaHHL806aSGCC27ISMu2vgeuu1q35aMcCEvoa71oQstBGeomNYk/t4930cNDq3z4WmH76oZXbVP/0r3B7vX3vGo3vJrA/rqBcqRcuFqYRTGBNkw4bL/OLtb/2lSKFht0tCWj/9MZ0P+gf6dbzJSLZtM75ZknkH9qr6V+Xe6R/TURqD40sIzyk/3X0Ox+gWhmnyFDLZXTissbDyrEA9XZUpmp9fkvZkIS/xamGOSVHgFoQk5BgwtoX82XqH5EFcgzQsnRWfd4k8vkiTwjcUFtzyWGzOh+boDaoBp6q/J/rtFMgaGo9QGdEWI5avDVAd6poUzgvGVgqhdZYCnhKHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uogRHDmZnoSah/JDKmyPnUtnAQq7YZjFfE+YAZQAE6g=;
 b=AKpKEF8FJuczBnQT1ydmLZbq8LMUXiKR9ko7SI5i5USdyXrdIyGigXM37+RzgZZK/NsDQ7kU6oFqDlDv16RRaxoS8ZWfJmoy8b1YoWrtCtJRgeTMUgmjNzivVSU595MMiY0qJD4LapN+vqiYTnZmSHd8wJzP7TK1jpi3rkMUNSdyKreRP2vO8N5MNIp8gH0N45JEh+hmEmTCC3Es0vLYvOsOc4mdshpsQzEwO8sRhBaQUHWstVB7HOhtO48/R+9+m0zJ2Je7UHW95ghvdHcubZKYz9LQLZngYEctjZYBXG179rJ8crK6q9auzmKxBnXvUKsdoDsdG3KWTCS1NDnxgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7133.namprd11.prod.outlook.com (2603:10b6:930:63::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 17:47:49 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 17:47:49 +0000
Date: Mon, 29 Apr 2024 10:47:46 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Lukas Wunner <lukas@wunner.de>, Dan Williams <dan.j.williams@intel.com>
CC: <gregkh@linuxfoundation.org>, Pierre-Louis Bossart
	<pierre-louis.bossart@linux.intel.com>, Marc Herbert
	<marc.herbert@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 1/3] sysfs: Fix crash on empty group attributes array
Message-ID: <662fdd4283b0b_1487294a7@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <170863444851.1479840.10249410842428140526.stgit@dwillia2-xfh.jf.intel.com>
 <170863445442.1479840.1818801787239831650.stgit@dwillia2-xfh.jf.intel.com>
 <ZiYrzzk9Me1aksmE@wunner.de>
 <662beb6ad280f_db82d29458@dwillia2-xfh.jf.intel.com.notmuch>
 <Ziv9984CJeQ4muZy@wunner.de>
 <662d2ca522cc6_b6e02942d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <Zi1qtKNwcyydP4c2@wunner.de>
 <662d6f24528d7_b6e0294d2@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <Zi4gK8rs7jjdJOh8@wunner.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zi4gK8rs7jjdJOh8@wunner.de>
X-ClientProxiedBy: MW4PR04CA0195.namprd04.prod.outlook.com
 (2603:10b6:303:86::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7133:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fa1bc50-5749-498a-1dc0-08dc68747c32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jlmEclaXtY6q3uFJRB416MyybrdkdYIoBvTnxb5oBIMdPgut5csj00kNvubq?=
 =?us-ascii?Q?7yf92yKWsRUc6mNKsHT5DfNzOWtqYEHrTRV0oGRP6eiNeMWnUNn7Yjzix2mX?=
 =?us-ascii?Q?GBmIariJKdxIzqUyCclqhTEwp+ovgnLexDetAPKET5MU9waQEpHcC/bK7JpC?=
 =?us-ascii?Q?m7pS8HWaXiaKoAQpzqm04su5e/8ldtzidm8Abdx3Y9JNZbUUHCPQkF/1FMmB?=
 =?us-ascii?Q?KqzwSIHAhT5TaBERhYVqZ4OAZZ+GtY8p6g6s1QmjpOi+kfjUgXxh+hXY5mCN?=
 =?us-ascii?Q?BFGQJFEIMzfebv/Qi236OdCSDkqVBlNazFIHEEHtp0/KO/EBF9R5Y8VrLq6P?=
 =?us-ascii?Q?myT5dgU+2HiyBVYaIBGQ2onGQhR/5fvw6TI/u8+ifJ9spVwfsXBX7aeNGBM0?=
 =?us-ascii?Q?IzUD6/OQmtFKRma1hqHz9kaPY4J+qCk1qV2lwBb8h4q6yIWlpuooopl466KR?=
 =?us-ascii?Q?BvjHuB727hZRsDfOP0zaDH6TJyHiQ53Ui6kMOaZqCHFm0ukO9yt3mRziiFf9?=
 =?us-ascii?Q?7srIZ82FcQypgzZUdgfpvbtgtRRNQqCdpyaLYKY4XQXmlroeNXchBUer61E2?=
 =?us-ascii?Q?AGD5RmG78NuwZIFwXsk3u8L47WSA0m66um2B628qauXY8nvurh2E/LBbQ5Et?=
 =?us-ascii?Q?ZjjwKCzOdovkFTN1CtvSTISqoK2Hx8Eh69sLAAPcsZM4EFZnmqfFSuBYLzoD?=
 =?us-ascii?Q?+lRFjm4chNpSFItw7rUURdqsb73MYz3t2tPpZiC54Dra7PMhIzOR5mMyPuqA?=
 =?us-ascii?Q?M97+o0mxRjEbwjHiiyKPqsMEBwPPmTzF8RZLe26QJeerqaExGQXaHAPRMHa8?=
 =?us-ascii?Q?BPUUcGqzQov9WNk51Z9hZ+wCSpEWLUOStw5d01DIg5s0otAxqQRF9PjAv9L2?=
 =?us-ascii?Q?Xzfhu7j6Baiirmp/WbQOFo2XuH9F8u6rkbw8ix39/mKiBHswLpa6uszMERyQ?=
 =?us-ascii?Q?GUO53vzAEL6NVuYHrf1thprfDQY+DjZhWB/pZXz9t9mMxb/WXfVIKx6e3Nii?=
 =?us-ascii?Q?/nclqT7fVwaO954ZxcZphj0Q8HytjwX3frYi4N5lxE7F6SXMrMiP7Q7HjcMO?=
 =?us-ascii?Q?dKx5QohpkHm1+d8IQkHR34HOXR4u7QP4XI14SYaSG5ecHtR7lK57r1S5sOq6?=
 =?us-ascii?Q?2xaaIarL9fJ5RVYIE96OK2dizVj5xl3HvCMrnCurZnNhc1vf/az6yFCYZP6y?=
 =?us-ascii?Q?U1vytAqOyt2gz3e0u9XaGmNdbpgezKuxKGKupEwrTIh0jKCj2s9kj0PHLQmd?=
 =?us-ascii?Q?epzaZFStFVSJkga2o9Je2Z3WTzd1HUFzxMlq1CgomA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q5WigdSkbMQObc5ZoEOA72cCFwIdC7fhbNFDt/k4ckQzUD0O76fPtre/gf+/?=
 =?us-ascii?Q?R6IurGllebd1zIYpMSNjhThntE/qwjS4hBLslF7zk608QPVDUw0S66YGAhQR?=
 =?us-ascii?Q?OPgB5e8Lh/HLkMBnX461gXc+7gKTeQDhe4Ty3HqHSqPemeEn8Zl9F46pw3Az?=
 =?us-ascii?Q?pQklmLwfwCRuMVuq0vOGF2THdTtdcfeJ5V++AznhwxMf8T+Ok9r8W1Fa8yzc?=
 =?us-ascii?Q?IpoloFQBiTCNDQi+sK4mpP4XiDET+g6q2k/Hf6FI3uFhF1BfjcmqUZjnLaxD?=
 =?us-ascii?Q?srEBRAKJ4EkKzHo6rnTvhi3Ndgmoaezn86FwUuRs9uQatsO8y0mzJ295t7yA?=
 =?us-ascii?Q?qWMxWCU58DHic6EwljkiGSQeP6h0B1rTLTHHCPIj76qgLwwumUBcfvqom86G?=
 =?us-ascii?Q?T9p6B/uaKV6bfuwd2J/MBSDIfqZSvNTTSTw6e839bE1yvtn1yNtuZ/VlUR7m?=
 =?us-ascii?Q?0eXL4G7dXnnIbRnvvX8Gpp4jIsNHPFCIXPMQs+qrkRJ2bBGdxGxrCzwmntxi?=
 =?us-ascii?Q?+GbwvKgaujiXFUuBzo2q+fV0ZQTR7M77Ij8IkbX5TBiM0HEOtjHOew33VA28?=
 =?us-ascii?Q?b9uruo/SZnR+kpKqDOYCWaqMyiNbPocWvkQV+Nst4jrxp1uOJGUs3KMEJVhR?=
 =?us-ascii?Q?FeCnxVfGql9q/5fgByk0CVYbW10phCFsHQqXr4mQhKw5z1q+xnypjy8Mx6By?=
 =?us-ascii?Q?Eh9KrVPGTaVtpofifOLzhndNa0V7KzRDbjlyXYn/z6nJzvfRSZv3MVKVIscK?=
 =?us-ascii?Q?5Am5JmHU03uFAf+0RihzqtfofrS70wC7A4iE/nihHjFcNUj5c5ghpwpRPSNu?=
 =?us-ascii?Q?L4JDEFI+yr3kHJu+YOSQT368fyqEmrfYRtsCRRL81A7XCYWE6GjGN6b8b3GJ?=
 =?us-ascii?Q?jcK/emnFSjHA8nUZ4CvtYcpfAAc3QaDzXIV68mjVqHSzfVC64LgzHG22E/LA?=
 =?us-ascii?Q?C8x6+DM2gqEvrNFm+K9QrNuDdE0/YdPQzYHsAYafeoRa95i4sYjwBQmnPUnU?=
 =?us-ascii?Q?MpaoZc9BxkNKsGgfzlPxgzkTeiS8DKmSlGl+9rk3VP+0QYNpjpE30ln1amFJ?=
 =?us-ascii?Q?Cqmgs6vorF670xpBCxRFH/iVTPYcwe6dnsUk81fAQVZa4K/whcWI1Dp3eTxp?=
 =?us-ascii?Q?Xuv4jpPOs4ffUl/ysm+fdiv2rkTeOkHcgq5E1P0u/o2mPb1BNLnZx9Be7R4c?=
 =?us-ascii?Q?dUuJPhkO4dGGotu0cRL/OWh2LNLZLewMCvD6LJ81mX4Fpstwb/FEqA2al2GI?=
 =?us-ascii?Q?N+lrokIWQyTu7vSvViJ8s0g2S7oDsS6lOP3GEtTgJ7Yf4uCnZmHOsE3ANeJG?=
 =?us-ascii?Q?dHO8RfJIiWTIt5BHxlLrtN0P+CwolkpGCGpWZSdQsjOPmY1vMbqqt9aFekjN?=
 =?us-ascii?Q?LUzcArFKF2x5MT/jnq0GZ+qwn+TWmB9YHkqiakiUBHrc74iKeTAylQIdqDOe?=
 =?us-ascii?Q?+9zyzB2vce6/ACEE80hTEDnaZe9ResLsQo5FcG3DPveUsd56qgZOQPKiGzi3?=
 =?us-ascii?Q?tMBrwaIcViWQk1wCXDoU6saHxiFCTvAa882L1Tk2PzH4Svsu4M/goswTAq2T?=
 =?us-ascii?Q?Il3CjYOKU53ZyrZpsPLP3dFowUpyebais/P5WUGS8dYjc+68k/3BcSyOo7zE?=
 =?us-ascii?Q?WA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa1bc50-5749-498a-1dc0-08dc68747c32
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 17:47:49.0411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tpOY1n4FABfLQ8V2amT8j72hFtjPjdAToRWJif6EgOD5zmT8CTb7rRIUTfEjyQ9DFoazm1cY0StWTlBqxIKVou9/QAD+5P5eW7gCn4ZmylU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7133
X-OriginatorOrg: intel.com

Lukas Wunner wrote:
> On Sat, Apr 27, 2024 at 02:33:24PM -0700, Dan Williams wrote:
> > Lukas Wunner wrote:
> > > Perhaps an optional ->is_group_visible() callback in struct attribute_group
> > > which gets passed only the struct kobject pointer?
> > > 
> > > At least for PCI device authentication, that would be sufficient.
> > > I could get from the kobject to the corresponding struct device,
> > > then determine whether the device supports authentication or not.
> > > 
> > > Because it's a new, optional callback, there should be no compatibility
> > > issues.  The SYSFS_GROUP_INVISIBLE return code from the ->is_visible()
> > > call for individual attributes would not be needed then, at least in my
> > > use case.
> > 
> > That's where I started with this, but decided it was overkill to
> > increase the size of that data structure globally for a small number of
> > use cases.
> 
> Memory is cheap and memory-constrained devices can set CONFIG_SYSFS=n.

That sounds severe, but point taken that someone could config-off the
cases that need this extension.

> There aren't that many struct attribute_groups and this is just
> 8 additional bytes on a 64-bit machine.  (There are way more
> struct attribute than struct attribute_group.)  The contortions
> necessary to overload individual attribute ->is_visible() callbacks
> to also govern the group's visibility aren't worth it.

I agree that most systems would not care about growing this structure,
but the same is true for almost all other data structure growth in the
kernel. It is a typical kernel pastime to squeeze functionality into
existing data structures.

> Having an ->is_group_visible() callback has the additional benefit that
> the mode of directories no longer needs to be hardcoded to 0755 in
> sysfs_create_dir_ns(), but can be set to, say, 0500 or 0700 or 0511,
> depending on the use case.  So more flexibility there as well.

Unnecessary growth is unnecessary growth. In this case all the known use
cases can use the SYSFS_GROUP_INVISIBLE flag returned from is_visible().
The awkwardness around cases that want to have an empty attributes array
and invisible group directory is noted and puts the solution on notice
for running afoul of the sunk cost fallacy in the future.

