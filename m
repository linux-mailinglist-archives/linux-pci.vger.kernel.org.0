Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27B9D19C3B2
	for <lists+linux-pci@lfdr.de>; Thu,  2 Apr 2020 16:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387807AbgDBONu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Apr 2020 10:13:50 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42341 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729213AbgDBONu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Apr 2020 10:13:50 -0400
Received: by mail-ed1-f65.google.com with SMTP id cw6so4280938edb.9
        for <linux-pci@vger.kernel.org>; Thu, 02 Apr 2020 07:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bw59ldBI6KmfNxBN+y0j5ytL7a/p3G46T3zdDz6zPM0=;
        b=Vd8sZW9+VxdPDDMgilaEnRb0n2QbgASfz9HECgv9zVtB1vRmYW4mmSFrcTDP5TjaBa
         pr6kMHwrcfwUQqsS/QB000by2Fz/jcC8d9c9NUoq2aIgv1nUwWJDce/5mhSKImSnHOHc
         nJWRSFm8I8EXaUl0MxUK2Q2Qa2Hq5YIxFdB5823aTghWsQNWqcLCxuCPBMEgpkrS9/ka
         A7iCujr37cbqWXvAZigq1EPswxHxySv02ocO0jHQClrE2blNg7wUt++pkqp2ZY9xQf4m
         SV4GobTX0SOeA28s7V1QPgL8QDjF7KWhcJ/6YkcWLz5Oe1u1hz73YTWP/lryjq+eBrvm
         oI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bw59ldBI6KmfNxBN+y0j5ytL7a/p3G46T3zdDz6zPM0=;
        b=F3BrE4YPlP/WILzeC4Rds027MM8cExta3lSxwfKZGwIpt9mm5/cHRFWEVackHMJ7ku
         V+7IhiDEZuLHTB0UYH2yE0gp9VtJoANJ2fulboUWZMWN/dUlNglA+Jzfx0peN+vBzPYK
         l8m5ctir1IclVrM70pmttKOCI2cMeBrYg/EYycO7UUQurKmr8+QdEXNOjV90pHjoQtcP
         gevBWfOsxOHZH1hxbD6JFRbsoh6jRGNq8f8zVXfTQG7Ri8lh/6z7JN2DkRUB+EnFWpAY
         Ll5Z+g/laJZmWms84jiXgR8ea934scayrdjI9mpDgGp3pQxmHx5S8loWLqNNLhUe4Gwd
         F+FA==
X-Gm-Message-State: AGi0PuYwVNt9cHZh1kuLLufR/nudsEGopHDPbLMLVEfIbppJEl9bwKk8
        p41DUkxdOCH7ILJPKSrDDUhj2iKh/ZELFHEWIns=
X-Google-Smtp-Source: APiQypLvFhqvwaErkuFG8n6IyUVYNWjly21J9H5nhf+TGWxgYZwQnRblj2PU+Ct5d3FUKcerwiQJsX0BOs8sNmoEPmc=
X-Received: by 2002:aa7:c251:: with SMTP id y17mr3058772edo.117.1585836827713;
 Thu, 02 Apr 2020 07:13:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzXK1pZufvY9VcXnjrrDMmiMoURtTaL1+8jGWL7k+yyGhKyDw@mail.gmail.com>
 <20200401233121.GA152016@google.com>
In-Reply-To: <20200401233121.GA152016@google.com>
From:   =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes@gmail.com>
Date:   Thu, 2 Apr 2020 15:13:36 +0100
Message-ID: <CAEzXK1qmYkpHzhbBmYG_Mvk+s6-NAJO-17+VW9fm-=trSZ-v5Q@mail.gmail.com>
Subject: Re: Problem with PCIe enumeration of Google/Coral TPU Edge module on Linux
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

The command that worked was:
#  sh -c "echo 1 >
/sys/bus/pci/devices/0000\:00\:01.0/pci_bus/0000\:01/bus_rescan"

The only new information compared to yesterday dmesg are the following line=
s:
...
[   20.633566] mvneta f1070000.ethernet eth0: Link is Up - 1Gbps/Full
- flow control off
[   20.633598] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[ 1048.661591] FAT-fs (sda1): Volume was not properly unmounted. Some
data may be corrupt. Please run fsck.
[ 1049.792121] EXT4-fs (sdb1): mounted filesystem with ordered data
mode. Opts: (null)
[60026.321476] pci_bus 0000:01: __pci_bus_assign_resources
[60026.321481] pci_bus 0000:01: pbus_assign_resources_sorted
[60026.321485] pci 0000:01:00.0: __dev_sort_resources
[60026.321487] __assign_resources_sorted
[60026.321490] pci 0000:01:00.0: __pci_bus_assign_resources
[60026.321493] pci 0000:01:00.0: pdev_assign_fixed_resources

Lu=C3=ADs

On Thu, Apr 2, 2020 at 12:31 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Apr 01, 2020 at 10:20:42PM +0100, Lu=C3=ADs Mendes wrote:
> > Hi Bjorn,
> >
> > Here is the dmesg output with the new kernel patch:
> > https://paste.ubuntu.com/p/7cv7ZcyrnG/
>
> Thanks.  What happens if you do this:
>
>   # echo 1 > sys/devices/pci0000:00/0000:00:01.0/pci_bus/0000:01/rescan
>
> (I think on v5.6 that file is "bus_rescan" instead of "rescan".
> There's a patch queued up to change it.)
