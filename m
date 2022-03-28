Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437894E9550
	for <lists+linux-pci@lfdr.de>; Mon, 28 Mar 2022 13:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238168AbiC1LlR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Mar 2022 07:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245188AbiC1LjN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Mar 2022 07:39:13 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184A1A3;
        Mon, 28 Mar 2022 04:37:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOS7Nje7xnbJPIs1E7tUEoRn3OW16Z3Nzhl7F1/M0qL/JvNIJZeRqRo0iZx15ry472eZbmHvyyMnCQVRxiBDdKfpEGtQDh179V8mf6cZqsVq+C+h0BmV6HAqnhKG40SsxY/DH1OykOrPE9nwnPmjeQfEEzezUJH50ncQ94KMV3+gRBszGHmqTF6vd4vNPVNWLahKC2iNR2YxwrW8RgSP3U12uPgUfkRdeO9+GsBWAMvR2KER/0tvwT8PAhgejZV6ZSI432y9Q4JpIM6jFUvCvXCjs80WeFU88YpYUK18q0G+8JEOsWJXGHGTyCvrl3UGitt8Y5mWnEJSXP+pcFUkUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wky6Dw4IOL0VUIvGxK33h2O0Oa8eBHODGGjK86WgDvg=;
 b=h7h5LhTngIc2/N/oaepT937DZ+dSKRhiEVQnogYayRuMfbV6cgNNPVJN2jsi8cQ30lYpYYfoUyReOR4h2YwrBkrCUx42saFpdrcDmCycKzO0+SUtnS4UKxhAprUrwJhjKq52AWF8EuDzlKFJSQDT/Y41VP+OgkhvNtC3035+9965d94xYG3mI3c2N20iwB/kL2jZEhRmbdfnpREN/idEN8keQb/Bl/asFlj9Oomfw+Mhpr7fAN0gs126khxGUfmPTVVLnoYs5qHkVMWyjBJIUK7RrX30zosfKM+4eaBmj67P4G35u+rksnFa8yZy/VgfHMg1qDNgK+2nlG8zeegwJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wky6Dw4IOL0VUIvGxK33h2O0Oa8eBHODGGjK86WgDvg=;
 b=JfTJcCU4iMl0S4OuoisPgeBGgI/uTep4OJ2FkYUBeFedtQ5LmIeO5IdUtVPaNSnN/AcXs9GKTDJkTMOASTGoMnh4Zj1nUJO4oI/fdOEOgS1qssS9VP1hcL0NyDJ81KTm3yDRFCT49m16TrrPTe2twWc3/HSRqH3JLmdDEXmrU90uNlwnYe05wzpyidwZ3Ce+XvKieIBnLfZ+NG7SU/0wNdiXOcC+mxhY1c1pKXexr35Bl487P1PYn/9aliEXiC71PbCEggsc1SV+18h2d+d5ZJNESFILE3wNd8FBMCJDznEkip+HszylGLIFoZwWevngun7PZkElvSxLdoQb8N/2ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 by CY4PR1201MB2550.namprd12.prod.outlook.com (2603:10b6:903:ce::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Mon, 28 Mar
 2022 11:37:31 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::9ce9:6278:15f:fd03]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::9ce9:6278:15f:fd03%8]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 11:37:31 +0000
Date:   Mon, 28 Mar 2022 08:37:28 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Shlomo Pongratz <shlomopongratz@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew.maier@eideticom.com, logang@deltatee.com,
        bhelgaas@google.com, Shlomo Pongratz <shlomop@pliops.com>
Subject: Re: [PATCH V2 1/1] Intel Sky Lake-E host root ports check.
Message-ID: <20220328113728.GA1693573@nvidia.com>
References: <20220327112011.3350-1-shlomop@pliops.com>
 <20220327112011.3350-2-shlomop@pliops.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220327112011.3350-2-shlomop@pliops.com>
