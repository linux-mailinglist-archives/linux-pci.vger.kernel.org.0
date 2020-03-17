Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28F761889B6
	for <lists+linux-pci@lfdr.de>; Tue, 17 Mar 2020 17:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgCQQDt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Mar 2020 12:03:49 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36388 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgCQQDt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Mar 2020 12:03:49 -0400
Received: by mail-io1-f68.google.com with SMTP id d15so21602564iog.3;
        Tue, 17 Mar 2020 09:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=tfPTr9c+gmB2qTQXjvO8mo7dSeG1TgIoTlBZZFCDn7A=;
        b=sFgcbP6PYCeuXhHguj4wST4XkgksmzOKH68kMPZb29cQrqJ8NlwS3mBc0LSCQWO7kg
         cx/GnKV0gpFGuaNWIGAijeCiAee0Z2ezPDnuI5R0QoXCAzAW3y+jJkZlA9PJyt2A6BZO
         Z6hODg53D9XBSlUDWM6rVHw3d4/M6AVMWWuZOzeXMkvLVowV+TDPeMjuTPc1O5TvhBlC
         d2qhzVL93JcosAKoeHZYxwZnDCy8ELFK3YTKvbrzjnpiQeGNN7q5Q+3FsuOrlLrYCTxp
         BrExwUtsqBDY9eLL7JJG+VfJjsD4vNU8GkivB9utlQfCSVCckYqsqO3yy0+t7KoUhGDu
         2LsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=tfPTr9c+gmB2qTQXjvO8mo7dSeG1TgIoTlBZZFCDn7A=;
        b=cgPe1zlGfcPp18K/wFzpV8q3MunJZF6NfwiYuaCThBFgKouJYQnWXPiUKjmqcS4XWk
         SiUYqyMmgzec9mwwASPWcHT2l1gjMJlgL0bdO2b1RXY3/ts9da66DDAaOOmH80p6Q/JX
         kfXokA497mQgrntkk1WgVFx7oG9hctuOb4OMkp8LOuxgwJFxwLpcXaKN3k3rBX5xXw9X
         tLxjEZBGcgSa4sUGw83wTNaiEIqLUoQiTY+OrNbAgHIa+JnhZOcLyBZ9q5PGhc2JjRZ7
         XO89jGmRzlet0FB6TYG/iPhZMIZsIi92JE5FRiSxsTF/Un+gF0JWMHdHf69OUlRT+SyR
         /g3Q==
X-Gm-Message-State: ANhLgQ0qGMtvN8BbRhuXwlQjYZdP22beeF/BdTyllMfBWmRe84jnBYjK
        2AajB3DGFgfjitgqZYYP/LVtyJc6omRtzdX/mAM=
X-Google-Smtp-Source: ADFU+vuvqVM8SBN+mnHO5V/axjhjcAeMTsMpcyTZV9/6JFSY/eo2kIogHLHEd9X2o9Jb5+gix3jKpSQvQZynyTqZiSo=
X-Received: by 2002:a5d:894d:: with SMTP id b13mr4755616iot.0.1584461028151;
 Tue, 17 Mar 2020 09:03:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <a46938d227f6a11c010943800450a10aac39b7d3.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20200317144203.GE23471@infradead.org> <ebb79d02-53f5-cc23-0b38-72a351a05097@linux.intel.com>
 <20200317150735.GA653@infradead.org>
In-Reply-To: <20200317150735.GA653@infradead.org>
Reply-To: bjorn@helgaas.com
From:   Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date:   Tue, 17 Mar 2020 11:03:36 -0500
Message-ID: <CABhMZUUn2RJWRTGc7xa1XcV3ozBOV24jjwhf6k08sP7XC1ETkw@mail.gmail.com>
Subject: Re: [PATCH v17 06/12] Documentation: PCI: Remove reset_link references
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Raj, Ashok" <ashok.raj@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 17, 2020 at 10:09 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Mar 17, 2020 at 08:05:50AM -0700, Kuppuswamy, Sathyanarayanan wrote:
> > > > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > >
> > >
> > > This should be folded into the patch removing the method.
> > This is also folded in the mentioned patch.
> > https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=review/edr&id=7a18dc6506f108db3dc40f5cd779bc15270c4183
>
> I can't find that series anywhere on the list.  What did I miss?

We've still been discussing other issues (access to AER registers,
synchronization between EDR and hotplug, etc) in other parts of this
thread.  The git branch Sathy pointed to above is my local branch.
I'll send it to the list before putting it into -next, but I wanted to
make progress on some of these other issues first.

Bjorn
