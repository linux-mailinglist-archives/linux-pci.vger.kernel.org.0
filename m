Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5587552D750
	for <lists+linux-pci@lfdr.de>; Thu, 19 May 2022 17:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240775AbiESPV2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 May 2022 11:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240774AbiESPV1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 May 2022 11:21:27 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E3B5D651
        for <linux-pci@vger.kernel.org>; Thu, 19 May 2022 08:21:24 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id p8so5429174pfh.8
        for <linux-pci@vger.kernel.org>; Thu, 19 May 2022 08:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=f7JvL7cRkHT6WvutknshyJqSAWWIC/d0uwyuRrudqYU=;
        b=Z1mk4v9YuvgOIrCHJjmolzc/lLfDnPywp1hhLdGlK7MTB+PC43JVUfbB9FmvcEmCsk
         6YfN0lcZgphn3bTvXNwVr8f9f3GGOKUr1mRlMqE5yoFgDC7IncPAlL0BUuiyt8p+3Tzj
         7LxXMnJFxb956R76saXYRUQWnOQ5JSf26+A0noChJTc6aHDv+cLX2EEXwDLDKAppZ4Wv
         2ci9waakk7Fx5tt/+D0nSmLhSbxy5kvQ096vvn5lNwIWxRwfOxXRJrvOVmXav6YeeDqr
         er05XKIns1tDNWh2Epgxk3OylV5mqAjGlUbX7exoqGnju0SFZ0WKCdCy+bt5bEFp0BAJ
         aFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=f7JvL7cRkHT6WvutknshyJqSAWWIC/d0uwyuRrudqYU=;
        b=F/GaRXb5Kfj9HtyCpO1jnSz7158OvmBENtF7l/ZGzXQf20Yvljnxd0HOlAn3bJ6ds5
         CnJ5Y3kZLyWVG4a6DXFPMX8DkGaSGngZYZSOUCkxhnz0WY7IwH7pOh9YMi16+mAzLqx6
         iJuVEZxBzXrFQo3y3eM/+60+X3J8LzzW7R91XhsShrv/YOtyqWg2fLk0LX+sBlmP6FqF
         IkPW43NukQ1JeA4SMn4GYhsxehdq7E/SvpjUhhetv9gXCxHImEg1LBmNze/5ndvd1imY
         iwBUoajnqyugXUV9NKcIGN1ad0xQlW76J0KUdJEljKCN0ynslG6quFeykR8nj1lUAWDs
         d0WA==
X-Gm-Message-State: AOAM532SLgtBMSNoFKN7hujE1bOvnyKoVlGgXFswKxSnisdB/XjR9to5
        Xbj0z6UCAoP++j9rhWu84Q2C
X-Google-Smtp-Source: ABdhPJyzNILDqts1I1/yQsoDMSaGDmbHzF/pvIgIKP2WfCmx2laD+skx/l/ZFL4KHzRXTQq4cuPrZw==
X-Received: by 2002:a65:5688:0:b0:3c2:1015:988e with SMTP id v8-20020a655688000000b003c21015988emr4428491pgs.280.1652973684315;
        Thu, 19 May 2022 08:21:24 -0700 (PDT)
Received: from thinkpad ([117.202.185.140])
        by smtp.gmail.com with ESMTPSA id o15-20020a17090ad24f00b001dc1950ead5sm5685089pjw.38.2022.05.19.08.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 08:21:23 -0700 (PDT)
Date:   Thu, 19 May 2022 20:51:16 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 15/17] PCI: dwc: Introduce dma-ranges property support
 for RC-host
Message-ID: <20220519152116.GA210475@thinkpad>
References: <20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru>
 <20220503214638.1895-16-Sergey.Semin@baikalelectronics.ru>
 <20220512135708.GC35848@thinkpad>
 <20220512194135.ku73pae2xdvyocx7@mobilestation>
 <20220517172042.GC4528@thinkpad>
 <20220518192623.fl3ogcxlurcd6okd@mobilestation>
 <20220519074053.GA24064@workstation>
 <20220519105238.7bgdigyxvg2cdct6@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220519105238.7bgdigyxvg2cdct6@mobilestation>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 19, 2022 at 01:52:38PM +0300, Serge Semin wrote:

[...]

> > > > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > > > > > index 747e252c09e6..33718ed6c511 100644
> > > > > > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > > > > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > > > > > @@ -397,8 +397,61 @@ static inline void dw_pcie_writel_atu_ib(struct dw_pcie *pci, u32 index, u32 reg
> > > > > > >  	dw_pcie_writel_atu(pci, PCIE_ATU_REGION_DIR_IB, index, reg, val);
> > > > > > >  }
> > > > > > >  
> > > > > > > -int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> > > > > > > -			     int type, u64 cpu_addr, u8 bar)
> > > > > > > +int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
> > > > > > > +			     u64 cpu_addr, u64 pci_addr, u64 size)
> > > > > > > +{
> > > > > > > +	u64 limit_addr = pci_addr + size - 1;
> > > > > > > +	u32 retries, val;
> > > > > > > +
> > > > > > > +	if ((limit_addr & ~pci->region_limit) != (pci_addr & ~pci->region_limit) ||
> > > > > > > +	    !IS_ALIGNED(cpu_addr, pci->region_align) ||
> > > > > > > +	    !IS_ALIGNED(pci_addr, pci->region_align) ||
> > > > > > > +	    !IS_ALIGNED(size, pci->region_align) ||
> > > > > > 
> > > > > 
> > > > > > Why do you want the size to be aligned? What if I want to transfer a small size
> > > > > > buffer?
> > > > > > 
> > > > > > Same question applies to outbound programming as well.
> > > > > 
> > > > > You can't program a region with the unaligned size by the DW PCIe CSRs
> > > > > design. The limit address lower bits are read-only and fixed with
> > > > > one's in accordance with the IP-core synthesize parameter
> > > > > CX_ATU_MIN_REGION_SIZE. So the mapping is always performed in the
> > > > > CX_ATU_MIN_REGION_SIZE chunks.
> > > > > 
> > > > > IATU_LIMIT_ADDR_OFF_{IN,OUT}BOUND.LIMIT_ADDR_HW = 
> > > > > {(CX_ATU_MIN_REGION_SIZE == 65536) ? "0xffff" :
> > > > >  (CX_ATU_MIN_REGION_SIZE == 32768) ? "0x7fff" :
> > > > >  (CX_ATU_MIN_REGION_SIZE == 16384) ? "0x3fff" :
> > > > >  (CX_ATU_MIN_REGION_SIZE == 8192)  ? "0x1fff" :
> > > > >  (CX_ATU_MIN_REGION_SIZE == 4096)  ? "0xfff" : "0xffff"}
> > > > > 
> > > > 
> > > 
> > > > Right. Even though the minimum size that could be mapped is 4k, I could still
> > > > use that 4k size for mapping small buffers also. So you should not be erroring
> > > > out here if the size is not aligned. 
> > > 
> > > Why would you need to do that? Even if you do and the operation
> > > doesn't return an error (or at least splash the syslog with a
> > > warning), the hardware would expand the mapping up to the aligned size
> > > anyway. Such implicit behavior would have given your software an
> > > impression that the mapping was performed in the way you asked with
> > > the size you specified so the upper part of the unaligned range is
> > > free to be used for something else. If the range is accessed, instead
> > > of a bus error or silent IO termination it may cause unexpected result
> > > of creating random PCIe bus traffic. So I'd rather have the
> > > code/platform setup fixed right from the start instead of waiting for
> > > the hard to find bug cause.
> > > 
> > 
> 
> > The application I'm working on is MHI bus. As per the design, it needs to copy
> > 16byte data to ring buffers in the host memory. If I use iATU, then I
> > cannot copy those small data with the size alignment.
> 
> First of all I don't see any driver using the DW PCIe iATU mapping
> functions directly. They are only utilized in the framework of the
> "ranges" and "dma-ranges" DT properties.

Not true. The PCI_EPF_TEST and PCI_EPF_NTB applications use iATU mpping function
through EPC ops.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/endpoint/functions/pci-epf-test.c#n250
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/endpoint/pci-epc-core.c#n476

Now that I've referred, we need to check if these drivers still work on top of
your patches. These are not supported on my platform, so perhaps Frank can
test?

> If the application you are
> referring to your private code, then it can't be a justification.

I should have mentioned it, but my application is not private. It is partly
available in linux-next:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/bus/mhi/ep/ring.c#n47
https://git.linaro.org/landing-teams/working/qualcomm/kernel.git/tree/drivers/pci/endpoint/functions/pci-epf-mhi.c?h=tracking-qcomlt-sdx55-drivers#n121

> Secondly if your application uses them then what about just extending
> the mapping range size while still access the lowest 15 bytes only? In
> that case you would create a more comprehensive software which would
> be aware of the hardware constraints.
> 

Hmm... I'm already doing a similar hack for getting the aligned address due to
iATU limitation, but I think doing the same for size should also work.

Thinking again, I agree with the alignment check. Thanks for the explanations.
But let's make sure the existing EPF drivers still work.

Thanks,
Mani

> > 
> > > > I know that it is a waste of memory but that doesn't mean that it won't work.
> > > 
> > > The correct statement in this case would be "it won't work in a way
> > > you expected, but with the implicit side effect applied to the memory
> > > above the requested one."
> > > 
> > 
> 
> > Agree but that would only happen when the application does out of bound
> > access and in that case the issue is with the application.
> 
> Not only in that case, but anyway how would such application be aware
> of the out of bounds access? Returning an error in case if the
> requested mapping can't be performed with the specified parameters is
> a possible solution. So the application would be aware of the hardware
> constraints and be sure it perceives them right. Otherwise the
> consequences of the out of bounds access would be very unexpected
> since the mapping is performed only for the small buffer.
> 
> -Sergey
> 
> > 
> > Thanks,
> > Mani
> > 
> > > -Sergey
> > > 
> > > > 
> > > > Thanks,
> > > > Mani
> > > > 
> > > > > -Sergey
> > > > > 
> > > > > > 
> > > > > > Thanks,
> > > > > > Mani
> > > > > > 
> > > > > > -- 
> > > > > > மணிவண்ணன் சதாசிவம்
> > > > 
> > > > -- 
> > > > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
