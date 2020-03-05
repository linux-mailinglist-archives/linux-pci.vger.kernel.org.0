Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37D2A17A917
	for <lists+linux-pci@lfdr.de>; Thu,  5 Mar 2020 16:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgCEPnC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Mar 2020 10:43:02 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40106 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725977AbgCEPnC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Mar 2020 10:43:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583422980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v5mw+5LGP9RE5YEazC7GDzkU8nm5NgoMOCIQaMpmC7k=;
        b=FmcVU6jeF7BAiwFEpYuZPoOox9BJcYEP3Nl47aPq0jNme9xeQnyMJwI2AFjz3hdMdLdnm5
        vNlsghqJhr9Bz+ByLNN0RCrOKTKB+ybjoh04kYFqXIwyTwv15fQfwVuy32EXZ7hqgl8EUB
        NuxsBGPr/nLrg8n4tV0wVCDOd4mvZIE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-ICDuoy5PMcuzm6FxqGUG3w-1; Thu, 05 Mar 2020 10:42:59 -0500
X-MC-Unique: ICDuoy5PMcuzm6FxqGUG3w-1
Received: by mail-qv1-f72.google.com with SMTP id v3so3195376qve.11
        for <linux-pci@vger.kernel.org>; Thu, 05 Mar 2020 07:42:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v5mw+5LGP9RE5YEazC7GDzkU8nm5NgoMOCIQaMpmC7k=;
        b=KEyRJcYISAuM5VYIqjMarg4QHh9oGBHrZ8B2rsHg3TnUwS7jriutItZdJFykFBjJqw
         sVZkH6NTGijdYo55LB67Qu8BldlmFyOsBGo1wOncbNMi0EZVb0taS99ZUGjCW9OvU1Pq
         dxWFThu7KAZWcEKARDY/rhjcp7t88mhKqiX5a/B3vFYCV2UfjGzHRXtZQMo7ZcUKKcjx
         DQks15Wpa4A4aOnQF/Q+nf472tNf6vTBmRbBwOt1WCMGxeYzLlAMrmkmYvXaIcFB8U01
         9cYpQZr1dO2VIF5bD5PTqPUK4jxIJ5L+JtRYQdUmRYM4UImdNdZPAfP77meFyMpgE7rP
         2A1Q==
X-Gm-Message-State: ANhLgQ2QN9qoD5ZS0WZYBb0GmXHzG4tSl3UhqEqlohYtJzsUPsOfIiFi
        ve/m62xVzB0J3uY51GaGnt4VnvVrDY1ijAm/L7DyDSC9CZmAljlYq8cL/jn+w0OygZ4vatskI8X
        m3Gv0GbDha6ID99hK75fV
X-Received: by 2002:a05:6214:1404:: with SMTP id n4mr6985874qvx.237.1583422978682;
        Thu, 05 Mar 2020 07:42:58 -0800 (PST)
X-Google-Smtp-Source: ADFU+vupwTlYbbOVLm7I6MzJJZnvoKTQidVVSGtwHtFKHWgU4GKKZRAi3AoaWmSSz3B5Prm1w8y2nQ==
X-Received: by 2002:a05:6214:1404:: with SMTP id n4mr6985848qvx.237.1583422978417;
        Thu, 05 Mar 2020 07:42:58 -0800 (PST)
Received: from redhat.com (bzq-79-180-48-224.red.bezeqint.net. [79.180.48.224])
        by smtp.gmail.com with ESMTPSA id n8sm15851215qke.37.2020.03.05.07.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 07:42:57 -0800 (PST)
Date:   Thu, 5 Mar 2020 10:42:51 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     "Jacob Pan (Jun)" <jacob.jun.pan@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Auger Eric <eric.auger@redhat.com>,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        jasowang@redhat.com, kevin.tian@intel.com,
        sebastien.boeuf@intel.com, robin.murphy@arm.com,
        "Kaneda, Erik" <erik.kaneda@intel.com>,
        "Rothman, Michael A" <michael.a.rothman@intel.com>
Subject: Re: [PATCH v2 1/3] iommu/virtio: Add topology description to
 virtio-iommu config space
Message-ID: <20200305104002-mutt-send-email-mst@kernel.org>
References: <9004f814-2f7c-9024-3465-6f9661b97b7a@redhat.com>
 <20200303130155.GA13185@8bytes.org>
 <20200303084753-mutt-send-email-mst@kernel.org>
 <20200303155318.GA3954@8bytes.org>
 <20200303105523-mutt-send-email-mst@kernel.org>
 <20200304133707.GB4177@8bytes.org>
 <20200304153821.GE646000@myrica>
 <20200304174045.GC3315@8bytes.org>
 <20200304133744.00000fdb@intel.com>
 <20200304215449.GE3315@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304215449.GE3315@8bytes.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 04, 2020 at 10:54:49PM +0100, Joerg Roedel wrote:
> On Wed, Mar 04, 2020 at 01:37:44PM -0800, Jacob Pan (Jun) wrote:
> > + Mike and Erik who work closely on UEFI and ACPICA.
> > 
> > Copy paste Erik's initial response below on how to get a new table,
> > seems to confirm with the process you stated above.
> > 
> > "Fairly easy. You reserve a 4-letter symbol by sending a message
> > requesting to reserve the signature to Mike or the ASWG mailing list or
> > info@acpi.info
> 
> Great! I think this is going to be the path forward here.
> 
> Regards,
> 
> 	Joerg

I don't, I don't see why we should bother with ACPI. This is a PV device
anyway, we can just make it self-describing. The need for extra firmware
on some platforms is a bug not a feature. No point in emulating that.

> > 
> > There is also another option. You can have ASWG own this new table so
> > that not one entity or company owns the new table."

