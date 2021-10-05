Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E392C4230E6
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 21:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235206AbhJEToz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 15:44:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:42582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235134AbhJEToz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Oct 2021 15:44:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 063D4610A5;
        Tue,  5 Oct 2021 19:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633462984;
        bh=93hVsy5BdDKlxUJFddXFi3vlWoO0RQGiRnw/E66GdM8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KYhYHG3q0/jMzU2P/lSej5mQZqlS1lOlJajSBxtUbkFvwRSihhtAyHaj7cEsOqc9h
         Oz5+t5YI0rMT5PVj4UvfF2f4JWP6x+0L/krFZ6sKIR7SL6EnRyD2iLNcmjqhXI+9bg
         zCw7M5f0xZ0HIPdq7rJwjqPsG13E94u0OOXE5W6F/EWgfWpM8YHY/8nIq/LcQO9Ny7
         KmmqUAOTgC6gxtRCIqNlmzs/fnfrQQ1+Z0mldWwHkb1l/mR5GYFSuHB7hj1eEgxwlv
         YXQkoH85br8e3dHfM9WzC6KRQ0JcUUFKNRZKRb+N0dYdrecgGUZzC3MR4ha1tYxlnc
         pVdBhqZAsvzUg==
Received: by pali.im (Postfix)
        id 85139812; Tue,  5 Oct 2021 21:43:01 +0200 (CEST)
Date:   Tue, 5 Oct 2021 21:43:01 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, nsaenz@kernel.org, bhelgaas@google.com,
        rjw@rjwysocki.net, lenb@kernel.org, robh@kernel.org, kw@linux.com,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] PCI: brcmstb: Add ACPI config space quirk
Message-ID: <20211005194301.enb5jddzdgczcolx@pali>
References: <20211005153209.GA1083986@bhelgaas>
 <d4b34193-31e5-2f95-6365-b58239c0dabb@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4b34193-31e5-2f95-6365-b58239c0dabb@arm.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

On Tuesday 05 October 2021 10:57:18 Jeremy Linton wrote:
> Hi,
> 
> On 10/5/21 10:32 AM, Bjorn Helgaas wrote:
> > On Thu, Aug 26, 2021 at 02:15:55AM -0500, Jeremy Linton wrote:
> > > Additionally, some basic bus/device filtering exist to avoid sending
> > > config transactions to invalid devices on the RP's primary or
> > > secondary bus. A basic link check is also made to assure that
> > > something is operational on the secondary side before probing the
> > > remainder of the config space. If either of these constraints are
> > > violated and a config operation is lost in the ether because an EP
> > > doesn't respond an unrecoverable SERROR is raised.
> > 
> > It's not "lost"; I assume the root port raises an error because it
> > can't send a transaction over a link that is down.
> 
> The problem is AFAIK because the root port doesn't do that.

Interesting! Does it mean that PCIe Root Complex / Host Bridge (which I
guess contains also logic for Root Port) does not signal transaction
failure for config requests? Or it is just your opinion? Because I'm
dealing with similar issues and I'm trying to find a way how to detect
if some PCIe IP signal transaction error via AXI SLVERR response OR it
just does not send any response back. So if you know some way how to
check which one it is, I would like to know it too.

> > 
> > Is "SERROR" an ARM64 thing?  My guess is the root port would raise an
> > Unsupported Request error or similar, and the root complex turns that
> > into a system-specific SERROR?

Yes, SError is arm64 specific. It is asynchronous CPU interrupt and
syndrome code then contains what happened.

> AFAIK, what is happening here the CPU core has an outstanding R/W request
> for which it never receives a response from the root port. So basically its
> an interconnect protocol violation that the CPU is complaining about rather
> than something PCIe specific.

Could you describe (ideally in commit message) which SError is
triggered? Normally if kernel receive SError interrupt it also puts into
dmesg or oops message also syndrome code which describe what kind of
error / event occurred. It could help also to other understand what is
happening there.
