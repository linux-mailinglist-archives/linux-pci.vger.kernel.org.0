Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BAA665898
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jan 2023 11:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjAKKIO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Jan 2023 05:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjAKKHv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2023 05:07:51 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42ACAD90
        for <linux-pci@vger.kernel.org>; Wed, 11 Jan 2023 02:04:32 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pFXy8-0006Ad-7r; Wed, 11 Jan 2023 11:04:28 +0100
Message-ID: <fc7d82b2-f10b-3bb4-a695-5aeae7b92e90@leemhuis.info>
Date:   Wed, 11 Jan 2023 11:04:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] PCI: revert "Enable PASID only when ACS RR & UF enabled
 on upstream path"
Content-Language: en-US, de-DE
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        linux-pci@vger.kernel.org
Cc:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Tony Zhu <tony.zhu@intel.com>, Joerg Roedel <jroedel@suse.de>
References: <20230111085745.401710-1-christian.koenig@amd.com>
From:   "Linux kernel regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20230111085745.401710-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1673431472;bd609d7a;
X-HE-SMSGID: 1pFXy8-0006Ad-7r
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11.01.23 09:57, Christian König wrote:
> This reverts commit 201007ef707a8bb5592cd07dd46fc9222c48e0b9.
> 
> It's correct that the PCIe fabric routes Memory Requests based on the
> TLP address, but enabling the PASID mapping doesn't necessary mean that
> Memory Requests will have a PASID associated with them.
> 
> The alternative is ATS which lets the device resolve the PASID+addr pair
> before a memory request is made into a routeable TLB address through the
> TA. Those resolved addresses are then cached on the device instead of
> in the IOMMU TLB.
> 
> So the assumption that you mandatory need ACS to enabled PASID handling
> on a device is simply not correct, we need to take ATS into account as
> well.
> 
> The patch caused failures with AMDs integrated GPUs because some of them
> only enable ATS but not ACS.
> 
> For now just revert the patch until this is completely solved.
> 
> CC: Jason Gunthorpe <jgg@nvidia.com>
> CC: Kevin Tian <kevin.tian@intel.com>
> CC: Lu Baolu <baolu.lu@linux.intel.com>
> CC: Bjorn Helgaas <bhelgaas@google.com>
> CC: Tony Zhu <tony.zhu@intel.com>
> CC: Joerg Roedel <jroedel@suse.de>
> Signed-off-by: Christian König <christian.koenig@amd.com>

One small thing to improve:

> Bug: https://bugzilla.kernel.org/show_bug.cgi?id=216865

s/Bug:/Link:/ here, otherwise you might get mails from Linus like these:
https://lore.kernel.org/all/CAHk-=wjMmSZzMJ3Xnskdg4+GGz=5p5p+GSYyFBTh0f-DgvdBWg@mail.gmail.com/
https://lore.kernel.org/all/CAHk-=wgs38ZrfPvy=nOwVkVzjpM3VFU1zobP37Fwd_h9iAD5JQ@mail.gmail.com/
https://lore.kernel.org/all/CAHk-=wjxzafG-=J8oT30s7upn4RhBs6TX-uVFZ5rME+L5_DoJA@mail.gmail.com/

This usage is also explained in
Documentation/process/submitting-patches.rst
(http://docs.kernel.org/process/submitting-patches.html) and
Documentation/process/5.Posting.rst
(https://docs.kernel.org/process/5.Posting.html)

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

P.S.: let me tell regzbot to monitor this thread:

#regzbot ^backmonitor: https://bugzilla.kernel.org/show_bug.cgi?id=216865
