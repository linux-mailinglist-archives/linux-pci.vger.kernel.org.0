Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C42523145F
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jul 2020 22:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbgG1U7u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jul 2020 16:59:50 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:34489 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728728AbgG1U7t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jul 2020 16:59:49 -0400
Received: from dante.cb.ettle ([143.159.226.70]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.179]) with ESMTPSA (Nemesis) id
 1N4Q4m-1kk9592UdC-011ScG; Tue, 28 Jul 2020 22:57:57 +0200
Message-ID: <e051ac790380f04be4eec6937032b7dcd411ec77.camel@ettle.org.uk>
Subject: Re: rtsx_pci not restoring ASPM state after suspend/resume
From:   James Ettle <james@ettle.org.uk>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     =?UTF-8?Q?=E5=90=B3=E6=98=8A=E6=BE=84?= Ricky 
        <ricky_wu@realtek.com>, Rui Feng <rui_feng@realsil.com.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Len Brown <lenb@kernel.org>,
        Puranjay Mohan <puranjay12@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacopo De Simoi <wilderkde@gmail.com>
Date:   Tue, 28 Jul 2020 21:57:55 +0100
In-Reply-To: <20200727214712.GA1777201@bjorn-Precision-5520>
References: <20200727214712.GA1777201@bjorn-Precision-5520>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ngSr6pffow2MrQKByZsOgkOjw+48NYsh/QNN7LLUjsPAUCqjVX8
 tL1Q5y77Y/Bs2y+PjxM3AhKLg7QCGAYBHkpKPbeoKgVN8NP/QG2k/yRXk5++m3OetQh41Ya
 DJ9/QeTBamu7kmt8fHgxdHGFq50o1X95ELCiESFFKaeYfotykVdh+uABvrcDJjdSac5fzVX
 uWHE9VjHfUjE5Zz/8vLvw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:I1+llK0lwZA=:1+7ikQm0qnZ3cRtuwgvMtX
 xVzHZJ6LvJC74PFGUjYCPmw3FKUWyqLBJQMp0zpRCSj43yEiwBsyFbTfNv/B+8Wkoeb2zzpGy
 GhCVDU1/m5pBYkJzF5gawSoJPIOSgVbY8K4iIJ8e3ByWO/wY1J9sVydnsXDsmzq2o3orfIp+s
 50xonzRQw0XJL9rMHfWjydEYRz9FG6NsVB/KHtktEgtGHm+8enL+TvaG0aAbE5brVgZC2DH5z
 cGXfdFdylZrWxk+mK6tOFGIL00ZAd/mJZXBuh+/yk8SWyDUMT8OXVumjEISQygo28sh5Mdj4g
 6q+2OjpjYZrPlpdmN1gug540sln/YMFlpaNsl1ci+K9wFPQ693Lob5A0XUH6IXnyhOGPncsMF
 mepD7X7E1QWOxMLXlolu1pbD6gsLlvTzysFnnJwx1OzY2y/G/lFbu/kQtLnOHX/iy/SZ0iZFp
 ag4VHsTYBGUZI37IKeyDAECD86XZXh9VWLQvyUF6V0oWqcq4zcdcnQyiHpHufB9cHzLJGVqcA
 ZDImJnreNYTTQQwYM7odkgnMyEax4axPqNweoGdeNYPREP4LTFloRFh1cMF6G/8j6jRIIA/S0
 Cmz91i9mqs40hGtCEieLqMhsU+wMUeJh9F2xtQESk0x9s13MWs1FSEsATuc2f24eyjJrjsK5g
 fNP9TRaWl6HKmE5bGCZnu57fruv4HdDYBE6bxQhETFzgoydlWx6F//luMGPvEZOJ5R8nyNpI8
 /Kndv/TTIPcPa7eLH/79LABiQ7hmWKL78/+LDZ4n+myEyIxCUlF7OuwDPad+K+NIMN/6kX4pv
 +aHhPB53pBMOfBaOpK99C/NMnnrsHscaKPHzeQ9xAqLMczpHuD5o03ee0Gd1y7kt4ZFjDhg
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2020-07-27 at 16:47 -0500, Bjorn Helgaas wrote:
> 
> I don't see anything in rtsx that enables L0s.  Can you collect the
> dmesg log when booting with "pci=earlydump"?  That will show whether
> the BIOS left it this way.  The PCI core isn't supposed to do this,
> so
> if it did, we need to fix that.
> 

dmesg log attached to the bugzilla as:

https://bugzilla.kernel.org/attachment.cgi?id=290655

(to keep everything in one place).

Thanks,
-James

