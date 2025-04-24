Return-Path: <linux-pci+bounces-26636-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC12CA99E58
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 03:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 822343B2624
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 01:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413D01C8601;
	Thu, 24 Apr 2025 01:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DudzNoOk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605542701C3;
	Thu, 24 Apr 2025 01:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745458694; cv=fail; b=nSISQ6R2LN49ZHfr8xBQ1I6K3dzolc28kWr7+84h/w0Uj6+6KrQdvgVKXGL0Yenl2aF/IeQOXHrx0EOYxozOkvIMUVo4xF0jeL+mU6/XIrYeIgEsNmy8sZcIO3jvqAui59rbvPAJdmskLFHQ1gRmp8iy1k22aru2LwUTG9iHuuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745458694; c=relaxed/simple;
	bh=7ALfG+TY6AAppPxZIXfBrAu9x28GCUGhYK7J1R2cNls=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jQ1fYBSlLclQQqluwCc5DVlVQbBi1vVhbqWi8+sqk210h9JYymC/n+vwitda0aibzu33sxfkC4l8x8uAuEhf9pwzqwsunS91+XoSHJAWlK3GoK1G5dntaJKn1QQumq1VjFTUzOkaXzW2ENZFYmBtRl7jKtaoaky4JzFDALLs1fA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DudzNoOk; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745458693; x=1776994693;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7ALfG+TY6AAppPxZIXfBrAu9x28GCUGhYK7J1R2cNls=;
  b=DudzNoOkgR9EgEUrshHRJ7gSD2sqE9d5GmPIKRMG73XrkP1N32z365hu
   kW4A57ljbdgVZwQisbNgLUSZFUiSDbuLbwwwttB6svn2KeeLEeOqnOgqy
   MDjsaaDveTnr9Un3bXNrNrACwu8jyPFHQ/+a14G99Ad9iIOHu3MYYVCqf
   mA4rIGHm8fCXs80U3Yoy2rsRSA1mSpXb9nl0n4A15z6ul3HgEf2jzao1K
   YouwfvSwm03Fysi+4IkMYpPbGIpB0kfkreM7eqbKxtEV20++xlEJYAmOe
   e9cir6yVzSdf2ifjNMVtatq5MzM93f5h9/p8TwB0ojUkLQsHct0CyuBNU
   w==;
