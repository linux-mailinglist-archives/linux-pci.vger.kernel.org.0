Return-Path: <linux-pci+bounces-30496-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A513AAE63CA
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 13:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 682EB1924CF2
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 11:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6845F22AE5D;
	Tue, 24 Jun 2025 11:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g/K311ce"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3C61EBA09;
	Tue, 24 Jun 2025 11:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750765547; cv=fail; b=Uav4JI1C9r/TVKFNZLKY/l2aZs5wq2blV3U2FPUwWlAtgMjO6dCvOBMXjBOE+9R7CTFrBsuZx8t26/IvcEG2HaOYUUAUWsNZg5rgkRmxOfmpSl9ztZy0CcuKfWO4VpeNjfAt6uQAxRtvaDOfxNwjCuP5shhJg+Z9phgrMqjnIg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750765547; c=relaxed/simple;
	bh=Fed/35Wks5A7ZrrX1z7TglcIwX+1f9HL+P5kTWBIVbw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EBAVJkbrI6tSmi+0v9QVWQFUW1lKE331q6fuBCwPinhZqtBExohzxQtaI+4cCmgfNjJBA6nV0UIHpRDbLvEZwoYMPxYCIq2gXOL5M4NRRPn6H+6ip6UBOJZjJ7TL16nqI/JIAiEVliTWpcbq37u/hUAIBsUy958Y+KnFTsZ5BMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g/K311ce; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750765546; x=1782301546;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Fed/35Wks5A7ZrrX1z7TglcIwX+1f9HL+P5kTWBIVbw=;
  b=g/K311ceYT4nBTUOgx+wK98Zptcozk80hVk+SHmokpXGQujZorYr5f3g
   fv3t3ZOuRgTGNVfcwC7AOEmq8yV1B4AqjjGvNiYSJslCzuGSdLMsgXlyJ
   YtN/eZkbs+vceno0MxkrvxmtNec4CADVVqVS/3uBGNTKq62QaC/BKiWte
   EwCWibSLth9f4yw8NDraGPdJuoquImYFnHReryoW4BOkcwX4cRfHcLl4P
   rmjNegU7grSu1higznkZvc9d6sR7Wb/eVtNEyF7niQ3lZZQiMAgUS42zV
   ZjCPt9frjO4HEwIXk2abpZgcVYy+S3d7yWdFhBULCGkL0BTDRfMJCkTPr
   w==;
