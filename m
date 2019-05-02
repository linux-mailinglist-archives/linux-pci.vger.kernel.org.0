Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3029B11BF8
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2019 17:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfEBPAG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 May 2019 11:00:06 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45688 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfEBPAG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 May 2019 11:00:06 -0400
Received: by mail-pg1-f195.google.com with SMTP id i21so1169911pgi.12
        for <linux-pci@vger.kernel.org>; Thu, 02 May 2019 08:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+h3hw8s9AtbUTxjsRg8h8D8msF/wrKXAgqEpw8EeNOA=;
        b=jlPMKdBldP3f4gKDgtqtVH6KYU8BBSCgulAP9KFpHF3ggzd6GSvZz16mK18TthOsMB
         1vIdQs+yeoBsgHJk6YekXKdpVP9K50gEgw25xuVBTGoxyyoHb29xzJ1Ag7owhc4iWbJH
         3vtoFqsW+jMQOE51MrgTIxpPqNuJeob2IO2cLCizNlQi3tIitPvtK0sQj6ZbAjSSmi7Q
         How1Fdr5GunZ9wIhUNpe8lJnwvz4fLYdBh0eoo7nwRiWBdB4lO/rCUKPbZYMYOEWstK6
         X9eprPBu7iBiQdu2/W6KBPXy8NJJCdW7KNyEh5OU4DREjJDfxop3p+3u0QEieu4jXfUx
         qsOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+h3hw8s9AtbUTxjsRg8h8D8msF/wrKXAgqEpw8EeNOA=;
        b=qPEmip2My1ggVXyADGqKz0f2sgOWJ6rpCRqg+oRkB5ucEqVAZbsH7QckTGNZK2Ytg+
         Fm73QNPlPtV3KxoloRreQurm5aR5jOt8WbxHPh3IMy6dZnUChq2KowHI8icY8H9OSKZU
         ndXGG95R1DoBJJyTTjnixTX8Rv+/G6S7SoH19elbJIt05AHG+idCK4zImg5nXK1rmXPP
         fkrbojPMy6c6V/5ApXwXb+dZ+qgMc6w4GlJ5IjEWyMu2L9+hF/52ZBtbO6b47nTvzEu6
         adXyMLz7KskoTGmRCCbQfG+oDvYPFGt+O3WUr8oaBABA89JBL2KNiFY3i1N78n0XeZ2r
         B8OA==
X-Gm-Message-State: APjAAAVw+AUsTEVZyvL6XCC9pX4VnXyp0Ls/3NsOMQYb64MVo6grPcIi
        OJ72zYF5WLuLjqyi5d4xwi8gFw==
X-Google-Smtp-Source: APXvYqxWyfb9Mb0R98oD1S3XalY5sExRiMmQ78TIyJ0AR6QKTKJB4fZ9Az+LDCDt3uqkWQ2xI1kwEg==
X-Received: by 2002:aa7:9242:: with SMTP id 2mr1888978pfp.230.1556809205168;
        Thu, 02 May 2019 08:00:05 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id i3sm60549129pfa.90.2019.05.02.08.00.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 08:00:03 -0700 (PDT)
Date:   Thu, 2 May 2019 08:00:06 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] PCI: qcom: Use clk_bulk API for 2.4.0 controllers
Message-ID: <20190502150006.GL2938@tuxbook-pro>
References: <20190502001955.10575-1-bjorn.andersson@linaro.org>
 <20190502001955.10575-2-bjorn.andersson@linaro.org>
 <20190502115351.GM3845@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502115351.GM3845@vkoul-mobl.Dlink>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu 02 May 04:53 PDT 2019, Vinod Koul wrote:
> On 01-05-19, 17:19, Bjorn Andersson wrote:
[..]
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index 0ed235d560e3..d740cbe0e56d 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -112,10 +112,10 @@ struct qcom_pcie_resources_2_3_2 {
> >  	struct regulator_bulk_data supplies[QCOM_PCIE_2_3_2_MAX_SUPPLY];
> >  };
> >  
> > +#define QCOM_PCIE_2_4_0_MAX_CLOCKS	3
> 
> empty line after the define please
> 

This follows the style of QCOM_PCIE_2_3_2_MAX_SUPPLY one block up, so
I think this is the way we want it.

> >  struct qcom_pcie_resources_2_4_0 {
[..]
> 
> 
> rest lgtm:
> 
> Reviewed-by: Vinod Koul <vkoul@kernel.org>
> 

Thanks!

Regards,
Bjorn
