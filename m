Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C684652F288
	for <lists+linux-pci@lfdr.de>; Fri, 20 May 2022 20:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347559AbiETSVb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 May 2022 14:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352674AbiETSVQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 May 2022 14:21:16 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22E934640;
        Fri, 20 May 2022 11:21:14 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id l13so9048197lfp.11;
        Fri, 20 May 2022 11:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+Hf/TTjZvIJgguQoReoeCBPpae2wzrfZLm0W7rE7A40=;
        b=YpC7BxbfU0JQGV/+eRko+YdAwCAyJWToP03qAA7tL9zkTPcRUsmK5IrV2+r3wRmXDV
         jwxO7fo47sqh6ANjEBoUBO6QiXT4apk5AG8hcUwN6DE1jra63QC8fHGAUoARohKJUpch
         e1JA/TeGyAgfcexCzt2UyILgMpGPLUXDC7SB+ZPgg7JOKx2SYbtgUMrT5n4289ux7y+2
         rmsgqr5PdfEcveDZFQAmaA/u7anrtwfEcLJ+WVsAIN6o/3kvUR89mwxNE8IA/+FX9qer
         V83n9iU3l8h1T2dSEwdSnqbjyFC3d5g9cfPoRrtdyiUKc5J8hQbFHep70XcMqRpXBb6L
         lshA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+Hf/TTjZvIJgguQoReoeCBPpae2wzrfZLm0W7rE7A40=;
        b=Hek1AJ7yikxdPSKdZRvbsrjHHxv4H5rexDW4fTCVkZutXfOnIlo/N9vGS67ctlqPYG
         LLdO0rnHt6mhU7jkaPp0hxgyiBLqa4h82Qbv0e7FSBvGXNUEMKBPYvgAxQ+mf8H4d1Xb
         VxJrSl0R2jBsoHH80FpCHeS5xf7yx1b+LuPAN+OQROjuuBpw8rfHk8Ef0H7R6AAdNCwO
         Ig8B8cbFD6QugJbmDsB5+/TvlxO+blriqLLDhBAWmksFPugq0YM1cFWR08rb4mcJmCyZ
         AbpdbTZKRPmIqQsV/ds2LKnG1MH4JqVkgweJkIxhMaBH+/N8CQJmL5Gj37pUnsR8uOfI
         xmrQ==
X-Gm-Message-State: AOAM531NQvEdwFLPjwp9b4RML/iBP3Uve1gKftPFDXwjwyKX/y6qprOW
        4swlLE0N8U7M4Jl+ScUMzDM=
X-Google-Smtp-Source: ABdhPJwE5ODuzJITkeLRjFs05/WQ+swUSj5paxBMU3uTDRK+Rqp/y7eo4bkwpMZ/tmzzx2oO+o3lAA==
X-Received: by 2002:ac2:593b:0:b0:477:a3d8:4042 with SMTP id v27-20020ac2593b000000b00477a3d84042mr7783794lfi.640.1653070872772;
        Fri, 20 May 2022 11:21:12 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id j29-20020ac2551d000000b004725b99d2fdsm748207lfk.164.2022.05.20.11.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:21:12 -0700 (PDT)
Date:   Fri, 20 May 2022 21:21:10 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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
Message-ID: <20220520182110.z7boelenloaxzvwo@mobilestation>
References: <20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru>
 <20220503214638.1895-16-Sergey.Semin@baikalelectronics.ru>
 <20220512135708.GC35848@thinkpad>
 <20220512194135.ku73pae2xdvyocx7@mobilestation>
 <20220517172042.GC4528@thinkpad>
 <20220518192623.fl3ogcxlurcd6okd@mobilestation>
 <20220519074053.GA24064@workstation>
 <20220519105238.7bgdigyxvg2cdct6@mobilestation>
 <20220519152116.GA210475@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220519152116.GA210475@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 19, 2022 at 08:51:16PM +0530, Manivannan Sadhasivam wrote:
