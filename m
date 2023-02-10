Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8BE692BAE
	for <lists+linux-pci@lfdr.de>; Sat, 11 Feb 2023 00:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjBJX5m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 18:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjBJX5l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 18:57:41 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE8670722;
        Fri, 10 Feb 2023 15:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676073461; x=1707609461;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0NyGPO4ZTqRNpcWDdUXcpb3C1cKJFpOLnTfmFHZokvI=;
  b=fPlJZUZK8ac/zJZ9Rgr01xNbjmJ6Vm+bbEIjIrjYOmss3YSASvsdDAek
   v3CiByw76gqSbxY0pQXGA3s/x6QFVFkwXV24NGVEGUr+1eBlOnUf3WmgF
   JQzUk72ZVDujMHyP2tKi8nQJtLhsDepQWkG6oH+LPHv17tLgOmjzUrUBB
   +aJbAFRkj18rawHnDEP/pQhI0FQ0RiYMzd38jXtur/FrvoEPFCittndEp
   r0I7Q9M5iNex6qQtPZklj9KxuNyxQqwU25H5qHCZ/ML6S/5wfqfjp1zdk
   oCeqNTn7f2rGv8I/TTKjn6sG60CYw09+3y9TlAflys+MjcZgmuDl3nzot
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="331862104"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="331862104"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 15:57:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="997111198"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="997111198"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 10 Feb 2023 15:57:40 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 15:57:39 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 10 Feb 2023 15:57:39 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 10 Feb 2023 15:57:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7jrslijAvvLcjV5CcQCZn48eGR8NHYCr+q7tIxUO+k6IiJ4OumudKgqof3IOGU6pfsNPciuAu0XvJyG5BbRXFL7bZTLDTjdKr+wayrFz28//2A3FnPC2U3O3mhTeY6K3gC//1c/Qh2WFYwGExWLX7/4mNJcUETaFDF+i1X+rYceTLOpCOqreksDjHTg6eDI8wFxQF2Tk8JWzSbFpJyonSCQSkE2DMa2Ey+l3mu6ijvk7afJAZj458V6qHTzY7wQQ1YFBD848ioQXGudzJp2A5K2Nw3shYWzArxi8p2tEUnJUfWUWCsem5gNvGeMnkhTPZMHbIxkjmSlUtd581XsVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DEfz6ge3f+WsLEfdx6C/pE3I+K4CuN4GcLk+bm2nZ3M=;
 b=kQFW6xx7E648o8FYnBdkMQXhu5Ux8LmitpRcCrEAg2T4LlMcprZUlhajRoIKfcb696ot7tlU+2UYy8oQgNzSehzcIQZFJHQO7RRTWrBE4ZkIQKpyWg+wVnFbaEqlLpLu7sUhNrD6XqKaA64qfcXXRo8yWvPbYo1mlYwOK+ELy3tKUsMm63Nsf6qajjwUnnFuNm3IycIYI6r3o4XAZQIuiFxqKmIrFo+kghd46pYKHRafuINalj6WRIAbA5hjghGuKgbGBLG2CByEOFPA9WSB8V7V62ChmfSwh3aEF/iQ6RYlZuterY0rfk2OuB/JpNUN9Rb4HSELxiUBF2GYWJi7jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN6PR11MB8194.namprd11.prod.outlook.com (2603:10b6:208:477::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.21; Fri, 10 Feb
 2023 23:57:37 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6086.020; Fri, 10 Feb 2023
 23:57:37 +0000
Date:   Fri, 10 Feb 2023 15:57:34 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>
CC:     Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <linuxarm@huawei.com>,
        <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH v2 03/10] PCI/DOE: Provide synchronous API and use it
 internally
Message-ID: <63e6d9ee1897d_1e494329471@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1674468099.git.lukas@wunner.de>
 <b589059ddc82039f00d695d75ac4017504df6bf6.1674468099.git.lukas@wunner.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b589059ddc82039f00d695d75ac4017504df6bf6.1674468099.git.lukas@wunner.de>
