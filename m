Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E8D2B6A6C
	for <lists+linux-pci@lfdr.de>; Tue, 17 Nov 2020 17:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgKQQiT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Nov 2020 11:38:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:60164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727010AbgKQQiT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Nov 2020 11:38:19 -0500
Received: from localhost (189.sub-72-105-114.myvzw.com [72.105.114.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA0A2217A0;
        Tue, 17 Nov 2020 16:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605631099;
        bh=2Bs/+9brtdJ8Qim1oOERf9SEfxCTiMSLLDSQGAmSgVw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=FJgl0tcRT6TKxDjmnER5PUVWbYUBtf3WNlJCooBmiNQC7EPHXuFU+gsfAWh5vcer9
         SvDxb90pgHzn/bVoIC+qV0f2WK9Z/lkKZOHEIA8qp3ySR7OJ8+VEgM0no0+sZ/zv5o
         9q6GVtsUygiaMPLli/873XLwhSKeFJZF5lX+eQ5c=
Date:   Tue, 17 Nov 2020 10:38:17 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        Lukas Wunner <lukas@wunner.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Time to re-enable Runtime PM per default for PCI devcies?
Message-ID: <20201117163817.GA1397220@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79940973-b631-90f9-dbc4-9579c6000816@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+to Rafael, author of the commit you mentioned,
+cc Mika, Kai Heng, Lukas, linux-pm, linux-kernel]

On Tue, Nov 17, 2020 at 04:56:09PM +0100, Heiner Kallweit wrote:
> More than 10 yrs ago Runtime PM was disabled per default by bb910a7040
> ("PCI/PM Runtime: Make runtime PM of PCI devices inactive by default").
> 
> Reason given: "avoid breakage on systems where ACPI-based wake-up is
> known to fail for some devices"
> Unfortunately the commit message doesn't mention any affected  devices
> or systems.
> 
> With Runtime PM disabled e.g. the PHY on network devices may remain
> powered up even with no cable plugged in, affecting battery lifetime
> on mobile devices. Currently we have to rely on the respective distro
> or user to enable Runtime PM via sysfs (echo auto > power/control).
> Some devices work around this restriction by calling pm_runtime_allow
> in their probe routine, even though that's not recommended by
> https://www.kernel.org/doc/Documentation/power/pci.txt
> 
> Disabling Runtime PM per default seems to be a big hammer, a quirk
> for affected devices / systems may had been better. And we still
> have the option to disable Runtime PM for selected devices via sysfs.
> 
> So, to cut a long story short: Wouldn't it be time to remove this
> restriction?

I don't know the history of this, but maybe Rafael or the others can
shed some light on it.
