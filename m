Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 132F717CF0D
	for <lists+linux-pci@lfdr.de>; Sat,  7 Mar 2020 16:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgCGP1D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 7 Mar 2020 10:27:03 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40586 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbgCGP1C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 7 Mar 2020 10:27:02 -0500
Received: by mail-ed1-f66.google.com with SMTP id a13so6315543edu.7
        for <linux-pci@vger.kernel.org>; Sat, 07 Mar 2020 07:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=t12eETEjMIcs0wGP/ExUn8HDfm4Jhs8gw92OYew6NSo=;
        b=TFu60l9vlLEssswYzLe/zM4wqtf641+8tEW4ZrzmCXbuQH7+6XzPXiB0yUXmcN2u8q
         9k9mCGUjDKQgVXbOt+Mr9ed1BlX+Ono8OE4gzdyk+4+soCf8nnDjElZP3j0329uAb1PA
         dnSYm7jOzdA4C+bFlTTfkkrpQzfaSqk8GfPMY6Pji+PlkAFeDp0VY6Q+e/CfXRThLFM/
         mHIA1Gu+rvyOqrfJ9XLsivDYIWx+dXsKs2mHsMmGe2oZ0HaDf83+2gh8L1SCdw6nuVE6
         qzRk4148l+6wuv9oTyyicX03SfIz6RtaKhwwqwXPiawqdP18BOp1+8ml+oT7XYhGejOE
         9cxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t12eETEjMIcs0wGP/ExUn8HDfm4Jhs8gw92OYew6NSo=;
        b=DJmDb8Mb1rS3LFN9JWV4AZWa7CzGfvEwQjXkDdi6cdgtdtZmmPPXrzt5PEdVGzHE8S
         HkLmnvvXJsnnanqreD1x/yjOgQEcUcc4xS/I2h1P3AfSaSMBcP9Y+CJJ5AjKYDesvA5W
         IjdA5rBiNhthoxu8VYm52Zxac1gKd+xHjzjeswJulB1S7NvP4CNGM+hRwkhwXEXMw4y1
         GPAyezAqJOQALDo40+sn9Yhv8SXb/TtKENeNnKuZ4bOqrrAv8Vz4vS1PzNWRVHa80UMH
         G/HVkxJ2SQR86RjlOrIwfq1LrZqajZLGQmXeQWebpUrPPAiLPczRk+5uSOQQ9UiaHVC4
         V7xQ==
X-Gm-Message-State: ANhLgQ3YO0C95cMhvMyOyCepKrnMmaf64U6wV5qtCR8FSKI38KYBbJUM
        IpzSN6aJYwcpmheNf6UIR2L4rnR4w2s1aZG7MZw=
X-Google-Smtp-Source: ADFU+vv8M0XT+DzZ5jcfljNd5Vh0UVIuU586NDwLW13dCrMAlU4clLCxDDewhhRP/kiM3Nuky9cpA8HB02WJ/54HLAM=
X-Received: by 2002:aa7:c54a:: with SMTP id s10mr8776067edr.345.1583594820692;
 Sat, 07 Mar 2020 07:27:00 -0800 (PST)
MIME-Version: 1.0
References: <CAEzXK1r0Er039iERnc2KJ4jn7ySNUOG9H=Ha8TD8XroVqiZjgg@mail.gmail.com>
 <20200306214753.GA235309@google.com> <CAEzXK1p-Vp5hyirYi3-b2SS+0pVTJZ3988+1iigEp4UM1VXmvw@mail.gmail.com>
In-Reply-To: <CAEzXK1p-Vp5hyirYi3-b2SS+0pVTJZ3988+1iigEp4UM1VXmvw@mail.gmail.com>
From:   =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes@gmail.com>
Date:   Sat, 7 Mar 2020 15:26:49 +0000
Message-ID: <CAEzXK1oukcnjgkY8Y6rkHcBAKwSvTDJsJVCf7nix4eoPPFsNqg@mail.gmail.com>
Subject: Re: Problem with PCIe enumeration of Google/Coral TPU Edge module on Linux
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

A quick look at the logs, makes me wonder if BAR0-BAR5 are only being
assigned to IO space on device by Linux, and BAR6 is the first bar
index that Linux is assigning on armhf/arm64 for mem space. If so,
that would be wrong because registers 0x10 and and 0x18 are BAR0 and
BAR2.
The TP-Link Gigabit LAN card that is installed on the other PCIe slot
has BAR 0 enabled but it is IO space and according to the registers
for the mem space, in that device, seen in dmesg, they are regs 0x18
and 0x20, or, BAR 2 and BAR 4, but Linux is assigning them to have
indices BAR 6 and BAR 8, since they are MEM space devices.
That looks wrong.... maybe the TP-Link device is working just because
BAR 0 does happen to exist in this case, which happens to be the
minimal requirement that allows pci_enable_device(...) to work,
passing in the test 'if (!r->parent)' performed by
pci_enable_resources(...) at drivers/pci/setup-res.c. Since most PCIe
cards have IO space, this generally works.
Can it be?

Lu=C3=ADs

