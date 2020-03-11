Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAEA7181FFB
	for <lists+linux-pci@lfdr.de>; Wed, 11 Mar 2020 18:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730472AbgCKRsb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Mar 2020 13:48:31 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34949 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730363AbgCKRsb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Mar 2020 13:48:31 -0400
Received: by mail-wr1-f67.google.com with SMTP id d5so3425946wrc.2
        for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2020 10:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dJisBFKbMBqKg6noQwABaFDqaax7PpzmdnTa5T7HIFc=;
        b=DsyT07n9KmuNUcGpnGQlykLySm8c1pZltZ9XAxU+VdONAIb0KGWhkcCiNIuS44ZvPd
         rUsM/WCVSYWVY9ECcwYrIBJgzqqtrSAQ0fQB9klx4Pe+rUGeeXUPHHdg3mMFaKqbgRbp
         RGRmSAUQZ41a7eN//8o3mS/dMVv6lst/LbuNRvatAfaPquh+qwjGa4F9AuLy/n8+Nld/
         X8JiCdm+VXkXZOpNqyuy0WWT8m4uOJHz+Iv5u5K1xFLZq0bnmzWZDBBH/FABLiCnOQqe
         7UyXsaGw7mJJ/IH8Q1/azfsGE8yiicmNPaA9nuYX/937Hi4Joe5XGXs45qkWQ4AMfpyJ
         huRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dJisBFKbMBqKg6noQwABaFDqaax7PpzmdnTa5T7HIFc=;
        b=o8J0+HUMajj08RygaubwAj0d2jPKiQuDUSGo+2SwWSA1K2Yhe2P7kne69TDvbg5NNg
         T+P+74lrE+WM0wP4CSc87yJkKf+6MxVRUQmkEdUh6t0K6odVWp7whfHil9t/9oFwP/36
         gLRsD9z2yqFOUK1ZCm668AtVziYM/tWPYjn/mbrx/dhbDMKQnt4Qz0KvmqRiIqk8Mfdd
         K3x5/4wH/xSET7nxPfHGR4bGd23Ax83J01mlOeWUcsJitQdGYB3XWt6HRFeThbgjXiqQ
         NL28T0ylUVKD56BG+OhW+PcaNLsynZL24WWwcsuoQVgq3FbdIImvsxoEOlQnByqdpvSt
         t+kg==
X-Gm-Message-State: ANhLgQ0IyS53hxWDQtQHRFKcW5RWY5l8MzzUVuOiRufaF3rJdHLolE8x
        k7UEmpm/RVR2xHcTp4B30BbodcV5Eyg=
X-Google-Smtp-Source: ADFU+vs2blBggilqwVNzNXsLeIM725udDE4U7R2eyLKGjPL9fnDruIpq1F+F76rZyHH40ix4+e295Q==
X-Received: by 2002:a5d:55cf:: with SMTP id i15mr5522683wrw.321.1583948910077;
        Wed, 11 Mar 2020 10:48:30 -0700 (PDT)
Received: from myrica ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id f4sm15885350wrt.24.2020.03.11.10.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 10:48:29 -0700 (PDT)
Date:   Wed, 11 Mar 2020 18:48:22 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "Boeuf, Sebastien" <sebastien.boeuf@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>
Subject: Re: [PATCH v2 1/3] iommu/virtio: Add topology description to
 virtio-iommu config space
Message-ID: <20200311174822.GA96893@myrica>
References: <20200228172537.377327-1-jean-philippe@linaro.org>
 <20200228172537.377327-2-jean-philippe@linaro.org>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D7BE404@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D7BE404@SHSMSX104.ccr.corp.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 05, 2020 at 08:07:32AM +0000, Tian, Kevin wrote:
> > From: Jean-Philippe Brucker
> > Sent: Saturday, February 29, 2020 1:26 AM
> > 
> > Platforms without device-tree do not currently have a method for
> > describing the vIOMMU topology. Provide a topology description embedded
> > into the virtio device.
> > 
> > Use PCI FIXUP to probe the config space early, because we need to
> > discover the topology before any DMA configuration takes place, and the
> > virtio driver may be loaded much later. Since we discover the topology
> > description when probing the PCI hierarchy, the virtual IOMMU cannot
> > manage other platform devices discovered earlier.
> > 
> > This solution isn't elegant nor foolproof, but is the best we can do at
> 
> can you elaborate "isn't elegant nor foolproof" part? is there any other 
> limitation (beside pci fixup) along the route, when comparing it to 
> the ACPI-approach?

Yes "not elegant" in part because of the PCI fixup. Fixups are used to
work around bugs, and it seems strange to have one for a normal use-case.
We also have to copy some of the virtio infrastructure since this code
runs before module load. And we have to add a third DMA configuration
method.

I don't believe anymore that the "not foolproof" part is right. After
studying the device infrastructure a little more this solution seems less
fragile than I previously thought, but it's still a big hack, and it's
only half of the story.

This patch only handles PCI-based endpoints and viommu. On ACPI platforms,
where the virtio-mmio device is specified by an object with _HID LNRO0005,
supporting virtio-iommu on MMIO requires installing a bus notifier. There
I'd rather use an ACPI table for the topology. Platforms that don't have
ACPI such as microvm specify virtio-mmio devices on the command-line.
There devices are only created when the virtio-mmio module is loaded,
which is too late. In that case I think we need to add an early pass on
the command-line, instead of a bus notifier.

Thanks,
Jean
