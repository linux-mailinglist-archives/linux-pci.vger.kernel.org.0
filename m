Return-Path: <linux-pci+bounces-3495-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB49856488
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 14:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B73AB2839AE
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 13:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF174130AEE;
	Thu, 15 Feb 2024 13:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mmu2OFA2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F7912FB16;
	Thu, 15 Feb 2024 13:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708004126; cv=fail; b=HsJiXGrqqbyQOrmj8df+On2BeojUKWrcNKAP3kcHUSZ2qIvwXGJc1wRK0AlaZze/KjbX2nH3yiYTQFOYtlIcA4bstm/rAIOKPEK8s1jGnx5meP11EQ2/FoT31+/z7wQtICks2ts0LhPSf/reGA4HkNIhqY9I281tuh6c8gBzZWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708004126; c=relaxed/simple;
	bh=huXAsG6Zy0HJTWpRoaolLu7x9jERvuVqEA88OMeNhFo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dDUNj6cs/Ot/9WdWRe0tZviz6QKUJDBdLu739i9oOGpufKonc0jrRU8OB360L91lJlp4apHMzikHVfhIrpUb1H8zp11UsJeEQhnJxBq1nU2rL9N98u0W/ViaDM3KRQG2+NSPvuQwhZoG2HM9rU06BpvzekFJ6DIKf1KQiieaU7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mmu2OFA2; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708004124; x=1739540124;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=huXAsG6Zy0HJTWpRoaolLu7x9jERvuVqEA88OMeNhFo=;
  b=mmu2OFA2uxGfJSYp5W9HDaaZz+JP8pkJJwxv7DDG9fI5yVjORWuAYo5b
   T+k9JheSx/lptmB3ln4Ijc8+wTSZZTnBRNdqSttsaslvf3dndIdcHjPmb
   KIYmyst8U2Pvm/d7JY2gqshHy9B3Jz/AjBLwyCj4l4HescQX2BsFpmzoP
   9PXP+HXBczoMxkXZMGRpj4See2CDfra95tlvNQXTsRyCNlZStmjh6a2b+
   +poDrLNIFQPZE3EKl8pFeg7xoSsagP6HsTbkKK+so1HLn6Hw8hwU4zSBf
   APH+OQvEZDHU4uwmDHmanZp5pdeSrnRRaBIcYnie1xD0RIfe94FYvHLor
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="1963058"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="1963058"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 05:35:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="912166996"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="912166996"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Feb 2024 05:35:23 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 05:35:22 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 05:35:22 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 15 Feb 2024 05:35:22 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 15 Feb 2024 05:35:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2mBbbFDv6e9SXdWpaWWKvm29tTiaRFnphyvZMvBvscaRzDySSPQuXcKjE+Cl8Oa1nznI8RVjkWtliamuQDZUMnrhoSftcG4pzXiVGuCI2Q9bE33QjDjnrcxqI+d7zX3o/n+1Wxh5vBFgpihfE14B1bqT2X7STpJnlnoHEMwthJY4HCF21DH6L7YBFBIhXCnu0dEiTxgUaccAtsIZ+63BhEGeqGFcEPp/U+HXU2ALQbEtAVhHajeEuqgklt1+dzzR8wD3OoAMIVXNW1ZagFlJi7gqe7ueaDbRCE/3wF0oFfs3ISfXM1psKzjymyAvm8swwhldHLDNMvQGZ09vVhXSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XiHDFQ7MYcgcwUbiU60maFMPmkZs0nKV3wu/ABW3Rsg=;
 b=jkXDUKi3Jz4M2Wa4OTPxeMZyClb53M2PiWd4GSLLzPbEkvXSSZQl0Dl4E2xfX6s2Ao5Jr+DBvIhykSnZNLbS5vSfHWBMfqtGUoSEiJpEBBPjSlIBg/XOLwp9GqYKwTGQYxQtzlgOsVe8UYt8xrI6fBnLBHt1PgrI54DwN9Kton+bX9DD+tyNxmxXwEnmFUoxaONwuaLATDZ/NPRoiyr8GgQL5dqt2R1FG8vIno9mnKYqEqoOAtfbCBlrVxAbg/qWongqNWTWBs6e8NMKP0o4qUkEzNTn5HxxMt9qkT1yJLujJj8wnDwR85IKPXDI68kTDMuhBMqvjkziCY9EFuWigQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS0PR11MB7409.namprd11.prod.outlook.com (2603:10b6:8:153::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40; Thu, 15 Feb
 2024 13:35:20 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::c806:4ac2:939:3f6]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::c806:4ac2:939:3f6%6]) with mapi id 15.20.7270.036; Thu, 15 Feb 2024
 13:35:20 +0000
