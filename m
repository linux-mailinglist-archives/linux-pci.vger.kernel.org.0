Return-Path: <linux-pci+bounces-355-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6758011EA
	for <lists+linux-pci@lfdr.de>; Fri,  1 Dec 2023 18:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 182E7B2132A
	for <lists+linux-pci@lfdr.de>; Fri,  1 Dec 2023 17:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678B14E639;
	Fri,  1 Dec 2023 17:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IWZFRkvc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AD5FC
	for <linux-pci@vger.kernel.org>; Fri,  1 Dec 2023 09:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701452491; x=1732988491;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=esMub7FqnqsvGkX3FjTx7pCKntYB0GqJCMWoPeJxjdM=;
  b=IWZFRkvcB86dxJ5EIizR0+HjFfMlJJcJ7tB0qUCInC4MH7Qp4gK5unU8
   0ZGqPkB1ZqNZcYv/h4UJABhmVdSlNaJUsbtdpcBIsQNkz+jebShU+uw8M
   L+Fq8MGgdp0aBHQ1kd4EAWl2iRBSoj+awwap6eM7A1KNKrqGU10i+gqdC
   JuxHMxlZXqlHIp+x9BGfPe+Gg4SM7h6as90tSUO2eDQcFa3b3v1h5rZgw
   Fhl8i1X3wf3nX+kgT6HpbyA01UgUIABqQV0NCMVgYp8obLlh9Y+HYxs4E
   JUTOmasISLvyzSkNF6Uen3XjpLyNrQudNJrg9kxCO/6hl6kOiwn10/Idj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="378559412"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="378559412"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 09:41:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="860626359"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="860626359"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Dec 2023 09:41:30 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 1 Dec 2023 09:41:30 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 1 Dec 2023 09:41:30 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 1 Dec 2023 09:41:30 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 1 Dec 2023 09:41:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M5hwjZI5h9I+FOaPGs5ZAfrymzuUEoeLyqVk4GNfhcmNa1g0gJmO6GDj6LqDjAhAbyyA1PP6tIOFjtaYA9viFH8DL4Fx/GAvVsJsFh5Jy1oNdArrOgJHUMYS5yjExiG1IAXpeXeg2UIyoalLGIWUroH+izjz0H3COMaIKrrfNuro/uFqVPe2poCdA+Odmvub09776pcdmraVpVks6oaGm5dSoTBlBKBTVApxIltLmDncLVCDNha6fUFCNVsNzWwi58q2Gx0vfL8AulVgdYf+VOJY9zV+hiz3YAx6VSYy3TGSdeFGF/cIra1a0ZdPlobknl3yTIr4YQP70CUM6/1I9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqvFIg80SbAsX5SLYxGRwpcLdOaDFAeJwhTz8+TojRI=;
 b=FMePYblZQWxiMXZCWrUvilaIrTidKw7NE0dBcrCOc4PDxV9etbCDYfrJ93QaqM5G8cWdfhqpMiMb7I/SnZWv8b9Kh7jXUfGefnjviD2mWYcSboW9n62QIiCGZeLteW6wEixyfV2UH+6qW/OuBPLFmWHxeM/XN0Yx9fucFaug7Em1DGo7uN86r7VLBlDe9cJxZrY1byyiUfiIRotNZrTZ+HzVZdWbjYorSXUNA0+Us2DDta6e+8f/eh+jcjuYzUuwF12UI8eoS6D6VZfUdUhSP+tLvVjTIFX+oQbi7s6miNiZD+xMokVAHXU534rJqnSkWKKaPmW7q0+h7t9/veyL3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SJ0PR11MB5937.namprd11.prod.outlook.com (2603:10b6:a03:42c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 17:41:28 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7046.024; Fri, 1 Dec 2023
 17:41:28 +0000
Message-ID: <8ce79475-1391-43c6-adb0-c4643ab5a53d@intel.com>
Date: Fri, 1 Dec 2023 10:41:26 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH 1/2] NTB: fix possible name leak in ntb_register_device()
To: Yang Yingliang <yangyingliang@huaweicloud.com>, <ntb@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: <jdmason@kudzu.us>, <allenbh@gmail.com>, <lpieralisi@kernel.org>,
	<kw@linux.com>, <mani@kernel.org>, <kishon@kernel.org>,
	<bhelgaas@google.com>, <yangyingliang@huawei.com>
