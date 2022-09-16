Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F845BB4BF
	for <lists+linux-pci@lfdr.de>; Sat, 17 Sep 2022 01:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiIPXQm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Sep 2022 19:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiIPXQl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Sep 2022 19:16:41 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E5FBC81E;
        Fri, 16 Sep 2022 16:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663370199; x=1694906199;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=eXKCNautQE7y3TkNYnlj/SCX2rCZpAS4S55QbICeuzU=;
  b=KcIYcUFLRcR+sAUh/xDNXyjQlcHT5dZ/X5/V+uy0nyZnLV9RUYBLc5bA
   El4n3g0FGV9m24JLgK4ZxU4dlLE5LyW8sxJE8HNy6wroBya3LhJApKPde
   qxdO/acNP4wfRHTyUKKXLBPyxBbrKyKBpLqA44pQUcIoiV80Nxdl0X46Z
   puxPdSgRyAxDcZ0Xj8VMIppPuHst6HCowlVB1+GgR3Ut7Mu450V1b8Ake
   Zb/DrSsJPSGRiwESN1FCyvXkH704wonisvsj9a6CkIR4XtSgUqNgojnJh
   5PMhQPJ4GOTfadK6IWD5OG4JOjr3E9j9BFhOWHCdfnPocBJ/X7jFlgdMD
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="286139504"
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="286139504"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 16:16:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="743498641"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 16 Sep 2022 16:16:39 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 16 Sep 2022 16:16:39 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 16 Sep 2022 16:16:38 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 16 Sep 2022 16:16:38 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 16 Sep 2022 16:16:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mtD5HTBVoe3u5wHlXknPwJh2Fc/TRsggkrKo566D5oOZrrQGZMr0x1xhDr7InkDhCKap3fmKjPB/2fq6AO+Q8huJvE1PyrMFcGFl6mLim2EB6q4thhfcw4MGLRbkj5rp8KwGJcJooUejTNhQDHU9sjhzKywUzBJnZeYNceHTIZ2HROvGmYdY4MZv28bHxaRlidq/dV7I9UFx8zmhdtNG/lUHx1OjMj7FjQDhDDrzurru7UFPCEnXqm9uBUlNBQy01wwGRnQw+P6C1zOR7QEF7toY//8NSkjTaJehjRW1o24mkHpL4hWwzLhmWGwrPkjgTVnH/0D1fJUdUCihI9Ydhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6DC5vBqiZgJ1LdzkKghf/i+Q3q+Woym5eMYbbH2JhI=;
 b=SGfFgwLMc6XvrhRB10M7M8bb1sw3GBQWCmgZ8T3jAJci03Agie1NwH3D5v4Zm8EQu5hqw4o4eDh+Z85ZLXyz2q0zLIPHekaVE3p5DT1Bk0725+dmAuGNWckGvTBIS9G9wMM1qFCh+xtMDiG9TeUgNE9Ihjc96yBu6UA0QSZGQxjrVjP2fy0wClU9sDKnHvtQ2C5ZLP0D48HJk6AdtOfNsoE/yyfjkGHnJX3vnLJODJ0JXP3hrCWPRgTrI93eurtxgjnWwuU+Suu5RruaVJ996BxpCG8xfOrmW/Jcnd1CS43Jfd7opq2WaQ7+z94/2qx+77/RhdnIGXebSPCLfqctlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SA1PR11MB6568.namprd11.prod.outlook.com
 (2603:10b6:806:253::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Fri, 16 Sep
 2022 23:16:36 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5632.016; Fri, 16 Sep 2022
 23:16:36 +0000
Date:   Fri, 16 Sep 2022 16:16:33 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Robert Richter <rrichter@amd.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-cxl@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 06/15] PCI/ACPI: Link host bridge to its ACPI fw node
Message-ID: <632503d165627_2a6ded294c6@dwillia2-xfh.jf.intel.com.notmuch>
References: <YxsTfVdOgc9sOOVm@rric.localdomain>
 <20220914221154.GA710889@bhelgaas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220914221154.GA710889@bhelgaas>