X-ClientProxiedBy: BLAPR03CA0062.namprd03.prod.outlook.com
 (2603:10b6:208:329::7) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fe7f0a4-dd50-4b0d-a3e5-08da10af57c8
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2550:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB25505100B3C43A4341F8920CC21D9@CY4PR1201MB2550.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7FeXMVfGdUfRyZTJ8Rmw+WyTkDlSJDNSebfq2rljNaKYlqeZoy4bRfrfl5PGnx16LscGPhPTUDqkeKSRgkiFVkvMQ7ZDOFMv2hi7rN6HOYGijELXf1No7blr6uMDObljYDCwDOUj8eCcVN99Pzu1t6hSvyK44IJb9oJd41ocDU0yFmEFBKeJFT12yRzouYrP6XFbK2n/WaXmTLeBKTmPiDp1XceZJlENOV1FhuKCtsSAuiW9mOLaRpXo8yUwo8zcRVlnP+5d5PjK6sIEalWkQ44INoDfGPkklFtO9rYaNTvxtEblZ3PkB+BIZH4l/fSHLZ9vHtucqCGrh4bprWQEUudo02Kj4U1haEPpu2iIXQB8XSYaf7JhAkbstzITZkq17DC+Ah/2i2HrNiatqO9a/JsjufEWojCllESbD/id+vWjdaVTNcK9KZhrbUGgKD/sYV6dEKOdG19aqCzmTRGsp+ErgOhc3r78+/oRsXWAOLAU9/RNnC7ZK2ZgZjbAnYG8nVsg7ncD8q+mayQ0P0ZVxYjP01fvcf5FTovGYoCtl8MGb6duRJtmVOnOfqRsNj6l0+iWMlNDZoX1IK9o0ShbhBZvNqn1kS5NhaCUXyFgujPFScxLMrcEg2oFq0bUOdRdA215GU/E+34IC4Tnr0qi2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(86362001)(36756003)(6512007)(6506007)(6666004)(316002)(6916009)(66476007)(66556008)(66946007)(8676002)(508600001)(6486002)(33656002)(2906002)(2616005)(1076003)(26005)(186003)(83380400001)(5660300002)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nhMScBxNe6YcWyN5yqadSjxMdgbF5nIS+WUKqvjXCy32AJcZdADEGqtwNvq+?=
 =?us-ascii?Q?T4vND/NaFkS/wIIALpVjM0H41FLbP4KGCCy6I4vD4wLRA5t3k29c6vUD/nbx?=
 =?us-ascii?Q?S2jWoCHy3j8adEUpMKIM9X3e8m+nyLVfzT5cdH6EEhVkspUbcV0v/xtry/BM?=
 =?us-ascii?Q?bnBGjil0OlsncrscNZwEphS08pE6IH9Kuna+6uqgFVlpJyvhE5g9O/9UWgD5?=
 =?us-ascii?Q?ZAxjzUlJBK3hXZvAdouMXjp9mEZI9D2W3yOQGnfMw3z3ZcXNpagzqK2/HnVu?=
 =?us-ascii?Q?mCJWw+PuJ7r4By47ajOtN9xOvTCmi5OgliwSjYSlb/1/vSIW11w7u4xfqwyU?=
 =?us-ascii?Q?g38YM5ReAljeHWXmbilfhwRv5Qzfx3YhTTWei8Pcq2+OkeL36tG4VcYo9BGl?=
 =?us-ascii?Q?J1uplzwwUwLN16T18UxfJkPVaaMraPOyHtLsezDyCncySQZ+BQRQCRbuvCXe?=
 =?us-ascii?Q?/r9sNQJMZ9GrKIE8EH5+MCKGQ/9TcbGI3wwrMqJ+FeMqzkTgZOkMyWAgReOq?=
 =?us-ascii?Q?6LSSjWztJCx81hh5FMfNFZdlzqKG08fK/QTptiZwg/dUpN8SCa1mgKG/UbF3?=
 =?us-ascii?Q?KPQ7rIb7y7KHFqXQIhRym70suEwl125W1LuVWuxGDtN7tksOH962K8R9VPPA?=
 =?us-ascii?Q?Z5YC476CuD5YuCtmnJUvYNdEQn401MfCTgrwNnyxoM3lOsgAvyY0PrbLL8VI?=
 =?us-ascii?Q?sL59zxQe0VaxGcnKWqWtdWDdYuMrcTBibq4ZbncnAw84spFAhBiEj9xuqmTU?=
 =?us-ascii?Q?qdKL800gjqbUc0JeZBj3f9PutrDtHdsYLqM1pLUbyZL2SL9J9w+W8YRoemy4?=
 =?us-ascii?Q?+NNsGw541OF9qaFLsGt9RMOViPY4Vo7dQPTC0g4mUhLLLKlN0zGcXheWqd95?=
 =?us-ascii?Q?ERbzRolABguzmfqtUHXucJvOSEA4oWx+q4VVVM90bZCRwcmUeh5ndwO2kLY9?=
 =?us-ascii?Q?i52Q3EUrKZw9x205ossCxe4tRzf6uf3Ctko6X6WUGlc44VIHaBX+L8thEhFQ?=
 =?us-ascii?Q?uaWS5WHuVK99wmpvTDNKdtXOlr3iYGSpXQH/X/LfBYIsogM6YbAwqx166coZ?=
 =?us-ascii?Q?FAJ39MIazLppdr+ZD9dwRi6HuR7fo0D+ZOkcZ0+a8jR2NvhP8fBiz2eZWdIb?=
 =?us-ascii?Q?xgwSQPJFZpGRZwUgTapLOoLXxJNR+X8lvx/QTNrtoKu4uxNayTo2ew2HL1KZ?=
 =?us-ascii?Q?I3Wu4gmFeR3KFYkMmi9YcN23wfvS1pIcYHAdNBtoF7//Waicz7NnCOQGFela?=
 =?us-ascii?Q?XytOjXkYM1nV4PMQsqeJ2rIfYNjH4uF30IcLHCe5oaYHr4UviwOm5VQeK7sn?=
 =?us-ascii?Q?SZOwNRNybv51UJK118Tqj34Y7qPubZqSqzFjIixFkj5NAlH8U7ynSpvYIu1f?=
 =?us-ascii?Q?mD5P5nQu2mOi2EOPUISaFlcPtZXaApGjtPEit824Xchm0+xkmQirHwcHJ9i+?=
 =?us-ascii?Q?zARHBdalqeBtZQlQTCeaPUm/IkUAAOzxuS9lZapRIUde6kJPbRqLWKKpneGx?=
 =?us-ascii?Q?iho/rGgZZI7ujkDDhRx2dpzKRuzmm5PG65UbpXGaRjHJiKMSdlRgpmC/XF89?=
 =?us-ascii?Q?A2wT6cnH334v5kQ42n3oC/igJXVnWAjz93ea61pL0jz5exlnDwFef/OV6FnH?=
 =?us-ascii?Q?10FSXRZCj7Kg9tDhCG3zBcZo8XKpwcOF4nkImNi5F2r10CPb5CRZuzc6FgOG?=
 =?us-ascii?Q?m67lbbw85A3bEXIO5g9BG1qQTb/O6FubgqTWgQJZRIEdSFNUxZE8P6RZW9w4?=
 =?us-ascii?Q?4KxG37AbIQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe7f0a4-dd50-4b0d-a3e5-08da10af57c8
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 11:37:30.9590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ybOsBiocxSyc/e/FSRCnUQ8BPJTkgdgeKXj4q0ydtxoo40m3tsvP+zsFRQ8/Rgxf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2550
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Mar 27, 2022 at 02:20:11PM +0300, Shlomo Pongratz wrote:
> On commit 7b94b53db34f ("PCI/P2PDMA: Add Intel Sky Lake-E Root Ports B, C, D to the whitelist")
> Andrew Maier added the Sky Lake-E additional devices
> 2031, 2032 and 2033 root ports to the already existing 2030 device.
> 
> The Intel devices 2030, 2031, 2032 and 2033 which are ports A, B, C and D,
> and if all exist they will occupy slots 0 till 3 in that order.
> 
> Now if for example device 2030 is missing then there will no device on slot 0, but
> other devices can reside on other slots according to there port.
> For this reason the test that insisted that the bridge should be on slot 0 was modified
> to support bridges that are not on slot 0.

