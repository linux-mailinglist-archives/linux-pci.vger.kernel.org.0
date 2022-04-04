Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03F14F1CD3
	for <lists+linux-pci@lfdr.de>; Mon,  4 Apr 2022 23:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379544AbiDDV3K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Apr 2022 17:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380360AbiDDTqm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Apr 2022 15:46:42 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8107F30F6A
        for <linux-pci@vger.kernel.org>; Mon,  4 Apr 2022 12:44:45 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id B97391F43BF6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649101484;
        bh=AetZO14xbcwjN7p2Q/tZR+lMGaIRX4VombXbjpftqPo=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=MGC+2yHksxo5ptY8I7dVON2PF0/XiL3nKTT7/vTzVJ62401X3ZPgJ53+n59uOX4nd
         EiCvATZyO2cNCj42poEmnhwVJPwILBOvoSVfMXMRj5g/JaeCtDSGcWCTt6Y+ZrOzJf
         mwxNPh0iTPUH9LdnNsJmxC8fR8BRnQ69BdS0JVgN9bIH7tHVg5sG80cs2QuM2ZQ7xs
         gwFdiOTYnHp8fS/ityq1nwP3S5Zf9Th8odhMSYfGKiRfZF5bwD88NK33npLm/Vgs5G
         4EJ7Aemiki4F/NTjpzykMuNrR8TqZonQCbXu2wIOK1gzOWuEOWex9M1TwLnjzcQzrE
         mg6tcv0TisQiQ==
Message-ID: <28ee7ff8-5b21-9154-74e9-efd59da4a498@collabora.com>
Date:   Mon, 4 Apr 2022 20:44:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: next/master bisection: baseline.login on asus-C523NA-A20057-coral
Content-Language: en-US
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org,
        "kernelci@groups.io" <kernelci@groups.io>,
        "kernelci-results@groups.io" <kernelci-results@groups.io>
References: <623c13ec.1c69fb81.8cbdb.5a7a@mx.google.com>
 <Yjyv03JsetIsTJxN@sirena.org.uk>
 <4e9fca2f-0af1-3684-6c97-4c35befd5019@redhat.com>
 <Yjzua8Wye/3DHBKx@sirena.org.uk>
 <f8e96f8a-c19c-6acd-2f54-688924f491e8@redhat.com>
 <28699579-8384-ff3b-5662-fb56d8ced766@collabora.com>
In-Reply-To: <28699579-8384-ff3b-5662-fb56d8ced766@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+kernelci

On 29/03/2022 19:44, Guillaume Tucker wrote:
> On 28/03/2022 13:54, Hans de Goede wrote:
>> Hi,
>>
>> On 3/24/22 23:19, Mark Brown wrote:
>>> On Thu, Mar 24, 2022 at 09:34:30PM +0100, Hans de Goede wrote:
>>>
>>>> Mark, if one of use writes a test patch, can you get that Asus machine to boot a
>>>> kernel build from next + the test patch ?
>>>
>>> I can't directly unfortunately as the board is in Collabora's lab but
>>> Guillaume (who's already CCed) ought to be able to, and I can generally
>>> prod and try to get that done.
>>
>> Ok, Guillaume, can you try a kernel with commit 5949965ec9340cfc0e65f7d8a576b660b26e2535
>> ("x86/PCI: Preserve host bridge windows completely covered by E820") + the 
>> attached patch added on top a try on the asus-C523NA-A20057-coral machine please
>> and see if that makes it boot again ?
> 
> Sorry I've been busy with a conference.  Sure, will put that
> through KernelCI tomorrow and let you know the outcome.

Well the issue seems to have been fixed on mainline, unless it's
intermittent.  In any case, next-20220404 is booting fine:

  https://linux.kernelci.org/test/plan/id/624aed811a5acd09adae071e/

Last time it was seen to fail was next-20220330:

  https://linux.kernelci.org/test/plan/id/62442f68e30d6f89a4ae06b7/


Ironically, the KernelCI staging linux-next job with the patches
mentioned in your previous email applied is now failing:

  https://staging.kernelci.org/test/plan/id/624b2d3b923f532dc305f4c7/

The kernel branch being used is:

  https://github.com/kernelci/linux/commits/staging-next


I haven't checked the logs or investigated any further, this is
just a quick summary based on the boot test results.

Please let us know if we should drop these patches or try
anything else.  I'll be on holiday for the rest of the week but
others can pick things up if needed.

Thanks,
Guillaume
