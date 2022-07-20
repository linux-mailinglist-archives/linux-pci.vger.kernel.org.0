Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57DF57BFA6
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jul 2022 23:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbiGTVeN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jul 2022 17:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbiGTVeN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jul 2022 17:34:13 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60815E827;
        Wed, 20 Jul 2022 14:34:11 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id bf13so17563116pgb.11;
        Wed, 20 Jul 2022 14:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uMfaOA0dCEc0Y+KHogJz6qUXZ7HQhYeRsFa6pE/6Lrg=;
        b=I4S2BEsq+qf/F8h6DXcChhNMrWg2GnRu4T21dhs2/9eKsdDDg4ILkGPrKSi6C/QHOp
         R5Jf4nK3KkRiw9ZAwZOWU3GaXvNpJdD50gb6RAqEx97hf87X3wncNfNZYyVDLyoG8Wd7
         JV8ppRJ1na+MyCMA1khbMIOFJwpt7bbTzriz5noYklCdLdRqToyAwKrJP1/9mli8Sm3M
         Q7OLuu7ZrDOTDm0A2NxZEWLHL5qGtRmlPpWycmSoiCW4rDJAbS26dN42vfnXv4/nzRtI
         n1Vd0sc+lTN45FkCLqUELvXK7aNwQcSrn/O005csGodfGCAs3+r253sZl2/ObBZ2JT+j
         IYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uMfaOA0dCEc0Y+KHogJz6qUXZ7HQhYeRsFa6pE/6Lrg=;
        b=2D02PPuqrDBRDaSwQ+CCBH8MupYEnWphV2RHhp6R2fpmfuZo8Teht9E5A3z/OPzftY
         LBJPbOz6QawY2c8058FGniTfR3jY4zW4ytoRq6IOf6xeY2JZooVASlgEUNFuBgGg9z4S
         aemYiHMtHp5qn4DGksrrFpcpokWk7FETnfIqjrLgWWSBIVoR1QuQpgR9gQwJeU0/wRIh
         Ik6dlQjInzeCiEdkvJFvZABVCh+5EM5Ef8y6/v1RbuPFgn3SaDjUAhJD4mklD4EK2vv8
         DsWf6PTw3kXLGIMdKHOOYIe4ucJBOBCAjjpw3mD1iMLkl/QQVwRqZ7ABqzltiDnt91q6
         evBg==
X-Gm-Message-State: AJIora+4RD4RfTzI2kbUxrGSDU2y343c6ImvgsIlBh+I8LgGLigAJAqb
        Jg4Pkz0t21f3kd5zex2RZMA=
X-Google-Smtp-Source: AGRyM1skqVnD1rvn6wErTlZ7qIMObRpv1ckGwpRu3TdyNjEQr+sq4mOpzbxayS902JpSkLbBS9YNjQ==
X-Received: by 2002:a63:8743:0:b0:41a:6f6b:db7b with SMTP id i64-20020a638743000000b0041a6f6bdb7bmr3116562pge.594.1658352851261;
        Wed, 20 Jul 2022 14:34:11 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id r3-20020a63a543000000b0040d1eb90d67sm12157419pgu.93.2022.07.20.14.34.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 14:34:10 -0700 (PDT)
Message-ID: <3cf519d2-9ffa-1337-935e-4a617a0eab16@gmail.com>
Date:   Wed, 20 Jul 2022 14:34:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/6] PCI: brcmstb: Split brcm_pcie_setup() into two
 funcs
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Jim Quinlan <jim2101024@gmail.com>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <CA+-6iNz8DTjAMXnWuOd=0W=qa6J4uD03oH3RJezEk1WxaUN1NA@mail.gmail.com>
 <20220719200332.GA1552587@bhelgaas>
 <CA+-6iNzn=JsG=xU2BxagyfeUMZ13p9yg=y+_wVcsAaZ0NgEvKg@mail.gmail.com>
 <CAL_JsqLm5pWFNLMYjRXrBNYumOd0Vdyaxj0+PGnABQbjA6bDBQ@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <CAL_JsqLm5pWFNLMYjRXrBNYumOd0Vdyaxj0+PGnABQbjA6bDBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/20/22 09:18, Rob Herring wrote:
