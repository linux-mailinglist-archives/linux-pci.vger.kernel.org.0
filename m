Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5103F789781
	for <lists+linux-pci@lfdr.de>; Sat, 26 Aug 2023 16:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjHZOqv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 26 Aug 2023 10:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjHZOq1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 26 Aug 2023 10:46:27 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7506B210B
        for <linux-pci@vger.kernel.org>; Sat, 26 Aug 2023 07:46:23 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bee82fad0fso12236765ad.2
        for <linux-pci@vger.kernel.org>; Sat, 26 Aug 2023 07:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693061183; x=1693665983;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cvjjfe1KUBN3ohw6yJuUww67ITTu8nVKPCe0bxCs6OE=;
        b=Wtq31WVrNH5UsZYQaC0tTuFHA8JMb3nTGV4XvpJdirkyPpnNr2ozFq+/JjibIxB9uI
         dJLQaDRF7kI6UBh3DZDt46LnVgQRrOzDFQ7W5sVpfAu+/+THbv3rAcKBkoqOVGP+yBAg
         3Nysg/Ec6h9hBKCN6OQGIhdDLxh0TyHcJRBJdoz2x5z+o02AV6VNXii84n6l6tgCHkmc
         g2iyBmRg+cK2U+EBuguXlypMzz1n2mYoyMke90yH+7o1HRFJcX7+AYK3DRmLuCF8unP4
         k790/Nm1Znr0P9wlwq5H4qGOWHRsJzhZadgdmNdWBCZ4WVc8AdzZn7lMIuR9V6jCk82r
         zbCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693061183; x=1693665983;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cvjjfe1KUBN3ohw6yJuUww67ITTu8nVKPCe0bxCs6OE=;
        b=GhBDAWf+OHbmNZc65P5inw1Eg2pN2v6jQcb6+keCRF9Amlr/51wk8IMFQekJSDr82e
         XdA1yspzPvi5A1jKooz9Nv3+U4W6TpSp7C9mmFPcu0CsnKaVmwgqfkLC+humFIMytDM7
         D9nEOw8zN7X4v0Gmsy4rYlRoOSuAeQ1S9OPgbGUjfdzZ+ougLoH5PTBjGPunOKJgodaG
         j5lIHRCCSzPWqykC8evvFBJAXGiCqM4AWvaEc1wJ7hTZnhNjPzHqWVU0ZZ3eh6n+cv9L
         h9iu2/oK0QBmvixkb7I6npADbu1H0zv3ezfFZDx/Q0FDo3QENFjyYFEjg8jURI/nZT1U
         pi8g==
X-Gm-Message-State: AOJu0Yyr91mlqyu7Wa2XHPZHKXo+Jz0ptZKRtHUJwwvFMrLzKbuG3Qrd
        dARQYEiZLeg149CuCPEExFl3w9konhVdEmJ74w==
X-Google-Smtp-Source: AGHT+IGGdf6SFxcjFol+302zSJxRzdTlKENX2fADfCRYYugfQ8pgY9tLxKTwVccX5HvNrpmRwa57uA==
X-Received: by 2002:a17:902:a416:b0:1bf:46ee:9c6 with SMTP id p22-20020a170902a41600b001bf46ee09c6mr16552524plq.48.1693061182827;
        Sat, 26 Aug 2023 07:46:22 -0700 (PDT)
Received: from thinkpad ([117.206.116.138])
        by smtp.gmail.com with ESMTPSA id k1-20020a170902694100b001b8b45b177esm3742889plt.274.2023.08.26.07.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 07:46:22 -0700 (PDT)
Date:   Sat, 26 Aug 2023 20:16:15 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     lpieralisi@kernel.org, kw@linux.com, kishon@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 2/7] PCI: epf-mhi: Make use of the alignment
 restriction from EPF core
Message-ID: <20230826144615.GA8858@thinkpad>
References: <20230717065459.14138-3-manivannan.sadhasivam@linaro.org>
 <20230825225006.GA642059@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230825225006.GA642059@bhelgaas>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 25, 2023 at 05:50:06PM -0500, Bjorn Helgaas wrote:
