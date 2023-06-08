Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A84F7286A3
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jun 2023 19:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235897AbjFHRwS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Jun 2023 13:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjFHRwR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jun 2023 13:52:17 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B651FDC;
        Thu,  8 Jun 2023 10:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686246736; x=1717782736;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=qspOuCwDOG5t1Z7/eoYucrs29L7VpDUE+O7pSzdj97A=;
  b=a3F7i1NQ+fsjKM+uCsh335eEXOaWB69YehoP/B9hZfXqfFcheYvombYj
   8eQZeI7+Ewu41JwXeirOx21cpCMZEmKcuTx/2YTMPYwk45j3UaMO1YTca
   L03+A5VBTd/w9Sa4aAxGj3kxtECThoh8zfNDQCmeaEsIkyWhvPxawb8GX
   A/dvqqw4gGvWsx7LRO5duBaXPC/Gl4h7A4TrRH/VpXlIEy8c6DzcTZXdT
   LyGYERc+wCVx/IlyxmKKAtUaeReCxMeGynKdKsYHuFydOYfAoHghcCQvY
   gynBoPa9Lzr3V7RQn5HCNwdmH4GGs64V51T0y1cMG1JAbwJ5g4P9GXqk7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="420967746"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="420967746"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 10:52:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="704222551"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="704222551"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 08 Jun 2023 10:52:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 8 Jun 2023 10:52:15 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 8 Jun 2023 10:52:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 8 Jun 2023 10:52:14 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 8 Jun 2023 10:52:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOz+CGvWL0cJDLiu6sI6drWoKjY5YzBfuwXjisfF+ibxnDtMeYrUvPShtrWWp4GQWAXz7IwYWKAV9yTxcs4xmgdi8l5F1Qv5MUeJIdDtEmjxboJm1Fcdm3KJf8FI4+Am4sGhRNX+UuUcMXKALJxfKvVvBQ64qiEBTVDyeFVoamEaOcboWb7B0LM0MWaFt/05u9tlpggV/Oq8v96k5sS7NX2r88m8mpx4YJZBYIrLsuA6D8xv90LcSjw7MYVUEJj4dgG8owqEB1UEtWxGxjrXLXITIyAercRx7q8J4nZmD2jYHAdSw81hw6L+bCh5ZUtWJVLl2sGFEz/pXErAVKbmfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tyGF3/+/QqJ8gG2BJCozuFx7vAP3AXHoL1/m6tiOn3s=;
 b=bZwFxQxz/wqN0dEPLGKChNpTPuEdXk8EhVaqWucpDCkQbijt3yfLmG4vtEBvqxHtgcN9uO+Qkx9k0TjGCghIS24QvHKU/JJ5I6BCXan6sj39wM24j96NZE1R7G++Bkd+icJO/KMlGxzednCN0HfODvgnDzDXxEvQrcdU0x26Ew7/fWvEXcBvO3WthSWpu5BCrlVyXitT30MZmx6So90EdObRjgtQOWRWgTpSJ+f9nq+pZl7OYbfoiUqwXkNPZ77yCGb/z3A0pXpJQWSGDCHzZjSRbXatTL1lg9kxWpIMjPbDNi2xVfK2VPFLun25Noqr4srOirZg4LvkKLj8wUE/qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by CH3PR11MB8139.namprd11.prod.outlook.com (2603:10b6:610:157::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 8 Jun
 2023 17:52:14 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6ccc:155b:3b7b:754f]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6ccc:155b:3b7b:754f%3]) with mapi id 15.20.6455.037; Thu, 8 Jun 2023
 17:52:13 +0000
Date:   Thu, 8 Jun 2023 10:52:07 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>
CC:     Ashok Raj <ashok_raj@linux.intel.com>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>, <iommu@lists.linux.dev>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: Question about reserved_regions w/ Intel IOMMU
Message-ID: <ZIIVR2+rGemC7wlF@a4bf019067fa.jf.intel.com>
References: <CAKgT0UezciLjHacOx372+v8MZkDf22D5Thn82n-07xxKy_0FTQ@mail.gmail.com>
 <CAKgT0UfMeVOz6AOqSvVvzpsedGDiXCNQrjM+4KDv7qJJ1orpsw@mail.gmail.com>
 <a1cff65b-b390-3872-25b5-dd6bbfb3524c@linux.intel.com>
 <CAKgT0UcE5bUe7ChytSyUWEkyqdwnNR1k_rcfyykPPWJ=ZzsdRg@mail.gmail.com>
 <ZIH1/e2OcCuD7DEi@araj-dh-work>
 <CAKgT0UfTzExYZGNCEXCJaS7huWDxwoC3Z_2JCzJHAgr9Qyxmsg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKgT0UfTzExYZGNCEXCJaS7huWDxwoC3Z_2JCzJHAgr9Qyxmsg@mail.gmail.com>