This helped our systems here! Thanks

Though to be clear the BIOS/ACPI modeling seems to be wrong in a way
which prevents linux from finding the true root port which is the main
cause of this problem.

2030-2033 are *root ports* not host bridges. So when we are in
pci_host_bridge_dev() the code is not looking at the system's host
bridge device at all, but a root port off the host bridge.

Which explains why the non-zero slot is happening.

So this might be better to add a flag 'IS_ROOT_PORT' instead of 'port'
and then just ignore the slot number entirely for root ports.

Though maybe someone has a better idea how the host bridge stuff is
supposed to work on these skylake-e systems.

> + * The method above will work in most cases but not for all.
> + * Note that the Intel devices 2030, 2031, 2032 and 2033 are ports A, B, C and D.
> + * Consider on a bus X only port C is connected downstream so in the PCI scan only
> + * device 8086:2032 on 0000:X:02.0 will be found as birdges with no children are ignored

'bridges' mispelled

> + *
>   * This function is equivalent to pci_get_slot(host->bus, 0), however it does
>   * not take the pci_bus_sem lock seeing __host_bridge_whitelist() must not
>   * sleep.
> @@ -350,7 +356,10 @@ static struct pci_dev *pci_host_bridge_dev(struct pci_host_bridge *host)
>  
>  	if (!root)
>  		return NULL;
> -	if (root->devfn != PCI_DEVFN(0, 0))
> +	/* Here just check that the function is 0
> +	 * The slot number will be checked later
> +	 */
> +	if (PCI_FUNC(root->devfn) != 0)
>  		return NULL;
>  
>  	return root;
> @@ -372,6 +381,13 @@ static bool __host_bridge_whitelist(struct pci_host_bridge *host,
>  	for (entry = pci_p2pdma_whitelist; entry->vendor; entry++) {
>  		if (vendor != entry->vendor || device != entry->device)
>  			continue;
> +		/* For devices which are bounded to a specific slot
> +		 * (e.g. Intel Sky Lake-E host root ports) check the port is
> +		 * Identical to the slot number.
> +		 * For other devices continue to inssist on slot 0

"insist" mispelled.

Jason
