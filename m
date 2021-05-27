Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C16E3393467
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 18:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235252AbhE0Q6k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 12:58:40 -0400
Received: from foss.arm.com ([217.140.110.172]:60548 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236727AbhE0Q6g (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 May 2021 12:58:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE63D11D4;
        Thu, 27 May 2021 09:57:02 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FD723F719;
        Thu, 27 May 2021 09:57:01 -0700 (PDT)
Date:   Thu, 27 May 2021 17:56:55 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] Revert "arm64: PCI: Exclude ACPI "consumer"
 resources from host bridge windows"
Message-ID: <20210527165655.GA21788@lpieralisi>
References: <20210527093200.GA16444@lpieralisi>
 <20210527163452.GA1402454@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527163452.GA1402454@bjorn-Precision-5520>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 27, 2021 at 11:34:52AM -0500, Bjorn Helgaas wrote:

[...]

> > > https://lore.kernel.org/r/20210510234020.1330087-1-luzmaximilian@gmail.com
> > 
> > Sigh. We can't apply this patch since it would trigger regressions on
> > other platforms (IIUC the root complex registers would end up in the
> > host bridge memory windows).
> > 
> > I am not keen on reverting commit 8fd4391ee717 because it does the
> > right thing.
> > 
> > I think this requires a quirk and immediate reporting to Microsoft.
> > 
> > Bjorn, what are your thoughts on this ?
> 
> In retrospect, I think 8fd4391ee717 (which I wrote), was probably a
> mistake.
> 
> Sure, it's a nice idea to have PNP0A03 _CRS methods that work nicely
> as designed, by describing host bridge registers as "consumer"
> resources and host bridge windows as "producer" registers, instead of
> having the bridge registers in _CRS of an unrelated PNP0C02 device.
> 
> But realistically, the PNP0A03/PNP0C02 issue is a solved problem, even
> though it's ugly, and I'm not sure why I thought Microsoft would see
> value in doing this differently on arm64 than on x86 and ia64.

We hoped we could comply with the specs, given that we were starting
from a clean slate (and not from ACPI tables cut and paste)

> What would break if we reverted 8fd4391ee717?  I guess any arm64
> platforms that described host bridge register space in PNP0A03 _CRS
> "consumer" resources ?

Yes. We would end up with that register space in the host bridge memory
windows - this does not sound right.

> And Windows probably doesn't work or isn't supported on those
> platforms?

By the look of it the answer is yes, Windows was not bootstrapped on
those platforms given that I *assume* Windows does not discriminate
between producer and consumer resources at all.

Lorenzo
