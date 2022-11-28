Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D71E63A0F8
	for <lists+linux-pci@lfdr.de>; Mon, 28 Nov 2022 06:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiK1FwQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Nov 2022 00:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiK1Fv4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Nov 2022 00:51:56 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB0F13F45;
        Sun, 27 Nov 2022 21:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669614699; x=1701150699;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fqFHf62w9A47B5Yllb4h2Ws5xS5lXU+g5JWHdE+Z7dg=;
  b=WeM6/8i5M4gT/0BgSSHs9HMBbUwFSSNXTCFIZar8X7aQUFXO/e/M6U7m
   iKNJteNhDj8/W5WZ3l+aC/TLavGngDWBW1QcbnLDTJI7ZE1rZW99DwQB4
   OkcZRBToUBr+QPjniIclhrZ1KzSnpCmwot0pGXLT71ZPwduMB79pNXfkp
   QDdkwJG4P7H4OPZhUTwF5jI0xk8i4GOlvQfPupBOau9esJh2DQkR223PI
   5RRhStasJLkCXcKAg+GDdep0xbl7t7F0vP8jTSicA20gIKrNL//bk10m/
   tZ3lnmB0fgTI1tuyHkUgHB2FWBtKxGZErFKtSbA/80OsVpNeiOFiX1rVP
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="314786533"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="314786533"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2022 21:51:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="817696663"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="817696663"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 27 Nov 2022 21:51:39 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 27 Nov 2022 21:51:39 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 27 Nov 2022 21:51:39 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 27 Nov 2022 21:51:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDc/Tbkyw3h/kNjJ2UMjjnUCRKcyrN6NGjSTvPP5diC5PFhQNAvjxtjxMBaaa7IwHLZsVD4vWF/FRZOaag7ewavoUQSqw1synzCdWSRK0KrfarsXtaeay8iRPnYTl+i9t2uSeXqcsLdP+7uYtdcwBLKlMx+4dVWLkW2T7l6BOSzjQduBFZ1FdRY4OgqdeThxzx9o8WhIHjvtv+FbGWor+NUEDFn7/KmynusZs7iNERTu/sAUeHr8Y+bxJ0Ao/CUGKSFP53XBO7djoZHI6mIsMWe45sdYxuM+C0PxJM9M5eyFTCueKaNuX4+24Kbh+bp9BwKylECHKKZM2+iGoTjCAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDRoIHU6Cw2WDt/Eg1I77ozWma3meS6guSMvAeyHKkc=;
 b=LIRnILbY7nBO2xwL5bwXxbcPk/QOTSfqZKrsgNhiGOyDKESC6KE3wR0tvPEXSK5HMIt2Id8V4czxZDgFRRWAssKJPcQWQjVwx2zY05OhT1Pk7Qh7Xb1v0A58DKX7fgA8TEcnvQY9SphxbT4QqPhAGO0XjK2/mpXoZuIlxvNKEgM+037rw3hjsqPJoI8uBmflv3grz/m1+JtvsS0EU1gPavEsEh06K05iEKbTom5hEwjWqBnVE871sntqrSRorXzlXJF721jSctOFDu95KzCTIx7MPz6v4mVJuo+fCAElkr05ZOZg5VIaJI0NhlI1t02rqXT8TlVCJZsnJB8OGeTxsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN6PR11MB3956.namprd11.prod.outlook.com (2603:10b6:405:77::10)
 by CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 05:51:36 +0000
Received: from BN6PR11MB3956.namprd11.prod.outlook.com
 ([fe80::7ac:fe96:566:65e]) by BN6PR11MB3956.namprd11.prod.outlook.com
 ([fe80::7ac:fe96:566:65e%3]) with mapi id 15.20.5857.023; Mon, 28 Nov 2022
 05:51:36 +0000
Message-ID: <f6e7bd7a-c901-a38c-e427-e9671dfb6d6c@intel.com>
Date:   Mon, 28 Nov 2022 13:51:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH V3 1/2] PCI/DOE: Remove the pci_doe_flush_mb() call
To:     <ira.weiny@intel.com>
CC:     Lukas Wunner <lukas@wunner.de>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Gregory Price <gregory.price@memverge.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20221128040338.1936529-1-ira.weiny@intel.com>
 <20221128040338.1936529-2-ira.weiny@intel.com>
