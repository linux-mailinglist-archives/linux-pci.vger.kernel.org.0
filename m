Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8CD32CF6F9
	for <lists+linux-pci@lfdr.de>; Fri,  4 Dec 2020 23:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388195AbgLDWjQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Dec 2020 17:39:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:59986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388191AbgLDWjQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Dec 2020 17:39:16 -0500
Date:   Fri, 4 Dec 2020 16:38:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607121515;
        bh=29mKW6TUQsdumXCa32bZLPWNoFlN8SPw3nQBmttE6BA=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=q+tJgVwskdsE4k+7/pyGtKLGBu6xx5XfmKPkO4m1JRgblFk26lvxXxjkJCvA4f5vz
         Nma1J2Njn67QHnhyjPrfB3D4cZzN65gbwUQUdSf4i+rdA+N4somCfmQ8bjOIs+0lSg
         YBESQV/znnwiyZfsHFfafPm+wDFW11hhXjF+fiIw+QLg003UKW41SfdA9HEcgqwxin
         /whBYrRFfcJY5VNgidLnuuFCpWfrEt1uCUCy/epi66W8nItDMouTKMm4By8QQRMY7H
         8JsLlVpqev5lK3cbxbLY67zXjY4GBwQpYDWAhB+hkkMSwanHZRVOoaL8KiYxoy5QkO
         qS6v4FgqxwZ4w==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hinko Kocevar <Hinko.Kocevar@ess.eu>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Recovering from AER: Uncorrected (Fatal) error
Message-ID: <20201204223834.GA1970318@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1a9f75f828c04130b16b7e0a3ae7f1e0@ess.eu>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 04, 2020 at 12:52:18PM +0000, Hinko Kocevar wrote:
> Hi,
> 
> I'm trying to figure out how to recover from Uncorrected (Fatal) error that is seen by the PCI root on a CPU PCIe controller:
> 
> Dec  1 02:16:37 bd-cpu18 kernel: pcieport 0000:00:01.0: AER: Uncorrected (Fatal) error received: id=0008
> Dec  1 02:16:37 bd-cpu18 kernel: pcieport 0000:00:01.0: PCIe Bus Error: severity=Uncorrected (Fatal), type=Transaction Layer, id=0008(Requester ID)
> Dec  1 02:16:37 bd-cpu18 kernel: pcieport 0000:00:01.0:   device [8086:1901] error status/mask=00004000/00000000
> Dec  1 02:16:37 bd-cpu18 kernel: pcieport 0000:00:01.0:    [14] Completion Timeout     (First)
> 
> This is the complete PCI device tree that I'm working with:
> 
> $ sudo /usr/local/bin/pcicrawler -t
> 00:01.0 root_port, "J6B2", slot 1, device present, speed 8GT/s, width x8
>  ├─01:00.0 upstream_port, PLX Technology, Inc. (10b5), device 8725
>  │  ├─02:01.0 downstream_port, slot 1, device present, power: Off, speed 8GT/s, width x4
>  │  │  └─03:00.0 upstream_port, PLX Technology, Inc. (10b5) PEX 8748 48-Lane, 12-Port PCI Express Gen 3 (8 GT/s) Switch, 27 x 27mm FCBGA (8748)
>  │  │     ├─04:00.0 downstream_port, slot 10, power: Off
>  │  │     ├─04:01.0 downstream_port, slot 4, device present, power: Off, speed 8GT/s, width x4
>  │  │     │  └─06:00.0 endpoint, Research Centre Juelich (1796), device 0024
>  │  │     ├─04:02.0 downstream_port, slot 9, power: Off
>  │  │     ├─04:03.0 downstream_port, slot 3, device present, power: Off, speed 8GT/s, width x4
>  │  │     │  └─08:00.0 endpoint, Research Centre Juelich (1796), device 0024
>  │  │     ├─04:08.0 downstream_port, slot 5, device present, power: Off, speed 8GT/s, width x4
>  │  │     │  └─09:00.0 endpoint, Research Centre Juelich (1796), device 0024
>  │  │     ├─04:09.0 downstream_port, slot 11, power: Off
>  │  │     ├─04:0a.0 downstream_port, slot 6, device present, power: Off, speed 8GT/s, width x4
>  │  │     │  └─0b:00.0 endpoint, Research Centre Juelich (1796), device 0024
>  │  │     ├─04:0b.0 downstream_port, slot 12, power: Off
>  │  │     ├─04:10.0 downstream_port, slot 8, power: Off
>  │  │     ├─04:11.0 downstream_port, slot 2, device present, power: Off, speed 2.5GT/s, width x1
>  │  │     │  └─0e:00.0 endpoint, Xilinx Corporation (10ee), device 7011
>  │  │     └─04:12.0 downstream_port, slot 7, power: Off
>  │  ├─02:02.0 downstream_port, slot 2
>  │  ├─02:08.0 downstream_port, slot 8
>  │  ├─02:09.0 downstream_port, slot 9, power: Off
>  │  └─02:0a.0 downstream_port, slot 10
>  ├─01:00.1 endpoint, PLX Technology, Inc. (10b5), device 87d0
>  ├─01:00.2 endpoint, PLX Technology, Inc. (10b5), device 87d0
>  ├─01:00.3 endpoint, PLX Technology, Inc. (10b5), device 87d0
>  └─01:00.4 endpoint, PLX Technology, Inc. (10b5), device 87d0
> 
> 00:01.0 is on a CPU board, The 03:00.0 and everything below that is
> not on a CPU board (working with a micro TCA system here). I'm
> working with FPGA based devices seen as endpoints here.  After the
> error all the endpoints in the above list are not able to talk to
> CPU anymore; register reads return 0xFFFFFFFF. At the same time PCI
> config space looks sane and accessible for those devices.

