Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 118C84789BC
	for <lists+linux-pci@lfdr.de>; Fri, 17 Dec 2021 12:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbhLQLXu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Dec 2021 06:23:50 -0500
Received: from mga17.intel.com ([192.55.52.151]:47797 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232376AbhLQLXu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Dec 2021 06:23:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639740229; x=1671276229;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9XN0DDLnEci5y/p5ugTDHM+r6B41a7fszqquHJfviHc=;
  b=VzGrAVdBFHZwweh2UgLg0379+LMLN8r3Ksq/0pdT/cdk8yTGp9NIrXkK
   2vJRp77NMkbyIfCHXSM2y3KaoaV+MvC0EV4ePnmJj8pIURz6u19gFIGkX
   ZTvmP4qGdqWnY1nTcmnLS1KoVMXV4A/0JGQoc6ACIVDt34++ILadLRZcb
   L3juGBmXHigVGtOfCLd/0uwtcXX7hirNpBXlIkjt+w0YbgPnSbeeNbI6d
   AYcFaUaKItUOXo+VCwnx/49XHhvKTQ2ZjucHnzbXMsaZfhk60Cn9fV4lc
   wKHJdkCAnysm8fvXiMgNzYZxT8obsOUAMn3l1os7nOAhFAjCGm/TIQDYY
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="220416365"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="220416365"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 03:23:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="615532124"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 17 Dec 2021 03:23:49 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 17 Dec 2021 03:23:48 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 17 Dec 2021 03:23:48 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 17 Dec 2021 03:23:48 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 17 Dec 2021 03:23:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPMeW4Lc+bZsN3ScaVRtkCKFgr+dffooKGdExSO0o6C/rYy+BcK45nyKZ3eGSDgKtA8R59oZhvJn65nyYBmwNP4JPhyr1FBW8AcDttOkD2Jr0zN/SWkVHRpi5AK34UV0s5EcADNA6VhlgLb7MGYDcg0xFYbPUGiLeqsCehd+BGJ+is6WYEEFS7y1tF32UUTEEhUR726Pcrlu4Z+lQHmM1w6ZhJXgnuE3A2B+GCPTnihTqLsvY8wiGNuGzXEY6IJWsGVTkSBW7R5VKL0ja1m1wT9ji0WZcdX3gM7CXgSSb+KHqhRPCShptgb0IqaLe72k6CU79ZtPmwHc033qc3JK/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PPHQUbeUhTKYRJEFdaiZKDqTMz4p85JwGdrm0s5XdU=;
 b=hvoAHQshC6Dre5meaaWELPcsfxzcNF6N219dHb0VZixpJVqrdeejJrQsgof2BWAFERC/SEeGF4QfBpYl2cCrYDOZ2umKZoqdkwXCeEPpHk/qCZS5ccrd/iyaDWVmece7Q0v6w9kF2PB4iKCWj5G/TI9dr2j0gz9CMwmFaTMRHXp7vr35GHjFgTBCTgswW+SljNx1sW9uRZKxEuFIxAnNxzrWoRqFs2r30MM0IecVmJrFjkVB/UY6+uJX/VNb4PmGw+sRZ0joV9BYPgSJ/HxLDB4vlIsXPrk92JPEz+YenoK1U9B1BCfst0B/ravFr1/Zt8xNlDFlYDcCSf7Dny6+3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5373.namprd11.prod.outlook.com (2603:10b6:5:394::7) by
 DM6PR11MB4187.namprd11.prod.outlook.com (2603:10b6:5:19e::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4801.14; Fri, 17 Dec 2021 11:23:46 +0000
Received: from DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::54fb:8c9f:670:3658]) by DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::54fb:8c9f:670:3658%4]) with mapi id 15.20.4801.017; Fri, 17 Dec 2021
 11:23:46 +0000
Message-ID: <7a82ddb8-5cb9-aeb8-df20-9f0e2c6fccaa@intel.com>
Date:   Fri, 17 Dec 2021 12:23:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.0
Subject: Re: [PATCH 2/2] PCI: Don't fail BAR resize if nothing is reassigned
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     Ard Biesheuvel <ardb@kernel.org>,
        "Michael J . Ruhl" <michael.j.ruhl@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
References: <20211215141626.3090807-1-michal.winiarski@intel.com>
 <20211215141626.3090807-3-michal.winiarski@intel.com>
 <60ff4820-5dd9-bb3b-9baa-55ac53c0646c@amd.com>
