Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31866975AC
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 06:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjBOFF6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Feb 2023 00:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233137AbjBOFFy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Feb 2023 00:05:54 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F62E34011;
        Tue, 14 Feb 2023 21:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676437552; x=1707973552;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LhssCX78EJ7pxa+stvGdLMqNeir7i0l/eGp6IHpN/0Y=;
  b=WOzfR/czNrmrRq71L2eZq9kPlDfxPidkyWEOrg/bhwpvzqGx0UFk9lO1
   +Yk1iZwFXnVOt/zBe8HyHR3PMzxY1WQ9mjdee8qRdfaiNRkjBD0IEAe4f
   g1Qi3sDPVw1eB0Xxr7OWwuNawQ4OtHrKRrgY6FIDinQn+YEfSOWYVNuAh
   iTpgvPrEif4metAZp9d2piRHYbVxWmS8MvXBIkLsX7a66b63cIGhCtABP
   fh6C6MFZGhjKLTLx0XxD/dHDJhuD1X2mVuhvUjemZys4Vk1M2Dut7F1OF
   f/WjbGniYmikeIdnDR3FjcSYQmeR5PloIkNtJxIscQsUBtw03/CGguQ8d
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="358764319"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="358764319"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 21:05:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="778633490"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="778633490"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 14 Feb 2023 21:05:37 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 21:05:36 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 14 Feb 2023 21:05:36 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 14 Feb 2023 21:05:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I1Ap5AS0YnWjVRu9ZTq9fynMdpOfqkafz2ozuZtdY5Vl/Y5e77NVztq6SyiFEvn9za2x0puFV9kCFxznWJ0bcBYAuLk9vtcYg+KJAtoxvBj2br5oVJzXlrp0vZeceeBtsaGedKf1bmZzgB4yQubEnmX2o0kpVSQEH67nx41g0Aof6tH5N+4KYS69WMj6ZfpMA7h59misXGAHxxYbIwcNo34hdgfw1sDBWQ2yBMdnbYPy9PhZ/lK7TRdIsM7oSAP+pSgkVLXLbH33+TF+TxTZ5dC16R/4RTYZTF2wczZFuRPrHB7wI/7COa4AYM8/kejmVHI+susj2tXIS7hbz4Rziw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCbuUAcyLK8MDK6JgBe25TBGJPZWfow9K0Tf9SevIIk=;
 b=OMQ2Tr3GWvPL1wRyJ1qXJLBIRSoXE3NR4DLBkdOXspM+8UKhihdq7ZIcOFQmUxqqWlJfUvIZLgWe0r6EijjmbqR86TeIJ0uhBLATw60xOw5ByxD9Iz5KipLbzAM297jrRnpb4PSJ5rXCtvJxwnHGNZ0F9MiWiy+QzJ/e4MpKbcB7JsCt+1DKy68ZBLXBnyTFQki5S5hwRe+E3H7n6y/ZNqd6Gjn7BvAGoEsXV9cAu0ubTY1dLOssL405AStwmqdThXSFL9A5TkPxHXSHsiGzyxarRjfPvllHeXkIJRuW3QU6wtfXIZxefW1pesx/sC+fpZ6TcJeZFzZT9ymeSTlnpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB3957.namprd11.prod.outlook.com (2603:10b6:a03:183::21)
 by CO1PR11MB4884.namprd11.prod.outlook.com (2603:10b6:303:6c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 05:05:32 +0000
Received: from BY5PR11MB3957.namprd11.prod.outlook.com
 ([fe80::a328:556d:855e:3f4b]) by BY5PR11MB3957.namprd11.prod.outlook.com
 ([fe80::a328:556d:855e:3f4b%2]) with mapi id 15.20.6086.024; Wed, 15 Feb 2023
 05:05:32 +0000
Message-ID: <d3806f93-9d75-5431-142d-1601eb2a1bab@intel.com>
Date:   Wed, 15 Feb 2023 13:05:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v3 15/16] PCI/DOE: Relax restrictions on request and
 response size
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>
CC:     Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <linuxarm@huawei.com>,
        <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
