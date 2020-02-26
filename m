Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA6CB16F5FC
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2020 04:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729982AbgBZDM7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Feb 2020 22:12:59 -0500
Received: from sonic315-22.consmr.mail.ne1.yahoo.com ([66.163.190.148]:39352
        "EHLO sonic315-22.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728989AbgBZDM7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Feb 2020 22:12:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1582686777; bh=EDeg07rZxl/sUH7fwsk+TOwTF2ljHnuXXPZhKhAcOt4=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=CiKOdXgipcEiGA/rKjrWm2Q1/4vyYPKjFNlqBJppzmlUcvgpyvBcHTiNC5s5vqzVBNwhSzhy1KhG5hOe5pBYEA3GHI/ycpZgHgFtsItDOv0UGlWCKhyc7vqPE5k6ZuTQh/TWQxeC6+vuTNuV5c6XZFe//JPCQXt7INXRM1br/GOn/2ZN+jYeFCxt0z+ZdOpbm3Q8gToaVLIkN603Pzyc0R+hUJ6xRcVGzVYcfXXwUcV9O4euNoO9+9cfUnBihzKexq9VgPHxiadagJmItkTgGRMRWkH82fdBHV6ML1Iq0FRSrZXz9aDdaaKkmScuUr+o6uGPMzXUiqGO1x4kFDlHgQ==
X-YMail-OSG: AsjNqDQVM1nMtfq1AQFtcNBgDhbGgVDDZbwCRD9IS92VT2GbRH0Z0SK.JVH.I3V
 SLoYGnkpmYsk1IchnDdkiPKKA.Dff6cBFbyF5bXLYj9WstAN2CTCoRo6e54Tewsk39LWmpYRJOWA
 ees17l3X5i1IX9PS9R8ol9n2DfL6WrzHC1MgE11KY6hgei92IYZQK_VNZwOn70awY8hARlhy5fom
 W2fWMVSk0WWvN_tYIoZh6BmA0wHt7z.de6a3HeCShF12WjfpvKDAVDyxuyYda0RchOtYAY6KIrTZ
 inhZ40BE2wZkYf7BK8AhxI_2KrTdH4Ap.zMa.FzZ0nU.81w8LZRmzwgWw6dPispkPzk0lNkT9XSY
 0B0g7C1rXIC8thPT7tfG1KMGAbEsf2vpzbGT5p8B5U6R8ImGdowf8R7DbfEn9hGbi9O6xo5ujCTz
 61ZjsDOc0LwmnbCmwtHEBLoVTCqTpRL7mnm2ce5h0ZC36kydQRqsCGlEsTLOPOHj2FSFETgh1EJ2
 ikdPmrojmhnjl_9ZGhJF.vg9eiXqnm69c.8PxdHPiq4VNOdfkbFZQ5kQ_2owX7Y2lbp7fw2eEJLr
 Inz4JyfF7qvt00ENsojnOOamO4H_mTPUnJChNgVlbLduMd0meG.2w_c9XoLAJKT5jBoEZG1jY.5U
 o.bxXVwOsZOo0VMvNe.8TZKR5lDECm0SjxY_3BMVZtZgwQiwq0MuIJsNUI.ACyjwfycggO3nR3j2
 RG9tdf7UZCxQVcxBganuPt_dwZx3jwiC4lwwY3FeaT_Ep6ij0gW3Jtm5NyMJo85NpOPwHdge0hLg
 f1vQ7HCoQomZUCk1tE4wnme9HgOj3UVviZiqMUwZa7Zo7MJdunCn.GGS5keefokGo1CysBRuCEc5
 uWuuSZWHnkxh6wSKKqj2_jw2YAXSAAwgFQ429HzbDevoC17aClVhzE_deslukW5hXbZlAA_Xcpa_
 r7zFWw9Hzo2nSu6ZAEdfjN6qQcLNY8Yf_w2QrPbtx9JDKQbRB0m1MAbsylCO3MqZdEw.nmhIKlus
 TCiIz1CgHWn5EP3W796iFfTqTqpFHD3inw2hVGxX6KLethHH4Za4BUjk5q5InHkq4s.F_HVgZ8lz
 d2yztrBnKbQtZL1d2pnt8kKNiZOC.qKzhDinLALBztJT.od0IW6sOFUea.aKD3SJVTK3EZVy_5Tp
 7vslgsjdjffDynm3MG7RKJ9jnYHsq64lZYGzyvWCrzJsPfxsfQQoTZMboq8sLIBuHLYrNXLzkySM
 1ZQyRVMm6XNXSaGzOvAUH4Mm272ezXDjfMWD07tKsH86Pe8BwXIzyUhFwdk7kp0wQH7Yo60Iz2eq
 Mrl7dm86PaWkQ4xalRAkLdBINULSY0LeDpXt8tg2x3IxTxJMeDG97s3mhctZrZuZP2Yzbn1Y7snt
 pT5cMFvJeFfKfUo4medxghqrvNhfNtGQcmqMQ
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Wed, 26 Feb 2020 03:12:57 +0000
Received: by smtp422.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 25570d402fada7184cb76a0285a4068d;
          Wed, 26 Feb 2020 03:12:53 +0000 (UTC)
Subject: Re: PCI device function not being enumerated [Was: PCMCIA not working
 on Panasonic Toughbook CF-29]
To:     "Michael ." <keltoiboy@gmail.com>,
        Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kris Cleveland <tridentperfusion@yahoo.com>,
        Jeff <bluerocksaddles@willitsonline.com>,
        Morgan Klym <moklym@gmail.com>,
        Philip Langdale <philipl@overt.org>,
        Pierre Ossman <pierre@ossman.eu>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
References: <20191029170250.GA43972@google.com>
 <20200222165617.GA207731@google.com>
 <CAPDyKFq_exHufHyibFCjS78PTZ7duS9ZSt3vi18CNM6+jMmwnw@mail.gmail.com>
 <20200226011310.GA2116625@rani.riverdale.lan>
 <CAFjuqNg_NW7hcssWmMTtt=ioY143qn76ooT7GRhxEEe9ZVCqeQ@mail.gmail.com>
From:   Trevor Jacobs <trevor_jacobs@aol.com>
Message-ID: <6e9db1f6-60c4-872b-c7c8-96ee411aa3ca@aol.com>
Date:   Tue, 25 Feb 2020 21:12:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFjuqNg_NW7hcssWmMTtt=ioY143qn76ooT7GRhxEEe9ZVCqeQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.15302 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_241)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

