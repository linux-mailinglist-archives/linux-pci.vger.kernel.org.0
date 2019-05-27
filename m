Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EED42B832
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2019 17:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfE0PPh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 May 2019 11:15:37 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:35467 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbfE0PPh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 May 2019 11:15:37 -0400
Received: by mail-vk1-f194.google.com with SMTP id k1so3919363vkb.2
        for <linux-pci@vger.kernel.org>; Mon, 27 May 2019 08:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S3tITZHYfrewmW5oJlisGGiL7wfHqP1R9OVY9cCC4GU=;
        b=nyXOSFh5BlUwb8lpNqnKaSBQgRfONMXwhRP9Y/9K8ZvRRl1RzvCdtSJAGb3tlav0Q1
         CWAX9g173/ldcgTpTq94BAsMHub39vAdpdY4uetoBC7vKMpReByFKsPpnFZDlKfApuwb
         9iJlOJ3PPSVIJgMinE0gSWua3uObivV4/z9uodGAmZvNc0i7qgzt6zVMHJhLkF1b6jz9
         Xr1YHM172OuPANKj5bnX/22+6gyO8053o9FVGRuxdNe5EWaSap0C85MKFTjo00SRcvVG
         G0Vf8rxL93ypJFFJ/JGJVW78HIwM8Gs0CqEOdCGG8WwQ1qYTez+tjx69bS8D2h4wUZiU
         bqlg==
X-Gm-Message-State: APjAAAUhRYqRx6JCrwwTZO8N2WJjJhH4ogQzYAb2wM1+jd4LG4HzBcaX
        xV3tn4o+JRLix0ZD+UVuOtFKng==
X-Google-Smtp-Source: APXvYqxJCHIEBYM/VufOiGYY7G560g6K/dg4+SJBDDD3dVA0O70dd9ZnwStYxTkM8qVIYrC3jk8P+g==
X-Received: by 2002:a1f:7cc7:: with SMTP id x190mr19173038vkc.92.1558970136480;
        Mon, 27 May 2019 08:15:36 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net. [100.0.197.103])
        by smtp.gmail.com with ESMTPSA id w131sm6373477vsw.7.2019.05.27.08.15.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 27 May 2019 08:15:35 -0700 (PDT)
Date:   Mon, 27 May 2019 11:15:32 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, jasowang@redhat.com,
        robh+dt@kernel.org, mark.rutland@arm.com, bhelgaas@google.com,
        frowand.list@gmail.com, kvmarm@lists.cs.columbia.edu,
        eric.auger@redhat.com, tnowicki@caviumnetworks.com,
        kevin.tian@intel.com, marc.zyngier@arm.com, robin.murphy@arm.com,
        will.deacon@arm.com, lorenzo.pieralisi@arm.com,
        bharat.bhushan@nxp.com
Subject: Re: [PATCH v7 0/7] Add virtio-iommu driver
Message-ID: <20190527111345-mutt-send-email-mst@kernel.org>
References: <20190115121959.23763-1-jean-philippe.brucker@arm.com>
 <20190512123022-mutt-send-email-mst@kernel.org>
 <20190527092604.GB21613@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527092604.GB21613@8bytes.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 27, 2019 at 11:26:04AM +0200, Joerg Roedel wrote:
> On Sun, May 12, 2019 at 12:31:59PM -0400, Michael S. Tsirkin wrote:
> > OK this has been in next for a while.
> > 
> > Last time IOMMU maintainers objected. Are objections
> > still in force?
> > 
> > If not could we get acks please?
> 
> No objections against the code, I only hesitated because the Spec was
> not yet official.
> 
> So for the code:
> 
> 	Acked-by: Joerg Roedel <jroedel@suse.de>

Last spec patch had a bunch of comments not yet addressed.
But I do not remember whether comments are just about wording
or about the host/guest interface as well.
Jean-Philippe could you remind me please?

-- 
MST