> On Mon, Jul 17, 2023 at 12:24:54PM +0530, Manivannan Sadhasivam wrote:
> > Instead of hardcoding the alignment restriction in the EPF_MHI driver, make
> > use of the info available from the EPF core that reflects the alignment
> > restriction of the endpoint controller.
> > 
> > For this purpose, let's introduce the get_align_offset() static function.
> 
> I thought this might be related to the [1/7] patch since they both
> mention an alignment restriction in the EPF core, but [1/7] sets
> pci_epc_features.align and this patch doesn't reference .align, so
> this must be a different alignment restriction?
> 
> I'm sure there's nothing wrong here, and this is already applied, so
> no need to do anything unless .align *should* appear here.
> 

You are absolutely right! The patch was intented to make use of "align" but
"page_size" was used as per old revision. Even though this patch works (because
both "page_size" and "align" were 4K in my setup), it should be fixed.

I will send a fix up patch now. Thanks for spotting.

- Mani

> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-mhi.c | 15 +++++++++++----
> >  1 file changed, 11 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> > index 9c1f5a154fbd..bb7de6884824 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> > @@ -102,6 +102,11 @@ struct pci_epf_mhi {
> >  	int irq;
> >  };
> >  
> > +static size_t get_align_offset(struct pci_epc *epc, u64 addr)
> > +{
> > +	return addr % epc->mem->window.page_size;
> > +}
> > +
> >  static int __pci_epf_mhi_alloc_map(struct mhi_ep_cntrl *mhi_cntrl, u64 pci_addr,
> >  				 phys_addr_t *paddr, void __iomem **vaddr,
> >  				 size_t offset, size_t size)
> > @@ -134,7 +139,7 @@ static int pci_epf_mhi_alloc_map(struct mhi_ep_cntrl *mhi_cntrl, u64 pci_addr,
> >  {
> >  	struct pci_epf_mhi *epf_mhi = to_epf_mhi(mhi_cntrl);
> >  	struct pci_epc *epc = epf_mhi->epf->epc;
> > -	size_t offset = pci_addr & (epc->mem->window.page_size - 1);
> > +	size_t offset = get_align_offset(epc, pci_addr);
> >  
> >  	return __pci_epf_mhi_alloc_map(mhi_cntrl, pci_addr, paddr, vaddr,
> >  				      offset, size);
> > @@ -161,7 +166,7 @@ static void pci_epf_mhi_unmap_free(struct mhi_ep_cntrl *mhi_cntrl, u64 pci_addr,
> >  	struct pci_epf_mhi *epf_mhi = to_epf_mhi(mhi_cntrl);
> >  	struct pci_epf *epf = epf_mhi->epf;
> >  	struct pci_epc *epc = epf->epc;
> > -	size_t offset = pci_addr & (epc->mem->window.page_size - 1);
> > +	size_t offset = get_align_offset(epc, pci_addr);
> >  
> >  	__pci_epf_mhi_unmap_free(mhi_cntrl, pci_addr, paddr, vaddr, offset,
> >  				 size);
> > @@ -185,7 +190,8 @@ static int pci_epf_mhi_read_from_host(struct mhi_ep_cntrl *mhi_cntrl, u64 from,
> >  				      void *to, size_t size)
> >  {
> >  	struct pci_epf_mhi *epf_mhi = to_epf_mhi(mhi_cntrl);
> > -	size_t offset = from % SZ_4K;
> > +	struct pci_epc *epc = epf_mhi->epf->epc;
> > +	size_t offset = get_align_offset(epc, from);
> >  	void __iomem *tre_buf;
> >  	phys_addr_t tre_phys;
> >  	int ret;
> > @@ -213,7 +219,8 @@ static int pci_epf_mhi_write_to_host(struct mhi_ep_cntrl *mhi_cntrl,
> >  				     void *from, u64 to, size_t size)
> >  {
> >  	struct pci_epf_mhi *epf_mhi = to_epf_mhi(mhi_cntrl);
> > -	size_t offset = to % SZ_4K;
> > +	struct pci_epc *epc = epf_mhi->epf->epc;
> > +	size_t offset = get_align_offset(epc, to);
> >  	void __iomem *tre_buf;
> >  	phys_addr_t tre_phys;
> >  	int ret;
> > -- 
> > 2.25.1
> > 

-- 
மணிவண்ணன் சதாசிவம்
