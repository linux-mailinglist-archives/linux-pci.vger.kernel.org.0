Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3CB044C6A7
	for <lists+linux-pci@lfdr.de>; Wed, 10 Nov 2021 19:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhKJSNU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Nov 2021 13:13:20 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:18676 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhKJSNU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Nov 2021 13:13:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1636567647;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=un7NStfNwXCHmUnry87vKRBPThpeYHr68ghmBQMF70o=;
    b=DsfpiHC7UekGMzBk5FwbJLJWR0gNb23MefeqmnAPe9Tk8WRjwQSbq7clMnlQX2Vmll
    WceZZPKNlQffrTfY1s09rfgs7nUKIyBleSj8mKNQ/66vXlTqAv5086+IFT59t+xkrWB2
    mPkPgcXTYWQD3GZELHCjdmOPAXyymaCyuWOKYAC1g5N/CTYZR5WTqF1wAERykLoShYTs
    +TPEwHvb8/RxIcHP/IYiwbnQftL6gJHBsyUV9jebugBtJ4xC9BvzHMW4724egxU0vQId
    R9fSbP+rUEB0wwj9JFAcr0/qWfqA16K0XySOOVG+4DdH5R10R4nTLQ5CqWauPlg8qN/J
    qBig==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBJSrwuuqxvPgAdSVjtJkpysql8WpJpy8CVmbv+Q=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a02:8109:89c0:ebfc:ccde:9e75:e3b9:1705]
    by smtp.strato.de (RZmta 47.34.5 AUTH)
    with ESMTPSA id N03801xAAI7OAgs
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 10 Nov 2021 19:07:24 +0100 (CET)
Message-ID: <78308692-02e6-9544-4035-3171a8e1e6d4@xenosoft.de>
Date:   Wed, 10 Nov 2021 19:07:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PASEMI] Nemo board doesn't recognize any ATA disks with the
 pci-v5.16 updates
Content-Language: de-DE
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
To:     "bhelgaas@google.com >> Bjorn Helgaas" <bhelgaas@google.com>,
        maz@kernel.org, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        lorenzo.pieralisi@arm.com, Rob Herring <robh@kernel.org>
Cc:     Matthew Leaman <matthew@a-eon.biz>,
        Darren Stevens <darren@stevens-zone.net>,
        mad skateman <madskateman@gmail.com>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        Christian Zigotzky <info@xenosoft.de>, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, kw@linux.com,
        Arnd Bergmann <arnd@arndb.de>, robert@swiecki.net,
        Olof Johansson <olof@lixom.net>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <3eedbe78-1fbd-4763-a7f3-ac5665e76a4a@xenosoft.de>
 <15731ad7-83ff-c7ef-e4a1-8b11814572c2@xenosoft.de>
 <17e37b22-5839-0e3a-0dbf-9c676adb0dec@xenosoft.de>
 <3b210c92-4be6-ce49-7512-bb194475eeab@xenosoft.de>
In-Reply-To: <3b210c92-4be6-ce49-7512-bb194475eeab@xenosoft.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 09 November 2021 at 03:45 pm, Christian Zigotzky wrote:
 > Hello,
 >
 > The Nemo board [1] doesn't recognize any ATA disks with the pci-v5.16 
updates [2].
 >
 > Error messages:
 >
 > ata4.00: gc timeout cmd 0xec
 > ata4.00: failed to IDENTIFY (I/O error, error_mask=0x4)
 > ata1.00: gc timeout cmd 0xec
 > ata1.00: failed to IDENTIFY (I/O error, error_mask=0x4)
 > ata3.00: gc timeout cmd 0xec
 > ata3.00: failed to IDENTIFY (I/O error, error_mask=0x4)
 >
 > I was able to revert the new pci-v5.16 updates [2]. After a new 
compiling, the kernel recognize all ATA disks correctly.
 >
 > Could you please check the pci-v5.16 updates [2]?
 >
 > Please find attached the kernel config.
 >
 > Thanks,
 > Christian
 >
 > [1] https://en.wikipedia.org/wiki/AmigaOne_X1000
 > [2] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0c5c62ddf88c34bc83b66e4ac9beb2bb0e1887d4

Hi All,

Many thanks for your nice responses.

I bisected today [1]. 0412841812265734c306ba5ef8088bcb64d5d3bd (of/irq: 
Allow matching of an interrupt-map local to an interrupt controller) [2] 
is the first bad commit.

I was able to revert the first bad commit [1]. After a new compiling, 
the kernel detects all ATA disks without any problems.

I created a patch for an easy reverting the bad commit [1]. With this 
patch we can do further our kernel tests.

Could you please check the first bad commit [2]?

Thanks,
Christian

[1] https://forum.hyperion-entertainment.com/viewtopic.php?p=54398#p54398
[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0412841812265734c306ba5ef8088bcb64d5d3bd

[+ Marc Zyngier, Alyssa Rosenzweig, Lorenzo Pieralisi, and Rob Herring 
because of the first bad commit]


