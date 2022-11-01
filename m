Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BEE61460F
	for <lists+linux-pci@lfdr.de>; Tue,  1 Nov 2022 09:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiKAIzK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Nov 2022 04:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiKAIzJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2022 04:55:09 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9BB17E26
        for <linux-pci@vger.kernel.org>; Tue,  1 Nov 2022 01:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1667292907; x=1698828907;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K+x2Ofw5qdZUuBP0BAOiF748sLcTlo52/7bG8uS2Gcw=;
  b=KiCfWYyRgbPcA6RGL+36D253x8g3se9cATJH2hVL35UvfuDF8JRpSdCM
   ZcB+kXEjG3gzPCyI+6I+Dj8A4oYFJ7mHttYG5B5gpscxXR8WFYTm2hsqF
   fWLHaZIH1tnRcTeS3yU+fWH9jbarZOyIH8iHX+ZiJkk2Sj4QNoWmZoF/m
   C/n70LD7i5L5hMUbZzzOADaWQR2uQzJgtY8j9+ObACZ1v0qVJXyuksJHg
   KHUK6b8iekiRDgCU72oX6lYx3PKYENJCEFmgScpkLR+XyCveouA21wbS4
   DFKoScCOztkqV3h0jIYH4Yl9SeoRMl03XykOkP9acTNMsSaXLprvwndcY
   A==;
X-IronPort-AV: E=Sophos;i="5.95,230,1661810400"; 
   d="scan'208";a="27083240"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 01 Nov 2022 09:55:05 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 01 Nov 2022 09:55:05 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 01 Nov 2022 09:55:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1667292905; x=1698828905;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject;
  bh=K+x2Ofw5qdZUuBP0BAOiF748sLcTlo52/7bG8uS2Gcw=;
  b=TdIsQVuz/KkkvLh9cLdEYW6i979A2h1TJwUugwSDyL8OBIsH+BeVcr5h
   kFFMI4wEcTAYiajuj/HQjHCZttH8Aa8/mQq/eWN1SLfSXbR/BnUZz7vYt
   7WC4tEXIxgTohP6jAzrOn71d+Bm5zB4J2lzRNqbLu+j7Kn2kDxrrmxagK
   PeZdHs6UduAAc4XOAklpDpLGffazCT7H75IfvxUWnyBzOvCgRiYUfw/eB
   Yd5GoZqkZNxFoRK9zvPYNampOsw/aZbI181foxuV3MDr5KNGAq5q5vn7o
   w/4c7GhaE2n34Y2zHeRXddWskX5pSQUOj9zKbR13Fa0l8VDONl4dFpbsf
   A==;
X-IronPort-AV: E=Sophos;i="5.95,230,1661810400"; 
   d="scan'208";a="27083239"
Subject: Re: Re: [PATCH 1/1] PCI: dwc: reduce log severity level if no link came up
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 01 Nov 2022 09:55:05 +0100
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 125FC280056;
        Tue,  1 Nov 2022 09:55:04 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-pci@vger.kernel.org
Date:   Tue, 01 Nov 2022 09:55:03 +0100
Message-ID: <5874911.lOV4Wx5bFT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <41c536dd-99c4-9fa5-39cc-2aea5b5e015b@nvidia.com>
References: <20221101081844.265264-1-alexander.stein@ew.tq-group.com> <41c536dd-99c4-9fa5-39cc-2aea5b5e015b@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Vidya,

Am Dienstag, 1. November 2022, 09:27:50 CET schrieb Vidya Sagar:
> Hi Alexander,
> Thanks for the patch, but, we already have a patch for it here
> 
> https://patchwork.kernel.org/project/linux-pci/patch/20220913101237.4337-1-v
> idyas@nvidia.com/
> 
> and discussion is going on there.

Ah, I wasn't aware of that. Thanks for the link and sorry for the noise.

Thanks,
Alexander

> Thanks,
> Vidya Sagar
> 
> On 11/1/2022 1:48 PM, Alexander Stein wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > Commit 14c4ad125cf9 ("PCI: dwc: Log link speed and width if it comes up")
> > changed the severity from info to error. If no device is attached this
> > error always is recorded which is not an error in this case.
> > 
> > Fixes: 14c4ad125cf9 ("PCI: dwc: Log link speed and width if it comes up")
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > ---
> > 
> >   drivers/pci/controller/dwc/pcie-designware.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c
> > b/drivers/pci/controller/dwc/pcie-designware.c index
> > 9e4d96e5a3f5a..432aead68d1fd 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -448,7 +448,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
> > 
> >          }
> >          
> >          if (retries >= LINK_WAIT_MAX_RETRIES) {
> > 
> > -               dev_err(pci->dev, "Phy link never came up\n");
> > +               dev_info(pci->dev, "Phy link never came up\n");
> > 
> >                  return -ETIMEDOUT;
> >          
> >          }
> > 
> > --
> > 2.34.1




