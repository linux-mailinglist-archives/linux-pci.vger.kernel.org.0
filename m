Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD21E533748
	for <lists+linux-pci@lfdr.de>; Wed, 25 May 2022 09:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238814AbiEYHV6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 May 2022 03:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235495AbiEYHV5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 May 2022 03:21:57 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314B63B3;
        Wed, 25 May 2022 00:21:53 -0700 (PDT)
Received: from [192.168.1.107] ([37.4.249.139]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mf0yy-1nN9XI2M5S-00gYvK; Wed, 25 May 2022 09:21:26 +0200
Message-ID: <427974aa-2152-8397-65df-6808de3d3b5e@i2se.com>
Date:   Wed, 25 May 2022 09:21:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1] PCI: brcmstb: Fix regression regarding missing PCIe
 linkup
Content-Language: en-US
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        James Dutton <james.dutton@gmail.com>,
        Cyril Brulebois <kibi@debian.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
References: <CANCKTBvqp7_MSG3aMpp6pmNoPUnYpH0c+8-r7Pzgebuzb4sZPA@mail.gmail.com>
 <20220523221036.GA130515@bhelgaas>
 <CANCKTBsEjkbdWCB4D22iamPr7YP0qUX=M1dZNNgxkfk1EwjjZQ@mail.gmail.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <CANCKTBsEjkbdWCB4D22iamPr7YP0qUX=M1dZNNgxkfk1EwjjZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:f0Q2OR5Ta0dr7CnmCGZvho+BbpygkgKR6q6eP3GZZYTHeWI4m+u
 DGPZqAbJylyPwROwLzjIIBTy/1dDetp6cSZzyMrm0bHViOolt7njTrUk+lUraDcIU4IsVgo
 RnAuyA/3wlPD033YrJo9AceacxRdMNyWP/gzmolxmIXmPZO2B+icLVeRyKuz7NLL+vhzDF7
 oEDkTlpcT21JtcQdhp9Ww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HV8TcJvspQw=:Nmsn/lw7cZw0UQJnyOq/Nt
 cjlSg881Mur6B4zJiXep1sagc+9KzVv8bk/UUpZ0ZxedOkczgm9Nvc23ZPk9ljvgd0Jhfpm5C
 WA40mI82Xjpl3NbxPe8HaTpAJ1Khkc7kv17ue4bGZyGxGbb7Iq0JDVuyf5h0G6ULOJcO4LtZN
 nATKk6MUJ/GiO0wA0os9RC/8pLd4CMYgadZEmNZEYbZotjibHej+GB5WSBE8kZqnmxv2wrk44
 la7zEGoRH+4FBpvkergkHJAJeeI+p+I7tz4c/ZUWzvagAQ8djNvRZvWVzpu1tiepOYcm9AjBs
 KaBQesekUuBXG2u6o7UPnsQuf9vRSSDpmqztEJNAezNFYKZx0PVEF05i3Nds7ZuK7oNiPQOtJ
 I+3X+Zouj+Hk+0CwRD5VQP3qmA38KTwjknvvY40ccDRL/gH4NlHaNrz5gWPL13rInnmNqUMJ8
 bWB9YB71nB9ZDXYJT3r00cY3V0L1Bhw1zKd1M65R4Ut7SqNuDE1AthU355dmKwFjMoy+o+RlJ
 4NkhLyGb4gq1EDA/TR/fnTCir5HWiobwnDu22DNG8TjJgiw6+zF4BJY/2Q4mRNOu+uYBOgcuW
 OsnkgE0jYuSE/2+ScNuusymyiIVHXVOOkBPsouy1CGvJSIfHdltlLs5vAhk+e1uS+1xxgvVi+
 GvPO2qvuRVBFU2wXZ4RkKHjS2Y62843lhfXQiuyWQhorq8I2BAI34MhtzWctKES3syfOsbepS
 gfI4Rh1aKTZGG1OLu9yEt0MGHIVHU+392r/qHA5yW2b2l+XuIEMwhn/q6cc=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jim,

