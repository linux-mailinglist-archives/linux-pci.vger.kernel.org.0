Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E759A2D4CF4
	for <lists+linux-pci@lfdr.de>; Wed,  9 Dec 2020 22:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388276AbgLIVfb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Dec 2020 16:35:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:44830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387804AbgLIVfb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Dec 2020 16:35:31 -0500
Date:   Wed, 9 Dec 2020 15:34:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607549691;
        bh=Ijxjlj4lL8UE+hp25kexw4TgoGCcQA02I64k1WeFKrw=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=UhR87/9/SGHGsxnhTZM+hwkTVKtTVWVCfjhLkZ4gVTJ0V/BucF92vAzxs3XYqaVUh
         9LnRCv7JNdM4tA5qqQt5+u3OEOJjxPxpNP0YUJs5gzX3zYEhOhii1vio+F9KwapVAT
         x95HYpilhT8X0umpXgc4tt1wIUwKq9+HcOrgwDk6Jh5sVGvPFmZiYgEvKXwzSzKZ0a
         /e+jlGom0maC7iFIY10cPdyyaq11fmQrsoDwGNR8cyvh+AibQ1nyGYfWmY48r0aD7X
         kjxCKedr/NRi11USZD0vCSzi5lGK/fizZ7Nlk/cvxSfRbpUqrJAFj9YdJxeAtLvHZ8
         Qs3rcDwNBgc5Q==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Michael Walle <michael@walle.cc>, lorenzo.pieralisi@arm.com,
        kw@linux.com, heiko@sntech.de, benh@kernel.crashing.org,
        shawn.lin@rock-chips.com, paulus@samba.org,
        thomas.petazzoni@bootlin.com, jonnyc@amazon.com,
        toan@os.amperecomputing.com, will@kernel.org, robh@kernel.org,
        f.fainelli@gmail.com, mpe@ellerman.id.au, michal.simek@xilinx.com,
        linux-rockchip@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, jonathan.derrick@intel.com,
        linux-pci@vger.kernel.org, rjui@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, Jonathan.Cameron@huawei.com,
        bhelgaas@google.com, linux-arm-kernel@lists.infradead.org,
        sbranden@broadcom.com, wangzhou1@hisilicon.com,
        rrichter@marvell.com, linuxppc-dev@lists.ozlabs.org,
        nsaenzjulienne@suse.de,
        Alexandru Marginean <alexm.osslist@gmail.com>
Subject: Re: [PATCH v6 0/5] PCI: Unify ECAM constants in native PCI Express
 drivers
Message-ID: <20201209213449.GA2546712@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209212017.vx7dps3jasjcwg6j@skbuf>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 09, 2020 at 11:20:17PM +0200, Vladimir Oltean wrote:
> On Wed, Dec 09, 2020 at 02:59:13PM -0600, Bjorn Helgaas wrote:
> > Yep, that's the theory.  Thanks for testing it!
> 
> Testing what? I'm not following.

You posted a patch that you said fixed the bug for you.  The fix is
exactly the theory we've been discussing, so you have already verified
that the theory is correct.

I'm sure Krzysztof will update his patch, and we'll get this tidied up
in -next again.

Bjorn
