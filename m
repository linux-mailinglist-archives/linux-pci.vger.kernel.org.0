Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42B84137ABB
	for <lists+linux-pci@lfdr.de>; Sat, 11 Jan 2020 01:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbgAKApV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jan 2020 19:45:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34643 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727755AbgAKApU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jan 2020 19:45:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578703519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iciugV/+jGgeytpBp9cwmPzmMPdUEsiCwhKZNaz4hBc=;
        b=S/LRCtu9MHMr/PQIceVX/SvkSuJMpNDXG+QEFKoUgWipivIwW4R/p+eNIJI7xnpoPj0pCT
        Qquy/QDg7PMZK/RRtMG7dm2M006o4g5gMrSPyqMVXgBA82qhypkGg/QvAyWyx2tv9BcpXI
        J7U9/G2Qk+EI+zMyHm5UwFdV16uR9hU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-Ty8LDPj2M76JWCO6KMHjEw-1; Fri, 10 Jan 2020 19:45:18 -0500
X-MC-Unique: Ty8LDPj2M76JWCO6KMHjEw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 940A2800D48;
        Sat, 11 Jan 2020 00:45:16 +0000 (UTC)
Received: from localhost (ovpn-12-27.pek2.redhat.com [10.72.12.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5EA315C1B5;
        Sat, 11 Jan 2020 00:45:13 +0000 (UTC)
Date:   Sat, 11 Jan 2020 08:45:10 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Jerry Hoemann <jerry.hoemann@hpe.com>
Cc:     Khalid Aziz and Shuah Khan <azizkhan@gonehiking.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Kairui Song <kasong@redhat.com>, linux-pci@vger.kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Randy Wright <rwright@hpe.com>, dyoung@redhat.com
Subject: Re: [RFC PATCH] PCI, kdump: Clear bus master bit upon shutdown in
 kdump kernel
Message-ID: <20200111004510.GA19291@MiWiFi-R3L-srv>
References: <20200110214217.GA88274@google.com>
 <e0194581-4cdd-3629-d9fe-10a1cfd29d03@gonehiking.org>
 <20200110230003.GB1875851@anatevka.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110230003.GB1875851@anatevka.americas.hpqcorp.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 01/10/20 at 04:00pm, Jerry Hoemann wrote:
> > I am not understanding this failure mode either. That code in
> > pci_device_shutdown() was added originally to address this very issue.
> > The patch 4fc9bbf98fd6 ("PCI: Disable Bus Master only on kexec reboot")
> > shut down any errant DMAs from PCI devices as we kexec a new kernel. In
> > this new patch, this is the same code path that will be taken again when
> > kdump kernel is shutting down. If the errant DMA problem was not fixed
> > by clearing Bus Master bit in this path when kdump kernel was being
> > kexec'd, why does the same code path work the second time around when
> > kdump kernel is shutting down? Is there more going on that we don't
> > understand?
> > 
> 
>   Khalid,
> 
>   I don't believe we execute that code path in the crash case.
> 
>   The variable kexec_in_progress is set true in kernel_kexec() before calling
>   machine_kexec().  This is the fast reboot case.
> 
>   I don't see kexec_in_progress set true elsewhere.
> 
> 
>   The code path for crash is different.
> 
>   For instance, panic() will call
> 	-> __crash_kexec()  which calls
> 		-> machine_kexec().
> 
>  So the setting of kexec_in_progress is bypassed.

Yeah, it's a differet behaviour than kexec case. I talked to Kairui, the
patch log may be not very clear. Below is summary I got from my
understanding about this issue:

~~~~~~~~~~~~~~~~~~~~~~~
Problem:

When crash is triggered, system jumps into kdump kernel to collect
vmcore and dump out. After dumping is finished, kdump kernel will try
ty reboot to normal kernel. This hang happened during kdump kernel
rebooting, when dumping is network dumping, e.g ssh/nfs, local storage
is HPSA.

Root cause:

When configuring network dumping, only network driver modules are added
into kdump initramfs. However, the storage HPSA pcie device is enabled
in 1st kernel, its status is PCI_D3hot. When crashed system jumps to kdump
kernel, we didn't shutdown any device for safety and efficiency. Then
during kdump kernel boot up, the pci scan will get hpsa device and only
initialize its status as pci_dev->current_state = PCI_UNKNOWN. This
pci_dev->current_state will be manipulated by the relevant device
driver. So HPSA device will never have chance to calibrate its status,
and can't be shut down by pci_device_shutdown() called by reboot
service. It's still PCI_D3hot, then crash happened when system try to
shutdown its upper bridge.

Fix:

Here, Kairui uses a quirk to get PM state and mask off value bigger than
PCI_D3cold. Means, all devices will get PM state 
pci_dev->current_state = PCI_D0 or PCI_D3hot. Finally, during kdump
reboot stage, this device can be shut down successfully by clearing its
master bit.

~~~~~~~~~~~~~~~

About this patch, I think the quirk getting active PM state for all devices
may be risky, it will impact normal kernel too which doesn't have this issue.

Wondering if there's any other way to fix or work around it.

Thanks
Baoquan