X-ClientProxiedBy: SJ0PR13CA0201.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN6PR11MB8194:EE_
X-MS-Office365-Filtering-Correlation-Id: 931a3b88-c3b2-4338-806b-08db0bc29613
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EYnWSwmHY233DrLWISfFH0J06TiISm3cxzOCgroSJC4mKbly7f73Oa1Pnur71jDJPXxx+diirRS9tyIrCPjGi+nR3iGbY0G2BBPPqVlKN+eGwPSQ+fk30CUESF6KOeIE3dU5QJQcfRiLAVRj5bH/WcxITW9p+c+88bxDpNrwgYilPs1kHoiA5n/ZBUFxBHwcBICI4BZjl7Z7cvUwZCGo6VTsCynRUSswLjX/zQhv6ICB5N60P7e/zsOV10umN+qgc1TeWNQP9mU2XJ1nzr3E8LNnNmQyQRMVxcHWnSbocVjmmEY4L/kve97N3+1QB/8JVTuyj3NYo17rmKMIOCGKaQi6ZQg+xwTUfLmKpQwR2/AlSeHhMvZanjf5flJOlCAjyDVZwiya+emWzdoUYbTp9+mMI5nmFVEFV46sI/D671HQxikwo0zZaZ7NZct6yOt724RsoADs8f0eFu83Yj54D6hBWmoi1GXcOLHXtTuxqfFsiz9Tfj+HtbgaO/g//ZyOIK+tAjO2e3Y/zZrXVUGcr3fy+eZwRWr9wdmglbOtLJyGUnM99IHJ5AXHCp3X/sY/pHyERfdZj5vAROpbJ/ZJcDvJMVXR5JoZ+6BMJ8gHz+Bzv86eZ/4+uvu4yMUyRNjE7nLqv692qDhZ6lBIs0oE8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(39850400004)(346002)(396003)(376002)(451199018)(83380400001)(66476007)(66556008)(66946007)(316002)(54906003)(110136005)(8676002)(6666004)(8936002)(5660300002)(41300700001)(4326008)(478600001)(6506007)(6512007)(186003)(9686003)(26005)(6486002)(86362001)(2906002)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1QgosJ/nU68ebl6zM7nnBdLdn3Oc3WCIWDMuhwVdQgwwhPd13ZaoMPsyXiAO?=
 =?us-ascii?Q?WH5xl43vHJZxEgX0A7KKw81Ob8lHcdasIeFQzN6vYMk6tdby4tFgeR9o7cvr?=
 =?us-ascii?Q?s+cERxWrqjXPX9A26oyFike0ZeIzRpVaSSUmI7skxVUQP8HXUdzMwAPJMm3Z?=
 =?us-ascii?Q?o5T+SNn2AlAGz22052gzsmokNcZxm7v04OxTqTUcxfQp+TiTg8/84jRRGUk0?=
 =?us-ascii?Q?IOViIrJpxNHO/3wPgxytdmEeU1LPthxMvJn5qNt+Mv2A7N05qYTT06dzv0y3?=
 =?us-ascii?Q?Maa2sU/NKmshFEOpzG7LLQg8z2cePoVYYN2tGODNL4fpHoLKDi7MIU+alwYb?=
 =?us-ascii?Q?1XVU9wpPTfNTNLX8wGZsQmY+2kcA/WKJPOq3L1p1U6ycwhfEVQFsNWYhW+zp?=
 =?us-ascii?Q?NxQOA9DTSKf3607EKMWN3txOLE9GPECBeHUsvDS61OHRDFcmQQ4N+Vm3xhnn?=
 =?us-ascii?Q?Q4v+C74NJss97wYehGerzhyVp9woQgREBghmyORpbAIZOFFTKFD3+LrEX0Ck?=
 =?us-ascii?Q?ifkMhoLrOcxf+PVV6zB0mGhowhQmukkq/MbMeXtGnHGV9XqmYLOQUI7a8iBh?=
 =?us-ascii?Q?AnPOcD8WR6nigpOM5JxmM5EDJ3AdmrHPbaOuZqWcdJxzeHXmr3w/EjZBxihL?=
 =?us-ascii?Q?3J/7TG2OO19chno2kKXlXefg5bro/nj+kQLCby+SuMMYEMuVC6gmNgqC+ZmA?=
 =?us-ascii?Q?RFUqSY4YWCY16Z2MbanrogTWa0alK8gxM5MI8NWFZ99DoaO+XZUinaGgZ1sK?=
 =?us-ascii?Q?WIpCejcmTalGzQkPhCoA5SN58O6Jebb8IAmLBe4zeqjtvjP6KBSNAffWVMeA?=
 =?us-ascii?Q?6LqMmA+79j+pkffXFsZAZ+q/EQ3YfSMseXnj9EThRyfrbk+YjLhclHZgydwg?=
 =?us-ascii?Q?dVz1yt1V1lC3giEtENdQY2dQO9YsyHGt5V1WNt3U6Opb6NXglBj/rn3qLCyD?=
 =?us-ascii?Q?i7LnaBivexgh5hXGI6YU1z4ekd/9mk7r1zhCFZQWmTCxeICuRWh43xVsgt8O?=
 =?us-ascii?Q?iXYkO5aZsZTDcVOYjYepPoog2u2rTe6l7GycZK6TPhNvEYRePkheQbfiHeNB?=
 =?us-ascii?Q?kmSDO7C75NZ7xrjHdevd2RNcXps+el5Fa8sufaJNTC0T0Abp7IJkqzIi+Tq1?=
 =?us-ascii?Q?Z3lLjKQCmGiSIzwQfl6X+1I/PiZZzOVY8h0fKmUVhw46jxFq9RFkFrx2befR?=
 =?us-ascii?Q?cxskf8z7pIBFyoMA8V2iEc7m/S8BPOKy2zABo0IwHHsdGLt/S/yPxweQ/b5i?=
 =?us-ascii?Q?afN8Osysjw4r4wIQcPxHhAgQKvGQW8tvhU1UfzRTecd1yF7cUVfLIyavVong?=
 =?us-ascii?Q?FmkYcK4mCuJzQxhfljakCjNAClxDXOnpeC7+bzyu4KHllzmsBufTzldBJ69I?=
 =?us-ascii?Q?PSjeQE/J0WPoBTC1nzhG+otbL932h6zQOPj3Pz+ADnlHBnY7sWlXwEM2zTD6?=
 =?us-ascii?Q?018rZ+f+WMZ0jNY6kZPLYYmqRgOasoteUsz9uN+s0QiTBvowgdgzmhFRNIfY?=
 =?us-ascii?Q?BdaoAhwSvgrgloipcitdYKCJk61Guon6BNvR7z3EyPIZEP85+17JefxlDLYN?=
 =?us-ascii?Q?96nm4wDtoUj6fBa2ncXaEA7gxB5RR2E1AnwqWzULjVpHu3nwoVNKzaf7YezD?=
 =?us-ascii?Q?vA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 931a3b88-c3b2-4338-806b-08db0bc29613
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 23:57:37.4353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +v0IJjZpx7BYjOB8snV1+cZF+YgSj0iSNOSB7GUc3AN1KBsvf5eXERmHVw0Ouy7emoZr+umIh52xxt9FGqKIlm4u7END9R0/uNV/uDKXgd8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8194
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Lukas Wunner wrote:
> The DOE API only allows asynchronous exchanges and forces callers to
> provide a completion callback.  Yet all existing callers only perform
> synchronous exchanges.  Upcoming commits for CMA (Component Measurement
> and Authentication, PCIe r6.0 sec 6.31) likewise require only
> synchronous DOE exchanges.
> 
> Provide a synchronous pci_doe() API call which builds on the internal
> asynchronous machinery.
> 
> Convert the internal pci_doe_discovery() to the new call.
> 
> The new API allows submission of const-declared requests, necessitating
> the addition of a const qualifier in struct pci_doe_task.
> 
> Tested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>

While I do wish there was a way to avoid a 7-argument function I can't
think of a better way to do this that does not run afoul of the previous
problems with this interface.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
