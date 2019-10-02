Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30933C86EF
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2019 13:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfJBLFl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Oct 2019 07:05:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:43900 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725917AbfJBLFl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Oct 2019 07:05:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CC8ABB03E;
        Wed,  2 Oct 2019 11:05:38 +0000 (UTC)
Date:   Wed, 2 Oct 2019 13:05:27 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [dmidecode] Crucial SODIMM-DDR3 RAM and Manufacturer: 859B
Message-ID: <20191002130527.4f9bf971@endymion>
In-Reply-To: <20190920202343.GA759@google.com>
References: <CA+icZUWyihryeijbre3wVxpGoSPohcPJq3LwN6gktZrgLccMUQ@mail.gmail.com>
        <20190920202343.GA759@google.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Sedat,

On Fri, 20 Sep 2019 15:23:43 -0500, Bjorn Helgaas wrote:
> [+cc Jean]

Thanks Bjorn.

> On Fri, Sep 20, 2019 at 03:04:39PM +0200, Sedat Dilek wrote:
> > I wonder how I can teach dmidecode to give me the correct Manufacturer name.  
> 
> I don't know, but Jean (cc'd) probably does.
> 
> You may be able to figure it out via the source or the spec, which you
> can find here: https://www.nongnu.org/dmidecode/
> 
> > root@iniza:~# dmidecode --handle 0x0036
> > # dmidecode 3.2
> > Getting SMBIOS data from sysfs.
> > SMBIOS 2.6 present.
> > 63 structures occupying 2524 bytes.
> > Table at 0x000E0840.
> > 
> > Handle 0x0036, DMI type 17, 28 bytes
> > Memory Device
> >         Array Handle: 0x0033
> >         Error Information Handle: Not Provided
> >         Total Width: 64 bits
> >         Data Width: 64 bits
> >         Size: 4096 MB
> >         Form Factor: SODIMM
> >         Set: None
> >         Locator: ChannelB-DIMM0
> >         Bank Locator: BANK 2
> >         Type: DDR3
> >         Type Detail: Synchronous
> >         Speed: 1333 MT/s
> >         Manufacturer: 859B
> >         Serial Number: E0FBCF01
> >         Asset Tag: 9876543210
> >         Part Number: CT51264BF160B.C16F
> >         Rank: Unknown
> > 
> > I upgraded my local PCI-IDs via 'update-pciids' tool from pciutils
> > Debian/buster AMD64 package.

DIMMs are not PCI devices, so dmidecode doesn't care about pciutils-ids
at all.

> > I tried...
> > 
> > root@iniza:~# diff /usr/share/misc/pci.ids /usr/share/misc/pci.ids.dileks
> > 31390a31391  
> > > 959B  Crucial Technology  

Moot point but this number does not match the one above so it wouldn't
work anyway.

> > Under Windows-7 with the SIW tool I can see...
> > 
> > Memory Information;
> > Device Locator || Memory Type || Capacity || Manufacturer || Model
> > Slot 1 || DDR3 [PC3-12800] || 4096 MBytes || Crucial Technology ||
> > CT51264BF160B.C16F

You should ask them how they are doing that. Are you even sure they
read the information from the DMI table?

> > How can I handle this correctly in Linux?

The manufacturer field is supposed to be encoded as a human-readable
string. You BIOS decided to put some 16-bit ID there instead. You seem
to think it is a PCI vendor ID but I have no reason to believe so (that
number doesn't match anything at http://pci-ids.ucw.cz/read/PC/ ). If
anything, it would most probably a JEDEC-106 manufacturer ID.

But anyway, dmidecode just decodes the fields according to the
specification. We try to avoid adding quirks for hardware which
deviates from the spec, as much as possible. The problem is not in
dmidecode, the problem is that your BIOS lazily copies the manufacturer
ID to the field instead of decoding it to the actual manufacturer name.
I've seen this before, you are not an isolated case.

You may argue that the specification should have left the decoding to
the OS to make BIOS code easier and smaller, and I would agree with
that (especially as the JEDEC-106 list keeps growing with company names
which I suspect don't even produce memory chips or modules), but other
BIOS vendors manage to deal with it properly, so it's definitely
possible.

We could add JEDEC-106 ID decoding to dmidecode to workaround the
issue, but first we would need a pci.ids-like package to provide the
IDs independently from the tools. Not only dmidecode would benefit from
that, decode-dimms could use it as well.

-- 
Jean Delvare
SUSE L3 Support
