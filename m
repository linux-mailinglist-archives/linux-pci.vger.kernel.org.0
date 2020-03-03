Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5C51773DB
	for <lists+linux-pci@lfdr.de>; Tue,  3 Mar 2020 11:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbgCCKTe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 05:19:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51862 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726661AbgCCKTd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Mar 2020 05:19:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583230772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+UK+NMIgmwHXQhkRXAJ4Lsi7p+Mwd36pSYsGKvj2cB0=;
        b=SfKRCoZ+rSSPDJrk/l8A56OJItYNdPcG/NDdEkldIeOQYLiikgifSXnZh0I3PCCcT/3Dqd
        dyWj/vbLqtq0hjWbaBQrbi0r+cY7sCXF2dg2Fg0pLCmZ5kA1iMtwQnMTHvCY0hX2chskp/
        jEzTs1uxKK/gyEujr+QRI2rgweOC3sg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-3lbbavzDNpGMbY6vLt0Brg-1; Tue, 03 Mar 2020 05:19:29 -0500
X-MC-Unique: 3lbbavzDNpGMbY6vLt0Brg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50AEB100550E;
        Tue,  3 Mar 2020 10:19:27 +0000 (UTC)
Received: from [10.36.116.59] (ovpn-116-59.ams2.redhat.com [10.36.116.59])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 02A3A1001B09;
        Tue,  3 Mar 2020 10:19:21 +0000 (UTC)
Subject: Re: [PATCH v2 1/3] iommu/virtio: Add topology description to
 virtio-iommu config space
To:     Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, bhelgaas@google.com, mst@redhat.com,
        jasowang@redhat.com, kevin.tian@intel.com,
        sebastien.boeuf@intel.com, jacob.jun.pan@intel.com,
        robin.murphy@arm.com
References: <20200228172537.377327-1-jean-philippe@linaro.org>
 <20200228172537.377327-2-jean-philippe@linaro.org>
 <20200302161611.GD7829@8bytes.org>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <9004f814-2f7c-9024-3465-6f9661b97b7a@redhat.com>
Date:   Tue, 3 Mar 2020 11:19:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200302161611.GD7829@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Joerg,

On 3/2/20 5:16 PM, Joerg Roedel wrote:
> On Fri, Feb 28, 2020 at 06:25:36PM +0100, Jean-Philippe Brucker wrote:
>> This solution isn't elegant nor foolproof, but is the best we can do at
>> the moment and works with existing virtio-iommu implementations. It also
>> enables an IOMMU for lightweight hypervisors that do not rely on
>> firmware methods for booting.
> 
> I appreciate the enablement on x86, but putting the conmfiguration into
> mmio-space isn't really something I want to see upstream. What is the
> problem with defining an ACPI table instead? This would also make things
> work on AARCH64 UEFI machines.
Michael has pushed this solution (putting the "configuration in the PCI
config space"), I think for those main reasons:
- ACPI may not be supported on some archs/hyps
- the virtio-iommu is a PCIe device so binding should not need ACPI
description

Another issue with ACPI integration is we have different flavours of
tables that exist: IORT, DMAR, IVRS

x86 ACPI integration was suggested with IORT. But it seems ARM is
reluctant to extend IORT to support para-virtualized IOMMU. So the VIOT
was proposed as a different atternative in "[RFC 00/13] virtio-iommu on
non-devicetree platforms"
(https://patchwork.kernel.org/cover/11257727/). Proposing a table that
may be used by different vendors seems to be a challenging issue here.

So even if the above solution does not look perfect, it looked a
sensible compromise given the above arguments. Please could you explain
what are the most compelling arguments against it?

Thanks

Eric
> 
> Regards,
> 
> 	Joerg
> 

