Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1EE730C599
	for <lists+linux-pci@lfdr.de>; Tue,  2 Feb 2021 17:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236257AbhBBQ1R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Feb 2021 11:27:17 -0500
Received: from mout.gmx.net ([212.227.15.15]:36983 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236312AbhBBQXZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Feb 2021 11:23:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1612282862;
        bh=j7MqdTeRJ2CWeYhU/BJJVscXmV0af2mzaUyfN5RfAW0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=SuXGNdGWi9JtCysGxjPI2Z3K4MA44C3FSkk8lyksyx668b1rVZp+3TJg7ueWsPovL
         bzVGqiANrOCu/bIJrD5lhFV7BFBFTViszkulxhYhtIHZRoaaTA6FT3xnhqpfDnh6XR
         rt9ML7UEEDkx9TFvJi+EGGzRG20jFfh4126YSUEk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.149.138] ([217.61.149.138]) by web-mail.gmx.net
 (3c-app-gmx-bs53.server.lan [172.19.170.137]) (via HTTP); Tue, 2 Feb 2021
 17:21:02 +0100
MIME-Version: 1.0
Message-ID: <trinity-0ead36a9-4583-40d1-8b47-146be8ae8533-1612282862443@3c-app-gmx-bs53>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Frank Wunderlich <linux@fw-web.de>,
        linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Aw: Re:  Re:  Re: [PATCH] pci: mediatek: fix warning in msi.h
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 2 Feb 2021 17:21:02 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <c63d8d7d966c1dda82884f361d4691c3@kernel.org>
References: <20201031140330.83768-1-linux@fw-web.de>
 <1604253261.22363.0.camel@mtkswgap22>
 <trinity-9eb2a213-f877-4af3-87df-f76a9c093073-1604255233122@3c-app-gmx-bap08>
 <87k0v4u4uq.wl-maz@kernel.org> <87pn4w90hm.fsf@nanos.tec.linutronix.de>
 <df5565a2f1e821041c7c531ad52a3344@kernel.org>
 <87h7q791j8.fsf@nanos.tec.linutronix.de>
 <877dr38kt8.fsf@nanos.tec.linutronix.de>
 <901c5eb8bbaa3fe53ddc8f65917e48ef@kernel.org>
 <87o8ke7njb.fsf@nanos.tec.linutronix.de>
 <trinity-1d7f8900-10db-40c0-a0aa-47bb99ed84cd-1604508571909@3c-app-gmx-bs02>
 <87h7q4lnoz.fsf@nanos.tec.linutronix.de>
 <074d057910c3e834f4bd58821e8583b1@kernel.org>
 <87blgbl887.fsf@nanos.tec.linutronix.de>
 <c63d8d7d966c1dda82884f361d4691c3@kernel.org>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:u3SIc85K08OE7DKGZvTGXOsAnmBdfTSXT9sG/woR+q++Yox4oBwPqjdX/Z6uHwHmIaCz9
 xtoVLE6VhiyeYHWnScTDNyxEkUGTOJd7tylKctqrRlGSEA+owGrs7nyr1NZxGWbgIV+z159lUGym
 /zmcTpTSQLJ5RyWeJYJvG+K1n3k1agV04JCFP0MglDPbVPTeumrlJYzkHAvTKhOg0dV1BPu+HcGy
 EEuP6iojtiTqbE5BBj/s6s2+7/hhLLjo2SP4WotNM4ugp9hrQPPBpBsMhj6rtagoWlYfMXzQ78Cg
 w8=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:k/Dr0NOy/1k=:UIeRd3EBwGoX18LylrsoZW
 bNHoK2iWsEigwQNdjNgdfNyjpIGewc6CdfmAyzSRjhk8J4W+8p1Eyg8AKANXDqKy6jrkNWTn6
 9Gd65OejMRWCmrlS/RtSmH6gIBExjnyZ1PjiSf4TvubbsWifzgnSt9YXQwBqWGi0hccLjWGMp
 tRq2hBW6rz+MgYlmdVq7gN0t86FaK79esvt9mlSrNVmV0+YjjtFVga0gUnDAl6FyPGuCJqeTX
 nIZV1cizRaOyGEKg5zVUcOoCa4orCUIiWMZi25lZwUXgX8vrptvb6kS0s5Lx6ypZCoLmq2TMy
 /NKErKz3wQFG2atbjOZBxXraIfCSgRYKddmllYDfwQ6vD6WOV7KILNyVNnqk2xmbO8lRIlpH1
 TjCn03mzIzrV02oT+A/3I6IlKqdXhJaj32TYXpQIACiXoiKy9PCiehiD5iU6pAhIr7M2cgYtd
 B0E2op19XSYNfcxpZHrafgtqawMxUY3AIyS4QbuyMfy+/8OkN7jitcK1tw2pWbE9hpHG/Q/Uw
 WQX7UrRSM7UX+j4jFfveeA5VO6N760iiAFTdZD4BQETytd4STgm3DtjFhyEwb8ZoYaSUX682U
 qKFPvvPb3yJ0o=
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

is there any new state?

kernel test robot reports the following problem (i do not see it when compiling for my arm/arm64 devices):

ARCH=i386

drivers/pci/probe.c: In function 'pci_register_host_bridge':
>> drivers/pci/probe.c:930:39: error: 'struct device' has no member named 'msi_domain'; did you mean 'pm_domain'?
930 | (bridge->msi_domain && !bus->dev.msi_domain))

and yes...msi_domain is only member of pci_host_bridge (include/linux/pci.h)

why do you check for msi_domain in pci_bus->dev

regards Frank
