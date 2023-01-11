Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D997665E26
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jan 2023 15:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbjAKOkt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Jan 2023 09:40:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235053AbjAKOkS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2023 09:40:18 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061c.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::61c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E7D1E3D8
        for <linux-pci@vger.kernel.org>; Wed, 11 Jan 2023 06:36:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XtwDA49/8JIZjkH9tfGhIDtKf2FXcKCMscnPlPc5a5HjwAanR3VYXDWNqinrSylsQgzxVypejnWU4fteVh2VYYGiqaZf9D4s9oJEdJJ8vwOmJO5NgIGdYWMHI3HTmwXNpyw+SAmD6xtWGvMX1NyolmDGgYhsgYx5TG36ffN3PHV5MLFDUcEfCsLN9mexuWlfyN5TlvjZs7+OoMCt24Yz87lGv04FukvUZew2BVzgzDAxd4q4Xh93aYhKvoHxorC+Vxc5GBLvkoMI9KyFkULzkfTOW5up2Ha1Q20jm6PTmUp0MW+k8Z6ZnuaG1dWW2GfbD8O3ceNlSajl+YqyhxK5vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MH32gXp6Gu1ejcPqr88SxOMxW3EjtGlW1MOa+0AeyuA=;
 b=eqzY6W3NhbJs3xK6LXr9lRWvPlhEfFDMrKNRH9ZPdIcuf0ClFbym4ZNuOuelEWHNHvKjDNMIghFtrpIau/2ZyRchq7297ci/PN6tplj0xW4Tki6Qnl67xGmW2rghIqyS134Vc6dAP6Y+rbLMeWvm+DcAv+D1JbtcEYhJfwtUrsIK+Ho6Sn5gCz4me7BoOgb5LjIzrh7g0SVolSlzByrOXn3OrUnPFLCYl+FiDeiqZd20FPLknCLeaTrUbgmKq290s1DDwORZVvSgFJZWbd0siSszGvAU4ZVaCYGATjFpbYgOwJFcfKeYjWjOkq49fwGDo7aKUWrG7uZv2xx+rNkEcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MH32gXp6Gu1ejcPqr88SxOMxW3EjtGlW1MOa+0AeyuA=;
 b=CT88MVXF5b9/ERkIMoH/taIOYFd1ApZjgL8PkaasAGN49/iPSLdPukSfs+X3e+ShnvoiaWMuNEbTBEnpFBRAde2Zxatm1uPCEvDqbqSa8Bg/sSB3oVUdTkPa2YKh3dt1NKuTkPW1o02H1+pLdiu+fb22H4J9s8YTsBpfto4UOkc5YJQhWfv9uD7uOJRsv9nAatS/A+pL2sRg18BbAT2rhBNZ9iRtDpL8LPIj7JWQ/xtbLL3gh3BMvRjXjfzUf3MoJhTd6wxUZ/+FjGz9x75dBhWXQh1UDf1WylWTJY5ttqA+KCI3eg6RmZZXxWLu0ZgdCjK8OufUfNDe04tltwxZng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW4PR12MB7000.namprd12.prod.outlook.com (2603:10b6:303:20a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 11 Jan
 2023 14:36:39 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.6002.013; Wed, 11 Jan 2023
 14:36:39 +0000
Date:   Wed, 11 Jan 2023 10:36:37 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc:     Christian =?utf-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>,
        linux-pci@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Tony Zhu <tony.zhu@intel.com>, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] PCI: revert "Enable PASID only when ACS RR & UF enabled
 on upstream path"
Message-ID: <Y77JdR5LgjFnP7FI@nvidia.com>
References: <20230111085745.401710-1-christian.koenig@amd.com>
 <Y760hRDQbXRlc2Yz@nvidia.com>
 <0da0f213-5d6a-c692-b9f7-9babb40adc96@amd.com>
 <Y769WqrbEUPQ3pt7@nvidia.com>
 <41e25f9f-b106-de77-97ab-d50196de7514@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41e25f9f-b106-de77-97ab-d50196de7514@amd.com>
