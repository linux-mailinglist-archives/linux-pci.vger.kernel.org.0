Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A956E6C68D7
	for <lists+linux-pci@lfdr.de>; Thu, 23 Mar 2023 13:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbjCWMu7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Mar 2023 08:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbjCWMu5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Mar 2023 08:50:57 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4012E26C36;
        Thu, 23 Mar 2023 05:50:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXW8Yg7X0Gcr12xUIz4+SK7LPDzzH9omhdaxUu8g3vPAB4LSfbN2oC441ao0ImdHNRPLMpQqvOSla7xSOw5WKp1T6zl3YliHZozuLtYpUzHKxDBwbej8M414oXUfXDZo/C715wKDEwvYeHP7mTnU0LCYn6hacsZIJ2v74FD2W6lvUWjKvXZdJylI0N0QsboL0lrGvqMZNB09zhiFyOj+uz8lK/rz5aU/AReQlUeSJAE7ZX0BDeOaVib0icPHM4OnwT+33RN0kcqjSrRfvQA5k9eAgxnKNwXpAvuiaQqCR2Yt6fSJE72NL4Hwv9AUAANer8Dnhkl+8g+OY8ieSBOhXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DxY/plbPjFN9UNy2Q0QIl23W9JdAqjVnWMxO95S6bY=;
 b=PMIZ2z1yf3A4gNK39qyL7UQal+b5UW9fFF0fCMHrhQ2Wd0iOMmnapiQpIB+bFwuLRmA/8P4Ev/qSs6kG6EbTDShJVXEFfj8gKoaaSyqB+xF8YtMPJwH/VqsXz0egbr4Hb9aZckO8w/ySxNQI40HR4bQEJYMr6rVT3QcSQQ923TzB4nu2VdpTcY3AweEFM5GGNBZGdRaU+s+fz8VduZX4jYPG3J4lHESThlDC43Jdjf8ZQ5zCLEbtoAdOr6KEhZBsO4EvkkyslHoqROnCkn/HLauMlOdlmxbfLI91GuCs/3NLYO9wrzo9gWd4lM5FTKIqcfVq8V5Uvi/Rlxn1z8zs/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DxY/plbPjFN9UNy2Q0QIl23W9JdAqjVnWMxO95S6bY=;
 b=suzs4OvscKaatTvD6F/tSLpgmGOfnIqg+8wAcS2fBEypsmAErSXmOhawmL1mlXjvMfGJ4qYMgHrIN3hPgJAHTUoK2aZGPhZ3bvXyWZQAxYXAoS7PQ20tKarAd0ZlxOs1VgNTDyC/ZZsKkkpxMAyStkfNn4UiIyXGwUJAkeM1KJ5M4TImun3NGsOLkkyXZ4cw8JJeIOQlPjUwe15p42qOersfvrTA5y8zVDYmLNQ/qR9ASmuuWICOtcLDjZD5jHgVAhPgLLHavsGDPVTd9p7YU9HKdwSwpOY77IiAC6UjilXjNXw8ixwUhr+I4tBYExBp4PxZ/yeSV51+DeDmHlsIRA==
