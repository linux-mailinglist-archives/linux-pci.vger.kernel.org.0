Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8ADE69741F
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 03:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjBOCIV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 21:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBOCIU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 21:08:20 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB77298D7;
        Tue, 14 Feb 2023 18:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676426899; x=1707962899;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JMs7kjyUhWlJOC1ZgCD35MRLER+2VPHYnCFClYJsWKE=;
  b=dV/0i8GaHpsCN1CTXzAMIKberdBKOqUz3lH5A6Da3qne0EGuf4WQYDJe
   2JGRxqqmtmOMxsoX2v7vdyZkkctkvTY1uhtMbALp/pCSQJ0J9YfZf9EAh
   JeM9eJKVgBAf2X/DKU8ziccuMGlMS+3BK9h/vE5o+goeatMzxxou/H3/d
   EeDCs/onCdBvQX3YyP5vJk52TTjaHxGf4rp0hPtGEmM+0hOpPt719fHOT
   EGxoTbvt+waIOjLueCcRAAmvauxP9Miy0xa4Y1yqyhtxprvu0urQYVouP
   tjqcGcD9SLl4F9fHIYPAhMrHqqoZZXnUUtn8hk1fF1qAlXl98DLoz6plI
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="311689535"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="311689535"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 18:08:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="671445451"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="671445451"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 14 Feb 2023 18:08:09 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 18:08:03 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 14 Feb 2023 18:08:03 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 14 Feb 2023 18:08:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kb2RINBabuy+F7u8qf5DswuKY9iYhpBB643BQvST0yCGsd5pxc/Mhzpw+R60IhLaXFYVPhZvcAp/rO/p54+2Yyd9fiVXq2niu6sDXP7Y+YFGEwmtOd2y1PtUdfiL0BLLkzUm4UlPwoap5P+Ry1HNPtchwUnASGk6GFcJ98PZyXqsVN7YWcf8BJrG1dqO7rkS9J+4HSBFHnLY/l2gIn1QjtW8wY9et5aROVjzEJDm5FwRVVCaSjQ6JaFc694D2rnKoGmTPh8qROtcYAOpmIVJishakRfGEhsLfyf+tCfO6QrThibTwrqSTX5mp/XC0vERwK3VQe0U0somy9G//PWFeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nd4XSohvEJvFK9TEQ9qnuuiOQdsmufogXP6HGHNtVaE=;
 b=Zjr84sCBt2csYWNmdt5dqmhpGfc3ZQYKWAtOwTXkDVf034LBLEjYcwhx8kL4ZE7IhAnSm5VdIqz1m82+wzcp2OaANB/PZl6niaS1DGgMRD6cMW/ZBMR/oONr5ru07MdF8vYKbpIsI57NbQTA6nJfcbUfCa0TdENGbJENmyD+uOO2xw4a0CSU+vnCAi/7Q5CeG29KsKWxxGlygPn2hN/54Ad1x1Xfgnq6uDGsBNFfe+WJZKZRZ41HDkx8zy8qf7LGOSk8z/DWatAO7t5o1SIZTCrmSTt4kPxI9o8908Rzp0cwQiyWtiptyP4iWPzhIEsnMk8r0DEWdLmdPWCA45Re0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN6PR11MB3956.namprd11.prod.outlook.com (2603:10b6:405:77::10)
 by CH3PR11MB8188.namprd11.prod.outlook.com (2603:10b6:610:15e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 02:08:01 +0000
Received: from BN6PR11MB3956.namprd11.prod.outlook.com
 ([fe80::8eb2:90e5:b496:f4ee]) by BN6PR11MB3956.namprd11.prod.outlook.com
 ([fe80::8eb2:90e5:b496:f4ee%5]) with mapi id 15.20.6086.024; Wed, 15 Feb 2023
 02:08:01 +0000
Message-ID: <130d9478-081d-2b72-539d-a377712f04f0@intel.com>
Date:   Wed, 15 Feb 2023 10:07:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v3 12/16] PCI/DOE: Create mailboxes on device enumeration
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
 <c3f9e24fffa318a045f89664fb9545099cb0d603.1676043318.git.lukas@wunner.de>
