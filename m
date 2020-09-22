Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD20A27425F
	for <lists+linux-pci@lfdr.de>; Tue, 22 Sep 2020 14:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgIVMuT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Sep 2020 08:50:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41103 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgIVMuT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Sep 2020 08:50:19 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kKhkL-000132-Bd; Tue, 22 Sep 2020 12:50:13 +0000
Subject: Re: [PATCH v2] PCI: brcmstb: fix a missing if statement on a return
 error check
To:     Jim Quinlan <james.quinlan@broadcom.com>,
        Markus Elfring <Markus.Elfring@web.de>
Cc:     "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        kernel-janitors@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jim Quinlan <jquinlan@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh@kernel.org>
References: <fe38fa7c-8ff7-8e83-968f-91007c058fcc@web.de>
 <CA+-6iNyGbL2jn1qUdX=AN17Xy5uX1-P=+Xi2NLSxHX-1FwLOwg@mail.gmail.com>
From:   Colin Ian King <colin.king@canonical.com>
Message-ID: <22b12b8a-4c16-5377-043d-00750597f822@canonical.com>
Date:   Tue, 22 Sep 2020 13:50:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <CA+-6iNyGbL2jn1qUdX=AN17Xy5uX1-P=+Xi2NLSxHX-1FwLOwg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22/09/2020 13:43, Jim Quinlan wrote:
> On Tue, Sep 22, 2020 at 7:49 AM Markus Elfring <Markus.Elfring@web.de> wrote:
>>
>>> The error return ret is not being check with an if statement and
>>
>> Wording alternative:
>> The return value from a call of the function “brcm_phy_start” was not checked and
>>
>>
>>> V2: disable clock as noted by Florian Fainelli and suggested by
>>>     Jim Quinlan.
>>
>> Alex Dewar contributed another update suggestion.
>>
>> [PATCH v2] PCI: brcmstb: Add missing if statement and error path
>> https://lore.kernel.org/linux-arm-kernel/20200921211623.33908-1-alex.dewar90@gmail.com/
>> https://lore.kernel.org/patchwork/patch/1309860/
>>
>> The exception handling needs further development considerations
>> for this function implementation.
> Hello,
> 
> I agree with Alex's patch.  I should have suggested this at the
> beginning but as our upstream STB suspend/resume is not yet functional
> and the one-line change would have worked until we fixed
> suspend/resume..  But this is the proper modification.

Yup, go with Alex's patch. That one is correct.


> 
> Thanks,
> Jim
>> Regards,
>> Markus

