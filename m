Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC70720081
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jun 2023 13:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbjFBLif (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Jun 2023 07:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234703AbjFBLie (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Jun 2023 07:38:34 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B142194
        for <linux-pci@vger.kernel.org>; Fri,  2 Jun 2023 04:38:33 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5147e40bbbbso2817859a12.3
        for <linux-pci@vger.kernel.org>; Fri, 02 Jun 2023 04:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685705911; x=1688297911;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g4pVi7VOBRFaULLi4SVb4N0TF+UwJd4kFrSgP2liy+0=;
        b=SRBOfRjcMUxkwQmK+GMU6ugb72NtsDBOdlKm2/+NDhdflQR5OD8Virae/S2OrpTlwO
         ZjTzB626ks47GxAxK84SDSj1Tc3sIqO1dbzcOou0RHHXUCGn0cb7BIjMcEWsKOCQ9C4M
         tPhbIcfhih3eRF0vixDhbxQ1z8D+GAZFZgazYUGZUEXQl1jcIZLxQobWdCQXF5m1xTjV
         9Id59zqHmc9JcD2zUVHT1rQMIjhf0+5Sh5eTFyFHd9wjCd8xD8MBix6alPUWxr1ddJcW
         2+eDvfzxDxwzpdyR1+lIogaHYzwAvkMe/Hizzbc7+CmakKaBvxuQxlfBQ35oFTKJTHqK
         kOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685705911; x=1688297911;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g4pVi7VOBRFaULLi4SVb4N0TF+UwJd4kFrSgP2liy+0=;
        b=GwlAm7alP4oMSzIxOguGf1rMVYg18niBelRwt3Dq7BAOZz4E9dBNgLBiDZzRyPtK6K
         nhIt/uYPFG04gIZNWGSVWNCmTrtczIc959NJXIPyQzLTE56ojoAavVcx7VKiXvfg2MM6
         z/7pAGKhLXC9HCdfADqZx9QDOFb4qYeoMId1StSCi2Uvdyxyyn0Fu+3rY+cjcx4uH6n8
         ae/2z1ZWFwJeozG9J44zvcWyD3+9Mnc80cEr5fZWUXR4P/XdMS+hUTeOV45G8wX7EDOF
         qMEDKsEhXB0e/9nFO6XM3Pb/XgfKHzukF2j2gf79mPuzmMmGRaaqnAe+wy224Vu+mcq6
         XeCQ==
X-Gm-Message-State: AC+VfDzTnDTdpFiGTIkzw7UeAbDS9i6hMxOGWGPsMo28gz+r9G/qvOmU
        12ETn2yTq5YWLkKUvxNrnQ8+
X-Google-Smtp-Source: ACHHUZ6VUn698+qtREhO6oDsLHHVh8G2t6Kbo1RoMnm9smgysN+NtVSs8CbNvZvvDyoAZ8jpv79wzA==
X-Received: by 2002:a05:6402:b34:b0:50c:9582:e968 with SMTP id bo20-20020a0564020b3400b0050c9582e968mr1801501edb.36.1685705911452;
        Fri, 02 Jun 2023 04:38:31 -0700 (PDT)
Received: from thinkpad ([117.217.186.79])
        by smtp.gmail.com with ESMTPSA id w15-20020a056402070f00b00514bb73b8casm602807edx.57.2023.06.02.04.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 04:38:31 -0700 (PDT)
Date:   Fri, 2 Jun 2023 17:08:20 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     lpieralisi@kernel.org, kw@linux.com, kishon@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 9/9] PCI: endpoint: Add PCI Endpoint function driver
 for MHI bus
Message-ID: <20230602113820.GA34855@thinkpad>
References: <20230601145718.12204-1-manivannan.sadhasivam@linaro.org>
 <20230601145718.12204-10-manivannan.sadhasivam@linaro.org>
 <c13b5771-e619-60cb-791d-1458f7adc9ac@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c13b5771-e619-60cb-791d-1458f7adc9ac@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 02, 2023 at 08:31:31AM +0900, Damien Le Moal wrote:
> On 6/1/23 23:57, Manivannan Sadhasivam wrote:
> > Add PCI Endpoint driver for the Qualcomm MHI (Modem Host Interface) bus.
> > The driver implements the MHI function over PCI in the endpoint device
> > such as SDX55 modem. The MHI endpoint function driver acts as a
> > controller driver for the MHI Endpoint stack and carries out all PCI
> > related activities like mapping the host memory using iATU, triggering
> > MSIs etc...
> > 
> > Reviewed-by: Kishon Vijay Abraham I <kishon@kernel.org>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Looks good, but not knowing this hardware, I only did a style review. I added
> some nits below.
> 
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> 
> 
> > ---
> >  drivers/pci/endpoint/functions/Kconfig       |  10 +
> >  drivers/pci/endpoint/functions/Makefile      |   1 +
> >  drivers/pci/endpoint/functions/pci-epf-mhi.c | 462 +++++++++++++++++++
> >  3 files changed, 473 insertions(+)
> >  create mode 100644 drivers/pci/endpoint/functions/pci-epf-mhi.c
> > 
> > diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpoint/functions/Kconfig
> > index 9fd560886871..f5171b4fabbe 100644
> > --- a/drivers/pci/endpoint/functions/Kconfig
> > +++ b/drivers/pci/endpoint/functions/Kconfig
> > @@ -37,3 +37,13 @@ config PCI_EPF_VNTB
> >  	  between PCI Root Port and PCIe Endpoint.
> >  
> >  	  If in doubt, say "N" to disable Endpoint NTB driver.
> > +
> > +config PCI_EPF_MHI
> > +	tristate "PCI Endpoint driver for MHI bus"
> > +	depends on PCI_ENDPOINT && MHI_BUS_EP
> > +	help
> > +	   Enable this configuration option to enable the PCI Endpoint
> > +	   driver for Modem Host Interface (MHI) bus in Qualcomm Endpoint
> > +	   devices such as SDX55.
> > +
> > +	   If in doubt, say "N" to disable Endpoint driver for MHI bus.
> > diff --git a/drivers/pci/endpoint/functions/Makefile b/drivers/pci/endpoint/functions/Makefile
> > index 5c13001deaba..696473fce50e 100644
> > --- a/drivers/pci/endpoint/functions/Makefile
> > +++ b/drivers/pci/endpoint/functions/Makefile
> > @@ -6,3 +6,4 @@
> >  obj-$(CONFIG_PCI_EPF_TEST)		+= pci-epf-test.o
> >  obj-$(CONFIG_PCI_EPF_NTB)		+= pci-epf-ntb.o
> >  obj-$(CONFIG_PCI_EPF_VNTB) 		+= pci-epf-vntb.o
> > +obj-$(CONFIG_PCI_EPF_MHI)		+= pci-epf-mhi.o
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> > new file mode 100644
> > index 000000000000..98f0d96cfd46
> > --- /dev/null
> > +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c

[...]

> > +static int pci_epf_mhi_write_to_host(struct mhi_ep_cntrl *mhi_cntrl,
> > +				     void __iomem *from, u64 to, size_t size)
> > +{
> > +	struct pci_epf_mhi *epf_mhi = to_epf_mhi(mhi_cntrl);
> > +	struct pci_epf *epf = epf_mhi->epf;
> > +	struct pci_epc *epc = epf_mhi->epf->epc;
> > +	void __iomem *tre_buf;
> > +	phys_addr_t tre_phys;
> > +	size_t offset = to % SZ_4K;
> > +	int ret;
> > +
> > +	mutex_lock(&epf_mhi->lock);
> > +
> > +	tre_buf = pci_epc_mem_alloc_addr(epc, &tre_phys, size + offset);
> > +	if (!tre_buf) {
> > +		ret = -ENOMEM;
> > +		goto err_unlock;
> > +	}
> > +
> > +	ret = pci_epc_map_addr(epc, epf->func_no, epf->vfunc_no, tre_phys,
> > +			       to - offset, size + offset);
> > +	if (ret) {
> > +		pci_epc_mem_free_addr(epc, tre_phys, tre_buf, size + offset);
> > +		goto err_unlock;
> > +	}
> 
> The above 2 hunks are that same as in pci_epf_mhi_read_from_host(). May be pack
> these in a helper function ? E.g. pci_epf_mhi_map() ?
> Note that I have a patch series in the work that does that at the pci_epc API
> level (pci_epc_map() + pci_epc_unmap()) to simplify function drivers.
> 
> > +
> > +	memcpy_toio(tre_buf + offset, from, size);
> > +
> > +	pci_epc_unmap_addr(epc, epf->func_no, epf->vfunc_no, tre_phys);
> > +	pci_epc_mem_free_addr(epc, tre_phys, tre_buf, size + offset);
> 
> Same here: pci_epf_mhi_unmap() ?
> 

Agree with both of the above comments. At have this change in my local tree but
that's not part of this series. Will merge it to this patch itself.

> > +
> > +err_unlock:
> > +	mutex_unlock(&epf_mhi->lock);
> > +
> > +	return ret;
> > +}
> > +

[...]

> > +static int pci_epf_mhi_bind(struct pci_epf *epf)
> > +{
> > +	struct pci_epf_mhi *epf_mhi = epf_get_drvdata(epf);
> > +	struct pci_epc *epc = epf->epc;
> > +	struct platform_device *pdev = to_platform_device(epc->dev.parent);
> > +	struct device *dev = &epf->dev;
> > +	struct resource *res;
> > +	int ret;
> > +
> > +	if (WARN_ON_ONCE(!epc))
> > +		return -EINVAL;
> 
> This should never happen. If there is a possibility that the EPC core code calls
> bind with epc == NULL, we need to fix that there.
> 

Right, this seems to be redundant.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