From:   =?UTF-8?Q?Micha=c5=82_Winiarski?= <michal.winiarski@intel.com>
In-Reply-To: <60ff4820-5dd9-bb3b-9baa-55ac53c0646c@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM5PR0301CA0033.eurprd03.prod.outlook.com
 (2603:10a6:206:14::46) To DM4PR11MB5373.namprd11.prod.outlook.com
 (2603:10b6:5:394::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8105b605-ac97-49c3-b48a-08d9c14fb0fd
X-MS-TrafficTypeDiagnostic: DM6PR11MB4187:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR11MB41877BC9EA4904770590095298789@DM6PR11MB4187.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a1S12OJZ7kKSUwoE+1GFjBCXyV/FPxOJddFVxKGuJMcCKYaXBbmjE0CspuET0P4qav5UX5uPa3vKy5CBs/K1DhvspzeuuGCg9N1aWG7Y/YB3rYiUv504zJfhTd6jMXPdSDY4GUDlXazMIVNeeYZ91AOmSOHwQ5wrgZDKZM4lrWW3fwf0itmYNRLnwv/1YspDLkLg6n0orOpXl83J6NHkc1ojHGE8MKPj7IQlzatbvd20AlrJ87OzwYkS2xLVnfiDJh4dvCEnLAOsd9oMrE1TkFhmetS4SGXGskjFOBHBBa8Xs9kw/oERvqST5XWANLEBmfU5gSk7WYOC0RCIK0hXM8nc+cOKyiowD5uuTO48e1C66Rfjp2apt8cv3ipqQ7IC2dvAZrTNnza760vsOqz2VonZpTbT4lICTjzbhRGcKcwqdxjh2BK3Y4I5Hu73I6igKNC3JnW8q9Ge/fO83urpwB4sTaVB5gMRH21JXXg8gzlkRCv8O0UjjgIx1owxrhMx3/oJDy3HCbHU9yDJcGtwvC8z/lQF+/Lxs+R/b1gl9l0rBYDpxwXAfpXJMY70LqSNxIdgBvyLgfaM2gveorEJyd5BJtdYOHOzCHVTbDjkg7WCd5vs7lkUiWLrpDHGM4hZ9cAwq6pQ8epQOr93tvPxPmpDvUdT5Gs87ZWVg+EabyQI5nV6XJM2M1/znXalNQousiQT3bzoSW3QN+2EalH/7nlg8+UDuzPYDW3XP4nUHa0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5373.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(86362001)(508600001)(8936002)(8676002)(5660300002)(6506007)(82960400001)(36756003)(6512007)(38100700002)(31686004)(83380400001)(6666004)(4326008)(107886003)(31696002)(6486002)(186003)(110136005)(66574015)(54906003)(2616005)(316002)(66476007)(66556008)(66946007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3VUOHB3eU1XRGtFc3VNaHVMdzd2TDlQV1ZCT2Z5dTRMbzdLdjNYU0VzZEhQ?=
 =?utf-8?B?NXlTYkw2QlNSVnJiVHlRblNyN2VsZGF5eTRRY29McTEwVzJGd085dFZlWW1j?=
 =?utf-8?B?RmdvbEJJMjcwWExiRnJwWlhLcm51WG1ZVmhrdENucnRGK3hrVXJWcDVPK293?=
 =?utf-8?B?aStMSEllV2FETXRwaFRnMHVXcFRsLzh0OWVwV2FmOHZVSFlXL2tOTDA0ZFNU?=
 =?utf-8?B?ZVZhcXNGd1E1SWNkY0puWlFkcWZBTUZBQ2c5R0hqNXQ4UkhYTUhLOGNvMml2?=
 =?utf-8?B?a09SK1Q0bWtiYjc2Ry9UOTRaN0xVWldCTVJQVG5JbVZYZjRLRGlGUkx5azcv?=
 =?utf-8?B?cTY3VUF1MFcxdmcrQnZIR21HeTRlYzYreVJsMmVNWlQrSVg5T09HYjNhUmJs?=
 =?utf-8?B?akxQaWU3V2d2b0J2ekhkUml0K2RLR0pmSmE1aGI5Z1dDOS9odk9uZEhoUFJy?=
 =?utf-8?B?K1pGM0syZWRFdGxZU2dmQTV2WTgrNVRxQnI0eVR6TWlQZFhka2NyQWR2WmFh?=
 =?utf-8?B?VlJkVndQcXRVbmwwSFp2U3ZtM1dDTnRFUU9SQkkydG5XUmNrVzhINTlWdFVh?=
 =?utf-8?B?SWdUTEhFTzFUMWNRdWk0aHZTL1BVSzdvaVVhUWhYYW80aS9wdi82NC81MTgz?=
 =?utf-8?B?SjJrc0ZIZEJOK2VzR1ExQ1Q2TjlrL1dsNUxTc1ZFYnNrMUV0blRBcjBPMXl2?=
 =?utf-8?B?QlNiRTJhOUxFSFRES3oxdncvT1pkMzh4OXp6bUhscmI5Y21iK1NIZ2JmZnkr?=
 =?utf-8?B?TzFMVmdaa04wd3VPdDFucnVlMGNVRlNWeGg5YkEybHJmTXlaKy82RXNWR2VD?=
 =?utf-8?B?ZWdjMFpMLys3NlV2dFpyMDBuWjBvTWNFdFBWM1NnM2xDd2Y4eVZpbWxjaSt3?=
 =?utf-8?B?TC9rOTJ2eS9UYUVFK0krdDJlRWJVblhaeC9IdU5iT3hKbHlzaFNpRjYydmoy?=
 =?utf-8?B?S2VxdllEakhEL29WajR1dUU1YmQ3WHJ2TDFTWmJGVzA0YVBwV2QzUUlEWlVh?=
 =?utf-8?B?RGxoSFI4d25PN2RYTEtmdFRJb2FFbnZoWFJlNU9YcVIrYVUzb3dIVUtVVjVH?=
 =?utf-8?B?M0xFQ3NYYk5iRkQreTAvblh0VTlkVkcxUXQ5VTFMTXByK1RMNmd2RHdwOEhD?=
 =?utf-8?B?RGNLSGZROXJxLzZGb1lNVVJNTFVFUFlEbGlWRjduNnFzUTFkSmp1Ylp5M3Fw?=
 =?utf-8?B?YzlyRlE0a2VaSlJjWVdIN2szTnRJRS9Gb1E2U1RNMnBQRTlkOVRBcTlvMmxm?=
 =?utf-8?B?RXU3SWtDRjZiNUR2MVo0YW9XVVd3K0NxbmlNbzNaTENaODVxRG4wTXcxOENQ?=
 =?utf-8?B?dWplNm5TMjA5ZWMzdjdkNmF6MDh0U2xqYkJ1RDg0VlhPU2E5REEwc21HMGtm?=
 =?utf-8?B?anZob2V4azkzM2Zwckx1aGp5RGs0c1hYaEhYSGNUWW9BVUZIak8ydUs5dU1s?=
 =?utf-8?B?d1U3UVl4TEY2VTVHYnhEQndvbDJOMTVQQzV3UkRTSUxHa096RUhkazRFNnpu?=
 =?utf-8?B?a3lOaXZQWmpWNHJYazU1LzB4SnRjbkRpcnVDMHlKdm4yb2huUmlwQkxBUzZX?=
 =?utf-8?B?TGVWelpEQkY3eVhqaHU4dUt2UWdISDV5Z21KMXVVMENDN292NkpVY0puSTEx?=
 =?utf-8?B?T1l5TTU0MTFJMmsyVkZiZStiR0w5OWNzSU9QZWV3eW9BWmlHa05FY0NyQnRp?=
 =?utf-8?B?VWdseklaNTVnSGRvRWdJY3VNdFY1d2dxcC9UMFJLTmxtQ284M1BoZkJSK3V3?=
 =?utf-8?B?MFVWYWNZWjl3cldXbkF6WjNuWXhkNDNkL3g3ZEVmNm5mTGRjTkJSNDJlZmla?=
 =?utf-8?B?VEFCeXlTVTBQT0FNWCt6YUhiTjMwQWJ6S3N0cVlvS3dsVC85RHdLQm9DS0JJ?=
 =?utf-8?B?RFFsNmhadW55NEZ1dWgvT1BMSXVkWXIrQUZaaHpoWXpQSHJ0c09OY25SUU0y?=
 =?utf-8?B?aXJCWXlOTnhWaVJMTStkQkRwVjJ2MUlTKzB4TTJQQUljYWRUM0oxSk42M3Vw?=
 =?utf-8?B?K1U5LzdGanZDcHg1SUJKSjNQbHlzVEFsNXd3Zjc1S01FdEFPZHdqejVrUGM3?=
 =?utf-8?B?RjRJSDlrMGJtMnd6bTlCM2phUDZYTWcvU0ZtUXpyNnphWkZueVV0WFJNVi9E?=
 =?utf-8?B?K3cwaGNOa1hDciszSStpeUc5ZDVPTEhZemx4QVhjc3poNXdxTm9BbUlTYVZr?=
 =?utf-8?B?bGZSZ2NZRWJEYUd3ZER5Um5ka2FxU285bWZBMmV6QytGRTlJY2NXSUs1Qkhw?=
 =?utf-8?B?Z1k4cEVzMHlBbDN1YTdxejFZR3pnaURWSEMrWS9KSmxPTnd3eUJNWlI1MG9P?=
 =?utf-8?Q?cQv541dAyzrGIqSviA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8105b605-ac97-49c3-b48a-08d9c14fb0fd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 11:23:46.7348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B/wijtwAWlgvsIQ9RzWWs8ZeZ3haF3mh2MqvoVgRyAt9iFJFmn7n9gl0wusQXqHpT2J6levPMRu04/6C/bVegPy8IWOBuxqKlg08qrGTy9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4187
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 16.12.2021 08:12, Christian König wrote:
> Am 15.12.21 um 15:16 schrieb Michał Winiarski:
>> When pci_reassign_bridge_resources returns -ENOENT, it means that no
>> resources needed to be "moved". This can happen when the resource was
>> resized to be smaller, and it's completely fine - there's no need to 
>> treat
>> this as an error and go back to the original BAR size.
> 
> Well that doesn't make much sense as far as I can see.
> 
> Drivers mandatory need to call pci_release_resource() on all resources 
> which might need to move for a resize, including the one which is about 
> to be resized.

Since IOV BARs have their own memory-decoding enabled bit, which is 
usually tied to the lifetime of virtual functions, the PF driver could 
do IOV BAR resize during its lifetime (without releasing its own resources).

> 
> When you get -ENOENT from pci_reassign_bridge_resources() it just means 
> that the function was not able to do it's work because the driver failed 
> to release it's resources before the resize.
> 
> Technically we could indeed skip this step if the new size is smaller 
> than the old size, but then the question is why would somebody resize in 
> the first place? The freed up address space is not usable if you don't 
> do this.

With regular BAR, the size of MMIO resource is equal to bar_size.
With IOV BAR, the size of MMIO resource is equal to iov_bar_size * 
total_vfs.

It means that the driver could use the pci_resize_resource in two ways, 
it could just call it like for the native BAR - overall MMIO resource is 
going to grow, or it could limit its total_vfs (overall MMIO resource is 
going to shrink, but from VF perspective, its individual BAR is going to 
be larger).

To ilustrate:

Native:

  1G    2G
+--+  +--+
|  |  |  |
+--+  |  |
       |  |
       +--+

Resource grows from 1G to 2G. No surprises.


IOV 4 VFs:

  1G    2G
+--+  +--+
|  |  |  |
+--+  |  |
|  |  |  |
+--+  +--+
|  |  |  |
+--+  |  |
|  |  |  |
+--+  +--+
       |  |
       |  |
       |  |
       +--+
       |  |
       |  |
       |  |
       +--+

Resource grows from 4G to 8G. But for larger number of VFs, and larger 
BAR sizes, finding MMIO space to accomodate may end up being tricky on 
some platforms.


IOV (limited to 2 VFs):

  1G    2G
+--+  +--+
|  |  |  |
+--+  |  |
|  |  |  |
+--+  +--+
|  |  |  |
+--+  |  |
|  |  |  |
+--+  +--+

No changes in resource size, we started with 4G and we end up with 4G 
after resize (but those 2 VFs can now use 2G BAR).

Does that make sense?

Thanks
-Michał

> 
> Regards,
> Christian.
> 
>>
>> Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
>> ---
>>   drivers/pci/setup-res.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
>> index 1946e52e7678a..5de5129055e0a 100644
>> --- a/drivers/pci/setup-res.c
>> +++ b/drivers/pci/setup-res.c
>> @@ -484,7 +484,7 @@ int pci_resize_resource(struct pci_dev *dev, int 
>> resno, int size)
>>       /* Check if the new config works by trying to assign everything. */
>>       if (dev->bus->self) {
>>           ret = pci_reassign_bridge_resources(dev->bus->self, 
>> res->flags);
>> -        if (ret)
>> +        if (ret && ret != -ENOENT)
>>               goto error_resize;
>>       }
>>       return 0;
> 

