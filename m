Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7176C68BF
	for <lists+linux-pci@lfdr.de>; Thu, 23 Mar 2023 13:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbjCWMqa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Mar 2023 08:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjCWMq2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Mar 2023 08:46:28 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BB7F5;
        Thu, 23 Mar 2023 05:46:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=duG/owgGNxIOxFJudXb2cDivNE+Zy1Opd88HQtbsq+oPtJOkTA605rXHJHJkyUG6zA4pUvdmoimsBGiZSaDeVsn0gw5eMoly8LDi/HxBFsB/gk2yaw7V6OUHBKAPgIl/fil+ZhRN7h5iDYUaq1V9KvJKzrRBvlGmsKz0OtmVT7mUxoUlbN5SBbTQkC8OB4irJiw2eI/QD2vu4F9P2faq5P/7AH8k3GACi5/WEjdX2AP8cnl9sBfQdbYEap1euomHV260Ns+zf4LqU1+nggC3NPSyxuo0MbFzl6g9aCE8ps1Jg2Q5CVeff4uuMX6PSXolo4mFN1qD/wg/8OTYBq4O9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ho1nCqgIoFEc0E9Gj7pPoJbjoHoacPyuwgKTbAo/u44=;
 b=jRsuyRKWXMy4EJZgqOw76Yd0+Yw/xE8uYIT0VjPhRqqlH4zPikOCIRChX98p3vzWPE9uXMyQWZGb+0Zy2AVuOREaTTBL8XpnC3Ny9jg7NUgA/hxzclBIj/mDsSmhiSsfPWC3jdS6lzUBWaPTqEYQRGUQR6U1hz4uE0nkeA8wD29KrJHOTHkFzjHO0RRd7bzZsSWg5wrrxGOh6ZQEc1UAZLEHn0IHiDx52doHLtLQjBTMLm11fBxfPIsGITgn/xAkZxuA43lek9/GiMtRQwn+EtfZQgRCZ1QW/fcjhCJMgqpejyCRAqNqWDf39I5mix2Q4TDBCm1b7wNWCKFbWTP7oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ho1nCqgIoFEc0E9Gj7pPoJbjoHoacPyuwgKTbAo/u44=;
 b=jbdrNCtIgr15EU9DQR9us0osCBba9AHrf8I9z8+8oKz7PQ3RvSfM5R4yIMIHe6Sbtz65xqnZRlRgC1UCpBdP5zX/oj1jrrzmK2MuHQE/nCEUF9Us8eWlTwQTmyxZ55gmRiM9qWmSICVNkBrbeuSjtP8HLZnj9PUdsF9SaRAbaCtBPkuLzTNTzLfrOSA8aePVCkScFLcubWBfUK8ekkzpswI67dNATCUdunwwBo3y/cF6X5+XSmprPoOpIepdyZU1anJp9y2GDy9ptcMtVYLWDyOfGt1IGDuQZvBK4IRtvAdexqW+6m9mHCg7zF5o1zDxC7pgH7CxDmvYFKd/9dIwiw==
