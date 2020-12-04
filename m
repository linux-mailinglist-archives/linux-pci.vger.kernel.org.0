Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 121862CEE62
	for <lists+linux-pci@lfdr.de>; Fri,  4 Dec 2020 13:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgLDMxC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Dec 2020 07:53:02 -0500
Received: from halon2.esss.lu.se ([194.47.240.53]:63059 "EHLO
        halon2.esss.lu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbgLDMxB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Dec 2020 07:53:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ess.eu; s=dec2019;
        h=mime-version:content-transfer-encoding:content-type:message-id:date:subject:
         to:from:from;
        bh=BpSS3guQkCmfBSeFXPCUKdzqc4BcKJr4dmgYQKFGDpg=;
        b=dZst1QLTJS8I7li+2dAxRKioBEK2MCiIAR24aHuQ/jUUNANlOnNhBHxoiFOQJFnug/K7AMOnSjNHr
         60liO+BM33Q8idP02ARaqenEKvun/XGsBvNsE9XBQGyS3Ki5XptAgWsj/uOIFtWIYG3FiYrERBN7mO
         Czgh6j7K2p7lnv06gZu8LwXJ6E2Lei0s+pcA/SDLfeKl2le2hP+/ZGwYQ1AMavp6unv7rjlXWa08nv
         eKX6StTrbqaltIRNF0htwbHdyI1ZTFuZcFZyt6c/hGaqst65sZgYzGKnOdi33wB7NdZSTj6C7ObbrZ
         eFddcA34EycdvutLdcRQt3hNR6NEXng==
Received: from mail.esss.lu.se (it-exch16-4.esss.lu.se [10.0.42.134])
        by halon2.esss.lu.se (Halon) with ESMTPS
        id 895c4051-362f-11eb-8373-005056a642a7;
        Fri, 04 Dec 2020 12:52:16 +0000 (UTC)
Received: from it-exch16-4.esss.lu.se (10.0.42.134) by it-exch16-4.esss.lu.se
 (10.0.42.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 4 Dec 2020
 13:52:18 +0100
Received: from it-exch16-4.esss.lu.se ([fe80::c5e0:cc1e:47fa:d859]) by
 it-exch16-4.esss.lu.se ([fe80::c5e0:cc1e:47fa:d859%5]) with mapi id
 15.01.2106.003; Fri, 4 Dec 2020 13:52:18 +0100
From:   Hinko Kocevar <Hinko.Kocevar@ess.eu>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Recovering from AER: Uncorrected (Fatal) error
Thread-Topic: Recovering from AER: Uncorrected (Fatal) error
Thread-Index: AQHWyjnHBCvZDVkUKEWv/A/OfK2ZeA==
Date:   Fri, 4 Dec 2020 12:52:18 +0000
Message-ID: <1a9f75f828c04130b16b7e0a3ae7f1e0@ess.eu>
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

Hi,

I'm trying to figure out how to recover from Uncorrected (Fatal) error that=
 is seen by the PCI root on a CPU PCIe controller:

Dec  1 02:16:37 bd-cpu18 kernel: pcieport 0000:00:01.0: AER: Uncorrected (F=
atal) error received: id=3D0008
Dec  1 02:16:37 bd-cpu18 kernel: pcieport 0000:00:01.0: PCIe Bus Error: sev=
erity=3DUncorrected (Fatal), type=3DTransaction Layer, id=3D0008(Requester =
ID)
Dec  1 02:16:37 bd-cpu18 kernel: pcieport 0000:00:01.0:   device [8086:1901=
] error status/mask=3D00004000/00000000
Dec  1 02:16:37 bd-cpu18 kernel: pcieport 0000:00:01.0:    [14] Completion =
Timeout     (First)

This is the complete PCI device tree that I'm working with:

$ sudo /usr/local/bin/pcicrawler -t
00:01.0 root_port, "J6B2", slot 1, device present, speed 8GT/s, width x8
 =86=8001:00.0 upstream_port, PLX Technology, Inc. (10b5), device 8725
 =81  =86=8002:01.0 downstream_port, slot 1, device present, power: Off, sp=
eed 8GT/s, width x4
 =81  =81  =84=8003:00.0 upstream_port, PLX Technology, Inc. (10b5) PEX 874=
8 48-Lane, 12-Port PCI Express Gen 3 (8 GT/s) Switch, 27 x 27mm FCBGA (8748=
)
 =81  =81     =86=8004:00.0 downstream_port, slot 10, power: Off
 =81  =81     =86=8004:01.0 downstream_port, slot 4, device present, power:=
 Off, speed 8GT/s, width x4
 =81  =81     =81  =84=8006:00.0 endpoint, Research Centre Juelich (1796), =
device 0024
 =81  =81     =86=8004:02.0 downstream_port, slot 9, power: Off
 =81  =81     =86=8004:03.0 downstream_port, slot 3, device present, power:=
 Off, speed 8GT/s, width x4
 =81  =81     =81  =84=8008:00.0 endpoint, Research Centre Juelich (1796), =
device 0024
 =81  =81     =86=8004:08.0 downstream_port, slot 5, device present, power:=
 Off, speed 8GT/s, width x4
 =81  =81     =81  =84=8009:00.0 endpoint, Research Centre Juelich (1796), =
device 0024
 =81  =81     =86=8004:09.0 downstream_port, slot 11, power: Off
 =81  =81     =86=8004:0a.0 downstream_port, slot 6, device present, power:=
 Off, speed 8GT/s, width x4
 =81  =81     =81  =84=800b:00.0 endpoint, Research Centre Juelich (1796), =
device 0024
 =81  =81     =86=8004:0b.0 downstream_port, slot 12, power: Off
 =81  =81     =86=8004:10.0 downstream_port, slot 8, power: Off
 =81  =81     =86=8004:11.0 downstream_port, slot 2, device present, power:=
 Off, speed 2.5GT/s, width x1
 =81  =81     =81  =84=800e:00.0 endpoint, Xilinx Corporation (10ee), devic=
e 7011
 =81  =81     =84=8004:12.0 downstream_port, slot 7, power: Off
 =81  =86=8002:02.0 downstream_port, slot 2
 =81  =86=8002:08.0 downstream_port, slot 8
 =81  =86=8002:09.0 downstream_port, slot 9, power: Off
 =81  =84=8002:0a.0 downstream_port, slot 10
 =86=8001:00.1 endpoint, PLX Technology, Inc. (10b5), device 87d0
 =86=8001:00.2 endpoint, PLX Technology, Inc. (10b5), device 87d0
 =86=8001:00.3 endpoint, PLX Technology, Inc. (10b5), device 87d0
 =84=8001:00.4 endpoint, PLX Technology, Inc. (10b5), device 87d0

00:01.0 is on a CPU board, The 03:00.0 and everything below that is not on =
a CPU board (working with a micro TCA system here). I'm working with FPGA b=
ased devices seen as endpoints here.
After the error all the endpoints in the above list are not able to talk to=
 CPU anymore; register reads return 0xFFFFFFFF. At the same time PCI config=
 space looks sane and accessible for those devices.

How can I debug this further? I'm getting the "I/O to channel is blocked" (=
pci_channel_io_frozen) state reported to the the endpoint devices I provide=
 driver for.
Is there any way of telling if the PCI switch devices between 00:01.0 ... 0=
6:00.0 have all recovered ; links up and running and similar? Is this infor=
mation provided by the Linux kernel somehow?

For reference, I've experimented with AER inject and my tests showed that i=
f the same type of error is injected in any other PCI device in the path 01=
:00.0 ... 06:00.0, IOW not into 00:01.0, the link is recovered successfully=
, and I can continue working with the endpoint devices. In those cases the =
"I/O channel is in normal state" (pci_channel_io_normal) state was reported=
; only error injection into 00:01.0 reports pci_channel_io_frozen state. Re=
covery code in the endpoint drivers I maintain is just calling the pci_clea=
nup_aer_uncorrect_error_status() in error handler resume() callback.

FYI, this is on 3.10.0-1160.6.1.el7.x86_64.debug CentOS7 kernel which I bel=
ieve is quite old. At the moment I can not use newer kernel, but would be p=
repared to take that step if told that it would help.

Thank you in advance,

Hinko