Content-Language: en-US
From:   "Li, Ming" <ming4.li@intel.com>
Organization: Intel
In-Reply-To: <20221128040338.1936529-2-ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:3:18::28) To BN6PR11MB3956.namprd11.prod.outlook.com
 (2603:10b6:405:77::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR11MB3956:EE_|CO1PR11MB4787:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b721db1-d4ad-4821-c570-08dad1049c60
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TpfM0jad8+WrqIWXkB8TD3PTl3yFMzDcwQwBpWeGsCsUpch+gaxPJJz0QPPcCv/AyJk0wQcuRRPgiu0Mv1WD1+0mDVeZtdPD1WWvrPbdzvSNyKbYHu/vrYtkQKNedp9QM4wLOo1KxS4JCrlq/BQkjynnoIcTCnS3i4CqhNDgkxhzCTi8nidIhDeqywqXG3yJBjIyW2iS7e1zhgDd8IQqx4bLErpUzNAxgDdOrXp3YB0s5tJAMzXFfyORGfSutrKpvq0qlO5lW85ehJBNYuPNgS7U0Wtz+tW5+Jfy6xk1uMLJMYrqhkEHxMNNVZ24r75SsxsjYehBWMOCwi9bEu88OzNkkPsOyet7yJuX3t1uwLwGF7qOEisrikXvtRUNq3ymAc/zUmPQmve3l9gO/QyhvljK0vexfgmM1XNVJEAzX3j6iRXK46cywcp6iKAY/94RNj98/u8CzVdRSd2v8MaZgSyvamE+uylF5P6NNIFCzynoWAlocMCBFj9A6VZWg3JewM+ZY5IuQEXPNkapGMw/bc94w4mhh1zDj0wF5ERsLLZpm3Hh1gwfetzKZDUqGWGl539pmlRjTpjGqxfDXRLeQRjSVB2MGJ12vISw7nQlmxq3rm3nCww+LzqzbckSr1JxEyygb5Gv9YE5AnAF9g280wvXNrW0VrDUNWYoEk3d1b5iDLFnU0Dn3QZOUqG7mv94lSKiOrYdJtBvbKWiWHULjWEuGxdL0FhLYiDc7PB5Sqc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB3956.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(376002)(39860400002)(366004)(136003)(451199015)(5660300002)(37006003)(6636002)(54906003)(316002)(26005)(6512007)(34206002)(2616005)(41300700001)(82960400001)(186003)(8936002)(36756003)(66946007)(66556008)(66476007)(8676002)(4326008)(38100700002)(2906002)(83380400001)(6666004)(31696002)(86362001)(6506007)(36916002)(6486002)(478600001)(53546011)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejVMdjVoWHVvVjJ0R1dSNlNzTTRBV0dtZ05SdkJFeDhTcitIVHpDSXI4M2pu?=
 =?utf-8?B?Sk53aGkwM3M2QkhaZlB2TkE4VG9ORTd1MDhDUWZsWkY5cGpmK202bTdOVEND?=
 =?utf-8?B?VDZCbWRFaFd5WlRQY3pJTTJ2Ly9rYjB6OEcrdng0Vmt2WXIzRmhpTGkwY1Yv?=
 =?utf-8?B?VGFtNk5DbDE3ZnM3VWIzSXY1SE1yVVprS2c3TGtucEFsbUN4SnBZZFhKWVVv?=
 =?utf-8?B?VUN6WG4rdHFKNjlZUURwM29SR3F5eUZ3VHBzSjJOQmVtZ2JreE9neDlOQXZ6?=
 =?utf-8?B?Rlk3bDdBMzBsOGRIWTltaHFaK0dwODFxSWwySUtqUytXWWtJYmVjMGZEZ251?=
 =?utf-8?B?YnFzK3NzQTZzUjhmcHdPcDNaQjdzdUI0aSs0V093UmtlZ2t1OFZyRlAwQVhm?=
 =?utf-8?B?Mlo2OS9maG14Vm1NM21ScmdjR0xDS3lncC9YVlhIZEt2Sk1JUVZrU2paK3V3?=
 =?utf-8?B?ZXdDdWRaaitpU1FlTzlNSzZzdkI0SUNpMVNCRisrVFk0RkpKVjZpY1MrbVlr?=
 =?utf-8?B?NFNHYnhwL0wxdFdhdkI2d1BqcFVuVitGakM5SUJGdVF3K29ITEp0V1c5d3Zy?=
 =?utf-8?B?VjlRcnUvZ0dnVjVCUWZJWTRxT1Nub3IzQTdVeHR4WmJaSmwxZklLOW0yV2hP?=
 =?utf-8?B?RkFma2VaYWtvaW4ydmhHSUpLalEwNlRsa2FFMU1wWlJueEMwa013ZldneWNE?=
 =?utf-8?B?Q2orU1ZSaHZJZzdmVi9PVWtFTjdpR3B3ZjJnQVd1OXBaVGxNSnlGazNicFFB?=
 =?utf-8?B?WHJpck51Z0pKZlBFb0o5RUt0MjVlQVk3QVlwMWRLeldMdmNXdklNQWx4NjBW?=
 =?utf-8?B?dmZFdkFFVDZWS1JjMnF3Uk1vbWhNRUZZaTRUSEhNRzZ6YTVRQVBqbmRHeFNz?=
 =?utf-8?B?Wm94SSt4ZHVjY3B5UnV1WURZOGNLMVhKcVlYT1BRSnZSaE1rSjBoeGViazFI?=
 =?utf-8?B?MEpSWStoUXN1RHArSWFGNDdLV2ZuTjQwbmx1RGFZdXpHMGNNb05UNUhJeGhK?=
 =?utf-8?B?K1lpUzIxNFlZWkwyNmtxZEtJUEQzSEhlY3J5YWJPd2krUmJNVmZJeEo4cDhQ?=
 =?utf-8?B?azVyMCs0QVIvZlo4ZDk4NysvL0lzTDZhL0pBNFozV3NTbSthWW9XYkxaSUZS?=
 =?utf-8?B?SkNSaGpOd0JnNzV4eEFrbUM2RFJieUViUTFPejg3eE5TZTltNVU0bklzOGVS?=
 =?utf-8?B?aEY1OUJJa3QwdStFQ3NycDJZTUtFalA2SVRFaUhlQUxoMElaZ3F5Y1dpQ1Fi?=
 =?utf-8?B?cEFUTW8vMzlyTi96R3BOWmdyZDlFbjRCd0VnRzdtSmRTa0pEKzlQM01xL2pm?=
 =?utf-8?B?UU9iZlBWbnA2YTV3R3ArcHZOUExLZElzUkcyWkVmUi9JWVVCdVMzSnh3ekQv?=
 =?utf-8?B?TitvWG42U2EyQTlNUkpUbmFJMHIveVg4cWhFelNJZzBha3B1UnlmVURzcDNB?=
 =?utf-8?B?R3o2UEZrYm9DZ1lEbU1od0lYdk05S2g0OVoxdUtlMllpd0pXay9SNUhvOGFy?=
 =?utf-8?B?RXJCY0RucXFpU2UrZ1IxSGJPYWwxNThlNjd1YTh6MHJ6cUdXTjgwUmxrVHJY?=
 =?utf-8?B?TUthQjlJTCt2ZVJrZkNxbFlBVmV3b0xvQjd4TWZJNEY5dmZZRjhBSmxSNm9V?=
 =?utf-8?B?dzRPcmtWMVNFTzJkbktCU2Yrenhoa3hlZEhaVnFFN2FxaStiQng0T2NUMlFu?=
 =?utf-8?B?cDlsVXI1UjFLcTMxZ1NRL3ZaT3A5QUpicFRPTHVscmt4aFU5NGxTVUdMdGQ5?=
 =?utf-8?B?SGRUWlJyc055NDBtY0pDckYzK3A4UFl0WEdHOUxjVFBpUVN3akZBbHlRT0pX?=
 =?utf-8?B?VkZQSkFWWlZXTEgzNzVJR0VFWlpEU0h5WXdSWm9vektMbnN5Y2xIQ3lPV2c2?=
 =?utf-8?B?Q1Q1cFVsR3pKQ2xOdzNMeFplcSt4OE9Ob3ZlV2hCYkJYRTJPK0p3SFpUMGJC?=
 =?utf-8?B?MDFqQnFFelkrWk5tN2p4eHViV2NYUm9zdFZaS2tBQXBicWNkd1Via3BIYnJl?=
 =?utf-8?B?ejdxOVR3UzAyUXpzYlo4WXR3dkRtUjVPUWwzRGwwN2FOZUplQWgzTWE2Rnl2?=
 =?utf-8?B?b2R3QitLUFJCM0VVZzd5dHEveU8ra2ZUWUdsZzRTRlQ3ZjJaTGtVc2s1RTlp?=
 =?utf-8?Q?2/QpUb3bagC/TKDNK+55LaCS8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b721db1-d4ad-4821-c570-08dad1049c60
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB3956.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 05:51:36.3602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rnKkFsj3hKJT+mHr+isjeP4ZqAY0dlGABVdkKvc98iI5ODQon1KT/2HhSoN1mJRAxmbxPnfu8r3TNkbFysS1NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4787
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 11/28/2022 12:03 PM, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> pci_doe_flush_mb() does not work and is currently unused.
> 
> It does not work because each struct doe_mb is managed as part of the
> PCI device.  They can't go away as long as the PCI device exists.
> pci_doe_flush_mb() was set up to flush the workqueue and prevent any
> further submissions to the mailboxes when the PCI device goes away.
> Unfortunately, this was fundamentally flawed.  There was no guarantee
> that a struct doe_mb remained after pci_doe_flush_mb() returned.
> Therefore, the doe_mb state could be invalid when those threads waiting
> on the workqueue were flushed.
> 
> Fortunately the current code is safe because all callers make a
> synchronous call to pci_doe_submit_task() and maintain a reference on
> the PCI device.  Therefore pci_doe_flush_mb() is effectively unused.
> 
> Rather than attempt to fix pci_doe_flush_mb() just remove the dead code
> around pci_doe_flush_mb().
> 
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Some comments inline.

> 
> ---
> Changes from V2:
> 	Lukas
> 		Clarify commit message.
> 	Jonathan
> 		Add comment for changed poll interval.

...

>  
> -static int pci_doe_wait(struct pci_doe_mb *doe_mb, unsigned long timeout)
> -{
> -	if (wait_event_timeout(doe_mb->wq,
> -			       test_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags),
> -			       timeout))
> -		return -EIO;
> -	return 0;
> -}
> -
>  static void pci_doe_write_ctrl(struct pci_doe_mb *doe_mb, u32 val)
>  {
>  	struct pci_dev *pdev = doe_mb->pdev;
> @@ -82,12 +73,9 @@ static int pci_doe_abort(struct pci_doe_mb *doe_mb)
>  	pci_doe_write_ctrl(doe_mb, PCI_DOE_CTRL_ABORT);
>  
>  	do {
> -		int rc;
>  		u32 val;
>  
> -		rc = pci_doe_wait(doe_mb, PCI_DOE_POLL_INTERVAL);
> -		if (rc)
> -			return rc;
> +		msleep_interruptible(PCI_DOE_POLL_INTERVAL_MSECS);
>  		pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);

Looks like we don't have to use msleep_interruptible() here, can use msleep() directly?

>  
>  		/* Abort success! */
> @@ -278,11 +266,7 @@ static void doe_statemachine_work(struct work_struct *work)
>  			signal_task_abort(task, -EIO);
>  			return;
>  		}
> -		rc = pci_doe_wait(doe_mb, PCI_DOE_POLL_INTERVAL);
> -		if (rc) {
> -			signal_task_abort(task, rc);
> -			return;
> -		}
> +		msleep_interruptible(PCI_DOE_POLL_INTERVAL_MSECS);
>  		goto retry_resp;
>  	}

