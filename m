Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC18976E235
	for <lists+linux-pci@lfdr.de>; Thu,  3 Aug 2023 09:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbjHCH5I convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 3 Aug 2023 03:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbjHCH4U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 03:56:20 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C18193C2;
        Thu,  3 Aug 2023 00:44:32 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 45F6E24E267;
        Thu,  3 Aug 2023 15:43:49 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 3 Aug
 2023 15:43:49 +0800
Received: from [192.168.125.136] (183.27.98.54) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 3 Aug
 2023 15:43:48 +0800
Message-ID: <dae4bd27-4ea6-43b1-d65c-225be7b5640b@starfivetech.com>
Date:   Thu, 3 Aug 2023 15:43:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 8/9] PCI: PLDA: starfive: Add JH7110 PCIe controller
Content-Language: en-US
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Minda Chen <minda.chen@starfivetech.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>
References: <20230802171805.GA62238@bhelgaas>
 <1c546489-40dd-25c5-3ac2-9e3b3fd5a670@starfivetech.com>
 <20230803065835.twdicvx62mgzzzqi@pali>
From:   Kevin Xie <kevin.xie@starfivetech.com>
In-Reply-To: <20230803065835.twdicvx62mgzzzqi@pali>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [183.27.98.54]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/8/3 14:58, Pali Rohár wrote:
> On Thursday 03 August 2023 10:23:47 Kevin Xie wrote:
>> On 2023/8/3 1:18, Bjorn Helgaas wrote:
>> > On Tue, Aug 01, 2023 at 03:05:46PM +0800, Kevin Xie wrote:
>> >> On 2023/8/1 7:12, Bjorn Helgaas wrote:
>> >> ...
>> > 
>> >> > The delay required by sec 6.6.1 is a minimum of 100ms following exit
>> >> > from reset or, for fast links, 100ms after link training completes.
>> >> > 
>> >> > The comment at the call of advk_pcie_wait_for_link() [2] says it is
>> >> > the delay required by sec 6.6.1, but that doesn't seem right to me.
>> >> > 
>> >> > For one thing, I don't think 6.6.1 says anything about "link up" being
>> >> > the end of a delay.  So if we want to do the delay required by 6.6.1,
>> >> > "wait_for_link()" doesn't seem like quite the right name.
>> >> > 
>> >> > For another, all the *_wait_for_link() functions can return success
>> >> > after 0ms, 90ms, 180ms, etc.  They're unlikely to return after 0ms,
>> >> > but 90ms is quite possible.  If we avoided the 0ms return and
>> >> > LINK_WAIT_USLEEP_MIN were 100ms instead of 90ms, that should be enough
>> >> > for slow links, where we need 100ms following "exit from reset."
>> >> > 
>> >> > But it's still not enough for fast links where we need 100ms "after
>> >> > link training completes" because we don't know when training
>> >> > completed.  If training completed 89ms into *_wait_for_link(), we only
>> >> > delay 1ms after that.
>> >> 
>> >> That's the point, we will add a extra 100ms after PERST# de-assert
>> >> in the patch-v3 according to Base Spec r6.0 - 6.6.1:
>> >>         msleep(100);
>> >>         gpiod_set_value_cansleep(pcie->reset_gpio, 0);
>> >> 
>> >> +       /* As the requirement in PCIe base spec r6.0, system must wait a
>> >> +        * minimum of 100 ms following exit from a Conventional Reset
>> >> +        * before sending a Configuration Request to the device.*/
>> >> +       msleep(100);
>> >> +
>> >>         if (starfive_pcie_host_wait_for_link(pcie))
>> >>                 return -EIO;
>> > 
>> > For fast links (links that support > 5.0 GT/s), the 100ms starts
>> > *after* link training completes.  The above looks OK if starfive only
>> > supports slow links, but then I'm not sure why we would need
>> > starfive_pcie_host_wait_for_link().
>> > 
>> Yes, the maximum speed of JH7110 PCIe is 5.0 GT/s (Gen2x1).
>> 
>> About starfive_pcie_host_wait_for_link():
>> JH7110 SoC only has one root port in each PCIe controller (2 in total)
>> and they do not support hot-plug yet.
> 
> Beware that even if HW does not support hotplug, endpoint PCIe card
> still may drop the link down and later put it up (for example if FW in
> the card crashes or when card want to do internal reset, etc...; this is
> very common for wifi cards). So drivers for non-hotplug controllers
> still have to handle hotplug events generated by link up/down state.
> 
> So it means that, if endpoint PCIe card is not detected during probe
> time, it may be detected later. So this check to completely stop
> registering controller is not a good idea. Note that userspace can
> tell kernel (via sysfs) to rescan all PCIe buses and try to discover new
> PCIea devices.
> 

Yes, we should not ignored this situation.

>> Thus, We add starfive_pcie_host_wait_for_link() to poll if it is a empty slot.
>> If nothing here, we will exit the probe() of this controller, and it will not
>> go into pci_host_probe() too.
>> This may not be a very standard logic, should we remove it or rewrite in a better way?
>> 
>> > Bjorn
> 
> Rather to remove this starfive_pcie_host_wait_for_link logic.
> 
> Better option would be to teach PCI core code to wait for the link
> before trying to read vendor/device ids, like I described in my old
> proposal.

Yes, the proposal can prevent us from writing the wrong timing.
However, as things stand, we have to do the waiting in host controller driver now.
We will keep the wait for the link, but don't return error when the link is down,
such as:
    if (starfive_pcie_host_wait_for_link(pcie))
	dev_info(dev, "port link down\n");