X-ClientProxiedBy: SJ0PR05CA0170.namprd05.prod.outlook.com
 (2603:10b6:a03:339::25) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|CH3PR11MB8139:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a1dbab3-55d0-4ca0-6913-08db6849175b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SPp5s/715sdZTVd7xQt54F9sKmUemLym3BLsb/nHmBLcnP6JYSZPs5kMaZW+EwXjOV/zMgAxEZ5KPLkmvry6ddtWECaU1oTrtmPcN+TYnUM2XGgf15ZtjypFqQP+2xVnrVgvKFkbxBmYJva/W+cPeNFUngn+t6vMwgcPfBDyQHkdzazTZ2lR1raJIpWgV4vBW4z3AEqFMhcqewaqyWpVkv/mn/MnAYr+MvXP0UFhzXDIxovMpboJZwA/3EUvGlA+fn27rUReDzNgeRwDHxZ+/oLqBB3dTiF15hWmjnwbsyIaaMKBK6v3S2CIupf9sHGs6KzxWPpFTWpSMIHaSkkXXyxHseq4G0u/M3WeJCtCcgOCX6WdReDIdrc7HPh3RNS7CpDK/LNcK4HyHQpF9JtVV79Ar5rJjpEgIrtZ4upLbsV8AfE2RGj2PE6m+0lCLzkWzcq97DkDw9h9cpvEWYj0+Ktth8kWEZasdqa+lW5O8owVSrLAlRswVxoi5y47P633sGs/cvHr7S0ugDmmf77CdfpGJIgSv+0TrVsrCUAwsbBh5+8ffjdx6XbgwBtjLTjWDFmuJNxiKXGQwGHqbzPS8YFhZmyHm+j46xH585pnhuk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199021)(6512007)(6506007)(26005)(53546011)(83380400001)(86362001)(186003)(82960400001)(38100700002)(44832011)(41300700001)(316002)(2906002)(4326008)(6916009)(54906003)(478600001)(66476007)(66946007)(8936002)(8676002)(6486002)(5660300002)(66556008)(6666004)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXpVUkI2ZFJ4WU5RbFZBdFA0TlpJWnpsSStubTVtenI5dmFiTFg5QWVNaFhP?=
 =?utf-8?B?YkdVeGRZSUhDQmNFb3FFcHlCMFhwcnF6SnVTWmpRaHdjUCt5VzJCejF5ZlZK?=
 =?utf-8?B?OVhsNjdJT2d5ZHRrVVRwOWJxaHBjTjFBREEyeEozL3FpaUNLMTJPMUVDbnVS?=
 =?utf-8?B?ek5nZ3pVSmFkT3RWTmdVNUFIc2U0MWZDTFo3WVdRcmJXVXQvZENUVzNFWUhi?=
 =?utf-8?B?bUpRVFdsK0U4LytKdTcrVVRLNlQ2Q2FDVXdaK3Evd0wwSThlRjlhNGVxZGFG?=
 =?utf-8?B?Ymx3SnIvM240b0JtdzFzVzJlaEZPVklva05VeDl4aksvdTJHelJ5aDd5TnZT?=
 =?utf-8?B?Sy9iZk5UdW1XdGZhVTFENURDR1BrMXZpM3pXN0tWa1ZLMUZmeDUwT0M4RFVr?=
 =?utf-8?B?UUJnV25rU05wMml0eml3ZHZqT29pdFVVa2s4amVwZ25IKzh5a0F4WVVoU1U2?=
 =?utf-8?B?T0hiTHZHY1hGQnc0eXRYbytJWVVRUDhzMEVvUml5Ty9LNWk3Y3hsNUN3S1dx?=
 =?utf-8?B?c3F1cjhiZVFaNzY3c3dVdEhSWnBTUHlHRmdzemxkVWd5VFpFdWpWR1BDOW9a?=
 =?utf-8?B?bkZMVG1QWU1SOXJJNkVIcWlQeGpBazJIQ1AzNUNGVVUrSld4dzByY3MyV29q?=
 =?utf-8?B?V1pUcFV5WlVXdXVvYlp6dWNiajY5dlNhQ2pKSldFR0t1OXJkQ0dUSUVGRHVk?=
 =?utf-8?B?TktHbTJtSWxRSWVmYUV4Z2drSjVsMTJFNmppNitZd2hwNDAwaVA4RG1CTkRQ?=
 =?utf-8?B?Q1dxUURTWmZQS25BSmx1VmxsNjNiME5nNDNmdCtFTnI4S2I1NFM2QWdTRzF1?=
 =?utf-8?B?MHlMZ0Q3RFMwSktPOFlBV0ZzOFVwcDlGamhSL1hYVVluQXl3dWw5MTVpd2xL?=
 =?utf-8?B?Q3F6NTBEOEt0NmZDYWx0ZlpkbFJORlVVSWNsUFlVbjZ2WUxiUEVoYzV4ZGFm?=
 =?utf-8?B?NFgxdEdFYzFPUW4rQTFrOHFBay8zRDFFVXdYN2xqYnE0MzlBTU9LenM5OUdQ?=
 =?utf-8?B?cElqWFdRcU1DS0lFcW5XUmJrZkJoYnpuWDdScC9LVkt2dVVaOEI2SXE5SXN5?=
 =?utf-8?B?RXdGTGFvdFduenJ6Vy9lUVBodS95U1duTFEweTlFcitUTHdSbVZpUFZETkli?=
 =?utf-8?B?T0VJQ2RSejlVb3RheTBHZW9LcFZuZ0pkcCs1L09kd0VFUy9DZTk1U2JYSHV5?=
 =?utf-8?B?bDMxQ2Uwd3BsKzJPWTlEelo4YlNqWGlqdVZpZnA5bDZNNnZ0cHByTlhXRHBE?=
 =?utf-8?B?dUwyRHN5TTR0K3ZYMkh5eGlXd044TStWTzlQVzIxZkNac0lETDFiNzhQRWta?=
 =?utf-8?B?ZEowdGcrMVNtUHVsdEg5cTUyU1JFa2dMRU5mT1JNUThJY3k5dlhPTks3SVVP?=
 =?utf-8?B?QWZDZDBMUW5FWnNQRURiRFdBZUtnOXQweW51OGRmcllTdzJ1T1ZmWGdMdldv?=
 =?utf-8?B?cVE0THlROFZvYVRObklDaXcrYXFjYlRDeWQyNEtOeno5SlZhMmc5ejFOK1g2?=
 =?utf-8?B?cCtZK0lCTzRXNFY3QkJHb3NvMWZ2VGdHU3BneDBuQkl6VmE0QklUeFBTVEl4?=
 =?utf-8?B?SnFmaHo5dWhUbnRicmtBeVVFbENqaXdCWjU0N2tWSzRrZzhheVJyWEZPUTc4?=
 =?utf-8?B?K2pEYnU4NmFCQW9CRnJId3MvVXdZVkg5L0IxSUJ5T25iZjZyb0RmUXprNVVQ?=
 =?utf-8?B?R2drbmc4VGg1NHM5NVY4dmtXZC85NjJUSE1WRXJxY0loSVNSRXVmMlN2YnBk?=
 =?utf-8?B?L1NiNHFqRjVHN1dGN3dKM1RoeGxPQk92di9DLytCOTNhdS9uRHhXTm5ETU1Q?=
 =?utf-8?B?THRxRldheHA0eW0zK0s2OUovYU1IMnBoc1NpQmxrNmpLNWdpRThBaTBjTUVy?=
 =?utf-8?B?MVZnRENSemRiQVJOVUEyaFlJVkFlNEFYSHcybWZENFd3UXhwU1NNU016aFJL?=
 =?utf-8?B?SUJ1SlhOck9nbVpHSHROUTUxVzZaNVVKSlF3RXhHZEVYY2NXNTVRNmdRWjV2?=
 =?utf-8?B?d1JBZ1FUWHdibnovMXl6OUhzVVZxeUMzZFNReHRweUhOOFFFSVNDRUdJeExF?=
 =?utf-8?B?QmN5L0JJWkZTd3piYVdUZDdSY0poZ2ZVZ1J5SmM5RlFLc0RtU0U4eGNJVlR1?=
 =?utf-8?B?K3hncGMvRVVLb0ZXZUhBY25sbktwK1RYNDN1eUhxcnQrUzhXQkdMcFplbTN3?=
 =?utf-8?B?QVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a1dbab3-55d0-4ca0-6913-08db6849175b
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 17:52:13.8195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CQyoLUeYnj/WcARd08JftBiZmSxSOM4uEvkGv7J78anP9sYSBWZMCOo/lfZnk1BG/IjT8cv2ugS8g3YyT/xyag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8139
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 08, 2023 at 10:10:54AM -0700, Alexander Duyck wrote:
> On Thu, Jun 8, 2023 at 8:40 AM Ashok Raj <ashok_raj@linux.intel.com> wrote:
> >
> > On Thu, Jun 08, 2023 at 07:33:31AM -0700, Alexander Duyck wrote:
> > > On Wed, Jun 7, 2023 at 8:05 PM Baolu Lu <baolu.lu@linux.intel.com> wrote:
> > > >
> > > > On 6/8/23 7:03 AM, Alexander Duyck wrote:
> > > > > On Wed, Jun 7, 2023 at 3:40 PM Alexander Duyck
> > > > > <alexander.duyck@gmail.com> wrote:
> > > > >>
> > > > >> I am running into a DMA issue that appears to be a conflict between
> > > > >> ACS and IOMMU. As per the documentation I can find, the IOMMU is
> > > > >> supposed to create reserved regions for MSI and the memory window
> > > > >> behind the root port. However looking at reserved_regions I am not
> > > > >> seeing that. I only see the reservation for the MSI.
> > > > >>
> > > > >> So for example with an enabled NIC and iommu enabled w/o passthru I am seeing:
> > > > >> # cat /sys/bus/pci/devices/0000\:83\:00.0/iommu_group/reserved_regions
> > > > >> 0x00000000fee00000 0x00000000feefffff msi
> > > > >>
> > > > >> Shouldn't there also be a memory window for the region behind the root
> > > > >> port to prevent any possible peer-to-peer access?
> > > > >
> > > > > Since the iommu portion of the email bounced I figured I would fix
> > > > > that and provide some additional info.
> > > > >
> > > > > I added some instrumentation to the kernel to dump the resources found
> > > > > in iova_reserve_pci_windows. From what I can tell it is finding the
> > > > > correct resources for the Memory and Prefetchable regions behind the
> > > > > root port. It seems to be calling reserve_iova which is successfully
> > > > > allocating an iova to reserve the region.
> > > > >
> > > > > However still no luck on why it isn't showing up in reserved_regions.
> > > >
> > > > Perhaps I can ask the opposite question, why it should show up in
> > > > reserve_regions? Why does the iommu subsystem block any possible peer-
> > > > to-peer DMA access? Isn't that a decision of the device driver.
> > > >
> > > > The iova_reserve_pci_windows() you've seen is for kernel DMA interfaces
> > > > which is not related to peer-to-peer accesses.
> > >
> > > The problem is if the IOVA overlaps with the physical addresses of
> > > other devices that can be routed to via ACS redirect. As such if ACS
> > > redirect is enabled a host IOVA could be directed to another device on
> > > the switch instead. To prevent that we need to reserve those addresses
> > > to avoid address space collisions.
> 
> Our test case is just to perform DMA to/from the host on one device on
> a switch and what we are seeing is that when we hit an IOVA that
> matches up with the physical address of the neighboring devices BAR0
> then we are seeing an AER followed by a hot reset.