X-ClientProxiedBy: BY5PR16CA0020.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::33) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SA1PR11MB6568:EE_
X-MS-Office365-Filtering-Correlation-Id: 871d2cd3-91ff-4915-773c-08da9839808e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /eYoT706h7Z/2jnrWj/WVHXErcWSDzjnFCrI4M05hHY8zyVaeyZxeJgaAoSMlkx9giCOPlTl79GKovAxk7ajY/KnIePJv7k1990yJdbLov5U6KZCenV5xa0Q7iAK3dI1yVQ+egHKJW5WfSNbrAaN00yry187k/ROVjKpSmkGW7UDA1Ss/WiqHFHXhcxho8iqZ35vwep/uQsvtzmeNk9rPPlQ5erp9QgR0xrOM/Ivq6IQf7z5XhlbwBRuPoqWoiMOf6rNQo505XmqyRJlI1Ueo+S1KT2n7fNzjvlFIiAbrbYs/maGHCzBXl/g4FFO/zNuUEH3msVb3SZ3XYFRhBdt4YFYXH8EoXxBwIQkdUqnohkEL/nLFJkzxOkaxATVfrfnh+5fzz3JG33Az0e53dihlxWpZKXwtFkSHDpVsv4FAN/h+/hEwyLQdDBZ9PEMW2WoAbWvyI9Vg2LxJzdX+jf+JCvfZqh8S19Q/buKQhGyBc0ZvJyy1ILA4cuSAhyCYtOuw0zUqyY4l3W50d3+h1DIWSrCSKMKlJPsfbPOQo0WHzdMti+pyDjzmDQh3n71j6GU1OYxl5kzzFwmr7SF0CsQxFc7h2GVIULb8LC0XBtnkTLNCNy1bFQATwDJDBHWO8Y/AxqlC5OPHeC5uVUsK16cefDNSG9G6mpuDRpbePDUH1ubhsDUiUxM3ImFtwZlNh3mNR8LT5NMqRcf0fZHDk7Cvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(136003)(376002)(366004)(396003)(451199015)(6506007)(110136005)(7416002)(66556008)(38100700002)(2906002)(41300700001)(5660300002)(9686003)(316002)(6512007)(6666004)(186003)(6486002)(8936002)(8676002)(82960400001)(478600001)(54906003)(86362001)(66946007)(4326008)(53546011)(26005)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KbNZPLCxOFf3FXdSj44My/9lvXWtBdBIEJnEtPdI+odT2zbM3gWo1NAiDEkD?=
 =?us-ascii?Q?+xq/L/tbl23cz6OS2/zRoQHfr7caESXtdxdoij+K2OnNgcA22J9WlYUS3VRV?=
 =?us-ascii?Q?2WGDd/oX7liQmwF9GVViedoEjB6k7svWsB38EKgPH53wvrH6h5M1KycUzNEW?=
 =?us-ascii?Q?CzR7QWt72IoD6WZMowZQbJdb4DytzpN50w4sQPM7pTyu/MXBuKDuEaIfQV8B?=
 =?us-ascii?Q?in0r/FZKLOEWcDb0hjofyrAJHhC7AaBRb2Qdw99ctAiwGqVmrwOshvH1vXR9?=
 =?us-ascii?Q?3T8FHdr1IO/878iA+2Fs7jelEt80ucER5/nV1dbh9djgr0LhA3NwDLhXATQD?=
 =?us-ascii?Q?SyeFtD4EdxnSq8PPzGWwTl6WlzVIhowt0lhT2STalGkYZuG0MWWTd0h9xnGX?=
 =?us-ascii?Q?FYvSg+4wAXXo0PWef8V92QoQC64DyVGhrA3MiWfI2nTDMsi7r7Lk16LcuWL4?=
 =?us-ascii?Q?Km9GbZkATvyKgTi3GdahzYjWFwW7WgfNYKRlrh3QltTx5ozIHsMTpwIYQTtq?=
 =?us-ascii?Q?1gmKlzEG3GE5+4VgWmRVl2e3tO0ZcP0X28BwEifURTfPmrZu7idUm7KsiUXu?=
 =?us-ascii?Q?OGoUOSIyh3rWnVnVGjXn+uz5wMtSvWVGBq11N55f0RiVjwUHwwMFh3YipIyV?=
 =?us-ascii?Q?jQ6v+NxP28pYl91i+9q/wh4OgVls623bS0uY0ar+GnNRKSlu9fJs8Jgj+OxR?=
 =?us-ascii?Q?E/La4JJKqPCmwzLxjo+6MKnCjqzYmUPC+3gYHpN0tOINBglhvz4zoY4KnvSm?=
 =?us-ascii?Q?ndK5R7GxNNI+Uj9V4l+frcu0Trlyavu53UQ41r2Y2kbgjN0KYOyviaud9HGt?=
 =?us-ascii?Q?oLm5c8/YU7eACkswVUUudkAMPyD7L1L+Q75AA35buy3F3OlU0HNDVV4DG7Eq?=
 =?us-ascii?Q?KJT3iBTjEQl4THuSkA4Go3qOdJhL7G4Ioawa9AcGzlHOqVusTjvTEMWgfA81?=
 =?us-ascii?Q?BYnwLv6uufcJelqwN9KkprzbyNJ0Th4794TdZ51ktWEmYcqvMKcE2KhI7CeP?=
 =?us-ascii?Q?DZVMKd6o39R3eBa6blyFRqIy1/1oNyz0E0QOgVU+qaHQ8rUSZven2y856Dgt?=
 =?us-ascii?Q?y/aJKxayZVw6bC6T2xgm1TrE7giaFfJNCw77WUqtQwDcszxe27QZtNeSfdp8?=
 =?us-ascii?Q?Yd4milLv/m3LHQnwxAgsVrxDCq2b6ZS9HR6fTjOFsRB7/eXKMRPzcGSPK+QG?=
 =?us-ascii?Q?nGuS3ON9lms8aU9nHM0Gd+wG4RJ9YE8v3lGr2MHXUNLcPrCD0LyftNSG8uLJ?=
 =?us-ascii?Q?IBT+81knKn9kA6qEqT9rmBVQhjYE0bMrlywPyyRkArpTEBMWUnsRXltaRWVP?=
 =?us-ascii?Q?lNW7DEp6qAwZ5SM8F4LyP+XjAm7e4Gth5lWQPtZJIsS5tR8KTgrQjRkZ9Jpf?=
 =?us-ascii?Q?uFaNNgV9ns3+zj6eqnSjVilPD1iwWzHMMFbKR8Zw6ZUecgBKPob9VOEJcZ8w?=
 =?us-ascii?Q?4QJ5iSgZ5+Z9S3bB/6s9UDxwghOWcNU00I0Zr46EVKvXJW4Xt47bYoPOye6b?=
 =?us-ascii?Q?CBW0aFpMWM7JmHVguT5C+20SApZz42vXT0ipogVSbLMONNvEX2LGOuR7qOoj?=
 =?us-ascii?Q?1MwBtUF8OGbTspasj0w/pY2wdXqLnDmMSYfGVI1jTKUKg1Eg24WrLodszSf5?=
 =?us-ascii?Q?2A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 871d2cd3-91ff-4915-773c-08da9839808e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 23:16:36.6068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fJrXxZ7T+rO33LmpfC4dlfPUogXM5yGbcUztdWxIe2ziTclmUKFql9AAvd9diYYOkvZ+iudqAz5BgqKoBhtEk1AXN0uBuOQyJrZvIaS7FBM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6568
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

