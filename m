Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8E2389AAE
	for <lists+linux-pci@lfdr.de>; Thu, 20 May 2021 02:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbhETA5y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 May 2021 20:57:54 -0400
Received: from mail-40136.protonmail.ch ([185.70.40.136]:50603 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhETA5y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 May 2021 20:57:54 -0400
Date:   Thu, 20 May 2021 00:56:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=schurger.org;
        s=protonmail2; t=1621472192;
        bh=++0Tn9+Ke2Qkssn6/IW3kjwnkn9AsLuGOERB1fFiAjE=;
        h=Date:To:From:Reply-To:Subject:From;
        b=FhFeAtPFWlM5fuzm8tTEEr50NfXWNSizeXIHRXta0b/lvl1BMMQFLeLq5+fFk/DK6
         dcM3WdbwDAv4ApIOog2ChvjrqBnAyjiwxMtF+saeCONb/K9g/ipS2IhGi7Av0aT9Q8
         cF6M3XjBlGA7fcB1vdTaUSSdDxMlUSuDxyTFkrlyStvSRX4rDbHo+Hqhts941hYyjT
         ehp4A9E3Pycea2UOn9vmFuBZRjk8JH0aBlrurW/F3cycwM3micdlAzRFQg2ROuBPx7
         Dc+OidB6iICmPWHa+25v/vEj74BU8RcEOyd5FECg5TSkdutX2/1DUcoovqIrNbn3jJ
         VOrRYiE6rhY2g==
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From:   Jean Schurger <jean@schurger.org>
Reply-To: Jean Schurger <jean@schurger.org>
Subject: Issue reading /sys/bus/pci/devices/0000:00:07.0/config on Ice Lake and linux >= 5.? <= 4.19
Message-ID: <44OhxNP39ivxFgzCEt3l6SB652D67EvZbkkzT04Lf-XZYfhHWvSz4AjsnuiC01IE4AZGG6_mRvoZV1hckW6kDr2uG6IZyM01fkm0tQ5Eg18=@schurger.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

I've got an Dell XPS 9300 (2020) with an up-to-date BIOS.

'lspci' shows that it have the following devices:

...
00:07.0 PCI bridge: Intel Corporation Ice Lake Thunderbolt 3 PCI Express Ro=
ot Port #0 (rev 03)
00:07.2 PCI bridge: Intel Corporation Ice Lake Thunderbolt 3 PCI Express Ro=
ot Port #2 (rev 03)
...

Reading /sys/bus/pci/devices/.../config for those two devices takes a lot o=
f time. I mean, seconds:


# strace -r cat /sys/bus/pci/devices/0000:00:07.0/config >/dev/null
[...]
     0.000040 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:00:07.0/config", =
O_RDONLY) =3D 3
[...]
     0.000042 read(3, "\206\200\35\212\7\4\20\0\3\0\4\6\0\0\201\0\0\0\0\0\0=
\0\0\0\0\1+\0PP\0\0"..., 131072) =3D 64
     1.787499 write(1, "\206\200\35\212\7\4\20\0\3\0\4\6\0\0\201\0\0\0\0\0\=
0\0\0\0\0\1+\0PP\0\0"..., 64) =3D 64
[...]


# strace -r cat /sys/bus/pci/devices/0000:00:07.2/config >/dev/null
[...]
    0.000051 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:00:07.2/config", O=
_RDONLY) =3D 3
[...]
     0.000051 read(3, "\206\200!\212\7\4\20\0\3\0\4\6\0\0\201\0\0\0\0\0\0\0=
\0\0\0,V\0``\0\0"..., 131072) =3D 64
     2.149361 write(1, "\206\200!\212\7\4\20\0\3\0\4\6\0\0\201\0\0\0\0\0\0\=
0\0\0\0,V\0``\0\0"..., 64) =3D 64
[...]


Reproducible 100% of time.
Issue is present in kernel 5.?+ (tested on 5.4, 5.10, 5.12) but not in 4.19=
.
Within the seconds it takes to read the config, the rest of the system is p=
erfectly fine.
No freeze, even not any kernel message.

I discovered that issue because Firefox read every pci devices config at st=
artup and takes a lot of time to start because of those two devices. (Same =
thing with lspci)
I stripped down the test to the most simple form to reproduce the problem w=
ith the 'cat' command.

For information, absolutely nothing is plugged on the thunderbolt ports and=
 the problem exists even if X is not started.

I don't know where to start to dig, I'm not familiar with the PCI system.

Any help would be greatly appreciated,
Kind regards,
Jean








