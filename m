Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11847CBCF7
	for <lists+linux-pci@lfdr.de>; Tue, 17 Oct 2023 10:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234701AbjJQIAG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Oct 2023 04:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234647AbjJQIAF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2023 04:00:05 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8442DED
        for <linux-pci@vger.kernel.org>; Tue, 17 Oct 2023 01:00:02 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-66cfd0b2d58so35416556d6.2
        for <linux-pci@vger.kernel.org>; Tue, 17 Oct 2023 01:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697529601; x=1698134401; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=INrC+5Wie+fprRRUI1JrVXEvROES6Vs47kj5Jp1nB5A=;
        b=YBVBupnI1M+x5IY28oQvfmr5hTlfm9eJLjWtI7/CGU8IYqotprS6+FNzemy40PU0qO
         Gu5gQ+poLFNQWsCjpT2jB5i7eBvCdCKXZ01rbUW/mn8/hbThE3rY02Z/g0fXqBouPO8w
         GtLY+oXN2ww12KMjA2Jlbapt0tDhQ0xksDIGp6LYRIHKR4I3E7dhY+GYghWU2pVPhLGV
         qGq7AIDq8TjtBUf1V5EgwFG+mGWhUj5sag0a2N/3jbbXe9knRWjE1CiCsyXc7I3pQdV0
         51T7AbvD/lRn2pWfWRcM+v8R7rJw81ud9YxK1j4I6+lSI/DTw55qhDNNn/CRVJeHlLaq
         aTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697529601; x=1698134401;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=INrC+5Wie+fprRRUI1JrVXEvROES6Vs47kj5Jp1nB5A=;
        b=hbfgmRCYtAbGq4BcQNXuRebI0dDZnQHsmjirtSEgj+GFPnHtn7NI899OH+Ux3yygvq
         KxcXQsuA6dJQ9mdpI/I/NJgxpFn8HCTScFoqY82xtBReJcmiBfNXpxH2JMfi36stAxvT
         dqYerlWl9uwz2FhHS8XS2PT0H+KkBvVUoAd125I6w2IVRKAv8aqfbi7/D/9cn0k3DDhm
         xy/9DGm++p3YELAXzSndCbM0BdoL16Td8uysxNStmxvJOcdRwAf+e+rVSw+cemiXoCBs
         K5G/ERmyAhjJ7t9mL4vUdf3GnHiINKR+IS3Xo3NbUd8OGg6+dPEKscerGJHNcAQ6tKNi
         V5qQ==
X-Gm-Message-State: AOJu0Yw1BWdG1qJIGgFS4UccUPQhmy23cSW3PzmEyY43uLgRuuMUPGl9
        1DC5uSgqC4Co0muhvC8+sn7TdKsAca3GYy+Bkw==
X-Google-Smtp-Source: AGHT+IE+SSVgX68tE3PWjNoFHnaivv1AlGTRaLTi7JSKhCrkTsa6tkt6Z0ukkJd2qvQxBA4h3BqQgg==
X-Received: by 2002:a05:6214:224d:b0:66d:1d2:dd85 with SMTP id c13-20020a056214224d00b0066d01d2dd85mr2299551qvc.48.1697529601644;
        Tue, 17 Oct 2023 01:00:01 -0700 (PDT)
Received: from thinkpad ([117.207.31.199])
        by smtp.gmail.com with ESMTPSA id f17-20020a056214165100b0065d05c8bb5dsm350794qvw.64.2023.10.17.00.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 01:00:01 -0700 (PDT)
Date:   Tue, 17 Oct 2023 13:29:52 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
        robh@kernel.org, gustavo.pimentel@synopsys.com,
        jingoohan1@gmail.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: dwc: Add host_post_init() callback
Message-ID: <20231017075952.GC5274@thinkpad>
References: <20231010155914.9516-2-manivannan.sadhasivam@linaro.org>
 <20231016205849.GA1225381@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231016205849.GA1225381@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 16, 2023 at 03:58:49PM -0500, Bjorn Helgaas wrote:
> On Tue, Oct 10, 2023 at 09:29:13PM +0530, Manivannan Sadhasivam wrote:
> > This callback can be used by the platform drivers to do configuration once
> > all the devices are scanned. Like changing LNKCTL of all downstream devices
> > to enable ASPM etc...
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware-host.c | 3 +++
> >  drivers/pci/controller/dwc/pcie-designware.h      | 1 +
> >  2 files changed, 4 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index a7170fd0e847..7991f0e179b2 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -502,6 +502,9 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> >  	if (ret)
> >  		goto err_stop_link;
> >  
> > +	if (pp->ops->host_post_init)
> > +		pp->ops->host_post_init(pp);
> 
> I know we talked about this a little bit in the context of enabling
> ASPM for devices below qcom 1.9.0 controllers at
> https://lore.kernel.org/r/20231011050058.GC3508@thinkpad
> 
> But I didn't realize at the time that this callback adds a fundamental
> difference between devices present at boot-time (these devices can be
> affected by this callback) and any devices hot-added later (we never
> run this callback again, so anything done by .host_post_init() never
> applies to them).
> 
> We merged this for now, and it helps enable ASPM for builtin devices
> on qcom, but I don't feel good about this from a larger DWC
> perspective.  If other drivers use this and they support hot-add, I
> think we're going to have problems.
> 

If someone is going to add same ASPM code in host_post_init() callback, they
will most likely aware of the hotplug issue. I see this as an interim solution
overall and we should fix the PCI core to handle this. But I do not see any
straightforward way to enable ASPM by default in PCI core as the misbehaving
devices can pull the system down (atleast in some x86 cases).

- Mani

-- 
மணிவண்ணன் சதாசிவம்
