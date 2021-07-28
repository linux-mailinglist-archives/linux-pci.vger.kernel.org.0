Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2F73D945D
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jul 2021 19:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbhG1RfW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jul 2021 13:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhG1RfW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Jul 2021 13:35:22 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C44C061757;
        Wed, 28 Jul 2021 10:35:19 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id ca5so6214428pjb.5;
        Wed, 28 Jul 2021 10:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3PzlsUS0qKWXyNmKIehGk56GXadOKQkGPpY5nA01M/I=;
        b=UwXvtSjRMoZIbi3eoNKm/tPsmFZ+JpRfMx5b+4rKRH4Ia2lLUf8wHGodjcMziHB+3g
         lEnzwX4Ndn0Ywzg4RVBd1PuH0fc0VQ3gLXt1UfYdRt1JV0YkVziGRS5/cS3AYrTX6Cls
         3Gdda5h+6rsdjMwnuytW3VCJMKNC4vnMnbS9ChrB7qfbuRf73PX6HNcDSfVc7E5c1zQF
         9uhIcHwBvfCEwDSj676Gl0Xoujvaq1UTNNXtl993bViGjYpP8rkcdqxhh/C7j2JsBdmv
         4fTLMp9U9eNTdiS6hqDjhgeevGdWeEnORPP4s1qZ7DMErEg8htSOW94RcFTpco8MITu+
         Rjyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3PzlsUS0qKWXyNmKIehGk56GXadOKQkGPpY5nA01M/I=;
        b=RffxUnVdLPmtv5MV1xrC+ofqvbeX834hzNuHUbllYhL18zseZGLc3vPUYGqFfWH4AI
         Oa/wzVLAOb1rwZ/4SMGbygZVXhkHWS8Y4TueMfKk5jx6W6h7A3TjeFTWK0ywn3EhQp/t
         MxTKkPJWzpiICMiT/fDhNHW+iEc7DZ4dgq2oMzBh9lxDJ6Eskr1WlI9XtDSDgvhnzZeQ
         jrrzRnBHpwj8TbkJXisLJrRdhvC6N7Hu/2JBTHHopr1AH8kXJGfTiGj8O+mNIOfK3I2v
         7u4VgVuKnwi22INwtng1Q8952HT/UL+dm8dIfmQopt6PE1DLk31yg2PygSr3vZZvASjl
         x30Q==
X-Gm-Message-State: AOAM530oQ3dBcCmEMhQug9G5+zEClGs+nIWNLRPZtHQjHD73yM02zLCV
        Ec+PwWjEfo0YelZcc5OppjI=
X-Google-Smtp-Source: ABdhPJxOEwT+loZNOJgRL23B6PkDaDEGYi2cDA47+4M+bsFE6K5S4GZj5+TYsC60xeAwTPRRQVnu7g==
X-Received: by 2002:a17:90b:1896:: with SMTP id mn22mr840485pjb.148.1627493718316;
        Wed, 28 Jul 2021 10:35:18 -0700 (PDT)
Received: from localhost ([49.32.196.184])
        by smtp.gmail.com with ESMTPSA id p17sm6649958pjz.16.2021.07.28.10.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 10:35:17 -0700 (PDT)
Date:   Wed, 28 Jul 2021 23:05:14 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v10 8/8] PCI: Change the type of probe argument in reset
 functions
Message-ID: <20210728173514.77yiv2vjvjpf6ao5@archlinux>
References: <20210709123813.8700-9-ameynarkhede03@gmail.com>
 <20210727222255.GA751984@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210727222255.GA751984@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/07/27 05:22PM, Bjorn Helgaas wrote:
> On Fri, Jul 09, 2021 at 06:08:13PM +0530, Amey Narkhede wrote:
> > Introduce a new enum pci_reset_mode_t to make the context of probe argument
> > in reset functions clear and the code easier to read.  Change the type of
> > probe argument in functions which implement reset methods from int to
> > pci_reset_mode_t to make the intent clear.
>
> Not sure adding an enum and a PCI_RESET_MODE_MAX seems worth it to me.
> It's really a boolean parameter, and I'd be happy to change it to a
> bool.  But I don't think it's worth checking against
> PCI_RESET_MODE_MAX unless we need more than two options.
>
Is it okay to use PCI_RESET_PROBE and PCI_RESET_DO_RESET as bool.
That would be less confusing than directly using true/false.

Thanks,
Amey

> > Add a new line in return statement of pci_reset_bus_function().
>
> Drop this line, since I don't think it's correct and there's no need
> to describe whitespace changes anyway.
>
> > Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> > Suggested-by: Krzysztof Wilczyński <kw@linux.com>
> > Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
>
> > @@ -306,7 +306,7 @@ static int nitrox_device_flr(struct pci_dev *pdev)
> >  		return -ENOMEM;
> >  	}
> >
> > -	pcie_reset_flr(pdev, 0);
> > +	pcie_reset_flr(pdev, PCI_RESET_DO_RESET);
> >
> >  	pci_restore_state(pdev);
> >
>
> > @@ -526,7 +526,7 @@ static void octeon_destroy_resources(struct octeon_device *oct)
> >  			oct->irq_name_storage = NULL;
> >  		}
> >  		/* Soft reset the octeon device before exiting */
> > -		if (!pcie_reset_flr(oct->pci_dev, 1))
> > +		if (!pcie_reset_flr(oct->pci_dev, PCI_RESET_PROBE))
> >  			octeon_pci_flr(oct);
> >  		else
> >  			cn23xx_vf_ask_pf_to_do_flr(oct);
>
> > +typedef enum pci_reset_mode {
> > +	PCI_RESET_DO_RESET,
> > +	PCI_RESET_PROBE,
> > +	PCI_RESET_MODE_MAX,
> > +} pci_reset_mode_t;
