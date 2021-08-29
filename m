Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 548AD3FAA26
	for <lists+linux-pci@lfdr.de>; Sun, 29 Aug 2021 10:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234708AbhH2Ias (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 29 Aug 2021 04:30:48 -0400
Received: from mga04.intel.com ([192.55.52.120]:42621 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232155AbhH2Iar (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 29 Aug 2021 04:30:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10090"; a="216297768"
X-IronPort-AV: E=Sophos;i="5.84,361,1620716400"; 
   d="gz'50?scan'50,208,50";a="216297768"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2021 01:29:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,361,1620716400"; 
   d="gz'50?scan'50,208,50";a="529694467"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Aug 2021 01:29:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Sun, 29 Aug 2021 01:29:55 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Sun, 29 Aug 2021 01:29:55 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Sun, 29 Aug 2021 01:29:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYtqIJ94b9OhebBCFwh2MPyqMrDOCLouEDH4kRQwc5GV5fJHBi439F0/YQIAgQk29PZA/3d5hFEv5ajYDjWO66zRy8RCYDAn/kIUg4wBSph3HGcTPHF3DmRc+3Z1r3BNvlxJfuYNypnS+c6J39hDXCXj26bg0tbmy/CdYRWlTOdOUfKvfJ9vc/6ra4Gy9n6pRG0nINNxI1PIx4u0E6t6YjAJQDCLWGJ1LFn35J/S6cpqlQmYG1fWNtyQwVyophqnPnkPmC+y/HRlpRHOLQIa/QJrm27Z1cYjRUMKcW2440T+uZebPgeGzruP8m/Cjp6qrByV/MotwiwwqPbF6cpRzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8YChfTsc0BBNSThuJedtw+6k6l+RxX0DOdA9zVuc3s=;
 b=SaOYjrLXQJWUrIDQCh2r0aXobigQ7jTr1AR/E2Be9OqU2PXZ6Q8/4Q3MW/EH1WfnLgXDI8VgBgEi9tF80b3iQ4kBys5Fgu81wEZKfXkQzJ7pSL9MHIoOiKSMfkTgAVX8i0RG/TrOTF5C2KdZzVKOOh3Qq8BjkDFfC1VS8jUQrXDdB7byv4sXmcEtztKtchVkJ+U9lsLpNXqY2xq51ROD9gTkyEba0x4bL6UNHRq/GaGIblXyEYU5iTm1yZNsnD6QbvS2h5Jp7yuC1MEQpx8bF723Yxxb+m8gzwS/btFGnFSnjMIynMtbkgYkm7w0PxhciFUGtddhw0643/8TbYPslQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8YChfTsc0BBNSThuJedtw+6k6l+RxX0DOdA9zVuc3s=;
 b=JJbkmluApOFNtSmwxxppscpgkfAoyYTYp2IwixB5dwdGYEV4S5bSzL6OIkn/6Ma8V7BZ3zTTox747FqetnHhIh0gbvszcchf8kHjtHCq34lL12Nt1qfuoGSjnZgXy0o3KK3CwsgZXhscuBveFYhyP0KV/abirfYfkmiU+tSShh0=
Authentication-Results: siemens.com; dkim=none (message not signed)
 header.d=none;siemens.com; dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by SJ0PR11MB5614.namprd11.prod.outlook.com (2603:10b6:a03:300::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Sun, 29 Aug
 2021 08:29:52 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::6d71:2479:2bf5:de7f]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::6d71:2479:2bf5:de7f%7]) with mapi id 15.20.4457.022; Sun, 29 Aug 2021
 08:29:52 +0000
Content-Type: multipart/mixed; boundary="------------XllkuXEhqWxFaGjUCENwwAXq"
Message-ID: <59100586-3531-fe69-9f00-3ed62335596f@intel.com>
Date:   Sun, 29 Aug 2021 16:29:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.0.3
Subject: Re: [PATCH] PCI/portdrv: Do not setup up IRQs if there are no users
References: <202108221525.NT2Kap5Q-lkp@intel.com>
Content-Language: en-US
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202108221525.NT2Kap5Q-lkp@intel.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     <clang-built-linux@googlegroups.com>, <kbuild-all@lists.01.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-Forwarded-Message-Id: <202108221525.NT2Kap5Q-lkp@intel.com>
X-ClientProxiedBy: HK0PR03CA0099.apcprd03.prod.outlook.com
 (2603:1096:203:b0::15) To SJ0PR11MB5598.namprd11.prod.outlook.com
 (2603:10b6:a03:304::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.125] (183.195.27.35) by HK0PR03CA0099.apcprd03.prod.outlook.com (2603:1096:203:b0::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.19 via Frontend Transport; Sun, 29 Aug 2021 08:29:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 127e9f4f-0be8-4c9e-7345-08d96ac72bbb
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5614:
X-Microsoft-Antispam-PRVS: <SJ0PR11MB56144F13D4737FDADB6FC153FBCA9@SJ0PR11MB5614.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:357;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ejXe3Qe5Jbnz2kSk9BVqLB/2d2jmzUfEEe+jZvYFwaSfXq2zoKuRfawpXqe1f4iPSWzOqQAC8OtbZhiKQ5wlDXrGzyZRe2zhUun9BmYTR7aI+ooA2TNHxCaGFC/6cAZPswgRM7EehbJGT7E9z4Frn6GRG7z3CG8Eb+u0cO0u83BPgA5oRGdJs1AjFOYPVBubHF2EMpSuX7X/JP58PGFB8nJ1SZRFGHJ2ThjVMcqJqPnK+qvPtZayGOQS+OkECh2Dkn0ZExBNecbwmULG0BBSzpcTWZATqC7VnmOI2aQm6/LD+SlUp272XNJVOwrPpUgEQiz6AeHuzKOS+8Oe4z3ngNO5VZezCSuPFp1Ml5RLe0arPQF9OADyiYR9WSDDeZFjHkgzSchiIiUdfcRsLFMs81qk464ujUN5pseYu17hqyTRuVRMdiQgKRa9kNJdZ29qDKHDfoRuEWZqIRYe40c/FWjV3+ICOZCeBPNpkB6lSN2fU+UKqOCXWa9VwV9cPIJXBkXq4c1LAlZTF6r70Xev7bfsgvYC5n8R/6t6JjfPyTnvS0GyPtdjKftTMuD0xfQLEBGmuspNOqvH/0GiAR943vzjPqrIe20tEMLixrKQvcJe0Erb3pnTL/hoopCXaL1FhM1HiYLC2E7TXZ05VR7/fcYpFZLMRH9tvfiqBI2gi03mbyCVbSOB7mKkQFnM8Ec/KV9Z0TE7bLjy1H06OoEGopbe/KdNSCGleB6JSNyO5ZuKFeHviATVz+SYgGYD+mBZ6Nbc8MOIUe6IU7TRkGabLndjM0pblbLAo2EmbRU6ME/uvN23aayI3PL5/a9CxZS4s4y1jXPVgTROSftGOP4uA3E173go0S33d3mq3yKjhMevntxPfLDui3TV5sC0bmUE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(6486002)(4326008)(86362001)(110136005)(16576012)(316002)(36756003)(83380400001)(66946007)(38100700002)(478600001)(6666004)(966005)(33964004)(31696002)(66576008)(66476007)(66556008)(26005)(186003)(5660300002)(235185007)(2616005)(956004)(2906002)(4001150100001)(8936002)(8676002)(31686004)(26730200005)(19860200003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTc3ZFpaOVozMm9GY3Z0ZTVlNnBBdlZJRzhxL3VwRHpOM2NveGkzbzFveDhm?=
 =?utf-8?B?bnFaNkRwZVJ5SHdGOW04bkQ2TFp2WGtDZ0pMcDFiRVRyYVFJOWVhd3MySXRX?=
 =?utf-8?B?UnQxT2ZQenpOWUY1U2VhL2ZUZndwaTlURmNhaGVsVHNqbjlDUXVZS1UwY2FD?=
 =?utf-8?B?NXFsVnNzdFIyVnFBZFBwWEZkdy8zbW9SbEFlc25XM3VwOVpCeWxtaVQybEY5?=
 =?utf-8?B?UDMxQU9xZTVUMWhNOE5yelppVHV6NDhadEpmNWJWTDJWSXlyUVZiUVRKd0NR?=
 =?utf-8?B?NXQ5R0l5S0pSL0Q2ZjFXQ3NWbUNXbGJxU0cvSlNjcmlJVTBHblp2VDNmSXBK?=
 =?utf-8?B?SjRyUnp0QUtEcGQxdGcrZjBPVUhnLzJvR25VVWNQdEF3MDlnaXMwZzdOR3hZ?=
 =?utf-8?B?S29OdUVIeFE0ZzJsV0ZxY2t0bXFVN0VMY0x2cFlkT3h3TStnUHUvR3FqNHJU?=
 =?utf-8?B?eFJsdVJqbFN1WXRjekhkdVpDTkNncUtjVitYR25aN0lQVGtPNHBkVGRib01B?=
 =?utf-8?B?bXFSZ0IycFJtRTZrR2RXL2ZxbGsyalQzLzBvWjNxMWZCR2Zla0FpK2dXZWFn?=
 =?utf-8?B?Vk9OOEFoZW5ScVR0Wjc1V3dmTFRSOURhLzlLUTUrUHhnMHpUQkpCeTk0TEw2?=
 =?utf-8?B?cVBTYVJGcEVQU3ZkKzlWNlZ4aWZTTjRMdmkzV2wwSEIyYnhEZFhIbHI5bW9j?=
 =?utf-8?B?ejNOcHg1OGR3aUhVMGJkd05yR2IrVFczVGFCa2NWd2w0RmJJWEk4VGRKeWN3?=
 =?utf-8?B?ZDFvYWRLMVNBYnlZMmVJbU1JYkduL1pMWHJGengyWlNGYU5zWCtWZzJVamhh?=
 =?utf-8?B?UURIVU92cDAvVFpRY0tXMWlPZnRJNlBKdTRnNVhLODBCK0hTTFZaY0gwVGxy?=
 =?utf-8?B?QTFuZHdFRUp2dTNLekovV2lJdTBJdzk1Ny9renF6cVRsL0xJVXlIR09qWGZr?=
 =?utf-8?B?WFhjY09ia2U3U1JGRGJVSUZSOWpHMUdLb3pFRWVOSU0xQ0V5Qnh0RE44cjFa?=
 =?utf-8?B?UWhHcTVZT1NsUGxNb25NaFJsODJmL1NDSEpSYXp4RDZKc1pWZ1pjeExtK3py?=
 =?utf-8?B?L0FNaGxoTVp0VCt1dDFYRmVIc25POEttbzd0M1NmUi9WRjEvYjg2a0RQcUxp?=
 =?utf-8?B?NklBK2FPdHRBOGc5OTlFRnVSOFlpZU1qTm9LZkJ6TURwbTF3RWVXYmRTVmxY?=
 =?utf-8?B?SmJjb3RkZkRWU1REZUZCajYzQWlFWmtwekhEa3gvSUV0djlYZE9EVHg0TDJH?=
 =?utf-8?B?T1MyVzdSZkJSSUZkR0k1TFZQT0xUMk9ZbzZvdUVIWDFWNld3cmplamVKMEZ2?=
 =?utf-8?B?NXNBZm0waVlIbG8vMXcxNmVCajk5dUw1SG54cVRUYVQ1UFEySzhjR0dTbVZy?=
 =?utf-8?B?Z3p3ZnJJV2l5Rlg2bHJjWnVld3hUd0pveXpKRzd4ZGxHUnRkVFNJa285MGVt?=
 =?utf-8?B?b2JSVmMzZ0NKeUNSWEszUUpsMDdUSFFmVHBleVg5OHptdm5ZMmJzZ25JR1JN?=
 =?utf-8?B?UktLMmlwcFVtYXdhU25vV2Z6WVZ2aGtzOCtiUFc4RjhML2hoekYxaE90MUtj?=
 =?utf-8?B?Vld2SFhPTXBKdm9xUUVreS92cXg0M0dWOHJvZ2loRXBFRzdRNFRQM0FYWlVN?=
 =?utf-8?B?bS9JMDVTRXhCcVJXOHEyaUdHeHFlbWFmbW9NRmFxdHpFbDl4dHM2aUl0cWdQ?=
 =?utf-8?B?bHFHemFab21vWThZRk9LN00wd1pNSnkyc3lHWW1BRDZuV3lZaUlvWkh6MFNw?=
 =?utf-8?Q?qLTXBfzYOt8owXzJ/Ki6BwTgEy+7mBWtXrXwh/3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 127e9f4f-0be8-4c9e-7345-08d96ac72bbb
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2021 08:29:51.8946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E1x/K+DL8EPx/ycJhIENAO6+P8+hDJ01pH9dOyr8HgJjNH1fJ24CXheJf8z6NVd2o4ary6vazt6NoTC5ZLMjWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5614
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--------------XllkuXEhqWxFaGjUCENwwAXq
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jan,

I love your patch! Perhaps something to improve:

[auto build test WARNING on pci/next]
[also build test WARNING on v5.14-rc6 next-20210820]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jan-Kiszka/PCI-portdrv-Do-not-setup-up-IRQs-if-there-are-no-users/20210820-215311
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
:::::: branch date: 2 days ago
:::::: commit date: 2 days ago
config: arm-randconfig-c002-20210822 (attached as .config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 9e9d70591e72fc6762b4b9a226b68ed1307419bf)
reproduce (this is a W=1 build):
         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
         chmod +x ~/bin/make.cross
         # install arm cross compiling tool for clang build
         # apt-get install binutils-arm-linux-gnueabi
         # https://github.com/0day-ci/linux/commit/30b9aea30a820b153bb866daf79d1738628934d8
         git remote add linux-review https://github.com/0day-ci/linux
         git fetch --no-tags linux-review Jan-Kiszka/PCI-portdrv-Do-not-setup-up-IRQs-if-there-are-no-users/20210820-215311
         git checkout 30b9aea30a820b153bb866daf79d1738628934d8
         # save the attached .config to linux build tree
         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm clang-analyzer

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


clang-analyzer warnings: (new ones prefixed by >>)

 >> drivers/pci/pcie/portdrv_core.c:364:8: warning: 3rd function call argument is an uninitialized value [clang-analyzer-core.CallAndMessage]
                    if (!pcie_device_init(dev, service, irqs[i]))
                         ^                              ~~~~~~~
    drivers/pci/pcie/portdrv_core.c:341:6: note: 'irq_services' is 0
            if (irq_services) {
                ^~~~~~~~~~~~
    drivers/pci/pcie/portdrv_core.c:341:2: note: Taking false branch
            if (irq_services) {
            ^
    drivers/pci/pcie/portdrv_core.c:360:2: note: Loop condition is true.  Entering loop body
            for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++) {
            ^
    drivers/pci/pcie/portdrv_core.c:362:3: note: Taking false branch
                    if (!(capabilities & service))
                    ^
    drivers/pci/pcie/portdrv_core.c:364:8: warning: 3rd function call argument is an uninitialized value [clang-analyzer-core.CallAndMessage]
                    if (!pcie_device_init(dev, service, irqs[i]))
                         ^                              ~~~~~~~

vim +364 drivers/pci/pcie/portdrv_core.c

8f3acca9acec15 Bjorn Helgaas     2013-12-19  305
facf6d1627a33b Rafael J. Wysocki 2009-01-01  306  /**
facf6d1627a33b Rafael J. Wysocki 2009-01-01  307   * pcie_port_device_register - register PCI Express port
facf6d1627a33b Rafael J. Wysocki 2009-01-01  308   * @dev: PCI Express port to register
facf6d1627a33b Rafael J. Wysocki 2009-01-01  309   *
facf6d1627a33b Rafael J. Wysocki 2009-01-01  310   * Allocate the port extension structure and register services associated with
facf6d1627a33b Rafael J. Wysocki 2009-01-01  311   * the port.
facf6d1627a33b Rafael J. Wysocki 2009-01-01  312   */
^1da177e4c3f41 Linus Torvalds    2005-04-16  313  int pcie_port_device_register(struct pci_dev *dev)
^1da177e4c3f41 Linus Torvalds    2005-04-16  314  {
30b9aea30a820b Jan Kiszka        2021-08-20  315  	int status, capabilities, irq_services, i, nr_service;
dc5351784eb36f Kenji Kaneshige   2009-11-25  316  	int irqs[PCIE_PORT_DEVICE_MAXSERVICES];
^1da177e4c3f41 Linus Torvalds    2005-04-16  317
1ce5e83063bf38 Kenji Kaneshige   2009-11-25  318  	/* Enable PCI Express port device */
1ce5e83063bf38 Kenji Kaneshige   2009-11-25  319  	status = pci_enable_device(dev);
1ce5e83063bf38 Kenji Kaneshige   2009-11-25  320  	if (status)
694f88ef7ada0d Kenji Kaneshige   2009-11-25  321  		return status;
fe31e69740eddc Rafael J. Wysocki 2010-12-19  322
fe31e69740eddc Rafael J. Wysocki 2010-12-19  323  	/* Get and check PCI Express port services */
fe31e69740eddc Rafael J. Wysocki 2010-12-19  324  	capabilities = get_port_device_capability(dev);
eca67315e0e0d5 Naga Chumbalkar   2011-03-21  325  	if (!capabilities)
fe31e69740eddc Rafael J. Wysocki 2010-12-19  326  		return 0;
fe31e69740eddc Rafael J. Wysocki 2010-12-19  327
1ce5e83063bf38 Kenji Kaneshige   2009-11-25  328  	pci_set_master(dev);
30b9aea30a820b Jan Kiszka        2021-08-20  329
30b9aea30a820b Jan Kiszka        2021-08-20  330  	irq_services = 0;
30b9aea30a820b Jan Kiszka        2021-08-20  331  	if (IS_ENABLED(CONFIG_PCIE_PME))
30b9aea30a820b Jan Kiszka        2021-08-20  332  		irq_services |= PCIE_PORT_SERVICE_PME;
30b9aea30a820b Jan Kiszka        2021-08-20  333  	if (IS_ENABLED(CONFIG_PCIEAER))
30b9aea30a820b Jan Kiszka        2021-08-20  334  		irq_services |= PCIE_PORT_SERVICE_AER;
30b9aea30a820b Jan Kiszka        2021-08-20  335  	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
30b9aea30a820b Jan Kiszka        2021-08-20  336  		irq_services |= PCIE_PORT_SERVICE_HP;
30b9aea30a820b Jan Kiszka        2021-08-20  337  	if (IS_ENABLED(CONFIG_PCIE_DPC))
30b9aea30a820b Jan Kiszka        2021-08-20  338  		irq_services |= PCIE_PORT_SERVICE_DPC;
30b9aea30a820b Jan Kiszka        2021-08-20  339  	irq_services &= capabilities;
30b9aea30a820b Jan Kiszka        2021-08-20  340
30b9aea30a820b Jan Kiszka        2021-08-20  341  	if (irq_services) {
f118c0c3cff4fe Rafael J. Wysocki 2009-01-13  342  		/*
dc5351784eb36f Kenji Kaneshige   2009-11-25  343  		 * Initialize service irqs. Don't use service devices that
dc5351784eb36f Kenji Kaneshige   2009-11-25  344  		 * require interrupts if there is no way to generate them.
30b9aea30a820b Jan Kiszka        2021-08-20  345  		 * However, some drivers may have a polling mode (e.g.
30b9aea30a820b Jan Kiszka        2021-08-20  346  		 * pciehp_poll_mode) that can be used in the absence of irqs.
30b9aea30a820b Jan Kiszka        2021-08-20  347  		 * Allow them to determine if that is to be used.
f118c0c3cff4fe Rafael J. Wysocki 2009-01-13  348  		 */
30b9aea30a820b Jan Kiszka        2021-08-20  349  		status = pcie_init_service_irqs(dev, irqs, irq_services);
dc5351784eb36f Kenji Kaneshige   2009-11-25  350  		if (status) {
30b9aea30a820b Jan Kiszka        2021-08-20  351  			irq_services &= PCIE_PORT_SERVICE_HP;
30b9aea30a820b Jan Kiszka        2021-08-20  352  			if (!irq_services)
1ce5e83063bf38 Kenji Kaneshige   2009-11-25  353  				goto error_disable;
f118c0c3cff4fe Rafael J. Wysocki 2009-01-13  354  		}
30b9aea30a820b Jan Kiszka        2021-08-20  355  	}
^1da177e4c3f41 Linus Torvalds    2005-04-16  356
^1da177e4c3f41 Linus Torvalds    2005-04-16  357  	/* Allocate child services if any */
40717c39b1e6c0 Kenji Kaneshige   2009-11-25  358  	status = -ENODEV;
40717c39b1e6c0 Kenji Kaneshige   2009-11-25  359  	nr_service = 0;
40717c39b1e6c0 Kenji Kaneshige   2009-11-25  360  	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++) {
90e9cd50f7feed Rafael J. Wysocki 2009-01-13  361  		int service = 1 << i;
90e9cd50f7feed Rafael J. Wysocki 2009-01-13  362  		if (!(capabilities & service))
90e9cd50f7feed Rafael J. Wysocki 2009-01-13  363  			continue;
40717c39b1e6c0 Kenji Kaneshige   2009-11-25 @364  		if (!pcie_device_init(dev, service, irqs[i]))
40717c39b1e6c0 Kenji Kaneshige   2009-11-25  365  			nr_service++;
f118c0c3cff4fe Rafael J. Wysocki 2009-01-13  366  	}
40717c39b1e6c0 Kenji Kaneshige   2009-11-25  367  	if (!nr_service)
fbb5de70bbe13e Kenji Kaneshige   2009-11-25  368  		goto error_cleanup_irqs;
40717c39b1e6c0 Kenji Kaneshige   2009-11-25  369
^1da177e4c3f41 Linus Torvalds    2005-04-16  370  	return 0;
f118c0c3cff4fe Rafael J. Wysocki 2009-01-13  371
fbb5de70bbe13e Kenji Kaneshige   2009-11-25  372  error_cleanup_irqs:
3674cc49da9a8f Christoph Hellwig 2017-02-01  373  	pci_free_irq_vectors(dev);
1ce5e83063bf38 Kenji Kaneshige   2009-11-25  374  error_disable:
1ce5e83063bf38 Kenji Kaneshige   2009-11-25  375  	pci_disable_device(dev);
f118c0c3cff4fe Rafael J. Wysocki 2009-01-13  376  	return status;
^1da177e4c3f41 Linus Torvalds    2005-04-16  377  }
^1da177e4c3f41 Linus Torvalds    2005-04-16  378

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
--------------XllkuXEhqWxFaGjUCENwwAXq
Content-Type: application/gzip; name=".config.gz"
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--------------XllkuXEhqWxFaGjUCENwwAXq
Content-Type: text/plain; charset=UTF-8; name="Attached Message Part"
Content-Disposition: attachment; filename="Attached Message Part"
Content-Transfer-Encoding: base64

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCmtidWlsZCBt
YWlsaW5nIGxpc3QgLS0ga2J1aWxkQGxpc3RzLjAxLm9yZw0KVG8gdW5zdWJzY3JpYmUgc2VuZCBh
biBlbWFpbCB0byBrYnVpbGQtbGVhdmVAbGlzdHMuMDEub3JnDQoNCg==

--------------XllkuXEhqWxFaGjUCENwwAXq--