X-CSE-ConnectionGUID: UVAHsqC5SbSTJE2JiK8iIw==
X-CSE-MsgGUID: 9watUKb+QduH/of1PGjTlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="52722807"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="52722807"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 04:45:45 -0700
X-CSE-ConnectionGUID: 2Xl9IpgQQuON3Fnkh1nqyg==
X-CSE-MsgGUID: A/TTlpNSTAahcthoZxEZmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="151319149"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 04:45:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 04:45:44 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 24 Jun 2025 04:45:44 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.88)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 04:45:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JAF2NP//D9a7JZyaRz7I9IeZZzNqyWLtk0Sc+cz5sKG76gWUhyY6dpRfXmWt6V4Zd5rQL/pVOsy/JXstSqIxa8LMPgrBdED/YC2n4WVfsTPOudsQJPUovHPEQlgB2/LzEtOU6ty4lcnAhDRdi0JRxccQAvxi0mNAaT2qf2av604MLm0z/31pBiqd9XmayG4tc2T7Dxy42Nm88BNBXodC0uBFCpwrLrvj6xzlu9Q7bVVt+5jJXL3I13CJjGitA7UNbgO9565E2M8Xokctr0lRxxpXXBPqCE/k3BR4n/BMI7KZORQv3gBUV7I4QkABHjnBz8I0jjSyqqQ2Pm19vjtWtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXsxkppxQenyXzcAIsUxCKuzwPjpIVL84KBMGafrOxQ=;
 b=J+XOxDpWdbK4FtRI97fF7IxGj8FCli2kk6s5BylmqPsQ3vNWt10zdlIcm5g/o6ZQ139jON59USkTPrh5Qc8j/7Kb0+BU+J0rvcbG30ZtXgzqunSiZo//jxtuobs2JkJA5PFIn0a0ql2zxb/iGXVbVV+UFWzN6Rv2JK0pAH4nCkAa9v8TsCMypP6YX9H+3DzgoExogAhotYPl1oBRfpi2jxkueZd5y9LR6cjU951CGFJiVf+qP2Jr7Bo/jMO1sHaAMPhZhZoB+w2pLohYJybcpSNl8z+JabPyzxz7l7CRl5hJ0p+jb4C9el5oykdTo+ZK5Rsbi71V9XG+8A+tXTLpYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH0PR11MB5249.namprd11.prod.outlook.com (2603:10b6:610:e0::17)
 by SJ1PR11MB6299.namprd11.prod.outlook.com (2603:10b6:a03:456::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Tue, 24 Jun
 2025 11:45:40 +0000
Received: from CH0PR11MB5249.namprd11.prod.outlook.com
 ([fe80::a665:5444:d558:23c3]) by CH0PR11MB5249.namprd11.prod.outlook.com
 ([fe80::a665:5444:d558:23c3%5]) with mapi id 15.20.8880.015; Tue, 24 Jun 2025
 11:45:40 +0000
Message-ID: <bd981a4a-e678-429d-8526-abd9290906d1@intel.com>
Date: Tue, 24 Jun 2025 17:15:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [v4,10/11] drm/xe/vrsr: Enable VRSR
Content-Language: en-GB
To: Badal Nilawar <badal.nilawar@intel.com>, <intel-xe@lists.freedesktop.org>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC: <anshuman.gupta@intel.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<bhelgaas@google.com>, <ilpo.jarvinen@linux.intel.com>,
	<lucas.demarchi@intel.com>, <rodrigo.vivi@intel.com>,
	<varun.gupta@intel.com>, <ville.syrjala@linux.intel.com>,
	<uma.shankar@intel.com>
References: <20250529111654.3140766-11-badal.nilawar@intel.com>
From: "Poosa, Karthik" <karthik.poosa@intel.com>
In-Reply-To: <20250529111654.3140766-11-badal.nilawar@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0074.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::7) To CH0PR11MB5249.namprd11.prod.outlook.com
 (2603:10b6:610:e0::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB5249:EE_|SJ1PR11MB6299:EE_
X-MS-Office365-Filtering-Correlation-Id: 02a240f4-a11a-4813-cd0c-08ddb314a4a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c3VDZTU5bnFPRmFqMEpjVDRaTmdYdTdyUzBDcUZrWGZSS3V5VzdKRC92Z2Ix?=
 =?utf-8?B?eGVvWktta1lDZUxPWmxubU5tOWRqUWpMSVJFMTdUNmpYTU9OaXl5N3YxcHJH?=
 =?utf-8?B?N01uV0dYYS9BcVRMTlk3cjM3a21hUkpBdTA2R21DaXdNcEJWQk15a1VTbUJa?=
 =?utf-8?B?ajhYWnV6a3VWZWJVb05IRzkyN1U3WUVZcEcwM1NIOFNXRkdtUlc3bUFoanph?=
 =?utf-8?B?MDhtMnNNdDBUc2tYaGpSSC9ZOUdENTVRTENoZXg2Z1ZRdHVEU3I0a3ErR0dQ?=
 =?utf-8?B?Sk1leDZPRWw1S0dpeEp5L1BBcWgwZE10amhVN3d6M2R5ZXZQRkNOVktBSXFv?=
 =?utf-8?B?NVhzd1Z5WS8vN2ozVCttbnNqK3NsWDZ4TjE5dmMzQmRlaG5YQjB4S2o5ZERX?=
 =?utf-8?B?bVJ2NTNReTBsbGtoeE1DR2hyTnhhd2JTampPVE8yZkVFenJDLzU5SWNhYUpI?=
 =?utf-8?B?d2c5NklzNEhxd2xZYlAyWk0vV0cvbGJ1aE1xU3A1QVVlOS9VcVJIKzNxeWZU?=
 =?utf-8?B?SmhEb3NFV0t2ZmJyREQ1RGQwYTVLUWdrUXI5WkVXZ0dZdE9rQ1BtV0pYblJM?=
 =?utf-8?B?Y1I5dmpSU0E0M1lYQzJsQTFqVzlhWW1EenlBNFFVaGpaeHFxVy9CekFSSzBi?=
 =?utf-8?B?RXRxTkpMa3pjVVpHQ1ZLSE9YQWJBSTlNVkV2RlFFa2lBNlB5SGNESUJEYmRj?=
 =?utf-8?B?UzlBYk1aK3RzckhwMm4xQ2NoR211OU5KSm1qcEFaSXovUDlFOUp2OGtYeTlt?=
 =?utf-8?B?TmdVOFdzYnl2dGx3L214aDdhS3d2dUF3TXlQSGhHTFpDWE5UZUx1RCtuenha?=
 =?utf-8?B?czRRL2pDSXZ2M3drdVVHMTRaQW1WanowZnlYYVRDd2ZFazh2dTRmMDBMSEc1?=
 =?utf-8?B?YldBb0FybS9aL0hQT2xVM1lNSlFpNjd5WEp4OGtJTnUvcjhmY0FMQVlMM1lo?=
 =?utf-8?B?TUtwQmpJcEFQN2VoLzFscjFlT1lVeGdobi9KT0VhdTlzdys3QmxkcURHdjEy?=
 =?utf-8?B?K2VlOGhPYUdYaHR4aHRoNmNWUVJ4ZERNc1BEZFB6REdaTnBhUVZPTkM1dTFi?=
 =?utf-8?B?RlA2WmJvdko4dWk2c3JGOG1nM1FndUdvTnF0dUhkY01ERkVUc3hpRm90emh2?=
 =?utf-8?B?eGY4dk4xQW1kcGF1UkNQNDJHRFRrdVNHM2lpQzFvWGdMaFZTczFVYzlGU08x?=
 =?utf-8?B?V3dldmJGMFg1THJoS1cvUXNWWERaMDFkbmhGbWszNWNSYndPZE5kV0t2UUJo?=
 =?utf-8?B?b09JSzY2VWhKQVNIVHlzcldJRXdCUmxjVTBEUW1LMnVmNk1rTTgxd05Fd2Ey?=
 =?utf-8?B?c3dvRGRRZllwUU9Fa2lHNzNBQ083eGNUSi9TbXBpSjBIcHJ2Ukk0MDQ4b3JX?=
 =?utf-8?B?OHgzVVVLd1pOemZETUR4MkpmeHlHS2ZJSE9rOEJZUzJuWlA4MGRWZ09NZXgz?=
 =?utf-8?B?RmJqeXc5VWRiSHErTWV6RFlGVkJwaFRqakFEWjBROUlKcDR5eEtnTkl6MlZp?=
 =?utf-8?B?eXVXNFBUVHpIYnNWZ3N4c0RvTmpCRjJORzdwcnFoOFhCNTFlODZYTG04SW1z?=
 =?utf-8?B?eG9OTmFlSWw0eit4ZitwY3pjWGovN3YxNE5IbTZGY0hkUmRGREVXRytqbnI0?=
 =?utf-8?B?b0xwamh2b3ZPRnR0T2RBajdNWXhrWmtIL3JxYVRWSWNPdHdRRmZOY2JERlZw?=
 =?utf-8?B?NDc4dDBCSzEvSWtaUENhQncrSVMwS3kvN3gybzhJaTBjTm54UTZpZnJnb2Q0?=
 =?utf-8?B?R0R2L1JVb1p1RkpWUEZ1cE5nNW0zVjVjb3FyYW1jY0JQU09zOHRFVkhyR09J?=
 =?utf-8?B?UEVJZFhCZ0lMRjhsaW1lZVVhcC9pV05SWVJKZVFtMTFyc0llNHl4b1BmVUFm?=
 =?utf-8?B?Rmc0SzFueXBGemkrNlE4MHQ3Rlg4TVB2SjVFbFVRNjlOeDRISEx1YVkzSEEv?=
 =?utf-8?Q?B0VZYdK3aYo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5249.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkNLMWkwSVVwMmZ3RVM3NGl0Z3ZsRGdsQkd3ZkF6dStKdmZmNkJxS2lyUi9y?=
 =?utf-8?B?V1dZUGF4bVZlRytkcGRFRjA1WWdQd3k1Y29TK210NHhVenl6Yys1R1dnRXdw?=
 =?utf-8?B?czhZVXZXN3BKTWw4c1hsS1Nlamx6TzVIMFRrTS9iNlRBZ3hOVlJmRjg4WUFx?=
 =?utf-8?B?QUdWSGZ0S2NXS2xwcWNrcVVHeGZQQ2tuSTdBNndXVExhMk13QTR4SG5Eb0t0?=
 =?utf-8?B?aGZGVW5zZEpzeXNDMzVhQnJzclQ3QjQ3bnV2Vm5Mb2hZQnJscnlZS2V1NXV5?=
 =?utf-8?B?ZjNWUDJKYktienEvcjYzNHY4cWhKSkU0WGJDWkxlT2hnRXBxT2x5alB2Rm1i?=
 =?utf-8?B?ODRPM1BwZ3NCOFBVU2RYRkQ3RkVnUE10TDN6dGJsT3BqQmw2dFQ4cTlua3Bv?=
 =?utf-8?B?ZDNHZXZSZnJaOEJRWk5obDRXaklabnVYT3dYZXArcXh3UzZINnA3TzR2SXd5?=
 =?utf-8?B?KzYrNVBXaGU3b1BxZHZuaThhWkhHVGJmTUt6YzkzWkFTZnhUNjUzWFFKbHQy?=
 =?utf-8?B?VkwyZHZMbkEvQnhHZ2lseFdjZDlNTVZSaHIxSFJXeG90MnpVYlpVcGJIVjZy?=
 =?utf-8?B?dThIWW9ScHpVMHBmdHBSRzZuYkxweElYQWgzY3ZCMFhaaDk0VFg3eTlqdVp5?=
 =?utf-8?B?azRqREtvUERlekdmajQxeXI0VjBMclBxZnBzWEtOVW41VmFBMzRLMGNDUWNz?=
 =?utf-8?B?ektlaHEyTE5HUGdIbFlTa0lid2hMSkNiajJqbE0zUlh2NFNkUUJFSGQwOUVq?=
 =?utf-8?B?dDZXck44eXFlUGRVbjJjWVFXMlRMT1llUUNMQXVheWRzU3c5dTRiQVZ6cmVJ?=
 =?utf-8?B?WGhDclU4UXJvMzFWSStLaGRRMlVOUFFDS1Bib3lXSFIvcDV0ZUtFUlFTemtM?=
 =?utf-8?B?NDVHLzJrSUFrSEMzT0ZDTEd0Tmh0ZEdtaGU1SFFKckQwaWlMSlZoVnRwdzJ1?=
 =?utf-8?B?SmdOVzEzUlVUaXp3MWxGWlUzRjRzQWl4VUY1WVBncFdMYzVKL3RZTjNTcTd4?=
 =?utf-8?B?SGhoMVZuY3BDT253RHR3RnIvTGRueE4yUXlMMmhxcnFndUFLYUhPOGFBYUV0?=
 =?utf-8?B?cTJNV3A2U2dZVEpvck41THNNVjVISUFZUlhiajU5bXgwdjF1c3NQMGxrUkxF?=
 =?utf-8?B?Ny9IL0ZxY1NibXJNYmhjdHI4N1VjbnAxa2dyN1lzL2VORzRLeTFGR2xGckFU?=
 =?utf-8?B?KzBlSldLdnBjUENOaERralJzRHpmUldmckk3ZlFpd1dqSDNEUCtDOEgxdms0?=
 =?utf-8?B?WlRtUFBvYVV3K21hekhMZzcyMUNNc2Z2UkFqbnhHcytPWUpsSDYwYndTaTFs?=
 =?utf-8?B?YmdxWW5taVY5MmREUitqLysxeWNNdWFLczdaQnYxclFTRjRYMUYyaDBqWXl2?=
 =?utf-8?B?bkpZZVo1RkRneXAycTFiS1plVEVvYm13SGppdW9qMmtqUG16bEQxdVFIenYz?=
 =?utf-8?B?Mk1kUVNjN0xlTVo3NFc5Zm1XNERlZjhnSVp6VnQ3NjR5YlQyb0ZZS3kwZ2xh?=
 =?utf-8?B?Zk4yV3JoRnZyd25GK0ZHV3RtSGp0LzFxaFh6d0hwTFBlN0s2RGg1T25Uc2xk?=
 =?utf-8?B?MHZCS3hoRzBwcDFrKzhvQXkzSWVyOTdZMjAvOEJvUkMyNU1hbzJvZEVTRzlw?=
 =?utf-8?B?d1lXdTNzOVpjQXJnM2kxUDhEcWxKejc4YXBVVXpaWlY4Wm1FMTlxNkM0bWsv?=
 =?utf-8?B?NmZHY3p4djVTVFgzNVJRYzhVdmxnOE5wa2RkNk5IVlJ3WFhyWGk2MzAvUkVF?=
 =?utf-8?B?YmZKbU9MN1BJc0JwWVlzL1dvSTQvQnUwZ3lneE1NU1hRbWVDM0pTUHA0Y1FX?=
 =?utf-8?B?aUJIYmtqQUJaa041OWNHUE4wMlF2NWh2VngxUlZBRzRBem8rUGp5d1Jkd3Nz?=
 =?utf-8?B?OEJoQzU0SSsrYW55bjVxd0ppci9EcDBYY09QSEJZejM4VzJwc0hjS21pcjhS?=
 =?utf-8?B?dHhlYW9hSnBoVS90dnFTVmJ6cEU1Qk9xZDhXeDVYUzRpRTEwdG5NZSt3Q3Jy?=
 =?utf-8?B?SjJCYVcrRHg0WFkvTnU2UnZaT0FFQXFzZVZtYy8yaXE4c1hDRjFmSGJ6SC93?=
 =?utf-8?B?L2VLaXBLUjh1dUJVd2YwcStHTURzWUlwcFV1VTMrUjVlZCszWlVpeDI4bDFL?=
 =?utf-8?B?SFcyUWhLWklSRnpGM2p4aFp5Mjk0YUZJVlAyNnZFVW1qcWRobVJ6TGg2ZHBD?=
 =?utf-8?B?c2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a240f4-a11a-4813-cd0c-08ddb314a4a7
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5249.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 11:45:40.3121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a2HX+ooMRzoX6K2g/YIMCPAK8WkxOWv2IYyw7UZWH7VSywhfhdMXkRUaVBGuZ2Cf8AYoqIVoccqvZvfWvpeXAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6299
X-OriginatorOrg: intel.com


On 29-05-2025 16:46, Badal Nilawar wrote:
> From: Anshuman Gupta <anshuman.gupta@intel.com>
>
> Enabling VRSR in runtime suspend and also in System wide suspend.

This can be rephrased to -

Integrate VRSR into both system-wide and runtime suspend-resume flows.

> Also fix couple of typo in xe_pm.c.
>
> Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
> Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_pci.c |  4 ++--
>   drivers/gpu/drm/xe/xe_pm.c  | 46 +++++++++++++++++++++++++++----------
>   2 files changed, 36 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
> index 5ae1df345416..fdf878594fb0 100644
> --- a/drivers/gpu/drm/xe/xe_pci.c
> +++ b/drivers/gpu/drm/xe/xe_pci.c
> @@ -926,7 +926,7 @@ static int xe_pci_suspend(struct device *dev)
>   
>   	/*
>   	 * Enabling D3Cold is needed for S2Idle/S0ix.
> -	 * It is save to allow here since xe_pm_suspend has evicted
> +	 * It is safe to allow here since xe_pm_suspend has evicted
>   	 * the local memory and the direct complete optimization is disabled.
>   	 */
>   	d3cold_toggle(pdev, D3COLD_ENABLE);
> @@ -943,7 +943,7 @@ static int xe_pci_resume(struct device *dev)
>   	struct pci_dev *pdev = to_pci_dev(dev);
>   	int err;
>   
> -	/* Give back the D3Cold decision to the runtime P M*/
> +	/* Give back the D3Cold decision to the runtime PM */
>   	d3cold_toggle(pdev, D3COLD_DISABLE);
>   
>   	err = pci_set_power_state(pdev, PCI_D0);
> diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
> index 1e061bfc3e52..19596d467298 100644
> --- a/drivers/gpu/drm/xe/xe_pm.c
> +++ b/drivers/gpu/drm/xe/xe_pm.c
> @@ -147,10 +147,12 @@ int xe_pm_suspend(struct xe_device *xe)
>   
>   	xe_display_pm_suspend(xe);
>   
> -	/* FIXME: Super racey... */
> -	err = xe_bo_evict_all(xe);
> -	if (err)
> -		goto err_pxp;
> +	if (xe->d3cold.target_state == XE_D3COLD_OFF) {
> +		/* FIXME: Super racey... */
> +		err = xe_bo_evict_all(xe);
> +		if (err)
> +			goto err_pxp;
> +	}
>   
>   	for_each_gt(gt, xe, id) {
>   		err = xe_gt_suspend(gt);
> @@ -162,6 +164,12 @@ int xe_pm_suspend(struct xe_device *xe)
>   
>   	xe_display_pm_suspend_late(xe);
>   
> +	if (xe->d3cold.target_state == XE_D3COLD_VRSR) {
> +		err = xe_pm_vrsr_enable(xe, true);
> +			if (err)
> +				goto err_display;
> +	}
> +
>   	drm_dbg(&xe->drm, "Device suspended\n");
>   	return 0;
>   
> @@ -203,9 +211,11 @@ int xe_pm_resume(struct xe_device *xe)
>   	 * This only restores pinned memory which is the memory required for the
>   	 * GT(s) to resume.
>   	 */
> -	err = xe_bo_restore_early(xe);
> -	if (err)
> -		goto err;
> +	if (xe->d3cold.target_state == XE_D3COLD_OFF) {
> +		err = xe_bo_restore_early(xe);
> +		if (err)
> +			goto err;
> +	}
>   
>   	xe_irq_resume(xe);
>   
> @@ -214,9 +224,11 @@ int xe_pm_resume(struct xe_device *xe)
>   
>   	xe_display_pm_resume(xe);
>   
> -	err = xe_bo_restore_late(xe);
> -	if (err)
> -		goto err;
> +	if (xe->d3cold.target_state == XE_D3COLD_OFF) {
> +		err = xe_bo_restore_late(xe);
> +		if (err)
> +			goto err;
> +	}
>   
>   	xe_pxp_pm_resume(xe->pxp);
>   
> @@ -616,7 +628,7 @@ int xe_pm_runtime_suspend(struct xe_device *xe)
>   
>   	xe_display_pm_runtime_suspend(xe);
>   
> -	if (xe->d3cold.target_state) {
> +	if (xe->d3cold.target_state == XE_D3COLD_OFF) {
>   		err = xe_bo_evict_all(xe);
>   		if (err)
>   			goto out_resume;
> @@ -632,6 +644,14 @@ int xe_pm_runtime_suspend(struct xe_device *xe)
>   
>   	xe_display_pm_runtime_suspend_late(xe);
>   
> +	if (xe->d3cold.target_state == XE_D3COLD_VRSR) {
> +		err = xe_pm_vrsr_enable(xe, true);
> +			if (err) {
> +				drm_err(&xe->drm, "Failed to enable VRSR: %d\n", err);
> +				goto out_resume;
> +			}
> +	}
> +
>   	xe_rpm_lockmap_release(xe);
>   	xe_pm_write_callback_task(xe, NULL);
>   	return 0;
> @@ -669,7 +689,9 @@ int xe_pm_runtime_resume(struct xe_device *xe)
>   			goto out;
>   
>   		xe_display_pm_resume_early(xe);
> +	}
>   
> +	if (xe->d3cold.target_state == XE_D3COLD_OFF) {
>   		/*
>   		 * This only restores pinned memory which is the memory
>   		 * required for the GT(s) to resume.
> @@ -686,7 +708,7 @@ int xe_pm_runtime_resume(struct xe_device *xe)
>   
>   	xe_display_pm_runtime_resume(xe);
>   
> -	if (xe->d3cold.target_state) {
> +	if (xe->d3cold.target_state == XE_D3COLD_OFF) {
>   		err = xe_bo_restore_late(xe);
>   		if (err)
>   			goto out;

Please rephrase commit message. Other than that, code code flow looks fine.

Acked-by: Karthik Poosa <karthik.poosa@intel.com>


