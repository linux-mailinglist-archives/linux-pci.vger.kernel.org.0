Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90326C30D5
	for <lists+linux-pci@lfdr.de>; Tue, 21 Mar 2023 12:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjCULuh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Mar 2023 07:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjCULug (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Mar 2023 07:50:36 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4AC1EBC5;
        Tue, 21 Mar 2023 04:50:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5zZRHjNUjfMsh8vT3j8x7sRsQvcP1OEdYVUCMFoRNrffQFIOzDD2uIT+e15smlS62+tnfREHhl/iYscCFo60SMITVaXNW3e8jWAb57Du0IeAdNeSXejoLE7i/nqBS8pFLii5j7r3FkXnUOwldw5x4pl2X4oFbd3oHi5tvW6XvAGeZMhD872SYOngZ3ZJ54Ls8Esy+QoblnHM8qnizq1c1efYcuqQWJfb+93rS2crLa10sDylP4nF1frjOG2PdZgrypRddUjWgTfXkXK7Sg3NreAc2NR7KMPAK1cmOd5rYeUKcNcv5LUcS7CBdOhhlZ5EuhwYVEF98ejH/2QBJJC6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55vXSENPPS0zRrFzNLPdkwGQNwqYQQ3mo1+0gTSxpf4=;
 b=ndLQbV3ISi1E/I+OX3oWoD3s0iUfx79Ajrjp+Y2Pd0GPOPj+R75wpx9mY6uWQgCGE5gb6VvlFBDQBxnuRp7UOvc4F6byq2yTrqJqRKxx9/+JQqYSx+AqVVmobn2VxSqCcIsGt7BEWNfUbFn1k7g4Oa6z3Q25vKWnHTx50r1WR6YW+9t66ZYz4wuJk6/dzLDHh+Zf3y+6VDB1wSi6lrxp+/yeCNEKG1fYn26iZitlBhYQkz0ra37M5TCh3CLR0V3WVI2JKpTGF02P57AOok+ZiNC+DxKPh2xmFlgpDF8uSR1ihB9h6a6SCVxtje03O8uxAhrkORfhGAvgnJb3KBpcsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55vXSENPPS0zRrFzNLPdkwGQNwqYQQ3mo1+0gTSxpf4=;
 b=X9rAjNIegJdZAWPkDgDyfxfBpNAK31USDgZ37XhLQA+4tj7/xbz4J2BkT+0P/jfOfH0oUqYEz1R7SrhgKGWLydoryKG8KvhIIJuclzeSPESTpVLkSg8PZRNksqowRkTsqhj9lZvueufqeXJeqHxkuR7TvsyIL8YsWNvE8cAQ6hNQNhSTKB84Nk62695NqtktCtzMP726OfzjnLLewN7dAuqRiGzCKyrASCGV3tcMoe/+sbkB1tFVTKmVnOLYkvZVrS3L6vUwNzE0QwkQoBgtE4Lm8WJNvLFmwMrP9enfiBcqmBg0uBgbNvng9mhmSW/cfxMbNxHI/f98uj1YKqAYIg==
Received: from MW4PR04CA0145.namprd04.prod.outlook.com (2603:10b6:303:84::30)
 by MN2PR12MB4160.namprd12.prod.outlook.com (2603:10b6:208:19a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 11:50:08 +0000
Received: from CO1NAM11FT077.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::71) by MW4PR04CA0145.outlook.office365.com
 (2603:10b6:303:84::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Tue, 21 Mar 2023 11:50:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT077.mail.protection.outlook.com (10.13.175.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.16 via Frontend Transport; Tue, 21 Mar 2023 11:50:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 21 Mar 2023
 04:49:59 -0700
Received: from [10.41.21.79] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 21 Mar
 2023 04:49:53 -0700
Message-ID: <dcf8b1a9-d0e3-510f-8dc3-5ef9eebb0696@nvidia.com>
Date:   Tue, 21 Mar 2023 17:19:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [Patch v3 07/11] cpufreq: tegra194: add OPP support and set
 bandwidth
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, <treding@nvidia.com>,
        <krzysztof.kozlowski@linaro.org>, <dmitry.osipenko@collabora.com>,
        <viresh.kumar@linaro.org>, <rafael@kernel.org>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <lpieralisi@kernel.org>
CC:     <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <mmaddireddy@nvidia.com>, <kw@linux.com>, <bhelgaas@google.com>,
        <vidyas@nvidia.com>, <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>,
        <ishah@nvidia.com>, <bbasu@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>
References: <20230320182441.11904-8-sumitg@nvidia.com>
 <202303211551.eBLRqnv0-lkp@intel.com>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <202303211551.eBLRqnv0-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT077:EE_|MN2PR12MB4160:EE_
X-MS-Office365-Filtering-Correlation-Id: 78e70ece-dd8b-4060-b32b-08db2a026b1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XT6G8TH/n9iX+XeNWNEh+uH+w7zRZF7OfqA/4sxnV6EWDiGaeVBwwZcO+nzjvze/yqQKzgONMnK1LER+B6+xmWtfQGIIrTRYy+SZtRD9vxRabSqN6a0WJXplRsAQcmcYxy4zs3YCvLjJTDVpKGWfeU/RJ+zDMWxjeuoWy6AUXQhsJazh+G/PRPw1a5AXFlrqe231OGEQ3QaFApEf2lqncyKlp4GI3KaFXH0t2BJpsXbEiJsoqlqJfaJqSgMqNASL21TT+3dNEpjLzQcnLTsqlmOBxZraPAfA20F7Q9vJLoxdAeplJoegBKX750unNg0aDG56VZRxO1+V3Mqplt0vQNvpkZ1yrIAx/1FYG6qiJeYl5Re6dKDRb9myEQSc/YAvFXW1oVSSnELyaTcPgZFfid4BI8EAf7M4cccutvshP05JL/ZtCXaJF7QNHCAC5YH32lfPEyKCwsXOQcGBrKYttpA4FTU3vZYDYTN1nrLKYDScPEiDHLegM5a5HUcLOVgI4SLD7fSgvTr+2q6g1tWT33aJ7qqWfROLwytpWmnF9JigxyVrM9QSTZ7gFAjMw9+EPjKDHyLi6NzkwHr8DUD5j7lFgz4MgUdY78m2fJeQZftPHTliIJ6chOF5qQVJWMUYrMX3T7cYbhDtDD6G27rlN24oJx5X4oFdaHadbECH+sDYD6EOiB3uHNGLuBl/NAVb8zz1T777zEAYEd8djEYDS0RXQSg/rPDNBNI3Am53dO0GDWqB9051P2MM98d99SuAnU4kwusFUDZcAV5NRxx+QtFKfbYK0KHSLnVVydo9TngGjI6aSw7YooaUgsUGoGYUOOQvEJdB/E3IQAzouM2smELJDtsoV8vuHTP8ymyjNyk=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199018)(40470700004)(46966006)(36840700001)(82740400003)(7636003)(82310400005)(86362001)(40460700003)(31696002)(40480700001)(36756003)(356005)(70586007)(70206006)(8936002)(16526019)(107886003)(8676002)(4326008)(41300700001)(6666004)(53546011)(26005)(966005)(186003)(478600001)(31686004)(16576012)(110136005)(316002)(54906003)(83380400001)(2616005)(2906002)(7416002)(5660300002)(47076005)(426003)(36860700001)(336012)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 11:50:07.7307
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e70ece-dd8b-4060-b32b-08db2a026b1c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT077.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4160
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 21/03/23 13:06, kernel test robot wrote:
> External email: Use caution opening links or attachments
> 
> 
> Hi Sumit,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on robh/for-next]
> [also build test WARNING on krzk-mem-ctrl/for-next pci/next pci/for-linus]
> [cannot apply to tegra/for-next rafael-pm/linux-next linus/master v6.3-rc3 next-20230321]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Sumit-Gupta/firmware-tegra-add-function-to-get-BPMP-data/20230321-024112
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
> patch link:    https://lore.kernel.org/r/20230320182441.11904-8-sumitg%40nvidia.com
> patch subject: [Patch v3 07/11] cpufreq: tegra194: add OPP support and set bandwidth
> config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20230321/202303211551.eBLRqnv0-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://github.com/intel-lab-lkp/linux/commit/fa31f117302fc7c15b5d9deeefb8c650554f503d
>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>          git fetch --no-tags linux-review Sumit-Gupta/firmware-tegra-add-function-to-get-BPMP-data/20230321-024112
>          git checkout fa31f117302fc7c15b5d9deeefb8c650554f503d
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/cpufreq/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202303211551.eBLRqnv0-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>>> drivers/cpufreq/tegra194-cpufreq.c:397:5: warning: no previous prototype for 'tegra_cpufreq_init_cpufreq_table' [-Wmissing-prototypes]
>       397 | int tegra_cpufreq_init_cpufreq_table(struct cpufreq_policy *policy,
>           |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 

Thank you for the report.

Adding static to the function prototype fixes the warning.
Can we please squash the below change (or) please let me know if i need 
to re-send the patch.

  +++ b/drivers/cpufreq/tegra194-cpufreq.c
  @@ -394,7 +394,7 @@ static unsigned int tegra194_get_speed(u32 cpu)
          return rate;
   }

  -int tegra_cpufreq_init_cpufreq_table(struct cpufreq_policy *policy,
  +static int tegra_cpufreq_init_cpufreq_table(
                             struct cpufreq_policy *policy,
                             struct cpufreq_frequency_table *bpmp_lut,
                             struct cpufreq_frequency_table **opp_table)

Thank you,
Sumit Gupta
