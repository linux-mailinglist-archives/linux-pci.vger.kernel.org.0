Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 603BE276EA6
	for <lists+linux-pci@lfdr.de>; Thu, 24 Sep 2020 12:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbgIXKY6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Sep 2020 06:24:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52379 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727089AbgIXKY6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Sep 2020 06:24:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600943097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wqpAFzoVVNPHoD2su633/m5i0f1o9UijACFpsiH+PwE=;
        b=UvDgsCYwz+IFeJWgcudpraOAhamV4DvHIpJJROcIZ4r3rb99VnHCtMFsbHNFInnoGUGeb8
        GDTdXTKWYqHw01cZlj9W6wnOV+BA+Nb1tGzqR1wirNSps9LAEklXA5U3G8aQvLjFNE4xIn
        neUCGdwd/8f/sg1+DctDmaR8oPmp7gA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-NGd59hkGNlmhZzSRNxTU6Q-1; Thu, 24 Sep 2020 06:24:55 -0400
X-MC-Unique: NGd59hkGNlmhZzSRNxTU6Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C7B21891E87;
        Thu, 24 Sep 2020 10:24:53 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-85.ams2.redhat.com [10.36.112.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C33715C1C7;
        Thu, 24 Sep 2020 10:24:46 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 0753A16E0A; Thu, 24 Sep 2020 12:24:46 +0200 (CEST)
Date:   Thu, 24 Sep 2020 12:24:46 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        virtio-dev@lists.oasis-open.org, lorenzo.pieralisi@arm.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Auger Eric <eric.auger@redhat.com>,
        iommu@lists.linux-foundation.org, sebastien.boeuf@intel.com,
        bhelgaas@google.com
Subject: Re: [PATCH v3 0/6] Add virtio-iommu built-in topology
Message-ID: <20200924102446.icsdv2yhof4nbnec@sirius.home.kraxel.org>
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
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

So that requirement basically kills the "we have something to play with
while the acpi table spec is in progress" argument.  Also note that qemu
microvm got acpi support meanwhile.

Are there other cases where neither ACPI nor DT are available?

take care,
  Gerd