I guess that you use msleep_interruptible() here for aborting current task when signals come.
So there should be signal_task_abort() and return when msleep_interruptible() receives a signal.

Thanks
Ming

>  
> @@ -383,21 +367,6 @@ static void pci_doe_destroy_workqueue(void *mb)
>  	destroy_workqueue(doe_mb->work_queue);
>  }
>  
> -static void pci_doe_flush_mb(void *mb)
> -{
> -	struct pci_doe_mb *doe_mb = mb;
> -
> -	/* Stop all pending work items from starting */
> -	set_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags);
> -
> -	/* Cancel an in progress work item, if necessary */
> -	set_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags);
> -	wake_up(&doe_mb->wq);
> -
> -	/* Flush all work items */
> -	flush_workqueue(doe_mb->work_queue);
> -}
> -
>  /**
>   * pcim_doe_create_mb() - Create a DOE mailbox object
>   *
> @@ -450,14 +419,6 @@ struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset)
>  		return ERR_PTR(rc);
>  	}
>  
> -	/*
> -	 * The state machine and the mailbox should be in sync now;
> -	 * Set up mailbox flush prior to using the mailbox to query protocols.
> -	 */
> -	rc = devm_add_action_or_reset(dev, pci_doe_flush_mb, doe_mb);
> -	if (rc)
> -		return ERR_PTR(rc);
> -
>  	rc = pci_doe_cache_protocols(doe_mb);
>  	if (rc) {
>  		pci_err(pdev, "[%x] failed to cache protocols : %d\n",

