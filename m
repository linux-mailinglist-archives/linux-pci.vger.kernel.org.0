Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72782432F6A
	for <lists+linux-pci@lfdr.de>; Tue, 19 Oct 2021 09:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbhJSHbe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Oct 2021 03:31:34 -0400
Received: from mga07.intel.com ([134.134.136.100]:55425 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234167AbhJSHbd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Oct 2021 03:31:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10141"; a="291909850"
X-IronPort-AV: E=Sophos;i="5.85,383,1624345200"; 
   d="gz'50?scan'50,208,50";a="291909850"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 00:29:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,383,1624345200"; 
   d="gz'50?scan'50,208,50";a="566814201"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Oct 2021 00:29:19 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 19 Oct 2021 00:29:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 19 Oct 2021 00:29:18 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 19 Oct 2021 00:29:18 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Tue, 19 Oct 2021 00:29:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWaWPTjS4fwpcHH2J/1nMPJFpepcKPaXnq8g/nl5UNcrQJpHhj0XsFWr8/LKyti7x1lGnYSr8WMtmCmGUSZtZGwCf4kEUu+RCrbMvZWq38ENVeR3P8jMIaWxIPAAiqC5kJmuGyZdYVwJP2/7Su28GaqLipsX+2CmXEJsAxpbL1keK62flTqWfuEHpDYZb9MuwZhnp6ReeS1Ptk3LCIZOyh8kfhgb1Yv1+gPQuH4UaI5NAfmy/GPNtRN+UyroUIlDi+xyJ4goH7o3kh8pce+dbAIrO/1nEhhdAW22OVC2Mp/oojmK3tJBfqRp7qXpvk06alH07c4pzFLNeMr81L5wwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gOqLvNVrU7rLQf1VVcPsrEyVFY9j8evcsfkL28Nbumo=;
 b=dSj05q3zs7kOzVwlUZmULWah9dvyO+qeeDhVSzpp3V5ixvGe/+qc/kHa9t8FZutF/3AaNl7O5oKCeDxZpkcaPAmys1ZBdcK6DTHbZjHgFEcKM5VuI1WLaBEHQY9LAt5QsraxBoR+gDFRFD3pvE/qXpmcrKhajXg8sUwhE0q5unml+HcDDnAIb2zP9wNL7rm1o+uQXCDn1XT25G7Mu9XkpllE/Q+CRatujJ2k0OQ9bhB6gioTDRfmf2Cql/xso9PfKhOwZ5C/RJNmED5l2t+Cn8lvlJxuGe+pcHOGB+SMx41B+JBPW58dGngSGraJITp9toE5gfzjGQUMglsf4v8FUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gOqLvNVrU7rLQf1VVcPsrEyVFY9j8evcsfkL28Nbumo=;
 b=EgHlNLmP+lPWrVWHG98i8H4BbYK0dXtUr7uqKkTM4VPWAVejy33nDm37ft1tR/cd8lC0E/JyWlur/WS/HlWYlL/nji+zXi1RJCYPlYGkKf0aSbMVCvgyY+klztvdNz+zCiZ4U7fCofCrx2LLTydFVQ71UWFON7gLzCS2V2/D8Fo=
Authentication-Results: rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Tue, 19 Oct
 2021 07:29:12 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::6d71:2479:2bf5:de7f]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::6d71:2479:2bf5:de7f%9]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 07:29:11 +0000
Content-Type: multipart/mixed; boundary="------------Xi0yn39XyeP9a3fDOVHMFGDT"
Message-ID: <347333dd-8e45-b454-a631-db2cdc436f2c@intel.com>
Date:   Tue, 19 Oct 2021 15:29:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.2.0
Subject: Re: [PATCH v1 2/3] ACPI: PM: Fix sharing of wakeup power resources
References: <202110171527.mOdEINNH-lkp@intel.com>
Content-Language: en-US
In-Reply-To: <202110171527.mOdEINNH-lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
CC:     <llvm@lists.linux.dev>, <kbuild-all@lists.01.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Mika Westerberg" <mika.westerberg@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>
From:   kernel test robot <yujie.liu@intel.com>
X-Forwarded-Message-Id: <202110171527.mOdEINNH-lkp@intel.com>
X-ClientProxiedBy: HK2PR0401CA0005.apcprd04.prod.outlook.com
 (2603:1096:202:2::15) To SJ0PR11MB5598.namprd11.prod.outlook.com
 (2603:10b6:a03:304::12)
