Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE8F5F20A6
	for <lists+linux-pci@lfdr.de>; Sun,  2 Oct 2022 01:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJAXuY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 1 Oct 2022 19:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiJAXuV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 1 Oct 2022 19:50:21 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4A420BDE;
        Sat,  1 Oct 2022 16:50:15 -0700 (PDT)
Message-ID: <2a465222-342a-418b-95af-9948f6ce9065@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1664668213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E50mveDkhjyT/f41Fre/RrdiU0a3ioACNtlJoHsW0io=;
        b=ONPbNZ3JwSONx6g62DdPSiaRq5lycwAkGySS5As9hNZwrdh2m4KHrSq3euYqmO9EW8zNbi
        hw9SuxjfSn5rBmkbKy7YwFly/6WlOJE1Ut6HqMSygMYoMUInZ/h0oh674Zhc3VF6r5NANt
        cXqkxZESbjiIi1HilBDEmxQfGXJEvxo=
Date:   Sat, 1 Oct 2022 17:50:07 -0600
MIME-Version: 1.0
Subject: Re: [PATCH V1 0/4] GPIO based PCIe Hot-Plug support
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Lukas Wunner <lukas@wunner.de>
Cc:     Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lpieralisi@kernel.org, kw@linux.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, mani@kernel.org,
        Sergey.Semin@baikalelectronics.ru, jszhang@kernel.org,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>
References: <20220930192747.21471-1-vidyas@nvidia.com>
 <20221001160025.GB9324@wunner.de> <20221001162049.ln2qheyyb5muifi7@pali>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <20221001162049.ln2qheyyb5muifi7@pali>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/1/2022 10:20 AM, Pali Rohár wrote:
> On Saturday 01 October 2022 18:00:25 Lukas Wunner wrote:
>> Adding Marek, Pali & Jon to cc as they've worked on somewhat similar
>> functionality:
>>
>> https://lore.kernel.org/linux-pci/20220927141926.8895-1-kabel@kernel.org/
>> https://lore.kernel.org/linux-pci/1581120007-5280-1-git-send-email-jonathan.derrick@intel.com/
>>
>> On Sat, Oct 01, 2022 at 12:57:43AM +0530, Vidya Sagar wrote:
>>> To support the Hot-plug feature, PCIe spec has a well-defined model for
>>> hardware implementation and software programming interface. There are also
>>> some architectures/platforms where the Hot-plug feature is implemented in a
>>> non-standard way and software support for the respective implementations is
>>> available with the kernel. This patch series attempts to add support for one
>>> such non-standard way of supporting the Hot-plug feature where a single GPIO
>>> is used to detect and report the Hot-Plug and Unplug events to the SW.
>>> The platforms that can use this piece of software need to have GPIO routed
>>> from the slot to the controller which can indicate the presence/absence of
>>> the downstream device through its state. This GPIO should also have the
>>> capability to interrupt the system when the connection/disconnection event
>>> takes place.
>>> A GPIO Hot-plug framework is written which looks for a "hotplug-gpios" named
>>> GPIO entry in the corresponding device-tree entry of the controller and
>>> registers a hot-pluggable slot with the Hot-plug framework.
>>> The platform drivers of the PCIe host bridges/root ports can register with the
>>> aforementioned GPIO Hot-Plug framework along with ops to perform any platform
>>> specific tasks during Hot-Plug/Unplug events.
>>>
>>> Oza Pawandeep made an attempt to upstream support for a similar Hot-plug
>>> feature implementation at a platform level, but the implementation as such
>>> was very specific to that platform (at least the way I understood it).
>>> https://patchwork.kernel.org/project/linux-pci/patch/1504155029-24729-2-git-send-email-oza.oza@broadcom.com/
>>> https://patchwork.kernel.org/project/linux-pci/patch/1504155029-24729-3-git-send-email-oza.oza@broadcom.com/
>>> https://patchwork.kernel.org/project/linux-pci/patch/1504155029-24729-4-git-send-email-oza.oza@broadcom.com/
>>> This current series also attempts to address that by extracting out all the
>>> common code to do with GPIO and Hot-plug core framework and expecting the
>>> platform drivers to only register/unregister with the GPIO framework. So,
>>> @Oza, could you try using the GPIO framework from this series and enable
>>> Hot-plug support for your platform if it still makes sense?
> 
> Hello!
> 
> Would not it better to rather synthesise PCIe Slot Capabilities support
> in your PCIe Root Port device (e.g. via pci-bridge-emul.c) and then let
> existing PCI hotplug code to take care for hotplugging? Because it
> already implements all required stuff for re-scanning, registering and
> unregistering PCIe devices for Root Ports with Slot Capabilities. And I
> think that there is no need to have just another (GPIO based)
> implementation of PCI hotplug.
I did that a few years ago (rejected), but can attest to the robustness 
of the pcie hotplug code on non-hotplug slots.
https://lwn.net/Articles/811988/


> 
> Similar thing Marek and me have implemented for PCIe link state events
> in patch series with Lukas pointed.
> 
>>> @Rob,
>>> Regarding the DT documentation change to add about 'hotplug-gpios, I'm not
>>> sure if pci.txt is the right place or the dt-schema repository
>>> i.e https://github.com/devicetree-org/dt-schema
>>> But, in the interest of keeping all the changes related to this feature in the
>>> the same repository, I made the changes to the pci.txt file in this repo itself.
>>> Please let me know if the documentation change needs to be moved to the other
>>> repo.
>>>
>>> The Changes have been tested on the Tegra234 platform.
>>>
>>> Vidya Sagar (4):
>>>    dt-bindings: Add "hotplug-gpios" PCIe property
>>>    PCI/hotplug: Add GPIO PCIe hotplug driver
>>>    PCI: tegra194: Add support to configure a pluggable slot
>>>    PCI: tegra194: Enable GPIO based Hot-Plug support
>>>
>>>   Documentation/devicetree/bindings/pci/pci.txt |   4 +
>>>   drivers/pci/controller/dwc/pcie-tegra194.c    |  85 +++++++-
>>>   drivers/pci/hotplug/Kconfig                   |  11 +
>>>   drivers/pci/hotplug/Makefile                  |   1 +
>>>   drivers/pci/hotplug/gpio_php.c                | 200 ++++++++++++++++++
>>>   drivers/pci/hotplug/gpiophp.h                 |  40 ++++
>>>   6 files changed, 334 insertions(+), 7 deletions(-)
>>>   create mode 100644 drivers/pci/hotplug/gpio_php.c
>>>   create mode 100644 drivers/pci/hotplug/gpiophp.h
>>>
>>> -- 
>>> 2.17.1
>>>