Message-ID: <7611f6f9-a021-4bbd-bc71-5363af3d9391@intel.com>
Date: Thu, 15 Feb 2024 14:35:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: dwc: Use the correct sleep function in wait_for_link
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>
CC: Jingoo Han <jingoohan1@gmail.com>, Gustavo Pimentel
	<gustavo.pimentel@synopsys.com>, Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>, Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Marijn Suijten <marijn.suijten@somainline.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Johan Hovold
	<johan+linaro@kernel.org>
References: <20240215-topic-pci_sleep-v1-1-7ac79ac9739a@linaro.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20240215-topic-pci_sleep-v1-1-7ac79ac9739a@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::10) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DS0PR11MB7409:EE_
X-MS-Office365-Filtering-Correlation-Id: 42b5222c-4be9-4f42-c485-08dc2e2af43d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EzRLSaqHfpJMsTXJJd3rl6CbeWSlU/VOBFODooA9M8I6/FrHNeCgil2foNVOgyN/Jis4nGNh46ntcooQ0MpohqdjE/05BrHwqHxRWG6oAU/Qu/IotRVjgFjG6c4G2eRXAJOdpbtXOQkD6LXny4qMB0r2bhCPBT+HC0Ep/Dytkr00N7bdub+pliPXamP2T1UyF2m4FG5bt1hpJ3OXAGwAWjyXpfuusLhNzumB7SQfJbShRwkumw+5s4UZk4qRVjXrLe8hBBpOEvFUGLCSOGumLZNGvib5NVUA1KJmDMRgyoOrud/GPGBTSX1nlm3zeJCs0ZVVXvsxMAWc+iFtbPliOSOBhQtH4VP1Yb9Dws5sMO6skysLl22LxjTt5WRb1AAkVjmOSGDYiGF8gYhxwV3tuGorZqp4lpdT6wS8buZHQYzukIbid+9wUkik2ANjs0lN+S9fELQmRVgeDesnG2/abX8Y7pWS6phyldBOO+7RbmgfQ9ru7Q7I+5W5ZHDeSBywe/w6mMxSNvB8B05ERqV3xlRNdFkL+9f8/NT0XZvc6ys=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(39860400002)(396003)(136003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(41300700001)(2616005)(26005)(31686004)(4326008)(2906002)(8936002)(66556008)(6916009)(66946007)(7416002)(8676002)(66476007)(5660300002)(966005)(6666004)(478600001)(316002)(38100700002)(6506007)(54906003)(6486002)(6512007)(31696002)(82960400001)(83380400001)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1pkL2FCTGZNL21mcVd3S2U4dUFicEQwSlFPSU9NK1NaQnNUemNsYm1NMGxP?=
 =?utf-8?B?SUlLclhDb21tRDB5Q0lna0I2eFpzMzMyL2ZMb2lLNXJNZldjZGMwM3FBSTdK?=
 =?utf-8?B?WlFHd0UyMUc0YXFEVVdkREZsZWNjSW1vbklJL0FCMnRJeWtncytYb2hoREdX?=
 =?utf-8?B?ek5wS2l0WXlkUzJ2M3AxN2hVWU1PYlBjMCtDZmloTVVSY1FLdFFCY3NwMVhL?=
 =?utf-8?B?ZTJINTRqTmVCQ0dXY01SdjE3UXBhOFJSMDZJMHJYa3hOYzdaWCtFZEgvM3dK?=
 =?utf-8?B?ZmM4b0dMc0JFZ3kyZW9ieU1xVDcrR05ZZWhBVFNSNDlpb3gycm93Ym43UVhR?=
 =?utf-8?B?WWI4QnJVQUl6RDM1eXlaZGJlZTJab1kxSmJGWWd1VkFqS09lZU1KZTh3Q1I0?=
 =?utf-8?B?eFBENmhmcmE0NEJKck9oN1FsTFhTMU1IaHNsS3VCSWNiTGt3OUcvek1VRUtX?=
 =?utf-8?B?UUs3R25oTzc3U0t1b1VNa0d4ZHRBdXFyWWluNmwrcmpmUHJOVFlhNVBEMHJL?=
 =?utf-8?B?aUlKSUJqRTVndFlIVmx0cmZiQzFhK2xodzVDNGtXWkdpcHpWb1hGc2lvSkFM?=
 =?utf-8?B?azNjNXZYOVc4WExRSUt4U1lhMlZDMDhZNjJrQldGSHlQb3RkbDhrY1k3aVFD?=
 =?utf-8?B?VE1CaGt6NVhsM1UzenFNVHVpemE3ZVNyZkxvQ3VjYStTZkF0SmZZbXorZVRn?=
 =?utf-8?B?Nkh0dlhJcGxEVzJOTWxIdU11V2JycnRrWWMyeFliTERrUjdqVnUvTHAzUlZD?=
 =?utf-8?B?azdnRWtTMEFHVC9BZ01EL2p4WFJMZHVucTBpd1VZVUdsK1lLNEpCM2c5cXlB?=
 =?utf-8?B?c2QrODlyQ1pOQmwzMjVRL2xJZ2N1WlE1TGQxOHlCQ1JWZVBvK0xuYlVhUVl4?=
 =?utf-8?B?eERKdmhSQkxreU1tOWtkcjVQNnhaclV4VHdmZ0VjdFJMR1NMSTdBZU1WL1V1?=
 =?utf-8?B?NU5pS2d0T1JHSEs1clA0SlVqQVE5VmJpN2pOVkdXWkdTOXpsTThQWjlhUjM0?=
 =?utf-8?B?cWc4TGZwcndEQ25hOFZiOGZ1cG9oR245Qmt2d1l1bTF0b2ExSEdUQ3R3VVVG?=
 =?utf-8?B?a21FN1lWTkRzam1qZTRxeEpXYU9qWUNHQWo2TEVhVjZXTnFyRE15SThnN1NP?=
 =?utf-8?B?UGlvZnlFSWpLbWZrUENXYWFNWWg1eExzaEhmdFh1QWpqYm5TVmlYc0V4L210?=
 =?utf-8?B?NkxEMlcwUTlwZWNPV2I1c2tleTEvWFQxK1NXV1hyeEJFTUQzbHFBWk1rMmw5?=
 =?utf-8?B?b2xjNnBzSnYvdlNoSVhQZTg2MUF1M1V0NUJnbU9OUDBDY1Vva2RVSzQ0TmFo?=
 =?utf-8?B?U2VLNVkzS3hSbStnT3dpTm1VZXEwU09iV3ZnYlNjY3h6Wm15QnorTlMycmpv?=
 =?utf-8?B?eWlYR1hrUWZReUdMeUZJa3ZVRitFb3B0ZzNtcEhNN1k0bkhDbHJEbWpLcStn?=
 =?utf-8?B?OFZxVnBEYW52MEFnWndCNEc3c0tVSE1zc2NZVE0vZDZqM1hxQStjY0JwWjNq?=
 =?utf-8?B?bDJLRzlsSHM4eGxoQ3N0VzJObXlKanJ4bWExYlVMVDRFT1lNa1hscEhkY2hD?=
 =?utf-8?B?Vll1Z3FRWHdqV1llOFNoejhmb2xkOVdYSWNEeVlsdm5jMVVJTnVKaDZDL2w3?=
 =?utf-8?B?TGczcHVwemlVRFlaTy9wYThRNGp2ZitqajdCdUxIbFdJWk4yUzhTZkZXTFJC?=
 =?utf-8?B?djJ0TEVnNXJiM25CTGRvd1pkUzIvK29ubURNdkI4SkVBdjg2dTU0MlEwckti?=
 =?utf-8?B?a0YzQys4WEFGa2RzRlRTUWZEaTlITUtsTG1tTUNqSUpjK2hJUkJkOXQ0UWV1?=
 =?utf-8?B?N2RQaFAySXVFeEJlcVFndEZZMGpYTVVUMjlvWWJzYXJVdEt5eHVSQloxc00x?=
 =?utf-8?B?UlZWNXIxSHlvTjNNMXpoMGxWMTEwc1UxdUluOTY3amgxSkdlbFh4M094UlJE?=
 =?utf-8?B?UHNZblFDbFBuVnJhblMzZlRLL29VYTJrQ1pZeitWakQyZ1ZDaXR1YlpiU0Rl?=
 =?utf-8?B?cE8yQ2dBeWx4RnlDVDV0SFhhUDVadmZaeFo1S2h4ZFc4ZVArOEJ0TTlxSmNk?=
 =?utf-8?B?NUFjRnlwRHFOWjdlenA2ZmFsTVN1bnV5K2Z2eUdGY01QK2x2RzVvV3VncTB2?=
 =?utf-8?B?SHRsc0IwRWhBbnhHNGtPUUhjZHpoN2grVUNCVGRCdExzWWk0YXNDQzlWbEkr?=
 =?utf-8?B?OGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b5222c-4be9-4f42-c485-08dc2e2af43d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 13:35:20.1915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y51QWoUJKeZZshIrukQLZ9XkI1BR1RzWcucTmEzJmWrt+Bgta376iAzgi9aFyT6UT8efymtSAlgxmJkMH51u+j/8SmvmA7X7VVC0vIWw1wA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7409
X-OriginatorOrg: intel.com

From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Thu, 15 Feb 2024 11:39:31 +0100

> According to [1], msleep should be used for large sleeps, such as the
> 100-ish ms one in this function. Comply with the guide and use it.
> 
> [1] https://www.kernel.org/doc/Documentation/timers/timers-howto.txt
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> Tested on Qualcomm SC8280XP CRD
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 2 +-
>  drivers/pci/controller/dwc/pcie-designware.h | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 250cf7f40b85..abce6afceb91 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -655,7 +655,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
>  		if (dw_pcie_link_up(pci))
>  			break;
>  
> -		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
> +		msleep(LINK_WAIT_MSLEEP_MAX);

Just use fsleep(LINK_WAIT_USLEEP_MAX) and let the kernel decide which
function to pick.

>  	}
>  
>  	if (retries >= LINK_WAIT_MAX_RETRIES) {
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 26dae4837462..3f145d6a8a31 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -63,8 +63,7 @@
>  
>  /* Parameters for the waiting for link up routine */
>  #define LINK_WAIT_MAX_RETRIES		10
> -#define LINK_WAIT_USLEEP_MIN		90000
> -#define LINK_WAIT_USLEEP_MAX		100000
> +#define LINK_WAIT_MSLEEP_MAX		100
>  
>  /* Parameters for the waiting for iATU enabled routine */
>  #define LINK_WAIT_MAX_IATU_RETRIES	5
> 
> ---
> base-commit: 26d7d52b6253574d5b6fec16a93e1110d1489cef
> change-id: 20240215-topic-pci_sleep-368108a1fb6f
> 
> Best regards,

Thanks,
Olek

