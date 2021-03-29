Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C1B34D59D
	for <lists+linux-pci@lfdr.de>; Mon, 29 Mar 2021 19:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhC2Q7V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Mar 2021 12:59:21 -0400
Received: from foss.arm.com ([217.140.110.172]:57426 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230329AbhC2Q6y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Mar 2021 12:58:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C4CF1474;
        Mon, 29 Mar 2021 09:58:54 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8067B3F719;
        Mon, 29 Mar 2021 09:58:52 -0700 (PDT)
Date:   Mon, 29 Mar 2021 17:58:47 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jim Quinlan <jquinlan@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] PCI: brcmstb: Use reset/rearm instead of
 deassert/assert
Message-ID: <20210329165847.GA10454@lpieralisi>
References: <20210312204556.5387-1-jim2101024@gmail.com>
 <20210312204556.5387-3-jim2101024@gmail.com>
 <20210329161040.GB9677@lpieralisi>
 <71903454-c20c-31f7-aaee-0d05eb22db7f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71903454-c20c-31f7-aaee-0d05eb22db7f@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 29, 2021 at 09:50:13AM -0700, Florian Fainelli wrote:
> On 3/29/21 9:10 AM, Lorenzo Pieralisi wrote:
> > On Fri, Mar 12, 2021 at 03:45:55PM -0500, Jim Quinlan wrote:
> >> The Broadcom STB PCIe RC uses a reset control "rescal" for certain chips.
> >> The "rescal" implements a "pulse reset" so using assert/deassert is wrong
> >> for this device.  Instead, we use reset/rearm.  We need to use rearm so
> >> that we can reset it after a suspend/resume cycle; w/o using "rearm", the
> >> "rescal" device will only ever fire once.
> >>
> >> Of course for suspend/resume to work we also need to put the reset/rearm
> >> calls in the suspend and resume routines.
> > 
> > Actually - I am sorry but it looks like you will have to split the patch
> > in two since this is two logical changes.
> 
> I do not believe this can be easily split, since there is currently a
> misused of the reset controller API and this patch fixes all call sites
> at once. It would not really make sense to fix probe/remove and then
> leave suspend/resume broken in the same manner.

Right - I was reading the previous versions of the set, it makes sense
to keep it in one logical change.

Do you want me to take it or you prefer an ACK so that it can go via
a different tree ?

Thanks,
Lorenzo
