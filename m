Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC2428C15C
	for <lists+linux-pci@lfdr.de>; Mon, 12 Oct 2020 21:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730985AbgJLTS3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Oct 2020 15:18:29 -0400
Received: from mail-dm6nam12on2074.outbound.protection.outlook.com ([40.107.243.74]:45761
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730938AbgJLTS3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Oct 2020 15:18:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mA8S4C2UfsVKHhqrNl1XWBDJ0uBTzhuZ7kw7Q6CkCrd6Fm72b7sLTOrTj/Oz6zHWDsOWuJ5NPvshjevk/bX10hM7i/rbKfXOkhtahUn6p7FWPVPeFNC7mky7lVHkg7hNe3X98nzUyz91tXn9xrfeeQK2LdBScye6Y4iPVMCTrNcW3ynBA7qeN5XcnHw2aKSsbeFcbxQny8s/tVtYvZpVowpLW+dPLtCPZn0R6Rw9yhPe/KOjtod7pjmZfNmUuzDad/kCIVMyMIs0HakOCkAeI3UHnga+oA/XpGiAToaEd1F9bxpLm8Rm/yzKVJYvCr1rF8VoMQD5Bp1BCv63lLnpmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1boBFCyzIBl4gIhJLrj2PG2aOe03eoJxTPEnN8A/b9c=;
 b=UHWj8vkvSXX7aF2+b+z/DZtCkv/gTkg+Gr3IP1e8M2XQmf2JpuNDFEIK/SnUlJxHohygAFFz6yV4FPQ0HHepKC1K3LPKHHIJSu1V2lNJEhI3HVPS2SUMa9HB7RehhQdI9kaBUpKxKZZZl8d4fU5CL/l3ViEED1NnFR76Yj9kco2Rx0F7QSDko7ve7YPhOEmxl11W3KNivlBLXXYPk+nJxP/5x9qqFOGSydzJSsHtmII19CUJg6VTZwkH2ZvS2g6hKIrfwNqLy9sxFTFrjANTjG+f5p2c+dlk9YVUybI80ipgp5Qlo8rYXvu0wjFdgz7XHx2XPMn4HjOWOtqrZ7gt1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1boBFCyzIBl4gIhJLrj2PG2aOe03eoJxTPEnN8A/b9c=;
 b=i5mGCIAGe4nOmup4k3sd8lzeW9CkCtj19pJSQQkjwj4w12hlvVljCskSVq3KpM+bkX4MemGU8Jmk33rALMeBA4KVtNEhLlNSXT0nyzlzdPNar5EukqDiTGp4GHmAoWqkym6MNxTTOnFCIbR7/hhLWlX1p5FtumbJd6LVPVgFyxk=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=windriver.com;
Received: from SJ0PR11MB5120.namprd11.prod.outlook.com (2603:10b6:a03:2d1::13)
 by BYAPR11MB2856.namprd11.prod.outlook.com (2603:10b6:a02:bd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.27; Mon, 12 Oct
 2020 19:18:26 +0000
Received: from SJ0PR11MB5120.namprd11.prod.outlook.com
 ([fe80::c048:b134:f828:e40]) by SJ0PR11MB5120.namprd11.prod.outlook.com
 ([fe80::c048:b134:f828:e40%6]) with mapi id 15.20.3455.029; Mon, 12 Oct 2020
 19:18:26 +0000
Subject: Re: PCI, isolcpus, and irq affinity
To:     Sean V Kelley <sean.v.kelley@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nitesh Narayan Lal <nitesh@redhat.com>
References: <20201012165839.GA3732859@bjorn-Precision-5520>
 <3FF15DD8-72AF-4C1D-BF66-248FC87FD903@intel.com>
From:   Chris Friesen <chris.friesen@windriver.com>
Message-ID: <99c9fb9a-d281-28f8-59a3-aa1f23a12261@windriver.com>
Date:   Mon, 12 Oct 2020 13:18:22 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <3FF15DD8-72AF-4C1D-BF66-248FC87FD903@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [70.64.84.123]
X-ClientProxiedBy: BY3PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:217::25) To SJ0PR11MB5120.namprd11.prod.outlook.com
 (2603:10b6:a03:2d1::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.25.39.5] (70.64.84.123) by BY3PR04CA0020.namprd04.prod.outlook.com (2603:10b6:a03:217::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23 via Frontend Transport; Mon, 12 Oct 2020 19:18:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9d0b9e9-2783-415d-a39d-08d86ee3980e
X-MS-TrafficTypeDiagnostic: BYAPR11MB2856:
X-Microsoft-Antispam-PRVS: <BYAPR11MB2856F824E362D4A2A7454EEDF6070@BYAPR11MB2856.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5ePWzY8Pq2jkRzzNTpYRWPtIAhcIANYQf+PX+kfXtCD0+ddRQVo8gveR5BzRBphruvDBnm8IMGileJRu4N5OfdqxuQevhOXSTFTZkgYdyGUmOCoYRLjwlZLStbluLo8mTfEwq597xaum5gG8Ix7TvPPp1UvHNwURqOStEuNoI+Tu1zj8Eloi1xL2mqLhslS4SuG4Cv22uthv5U8J1SumZkmPtQJj8erZn2Zny61uRMXSHhTDV/usL4/fKmTKqWcSYmOxNbWgIjzuA/c1TPLkcoQ5vyEDbpm3HMH8WTcy6n3OQnrvkv0AJiVp2yPn3ClVo1Om3V6FYb9N4L3nZOqNibPIdzJ0iYHZ4OBTN0PwAgS4VxHLPcZ97EL8Wj6fFbX5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5120.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(346002)(376002)(396003)(136003)(366004)(53546011)(6486002)(316002)(36756003)(4744005)(52116002)(26005)(44832011)(956004)(2616005)(66946007)(16576012)(4326008)(16526019)(186003)(54906003)(6666004)(8936002)(110136005)(8676002)(86362001)(31686004)(5660300002)(66476007)(478600001)(66556008)(2906002)(31696002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: pPCOqFJiB0+YsJhoQix/TqPouqxvx3E6AEdhu3qR+JxAnfvERX2UcbHCiTTyw4mzWV/ez1UAdiGfWp4CqTo6JK31eZgGViczpWFj0BYst4GJ7UQOeYfRhOgBZAqlCGFW2/maBJ9aN2kj9d6wrX7K0xeUd0gUMvZywfZS1Ae9oah3IcLJoyZqZUeRucXPFdo1pPUo83Xyi9kGr9QMghKnH1c+QSXNqDZNnruWPRQN9uPSh87NqDhfSmercITpB8DfJnflJExvwT+Uawu3h63uDvlyA+aQ1U+p0CnrVe4RylzsNWPm6F6+Yp8rZX6htC2Kj6a1KfuE/l6gY4JRe0KlxLKLDdnivinHVT+OG9nnfeg3c9pYuwfBqdv7CLadQCgzVxcvjW/oqeJDRxHgWa05E3dHA1dplJzM/qfaV5x3OXJp7hATdyNds3u3x+tHer3/Uh4N+7i7VNDRFZhahLZtgln9B12NkOUpCSfs4UnrHJ+Y39vBzz2R/xKadhKiNI/kdDO2640xXDdThOX9CcCifC2mcDAk+w9QJL5g6yCC7wamZO2GCSoV8C1wd5yIz/V6t+fAYpgzSuwuPOVBKryrxPsbQoVV/aBAn2UKap/FgpUdXLw0Sati5P161QbHvbc1cvxJPW0RvHk7Wt8EEBekLA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9d0b9e9-2783-415d-a39d-08d86ee3980e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5120.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2020 19:18:26.2086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G+rUEdomPcD7cidlMhTfONIRVEIPqaAevPb8LYXR2GbNnYZA7+/oMeidFttaOVgkFUoU+YoKFkfbKO6oEAwJ1qpIipn7ZsZtAojuQDvZiUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2856
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/12/2020 11:39 AM, Sean V Kelley wrote:

> Are you attempting a tick-less run?  I’ve seen the NO_HZ_FULL (full 
> dynticks) feature behave somewhat inconsistently when PREEMPT_RT is 
> enabled.  The timer ticks suppression feature can at times appear to be 
> not functioning. I’m curious about how you are attempting to isolate the 
> cores.

We're trying to run tickess on a subset of the CPUs, using a combination 
of isolcpus, irqaffinity, rcu_nocbs, and nohz_full boot args, as well as 
runtime affinity adjustment for tasks and IRQs.

I don't think we're seeing full suppression of timer ticks, but partial 
suppression is happening.  Application CPUs are showing as low as 10K 
interrupts for LOC while the housekeeping CPUs are 300-500 million.

Chris
