Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2BB213BA8F
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2020 08:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbgAOH5y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jan 2020 02:57:54 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54786 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbgAOH5y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jan 2020 02:57:54 -0500
Received: by mail-wm1-f68.google.com with SMTP id b19so16689236wmj.4
        for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2020 23:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6Ia3VncVrF7c3ZybtE0PPF5JK9Ck+5/tRhdE7y0iz1s=;
        b=i8ACrPmCSBs+LYW5GnsySs7+9Wv84u6t9RSSW45kj5ZeFcp32dD8ehSZC7Xt1/5Bqg
         h1DjGveoSyal45wtXHcZT12ieGr2xy/e8wo3G3CDUp4cnmrVk2dBMBHelGHp79Fony6U
         PzxYeHpAPCO7OJlHOgT9kJnoaQxA/TYufvx/R4aFz+DWsO6XAAmRO/6BrT+Ih8WgpQdu
         c6ekNSgZ6GiY2J08rJXJvTGQ1oEZ9kxZNs4IRe/nMDFb9UnQ9GcYUYMB+eaE+qqao7xg
         33CsbG7zAeSpBNRqs3YmXjFWPmjtHKVWEZJY7FefO2sA/OEizZXaufWIgyH59yrGNt8Q
         Yk/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6Ia3VncVrF7c3ZybtE0PPF5JK9Ck+5/tRhdE7y0iz1s=;
        b=Pz2FbOxqPGKr3FhgnWcsTqV4coz/chPANsKs/ONmaDXbGsUlUlbLN4KYD5SS6cAkB7
         pVbqCaLvhmTQwYik1jldQZv8j7MLc/e18FKkaXefswI3FIrvjIofxMe8CHKhB94WaWl3
         DzKjaqPC/4PA+W1rxIQzcQSLSRRIRr0coOQwpNWq6aR7N30Gw2lp2QPYQUh6jx7aYHZk
         ibXA1dpcAnzixtk6b+cmcRBardZ5dk/ZHUp9bFsU1shQiXisdjrXbTWCbSI3WwxZbQtB
         oxeltkNfvGPSHcMJqntc23P3hZQH1GLDr1SAZNt4NDuBmm634/5qmk70HKtuhOY8/gND
         syLA==
X-Gm-Message-State: APjAAAVlLpicAYcWY1OK0zzrcxvBsBIC1Lipwg+i1cquFaoF3XNmSdJr
        vsN/ZaHt+Z95jQdGQ/2UCF4pmUXay/8=
X-Google-Smtp-Source: APXvYqyNEYvahUX2hjnKrrpMAXYUfqqL20FGP88ce7WRH3XP7tUR3FPmbPiIfTuZpy5b/JjF1w/zZg==
X-Received: by 2002:a7b:cd07:: with SMTP id f7mr30916595wmj.37.1579075071790;
        Tue, 14 Jan 2020 23:57:51 -0800 (PST)
Received: from myrica ([2001:171b:2266:ba60:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id h2sm23782648wrv.66.2020.01.14.23.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 23:57:51 -0800 (PST)
Date:   Wed, 15 Jan 2020 08:57:46 +0100
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
Subject: Re: [PATCH v4 13/13] iommu/arm-smmu-v3: Add support for PCI PASID
Message-ID: <20200115075746.GA32782@myrica>
References: <20191219163033.2608177-1-jean-philippe@linaro.org>
 <20191219163033.2608177-14-jean-philippe@linaro.org>
 <20200114124541.GE29222@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114124541.GE29222@willie-the-truck>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 14, 2020 at 12:45:42PM +0000, Will Deacon wrote:
> On Thu, Dec 19, 2019 at 05:30:33PM +0100, Jean-Philippe Brucker wrote:
> > Enable PASID for PCI devices that support it. Since the SSID tables are
> > allocated by arm_smmu_attach_dev(), PASID has to be enabled early enough.
> > arm_smmu_dev_feature_enable() would be too late, since by that time the
> 
> What is arm_smmu_dev_feature_enable()?

It's the implementation of the IOMMU op .dev_enable_feat(), which I'll add
later (called by a device driver to enable the SVA feature). I'll reword
this comment, since the only real requirement is enabling PASID before
ATS.

> >  static void arm_smmu_detach_dev(struct arm_smmu_master *master)
> >  {
> >  	unsigned long flags;
> > @@ -2852,13 +2899,16 @@ static int arm_smmu_add_device(struct device *dev)
> >  
> >  	master->ssid_bits = min(smmu->ssid_bits, fwspec->num_pasid_bits);
> >  
> > +	/* Note that PASID must be enabled before, and disabled after ATS */
> > +	arm_smmu_enable_pasid(master);
> 
> Is that part of the PCIe specs? If so, please can you add a citation to the
> comment?

Yes (PCIe 4.0r1.0 10.5.1.3 ATS Control register).

> Are there any other ordering requirements, i.e. with respect to enabling
> substreams at the SMMU? For example, can a speculative ATS request provide
> a PASID?

You recent fix bfff88ec1afe ("iommu/arm-smmu-v3: Rework enabling/disabling
of ATS for PCI masters") should prevent from speculative ATS requests.
More generally both ATS and SSID are enabled and disabled at the same time
in the SMMU, when toggling STE.V, so any request arriving before STE
enablement will be aborted regardless of SSID.

Thanks,
Jean

