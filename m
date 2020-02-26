Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44D9416F4CF
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2020 02:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbgBZBNP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Feb 2020 20:13:15 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:33120 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729376AbgBZBNP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Feb 2020 20:13:15 -0500
Received: by mail-qv1-f66.google.com with SMTP id ek2so601562qvb.0;
        Tue, 25 Feb 2020 17:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g9IVOOyveIOG/WhiBrdQii/HTAWJ7aaj0Z2qhoJV+kg=;
        b=QOfwGYa5MV/yzhdx+dRDusu+NUxWqul4DSDbRfveZbqA44oF8qX5RemktrjpArDn5h
         N+TrwhG1R3JEKXWSLpRzC9+oVOaNLdfeG140uECoHq/z3r+02U+S4Dq3AEkaXXnlJUMe
         btwCsi3Wyu9q+0+evx7rkITektujyfpQ6sMTtyltsFoWqxWfPBR8LzExhlaNbRk0RNYF
         Bg9rhIvVI5b7Y7XiH9OuBIBh2+RudzY7zEb41iizlA8r3zYw+bluytOHr74TtHKzKRWi
         tql2pPMLJF9Vx/UMyDmtrn294A4UPWlo8iZKHhr/V8DUV+QAWNS8EySQbL6/kasnrMBe
         B/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=g9IVOOyveIOG/WhiBrdQii/HTAWJ7aaj0Z2qhoJV+kg=;
        b=IO9hcIut0CTS+sgwpLsKCwF/cqKAZQKqrpynIO5kxVLOsfMY07F9KpzRfUWUKb1OAr
         VNCvjk/Ex8ZPPERqiNFBjfz0gvtyQ2JC8PSP48POCrd5tUdZW77Q/80gPwLai5XOiPt0
         aZdiTF2Xs4c6q82qUuBiX1yLFPcZW0gTAOtMbNb5hMEfzf4HbLK8o7D2ZG6BO7zUnXZV
         s2i86bjmrSnASABnHBN4aOs7JN7g3iKoA0FisCI1/fb3kCiyjBAFfCRJzoKQ8Fquc8gB
         sT+3liWR6pmq4D1/rFMB7Mu6yARslWyLxAJLVV8sCxT2Yl+yQHQk0ot0UYsWbS8iHXI5
         vZIQ==
X-Gm-Message-State: APjAAAWl+9NKBFu9Rlh7j44Ie7SnkGh07wlPBJjCut4h4gMX/n5tEPSu
        0k/HakUI5+ChltHLb7EwSQs=
X-Google-Smtp-Source: APXvYqwVyIi4Q0mevSguwQvmEVF9QrMusalzNCHa8YtOT+DvMKFxwuuiuBI7P25L2wWhoBOqHxh0kg==
X-Received: by 2002:a0c:fb0f:: with SMTP id c15mr2008613qvp.209.1582679594257;
        Tue, 25 Feb 2020 17:13:14 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id y91sm228656qtd.13.2020.02.25.17.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 17:13:13 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 25 Feb 2020 20:13:12 -0500
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "Michael ." <keltoiboy@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Trevor Jacobs <trevor_jacobs@aol.com>,
        Kris Cleveland <tridentperfusion@yahoo.com>,
        Jeff <bluerocksaddles@willitsonline.com>,
        Morgan Klym <moklym@gmail.com>,
        Philip Langdale <philipl@overt.org>,
        Pierre Ossman <pierre@ossman.eu>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: PCI device function not being enumerated [Was: PCMCIA not
 working on Panasonic Toughbook CF-29]
Message-ID: <20200226011310.GA2116625@rani.riverdale.lan>
References: <20191029170250.GA43972@google.com>
 <20200222165617.GA207731@google.com>
 <CAPDyKFq_exHufHyibFCjS78PTZ7duS9ZSt3vi18CNM6+jMmwnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPDyKFq_exHufHyibFCjS78PTZ7duS9ZSt3vi18CNM6+jMmwnw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 25, 2020 at 04:03:32PM +0100, Ulf Hansson wrote:
> On Sat, 22 Feb 2020 at 17:56, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Tue, Oct 29, 2019 at 12:02:50PM -0500, Bjorn Helgaas wrote:
> > > [+cc Ulf, Philip, Pierre, Maxim, linux-mmc; see [1] for beginning of
> > > thread, [2] for problem report and the patch Michael tested]
> > >
> > > On Tue, Oct 29, 2019 at 07:58:27PM +1100, Michael . wrote:
> > > > Bjorn and Dominik.
> > > > I am happy to let you know the patch did the trick, it compiled well
> > > > on 5.4-rc4 and my friends in the CC list have tested the modified
> > > > kernel and confirmed that both slots are now working as they should.
> > > > As a group of dedicated Toughbook users and Linux users please accept
> > > > our thanks your efforts and assistance is greatly appreciated.
> > > >
> > > > Now that we know this patch works what kernel do you think it will be
> > > > released in? Will it make 5.4 or will it be put into 5.5 development
> > > > for further testing?
> > >
> > > That patch was not intended to be a fix; it was just to test my guess
> > > that the quirk might be related.
> > >
> > > Removing the quirk solved the problem *you're* seeing, but the quirk
> > > was added in the first place to solve some other problem, and if we
> > > simply remove the quirk, we may reintroduce the original problem.
> > >
> > > So we have to look at the history and figure out some way to solve
> > > both problems.  I cc'd some people who might have insight.  Here are
> > > some commits that look relevant:
> > >
> > >   5ae70296c85f ("mmc: Disabler for Ricoh MMC controller")
> > >   03cd8f7ebe0c ("ricoh_mmc: port from driver to pci quirk")
> > >
> > >
> > > [1] https://lore.kernel.org/r/CAFjuqNi+knSb9WVQOahCVFyxsiqoGgwoM7Z1aqDBebNzp_-jYw@mail.gmail.com/
> > > [2] https://lore.kernel.org/r/20191021160952.GA229204@google.com/
> >
> > I guess this problem is still unfixed?  I hate the fact that we broke
> > something that used to work.
> >
> > Maybe we need some sort of DMI check in ricoh_mmc_fixup_rl5c476() so
> > we skip it for Toughbooks?  Or maybe we limit the quirk to the
> > machines where it was originally needed?
> 
> Both options seems reasonable to me. Do you have time to put together a patch?
> 
> Kind regards
> Uffe

The quirk is controlled by MMC_RICOH_MMC configuration option. At least
as a short-term fix a bit better than patching the kernel, building one
with that config option disabled should have the same effect.

From the commit messages, the quirk was required to support MMC (as
opposed to SD) cards in the SD slot. I would assume this will be an
issue with the chip in any machine as the commit indicates that the
hardware in the chip detects MMC cards and doesn't expose them through
the SDHCI function.

It looks like the quirk was only enabled by default in 2015, at least
upstream [1], though in Debian it was enabled in May 2010 going by their
git repo, maybe in 2.6.32-16.

[1] commit ba2f73250e4a ("mmc: Enable Ricoh MMC quirk by default")
