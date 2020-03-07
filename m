Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 031E817CE02
	for <lists+linux-pci@lfdr.de>; Sat,  7 Mar 2020 13:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgCGMLv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 7 Mar 2020 07:11:51 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41033 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgCGMLv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 7 Mar 2020 07:11:51 -0500
Received: by mail-ed1-f65.google.com with SMTP id m25so5840352edq.8
        for <linux-pci@vger.kernel.org>; Sat, 07 Mar 2020 04:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3k42LStM+IlcgAERjIQAwb7o/QoooUTT83BLWSnKdTA=;
        b=QX4ziUdSOKXtdHF0+0glwxG7kiUzjlnLKATOvI9JfKqQN7Wwi772gu3YTIHW3+YnuF
         ofAVK3dQXzu+8jCGYYrWahu30mEC7DtLWLr+wSEpLgP4VwF9xbqM1b5Lq3zzr/ikhzAe
         SKlv2zP2eQisXfQUk+/hzNHhRaIoT6Bx/O4UAM/aJQb41TEVy0Z5FqVxfRUcA6wrD4mO
         5P3jMv//yYqvppeVJXpZHxLYxsDtY1DJd1lXtM8+zofDDAVAbnALdlVhQYaNT+bjcwd9
         XnF9DZKM9vx+GzgoC7eRyvR6tEKwjVBdcsaYNViFnHIq0idpu/r/TjwiXsncRZrxhXqP
         rajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3k42LStM+IlcgAERjIQAwb7o/QoooUTT83BLWSnKdTA=;
        b=BTDMtrQmOfO+6uIolXYXwk+LlKoRaJ+9lgwwIpl32uCr0juBH15WzA9/tlmNr1ZzR8
         Hn9hdRY31SVmZPnEFrxnIwfW0AOkCXif4X9nQhPCl7Cs4/2aZcK1h6g5BO+vskk0sLUp
         sfcwmoMGMfdyL/Yh0Ar0F8jgPwbXxlo7R39bB2TrdwakITBZQUU6Cc7LL/dcg3mKVmPr
         0s8RnBB/P0UwPwZznMipkhi7Ww4pvfQdX0INxbYN0YyRhqKAXRj4YOsK45LbYEIpLsdR
         MELJpSmq1aTIl2hRMCMy5D4c1lCV4DA2LI3iAyAf+op5uD0/swoim2P7GqI51s1c6IYz
         lDvA==
X-Gm-Message-State: ANhLgQ3ACzZsWM7KHHA+rNSSBIieQ1BvVxZrttbCoj7lnlO7dvOaQapD
        EGlkodh+YG4FGSBEoRLKi8+4qFSSuAPN2oSfBjYAMNGe
X-Google-Smtp-Source: ADFU+vugP1c2QX71xR8pLYisXtypRtbKBDqWO2bI8jut3pLmAOg+5zZxTbO0LC2aQyj2IlBoNwJfKmUd8t/9bqBNXyQ=
X-Received: by 2002:a17:906:4ada:: with SMTP id u26mr7053015ejt.20.1583583107579;
 Sat, 07 Mar 2020 04:11:47 -0800 (PST)
MIME-Version: 1.0
References: <CAEzXK1r0Er039iERnc2KJ4jn7ySNUOG9H=Ha8TD8XroVqiZjgg@mail.gmail.com>
 <20200306214753.GA235309@google.com>
In-Reply-To: <20200306214753.GA235309@google.com>
From:   =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes@gmail.com>
Date:   Sat, 7 Mar 2020 12:11:36 +0000
Message-ID: <CAEzXK1p-Vp5hyirYi3-b2SS+0pVTJZ3988+1iigEp4UM1VXmvw@mail.gmail.com>
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

Hi Bjorn,

Thanks for your help.