That's correct, I tested a bunch of the old distros including slackware, 
and 2.6.32 is where the problem began.

Also, the Panasonic Toughbook CF-29s effected that we tested are the 
later marks, MK4 and MK5 for certain. The MK2 CF-29 worked just fine 
because it has different hardware supporting the PCMCIA slots. I have 
not tested a MK3 but suspect it would work ok as it also uses the older 
hardware.

Thanks for your help guys!
Trevor

On 2/25/20 7:50 PM, Michael . wrote:
> Through our own testing it hasn't worked on any of the regular Linux
> releases (both Deb and RPM varieties, and I think someone tested Arch
> or Slackware as well) after 2.6.32 .
>
> On 26/02/2020, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>> On Tue, Feb 25, 2020 at 04:03:32PM +0100, Ulf Hansson wrote:
>>> On Sat, 22 Feb 2020 at 17:56, Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>> On Tue, Oct 29, 2019 at 12:02:50PM -0500, Bjorn Helgaas wrote:
>>>>> [+cc Ulf, Philip, Pierre, Maxim, linux-mmc; see [1] for beginning of
>>>>> thread, [2] for problem report and the patch Michael tested]
>>>>>
>>>>> On Tue, Oct 29, 2019 at 07:58:27PM +1100, Michael . wrote:
>>>>>> Bjorn and Dominik.
>>>>>> I am happy to let you know the patch did the trick, it compiled
>>>>>> well
>>>>>> on 5.4-rc4 and my friends in the CC list have tested the modified
>>>>>> kernel and confirmed that both slots are now working as they
>>>>>> should.
>>>>>> As a group of dedicated Toughbook users and Linux users please
>>>>>> accept
>>>>>> our thanks your efforts and assistance is greatly appreciated.
>>>>>>
>>>>>> Now that we know this patch works what kernel do you think it will
>>>>>> be
>>>>>> released in? Will it make 5.4 or will it be put into 5.5
>>>>>> development
>>>>>> for further testing?
>>>>> That patch was not intended to be a fix; it was just to test my guess
>>>>> that the quirk might be related.
>>>>>
>>>>> Removing the quirk solved the problem *you're* seeing, but the quirk
>>>>> was added in the first place to solve some other problem, and if we
>>>>> simply remove the quirk, we may reintroduce the original problem.
>>>>>
>>>>> So we have to look at the history and figure out some way to solve
>>>>> both problems.  I cc'd some people who might have insight.  Here are
>>>>> some commits that look relevant:
>>>>>
>>>>>    5ae70296c85f ("mmc: Disabler for Ricoh MMC controller")
>>>>>    03cd8f7ebe0c ("ricoh_mmc: port from driver to pci quirk")
>>>>>
>>>>>
>>>>> [1]
>>>>> https://lore.kernel.org/r/CAFjuqNi+knSb9WVQOahCVFyxsiqoGgwoM7Z1aqDBebNzp_-jYw@mail.gmail.com/
>>>>> [2] https://lore.kernel.org/r/20191021160952.GA229204@google.com/
>>>> I guess this problem is still unfixed?  I hate the fact that we broke
>>>> something that used to work.
>>>>
>>>> Maybe we need some sort of DMI check in ricoh_mmc_fixup_rl5c476() so
>>>> we skip it for Toughbooks?  Or maybe we limit the quirk to the
>>>> machines where it was originally needed?
>>> Both options seems reasonable to me. Do you have time to put together a
>>> patch?
>>>
>>> Kind regards
>>> Uffe
>> The quirk is controlled by MMC_RICOH_MMC configuration option. At least
>> as a short-term fix a bit better than patching the kernel, building one
>> with that config option disabled should have the same effect.
>>
>>  From the commit messages, the quirk was required to support MMC (as
>> opposed to SD) cards in the SD slot. I would assume this will be an
>> issue with the chip in any machine as the commit indicates that the
>> hardware in the chip detects MMC cards and doesn't expose them through
>> the SDHCI function.
>>
>> It looks like the quirk was only enabled by default in 2015, at least
>> upstream [1], though in Debian it was enabled in May 2010 going by their
>> git repo, maybe in 2.6.32-16.
>>
>> [1] commit ba2f73250e4a ("mmc: Enable Ricoh MMC quirk by default")
>>