MIME-Version: 1.0
Received: from [10.238.2.77] (192.198.143.18) by HK2PR0401CA0005.apcprd04.prod.outlook.com (2603:1096:202:2::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 07:29:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78a801e2-f5c8-49e9-35d6-08d992d2253c
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:
X-Microsoft-Antispam-PRVS: <SJ0PR11MB56451D30546EEE2F4DA66BFFFBBD9@SJ0PR11MB5645.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NGYP4tlgKU7AWDIVwI0TKHWi0DuwPPvYw20Rs8BOq0dtPgKYaP0pTPCqCQ68HPLEQfIWxKpaSVU+OjUFptfC5SiF/bsHMd2lLhZtc1iqdge4S7VWvx3ynucmWOry/LhY2QplO2vdeMrsdbHFkglbFgEplNOA4JKe2kuHYoLJA8AR3JrGTtZkFEGzLpGrudwwgl61b9HFgOdu7X826PdOsvY4DxHNmg0Eb19LnALg6ZNUAmsMecLjPtXZCHjuvWWHLetXH0QOokLHrE34Ewysdt+aFHkcG9KgOL44l4qYfc6OBS64sn6osAXQ4hBonZdPJMmqFWzTPyo3kqBhqxdBvGNJr5qurqDf+nYGCtEMKx4btvV2p5BO3TE8wcFSlVylrYMfdDMR1eRryKx87nG9r1FXrTXpa7IdxlEE47sY4PkMnsraZFa/zY4K4P0lH/TxpmqgqJqy+xVyDpT0MWg1cOdv7xAk9AUYifAoJ30MFjr+iznEQ5xH8+a4IXeJx5I+MiXh5rtBQb/1p3GlnywRmNAAAWmK1o5k7aWHom0X9wmZ00LNxZjGInGPoCCqOsYgtNCakGaabLwfacJt9VTXL3j1p6RC7sSO5Atj7KNvMihIbY8pH8GgxWOH/Vdz+CPZwtUDOmMl0aiH55estZUsi4lYNyrPXU2I5g+whbhfRkI8oTO/c18Mw4HVCRHe7isIOcsKkQUBm/gP27e+fSQMRPtnZPktpg3V0dnSHD6yMKwAc1mbOn0DGJn9N6olAlQo+CcpcpktvpHRGiwl0oycJWJIqjuB3ag/Ru3o/F4SxewtX0/+kQ4sKyt9g2X4kfsM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(5660300002)(235185007)(16576012)(4001150100001)(316002)(36756003)(8936002)(83380400001)(4326008)(2906002)(38100700002)(2616005)(31686004)(508600001)(966005)(26005)(110136005)(54906003)(186003)(31696002)(66946007)(8676002)(6486002)(33964004)(66476007)(66556008)(956004)(82960400001)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFA2TnF1eVF6ckM5VHhMNXR0SUxFbnlzMmVDSG93M0FqUXdUWlN4bWFnVFZE?=
 =?utf-8?B?WGdoT3orWkM1R0RDd2pralpKckd5U2xjNzc5TktXQzNtWGdZVjhqZ2h2ZzlF?=
 =?utf-8?B?c0dlTkptVDBqZU42NndFVW1XR0RrbCtzZGVlN05DZkFuTHVlVEluUFVmQ2pt?=
 =?utf-8?B?SEFxdStMcDBiNmt3VjVSVUE0SzdVS3RSSUpUMzhrbDc0V2I3WktPMlZNVkpR?=
 =?utf-8?B?UnNsVmpnM1h2UFg5b09yRktMNTFqT21RRnl6QzJKdDJTWkcvZFoyTXB0VGtC?=
 =?utf-8?B?a1Y5cG9jQTdYOEFNb25zVTVNdGhqSk04eVhlSkw4NmxIdWdBMlRneS9iSStZ?=
 =?utf-8?B?L01LSS83MXM4UzIzMndzQTBZR2drbm5DdG1qZlpJUWV3MkwycFZ6QWNWK1Ni?=
 =?utf-8?B?eW1FdERiOHluaTFud2VpL3AzMVZOaG9zOHkyK2dJeTdwSzU5R1l4T3RmOUhU?=
 =?utf-8?B?Q3ptS2l3dUZobmpQWnRUTXk0Yy9SR0ZSbU5IZGc1VERsUEtXbVEvQUZ0UThN?=
 =?utf-8?B?eGlzZHlKbll2WkI1QVppRm5OL3VkZW9sSzU5VDFKd0V4citTQTRaSkxJWWpY?=
 =?utf-8?B?c055ZldHWVdoRTVBV1J5V00yWjlTVFk4UHBReGdLc3JqSTJtd0FMeE5OOWxn?=
 =?utf-8?B?UmdJekhLUzdFNEJOcVQ0WXJkcGtJOEVhMlN0U3AxRUZmMk9wTVI2N0pjOXBu?=
 =?utf-8?B?eHJyanRxNmxPNUpwd1pjd0w5NWhUaE1NVENpOFU1NWlaeng4TzdnZmd4Y3J2?=
 =?utf-8?B?TVF4ZnBWMzhoYjFneVlzNmR0OHZrQzlha3UzSTZrdmNjaVJGU1BPM1hURTBk?=
 =?utf-8?B?UVFFbzRiNlVUbVduZ2RhaXBlTURGMnZuRGl4OHB5TG9IMXc3bFdiU29oa1N3?=
 =?utf-8?B?RXRUOWdKeW1RZHQ5akM0eXNJVXdpYzU1bVRZb3Rxa0RkUDRQbm5QNG5YZmxO?=
 =?utf-8?B?ZEF4c0IxQllqNDk5Wjdnb2ZkZXJ5WVdTWElYQjRuVGhWRFlWSXFid1NuZXRX?=
 =?utf-8?B?ZVJydDBpTFBTZ0pDcTdYbTVJS3ZzSVpNTUpBT3RBRUczS0xubUozZklxSkpy?=
 =?utf-8?B?VXBjSjlsS21GWDNDTkh0eUs3QWR1T3ByZHJLWEp4ZUZZVmZFMmRUd1g4UG1X?=
 =?utf-8?B?R2REWEwzV2pvRkZMTUNuVmY3d0wxckVja0dPaUtMVXV3cXY1dmw1bGN5WjZ2?=
 =?utf-8?B?eXN5ZmZWaHQxODhuTGlTT3c0cEhsT2IxOXVBeTRUNzBzd2t3Vy9RK3dxVW00?=
 =?utf-8?B?MlYyOEFNcHhnaHFHYlo2Mmw4MGM1ajdNWFFFc0M2cG05M2h1RHlhNllkdVN0?=
 =?utf-8?B?Q0VLU0RGQVNGMGplZGxic1A0SVVMVlQydmltYUE0ei9ObWp4ZkM2U0VTYUlC?=
 =?utf-8?B?WjlFT0l3QlllcThhQVhDWTc1LzlwVTF6ZE1nTkZONkE5eGJnMVhCSVphQW43?=
 =?utf-8?B?b1FyeXhvZDdNT0N5RXJQZkdIRzlKZHVveWd1LzA5SkJHa0wyQ1p0eHVuZUpr?=
 =?utf-8?B?Tk1NQTJvWmw1UGtzY2tnZ2l0VFFORURIU29YTGJJSmRrZ1FGWFpKV0Zsdis5?=
 =?utf-8?B?VUNSaUV4RllWWGhQa0ZqdUlBeUJaTU9EVmZSMjQydFdiSzNrcjJRRzRJcTkw?=
 =?utf-8?B?T25kN01FQ3V1QzVKR2xTV0tEQnZFQ004ZFdNSXA4cE42KzdmNG53ZXhKSDBF?=
 =?utf-8?B?NlpSUDFmdHlocjUzWlR4MlVPYWt2TFlTQVZ2a3NQRmFEZG5QZ1AvZ1VnL3FN?=
 =?utf-8?Q?xPA5oexz+f4lJn4ZB6ju5tFUqvQfUl81t4dJW/4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a801e2-f5c8-49e9-35d6-08d992d2253c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 07:29:11.7963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lE0W8P9u25nv2t+n6yj7wSQ1iJRTdH1EtJiNC/MA9Bx/HfkE4dVjQLcKoMeVeOXRC1ZP9mECC8wObz4hJbx3MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5645
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--------------Xi0yn39XyeP9a3fDOVHMFGDT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

Thanks for your patch! Perhaps something to improve:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on linux/master linus/master v5.15-rc5 next-20211015]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Rafael-J-Wysocki/ACPI-PM-Address-issues-related-to-managing-wakeup-power-resources/20211016-010527
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: x86_64-randconfig-c007-20211015 (attached as .config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 6069a6a5049497a32a50a49661c2f4169078bdba)
reproduce (this is a W=1 build):
         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
         chmod +x ~/bin/make.cross
         # https://github.com/0day-ci/linux/commit/5e93f177b80cbc9b9ee6ffc15ff9ad0ad23f2a7a
         git remote add linux-review https://github.com/0day-ci/linux
         git fetch --no-tags linux-review Rafael-J-Wysocki/ACPI-PM-Address-issues-related-to-managing-wakeup-power-resources/20211016-010527
         git checkout 5e93f177b80cbc9b9ee6ffc15ff9ad0ad23f2a7a
         # save the attached .config to linux build tree
         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 clang-analyzer

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


