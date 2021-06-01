Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABC9397B9C
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jun 2021 23:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbhFAVRU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Jun 2021 17:17:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:52100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234707AbhFAVRS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Jun 2021 17:17:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC3DB613B1;
        Tue,  1 Jun 2021 21:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622582137;
        bh=MDPBQO0xqyU7JBB9JwRSYLds63k/uuGat5vpQ7A4njc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bSuITOEGklerNUdwfdDUPRaa0sv02WeF3vfGVQm+q4QtjNzuW0oQPjWNzhwzFmKdi
         JGflQXpBM9t+P8cmFT1iXGBnPTImN05mSzaWD9LEHVA+Q1ZvDjjdpeIxrty66S8pCD
         8qGJcrx/bhUW3o4Oq1IUH8CVf3O7hABOqojsOw7rJs7dzdNdt4r+aChNgtftDxVQCj
         bggMptdhhcmXEf7+QXTSYltihHZmBdd6btr6HMKfGnLuMNJdWYWokXGHPyQT76jkTm
         keQYuYMaBLAGDgi08zIQOJgM4j6zjlxmvewmNiZ91r9YGeyZ5YW6EBXBu58ifEPPGq
         jp0sq1cGktsXQ==
Date:   Tue, 1 Jun 2021 16:15:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org,
        =?iso-8859-1?Q?R=F6tti?= 
        <espressobinboardarmbiantempmailaddress@posteo.de>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH] PCI: Add Max Payload Size quirk for ASMedia ASM1062 SATA
 controller
Message-ID: <20210601211530.GA1972509@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210601170907.GA1949035@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 01, 2021 at 12:09:09PM -0500, Bjorn Helgaas wrote:
> On Fri, May 28, 2021 at 02:12:08AM +0200, Pali Rohár wrote:
> > On Tuesday 11 May 2021 18:16:12 Marek Behún wrote:
> > > Ping? :)
> > > 
> > > Marek
> > 
> > Bjorn: Gentle reminder :)
> 
> The current patch [1] doesn't look mergeable as-is.
> 
>   - "ASM1062 SATA controller causes an External Abort on controllers
>     which support Max Payload Size >= 512" doesn't sound like a
>     correct description.
> 
>     That description suggests the problem is with the *PCI
>     controller*, not with the ASM1062.  I think that's incorrect; I
>     think the problem is with the ASM1062.
> 
>     I would expect something like "ASM1062 advertises Max_Payload_Size
>     Supported of 512, but in fact it cannot handle TLPs with payload
>     size of 512."

MPS is somewhat complicated, and I don't think we have good
documentation in the Linux source.  FWIW, this paper has a really good
explanation of the MPS (Max Payload Size) and MRRS (Max Read Request
Size) concepts:

https://www.xilinx.com/support/documentation/white_papers/wp350.pdf