Am 24.05.22 um 18:54 schrieb Jim Quinlan:
> On Mon, May 23, 2022 at 6:10 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>> On Sat, May 21, 2022 at 02:51:42PM -0400, Jim Quinlan wrote:
>>> On Sat, May 21,
>>> 2CONFIG_INITRAMFS_SOURCE="/work3/jq921458/cpio/54-arm64-rootfs.cpio022
>>> at 12:43 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>> On Wed, May 18, 2022 at 03:42:11PM -0400, Jim Quinlan wrote:
>>>>> commit 93e41f3fca3d ("PCI: brcmstb: Add control of subdevice
>>>>> voltage regulators")
>>>>>
>>>>> introduced a regression on the PCIe RPi4 Compute Module.  If the
>>>>> PCIe endpoint node described in [2] was missing, no linkup would
>>>>> be attempted, and subsequent accesses would cause a panic
>>>>> because this particular PCIe HW causes a CPU abort on illegal
>>>>> accesses (instead of returning 0xffffffff).
>>>>>
>>>>> We fix this by allowing the DT endpoint subnode to be missing.
>>>>> This is important for platforms like the CM4 which have a
>>>>> standard PCIe socket and the endpoint device is unknown.
>>>> I think the problem here is that on the CM, we try to enumerate
>>>> devices that are not powered up, isn't it?  The commit log should
>>>> say something about that power situation and how the driver learns
>>>> about the power regulators instead of just pointing at an DT
>>>> endpoint node.
>>> This is incorrect.  The regression occurred because the code
>>> mistakenly skips PCIe-linkup if the PCI portdrv DT node does not
>>> exist. With our RC HW, doing a config space access to bus 1 w/o
>>> first linking up results in a CPU abort.  This regression has
>>> nothing to do with EP power at all.
>> OK, I think I'm starting to see, but I'm still missing some things.
>>
>> 67211aadcb4b ("PCI: brcmstb: Add mechanism to turn on subdev
>> regulators") added pci_subdev_regulators_add_bus() as an .add_bus()
>> method.  This is called by pci_alloc_child_bus(), and if the DT
>> describes any regulators for the bridge leading to the new child bus,
>> we turn them on.
>>
>> Then 93e41f3fca3d ("PCI: brcmstb: Add control of subdevice voltage
>> regulators") added brcm_pcie_add_bus() and made *it* the .add_bus()
>> method.  It turns on the regulators and brings the link up, but it
>> skips both if there's no DT node for the bridge to the new bus.
> Hi Bjorn,
>
> Yes, I meant it to skip the turning on of the regulators if the DT
> node was missing
> but I failed to notice that it would also skip the pcie linkup as well.  As you
> may have guessed, all of my test systems have the PCIe root port
> DT node.
>
>> I guess RPi4 CM has no DT node to describe regulators, so we skip both
>> turning them on *and* bringing the link up?
> Yes. One repo did not have this node (Cyril/debina?), one did
> (https://github.com/raspberrypi/firmware/tree/master/boot).
> Of course there is nothing wrong with omitting the node; it should
> have pcie linkup regardless.
Please ignore the vendor tree, because you only have to care about 
mainline kernel and DT here.
>
>> But above you say it's the *endpoint* node that doesn't exist.  The
>> existing code looks like it's checking for the *bridge* node
>> (bus->dev->of_node).  We haven't even enumerated the devices on the
>> child bus, so we don't know about them at this point.
> You are absolutely correct and I must change the commit message
> to say the "root port DT node".   I'm sorry; this mistake likely did not
> help you understand the fix. :-(
>
>> What happens if there is a DT node for the bridge, but it doesn't
>> describe any regulators?  I assume regulator_bulk_get() will fail, and
>> it looks like that might still keep us from bringing the link up?
> The regulator_bulk_get()  func does not fail if the regulators are not
> present.  Instead it "gets"
> a dummy device and issues a warning per missing regulator.
> A version of my pullreq submitted code to prescan the DT node and call
> regulator_bulk_get() with
> only the names of the regulators present, but IIRC this was NAKd.
> Hopefully I will not be swamped with RPi developers'  emails when they
> think these warnings are an issue.

This won't be the first driver complaining about missing regulators and 
won't be the last one. So don't expect an email from me ;-)

Best regards

