Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6944C1153E4
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2019 16:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfLFPIk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Dec 2019 10:08:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:60936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726234AbfLFPIk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Dec 2019 10:08:40 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5382424659;
        Fri,  6 Dec 2019 15:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575644919;
        bh=Mk2Qn+6rQTzSn+2H0WBlJBLvPoY4xXtoMOqRsbebiEA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=B+AbtR+2D/wgn5nJjHJb1K37ECvtLq4AQF0xT/4IiZP9LFCiykGA1hfj5hT+JSrhO
         M10YtBBd6huCyf0ivSKsrfQ6C5/rpsDde+anr7cpqtY8I5y92r3IcE0MjI5xoQkYZP
         UBkQz4FTXNmA1KTocOPvtkfwnKfGDJx92QkSyzHQ=
Date:   Fri, 6 Dec 2019 09:08:38 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ranran <ranshalit@gmail.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [Bug 205701] New: Can't access RAM from PCIe
Message-ID: <20191206150837.GA98601@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ2oMhJDxkU8TpFon4vzBiL5WrYv-zQNtYW8xbqaQLh2eS7bbg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 06, 2019 at 08:09:48AM +0200, Ranran wrote:
> On Fri, Nov 29, 2019 at 8:38 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Fri, Nov 29, 2019 at 06:10:51PM +0200, Ranran wrote:
> > > On Fri, Nov 29, 2019 at 4:58 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Fri, Nov 29, 2019 at 06:59:48AM +0000, bugzilla-daemon@bugzilla.kernel.org wrote:
> > > > > https://bugzilla.kernel.org/show_bug.cgi?id=205701

> I have tried to upgrade to latest kernel 5.4 (elrepo in centos), but
> with this processor/board (system x3650, Xeon), it get hang during
> kernel boot, without any error in dmesg, just keeps waiting for
> nothing for couple of minutes and than drops to dracut.

- I don't think you ever said exactly what the original failure mode
  was.  You said DMA from an FPGA failed.  What is the specific
  device?  How do you know the DMA fails?

- Re your v5.4 kernel testing, dracut is a user-space distro thing, so
  it sounds like your hang is some sort of installation problem that I
  can't really help you with.  Maybe there are troubleshooting hints
  at https://www.kernel.org/pub/linux/utils/boot/dracut/dracut.html.
  You may also be able to just drop a v5.4 kernel on your v4.18
  system, at least for testing purposes.

- Your comment #3 in bugzilla is a link to a Google Doc containing a
  test module.  In the future, please attach things as plain text
  attachments directly to the bugzilla.  There's an "Add attachment"
  link immediately before the "Description" comment in bugzilla.  I
  did it for you this time.

- It looks like your test_module.c is a kernel module, and frankly
  it's a mess.  Global variables that should be per-device, unused
  variables (dma_get_mask() called for no reason), confused usage
  (e.g., using both pci_dev_s and pPciDev), whitespace that appears
  random, etc.  I suggest starting with Documentation/PCI/pci.rst and,
  at least for this debugging effort, making it a self-contained
  driver instead of splitting things between a kernel module and
  user-space.

- Your comment #4 is a link to a Google Doc containing lspci output.
  I attached it to bugzilla directly for you.

- You apparently didn't run lspci as root ("sudo lspci -vv"), so it
  is missing a lot of information.

- Your lspci doesn't match either of the dmesg logs.  Please make sure
  all your logs are from the same machine in the same configuration.
  For example, the first devices found by the kernel (from both
  comments #1 and #2) are:

    pci 0000:00:00.0: [8086:3c00] type 00 class 0x060000
    pci 0000:00:01.0: [8086:3c02] type 01 class 0x060400
    pci 0000:00:02.0: [8086:3c04] type 01 class 0x060400
    pci 0000:00:02.2: [8086:3c06] type 01 class 0x060400
    ...

  But the lspci doesn't include 00:01.0, 00:02.0, or 00:02.2.  It
  shows:

    00:00.0 Host bridge: Intel Corporation Device 2020 (rev 04)
    00:04.0 System peripheral: Intel Corporation Sky Lake-E CBDMA Registers (rev 04)
    00:04.1 System peripheral: Intel Corporation Sky Lake-E CBDMA Registers (rev 04)
    00:04.2 System peripheral: Intel Corporation Sky Lake-E CBDMA Registers (rev 04)
    ...
