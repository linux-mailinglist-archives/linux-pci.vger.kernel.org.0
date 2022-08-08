Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8C858C868
	for <lists+linux-pci@lfdr.de>; Mon,  8 Aug 2022 14:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237657AbiHHMfx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Aug 2022 08:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237179AbiHHMfr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Aug 2022 08:35:47 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138991168
        for <linux-pci@vger.kernel.org>; Mon,  8 Aug 2022 05:35:41 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id B1ED22223A;
        Mon,  8 Aug 2022 14:35:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1659962138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jxPbVSFTrnTbPilFNqolQLOLMuHHcIBMSuaITXMk7Ss=;
        b=MFQ/Ab5N6YWbyjK9KBwOHK020YrommfA9G1IutfypVSN5ZUbTrgPZLsYAkdjO/GdIUZtq5
        qBlIGwTpf0374Ybw/ud+4CfCZS5CWjeeYXMZoh5VG+jFnDjckNrBT7vLVnsEZw6OoRf4g0
        +K3l8asdvXqT/9COZ5qJurWLTuLh9Ro=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 08 Aug 2022 14:35:38 +0200
From:   Michael Walle <michael@walle.cc>
To:     Mark Brown <broonie@kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernelci-results@groups.io, bot@kernelci.org,
        gtucker@collabora.com, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org
Subject: Re: next/master bisection: baseline.bootrr.intel-igb-probed on
 kontron-pitx-imx8m
In-Reply-To: <YvEAF1ZvFwkNDs01@sirena.org.uk>
References: <62eed399.170a0220.2503a.1c64@mx.google.com>
 <YvEAF1ZvFwkNDs01@sirena.org.uk>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <deda4eb1592cb61504c9d42765998653@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+ Heiko as the owner of that board, resend as I accidentally deleted
most of the text, sorry for the noise]

Am 2022-08-08 14:22, schrieb Mark Brown:
> On Sat, Aug 06, 2022 at 01:48:25PM -0700, KernelCI bot wrote:
> 
> The KernelCI bisection bot found that 5a46079a96451 "PM: domains: 
> Delete
> usage of driver_deferred_probe_check_state()" triggered a failure to
> probe the PCI controller or attached ethernet on kontron-pitx-imx8m.
> There's no obvious errors in the boot log when things fail, we simply
> don't see any of the announcements from the PCI controller probe like 
> we
> do on a working boot:

I guess that is the same as:
https://lore.kernel.org/lkml/Yr3vEDDulZj1Dplv@sirena.org.uk/

-michael

