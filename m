Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8773F2B30A7
	for <lists+linux-pci@lfdr.de>; Sat, 14 Nov 2020 21:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgKNUj1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 14 Nov 2020 15:39:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:33840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbgKNUj1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 14 Nov 2020 15:39:27 -0500
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0343223EA;
        Sat, 14 Nov 2020 20:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605386367;
        bh=phzN4c8T4A83NSrUwrdPTsK4VSESQBGRl/KVZH9nF4s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=vqAjbm3N3JcxQm7JAhD7Apa3Sj84OFUG3OgpJPu5sjvS2baSLfNNtXN9MVWvXIXXy
         TkrT8EbTVz2lk0OWIZIvPFjHBUkC4ithkJI6QnxcaidiyMYihY97Gf81EPRKQ5FgEr
         5Jdzu02eibYttU73MDsdsEzK2m6yIV8dx9CAWiYY=
Date:   Sat, 14 Nov 2020 14:39:25 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        linux-pci@vger.kernel.org, kexec@lists.infradead.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, andi@firstfloor.org,
        lukas@wunner.de, okaya@kernel.org, kernelfans@gmail.com,
        ddstreet@canonical.com, gavin.guo@canonical.com,
        jay.vosburgh@canonical.com, kernel@gpiccoli.net,
        shan.gavin@linux.alibaba.com,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH 1/3] x86/quirks: Scan all busses for early PCI quirks
Message-ID: <20201114203925.GA1182595@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d00gltb9.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Nov 14, 2020 at 12:40:10AM +0100, Thomas Gleixner wrote:
> Bjorn,
> 
> On Sat, Nov 14 2020 at 00:31, Thomas Gleixner wrote:
> > On Fri, Nov 13 2020 at 10:46, Bjorn Helgaas wrote:
> >> pci_device_shutdown() still clears the Bus Master Enable bit if we're
> >> doing a kexec and the device is in D0-D3hot, which should also disable
> >> MSI/MSI-X.  Why doesn't this solve the problem?  Is this because the
> >> device causing the storm was in PCI_UNKNOWN state?
> >
> > That's indeed a really good question.
> 
> So we do that on kexec, but is that true when starting a kdump kernel
> from a kernel crash? I doubt it.

Ah, right, I bet that's it, thanks.  The kdump path is basically this:

  crash_kexec
    machine_kexec

while the usual kexec path is:

  kernel_kexec
    kernel_restart_prepare
      device_shutdown
        while (!list_empty(&devices_kset->list))
          dev->bus->shutdown
            pci_device_shutdown            # pci_bus_type.shutdown
    machine_kexec

So maybe we need to explore doing some or all of device_shutdown() in
the crash_kexec() path as well as in the kernel_kexec() path.