Received: from CY8PR11CA0009.namprd11.prod.outlook.com (2603:10b6:930:48::13)
 by MW6PR12MB9017.namprd12.prod.outlook.com (2603:10b6:303:23b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 12:46:24 +0000
Received: from CY4PEPF0000C97B.namprd02.prod.outlook.com
 (2603:10b6:930:48:cafe::73) by CY8PR11CA0009.outlook.office365.com
 (2603:10b6:930:48::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 12:46:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000C97B.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Thu, 23 Mar 2023 12:46:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 23 Mar 2023
 05:46:12 -0700
Received: from [10.41.21.79] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 23 Mar
 2023 05:46:06 -0700
Message-ID: <d4b04bac-52e8-2780-cd83-e0a3d56c3c8d@nvidia.com>
Date:   Thu, 23 Mar 2023 18:16:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [Patch v3 10/11] memory: tegra: handle no BWMGR MRQ support in
 BPMP
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <treding@nvidia.com>, <dmitry.osipenko@collabora.com>,
        <viresh.kumar@linaro.org>, <rafael@kernel.org>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <lpieralisi@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <mmaddireddy@nvidia.com>, <kw@linux.com>, <bhelgaas@google.com>,
        <vidyas@nvidia.com>, <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>,
        <ishah@nvidia.com>, <bbasu@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>
References: <20230320182441.11904-1-sumitg@nvidia.com>
 <20230320182441.11904-11-sumitg@nvidia.com>
 <dd6257a9-1a12-23f9-e770-0809aaa7ed0e@linaro.org> <ZBwiFEJ1bTMy6yTf@orome>
 <65352fe3-6fb8-cb84-37b8-c9f59e26d3f9@linaro.org> <ZBwjvy9KXWE02I1X@orome>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <ZBwjvy9KXWE02I1X@orome>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97B:EE_|MW6PR12MB9017:EE_
X-MS-Office365-Filtering-Correlation-Id: 9799b385-5340-412c-8a6e-08db2b9c9c52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pTNVxIo0gqyCf/6c8lnWap70La0ZCGjFowVb7wqmR9IwEDzNoYsPArDrt/OtS51X1vPQZy1Bq4WkuL0fsdURThBlEb37s+pzk4Jpg0qpI2li8I148C9KRPJTm2L5yL1/2mJdmpRXZ/ANHNJXwbw77F1GcZRVgi76qYVV8nEzVYEMQFpBnxV4R5/YrnyNjZxtSF5q+BxsYFVMpNN2co430cG95rRYvDPognYHX7R0xN65CIOGqtwbL9yGwPk3V0IBxQycE2EODnzC+VDTLiua8fKSuxMnDjL0cXmBHDh6jmxo9gPfCMkXKLC8sZ9bjWQL2aYL6lUnEAuWbQTSiK2Kra62jxDjiu3ijvFS/KwltFHTc8R3KO4ez5pDTbYemZVk0LqRruXM0O2pa3L4kmZS4l6zqPIuUX+187C3WTGRW69V1yfY3PV1QhWVKq371NMraXIcCCjktGIuX7ZNkpmtfvChi9xE63oCdejwAXjd3pwGucARELGeUn2b0XLP0aj59WwEnpfwWjPvscpz4q5GApKVcHOPnqKHACfxFKzJp06NU9NiLuOW1szA83cB+1by11c/PhbXDtPpIZGlCi0zv90VJrR7lebL68652IU7Zolh8LDNyjCQeECd3UmrEhgJvRFIBToaWw7W3osnWJiUH2q7xPjiouWlf/vDcAFz+aQWFViO2wj/SIW4ZNoBNu/wKsTqSC4yZAN/z/8NHk3IfEniE4wuEKQyuun487q+w+UeH9NmKU4AWthboDCtHkooIPSQgSJ7LCR0g52HN7INg4LFULXpUC+2RjJnLV6cHhg=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(396003)(39860400002)(376002)(451199018)(36840700001)(46966006)(40470700004)(31686004)(36756003)(7416002)(26005)(6666004)(53546011)(107886003)(83380400001)(2906002)(47076005)(426003)(40460700003)(31696002)(86362001)(356005)(36860700001)(82310400005)(16576012)(41300700001)(316002)(110136005)(54906003)(4326008)(70206006)(70586007)(8676002)(16526019)(2616005)(336012)(186003)(40480700001)(82740400003)(7636003)(478600001)(5660300002)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 12:46:23.9042
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9799b385-5340-412c-8a6e-08db2b9c9c52
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C97B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9017
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 23/03/23 15:32, Thierry Reding wrote:
> On Thu, Mar 23, 2023 at 10:58:18AM +0100, Krzysztof Kozlowski wrote:
>> On 23/03/2023 10:55, Thierry Reding wrote:
>>> On Wed, Mar 22, 2023 at 06:50:23PM +0100, Krzysztof Kozlowski wrote:
>>>> On 20/03/2023 19:24, Sumit Gupta wrote:
>>>>> If BPMP-FW doesn't support 'MRQ_BWMGR_INT', then the MC Client driver
>>>>> probe fails with 'EPROBE_DEFER' which it receives on calling the func
>>>>> 'devm_of_icc_get()'. Fix this by initializing the ICC even if the MRQ
>>>>> is missing and return 'EINVAL' from 'icc_set_bw()' instead of passing
>>>>> the request to BPMP-FW later when the BW request is made by client.
>>>>>
>>>>> Fixes: ("memory: tegra: add interconnect support for DRAM scaling in Tegra234")
>>>>
>>>> That's not correct tag.
>>>>
>>>> Anyway, send fixes separately.
>>>
>>> I think this was a bit confusing. This fixes an issue that was
>>> introduced in a patch earlier in this series, so it's probably better to
>>> squash it into that patch rather than have a separate fix patch in the
>>> same series.
>>>
>>
>> Yeah, it is quite confusing to send buggy code and immediately fix it...
>> Introducing known bugs is actually non-bisectable and harming.
> 
> I don't think this was done purposefully but rather as a way of more
> clearly showing what was changed. This is also an issue that can only
> happen on certain boards, so it's easy to miss.
> 
> But yeah, this is bad for bisectibility.
> 
> Sumit, please merge this into the patch that you reference in the Fixes:
> tag along with the fix in patch 11.
> 
> Thierry

Sure, I will merge this change in parent patch and send v4.

Thanks,
Sumit
