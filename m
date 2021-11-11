Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02EE044D53C
	for <lists+linux-pci@lfdr.de>; Thu, 11 Nov 2021 11:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhKKKsJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Nov 2021 05:48:09 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:25900 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbhKKKsJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Nov 2021 05:48:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1636627473;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=ma0TFr7iZJMiYrb0naNb8BXA+X8CHMOl/hj+LOHXaz0=;
    b=UEB93MwmcbJ4M6NGI/0OL2V1pMjg6oE94muDBy3pH1P2sgFqrCoYLkHOtmTR+ubzhh
    36rt2Xee7oPdpxY7Q+DuPMjASW5wGCw82ftye1tWL0WOS2QocwxVYm6yQk3Ens6aQeoz
    uAup5ua6BvFtHOq8oiA4zF41opldX+ce8lJE50DFTPtXKtTNqYr1/qjE6b3OhvQatqLQ
    xoEFsFGKPr4A719EkejGENlHoAEsUi8OVSYO7bDLf977Gv47aJh5zm/sefiKJh2MEnne
    m8KgnWW1OXzO6KZmj/we4aBY6HNnXzFlLogy/Psr8p34GDPvIuRztI0rAqXdWUF5eJ8m
    pxug==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBJSrwuuqxvPgFdUfkfTNIrYqeqUw78GttMdoRvw=="
X-RZG-CLASS-ID: mo00
Received: from cc-build-machine.a-eon.tld
    by smtp.strato.de (RZmta 47.34.5 AUTH)
    with ESMTPSA id N03801xABAiVIFG
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 11 Nov 2021 11:44:31 +0100 (CET)
Subject: Re: [PASEMI] Nemo board doesn't recognize any ATA disks with the
 pci-v5.16 updates
To:     Marc Zyngier <maz@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "bhelgaas@google.com >> Bjorn Helgaas" <bhelgaas@google.com>,
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
 <8cc64c3b-b0c0-fb41-9836-2e5e6a4459d1@xenosoft.de>
 <87r1bn88rt.wl-maz@kernel.org>
 <f40294c6-a088-af53-eeea-4dfbd255c5c9@xenosoft.de>
 <87pmr7803l.wl-maz@kernel.org>
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <c93c7f72-6e46-797b-bee3-c9ae3b444f60@xenosoft.de>
Date:   Thu, 11 Nov 2021 11:44:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87pmr7803l.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11 November 2021 at 11:20 am, Marc Zyngier wrote:
> On Thu, 11 Nov 2021 07:47:08 +0000,
> Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
>> On 11 November 2021 at 08:13 am, Marc Zyngier wrote:
>>> On Thu, 11 Nov 2021 05:24:52 +0000,
>>> Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
>>>> Hello Marc,
>>>>
>>>> Here you are:
>>>> https://forum.hyperion-entertainment.com/viewtopic.php?p=54406#p54406
>>> This is not what I asked. I need the actual source file, or at the
>>> very least the compiled object (the /sys/firmware/fdt file, for
>>> example). Not an interpretation that I can't feed to the kernel.
>>>
>>> Without this, I can't debug your problem.
>>>
>>>> We are very happy to have the patch for reverting the bad commit
>>>> because we want to test the new PASEMI i2c driver with support for the
>>>> Apple M1 [1] on our Nemo boards.
>>> You can revert the patch on your own. At this stage, we're not blindly
>>> reverting things in the tree, but instead trying to understand what
>>> is happening on your particular system.
>>>
>>> Thanks,
>>>
>>> 	M.
>>>
>> I added a download link for the fdt file to the post [1]. Please read
>> also Darren's comments in this post.
>
> Am I right in understanding that the upstream kernel does not support
> the machine out of the box, and that you actually have to apply out of
> tree patches to make it work?
No, you aren't right. The upstream kernel supports the Nemo board out of 
the box. [1]

- Christian

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?qt=grep&q=Darren+Stevens
