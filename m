Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953152D4829
	for <lists+linux-pci@lfdr.de>; Wed,  9 Dec 2020 18:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732917AbgLIRkw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Dec 2020 12:40:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:44504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732914AbgLIRkw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Dec 2020 12:40:52 -0500
Date:   Wed, 9 Dec 2020 11:40:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607535611;
        bh=YNVe6WwDeX6KDLDNHkWie6Teyfo8EqtXTSikd7tkZWo=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=uSdeSkS/CBl6cXOxOuWP1/QiemWEnLOtpC7Jlcb4VbzQn3gDwffwn5qawWefaX+MN
         VHa75v+83i5hNwzSSp3TdUrr0poguKl9FarKnWzqkQYAhG9BhTBzZf+CgmlEWQkNeo
         Hc6zFEsgkFI/3ejR3b2Y0DaBIuFjFnhMjC/7fOHt5+9r+ZAaI7l6/O6vnmgMfsgmv9
         k5M5sZAdJMPUnf0ewZAymW727aA3dfngQ5n0qgP+wykl1OiYHzWu5J112dYL3OwNGT
         Yp5RiNjpE5nnq4bhhQpYweDgjQkl3di7X6eKKdPsrnXyWxG/s38ap5pNt0mnyePN7D
         4z0b5jfoesYpw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hinko Kocevar <Hinko.Kocevar@ess.eu>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Recovering from AER: Uncorrected (Fatal) error
