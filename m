Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85914D1D0C
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2019 01:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731834AbfJIXuR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Oct 2019 19:50:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51619 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731145AbfJIXuR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Oct 2019 19:50:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570665015;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YAtqhT5ONsjqWUWONs3upOQbCcX6WU5MkOT7sl7Bewo=;
        b=I3G816pIrs5JzNswH8L+jg79EoPY0ZBz4gJVEMxnRSCdz/uvZh9bwsSGYPFqBA1tYXdlEz
        Gp+8G3K47wZHXAo9D8Poj8yTZMaO5lvilRgpdwYs16iXQRrCyX5uEILYoJSC7D+kVgzubP
        88tSYzqOeI+s3FtBBYZcMe1lK9iMBB8=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-gCTN2usyNsincUFZmlKQgg-1; Wed, 09 Oct 2019 19:50:14 -0400
Received: by mail-io1-f70.google.com with SMTP id u18so6810777ioc.4
        for <linux-pci@vger.kernel.org>; Wed, 09 Oct 2019 16:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=focIOQfcQNyrOXPkI531vbndDZb3WURIChJxW2xJzLs=;
        b=KI/KsuDPBoNimlz3A6ZLwTZfVbNf2ZD+G6oKYCuvDjUTqeerW+fEEuteQh8h9JPrch
         7p4g1hDN3A17I4r2vXnLti21uS2IIBQoCBhMQgBTQFpRDPLWRcLXmuqzqjI0bEnOzlEa
         21KFOtKCFiiljSYIK1FTIQtMpKBMO9A5uwCwan+v8a9kknZxfdeJDdpc1RChOnIyFtuO
         uv0uqvsQHw1me7xyKoDPFzYzsPefasOP+QHwLVft+0XI6gqJOkCWe3I73Nq6fkA+mEdn
         RV7soVtxipR6oSI4udi457Oj0wAWIUSYdls6BqjL9k+NpOza5ORz5kHd2kth2jqyKeaR
         vAAw==
X-Gm-Message-State: APjAAAVrV8BjdeZP0iAFRIa7/CdWExpGP8e1BFjRnbZHuSu6lyw8D1su
        q9moYnL+2wFd+TsZsAuVoSbpQQU/HvXkJGWu2Zfwn217t96iSBSwMCfmB0B9kE0zkYcJlJGctW/
        SOU8DKoIDSEE30GlXBSaL
X-Received: by 2002:a5d:8b49:: with SMTP id c9mr4491132iot.209.1570665013831;
        Wed, 09 Oct 2019 16:50:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyBHaFMxZO0WJshtgxh7/OOthnkRt0Ri0Ng2qxBJgBmVLrUfw4ehvtKeNCwBnq7zLTnWQxQQg==
X-Received: by 2002:a5d:8b49:: with SMTP id c9mr4491111iot.209.1570665013586;
        Wed, 09 Oct 2019 16:50:13 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id f23sm2553411ioc.36.2019.10.09.16.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 16:50:12 -0700 (PDT)
Date:   Wed, 9 Oct 2019 16:50:09 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        iommu@lists.linux-foundation.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/2] iommu/vt-d: Select PCI_PRI for INTEL_IOMMU_SVM
Message-ID: <20191009235009.a3mxw4qrklkqwuzf@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Bjorn Helgaas <helgaas@kernel.org>,
        Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, Ashok Raj <ashok.raj@intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        iommu@lists.linux-foundation.org,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20191009224551.179497-1-helgaas@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20191009224551.179497-1-helgaas@kernel.org>
User-Agent: NeoMutt/20180716
X-MC-Unique: gCTN2usyNsincUFZmlKQgg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed Oct 09 19, Bjorn Helgaas wrote:
>From: Bjorn Helgaas <bhelgaas@google.com>
>
>I think intel-iommu.c depends on CONFIG_AMD_IOMMU in an undesirable way:
>
>When CONFIG_INTEL_IOMMU_SVM=3Dy, iommu_enable_dev_iotlb() calls PRI
>interfaces (pci_reset_pri() and pci_enable_pri()), but those are only
>implemented when CONFIG_PCI_PRI is enabled.  If CONFIG_PCI_PRI is not
>enabled, there are stubs that just return failure.
>
>The INTEL_IOMMU_SVM Kconfig does nothing with PCI_PRI, but AMD_IOMMU
>selects PCI_PRI.  So if AMD_IOMMU is enabled, intel-iommu.c gets the full
>PRI interfaces.  If AMD_IOMMU is not enabled, it gets the PRI stubs.
>
>This seems wrong.  The first patch here makes INTEL_IOMMU_SVM select
>PCI_PRI so intel-iommu.c always gets the full PRI interfaces.
>
>The second patch moves pci_prg_resp_pasid_required(), which simply returns
>a bit from the PCI capability, from #ifdef CONFIG_PCI_PASID to #ifdef
>CONFIG_PCI_PRI.  This is related because INTEL_IOMMU_SVM already *does*
>select PCI_PASID, so it previously always got pci_prg_resp_pasid_required(=
)
>even though it got stubs for other PRI things.
>
>Since these are related and I have several follow-on ATS-related patches i=
n
>the queue, I'd like to take these both via the PCI tree.
>
>Bjorn Helgaas (2):
>  iommu/vt-d: Select PCI_PRI for INTEL_IOMMU_SVM
>  PCI/ATS: Move pci_prg_resp_pasid_required() to CONFIG_PCI_PRI
>
> drivers/iommu/Kconfig   |  1 +
> drivers/pci/ats.c       | 55 +++++++++++++++++++----------------------
> include/linux/pci-ats.h | 11 ++++-----
> 3 files changed, 31 insertions(+), 36 deletions(-)
>
>--=20
>2.23.0.581.g78d2f28ef7-goog
>
>_______________________________________________
>iommu mailing list
>iommu@lists.linux-foundation.org
>https://lists.linuxfoundation.org/mailman/listinfo/iommu

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

