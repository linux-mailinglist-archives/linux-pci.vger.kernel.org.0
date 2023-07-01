Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F66F744572
	for <lists+linux-pci@lfdr.de>; Sat,  1 Jul 2023 02:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjGAAH2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jun 2023 20:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjGAAH0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Jun 2023 20:07:26 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609361BC6;
        Fri, 30 Jun 2023 17:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688170045; x=1719706045;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mGBVmFPB3lUEzwDzAvQ0nEDvVlgmPf57YZH/VgcndDc=;
  b=PZ/NzeAHbR5W4dh9Q/kAu2Kvzoqu7gRyXL2rdtdobAZepPvrv47ekL4T
   LKQ7BOJLhOjjyETrhlhxT8qBoxZSBms7LaJ9PTHQ3v3EnFaPPA55Q3Rwb
   27kbuTIoWG8GxAmaNG3b2jkuALBbrxHwIvtIYmkDG48OlAacZzCEFOJNo
   Wf2mTr8VO3vlNGWYodTvzE2RQcXYkhpft+s7AlF9579Yu3OeqTzXamvOQ
   9cBFFiZwZuZbH5zRLOYmDsNhtemWUoLhRYgI3H0vfO/sIu8PyuwDn0QRU
   gPSpjG3x1/O4gV7/1iaM76rhDZjEELXb7jGWXRpDjcJiUrM7sbQ2/1uG5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="362564223"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="362564223"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 17:07:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="964568675"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="964568675"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 30 Jun 2023 17:07:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 30 Jun 2023 17:07:24 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 30 Jun 2023 17:07:24 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 30 Jun 2023 17:07:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tc8xexAdYcCrST87BhOU8JqJv0MZvq+n7+DsSFBtGzShSNmtBWyvpqs470uF/6DHdDXUMmhcf5vFkSNOco4JW0gxV5n/UB/0ZNQL8bvfqEIMGbBMw7iN4sZJFfxd+JJQ+ElJsS6wip9cScs5ux05yk3ln2IMKN/hiIukmbwdECLtcKF/Zf6chTacEQMPi+osrfmctLLwg0Hh1bhp7PQUVKmz699/l3GcGqOYXSiukD7YWpR55Vof4T3KdIIRBOZrApVixw6MeROZnednzRmssauXuF8foKDdPBonzteKbZ8JnvRM6IO98Yqh0zOGe/fCKVLtQUCs96LVSAALycHrWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0OM5o/WwASXs6KwT24YsfgDWMPKuNzxvNOL7d3s198=;
 b=XDLiFPmKFe1garAFaK2m7fXLE09ecg9E/dN2F7WgGaXPthHkw2dOSUySZdgHY7Uy+D5NTbW3xKnEfcOMZoGcYe5GGXPv7IWe+QTbuXH3CCwIjI7eDr8a4M85/BGEP5aqIZ0fnNHdFFAKqkj9IbrBco++B2MzLtl/xdH6FppQHMTqvME2u5+Sy4+svWMP1u7p0gClNW8z8w9yhxWpjCN4lRYmVkOk1Gl2BCC5xZ0kUsRTBNYqBKL2JuMhEFQMPf1F80Gx5YNusUj+Q/NhDxVJvr/LvXMrde73+cFJXjB22I3bBxCkbCeWB9d4TrM1scuPBd2RCI0isPNYs7lOhwjjsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5578.namprd11.prod.outlook.com (2603:10b6:510:e7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Sat, 1 Jul
 2023 00:07:21 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0%7]) with mapi id 15.20.6500.029; Sat, 1 Jul 2023
 00:07:20 +0000
