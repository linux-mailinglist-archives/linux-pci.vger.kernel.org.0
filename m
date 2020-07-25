Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C07322D9DB
	for <lists+linux-pci@lfdr.de>; Sat, 25 Jul 2020 22:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgGYU1t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Jul 2020 16:27:49 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:60735 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbgGYU1t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Jul 2020 16:27:49 -0400
Received: from dante.cb.ettle ([143.159.226.70]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.163]) with ESMTPSA (Nemesis) id
 1MG9c4-1k0YHa0v5Y-00GVa0; Sat, 25 Jul 2020 22:27:34 +0200
Message-ID: <aaa64572fac0fc411b79a9adb59b5bbcbdf4b1a8.camel@ettle.org.uk>
Subject: Re: rtsx_pci not restoring ASPM state after suspend/resume
From:   James Ettle <james@ettle.org.uk>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?Q?=E5=90=B3=E6=98=8A=E6=BE=84?= Ricky 
        <ricky_wu@realtek.com>
Cc:     Rui Feng <rui_feng@realsil.com.cn>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Len Brown <lenb@kernel.org>,
        Puranjay Mohan <puranjay12@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacopo De Simoi <wilderkde@gmail.com>
Date:   Sat, 25 Jul 2020 21:27:11 +0100
In-Reply-To: <20200724231309.GA1551055@bjorn-Precision-5520>
References: <20200724231309.GA1551055@bjorn-Precision-5520>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:EA9tER/Bd2hSFPo8Zx7zt1ovwlzKiRiE/2Mb+rFMyCQNZ94yn8h
 32trVTFpvlNCdZG2EdRTb4vpPYGEpkDE7A3vE0QEHETZfcuJACx8jSLHgPRWwhcatGnhYPl
 gzm8up2coi4KEamEz0R6ksGfJI/Qf14K+Kto4gaXCHTXgJ6+4ouWpXbeYAQY4gIDS7iTy+9
 +hjMgTPvIj7NUgQZnV2yw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JZjZTjOj7SQ=:0KLvKiujkBxA7xC2K0ojRP
 ehek6TkvcfaKJtlg1SEXJn49se4KFhN6rU6nhURuL7+L3+LZyldDNxpOwJPB2nQSb2fuNdyau
 l2ngyyK6drHvr1UICh26PK8iiKwUQhg57UCsaZm81zC9S/mnsD7UR5WMa0eGtOYkul04k+0jD
 081QD9JqXZ0kxUABDyG0wu2An3sGeOAwVHQLt3wjTYSFaU3HdtfsIS7FSuKKpq5Vwo3//HUz+
 JzzB874Y6vqCtTHoeyxJNGCYSMAvJh4n6iz9+HmMZie5/SStSZnXAsw7xrFFMAOyPdZEKzzfF
 Emk/o/ZxWdH5aT/PwMX7FQpl8+gQPzptQywRgAnhcAlqdAu25sa2p/qqwl0/CE/bOHY67smtY
 Ox3BXyZ68F9RjpQqWFR/ABHYFbK0Ci6slvdMnC4ncJGXUTksIA3npZSTBib/50SL+zUkYu/CY
 oM4jcmpTSZiX4y41K+WNSz2gwU/YSHvCSgu0MImdOePchi9g5LHotWqe2pSi7wIiSVFxDcGVQ
 aDdrpQRUJ7ne9QwpTByT1kXuUbR76yQoVFLEgN5yZlhvUlDs2JSwbkoWiQCxocZMebwBP2yht
 eD0azSCJOJMooBskIMuQB+vXw6ApPJTkD6+AA0evsxodGjZkVDDvdbW0bAjMiy0K5eIgtjbL/
 1LdfXgeLJC0Ur/HUvor9W4ZVz/QQpyiZ11CL67hUZ9HCI/2mmzIk7zXAO/Z9FJPVCkl+KYMbc
 KegWW4/1lSrZUd7YmMuGDvONxOo3l8NZMhqFjIufkmYxS5qdHKZSWBKQW/xl4ryJ/17EAJEsG
 FzWqRSGPjvf6fI0dIWgTiyrtCq3ALaT9f3V56s55NfAf0pkDH79xkhVy9LD0tgHNrUV4LK5
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 2020-07-24 at 18:13 -0500, Bjorn Helgaas wrote:
> 
> Maybe we should simplify this a little bit more.  James, if you don't
> touch ASPM config at all, either manually or via udev, does the ASPM
> configuration stay the same across suspend/resume?
> 

Yes, it stays the same. Explicitly: 

With the udev rule disabled, immediately following clean boot from
power-off (and no additional tinkering), ASPM is OFF to the best of my
knowledge:

 - link/l1_aspm in sysfs is 0 for PCI devices 0000:01:00.[01];
 - the processor sleeps no deeper than package C3.

The situation above is the same following a suspend/resume cycle --
both in terms of sysfs, and observed package C-state occupancy.

[Tested on kernel 5.7.10, but the behaviour is the same as prior
kernels.]

Thanks,
James.

