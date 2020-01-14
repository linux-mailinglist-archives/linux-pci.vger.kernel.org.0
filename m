Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA9F713AF68
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2020 17:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgANQbI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jan 2020 11:31:08 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43363 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbgANQbH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jan 2020 11:31:07 -0500
Received: by mail-wr1-f67.google.com with SMTP id d16so12809643wre.10
        for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2020 08:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nIBJ+W2XCD+RKINYx9xkIa8YvUMMciM9OXCElPBSqto=;
        b=M0rGSjX9nhYA7xN6pq7nhN6GCQ/pfDUlb4rdJCSHj6D+yjeHRwNaicItFWdsW8JbyT
         0r2ZOLTPD4PiLhKBQP+gQi3RfUVO8CPvNNeGmJYcQZsBNoaUF+rmB9LeAdDXtYoTAs3z
         /M1wPatIKp5y/+wVTpYms7hkx+ApHpcYj3Ty2BCTxMnBE26KXcbIZuRLQWJKDUism3aC
         xcmD0s0/v47kD/d6AfPrCR3HWlQ6APhaS4fwC4dlUmgTCHyCQHB83AVLmEbcEqm7Cwlb
         WeokJ+UT1R5DNUZMf2Ox/rwDuSmxPny71TIZNSbBI/CKjU78aXO6zyLB4mt0lwBIkwBK
         Kv/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nIBJ+W2XCD+RKINYx9xkIa8YvUMMciM9OXCElPBSqto=;
        b=C/WTuIzBUcsNI3U1lfYonRZOizrty8160C3igeX+yH7pW3XCuAezF1KwrFEWUH7guJ
         ZpOuCeIMOLSiJuMmYHewk70bBJdBuOVlX8oiGJtdFXFcu8o/swv5lJWqcW24E7+SRddA
         KfePaEQyeQS3ghxPIsAlX/fqOP7toRgkKfgAAMvCE07U9PVnmBCv/pvoSqd4BDMzJXHz
         HUVilwN9OYahMk0YTcKu8livAc0inrvgwT8EzwSccHc1uuZjuUSzXR3kXO1kwksejHWS
         0LxyToHNsGGTQsp/TJKPT1mFcQGIbGYOeg60Jmo4v0whCYqGqMdvP0JA8a+Wr69PKbVa
         xLPA==
X-Gm-Message-State: APjAAAXOWXuoAoE5UKYlkvpT63gFgYu3p5yroKA8fdfuCjBeZU04CLpF
        YuMf5V+aC4NvIhIaBH/rxg5sBg==
X-Google-Smtp-Source: APXvYqw0/eegQ0zcb+toj+yn2h4NywBCJ2IMJC+LicnhxZZ6kzhHXcoqIC9Hr1rNQ6HwLknQccYolQ==
X-Received: by 2002:adf:dd46:: with SMTP id u6mr26754664wrm.13.1579019466232;
        Tue, 14 Jan 2020 08:31:06 -0800 (PST)
Received: from myrica ([2001:171b:2266:ba60:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id a16sm20643732wrt.37.2020.01.14.08.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 08:31:05 -0800 (PST)
Date:   Tue, 14 Jan 2020 17:31:01 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, joro@8bytes.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        robin.murphy@arm.com, bhelgaas@google.com, eric.auger@redhat.com,
        jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
Subject: Re: [PATCH v4 09/13] iommu/arm-smmu-v3: Prepare for handling
 arm_smmu_write_ctx_desc() failure
Message-ID: <20200114163101.GB5319@myrica>
References: <20191219163033.2608177-1-jean-philippe@linaro.org>
 <20191219163033.2608177-10-jean-philippe@linaro.org>
 <20200114124247.GD29222@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114124247.GD29222@willie-the-truck>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 14, 2020 at 12:42:47PM +0000, Will Deacon wrote:
> On Thu, Dec 19, 2019 at 05:30:29PM +0100, Jean-Philippe Brucker wrote:
> > Second-level context descriptor tables will be allocated lazily in
> > arm_smmu_write_ctx_desc(). Help with handling allocation failure by
> > moving the CD write into arm_smmu_domain_finalise_s1().
> > 
> > Reviewed-by: Eric Auger <eric.auger@redhat.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> >  drivers/iommu/arm-smmu-v3.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> > index e147087198ef..b825a5639afc 100644
> > --- a/drivers/iommu/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm-smmu-v3.c
> > @@ -2301,8 +2301,15 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
> >  	cfg->cd.ttbr	= pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
> >  	cfg->cd.tcr	= pgtbl_cfg->arm_lpae_s1_cfg.tcr;
> >  	cfg->cd.mair	= pgtbl_cfg->arm_lpae_s1_cfg.mair;
> > +
> > +	ret = arm_smmu_write_ctx_desc(smmu_domain, 0, &cfg->cd);
> 
> Hmm. This ends up calling arm_smmu_sync_cd() but I think that happens before
> we've added the master to the devices list of the domain. Does that mean we
> miss the new SSID during the invalidation?

Yes, the arm_smmu_sync_cd() isn't useful in this case, it's only needed
when the STE is live and arm_smmu_write_ctx_desc() is called for a
ssid!=0. On this path, the CD cache is invalidated by a CFGI_STE executed
later, when arm_smmu_attach_dev() installs the STE. I didn't want to add a
special case that avoids the sync when ssid==0 in because a spurious sync
probably doesn't impact performance here and arm_smmu_write_ctx_desc() is
quite fiddly already.

Thanks,
Jean
