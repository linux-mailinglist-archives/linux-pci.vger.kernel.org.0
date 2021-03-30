Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088F134F1DB
	for <lists+linux-pci@lfdr.de>; Tue, 30 Mar 2021 21:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbhC3T4W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Mar 2021 15:56:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:34420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233257AbhC3T4N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Mar 2021 15:56:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8AAB461919;
        Tue, 30 Mar 2021 19:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617134172;
        bh=yum7BnTjzvfFd8YWV41JNtg+M8BZHBF7euDZJquPwcU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=in4uRNaNoMHJgQUw2mLm3e8FlrrB7/mS+mzgxp8xJvumCAnZQDI98qzQyYCYeNQRK
         CD5JwRXX5SCaRlDQX49FryLZH8ubfzKDVSD4aLjwtNFttHiPGRXhX5x8Yg2AA7em7l
         8PHv6GSOlIgR7ncDSDKiBh3c3zdMImbhYof40YIgNCUj3uwNH+vPYgOCFLtXE9YFkt
         j+4bdKdHOoiKEEQnGM1hud2Gp8eP7SGL+pyD0D3mQIsosqKFD7WHkuQ3hJKxqpv26G
         DydzzJNtMagOnAsGxklwvUyN5SLbqLmaoUKovUVWYAoHvAvOs+HMm2tB746BAB0ER4
         FDseJfSN33RNA==
Date:   Tue, 30 Mar 2021 14:56:11 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI/VPD: Silence warning if optional VPD PROM is missing
Message-ID: <20210330195611.GA1305306@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87b23db1-a177-190e-a792-eef621a78597@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Mar 07, 2021 at 10:34:25PM +0100, Heiner Kallweit wrote:
> On 07.03.2021 19:27, Krzysztof Wilczyński wrote:
> > Hi Heiner,
> > 
> >> Realtek RTL8169/8168/8125 NIC families indicate VPD capability and an
> >> optional VPD EEPROM can be connected via I2C/SPI. However I haven't
> >> seen any card or system with such a VPD EEPROM yet. The missing EEPROM
> >> causes the following warning whenever e.g. lscpi -vv is executed.
> >>
> >> invalid short VPD tag 00 at offset 01
> >>
> >> The warning confuses users, I think we should handle the situation more
> >> gentle. Therefore, if first VPD byte is read as 0x00, assume a missing
> >> optional VPD PROM as and silently set the VPD length to 0.
> > [...]
> > 
> > True.  I saw people on different forum and IRC asking for clarification
> > assuming their NIC broke, or that something is wrong, so this would
> > indeed save them some worry, nice!
> > 
> > Having said that, I also saw this particular warning showing up for some
> > storage controllers (often some SAS cards), so a question here: would it
> > warrant adding a pci_dbg() with an appropriate message rather than just
> > returning 0?  I wonder if this might be useful for someone who is trying
> > to troubleshoot and/or debug some issues with their device.
> > 
> > What do you think?
> > 
> I don't have a strong opinion here, but yes, that's something we could do.

How about if we just downgrade the pci_warn() to a pci_info()?