Date:   Fri, 30 Jun 2023 17:07:16 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <torvalds@linux-foundation.org>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Compute Express Link (CXL) for 6.5
Message-ID: <649f6e34d4386_14494294e2@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: MW4PR03CA0092.namprd03.prod.outlook.com
 (2603:10b6:303:b7::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5578:EE_
X-MS-Office365-Filtering-Correlation-Id: 06ff03ff-aa3b-4354-e421-08db79c72343
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PAJZyvkHc6aLIAvRYOz18F3GJ8Vm+E1V3OVLIN7ztTpgL+lbH7tmwP+xOF/1h1i3BPjlINYalT/dQb5/75b+gO1RHmfQQ7VRESeHQxCieA3TmV7DiaPE0VJQCsxp7KtgcFB0dGNJ4ApBdd8S2EdfIWKe9DwDpQktVFm8mJm44uJQiTJua3cV42KwjMOCwDRY3Wgc9AxX3/oILQT3L7oK0ul7fL6K0ul413iMXegnhl2QnFoZbJcqxNm/f7+PfudhCbvCzOWwKMjtMmpHwiDcy6/Ktb+u5jLgYfpmNgrjOZ2CZqpJTkkw6aUE2PUI9Dtbqlhs3b1e2JR3gFb8JXuUuXz2hXeNDKvB6ORaJxn5aCRD2wAMpooYiMjK7udQoQCkceHOm4RQEpfvd0R76szMtbNLA1qfcRL17G7/BEei8ycNi9fWoeiP+qyLcqfw9/NU2h30L7Q1rGHZ8fWMQ/2IMNcdCv0VIl0wmBoim5pNpduwSIZsvV+b2ipxspMOx5tDPu5j/EbfnvhynoiGhgxf4ChYy9oBC+mpvJvt3zm27PUabNHEjIvdwvP6BBvDMSC/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(136003)(376002)(396003)(39860400002)(451199021)(6916009)(66556008)(66476007)(8676002)(41300700001)(82960400001)(4326008)(8936002)(66946007)(316002)(38100700002)(6506007)(478600001)(5660300002)(9686003)(26005)(6512007)(186003)(6486002)(6666004)(86362001)(83380400001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kA2lKhI0v3zFh66JNZ0+izvb/E/E5ena1hUrJfz1ro9is3gzpVVSNMsEhJ2h?=
 =?us-ascii?Q?urvgjlStY5A7XiDA60TbzC+DVl87ykxjWkNS5+2CWggQOHQavmJJdiuRF1rC?=
 =?us-ascii?Q?eQLbuXafyJ36WT/MnH+c7Ld5EqvPvTtDKb1+JwCe11bDDa/sntWHCljbNTkF?=
 =?us-ascii?Q?q6LM91KQRCgXhEKQtysGnz80bcoMsndWET4ZMPR38ZqP24u2nMzJnF08LsYj?=
 =?us-ascii?Q?O6F+2aDxG1xBnjn8E1cqudSAV053sb0KLwTc+yagQg3bxQ+LZ2/Z/EGuuQxG?=
 =?us-ascii?Q?a9VaIEfQG8VFbtUrvwk6J/5OqzapbFz1ofrd24t4dTv4WVpqMX+gAg+vRdGE?=
 =?us-ascii?Q?rXK0R4m7KnmpPHXO0D1doyOjgy+AtixpeQpam+hl55MU2s+inKUX9BCE81GS?=
 =?us-ascii?Q?L/di0SVb95CsFx8qy5Npj3WzBtjp0bPXyOFQRkWjr0hXdpW61KSKIQ1iRNjO?=
 =?us-ascii?Q?q9snOuaMjlcBJPIKYsuH/8GdeE/g1qJMLm6wuuWRFs5TF5Bb0US4I+mSFs/M?=
 =?us-ascii?Q?Ny6GXtFLBLg4+IlUQYEfhhrTm/X105n3GJm9L12FvIr4+05BAH4Q1MnLDCEC?=
 =?us-ascii?Q?pUBRFxeTn0/tBfYJFXiNXpBf1TnPZdG7l2sGlmZ2vv1/OukajlepUm2qAhSe?=
 =?us-ascii?Q?eiXxcLkOJxgzUjr8fbEE1PMTVV/i0biMRFxwAtZjQIVP82e6qyUlayHTO97Q?=
 =?us-ascii?Q?Zq23eGFUT5ZxPG853sgFvuLmdFSbApy+mzsDI+aDvXJK6GFBc+epxGXyVHbu?=
 =?us-ascii?Q?cVL44vmFmHJBYAN9RXS0e9UC34OTBkMTsNh7u7689W2Aw+6e+cVVUc1Kzk5v?=
 =?us-ascii?Q?6xfZWjktYsBay6jgjGt2aaz8vpMOgpko+CbjgEwHVobxXv9alIVvGkPZxUJw?=
 =?us-ascii?Q?50Ofnu7m9rVgsPb7cPK8s2EHi7mModkG9fbeMD2D2kG9TqRfFlniBX/BXV6Z?=
 =?us-ascii?Q?10iwt0QyFy26syplGinxoRLNw22fE+KwuXsHLu/p/KMKs435P1FOJMWQj5I8?=
 =?us-ascii?Q?4vVnKFKASjb3/M5sGG7E56a/PGVI+2CwTA4k/rj1iCVNMPVDCMfZ9tXHVNQr?=
 =?us-ascii?Q?10Ut4BFIN7tDd6iSVywp9Ezt0PEl2Tdh1M3BzjOVK6Q5UiqHnH6qr5OIn7ik?=
 =?us-ascii?Q?yKO5iGXmr0nxAVE5ZlXzln68Jl5Z4396KErYey3sfScCcWao/LxAEaENVnuu?=
 =?us-ascii?Q?ut03VF5ntVpRcj3vbEgKQsCNDCKE8u7AfxLBnsviJ0KAfYNFs7bvsDFhNM7R?=
 =?us-ascii?Q?VhcTtHWp0dDx5hKznfRqebK+C2AEOOqpBVfInoDLvYa9BmeXd1pu/FeUNypq?=
 =?us-ascii?Q?GABv2R0b+IaA7/8kXfLLpiguekRjt5LxKEoV2FeGAyTLMGJSWE8C4MYRdf43?=
 =?us-ascii?Q?ga44AweBEXTtmyn80k1y2RKYNovFo2UPlEctdO4bBDf3z8APhVJPMY+i4IAf?=
 =?us-ascii?Q?u/A/d3NcotL8xrm3SL9d5AD7Dzl03fDq8OSPADobznNYxPgwQK7oNix4tOjC?=
 =?us-ascii?Q?rPeLm4/nIMXsfjnc7VdBnG/c6tWa6VHqFhXBiEO5TMCJloxi4v/c3aNEudL5?=
 =?us-ascii?Q?0+Nf26jKRD4KUdN/chftrVy+Aws78eH7CfFHsL5us8QE+jiLwS90/+3HjL92?=
 =?us-ascii?Q?5g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 06ff03ff-aa3b-4354-e421-08db79c72343
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2023 00:07:20.2860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VVcCyWofl65p5SaljOOAPBlnZcEOCZxdL26wlVqlkcN4TyujhqTcGwGFpoWZ6ZUj94pQ+gZn4qhTxZSaxsUF/hjPYWTcJTEhpYLhXxH6cvE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5578
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-for-6.5

...to receive the CXL update for this cycle. The highlights in terms of
new functionality are support for the standard CXL Performance Monitor
definition that appeared in CXL 3.0, support for device sanitization
(wiping all data from a device), secure-erase (re-keying encryption of
user data), and support for firmware update. The firmware update support
is notable as it reuses the simple sysfs_upload interface to just cat(1)
a blob to a sysfs file and pipe that to the device.

Additionally there are a substantial number of cleanups and
reorganizations to get ready for RCH error handling (RCH == Restricted
CXL Host == current shipping hardware generation / pre CXL-2.0
topologies) and type-2 (accelerator / vendor specific) devices.

For vendor specific devices they implement a subset of what the generic
type-3 (generic memory expander) driver expects. As a result the rework
decouples optional infrastructure from the core driver context.

For RCH topologies, where the specification working group did not want
to confuse pre-CXL-aware operating systems, many of the standard
registers are hidden which makes support standard bus features like AER
(PCIe Advanced Error Reporting) difficult. The rework arranges for the
driver to help the PCI-AER core. Bjorn is on board with this direction
but a late regression disocvery means the completion of this
functionality needs to cook a bit longer, so it is code reorganizations
only for now.

It has all appeared in linux-next. Stephen did report that one of the
Fixes: tags has an 11-character rather than 12-character abbreviated
commit id. That submitter has updated their gitconfig going forward.
There is also one late kernel-doc fixup that I missed when merging the
driver-context decoupling with the new background command facilities.

---

The following changes since commit 858fd168a95c5b9669aac8db6c14a9aeab446375:

  Linux 6.4-rc6 (2023-06-11 14:35:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-for-6.5

for you to fetch changes up to fe77cc2e5a6a7c85f5c6ef8a39d7694ffc7f41c9:

  cxl: Fix one kernel-doc comment (2023-06-29 16:03:58 -0700)

----------------------------------------------------------------
cxl for v6.5

- Add infrastructure for supporting background commands along with
  support for device sanitization and firmware update

- Introduce a CXL performance monitoring unit driver based on the common
  definition in the specification.

- Land some preparatory cleanup and refactoring for the anticipated
  arrival of CXL type-2 (accelerator devices) and CXL RCH (CXL-v1.1
  topology) error handling.

- Rework CPU cache management with respect to region configuration
  (device hotplug or other dynamic changes to memory interleaving)

- Fix region reconfiguration vs CXL decoder ordering rules.

----------------------------------------------------------------
Dan Williams (23):
      cxl/rch: Prepare for caching the MMIO mapped PCIe AER capability
      cxl: Rename 'uport' to 'uport_dev'
      cxl/region: Move cache invalidation before region teardown, and before setup
      cxl/region: Flag partially torn down regions as unusable
      cxl/region: Fix state transitions after reset failure
      cxl/regs: Clarify when a 'struct cxl_register_map' is input vs output
      tools/testing/cxl: Remove unused @cxlds argument
      cxl: Fix kernel-doc warnings
      cxl: Remove leftover attribute documentation in 'struct cxl_dev_state'
      cxl/mbox: Move mailbox related driver state to its own data structure
      cxl/memdev: Make mailbox functionality optional
      cxl/port: Rename CXL_DECODER_{EXPANDER, ACCELERATOR} => {HOSTONLYMEM, DEVMEM}
      cxl/hdm: Default CXL_DEVTYPE_DEVMEM decoders to CXL_DECODER_DEVMEM
      cxl/region: Manage decoder target_type at decoder-attach time
      cxl/pci: Unconditionally unmask 256B Flit errors
      cxl/memdev: Formalize endpoint port linkage
      Revert "cxl/port: Enable the HDM decoder capability for switch ports"
      Merge branch 'for-6.5/cxl-background' into for-6.5/cxl
      Merge branch 'for-6.5/cxl-fwupd' into for-6.5/cxl
      Merge branch 'for-6.5/cxl-type-2' into for-6.5/cxl
      Merge branch 'for-6.5/cxl-region-fixes' into for-6.5/cxl
      Merge branch 'for-6.5/cxl-perf' into for-6.5/cxl
      Merge branch 'for-6.5/cxl-rch-eh' into for-6.5/cxl

Davidlohr Bueso (12):
      rcuwait: Support timeouts
      cxl/pci: Allocate irq vectors earlier during probe
      cxl/pci: Introduce cxl_request_irq()
      cxl/mbox: Add background cmd handling machinery
      cxl/mbox: Allow for IRQ_NONE case in the isr
      cxl/mem: Introduce security state sysfs file
      cxl/mbox: Add sanitization handling machinery
      cxl/mem: Wire up Sanitization support
      cxl/test: Add Sanitize opcode support
      cxl/mem: Support Secure Erase
      cxl/test: Add Secure Erase opcode support
      cxl/pci: Use correct flag for sanitize polling

Jonathan Cameron (5):
      perf: Allow a PMU to have a parent
      cxl: Add functions to get an instance of / count regblocks of a given type
      cxl/pci: Find and register CXL PMU devices
      perf: CXL Performance Monitoring Unit driver
      docs: perf: Minimal introduction the the CXL PMU device and driver

Robert Richter (11):
      cxl/acpi: Probe RCRB later during RCH downstream port creation
      cxl: Rename member @dport of struct cxl_dport to @dport_dev
      cxl/core/regs: Add @dev to cxl_register_map
      cxl/acpi: Move add_host_bridge_uport() after cxl_get_chbs()
      cxl/acpi: Directly bind the CEDT detected CHBCR to the Host Bridge's port
      cxl/port: Remove Component Register base address from struct cxl_dport
      cxl/regs: Remove early capability checks in Component Register setup
      cxl/mem: Prepare for early RCH dport component register setup
      cxl/pci: Early setup RCH dport component registers from RCRB
      cxl/port: Store the port's Component Register mappings in struct cxl_port
      cxl/port: Store the downstream port's Component Register mappings in struct cxl_dport

Terry Bowman (1):
      cxl/pci: Refactor component register discovery for reuse

Vishal Verma (4):
      cxl: add a firmware update mechanism using the sysfs firmware loader
      tools/testing/cxl: Fix command effects for inject/clear poison
      tools/testing/cxl: Use named effects for the Command Effect Log
      tools/testing/cxl: add firmware update emulation to CXL memdevs

Yang Li (1):
      cxl: Fix one kernel-doc comment

 Documentation/ABI/testing/sysfs-bus-cxl  |  48 ++
 Documentation/admin-guide/perf/cxl.rst   |  68 +++
 Documentation/admin-guide/perf/index.rst |   1 +
 MAINTAINERS                              |   7 +
 drivers/cxl/Kconfig                      |  14 +
 drivers/cxl/acpi.c                       | 208 ++++---
 drivers/cxl/core/Makefile                |   1 +
 drivers/cxl/core/core.h                  |  11 +
 drivers/cxl/core/hdm.c                   |  48 +-
 drivers/cxl/core/mbox.c                  | 339 ++++++-----
 drivers/cxl/core/memdev.c                | 503 +++++++++++++++-
 drivers/cxl/core/pci.c                   |  31 +-
 drivers/cxl/core/pmem.c                  |   2 +-
 drivers/cxl/core/pmu.c                   |  68 +++
 drivers/cxl/core/port.c                  | 163 +++--
 drivers/cxl/core/region.c                | 168 ++++--
 drivers/cxl/core/regs.c                  | 182 +++++-
 drivers/cxl/cxl.h                        | 104 ++--
 drivers/cxl/cxlmem.h                     | 229 +++++--
 drivers/cxl/cxlpci.h                     |   1 +
 drivers/cxl/mem.c                        |  26 +-
 drivers/cxl/pci.c                        | 486 ++++++++++-----
 drivers/cxl/pmem.c                       |  35 +-
 drivers/cxl/pmu.h                        |  28 +
 drivers/cxl/port.c                       |  21 +-
 drivers/cxl/security.c                   |  27 +-
 drivers/perf/Kconfig                     |  13 +
 drivers/perf/Makefile                    |   1 +
 drivers/perf/cxl_pmu.c                   | 990 +++++++++++++++++++++++++++++++
 include/linux/perf_event.h               |   1 +
 include/linux/rcuwait.h                  |  23 +-
 kernel/events/core.c                     |   1 +
 tools/testing/cxl/Kbuild                 |   5 +-
 tools/testing/cxl/test/cxl.c             |  36 +-
 tools/testing/cxl/test/mem.c             | 367 +++++++++---
 tools/testing/cxl/test/mock.c            |  59 +-
 tools/testing/cxl/test/mock.h            |   3 -
 37 files changed, 3475 insertions(+), 843 deletions(-)
 create mode 100644 Documentation/admin-guide/perf/cxl.rst
 create mode 100644 drivers/cxl/core/pmu.c
 create mode 100644 drivers/cxl/pmu.h
 create mode 100644 drivers/perf/cxl_pmu.c