On Sat, Mar 7, 2020 at 12:11 PM Lu=C3=ADs Mendes <luis.p.mendes@gmail.com> =
wrote:
>
> Hi Bjorn,
>
> Thanks for your help.
>
> On Fri, Mar 6, 2020 at 9:47 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > [+cc Thomas, Jason, Nicholas, Ben]
> >
> > On Fri, Mar 06, 2020 at 02:32:59PM +0000, Lu=C3=ADs Mendes wrote:
> > > Hi,
> > >
> > > I'm trying to use Google/Coral TPU Edge modules for a project, on
> > > arm64 and armhf, but BAR0 doesn't get assigned during the enumeration
> > > of PCIe devices and consequently pci_enable_device(...) fails on BAR0
> > > resource with value -22 (EINVAL) (resource has null parent) when
> > > loading gasket/apex driver.
> > >
> > > I'm also trying to adapt gasket/apex to run on armhf, but anyhow that
> > > is not the root cause for this issue.
> > >
> > > Relevant Log extracts follow in attachment.
> >
> > Hi Lu=C3=ADs,
> >
> > Thanks for the report, and sorry for the problem you're tripping over.
> > I cc'd a few folks who might be interested.
> >
> > > [    6.983880] mvebu-pcie soc:pcie: /soc/pcie/pcie@1,0: reset gpio is=
 active low
> > > [    6.993528] hub 4-1:1.0: 4 ports detected
> > > [    6.993749] mvebu-pcie soc:pcie: /soc/pcie/pcie@2,0: reset gpio is=
 active low
> > > [    7.106741]  sdb: sdb1
> > > [    7.109826] sd 2:0:0:0: [sdb] Attached SCSI removable disk
> > > [    7.242916] mvebu-pcie soc:pcie: PCI host bridge to bus 0000:00
> > > [    7.248854] pci_bus 0000:00: root bus resource [bus 00-ff]
> > > [    7.254370] pci_bus 0000:00: root bus resource [mem 0xd0000000-0xe=
fffffff]
> > > [    7.261267] pci_bus 0000:00: root bus resource [io  0x1000-0xeffff=
]
> > > [    7.267621] pci 0000:00:01.0: [11ab:6828] type 01 class 0x060400
> > > [    7.273662] pci 0000:00:01.0: reg 0x38: [mem 0x00000000-0x000007ff=
 pref]
> > > [    7.293971] PCI: bus0: Fast back to back transfers disabled
> > > [    7.299558] pci 0000:00:01.0: bridge configuration invalid ([bus 0=
0-00]), reconfiguring
> > > [    7.315694] pci 0000:01:00.0: [1ac1:089a] type 00 class 0x0000ff
> > > [    7.321749] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff=
 64bit pref]
> > > [    7.322814] usb 4-1.1: new high-speed USB device number 3 using xh=
ci-hcd
> > > [    7.329004] pci 0000:01:00.0: reg 0x18: [mem 0x00000000-0x000fffff=
 64bit pref]
> > > [    7.343111] pci 0000:01:00.0: 2.000 Gb/s available PCIe bandwidth,=
 limited by 2.5 GT/s x1 link at 0000:00:01.0 (capable of 4.000 Gb/s with 5 =
GT/s x1 link)
> > > [    7.383442] PCI: bus1: Fast back to back transfers disabled
> > > [    7.389031] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated =
to 01
> > > [    7.495604] pci 0000:00:02.0: ASPM: current common clock configura=
tion is broken, reconfiguring
> > > [    7.552513] pci 0000:00:01.0: BAR 8: assigned [mem 0xe8000000-0xe8=
1fffff]
> > > [    7.565611] pci 0000:00:01.0: BAR 6: assigned [mem 0xe8200000-0xe8=
2007ff pref]
> > > [    7.580096] pci 0000:00:01.0: PCI bridge to [bus 01]
> > > [    7.585079] pci 0000:00:01.0:   bridge window [mem 0xe8000000-0xe8=
1fffff]
> > > [    7.653228] pcieport 0000:00:01.0: enabling device (0140 -> 0142)
> > >
> > >
> > > [   11.188025] gasket: module is from the staging directory, the qual=
ity is unknown, you have been warned.
> > > [   11.217048] apex: module is from the staging directory, the qualit=
y is unknown, you have been warned.
> > > [   11.217926] apex 0000:01:00.0: can't enable device: BAR 0 [mem 0x0=
0000000-0x00003fff 64bit pref] not claimed
> > > [   11.227825] apex 0000:01:00.0: error enabling PCI device
> >
> > It looks like we did assign space for the bridge window leading to
> > 01:00.0, but failed to assign space to the 01:00.0 BAR itself.
> >
> > I don't know offhand why that would be.  Can you put the entire dmesg
> > log somewhere we can see?  That will tell us what kernel you're using
> > and possibly other useful things.
>
> Sure, complete dmesg is available at: https://pastebin.ubuntu.com/p/qnzJ5=
6kM7k/
> This is a custom built machine based on the Armada 388 armhf SoC, that
> I am using, but I've also tried an arm64 machine from Toradex, an
> Apalis IMX8QM with the Apalis Eval board, producing similar results
> with different kernels and also different ARM architectures.
> >
> > Does the same problem happen with other devices, or does it only
> > happen with the gasket/apex combination?  There shouldn't be anything
> > device-specific in the PCI core resource assignment code.
>
> This issue seems to happen only with the Coral Edge TPU device, but it
> happens independently of whether the gasket/apex driver module is
> loaded or not. The BAR 0 of the Coral device is not assigned either
> way.
>
> Lu=C3=ADs
