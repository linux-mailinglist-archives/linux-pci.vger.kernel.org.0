Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137EE55E754
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 18:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346749AbiF1O14 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 10:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346144AbiF1O1y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 10:27:54 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7D22CDC3;
        Tue, 28 Jun 2022 07:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656426473; x=1687962473;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=SS6n+ItDhV2wXHH5Y5gPQfDTKNgJV8wt0OTnP53wVq8=;
  b=WMX6aLEivBO9cm5r8zQFARTdY2J7G5o1DvYBuv8vDOZyfDHEoMwfuAZY
   ouQtS5h9Vnf6xQ0ZwNYS0Rs7XLoNpzyYkjjNxGhLeRTVgkRjvbviiqlnk
   Gd8aBB8oj2rPHBxq7tFtsZnxc6fjCCrG7U8mdhMakx8Y7qy3CNnAl2PvG
   FRo5ukoHRoZA4DobrZfEtE5gzjP0cL9OzaV5FqCF5Ex+MTvD+PUEy5fw4
   +ZRs5bJ2BNgHypnEKxntjihK6pjShZHpJqOfyS2vRl4XCCBvaQ3qVOYCE
   +i2Kj4cXhqoQticT6PzpLshc4R6ULYsuEnSyP2V+RJdmo2QcjFV1oh3qh
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="282490281"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="282490281"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 07:27:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="717459500"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 28 Jun 2022 07:27:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 28 Jun 2022 07:27:52 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 28 Jun 2022 07:27:52 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 28 Jun 2022 07:27:52 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 28 Jun 2022 07:27:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OoE5Ml04ZKoP3HM727rYh28RNrZqwKo0U8DFOBBnNmiXkQnUipso2IWeZMJ0rSGNrE6pF5ju4KNZVrQ6wxc4GYLEA9I4FUvX3HNyibpj4h6s1eZZN/qbYCtwoMtTa3+2yysmsh+w2vVcnGdkRZtC1RvNSZx/YA+iAP87DLMJZU6MXzoDGT1gberKYSTJO+VIKQeeeRvu92DtCGYHBNiApYXg6YahVXl9EwJgZDHCtzw8T/YM2tMEPAWTuFoTf/+uRLiqNCX/kEnIAYxb1DUHGYdqlb15ZXBQNyE0k+X6ptFTYjt7lVCPSsucwiMD9UJ1Y2neNb0r+BtxK4sjyVRz+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u45xGwDyjQByits0TUpbo7Zi2to5y6Yif3VNQAQTIjk=;
 b=lobz20eO4+MfPFHKY4N0k9A40j7scVaoV/gvfYGcPnttDb+OBfav/4oxjzpT2IJEOOtjmqufhbAIyJ1Pwb7CkMtopFmg73gREF27ivuXyaU3F2LiqOGVwCLqCqNI5kSRhUF1UdLG3t7m6RWYgU9uXnpFobSAgADTxKF34CWthiI65RgzjXxmdasnHOp0XfaJi418ZlTKDOjWRZqscV8UVQ+iWu3r0y7Ib8yCIKI2HBwKiEHZO6iHMgvxQXr7MMEt/BCUdtcNczhtBEIahR8yEFDylr/RBCv4hlcmUOmbWhcySBILut5M3jX8Zp7deT3a5GjJJLwMOilbVkYhVbFdwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SA2PR11MB4955.namprd11.prod.outlook.com
 (2603:10b6:806:fa::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Tue, 28 Jun
 2022 14:27:51 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 14:27:50 +0000
Date:   Tue, 28 Jun 2022 07:27:49 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <hch@infradead.org>,
        <alison.schofield@intel.com>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH 02/46] cxl/port: Keep port->uport valid for the entire
 life of a port
Message-ID: <62bb0fe548533_169b9c294b9@dwillia2-xfh.notmuch>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
 <165603871491.551046.6682199179541194356.stgit@dwillia2-xfh>
 <20220628124718.000023f8@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220628124718.000023f8@Huawei.com>
X-ClientProxiedBy: MWHPR14CA0068.namprd14.prod.outlook.com
 (2603:10b6:300:81::30) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1abdb9ab-69e7-49fc-6e0c-08da59126188
