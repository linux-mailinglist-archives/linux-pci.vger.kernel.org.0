Return-Path: <linux-pci+bounces-18939-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DAD9FA4D7
	for <lists+linux-pci@lfdr.de>; Sun, 22 Dec 2024 09:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C537166DA6
	for <lists+linux-pci@lfdr.de>; Sun, 22 Dec 2024 08:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07D417C21C;
	Sun, 22 Dec 2024 08:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PkCb+vyk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4733FEEC5;
	Sun, 22 Dec 2024 08:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734857406; cv=fail; b=nGmhyBOCK4aMc19Wr8QQfL39oIcREQswN1W7B4nEk8kQJWEyKFd+M3QD49lebPHKY4lz174pFYST+i0F8Wz0xlX7VjO16YtlhG/JhprTSMSfSx+d2vmaUKVAfdMMcDg2WP893CWyXkcNdgko5wxvZpLgXA7IsUSJMWoCTv+2Nd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734857406; c=relaxed/simple;
	bh=0ePlseQyUgtqY8TPlM9jQUMLbCRc3I+lId8P4YOQa3o=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=byyole7QEkv/URUNYe7chLN0ay9rCWbme3Kjfia9selzci4h+VP5L38mIyzvq3pZuhFs6kWeZzQcBUxduubAgVeJNAm+U6UvKdI4htpv0Wes3kBsIUJjdm6pGJ34h5cgz52wLLGrAM6zn+9YCV3IF4mssGhEWOBNqFGmIPyTLfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PkCb+vyk; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734857404; x=1766393404;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0ePlseQyUgtqY8TPlM9jQUMLbCRc3I+lId8P4YOQa3o=;
  b=PkCb+vykc/l/a4nplfpkjvhgt2YTVNgVOqIQa55uMcYP2bvyvYERMD6i
   w5kddlkasJGreSSU4RiXn4uT9Es01f7OtGMVY9eDxDoQ/OUcuCT3vP1hL
   T4jxBbllNvqX4xqgNSuN0PrmOZtQ8JopXSiw1ddgsAj5p5WlG0m33KP77
   ikgXG6gOCHNjsHEtGAU8rT+FYH1J807gR480ZMCOi0sXoiTaIoiZLnD51
   Vf6RWDxrFv7VQv+lEectr1zkBOXGI21RoNg9U4LoGzTYijrNcCG05ea79
   tRSdNajG5jNqXufb1ntNcHvXSLN7J8hAc0GFuQz027K8eLohAc9k/MrQ2
   Q==;
X-CSE-ConnectionGUID: oV7ByeTwT5+KBhNYmSgYqg==
X-CSE-MsgGUID: BLphHmP/RNOEMjiSNAn5EQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11293"; a="35511183"
X-IronPort-AV: E=Sophos;i="6.12,254,1728975600"; 
   d="scan'208";a="35511183"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2024 00:50:03 -0800
X-CSE-ConnectionGUID: LtnjahBQSm2THwc9Vgn7xg==
X-CSE-MsgGUID: Zz0rIz7zRLGAfd3A3Y0nRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="98770807"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Dec 2024 00:50:04 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 22 Dec 2024 00:50:02 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Sun, 22 Dec 2024 00:50:02 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 22 Dec 2024 00:50:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IxBn5UIhFJq93VtVplM4sbDL2Mw46Z5A2pvSYEOWF+qP+ohoCNcPRICUSIH+/C2KRei/KAsf+j//LK3ey4mwtSkO/kHelvOaPFw8QlvP5H1MoDqd9NZslMEiNfMhqivtN3j8r2+eLwpeEjxvTSxdO7luUrR5cAOvt8dIYnUj6C00a280esuaC8OrVy25fwpeD8sX5DOHyTGNxNysu3LDTJGxSt4PqQq5E3g4esVK+fmdkyu4f7tmyMmoC//CuNYWD3DTgNhqNw7J4ODmZUBtyV2lPdCaPmdP9LoLjNySHeKuVxEDjUob+f8/wRWparPRDI22SSH6TtJPB++Mw5NwIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXRMAEOEV6CM1/mSFk95peWCTNpRK6e4p0yq3RXVDsk=;
 b=V18fzMBp9RTZNKrfnqheoO6Q9dcwX993NK2bcWCeFQIl7JB5smZeIP3uBuf13fQ4xdUjjZPhdRCzx+ZxqfwkxbVBaZC6t+2SL7lHGS0MymRXIkjMmFoDl3sQ+lBXg1tIDmg4UsebMKz0hy/DEYq3l3QFD1DIufjMrKnmdP+vEMhjQNelPgnTLlMAK+2l9O2zG1FuQ1bQaRAe4rGoEiJg6CnkU0ZAFtN4B0Ke886pm1BPAeOhZ9IrDx8DZy1H5dMuoI5uSYvBNBrqr5Lw8NwrEQDGHe1RDWYOpVKf+/VPwAQiZDbtlD2WNM+OSfKwdwW0gnwTSohVDRreJ7Fs11+Brg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5949.namprd11.prod.outlook.com (2603:10b6:510:144::6)
 by DM6PR11MB4530.namprd11.prod.outlook.com (2603:10b6:5:2a4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.19; Sun, 22 Dec
 2024 08:49:50 +0000
Received: from PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861]) by PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861%3]) with mapi id 15.20.8272.013; Sun, 22 Dec 2024
 08:49:50 +0000