References: <20231201033057.1399131-1-yangyingliang@huaweicloud.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20231201033057.1399131-1-yangyingliang@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::14) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SJ0PR11MB5937:EE_
X-MS-Office365-Filtering-Correlation-Id: acab799f-0943-4e57-a0ac-08dbf294bf40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xXgZ+Bk+9g9ZYY/kh+/QsEOSIjsUdGOSUqc1KeWAVw1B9Pm9DfjizfkAMAmc/LBdh5PZ3hJ25t7E/eAWJEVkaGF2QbsQ+KuvXiHhl0dtLt25zyhqSWSqr2/zEr+1urU+0enVgRfRegy7H6ADp1HAU1iPSd/hdepx+PPhWCUwJZrJ9nQhPMRGES1VeaDhRMhjQ6XuizQbHN1XaIDopsWAgWqb0+xwBGdd3R/zzAOq3ibDGIkaG9Yq04+ijVwJFuGAAGtnmq/S023D9uqJ6OVt+DFZD+UncnoPVQFJXJnE4EDYKVyMJwm/YoTfwLy5K1pW61cFPaovxUcfOwj2q5FGWes8Utr2ylQ2uxtybNZ/dZhKvc6lumMR22aVSgN23UuCNR9yMv/dWAPmVNvUNFL65hW9RDQ30eDZbaY8tGrSfkGPj+JIKqcEbsPuEEKAi4uX610hoEUQrfLqZjjK4GV3JD9d+mshXq9lgdSnitAoGlJUZZDjPmHa3SAPi4BVuzKF3Z2mnc+qHjk0AHdmFFqEjQLUF0rT8LjuzJkhas9UMx/klIdefPdF4ZtgDf/YXuLb5BsrR1sjIRUYxjvZIKQLvLS2jz0exC75YljSaUHrZaJJBX/f7vG0PdEQCQHoedaF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(39860400002)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(7416002)(5660300002)(2906002)(8676002)(8936002)(4326008)(66476007)(316002)(66946007)(66556008)(41300700001)(53546011)(478600001)(6506007)(6486002)(2616005)(44832011)(31686004)(26005)(6512007)(38100700002)(83380400001)(82960400001)(31696002)(86362001)(36756003)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEM0a2s5VXE2Y2t5SVRTNjdjZ0M2bVBCTGlkSDc2SnE4L2UzdmdiMENmSk1N?=
 =?utf-8?B?ak9YZkVTcmVPVU5GdmxsbXZLTTkxVGFxK0hCZEtsR1RjUlRqdGxBaEVIS0FD?=
 =?utf-8?B?emJCTTFWSkw2Z01VS1NibFBLblI2eEEvMGRhMmgzQ1J6a3FqS0daYVR2WlVQ?=
 =?utf-8?B?Q21QNnl4MmxvcHJycVFKVU9VejNHbU9zRVJVM1R5NnJzMmNBcFh6S013RVhi?=
 =?utf-8?B?WlJ3UE9ON0MwSFdtZGNHUHkvN2JHYjRLd2cxUFhuTWlUbk1wY2tKTnl0YkFR?=
 =?utf-8?B?TEVFMGFCK3I0a2YzejZSbUszYlF5YmlPZjlZb2FycCtPZU1GakhKRUdaMk1M?=
 =?utf-8?B?UkdlWGFDSWNCbThNQXlJVFVhVEFpREZEM3ZwZUQ3NVp4eFBRdFNEWk9oMFo1?=
 =?utf-8?B?VFNzclptTHFEdUcwNUNNMFk1RUtIQU8wazZVVVh0Qlk1cUhuL2Z4ZnRyVk5k?=
 =?utf-8?B?WWs2L0ltZnF2OGxWcisyTTBSOFBJdGc4T205REswUWJtblh3MXVvcmlqa2pn?=
 =?utf-8?B?cTYyaXBKSWpUdmhHdGJnd0x5TmRFSDJVcC81cEpLL1crV1hTaXFhSWhRK0Zu?=
 =?utf-8?B?WVZnWlhwWndpczUzVHRzUUlsQ2NDYVRkemw0TTkzL3dPWDVld1VCTWNPd3Nq?=
 =?utf-8?B?VUNaT1F5QnJSYkZlUUFtR2RNTGtpcjdwMnBtSTB4T3dDK1Zzc3RwcXdLZXJ3?=
 =?utf-8?B?SmY1LzY5Wk5VdzZCRUNmQWh0MStRTDY4NTUra0NtMUM4N2lDdlR6TTgzM1RQ?=
 =?utf-8?B?OVAzN1ovZFBoRnZ0cnpXVFdZVEVaVEo2ZjljZFlDeURNZ0xreVB4TmpZc2o3?=
 =?utf-8?B?cjJYK2NLT1dzcDh5SnVlWDBwODI1ZUlvOVpXMDJMTEd3NjFEOGl4SG9Wc1Nk?=
 =?utf-8?B?VnJoeFNrNkhEd2dIR3RRSm9MaW45WUZNdWdVSUswNm9zZU9WamdSNWtDWTIw?=
 =?utf-8?B?Nk02ZkZZYkF2NHEzMTF1TDMwdzkzemhScTBoaEFXVnJDYlZXWE5qSm5KSmNE?=
 =?utf-8?B?Q0EybEZFZXpXbVF3bEZ5VHM3bmUva3g2SWdCTzJublhJc1ovRDNTQjFsdmFn?=
 =?utf-8?B?NXYvMTRSaVFlUjMwUnVLSVZDSjRzRmYySi9kM0MvNW5hTUQ4eUtFNVFEQnlt?=
 =?utf-8?B?bGwvazZESUoyZ2drTnA4Vzk5ampTNWdCQ0U5cUxQVmZnbjdKSTFhTVpCOTVD?=
 =?utf-8?B?cFJFZklFMTdlSWhDMFY2c0kwMHdQU2V4THhtdjIyNG5uWE1wZUlVTG9HL2Ju?=
 =?utf-8?B?Q2lZMEdKbGZNWnNOdTN6SHM0U0ZRdUlZM2lVMXdjNzNHY1VqUkV3R0QyUFQ2?=
 =?utf-8?B?eURuMzJlRUJzTU44UTNjd0FEcUh6dEhtOVlkRi9LMUNuTVZTVGI2dllEcXE2?=
 =?utf-8?B?dHEzY3dlUHA5TFNGcUdobXFFQWhCYTlnT0RKN1A5V1lYbG1OUis5SktJV0NE?=
 =?utf-8?B?eGh6VE5idXZUckVoZG1ucVVVazUwSGN5KzBZZDFDcXhIeUd6MEErWHZWL09D?=
 =?utf-8?B?MXNqMkhUamZDVzZsOHhKeTY0ZUNxSGx5WmRBa3B3OWFTLzk1RGVYcm1lZXpP?=
 =?utf-8?B?d0ZEL3NoMVBtQkhHbm5HT0U0L3hHa3V2Qk0wZGpFUVZwZC9kamZ4WTdITlhu?=
 =?utf-8?B?Nzg5T0JNL2diM2pYbFdyNklDR2VTVnpWdGc3RENrcmlJQTVleHMzZUdDVndW?=
 =?utf-8?B?N1d1aXd3YUJxZTBpR0FmQmozbHNybkFLbk80L0xtbHNrWTI2dWxRajg1VGEr?=
 =?utf-8?B?VllOUGpPNjZRWituSi95OSszeEhSd1NLMERWc3hGai9IMThwYzV0SHByeEEv?=
 =?utf-8?B?dnEyWmNQZ2hiaVNJK1lEN090S0JjZnlTMmYzVUViSjcvOVBrZU1YSjEyT1pK?=
 =?utf-8?B?U2ljbUVDUi9oYTMwdm10MWdzSGtkZUM3dVlCOE00YnNycW15Zk0wU2E5b3k1?=
 =?utf-8?B?ZjFCcVNhVXI1ZmpMeDdJblNUc1crdHhFU1F5ek5URW9QcjQwRFMwcFZVRm12?=
 =?utf-8?B?U0tBb3hKWHo0UnJpNm9abG5uNCtoc09wTDk1bm1lbWRwV2xaaGc3ck90dExG?=
 =?utf-8?B?TlhKUFN1R2RKQW5SVzNuRUFOc3J1Qk5mWWdxZEc5c2VaNE55WkpOU0lzRFVY?=
 =?utf-8?Q?GPr285gapIM/RLwkoOSfb/j96?=
