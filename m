Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9E10CE70A
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2019 17:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfJGPPx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Oct 2019 11:15:53 -0400
Received: from mout.gmx.net ([212.227.17.22]:50113 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727589AbfJGPPx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Oct 2019 11:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570461327;
        bh=7rBtCp3NfShSXK3Kv+IAReHLw5T4ftpXx5yP1hWFT+U=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=QFcLimgrNqJJNZpwk+TUlmT5oNN6lmLXBDzbNEnp9jvZkOVbdIQF0sDKilPpjgW0Z
         2akrMnBGQo+tX90UCKbbCpwr+1LXmmf+O3iRia7oWhwyhs8hbknRjufic3hI/2Vygf
         6wycxPsaRKxETE3c3zr9KpNvHJZ/slkqWLPds2IA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from mandree.no-ip.org ([79.229.35.161]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJmKX-1iWYly0jVJ-00K6Bo; Mon, 07
 Oct 2019 17:15:27 +0200
Received: from ryzen.an3e.de (localhost [IPv6:::1])
        by ryzen.an3e.de (Postfix) with ESMTP id C3CB2121A4F;
        Mon,  7 Oct 2019 17:15:24 +0200 (CEST)
Subject: Re: [PATCH v2 0/2] PCI: Add missing link delays
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191004123947.11087-1-mika.westerberg@linux.intel.com>
 <811277ae-bec1-1724-23ce-c13407bd79c5@gmx.de>
 <20191004130619.GI2819@lahna.fi.intel.com>
 <ed169065-1a2a-4729-b052-6ec8b1bf4835@gmx.de>
 <20191007093236.GP2819@lahna.fi.intel.com>
From:   Matthias Andree <matthias.andree@gmx.de>
Autocrypt: addr=matthias.andree@gmx.de; prefer-encrypt=mutual; keydata=
 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
 H29L93g/7fa+B3v7
Message-ID: <a5cfebd8-a9f8-ce68-21b7-f38514f9be87@gmx.de>
Date:   Mon, 7 Oct 2019 17:15:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191007093236.GP2819@lahna.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:AO1dlJVudtmspUt2XIvfh/yR2oJDaLEGkSKPHGMgKahQ5agm2+h
 QiaIrV9Hp3FMeGyQxqVMOiHpa5hJ/18f1f5Z1+Uo4xZP9dqe7xfD5jr+jcjO0v6q5LlXCMV
 VcX1v/77OgkW9gcf8nVPCc/0xZBDCt1K0MIgfZ3m/AnOnS4ZuRvNixzRqw5MThpYULaBjY4
 kb83JQzOdIMuB0FOqDdIw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:U8WaWRyCEDc=:Xdl9gU48ETBmIygUmd2Y4C
 gvlXZ1EmU0h1tRk/+N5U7F4q50TTx7+8n/r9/H+nQwcgcCQxL5DpvQCx+G/CV+dWldsr7RFCn
 +i3NApL583B7U4UbY1EEYlxOLwyn95HUOiEDluGhp2Q39eMKJiGoaaVwHBlSsaY5ArqHbqo2V
 mjh9b/06ObTZEUSD8bx54vEBcilY9rHCu3CY3JtQFi00GeQwyiBbKynzcQTGoVSdjrGf3ckcA
 M4AgdRWT8eMiVtj+qb+NdnsZixC7y17sLEV2wQ+/LL4JRSNW7o+4n9TqZxhBlN1DgKbzb137p
 WS0LXXGNWQd7jE7LUWZhoMhT8c6pNB6DpNcaRndf5W6tEJrFjOgzNz9rss8wfmzWonjubddWX
 +AchKHEScuHmLvJ6KUddTBST9q9n81frS64/rReAjTk+ySjj+rMzMi2ndc7uymU91uofal2wB
 oCWAOcFrjqJnoAAmLCOxOlqs7eR6v7+pjCW2IfawGHVinORPxshlo2UOJY8lvjcm79jX96KEN
 AOsvGRvPX3DrZe3uQotHqo6NE7YpRsnJNO7R4p7KzMdRuL+ti8Wy2TpjIH3SMqgD01LyFFMR/
 fNFEChulf8QcF9b7DJspj0bmFa2Dn+FOUncDZTapTvwOvBItdf0Cy+tffkQLwMbjwCV5MIzkr
 bY+DdkUdwkjenJE5bDG0qJ+FR09oCAzTbwBw1dvOJrv1R2ltaauFstLoeIKEprwnqcb3YDAZJ
 4vp/hrV7Vl3HH4Cro7YHyWofZ3x4xt5G4xHD7HaYDxsouw2Nf0T94feDJrgPWFJS8fzYmPWIW
 U9f3TN5ADBriaPXSzfsdgKrsqmKIZx6AnhPgksyMFXBHlXE4D9XBoUM+R+hLDyGiqeQ7fP9gl
 2gwfETVgB5LTpbjyHph7il6ec7qBfneFouyOOqiuLqsv5jiiDxvKiUZ0QzmoIHNKpw/o1tH7l
 EXgopLcs/OurwnrVNhTzjvYhthSmBL/7nvZa28r+pM32pePvDYG3Dhl+bpgLZgO7ah9Ids87O
 MUGHgKym2f1nQHvS0PDm+7cW9IOESmq3Fxjhh6O2Ohwxwkao9Bwa2zLc0rfE/vEYqafALQgx+
 CglKB45SGft/jn4Cm0HqlaNa9As3hJqoUVkZqicTMCZKV8s+DvW/GiMkfwW7JZUjWHLAnM1Gl
 8s0xrjPJHONain4Zz19yoWBVm/Y+tvc7zRSuf1V+LBjCphctcpkk2Xb8qbjBueaohRWgAv/mE
 Z8uzQGZ64Hi9gVDqbjmlPCibB/3z6wqpEgM9hsEpQgptSJ6ANzWVDoc1vyo0=
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 07.10.19 um 11:32 schrieb Mika Westerberg:
> On Sat, Oct 05, 2019 at 09:34:41AM +0200, Matthias Andree wrote:
>> Am 04.10.19 um 15:06 schrieb Mika Westerberg:
>>> On Fri, Oct 04, 2019 at 02:57:21PM +0200, Matthias Andree wrote:
>>>> Am 04.10.19 um 14:39 schrieb Mika Westerberg:
>>>>> @Matthias, @Paul and @Nicholas, I appreciate if you could check that this
>>>>> does not cause any issues for your systems.
>>>> Just to be sure: is this intended to be applied against the 5.4-rc*
>>>> master branch?
>>> Yes, it applies on top of v5.4-rc1.
>> I am sorry to say that I cannot currently test - my computer has a
>> GeForce 1060-6GB an no onboard/on-chip graphics.
>> The nvidia module 435.21 does not compile against 5.4-rc* for me (5.3.1
>> was fine).
> I think the two patches should apply cleanly on 5.3.x as well.

Mika, that worked.

With your two patches on top of Linux 5.3.4, two Suspend-to-RAM cycles
(ACPI S3), one Suspend-to-disk cycle (ACPI S4),
no regressions observed => success?

Let me know off-list if you need any of my "usual logs" from my test script.

One blank line added to delineate Greg's release from your patches:

> * 9c2dfb396722 2019-10-04 | PCI: Add missing link delays required by
> the PCIe spec (HEAD -> linux-5.3.y) [Mika Westerberg]
> * 00103c8c3fa8 2019-10-04 | PCI: Introduce pcie_wait_for_link_delay()
> [Mika Westerberg]
>
> * ed56826f1779 2019-10-05 | Linux 5.3.4 (tag: v5.3.4,
> stable/linux-5.3.y) [Greg Kroah-Hartman]
> * d0b85a37c06b 2019-09-04 | platform/chrome: cros_ec_rpmsg: Fix race
> with host command when probe failed [Pi-Hsun Shih]
> * bec8c6dec605 2019-09-22 | mt76: mt7615: fix mt7615 firmware path
> definitions [Lorenzo Bianconi]
> * 5dab55b417ca 2019-07-02 | mt76: mt7615: always release sem in
> mt7615_load_patch [Lorenzo Bianconi]
> * 88688a6cd741 2019-09-09 | md/raid0: avoid RAID0 data corruption due
> to layout confusion. [NeilBrown]
Regards,
Matthias