Message-ID: <97ae6e74-3b4e-46ef-a8f2-937bc7fd393c@intel.com>
Date: Sun, 22 Dec 2024 10:49:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v4] e1000e: Fix real-time violations on link up
To: Gerhard Engleder <gerhard@engleder-embedded.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
CC: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <bhelgaas@google.com>,
	<pmenzel@molgen.mpg.de>, <aleksander.lobakin@intel.com>, Gerhard Engleder
	<eg@keba.com>, Avigail Dahan <avigailx.dahan@intel.com>
References: <20241219192743.4499-1-gerhard@engleder-embedded.com>
Content-Language: en-US
From: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>
In-Reply-To: <20241219192743.4499-1-gerhard@engleder-embedded.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::13) To PH0PR11MB5949.namprd11.prod.outlook.com
 (2603:10b6:510:144::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5949:EE_|DM6PR11MB4530:EE_
X-MS-Office365-Filtering-Correlation-Id: ebe40e9b-9c57-4b1f-586c-08dd226598ab
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QnhzSzZ2N3V6VElHbUhYZldLKzR6blR1SzhOTk5yUFVIU1JnMWdURUhOYmk0?=
 =?utf-8?B?TTVUdkxpM3JBMjEwT2J2dWdScVA5Y3hRbFpTV3gwWFlyT1JhdEN1ZkFsWVJR?=
 =?utf-8?B?YU15YXlDcFpPOGFrWmVreHowUFFHbzlhekQ5eFhpTkNmczZHekJHdk5WS0pB?=
 =?utf-8?B?YmRvblc1TnBmQmg4UXVtUUdzeHNldEpya1FzQkF0Tkh3L3Y1MlpDUmswY3JJ?=
 =?utf-8?B?b1l2MXNMRjVsZ2Vkd0dHLzh3OHlhcktUTWVrYnc0emc5WVNKdTJFc3lqZ04w?=
 =?utf-8?B?enVHVk9rS3kvN3dmbURyY21KK1gzVEp4a2txNXdpbnhvd3FIa005WU40NDJF?=
 =?utf-8?B?OHU0QW9xNElscDNhaktNQ3k0THFtcXkycityTGlMSUhHMmFNQnlDclNiRWZi?=
 =?utf-8?B?OVduL21KMDJwelp1Z3BHZzZndU1HenRsYWEwK1k3ZlI5eERJYXZhOEkxeUJS?=
 =?utf-8?B?Z3dFOG5Ka2N4cWFFWitFbkx2c1Y5Y1Z5TTVYb1R0L2ZkMEJJandlYTVaWTBx?=
 =?utf-8?B?M0pVbG5FTW1LdmppSTJLamFnQUhCN2RKczZicnlUT2FLQUZhL29rOUVPdXYv?=
 =?utf-8?B?V1JkelNhL0I4V09RZHlnZ3VSblZ0U29lMHFTTDdMTllXQ2prT1FvUVBRWW1m?=
 =?utf-8?B?QnJQRDNma2N2ZzR5ZGtPbnJFQ1BsaWtDekZBaWhRTnhqRzFsWjFKTUxLU0dL?=
 =?utf-8?B?ckRlQmpIWmZtaXQ4M2h2T1pzUFoxVmRBQStDUTB2ckpjazlobjN4UW42VjlK?=
 =?utf-8?B?RE5GN0haa1FXdEw4MFVKUmlKR05RNlBUZk9FbUtWbGlRVHNJcFIvWmdLMVRT?=
 =?utf-8?B?WkdjVUluVGJMTDNHM0pSeW81dHBaYzQ4WGhzSUFvZm8ya2VSTnVrb25ockNk?=
 =?utf-8?B?bGdNNjFVMHZRUG9GWmJqRzQxRU02Zy9ZRUYxNDgwQlpJTWNveXNhOHF1d3I2?=
 =?utf-8?B?UHp1NVQ4TEtRVkNUdVl3SmN5citmV2FSS2xVdFF2cDA5V1RURUhwVXdTQ3Jz?=
 =?utf-8?B?dDFuZWZTV3lRaXJ6TUs2VllwSzJTbHlzNTNTaThQN24rSmgxVS9XS21TdWVv?=
 =?utf-8?B?K09FSUNOOWp3UXhDczMxdlFGM0UzV2dYSTJsamxXSmJtbGw0VjlaYk1CVEh3?=
 =?utf-8?B?RG5LQXlJdjhDVm9BQjMzUGdzcXdMc0pNZng2bmtZQnVFNFFPbURKZWFiTUdl?=
 =?utf-8?B?N3VDSWxYR2pQRExEWWNmSTF3RG1leGZMUFh2Z1BUbG9rcGMwTEpEcUdNMEx4?=
 =?utf-8?B?WE5TQ1dXSlFDRGxpTkRqa25sQ1lYWHJJcXJ0SjFVSFNTcVRsb0NGK2NnRDhy?=
 =?utf-8?B?OXNmZXRuSEhFM3FTMGdUdXVrcGFrUEZGVVFsWG40WG9DK2JpQlpaUmp6YnJ5?=
 =?utf-8?B?N1U2YitwUXkwS2Y5aC8xK3pEU2RhMjRrZUROcksyVWl3U0MyaEdSUzZJVUV2?=
 =?utf-8?B?VGhwOUxTNXRDaUdsanVzcnZRdzRJcEs3VTZ2dTkzVHBITWNzL0FXTXhKaFBa?=
 =?utf-8?B?eGpjdng4b3BZYXIvZGdoMTIxRTR2c09FODBRS0VBT1F5VktialI4S2pRSkNG?=
 =?utf-8?B?RDVnVTJnU1RTcVhzRlpxd0tTaktrQkR1eW5yQjFQNHdRRk5SK1lyTFNKSXdI?=
 =?utf-8?B?L2JJOFVqNFR2Njc3Y1RWY1lDRmRqQjQwMUdqTEJNUjFKVDkrRzVLN0F5ZnE4?=
 =?utf-8?B?R3Z0dWxIM2taclpOUVhReE51TmNzbnBjN0QvUzNQUkZJck5ac1lkU1JhN250?=
 =?utf-8?B?dXhOSzNmSzVqYVZkU3BhV1dEYjVBQnN0SFd1K005QVBLLzEwS1o4cmpEMUtm?=
 =?utf-8?B?UEJqRVBGeUN0enp2aDN4QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5949.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0hqbVRXZDU0TWx2S0lzaGpUZ2RYRFJmZjhDUjQ0ZitZNzV5RmFyaWVRVWdr?=
 =?utf-8?B?UVErMVJBVEZyUnFFcE53WlpBQVVxd1RvMm80RXlUV29IakwzSUJBL2xOZ2tE?=
 =?utf-8?B?VFIvamVzamxIWGUxMXlkTlgxcGNlL1ViWk9BNkZ3VmVZenVsY1dWbitKMGpB?=
 =?utf-8?B?NWcrcFY2Z2RTU2poVmJZRnFxS2dTSG1ub1ZhUUZST3pLWE0zRkR6MWJpU1pr?=
 =?utf-8?B?K1dHeFVaTzRyNFhILytudjNXM2hlam9lZTA0NSs1c09EN2VrRHE2eTdkVm5F?=
 =?utf-8?B?SW43dDZkRjNNaUdhekRWVjRlV3VjL0tydWFIS3NFdDNUcWJhL092V3hLUHI4?=
 =?utf-8?B?b29keUw0ZHZaNk5ISHVCSkpwdTNEODYxdVJRYitUSzZFZnhuaVJWWW1UMkVp?=
 =?utf-8?B?dGZGaStaTHNHYm05NGFqWHBwNzZGdjlET0VtY3BZVnFpNFlDR0ZDWlhwcW1M?=
 =?utf-8?B?WG8vN0ZSbHlLdkNiUHV1WUl1TUkrWHdIaW1VVEpkVUxtZzZCckpmQ3lHVkNp?=
 =?utf-8?B?WjNnK1lpU3MzNmlXQWJqM1o3SlFiT0xaT0N6SjZta2pRUTlYSGkwOWp4VXFN?=
 =?utf-8?B?ZW9zemxuWjlkY2ZodDdQT3NYRlhrNGNhWlkyeXBMc1BFelJtdnljbXgwS3Rn?=
 =?utf-8?B?WW9qMmxqOXQ3cFZVVEwxWDNHbWI1TndBc2MySXZuNCtrZWprajhsd3owN0JF?=
 =?utf-8?B?SjNJc2hodnMrb2NBaElyZzJVRTB5bUJYY29Fd1d2bFFKSFRwQ1hXY0hxWExZ?=
 =?utf-8?B?WHAvbTROMmJtQi9VK3hNZUxjWE1hQlN6eEoyTGZMLzBiTWY0SXFtVm1Idm5P?=
 =?utf-8?B?UFgrTHViN2pSR1ZqbWtxWFdjSmJ1b2J2a3dhRi9VbFZCeEJDYk5qVGEwVnVE?=
 =?utf-8?B?ekVZT0dOSEUwNkM0cnVIZlp2UEVvWFhBY1V0a1dSRExOT0NqWEFTUnFpaE9Q?=
 =?utf-8?B?STVZRnhoL2hxczkyaVJValE5cUEzSFpVRHhEcUNObGpDR2dIb21id3RFRkFu?=
 =?utf-8?B?UDQzOXE4WUVIREdNYXRRYmlHMDI2N1RKNnNwUVRzemwvenloQk1EWWFoV2pz?=
 =?utf-8?B?UkpHOTNheENQcFpvNWRibHpqM2xPV0ZmYTUrYnZzdFZtUFVEdXdmbDMzY2tN?=
 =?utf-8?B?RWVxRjU4TmVZTlF1Nm1oam9GYjIwazBNaFI3NE93MHZoRnNnb2VUSW1nT3FU?=
 =?utf-8?B?UmduL1gySXI3WE0rR1czQkRBSDNPK25rcGlCcW1YclV4cDdLUWxUUWxGVmlO?=
 =?utf-8?B?TkJ6N1g2QWVGcHQ4VHd5SEs5Z0tSbFpWT3lPT0NyQ2g3K1B0WDNHZWJXVVhC?=
 =?utf-8?B?a1FsMWZ5UC9GcTBWMUVnTVZKMUVMRlRzK2VXSCtaL2crNFBWUE9KNFZCWmUy?=
 =?utf-8?B?MU5FbHBOaERoUXZDTFhjOFJkd3FRMndINVUwTEdxS1FZVTUrWVJQaW5hb1V6?=
 =?utf-8?B?SGtVbEJGSGgzVWhHV1JLR2JNMTRlZUlVZzJZbDA0SnZOdXZSZi9DMm85VWNT?=
 =?utf-8?B?eGlROTJhQTBZWVBzR0NRUitLVkNsSzNsMU9iVVJXY01vRHBaREpSWDJ5NzVX?=
 =?utf-8?B?SVdhTmdvRGFuemJtd3p4QmhjaG9JZ3MrU1NmcWlTbWY5dzZFUlFQV0FPU0Jv?=
 =?utf-8?B?OE8yVGNFSnZsTFJ6alVNT3c4b0VCNGJNRFg0TU5wL1JMN256dkJPamxqS3ZX?=
 =?utf-8?B?QTFmV05BWERReTVBSUoyU1dCT29zMFp3RXcvR2dwUzZDRnc4ZkErQzArREQ4?=
 =?utf-8?B?Wi9pT0JwODlkNU93aGs5dkF2akZoODR3T0tWNnpQYnpSeGt2bm5hUHFiSnYr?=
 =?utf-8?B?MG1yQXJGT3VLajNTT1lTZVBycmt0V3Y4aTkyd1hPVFJ2WS81bmNyNTVCcWNQ?=
 =?utf-8?B?OGkxWXNrb1kzL0pYTmx2NWN0dVZ1VGlpMSswcS9ldGZaZDRzazBqa0hVeU1n?=
 =?utf-8?B?aG01OTIramZiVytyT1pFU0xwZW1VcFpXb1gyQkl4eFg0ZzhHSXVlSWFMS3Qx?=
 =?utf-8?B?MzRtcEZTQ2I5Lzg4RzhkcVdPZkY5aTd1OGdTeENzaVBPdTIrTGZGdjBVTy9j?=
 =?utf-8?B?SVM0eU40MWYzTktYeWg5cWg5Zjl0K3dHQ3ZMNkplUUxrZ1lDVkdVUHBVM25W?=
 =?utf-8?B?QlFnVlFXak5DM3BodE50V1o0Rzcxbi85U21zRDhTUC9LbUwzRTlmQWhMbFIw?=
 =?utf-8?B?T1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe40e9b-9c57-4b1f-586c-08dd226598ab
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5949.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2024 08:49:50.7699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: obvt5JJQ/LMjZlqJE3zg5fDrJwNNSw4VhnpCHQfYMqXZ5oFqEzkziwgmenGRawuHnSkOShVKsjJWGDHrOhWzkUvDtklOfANCn8abkyTcXwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4530
X-OriginatorOrg: intel.com



On 12/19/2024 9:27 PM, Gerhard Engleder wrote:
> From: Gerhard Engleder <eg@keba.com>
> 
> Link down and up triggers update of MTA table. This update executes many
> PCIe writes and a final flush. Thus, PCIe will be blocked until all
> writes are flushed. As a result, DMA transfers of other targets suffer
> from delay in the range of 50us. This results in timing violations on
> real-time systems during link down and up of e1000e in combination with
> an Intel i3-2310E Sandy Bridge CPU.
> 
> The i3-2310E is quite old. Launched 2011 by Intel but still in use as
> robot controller. The exact root cause of the problem is unclear and
> this situation won't change as Intel support for this CPU has ended
> years ago. Our experience is that the number of posted PCIe writes needs
> to be limited at least for real-time systems. With posted PCIe writes a
> much higher throughput can be generated than with PCIe reads which
> cannot be posted. Thus, the load on the interconnect is much higher.
> Additionally, a PCIe read waits until all posted PCIe writes are done.
> Therefore, the PCIe read can block the CPU for much more than 10us if a
> lot of PCIe writes were posted before. Both issues are the reason why we
> are limiting the number of posted PCIe writes in row in general for our
> real-time systems, not only for this driver.
> 
> A flush after a low enough number of posted PCIe writes eliminates the
> delay but also increases the time needed for MTA table update. The
> following measurements were done on i3-2310E with e1000e for 128 MTA
> table entries:
> 
> Single flush after all writes: 106us
> Flush after every write:       429us
> Flush after every 2nd write:   266us
> Flush after every 4th write:   180us
> Flush after every 8th write:   141us
> Flush after every 16th write:  121us
> 
> A flush after every 8th write delays the link up by 35us and the
> negative impact to DMA transfers of other targets is still tolerable.
> 
> Execute a flush after every 8th write. This prevents overloading the
> interconnect with posted writes.
> 
> Signed-off-by: Gerhard Engleder <eg@keba.com>
> Link: https://lore.kernel.org/netdev/f8fe665a-5e6c-4f95-b47a-2f3281aa0e6c@lunn.ch/T/
> CC: Vitaly Lifshits <vitaly.lifshits@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Tested-by: Avigail Dahan <avigailx.dahan@intel.com>

Reviewed-by: Vitaly Lifshits <vitaly.lifshits@intel.com>

> ---
> v4:
> - add PREEMPT_RT dependency again (Vitaly Lifshits)
> - fix comment styple (Alexander Lobakin)
> - add to comment each 8th and explain why (Alexander Lobakin)
> - simplify check for every 8th write (Alexander Lobakin)
> 
> v3:
> - mention problematic platform explicitly (Bjorn Helgaas)
> - improve comment (Paul Menzel)
> 
> v2:
> - remove PREEMPT_RT dependency (Andrew Lunn, Przemek Kitszel)
> ---
>   drivers/net/ethernet/intel/e1000e/mac.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/mac.c b/drivers/net/ethernet/intel/e1000e/mac.c
> index d7df2a0ed629..44249dd91bd6 100644
> --- a/drivers/net/ethernet/intel/e1000e/mac.c
> +++ b/drivers/net/ethernet/intel/e1000e/mac.c
> @@ -331,8 +331,21 @@ void e1000e_update_mc_addr_list_generic(struct e1000_hw *hw,
>   	}
>   
>   	/* replace the entire MTA table */
> -	for (i = hw->mac.mta_reg_count - 1; i >= 0; i--)
> +	for (i = hw->mac.mta_reg_count - 1; i >= 0; i--) {
>   		E1000_WRITE_REG_ARRAY(hw, E1000_MTA, i, hw->mac.mta_shadow[i]);
> +
> +		if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> +			/*
> +			 * Do not queue up too many posted writes to prevent
> +			 * increased latency for other devices on the
> +			 * interconnect. Flush after each 8th posted write,
> +			 * to keep additional execution time low while still
> +			 * preventing increased latency.
> +			 */
> +			if (!(i % 8) && i)
> +				e1e_flush();
> +		}
> +	}
>   	e1e_flush();
>   }
>   