Received: from CY5PR14CA0008.namprd14.prod.outlook.com (2603:10b6:930:2::15)
 by BL1PR12MB5364.namprd12.prod.outlook.com (2603:10b6:208:314::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 12:50:53 +0000
Received: from CY4PEPF0000C97A.namprd02.prod.outlook.com
 (2603:10b6:930:2:cafe::9e) by CY5PR14CA0008.outlook.office365.com
 (2603:10b6:930:2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 12:50:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000C97A.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Thu, 23 Mar 2023 12:50:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 23 Mar 2023
 05:50:39 -0700
Received: from [10.41.21.79] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 23 Mar
 2023 05:50:29 -0700
Message-ID: <3b1a1a8b-8113-6a80-1441-fb197fd992f0@nvidia.com>
Date:   Thu, 23 Mar 2023 18:20:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [Patch v3 07/11] cpufreq: tegra194: add OPP support and set
 bandwidth
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        kernel test robot <lkp@intel.com>, <treding@nvidia.com>,
        <dmitry.osipenko@collabora.com>, <viresh.kumar@linaro.org>,
        <rafael@kernel.org>, <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
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
 <dcf8b1a9-d0e3-510f-8dc3-5ef9eebb0696@nvidia.com>
 <5e0bb728-1cdd-6c16-b096-eb0934effe94@linaro.org>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <5e0bb728-1cdd-6c16-b096-eb0934effe94@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97A:EE_|BL1PR12MB5364:EE_
X-MS-Office365-Filtering-Correlation-Id: 0013c3f6-84eb-4334-4d7f-08db2b9d3c5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cm0h+iofzQ7qkL89LZYQegCZyfQnk3VdeGLS4eSnochqEQCuh8B/KZ5Q7YvZYP+XC/nTwcKQ37mKVdqQ76lBcH8rXMb4Hmmm3Oef6/0944tgNgXigM/yxX96eZle3dKKEby/TkAQh3cgDv7nzKCaXwJs9yIqd3n7uUG63oHaL2zaV68GEMNThYUIumBMslpslF6qOTwNum9cTB7MF7eE9GYdXutT82/nImGLJkU2z9Bi4stmWtuhyRMU/sivziWGvHHmYoC8T+QRazRhG6XzpE/B3s8LgknS0iiNxH19cvxlaElNybkesT27/dnqhsNIKvhUkS0Vhfo3gkDRjZlQQ4LGyATVFL2XVEmL0EKvw2oSQwTqbDxvKpHrXWLsQkAE7Caqy6w4Dt8b1PXa6M+6PTE7Kr/hoSt2bJyXXjXs76Nfwu7MRd3ub6o5SV/nGa/rkTSKKTS5E9zf8e7My3LmftywGGWXDrovq18JgkckGwCC3+9w+pnRX1J/gih6DxdVQ30z4aw0LloYFcdtrdcOHcovkEInxpcfirR4SQ6uloTgiwRyhV5K6iaX2CKhvlW1t0FDQhZXyF0aUntmDXssLFR0IVQ7fN23AYALz9X0CyAbhkhcDjIChTXcfLcTePSKDDdygEz0R1jrcU62bAlqtviTAUCUEvS+MBNbfutGbDGCgNNmzu9hxvVtF6AbV/FZU7VyAQK9i7TSJcA0TwWipZiVN1F2stHI0hvARQnG5UlvXb6iV3AaOXsrC6HCqVjn/i7jYpRMsHEdCKi4w83dT2CaeFqR6mscFi2fJ2GIg9eMK4yNkNhSPp6oRfDFNKajfVTDroezkaMgFXFXUrL95tEaV63bcf6gT9yP3vcMOVc=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(346002)(396003)(136003)(451199018)(46966006)(40470700004)(36840700001)(31686004)(356005)(40480700001)(2906002)(40460700003)(83380400001)(478600001)(966005)(2616005)(336012)(186003)(16526019)(86362001)(31696002)(82310400005)(36756003)(316002)(16576012)(110136005)(54906003)(70206006)(8676002)(36860700001)(4326008)(70586007)(8936002)(426003)(47076005)(107886003)(6666004)(53546011)(26005)(7636003)(5660300002)(7416002)(41300700001)(82740400003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 12:50:52.3905
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0013c3f6-84eb-4334-4d7f-08db2b9d3c5a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C97A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5364
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 22/03/23 23:21, Krzysztof Kozlowski wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 21/03/2023 12:49, Sumit Gupta wrote:
>>
>>
>> On 21/03/23 13:06, kernel test robot wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> Hi Sumit,
>>>
>>> Thank you for the patch! Perhaps something to improve:
>>>
>>> [auto build test WARNING on robh/for-next]
>>> [also build test WARNING on krzk-mem-ctrl/for-next pci/next pci/for-linus]
>>> [cannot apply to tegra/for-next rafael-pm/linux-next linus/master v6.3-rc3 next-20230321]
>>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>>> And when submitting patch, we suggest to use '--base' as documented in
>>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>>
>>> url:    https://github.com/intel-lab-lkp/linux/commits/Sumit-Gupta/firmware-tegra-add-function-to-get-BPMP-data/20230321-024112
>>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
>>> patch link:    https://lore.kernel.org/r/20230320182441.11904-8-sumitg%40nvidia.com
>>> patch subject: [Patch v3 07/11] cpufreq: tegra194: add OPP support and set bandwidth
>>> config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20230321/202303211551.eBLRqnv0-lkp@intel.com/config)
>>> compiler: aarch64-linux-gcc (GCC) 12.1.0
>>> reproduce (this is a W=1 build):
>>>           wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>           chmod +x ~/bin/make.cross
>>>           # https://github.com/intel-lab-lkp/linux/commit/fa31f117302fc7c15b5d9deeefb8c650554f503d
>>>           git remote add linux-review https://github.com/intel-lab-lkp/linux
>>>           git fetch --no-tags linux-review Sumit-Gupta/firmware-tegra-add-function-to-get-BPMP-data/20230321-024112
>>>           git checkout fa31f117302fc7c15b5d9deeefb8c650554f503d
>>>           # save the config file
>>>           mkdir build_dir && cp config build_dir/.config
>>>           COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
>>>           COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/cpufreq/
>>>
>>> If you fix the issue, kindly add following tag where applicable
>>> | Reported-by: kernel test robot <lkp@intel.com>
>>> | Link: https://lore.kernel.org/oe-kbuild-all/202303211551.eBLRqnv0-lkp@intel.com/
>>>
>>> All warnings (new ones prefixed by >>):
>>>
>>>>> drivers/cpufreq/tegra194-cpufreq.c:397:5: warning: no previous prototype for 'tegra_cpufreq_init_cpufreq_table' [-Wmissing-prototypes]
>>>        397 | int tegra_cpufreq_init_cpufreq_table(struct cpufreq_policy *policy,
>>>            |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>
>> Thank you for the report.
>>
>> Adding static to the function prototype fixes the warning.
>> Can we please squash the below change (or) please let me know if i need
>> to re-send the patch.
> 
> You must send new version which does not have warnings. The best if you
> also build test your code before sending (it's kind of obvious except
> that it is not).
> 
> Best regards,
> Krzysztof
> 

Sorry, missed checking with "W=1". Will take care in v4.

Thanks,
Sumit