References: <cover.1676043318.git.lukas@wunner.de>
 <fdb52e091b62b34c2036a61ae9ab8087dba4e4db.1676043318.git.lukas@wunner.de>
From:   "Li, Ming" <ming4.li@intel.com>
Organization: Intel
In-Reply-To: <fdb52e091b62b34c2036a61ae9ab8087dba4e4db.1676043318.git.lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0181.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::13) To BY5PR11MB3957.namprd11.prod.outlook.com
 (2603:10b6:a03:183::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB3957:EE_|CO1PR11MB4884:EE_
X-MS-Office365-Filtering-Correlation-Id: 12a48f45-6c15-46d6-f504-08db0f12432d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 16D1Vg4hdKKvd+hnYPydrXPnGEZnHskTvrDp1he6xSH36E1Cc6i+UEC+7dlZYbRXNiGlFllmCyjaerBWrC+jzN6YvdvNiExTJNFy2fREK3L500ADIm/hz5Q4sF0Qq8scolSppg15QbOyAnnDzt1LDgfNi1oJ+UdqgJbkJmL+hq09vmfnZM/X90YmRTEQ7xzsOjwEyw0nqHNGHMy9pHtlroQ2thK0UX21A5qVQR57gEz5ddXhtrHa5g+Z2qOAcAvtCudjQ424jGrZJTbmH1tG1RUCzNCze3q1auS4PyFeaXgscp5WhDPsSoRqyVM5zXHcqTaUqrYDhKV6J48i9GrCnM7kPJfGmM7yVfMI2+yvi2zs/1jezESbJCrCVwIwKGMB2L+oMX6vZCPySKCX6jaa3uKOQWdxPp+khlpl63hhTmnfWqQy0KAquORLuHqQW/8SKf3GmVU8+qHmhxhialOpt0xJuaqLEplB6DUvvT7e4kwYYDrx0N1X/vPiMqzunxc2POLedllBFtrMyfls8uD60EgcqoJIoaNZ2nckCucg9QlopwtoI7xya2OgKAK/LRODTqnlw9eLEAPwgXg6ryGPlqhe9t49Et86clJuKegbfl6iAuWInW0ti5EWFo0G4oBS2YFuNXzQhP6vT+9P3uCJus8yh4pTmTPGb9VPolK7JVmUDNM8z1qlMmrTp4hCC92AF6HQRBRAyRFB9m9ZfXcYa7QoKaef0yIBLL04fSvHU9o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB3957.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(136003)(396003)(39860400002)(376002)(451199018)(2616005)(83380400001)(6486002)(966005)(86362001)(478600001)(186003)(36916002)(26005)(6512007)(53546011)(6666004)(6506007)(31696002)(36756003)(38100700002)(82960400001)(8936002)(41300700001)(5660300002)(316002)(54906003)(6916009)(4326008)(66946007)(66476007)(66556008)(8676002)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlMrSkdFeENNcHlBNnZQZFZ2eFpaejBwRGNtcUJ5SmU0K2UxbzNoUWV3UEVt?=
 =?utf-8?B?MDJnb1ZmNnd6TkpDTlRnWGx1MXc5L1NUMXYzQlREWEdnQ1p2bXhiS3IweWpx?=
 =?utf-8?B?SXo0TjgzL28rbkE4WFc3R1FxUC9TNzBOcGk1YmRmOTA5MVppa3ZWenRjTTk1?=
 =?utf-8?B?UW1XWFl5VFd5dVkxSC83aEd1SUJqL1d5L1dRa2M5QWtNSWJJb3hwRUtXeU56?=
 =?utf-8?B?L3BGcGhqaGplSWlZb21tb0Y4c09OMFdraXVGakxtVW83cVR5a2Z2dzV5SmtH?=
 =?utf-8?B?T05FSlZaMUdqTU0yc3N0RWtvU1JDOUlWY2p1UDJyNFFaVzQyVG1jbG12ZDJ2?=
 =?utf-8?B?REVzWjY5c0EvWDl6VWNaLzZ2MzlJR2ZvbjVRVGxsRjVGMWE0UENDZm9VOTB5?=
 =?utf-8?B?QUNKbFVTL3VhQWZ5RDRrZEFmV3c5bktmdnhVN1B5V1hhbUFMRGdPTUg0SmFa?=
 =?utf-8?B?b0lGcVAzaTlicU5sSlVhQ3BaRnAzOHNUVm5MU2p3YnhicXVueVRYZEd2R0tO?=
 =?utf-8?B?T21jL1YweWE2MEl6Wkw4ZUZsU0wyQ3dLSUdxS1NNMktSUTM4eFhhbEZmYWVl?=
 =?utf-8?B?eFkvYmlvODNWYU1YMnd3WmdGM0Yrc04zZm02UjVzMGREZFJtOEhBelA0cG5J?=
 =?utf-8?B?aFRvbHk0NUcrTGFLdFV6eUxBUVN3d1BZTU5DaXhWbjE2Q0xBN2NCNWJWbGdm?=
 =?utf-8?B?TVdsR2p6VE5hUm9SK2RVUFozOEhOSU9Rd0FXVUVuU2FGdmc5SitpdlRFSWNw?=
 =?utf-8?B?UWt4SkR6SG10andoSXp0VmZucmMrWm5uSmtFTS9xQnFLYnZuNkpjSWdQamdU?=
 =?utf-8?B?ajlST1o2cVFsRFdtaXVTUmxpc1I4WmQ2czdVbVRRRjNoVFUwSHhWVjVUNk55?=
 =?utf-8?B?L0Y2dnlhTFVxZmFCa1N5NDcxRi9ycTg0SlJkWWhOVjFYbHMwMFFNUjBBRmJM?=
 =?utf-8?B?dEVCNkFqeWM3TTM0OFYramtmcExDZ3JJcFIwWWxoNVRPK0twNTNMOU56ODdU?=
 =?utf-8?B?ZmNKZ05OZVQ2eEo0dEIrUFQ5bWJXejV0TkxDYlRsaTI4Mk03Tkk2OEdJM3ky?=
 =?utf-8?B?UHpxTDhxQ3FUdmlEcGI3SlRkNEtISjN2eXB5K3ZxcVRDMDUzb2xvT0hySFUv?=
 =?utf-8?B?NlUwbktpbWJoN1dHcktpSHl1VitWZXp3Q1VSRE1peDEza3NySHJtYnQyYkRV?=
 =?utf-8?B?ZHQ3bkpiYm9LNFgxT0QrclkvZk54dU9EZTBMenBhc056VG1NdkMxcTRuZFdC?=
 =?utf-8?B?bUt2YWZXTys4VnVYQnhORHBXTVRnVG1MeEF6QzZ3RkpGUk5RQnY1OXBNUGph?=
 =?utf-8?B?d25uZk9uTE5YK28ycE9YRXNvSmRqVkh4UGRZYXJqWTcwdGFzTVplaExwOXJx?=
 =?utf-8?B?WGxjQ2xWNG5wQ2t0YmFmTi9aOWpSd3NHTllXWGpDN0crZnlGNUttb2c4R0ho?=
 =?utf-8?B?eXdGN25XWC9Td2F6TkIxdmxib01vbGt2TWVlakkwSDhTMVEzVnFxb1FlNzZY?=
 =?utf-8?B?L3BlaHpMeEZ6bStxeWk5eE9GaXFkUE8xaTRjMjFuaG9GM2IzclJseTlKd3Zz?=
 =?utf-8?B?ZmVFRFZLbDJuUFowY0RxVmpNYTJXb0VTbVBhZzFWY3hzRnpvZDNFc1BjNDdk?=
 =?utf-8?B?Y2NaZld4QlArRGJnUmZmM1U5L0hDeGpvUWM2ZmNRS2k1SlNDMFI2Q3MzdE96?=
 =?utf-8?B?SWJxbXJNQUpoSFJRQkdBOTlsNFFRTmdXMks1Tm1FdUQ0R0JxUGJ1VFlPbGtV?=
 =?utf-8?B?SVk5QmtTbnBQSmp6R1l0YVAvelM5eGhNQS8yUG1FanM0d0IvaVRJeUtlUFNG?=
 =?utf-8?B?bFBncmRJdHJFWDUwV1VVZ3dOU25sU3hjby9CcVJpZC9lcTRDeFV0MEQ3U0Zj?=
 =?utf-8?B?YmZnYVBHTDZtKzVOend6L2xuWXBrK05KWU5Bd0Z1cHBpa3o3KzhvN2dCV085?=
 =?utf-8?B?VGVscmM5WmpreDQ5S3pEdjk3QmRmSHVIMStqZld6T1VOUERBd2JaWVdyU1Er?=
 =?utf-8?B?RXpaNXhacE81WjJvT0U1ZzVZbkRCTm9acVJiVC9KYlFiTGRBZTNCbktWNjJO?=
 =?utf-8?B?VFVQWU0wUVZ4RklMTWFEa0FBYXYwaXh4cU1YdFJGUWJOWkl3bXM4Mkk1ditJ?=
 =?utf-8?Q?o2l3W877alAb5MWxyMMXxaD9L?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a48f45-6c15-46d6-f504-08db0f12432d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3957.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 05:05:32.1161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gpwBRr4dXPklngscSKctBDsXQXywwBefusr7O+YemPMIyTQ959AAN3IHI0m76FeZ8jk7wgH7pOQGcujCzGzaxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4884
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/11/2023 4:25 AM, Lukas Wunner wrote:
> An upcoming user of DOE is CMA (Component Measurement and Authentication,
> PCIe r6.0 sec 6.31).
> 
> It builds on SPDM (Security Protocol and Data Model):
> https://www.dmtf.org/dsp/DSP0274
> 
> SPDM message sizes are not always a multiple of dwords.  To transport
> them over DOE without using bounce buffers, allow sending requests and
> receiving responses whose final dword is only partially populated.
> 
> To be clear, PCIe r6.0 sec 6.30.1 specifies the Data Object Header 2
> "Length" in dwords and pci_doe_send_req() and pci_doe_recv_resp()
> read/write dwords.  So from a spec point of view, DOE is still specified
> in dwords and allowing non-dword request/response buffers is merely for
> the convenience of callers.
> 
> Tested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  Changes v2 -> v3:
>  * Fix byte order of last dword on big endian arches (Ira)
>  * Explain in commit message and kerneldoc that arbitrary-sized
>    payloads are not stipulated by the spec, but merely for
>    convenience of the caller (Bjorn, Jonathan)
>  * Add code comment that "remainder" in pci_doe_recv_resp() signifies
>    the number of data bytes in the last payload dword (Ira)
> 
>  drivers/pci/doe.c | 74 +++++++++++++++++++++++++++++++----------------
>  1 file changed, 49 insertions(+), 25 deletions(-)
>

......

> +
> +	if (payload_length) {
> +		/* Read all payload dwords except the last */
> +		for (; i < payload_length - 1; i++) {
> +			pci_read_config_dword(pdev, offset + PCI_DOE_READ,
> +					      &val);
> +			task->response_pl[i] = cpu_to_le32(val);
> +			pci_write_config_dword(pdev, offset + PCI_DOE_READ, 0);
> +		}
> +
> +		/* Read last payload dword */
>  		pci_read_config_dword(pdev, offset + PCI_DOE_READ, &val);
> -		task->response_pl[i] = cpu_to_le32(val);
> +		cpu_to_le32s(&val);
> +		memcpy(&task->response_pl[i], &val, remainder);

This "Read last payload dword" seems like making sense only when remainder != sizeof(u32).
If remainder == sizeof(u32), it should be read in above reading loops.
But this implementation also looks good to me.

Reviewed-by: Ming Li <ming4.li@intel.com>

>  		/* Prior to the last ack, ensure Data Object Ready */
> -		if (i == (payload_length - 1) && !pci_doe_data_obj_ready(doe_mb))
> +		if (!pci_doe_data_obj_ready(doe_mb))
>  			return -EIO;
>  		pci_write_config_dword(pdev, offset + PCI_DOE_READ, 0);
> +		i++;
>  	}
>  
>  	/* Flush excess length */


