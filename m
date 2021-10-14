Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF2142E320
	for <lists+linux-pci@lfdr.de>; Thu, 14 Oct 2021 23:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbhJNVNQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Oct 2021 17:13:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:55720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230094AbhJNVNM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Oct 2021 17:13:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 676696109E;
        Thu, 14 Oct 2021 21:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634245866;
        bh=iiZ6JDHivyFJbkZ5sNSTIAKzOMToedWLnGi56Ob1Wb0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ilQBTUta8SxuOu3VB24+5GlLTg35LyBFQUH72Zn3MLJfmfDqIUnUOy5bNSGIdyVhH
         cAsNyw4lxbrjmy1dOEugJkhKItZj9zk9YTGzJSzyYNQhlyHEzNZRjJZaqOV/nzH891
         J1+L5sU/+R9fycG93wz7PGHu93nf7TpPvspvZc3zB4TLnygQQXJ6CmKjeXGQQSygDW
         XhYDQSwJaRBH1CUEUYLymtHAvuAPyfAo/8Om0r70WxlOXwgTSGHCzfBurxHOpcumvb
         SuhXdl4d+b+2wNiI7FyVt8LP+P1FgcueAcI0+FtkVa3jkt5pjEMbKc/KSut6AORcal
         WOeOL7m/hSRjw==
Date:   Thu, 14 Oct 2021 16:11:04 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/1] x86/PCI: Ignore E820 reservations for bridge
 windows on newer systems
Message-ID: <20211014211104.GA2048701@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014153908.4812-1-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 14, 2021 at 05:39:07PM +0200, Hans de Goede wrote:
> Hi All,
> 
> Here is v4 of my patch to address the E820 reservations vs PCI host bridge
> ranges issue which are causing touchpad and/or thunderbolt issues on many
> different laptop models.
> 
> I believe that this is ready for merging now.
> 
> Bjorn, can you review/ack this please ?
> 
> x86/tip folks it would be ideal if you can pick this up and send it out
> as a fix to Linus for 5.15. This fixes a bug which has been plaguing a
> lot of users (see all the bug links in the commit msg).

FWIW, I think there's a v5 coming.
