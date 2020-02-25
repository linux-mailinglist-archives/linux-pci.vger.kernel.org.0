Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 151ED16F3E8
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2020 00:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbgBYXxJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Feb 2020 18:53:09 -0500
Received: from mail.willitsonline.com ([216.7.65.54]:51616 "EHLO
        mail.willitsonline.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729393AbgBYXxI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Feb 2020 18:53:08 -0500
X-Greylist: delayed 377 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Feb 2020 18:53:08 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.willitsonline.com (Postfix) with ESMTP id EADF5111E21
        for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2020 15:46:50 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at iredmail2.willitsonline.com
Received: from mail.willitsonline.com ([127.0.0.1])
        by localhost (iredmail2.willitsonline.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tGcskKKMnjLs for <linux-pci@vger.kernel.org>;
        Tue, 25 Feb 2020 15:46:50 -0800 (PST)
Received: from _ (localhost.localdomain [127.0.0.1])
        (Authenticated sender: bluerocksaddles@willitsonline.com)
        by mail.willitsonline.com (Postfix) with ESMTPSA id E6052111D61;
        Tue, 25 Feb 2020 15:46:35 -0800 (PST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 25 Feb 2020 15:46:35 -0800
From:   bluerocksaddles@willitsonline.com
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "Michael ." <keltoiboy@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Trevor Jacobs <trevor_jacobs@aol.com>,
        Kris Cleveland <tridentperfusion@yahoo.com>,
        Morgan Klym <moklym@gmail.com>,
        Philip Langdale <philipl@overt.org>,
        Pierre Ossman <pierre@ossman.eu>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        linux-mmc@vger.kernel.org
Subject: Re: PCI device function not being enumerated [Was: PCMCIA not working
 on Panasonic Toughbook CF-29]
In-Reply-To: <CAPDyKFq_exHufHyibFCjS78PTZ7duS9ZSt3vi18CNM6+jMmwnw@mail.gmail.com>
References: <20191029170250.GA43972@google.com>
 <20200222165617.GA207731@google.com>
 <CAPDyKFq_exHufHyibFCjS78PTZ7duS9ZSt3vi18CNM6+jMmwnw@mail.gmail.com>
Message-ID: <37a39a53a54ca4ae09b4cfa9d999a47e@willitsonline.com>
X-Sender: bluerocksaddles@willitsonline.com
User-Agent: Roundcube Webmail
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn,

If you folks need a test unit or five, let me know. I can donate any 
Mark CF-29 to the project. (MK 2 or 3 will duplicate the "problem".) 
They are non-pae 386.

Jeff

On 2020-02-25 07:03, Ulf Hansson wrote:
> On Sat, 22 Feb 2020 at 17:56, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> 
>> On Tue, Oct 29, 2019 at 12:02:50PM -0500, Bjorn Helgaas wrote:
>> > [+cc Ulf, Philip, Pierre, Maxim, linux-mmc; see [1] for beginning of
>> > thread, [2] for problem report and the patch Michael tested]
>> >
>> > On Tue, Oct 29, 2019 at 07:58:27PM +1100, Michael . wrote:
>> > > Bjorn and Dominik.
>> > > I am happy to let you know the patch did the trick, it compiled well
>> > > on 5.4-rc4 and my friends in the CC list have tested the modified
>> > > kernel and confirmed that both slots are now working as they should.
>> > > As a group of dedicated Toughbook users and Linux users please accept
>> > > our thanks your efforts and assistance is greatly appreciated.
>> > >
>> > > Now that we know this patch works what kernel do you think it will be
>> > > released in? Will it make 5.4 or will it be put into 5.5 development
>> > > for further testing?
>> >
>> > That patch was not intended to be a fix; it was just to test my guess
>> > that the quirk might be related.
>> >
>> > Removing the quirk solved the problem *you're* seeing, but the quirk
>> > was added in the first place to solve some other problem, and if we
>> > simply remove the quirk, we may reintroduce the original problem.
>> >
>> > So we have to look at the history and figure out some way to solve
>> > both problems.  I cc'd some people who might have insight.  Here are
>> > some commits that look relevant:
>> >
>> >   5ae70296c85f ("mmc: Disabler for Ricoh MMC controller")
>> >   03cd8f7ebe0c ("ricoh_mmc: port from driver to pci quirk")
>> >
>> >
>> > [1] https://lore.kernel.org/r/CAFjuqNi+knSb9WVQOahCVFyxsiqoGgwoM7Z1aqDBebNzp_-jYw@mail.gmail.com/
>> > [2] https://lore.kernel.org/r/20191021160952.GA229204@google.com/
>> 
>> I guess this problem is still unfixed?  I hate the fact that we broke
>> something that used to work.
>> 
>> Maybe we need some sort of DMI check in ricoh_mmc_fixup_rl5c476() so
>> we skip it for Toughbooks?  Or maybe we limit the quirk to the
>> machines where it was originally needed?
> 
> Both options seems reasonable to me. Do you have time to put together a 
> patch?
> 
> Kind regards
> Uffe
