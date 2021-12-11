Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99AD3471124
	for <lists+linux-pci@lfdr.de>; Sat, 11 Dec 2021 04:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244497AbhLKDOs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Dec 2021 22:14:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244455AbhLKDOr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Dec 2021 22:14:47 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C316BC061751
        for <linux-pci@vger.kernel.org>; Fri, 10 Dec 2021 19:11:11 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id l18so4914461pgj.9
        for <linux-pci@vger.kernel.org>; Fri, 10 Dec 2021 19:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wZPVLhTmfjbvLXy8wFUxjggNBQQIUKMzW/yUT1AkbIg=;
        b=MsYzCgMk4JLhLMLV7WvCd6xB1q8NhaATEzsou9pc+5yIw8jz16Pojr5PkCg+GNQZwH
         AUKsuvTFZdLNvJ5v5Tbp8QslJvhTIYkHENo+gv+UNGu6IPk6BCEK0nEvE/iYG/+x1+sG
         9Gf+85gnPTKrexYtcSS1JoIiLgXRB/HVZ0z6QmDpzQmF+VTLE5l3UCpWic0HatC6vqsE
         oHJdQ2exIMqZGYV3cp0D+xO2hKRQLTY/aIvLQ4DfSg/ID5T5eo7cbougTC4vRHXLdFMM
         vzFHrhGhFVI3u46UKk0kGJeS+vzk2qYvfhoDc5FpCZ72e5LX+JBa6JcUYXdHCSdU1WyJ
         KYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wZPVLhTmfjbvLXy8wFUxjggNBQQIUKMzW/yUT1AkbIg=;
        b=vVCxdRjGVEtyJYbcgpcK1r/jQrLW8I3SjcG4LBdJhBnGKfMo6xG8i3jVxMFPiB7rwC
         Kng3TaG0v5JedcT+04iZ3451qRV2JEv7KXZN54xOTiGNtQeAjIdG0ld97MAnjhWyKNkb
         TJ+Y9EJ9GsGuArbdsZiuKfLQTPPuJUeHIgP0RCiebusWijoCjpaNcItv7TpKH3r/Ph6F
         23f9k+BZtRB/FsabsfikrSbNwsXIuKwpO77X7FIFNEmyFSMRWPk2CqCzhKERRxcho2OU
         w44g47c5+Cmacfnta5GAbuANnH4h+mgbX4F8QuBir8DB93KQewCQe7gEXoVDDS05HIoS
         +SaQ==
X-Gm-Message-State: AOAM531x+LPYusIVmcODmDiX5n9v8d9fhvHDKZZtu9HGp0+IC3SlaHmI
        Yx5i8JNVi3mynAgEHiviascj
X-Google-Smtp-Source: ABdhPJzfchh3tDRiN4hj1vD/tbB0nD8iMxo/XxSFswJDLeGypxG5uepeX4JiFWmvYZpdUOFfDLT6kA==
X-Received: by 2002:a05:6a00:b49:b0:49f:c8e0:51ff with SMTP id p9-20020a056a000b4900b0049fc8e051ffmr21021033pfo.36.1639192271182;
        Fri, 10 Dec 2021 19:11:11 -0800 (PST)
Received: from workstation ([202.21.42.75])
        by smtp.gmail.com with ESMTPSA id m15sm3876838pgd.44.2021.12.10.19.11.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Dec 2021 19:11:10 -0800 (PST)
Date:   Sat, 11 Dec 2021 08:41:06 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v2 05/10] PCI: qcom: Add ddrss_sf_tbu flag
Message-ID: <20211211031106.GB21304@workstation>
References: <20211208171442.1327689-1-dmitry.baryshkov@linaro.org>
 <20211208171442.1327689-6-dmitry.baryshkov@linaro.org>
 <20211210112241.GE1734@thinkpad>
 <95401925-6e97-8fce-4fe6-4701c4fad301@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95401925-6e97-8fce-4fe6-4701c4fad301@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Dec 11, 2021 at 04:59:05AM +0300, Dmitry Baryshkov wrote:
> On 10/12/2021 14:22, Manivannan Sadhasivam wrote:
> > On Wed, Dec 08, 2021 at 08:14:37PM +0300, Dmitry Baryshkov wrote:
> > > Qualcomm PCIe driver uses compatible string to check if the ddrss_sf_tbu
> > > clock should be used. Since sc7280 support has added flags, switch to
> > > the new mechanism to check if this clock should be used.
> > > 
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > ---
> > >   drivers/pci/controller/dwc/pcie-qcom.c | 5 ++++-
> > >   1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > index 51a0475173fb..803d3ac18c56 100644
> > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > @@ -194,7 +194,9 @@ struct qcom_pcie_ops {
> > >   struct qcom_pcie_cfg {
> > >   	const struct qcom_pcie_ops *ops;
> > > +	/* flags for ops 2.7.0 and 1.9.0 */
> > 
> > No need of this comment.
> 
> Dropping it
> 
> > 
> > >   	unsigned int pipe_clk_need_muxing:1;
> > 
> > This should be added in the previous patch.
> 
> It exists already
> 

Ah, my tree was outdated. I do see it in -rc4.

> > 
> > > +	unsigned int has_ddrss_sf_tbu_clk:1;
> > 
> > Wondering if we could make both the flags "bool" as the values passed to it
> > are of boolean type. I don't think we could save a significant amount of
> > memory using bitfields.
> 
> I followed the existing pipe_clk_need_muxing. I have no strong preference
> here, so let's see what Bjorn will prefer.
> 

Okay.

Thanks,
Mani

> > 
> > Thanks,
> > Mani
> > >   };
> > >   struct qcom_pcie {
> > > @@ -1164,7 +1166,7 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
> > >   	res->clks[3].id = "bus_slave";
> > >   	res->clks[4].id = "slave_q2a";
> > >   	res->clks[5].id = "tbu";
> > > -	if (of_device_is_compatible(dev->of_node, "qcom,pcie-sm8250")) {
> > > +	if (pcie->cfg->has_ddrss_sf_tbu_clk) {
> > >   		res->clks[6].id = "ddrss_sf_tbu";
> > >   		res->num_clks = 7;
> > >   	} else {
> > > @@ -1512,6 +1514,7 @@ static const struct qcom_pcie_cfg sdm845_cfg = {
> > >   static const struct qcom_pcie_cfg sm8250_cfg = {
> > >   	.ops = &ops_1_9_0,
> > > +	.has_ddrss_sf_tbu_clk = true,
> > >   };
> > >   static const struct qcom_pcie_cfg sc7280_cfg = {
> > > -- 
> > > 2.33.0
> > > 
> 
> 
> -- 
> With best wishes
> Dmitry
