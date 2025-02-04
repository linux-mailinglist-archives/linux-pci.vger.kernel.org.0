Return-Path: <linux-pci+bounces-20716-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2D8A27D2F
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 22:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9F153A4294
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 21:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FF1219E98;
	Tue,  4 Feb 2025 21:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A6s77Az2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092DF25A62C;
	Tue,  4 Feb 2025 21:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738704135; cv=fail; b=sJHA1zRu2/dg+MRDWu0tpReBZQzUg+G3xtt63VMqU2MYpJmSzsDnTMYOtNfj4arCe5FTbCefueMEw8fK7hq9zgwfMdlKb1pr/IIdOHwJkRQ41h5+tKIDCR2Hy9Pa/aS/tyMKFxeuEiTjb9BWLpxZX+IRDuHPXMNcq3Y2PXZ7n9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738704135; c=relaxed/simple;
	bh=gS/2N6CowSdjakmR7aqekbqlsOck5tH4svqFfZpzN0o=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=enEXMFtyE7H0A8hUwVJ/BBgc6vtIGAx8LSc3Ui6JkWExITRWgJihC+PU1CE6bZnbDwZ65Pv9PcDLEoWJgCHpAOhzXb8dCrpuj6By3p3wqq9BDGZB6dWNbsHmnA4tPEf1q7rnT1OO1Z3CdJOcCqHCkVNXoTYSPCKe4A28qzt2J+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A6s77Az2; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738704134; x=1770240134;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gS/2N6CowSdjakmR7aqekbqlsOck5tH4svqFfZpzN0o=;
  b=A6s77Az2tjhryzE/hE3juZSLMoR+eg/pIKcB4dKWdaoevLQbbd2zmYph
   8G2lTJvbF99K0EzA6wpU2N7UnpZJU1sbTs21O2sHQ3x3nbEfaz7Ke0WdF
   mKvi4tQKV9jtPrL5pBgx8mVLdEP71atDIpd2S6bZ25rh6gboHhNG45A3u
   kKns1C3A8ubNgwMDNxosED67a3Xkc41CR0YWn9q/QHX1mPOcdeiChxwAr
   EhTgHHMOorzUPPRjInv2ydERd2Ndov9fB7QBQJ3EEjcjByg47g7OremEV
   RsVFDOpIZHLbf+wEX3Mkz57EwXsHaRIjOY0PcFnOdQsY3nstF7EzExXl1
   A==;
X-CSE-ConnectionGUID: kKiQ4sf6T1mQrzDH9HVUXw==
X-CSE-MsgGUID: /QdM7A1XQ92BTIaudd4PZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39154332"
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="39154332"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 13:22:13 -0800
X-CSE-ConnectionGUID: Jt2huqVwRaOoE5b2SPO9Ww==
X-CSE-MsgGUID: ZaXGtu1dQI+m/2psT0t+cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="141572991"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Feb 2025 13:22:12 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Feb 2025 13:22:12 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 4 Feb 2025 13:22:12 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Feb 2025 13:22:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yubrW7Bj2BfRlcS9slo4Yol+eMDZGQVF31+yc2/5IvVKCUf3pXwjEzmRBpYat/cQUm3E1MJi2fLbTlaQUd00SCEhO95CO9f7tM+KMjQO9MuIxmvai83VxtCwdo0z3q4CNJxIoSU1UAWcyRrLAJJgwTPl9zVCFG/RW0eVfz0FdHZ0Z4J85cS/69wQ1sdrpqC4zgmTjK/bj3HlqfpL9v/DejWTAaDnKMTSDSgRzKM1LPXcUwcB+4WpP9/rCVDuIr2DKnJKayvU+/bvHWsz1tq4QKp9BIxlJ28dos7qO60iAJ76IvC3qY/PNob6OOawYYPJzlWDdmdJUegsUdzGWUO9/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=caniFS74vkqx6FGFKwr6aY970jz8Vj4i3kt5QsmDFw4=;
 b=es67/fMrRHaSziC9W8uIhUOvyCe/3TwfppUlX9NT/dkZIfRiZIhT2i0uIfnC5h1+evpZf8RPdMqo2Ly27uM6V6FMxgJcSrhW07TqU1OpmHg6I2meP1E7yFL1lm4fDEdnpTRezW12+W4/8fJTy/43i+qQKEtIL0wE81jMu9ADsNngpUpfqWslDBE5Bod4yLg1I2MkqNifVoF14cweNBInuiSntm/POrxueHzOGrsOJKefiVYvg0kkMVoYg4njHP1FHuXUwfUr/5dPgTTuCHnhqiiX8Zjq/6NCQf+q+7bIgQrD9Zd943qH1rDiZiEpcie2SXiY1VDi9zFKxsTNMSp8Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by BL1PR11MB5956.namprd11.prod.outlook.com (2603:10b6:208:387::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 21:21:33 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab%7]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 21:21:33 +0000
