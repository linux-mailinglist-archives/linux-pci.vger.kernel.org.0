Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F271DE6F1
	for <lists+linux-pci@lfdr.de>; Fri, 22 May 2020 14:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbgEVMc5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 May 2020 08:32:57 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:65433 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728495AbgEVMc4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 May 2020 08:32:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1590150775; x=1621686775;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=jxpIcUQcFnD1p6i5FtXCqzY/ZBVzyH8VSD5KQpS2Dv4=;
  b=YJFXzry9FtKA1A4X0muJJ29ab8k1dsQrA9rAVH4IokavErGjk5aMzx/g
   Obr+eb44p5X4vPYpwQEpm6+5JrzQ+nTNf0zPTrfU/d0CI33mW0gpn5kkB
   kGz/qlEDlM8YP3FH3fMxIwSJy9WxV27VfSU5eYrUxTNDnL82PrCB1C42b
   +cGbK+05hZaRwKvKAF6tMSnJPn+TVAqjknFHWzxu0WLlk+X8aFRFY3PeH
   aN/PRJVg0Q4Rq+RfpSoTayza9quuQ9b0KjmBNOEtMcr6XfZMBzrocXfyT
   2Gjkir4g3pQoVwIJUpUBLcG6fMVT/yBWTtDVQDR75N6G4JWkteKVprQEM
   Q==;
IronPort-SDR: 8ZK7dF8XNyTVqcmAlieJNGc8ljWKTyZ86GajqAeHAD/M66C/8vrpRdodVajKVxcBkEM50NECXu
 YBTMSqFe48JXgTzgSQSyLrJmj9wfu2YRv5hBNuf4050KcPgOXelT7A7rvuA01zi4F2poQm0tqd
 +9XCEGEbSmDlxpODFm1UAAA/TFn12r8VbpTFKuWm/zzPj3sKk05Mc5NqQmxODS+16g6CzBrzxn
 ZQLnS69slGKl0TyJ3Z1hNwIPxOIy1B5i2tA4bQgJNBHP1lqO4f+7ChQDDqssvamLHvoGdm+TiM
 TYI=
X-IronPort-AV: E=Sophos;i="5.73,421,1583164800"; 
   d="scan'208";a="138635476"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 May 2020 20:32:55 +0800
IronPort-SDR: WScRrQ8r1mHxw/nvSIXGkw9RkTs67dwGCoVQv4yu+90OHXk+HHwiMxBw7UF6IJIYihvjXK+fbo
 dwvyNPLGBY+Cnctpa/GaE7VYL1p90VLKI=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2020 05:22:54 -0700
IronPort-SDR: OHwPvCphzfHlZfMUYqYjBYkAg+mjt1HpcboZgR02qCCB+C6sN2IL/1+cRCfEupoL/XD+oM1Iz8
 uL5wRqbiGh3g==
WDCIronportException: Internal
Received: from unknown (HELO redsun52) ([10.149.66.28])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2020 05:32:55 -0700
Date:   Fri, 22 May 2020 13:32:50 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@wdc.com>
To:     Paul Burton <paulburton@kernel.org>
cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: piix4-poweroff.c I/O BAR usage
In-Reply-To: <CAG0y8xkAqscKC0qpx+zkBsmxtZFRaHdSgNLA78eGJUsQEtxQSA@mail.gmail.com>
Message-ID: <alpine.LFD.2.21.2005221315360.21168@redsun52.ssa.fujisawa.hgst.com>
References: <20200520135708.GA1086370@bjorn-Precision-5520> <alpine.LFD.2.21.2005220144230.21168@redsun52.ssa.fujisawa.hgst.com> <CAG0y8xkAqscKC0qpx+zkBsmxtZFRaHdSgNLA78eGJUsQEtxQSA@mail.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 21 May 2020, Paul Burton wrote:

> I'm reachable but lacking free time & with no access to Malta hardware
> I can't claim to be too useful here, so thanks for responding :)

 Great you're still around!  I hope you're doing good in this difficult 
time, and overall.  I have recently learnt WaveComp is no more. :(

> Before being moved to a driver (which was mostly driven by a desire to
> migrate Malta to a multi-platform/generic kernel using DT) this code
> was part of arch/mips/mti-malta/ where I added it in commit
> b6911bba598f ("MIPS: Malta: add suspend state entry code"). My main
> motivation at the time was to make QEMU exit after running poweroff,
> but I did ensure it worked on real Malta boards too (at least Malta-R
> with CoreFPGA6). Over the years since then it shocked a couple of
> hardware people to see software power off a Malta - if the original
> hardware designers had intended that to work then the knowledge had
> been lost over time :)

 Well, the Malta was designed by the Copenhagen team, which was dissolved 
IIRC back in 2003, so indeed the intent may have been lost in the mist of 
time.  I did know powering off is possible (same with the Atlas CompactPCI 
board if you ever came across one, not supported by Linux anymore) as it 
was inherent to the southbridge, and I remember discussing it once with 
Chris Shaw back in the MIPS UK days.  I guess the further it went, the 
more it became forgotten.

 Thanks for confirming it has been verified, though I was sure you did it 
anyway.

  Maciej
