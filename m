Return-Path: <linux-pci+bounces-2702-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0520840142
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 10:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98189280A9A
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 09:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CBB54FBA;
	Mon, 29 Jan 2024 09:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PjWarIiX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8C956449;
	Mon, 29 Jan 2024 09:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706519928; cv=fail; b=YMYP4bZUfjwyL+Bzl5S6jBhlbwiCsXV3+55DEePizeYlTPhu0fVgdsKAmzz9Oez9RUv5QIUve4Uyr7zW0Nh3YiwqjUG2yInod13/d8n0e5o8MkDG6molYvkI5+YVxk96rsLFxGH9eU5NH8HLTUAKFOIxhuKc5SOLSH227dvUSEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706519928; c=relaxed/simple;
	bh=Nho6TmS8CU0+9eClbKrBc3jGPKXgGR55zO1VLrRqclI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mlgglR2+4rcw7WfvwL9FegRzuCQpCnjNVFXNYd20wqm+vFYEeZl1OwMqe146vUWSuvABwL1V6mL+iOQI5mhznslQdOoY2y/FIrIp6Wo4xGmlKib6z26w5woON6W1Bz53O0jfwRN9IjDE2wthWumdUhzZ+Hrr6MJ/4CMnxd+86KY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PjWarIiX; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706519926; x=1738055926;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Nho6TmS8CU0+9eClbKrBc3jGPKXgGR55zO1VLrRqclI=;
  b=PjWarIiXU4DBzEORwn4TGJSi3Da21deK4iqIbjHnJfJzhWprXIXOvjJK
   W/8c7++Pp21Vm8LHw83Ojylk5Osdzr9L/Hr1jtYSPijiCku19t2C0XK5S
   KAEJi3hzsC6eTN6+OJycBxhTuXKMp25y0uFBBDPKOItFl7Zqj8oOcXQm2
   /yvEyxIoKrinlUUThQl5RKyeS97jOZp2v13CtCOFknuxoq6UKGkLOUMxl
   Hwo4uOh22OOabeW5Z1063K9cYR/Jz738i78RisJdFpOwTIK6byCatewHP
   BYhE/9skBNgp0UuiduooZbhr0j+F79D8YNOvo0rF0b5pzP8gHiN5myiSb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="2762449"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="2762449"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 01:18:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="911007210"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="911007210"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jan 2024 01:18:45 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 01:18:44 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 01:18:43 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jan 2024 01:18:43 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Jan 2024 01:18:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDdtKJAEkYn10TUEcUKVE8ZmyzVwMQ7Smb8AIYUaqCfN4Ua0q3L5D/GoGDRn1HUnzfWGJJ3V7l9QSMKcTgMs7JlIG8zs4/Yc3DVxW9iyX//nI2yNncvtgd7ID6uHSkLoyiwPVad9XnwKPO9Dy6kVhst2KrJF4U1hxyYnYbJnrIDOJVQS4ORd5Bci2BmRts9FFmNLxOgWZl+3++/W4/ThxMHThdb0ahfd2bLEEJUUnG5TaY1+px7L4jif7CpxR3vLGUQu3Esx5xEmnY9783pSc31YBBWZP9yfwD9sktSFFVKjDoY3Ka4Viikc77TE7BTVF3/h2uiuFu4Tc3B6XcUoWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3EoqTcopsBuY5eGPu85uNcFo3b1Jgdxe0dxcPB6tF6U=;
 b=Myp3lIsm9z+GyME1wy8mi5dnSUqKb9Sra+2oOARfTs08Nk7XF+vnIg8DZNstkDW8wzvjlh6TeAwqiIyefy+fLq1q87MhApBNjgGM3tHrovDbTSZkWFFjyCatmL+N2uAgAW0CPXeq2KkN2irMZl8QlAfF1FxVKhgG5CzIVm/knX0CJRwSWqwMhkUduiJVxWfdQB4YfffzBye+wK7e4YHe0vBJ4lmLOUWq5670t1i9J4P5biHtwdndpm21nfMB8ZpY4TMoFaLl+jaHk6W5YAXFQ/vj/tedlZiPMGgssPF5M6waYfZTV1FND9Fwa8CKEqiijLK+PSIcgKNBDchdHo7HkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA0PR11MB4639.namprd11.prod.outlook.com (2603:10b6:806:70::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.33; Mon, 29 Jan
 2024 09:18:34 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b877:93ff:2217:eb13]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b877:93ff:2217:eb13%7]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 09:18:34 +0000
