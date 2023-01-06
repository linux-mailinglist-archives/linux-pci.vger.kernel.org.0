Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67D26601DB
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jan 2023 15:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbjAFOO4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Jan 2023 09:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235050AbjAFOOv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Jan 2023 09:14:51 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAC17A904;
        Fri,  6 Jan 2023 06:14:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cdf3ZZ8NZ0EgDL4jGSE9/CMsYXf0Hk1N1JVLaloZfQHYJZazhT7XVQvc2JyTgLz2QDFV6h08wbbKU3D/vDw5ORC57uC5D3J3whvcj5giVwd+EoksiwGMxnQ2CyKFEj34MCaps6rGv0nnsgWgDNvF2JShjpCGFF2VttaixodAY9XuyadJWb69IWHtDEQ1BifewlQ8UkXw3kEsMcOJtFAigCOtiiL1iWQnZc6rq73/5X1UShS7V6ZCRU1+r8tSvlPzC3UGf28iDtbKd6OSeXumZL1/GrC4c3ml6dNxdbq8NisWg9Oc/NCgjHspc0OlgGaxA/JBt7LSDpdeP9GlgUsgfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Us5ISKgFT3EjCiT3xyMAh29/heBtKCsItGahZCzSnc=;
 b=P7uZ7lYBLu1lHIUm9uoDPgxNBdqe2gR9v31MX+M+49YZOR6DrZf/7tAbThVfv3wpFmRjw9KT1TEMdU9Brb6y5ZPxhhzU6qg5wryMlWC/J1wiHiKK9yO7cM3m+eEGOumOAeHhoO8aMF1H1BK3nL7rE6XF/Qe7ljRIDQvevQlXRTALiaQDeb7YJU+v+DPbJN4cCDwK+hgrTcEFWC6OdE5JpuFsTFxO/NWfcfeJDSaE8hSuwle1QPMq1SLtppF8+2IOOZ9Y8Sd7rj0wUKSY6xW0mt3LlqsefNXe0uEFzUtfWN9Evd/En67PtsEoprjikXKs/D+3qCy8JxIbIzX2GeW5sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Us5ISKgFT3EjCiT3xyMAh29/heBtKCsItGahZCzSnc=;
 b=rGp9EqPJ2fDEtwH03wp0xJIrG4eWT/mcpEicm8n7/ccrL8Ck9M7+Ib72wQ9cLEfyIpFq5FreXEHY+hxxX2F/nwck1SVOCHKx7xjU/E/h4qCEHJ8ugk8DRcyLcoKVf/O4r4RKBk91JoPHS0AiiNZcgNBgAG14llMOI9dmHY3P8ynDkM/DCF0ErxQ4ilomtMn9XpPxyOpzoHtYVAD3CEppZSiJ/C7snTNGhPEiD+rw13u7H2kRZl/gGuORSVzMBVhCrZGsxxrPFut82Jgpd8iNbSYxnJJFqhmmKfvOT3VJ+5OJSYcvOadwEZAJ2212odvMMafrFdI/n9V8xvEduQZN0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB5420.namprd12.prod.outlook.com (2603:10b6:510:e8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 14:14:45 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 14:14:44 +0000
Date:   Fri, 6 Jan 2023 10:14:43 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Vasant Hegde <vasant.hegde@amd.com>
Cc:     Matt Fagnani <matt.fagnani@bell.net>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Joerg Roedel <jroedel@suse.de>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [regression, bisected, =?utf-8?Q?pci?=
 =?utf-8?Q?=2Fiommu=5D_Bug=C2=A0216865_-_Black_screen_whe?= =?utf-8?Q?n?=
 amdgpu started during 6.2-rc1 boot with AMD IOMMU enabled
Message-ID: <Y7gs0zYKp/VXACBi@nvidia.com>
References: <15d0f9ff-2a56-b3e9-5b45-e6b23300ae3b@leemhuis.info>
 <5aa0e698-f715-0481-36e5-46505024ebc1@bell.net>
 <aea57c5f-2d20-c589-ad44-a63f1133a3db@linux.intel.com>
 <157c4ca4-370a-5d7e-fe32-c64d934f6979@amd.com>
 <223ee6d6-70ea-1d53-8bc2-2d22201d8dde@bell.net>
 <6fff9d10-f77f-e55a-9020-8a1bd34cf508@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fff9d10-f77f-e55a-9020-8a1bd34cf508@amd.com>
X-ClientProxiedBy: MN2PR17CA0008.namprd17.prod.outlook.com
 (2603:10b6:208:15e::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB5420:EE_
X-MS-Office365-Filtering-Correlation-Id: fcb4ed69-346c-4c6d-1d95-08daeff05bbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R5MlJ4ApRI3XBwKBS55S7MFphbPkeFLAOJHsXLM8qnXu8kBE3fGQd+Eax6GdS5HTSittgt/Mlukjo7QU0iDoiu3ZFONXT4AnarGMR4BexsYtI+jo3Ukbhu5DM1MacMxqpGdSVr5cwuSNqwtDZ3EtO8f/AjrIDOi5YPHUClvsQGW7q5Mvj3De0w9v0vOJ1j89t+94tCh0tzij2EckS4pV7Vlx2I6aQ6soG9S4Cxw5HclRCpFDrT7utcKvqlVtgwqFrjVhFfGPhh0wkaBQPt1kgb8s1+24GNm2WMme7P5XAxRKGuq9AACcf6x5H1qpAED/NgpHdu3nl+AAbNbcRgoMX4Hmc4FCuTo5Ug4RtIFTaynb6nwZJthRrHzbZXp2Z2Fec4qtj2y/QoS42bda4HlSpcc1x/KADLe2mgwSfo3UpHEq3YTJ0R2daOaUdOmXm+0hGqa2zQ5ppHA/JoUI+JLPCmFrNQAAPo5LxJ7q3g6zp9QMjR+3b8Il0gUOCJ1NvIYaIQrRGQqw92YlF0bFHcpmm9l5ppz49QylutaTs18h7uFMlWUGl0VXqao4hXs1YgNAeD3hcGBspf/f2fH02TgsxZBLT8peiuWSGgJXnWC2T2UNILuGXl0N/ULk4AqixS3hCJbP2XR9+9x94yO4SAND1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(451199015)(5660300002)(2906002)(7416002)(8936002)(41300700001)(316002)(478600001)(4326008)(54906003)(66556008)(66476007)(66946007)(6916009)(6486002)(6512007)(26005)(6506007)(83380400001)(186003)(53546011)(38100700002)(2616005)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NrnXR9PmFtTNJYKBqrLNfpAoj1k32AT6bC5FlYrhFiQTIU+DpK80FjsoMxVC?=
 =?us-ascii?Q?BiUvIiBLJ6EB/ivOR7IjrTEZl7jJudpb9sqWto1ERWl7si03SEgpBtujg96y?=
 =?us-ascii?Q?krSgBh1z3DyLd/vulPfjlpmjr1mVBfDNmNC30uzeLIwEK81735tV0MC6xbz6?=
 =?us-ascii?Q?iKOP2jebrFMBcp3wOzDvvbnlqlZnXph0CG5SdWmju3+jHRUGwSe+6E67RKZr?=
 =?us-ascii?Q?LN11ubSNqnU+mfkVMFqGWZgW5lZqZkSyUKNyfvSybGPaTzJ4e6FayQE47mOm?=
 =?us-ascii?Q?5wlwmYsGUqSOJn99PZ0ZpqQVxityzDiOQs0fjxNiapk/koehFBeHXMSlLrbm?=
 =?us-ascii?Q?BRuITp2X31BwR7ZxRoR0PzfQ+ybp92NH2/J684LZljkOzOB6+T9b23o1BncE?=
 =?us-ascii?Q?eq3uPlhJMrXK+02bIl6RCVXHoROwKOKO5AxiwV1zPxPD2wbJUFWXlSmYsk23?=
 =?us-ascii?Q?TuD9m32oFqlQid+79DBNLQNVLkxa4wCAP5XO95EEGvWOBYOpMuG0etP5kPZG?=
 =?us-ascii?Q?NsT/rCnkbuYFRtALGp+644XfBuJb3SqEZJn2JRUey5LYo2YuXr8sqLe6jAtK?=
 =?us-ascii?Q?aCAe0qDR8SY6xwZdkyO/xK64DnpoeKuiB0ylD6Ey2PE/p+kd5ieTiaQpsWE4?=
 =?us-ascii?Q?Qg3qq4F7Up/FlMcG11KC9Ra6/6BL16xuuqnFqn/ycKmK+f5jGPNUpUiNMDbG?=
 =?us-ascii?Q?mOJ6DZEBlcMUsdMzE881jo2zeNc/alsOyQ+NORxInc7tgc7JwRJvW++NM/SO?=
 =?us-ascii?Q?wjnkwdKSjA1Tvt7qYIIg3s5HpaBh1N+yszmtRkn3gI6WzkKhe30iZkmcsK/P?=
 =?us-ascii?Q?OxKQulSYZuiCu9aLkeJwHN4L/8ZDVnmQuNPGbS6dOdUbyKs+hoBnuGpjxYno?=
 =?us-ascii?Q?kBNOcl0W1pw+2ReHCArAAQKicWJuNBTBcJzVQAADBoB17qXMbPkx37PWNK25?=
 =?us-ascii?Q?BXYONZKkFuSvlaHvM+4gDbDVa3lgKehPwk50S2N4Jprd2AAseSFZwVowngc/?=
 =?us-ascii?Q?DytFgZ8azEiWoK6kIGYMbB7gJwTrFyOcjLoJV7RAesoL3ptKa2JAheDVEh3f?=
 =?us-ascii?Q?5keMFmqFrz3ML6jFXf4WJjHK8PS9bGoHGEzDa1jQl5mXoTRpmucUaC08xRHF?=
 =?us-ascii?Q?ODgBlsRtSYDeGjlFDyPmsmR1GaqZkk49lkMMDNZ5Zi3UsvgQd/o+DmDjJiu3?=
 =?us-ascii?Q?EVptVlvqxviY+HUXGW+vPdn0Rb1rDGMKs1xbNHYbiCvrZpZrFnd79/7UlrQd?=
 =?us-ascii?Q?9rShzuu9G71UAIP7O1VtysK+DWBppkf35JZsdTG5eiVQbNiw3A++xs0GJo31?=
 =?us-ascii?Q?e0mwg1Fsku4RtRZESxpd7oFN2CkJgf4xdWP47yJZ09YjXj35c1EUjSkPnWBI?=
 =?us-ascii?Q?2a2tWr/6aQatIXyPw4MgjD4mrlpmN17O9tf8B7qu1TaHbTJdGpn4zj8knXPv?=
 =?us-ascii?Q?bGoJM5NiCrK3RIImt+lItKQeUVhNjo4/5tkBLfyzz8yn3yFJznlI76Ba/+6N?=
 =?us-ascii?Q?Zf3pUht2QnkNBRZE8JUypQPqjir0V0BViH0TcQ5HpqwVpmZBbIunZi8JLFeD?=
 =?us-ascii?Q?OHZnqADUuS/ItiD6Mnm7YhC0Ukyqkx3Sm8tHuINi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb4ed69-346c-4c6d-1d95-08daeff05bbe
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 14:14:44.0002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ELeGo5ygYDR7Wd1LnWvH+SP6yR92Jx5yzJCb1JH7qivrJN8Gxa2rdKTbj5xOmt0d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5420
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 05, 2023 at 03:57:28PM +0530, Vasant Hegde wrote:
> Matt,
> 
> On 1/5/2023 6:39 AM, Matt Fagnani wrote:
> > I built 6.2-rc2 with the patch applied. The same black screen problem happened
> > with 6.2-rc2 with the patch. I tried to use early kdump with 6.2-rc2 with the
> > patch twice by panicking the kernel with sysrq+alt+c after the black screen
> > happened. The system rebooted after about 10-20 seconds both times, but no kdump
> > and dmesg files were saved in /var/crash. I'm attaching the lspci -vvv output as
> > requested.
> > 
> 
> Thanks for testing. As mentioned earlier I was not expecting this patch to fix
> the black screen issue. It should fix kernel warnings and IOMMU page fault
> related call traces. By any chance do you have the kernel boot logs?
> 
> 
> @Baolu,
>   Looking into lspci output, it doesn't list ACS feature for Graphics card. So
> with your fix it didn't enable PASID and hence it failed to boot.

The ACS checks being done are feature of the path not the end point or
root port.

If we are expecting ACS on the end port then it is just a bug in how
the test was written.. The test should be a NOP because there are no
switches in this topology.

Looking at it, this seems to just be because pci_enable_pasid is
calling pci_acs_path_enabled wrong, the only other user is here:

	for (bus = pdev->bus; !pci_is_root_bus(bus); bus = bus->parent) {
		if (!bus->self)
			continue;

		if (pci_acs_path_enabled(bus->self, NULL, REQ_ACS_FLAGS))
			break;

		pdev = bus->self;

		group = iommu_group_get(&pdev->dev);
		if (group)
			return group;
	}

And notice it is calling it on pdev->bus not on pdev itself which
naturally excludes the end point from the ACS validation.

So try something like:

	if (!pci_acs_path_enabled(pdev->bus->self, NULL, PCI_ACS_RR | PCI_ACS_UF))

(and probably need to check for null ?)

Jason
