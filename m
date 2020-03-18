Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 526E5189EC8
	for <lists+linux-pci@lfdr.de>; Wed, 18 Mar 2020 16:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgCRPEg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Mar 2020 11:04:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:34800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726979AbgCRPEg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Mar 2020 11:04:36 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4FEB20770;
        Wed, 18 Mar 2020 15:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584543875;
        bh=H6PswJchhT4zoiIUpYSuLhsYKHr9FQNTUobaJ0t3VDs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=W8viFJTmIa3k7paTT9mQlwLWj5dIMRyBsNqIGdgUsf4Dw/dTqS0GpsSRMEq2fjq7M
         kgCKazdrsiCuVBHdAzaD1WJ8qvM8MN/iJpSVmparE24Zg3sOvYXHq9LZJ1yjOnxpkc
         jaJWhbl/8wu/8v55LH8OfPulQ2GPx75k38FrDU7Y=
Date:   Wed, 18 Mar 2020 10:04:32 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Saheed Bolarinwa <refactormyself@gmail.com>
Cc:     Bjorn Helgaas <bjorn@helgaas.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-pci@vger.kernel.org
Subject: Re: Linux Kernel Mentorship Summer 2020
Message-ID: <20200318150432.GA234686@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABGxfO5aN2kJd8YOhbOALw5j7Eq1-rArC_O10RQyFUUhM6YGqw@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc linux-pci because there are lots of interesting wrinkles in this
issue -- as background, my idea for this project was to make
pcie_capability_read_word() return errors  more like
pci_read_config_word() does.  When a PCI error occurs,
pci_read_config_word() returns ~0 data, but
pcie_capability_read_word() return 0 data.]

On Mon, Mar 16, 2020 at 02:03:57PM +0100, Saheed Bolarinwa wrote:
> I have checked the function the  pcie_capability_read_word() that
> sets *val = 0  when pci_read_config_word() fails.
> 
> I am still trying to get familiar to the code, I just wondering why
> the result of pci_read_config_word()  is not being returned directly
> since  *val  is passed into it.

pci_read_config_word() needs to return two things:

  1) A success/failure indication.  This is either 0 or an error like
  PCIBIOS_DEVICE_NOT_FOUND, PCIBIOS_BAD_REGISTER_NUMBER, etc.  This is
  the function return value.

  2) A 16-bit value read from PCI config space.  This is what goes in
  *val.

pcie_capability_read_word() is similar.  The idea of this project is
to change part 2, the value in *val.

The reason is that sometimes the config read fails on PCI.  This can
happen because the device has been physically removed, it's been
electrically isolated, or some other PCI error.  When a config read
fails, the PCI host bridge generally returns ~0 data to satisfy the
CPU load instruction.

The PCI core, i.e., pci_read_config_word() can't tell whether ~0 means
(a) the config read was successful and the register on the PCI card
happened to contain ~0, or (b) the config read failed because of a PCI
error.

Only the driver knows whether ~0 is a valid value for a config space
register, so the driver has to be involved in looking for this error.

My idea for this project is to make this checking more uniform between
pci_read_config_word() and pcie_capability_read_word().

For example, pci_read_config_word() sets *val = ~0 when it returns
PCIBIOS_DEVICE_NOT_FOUND.

On the other hand, pcie_capability_read_word() sets *val = 0 when it
returns -EINVAL, PCIBIOS_DEVICE_NOT_FOUND, etc.

> This is what is done inside pci_read_config_word() when
> pci_bus_read_config_word() is called. I tried to find the definition
> of  pci_bus_read_config_word() but I couldn't find it.  I am not
> sure I need it, though.

pci_bus_read_config_word() and similar functions are defined by the
PCI_OP_READ() macro in drivers/pci/access.c.  It's sort of annoying
because grep/cscope/etc don't find those functions very well.  But
you're right; they aren't really relevant to this project.

> I am also confused with the last statement of the Project
> description on the Project List
> <https://wiki.linuxfoundation.org/lkmp/lkmp_project_list> page. It
> says, "*This will require changes to some callers of
> pci_read_config_word() that assume the read returns 0 on error.*" I
> think the callers pcie_capability_read_word() are supposedly being
> referred to here.

Yes, that's a typo.  The idea is to change pcie_capability_read_*(),
so we'd probably need to change some callers to match.