> On Thu, May 19, 2022 at 01:52:38PM +0300, Serge Semin wrote:
> 
> [...]
> 
> > > > > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > > > > > > index 747e252c09e6..33718ed6c511 100644
> > > > > > > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > > > > > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > > > > > > @@ -397,8 +397,61 @@ static inline void dw_pcie_writel_atu_ib(struct dw_pcie *pci, u32 index, u32 reg
> > > > > > > >  	dw_pcie_writel_atu(pci, PCIE_ATU_REGION_DIR_IB, index, reg, val);
> > > > > > > >  }
> > > > > > > >  
> > > > > > > > -int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> > > > > > > > -			     int type, u64 cpu_addr, u8 bar)
> > > > > > > > +int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
> > > > > > > > +			     u64 cpu_addr, u64 pci_addr, u64 size)
> > > > > > > > +{
> > > > > > > > +	u64 limit_addr = pci_addr + size - 1;
> > > > > > > > +	u32 retries, val;
> > > > > > > > +
> > > > > > > > +	if ((limit_addr & ~pci->region_limit) != (pci_addr & ~pci->region_limit) ||
> > > > > > > > +	    !IS_ALIGNED(cpu_addr, pci->region_align) ||
> > > > > > > > +	    !IS_ALIGNED(pci_addr, pci->region_align) ||
> > > > > > > > +	    !IS_ALIGNED(size, pci->region_align) ||
> > > > > > > 
> > > > > > 
> > > > > > > Why do you want the size to be aligned? What if I want to transfer a small size
> > > > > > > buffer?
> > > > > > > 
> > > > > > > Same question applies to outbound programming as well.
> > > > > > 
> > > > > > You can't program a region with the unaligned size by the DW PCIe CSRs
> > > > > > design. The limit address lower bits are read-only and fixed with
> > > > > > one's in accordance with the IP-core synthesize parameter
> > > > > > CX_ATU_MIN_REGION_SIZE. So the mapping is always performed in the
> > > > > > CX_ATU_MIN_REGION_SIZE chunks.
> > > > > > 
> > > > > > IATU_LIMIT_ADDR_OFF_{IN,OUT}BOUND.LIMIT_ADDR_HW = 
> > > > > > {(CX_ATU_MIN_REGION_SIZE == 65536) ? "0xffff" :
> > > > > >  (CX_ATU_MIN_REGION_SIZE == 32768) ? "0x7fff" :
> > > > > >  (CX_ATU_MIN_REGION_SIZE == 16384) ? "0x3fff" :
> > > > > >  (CX_ATU_MIN_REGION_SIZE == 8192)  ? "0x1fff" :
> > > > > >  (CX_ATU_MIN_REGION_SIZE == 4096)  ? "0xfff" : "0xffff"}
> > > > > > 
> > > > > 
> > > > 
> > > > > Right. Even though the minimum size that could be mapped is 4k, I could still
> > > > > use that 4k size for mapping small buffers also. So you should not be erroring
> > > > > out here if the size is not aligned. 
> > > > 
> > > > Why would you need to do that? Even if you do and the operation
> > > > doesn't return an error (or at least splash the syslog with a
> > > > warning), the hardware would expand the mapping up to the aligned size
> > > > anyway. Such implicit behavior would have given your software an
> > > > impression that the mapping was performed in the way you asked with
> > > > the size you specified so the upper part of the unaligned range is
> > > > free to be used for something else. If the range is accessed, instead
> > > > of a bus error or silent IO termination it may cause unexpected result
> > > > of creating random PCIe bus traffic. So I'd rather have the
> > > > code/platform setup fixed right from the start instead of waiting for
> > > > the hard to find bug cause.
> > > > 
> > > 
> > 
> > > The application I'm working on is MHI bus. As per the design, it needs to copy
> > > 16byte data to ring buffers in the host memory. If I use iATU, then I
> > > cannot copy those small data with the size alignment.
> > 
> > First of all I don't see any driver using the DW PCIe iATU mapping
> > functions directly. They are only utilized in the framework of the
> > "ranges" and "dma-ranges" DT properties.
> 

> Not true. The PCI_EPF_TEST and PCI_EPF_NTB applications use iATU mpping function
> through EPC ops.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/endpoint/functions/pci-epf-test.c#n250
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/endpoint/pci-epc-core.c#n476
> 
> Now that I've referred, we need to check if these drivers still work on top of
> your patches. These are not supported on my platform, so perhaps Frank can
> test?

Wow, you are right. I've missed the epf drivers completely. They don't
take the buffer size alignment into account. This patch and the
range-related patch most likely will regress both of these drivers.(
Alas they can't be fixed that easily.

1) drivers/pci/endpoint/functions/pci-epf-test.c retrieves size from
the user-space by means of an ioctl implemented in the
drivers/misc/pci_endpoint_test.c char-device driver (see what is
written at the PCI_ENDPOINT_TEST_SIZE offset). It doesn't make
sure that aside with the base address the size needs to be also
aligned.

2) drivers/pci/endpoint/functions/pci-epf-ntb.c uses the size based on
the NTB entity. It's either Door-Bell entry or a Memory Window. If the
Door-bell/MSI-X part can be more or less easily fixed, the MW-part
can't because the PCIe-bus part of the EP-function implementation
doesn't provide such information. After fixing that I would have also
needed to fix the drivers/ntb/hw/epf/ntb_hw_epf.c driver so the
callback method mw_get_align() would return the size alignment
constraint.

