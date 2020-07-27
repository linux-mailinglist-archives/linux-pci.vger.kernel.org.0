Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 117EC22F985
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jul 2020 21:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbgG0Twp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jul 2020 15:52:45 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:46655 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728348AbgG0Two (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jul 2020 15:52:44 -0400
Received: from dante.cb.ettle ([143.159.226.70]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.179]) with ESMTPSA (Nemesis) id
 1MDhth-1k6zik1Bvr-00Am5E; Mon, 27 Jul 2020 21:52:29 +0200
Message-ID: <f02332767323fc3ecccea13dd47ecfff12526112.camel@ettle.org.uk>
Subject: Re: rtsx_pci not restoring ASPM state after suspend/resume
From:   James Ettle <james@ettle.org.uk>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     =?UTF-8?Q?=E5=90=B3=E6=98=8A=E6=BE=84?= Ricky 
        <ricky_wu@realtek.com>, Rui Feng <rui_feng@realsil.com.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Len Brown <lenb@kernel.org>,
        Puranjay Mohan <puranjay12@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacopo De Simoi <wilderkde@gmail.com>
Date:   Mon, 27 Jul 2020 20:52:25 +0100
In-Reply-To: <20200727141438.GA1743062@bjorn-Precision-5520>
References: <20200727141438.GA1743062@bjorn-Precision-5520>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:9hfivm38n1X2xOxy/Suu/TO1CvJBOaht+YsoUaogoxU2UatFES1
 yLbIx7EiMtZhjackxSMSZoMYO8ABl6QCTeqHGkykO4ApN3mCjgRPNtF5RciMeU0EM69bu2S
 OynHPsgfDsivKrc6SkbIs2lGnk8XKXsRhl+4uLfUfNHrtcy3+v9xkwFnMQE9OzS6uLvjFKp
 swW30Q12/xmzaYP+eWX5Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ftS2pohcS44=:t9NtZstD6U5IboUkPoKZr/
 QuBjV/xi+EqWcbyOcIFWFIJshm/cxNM7FxtJVqjAEhnD7O6LpxKq+JP2unecoONFokTC9S/OJ
 i/c7U6pwvgTY3kKrTFX1W1pakuXJDBp7a1pG2vLzpFnSjX4xnBbuzh+faqGUWc8IJibbQoEdh
 LWfZmkWq05eCeDlIh5KZfCrurarxASSPuC/NCyew/ivYUDVO0WWidbXEOayMN4/4BUZDM2TlJ
 tgrCDVfcjCgVoDm/Qk6a8u4q1cliB2st7gdtzwE3BMG/0ox4Peas6AkUKi0B547p1lS9/NP2p
 MmgulaBcXD5d3ocSibBiBm47Bsb8DiGRnZDMzsyh+GzLGZ5wXJ0EisQmrRyvXoT7oQIC5/Npi
 v1WliQ5cnNwWolvZ4gVt0HmDo0ltEju1iuPARcgiXmhOdhw1SzjeDXoVc64YbZ35odewz6gCP
 R4wyfUjVGtArz4SIGpVFpB8jmsaW04Q1hvenZiREgEpEmY/ULOwyT6lbZ4zB6kwnU3yY8OxLT
 MWGP+4tQlQxNUJ08rUazkVbxEBuy1NNkjDcAUsBc+jatGsGqfBlpsCVy+GL1BRUqUWrBp3kpJ
 hLjnU6dB9a0CHOcmyCy5y3LLX/xmF7KP5zbdvw/GODMLhbY3RJ9z44e2CzB/1PnMo9Iz4LMCG
 +DdMSfslEQNb2AJaFC9zWBQJycwowss57O1tPSrkT2EWhdXU6AzMELjhyHZIt6AflaciqxCcx
 aKnumUXOBrUtxhy3yC7GZGJ+MZt2t6mdKzwZAkKWj99YmjUTEVJ3Ys0JMzsfVKw7tl9zq4r/T
 AccI7JgKavL12PVXGy1R5pu4lf3SztPcBEmVnuKGcPaf9pWFdu2AhmRiGXzIAxDbT6dhJRK
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2020-07-27 at 09:14 -0500, Bjorn Helgaas wrote:
> I don't know the connection between ASPM and package C-states, so I
> need to simplify this even more.  All I want to do right now is
> verify
> that if we don't have any outside influences on the ASPM
> configuration
> (eg, no manual changes and no udev rules), it stays the same across
> suspend/resume.

Basically this started from me observing deep package C-states weren't
being used, until I went and fiddled with the ASPM state of the
rtsx_pci card reader under sysfs -- so phenomenological poking on my
part.

> So let's read the ASPM state directly from the
> hardware like this:
> 
>   sudo lspci -vvs 00:1d.0 | egrep "^0|Lnk|L1|LTR|snoop"
>   sudo lspci -vvs 01:00   | egrep "^0|Lnk|L1|LTR|snoop"
> 
> Can you try that before and after suspend/resume?

I've attached these to the bugzilla entry at:

https://bugzilla.kernel.org/show_bug.cgi?id=208117

Spoiler: With no udev rules or suspend hooks, things are the same
before and after suspend/resume. One thing I do see (both before and
after) is that ASPM L0s and L1 is enabled for the card reader, but
disabled for the ethernet chip (does r8169 fiddle with ASPM too?).

[Oddly when I set ASPM (e.g. using udev) the lspci tools show ASPM
enabled after a suspend/resume, but still no deep package C-states
until I manually fiddle via sysfs on the card reader. Sorry if this
only muddies the water further!]

Thanks,
-James



