Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E71C35EB50
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2019 20:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfGCSNa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jul 2019 14:13:30 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43354 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfGCSNa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Jul 2019 14:13:30 -0400
Received: by mail-qk1-f196.google.com with SMTP id m14so3533698qka.10
        for <linux-pci@vger.kernel.org>; Wed, 03 Jul 2019 11:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dIkgJeJBuw++uppqsU+TnGBul+EFF40cgrIXzTaEkqk=;
        b=BDcvXVU5S9Xe6RaZL1d/tzhqXI0ERzROC5Hwy70kI1UbibB5XGc2qktpp6KCRj2eJ8
         Cvf/ZQdisnA3SE13u0kPAYYcxD7/vjlMJCRXFqswT6wm7B/ZH66kJW3+LI/VOPZjovQN
         evL2O/4brhczby9X6zVffdg7OkrHAb/PwnzOSEYjUiLxJrWp9rpmHGHLGRdXBfZRWW4W
         JckFR0Y+fY+7lMoaMBwbiK+8lcXoBeP3tQ697oFwWt03yHVMREfyYMjvXlRNVt9JAfjh
         vs4ZSzvO0c/ohYv6r1U/r7F4radpVLs9xgn1pHEoMnI8AYroHgpDAIAg2e2jlz8s1P1X
         DWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dIkgJeJBuw++uppqsU+TnGBul+EFF40cgrIXzTaEkqk=;
        b=o0wzRaUSn6t0sn6llXbsE8nhaWNyzCA4foVignjQ4mNS9ScptN2Bk+Jow3n8/Savub
         NCKmGiEYk+k99BhSSO+5IaHg5UaIOIUzGJTnCPSmrVYPhjD1US6Y6pCmkLMdaBHekPl3
         d7yYqR4RdO1gcw+RtkMZ0B0cxcHTqfhwpFowxeaF5NGPBmlkcTpSaiiUXZ6MGZCV2m4w
         PidJwYon/R7RzkcLF2+QVcCWSjPS7vBWq1mfQxww/pSgR+kwOTS12dVDTKK9Fp851FfR
         ub5WWbyxqvNsGOF4RfsNXjoQ1/GYXH2B8zGXZ0a3awjiX8QsRAMipETnviQAdPK4viVN
         YyOg==
X-Gm-Message-State: APjAAAUR00Q960KKqhhAx1sTzS5yxZVUgCurNrDEqRIcYzUDBK0jZOTw
        uy1z94WXm9rchLPVxBDCqZeKSA==
X-Google-Smtp-Source: APXvYqwJ/Yia/+35gou6qrRAmIkzXiI4t3koOKtXe3iAnV4Brg/bboybUghnJVCplNkmCRgecJA4HA==
X-Received: by 2002:a37:ad0:: with SMTP id 199mr2986016qkk.90.1562177609563;
        Wed, 03 Jul 2019 11:13:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id i17sm1533124qta.6.2019.07.03.11.13.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Jul 2019 11:13:29 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hijl2-0000Hu-Jr; Wed, 03 Jul 2019 15:13:28 -0300
Date:   Wed, 3 Jul 2019 15:13:28 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     AlexDeucher <alexander.deucher@amd.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 20/22] mm: move hmm_vma_fault to nouveau
Message-ID: <20190703181328.GC18673@ziepe.ca>
References: <20190701062020.19239-21-hch@lst.de>
 <20190703180356.GB18673@ziepe.ca>
 <20190703180525.GA13703@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703180525.GA13703@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 03, 2019 at 08:05:25PM +0200, Christoph Hellwig wrote:
> On Wed, Jul 03, 2019 at 03:03:56PM -0300, Jason Gunthorpe wrote:
> > I was thinking about doing exactly this too, but amdgpu started using
> > this already obsolete API in their latest driver :(
> > 
> > So, we now need to get both drivers to move to the modern API.
> 
> Actually the AMD folks fixed this up after we pointed it out to them,
> so even in linux-next it just is nouveau that needs fixing.

Oh, I looked at an older -next, my mistake. Lets do it then.

Jason
