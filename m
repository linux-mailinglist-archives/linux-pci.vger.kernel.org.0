Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E6255F315
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 04:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiF2CDM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 22:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiF2CDL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 22:03:11 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829CD62E2;
        Tue, 28 Jun 2022 19:03:09 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id bx13so8467871ljb.1;
        Tue, 28 Jun 2022 19:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ExQ+cUMd6CKqjpDycA1VWArMZGHVO2kBf1mIyUSWUMI=;
        b=PT+1enTwylQGJttgLNm/f+y6PAAMxPLFoJ1bLOMr3qqI4ehPAJREIYE5NU8jIDhouR
         blRn2vppeXauVZ2BUvRg3gJzOr0ig1+ZXp7eVHsVUL5oEXxCaGOAyG0V+bupXo+kxqG4
         XZSupZY80F05DJ05xU6DjnrfhH+LvgfwnxR/reYQLC8KCMrmczzUuAbQ6nmKPXfCpN0j
         lpZXPPMAafRyHbCR3NDNwCCVas6PwiwrJ3n9yXR942PdJIZmGnd93Kvr8FZgaWhbR/cz
         MVkFy0ZcRj0Ky+IT/o4nQImqGf5oomlJv2fqfWbgeBKi774voWNQ1l8tN5yRIRbmAswi
         3PHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ExQ+cUMd6CKqjpDycA1VWArMZGHVO2kBf1mIyUSWUMI=;
        b=oOQdAzkwz/1BmWsfXBTusu5JiZwPGSOSw1ulgOX6/YlLM1pt/HcMrw4jGHpMawpK/d
         7YLLwCSCsCF9BeljUObv2m3HVJSsFVVDJl2ZJ3xloy1oba14+dnWys7D9FC8iQA7LWiq
         lpN+tJrmYZR8kV7JJnldQOdLOj4uR6hbDdPj75k9bHu6W8kPer24ty2GRmEdFhFMrSSG
         cEsYZlNhr2A6qbollLJP7zm/WahW2z8HY8M5F8Kf9OAru1eIZpT4v9y5GUlKJQuobsf4
         IjaFKgMOt6TVyRaslbd9QUtecbTNs6uVR7P9mZmztiDE19c2nQ6ADuiU7yAV1hRi/H5g
         nM2g==
X-Gm-Message-State: AJIora/UMrxCHDha5Gj2siKObFgxXVbPR3y3j0T6JFVX5g5OWUkvFSot
        06XpgJXPNfW07rczt5F71wtBMhgE5rK7ew==
X-Google-Smtp-Source: AGRyM1tZFTVZHjJqttARLkObnCqgS1L27IoScDHQowiwij0Z6kABr9KhfJ75bKeAppYfU99m1gaN/A==
X-Received: by 2002:a2e:aa0e:0:b0:25a:891f:d9bb with SMTP id bf14-20020a2eaa0e000000b0025a891fd9bbmr400225ljb.343.1656468187927;
        Tue, 28 Jun 2022 19:03:07 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id v8-20020ac258e8000000b0047f6d20e424sm2408218lfo.55.2022.06.28.19.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 19:03:07 -0700 (PDT)
Date:   Wed, 29 Jun 2022 05:03:05 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v5 11/18] PCI: dwc: Organize local variables usage
Message-ID: <20220629020305.wspbv6fhluoyklum@mobilestation>
References: <20220624143428.8334-12-Sergey.Semin@baikalelectronics.ru>
 <20220628233327.GA1879296@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220628233327.GA1879296@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 28, 2022 at 06:33:27PM -0500, Bjorn Helgaas wrote:
> On Fri, Jun 24, 2022 at 05:34:21PM +0300, Serge Semin wrote:
> > There are several places in the common DW PCIe code with incoherent local
> > variables usage: a variable is defined and initialized with a structure
> > field, but the structure pointer is de-referenced to access that field
> > anyway; the local variable is defined and initialized but either used just
> > once or not used afterwards in the main part of the subsequent method.
> > It's mainly concerns the pcie_port.dev field. Let's fix that in the
> > relevant places.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > 
> > ---
> > 
> > Changelog v4:
> > - This is a new patch created on the v4 lap of the series.
> > ---
> >  drivers/pci/controller/dwc/pcie-designware-host.c | 12 ++++++------
> >  drivers/pci/controller/dwc/pcie-designware.c      |  8 +++-----
> >  2 files changed, 9 insertions(+), 11 deletions(-)
> 
> > @@ -633,7 +633,7 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
> >  		}
> >  
> >  		if (pci->num_ob_windows <= atu_idx)
> > -			dev_warn(pci->dev, "Resources exceed number of ATU entries (%d)\n",
> > +			dev_warn(dev, "Resources exceed number of ATU entries (%d)\n",
> 

> I dropped this hunk because of this:
> 
>   drivers/pci/controller/dwc/pcie-designware-host.c:634:13: error: ‘dev’ undeclared (first use in this function); did you mean ‘cdev’?
>     634 |    dev_warn(dev, "Resources exceed number of ATU entries (%d)\n",
> 

Right. It must have been fixed by the auto-merging procedure of my
local working git-dir. Thanks.

-Sergey

> >  				 pci->num_ob_windows);
> >  	}
> >  
