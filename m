Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC4E3611A0
	for <lists+linux-pci@lfdr.de>; Thu, 15 Apr 2021 20:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbhDOSCy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Apr 2021 14:02:54 -0400
Received: from mout.web.de ([212.227.15.3]:37907 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234407AbhDOSCy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Apr 2021 14:02:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1618509745;
        bh=JVNsfyzS9pcv9aOIQP2PqYZOV0tqmt0zJQQhKeJU3fc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=fgmi82RqwnG8uVWenVb4P5JAIkJ0EAuLQOCOi+qTYXHMeqLnOeG0ZBsYqoy04l5Nh
         xdZly78oXPs1c1whNL29N432jrql6XdiumDvENow4z6bdreK3IgUWk7OSmJ6AhCtRL
         PvFjmEnkK+G/zQkgqLVP/9IZbFCZ3Cj5dP2TiOWc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.2.111] ([178.4.39.112]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M5OaF-1lk3na1Jq3-00zU5j; Thu, 15
 Apr 2021 20:02:25 +0200
Subject: Re: QCA6174 pcie wifi: Add pci quirks
To:     Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <08982e05-b6e8-5a8d-24ab-da1488ee50a8@web.de>
 <20210414210350.GA2537653@bjorn-Precision-5520>
 <20210414203650.1f83a5dd@x1.home.shazbot.org>
From:   Ingmar Klein <ingmar_klein@web.de>
Message-ID: <eec3bb3b-9eba-a0cb-73da-88353a0d3e99@web.de>
Date:   Thu, 15 Apr 2021 20:02:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210414203650.1f83a5dd@x1.home.shazbot.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:j2RWH3VMgFo4SJLh5Oqo3oT6N1ks0sB8h/CGSCzOScAvbQU0EKE
 ua5oklAip9qKaAqw2LTMzHn7GclOLNvAmhbNSmeqFu6KFy7gX/ObqoQsLXJblrQnXCjpJNl
 2LNDtmDgQhU4e5nHV03gMwY5LJ7SkY7O6ZNeIG3F0YC+qztWlrjc7PD/+9wbsd9bRszi+2d
 9KMMN14H76Takn4I+di0g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:B76y/98jsU0=:eNACdmYeQ0p39ggwgPuGDc
 OKj02qUQBS/NYp3i0eQ0Rscs7v1QXkgqXVMuVMkMpNXPsqw3s51CRUrvpSj982OIwu9JKORPv
 tLizloQnKW7VheU3YHPftE8bBgYj41krTs1KC0ADEY4tSXl1XFq7gG1diTDw9ZUlHGo2xt1Aw
 y3/wOMCe0cxfcun3K0eH1VLmeH1KwRrh7qpmLGgI2gqe7fkFF8P/DddjjtvVnyrb/a7m/h0ES
 IAk+WAVtdGUsSIW+armM8irCDr2dbhEm69uY1pxORG7duTq1ov2i9xNLHWL+HdyfNK+HqRsRS
 JOxmF9BwHVZalyLJ9ab9lBLUo2z5pHNrvBvEyHVnMZn0sRUfCK5xoy2EpoXucopeYHuDRr94a
 VazmEhec0O1pxOm8wPSti5qtAsy07WfgSvcAkRiSCGhNH2QEw5eFJPlWdiFFT3LUOADXnkYeQ
 s8yRjx912EMtrJd3BMn1Sm2caFmKGCEaauBwieCOuaRErqd+3hle/e+lZfb+g++yfWPhqGfo+
 4MX/lHgtxfp76YFyPnZVYWnCCUVFLJFeBVNpX1AFVSgqfLzryefn5AU1oGfP04D4YsV7ENB41
 iZXMSixJzUvLvF3tQlvLpizz2QAf1sXvuYjc9Sxhm61R93kmRyk0Hbu+VIupH37z7+jCrECS+
 NI6phVvlmFBjRXb2hAlgnOk8+wePulEkzlgHOo8mDuweZhZwyoJaBpezn3azxvoBYPIfuzbef
 YVIx1JOTvoXuUHJ/CbhQPRXgGTPMwjHazrfqiVWxQrlSuUnVeATJGc4jZiN+VOr2qZJfFTBHM
 pCnGfWqNtfr9kOidi+OUyRz//7xQ+G+iXEIBPRZ0hFkN24ACkfYlGVYk1gVS4IHLX1RQFmD+o
 ZIc7++k5jRijG1+clWO720itIYPDiAzQhYx11TIce3Xpx2D0kGjtwtYairogAMa1+z68lc7oI
 FRz3UnYk+VzRmHleDk6lI/NqcvwuSdVAibB6k/E14JhPKyOMKPgcUMHpQ5rVaeQMoTHJXJx1E
 K2+8WnG0TxVz+C5evwfFQRO0gbCn1SdxHlLLqR0ueGM27ldby2AtD9+UKwO16BtMQfoj48nUo
 QM/Bc9nAdiipjNb6U8Rs7L9Or8mKlujXUmfQCiB9nT6MPBMb10+LrUW1z/OoUxKPdceoBeesg
 MHdxFpnBJyoHFJaDtQGmy6rbA8s8xQufNfYOdXRJlcboRgHRKcrUOgvew+sO8l5sylgoU=
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

First thanks to you both, Alex and Bjorn!
I am in no way an expert on this topic, so I have to fully rely on your
feedback, concerning this issue.

If you should have any other solution approach, in form of patch-set, I
would be glad to test it out. Just let me know, what you think might
make sense.
I will wait for your further feedback on the issue. In the meantime I
have my current workaround via quirk entry.

By the way, my layman's question:
Do you think, that the following topic might also apply for the QCA6174?
https://www.spinics.net/lists/linux-pci/msg106395.html
Or in other words, should a similar approach be tried for the QCA6174
and if yes, would it bring any benefit at all?
I hope you can excuse me, in case the questions should not make too much
sense.

Best regards,
Ingmar


Am 15.04.2021 um 04:36 schrieb Alex Williamson:
> On Wed, 14 Apr 2021 16:03:50 -0500
> Bjorn Helgaas <helgaas@kernel.org> wrote:
>
>> [+cc Alex]
>>
>> On Fri, Apr 09, 2021 at 11:26:33AM +0200, Ingmar Klein wrote:
>>> Edit: Retry, as I did not consider, that my mail-client would make thi=
s
>>> party html.
>>>
>>> Dear maintainers,
>>> I recently encountered an issue on my Proxmox server system, that
>>> includes a Qualcomm QCA6174 m.2 PCIe wifi module.
>>> https://deviwiki.com/wiki/AIRETOS_AFX-QCA6174-NX
>>>
>>> On system boot and subsequent virtual machine start (with passed-throu=
gh
>>> QCA6174), the VM would just freeze/hang, at the point where the ath10k
>>> driver loads.
>>> Quick search in the proxmox related topics, brought me to the followin=
g
>>> discussion, which suggested a PCI quirk entry for the QCA6174 in the k=
ernel:
>>> https://forum.proxmox.com/threads/pcie-passthrough-freezes-proxmox.275=
13/
>>>
>>> I then went ahead, got the Proxmox kernel source (v5.4.106) and applie=
d
>>> the attached patch.
>>> Effect was as hoped, that the VM hangs are now gone. System boots and
>>> runs as intended.
>>>
>>> Judging by the existing quirk entries for Atheros, I would think, that
>>> my proposed "fix" could be included in the vanilla kernel.
>>> As far as I saw, there is no entry yet, even in the latest kernel sour=
ces.
>> This would need a signed-off-by; see
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?id=3Dv5.11#n361
>>
>> This is an old issue, and likely we'll end up just applying this as
>> yet another quirk.  But looking at c3e59ee4e766 ("PCI: Mark Atheros
>> AR93xx to avoid bus reset"), where it started, it seems to be
>> connected to 425c1b223dac ("PCI: Add Virtual Channel to save/restore
>> support").
>>
>> I'd like to dig into that a bit more to see if there are any clues.
>> AFAIK Linux itself still doesn't use VC at all, and 425c1b223dac added
>> a fair bit of code.  I wonder if we're restoring something out of
>> order or making some simple mistake in the way to restore VC config.
> I don't really have any faith in that bisect report in commit
> c3e59ee4e766.  To double check I dug out the card from that commit,
> installed an old Fedora release so I could build kernel v3.13,
> pre-dating 425c1b223dac and tested triggering a bus reset both via
> setpci and by masking PM reset so that sysfs can trigger the bus reset
> path with the kernel save/restore code.  Both result in the system
> hanging when the device is accessed either restoring from the kernel
> bus reset or reading from the device after the setpci reset.  Thanks,
>
> Alex
>
