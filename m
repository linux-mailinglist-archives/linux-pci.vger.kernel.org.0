Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72D1A10931F
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2019 18:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfKYRxV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Nov 2019 12:53:21 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40144 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfKYRxV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Nov 2019 12:53:21 -0500
Received: by mail-wm1-f68.google.com with SMTP id y5so232405wmi.5
        for <linux-pci@vger.kernel.org>; Mon, 25 Nov 2019 09:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w762PFi0VU3n3eQDHHvKOAEXrmJ/fz15F0VMqWwRKbE=;
        b=ucHw3iITUddgxmI0WaTeJ03oRUG5uF8HifGtGA0su/1oL8KAd8AZXtYGuQKcpbum8e
         d6QnTIGwff7BVf7S6toPsGifytN5SktOO+ePb6YqXPtb6gYo3YNY4PxId/vuZoubQL3B
         HZEwCDCJkQy+orvI6z5xFNqQfTmQLH9SdLq2Q9e4wsRNaJ0SGNOa+RCVpbB12Hl8Og9f
         CXY6WHbjQ2/65OtfFrYy/fCeDjmmeVA24mCcyFcYoKY1qa9FXUzoMG82gzImz8jhXo5w
         bHyegwRNLGNDIEyqqMjAAXkzFtDrFlkTpk8MwFyhHzyAPZmSpbf+F2CL2BoPmWn8fWWF
         u01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w762PFi0VU3n3eQDHHvKOAEXrmJ/fz15F0VMqWwRKbE=;
        b=QfhggPmbGw2E7L8QC0/yr7mEl3tRrtiROzvRVHLR30+M6afp+e197G08E/CaeH/9xa
         B47bahqVmQS6puN4EdlNw0zr+QsShRUoJ7y8jo9dc/rCQTJm8+T0IkwuSoafV52iLdLR
         XfgqcQvC/N62WvGswOJ5z6j1Y12p0HlDCP0Vw9m3J8DOVgU1YiJsl4w96YGsR/TqTqH2
         nw7OaifFOOwBoLyKZJcNqfmi6PxTsdt8Ssjt3Mm0WE9JfaF1EeTRZqwdHGvhZQjNjWfF
         GcrnwTZZKpfJwsZXPdStC147Z7MpyvW+/AJvGXCEtxNXQOdTzo8CFQDsqv19FkOP3kx3
         ZvpA==
X-Gm-Message-State: APjAAAWuPs1+tB86+Y9kG3RHAWrjMM1ZXrQkGu0XM8ahnHDf/16k11y/
        Qor9JxB111qEKAs55pIYtnSqTg==
X-Google-Smtp-Source: APXvYqzAZYIvQKGmfaQYD5lQJqrthSCPdfwYB+f4khqntbOAs2pzi4zET6f0XPBxuKoaB6N7z3djFQ==
X-Received: by 2002:a7b:c959:: with SMTP id i25mr98865wml.100.1574704399261;
        Mon, 25 Nov 2019 09:53:19 -0800 (PST)
Received: from lophozonia (xdsl-188-155-204-106.adslplus.ch. [188.155.204.106])
        by smtp.gmail.com with ESMTPSA id p1sm26490wmc.38.2019.11.25.09.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 09:53:18 -0800 (PST)
Date:   Mon, 25 Nov 2019 18:53:16 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, virtio-dev@lists.oasis-open.org,
        rjw@rjwysocki.net, lenb@kernel.org, lorenzo.pieralisi@arm.com,
        guohanjun@huawei.com, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, joro@8bytes.org, bhelgaas@google.com,
        jasowang@redhat.com, jacob.jun.pan@intel.com,
        eric.auger@redhat.com, sebastien.boeuf@intel.com,
        kevin.tian@intel.com
Subject: Re: [RFC 00/13] virtio-iommu on non-devicetree platforms
Message-ID: <20191125175316.GC945122@lophozonia>
References: <20191122105000.800410-1-jean-philippe@linaro.org>
 <20191122075438-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122075438-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 22, 2019 at 08:00:46AM -0500, Michael S. Tsirkin wrote:
> > (2) In addition, there are some concerns about having virtio depend on
> >     ACPI or DT. Some hypervisors (Firecracker, QEMU microvm, kvmtool x86
> >     [1])
> 
> power?

In kvmtool it boot with device tree. It also doesn't need virtio-iommu I
think, since it has its own paravirtualized interface.

> > don't currently implement those methods.
> > 
> >     It was suggested to embed the topology description into the device.
> >     It can work, as demonstrated at the end of this RFC, with the
> >     following limitations:
> > 
> >     - The topology description must be read before any endpoint managed
> >       by the IOMMU is probed, and even before the virtio module is
> >       loaded. This RFC uses a PCI quirk to manually parse the virtio
> >       configuration. It assumes that all endpoints managed by the IOMMU
> >       are under this same PCI host.
> > 
> >     - I don't have a solution for the virtio-mmio transport at the
> >       moment, because I haven't had time to modify a host to test it. I
> >       think it could either use a notifier on the platform bus, or
> >       better, a new 'iommu' command-line argument to the virtio-mmio
> >       driver.
> 
> 	A notifier seems easier for users. What are the disadvantages of
> 	that?

For each device we have to check if it's virtio-mmio, then map the MMIO
resource and check the device type. Having a dedicated command-line
argument would be more efficient.

Thanks,
Jean
