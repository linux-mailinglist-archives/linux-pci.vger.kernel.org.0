Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 525FE1C4DA4
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 07:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725535AbgEEFTv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 May 2020 01:19:51 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54000 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725320AbgEEFTt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 May 2020 01:19:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588655987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TDox4kEBOjt8ok5EwDS4BtmzAHx0WC6c0UbWruHoZeA=;
        b=ihcDoq+3IjI5QDzYWEqbp6I800c9QbhKLBnsyQ4qUSo4R7fI17nht6r0gp6xx/xHaVZTUN
        n6lAnhW802CL0sx1JRZK9nPqzSoscTQ8h0eWUT4rGb+YgsLBjfI2fuQmMquHnjs1w7wg4U
        +U2QP3cYc+4M2E39WzVRkmM4ZuSDfsg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-iSxElwQHOpamPjQotqIKYw-1; Tue, 05 May 2020 01:19:40 -0400
X-MC-Unique: iSxElwQHOpamPjQotqIKYw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4EE1A1005510;
        Tue,  5 May 2020 05:19:38 +0000 (UTC)
Received: from x1.home (ovpn-113-95.phx2.redhat.com [10.3.113.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 86DD25D9D3;
        Tue,  5 May 2020 05:19:37 +0000 (UTC)
Date:   Mon, 4 May 2020 23:19:36 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Darrel Goeddel <DGoeddel@forcepoint.com>,
        Mark Scott <mscott@forcepoint.com>,
        Romil Sharma <rsharma@forcepoint.com>
Subject: Re: [PATCH] iommu: Relax ACS requirement for RCiEP devices.
Message-ID: <20200504231936.2bc07fe3@x1.home>
In-Reply-To: <1588653736-10835-1-git-send-email-ashok.raj@intel.com>
References: <1588653736-10835-1-git-send-email-ashok.raj@intel.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon,  4 May 2020 21:42:16 -0700
Ashok Raj <ashok.raj@intel.com> wrote:

> PCIe Spec recommends we can relax ACS requirement for RCIEP devices.
> 
> PCIe 5.0 Specification.
> 6.12 Access Control Services (ACS)
> Implementation of ACS in RCiEPs is permitted but not required. It is
> explicitly permitted that, within a single Root Complex, some RCiEPs
> implement ACS and some do not. It is strongly recommended that Root Complex
> implementations ensure that all accesses originating from RCiEPs
> (PFs and VFs) without ACS capability are first subjected to processing by
> the Translation Agent (TA) in the Root Complex before further decoding and
> processing. The details of such Root Complex handling are outside the scope
> of this specification.
> 
> Since Linux didn't give special treatment to allow this exception, certain
> RCiEP MFD devices are getting grouped in a single iommu group. This
> doesn't permit a single device to be assigned to a guest for instance.
> 
> In one vendor system: Device 14.x were grouped in a single IOMMU group.
> 
> /sys/kernel/iommu_groups/5/devices/0000:00:14.0
> /sys/kernel/iommu_groups/5/devices/0000:00:14.2
> /sys/kernel/iommu_groups/5/devices/0000:00:14.3
> 
> After the patch:
> /sys/kernel/iommu_groups/5/devices/0000:00:14.0
> /sys/kernel/iommu_groups/5/devices/0000:00:14.2
> /sys/kernel/iommu_groups/6/devices/0000:00:14.3 <<< new group
> 
> 14.0 and 14.2 are integrated devices, but legacy end points.
> Whereas 14.3 was a PCIe compliant RCiEP.
> 
> 00:14.3 Network controller: Intel Corporation Device 9df0 (rev 30)
> Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, MSI 00
> 
> This permits assigning this device to a guest VM.
> 
> Fixes: f096c061f552 ("iommu: Rework iommu_group_get_for_pci_dev()")
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> To: Joerg Roedel <joro@8bytes.org>
> To: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: iommu@lists.linux-foundation.org
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Darrel Goeddel <DGoeddel@forcepoint.com>
> Cc: Mark Scott <mscott@forcepoint.com>,
> Cc: Romil Sharma <rsharma@forcepoint.com>
> Cc: Ashok Raj <ashok.raj@intel.com>
> ---
>  drivers/iommu/iommu.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 2b471419e26c..5744bd65f3e2 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1187,7 +1187,20 @@ static struct iommu_group *get_pci_function_alias_group(struct pci_dev *pdev,
>  	struct pci_dev *tmp = NULL;
>  	struct iommu_group *group;
>  
> -	if (!pdev->multifunction || pci_acs_enabled(pdev, REQ_ACS_FLAGS))
> +	/*
> +	 * PCI Spec 5.0, Section 6.12 Access Control Service
> +	 * Implementation of ACS in RCiEPs is permitted but not required.
> +	 * It is explicitly permitted that, within a single Root
> +	 * Complex, some RCiEPs implement ACS and some do not. It is
> +	 * strongly recommended that Root Complex implementations ensure
> +	 * that all accesses originating from RCiEPs (PFs and VFs) without
> +	 * ACS capability are first subjected to processing by the Translation
> +	 * Agent (TA) in the Root Complex before further decoding and
> +	 * processing.
> +	 */

Is the language here really strong enough to make this change?  ACS is
an optional feature, so being permitted but not required is rather
meaningless.  The spec is also specifically avoiding the words "must"
or "shall" and even when emphasized with "strongly", we still only have
a recommendation that may or may not be honored.  This seems like a
weak basis for assuming that RCiEPs universally honor this
recommendation.  Thanks,

Alex

> +	if (!pdev->multifunction ||
> +	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END) ||
> +	     pci_acs_enabled(pdev, REQ_ACS_FLAGS))
>  		return NULL;
>  
>  	for_each_pci_dev(tmp) {

