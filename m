Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEDF8276D9D
	for <lists+linux-pci@lfdr.de>; Thu, 24 Sep 2020 11:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgIXJiW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Sep 2020 05:38:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48554 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726380AbgIXJiW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Sep 2020 05:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600940300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GQMLt7r4p28L0sSJJPMjF6juRbduNigBdA5Pg+z0Rro=;
        b=TwA14iCqybqth1d1SG2Ws9xyZp3lFSA6JZRWUTIbtEfolXMa+SwWh3GDWwBUXBbIkVdlv/
        GDmzKpq+OBrRRBjYxeertDy28tXqQ34ba711kV2sbk6pkyJ5pMqVF9ubleDUV8f5uRsrjk
        Q6aUL12SOGRyhypUxbQyM8W7gqO10QU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199--Y3gkqG9P66DfIW5SK8r8g-1; Thu, 24 Sep 2020 05:38:19 -0400
X-MC-Unique: -Y3gkqG9P66DfIW5SK8r8g-1
Received: by mail-wm1-f71.google.com with SMTP id m25so1028225wmi.0
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2020 02:38:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GQMLt7r4p28L0sSJJPMjF6juRbduNigBdA5Pg+z0Rro=;
        b=uhG8RY6+Qg8O/dF2sbcFBkw4XBHOhZyOlT1Tej1DxLqcin/G0YVNFblAlIcp2KtqsY
         2ypznm1XJo7oEftTVqp1dwVIUeycpZa5t6EwiONqT5gIeQ9TT7y287kk9tR10SgldceE
         CapfLuxzKLZliDDUc4JOHK5ELznJ7SLxNtISSu4es+xd1rdDFvAvVmcH9573RMfkJU9B
         eAbDF2SS1EQvXxzvUQ8IFG3SJENlgcPTn7ImDOolvzQalCB5QP6O6vaR7W3DXsh6bE0B
         b1QwSiifSWy9+wItTtnoIltgSQuK/kzIrcySLpQhe00N4yPs9a0qwK45umGdJ0U/R/ao
         /G0g==
X-Gm-Message-State: AOAM532TV8KvKtaDpVVgVBC4AHJhuRAeL63h+akzwHA7NhBocY8Nul43
        ZfgbgPc4EIbfPTtkzW4p1I/Ky1JmZCB/2m0zyPd+5TXZmnzvTLAeyoc4yX18/NC/MjrPGbwfiXr
        eCDx1eAErLk4WdhCRkPx5
X-Received: by 2002:a5d:568d:: with SMTP id f13mr4007445wrv.303.1600940298005;
        Thu, 24 Sep 2020 02:38:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNfu1dfe6iZYDmyztM8WdEywh/avjWGmq3NjwJSF1cAVd6SUgRkwNdlaUiQJUtrdpjEEYZSA==
X-Received: by 2002:a5d:568d:: with SMTP id f13mr4007413wrv.303.1600940297782;
        Thu, 24 Sep 2020 02:38:17 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
        by smtp.gmail.com with ESMTPSA id c205sm2730814wmd.33.2020.09.24.02.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 02:38:16 -0700 (PDT)
Date:   Thu, 24 Sep 2020 05:38:13 -0400
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
Message-ID: <20200924053159-mutt-send-email-mst@kernel.org>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
 <ab2a1668-e40c-c8f0-b77b-abadeceb4b82@redhat.com>
 <20200924045958-mutt-send-email-mst@kernel.org>
 <20200924092129.GH27174@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924092129.GH27174@8bytes.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 24, 2020 at 11:21:29AM +0200, Joerg Roedel wrote:
> On Thu, Sep 24, 2020 at 05:00:35AM -0400, Michael S. Tsirkin wrote:
> > OK so this looks good. Can you pls repost with the minor tweak
> > suggested and all acks included, and I will queue this?
> 
> My NACK still stands, as long as a few questions are open:
> 
> 	1) The format used here will be the same as in the ACPI table? I
> 	   think the answer to this questions must be Yes, so this leads
> 	   to the real question:

I am not sure it's a must.
We can always tweak the parser if there are slight differences
between ACPI and virtio formats.

But we do want the virtio format used here to be approved by the virtio
TC, so it won't change.

Eric, Jean-Philippe, does one of you intend to create a github issue
and request a ballot for the TC? It's been posted end of August with no
changes ...

> 	2) Has the ACPI table format stabalized already? If and only if
> 	   the answer is Yes I will Ack these patches. We don't need to
> 	   wait until the ACPI table format is published in a
> 	   specification update, but at least some certainty that it
> 	   will not change in incompatible ways anymore is needed.
> 

Not that I know, but I don't see why it's a must.

> So what progress has been made with the ACPI table specification, is it
> just a matter of time to get it approved or are there concerns?
> 
> Regards,
> 
> 	Joerg