X-MS-Exchange-CrossTenant-Network-Message-Id: acab799f-0943-4e57-a0ac-08dbf294bf40
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 17:41:28.2811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5AAJCgYPw+zzZh5q4XXQJUpRQ+IAG/3C+8YfLfHW+2mzDtQq7MzF8t6QpkCRcI0DrbWBlL17ZWJU26dNTcHYRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5937
X-OriginatorOrg: intel.com



On 11/30/23 20:30, Yang Yingliang wrote:
> From: Yang Yingliang <yangyingliang@huawei.com>
> 
> If device_register() returns error in ntb_register_device(),
> the name allocated by dev_set_name() need be freed. As comment
> of device_register() says, it should use put_device() to give
> up the reference in the error path. So fix this by calling
> put_device(), then the name can be freed in kobject_cleanup().
> 
> Remove the outside put_device() in pci_vntb_probe() and return
> the error code.
> 
> Fixes: a1bd3baeb2f1 ("NTB: Add NTB hardware abstraction layer")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/ntb/core.c                            | 8 +++++++-
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 6 +-----
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/ntb/core.c b/drivers/ntb/core.c
> index 27dd93deff6e..d702bee78082 100644
> --- a/drivers/ntb/core.c
> +++ b/drivers/ntb/core.c
> @@ -100,6 +100,8 @@ EXPORT_SYMBOL(ntb_unregister_client);
>  
>  int ntb_register_device(struct ntb_dev *ntb)
>  {
> +	int ret;
> +
>  	if (!ntb)
>  		return -EINVAL;
>  	if (!ntb->pdev)
> @@ -120,7 +122,11 @@ int ntb_register_device(struct ntb_dev *ntb)
>  	ntb->ctx_ops = NULL;
>  	spin_lock_init(&ntb->ctx_lock);
>  
> -	return device_register(&ntb->dev);
> +	ret = device_register(&ntb->dev);
> +	if (ret)
> +		put_device(&ntb->dev);
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL(ntb_register_device);
>  
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 3f60128560ed..2b7bc5a731dd 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -1278,15 +1278,11 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	ret = ntb_register_device(&ndev->ntb);
>  	if (ret) {
>  		dev_err(dev, "Failed to register NTB device\n");
> -		goto err_register_dev;
> +		return ret;
>  	}
>  
>  	dev_dbg(dev, "PCI Virtual NTB driver loaded\n");
>  	return 0;
> -
> -err_register_dev:
> -	put_device(&ndev->ntb.dev);
> -	return -EINVAL;
>  }
>  
>  static struct pci_device_id pci_vntb_table[] = {