This could be caused by a reset.  We probably do a secondary bus reset
on the Root Port, which resets all the devices below it.  After the
reset, config space of those downstream devices would be accessible,
but the PCI_COMMAND register may be cleared which means the device
wouldn't respond to MMIO reads.

None of this explains the original problem of the Completion Timeout,
of course.  The error source of 0x8 (00:01.0) is the root port, which
makes sense if it issued a request transaction and never got the
completion.  The root port *should* log the header of the request and
we should print it, but it looks like we didn't.  "lspci -vv" of the
device would show whether it's capable of this logging.

If you're talking to an FPGA, the most likely explanation is a bug in
the FPGA programming where it doesn't respond when it should.

A PCIe analyzer would show exactly what the problem is, but those are
expensive and rare.  But if you're dealing with FPGAs, maybe you have
access to one.

> How can I debug this further? I'm getting the "I/O to channel is
> blocked" (pci_channel_io_frozen) state reported to the the endpoint
> devices I provide driver for.  Is there any way of telling if the
> PCI switch devices between 00:01.0 ... 06:00.0 have all recovered ;
> links up and running and similar? Is this information provided by
> the Linux kernel somehow?
> 
> For reference, I've experimented with AER inject and my tests showed
> that if the same type of error is injected in any other PCI device
> in the path 01:00.0 ... 06:00.0, IOW not into 00:01.0, the link is
> recovered successfully, and I can continue working with the endpoint
> devices. In those cases the "I/O channel is in normal state"
> (pci_channel_io_normal) state was reported; only error injection
> into 00:01.0 reports pci_channel_io_frozen state. Recovery code in
> the endpoint drivers I maintain is just calling the
> pci_cleanup_aer_uncorrect_error_status() in error handler resume()
> callback.
> 
> FYI, this is on 3.10.0-1160.6.1.el7.x86_64.debug CentOS7 kernel
> which I believe is quite old. At the moment I can not use newer
> kernel, but would be prepared to take that step if told that it
> would help.

It's really not practical for us to help debug a v3.10-based kernel;
that's over seven years old and AER handling has changed significantly
since then.  Also, CentOS is a distro kernel and includes many changes
on top of the v3.10 upstream kernel.  Those changes might be
theoretically open-source, but as a practical matter, the distro is a
better place to start for support of their kernel.

Bjorn
