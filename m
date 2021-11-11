Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D6444D1A0
	for <lists+linux-pci@lfdr.de>; Thu, 11 Nov 2021 06:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbhKKF2a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Nov 2021 00:28:30 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:14845 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhKKF23 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Nov 2021 00:28:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1636608294;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=Xd6Py2f86FSpG6C+Erqk7EblQDN8D3vWdWbNKCJUwOg=;
    b=cGUtganz2RaZTUGKG0sM40bFi8/dSWg5XHEJMiy6TlWnRoN9RmimrDpeY/nhSZaFft
    SIZwkNUa/Pie8vSfP8iET/D/FONPQqt50vALwFzdmKA4idNy0jwDdvzORYqqfAKSLHz/
    e7n0vYlobICJ8FgOoCbn7R2CFMY1dY4oAbwcF6xUw3tL8WCJun9JGMWWHAD9VfhfB/qF
    wqtEwwdaIRmcQmqjJCdrmwH6sl3POswe+RtX69eyWqNI/MDSUWJeN+nmsUQbkEqpOLjz
    lPM/mxjjtoaWs9LMFeJPWCiaduMwrq+Go0TyAWTjdPrF0r0F+AutFpakLX39BGl6tC7M
    rCqw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBJSrwuuqxvPhWI9Q+uux5TZjyZDAcEWxCgiq/uQ=="
X-RZG-CLASS-ID: mo00
Received: from cc-build-machine.a-eon.tld
    by smtp.strato.de (RZmta 47.34.5 AUTH)
    with ESMTPSA id N03801xAB5OrFQL
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 11 Nov 2021 06:24:53 +0100 (CET)
Subject: Re: [PASEMI] Nemo board doesn't recognize any ATA disks with the
 pci-v5.16 updates
To:     Marc Zyngier <maz@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc:     "bhelgaas@google.com >> Bjorn Helgaas" <bhelgaas@google.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        lorenzo.pieralisi@arm.com, Rob Herring <robh@kernel.org>,
        Matthew Leaman <matthew@a-eon.biz>,
        Darren Stevens <darren@stevens-zone.net>,
        mad skateman <madskateman@gmail.com>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        Christian Zigotzky <info@xenosoft.de>, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, kw@linux.com,
        Arnd Bergmann <arnd@arndb.de>, robert@swiecki.net,
        Olof Johansson <olof@lixom.net>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <78308692-02e6-9544-4035-3171a8e1e6d4@xenosoft.de>
 <20211110184106.GA1251058@bhelgaas> <87sfw3969l.wl-maz@kernel.org>
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <8cc64c3b-b0c0-fb41-9836-2e5e6a4459d1@xenosoft.de>
Date:   Thu, 11 Nov 2021 06:24:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87sfw3969l.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10 November 2021 at 08:09 pm, Marc Zyngier wrote:
> HI all,
>
> On Wed, 10 Nov 2021 18:41:06 +0000,
> Bjorn Helgaas <helgaas@kernel.org> wrote:
>> On Wed, Nov 10, 2021 at 07:07:24PM +0100, Christian Zigotzky wrote:
>>> On 09 November 2021 at 03:45 pm, Christian Zigotzky wrote:
>>>> Hello,
>>>>
>>>> The Nemo board [1] doesn't recognize any ATA disks with the pci-v5.16
>>> updates [2].
>>>> Error messages:
>>>>
>>>> ata4.00: gc timeout cmd 0xec
>>>> ata4.00: failed to IDENTIFY (I/O error, error_mask=0x4)
>>>> ata1.00: gc timeout cmd 0xec
>>>> ata1.00: failed to IDENTIFY (I/O error, error_mask=0x4)
>>>> ata3.00: gc timeout cmd 0xec
>>>> ata3.00: failed to IDENTIFY (I/O error, error_mask=0x4)
>>>>
>>>> I was able to revert the new pci-v5.16 updates [2]. After a new
>>> compiling, the kernel recognize all ATA disks correctly.
>>>> Could you please check the pci-v5.16 updates [2]?
>>>>
>>>> Please find attached the kernel config.
>>>>
>>>> Thanks,
>>>> Christian
>>>>
>>>> [1] https://en.wikipedia.org/wiki/AmigaOne_X1000
>>>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0c5c62ddf88c34bc83b66e4ac9beb2bb0e1887d4
>>> Hi All,
>>>
>>> Many thanks for your nice responses.
>>>
>>> I bisected today [1]. 0412841812265734c306ba5ef8088bcb64d5d3bd (of/irq:
>>> Allow matching of an interrupt-map local to an interrupt controller) [2] is
>>> the first bad commit.
>>>
>>> I was able to revert the first bad commit [1]. After a new compiling, the
>>> kernel detects all ATA disks without any problems.
>>>
>>> I created a patch for an easy reverting the bad commit [1]. With this patch
>>> we can do further our kernel tests.
>>>
>>> Could you please check the first bad commit [2]?
>>>
>>> Thanks,
>>> Christian
>>>
>>> [1] https://forum.hyperion-entertainment.com/viewtopic.php?p=54398#p54398
>>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0412841812265734c306ba5ef8088bcb64d5d3bd
>>>
>>> [+ Marc Zyngier, Alyssa Rosenzweig, Lorenzo Pieralisi, and Rob Herring
>>> because of the first bad commit]
>> Thank you very much for the bisection and for also testing the revert!
>>
>> It's easy enough to revert 041284181226 ("of/irq: Allow matching of an
>> interrupt-map local to an interrupt controller"), and it seems like
>> that's what we need to do.  I have it tentatively queued up.
>>
>> That commit was part of the new support for the Apple M1 PCIe
>> interface, and I don't know what effect a revert will have on that
>> support.  Marc, Alyssa?
> It is going to badly break the M1 support, as we won't be able to take
> interrupts to detect that the PCIe link is up.
>
> Before we apply a full blown revert and decide that this isn't
> workable (and revert the whole M1 PCIe series, because they are
> otherwise somewhat pointless), I'd like to understand *what* breaks
> exactly.
>
> Christian, could you point me to the full DT that this machine uses?
> This would help understanding what goes wrong, and cook something for
> you to test.
>
> Thanks,
>
> 	M.
>
Hello Marc,

Here you are: 
https://forum.hyperion-entertainment.com/viewtopic.php?p=54406#p54406

We are very happy to have the patch for reverting the bad commit because 
we want to test the new PASEMI i2c driver with support for the Apple M1 
[1] on our Nemo boards.

Thanks for your help,
Christian

[1] https://forum.hyperion-entertainment.com/viewtopic.php?p=54086#p54086

