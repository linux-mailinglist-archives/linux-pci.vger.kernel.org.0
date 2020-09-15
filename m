Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D36526AED2
	for <lists+linux-pci@lfdr.de>; Tue, 15 Sep 2020 22:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgIOUph (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Sep 2020 16:45:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:38264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727934AbgIOUie (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Sep 2020 16:38:34 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E009D20771;
        Tue, 15 Sep 2020 20:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600202313;
        bh=6OFcjc8AUBZdK+9plPG89k0p2JtR+uS0BbwxGz9pmZ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QXXRhIgOj6M/8UA44zC7096rO6fmBPjFGKYGx5rC92qDU9yhVJwOyj7ijajWVAp/C
         Vn2Xu/NNBm4oJToVKv0TlqBZ2StQJOnD7EzAW9SYRanhY2zfXB5N4xIRuE33tqHK3X
         d2wSC1qMoX5zFDweF8Qq6/h8k0WKCew4U88uIAHE=
Date:   Tue, 15 Sep 2020 15:38:31 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Konstantin Khlebnikov <khlebnikov@openvz.org>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Lukas Wunner <lukas@wunner.de>,
        Oliver O'Halloran <oohall@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        zhouyanjie <zhouyanjie@wanyeetech.com>, git <git@xen0n.name>
Subject: Re: [RFC PATCH v3] PCI/portdrv: Only disable Bus Master on kexec
 reboot and connected PCI devices
Message-ID: <20200915203831.GA1426995@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H7+jMPab9oM_E1J8cfzq0NYCd3w==1WNV3_Hkt0NL7ZCA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 15, 2020 at 09:36:13AM +0800, Huacai Chen wrote:
> Hi, Tiezhu,
> 
> On Mon, Sep 14, 2020 at 7:25 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> >
> > On 09/14/2020 05:46 PM, Huacai Chen wrote:
> > > Hi, Tiezhu,
> > >
> > > On Mon, Sep 14, 2020 at 5:30 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> > >> On 09/14/2020 04:52 PM, Huacai Chen wrote:
> > >>> Hi, Tiezhu,
> > >>>
> > >>> How do you test kexec? kexec -e or systemctl kexec? Or both?
> > >> kexec -l vmlinux --append="root=/dev/sda2 console=ttyS0,115200"
> > >> kexec -e
> > > So you haven't tested "systemctl kexec"?
> >
> > Yes, the distro I used is Loongnix which has not kexec service now.
> > Is there any problem when use systemctl kexec? If you have more details,
> > please let me know.
> If you use systemctl kexec, the first part of kexec is the same as a
> normal reboot/poweroff. So, there is no reason that reboot/poweroff is
> bad but kexec is good.
> Then, Bjorn, what is the best solution now? It seems like my first
> version is OK (commit messages should be improved, of course).

Sorry, there are too many conversations going on for me to keep track
of what first version you're referring to.  Please include a specific
lore.kernel.org URL.

Bjorn