So to speak without corresponding HW at hand I won't be able to
successfully fix them.

> 
> > If the application you are
> > referring to your private code, then it can't be a justification.
> 
> I should have mentioned it, but my application is not private. It is partly
> available in linux-next:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/bus/mhi/ep/ring.c#n47
> https://git.linaro.org/landing-teams/working/qualcomm/kernel.git/tree/drivers/pci/endpoint/functions/pci-epf-mhi.c?h=tracking-qcomlt-sdx55-drivers#n121
> 
> > Secondly if your application uses them then what about just extending
> > the mapping range size while still access the lowest 15 bytes only? In
> > that case you would create a more comprehensive software which would
> > be aware of the hardware constraints.
> > 
> 

> Hmm... I'm already doing a similar hack for getting the aligned address due to
> iATU limitation, but I think doing the same for size should also work.
> 
> Thinking again, I agree with the alignment check. Thanks for the explanations.
> But let's make sure the existing EPF drivers still work.

Don't bother with re-developing our code. Since I can't fix the
denoted client drivers we have no choice but to do as you say and drop
the size alignment check. Thanks for pointing this out.

-Sergey

> 
> Thanks,
> Mani
> 
> > > 
> > > > > I know that it is a waste of memory but that doesn't mean that it won't work.
> > > > 
> > > > The correct statement in this case would be "it won't work in a way
> > > > you expected, but with the implicit side effect applied to the memory
> > > > above the requested one."
> > > > 
> > > 
> > 
> > > Agree but that would only happen when the application does out of bound
> > > access and in that case the issue is with the application.
> > 
> > Not only in that case, but anyway how would such application be aware
> > of the out of bounds access? Returning an error in case if the
> > requested mapping can't be performed with the specified parameters is
> > a possible solution. So the application would be aware of the hardware
> > constraints and be sure it perceives them right. Otherwise the
> > consequences of the out of bounds access would be very unexpected
> > since the mapping is performed only for the small buffer.
> > 
> > -Sergey
> > 
> > > 
> > > Thanks,
> > > Mani
> > > 
> > > > -Sergey
> > > > 
> > > > > 
> > > > > Thanks,
> > > > > Mani
> > > > > 
> > > > > > -Sergey
> > > > > > 
> > > > > > > 
> > > > > > > Thanks,
> > > > > > > Mani
> > > > > > > 
> > > > > > > -- 
> > > > > > > மணிவண்ணன் சதாசிவம்
> > > > > 
> > > > > -- 
> > > > > மணிவண்ணன் சதாசிவம்
> 
> -- 
> மணிவண்ணன் சதாசிவம்