Message-ID: <7adec292-9d38-41ab-a982-bd840b24f3ab@intel.com>
Date: Mon, 29 Jan 2024 17:21:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 5/5] iommu/vt-d: improve ITE fault handling if target
 device isn't present
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Ethan Zhao
	<haifeng.zhao@linux.intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>
CC: "dwmw2@infradead.org" <dwmw2@infradead.org>, "will@kernel.org"
	<will@kernel.org>, "lukas@wunner.de" <lukas@wunner.de>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20240129034924.817005-1-haifeng.zhao@linux.intel.com>
 <20240129034924.817005-6-haifeng.zhao@linux.intel.com>
 <BN9PR11MB52761CC3E5F08D4B7BAD7F918C7E2@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB52761CC3E5F08D4B7BAD7F918C7E2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::20)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA0PR11MB4639:EE_
X-MS-Office365-Filtering-Correlation-Id: 99626e04-6cdc-43c6-a436-08dc20ab44cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z/kAMa5WFlcIPR3npI6pd6N4fUmvA2FWxwFlcifmUaxlFEVgX9ahOGaMKU4tn6n1Pp0TOWmXkM1+OHAW1p9ugGOVjYj7rQPUsvWLYlC/uuO/cLcCSYRa2GJAcxkPFwftDTQoNTdBhzRaIT8jjSgk/Z+UDuHrgRw1yhwt+sAiVtWFxJjRUO22VlWsmVJ7fbf2Dd7Lb5nVt0ueoVcGQqnAcDgtiAhwgxR/oYkfU/o9ayrlWEaG+RMZ0jo3GL9YldFOLJMEOOF/tQzW+j9+uAaO7uvPDfEWBd8DUOVqu9sEAPq4wfSQwZplPnAmVYXXkr+Ub/o0yGuq43x6C7GIWyn91iEEZM7aKxVexKIegoy9jdk6dZANm8wvy+P/HeVZL46qbpWKaGbdK4LcCLbqyqsHAO7NWDTyFoGpeQlrzGM+0rvhQksQeC6MRkSHyLtEBjDruKhK78yAt9FiFVoHpG0RiYW+6N/U7OxDb7hhgXFMUGVOxheTPwkNSDD0/oy2FzFlSnoUQiIUcStnJr4DDndycHd38bCbLxkUgxqbZ4YVwzVfJBwFOQOnJhHkYPqygueHx1Nf2Qh1N5HLeQu5X8KBIgEyjsDZ/RRBoNQHe5vyEc2SO4CkKgm5a4q91vwsQLNFngE4qeqF3r07QI8N6ieKlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(396003)(136003)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(41300700001)(82960400001)(31686004)(38100700002)(66556008)(53546011)(6506007)(110136005)(66946007)(54906003)(316002)(86362001)(6486002)(66476007)(8676002)(8936002)(5660300002)(2616005)(6512007)(7416002)(31696002)(478600001)(2906002)(4326008)(6666004)(26005)(83380400001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3ZMdDJ4STgweFpoV2pCQjBoMngrcXhHclhER2JLQkRGeWdKdCtoc0JtQnVU?=
 =?utf-8?B?LzFZVi9INXhGa2UzZ2R5dTU0NlA2b2dwTkQrR3AxdzVmYVJIYXJwWXBRZzk3?=
 =?utf-8?B?S2UyMkpkd0o3RWRVVWVzU0orVElNcFFoN25VZDVyenIwRjFDS09GTDdERjhR?=
 =?utf-8?B?cDdEM0VFMnc5NmlwRnlidkFpTU52bnhTcWdxeTIrbjFhSVJtczVBdkN2RGpi?=
 =?utf-8?B?RTk5SmRpenErM2pXd0tSeXVNZ091bjFmd0oxUWtDYlJxOTRaVFVMYk12bXZY?=
 =?utf-8?B?b28wanZMYkc1akpKV2xiT08vYm9JMW9SWXR6Vk4xMUt6TnZ3NFMrSUNiWE53?=
 =?utf-8?B?MG1FRFJ2ek5BSUNZNS82V2oxMkFvRnVUdWNKa2diYXlCek4zaDRDQ2hXOHFF?=
 =?utf-8?B?YVB6dm5jSDdxZVhLWE5HaFBpUi95S1J4d3A0OGhCanVTVE42Zm5KRUI1dkZX?=
 =?utf-8?B?WW9Ydit3UU4rR3c5b0xpQUxTMTlkTFdCa0VuZEFabzBXY05KMlBZeWRZK2cv?=
 =?utf-8?B?b0tXRlBRR3JMMU44bjZNZUxrYzZQeXhvRU5kODV2dWsvNlRibVBPV254akxI?=
 =?utf-8?B?eXpPWk1VWHN3NG1iR2VBNDNjUjVHek9reTdpak51ODAzL3pDV0dPVkxmbzlO?=
 =?utf-8?B?eGY5NEdNQmVnRWZGUWE0bjVzUFVaY2l2d2dFNWc5MHVlcjA1ZjQ0RjJiTGtZ?=
 =?utf-8?B?YUtYQVdHYkoyQ1RLVHFIdDdXM2Q3N2pHNFhGd0NFNUIvZWNvcVl2Z3RCcit5?=
 =?utf-8?B?U3NWSnRSVmt2R3VBOE9ZTTRzUWovQ1B4ZStIc29zUHBJWFMvWnN1VWVIL1JT?=
 =?utf-8?B?WFVueDJJMFBZMnFoZ0phM1NVVHBxdGVsQS9ETGVzWENrWW9HVDY1RE01R3Jv?=
 =?utf-8?B?czJMb0JjWkphWWZQNGZEWXJuVFhYdFZ0bGR2M2duWXpkc0hGaGtGaWFoOUln?=
 =?utf-8?B?eFp5Ni82a2doYys0NVVXbytidTNpTnZudUlVVTVLZFcxejQwSHp2NnVmYzEx?=
 =?utf-8?B?OHlYMHlpUmhDbi9zajFZWm51aFIxb2pxRGVYUkZUOFRTTktiekZWMU1URTNq?=
 =?utf-8?B?YUdXc2E3RXRjekt1MXZ2STlGK280d1A1VjdmSThpWGdXeWxGLzA3MVE5RG0x?=
 =?utf-8?B?UzVtem5HOXUyTlFpajZPOHNzQkw2a1RSUVdQVmtKTXFzNFdHSWF6eDZ6Y3Vl?=
 =?utf-8?B?enNyWWVTZHZLUytta0V6ODU1VmY4eEVOcmRkVVpXN2dYK2JlL2YrTGhabHds?=
 =?utf-8?B?UEJ1V0s3S0c0SDBuSXJzV1N2YW1rL2dqdUcwVStVSWxUZlI0Zkl1RG83STR3?=
 =?utf-8?B?dEltckRkVnBlZS9WNlpEQjI0U2d6NUxOUmhleW1VcWZjUW9OZ0JiY1VleWhU?=
 =?utf-8?B?VFdBYnhYNVB3ZXpUbGZhS3pvQlJua0JERkhsaXV4czA3Zi9hdnBSbHlqbDBC?=
 =?utf-8?B?UG1vYTQvWXFNaTBYc1lQWGFkeEpsS2hRYTdTc0lFYVh0TllMMWhiL25sODln?=
 =?utf-8?B?QzVOZzFyR2tRZHlXUzJPZWN6RHpzMlpjSEFWRm45Z0FFcUhVVGk3YVNkNGJv?=
 =?utf-8?B?NHhtVWlPR1dPQzR2TExoTTBkcE1UUG5TSWpkbVFTa1R1bUZGcEE5eGNpcFR0?=
 =?utf-8?B?alZaQ3UwUjg5eGNQcm5iMEdPaTZJZzhJM3RUSVhUU3hYRVJPcnZBZ0VJNElM?=
 =?utf-8?B?S21MU1NzSHVUT2dBSDVzZUlNNlREbnI4NzJlQ1VBRkd3ZjB2RmtzSGpueEly?=
 =?utf-8?B?ZzFDczdCUCs5NTRqNGNkNmpwcEs3K0RubDJObUIvS1dDMVZQd1VWQW9sNHVS?=
 =?utf-8?B?djQzZ0l1L0F4OXdOdTRyVmJ2dVMwNjNub0tBTFRpZDhzei90QjhLa2xyMEFZ?=
 =?utf-8?B?MFB4a3E4YjNBRjFhSWxGbWc0bEhhcldoTGVjeXBkYStrZUxvSWljSW83Ykly?=
 =?utf-8?B?WVViUng0S1JpcWt1SG84NXV1RHFSUTBacWJEc01KcGNGaFRaVXdIbXhZbnlr?=
 =?utf-8?B?VURSVTB0Y0RxSnd2WFlpK2xvdDJ2YXFyc1hTdTluemxHMk9XRUpQdjVVaDdx?=
 =?utf-8?B?bFZqS0EzdFRPWkJzRStPalFQY2QyTHMyY1QxMTdmek5Td2hEK3hreHA4a3ZF?=
 =?utf-8?Q?Ce3mLgnFPGG4WavYeq0Lssxow?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 99626e04-6cdc-43c6-a436-08dc20ab44cd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 09:18:34.8489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mylnPZ3kg8NXwAQL92hyiYlVd5R0z10IyC3vCYzhblJUx3WUS1iryk/sR425zSrBUXjo6s9gE/ZVRfCqjT7xqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4639
X-OriginatorOrg: intel.com

On 2024/1/29 17:06, Tian, Kevin wrote:
>> From: Ethan Zhao <haifeng.zhao@linux.intel.com>
>> Sent: Monday, January 29, 2024 11:49 AM
>>
>> Because surprise removal could happen anytime, e.g. user could request safe
>> removal to EP(endpoint device) via sysfs and brings its link down to do
>> surprise removal cocurrently. such aggressive cases would cause ATS
>> invalidation request issued to non-existence target device, then deadly
>> loop to retry that request after ITE fault triggered in interrupt context.
>> this patch aims to optimize the ITE handling by checking the target device
>> presence state to avoid retrying the timeout request blindly, thus avoid
>> hard lockup or system hang.
>>
>> Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
>> ---
>>   drivers/iommu/intel/dmar.c | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
>> index 814134e9aa5a..2e214b43725c 100644
>> --- a/drivers/iommu/intel/dmar.c
>> +++ b/drivers/iommu/intel/dmar.c
>> @@ -1272,6 +1272,7 @@ static int qi_check_fault(struct intel_iommu
>> *iommu, int index, int wait_index,
>>   {
>>   	u32 fault;
>>   	int head, tail;
>> +	u64 iqe_err, ite_sid;
>>   	struct q_inval *qi = iommu->qi;
>>   	int shift = qi_shift(iommu);
>>
>> @@ -1316,6 +1317,13 @@ static int qi_check_fault(struct intel_iommu
>> *iommu, int index, int wait_index,
>>   		tail = readl(iommu->reg + DMAR_IQT_REG);
>>   		tail = ((tail >> shift) - 1 + QI_LENGTH) % QI_LENGTH;
>>
>> +		/*
>> +		 * SID field is valid only when the ITE field is Set in FSTS_REG
>> +		 * see Intel VT-d spec r4.1, section 11.4.9.9
>> +		 */
>> +		iqe_err = dmar_readq(iommu->reg + DMAR_IQER_REG);
>> +		ite_sid = DMAR_IQER_REG_ITESID(iqe_err);
>> +
>>   		writel(DMA_FSTS_ITE, iommu->reg + DMAR_FSTS_REG);
>>   		pr_info("Invalidation Time-out Error (ITE) cleared\n");
>>
>> @@ -1325,6 +1333,16 @@ static int qi_check_fault(struct intel_iommu
>> *iommu, int index, int wait_index,
>>   			head = (head - 2 + QI_LENGTH) % QI_LENGTH;
>>   		} while (head != tail);
>>
>> +		/*
>> +		 * If got ITE, we need to check if the sid of ITE is the same as
>> +		 * current ATS invalidation target device, if yes, don't try this
>> +		 * request anymore if the target device isn't present.
>> +		 * 0 value of ite_sid means old VT-d device, no ite_sid value.
>> +		 */
>> +		if (pdev && ite_sid && !pci_device_is_present(pdev) &&
>> +			ite_sid == pci_dev_id(pci_physfn(pdev)))
>> +			return -ETIMEDOUT;
>> +
> 
> since the hardware already reports source id leading to timeout, can't we
> just find the pci_dev according to reported ite_sid? this is a slow path (either
> due to device in bad state or removed) hence it's not necessary to add more
> intelligence to pass the pci_dev in, leading to only a partial fix can be backported.
> 
> It's also more future-proof, say if one day the driver allows batching invalidation
> requests for multiple devices then no need to pass in a list of devices.
> 
> Then it's easier to backport a full fix.

May consider pci_get_domain_bus_and_slot() or
pci_find_bus()/pci_get_slot(). But I doubt if the pci_dev is still tracked
in the bus or a kind of dev list in the device hot removal case. So Ethan
may need to check.

Regards,
Yi Liu

-- 
Regards,
Yi Liu

