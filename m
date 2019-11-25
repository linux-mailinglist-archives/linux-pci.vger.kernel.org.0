Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A489109336
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2019 19:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbfKYSCy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Nov 2019 13:02:54 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55100 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbfKYSCw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Nov 2019 13:02:52 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so267018wmj.4
        for <linux-pci@vger.kernel.org>; Mon, 25 Nov 2019 10:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DsVFgOaoUnvqgpXrrfO/kuxApZChsstp982wmsPwKow=;
        b=BVZoTiVVWzkDa6J2Q2Qlyztkv9vYFsD8IQFSzj6F/veUx4CwkaYyPnMFRUYWaN8vy4
         FN/26iKAp68el7tDKgZOR8bbr3gZQ+IIjxSCIbCU3xYwtaRnVItBvJtOT5eD0zVON6uG
         /vdQ+r1fFJyFa5adDPjnZxlevY/yeOnNxUybX639YiR7WofyJKBI4nK48UtjD0iVidNm
         6GJ9ITcStA6id5xJFVLJHZv6Lax/OfEErhFa/2G/Ceczqd2xJ8z/NNb+5Zv+8SmMkZFv
         HaZyLOMDnD+07/EQFr1qxCxir+RJwAnSaMeHJgSUMK3rZ0osaPrGXBCwdtx82UlEbUCw
         EIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DsVFgOaoUnvqgpXrrfO/kuxApZChsstp982wmsPwKow=;
        b=q+6auOUnQVwPqDljDxVdOsnJJZZcGnQ9Y4BV2Nde4eLp8aWSJ+NvBDweNt1qXmchmx
         2ZXo+VJvHA9TrpwVEmYC/LktPHHNg2zNpHsxgZilo3m6Z4qvDqg+cRd1o+rWhVJmEB5e
         BREgoxKrOR2tInnt5vd/avnqakjWa3q4xRkgVga2NjkcH3wXofC3tPzKL5ZMIpQe9DxO
         s5CUNuPUKqUnyA7RYhhcMOnjSxfxF0JRm2SEksBYY0argQN9cB3QgdvVTEqKlqaZqhli
         iPGC9Q4eAkaUsMA49zBp3NMt7HTszprDes3YYa8Tr7Yhr6iDVPZZj5vrb3cnOZxuW+p1
         TyzQ==
X-Gm-Message-State: APjAAAW3t29frromMIJgSjSrawRbOMGuJ8O/SZHRpLmebH2vuG94VIML
        BrN3kOGOcf7Tza2YnnHEbxwyLw==
X-Google-Smtp-Source: APXvYqw9M5aeYuFnK4VC6ZcTBEX4VkbAMP2hH5YfKViShTZm/FHN5Dr4VO7dByhvs7N0wxzK+UaojA==
X-Received: by 2002:a7b:c1d3:: with SMTP id a19mr93685wmj.127.1574704970043;
        Mon, 25 Nov 2019 10:02:50 -0800 (PST)
Received: from lophozonia (xdsl-188-155-204-106.adslplus.ch. [188.155.204.106])
        by smtp.gmail.com with ESMTPSA id 72sm11785825wrl.73.2019.11.25.10.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 10:02:49 -0800 (PST)
Date:   Mon, 25 Nov 2019 19:02:47 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     "Jacob Pan (Jun)" <jacob.jun.pan@intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, virtio-dev@lists.oasis-open.org,
        rjw@rjwysocki.net, lenb@kernel.org, lorenzo.pieralisi@arm.com,
        guohanjun@huawei.com, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, joro@8bytes.org, bhelgaas@google.com,
        mst@redhat.com, jasowang@redhat.com, eric.auger@redhat.com,
        sebastien.boeuf@intel.com, kevin.tian@intel.com
Subject: Re: [RFC 00/13] virtio-iommu on non-devicetree platforms
Message-ID: <20191125180247.GD945122@lophozonia>
References: <20191122105000.800410-1-jean-philippe@linaro.org>
 <20191122160102.00004489@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122160102.00004489@intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 22, 2019 at 04:01:02PM -0800, Jacob Pan (Jun) wrote:
> > (1) ACPI has one table per vendor (DMAR for Intel, IVRS for AMD and
> > IORT for Arm). From my point of view IORT is easier to extend, since
> > we just need to introduce a new node type. There are no dependencies
> > to Arm in the Linux IORT driver, so it works well with CONFIG_X86.
> > 
> From my limited understanding, IORT and VIOT is to solve device topology
> enumeration only? I am not sure how it can be expanded to cover
> information beyond device topology. e.g. DMAR has NUMA information and
> root port ATS, I guess they are not used today in the guest but might
> be additions in the future.

The PCI root-complex node of IORT has an ATS attribute, which we can
already use. However its scope is the root complex, not individual root
ports like with DMAR.

I'm not very familiar with NUMA, but it looks like we just need to specify
a proximity domain in relation to the SRAT table, for each viommu? The
SMMUv3 node in IORT has a 4-bytes "proximity domain" field for this. We
can add the same to the VIOT virtio-iommu nodes later, since the
structures are extensible.

But it might be better to keep the bare minimum information in the FW
descriptor, and put the rest in the virtio-iommu. So yes topology
enumeration is something the device cannot do itself (not fully that is,
see (2)) but for the rest, virtio-iommu's PROBE request can provide
details about each endpoint in relation to their physical IOMMU.

We could for example add a bit in a PROBE property saying that the whole
path between the IOMMU and the endpoint supports ATS. For NUMA it might
also be more interesting to have a finer granularity, since one viommu
could be managing endpoints that are behind different physical IOMMUs. If
in the future we want to allocate page tables close to the physical IOMMU
for example, we might need to describe multiple NUMA nodes per viommu,
using the PROBE request.

Thanks,
Jean
