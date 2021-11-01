Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3B8441E1C
	for <lists+linux-pci@lfdr.de>; Mon,  1 Nov 2021 17:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbhKAQ3s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Nov 2021 12:29:48 -0400
Received: from mail-bn7nam10on2062.outbound.protection.outlook.com ([40.107.92.62]:14592
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232066AbhKAQ3r (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Nov 2021 12:29:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T593nXvRklWUzWk26eO2yga71asLobIAnHgG4RsFN9XQYlvC9hN2AaPSInjefTGjh+BO7NuN0hIsaRNbm05QQnXm5zD9RFxFW9NwiWexAZj2vmYh5Fa2SPQ4bJ301U04mogwpH37fP3PadCaBlrrRFyWlgj+WNJlkoiHdD1TEZTZd0H/9yGtYCc8G3F1nTL+0e2JWTJlUE0yD8MtAN9K2rDYNzCeeJCwNkeQrZ3YxIda1JP8gMC544iaxf1BNsxyjlArwO7wXL2mKmhoIguZPgIVSyolYOF7oX6PiYb9c9UNNz6aZj6kLTX54hOjTn9MPchOat8zFwjjuSJ78L58xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oiKHJPudDRpjOXXBxugxm674l8UEZPNlv56plWQVYGo=;
 b=XQ377+Hsg/aWsYZ3lLJDvHYIb2O0WONtpmGxV+QMxdTQlyj9Agp7x71gqU4pHBk4ZoYLDtg+nRNnxpUSnR4yprT0qQ8RbBWvzf7NP8+4y21C9FQhfjMf6Wp7CDJ5XA/iRxhjvIqxDxKF1zVP3MDom7wl4nfFtQ1qkvVI3yWBSeUCXijP++kI681it+bBDpoitKU/IqL8XhIzS2T/9P0X+IoLzoyo1SCm8k/OLB4chu6Zb4stUIdM/Gw9FYgEb9mMmmVP+M2I/twTsdAvv3td/SprBFsGUMaDroMEMu2z/vpu/ews2f8LZlzeQq7ac2fPsBsazhpGSl1WLw3U9IKOow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oiKHJPudDRpjOXXBxugxm674l8UEZPNlv56plWQVYGo=;
 b=BRxbeC6C21irU3SMw7rPEgwgh9fZkbIfYxXONGUFxGiYUYnxFIH5ze5RH8onwPxt9hs71WIncMbTCJMjL217E2lcAcx8Cb8GJnYK9SagfzUtHMWITg//FqMinWJiFkg8NjGFz7C2BCS+alf+4LWnG9HmELwHqsOclHaMWmhJi0u9nEicL7vjVkV74QtgjyzL1o6FhXZ8/ScXrZR8qEAJwAXms0DPNKmcPS+FDHk5TRZ4AHzbQsr0dFMqHGuIS0uQXa3aYNstNWuubhWorJZcmblp3AVz0ThBV4tiKuNtviO6GLh1aiq4QfTA/aO4/DsmlSLCfVfW7CdYerAnmMz18w==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5221.namprd12.prod.outlook.com (2603:10b6:208:30b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Mon, 1 Nov
 2021 16:27:12 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4649.019; Mon, 1 Nov 2021
 16:27:12 +0000
Date:   Mon, 1 Nov 2021 13:27:11 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Marvell: Update PCIe fixup
Message-ID: <20211101162711.GA2744544@nvidia.com>
References: <20211101150405.14618-1-pali@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211101150405.14618-1-pali@kernel.org>
X-ClientProxiedBy: MN2PR06CA0010.namprd06.prod.outlook.com
 (2603:10b6:208:23d::15) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR06CA0010.namprd06.prod.outlook.com (2603:10b6:208:23d::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Mon, 1 Nov 2021 16:27:12 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mha9P-004XYX-Iy; Mon, 01 Nov 2021 13:27:11 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81b9ea77-aef5-4429-34b3-08d99d54759b
X-MS-TrafficTypeDiagnostic: BL1PR12MB5221:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5221B29A8F9C7EAAE604EE2EC28A9@BL1PR12MB5221.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JXafVqB6Es3sgecCphn+SRID4nNUiGuIfwU8h+IvxtBQb4k4GcnxKkSDPSa2s8CIiB2cP4l0uLp9SnJxMCF+1LIf1PuFE+3g5kAufP0LPsZdRqcbSyTyaYoJuwq5xMuvK/6LPwPpvTZM0+hErlCAdrIXndTIH61khkNW0EQFe9Jj7F2AzhGzMvQeDoVaek4WwkAm9YlEQRog97jlM24xzrDzUPl1/fDjcs9rickxvyEAkwYmh44WWrp/FSmBP40szTXRwGloJpsATfz1CbLRpND+ul4CViE+69EIKbXFq/ZyEa/h+qHugSKMw0DdV/wyRLzXM8is7URegHeQbIOqV4CD2Aciu3VebsS6/79GvaiNHo/O06uefoL/99gxZNOWKaL5meg4q5GryP2uuPYj6FxLDi8aiZ3hLzZNKRM8/9kox7IDnp3AEulCimVEbMQxrv0T2eObFaCAI03m5Ynazem30DPeGUfyKi4sr7w8vGM4eQ5HHYt8ZzOlMKejEqcjBZ8yQBWtOcGbzL1gW1t5VkH40a2oPU8OjXE94B0hSNAsma42szkblVFz4wFcvbrWWz/boijfGxkoImcnN+zjRnjgXifjXzQWgn2sdw4rx5PWX9J25w9UX4RqDPVZ5Ht59zpyLQ3FyBdxbkUX59ES6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(186003)(15650500001)(2906002)(66946007)(26005)(66574015)(86362001)(508600001)(66556008)(8676002)(426003)(66476007)(2616005)(38100700002)(8936002)(7416002)(36756003)(6916009)(1076003)(9786002)(5660300002)(4744005)(83380400001)(4326008)(316002)(54906003)(9746002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3ErL0NPK0lLSE8zcVJUY3ZyclRIQUdEd2E3NGJ2aTdPVmpyVVdKaFJIVm8z?=
 =?utf-8?B?cWZPWGNCeFBtVXRxbE1vL2xYMGt0OXJEbTUxSDBWdVhJTjJleUNJTmZpYUJ4?=
 =?utf-8?B?Y2djeWg0MTdzWjUrUjlBaENyOXUwVWNPWVNtTCs5ZzJMUVdYQmpEU2FSakNk?=
 =?utf-8?B?WWVMTk9GRkZRVXBKVVdSckZSdnhJYlhCR0JQc0pmczdZeEdwYXl5bnFHRE9S?=
 =?utf-8?B?V0NaWFYrTlJ5UnZyTUtPVEI1aEJLU0F3bCtXTU1HcVV0NFF6Ykp5VGtuWWZl?=
 =?utf-8?B?RG9PQUFvNm1GZXdyVFU1VUdLS0RoZjFYQjNtREhNK24wUHEvcHF6YmJkVytK?=
 =?utf-8?B?cW43QUlUZEhLcHB0MlkzMlU0YnhCYW9sMTMrWHR3U2pxcnFvdkEyWEdPVjlj?=
 =?utf-8?B?dHMrWVpONCtsMWdUM3ROODJmZzUvQjFneU90d20xTSs0QkFnNEk5NmNPQTZp?=
 =?utf-8?B?eXoyTm1UZ2FxZndBSCtwbTY4R1NkTWVhMUlKdTB1aDVEQWQ2NGhlb1c4UWg5?=
 =?utf-8?B?dXcwQjBKb3lVbHZueGdzcmdGWVNXUGZCSUlVSVpUTmhjbzNwT0VEcGY4aXhq?=
 =?utf-8?B?cTMzL0tSNkZwOTZvUnU5OHF5dmtGU2JTdjM4ZmVoNDVIa2lqVzVBemNUakVs?=
 =?utf-8?B?bXlkOVNqczJvYjZFNlo4OU9lelhHcVZXTERBSzJTeEtuMjhBeU8vUUFZYWhR?=
 =?utf-8?B?QkNSOU5TdzJ2bHRHWkJta0J3ZldYRWg4V2E0VUFyWWdXRURYMjRKYWZ4UjRM?=
 =?utf-8?B?YzFXTStPVmpOKzkwdWFhb2MwaDNyTTROd1g1YUlwQ3VkbG1YSFlFenJ5Zjhy?=
 =?utf-8?B?Q0NqYXc4ajlnL3IxbGc0c2tMbmFVTXpURkZrbjNQSmVteHhiY0hxdHE4dzFE?=
 =?utf-8?B?bHFTSGN4ZEdoUXlEcTh4TmdMMGd6b0RyTW9RMnFpaGlNOFJFc0N0cHBsRXR2?=
 =?utf-8?B?dE5CcmJDR2hDNi9laUdqUWlUbVAzRnJsTFhsM0ZDZCtwWFNaaXpZMThaenhj?=
 =?utf-8?B?REEvNThTM3ZxenlrMis1QkxqTTZwZ2hOM29aaEduS1hEa3VZNGRHM0pOSXJj?=
 =?utf-8?B?RnhXZXBkMmdYUG53bWVudE5XQ2xidEF5cFZLaWtZczNid3RUN0paN0ZYVWlR?=
 =?utf-8?B?YVAxOXFYK0lldWZSSmxaanRjYkJNTlJNMUQxa1o4VE1GWFFkM040UnAxSnBC?=
 =?utf-8?B?T0dienoyc1FjMjdLZVB5YUJMV3VNQi9rZStzTzFrQ2NDcVBSVlF1eHl0VVlG?=
 =?utf-8?B?Nll2MmlyR3pHK0JRM2llVnFnME4rb1VPcjUyNGRiY3FzcWIvdFphcHRQWENR?=
 =?utf-8?B?QnJ6SWxTY2w0NUhCM2FyaVk0VFRjdkM1MmNZektEdHNFbWhFSzNXOWUwK09C?=
 =?utf-8?B?MEt1blFLRmpKQXU1QzFyQ1doTjlldjlKSStkMWx0WmVQR0VMWTI2NHlFMCtM?=
 =?utf-8?B?RmJWTkZqL0dad3FlQkx5Z2RxN0NocDhDdmxXdWFXSzlieVVUWWpKNWRjNmwz?=
 =?utf-8?B?aEJrZzlzTENNYzhvNml1OWdXVUNBdHRGcVdYSjZvR1QzK09GN2R5MHl0bXQy?=
 =?utf-8?B?TWRWLzZEVTVpWldEQ245cGhZMkJHUlNnbkxzZkxtMnJiMFNqWmtjN3hNQ3hy?=
 =?utf-8?B?RkR0bmRkNGt5bGplOTVoVDVKcjd4WmVES3dDOXZzK29mbFpkdE9nTDlkNWcz?=
 =?utf-8?B?UVI1ejdwbFBtZ1haS1FmTFdCdnpFckc0VXg3cTVEVm52NlAxUmZ1amZ2dHNz?=
 =?utf-8?B?TXJGSWtac2dCeVBEVVZrRktDdlhMZWZmQWZXa2pveDdEaDQxd3Y5a3Q5dm5k?=
 =?utf-8?B?QkwzWjJUMHViYTc3KzkyTmxiODNXVzJtOUdYUFFIMUc4QUJpTHdnRFpEVEph?=
 =?utf-8?B?ZmtHUWI1YnBQamxRR2t4Z29MZklja3QvSUs0MWk4QlUxTDU1R05XdTU4WVd5?=
 =?utf-8?B?OWpHR3hCeU9weFRhYmhwZmtuTGZwN1Z0TG1haU9OVi9mV1hZL1A4ZFdNdzNF?=
 =?utf-8?B?MlpyYkJ5V2pQck80WmFQSElRb21LcDgxNmk1TlBNbGEwekw0S2tLZzZmK1hJ?=
 =?utf-8?B?aFJ0d3I5c0NsT21jZFAxQzZHT0Rrak1lbFlFYWRLT1RUSVVsYm9EQytTU0x0?=
 =?utf-8?Q?IGJM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b9ea77-aef5-4429-34b3-08d99d54759b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 16:27:12.7168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q2geDuAx3On5StrbryBIVfEeKhydIfb7nIRkEibO4Ff2vi3OBsA9CoFiyKE5GUY3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5221
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 01, 2021 at 04:04:05PM +0100, Pali Rohár wrote:
> - The code relies on rc_pci_fixup being called, which only happens
>   when CONFIG_PCI_QUIRKS is enabled, so add that to Kconfig. Omitting
>   this causes a booting failure with a non-obvious cause.
> - Update rc_pci_fixup to set the class properly, copying the
>   more modern style from other places
> - Correct the rc_pci_fixup comment
> 
> This patch just re-applies commit 1dc831bf53fd ("ARM: Kirkwood: Update
> PCI-E fixup") for all other Marvell platforms which use same buggy PCIe
> controller.

I wonder if that code is even relevant any more since we started using
CONFIG_PCI_MVEBU

?

Really, these broken controllers should not be used "raw" but always
via their special host bridge driver that fixes all the config space
problems.

Jason
