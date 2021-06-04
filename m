Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED0CF39B135
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 06:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbhFDEJm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Jun 2021 00:09:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229775AbhFDEJm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Jun 2021 00:09:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2336D613F6;
        Fri,  4 Jun 2021 04:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622779676;
        bh=Fa4/vxtklnpuLSehENDylHOnyear+62tzcqRhPIPqek=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eV/07M0PUUi3rOoNjsY2m3a/yz9ORz3+mylUp9T/vwFzEDkHIQGD0giGKx07H99YO
         7CGMX0wK/0aAOm6qJMDlu+oUX4+fND7z9ms+tW6xLLOQi6wCmKI/0FJO19Q/OP+CzV
         MfwMuH7t0qdVd/iGyQwiWxz4ZFSjg5+ybzbrk5WIMz30qFAmhRPwlDLkvqcJnEp5Oc
         lwQD9hGEsBEnRRjW+XtQO/1gfMNaIvB9Pqo6pM/joz1wKXpiXeqV4bCuatWT51es5P
         OVZXKZ2jQ8tmJXe9PxxzvVh3zpTIHW1ApvGOrn8EdZPpkbkR5k3T2chr55nXLLgGxO
         b6k/qsOw/kHRw==
Date:   Thu, 3 Jun 2021 23:07:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Joe Perches <joe@perches.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 0/6] PCI/sysfs: Use sysfs_emit() and sysfs_emit_at()
 in "show" functions
Message-ID: <20210604040749.GA2170475@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210603000112.703037-1-kw@linux.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 03, 2021 at 12:01:06AM +0000, Krzysztof Wilczyński wrote:
> Hello,
> 
> This series aims to bring support for the sysfs_emit() and
> sysfs_emit_at() functions to the existing PCI-related sysfs objects.
> These new functions were introduced to make it less ambiguous which
> function is preferred when writing to the output buffer in a device
> attribute's "show" callback [1].
> 
> Thus, the existing PCI sysfs objects "show" functions will be converted
> from the using the sprintf(), snprintf() and scnprintf() functions to
> sysfs_emit() and sysfs_emit_at() accordingly, as the latter is aware of
> the PAGE_SIZE buffer limit that the sysfs object has and correctly
> returns the number of bytes written into the buffer.
> 
> This series will also address inconsistency related to the presence (or
> lack of thereof) of a trailing newline in the show() functions adding it
> where it's currently missing.  This will allow for utilities such as the
> "cat" command to display the result of the read from a particular sysfs
> object correctly in a shell.
> 
> While working on this series a problem with newline handling related to
> how the value of the "resource_alignment" sysfs object was parsed and
> then persisted has been found and corrected.  Also, while at it,
> a change enabling support for the value of "resource_alignment"
> previously set using either a command-line argument or through the sysfs
> object to be cleared at run-time was also included, and thus aligning
> this particular sysfs object with the behaviour of other such objects
> that allow for the value to be dynamically updated and cleared as
> required.
> 
> Additionally, a fix to a potential buffer overrun that has been found in
> the dsm_label_utf16s_to_utf8s() function that is responsible for the
> character conversion from UTF16 to UTF8 of the buffer that holds the
> device label obtained through the ACPI _DSM mechanism is included as
> part of this series.
> 
> Finally, a minor fix is also included in this series that has been added
> to ensure that the value of the "driver_override" variable is only
> exposed through the corresponding sysfs object when a value is set or
> otherwise if the value has not been set, the object would return
> a string representation of the NULL value.  This will also align this
> particular sysfs object's behaviour with others, where when there is no
> value then nothing is returned.
> 
> [1] Documentation/filesystems/sysfs.rst
> 
> This series is related to:
>   commit ad025f8 ("PCI/sysfs: Use sysfs_emit() and sysfs_emit_at() in "show" functions")
> 
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
> 
> ---
> Changes in v2:
>   None.
> 
> Changes in v3:
>   Added Logan Gunthorpe's "Reviewed-by".
> 
> Changes in v4:
>   Separated and squashed all the trivial sysfs_emit()/sysfs_emit_at()
>   changes into a single patch as per Bjorn Helgaas' request.
>   Carried Logan Gunthorpe's "Reviewed-by" over.
> 
> Changes in v5:
>   Added check to the resource_alignment_show() function to ensure that
>   there is an extra space left in the buffer for the newline character,
>   assuming that it might be provided.
> 
> Changes in v6:
>   Added a cover letter as per Bjorn Helgaas' request.
>   New patch addressing a potential buffer overrun in the
>   dsm_label_utf16s_to_utf8s() function has been added.
> 
> Krzysztof Wilczyński (6):
>   PCI/sysfs: Use sysfs_emit() and sysfs_emit_at() in "show" functions
>   PCI/sysfs: Use return value from dsm_label_utf16s_to_utf8s() directly
>   PCI/sysfs: Fix trailing newline handling of resource_alignment_param
>   PCI/sysfs: Add missing trailing newline to devspec_show()
>   PCI/sysfs: Only show value when driver_override is not NULL
>   PCI/sysfs: Fix a buffer overrun problem with
>     dsm_label_utf16s_to_utf8s()
> 
>  drivers/pci/hotplug/pci_hotplug_core.c |  8 +++---
>  drivers/pci/hotplug/rpadlpar_sysfs.c   |  4 +--
>  drivers/pci/hotplug/shpchp_sysfs.c     | 38 ++++++++++++++------------
>  drivers/pci/iov.c                      | 12 ++++----
>  drivers/pci/msi.c                      |  8 +++---
>  drivers/pci/p2pdma.c                   |  7 ++---
>  drivers/pci/pci-label.c                | 22 ++++++++-------
>  drivers/pci/pci-sysfs.c                |  7 +++--
>  drivers/pci/pci.c                      | 34 +++++++++++++----------
>  drivers/pci/pcie/aer.c                 | 20 ++++++++------
>  drivers/pci/pcie/aspm.c                |  4 +--
>  drivers/pci/slot.c                     | 18 ++++++------
>  drivers/pci/switch/switchtec.c         | 18 ++++++------
>  13 files changed, 107 insertions(+), 93 deletions(-)

I applied these to pci/resource for v5.14, thanks!

I dropped the driver_override change to avoid breaking driverctl.

I reordered the dsm_label_utf16s_to_utf8s()-related patches to make
the buffer overflow fix slightly smaller.

If we need to tweak the resource_alignment_param patch, I can just
squash in incremental changes.