> <6>[    2.434563] imx6q-pcie 33800000.pcie: host bridge
> /soc@0/pcie@33800000 ranges:
> <6>[    2.436149] imx6q-pcie 33c00000.pcie: host bridge
> /soc@0/pcie@33c00000 ranges:
> <6>[    2.436168] imx6q-pcie 33c00000.pcie:   No bus range found for
> /soc@0/pcie@33c00000, using [bus 00-ff]
> <6>[    2.436208] imx6q-pcie 33c00000.pcie:       IO
> 0x0027f80000..0x0027f8ffff -> 0x0000000000
> <6>[    2.436233] imx6q-pcie 33c00000.pcie:      MEM
> 0x0020000000..0x0027efffff -> 0x0020000000
> <6>[    2.436985] imx6q-pcie 33c00000.pcie: iATU unroll: enabled
> <6>[    2.436993] imx6q-pcie 33c00000.pcie: Detected iATU regions: 4
> outbound, 4 inbound
> <6>[    2.439329] sdhci-esdhc-imx 30b50000.mmc: Got WP GPIO
> <6>[    2.447119] imx6q-pcie 33800000.pcie:       IO
> 0x001ff80000..0x001ff8ffff -> 0x0000000000
> <4>[    2.455485] sdhci-esdhc-imx 30b50000.mmc: drop HS400 support
> since no 8-bit bus
> <6>[    2.464884] imx6q-pcie 33800000.pcie:      MEM
> 0x0018000000..0x001fefffff -> 0x0018000000
> <6>[    2.464895] mmc0: SDHCI controller on 30b40000.mmc
> [30b40000.mmc] using ADMA
> <6>[    2.504586] mmc1: SDHCI controller on 30b50000.mmc
> [30b50000.mmc] using ADMA
> <6>[    2.537041] imx6q-pcie 33c00000.pcie: Link up
> <6>[    2.547713] imx6q-pcie 33c00000.pcie: Link: Gen2 disabled
> <6>[    2.553652] imx6q-pcie 33c00000.pcie: Link up, Gen1
> <6>[    2.559036] imx6q-pcie 33c00000.pcie: Link up
> <6>[    2.563987] imx6q-pcie 33c00000.pcie: PCI host bridge to bus 
> 0001:00
> 
> https://storage.kernelci.org/mainline/master/v5.19-7280-gb44f2fd87919b/arm64/defconfig/clang-14/lab-kontron/baseline-kontron-pitx-imx8m.txt
> 
> (interleaved with the SDHCI probe which is in the failing boot) though 
> I
> am wondering if the "no bus range found..." warning above might have
> been escallated into a failure to probe.
> 
> I've included the full bisection report below, including links to more
> information including full boot failing logs plus a reported-by tag for
> the bot.
> 
>> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
>> * This automated bisection report was sent to you on the basis  *
>> * that you may be involved with the breaking commit it has      *
>> * found.  No manual investigation has been done to verify it,   *
>> * and the root cause of the problem may be somewhere else.      *
>> *                                                               *
>> * If you do send a fix, please include this trailer:            *
>> *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
>> *                                                               *
>> * Hope this helps!                                              *
>> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
>> 
>> next/master bisection: baseline.bootrr.intel-igb-probed on 
>> kontron-pitx-imx8m
>> 
>> Summary:
>>   Start:      861397378de91 Add linux-next specific files for 20220803
>>   Plain log:  
>> https://storage.kernelci.org/next/master/next-20220803/arm64/defconfig+crypto/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.txt
>>   HTML log:   
>> https://storage.kernelci.org/next/master/next-20220803/arm64/defconfig+crypto/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.html
>>   Result:     5a46079a96451 PM: domains: Delete usage of 
>> driver_deferred_probe_check_state()
>> 
>> Checks:
>>   revert:     PASS
>>   verify:     PASS
>> 
>> Parameters:
>>   Tree:       next
>>   URL:        
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>>   Branch:     master
>>   Target:     kontron-pitx-imx8m
>>   CPU arch:   arm64
>>   Lab:        lab-kontron
>>   Compiler:   gcc-10
>>   Config:     defconfig+crypto
>>   Test case:  baseline.bootrr.intel-igb-probed
>> 
>> Breaking commit found:
>> 
>> -------------------------------------------------------------------------------
>> commit 5a46079a96451cfb15e4f5f01f73f7ba24ef851a
>> Author: Saravana Kannan <saravanak@google.com>
>> Date:   Wed Jun 1 00:06:57 2022 -0700
>> 
>>     PM: domains: Delete usage of driver_deferred_probe_check_state()
>> 
>>     Now that fw_devlink=on by default and fw_devlink supports
>>     "power-domains" property, the execution will never get to the 
>> point
>>     where driver_deferred_probe_check_state() is called before the 
>> supplier
>>     has probed successfully or before deferred probe timeout has 
>> expired.
>> 
>>     So, delete the call and replace it with -ENODEV.
>> 
>>     Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>     Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>>     Signed-off-by: Saravana Kannan <saravanak@google.com>
>>     Link: 
>> https://lore.kernel.org/r/20220601070707.3946847-2-saravanak@google.com
>>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> 
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> index 739e52cd4aba5..3e86772d5fac5 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -2730,7 +2730,7 @@ static int __genpd_dev_pm_attach(struct device 
>> *dev, struct device *base_dev,
>>  		mutex_unlock(&gpd_list_lock);
>>  		dev_dbg(dev, "%s() failed to find PM domain: %ld\n",
>>  			__func__, PTR_ERR(pd));
>> -		return driver_deferred_probe_check_state(base_dev);
>> +		return -ENODEV;
>>  	}
>> 
>>  	dev_dbg(dev, "adding to PM domain %s\n", pd->name);
>> -------------------------------------------------------------------------------
>> 
>> 
>> Git bisection log:
>> 
>> -------------------------------------------------------------------------------
>> git bisect start
>> # good: [7c6327c77d509e78bff76f2a4551fcfee851682e] Merge 
>> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
>> git bisect good 7c6327c77d509e78bff76f2a4551fcfee851682e
>> # bad: [861397378de91c64dec69a160595b891f443294f] Add linux-next 
>> specific files for 20220803
>> git bisect bad 861397378de91c64dec69a160595b891f443294f
>> # good: [9caf5c540b57105ac31f351518d83e1884c3d64a] Merge branch 
>> 'master' of git://linuxtv.org/media_tree.git
>> git bisect good 9caf5c540b57105ac31f351518d83e1884c3d64a
>> # good: [5ec97d04fa30ac49b48a141c0ee6bbe3038b0dad] Merge branch 'next' 
>> of git://git.kernel.org/pub/scm/virt/kvm/kvm.git
>> git bisect good 5ec97d04fa30ac49b48a141c0ee6bbe3038b0dad
>> # bad: [f95826f64a15aefb5e82a2a51341afd30cae191a] Merge branch 'next' 
>> of git://github.com/awilliam/linux-vfio.git
>> git bisect bad f95826f64a15aefb5e82a2a51341afd30cae191a
>> # good: [b5276c924497705ca927ad85a763c37f2de98349] drivers: lkdtm: fix 
>> clang -Wformat warning
>> git bisect good b5276c924497705ca927ad85a763c37f2de98349
>> # bad: [8d0a69bdbdaaf73040a80479497f153f43120787] Merge branch 
>> 'driver-core-next' of 
>> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
>> git bisect bad 8d0a69bdbdaaf73040a80479497f153f43120787
>> # good: [62776e969e13c7124e614937c0333dc24c0db0db] Merge branch 
>> 'for-next' of 
>> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
>> git bisect good 62776e969e13c7124e614937c0333dc24c0db0db
>> # good: [3413a46f9d313b6870e1c2fd5bae2892b725ef2e] Merge branch 
>> 'for-next' of 
>> git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git
>> git bisect good 3413a46f9d313b6870e1c2fd5bae2892b725ef2e
>> # bad: [2fd26970cf66bd52dc42843c46968040caa8c9a1] Revert "kernfs: 
>> Change kernfs_notify_list to llist."
>> git bisect bad 2fd26970cf66bd52dc42843c46968040caa8c9a1
>> # bad: [5f8954e099b8ae96e7de1bb95950e00c85bedd40] Revert "mwifiex: fix 
>> sleep in atomic context bugs caused by dev_coredumpv"
>> git bisect bad 5f8954e099b8ae96e7de1bb95950e00c85bedd40
>> # bad: [71066545b48e4259f89481199a0bbc7c35457738] driver core: Set 
>> fw_devlink.strict=1 by default
>> git bisect bad 71066545b48e4259f89481199a0bbc7c35457738
>> # bad: [f8217275b57aa48d98cc42051c2aac34152718d6] net: mdio: Delete 
>> usage of driver_deferred_probe_check_state()
>> git bisect bad f8217275b57aa48d98cc42051c2aac34152718d6
>> # bad: [24a026f85241a01bbcfe1b263caeeaa9a79bab40] pinctrl: devicetree: 
>> Delete usage of driver_deferred_probe_check_state()
>> git bisect bad 24a026f85241a01bbcfe1b263caeeaa9a79bab40
>> # bad: [5a46079a96451cfb15e4f5f01f73f7ba24ef851a] PM: domains: Delete 
>> usage of driver_deferred_probe_check_state()
>> git bisect bad 5a46079a96451cfb15e4f5f01f73f7ba24ef851a
>> # first bad commit: [5a46079a96451cfb15e4f5f01f73f7ba24ef851a] PM: 
>> domains: Delete usage of driver_deferred_probe_check_state()
>> -------------------------------------------------------------------------------
>> 
>> 
>> -=-=-=-=-=-=-=-=-=-=-=-
>> Groups.io Links: You receive all messages sent to this group.
>> View/Reply Online (#30209): 
>> https://groups.io/g/kernelci-results/message/30209
>> Mute This Topic: https://groups.io/mt/92825373/1131744
>> Group Owner: kernelci-results+owner@groups.io
>> Unsubscribe: https://groups.io/g/kernelci-results/unsub 
>> [broonie@kernel.org]
>> -=-=-=-=-=-=-=-=-=-=-=-
>> 
>> 