Bjorn Helgaas wrote:
> On Fri, Sep 09, 2022 at 12:20:45PM +0200, Robert Richter wrote:
> > On 08.09.22 12:45:16, Dan Williams wrote:
> > > Rafael J. Wysocki wrote:
> > > > On Thu, Sep 8, 2022 at 8:05 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > > > >
> > > > > Robert Richter wrote:
> > > > > > A lookup of a host bridge's corresponding acpi device (struct
> > > > > > acpi_device) is not possible, for example:
> > > > > >
> > > > > >       adev = ACPI_COMPANION(&host_bridge->dev);
> > > > > >
> > > > > > This could be useful to find a host bridge's fwnode handle and to
> > > > > > determine and call additional host bridge ACPI parameters and methods
> > > > > > such as HID/CID or _UID.
> 
> > ...
> > No, it is x86. And true, it is set. So this series is actually working
> > without this patch. It can be dropped.
> > 
> > Now, I just checked my logs. The reason I was adding this is that
> > during code development I modified the code to have bridge->dev.parent
> > set. Then, the fwnode is not linked. I later dropped that change but
> > kept this patch.
> 
> If this patch does the same thing as the ACPI_COMPANION_SET() in
> several pcibios_root_bridge_prepare() implementations, I would love to
> keep this patch, which does it in a generic place, and drop the
> corresponding code from those arch-specific functions.
> 
> But I don't understand the fwnode stuff well enough to know if this is
> feasible.

I took a brief look, but I could not convince myself that these lookups:

arch/ia64/pci/pci.c ((struct pci_controller *) bridge->bus->sysdata)->companion
arch/loongarch/pci/acpi.c to_acpi_device(((struct pci_config_window *) bridge->bus->sysdata)->parent)
arch/arm64/kernel/pci.c to_acpi_device(((struct pci_config_window *) bridge->bus->sysdata)->parent)
arch/x86/pci/acpi.c ((struct pci_sysdata *) bridge->bus->sysdata)->companion

...are identical to what acpi_pci_root_add() used to create the
acpi_pci_root.
