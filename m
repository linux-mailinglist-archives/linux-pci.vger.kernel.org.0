Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F78B36E0D8
	for <lists+linux-pci@lfdr.de>; Wed, 28 Apr 2021 23:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhD1VQG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Apr 2021 17:16:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:52324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229593AbhD1VQF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Apr 2021 17:16:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 992B26143A;
        Wed, 28 Apr 2021 21:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619644519;
        bh=uhdOMZ8tGyNZGea5SRkB1tPekQALrgofje7a/fr1ld0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=aem+iDHKjqn+x1XBM76eh7q9qnPTTNlVIQ9PYEkubDITdzNog5g9E+nUlueO/BYK6
         Y+ng5pcPvjC4XzUGzFsBoGAns4sjlKPeLVPfC6g9Yz3rTSjQ62sSY6QeJRKdmxlZ96
         MUFn233zUTSx3LQ8k/mhlkrCyMMxXosyA5yUtP86ujo8v/ML1Ym3zUvo/RmdToQ8WD
         DQqw+DaEAcYtYvfeS8pn97gom3pCijpfowcPORpOhPQzKHQYKOsAhRmAtc4fd/R+L8
         seVqFXhVYbm+1/Ki3pjpZd3FUo3LkyxmQYtsiSbL0I0HzAf+O9yX4A4kWP/aFYhCZ9
         voSphzFw7uRlA==
Date:   Wed, 28 Apr 2021 16:15:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ian Kumlien <ian.kumlien@gmail.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>
Subject: Re: [PATCH 1/3] PCI/ASPM: Use the path max in L1 ASPM latency check
Message-ID: <20210428211518.GA432124@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA85sZvZ2o5EXK+yM2JBy5wnLb9NL6sfdFyzvqRjq_ZvO8P-aw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 26, 2021 at 04:36:24PM +0200, Ian Kumlien wrote:
> On Thu, Feb 25, 2021 at 11:03 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Wed, Feb 24, 2021 at 11:19:55PM +0100, Ian Kumlien wrote:
> 
> [... 8<...]
> 
> > I think the most useful information would be the ASPM configuration of
> > the tree rooted at 00:01.2 under Windows, since there the NIC should
> > be supported and have good performance.
> 
> So the AMD bios patches to fix USB issues seems to have fixed this
> issue as well!

Really?  That's amazing!  I assume they did this by changing the exit
or acceptable latency values?

It would be really interesting to see the "lspci -vv" output after the
BIOS update.

Thanks a lot for following up on this!

Bjorn