On Fri, Mar 6, 2020 at 9:47 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Thomas, Jason, Nicholas, Ben]
>
> On Fri, Mar 06, 2020 at 02:32:59PM +0000, Lu=C3=ADs Mendes wrote:
> > Hi,
> >
> > I'm trying to use Google/Coral TPU Edge modules for a project, on
> > arm64 and armhf, but BAR0 doesn't get assigned during the enumeration
> > of PCIe devices and consequently pci_enable_device(...) fails on BAR0
> > resource with value -22 (EINVAL) (resource has null parent) when
> > loading gasket/apex driver.
> >
> > I'm also trying to adapt gasket/apex to run on armhf, but anyhow that
> > is not the root cause for this issue.
> >
> > Relevant Log extracts follow in attachment.
>
> Hi Lu=C3=ADs,
>
> Thanks for the report, and sorry for the problem you're tripping over.
> I cc'd a few folks who might be interested.
>
> > [    6.983880] mvebu-pcie soc:pcie: /soc/pcie/pcie@1,0: reset gpio is a=
ctive low
> > [    6.993528] hub 4-1:1.0: 4 ports detected
> > [    6.993749] mvebu-pcie soc:pcie: /soc/pcie/pcie@2,0: reset gpio is a=
ctive low
> > [    7.106741]  sdb: sdb1
> > [    7.109826] sd 2:0:0:0: [sdb] Attached SCSI removable disk
> > [    7.242916] mvebu-pcie soc:pcie: PCI host bridge to bus 0000:00
> > [    7.248854] pci_bus 0000:00: root bus resource [bus 00-ff]
> > [    7.254370] pci_bus 0000:00: root bus resource [mem 0xd0000000-0xeff=
fffff]
> > [    7.261267] pci_bus 0000:00: root bus resource [io  0x1000-0xeffff]
> > [    7.267621] pci 0000:00:01.0: [11ab:6828] type 01 class 0x060400
> > [    7.273662] pci 0000:00:01.0: reg 0x38: [mem 0x00000000-0x000007ff p=
ref]
> > [    7.293971] PCI: bus0: Fast back to back transfers disabled
> > [    7.299558] pci 0000:00:01.0: bridge configuration invalid ([bus 00-=
00]), reconfiguring
> > [    7.315694] pci 0000:01:00.0: [1ac1:089a] type 00 class 0x0000ff
> > [    7.321749] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff 6=
4bit pref]
> > [    7.322814] usb 4-1.1: new high-speed USB device number 3 using xhci=
-hcd
> > [    7.329004] pci 0000:01:00.0: reg 0x18: [mem 0x00000000-0x000fffff 6=
4bit pref]
> > [    7.343111] pci 0000:01:00.0: 2.000 Gb/s available PCIe bandwidth, l=
imited by 2.5 GT/s x1 link at 0000:00:01.0 (capable of 4.000 Gb/s with 5 GT=
/s x1 link)
> > [    7.383442] PCI: bus1: Fast back to back transfers disabled
> > [    7.389031] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to=
 01
> > [    7.495604] pci 0000:00:02.0: ASPM: current common clock configurati=
on is broken, reconfiguring
> > [    7.552513] pci 0000:00:01.0: BAR 8: assigned [mem 0xe8000000-0xe81f=
ffff]
> > [    7.565611] pci 0000:00:01.0: BAR 6: assigned [mem 0xe8200000-0xe820=
07ff pref]
> > [    7.580096] pci 0000:00:01.0: PCI bridge to [bus 01]
> > [    7.585079] pci 0000:00:01.0:   bridge window [mem 0xe8000000-0xe81f=
ffff]
> > [    7.653228] pcieport 0000:00:01.0: enabling device (0140 -> 0142)
> >
> >
> > [   11.188025] gasket: module is from the staging directory, the qualit=
y is unknown, you have been warned.
> > [   11.217048] apex: module is from the staging directory, the quality =
is unknown, you have been warned.
> > [   11.217926] apex 0000:01:00.0: can't enable device: BAR 0 [mem 0x000=
00000-0x00003fff 64bit pref] not claimed
> > [   11.227825] apex 0000:01:00.0: error enabling PCI device
>
> It looks like we did assign space for the bridge window leading to
> 01:00.0, but failed to assign space to the 01:00.0 BAR itself.
>
> I don't know offhand why that would be.  Can you put the entire dmesg
> log somewhere we can see?  That will tell us what kernel you're using
> and possibly other useful things.

Sure, complete dmesg is available at: https://pastebin.ubuntu.com/p/qnzJ56k=
M7k/
This is a custom built machine based on the Armada 388 armhf SoC, that
I am using, but I've also tried an arm64 machine from Toradex, an
Apalis IMX8QM with the Apalis Eval board, producing similar results
with different kernels and also different ARM architectures.
>
> Does the same problem happen with other devices, or does it only
> happen with the gasket/apex combination?  There shouldn't be anything
> device-specific in the PCI core resource assignment code.

This issue seems to happen only with the Coral Edge TPU device, but it
happens independently of whether the gasket/apex driver module is
loaded or not. The BAR 0 of the Coral device is not assigned either
way.

Lu=C3=ADs
