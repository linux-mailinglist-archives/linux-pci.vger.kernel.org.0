Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3719027713B
	for <lists+linux-pci@lfdr.de>; Thu, 24 Sep 2020 14:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbgIXMld (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Sep 2020 08:41:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49261 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727570AbgIXMld (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Sep 2020 08:41:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600951291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aNSiF3HKmN7T9wLSIPvLbtJzDyySplPmYpNDTcjCSdE=;
        b=Iq4Nc56+qxPCtsc9Np16NHTK8Qq+B6BBTv8y4Fakr/nrlgk73LWeOgxj2eHtDKBIol6Dze
        7iXi4SaKHli28MQ88/itFneRQqYvPY6h44W6nwc9Ej9nMRB+so/pZ84tAe2l1bVxQ3XE1l
        KuJXpb6dXkmMg4x4IWEziaZnKdD659Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-T0G3EO7NN3qANHK6jKM01A-1; Thu, 24 Sep 2020 08:41:28 -0400
X-MC-Unique: T0G3EO7NN3qANHK6jKM01A-1
Received: by mail-wr1-f70.google.com with SMTP id w7so1197635wrp.2
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2020 05:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aNSiF3HKmN7T9wLSIPvLbtJzDyySplPmYpNDTcjCSdE=;
        b=HvLBHmZVXbuPa/tMQqh41aRnBm1Ql2t8NPxY2ior88vyS1CqxcR+/6hvqn2AlWxCG2
         4EQSIjYBxoF8KXxT9dcoBru0TeoKT1zueYcZRPmdAIO8z9E4trrYj/6W8lkf1unvxPV7
         INL8dacpoljcw1tV/qNEZiZ4y0F/Q5FQkjr8LSrenFGRbvyoLs0qJjH78L5ttNX/yW/U
         XSuSodlFdJddESmaP0LxfhtLJT1whNGEIRhpGKUBsV8NNb7/qTSejM1AEacGTjTv9YE0
         SPeW0qJaIxNxoiQpDSD+JG9v8f9vsr2D0QOEY0S9zvNyybnSfmWmjPf+AKpM5ouuUvZU
         HXXw==
X-Gm-Message-State: AOAM530TE4vJlfoNrahHsbZyY04QBflOTVn/Wod8UvioKFsGKmPmYk6D
        7I67tKLnh8dDKsmaUYBQGT2IBeVuR+rTjmKKfn2R7MgJSqZYMyHSVYNQTn9teDZNBLalFX4NML+
        TKrpcwgssDtVDqwqmUSL7
X-Received: by 2002:adf:e4c5:: with SMTP id v5mr4746940wrm.320.1600951287613;
        Thu, 24 Sep 2020 05:41:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEXHb/sRDwgsZMDckSultGUskNu3nU9TGPgRovxnxIBYnpHIZ20/F1hEMcaTVWh90tOc5wHQ==
X-Received: by 2002:adf:e4c5:: with SMTP id v5mr4746933wrm.320.1600951287425;
        Thu, 24 Sep 2020 05:41:27 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
        by smtp.gmail.com with ESMTPSA id z11sm3575767wru.88.2020.09.24.05.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 05:41:26 -0700 (PDT)
Date:   Thu, 24 Sep 2020 08:41:21 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Auger Eric <eric.auger@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, jasowang@redhat.com, kevin.tian@intel.com,
        sebastien.boeuf@intel.com, lorenzo.pieralisi@arm.com
Subject: Re: [PATCH v3 0/6] Add virtio-iommu built-in topology
Message-ID: <20200924083918-mutt-send-email-mst@kernel.org>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
 <ab2a1668-e40c-c8f0-b77b-abadeceb4b82@redhat.com>
 <20200924045958-mutt-send-email-mst@kernel.org>
 <20200924092129.GH27174@8bytes.org>
 <20200924053159-mutt-send-email-mst@kernel.org>
 <20200924100255.GM27174@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924100255.GM27174@8bytes.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 24, 2020 at 12:02:55PM +0200, Joerg Roedel wrote:
> On Thu, Sep 24, 2020 at 05:38:13AM -0400, Michael S. Tsirkin wrote:
> > On Thu, Sep 24, 2020 at 11:21:29AM +0200, Joerg Roedel wrote:
> > > On Thu, Sep 24, 2020 at 05:00:35AM -0400, Michael S. Tsirkin wrote:
> > > > OK so this looks good. Can you pls repost with the minor tweak
> > > > suggested and all acks included, and I will queue this?
> > > 
> > > My NACK still stands, as long as a few questions are open:
> > > 
> > > 	1) The format used here will be the same as in the ACPI table? I
> > > 	   think the answer to this questions must be Yes, so this leads
> > > 	   to the real question:
> > 
> > I am not sure it's a must.
> 
> It is, having only one parser for the ACPI and MMIO descriptions was one
> of the selling points for MMIO in past discussions and I think it makes
> sense to keep them in sync.
> 
> > We can always tweak the parser if there are slight differences
> > between ACPI and virtio formats.
> 
> There is no guarantee that there only need to be "tweaks" until the
> ACPI table format is stablized.
> 
> Regards,
> 
> 	Joerg

But this has nothing to do with Linux.  There is also no guarantee that
the two committees will decide to use exactly the same format. Once one
of them sets the format in stone, we can add support for that format to
linux. If another one is playing nice and uses the same format, we can
use the same parsers. If it doesn't linux will have to follow suit.

-- 
MST

