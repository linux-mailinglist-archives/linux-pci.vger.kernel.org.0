Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34AEC1E90D6
	for <lists+linux-pci@lfdr.de>; Sat, 30 May 2020 13:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbgE3Ldz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 30 May 2020 07:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbgE3Ldz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 30 May 2020 07:33:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8790AC03E969;
        Sat, 30 May 2020 04:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uBs5qA4b4HpHoQWurKlW7KyHPg6+1oDn7PTuK57+Tk0=; b=IMwvZtlWkoReIdDdp8GfPd1IaK
        rweQ97xMVVudMr4rghIG7Ph4wDb5B+v3ELxgAMCXyaDZWLjmFlqnlrv0K3NzIPUgF9nJFKYpjtGUH
        Zl1heV2A1hGNxoL+wBQKhjercn0Nr4cMI2jMWEzdtJmsWvsjRxlixrXQHFUjo5Ao8jDRDYfJfmSmh
        0iDrdxI/B5ZUELjBcIwR2I31rBDm+cy3ghjORls71Te+oqG9qUl9IEu5bdZwwutgG7HWD/Uq88Jgk
        UzWS5VtFOTGHIJ4o7mb3sF2OvC6KloCsEbEwrONDPhCylf3wLwRIOTfHOFyPJhgz+j3/14wKkpDl/
        1vZSxPPw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jezkG-0004GI-MC; Sat, 30 May 2020 11:33:44 +0000
Date:   Sat, 30 May 2020 04:33:44 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: Lost PCIe PME after a914ff2d78ce ("PCI/ASPM: Don't select
 CONFIG_PCIEASPM by default")
Message-ID: <20200530113344.GA2834@infradead.org>
References: <bdc33be8-1db6-b147-cbc4-90fa0dc3d999@gmail.com>
 <20200529202135.GA461617@bjorn-Precision-5520>
 <20200529205900.whx3mxuvt6ijlqwg@srcf.ucam.org>
 <824d63d8-668c-22c8-a303-b44e30e805e1@gmail.com>
 <20200529225801.szl4obsas6ndilz4@srcf.ucam.org>
 <7c8cab08-e2d4-1952-1923-aa023ea67657@gmail.com>
 <20200530071434.vjkqxfmgo7xpls6j@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200530071434.vjkqxfmgo7xpls6j@srcf.ucam.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, May 30, 2020 at 08:14:34AM +0100, Matthew Garrett wrote:
> On Sat, May 30, 2020 at 08:33:50AM +0200, Heiner Kallweit wrote:
> 
> > It *was* default y. This changed with a914ff2d78ce ("PCI/ASPM: Don't
> > select CONFIG_PCIEASPM by default") and that's what triggered the
> > problem. If there's no easy solution, then maybe it's best to revert
> > the change for now.
> 
> Oh, sorry, I was looking at mainline. CONFIG_PCIEASPM should 
> *definitely* be enabled by default - platforms expect the OS to support 
> it. If we want to get rid of default y then I think it'd make more sense 
> to have a CONFIG_DISABLE_PCIEASPM that's under EXPERT, and people who 
> really want to disable the code can do so.

I think the fact that the EXPERT didn't get removed in the above bug
is a defintive bug.  But I'd go further and think the CONFIG_PCIEASPM
option should be removed entirely.  There is absolutely no good reason
to not build this small amount of code if PCIe support is enabled.
