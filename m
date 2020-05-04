Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C23AA1C3C8D
	for <lists+linux-pci@lfdr.de>; Mon,  4 May 2020 16:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbgEDOMO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 May 2020 10:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729000AbgEDOMN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 May 2020 10:12:13 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249C5C061A0E
        for <linux-pci@vger.kernel.org>; Mon,  4 May 2020 07:12:13 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id y24so9262765wma.4
        for <linux-pci@vger.kernel.org>; Mon, 04 May 2020 07:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cBYi8j74hWiNZr+qveo+/wt9+YdcPXbPEFJvXHtn9pk=;
        b=Vq2ie4yP/X47QYD6lxsDV5syeThtLJI2ewNwfJLRuRvqg9UoVTEgtYRgWLvaBdnVPa
         0wxiY2Klubhm0nN4CMoAjyALlAO50NfO102r/fy+H5GCSi63zznRgC0xu4L85wpV03xu
         DfhamtALWXxNYB9JgzXyAATJJmNT8UEf6XEH6k0T1kswbiEY71Yel0l1afn0RX60zeBH
         aqxDJDIPxXQSFKQhe8Dd/PnFMhfN2602ltmhdR00hWRbv/fHUel+9cX1FVpDN6rRaZVF
         s/UX7jAgy7BBd0Tzf4XpwroHU3tmThERIbg1xf8cdc1LjpguouxRX8TELXLyxcryX5LF
         R2oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cBYi8j74hWiNZr+qveo+/wt9+YdcPXbPEFJvXHtn9pk=;
        b=W2VD+BZOnH4UKf852VXttd97maTMKhcuWmjqPWm5GwdIGgEfLs6tcbo3/BjWg5MDK1
         JJ5tC8jhfzPytqkpBtn5bN2M6JGTE6tPFfe3z+7zwPp5ErOEhAVd8yll8ATduKuj8CyR
         dsz+arWEF5M2MF8LL9EyW38zgDzAxn1Y6U5YAAMUalWNdBvmevya9M6ugxzqNnvrU0Ap
         V5xPmK48q6bh8i6X2hw3Sx7NGs2Sajun+oswCckD/TzGh8oaBs7ySkUZ42IkpmoocqIb
         1LOxvwUGH7+Z4ZOp2KWbHQ/x24ZYT856abF4vPT4Lmw3OzUkTDz19e/zQn7vOL+Tyg27
         B8jg==
X-Gm-Message-State: AGi0PuZKho7rW9ddi3QefbqUN/a/kWaLJ+eLeA3qORBeKcoA+elcK4ph
        7hYXRdBlzG7WRge67JDN2soXkg==
X-Google-Smtp-Source: APiQypJGsU7OdMfQlFADSEeYP/iyop6F2RgiIW4sMbSjpQ+r/TAhN3MWxBAEOgHp3eUgHcwFPiU/5w==
X-Received: by 2002:a05:600c:290f:: with SMTP id i15mr14075509wmd.167.1588601531837;
        Mon, 04 May 2020 07:12:11 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id r23sm13017379wra.74.2020.05.04.07.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 07:11:52 -0700 (PDT)
Date:   Mon, 4 May 2020 16:11:37 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, joro@8bytes.org, catalin.marinas@arm.com,
        will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        jacob.jun.pan@linux.intel.com, christian.koenig@amd.com,
        felix.kuehling@amd.com, zhangfei.gao@linaro.org, jgg@ziepe.ca,
        xuzaibo@huawei.com, fenghua.yu@intel.com, hch@infradead.org
Subject: Re: [PATCH v6 11/25] iommu/arm-smmu-v3: Share process page tables
Message-ID: <20200504141137.GA170104@myrica>
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
 <20200430143424.2787566-12-jean-philippe@linaro.org>
 <580a915f-f8bf-3b3e-c77d-6d0c2ea4bd02@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <580a915f-f8bf-3b3e-c77d-6d0c2ea4bd02@arm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 30, 2020 at 04:39:53PM +0100, Suzuki K Poulose wrote:
> On 04/30/2020 03:34 PM, Jean-Philippe Brucker wrote:
> > With Shared Virtual Addressing (SVA), we need to mirror CPU TTBR, TCR,
> > MAIR and ASIDs in SMMU contexts. Each SMMU has a single ASID space split
> > into two sets, shared and private. Shared ASIDs correspond to those
> > obtained from the arch ASID allocator, and private ASIDs are used for
> > "classic" map/unmap DMA.
> > 
> > Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> 
> > +
> > +	tcr = FIELD_PREP(CTXDESC_CD_0_TCR_T0SZ, 64ULL - VA_BITS) |
> > +	      FIELD_PREP(CTXDESC_CD_0_TCR_IRGN0, ARM_LPAE_TCR_RGN_WBWA) |
> > +	      FIELD_PREP(CTXDESC_CD_0_TCR_ORGN0, ARM_LPAE_TCR_RGN_WBWA) |
> > +	      FIELD_PREP(CTXDESC_CD_0_TCR_SH0, ARM_LPAE_TCR_SH_IS) |
> > +	      CTXDESC_CD_0_TCR_EPD1 | CTXDESC_CD_0_AA64;
> > +
> > +	switch (PAGE_SIZE) {
> > +	case SZ_4K:
> > +		tcr |= FIELD_PREP(CTXDESC_CD_0_TCR_TG0, ARM_LPAE_TCR_TG0_4K);
> > +		break;
> > +	case SZ_16K:
> > +		tcr |= FIELD_PREP(CTXDESC_CD_0_TCR_TG0, ARM_LPAE_TCR_TG0_16K);
> > +		break;
> > +	case SZ_64K:
> > +		tcr |= FIELD_PREP(CTXDESC_CD_0_TCR_TG0, ARM_LPAE_TCR_TG0_64K);
> > +		break;
> > +	default:
> > +		WARN_ON(1);
> > +		ret = -EINVAL;
> > +		goto err_free_asid;
> > +	}
> > +
> > +	reg = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
> > +	par = cpuid_feature_extract_unsigned_field(reg, ID_AA64MMFR0_PARANGE_SHIFT);
> > +	tcr |= FIELD_PREP(CTXDESC_CD_0_TCR_IPS, par);
> > +
> > +	cd->ttbr = virt_to_phys(mm->pgd);
> 
> Does the TTBR follow the same layout as TTBR_ELx for 52bit IPA ? i.e,
> TTBR[5:2] = BADDR[51:48] ? Are you covered for that ?

Good point, I don't remember checking this. The SMMU TTBR doesn't have the
same layout as the CPU's, and we don't need to swizzle the bits. For the
lower bits, the alignment requirements on the pgd are identical to the
MMU.

Thanks,
Jean