Message-ID: <5a3f047a-9183-4c5f-8ba8-bbc3b28e1786@intel.com>
Date: Tue, 4 Feb 2025 13:21:29 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v4] e1000e: Fix real-time violations on link up
To: Gerhard Engleder <gerhard@engleder-embedded.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <przemyslaw.kitszel@intel.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <bhelgaas@google.com>,
	<pmenzel@molgen.mpg.de>, <aleksander.lobakin@intel.com>, Gerhard Engleder
	<eg@keba.com>, Vitaly Lifshits <vitaly.lifshits@intel.com>, Avigail Dahan
	<avigailx.dahan@intel.com>, Simon Horman <horms@kernel.org>
References: <20241219192743.4499-1-gerhard@engleder-embedded.com>
 <20250106111752.GC4068@kernel.org>
 <bd604c16-0f5c-479c-aa13-932f1570e5b5@engleder-embedded.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <bd604c16-0f5c-479c-aa13-932f1570e5b5@engleder-embedded.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0085.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::26) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|BL1PR11MB5956:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a208c4a-8091-4c72-1b6a-08dd4561e62b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjJjdXE3OGttWG9rZjljV1crR09lenZLalFDM2R1ekgySWN4MTdsbThaM0lX?=
 =?utf-8?B?ZHREbjBmRzVyQUlRQzlwUGwvcFJlNXRIejEzSEFrZk02QmUydjJYakRxVzJN?=
 =?utf-8?B?dDdZZm1CUk5uUzV0S3U4eWpZTmNzYlVYeVhGQlc3SUhOK3lxdmdnSlYxRFdn?=
 =?utf-8?B?MDVhUldqY1I5NVh6ZlFTcjhaY3c5aDR4ZGxLN1p0Q3ZVY0xLZzhla2RhZlFK?=
 =?utf-8?B?U2ltN2kzSFl2cDkxakhKM1pvL2V0QTA5b1ZOdXg5TzVVZXJYcGdtckVNQ1Na?=
 =?utf-8?B?RnRJTWxXTkNKWi9ZTytYMUljbDVZOVpQS1REbHVUVjZkbkd4UDNSVU9pUGtH?=
 =?utf-8?B?c2RQT3BSVXo3WnN5N1Nkam0ydERPWXVMcHlLbUprZDFZVWthdHVLakxjL0Rh?=
 =?utf-8?B?UzIzNXNsSHVhcUdkVkdqN3RRaEFNV1EydXZ4U2lyRWxRaWI4WXBtYzVlTUNI?=
 =?utf-8?B?am5SV2FCU0hsMW1yY0N4a0xGOTNVQ1VxQ3JiSm5aRGRXYkJDUktFdWNxalMw?=
 =?utf-8?B?RkdGRFdzeXR2cGhyNkpDclNmWS9oTlNWY09YWDZTRTlsbWt0T2VVR3V6a2J6?=
 =?utf-8?B?TlJsdDhCQXVRT3dKbWhkVG8vTmgyN3piRUFYZXdqZU5QMXJmWGNFUi9vL1kx?=
 =?utf-8?B?Ylgzc2tjU3AwOU9uWGJkbjhGZldxdmg1QTEzQUE0UUl4a0FrbTJNTk5WaEQx?=
 =?utf-8?B?dko0SkhmKzMvK1ZZejJodnVGREJMd3hwa013dCtTRnlFTUtvSHFaTEJrMFB6?=
 =?utf-8?B?clgyN1FkcWcvaHhLZjJYZDVzM2hMbUVQUVB2cnpXVmpWdk9PS3g5RGlxUVlo?=
 =?utf-8?B?dU5iY1Vydk9wTFZZQ21ScFhlT2ZTYlo4bmN2RnlaMlc5bjcvakh6bG00aGN2?=
 =?utf-8?B?RFNxVUtkVWVGVlJBMjN6MzV1SWFlMzBQejdYdHNqNkl2MHBGVmFzd21SUlJQ?=
 =?utf-8?B?ZFgxR2s2Mld3V25aNUlNMDg4T2xxUWVaSmttLzBVWElENm5xLzM2Q3dFYmk0?=
 =?utf-8?B?TldsaVM3UkkxcllFMVJyNWlGbzF4ZGRwanhKWnVPdVFHL2d1LzJhSjVRbSt5?=
 =?utf-8?B?LzdEY2ZkTGFpOXJ2bEJUbXNrZUxYTDNIVUhRSVN1ZVk5Z05YbmJXajdLQ25o?=
 =?utf-8?B?Sy93MklGNWpTeHVVcVJ6S2x6UlpwTFIyNWFEL3RSRlVOam5TOVhlTVdnTThv?=
 =?utf-8?B?ekFORWY1TDNxeHJvN2pOdy91QWVwVE9OWEI0UXpFbTBKUEhqdDU4WldqTzBa?=
 =?utf-8?B?dDNleXU0VHBaeFFUbEtiSU9kSXNCa3pzVEhxd25SY2FkeVFmMFdnYnRQWlBM?=
 =?utf-8?B?d0VRREkwMlVOQm1wdUhzU0QwOFZ4aFJLRE4rcWE1WlNPcUZGMWhHOFFPYnFa?=
 =?utf-8?B?cDc0aXBNdDdNYnRGSE9BZ1dwUFRFWTFMdUZDdEsrQ0I0OFAwbHVhM0Z1UVBs?=
 =?utf-8?B?QjVENVllRzF4akpkYjFTTUxUaStNZDZ5TlFTRUlIY2E3UVJxQkZzQnF0cmc0?=
 =?utf-8?B?OG9leHkzNUJxZVF1cTh2Z2txNFZ5VzFwU2dheXVRQ0VSTmtzejJoS0NpczVU?=
 =?utf-8?B?OWhnMTlOZEJGR3JCck0vdmZaSUZzUFYrMGpFTVhqUDJjY2QvYzRwRldlUitt?=
 =?utf-8?B?SnNGSUZ6NjJXdHZFZ2xha2poYWlDN3dYTmRtY0NMLy8rT2dPVHEzVFR0WG9y?=
 =?utf-8?B?SXpPWGZPV0FvZFlZUElnOHlpK2JpbHg0UGZyVVJReVFxYkMyRzhFNFFWM3E0?=
 =?utf-8?B?TXhMNHppbVBoeEtCa0srT2xWc2s3SG13RWxoZUtWZG9adUtnbnJPL0pEUS8w?=
 =?utf-8?B?ejhCWGxlbFczMG02Nk9DbVpSd2tURndvY0hJOWdDaWpCQ2l1S0JQQXlYUWNP?=
 =?utf-8?Q?a3zRe5jjsNZcz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3RzWXBDdEZHZmh4RXV5Zlp3V0JIMS9lanBSMTRaMjRod3RSbndhK0pUcXIy?=
 =?utf-8?B?NjVpVFlyZUtYY2hvN3pyVGI1UDJqTUVrZ05NekpVeDBBbVpaSUpVUkl0V0oy?=
 =?utf-8?B?U0tNcTNYMjV1V3FUSDJwUGs5Y0w2RGNBVDYxMnp2bTlTU0pMMUhUTlV1Si85?=
 =?utf-8?B?bjZtU1Yyc0xFc0ZXNXY4ZkhWWUVIUlhLalFFbWFlZ3RqaUVYbVJVbWxoT1NG?=
 =?utf-8?B?RkZ2elRGd21jS09FK2NNUjU0RGRadWFVMCtFckQrS1h6QXcySWxYdXJac3NE?=
 =?utf-8?B?bEhqUjJmOXlCVTlSeFpPcDNxdjlFa3Q4NmZidnpWRkI3ODllNys2RmVCTXlw?=
 =?utf-8?B?dzZKaHpOTHg3bXJqanBOam9Ud1dvT0czN3dNSElIMEw4eHBvY04rYTRjQ25Y?=
 =?utf-8?B?dklGT3FwVHdIZGxneVVaR3UyYjlqV2VTQXVLekR2Qm1aQ3RuL3RsRlI0RXlY?=
 =?utf-8?B?Q0w2Rnpna0lBWE5sUlF4VkRmNjR3Vy9ZZnNNcDcwaGtvV1UxdDFrU2hDQUZM?=
 =?utf-8?B?elNmeG1wS0hGWkxFVDllb2FEVDRBWHlvMmxQY0RsaEJPeDFDYkZZQzNPQi9X?=
 =?utf-8?B?NmJlYVZ0UmJ0V0pZRDdaZHdoOFlJUGVzaVFSRjk0aE9qaDJVeTVmZTY1cE1F?=
 =?utf-8?B?V2k4Tm84ZGEvQmp1eVZzS0MxR2M0U2RCcDFVR01yZEVjaW13R1BNRFp4VVE0?=
 =?utf-8?B?UlYyMEUrZHhDVUlCc0h0ckRqT0kwNzY4VEh2cTlqd3pteFl1a2grZXlsbEtu?=
 =?utf-8?B?dnVISXo5enQ4dHZqNjRjSVRna1lsMHZnb0lRSU5HVTlvVEoyQndSUUFFMXBz?=
 =?utf-8?B?M2Eybk1qRUIwM29UUkoxZ0dsSXVDYnVVR0NYbE9RRThJT3pYNllaVjE1a21W?=
 =?utf-8?B?WnMrWTIweGIvNmV1Z1NJeGhWT0hHNzJHTDlCOVhaWWpXUDFlRlE4MWdGaTFI?=
 =?utf-8?B?dncvM3NRKzdtNnRJMk5RN0VjRklPRFVXZVNRRTB6bGpVUXUrYzYzN0lOV0xl?=
 =?utf-8?B?a1k4Q1k0cHRrMTJWRkphSGJXYmFwSGowV01iWWQzalpLelNXcjBpS28yaHpQ?=
 =?utf-8?B?QlNBMGNzelJXbEJ2bmY4blVtMEgrUU9FSU8rVFVaSTJNZzBnYml4T09iaWFY?=
 =?utf-8?B?a2RqaXM4bGEvNTJGVnd5amlMQi9tSUV4ZlFEL3BISHRhQkIwMzN5RThESjRD?=
 =?utf-8?B?SXVyZUFlSUtLU3NVc2NmWG1aeWpKd1U4QTBoRG4wV0ZHdy9lRllXMWVseHRV?=
 =?utf-8?B?ME16R2trRjBGMmZtMnBNNHFmTnB1MjNvYUp3RVhiUnpWeCtxUy9td2o3S1lv?=
 =?utf-8?B?aUN5b0oxK3BoZ2xpZTNpS1lkVlVBSmtIVUt2ZDZFWFlMNEg4MElVbGNCUXlz?=
 =?utf-8?B?UElrUkxYRDU1V0VwRFVtVVlhOXcwV3JPcHY5Q3o2anU0bDlsd1FJR1U0Sk0v?=
 =?utf-8?B?cFMxSkdCV29OTk5qT1NFUEo2Z1gvODRjU1BtdGlvY244UDRUaGMxM1IyZy9m?=
 =?utf-8?B?MzJZTC9STzZkWFZPelJTQWpqWEVucEZiK1pkV2pCQ2RRcHIra3FPL1N3U1VR?=
 =?utf-8?B?WTFNbldQVHZzNWpaYkl5d0FubUgramRaT00zNDg5MGlYdW5kbkhnUTdWMlk0?=
 =?utf-8?B?WnBHbTZ1NkN5V3h4VVZ1TU9rSEdtaStYTkhPaWlTSXlhYTgvYnZHNWprN0JW?=
 =?utf-8?B?ckxCdUxVSGZDaGtTNThTSy9vajRiOXlyTHZRQkZKbzgwZHRrRUF6T1QvQlRm?=
 =?utf-8?B?b2ZGWDZTUGpyTDNaSnlLZGpaeml4NmRQOWt3ZlJDa2dndSsyaTYyUVc5c1dT?=
 =?utf-8?B?eFNUMkpYWW1qa0pseStKazNNT01uWlFucDRuRjEvTkR0OHdZaHlTU3gxQUxu?=
 =?utf-8?B?bmpiRi9MME5BQm9vbHRMWW4wRW0xQjhKUXV5eTNqVTJ3TENzeTJCQmM4bjJn?=
 =?utf-8?B?YWJxRDBYR0pybzhiRzJyTjZwVDRIWk5tQXRyYmFWR0ZwamU0NDRDVVFKdkcr?=
 =?utf-8?B?TFYvMmEzVUFIR2VFcjdRQXd0ZEF0T2pMVFJDUnlCUkFKNUxqcXQzd0gyZGM4?=
 =?utf-8?B?a1hMdThIRExMQnBuSmxaemZJWFJRTjV0NkR4RGxtWEtraGxmUmRwcC8ybkJi?=
 =?utf-8?B?RGU3UnJzbHptVEhQVEYzclNXa2UwMkRNQ0dDNUJaOGNRa3lxOVZHbkhFamRS?=
 =?utf-8?B?VVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a208c4a-8091-4c72-1b6a-08dd4561e62b
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 21:21:33.4410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 81bhvVGTQVWALV5qs0CTSzb6/pUjhFiJVjhCqCJN62F0EiVqCP33ToQP+i9940UydgpigPVD83ZPwLSAVsxHF2sJh08kksYTI1wRrV7CMjc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5956
X-OriginatorOrg: intel.com



On 2/4/2025 12:18 PM, Gerhard Engleder wrote:
> Is there anything left from my side to get this change over iwl-next
> into net-next?

Hi Gerhard,

Nothing at the moment. I have it on my list to send but I'm working 
through the backlogged patches.

Thanks,
Tony

> Gerhard


