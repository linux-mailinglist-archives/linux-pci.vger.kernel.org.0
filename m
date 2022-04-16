Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76AF503514
	for <lists+linux-pci@lfdr.de>; Sat, 16 Apr 2022 10:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbiDPIDu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Apr 2022 04:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbiDPIDs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Apr 2022 04:03:48 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A1B100E29;
        Sat, 16 Apr 2022 01:01:15 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id k5so17041743lfg.9;
        Sat, 16 Apr 2022 01:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MXlAdpQLGQGUUo4/nFrsdLnsJFw/wYKXZIo/9dWMKPs=;
        b=GlWDVh4mGOslT9x+9Cf/M39/Uru7iSzMMGf0MsIHsJOECxtBIQEKSiOhQ6d5pbdf4j
         0Q4ZSqwrihtygT0jrukCM2I5zVYNwWIr+kQ9Vt/kp3uXZwNjlTgFSu1injKGGeDyIW7w
         l1qnOjTfmeatmweRiq24gZCi7q6JE9tLgmNi0SvW/Up+I0yjZLEIR58qIBBomdv5S+On
         o6HQSqmfwHSo2KYKzD3onll3iGoNhgFDBt+GBdRV0h5xCFZ7DjwqXq/3/TE9n4v7T1+2
         1jE2ZhXcJvn5NewsRez8HY/igateUo1vk+AZ087w895RzKsn83MZsPgSNi2LQnx9IZo6
         xO2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MXlAdpQLGQGUUo4/nFrsdLnsJFw/wYKXZIo/9dWMKPs=;
        b=3AjgWXLADfJDv+on13NN3zfZ47SZfUsp17pNBe7w//lEtWWxzNUgzz0VddMAXpb0HE
         T0EK+G3fhpD9yZ+xYN8dOK1JWd3PubTEmmp0L3LypROMNIzFpck8EX4M8+K/fDxrGP6t
         K1xJGRcHocCafbGOBNNjWS/fE5KFELlr1KqgozvnwQSkbpQf92G/FB5PsTATTLvYJpo5
         /afb3mHAvEFGhAQW2I2gLEeR9m3Cf93yXZ2VRxSJNPuwCVmbybfYctNZPB44ukVfJOFo
         ZLJQ+/WRQHsukEZ7nzMevMFXsuY8OhpYfxNE1pwq3Gls16C5tzScV9Bp9gjHtt0RQ/wk
         sYyQ==
X-Gm-Message-State: AOAM533FHeMdhLJw31EoD4cX2ivBL1srpuBbDxO8YuM2EJTLggq1LB2J
        5Pq7JXUFwCBbNcbtKPSpNdgt99RgsR6fdA==
X-Google-Smtp-Source: ABdhPJz6CVXoHDhAV9Gyik5pPZg9sjhX0loL8jq9bIV8r8fjCmT8MZhcpEDiC1lO6R2UIgUS5k4BJQ==
X-Received: by 2002:a05:6512:3c87:b0:46c:fde0:5d2e with SMTP id h7-20020a0565123c8700b0046cfde05d2emr1683544lfv.525.1650096073460;
        Sat, 16 Apr 2022 01:01:13 -0700 (PDT)
Received: from mobilestation (ip1.ibrae.ac.ru. [91.238.191.1])
        by smtp.gmail.com with ESMTPSA id t25-20020a19dc19000000b0044a16b068c7sm593375lfg.117.2022.04.16.01.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 01:01:11 -0700 (PDT)
Date:   Sat, 16 Apr 2022 11:01:09 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/16] PCI: dwc: Add more verbose link-up message
Message-ID: <20220416080109.pqnuojor6lewltr3@mobilestation>
References: <20220324013734.18234-1-Sergey.Semin@baikalelectronics.ru>
 <20220324013734.18234-4-Sergey.Semin@baikalelectronics.ru>
 <8569d431ce4e1d64ae271f0498c7a0395d2c5c7e.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8569d431ce4e1d64ae271f0498c7a0395d2c5c7e.camel@perches.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 28, 2022 at 04:31:53PM -0700, Joe Perches wrote:
> On Thu, 2022-03-24 at 04:37 +0300, Serge Semin wrote:
> > Printing just "link up" isn't that much informative especially when it
> > comes to working with the PCI Express bus. Even if the link is up, due to
> > multiple reasons the bus performance can degrade to slower speeds or to
> > narrower width than both Root Port and its partner is capable of. In that
> > case it would be handy to know the link specifications as early as
> > possible. So let's add a more verbose message to the busy-wait link-state
> > method, which will contain the link speed generation and the PCIe bus
> > width in case if the link up state is discovered. Otherwise an error will
> > be printed to the system log.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c | 22 +++++++++++++++-----
> >  1 file changed, 17 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> []
> > @@ -528,14 +528,26 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
> >  
> >  	/* Check if the link is up or not */
> >  	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
> > -		if (dw_pcie_link_up(pci)) {
> > -			dev_info(pci->dev, "Link up\n");
> > -			return 0;
> > -		}
> > +		if (dw_pcie_link_up(pci))
> > +			break;
> > +
> >  		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
> >  	}
> >  
> > -	dev_info(pci->dev, "Phy link never came up\n");
> > +	if (retries < LINK_WAIT_MAX_RETRIES) {
> > +		u32 offset, val;
> > +
> > +		offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> > +		val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
> > +
> > +		dev_info(pci->dev, "PCIe Gen.%u x%u link up\n",
> > +			 FIELD_GET(PCI_EXP_LNKSTA_CLS, val),
> > +			 FIELD_GET(PCI_EXP_LNKSTA_NLW, val));
> > +
> > +		return 0;
> > +	}
> > +
> > +	dev_err(pci->dev, "Phy link never came up\n");
> >  
> >  	return -ETIMEDOUT;
> >  }
> 

> IMO: it's generally bette to test the error condition and unindent
> the typical return.

Absolutely right. Thanks for noticing that. No idea why I haven't done
the way you said 'cause it seems neater, more maintainable than what I
suggested here.

-Sergey

> 
> 	if (retries >= LINK_WAIT_MAX_RETRIES) {
> 		dev_err(pci->dev, "Phy link never came up\n");
> 		return -ETIMEDOUT;
> 	}
> 
> 	offset = ...
> 	val = ...
> 	dev_info(...)
> 
> 	return 0;
> }
> 
