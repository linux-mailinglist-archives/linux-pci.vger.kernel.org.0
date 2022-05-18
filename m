Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B50B52B103
	for <lists+linux-pci@lfdr.de>; Wed, 18 May 2022 06:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiEREDu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 May 2022 00:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiEREDu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 May 2022 00:03:50 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1404342A0B
        for <linux-pci@vger.kernel.org>; Tue, 17 May 2022 21:02:10 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id i1so620530plg.7
        for <linux-pci@vger.kernel.org>; Tue, 17 May 2022 21:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=oMTtZkU4nCZ91NEzU4LZyarDEe9CrBJP6c+5gci4GhU=;
        b=hF2SJNQuyAPX27K3O9IKX/L7RDe9giGyYcZXLKfxFWF8u2tDkNwctNMV0RTCXeqRtY
         Z/h56M6pzUGxi0REj9rAvd+5EJwbbTuTDWrXHJHFAHMuLiUAg2edghW6NutRy2mfL/Jm
         GMPvVsvejGx11NLjXPDbv0od0DV06IaVgfKqzMldePlFVBPRgeTw+s3gy6CS6Q6xrJze
         6igJeBRbf8skF17n1cjJu1pjR5o3rBESjG0GklU0cXmf8msxavMpTLRNixhQLL59apY2
         lP+0Sw+pVuMPOZDXlWhb4y+h+vBrYz5EEnJNZwavhIqx6Af8rBeeMJdmBg6IXNl3Q/9S
         PC5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=oMTtZkU4nCZ91NEzU4LZyarDEe9CrBJP6c+5gci4GhU=;
        b=sY6KXTLQXqmYA29zw3lf5b+8JJ6VdSE3LnMS9Fm2IJ0ZbkjuqTf9f3fL6zN5NPxtEH
         G65kfHWIOGs1fTZ2MczV/7nLU/EwWekdxrdI8gKLrE7dFV8DmZ/uHA2PP3awZL2sGN2F
         cOi1YRkHylkpIvYh92sbkgdDS9fSpVudh16sMibelsZUIEmL7eiDN+kf9r7s+1/l2fU/
         pXe08l7fE2B7i5XaXpi2/tgrsq1d32ZrPGYiYhHP0fWqI086QeQUy/4cbEkw017jvl6X
         75N8TiLzd8Q3C5WS6XajwhzniBmhoI5kxXFDsFl4SIWF5xpyRmsvde+pBYpxnUofBEgz
         M11Q==
X-Gm-Message-State: AOAM530udKOP7qFM8TMFfhveo4DsxTdIXNzWwcolS/HpSQxwx5AMsh5L
        BT3AaPPbBEW6j/pZ5Xz/lNhY
X-Google-Smtp-Source: ABdhPJzXyPrirmGjfB9wAO7hUPPrBdR7ojzbTs2rrQl2LhF5QrddfhsS+8ZM5ow+o6gPFsXwn0NTUA==
X-Received: by 2002:a17:90a:f3d5:b0:1df:2191:5ad2 with SMTP id ha21-20020a17090af3d500b001df21915ad2mr20245819pjb.136.1652846365631;
        Tue, 17 May 2022 20:59:25 -0700 (PDT)
Received: from thinkpad ([117.207.31.8])
        by smtp.gmail.com with ESMTPSA id g8-20020a170902d5c800b0015e8d4eb225sm413568plh.111.2022.05.17.20.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 20:59:25 -0700 (PDT)
Date:   Wed, 18 May 2022 09:29:15 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jens Axboe <axboe@fb.com>,
        Veerabhadrarao Badiganti <quic_vbadigan@quicinc.com>,
        quic_krichai@quicinc.com, Nitin Rawat <quic_nitirawa@quicinc.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 1/3] PCI: Add a flag to notify PCI drivers about
 powerdown during suspend
Message-ID: <20220518035915.GB4791@thinkpad>
References: <20220517150908.GA4528@thinkpad>
 <20220517172423.GA1083672@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220517172423.GA1083672@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 17, 2022 at 12:24:23PM -0500, Bjorn Helgaas wrote:
> On Tue, May 17, 2022 at 08:39:08PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, May 16, 2022 at 03:18:17PM -0500, Bjorn Helgaas wrote:
> > > On Fri, May 13, 2022 at 04:30:25PM +0530, Manivannan Sadhasivam wrote:
> > > > On some systems like Chromebooks based on Qcom chipsets, the OS may
> > > > powerdown all PCIe devices during system suspend for aggressive
> > > > powersaving. In that case, the PCI host controller drivers need to notify
> > > > the PCI device drivers that the power will be taken off during system
> > > > suspend so that the drivers can prepare the devices accordingly.
> > > 
> > > "The OS may powerdown all PCIe devices ..." makes it sound like this
> > > is an OS policy decision.  Where exactly (what function) is that?
> > > 
> > > Or if it's not an OS policy decision, but rather some property of the
> > > hardware, say that specifically.
> > 
> > On SC7280, it is the Resource Power Manager(RPMh) that's powering
> > the devices down by cutting off the PCIe voltage domain. But the
> > SC7280 RC driver itself may put the PCIe devices into D3cold state
> > during system suspend.
> > https://lore.kernel.org/lkml/CAE-0n53ho2DX2rqQMvvKAuDCfsWW62TceTaNPzv5Mn_NQ-U6dA@mail.gmail.com/T/
> > 
> > So to cover both cases (one is a hardware independent of SoC and
> > another one is the device driver), and to be generic, I've used the
> > term "OS" after looking at the previous flags.
> 
> This sort of device-specific behavior definitely needs a pointer to an
> example.  Otherwise it seems like it could be generic PCIe behavior
> that should be documented in the PCIe base spec.
> 

Okay.

> > > > One prime example is the PCI NVMe driver. This flag can be used by the
> > > > driver to shutdown the NVMe device during suspend and recover it during
> > > > resume.
> 
> Apparently nvme is broken, or at least sub-optimal, without this flag.

Yes, broken on SC7280 or any other SoCs that turn off power.

> What other drivers will be similarly affected?
> 

I don't have a list but the drivers that don't expect the device to be turned
off or reset during suspend may experience this issue. Right now, we have only
identified the issue with NVMe because that's what used on Chromebooks.

But in the coming days, we may need to fix some of the drivers also.

Thanks,
Mani

> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > ---
> > > >  include/linux/pci.h | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > > index 60adf42460ab..069caf1fe88d 100644
> > > > --- a/include/linux/pci.h
> > > > +++ b/include/linux/pci.h
> > > > @@ -578,6 +578,7 @@ struct pci_host_bridge {
> > > >  	unsigned int	preserve_config:1;	/* Preserve FW resource setup */
> > > >  	unsigned int	size_windows:1;		/* Enable root bus sizing */
> > > >  	unsigned int	msi_domain:1;		/* Bridge wants MSI domain */
> > > > +	unsigned int	suspend_poweroff:1;	/* OS may poweroff devices during system suspend */
> > > >  
> > > >  	/* Resource alignment requirements */
> > > >  	resource_size_t (*align_resource)(struct pci_dev *dev,

-- 
மணிவண்ணன் சதாசிவம்