X-CSE-ConnectionGUID: bOoiKmttTv6PPbrxWlgUcQ==
X-CSE-MsgGUID: koqHrsAQSOqX4og12RscyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="57268760"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="57268760"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 18:38:12 -0700
X-CSE-ConnectionGUID: +TMsV4g7QJiZEMeuShTE3A==
X-CSE-MsgGUID: QJDIrA5xQQSvLc3LEnKbow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="132380754"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 18:38:12 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 23 Apr 2025 18:38:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 23 Apr 2025 18:38:11 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 23 Apr 2025 18:38:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hp+/vJpFuCCTUrpFKi7b0CWrhXKMGjdwlKVUCcWorzx1dLCsAEMrhNVuRjmJMoTAEOty0XEns674jlrxkHNf02VMlIo6wLg7eInE5mZCXaqNWfZ1/wojmlnOkm5qYjvcRF8VhF3BLFfP3ilYOwZJorabxk4BP0Qy6hw3JtMp4u5OFaicbsT/ZTZzPxkh1z5UluNOp9gAXDBcX8AvPkLZcfVAxQyJTfHw08fiz1Ys0Zy7Ly2rg8CC//VZfa1Vsr0RFPlu5pX6fP9Sipx2P0y29rRxMkVmgxCYq9r+lg9QqxofGW9FVg20jG+jvOkAE6sZTnzAjmh86HN5qmnoYmaY5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2CCUM2sRfcmElTa8gyq1r5YfJZy3qzhlBTbIpu0DMDo=;
 b=Aaf5mgm82GpEKzQJjccetax/OPc00U1odsmEQyrMz+54bDJMkmZFelXxRZducLxBOPVGM3BiiYwJ50Emhf+l5bkauexR8zO3WTpheEbxDBf+yY0o3e2aLATdd1bxG0+sS9xMIjAqE5fIW/ZXa43wi+gMj+743G+2rDWXRVtdSsJMNJKaE7LRfark8qSNVQyaJMAr+aNZ8MlBDyfl8rmCFre7W6ym+e5bRUSEfos87RZ9bwhOCDfUzwDNXp5L6+eXreL+RmIt80GHZ3PSdyiaEm/u9EtGDz3fkqGINGlXlqu7w91vplBlG2D1CRAsu4ZRwOfXKU78sxRvEZZTjT0FSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY5PR11MB6092.namprd11.prod.outlook.com (2603:10b6:930:2c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.32; Thu, 24 Apr
 2025 01:37:41 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8655.031; Thu, 24 Apr 2025
 01:37:41 +0000
Date: Wed, 23 Apr 2025 18:37:38 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "David E. Box" <david.e.box@linux.intel.com>, <corbet@lwn.net>,
	<bhelgaas@google.com>, <kuurtb@gmail.com>, <hdegoede@redhat.com>,
	<ilpo.jarvinen@linux.intel.com>, <vkoul@kernel.org>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<sanyog.r.kale@intel.com>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<dakr@kernel.org>, <dan.j.williams@intel.com>,
	<andriy.shevchenko@linux.intel.com>
CC: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
	<Dell.Client.Kernel@dell.com>, <linux-sound@vger.kernel.org>
Subject: Re: [PATCH 5/7] soundwire: sysfs: Use ATTRIBUTE_GROUP_VISIBLE()
Message-ID: <680995e25de06_71fe294b0@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250423175040.784680-1-david.e.box@linux.intel.com>
 <20250423175040.784680-6-david.e.box@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250423175040.784680-6-david.e.box@linux.intel.com>
X-ClientProxiedBy: MW4PR03CA0135.namprd03.prod.outlook.com
 (2603:10b6:303:8c::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY5PR11MB6092:EE_
X-MS-Office365-Filtering-Correlation-Id: dcfec0c1-9749-4b4e-5703-08dd82d09a90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?U0HLsLUEKRwtm8W0lNeWi5kncMZczbNkRh/VqsHQc+TTSdgZ151I8bAxz/N9?=
 =?us-ascii?Q?Ps6dhziP5+aGqoKcy/Qd25W1URs0spaF+p/tJhoV1nt7UESL47PB1Bfq7gzV?=
 =?us-ascii?Q?Uu6P+YaLqRWgxKAIYzXLwWQ8iGfPaCydChTXar8vbqL2evoz/3eJ9s2omUbQ?=
 =?us-ascii?Q?z2F8iLKgMdq7pKTlGnLrHQL3YmEWUL4bV1pZuzYBP/8YtcYrEK2mElQuI+eZ?=
 =?us-ascii?Q?5pepHmHSAzJwal+JvNnxU8r7uaWxOF7q+MseAqbnGoE5wh8un/38sRYIQTr2?=
 =?us-ascii?Q?uWf0qWOzVWSEQF6ZLekMdLkyU4/C1geHXabwEmdLJrJLnEQdPZ9i6lBOtlMq?=
 =?us-ascii?Q?vTZNYm1fu/teUHoOedIVDLfQLO1fp5XmR3ORKnXzexaJqKfOv5btLfNYK5lN?=
 =?us-ascii?Q?uA8+2hRicPSKhMGSc2gyiT3AC3nx//X5zKPRseTJRSGSBsyEhcISACxyTBov?=
 =?us-ascii?Q?1fVsXLHE0mxJIrQv3SZHbEtX7lBLLbOS/hETkRWfOvyf68HtR9aGfp2cf064?=
 =?us-ascii?Q?iillhAjoVPpN1uS5fJAwz+ljssppunLjYTo0Dj3Bpl7PELgHranuwF1nyVQZ?=
 =?us-ascii?Q?DIJvMAkOLP3LmvrZabd6Df4h8B9REOIIDI1i+ftt5bkZQPkvu0RzJW9mmJvD?=
 =?us-ascii?Q?C8Y1i+s/N3qaAl4CIwEeN7BSs4CQUfbPZyIUmT80mbjritKb+U2E5iVFhYGs?=
 =?us-ascii?Q?iNNNXpZgviA1LsR9A8q/U/ae5RFEUjBd29eLcLhSvzu82zv6CHMzBXYIOSzR?=
 =?us-ascii?Q?XyPPkkdVHyYsY5clM6w2wMf/BZ86goZsgc2OaewiAayRsvI9AED+qBt6hj6J?=
 =?us-ascii?Q?TPFh/S3Qeo0gkrcWXCrUzpPLNl7tbQhlTUNFQ+5g31mKob/XKXXyXlg8JmqV?=
 =?us-ascii?Q?/Yk7FovYbAh9BR6sONakpPj4EBYyEke6ZH4hiuxH7vgjz3dO4ec0ebithvRp?=
 =?us-ascii?Q?8L2hnRf9P2y96PTa6KRbO870NTRqdhb729DvkBNK03en1kfW8YR5NsFpr/Cp?=
 =?us-ascii?Q?YRJp7P9HXmqXIV6LdLfRULQNRbgwj8MWNzB3gTBsj1UNtaUM22xHyqSvHTpz?=
 =?us-ascii?Q?bI3ITlx2QrGwPysBOk7VLghQXXQjY0aI5Vja3AukVVcdNGIWQSvvgxbWBRE5?=
 =?us-ascii?Q?EyOLeDC5vmP5zkHiJhus6JH75hBCEu7Smhm4d8pY0r6CXDLxdyMGioqKa42E?=
 =?us-ascii?Q?jisPTkJMl/QBXiedAua+ozwiVKBOiGMmnC5fzSwT+ytkSOXZado8xfhHz7v2?=
 =?us-ascii?Q?InERYfg8i28QLOCyH9Gxlqvk8u4EnoMEpW5yUAoJp27LSPLvZC74JslrMdOz?=
 =?us-ascii?Q?PFHvNiRCliQUmKc5kvbGq8JtknEOuzTjw673i2WximgsP8CJ8PXtG+rkjIEg?=
 =?us-ascii?Q?IxVdNVoFT6jRmgmGvU0Idfw6ZdjQziBdopxdImLxKlGK0/cBee7NpeJ9wE/J?=
 =?us-ascii?Q?8Mi9V+wCQYl8nX+3dMxCh3UibTNs/jm0dAkY9zE0drmhWyukaHaXUw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xsfOyEWvHco7J2pYAqBkDh6yPqI0IgBe0qzHCqp5afHFMOQQ5jJgtmv813tf?=
 =?us-ascii?Q?ZnxZMNr21RHVimoiIjdNFwoKEYZ4wqFWJwi6Ao02o0LBVk770XXIuvsyhQrc?=
 =?us-ascii?Q?/v+8I/s++Q/vKXrgaeQqrSBtAc2R/6z97/pWwdyf6h3E29uGNUFennqenChq?=
 =?us-ascii?Q?H6hD1aaZQcPOcnim+SHnUdaqYj+IQwYr9IByJHRFABcidpnNM/vj5sO6DkeB?=
 =?us-ascii?Q?5oCFanDmxLwlJ0z7OaNRaCW0nZn8kygZ4FrN3a4EfmPb6i6AtJI1U2Fpa2NO?=
 =?us-ascii?Q?RslT1AMs62p+zPGKvYFNjWdX3RLHb8qK/C+BQnm0a+sMNPpm9TQdEv42Zpwj?=
 =?us-ascii?Q?3ZwNfrsmj5JvcgSt8GF5Ow4W3bxc6YC8dkgk8K56PG2HWB88tYm7KHADoU7L?=
 =?us-ascii?Q?QvV/wl/XjAnHvDLST/KNpeT8Bi9F3wr1OBj6s1TMcfpdNt0fNPEt3ZgO0JAy?=
 =?us-ascii?Q?Kw6Xpkv+ac5jBzPTJOUlPE+vDtDmYbmkilEBZmvuM56n/aSKOiFC4Y3bWupz?=
 =?us-ascii?Q?FKkgDqZ5tMMw/LLlz1k6VohWcXR35tlI9hdgSC4H2KGzvzu+2Oc6hX5DQLVp?=
 =?us-ascii?Q?MniIjq+pP0rH5nfM6Q+ANiucQn4UY2uiJTbQUTCOkhQLXKPWllA0UIsLPwvn?=
 =?us-ascii?Q?Oq4fj/l4EfEZ55gUPL11iDx5RV3XkllO2H2T7PUKJ2PK3hpnCzqWrD+CZK+0?=
 =?us-ascii?Q?TLRVLVT+4fCHZnkrXGCm7ZGABdVtYsgBxx51HCzc3Z3fjs5WE0mh5Xl6B/wf?=
 =?us-ascii?Q?fAgPls+ZMqd5VHBdhpH5OxgV5XwZMhmDHMhBoAZlOrYzFRSkH+xTdbaPwxvO?=
 =?us-ascii?Q?++te/KIqH30ftJqbE11ca6xuxh5OMx6b45TDu0NhxUY4Sgio6GmK+8bpheS3?=
 =?us-ascii?Q?tgVUGVxtdSJWbOUopqOdggZ2Dkgb0v8SgJMI/fW2l21lJwJuVpUD3KV1AF8f?=
 =?us-ascii?Q?K1b93QNPe5bANX2xcRh2TFvBuBYabsD+r7FBHVTbgrepGs49a6H7BReX6uLI?=
 =?us-ascii?Q?gI2/ii9hrO6xwgOhis8gH6Y1ab3d8Ogk85Ij0y6OWJqzJ4aLUOXDLEytsBfo?=
 =?us-ascii?Q?9pRmlN3grQghSj5s5taEpkx9xBbEjztT1APn1kZ93A1diXVbuFgBUDJJM6+N?=
 =?us-ascii?Q?/8iAv9aMjXQJDPhXvKgYf+DILHACqtH84JvFysqik4TbumtNlbDwO3Vh8v13?=
 =?us-ascii?Q?N16fJwh5uRLQ+RsSR7/BiiOLLW6jFcUWsSbzv1vEsWO9WqNMEop4xxtpPsw3?=
 =?us-ascii?Q?tkH+P82ERbaeEyfT8c2GFh8v0AW79D3SBKrfJf4cR+RUD8iXebFk0BuHVI+L?=
 =?us-ascii?Q?M2LTJ8MbmCkvz1vNfNw5sU52SkAQ52J5IRczWb2y8YO4sg93zLKgl4GPnxBy?=
 =?us-ascii?Q?BzumiFi2fUnt0rCxf6UBIUxBVqRcY4hDaWEsuQ4WCegbqUlgCW3Gaj5Ou7sh?=
 =?us-ascii?Q?g1/DNLCwG+WbZn6ya5wixczUSh4F7eFLiRf+bxo7ue4dkyGo/oK6OJc06NOc?=
 =?us-ascii?Q?SO2/BUNpGgcs2Z8j5I39xsU6vfr6GRh/thj0GT57SbF8Yo4nLJh5+SiKB38I?=
 =?us-ascii?Q?QWsB0IovIIlC0aVGYRTwjG7Bgg+S5I/Qr9BKa7UNQt+zFq5wgOS3w/Sp259I?=
 =?us-ascii?Q?Qw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dcfec0c1-9749-4b4e-5703-08dd82d09a90
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 01:37:41.6369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NT3gESrPAnXS2cIyG57g0C5/tzB+AiXF8ZrEmMpoQ6vSvQj+4+7Lw0jZv0uNOo/+VxlJuS2dHtvcEjUurUfgkSVSWsGZFWySzmEBC9l4tg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6092
X-OriginatorOrg: intel.com

David E. Box wrote:
> Replace the manual definition of the dp0 attribute group with the newly
> introduced ATTRIBUTE_GROUP_VISIBLE() macro, simplifying the code and
> improving maintainability.
> 
> Consolidate the definition of dp0_attrs and move the attribute array above
> the macro so that they are visibly tied together.  While here, also remove
> the unneeded trailing comma after NULL at the end of all attribute arrays.

I am generally not a fan of "while we're at it" clauses, but this looks
ok.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

