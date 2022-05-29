Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DCE5371F0
	for <lists+linux-pci@lfdr.de>; Sun, 29 May 2022 19:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbiE2Rgc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 29 May 2022 13:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbiE2Rga (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 29 May 2022 13:36:30 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DB211465;
        Sun, 29 May 2022 10:36:28 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nvMq1-0005v5-9X; Sun, 29 May 2022 19:36:25 +0200
Message-ID: <ee5c8d64-c6a3-ad43-f6fc-098a2ae3dce1@leemhuis.info>
Date:   Sun, 29 May 2022 19:36:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/1] PCI: brcmstb: Fix regression regarding missing
 PCIe linkup
Content-Language: en-US
To:     Jim Quinlan <jim2101024@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        James Dutton <james.dutton@gmail.com>,
        Cyril Brulebois <kibi@debian.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220528224423.7017-1-jim2101024@gmail.com>
 <20220528224423.7017-2-jim2101024@gmail.com>
 <CANCKTBvyUOHJgh1=kFdyRFxWX5D4POnn0wmHYj-eNUQEP6esvA@mail.gmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <CANCKTBvyUOHJgh1=kFdyRFxWX5D4POnn0wmHYj-eNUQEP6esvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1653845788;9339f1b1;
X-HE-SMSGID: 1nvMq1-0005v5-9X
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 29.05.22 18:52, Jim Quinlan wrote:
> On Sat, May 28, 2022 at 6:44 PM Jim Quinlan <jim2101024@gmail.com> wrote:
>>
>> commit 93e41f3fca3d ("PCI: brcmstb: Add control of subdevice voltage regulators")
> 
>> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
>> introduced a regression on the PCIe RPi4 Compute Module.  If the PCIe
>> root port DT node described in [2] was missing, no linkup would be attempted,
>> and subsequent accesses would cause a panic because this particular PCIe HW
>> causes a CPU abort on illegal accesses (instead of returning 0xffffffff).
>>
>> We fix this by allowing the DT root port node to be missing, as it behaved
>> before the original patchset messed things up.
>>
>> In addition, two small changes are made:
>>
>>   1. Having pci_subdev_regulators_remove_bus() call
>>      regulator_bulk_free() in addtion to regulator_bulk_disable().
>>   2. Having brcm_pcie_add_bus() return 0 if there is an
>>      error in calling pci_subdev_regulators_add_bus().
>>      Instead, we dev_err() and turn on our refusal mode instead.
>>
>> It would be best if this commit were tested by someone with a Rpi CM4
>> platform, as that is how the regression was found.  I have only emulated
>> the problem and fix on different platform.
>>
>> Note that a bisection identified
>>
>> commit 830aa6f29f07 ("PCI: brcmstb: Split brcm_pcie_setup() into two funcs")
>>
>> as the first failing commit.  This commit is a regression, but is unrelated
>> and was fixed by a subsequent commit in the original patchset.
>>
>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=215925
>> [2] Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
>>
>> Fixes: 93e41f3fca3d ("PCI: brcmstb: Add control of subdevice voltage regulators")
>> Fixes: 830aa6f29f07 ("PCI: brcmstb: Split brcm_pcie_setup() into two funcs")
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215925
> Thorston -- I forgot to replace the bugzilla link; I'll get it on V3.  -- Jim

Don't worry to much about these details that might matter for regzbot
normally (the automatic handling of links to bugzilla ticket is sadly
dysfunctional currently anyway). Just getting the issue fixed in the
not-to-distant future is what I mainly care about. :-D

Ciao
Thorsten