From:   "Li, Ming" <ming4.li@intel.com>
Organization: Intel
In-Reply-To: <c3f9e24fffa318a045f89664fb9545099cb0d603.1676043318.git.lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:54::13) To BN6PR11MB3956.namprd11.prod.outlook.com
 (2603:10b6:405:77::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR11MB3956:EE_|CH3PR11MB8188:EE_
X-MS-Office365-Filtering-Correlation-Id: 893f598d-1dcf-44a8-6791-08db0ef976a3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4G1anrZZGI0AykvbFskdwDRkJdA1z9xFEKlc9jGKzXam3Tqm6CEoa5yPz9eapSIYGh4/7/Lue7tQtroeEoC9up1WtIgAx6b9Nxsht2SkjD3EIJb1RZ/KPHP8CM/UnWCNBpN3H5+dMz80PR6HrgB/zyaxCH7kD1HwTI8X5/uoIKEYe80CEAIWiSXOJATdt79tgpXH6G2YEYyIKT9dBzMEXOjYrIYua7flflogIsz8zKYecL9YLCdexpRXpAkbvWfpeHXeYaE/grAk/08BkGy08rpBF8+PdwqOcLssi8N9KZnEuWXS9CXlgFkADlxoGT7aHoALMoDUJmCTGXQIp9bqipNGBj/scOM75JUO+Xy9CbkTs+YWqlFqtHe/adi/K76zADGqeYwVs7Eha1ipudx2aXOPAz/BIDTOxSBPl0R0ZRg8RwBk9QtOMOt/nbGmfj2SL8BfCq7szw5c04HtBpUULG6xkX/Jp09qRDhYO+K9CGfx4pG7dxhN7JV5Yp0Z1qhlIW5WlHRE1itzs3VhB1zzK94UgWShivN35l2G8yUzv8jnfz3zwrKbnXeyOJoEzsC2PcN31oSspX5Z3KEkmTaFFw9uLknn9ljT2mnQx2nwBCcg7+JOgA2fc8fj0steMM6FhONl6nIRH4gB6bCjYFo9uBufNq8CbF0Jh73PbUw9huyI8YNfdNny3dsNoUR3NUlbH0UGnEUoZjc6bhrTgxdHKjbklzkDWJWOlLHgr0Y2FjQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB3956.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(39860400002)(396003)(346002)(366004)(451199018)(41300700001)(5660300002)(8936002)(83380400001)(82960400001)(31696002)(38100700002)(86362001)(36916002)(4326008)(54906003)(316002)(8676002)(66556008)(66476007)(6916009)(186003)(6512007)(2616005)(66946007)(26005)(53546011)(6506007)(6666004)(36756003)(478600001)(6486002)(31686004)(15650500001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YndGenRlQXpkUkJkaGxWRmJlYkpKY0owQUs1bGpIK1Rna0wyWDFPRzRYYVVw?=
 =?utf-8?B?eEhDSzNNWVVUaW1iQzJqMi9lbUhORGVRZHJ6Zzcra1BtK1Q1R1RSUlVQa0lq?=
 =?utf-8?B?bXo1bWkzTnVHQ2k5anBXREVHWW0yOVpSd3kxSkRJVUR3WkRJclZtVXR1KzVE?=
 =?utf-8?B?Qm4xcFFITlNabTl2b0Q4RnV0bHlabWNPaE5CSXFxakkyclV3QVVUZGJOd2VE?=
 =?utf-8?B?SitWNXlNME0wcmd0eGNWbzJYUDA3TjNXc1paK0U0V3NVS3VEZXZOUlIramgz?=
 =?utf-8?B?blhSVjMvMzg1ellmZWZkd20vT0krRTdIdVlZNTNUa29RRWloMzVwdmMwN25P?=
 =?utf-8?B?OGltTGNuRm90WG12azEyVkV1ZEhxKzU3SExCRS8xd1o5dVYxUnZGZWF2UEx0?=
 =?utf-8?B?MFhmZFEwL3NCNGh3MjdXRGloOFhwMktpVDJENHc0Ti9zbWs1MzkveDFWTnhC?=
 =?utf-8?B?ZExFZWFLdzZucXBMdVpJUkZZbFBBZUtJQVB4YlFlRmVaZlNTcG1ja3drRmU2?=
 =?utf-8?B?elJ5YWpTYVVDSGVHYTlpdU9SWnZqYk1WUGN5UGVPYWtHcWdhS0VZbDkvTUZ4?=
 =?utf-8?B?RHNQNVkySEdwMG1KNUQ0L0ppRW5HTHY2YWxhVDJWYk5uSzdCcXFUb3ZoL0E5?=
 =?utf-8?B?NEdXUjJNR1NXR0Jkc2FuRXZsdExKbS95bHJ3cGcvcGFLNVJ2SkV4QStGTEps?=
 =?utf-8?B?cS9LeGRyb3Bsb3c0MW1KdWdHWUFicGV3NFkrL1dYOXlQcHNKVjdqd3EzMzRB?=
 =?utf-8?B?QWd6MDVQdVVjMW9nZ0grQnhMcXBtdHUzR1JNMXRuNGxhb0tOWmYvQXlzWUtz?=
 =?utf-8?B?MEJHa29ISU9haHdIaHRJRU1HNzkyY2R1a24xbmdZM0ZvTmUzYUYyK1VwdnpI?=
 =?utf-8?B?OFpVWTY2eDZjUGlUekJka2pjc2ZGR1NZb1VWT1JrY3pPQ0N6Y0ZucE8xOVp4?=
 =?utf-8?B?bGE5amx0K1NFUUhzT3lzR1lyVHlaYlQvYzd1TktKbWJacjl6QXRIbU1kMTFC?=
 =?utf-8?B?TDE2U2NNVzBoWXpRWWN2SFhPTWJMNytzcTY4dmVMYXFXSmpOTmpDLzFrWG9D?=
 =?utf-8?B?NnJVTWhac1c3cWFRQ3pYaXpMajFRQU03SU42S2U4YjVvZlVCTGZrbVpraVVE?=
 =?utf-8?B?bzhXb3YvMmliaWlTeTZRdjh1disvWTBhTW9nZ0ZiQTZNdnZNTU9kMXc2RDRG?=
 =?utf-8?B?M3EzeEZMM1VXQ0E5MTJMakJGYnJ2TWxZNzFQRlZpM2xUSGxkVDBxOVlyZEIx?=
 =?utf-8?B?dldjSG1TaWZCbzl5TDZ1cXV3ZDNHV05BQXhqcDBZTTArSXc4aTh6WFV0ZU9v?=
 =?utf-8?B?N0V5UitBY0RjTUxTcE9sNDFyL2t6bGN5QVI1VHdWai81ZytlTUJyRlIzODFZ?=
 =?utf-8?B?bnNRZUR3MUVvN01HMUZ1Tzg4TitESUFsVHhYa0hnM3h2QnFjYVRrbGJvYUtn?=
 =?utf-8?B?YmNDcWJyWllMUU10RUhrVEpidXcxeFh6aUZ1RGpwSVA5T2drUzhpdHVlM0JN?=
 =?utf-8?B?Q0ErODU3bWU5NjN5QlFvbUEreUZXb1EwcXIxWVFwdUI5UHRHM25aKzBDelZj?=
 =?utf-8?B?ZzVTZm1MRWFpbXYxYnk3eFpJb0kxV2tORHVnWDBNd2lHa2RnbHZ4bE02S0tv?=
 =?utf-8?B?WXUvNzRHdUJpRUxQSDRKb09NZjNKQ25Ud0hmYlhtNDJ4TG80M2g4clI1MkVS?=
 =?utf-8?B?cEdTckxiWWRTMUdGV0ZEMXJ2Y2MxQlhCTVdlc1pOREpWcEVyRXJGLzUzM0tz?=
 =?utf-8?B?Q0h3UDdWSmI5RDFxOXlxZjJ3MkxHeVJ0TXRVZmg5aG5zREVCL1RENzR4RHds?=
 =?utf-8?B?SWVEeE9RNmdDWE1nL2JSOTdrNitFTFBtWStrd2NLZ0xSeUNhZXRPcHYwdnVW?=
 =?utf-8?B?T08ranQ4dnM3Mzl1QkNoQzVUVEhMSm5JV2lON0RuYm0vNXVhTzNCTDRtMXlE?=
 =?utf-8?B?SjNGWnJEemtTZS9YRk5wKzg5cVR6U0l3aCt6TFZjRWM3d1ZuVld3aE5vY0lK?=
 =?utf-8?B?aURrR2hxa0VtcjZhalJjVTI5QlBYU1FHVlI1NnBIb2ZTL05WZW5RMjg0ckFK?=
 =?utf-8?B?RzArK04zcnhPNzJyYUE5NHlEYUZQK0NPc0xibHFvY1RObW4vdXRVYW1TcE5j?=
 =?utf-8?Q?8UpxHppaOvqNz+kcP/1/ypULG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 893f598d-1dcf-44a8-6791-08db0ef976a3
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB3956.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 02:08:00.6872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mErrXocGbjuMyz8JVu3vO8eGYnaJZed2sn/WteHT6eCUpEA9rMAomoXZb/POSeiUlOq8LADTkyh/n+F2X7S4YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8188
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/11/2023 4:25 AM, Lukas Wunner wrote:
> Currently a DOE instance cannot be shared by multiple drivers because
> each driver creates its own pci_doe_mb struct for a given DOE instance.
> For the same reason a DOE instance cannot be shared between the PCI core
> and a driver.
> 
> Overcome this limitation by creating mailboxes in the PCI core on device
> enumeration.
> 
> Provide a pci_find_doe_mailbox() API call to allow drivers to get a
> pci_doe_mb for a given (pci_dev, vendor, protocol) triple.  This API is
> modeled after pci_find_capability() and can later be amended with a
> pci_find_next_doe_mailbox() call to iterate over all mailboxes of a
> given pci_dev which support a specific protocol.
> 
> On removal, destroy the mailboxes in pci_destroy_dev(), after the driver
> is unbound.  This allows drivers to use DOE in their ->remove() hook.
> 
> On surprise removal, cancel ongoing DOE exchanges and prevent new ones
> from being scheduled.  Thereby ensure that a hot-removed device doesn't
> needlessly wait for a running exchange to time out.
> 
> Tested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Ming Li <ming4.li@intel.com>

