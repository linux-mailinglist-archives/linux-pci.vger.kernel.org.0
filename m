Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8DA4DDF9E
	for <lists+linux-pci@lfdr.de>; Fri, 18 Mar 2022 18:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239509AbiCRRJj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Mar 2022 13:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237883AbiCRRJi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Mar 2022 13:09:38 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15211326FA
        for <linux-pci@vger.kernel.org>; Fri, 18 Mar 2022 10:08:20 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id u17so9939895pfk.11
        for <linux-pci@vger.kernel.org>; Fri, 18 Mar 2022 10:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3/c/kx+Yhwa22KJHaZwf6XHEmcwOxk0Z6fD1vF0HOHI=;
        b=AZzmyRMY6nx6YgA/5wXf+2tHdpM8snEhmzOPrL2P/Jws4ZjmzB6ZnUp+ai+V2uiioo
         ZXM0UEwnzF8n1RKTKfrNFHILml6CH4h2iG63n6ifzce5S6pBZ+eNDTwUXMcu/tPoo/P4
         rhOBUJV5OGeoxs7+W/rFxqrx/2wcVv+n0t0Y6EWB/VNaubZhWOHv31IHjYLgHJx40SRT
         s2dMbKJ7rJPm6RXMQEvj9oJ3mSNeGsYy8UR5c+TBrpT/z8zzdtEVpShlcqL9RqZCaXtd
         74Ry3LT/DdAgqsL1nvhWOQm3rgs7iED6KQSjOcQ8L2/7SzkNoq697UurSfIqADV/5EoH
         U5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3/c/kx+Yhwa22KJHaZwf6XHEmcwOxk0Z6fD1vF0HOHI=;
        b=YBgd116kL1T3eOlnIt2ZvLp4Adujm5wVLRDVb5/n0a3xBEOasesXRkSOi2Marb9VOx
         MY/kybvIOxLt4lsjG07tYC14UJOPt8ghDL/SRGsSD04VW3yk9kPELSr1Zf21vGpz06mP
         zBnUa/Q9qqFF5NRzVXGURHs+9RQbS4La3trcu9QOKOcvn25b82bOYNWXZKT6zxnRgCLZ
         LYnrn37gICl2xiQ2rADoBl6NMX1obEAU5EFWwrw6dWxXHbRa8P/qk5R7dKnPmRtgwGlP
         l+2rx12lkIJOnqc+LIXBNDOr6/JBj0057kpNxEG5ksX+Nfa+uGxQusY64f4z0lt4jH2r
         F4MQ==
X-Gm-Message-State: AOAM532ISJxzxfxyVwD5q/e+v9nXNU2V/ZQxF0DkOwFhSIBkqU/NiRWa
        31QAL7wgdZHQrDuBufJWJWhniYipOcvnl0Yh7vMPSTezQAc=
X-Google-Smtp-Source: ABdhPJzIDq43aN8M7LXrco5zu6Fd6XsfVYOjDc6yyAfHXlp7dVuBEzLxcAfW5SEF9hlEO1oHwqKpWaUYKREZuq0sxkM=
X-Received: by 2002:a63:5c53:0:b0:381:309e:e72c with SMTP id
 n19-20020a635c53000000b00381309ee72cmr8655829pgm.40.1647623299445; Fri, 18
 Mar 2022 10:08:19 -0700 (PDT)
MIME-Version: 1.0
References: <164740402242.3912056.8303625392871313860.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164740403796.3912056.13648238900454640514.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220317100947.000060f9@Huawei.com>
In-Reply-To: <20220317100947.000060f9@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 18 Mar 2022 10:08:09 -0700
Message-ID: <CAPcyv4h9e4ON98Vc23fSAZ2f7-vWP1+0Zu6hNvubfcWuY1VbzA@mail.gmail.com>
Subject: Re: [PATCH 3/8] cxl/pci: Kill cxl_map_regs()
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 17, 2022 at 3:10 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue, 15 Mar 2022 21:13:58 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > The component registers are currently unused by the cxl_pci driver.
> > Only the physical address base of the component registers is conveyed to
> > the cxl_mem driver. Just call cxl_map_device_registers() directly.
> >
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Makes sense.   Not sure how we ended up with the unused component register
> handling.  I guess code evolution...

Yeah, this happened when the cxl_port and cxl_mem drivers split the
responsibility of those blocks to downstream drivers.

>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> > ---
> >  drivers/cxl/pci.c |   23 +----------------------
> >  1 file changed, 1 insertion(+), 22 deletions(-)
> >
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 994c79bf6afd..0efbb356cce0 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -346,27 +346,6 @@ static int cxl_probe_regs(struct pci_dev *pdev, struct cxl_register_map *map)
> >       return 0;
> >  }
> >
> > -static int cxl_map_regs(struct cxl_dev_state *cxlds, struct cxl_register_map *map)
> > -{
> > -     struct device *dev = cxlds->dev;
> > -     struct pci_dev *pdev = to_pci_dev(dev);
> > -
> > -     switch (map->reg_type) {
> > -     case CXL_REGLOC_RBI_COMPONENT:
> > -             cxl_map_component_regs(pdev, &cxlds->regs.component, map);
> > -             dev_dbg(dev, "Mapping component registers...\n");
> > -             break;
> > -     case CXL_REGLOC_RBI_MEMDEV:
> > -             cxl_map_device_regs(pdev, &cxlds->regs.device_regs, map);
> > -             dev_dbg(dev, "Probing device registers...\n");
> > -             break;
> > -     default:
> > -             break;
> > -     }
> > -
> > -     return 0;
> > -}
> > -
> >  static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> >                         struct cxl_register_map *map)
> >  {
> > @@ -599,7 +578,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >       if (rc)
> >               return rc;
> >
> > -     rc = cxl_map_regs(cxlds, &map);
> > +     rc = cxl_map_device_regs(pdev, &cxlds->regs.device_regs, &map);
> >       if (rc)
> >               return rc;
> >
> >
> >
>
