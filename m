Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7DD2DED41
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2019 15:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbfJUNPQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Oct 2019 09:15:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:43368 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726767AbfJUNPQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Oct 2019 09:15:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 07225B712;
        Mon, 21 Oct 2019 13:15:14 +0000 (UTC)
Date:   Mon, 21 Oct 2019 15:15:14 +0200
Message-ID: <s5hv9sidyu5.wl-tiwai@suse.de>
From:   Takashi Iwai <tiwai@suse.de>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] PCI: Add a helper to check Power Resource Requirements _PR3 existence
In-Reply-To: <s5hlftih26g.wl-tiwai@suse.de>
References: <20191018073848.14590-1-kai.heng.feng@canonical.com>
        <s5hr23ah3g9.wl-tiwai@suse.de>
        <4C18DF4A-FAE8-4762-AF65-F892A4845297@canonical.com>
        <s5hlftih26g.wl-tiwai@suse.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI/1.14.6 (Maruoka)
 FLIM/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL/10.8 Emacs/25.3
 (x86_64-suse-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI 1.14.6 - "Maruoka")
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 18 Oct 2019 10:45:43 +0200,
Takashi Iwai wrote:
> 
> On Fri, 18 Oct 2019 10:30:11 +0200,
> Kai-Heng Feng wrote:
> > 
> > 
> > 
> > > On Oct 18, 2019, at 16:18, Takashi Iwai <tiwai@suse.de> wrote:
> > > 
> > > On Fri, 18 Oct 2019 09:38:47 +0200,
> > > Kai-Heng Feng wrote:
> > >> 
> > >> A driver may want to know the existence of _PR3, to choose different
> > >> runtime suspend behavior. A user will be add in next patch.
> > >> 
> > >> This is mostly the same as nouveau_pr3_present().
> > >> 
> > >> Reported-by: kbuild test robot <lkp@intel.com>
> > > 
> > > It's confusing -- this particular change isn't reported by the test
> > > bot, but only about the lack of the CONFIG_ACPI ifdef.
> > 
> > Hmm, because the test bot asked to add the tag.
> 
> Yes, but it's only if you add a new fix patch on top of it.
> You can write some their credit, too, but basically it'd be enough to
> point to the Link tag to the thread.
> 
> > If it's not appropriate will you drop it? I can also send a v7.
> 
> I can modify in my side.

Now I merged both patches to for-next branch.


thanks,

Takashi
