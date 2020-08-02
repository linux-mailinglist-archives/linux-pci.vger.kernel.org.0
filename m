Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B555D235878
	for <lists+linux-pci@lfdr.de>; Sun,  2 Aug 2020 18:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbgHBQbR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 2 Aug 2020 12:31:17 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:60051 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgHBQbR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 2 Aug 2020 12:31:17 -0400
Received: from dante.cb.ettle ([143.159.226.70]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.179]) with ESMTPSA (Nemesis) id
 1MVMJ7-1k9b0P0Uzf-00SN5k; Sun, 02 Aug 2020 18:30:58 +0200
Message-ID: <11bdea17bed6fabed7a808111dc66083cb6933c4.camel@ettle.org.uk>
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
Date:   Sun, 02 Aug 2020 17:30:55 +0100
In-Reply-To: <20200728230603.GA1870954@bjorn-Precision-5520>
References: <20200728230603.GA1870954@bjorn-Precision-5520>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:i0uMgft/n0YUHgYJ+xRCTUHuh9ibvCZXeiFxt97RYUxvp/yvjcy
 5M0uVcMKvRlKzJlyrlhiZwlnRP8v4h996XGbR11kFvmMWiImUn7fqhkUh2raYH+aDkCV/fq
 /n2wHzr8X7aUBCgeMzCAyPXnsM8roFlSNw0TvxzQdFrkOH3a2rLlWxHlxbPFfbwGb6AE23c
 1cbJGwhS5E8js/IfDGGUw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3TYrtuwh63g=:PqayZrJ1RA1Gixibc8lcKX
 jRwCXW7NVRaStXmvhenNdxc7K5PwULeA4kfbxmAr4xUrI87qHGnlwKpQ53DYSiecw2//0s0Fs
 uMZfhepWw+9IX8g7y4gYJE0XHmISvQkVGnee0L7aPk4UyoxAyJ8GHKLNy7hyzxj+Tez3g86YW
 KubgT9to+EQj/sL40DwQDbKJj3y4rOwFKcM0o5pOvXk7qHmwsZHSoLkQ7lobjvqQJtzXAVDuS
 +j1qjhXIK2yuIC/tPFwLKxVNAZI6ggxoaAoHKOySZpr4FtVEZHdsh6cTClXa5XR+RTlqwpPcR
 YMOzD+YCoYh2/AVq+uAYywFSILKMsBh9CXUs5ErTgyRte8GAbdNkGdqYcCYygKCsqCSfOowCo
 e50HnJDZ1kCihhIJMmpe8JrDAyTOhjh92wrqIDrt8NFzcKr2ya3NiRewI3RN42jy/rsBV2VQw
 x3GOOw7XfD3AnOqsHlKbeEcSsFuUJmK+cbVg01esqpnXQd9DVALinAycTheuk3HbQuCgkVCdG
 b2W1a8BQ9pTNvMVYREQcYLXfzNwMW7/w7GE5LTu6yXTl7WoYg4+WL7KvduVUVyQOdG1ZuSQXG
 LMHzA9H4NS+3K28bwYmcwM5Pd+6b/ZyKLSiD9mBj3ebzrJdoSc4kE9OzNpc3na40xVovNLLTG
 Dx9iLDIw3CYckuPjXuEWpfrBSAkIx1nJ8jx/mgfge5l5J7XMmKUVYqRQ9Xy20KqbHa3hM+xvm
 UBFD/zwzHoY0H6Wf5hjs1yB1TkIeZUFnkVCfUngfQozVJlYNhp+Eky3BsbGr/69YczDCGeokb
 hw2s/cWLabb5YOG4gsJmIK+KT/P2x8ZsH1edsC0ZjsUVXv+8Aawiq7tfUMiNdu6fHUjW4dA
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

On Tue, 2020-07-28 at 18:06 -0500, Bjorn Helgaas wrote:
> 
> I tried to deduce the problem from the code in aspm.c, but I didn't
> see the problem.  If you have the ability to build a kernel with a
> debug patch, can you boot with the patch below and collect the dmesg
> log?

I've built such a kernel and attached the dmesg output at

https://bugzilla.kernel.org/attachment.cgi?id=290713

For this, the machine was booted from off, no funny udev rules or sysfs
tinkering.

Thanks,
-James

