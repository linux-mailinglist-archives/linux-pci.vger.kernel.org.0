Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE64E53550C
	for <lists+linux-pci@lfdr.de>; Thu, 26 May 2022 22:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345122AbiEZUsm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 May 2022 16:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345591AbiEZUsm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 May 2022 16:48:42 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C780E1EEF8;
        Thu, 26 May 2022 13:48:40 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-f2bb84f9edso3585981fac.10;
        Thu, 26 May 2022 13:48:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MiZ+0IvW8jjjxvu1Bkq9ZIWIVqKUJacSyRxJpKCYH18=;
        b=uZEMbYlNVtF4szbUXCjejmQIa4Fy4MKpHVFNrHlp/spmcM6X0hKlbrj9YU68MtUWNq
         nw4XspnuA/T5nsMgcYxpoKtnXqKDKzn4zAKHobN/GS2hRbCfeGz+iuj8CrMrCSXRvfO1
         WesT8iQ4Gi7tCqicvThfPTha/R56s7vkIRANzAyAs9PTzncegrjmZSWAQtelzWna4ilI
         OXTYrFqMz+VY+dNdwDMh/xqisfAN+KuHOlXHXua4nsJbr4d5/4uSxN7V8gm43raT/1eT
         GWhs5/fy7EdmyeDXoMue5N3ZV77KSEpl35peuQUnptG7LeT9Yttsq5cLvOsXipU5nzDU
         B1uQ==
X-Gm-Message-State: AOAM530ML96IXKTwDmGwjjLvpNwtho2yHYQ9mtE2UXkxyKXRM4K8PfP2
        0s0rFJex6yl7ixCkrkATEQ==
X-Google-Smtp-Source: ABdhPJwzclLUkR3PCJ6MEvx5J/Soe/zca3RJeZCRBhWGgy4tEyDUtmeTjwbPMaDrqR8MEXweQCsEeQ==
X-Received: by 2002:a05:6870:7084:b0:ed:d709:34be with SMTP id v4-20020a056870708400b000edd70934bemr2229680oae.4.1653598120077;
        Thu, 26 May 2022 13:48:40 -0700 (PDT)
Received: from robh.at.kernel.org (rrcs-192-154-179-37.sw.biz.rr.com. [192.154.179.37])
        by smtp.gmail.com with ESMTPSA id y17-20020a4ae711000000b0035eb4e5a6d2sm1036427oou.40.2022.05.26.13.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 13:48:39 -0700 (PDT)
Received: (nullmailer pid 238876 invoked by uid 1000);
        Thu, 26 May 2022 20:48:37 -0000
Date:   Thu, 26 May 2022 15:48:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com, kbusch@kernel.org,
        hch@lst.de, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, svarbanov@mm-sol.com,
        bjorn.andersson@linaro.org, axboe@fb.com,
        quic_vbadigan@quicinc.com, quic_krichai@quicinc.com,
        quic_nitirawa@quicinc.com, vidyas@nvidia.com, sagi@grimberg.me
Subject: Re: [PATCH 1/3] PCI: Add a flag to notify PCI drivers about
 powerdown during suspend
Message-ID: <20220526204837.GJ54904-robh@kernel.org>
References: <20220513110027.31015-2-manivannan.sadhasivam@linaro.org>
 <20220516201817.GA1047280@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516201817.GA1047280@bhelgaas>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 16, 2022 at 03:18:17PM -0500, Bjorn Helgaas wrote:
> On Fri, May 13, 2022 at 04:30:25PM +0530, Manivannan Sadhasivam wrote:
> > On some systems like Chromebooks based on Qcom chipsets, the OS may
> > powerdown all PCIe devices during system suspend for aggressive
> > powersaving. In that case, the PCI host controller drivers need to notify
> > the PCI device drivers that the power will be taken off during system
> > suspend so that the drivers can prepare the devices accordingly.
> 
> "The OS may powerdown all PCIe devices ..." makes it sound like this
> is an OS policy decision.  Where exactly (what function) is that?
> 
> Or if it's not an OS policy decision, but rather some property of the
> hardware, say that specifically.
> 
> > One prime example is the PCI NVMe driver. This flag can be used by the
> > driver to shutdown the NVMe device during suspend and recover it during
> > resume.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  include/linux/pci.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 60adf42460ab..069caf1fe88d 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -578,6 +578,7 @@ struct pci_host_bridge {
> >  	unsigned int	preserve_config:1;	/* Preserve FW resource setup */
> >  	unsigned int	size_windows:1;		/* Enable root bus sizing */
> >  	unsigned int	msi_domain:1;		/* Bridge wants MSI domain */
> > +	unsigned int	suspend_poweroff:1;	/* OS may poweroff devices during system suspend */

Why does this apply to the whole host bridge? What if you have multiple 
devices and some are powered off and others aren't?

Rob
