Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8D47D870B
	for <lists+linux-pci@lfdr.de>; Thu, 26 Oct 2023 18:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjJZQwr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Oct 2023 12:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjJZQwq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Oct 2023 12:52:46 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2047.outbound.protection.outlook.com [40.107.6.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA85D187;
        Thu, 26 Oct 2023 09:52:43 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=EMURaodG8TIP5xt3zgtcq2y+xtz61hpJIVhfsSzXUbnZ5RWjC0w20P5c2YSDOGG/qurGXAks3x0U9QPt3B4bH09djE/biXkkEPetopAyYTLnfWq0vbkfgy6y6TrEH60eYcUW4mf0moiR4ZJUUR0+NvwP+8UDb/RDjDxbMypfjvcXfwxlqJjne8NvNdS/tahCtoa1ZPuM1InS05zv2ZvVKLpdQ6aAbMSuBAkRzQ61ATwBSe92SH8CA4j6LE7i7wD0QYnUF8n1Ar9gKjq6SyePZY348i2umBPZox/g/uRD0l/KIyddBAtQOeT8EixALAy8Ds5uJuPT49PXXVLpUPaYkw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOwv4sv50j5Hgjt8vw9pbb+/URwkgpeNnV4GthI7stA=;
 b=imfGFbl9zKBACmlD0Oatj4gzlyusFmgXjSpNB+Vu2a6P17EdwCQnsUKNG63QwaUz+KVEXvflw4YOMIhCMNxJ9xmsEXPqQs4rarw2k2ch/i6VdFKlzo6uFBkoiBtNGxqxYeuVqzaOMcHTYxnd0ooXJuzxyvH/MIpgTTOdAg6xie6hdvV2kcekofRL/MKGmHAl2JTwZTuo2YC2Oe7VcYWNzHNRVwznEnvzuAiZZG/uzP67rHogeFV9pncjF0tSRJ1gq1KKD3/VaxxkkTaPwLhsYJlsq/h7D4t6/SzAgilUtrIBrAzv1KDxlvGv3zbPN/pt05bLx2hvj+31hV9VDX6imA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOwv4sv50j5Hgjt8vw9pbb+/URwkgpeNnV4GthI7stA=;
 b=oyI1TOC78PcWkAKddyuwXHS/hwPOcB9LZycON0M1CQmVCCeAU5E8zUShTWjC5kmLaE5GwJnUrDbYsYV2I3+WSzTS4MDQxRYtvtPIfFaeygVncCTPj/mGMKywBJELCk88Sk4aCFCodcz0t/qxhx8Vzc6FWEaNmyAZmWI8kcUKjC0=
Received: from AS9PR06CA0461.eurprd06.prod.outlook.com (2603:10a6:20b:49a::12)
 by PAXPR08MB7492.eurprd08.prod.outlook.com (2603:10a6:102:2b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 16:52:40 +0000
Received: from AMS0EPF0000019E.eurprd05.prod.outlook.com
 (2603:10a6:20b:49a:cafe::23) by AS9PR06CA0461.outlook.office365.com
 (2603:10a6:20b:49a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.34 via Frontend
 Transport; Thu, 26 Oct 2023 16:52:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS0EPF0000019E.mail.protection.outlook.com (10.167.16.250) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 16:52:39 +0000
Received: ("Tessian outbound 7671e7ddc218:v228"); Thu, 26 Oct 2023 16:52:38 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 96b21924e1c907d4
X-CR-MTA-TID: 64aa7808
Received: from cff91a715612.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 9C90C98F-D5B3-40D2-A4AE-906ACE17A83E.1;
        Thu, 26 Oct 2023 16:52:32 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id cff91a715612.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 26 Oct 2023 16:52:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mIfx4Teix/eamyDY6Fiz1kr1pTVoKi9A0vt3mLLjy1l3qxDY+0/RxckqhGRPLaKUUXjBq0wSuZu+W09XQdKcFU0qGpncDrr5B5PobvT1I1qXvQgS1QNFrTxB89OrirZqUCWszinD0lG91BOUchM2w77En+aZWx6r4aVDsRfSZvolxjreS/LQsgCuJQQzYEKtrYNAj0CqBSLK9ybG8Rh3jnQClkdeoAl00tJjdkz0OIVJdIqdaeHcAyB+W2ijOZZfTFSsn9tIxntJ0gYmPS6lREGiaXLRCt5MkIWi0gXN3dpnebzm9zgbYe/fREiMHB7WZNsgFA87eRhXB1hOBr47tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOwv4sv50j5Hgjt8vw9pbb+/URwkgpeNnV4GthI7stA=;
 b=nmjQMmCEA+V6pLVRDn88WFOuQjPV7qUWmtWkNTASwC5aqkmttO9B4jzz/LqUDUyOxToGIPvX5v1KfCEZYrpd1ZLBGd2+pRh9PaPLEJo4soFhEA+Iv0uqnMbkKTVATcCRMpRhvXdBkIRsiS7JNixLfy22U8stSArgWZFn6eRPVXqupjoMuEnorYXDvkOJf5v7cW7BdN/ZYbRc1SYmnV8SO6YieFsuLCeA4ozDurBIz7+893M6cH7LV8BG9QX9dxF2nFEn9D0asABHdfW60Gi0RnQQneJZQLNVPd6j9vKXEanunC4zn3m00ODuofJMqn8mNaG3jhCP7e7CG4EmlqGDFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOwv4sv50j5Hgjt8vw9pbb+/URwkgpeNnV4GthI7stA=;
 b=oyI1TOC78PcWkAKddyuwXHS/hwPOcB9LZycON0M1CQmVCCeAU5E8zUShTWjC5kmLaE5GwJnUrDbYsYV2I3+WSzTS4MDQxRYtvtPIfFaeygVncCTPj/mGMKywBJELCk88Sk4aCFCodcz0t/qxhx8Vzc6FWEaNmyAZmWI8kcUKjC0=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB6650.eurprd08.prod.outlook.com (2603:10a6:10:26d::23)
 by DB4PR08MB8104.eurprd08.prod.outlook.com (2603:10a6:10:384::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Thu, 26 Oct
 2023 16:52:28 +0000
Received: from DB9PR08MB6650.eurprd08.prod.outlook.com
 ([fe80::4b11:196a:114e:55ff]) by DB9PR08MB6650.eurprd08.prod.outlook.com
 ([fe80::4b11:196a:114e:55ff%4]) with mapi id 15.20.6933.022; Thu, 26 Oct 2023
 16:52:27 +0000
Message-ID: <8f8a2e42-f6ed-4328-9457-5f986d761224@arm.com>
Date:   Thu, 26 Oct 2023 17:52:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/4] drivers/perf: add DesignWare PCIe PMU driver
Content-Language: en-GB
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     Will Deacon <will@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        Yicong Yang <yangyicong@huawei.com>,
        chengyou@linux.alibaba.com, kaishen@linux.alibaba.com,
        baolin.wang@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        rdunlap@infradead.org, mark.rutland@arm.com,
        zhuo.song@linux.alibaba.com, renyu.zj@linux.alibaba.com
References: <20231020134230.53342-1-xueshuai@linux.alibaba.com>
 <20231020134230.53342-4-xueshuai@linux.alibaba.com>
 <20231023123202.GA3515@willie-the-truck>
 <cf72afb6-44c7-45f0-bfaa-6881f6782ebf@arm.com>
 <5b695595-d243-4ea5-97bb-f4c74398fc27@linux.alibaba.com>
 <20231026144428.00005db8@Huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231026144428.00005db8@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0024.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::36) To DB9PR08MB6650.eurprd08.prod.outlook.com
 (2603:10a6:10:26d::23)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR08MB6650:EE_|DB4PR08MB8104:EE_|AMS0EPF0000019E:EE_|PAXPR08MB7492:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d835977-77fd-4ee9-3a38-08dbd643f695
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: aUMWRlZ5sQmQqTrvZQJmUBfRZ+3apZJSvP8RRwqBlJRIlo19Vrr3ppy0Hwp8aj6K14Wib91cVDgdgpIQcEIpFKk5ZJ0YKNU3pYslz0maodx+ezF88B9WibFT8O5R6JtbWOIUGWpzjPgG6oEnm7K5A1KfntgYAONGKVRkULTb1url5zSCPRLrZUpikzc7YZuZTIBJ98yJuLLW5D3VuVroCqBAks9JxgI73u11WNggfeDLWq9c5/uVUpaQtQxMC/lkguhpqJ56zyBorYKP+McyCOlpKOFBWghThIha0XO5ylMPSI3k5UmVBaRZCjBYyLqiudA4hnvGSlmiFVJB5OfSWK9xadB+F9VUrYLgCYu+tlWEDWnYNkcjkLr572M42QGAf5OAUy5gf2HW/TKCZUa0wdjd2+tSB/QHyTbv44eGEFljw/xQQmLUQFljWk+eQ4IGgwnSTBzLACFnwM1sGz+OJjf/Hl7hVa/dQ9IiuXF76CRJgArA409DRJdlEdFoPf0DgPFS++7//OJiZciAWcxKIf2V0HSbMCmeiYwyYDGiA3k9D9qphTwphgTdacehC6U8RB5hVvE7vp2Vsocy71wD9i4JC/Ot4Hd+bYOehe4H2WlLTcf9HiUEwJ3gf1midSf+MmoXr5+ikR0L6rimT3uq6Q==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6650.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(376002)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(2616005)(38100700002)(6512007)(6506007)(53546011)(8936002)(41300700001)(83380400001)(26005)(478600001)(4326008)(6486002)(44832011)(4001150100001)(7416002)(66946007)(66476007)(110136005)(54906003)(316002)(66556008)(8676002)(5660300002)(36756003)(31696002)(86362001)(31686004)(6666004)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8104
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF0000019E.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 04d58bb7-c8bc-4be3-d65c-08dbd643ef31
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QvoVajAucjru+FBp9WnXzWGLyJEwun2LstMbJIooouP6rfSW6HO5wIyK61JNXKQzLblSqtB2iTQb2D0YUxKvjQbc67NuQT9ZLzvqbahvrlebY0ZEKK2RIauykHZc8xTHXm1wtOpWDO3RFDoLxdSyFELH1DRdAaTn7j4FquxeOS6ZPa/NdDm+tJReYKArYuGfPSoYk+FaFkCueQFOrOU1EIBEZPJoF7t/89l8L7nxT/zDCi3+MabVdalWyNYaTH6RzX8wPhdFSuJwnB+7Ci1gOuIR53hSe3IoyMcNDc9+2/lR+3z02j3aUu5dVQFoNmwuN3Fx9HCSLGiOYFX7won5LM4gKuDB82gBa88zlmVytEROvNaj62IWkV/Df1gE/k44CdZufQ52o4CjcM7YRMsbiPmNJSm/6xrawTXGSmqXzy9c1kHEXa18+vX3TEwNoFJUKx0cqmvcH0/Havx1GwQm1NM00M6WOs2KPeBf6/2inQF/52qmb9huWENGrcX2bZgDQMsOMweZbLmtKv2TlTL22b5e8T7H+rMTPh2q2kBMRHxzq/Cvwx5YBtlyTtQU8/UxamPkOtwsr3Yv+ZhrZ4/T9Vfmp1GoptX2ojzwDEfBFTRFX5pouvT4eNcBSz39+pyGTlYF2usdA6wz1yAK1Ku9KmPRvTnZnSSyUIBrkNndKlAIBgV2ZTDE+dNp/Q1dClpQKcfS/L96tvr/P5imcCUOBhJrrT0HleThlOe//myVKE/7PrJZIgD6/vDB8M1YzJqILj7fFkF6mYtnXDu5XXwtAA==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(82310400011)(36840700001)(46966006)(40470700004)(31686004)(40460700003)(26005)(47076005)(2906002)(8676002)(36860700001)(4326008)(44832011)(83380400001)(53546011)(6506007)(36756003)(6512007)(5660300002)(2616005)(6666004)(8936002)(107886003)(6486002)(41300700001)(40480700001)(86362001)(336012)(4001150100001)(110136005)(356005)(31696002)(54906003)(82740400003)(70206006)(478600001)(70586007)(316002)(81166007)(450100002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 16:52:39.0247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d835977-77fd-4ee9-3a38-08dbd643f695
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019E.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7492
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 26/10/2023 2:44 pm, Jonathan Cameron wrote:
> On Tue, 24 Oct 2023 17:29:34 +0800
> Shuai Xue <xueshuai@linux.alibaba.com> wrote:
> 
>> + Will, Jonathan, Bjorn and Yicong for probe and hotplug handing.
>>
>> On 2023/10/24 02:51, Robin Murphy wrote:
>>> On 2023-10-23 13:32, Will Deacon wrote:
>>> [...]
>>>>> +
>>>>> +    /*
>>>>> +     * The Group#1 event measures the amount of data processed in 16-byte
>>>>> +     * units. Simplify the end-user interface by multiplying the counter
>>>>> +     * at the point of read.
>>>>> +     */
>>>>> +    if (event_id >= 0x20 && event_id <= 0x23)
>>>>> +        return (((u64)hi << 32) | lo) << 4;
>>>>> +    else
>>>>> +        return (((u64)hi << 32) | lo);
>>>>
>>>> nit, but I think it would be clearer to do:
>>>>
>>>>      ret = ((u64)hi << 32) | lo;
>>>>
>>>>      /* ... */
>>>>      if (event_id >= 0x20 && event_id <= 0x23)
>>>>          ret <<= 4;
>>>
>>> Nit: "ret *= 16;" since the comment says it's multiplying a value, not moving a bitfield. The compiler already knows the most efficient way to implement constant multiplication.
>>
>> Cool, will use multiplication directly.
>>
>>>    
>>>>
>>>>      return ret;
>>>>   
>>> [...]
>>>>> +static int __init dwc_pcie_pmu_init(void)
>>>>> +{
>>>>> +    int ret;
>>>>> +
>>>>> +    ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
>>>>> +                      "perf/dwc_pcie_pmu:online",
>>>>> +                      dwc_pcie_pmu_online_cpu,
>>>>> +                      dwc_pcie_pmu_offline_cpu);
>>>>> +    if (ret < 0)
>>>>> +        return ret;
>>>>> +
>>>>> +    dwc_pcie_pmu_hp_state = ret;
>>>>> +
>>>>> +    ret = platform_driver_register(&dwc_pcie_pmu_driver);
>>>>> +    if (ret)
>>>>> +        goto platform_driver_register_err;
>>>>> +
>>>>> +    dwc_pcie_pmu_dev = platform_device_register_simple(
>>>>> +                "dwc_pcie_pmu", PLATFORM_DEVID_NONE, NULL, 0);
>>>>> +    if (IS_ERR(dwc_pcie_pmu_dev)) {
>>>>> +        ret = PTR_ERR(dwc_pcie_pmu_dev);
>>>>> +        goto platform_device_register_error;
>>>>> +    }
>>>>
>>>> I'm a bit confused as to why you're having to create a platform device
>>>> for a PCI device -- is this because the main designware driver has already
>>>> bound to it? A comment here explaining why you need to do this would be
>>>> very helpful. In particular, is there any dependency on another driver
>>>> to make sure that e.g. config space accesses work properly? If so, we
>>>> probably need to enforce module load ordering or something like that.
>>>
>>> AFAICS the platform device/driver serve no purpose other than being a hilariously roundabout way to run the for_each_pci_dev() loop in dwc_pcie_pmu_probe() upon module init, and to save explicitly freeing the PMU name/data. Furthermore the devres action for dwc_pcie_pmu_remove_cpuhp_instance() is apparently going for even more style points at module exit by not even relying on the corresponding .remove callback of the tenuous platform driver to undo what its .probe did, but (ab)using the device's devres list to avoid having to keep track of an explicit list of PMU instances at all.
>>
>> You are right.
> 
> Also provides a (potential) parent for the PMU devices which is something
> we were trying to clean up for existing PMUs (which end up in the
> wrong directly in sysfs because they typically don't have parents).

Surely the relevant PCI device would be an even more appropriate parent, 
though, since that's the true topology?

Thanks,
Robin.