Message-ID: <20201209174009.GA2532473@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e992a9f8cc7441b79567babe83e855fd@ess.eu>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[non-standard email quoting below, ">" for both my text and Hinko's,
see https://en.wikipedia.org/wiki/Posting_style#Interleaved_style]

On Wed, Dec 09, 2020 at 10:02:10AM +0000, Hinko Kocevar wrote:
> ________________________________________
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Friday, December 4, 2020 11:38 PM
> To: Hinko Kocevar
> Cc: linux-pci@vger.kernel.org
> Subject: Re: Recovering from AER: Uncorrected (Fatal) error
> 
> On Fri, Dec 04, 2020 at 12:52:18PM +0000, Hinko Kocevar wrote:
> > Hi,
> >
> > I'm trying to figure out how to recover from Uncorrected (Fatal) error that is seen by the PCI root on a CPU PCIe controller:
> >
> > Dec  1 02:16:37 bd-cpu18 kernel: pcieport 0000:00:01.0: AER: Uncorrected (Fatal) error received: id=0008
> > Dec  1 02:16:37 bd-cpu18 kernel: pcieport 0000:00:01.0: PCIe Bus Error: severity=Uncorrected (Fatal), type=Transaction Layer, id=0008(Requester ID)
> > Dec  1 02:16:37 bd-cpu18 kernel: pcieport 0000:00:01.0:   device [8086:1901] error status/mask=00004000/00000000
> > Dec  1 02:16:37 bd-cpu18 kernel: pcieport 0000:00:01.0:    [14] Completion Timeout     (First)
> >
> > This is the complete PCI device tree that I'm working with:
> >
> > $ sudo /usr/local/bin/pcicrawler -t
> > 00:01.0 root_port, "J6B2", slot 1, device present, speed 8GT/s, width x8
> >  ├─01:00.0 upstream_port, PLX Technology, Inc. (10b5), device 8725
> >  │  ├─02:01.0 downstream_port, slot 1, device present, power: Off, speed 8GT/s, width x4
> >  │  │  └─03:00.0 upstream_port, PLX Technology, Inc. (10b5) PEX 8748 48-Lane, 12-Port PCI Express Gen 3 (8 GT/s) Switch, 27 x 27mm FCBGA (8748)
> >  │  │     ├─04:00.0 downstream_port, slot 10, power: Off
> >  │  │     ├─04:01.0 downstream_port, slot 4, device present, power: Off, speed 8GT/s, width x4
> >  │  │     │  └─06:00.0 endpoint, Research Centre Juelich (1796), device 0024
> >  │  │     ├─04:02.0 downstream_port, slot 9, power: Off
> >  │  │     ├─04:03.0 downstream_port, slot 3, device present, power: Off, speed 8GT/s, width x4
> >  │  │     │  └─08:00.0 endpoint, Research Centre Juelich (1796), device 0024
> >  │  │     ├─04:08.0 downstream_port, slot 5, device present, power: Off, speed 8GT/s, width x4
> >  │  │     │  └─09:00.0 endpoint, Research Centre Juelich (1796), device 0024
> >  │  │     ├─04:09.0 downstream_port, slot 11, power: Off
> >  │  │     ├─04:0a.0 downstream_port, slot 6, device present, power: Off, speed 8GT/s, width x4
> >  │  │     │  └─0b:00.0 endpoint, Research Centre Juelich (1796), device 0024
> >  │  │     ├─04:0b.0 downstream_port, slot 12, power: Off
> >  │  │     ├─04:10.0 downstream_port, slot 8, power: Off
> >  │  │     ├─04:11.0 downstream_port, slot 2, device present, power: Off, speed 2.5GT/s, width x1
> >  │  │     │  └─0e:00.0 endpoint, Xilinx Corporation (10ee), device 7011
> >  │  │     └─04:12.0 downstream_port, slot 7, power: Off
> >  │  ├─02:02.0 downstream_port, slot 2
> >  │  ├─02:08.0 downstream_port, slot 8
> >  │  ├─02:09.0 downstream_port, slot 9, power: Off
> >  │  └─02:0a.0 downstream_port, slot 10
> >  ├─01:00.1 endpoint, PLX Technology, Inc. (10b5), device 87d0
> >  ├─01:00.2 endpoint, PLX Technology, Inc. (10b5), device 87d0
> >  ├─01:00.3 endpoint, PLX Technology, Inc. (10b5), device 87d0
> >  └─01:00.4 endpoint, PLX Technology, Inc. (10b5), device 87d0
> >
> > 00:01.0 is on a CPU board, The 03:00.0 and everything below that is
> > not on a CPU board (working with a micro TCA system here). I'm
> > working with FPGA based devices seen as endpoints here.  After the
> > error all the endpoints in the above list are not able to talk to
> > CPU anymore; register reads return 0xFFFFFFFF. At the same time PCI
> > config space looks sane and accessible for those devices.
> 
> This could be caused by a reset.  We probably do a secondary bus reset
> on the Root Port, which resets all the devices below it.  After the
> reset, config space of those downstream devices would be accessible,
> but the PCI_COMMAND register may be cleared which means the device
> wouldn't respond to MMIO reads.
> 
> After adding some printk()'s to the PCIe code that deals with the reset, I can see that the pci_bus_error_reset() calls the pci_bus_reset() due to bus slots list check for empty returns true. So the the secondary bus is being reset.
> 
> None of this explains the original problem of the Completion Timeout,
> of course.  The error source of 0x8 (00:01.0) is the root port, which
> makes sense if it issued a request transaction and never got the
> completion.  The root port *should* log the header of the request and
> we should print it, but it looks like we didn't.  "lspci -vv" of the
> device would show whether it's capable of this logging.
> 
> I'm mostly concerned about the fact that the secondary bus is
> rendered useless after the reset/recovery. AIUI, this should not
> happen.

It should not.  The secondary bus should still work after the reset.

> After upgrading my pciutils I get a bit more output from lspci -vv for the Root port. It seems it is capable of logging the errors:
> 
>         Capabilities: [1c0 v1] Advanced Error Reporting
>                 UESta:  DLP- SDES- TLP- FCP- CmpltTO+ CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UESvrt: DLP+ SDES- TLP- FCP- CmpltTO+ CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>                 AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
>                         MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>                 HeaderLog: 00000000 00000001 00000002 00000003
>                 RootCmd: CERptEn+ NFERptEn+ FERptEn+
>                 RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
>                          FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
>                 ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0008
> 
> The above was provoked with the aer-inject of the same error as seen in initial report, with bogus 'HEADER_LOG 0 1 2 3'.
> 
> Dec  9 10:25:19 bd-cpu18 kernel: pcieport 0000:00:01.0: aer_inject: Injecting errors 00000000/00004000 into device 0000:00:01.0
> Dec  9 10:25:19 bd-cpu18 kernel: pcieport 0000:00:01.0: AER: Uncorrected (Fatal) error received: 0000:00:01.0
> Dec  9 10:25:19 bd-cpu18 kernel: pcieport 0000:00:01.0: PCIe Bus Error: severity=Uncorrected (Fatal), type=Transaction Layer, (Requester ID)
> Dec  9 10:25:19 bd-cpu18 kernel: pcieport 0000:00:01.0:   device [8086:1901] error status/mask=00004000/00000000
> Dec  9 10:25:19 bd-cpu18 kernel: pcieport 0000:00:01.0:    [14] CmpltTO               
> Dec  9 10:25:19 bd-cpu18 kernel: mrf-pci 0000:0e:00.0: [aer_error_detected] called .. state=2
> 
> 
> Question: would using different (real?) HEADER_LOG values affect the recovery behaviour?

No, it shouldn't.  I'm pretty sure we only print those values and they
don't influence behavior at all.

> > How can I debug this further? I'm getting the "I/O to channel is
> > blocked" (pci_channel_io_frozen) state reported to the the endpoint
> > devices I provide driver for.  Is there any way of telling if the
> > PCI switch devices between 00:01.0 ... 06:00.0 have all recovered ;
> > links up and running and similar? Is this information provided by
> > the Linux kernel somehow?
> >
> > For reference, I've experimented with AER inject and my tests showed
> > that if the same type of error is injected in any other PCI device
> > in the path 01:00.0 ... 06:00.0, IOW not into 00:01.0, the link is
> > recovered successfully, and I can continue working with the endpoint
> > devices. In those cases the "I/O channel is in normal state"
> > (pci_channel_io_normal) state was reported; only error injection
> > into 00:01.0 reports pci_channel_io_frozen state. Recovery code in
> > the endpoint drivers I maintain is just calling the
> > pci_cleanup_aer_uncorrect_error_status() in error handler resume()
> > callback.
> >
> > FYI, this is on 3.10.0-1160.6.1.el7.x86_64.debug CentOS7 kernel
> > which I believe is quite old. At the moment I can not use newer
> > kernel, but would be prepared to take that step if told that it
> > would help.
> 
> It's really not practical for us to help debug a v3.10-based kernel;
> that's over seven years old and AER handling has changed significantly
> since then.  Also, CentOS is a distro kernel and includes many changes
> on top of the v3.10 upstream kernel.  Those changes might be
> theoretically open-source, but as a practical matter, the distro is a
> better place to start for support of their kernel.
> 
> I followed your advice and started using kernel 5.9.12; hope this is recent enough.
> 
> With that kernel I see a bit of different behavior than with the
> 3.10 earlier. Configuration access to the devices on the secondary
> bus is not OK; all 0xFFFFFFFF. This is what I see after the error
> was injected into the root port 00:01.0 and secondary bus reset was
> made as part of recovery:
> 
> 00:01.0 PCI bridge: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor PCIe Controller (x16) (rev 05) (prog-if 00 [Normal decode])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 01:00.0 PCI bridge: PLX Technology, Inc. Device 8725 (rev ca) (prog-if 00 [Normal decode])
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Interrupt: pin A routed to IRQ 128
> 02:01.0 PCI bridge: PLX Technology, Inc. Device 8725 (rev ff) (prog-if ff)
> 	!!! Unknown header type 7f
> 	Kernel driver in use: pcieport
> 
> 03:00.0 PCI bridge: PLX Technology, Inc. PEX 8748 48-Lane, 12-Port PCI Express Gen 3 (8 GT/s) Switch, 27 x 27mm FCBGA (rev ff) (prog-if ff)
> 	!!! Unknown header type 7f
> 	Kernel driver in use: pcieport
> 
> 04:11.0 PCI bridge: PLX Technology, Inc. PEX 8748 48-Lane, 12-Port PCI Express Gen 3 (8 GT/s) Switch, 27 x 27mm FCBGA (rev ff) (prog-if ff)
> 	!!! Unknown header type 7f
> 	Kernel driver in use: pcieport
> 
> 0e:00.0 Signal processing controller: Xilinx Corporation Device 7011 (rev ff) (prog-if ff)
> 	!!! Unknown header type 7f
> 	Kernel driver in use: mrf-pci
> 
> The return code from aer_root_reset() is PCI_ERS_RESULT_RECOVERED.
> How come that the 01:00.0 upstream port PCI_COMMAND register is
> cleared? I guess that explains why the rest of the devices in the
> chain down to the endpoint at 0e:00.0 are rendered useless.
> 
> Then, as part of having fun, I made the pci_bus_error_reset() *NOT*
> do the actual reset of the secondary by just returning 0 before the
> call to the pci_bus_reset(). In this case no bus reset is done,
> obviously, and MMIO access to my endpoint(s) is working just fine
> after the error was injected into the root port; as if nothing
> happened.
> 
> Is it expected that in cases of seeing this type of error the
> secondary bus would be in this kind of state? It looks to me that
> the problem is not with my endpoints but with the PCIe switch on the
> CPU board (01:00.0 <--> 02:0?.0).

Hmm.  Yeah, I don't see anything in the path that would restore the
01:00.0 config space, which seems like a problem.  Probably its
secondary/subordinate bus registers and window registers get reset to
0 ("lspci -vv" would show that) so config/mem/io space below it is
accessible.

I didn't have much confidence in our error handling to begin with, and
it's eroding ;)

Bjorn
