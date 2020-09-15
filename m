Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9EFE26AE37
	for <lists+linux-pci@lfdr.de>; Tue, 15 Sep 2020 21:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbgIOT4E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Sep 2020 15:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727729AbgIOTzd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Sep 2020 15:55:33 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B33C061797
        for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2020 12:55:05 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d19so1901896pld.0
        for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2020 12:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ANJOfSdlpRaHSBBO4TQnqknbM6J+0XuYtQl6sOjOU6g=;
        b=vbKyE1eGXl1ab37xPuCgN3XERmZgx8c72CmccznAaQT/qdPIFWgEvL2g7tdxHUje1+
         uH3g5E43P/o9/UJXb7GQiTNIYyMi0BTbo9lWzld48up8d8Dpu5ogNRBAKeUa8TQgWld4
         mXnM7bosw+BwFaU3OdjM3MkSleUZ0pAHWgLipyCpVaQWGWHMKkgE5EtkjCyhdPbfacRb
         BF4zvVAEvnt46T2LrUiCt+Ej1O5VNJn4gCUeqdOMVp0NP959/LyLVZ2HbrBpysEqZZ7U
         /glUHqltfoq9EtlZslQ0cG+F+Ocwp8nEhATulLHJinhygWWgTymGqXK7y09zkav+1GU6
         8HAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ANJOfSdlpRaHSBBO4TQnqknbM6J+0XuYtQl6sOjOU6g=;
        b=dToT1fIfDPGaaEuqdkKrtBF+zrr+8oD5/Eu3qffUBfr+agwn8oyHK+4ZcuUsAZqQ2o
         sLxeRFFe+WyeNT06UX+/Pz4xhFa5LYJT5RtirfPPX/lTbkagA+K2575l0ztFVQVeLwxZ
         QqmFIGENA/rlavR+liozbFOD1iVAg18fYImP2andQ4o7tZqM3uHs8Qe7iXt5AzHj1tSi
         Hr1SCkla+OJU+qvuBoaxfbri5DotCzEUTwhuriPGsWUdR40yitfnXaykWzjsS8076U3O
         utTZPL9vURzlxMoZoWSGqXiuucCefSaUHjOingoA/5yM9ZWbX3dHhgdkIfeEuDG1io54
         nJjg==
X-Gm-Message-State: AOAM532J9gyffkyBI2X/DqhxH/KNEwsZ3fLqGggMQqLunKySr9nEP2qd
        e5j0kcZ+OXEkOy89uz5zABVH1Q==
X-Google-Smtp-Source: ABdhPJypvLei95eAIfBf9YhOFqqQKZ1C34DJmEf5yt+0uB+ckb9ORNsADCaKLRMdqq9zVPIXlUuLOA==
X-Received: by 2002:a17:902:9685:b029:d1:e5e7:be1b with SMTP id n5-20020a1709029685b02900d1e5e7be1bmr3266435plp.78.1600199704611;
        Tue, 15 Sep 2020 12:55:04 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id z4sm14594221pfr.197.2020.09.15.12.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 12:55:04 -0700 (PDT)
Date:   Tue, 15 Sep 2020 13:55:01 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Russell King <linux@armlinux.org.uk>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        arnaud.pouliquen@st.com, loic.pallardy.st.com@xps15
Subject: Re: [PATCH 6/6] dma-mapping: introduce DMA range map, supplanting
 dma_pfn_offset
Message-ID: <20200915195501.GA3666944@xps15>
References: <20200914073343.1579578-1-hch@lst.de>
 <20200914073343.1579578-7-hch@lst.de>
 <20200914230147.GA3251212@xps15>
 <20200915054122.GA18079@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915054122.GA18079@lst.de>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 15, 2020 at 07:41:22AM +0200, Christoph Hellwig wrote:
> On Mon, Sep 14, 2020 at 05:01:47PM -0600, Mathieu Poirier wrote:
> 
> [700 lines of the fullquote deleted..]
> 
> > > +	for (r = map; r->size; r++)
> > > +		num_ranges++;
> > > +
> > > +	new_map = kmemdup(map, array_size(num_ranges + 1, sizeof(*map)),
> > > +			  GFP_KERNEL);
> > > +	if (!new_map)
> > > +		return -ENOMEM;
> > > +	to->dma_range_map = new_map;
> > > +	return 0;
> > > +}
> > > +
> > 
> > This patch seemed Ok to me but it broke the stm32 remoteproc implementation.  When
> > I tested things out function dma_coerce_mask_and_cohenrent() returns -5 and the
> > rest of the initialisation fails.  I isolated things to function dma_to_pfn()
> > [2].  In the original implementation __bus_to_pfn() returns 0xfffff and
> > dev->dma_pfn_offset is equal to 0x38000.  As such the function returns 0x137fff
> > and dma_supported() a non-zero value[3].
> > 
> > With this set function dma_to_pfn() received a face lift.  Function
> > __bus_to_pfn() still returns 0xfffff but translate_dma_to_phys() returns 0,
> > which forces dma_supported() to also return 0 and that is where the -5 (-EIO)
> > comes from.
> > 
> > Taking a futher look at translate_dma_to_phy(), @dma_addr never falls within the
> > bus_dma_region ranges and returns 0.
> > 
> > I'm suspecting an initialisation problem and if it occurred here, it will
> > likely show up elsewhere.
> 
> Can you try this incremental patch?
> 
> diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
> index 088c97181ab146..c6b21acba7a459 100644
> --- a/include/linux/dma-direct.h
> +++ b/include/linux/dma-direct.h
> @@ -46,7 +46,7 @@ static inline phys_addr_t translate_dma_to_phys(struct device *dev,
>  		if (dma_addr >= m->dma_start && dma_addr - m->dma_start < m->size)
>  			return (phys_addr_t)dma_addr + m->offset;
>  
> -	return 0;
> +	return (phys_addr_t)-1;

That did the trick - the stm32 platform driver's probe() function completes and
the remote processor is operatinal. 

That being said the value returned by function dma_to_pfn()
is 0x137fff in the original code and 0xfffff with your patches applied.

Thanks,
Mathieu

>  }
>  
>  #ifdef CONFIG_ARCH_HAS_PHYS_TO_DMA