X-MS-TrafficTypeDiagnostic: SA2PR11MB4955:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S2AVnJ7Yu51ptQTlz/3tJfyM4fqJYWL4P2UBhofhd03JFDPU51KQBltt22exBkHwsunhDo+ALksMhFtAqJybngcqPenFo0HvZfgefnk0Ya89opSEOiMkzoIf6LBEA1hru9SOnas2Rl3BfOoQW5p6TGNthCj0R2m6NtrIxbZAgB320OiSvKPSclz4qjRIQWmhD9Dxx7/NrsyDt1E82CQMD9xYQHvk4i0HEfmjB75Zky1u153Gzd5FBErRUDJHCaaCneYohi9oabZDNqLV96oRS0PVdK9VbiDrR9b2b5oIUIalOvGf9EU5/LwDIGdNMlO1aUjt116313foc3fnou9D4pBlj5J/PhmQB81JEX6H1gr5w90FKShhxfQtS7YY8a3Go3jtONPwbJLwXO/n+HRdhsxsLEuLnd+3BeyU4K840kfjYsjWiSAt4b26PzzIgZ0q4Upze6VBxTlNZ0xCI/gdQYL0HPGrsKUn/esNX5WaTvb3tHJyGgth+ocAaHUiAV2nvgkZO00jScCrgie86Td1bi/NHmrpFDj6WtZUXijZDZaFJdLgK6PUUpQiRf7tXJudtkmuP0vCsJFO9fzBhnacvwvB6GgUgh+ztipK+jV0m8PhhkTxIx3MyFR5MJGi+NVUGRQiT0ejdlWE3Sk5hcVSGqHcDdf18v2ioHsilNS8fTFLCx2bbn7E56uaC3JWoqiDckC7rcVY1Yf0gOkEXHoMv98z338Y+v62nvNyx5AxYnc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(39860400002)(346002)(136003)(376002)(86362001)(8676002)(5660300002)(8936002)(83380400001)(82960400001)(186003)(6506007)(66946007)(478600001)(6486002)(6512007)(38100700002)(4744005)(316002)(66556008)(26005)(41300700001)(66476007)(110136005)(2906002)(4326008)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SWAqlD+0Q0eN7DHTxolZIhIMfSVXnrNb+yvCYMhDYh2s3UAvu3GDSzphoJH6?=
 =?us-ascii?Q?6P3LxyJgwjwTUnJngFwh8/Gz3pxFhqi6i5JHM6PlYBO8wnMFV8Cw7UXvVYBZ?=
 =?us-ascii?Q?QWYO8v1fqYdQMAqI/1IkbJcN4r+8eZRc7WeMrSxdUEg7eAgGLFsNl73FW2lN?=
 =?us-ascii?Q?RCTIV5bMKS+U2PyqjNwflNYUTDnGV3gfMNx0YfC6wkp2IsBJsfLjVPZ/ZQki?=
 =?us-ascii?Q?BSjpF4yAJZKAj4HUFQUs720lqIM9GREFPcqwUhHGoY5vxlaSauKo2GFpxB9H?=
 =?us-ascii?Q?2+BSN61Gpb3PRhKnYdmbhBpLydfggnDZ34uljKqI1jIyuD1uNZr5q1Gq9B0T?=
 =?us-ascii?Q?/XgU4ozd1PvX8Fwj8hQHOEJKheH97rEOe3Te6UwIkvXduG7f8IHD3OA4sIyo?=
 =?us-ascii?Q?QO7sCS4VMUhtZ5/C4uy6Fig7FGrmE5qmgFOEu9dGDlcjXZ2Eubc93scgk4AZ?=
 =?us-ascii?Q?Fx++lPUxk18rojwGDtqFlrYkyCP0kDiFOwRPUrR+ySLeC4QfttHcDJVzonMs?=
 =?us-ascii?Q?aNkfsb+J39lBo2NME/0WK+G9/8nuqK4OyNu7CEJ7HjyJs44TLsuUVxJpWv+O?=
 =?us-ascii?Q?EQyL2J6X+IQ8c8oLhffJBo1gSlcC+OOeewLhgJ6xJSnWSKFG68nhm2nPOcmK?=
 =?us-ascii?Q?XnwwGBdYGAqXOP3Pb76A6QDyWwIebSos5X6NIWWPmAjY9TL7SZ8R8IyzRBhP?=
 =?us-ascii?Q?VzxqmaxCxZstSuucxVcat4/Ikt15kC+5rup51AcnbvZ4CiB8io6uPeHVGBxi?=
 =?us-ascii?Q?33FTG3SNNT5fKsz8I3p2p3OP+1ppVnKBAsiPkMzWOoNa+HFDrLErh0776OY8?=
 =?us-ascii?Q?vELQyXSEzdSEdzrWgXciiuXp9ZDsqXAZ55UBTLUtrHcBFYBqX/ZQhrcKaSKS?=
 =?us-ascii?Q?daJBg4QjcsVCPJA727YPmejC61fgFK+HTpc5PmkxVKFv1U3cp+stcYt0UzHx?=
 =?us-ascii?Q?qST4rUSX3sEs3xb9jzD0t2LJFOTSGlPwAMISYWI3+Tz06+3DoAfl3iyHo37z?=
 =?us-ascii?Q?34mj/Jb9Ht9MOMZv7c1NPLe0iY/iWIVjXyVFM+ruwwtAVFgfPrD2mef6lBML?=
 =?us-ascii?Q?AjZPChAsv5IitUmdd+cTp1fwTBnUQrnEO8swnR9AYDxAwUa8dWbCtSe8r22e?=
 =?us-ascii?Q?kNx5U7Dobc8WzyiSQS4rGOg7RgUiLlQwone4fZIpBz4P4VfB1bnT+aAyFBrT?=
 =?us-ascii?Q?tKXMPnRnw0A1y1hKWaTduxzWlP9K/Qv92Dg7SaBLIhLXyYCPF2hu3utIUm4r?=
 =?us-ascii?Q?udjKgICrndOXWwt9JofEsrhk7d85YVrb0wJJsh8DwYrSjcH0D9IZviqbE1uV?=
 =?us-ascii?Q?gwIg793F+ljek6u1vESDoCpPU+ZAdhs8AC+I4ZSG/mRhQEPDGhLOO2u3BE4V?=
 =?us-ascii?Q?SEyNY7hQNg9o11RPShOccil91+4YOE+ADOIUdG2aQBVSVPptUpcA9edZAg3M?=
 =?us-ascii?Q?4aIJQUpxyT2GZL0Wv93poXcwNCo8+hXuuc+U+dVzEURAYPrsSP2W7VT8V3pa?=
 =?us-ascii?Q?7jtBI5pufaA7cdtDKv8gNj3ln48p/iMnMTjSVMdVXmbjMVPlkoe9nJcSNCGP?=
 =?us-ascii?Q?1yHArJOvO3VFEZnRC3xFaNZdgGXjHdjBqZ+rw3GiSpNTnRgBRmc4U60s40Li?=
 =?us-ascii?Q?zQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1abdb9ab-69e7-49fc-6e0c-08da59126188
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 14:27:50.8991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DBGooG0gq5U623P0tHFbDBZH7YtrUvDhFxGdVNWIeA31OOn/xdAuC32PpRT1DVkEeu1TuE6YXxgfxqwVelgaQdmxpAGW2DKxDgSNM5N07Ow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4955
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Jonathan Cameron wrote:
> On Thu, 23 Jun 2022 19:45:14 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > The upcoming region provisioning implementation has a need to
> > dereference port->uport during the port unregister flow. Specifically,
> > endpoint decoders need to be able to lookup their corresponding memdev
> > via port->uport.
> > 
> > The existing ->dead flag was added for cases where the core was
> > committed to tearing down the port, but needed to drop locks before
> > calling device_unregister(). Reuse that flag to indicate to
> > delete_endpoint() that it has no "release action" work to do as
> > unregister_port() will handle it.
> > 
> > Fixes: 8dd2bc0f8e02 ("cxl/mem: Add the cxl_mem driver")
> 
> From the explanation I'm not seeing why this has a fixes tag?

True, that can be dropped as the crash scenario that found the need for
this was not relevant at that older baseline.