X-ClientProxiedBy: MN2PR20CA0054.namprd20.prod.outlook.com
 (2603:10b6:208:235::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW4PR12MB7000:EE_
X-MS-Office365-Filtering-Correlation-Id: d528a57e-d15a-480b-8100-08daf3e13fd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c50cq6EpiMURV4hNpD+7Qt8cu9hlAwuKaY8vf9PPuFnmRvRhHx3TFcuHBfhJ3fu96h374lU9dleYoF2EKYuLnWphZqHubW1dIJM/qkOzVrrUHw9FVtibyy9/Hr64wBOWZbFwTzk2w2yEqJDhAtgN1cwjFgRyK8KjvLPT+fBbVBI3mi8+9stJLFFar5gErQ8oZwgJutA3mNGBEXkSHHaMFIrL5Bxvm5Hz1u73Ccey26z4YxrDFGwWCU+WvSAga+pkQ/O3DFOQEqV+9PZM/b9w6GNxu1Bu6JYqoPC97BjCjzprq+wujPclmXbfmzJfsfw36SLkwE7B14/FJPS5IAkGZ0pr+11lTCFG2kNd0wkFicHWIPhFBTgua9vHR6EhHnjSs/zGYH+Pn+L47c1i8gifmTGTSb2U1x/5TWcJSPdfhtKrqycNk8Ab+s06cnpvhDb7gr88VSN+Z4SFMSxs66ajsSArmRRKm4Gq8pUKNyoO2OgetTIJZp63FVNfz/rBOYCf3lt+BosX5YcuYvNy4zeH5Yw5UkPXFCvgfFxJPhFhQ/u6S+mVGwkzSfvCSKGObABtVZ21Ef0mLKKp437TzMMRiXcfAlAOKR6fCQDASH+Nz/yqR2RN9qhqbW5dr6/U52IyoBvNnWv/LBhhOeLrVspiRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(39860400002)(396003)(376002)(451199015)(66574015)(41300700001)(6506007)(4744005)(8936002)(5660300002)(2906002)(66556008)(66476007)(66946007)(8676002)(6916009)(4326008)(36756003)(38100700002)(2616005)(316002)(54906003)(478600001)(6486002)(86362001)(26005)(186003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnNxcmRXWmVnV2tRK2d2WTV2bkIxQnAyM0I4Njh5bDgxRVo2dTlOMGhwc1hB?=
 =?utf-8?B?NjFJTGF3UXh6TExUb0xxNnJzaXZ1WS85U2svRWJtbDkxTFI3K0xZSzlabmhP?=
 =?utf-8?B?NklZTCtSYlg2V0c0WklOWXdwblU0WW03cHRjUHBxNVBwQ3hNOFh4MlUyUmJX?=
 =?utf-8?B?ZUJtVC9GRHZtZXlCcmtLNWd2UHhiQWtPK0d5U1JQeGlhWFhMWW10QmNPN3py?=
 =?utf-8?B?MklVWXN5ZC9Fb3FyaTFON2xSbWxRWFV0RTlRbVVvZnl2TGZ6eWh5WlJsVGRv?=
 =?utf-8?B?Y2ExR1l5TkFWbDF0bTlORFl4VXo5blVzWlp6ZjZjRGtDenFwODd4cm9GWjBa?=
 =?utf-8?B?eDRGZkl1dEROL3VMSXovMndEY1QvT0Viemd1YkJKaVF6SGxEYzY1ZFRWRUgx?=
 =?utf-8?B?dkRaQ2E1TjZKbXRBd2JVTWhKdzIvT0lsbUg3UDFvN1BvRzVmcXI2ZXN0QUw5?=
 =?utf-8?B?aU9FZTc1Y3pJQXZjVzVScmxvTFVGT3YrTC80STZCTENaMTNnQ1VhOHVxVEtP?=
 =?utf-8?B?Qll2YUc5VU1YZDg5SmZ4N21pa2J5NEpCZUU0Ly81SmZBRXY3eHRGbVl6QlRS?=
 =?utf-8?B?WWM5S3lGZGhoZG5rM3JVUmxTOXZWRnNNREsvYVJsRGRhYjY3aklvakp1ZGxr?=
 =?utf-8?B?TmJMS0ttRnU1cWp6cm5aNEROY3owZ0FVN2dEUmNnU2FYMm40T1JEenFQc0M3?=
 =?utf-8?B?Y3RuL2krSm9LK2NPZHk3RWpmaHFrY25qSWpDVWVBaUkxdWRadjlXcDZTMHA3?=
 =?utf-8?B?Uk9MM3N6MC9qMGFQZExlNnpiMS9pSkNsZUlUbGU0dmFoOHRIQXZMT3JDRFZl?=
 =?utf-8?B?RGdZRzJnNS96eEF6ank5NWpGSW1QbXRlVDhIcUtpSE94QmFYSUdhSy9DZlRT?=
 =?utf-8?B?WHpSTFd2akVUdTh6cEJCc3ordEVMZDVCTkN5bExDVXAyd1hVSGI5VGlud2dL?=
 =?utf-8?B?TENLb1BqZ2c3ZWY5dFV2eVU2Tyt2QVJnaFMrRXlnWnRvL0EwcE45eHBwTER1?=
 =?utf-8?B?eUJPL0dGNG5oU21kbEllL3psU3F6cEY4TXY5NCtOZ0w4eUJLcm5oR2dFbE9S?=
 =?utf-8?B?UlIyU3JyZmhLT3EzSDRMS2dtcDAzWEMyY1phRmZOL3R6ak96NTF3cnNnQ0Fi?=
 =?utf-8?B?ZDBFM2tMZUhBZ0l2L0ZYeWsxUlUyN2EvWjdFeHB6bjlMaEtXWTFiamtFZXA5?=
 =?utf-8?B?SjJoN1F0YzlBeXlwWHBYMlhENDNXa1RjUGhHSnFyaTd2LzRNMFFSdGJPV1M0?=
 =?utf-8?B?aVkzN0ZoeG5reVNkdDlGK3JPWVBwN1IxWTByeEtUdGdVOXZPZXIvVDJBcitw?=
 =?utf-8?B?YUo4MXg4Zm5iZ2NNVWZ0MGdtMVN5bjNxMlZUU29ZTEZNT0VMYXdTb1NnYTVS?=
 =?utf-8?B?ckcxT2VoSmhnRExYR1RLY0U2N0g0STFQQmxNSTg0VkdYdjNnVlZ0UHZSQ003?=
 =?utf-8?B?MHI4NDBKN1BxZ0J2RHN2SDNQaXFVZk5MaFdyTlBGbmgwamtLWVBRZmZyQUxM?=
 =?utf-8?B?TXp1dXdWZHhPMkd1M2FMRnhzcmJuSEFIaWRWc3I3SG9NV2k4ejVrbWYzVFo0?=
 =?utf-8?B?RFpxK2pDMCtqd2Vab0dwaGlrT0NxWXI4NFFudnBmdXloVnFYT0RxZ2NNUGgz?=
 =?utf-8?B?V1dRWWZ4VkNUTWkwdkxtUWpiK3BLY3RPRDV2OXhOSXozQTRjanBOS2t1VzN4?=
 =?utf-8?B?c2QwK2poY0tBT253VTVGNG5qc0xJdlcwcUc3dHM3Ti9TdGUvTmNlUDhVOExq?=
 =?utf-8?B?U2liV1lvYzVJZzBnYTdHZk14RFliOU9oSHhUMFJyWTFiZEdkRHpZVkFXbDhu?=
 =?utf-8?B?OExwUStEM1NhVkFLODErUjdieU9oZlI0T1VUdUFYRE41NkJOcDRjckJ3ZVdo?=
 =?utf-8?B?V0pkMFBoMk5tNS8zL3RnenhsdHBsV1NERzdYdXptMzZTTVczU01JSEpXNVYy?=
 =?utf-8?B?OVNtUXRCZ3pCZGhGcjFDaFNCVDZTZ3lISStUOGlMbXNxUUVHL3BMNlRKNGty?=
 =?utf-8?B?UmtKVjFFSzU5Q3VBZjNPWkFmUE9JSXFOdHM4ZjlrMFdObnhVTnBQNDJXRTVD?=
 =?utf-8?B?NHYvUjFHaXlGdjgxamlybVYzQVQ3dGVncDhLWjAvWVowQjhETytMYWJ0dlBU?=
 =?utf-8?Q?7MLn07rEgDtzB20By47MJEd9K?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d528a57e-d15a-480b-8100-08daf3e13fd0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 14:36:39.1572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RN6MihJlxFQA93ZUu6VOHtICkce0r8UEzSr7xVu8/63xtXOdILhBEldmZDphJ2wW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7000
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 11, 2023 at 03:07:36PM +0100, Christian König wrote:

>    Well no, we can perfectly fine enable this as we have done in the past.
>    What we can't do is rejecting it without driver specific knowledge,
>    because the hardware might still work correctly.

It is an interesting point that any device using PASID for SVA must
necessary also be doing ATS/PRI and thus must always be setting the
translated bit in their Mem TLPs

So, at least at this instant in the kernel we have no need for the ACS
check as everything is SVA.

This is forward looking where we are going to have non SVA uses of
PASIDs and we cannot guarantee translated TLPs.

Keep in mind this is pretty much an integrity problem, eg if I allow
iommufd to assign page tables to a PASID without PRI we can get bad
behaviors if the HW does not route properly.

So we are justified to be conservative here to prevent data corruption
in bad cases.

Jason
