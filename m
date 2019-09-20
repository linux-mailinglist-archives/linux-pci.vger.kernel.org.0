Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06E63B9866
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2019 22:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbfITUXp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Sep 2019 16:23:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:46224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728821AbfITUXo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Sep 2019 16:23:44 -0400
Received: from localhost (odyssey.drury.edu [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2EEC208C0;
        Fri, 20 Sep 2019 20:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569011024;
        bh=Ze1NgPXZkZg2anihGvGu0KD6oU6aWftTmHgfCaBRztc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=isKtYiS/QyK0VyyOeeGjHcCUtL8V5B9vBfZNB+R8UVrZGP0dqAJVAhuEj7sVEhnwK
         6ClBO42pagEO0Cww8nMdAv5TDC0g92GWC+9aRT3D9mGXvWlrlU3GIGPT/gMhGsQ/zm
         3rl+c3POygTOIjquHKkl5R88G0hX/R/SLrRoBkN4=
Date:   Fri, 20 Sep 2019 15:23:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean Delvare <jdelvare@suse.de>
Subject: Re: [dmidecode] Crucial SODIMM-DDR3 RAM and Manufacturer: 859B
Message-ID: <20190920202343.GA759@google.com>
References: <CA+icZUWyihryeijbre3wVxpGoSPohcPJq3LwN6gktZrgLccMUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUWyihryeijbre3wVxpGoSPohcPJq3LwN6gktZrgLccMUQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Jean]

On Fri, Sep 20, 2019 at 03:04:39PM +0200, Sedat Dilek wrote:
> [ Please CC me I am not subscribed to this ML ]
> 
> Hi,
> 
> not sure if linux-pci ML is the correct place to ask my question.
> 
> I wonder how I can teach dmidecode to give me the correct Manufacturer name.

I don't know, but Jean (cc'd) probably does.

You may be able to figure it out via the source or the spec, which you
can find here: https://www.nongnu.org/dmidecode/

> root@iniza:~# dmidecode --handle 0x0036
> # dmidecode 3.2
> Getting SMBIOS data from sysfs.
> SMBIOS 2.6 present.
> 63 structures occupying 2524 bytes.
> Table at 0x000E0840.
> 
> Handle 0x0036, DMI type 17, 28 bytes
> Memory Device
>         Array Handle: 0x0033
>         Error Information Handle: Not Provided
>         Total Width: 64 bits
>         Data Width: 64 bits
>         Size: 4096 MB
>         Form Factor: SODIMM
>         Set: None
>         Locator: ChannelB-DIMM0
>         Bank Locator: BANK 2
>         Type: DDR3
>         Type Detail: Synchronous
>         Speed: 1333 MT/s
>         Manufacturer: 859B
>         Serial Number: E0FBCF01
>         Asset Tag: 9876543210
>         Part Number: CT51264BF160B.C16F
>         Rank: Unknown
> 
> I upgraded my local PCI-IDs via 'update-pciids' tool from pciutils
> Debian/buster AMD64 package.
> 
> I tried...
> 
> root@iniza:~# diff /usr/share/misc/pci.ids /usr/share/misc/pci.ids.dileks
> 31390a31391
> > 959B  Crucial Technology
> 
> Under Windows-7 with the SIW tool I can see...
> 
> Memory Information;
> Device Locator || Memory Type || Capacity || Manufacturer || Model
> Slot 1 || DDR3 [PC3-12800] || 4096 MBytes || Crucial Technology ||
> CT51264BF160B.C16F
> 
> How can I handle this correctly in Linux?
> 
> Thanks in advance.
> 
> Regards,
> - Sedat -
