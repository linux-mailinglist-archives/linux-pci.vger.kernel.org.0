Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC69D2D3F74
	for <lists+linux-pci@lfdr.de>; Wed,  9 Dec 2020 11:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgLIKC4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Dec 2020 05:02:56 -0500
Received: from halon2.esss.lu.se ([194.47.240.53]:44976 "EHLO
        halon2.esss.lu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729051AbgLIKC4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Dec 2020 05:02:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ess.eu; s=dec2019;
        h=mime-version:content-transfer-encoding:content-type:in-reply-to:references:
         message-id:date:subject:cc:to:from:from;
        bh=wevMnQPVy7bBIOw/q8c1d5rzAT/cWecUeVVWvcaKMvg=;
        b=cZDJ1arcUPak3+68oTPhg2DqOHZz4s/xHkTMAm9Y12mTNW2T2ZfwrDmC+Pty5hFN/ppKsXjEly8SV
         L1w/vni8w2rvRX1ODopRh0FqodowNlR+EKAwCS2e2erfez1PzyZtA30UBbR7nVOTT6EdU2DQXjt15a
         7ud1H3VW+E3fUdKs/aZB974us0xyMWaGhhPzkLZjbHJxc3xf9fx5KuOYtmBy0NyXhSMDheBNq5QT2Z
         gzJTriQFTM4S/cY4mLXNRkbR14VPoyidvj8STckgKQ5GbknWvFHaskN1iIKhS9BMTgaEDn6W8Ee1Bo
         +QK4cFULojSKsA176cr9NeHiC3rmCxg==
Received: from mail.esss.lu.se (it-exch16-2.esss.lu.se [10.0.42.132])
        by halon2.esss.lu.se (Halon) with ESMTPS
        id 974a3109-3a05-11eb-8373-005056a642a7;
        Wed, 09 Dec 2020 10:02:05 +0000 (UTC)
Received: from it-exch16-4.esss.lu.se (10.0.42.134) by it-exch16-2.esss.lu.se
 (10.0.42.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 9 Dec 2020
 11:02:11 +0100
Received: from it-exch16-4.esss.lu.se ([fe80::c5e0:cc1e:47fa:d859]) by
 it-exch16-4.esss.lu.se ([fe80::c5e0:cc1e:47fa:d859%5]) with mapi id
 15.01.2106.003; Wed, 9 Dec 2020 11:02:11 +0100
From:   Hinko Kocevar <Hinko.Kocevar@ess.eu>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Recovering from AER: Uncorrected (Fatal) error
Thread-Topic: Recovering from AER: Uncorrected (Fatal) error
Thread-Index: AQHWyjnHBCvZDVkUKEWv/A/OfK2ZeKnndy4AgAcPNn8=
Date:   Wed, 9 Dec 2020 10:02:10 +0000
Message-ID: <e992a9f8cc7441b79567babe83e855fd@ess.eu>
References: <1a9f75f828c04130b16b7e0a3ae7f1e0@ess.eu>,<20201204223834.GA1970318@bjorn-Precision-5520>
In-Reply-To: <20201204223834.GA1970318@bjorn-Precision-5520>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [194.47.241.248]
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


________________________________________
From: Bjorn Helgaas <helgaas@kernel.org>
Sent: Friday, December 4, 2020 11:38 PM
To: Hinko Kocevar
Cc: linux-pci@vger.kernel.org
Subject: Re: Recovering from AER: Uncorrected (Fatal) error

On Fri, Dec 04, 2020 at 12:52:18PM +0000, Hinko Kocevar wrote:
> Hi,
>
> I'm trying to figure out how to recover from Uncorrected (Fatal) error th=
at is seen by the PCI root on a CPU PCIe controller:
>
> Dec  1 02:16:37 bd-cpu18 kernel: pcieport 0000:00:01.0: AER: Uncorrected =
(Fatal) error received: id=3D0008
> Dec  1 02:16:37 bd-cpu18 kernel: pcieport 0000:00:01.0: PCIe Bus Error: s=
everity=3DUncorrected (Fatal), type=3DTransaction Layer, id=3D0008(Requeste=
r ID)
> Dec  1 02:16:37 bd-cpu18 kernel: pcieport 0000:00:01.0:   device [8086:19=
01] error status/mask=3D00004000/00000000
> Dec  1 02:16:37 bd-cpu18 kernel: pcieport 0000:00:01.0:    [14] Completio=
n Timeout     (First)
>
> This is the complete PCI device tree that I'm working with:
>
> $ sudo /usr/local/bin/pcicrawler -t
> 00:01.0 root_port, "J6B2", slot 1, device present, speed 8GT/s, width x8
>  =86=8001:00.0 upstream_port, PLX Technology, Inc. (10b5), device 8725
>  =81  =86=8002:01.0 downstream_port, slot 1, device present, power: Off, =
speed 8GT/s, width x4
>  =81  =81  =84=8003:00.0 upstream_port, PLX Technology, Inc. (10b5) PEX 8=
748 48-Lane, 12-Port PCI Express Gen 3 (8 GT/s) Switch, 27 x 27mm FCBGA (87=
48)
>  =81  =81     =86=8004:00.0 downstream_port, slot 10, power: Off
>  =81  =81     =86=8004:01.0 downstream_port, slot 4, device present, powe=
r: Off, speed 8GT/s, width x4
>  =81  =81     =81  =84=8006:00.0 endpoint, Research Centre Juelich (1796)=
, device 0024
>  =81  =81     =86=8004:02.0 downstream_port, slot 9, power: Off
>  =81  =81     =86=8004:03.0 downstream_port, slot 3, device present, powe=
r: Off, speed 8GT/s, width x4
>  =81  =81     =81  =84=8008:00.0 endpoint, Research Centre Juelich (1796)=
, device 0024
>  =81  =81     =86=8004:08.0 downstream_port, slot 5, device present, powe=
r: Off, speed 8GT/s, width x4
>  =81  =81     =81  =84=8009:00.0 endpoint, Research Centre Juelich (1796)=
, device 0024
>  =81  =81     =86=8004:09.0 downstream_port, slot 11, power: Off
>  =81  =81     =86=8004:0a.0 downstream_port, slot 6, device present, powe=
r: Off, speed 8GT/s, width x4
>  =81  =81     =81  =84=800b:00.0 endpoint, Research Centre Juelich (1796)=
, device 0024
>  =81  =81     =86=8004:0b.0 downstream_port, slot 12, power: Off
>  =81  =81     =86=8004:10.0 downstream_port, slot 8, power: Off
>  =81  =81     =86=8004:11.0 downstream_port, slot 2, device present, powe=
r: Off, speed 2.5GT/s, width x1
>  =81  =81     =81  =84=800e:00.0 endpoint, Xilinx Corporation (10ee), dev=
ice 7011
>  =81  =81     =84=8004:12.0 downstream_port, slot 7, power: Off
>  =81  =86=8002:02.0 downstream_port, slot 2
>  =81  =86=8002:08.0 downstream_port, slot 8
>  =81  =86=8002:09.0 downstream_port, slot 9, power: Off
>  =81  =84=8002:0a.0 downstream_port, slot 10
>  =86=8001:00.1 endpoint, PLX Technology, Inc. (10b5), device 87d0
>  =86=8001:00.2 endpoint, PLX Technology, Inc. (10b5), device 87d0
>  =86=8001:00.3 endpoint, PLX Technology, Inc. (10b5), device 87d0
>  =84=8001:00.4 endpoint, PLX Technology, Inc. (10b5), device 87d0
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

After adding some printk()'s to the PCIe code that deals with the reset, I =
can see that the pci_bus_error_reset() calls the pci_bus_reset() due to bus=
 slots list check for empty returns true. So the the secondary bus is being=
 reset.

None of this explains the original problem of the Completion Timeout,
of course.  The error source of 0x8 (00:01.0) is the root port, which
makes sense if it issued a request transaction and never got the
completion.  The root port *should* log the header of the request and
we should print it, but it looks like we didn't.  "lspci -vv" of the
device would show whether it's capable of this logging.

I'm mostly concerned about the fact that the secondary bus is rendered usel=
ess after the reset/recovery. AIUI, this should not happen.

After upgrading my pciutils I get a bit more output from lspci -vv for the =
Root port. It seems it is capable of logging the errors:

        Capabilities: [1c0 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO+ CmpltAbrt- UnxCmplt- =
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES- TLP- FCP- CmpltTO+ CmpltAbrt- UnxCmplt- =
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFa=
talErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFa=
talErr+
                AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECR=
CChkCap- ECRCChkEn-
                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                HeaderLog: 00000000 00000001 00000002 00000003
                RootCmd: CERptEn+ NFERptEn+ FERptEn+
                RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
                         FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
                ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0008

The above was provoked with the aer-inject of the same error as seen in ini=
tial report, with bogus 'HEADER_LOG 0 1 2 3'.

Dec  9 10:25:19 bd-cpu18 kernel: pcieport 0000:00:01.0: aer_inject: Injecti=
ng errors 00000000/00004000 into device 0000:00:01.0
Dec  9 10:25:19 bd-cpu18 kernel: pcieport 0000:00:01.0: AER: Uncorrected (F=
atal) error received: 0000:00:01.0
Dec  9 10:25:19 bd-cpu18 kernel: pcieport 0000:00:01.0: PCIe Bus Error: sev=
erity=3DUncorrected (Fatal), type=3DTransaction Layer, (Requester ID)
Dec  9 10:25:19 bd-cpu18 kernel: pcieport 0000:00:01.0:   device [8086:1901=
] error status/mask=3D00004000/00000000
Dec  9 10:25:19 bd-cpu18 kernel: pcieport 0000:00:01.0:    [14] CmpltTO    =
          =20
Dec  9 10:25:19 bd-cpu18 kernel: mrf-pci 0000:0e:00.0: [aer_error_detected]=
 called .. state=3D2


Question: would using different (real?) HEADER_LOG values affect the recove=
ry behaviour?


If you're talking to an FPGA, the most likely explanation is a bug in
the FPGA programming where it doesn't respond when it should.

The thing is that this error does not happen that often and most of the tim=
e the card using FPGA is just fine. TBH, I am doing some stress testing of =
the card removal through the MCH (exercising hotplug) and this when I notic=
ed the initial problem.

A PCIe analyzer would show exactly what the problem is, but those are
expensive and rare.  But if you're dealing with FPGAs, maybe you have
access to one.

Sadly, no, I do not have access to the analyzer.

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

I followed your advice and started using kernel 5.9.12; hope this is recent=
 enough.

With that kernel I see a bit of different behavior than with the 3.10 earli=
er. Configuration access to the devices on the secondary bus is not OK; all=
 0xFFFFFFFF. This is what I see after the error was injected into the root =
port 00:01.0 and secondary bus reset was made as part of recovery:

00:01.0 PCI bridge: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Co=
re Processor PCIe Controller (x16) (rev 05) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
01:00.0 PCI bridge: PLX Technology, Inc. Device 8725 (rev ca) (prog-if 00 [=
Normal decode])
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 128
02:01.0 PCI bridge: PLX Technology, Inc. Device 8725 (rev ff) (prog-if ff)
	!!! Unknown header type 7f
	Kernel driver in use: pcieport

03:00.0 PCI bridge: PLX Technology, Inc. PEX 8748 48-Lane, 12-Port PCI Expr=
ess Gen 3 (8 GT/s) Switch, 27 x 27mm FCBGA (rev ff) (prog-if ff)
	!!! Unknown header type 7f
	Kernel driver in use: pcieport

04:11.0 PCI bridge: PLX Technology, Inc. PEX 8748 48-Lane, 12-Port PCI Expr=
ess Gen 3 (8 GT/s) Switch, 27 x 27mm FCBGA (rev ff) (prog-if ff)
	!!! Unknown header type 7f
	Kernel driver in use: pcieport

0e:00.0 Signal processing controller: Xilinx Corporation Device 7011 (rev f=
f) (prog-if ff)
	!!! Unknown header type 7f
	Kernel driver in use: mrf-pci

The return code from aer_root_reset() is PCI_ERS_RESULT_RECOVERED. How come=
 that the 01:00.0 upstream port PCI_COMMAND register is cleared? I guess th=
at explains why the rest of the devices in the chain down to the endpoint a=
t 0e:00.0 are rendered useless.


Then, as part of having fun, I made the pci_bus_error_reset() *NOT* do the =
actual reset of the secondary by just returning 0 before the call to the pc=
i_bus_reset(). In this case no bus reset is done, obviously, and MMIO acces=
s to my endpoint(s) is working just fine after the error was injected into =
the root port; as if nothing happened.

Is it expected that in cases of seeing this type of error the secondary bus=
 would be in this kind of state? It looks to me that the problem is not wit=
h my endpoints but with the PCIe switch on the CPU board (01:00.0 <--> 02:0=
?.0).

Thanks!
//hinko



Bjorn
