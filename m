Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 454A217A901
	for <lists+linux-pci@lfdr.de>; Thu,  5 Mar 2020 16:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgCEPj1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Mar 2020 10:39:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31524 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725989AbgCEPj1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Mar 2020 10:39:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583422766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NqkJYnrX939afrvZWNAzIUgTdi1dF3s2yc9aSiDADMI=;
        b=PRSvraWuxX969ZEfzv/UrkXKmrwCFFHh7OkRdtAnNwpmw+6nRyxWKnuQgKOxuYsxTs7FH+
        iffA1EP7DY80c0HAJv7mv9i4TC4/FCTyxhqqaY3V3kh4qDUSezfinZfFKFSiKiW22sXsY3
        gUuO6w+yZYVWozkB1zDoqOmpFdR1VmQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-au_P6tFPM3yooqVHUn-JYg-1; Thu, 05 Mar 2020 10:39:24 -0500
X-MC-Unique: au_P6tFPM3yooqVHUn-JYg-1
Received: by mail-qk1-f199.google.com with SMTP id h6so4058239qkj.14
        for <linux-pci@vger.kernel.org>; Thu, 05 Mar 2020 07:39:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NqkJYnrX939afrvZWNAzIUgTdi1dF3s2yc9aSiDADMI=;
        b=kktiWMB53miS8k13Kgyhk1YtETpmTsK2aU6lAI0W2sTTmzhumSGSZ6+k/cGGYzM/5Z
         lyff5AUHc8NWP3se5VCqHhFeK/3a0Er6E39V9+uMDztiIptWB4k6udLdFqPfAS81nWRg
         y7vS5GVb7iRKj0/9MuwBc4QfR29vfuxh3eFWr5QoecZzBm2YdvpYmIxVRsj8eW86sU4l
         EyjzUODl15zCjPXvFAAOt68ORcGH4T2Fxh07fhQ3U2BQz3uTawW9f3ADV5nhgkKAOZiS
         fzByYomzMoo06/q84F7XeCtRDlKYIZ/xTdtZD5QW7wIvvkbL0+YGa5jnhHGEZJ4SAHn5
         y2UQ==
X-Gm-Message-State: ANhLgQ2zkWH0kd0dgX74NZpFXlatH1SXLutZJPKmQF8TSPMKaeVP7GkQ
        aHSTMGlYRDgy/ZC+HXfEha1faHJJKCcS4mGyflTBXl+aqD0vkA4Sk03m+dVijhlQ1NeR8r/eFiS
        Wj7f6IlhHgY1LYP0ujk8+
X-Received: by 2002:a37:ef04:: with SMTP id j4mr8605769qkk.68.1583422764390;
        Thu, 05 Mar 2020 07:39:24 -0800 (PST)
X-Google-Smtp-Source: ADFU+vugbQrzs1xvBMEx8t8NnE6JKtfBaXVhDcJzv5NXl0ZNLWtGWOLk269aWs3+9NVlpA5U/V3/0w==
X-Received: by 2002:a37:ef04:: with SMTP id j4mr8605755qkk.68.1583422764197;
        Thu, 05 Mar 2020 07:39:24 -0800 (PST)
Received: from redhat.com (bzq-79-180-48-224.red.bezeqint.net. [79.180.48.224])
        by smtp.gmail.com with ESMTPSA id w4sm2509730qts.92.2020.03.05.07.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 07:39:22 -0800 (PST)
Date:   Thu, 5 Mar 2020 10:39:17 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Auger Eric <eric.auger@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        jasowang@redhat.com, kevin.tian@intel.com,
        sebastien.boeuf@intel.com, jacob.jun.pan@intel.com,
        robin.murphy@arm.com
Subject: Re: [PATCH v2 1/3] iommu/virtio: Add topology description to
 virtio-iommu config space
Message-ID: <20200305103759-mutt-send-email-mst@kernel.org>
References: <20200228172537.377327-2-jean-philippe@linaro.org>
 <20200302161611.GD7829@8bytes.org>
 <9004f814-2f7c-9024-3465-6f9661b97b7a@redhat.com>
 <20200303130155.GA13185@8bytes.org>
 <20200303084753-mutt-send-email-mst@kernel.org>
 <20200303155318.GA3954@8bytes.org>
 <20200303105523-mutt-send-email-mst@kernel.org>
 <20200304133707.GB4177@8bytes.org>
 <20200304142838-mutt-send-email-mst@kernel.org>
 <20200304215001.GD3315@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304215001.GD3315@8bytes.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 04, 2020 at 10:50:02PM +0100, Joerg Roedel wrote:
> On Wed, Mar 04, 2020 at 02:34:33PM -0500, Michael S. Tsirkin wrote:
> > All these extra levels of indirection is one of the reasons
> > hypervisors such as kata try to avoid ACPI.
> 
> Platforms that don't use ACPI need another hardware detection mechanism,
> which can also be supported. But the first step here is to enable the
> general case, and for x86 platforms this means ACPI.
> 
> Regards,
> 
> 	Joerg

Frankly since a portable way to do it is needed anyway I don't see why
we also need ACPI.

-- 
MST

