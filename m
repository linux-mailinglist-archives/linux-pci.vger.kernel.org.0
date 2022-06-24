Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12FB558D4F
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 04:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiFXCpH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jun 2022 22:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiFXCpG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 22:45:06 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62417515A6;
        Thu, 23 Jun 2022 19:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656038705; x=1687574705;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Qa4099bpg3KbZYT9k4t+CMJpeboIp7dBq3gcbtbbIJE=;
  b=N+jfCQPWxjSAQuWrqej3eiB9Fy3T9psypgN1VcOJ4LHLV8fMVzlbhtr4
   l57O5qokoDg5p6nDeLF3Z2AcA/X5NvOIVRtgnx4r3FUZESGp1AewBX8UO
   9piv2hQDxAE6Mu4JgOjJAfnIafY/U4Oj6DcS6gOwn94H8wWuS5Iefvh8I
   0qlM2oJ8runw3jICMRHtBmyydhHiHjQlLE9/w4+684Vaz1dX74AAPYJIZ
   01tiQV1tJOgWUpVkL0p5nyC1Dl4l6pQoQRskbR3X/SjEDcHcZD6Q7lSWl
   AtwPcRRVMpfHvnQN0D06em6ZdAgFxepbOBwOFWUSUHhCSOiimxvUT6xk7
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="280948800"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="280948800"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 19:45:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="678351263"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Jun 2022 19:45:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 23 Jun 2022 19:45:04 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 23 Jun 2022 19:45:04 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 23 Jun 2022 19:45:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPnc9ouZxvAhTFLplGyiBzzcVeUhdTXY+MUBs00AnUAxw5vlg1mGy+KGd/2TO6XlxvcOCpC8gYIR0n5iJsaXYHpCDlS8EP2KuNm2GiHcmaTZUFLc6LnOYy0FPvI45Sq5HrGyANXwKSQ/8oZEPE7oNg7LR2yYe6HiLT6APl8Vho2bU1y2YcD/ogj0CRPHbDEqtrM18TJ84Gg0s+/oDZOFvuENREek33K2JV+/coRen+KJJaKlYBCM/RwISi2lj7I0UGNRDARPry1cRhu6JpvUjMQ+bG9hCidgOIR9EdbLi5aHLhmx1eq0dAKUBju8SpIWK0JvgYIn2VmpZ0i5TpNklQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/wiI3KNhbz4OIDC9ov32NfR0syX0GOPsn837DV5ZZs=;
 b=TAqqAMrJSF01Vh61vtRkI5q7BXbj4Q3jc5fCh1esEy4Ihp0iHRjhZk8cHmfZkL7DtyTLMUKlzEInDwfXd6vs4ELCdCTSwE4KodTxlblShMXGDsvjXbiUx584fxtVPqNKVqrDR1+D7+7A1s4yg7nAdBwtRBWf2OXnxFxUvhHhASku5nJZJgj5mdxa+cx/4lgo+cXWdwz+tEMEcODU7SAcsFTsfKIOWJ+3aPcwom0JLFXE7/ab6h+BEUInVd+OhWMHZ1qpr9FIwZcLzWM113tcTP6gHXaaNviFi6VlYmSjC49SuVgANnHx8Fg0BW2lgu9ZXdcYVXYxeUf4zvpwtpTcLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM5PR11MB1993.namprd11.prod.outlook.com
 (2603:10b6:3:12::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Fri, 24 Jun
 2022 02:45:02 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5353.022; Fri, 24 Jun 2022
 02:45:02 +0000
Date:   Thu, 23 Jun 2022 19:45:00 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <linux-cxl@vger.kernel.org>
CC:     Ira Weiny <ira.weiny@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Matthew Wilcox <willy@infradead.org>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>
Subject: [PATCH 00/46] CXL PMEM Region Provisioning
Message-ID: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: StGit/0.18-3-g996c
X-ClientProxiedBy: MWHPR22CA0047.namprd22.prod.outlook.com
 (2603:10b6:300:69::33) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95ddffdc-2f06-487c-e562-08da558b89ad
X-MS-TrafficTypeDiagnostic: DM5PR11MB1993:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o7D6JAY0PZT/bLcmymtl+kpzZy6wYgvwQ/9VVKLLxsaULKpBiQ6PE0SarH9VrMxKUDxzoI4HcM2gcjGsazLaGpbhqLm7mytZ0DKbGS1F/C6fV4yebKBQj0gMrbDFuJqpBKet+xcmJR8TE1T+SUhQpNklkEAxuUFvgQFr5Ojb3wwTCqgMtAdKj1dqTOuVEAxuh4fjcIbYVvcjocG2v6QzDleQ+Z5fqlisr/ZM5J58uqLAF7rDCFbGH2qxBrcgV/GJUFuhZr6bskKhm3ky64uiLIuXpFDgcTbrGS6DrWqyUtRWb74/o/eUM6gfvOBh7qNdGDvDFbDCi9aDG1bzoWKVCdW155RwpldUTwQT8kveTQ5xpjg9Q7rdNh5YWvonEdxzCGvfny9d3eEIy0fdXpIaM+Uw0BO1kD4X0HaD7osDms/OFnVEbQ61YbOm3e77RSaG8uUSk7FAVmwxhgE2OTTzD3pzUWfdgeX27wrxtVUtWGBNPFBQyF1sANQypLK8PKPx8gHqAkDkuBYOQflCiNI4MudEQnbIhGKn0KtfOkvzIvZPhLIADAS0/SZh/fc+BbTq/qnPMmDzvum1XOOWU8gS72r4jjKDsN4eR3XMJVQ21MASLfI3NEsvcHB3rIcq69PKrGAL7eWKEEIxNjwgxMNVhETzw4Jxxb3msG1rzyEQZEWaK7b8++FyuJToASW2rvS04x4THLnn2LwJmhOqVa7WKbWMFNL1IZeLv0HdbOdrg4Fo+Eg5BH/farOegC1MJlRw8eBPoBDewgHaEHwLBDtPgttnn8iLmcP2iq2RtzNgxJig8amRkeD03zx8ylY2QgnV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(376002)(396003)(346002)(136003)(39860400002)(6506007)(6486002)(2906002)(41300700001)(478600001)(66476007)(316002)(9686003)(4326008)(103116003)(8676002)(66556008)(966005)(86362001)(33716001)(54906003)(6916009)(66946007)(6512007)(26005)(83380400001)(38100700002)(8936002)(186003)(82960400001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BS2wTLzkOhz4BiqF0KTY5ufdSFV9I7p02bqMX/Iz+nFDbYORTvJXAFxflKdb?=
 =?us-ascii?Q?iW7+TgpC8+qN4NHlW1SdRzoN0jYLJiO/B60/dlyvlNOINusJPtWSjNx+cbxJ?=
 =?us-ascii?Q?Nr2oeh+7m7C2nUigVIeJnbV8lryEw2Pij9usmqkkdW7KAkinZk857SFgRWdU?=
 =?us-ascii?Q?mG5TUTAYW3/tHvxULjWpJIcA1cINmPmZq+MoT8yOP5QqzBkdptKQgkVxbRyt?=
 =?us-ascii?Q?UUx5NHd46dJdYqgt467ENkNoRoAtHlinjdK88lW/orgIZYf13qb+67C5pSEa?=
 =?us-ascii?Q?jp35nAS87e0l51AriHYjv7UPz7hNe0p+nCwgrbOYgiDv+PyR2h3Z+arCNtoK?=
 =?us-ascii?Q?zQV1Ad9M5AMJDoMQSsj57GjR+0hOaBmOOvmwLYGGSiRWVRN5YY0xxJkZhuv8?=
 =?us-ascii?Q?ArLSzRFD56Jy7ZBm3sSQ8lSlHz8o9+aCd1eJlJlI5Sh2ZsmxVhwPdgZ4uRQd?=
 =?us-ascii?Q?bMeboT0iTZhlR5onnnKMg5vRBuh90kQmgUigaKimbTuR3ZNjGNxpQm5n8DDW?=
 =?us-ascii?Q?PUcULPB3LrQRJM7QR9Yrpift/2GznW9ni/cnaxrvrFIFiSP2UE4tVeazFNWf?=
 =?us-ascii?Q?onbiZY1udFlrP4cwwQ2ZbtKrKLRoGdSImn1lPDAdwRnvS624/YCkYv7HM1A1?=
 =?us-ascii?Q?3zW8JsHoIAQve9tBCyO1gVpcNWfB0Tj4Nb5SPXzWKij5dHx0y3dEO9BRVkmO?=
 =?us-ascii?Q?Gpp6A1txOMAg5DYJtJS9SwDE1jGfCzCbdSSjYstD23uzgmvFLJbaLPN/ora+?=
 =?us-ascii?Q?t62j9RYPtwJlGXcR0q4oqswMKeoTTWm6IG8ZD59dpsnmbZ0k/HbtJXSaAei+?=
 =?us-ascii?Q?IdKWlEEpCpDjbLHECTmnNqqngW5RVb3LtijUhj+kiBrS+IIyAzUBuh/QdUuH?=
 =?us-ascii?Q?nbuNK2m8X0GebQz6Tc3Ku+edfycqA+WdoVCvcmdE66VRRUfUldjiWM6WNYfQ?=
 =?us-ascii?Q?GAPEDwPPK2rIdJf6mzmn+sFNsD8WN0xe6TPV0e9AaLzS1/rQPhyPU9fehBJf?=
 =?us-ascii?Q?1b5TIX/VsEQlt9aLFZ1mpUapdNW2jzLC1iZOqYAnxAxeIAs9szooXNl3xxxn?=
 =?us-ascii?Q?rO9tU5yBnxlXQgnVjHTsm/58O4ObGNeuCmr19DmMxzyXMGLKswex6FFJVeCj?=
 =?us-ascii?Q?tm4ZLMi3pidJbwUpXixWOKldOFIResWLvS+ClONus2Ixqd9Dlg7TzA/iHm4j?=
 =?us-ascii?Q?P6OlgVCq7aW+Pu9VWvsGgb72l4YUSeBCJO3Mlu/+14hNAXmjQxYnDqb/MUKl?=
 =?us-ascii?Q?U9lyWlTBEihDC8OkLaI/S0Lcmp7QT5DRCjAR0k4gmQtstT+ufQ5QAR9QxlyU?=
 =?us-ascii?Q?ox4NiUs4ERTeDjLtzBFizpYY5C2jfVZkr0OymJbVr2Eh0zfbW5XfLNMd/XlF?=
 =?us-ascii?Q?x1+GknWDnK/pbnmMLXF2scyt5Ueu4dT20t0gKFE5NT95FJcfzcCKNfIbb8+y?=
 =?us-ascii?Q?2Bxj98rxvGxjM7M/4QJkobv8Lna9c9InI+M3eakwwDX5/kETTNwT60Sr9QPn?=
 =?us-ascii?Q?WQuZvRhS5TjmfDvJ0h/QMut5+KHGYe9YRhwclpjJXWRy5wkPsKRXnUzXnjBf?=
 =?us-ascii?Q?tciFtQjcpTAMHdaoMp7CnldxkGpTLSsQIhO6d0WUclJwdW+2Jf5pNmtU9xeB?=
 =?us-ascii?Q?XA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ddffdc-2f06-487c-e562-08da558b89ad
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 02:45:02.6442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o3fExV52zOfk4/pyFdDbT6z2YsvFzYfNcpXRT30vPUOPLjZ+TTeJHLyhaEeWSKFA/50IjfDBLDOYO0lSgjtZw533iBgoDEpGZ3H7nYC9R2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1993
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tl;dr: 46 patches is way too many patches to review in one sitting. Jump
to the PATCH SUMMARY below to find a subset of interest to jump into.

The series is also posted on the 'preview' branch [1]. Note that branch
rebases, the tip of that branch at time of posting is:

7e5ad5cb1580 cxl/region: Introduce cxl_pmem_region objects

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=preview

---

Until the CXL 2.0 definition arrived there was little reason for OS
drivers to care about CXL memory expanders. Similar to DDR they just
implemented a physical address range that was described to the OS by
platform firmware (EFI Memory Map + ACPI SRAT/SLIT/HMAT etc). The CXL
2.0 definition adds support for PMEM, hotplug, switch topologies, and
device-interleaving which exceeds the limits of what can be reasonably
abstracted by EFI + ACPI mechanisms. As a result, Linux needs a native
capability to provision new CXL regions.

The term "region" is the same term that originated in the LIBNVDIMM
implementation to describe a host physical / system physical address
range. For PMEM a region is a persistent memory range that can be
further sub-divided into namespaces. For CXL there are three
classifications of regions:
- PMEM: set up by CXL native tooling and persisted in CXL region labels

- RAM: set up dynamically by CXL native tooling after hotplug events, or
  leftover capacity not mapped by platform firmware. Any persistent
  configuration would come from set up scripts / configuration files in
  usersapce.

- System RAM: set up by platform firmware and described by EFI + ACPI
  metadata, these regions are static.

For now, these patches implement just PMEM regions without region label
support. Note though that the infrastructure routines like
cxl_region_attach() and cxl_region_setup_targets() are building blocks
for region-label support, provisioning RAM regions, and enumerating
System RAM regions.

The general flow for provisioning a CXL region is to:
- Find a device or set of devices with available device-physical-address
  (DPA) capacity

- Find a platform CXL window that has free capacity to map a new region
  and that is able to target the devices in the previous step.

- Allocate DPA according to the CXL specification rules of sequential
  enabling of decoders by id and when a device hosts multiple decoders
  make sure that lower-id decoders map lower HPA and higher-id decoders
  map higher HPA.

- Assign endpoint decoders to a region and validate that the switching
  topology supports the requested configuration. Recall that
  interleaving is governed by modulo or xormap math that constrains which
  device can support which positions in a given region interleave.

- Program all the decoders an all endpoints and participating switches
  to bring the new address range online.

Once the range is online then existing drivers like LIBNVDIMM or
device-dax can manage the memory range as if the ACPI BIOS had conveyed
its parameters at boot.

This patch kit is the result of significant amounts of path finding work
[2] and long discussions with Ben. Thank you Ben for all that work!
Where the patches in this kit go in a different design direction than
the RFC, the authorship is changed and a Co-developed-by is added mainly
so I get blamed for the bad decisions and not Ben. The major updates
from that last posting are:

- all CXL resources are reflected in full in iomem_resource

- host-physical-address (HPA) range allocation moves to a
  devm_request_free_mem_region() derivative

- locking moves to two global rwsems, one for DPA / endpoint decoders
  and one for HPA / regions.

- the existing port scanning path is augmented to cache more topology
  information rather than recreate it at region creation time

[2]: https://lore.kernel.org/r/20220413183720.2444089-1-ben.widawsky@intel.com

PATCH SUMMARY

If you want to jump straight to the meat of the new infrastructure start
reading at patch 34.

- Patch 34 through 42 is the bulk of the new infrastructure that is
  needed to stand up a new region regardless of whether it is PMEM, or
  RAM.

- Patch 33 is a new core facility for allocating physical address space.
  It is a straightforward extension of devm_request_free_mem_region().

- Patch 9 uses insert_resource_expand_to_fit() to inform the new
  allocator mentioned above about which address ranges are busy / free.

- Patch 46 is the support that takes a CXL PMEM region and turns it into
  a LIBNVDIMM region. Patches 43-45 are just prep work for patch 46.

- Patch 16 - 20 is the infrastructure to mangage DPA capacity, including
  enumerating the DPA that platform firmware may have already allocated
  to a System RAM region. They also enable DPA allocations to be manipulated
  separate from the case when the decoder is assigned to a given region.
  This separation of allocation and region assignment is necessary for
  enumerating regions from region labels where labels within and across
  devices may disagree. Userspace in that situation may need to jump in
  and sort out the allocation conflicts.

- Patches 21 - 24 are updates to cxl_test to put this new implementation
  through its paces with a x8 device region creation test. Recall that
  cxl_test is a way to ship canned CXL configurations in the kernel
  alongside new CXL subsystem code to supplement testing that can be done
  with real devices or QEMU emulation. Note cxl_test just implements
  device topology and ABI, it does not test the PCI-related aspects of
  the implementation.

- Patches 25 - 29 are enhancements to the port enumeration code to cache
  and improve the lookup of topology metadata that is relevant for
  region provisioning.

- Patches 30 - 32 are some straightforward pre-work for exporting
  decoder settings via sysfs.

- Patch 1 - 8, 10 - 15 are some miscellaneous fixes and refactorings
  that should be straightforward to review.

[PATCH 01/46] tools/testing/cxl: Fix cxl_hdm_decode_init() calling convention
[PATCH 02/46] cxl/port: Keep port->uport valid for the entire life of a port
[PATCH 03/46] cxl/hdm: Use local hdm variable
[PATCH 04/46] cxl/core: Rename ->decoder_range ->hpa_range
[PATCH 05/46] cxl/core: Drop ->platform_res attribute for root decoders
[PATCH 06/46] cxl/core: Drop is_cxl_decoder()
[PATCH 07/46] cxl: Introduce cxl_to_{ways,granularity}
[PATCH 08/46] cxl/core: Define a 'struct cxl_switch_decoder'
[PATCH 09/46] cxl/acpi: Track CXL resources in iomem_resource
[PATCH 10/46] cxl/core: Define a 'struct cxl_root_decoder' for tracking CXL window resources
[PATCH 11/46] cxl/core: Define a 'struct cxl_endpoint_decoder' for tracking DPA resources
[PATCH 12/46] cxl/mem: Convert partition-info to resources
[PATCH 13/46] cxl/hdm: Require all decoders to be enumerated
[PATCH 14/46] cxl/hdm: Enumerate allocated DPA
[PATCH 15/46] cxl/Documentation: List attribute permissions
[PATCH 16/46] cxl/hdm: Add 'mode' attribute to decoder objects
[PATCH 17/46] cxl/hdm: Track next decoder to allocate
[PATCH 18/46] cxl/hdm: Add support for allocating DPA to an endpoint decoder
[PATCH 19/46] cxl/debug: Move debugfs init to cxl_core_init()
[PATCH 20/46] cxl/mem: Add a debugfs version of 'iomem' for DPA, 'dpamem'
[PATCH 21/46] tools/testing/cxl: Move cxl_test resources to the top of memory
[PATCH 22/46] tools/testing/cxl: Expand CFMWS windows
[PATCH 23/46] tools/testing/cxl: Add partition support
[PATCH 24/46] tools/testing/cxl: Fix decoder default state
[PATCH 25/46] cxl/port: Record dport in endpoint references
[PATCH 26/46] cxl/port: Record parent dport when adding ports
[PATCH 27/46] cxl/port: Move 'cxl_ep' references to an xarray per port
[PATCH 28/46] cxl/port: Move dport tracking to an xarray
[PATCH 29/46] cxl/port: Cache CXL host bridge data
[PATCH 30/46] cxl/hdm: Add sysfs attributes for interleave ways + granularity
[PATCH 31/46] cxl/hdm: Initialize decoder type for memory expander devices
[PATCH 32/46] cxl/mem: Enumerate port targets before adding endpoints
[PATCH 33/46] resource: Introduce alloc_free_mem_region()
[PATCH 34/46] cxl/region: Add region creation support
[PATCH 35/46] cxl/region: Add a 'uuid' attribute
[PATCH 36/46] cxl/region: Add interleave ways attribute
[PATCH 37/46] cxl/region: Allocate host physical address (HPA) capacity to new regions
[PATCH 38/46] cxl/region: Enable the assignment of endpoint decoders to regions
[PATCH 39/46] cxl/acpi: Add a host-bridge index lookup mechanism
[PATCH 40/46] cxl/region: Attach endpoint decoders
[PATCH 41/46] cxl/region: Program target lists
[PATCH 42/46] cxl/hdm: Commit decoder state to hardware
[PATCH 43/46] cxl/region: Add region driver boiler plate
[PATCH 44/46] cxl/pmem: Delete unused nvdimm attribute
[PATCH 45/46] cxl/pmem: Fix offline_nvdimm_bus() to offline by bridge
[PATCH 46/46] cxl/region: Introduce cxl_pmem_region objects

---

 Documentation/ABI/testing/sysfs-bus-cxl         |  271 +++
 Documentation/driver-api/cxl/memory-devices.rst |   11 
 drivers/cxl/Kconfig                             |    8 
 drivers/cxl/acpi.c                              |  198 ++-
 drivers/cxl/core/Makefile                       |    1 
 drivers/cxl/core/core.h                         |   52 +
 drivers/cxl/core/hdm.c                          |  663 ++++++++
 drivers/cxl/core/mbox.c                         |   95 +
 drivers/cxl/core/memdev.c                       |    4 
 drivers/cxl/core/pci.c                          |    8 
 drivers/cxl/core/pmem.c                         |    4 
 drivers/cxl/core/port.c                         |  678 ++++++---
 drivers/cxl/core/region.c                       | 1797 +++++++++++++++++++++++
 drivers/cxl/cxl.h                               |  294 +++-
 drivers/cxl/cxlmem.h                            |   39 
 drivers/cxl/mem.c                               |   49 -
 drivers/cxl/pci.c                               |    2 
 drivers/cxl/pmem.c                              |  256 +++
 drivers/nvdimm/region_devs.c                    |   28 
 include/linux/ioport.h                          |    2 
 include/linux/libnvdimm.h                       |    5 
 kernel/resource.c                               |  181 ++
 mm/Kconfig                                      |    5 
 tools/testing/cxl/Kbuild                        |    1 
 tools/testing/cxl/test/cxl.c                    |  123 +-
 tools/testing/cxl/test/mem.c                    |   53 -
 tools/testing/cxl/test/mock.c                   |    8 
 27 files changed, 4300 insertions(+), 536 deletions(-)
 create mode 100644 drivers/cxl/core/region.c

base-commit: f50974eee5c4a5de1e4f1a3d873099f170df25f8
