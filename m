Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5339A2A298A
	for <lists+linux-pci@lfdr.de>; Mon,  2 Nov 2020 12:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgKBLai (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Nov 2020 06:30:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:36958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728516AbgKBLai (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Nov 2020 06:30:38 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BBD722275;
        Mon,  2 Nov 2020 11:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604316637;
        bh=X8JnEcClp9UY0EBJJar83EIQZ/sedukphcjMgxzniwA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=s3eYWJ4N05JGw5+J/sKBXzA4jKOxGBTv3QKtEmtbFH+eQG0ZYZbnrRoFbkrLQEo8k
         J3xp60f0jrLcPmTns9Q7lBXGpZyNGjzoDZ2w5KPGfjBDrJfgR1mS0IsennEMBptZEA
         uf6FJ8R0fyKiLzl+69lS77KXzFVvcPJpF4lw5sQc=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kZY2k-006drC-O9; Mon, 02 Nov 2020 11:30:35 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 02 Nov 2020 11:30:34 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Frank Wunderlich <linux@fw-web.de>,
        linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: Aw: Re: [PATCH] pci: mediatek: fix warning in msi.h
In-Reply-To: <87pn4w90hm.fsf@nanos.tec.linutronix.de>
References: <20201031140330.83768-1-linux@fw-web.de>
 <878sbm9icl.fsf@nanos.tec.linutronix.de>
 <EC02022C-64CF-4F4B-A0A2-215A0A49E826@public-files.de>
 <87lfflti8q.wl-maz@kernel.org> <1604253261.22363.0.camel@mtkswgap22>
 <trinity-9eb2a213-f877-4af3-87df-f76a9c093073-1604255233122@3c-app-gmx-bap08>
 <87k0v4u4uq.wl-maz@kernel.org> <87pn4w90hm.fsf@nanos.tec.linutronix.de>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <df5565a2f1e821041c7c531ad52a3344@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: tglx@linutronix.de, frank-w@public-files.de, ryder.lee@mediatek.com, linux-mediatek@lists.infradead.org, linux@fw-web.de, linux-kernel@vger.kernel.org, matthias.bgg@gmail.com, linux-pci@vger.kernel.org, bhelgaas@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020-11-01 22:27, Thomas Gleixner wrote:
> On Sun, Nov 01 2020 at 21:47, Marc Zyngier wrote:
>> On Sun, 01 Nov 2020 18:27:13 +0000,
>> Frank Wunderlich <frank-w@public-files.de> wrote:
>> Thinking of it a bit more, I think this is the wrong solution.
>> 
>> PCI MSIs are optional, and not a requirement. I can trivially spin a
>> VM with PCI devices and yet no MSI capability (yes, it is more
>> difficult with real HW), and this results in a bunch of warning, none
>> of which are actually indicative of anything being wrong.
> 
> Well. No.
> 
> The problem is that the device enumerates MSI capability, but the host
> bridge is not proving support for MSI.
> 
> The host bridge fails to mark the bus with PCI_BUS_FLAGS_NO_MSI. That's
> the reason why this runs into this issue.

Right, that's the piece I was missing, thanks for that.

However, that doesn't really address the issue when the host bridge and
the MSI widget are two separate entities, oblivious of each other (which
is a pretty common thing on the ARM side).

In this configuration, you can't really decide whether you have a MSI
domain in the host bridge driver (the association is done in the code
PCI code, after you have registered it with the core code), and by the
time you get a pointer to the bus, the endpoints have already been 
probed.

The following patch makes it work for me (GICv3 guest without an ITS)by
checking for the presence of an MSI domain at the point where we 
actually
perform this association, and before starting to scan for endpoints.

I *think* this should work for the MTK thingy, but someone needs to
go and check.

Thanks,

         M.

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 4289030b0fff..bb363eb103a2 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -871,6 +871,8 @@ static void pci_set_bus_msi_domain(struct pci_bus 
*bus)
  		d = pci_host_bridge_msi_domain(b);

  	dev_set_msi_domain(&bus->dev, d);
+	if (!d)
+		bus->bus_flags |= PCI_BUS_FLAGS_NO_MSI;
  }

  static int pci_register_host_bridge(struct pci_host_bridge *bridge)

-- 
Jazz is not dead. It just smells funny...
