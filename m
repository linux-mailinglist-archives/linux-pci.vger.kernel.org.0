Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47888369646
	for <lists+linux-pci@lfdr.de>; Fri, 23 Apr 2021 17:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbhDWPho (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Apr 2021 11:37:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27631 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242623AbhDWPhn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Apr 2021 11:37:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619192226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QE00ekCvz72op1kqPnrabeAOzDQ62cHgXJniiHHMFJ8=;
        b=NQYMzCzYtkZqLFBTDgVAsRkXMGZcWClNWuosVyG9IAtEyCRGnDWIi0YNLT18gxKYZPjlIu
        lHq4ASjZsGynJ1zV3aJwt2bEdkiTwfGojQTbtRFl/Q3o4rw0+Gol9YcA92f/9uLuemsVSj
        q1CXLMFd1YtgFQGqyqqGzk4ASOtdn9g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-2thQh4izMbe4Ge3gmIpgBA-1; Fri, 23 Apr 2021 11:37:04 -0400
X-MC-Unique: 2thQh4izMbe4Ge3gmIpgBA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 990C6652;
        Fri, 23 Apr 2021 15:37:02 +0000 (UTC)
Received: from redhat.com (ovpn-114-21.phx2.redhat.com [10.3.114.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 297A719704;
        Fri, 23 Apr 2021 15:37:02 +0000 (UTC)
Date:   Fri, 23 Apr 2021 09:37:01 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     Shanker Donthineni <sdonthineni@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vikram Sethi <vsethi@nvidia.com>
Subject: Re: [PATCH 1/1] PCI: Add pci reset quirk for Nvidia GPUs
Message-ID: <20210423093701.594efd86@redhat.com>
In-Reply-To: <ff4812ba-ec1d-9462-0cbd-029635af3267@kernel.org>
References: <20210423145402.14559-1-sdonthineni@nvidia.com>
        <ff4812ba-ec1d-9462-0cbd-029635af3267@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 23 Apr 2021 11:12:05 -0400
Sinan Kaya <okaya@kernel.org> wrote:

> +Alex,
> 
> On 4/23/2021 10:54 AM, Shanker Donthineni wrote:
> > +static int reset_nvidia_gpu_quirk(struct pci_dev *dev, int probe)
> > +{
> > +#ifdef CONFIG_ACPI
> > +	acpi_handle handle = ACPI_HANDLE(&dev->dev);
> > +
> > +	/*
> > +	 * Check for the affected devices' ID range. If device is not in
> > +	 * the affected range, return -ENOTTY indicating no device
> > +	 * specific reset method is available.
> > +	 */
> > +	if ((dev->device & 0xffc0) != 0x2340)
> > +		return -ENOTTY;
> > +
> > +	/*
> > +	 * Return -ENOTTY indicating no device-specific reset method if _RST
> > +	 * method is not defined
> > +	 */
> > +	if (!handle || !acpi_has_method(handle, "_RST"))
> > +		return -ENOTTY;
> > +
> > +	/* Return 0 for probe phase indicating that we can reset this device */
> > +	if (probe)
> > +		return 0;
> > +
> > +	/* Invoke _RST() method to perform the device-specific reset */
> > +	if (ACPI_FAILURE(acpi_evaluate_object(handle, "_RST", NULL, NULL))) {
> > +		pci_warn(dev, "Failed to reset the device\n");
> > +		return -EINVAL;
> > +	}
> > +	return 0;
> > +#else
> > +	return -ENOTTY;
> > +#endif
> > +}  
> 
> Interesting, some pieces of this function (especially the ACPI _RST)
> could be generalized.

Agreed, we should add a new function level reset method for this rather
than a device specific reset.  At that point the extent of the device
specific quirk could be to restrict SBR.  It'd be useful to know what
these devices are (not in pciids yet), why we expect to only see them in
specific platforms (embedded device?), and the failure mode of the SBR.
Thanks,

Alex