ACS is always confusing.. Does your NIC have a DTLB?

If request redirect is set, and the Egress is enabled, then all
transactions should go upstream to the root-port->IOMMU before being
served.

In my 6.0 spec its in 6.12.3 ACS Peer-to-Peer Control Interactions?

And maybe lspci would show how things are setup in the switch?

> 
> > Any untranslated address from a device must be forwarded to the IOMMU when
> > ACS is enabled correct?I guess if you want true p2p, then you would need
> > to map so that the hpa turns into the peer address.. but its always a round
> > trip to IOMMU.
> 
> This assumes all parts are doing the Request Redirect "correctly". In
> our case there is a PCIe switch we are trying to debug and we have a
> few working theories. One concern I have is that the switch may be
> throwing an ACS violation for us using an address that matches a
> neighboring device instead of redirecting it to the upstream port. If
> we pull the switch and just run on the root complex the issue seems to
> be resolved so I started poking into the code which led me to the
> documentation pointing out what is supposed to be reserved based on
> the root complex and MSI regions.
> 
> As a part of going down that rabbit hole I realized that the
> reserved_regions seems to only list the MSI reservation. However after
> digging a bit deeper it seems like there is code to reserve the memory
> behind the root complex in the IOVA but it doesn't look like that is
> visible anywhere and is the piece I am currently trying to sort out.
> What I am working on is trying to figure out if the system that is
> failing is actually reserving that memory region in the IOVA, or if
> that is somehow not happening in our test setup.

I suspect with IOMMU, there is no need to pluck holes like we do for the
MSI. In very early code in IOMMU i vaguely recall we did that, but our
knowledge on ACS was weak. (not that has improved :-)). 

Knowing how the switch and root ports are setup with forwarding may help
with some clues.  The easy option is maybe forcibly adding to the reserved
range may help to see if you don't see the ACS violation. 

Baolu might have some better ideas. 

-- 
Cheers,
Ashok

Bike Shedding: (a.k.a Parkinson's Law of Triviality)
- When the discussion on a topic is inversely proportionate to the gravity of
  the topic.