clang-analyzer warnings:

 >> drivers/acpi/power.c:739:2: warning: Undefined or garbage value returned to caller [clang-analyzer-core.uninitialized.UndefReturn]
            return err;
            ^      ~~~
    drivers/acpi/power.c:712:2: note: 'err' declared without an initial value
            int err;
            ^~~~~~~
    drivers/acpi/power.c:714:6: note: Assuming 'dev' is non-null
            if (!dev || !dev->wakeup.flags.valid)
                ^~~~
    drivers/acpi/power.c:714:6: note: Left side of '||' is false
    drivers/acpi/power.c:714:14: note: Assuming field 'valid' is not equal to 0
            if (!dev || !dev->wakeup.flags.valid)
                        ^~~~~~~~~~~~~~~~~~~~~~~~
    drivers/acpi/power.c:714:2: note: Taking false branch
            if (!dev || !dev->wakeup.flags.valid)
            ^
    drivers/acpi/power.c:719:6: note: Assuming the condition is true
            if (dev->wakeup.prepare_count++)
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~
    drivers/acpi/power.c:719:2: note: Taking true branch
            if (dev->wakeup.prepare_count++)
            ^
    drivers/acpi/power.c:720:3: note: Control jumps to line 738
                    goto out;
                    ^
    drivers/acpi/power.c:739:2: note: Undefined or garbage value returned to caller
            return err;
            ^      ~~~


