Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 805E210A729
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2019 00:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfKZXhh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Nov 2019 18:37:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:42818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbfKZXhh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Nov 2019 18:37:37 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD951206CC;
        Tue, 26 Nov 2019 23:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574811457;
        bh=+Mdzm22zPeF5+afyhd9ngmeJjwhXyMQ7rcNDgR7rfDg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=WfrUfCU8uRk9dUy01UDr4rVnfRyGrzkUmm8ZkU5FIzmuWdMEut37iCOLiUna8KlcD
         BsNAJq/wnZjD2QhjxTS2FvwNBNVkFs2vLSns2HO+EI7nhzh4086zq0rKCXbspDfYuq
         9QTwzIetDCnXyC8HsWK3NPe/O0vVDeg+ezwajnKM=
Date:   Tue, 26 Nov 2019 17:37:35 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     Austin Bolen <austin_bolen@dell.com>, keith.busch@intel.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukas@wunner.de
Subject: Re: [PATCH] PCI: pciehp: Make sure pciehp_isr clears interrupt events
Message-ID: <20191126233735.GA215993@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7ac93e3-9a1f-2cd5-bf0b-30b562bd707d@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 25, 2019 at 03:03:23PM -0600, Stuart Hayes wrote:
> 
> On 11/12/19 3:59 PM, Stuart Hayes wrote:
> > The pciehp interrupt handler pciehp_isr() will read the slot status
> > register and then write back to it to clear just the bits that caused the
> > interrupt. If a different interrupt event bit gets set between the read and
> > the write, pciehp_isr() will exit without having cleared all of the
> > interrupt event bits, so we will never get another hotplug interrupt from
> > that device.
> > 
> > That is expected behavior according to the PCI Express spec (v.5.0, section
> > 6.7.3.4, "Software Notification of Hot-Plug Events").
> > 
> > Because the "presence detect changed" and "data link layer state changed"
> > event bits are both getting set at nearly the same time when a device is
> > added or removed, this is more likely to happen than it might seem. The
> > issue can be reproduced rather easily by connecting and disconnecting an
> > NVMe device on at least one system model.
> > 
> > This patch fixes the issue by modifying pciehp_isr() to loop back and
> > re-read the slot status register immediately after writing to it, until
> > it sees that all of the event status bits have been cleared.
> > 
> > Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> 
> Bjorn,
> 
> Do you have any comments or issues with this patch set?  Anything I can do?

Were you planning to address Lukas' comments?

https://lore.kernel.org/r/20191114025022.wz3gchr7w67fjtzn@wunner.de
