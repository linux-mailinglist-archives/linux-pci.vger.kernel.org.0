Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B097547E781
	for <lists+linux-pci@lfdr.de>; Thu, 23 Dec 2021 19:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbhLWSMG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Dec 2021 13:12:06 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:53309 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbhLWSMF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Dec 2021 13:12:05 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 2103E223E9;
        Thu, 23 Dec 2021 19:12:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1640283123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nRX7vAwWjeC+5mIHv2fkVxYbCFKHsJmLOBQYXaEnGoc=;
        b=t5jQaHjtifmYXk96YE3zxFBmUUzMx/fAG34lCURwpKTj6zE8naRnTr9HWUtdQmBTs0yM85
        rvUu9QbX1nivR0VyadbTes7pB7y4y7Pt+/TR1Xvk7pw8t+60iOcVXdlrFLWa1S/vSg6b7d
        vYI3aIPMNdYkbajHDCphv9r0N9ciqIk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 23 Dec 2021 19:12:02 +0100
From:   Michael Walle <michael@walle.cc>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH v2] PCI: Fix Intel i210 by avoiding overlapping of BARs
In-Reply-To: <20211223163754.GA1267351@bhelgaas>
References: <20211223163754.GA1267351@bhelgaas>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <9526698be0ced0f7a7ed00bd76538d16@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 2021-12-23 17:37, schrieb Bjorn Helgaas:

> I intended to change the quirk from FINAL to EARLY, but obviously
> forgot.  Here's the updated version:
> 
> commit bb5639b73a2d ("PCI: Work around Intel I210 ROM BAR overlap 
> defect")
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Tue Dec 21 10:45:07 2021 -0600
> 
>     PCI: Work around Intel I210 ROM BAR overlap defect
> 
>     Per PCIe r5, sec 7.5.1.2.4, a device must not claim accesses to its
>     Expansion ROM unless both the Memory Space Enable and the Expansion 
> ROM
>     Enable bit are set.  But apparently some Intel I210 NICs don't work
>     correctly if the ROM BAR overlaps another BAR, even if the 
> Expansion ROM is
>     disabled.
> 
>     Michael reported that on a Kontron SMARC-sAL28 ARM64 system with 
> U-Boot
>     v2021.01-rc3, the ROM BAR overlaps BAR 3, and networking doesn't 
> work at
>     all:
> 
>       BAR 0: 0x40000000 (32-bit, non-prefetchable) [size=1M]
>       BAR 3: 0x40200000 (32-bit, non-prefetchable) [size=16K]
>       ROM:   0x40200000 (disabled) [size=1M]
> 
>       NETDEV WATCHDOG: enP2p1s0 (igb): transmit queue 0 timed out
>       Hardware name: Kontron SMARC-sAL28 (Single PHY) on SMARC Eval
> 2.0 carrier (DT)
>       igb 0002:01:00.0 enP2p1s0: Reset adapter
> 
>     Previously, pci_std_update_resource() wrote the assigned ROM 
> address to the
>     BAR only when the ROM was enabled.  This meant that the I210 ROM 
> BAR could
>     be left with an address assigned by firmware, which might overlap 
> with
>     other BARs.
> 
>     Quirk these I210 devices so pci_std_update_resource() always writes 
> the
>     assigned address to the ROM BAR, whether or not the ROM is enabled.
> 
>     Link: 
> https://lore.kernel.org/r/20201230185317.30915-1-michael@walle.cc
>     Link: https://bugzilla.kernel.org/show_bug.cgi?id=211105
>     Reported-by: Michael Walle <michael@walle.cc>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Tested-by: Michael Walle <michael@walle.cc>

Thanks,
-michael