vim +739 drivers/acpi/power.c

77e766099efc29 Rafael J. Wysocki 2008-07-07  703
^1da177e4c3f41 Linus Torvalds    2005-04-16  704  /*
^1da177e4c3f41 Linus Torvalds    2005-04-16  705   * Prepare a wakeup device, two steps (Ref ACPI 2.0:P229):
^1da177e4c3f41 Linus Torvalds    2005-04-16  706   * 1. Power on the power resources required for the wakeup device
77e766099efc29 Rafael J. Wysocki 2008-07-07  707   * 2. Execute _DSW (Device Sleep Wake) or (deprecated in ACPI 3.0) _PSW (Power
77e766099efc29 Rafael J. Wysocki 2008-07-07  708   *    State Wake) for the device, if present
^1da177e4c3f41 Linus Torvalds    2005-04-16  709   */
77e766099efc29 Rafael J. Wysocki 2008-07-07  710  int acpi_enable_wakeup_device_power(struct acpi_device *dev, int sleep_state)
^1da177e4c3f41 Linus Torvalds    2005-04-16  711  {
5e93f177b80cbc Rafael J. Wysocki 2021-10-15  712  	int err;
^1da177e4c3f41 Linus Torvalds    2005-04-16  713
^1da177e4c3f41 Linus Torvalds    2005-04-16  714  	if (!dev || !dev->wakeup.flags.valid)
77e766099efc29 Rafael J. Wysocki 2008-07-07  715  		return -EINVAL;
^1da177e4c3f41 Linus Torvalds    2005-04-16  716
9b83ccd2f14f64 Rafael J. Wysocki 2009-09-08  717  	mutex_lock(&acpi_device_lock);
9b83ccd2f14f64 Rafael J. Wysocki 2009-09-08  718
9b83ccd2f14f64 Rafael J. Wysocki 2009-09-08  719  	if (dev->wakeup.prepare_count++)
9b83ccd2f14f64 Rafael J. Wysocki 2009-09-08  720  		goto out;
0af4b8c4fb3119 Rafael J. Wysocki 2008-07-07  721
5e93f177b80cbc Rafael J. Wysocki 2021-10-15  722  	err = acpi_power_on_list(&dev->wakeup.resources);
993cbe595dda73 Rafael J. Wysocki 2013-01-17  723  	if (err) {
5e93f177b80cbc Rafael J. Wysocki 2021-10-15  724  		dev_err(&dev->dev, "Cannot turn on wakeup power resources\n");
^1da177e4c3f41 Linus Torvalds    2005-04-16  725  		dev->wakeup.flags.valid = 0;
b5d667eb392ed9 Rafael J. Wysocki 2013-02-23  726  		goto out;
b5d667eb392ed9 Rafael J. Wysocki 2013-02-23  727  	}
5e93f177b80cbc Rafael J. Wysocki 2021-10-15  728
77e766099efc29 Rafael J. Wysocki 2008-07-07  729  	/*
993cbe595dda73 Rafael J. Wysocki 2013-01-17  730  	 * Passing 3 as the third argument below means the device may be
993cbe595dda73 Rafael J. Wysocki 2013-01-17  731  	 * put into arbitrary power state afterward.
77e766099efc29 Rafael J. Wysocki 2008-07-07  732  	 */
0af4b8c4fb3119 Rafael J. Wysocki 2008-07-07  733  	err = acpi_device_sleep_wake(dev, 1, sleep_state, 3);
9b83ccd2f14f64 Rafael J. Wysocki 2009-09-08  734  	if (err)
9b83ccd2f14f64 Rafael J. Wysocki 2009-09-08  735  		dev->wakeup.prepare_count = 0;
9b83ccd2f14f64 Rafael J. Wysocki 2009-09-08  736
9b83ccd2f14f64 Rafael J. Wysocki 2009-09-08  737   out:
9b83ccd2f14f64 Rafael J. Wysocki 2009-09-08  738  	mutex_unlock(&acpi_device_lock);
0af4b8c4fb3119 Rafael J. Wysocki 2008-07-07 @739  	return err;
^1da177e4c3f41 Linus Torvalds    2005-04-16  740  }
^1da177e4c3f41 Linus Torvalds    2005-04-16  741

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
--------------Xi0yn39XyeP9a3fDOVHMFGDT
Content-Type: application/gzip; name=".config.gz"
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
WbMHTpv4H+IGj3w/FQIA

--------------Xi0yn39XyeP9a3fDOVHMFGDT--
