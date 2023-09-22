Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A6D7AB122
	for <lists+linux-pci@lfdr.de>; Fri, 22 Sep 2023 13:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjIVLqP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Sep 2023 07:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbjIVLqO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Sep 2023 07:46:14 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605B5FB
        for <linux-pci@vger.kernel.org>; Fri, 22 Sep 2023 04:46:05 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qjebe-00063Z-UW; Fri, 22 Sep 2023 13:45:59 +0200
Message-ID: <785cbc11-3d85-4551-8290-0ca31e9be77e@leemhuis.info>
Date:   Fri, 22 Sep 2023 13:45:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/PM: Mark devices disconnected if their upstream PCIe
 link is down on resume
Content-Language: en-US, de-DE
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mark Blakeney <mark.blakeney@bullet-systems.net>,
        Kamil Paral <kparal@redhat.com>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-pci@vger.kernel.org,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <20230921201945.GA343804@bhelgaas>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <20230921201945.GA343804@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1695383165;8bb2f802;
X-HE-SMSGID: 1qjebe-00063Z-UW
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_PASS,T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21.09.23 22:19, Bjorn Helgaas wrote:
> [+cc Kamil, Chris]
> 
> On Mon, Sep 18, 2023 at 08:30:41AM +0300, Mika Westerberg wrote:
>> Mark Blakeney reported that when suspending system with a Thunderbolt
>> dock connected and then unplugging the dock before resume (which is
>> pretty normal flow with laptops), resuming takes long time.
>>
>> What happens is that the PCIe link from the root port to the PCIe switch
>> inside the Thunderbolt device does not train (as expected, the link is
>> upplugged):
> [...]
>> Fixes: e8b908146d44 ("PCI/PM: Increase wait time after resume")
>> Reported-by: Mark Blakeney <mark.blakeney@bullet-systems.net>
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217915
>> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Applied with Lukas' Reviewed-by to pm for v6.7.
>
> e8b908146d44 appeared in v6.4. 

Then why did you apply this for 6.7 and not to a branch targeting the
current cycle? Linus wants regression introduced during round about the
last 12 months to be handled liked regressions from the current cycle,
unless there is some good reason to treat the fix differently (big risk
of other regressions for example).

> Seems like maybe a candidate for stable? 

+1

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