> On Wed, Jul 20, 2022 at 8:53 AM Jim Quinlan <james.quinlan@broadcom.com> wrote:
>>
>> On Tue, Jul 19, 2022 at 4:03 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>
>>> On Tue, Jul 19, 2022 at 09:08:48AM -0400, Jim Quinlan wrote:
>>>> On Mon, Jul 18, 2022 at 6:40 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>>> On Mon, Jul 18, 2022 at 02:56:03PM -0400, Jim Quinlan wrote:
>>>>>> On Mon, Jul 18, 2022 at 2:14 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>>>>> On Sat, Jul 16, 2022 at 06:24:49PM -0400, Jim Quinlan wrote:
>>>>>>>> Currently, the function does the setup for establishing PCIe link-up
>>>>>>>> with the downstream device, and it does the actual link-up as well.
>>>>>>>> The calling sequence is (roughly) the following in the probe:
>>>>>>>>
>>>>>>>> -> brcm_pcie_probe()
>>>>>>>>     -> brcm_pcie_setup();                       /* Set-up and link-up */
>>>>>>>>     -> pci_host_probe(bridge);
>>>>>>>>
>>>>>>>> This commit splits the setup function in two: brcm_pcie_setup(), which only
>>>>>>>> does the set-up, and brcm_pcie_start_link(), which only does the link-up.
>>>>>>>> The reason why we are doing this is to lay a foundation for subsequent
>>>>>>>> commits so that we can turn on any power regulators, as described in the
>>>>>>>> root port's DT node, prior to doing link-up.
>>>>>>>
>>>>>>> All drivers that care about power regulators turn them on before
>>>>>>> link-up, but typically those regulators are described directly under
>>>>>>> the host bridge itself.
>>>>>>
>>>>>> Actually, what you describe is what I proposed with my v1 back in Nov 2020.
>>>>>> The binding commit message said,
>>>>>>
>>>>>>     "Quite similar to the regulator bindings found in
>>>>>>     "rockchip-pcie-host.txt", this allows optional regulators to be
>>>>>>     attached and controlled by the PCIe RC driver."
>>>>>>
>>>>>>> IIUC the difference here is that you have regulators described under
>>>>>>> Root Ports (not the host bridge/Root Complex itself), so you don't
>>>>>>> know about them until you've enumerated the Root Ports.
>>>>>>> brcm_pcie_probe() can't turn them on directly because it doesn't know
>>>>>>> what Root Ports are present and doesn't know about regulators below
>>>>>>> them.
>>>>>>
>>>>>> The reviewer's requested me to move the regulator node(s)
>>>>>> elsewhere, and at some point later it was requested to be placed
>>>>>> under the Root Port driver.  I would love to return them under the
>>>>>> host bridge, just say the word!
>>>>>
>>>>> Actually, I think my understanding is wrong.  Even though the PCI core
>>>>> hasn't enumerated the Root Port as a pci_dev, brcm_pcie_setup() knows
>>>>> about it and should be able to look up the regulators and turn them
>>>>> on.
>>>>
>>>> One can do this with
>>>>         regulator_bulk_get(NULL, ...);
>>>>
>>>> However, MarkB did not like the idea of a driver getting the
>>>> regulator from the global DT namespace [1].
>>>>
>>>> For the RC driver, one  cannot invoke  regulator_bulk_get(dev, ...)
>>>> if there is not a direct child regulator node.  One needs to use the
>>>> Port driver device.  The Port driver device does not exist at this
>>>> point unless one tries to prematurely create it; I tried this and it
>>>> was a mess to say the least.
>>>>
>>>>> Can you dig up the previous discussion about why the regulators need
>>>>> to be under the Root Port and why they can't be turned on before
>>>>> calling pci_host_probe()?
>>>>
>>>> RobH did not want the regulators to be under the RC as he said their
>>>> DT location should resemble the HW [2].  The consensus evolved to
>>>> place it under the port driver, which can provide a general
>>>> mechanism for turning on regulators anywhere in the PCIe tree.
>>>
>>> I don't want to redesign this whole thing.  I just want a crisp
>>> rationale for the commit log.
>>>
>>> All other drivers (exynos, imx6, rw-rockchip, histb, qcom, tegra194,
>>> tegra, rockchip-host) have regulators for downstream PCIe power
>>> directly under the RC.  If putting the regulators under an RP instead
>>> is the direction of the future, I guess that might be OK, and I guess
>>> the reasons are:
>>>
>>>   1) Slot or device power regulators that are logically below the RP
>>>      should be described that way in the DT.
>>>
>>>   2) Associating regulators with a RP allows the possibility of
>>>      selectively controlling power to slots/devices below the RP,
>>>      e.g., to power down devices below RP A when suspending while
>>>      leaving wakeup devices below RP B powered up.
>>>
>>> I think in your case the motivating reason is 2).
>>>
>>> Your commit log for "Add mechanism to turn on subdev regulators"
>>> suggests that you want some user control of endpoint power, e.g., via
>>> sysfs, but I don't see that implemented yet except possibly via a
>>> "remove" file that would unbind the driver and remove the entire
>>> device.
>> Hi Bjorn,
>>
>> Initially we wanted to (a) turn on any regulator found under the RC
>> node and (b) allow the possibility of the regulator to control the
>> EP's power. From the feedback, we realized early on that neither of
>> these were going to fly, so we conceded both requests and just wanted
>> to turn on standard PCIe regulators.  Upon reading the aforementioned
>> commit message I realize that there are a couple of leftover sentences
>> from these early days that must be removed.
>>
>> I think when I submitted v1 of the original series that only the
>> rockchip driver had regulators under the RC.   And my recollection was
>> that this was accepted but there was apprehension of this turning into
>> the "standard" way of turning on such regulators,  as the location of
>> the regulator nodes was in question.
>>
>> In short, I would be quite content  to follow the existing examples.
> 
> The existing examples are, in general, incomplete and only work for
> the simplest cases.
> 
> There's 2 cases to consider here. The first is standard slots with
> standard PCIe signals (e.g. PERST#) and voltage rails. The 2nd is
> either non-standard slots or just soldered down devices which could
> have any number of device specific resources. In the latter case,
> those resources need to go into the node for the device. For the
> former case (which we are discussing here), putting the resources in
> the upstream (side of the link) node is fine. That's the root port
> node(s) or switch port nodes. However, since most host bridges are a
> single RP and don't put the RP node in DT, we've ended up with these
> properties in host bridge nodes. That's fine as long as it's a single
> RP and device. When it is not, we need to do something different. The
> only way this scales is putting resources in the port nodes as those
> are what have a 1:1 relationship to slots. If that's supported, then
> the simple cases are also easily supported with if the resources are
> not found in the port node/device, then look for them in the parent
> node. That's also the path for how we get the handling of PERST out of
> every host bridge driver.

This has me confused now, are you suggesting that we pursue what Jim has put together here as a series which describes the regulators in the PCIe end-point device DT node, or that given that we have a single RC single RP configuration it is somewhat acceptable to describe regulators in the PCIe RC node?
-- 
Florian
