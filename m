Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD24570DC6
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jul 2022 01:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbiGKXCR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jul 2022 19:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbiGKXCQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jul 2022 19:02:16 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D821774E3C
        for <linux-pci@vger.kernel.org>; Mon, 11 Jul 2022 16:02:13 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id j3so5996700pfb.6
        for <linux-pci@vger.kernel.org>; Mon, 11 Jul 2022 16:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zQXYkIpLa/jRv8ngkizdneaBLdDBpj/gCgWHugoncaE=;
        b=X/5PcPYqGqKuus1jat1z2VDjmGnFRlWFHPH2K9MAZocdY+pZKAu34y993HN6SNVKmS
         cDtn7l1Vyb7XKJpemTGBWS9vphxKWpKMdthKiM0nSLVjl9DPUQq7HKuRKW3b3nLFnjU8
         SBP0182OirwDB7BgZls6GFj1KXOhaFARIykUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zQXYkIpLa/jRv8ngkizdneaBLdDBpj/gCgWHugoncaE=;
        b=8Nz/UvGgeBUuowOX3yF/JoyE6kmmDA5CcRYM4Px9uz/yjvbZY2NL9xUAjdXAfVofy4
         XeVtceJtzq9HLbsGYbXXK0rs0wdJuC0fGG+LbnkDpibKm2TLX0yDhVW00uE6y28akkCo
         rNGRiBP4lY2IsP2TRihfqCYGQH63glfp0SiGXd9Z87oJcYpJDuK2G0YjAZE2K3QSsLTo
         qKS01xrtflCGHk+5caiSR6TFKYbUiYBZC3ACHriZdmsIE8MZIVNolLZMfEiwYoFhGT3v
         0BDTNdzPNkrrVb4PieH5H8FuXloM9t0Bi2CMap+fZTCukWMD9YfqDO8SJVIB1dWUjO6p
         Xrgw==
X-Gm-Message-State: AJIora+cjqP9L4KNx0N5gFMtKKE+recOW4Qeou2rSbC0PBqcPrW2HvL0
        hYAbV8yJEEWmQfgORCjQ2HYMyw==
X-Google-Smtp-Source: AGRyM1vd+YT28J4QtbEwB9SqrDW2ijRXinz1/hQByXl8qLxAh5tbMVtL1AGh7dMFvZN0PHy8+1tZ0g==
X-Received: by 2002:a65:49c5:0:b0:412:6e3e:bd91 with SMTP id t5-20020a6549c5000000b004126e3ebd91mr18068217pgs.221.1657580533320;
        Mon, 11 Jul 2022 16:02:13 -0700 (PDT)
Received: from medusa.lab.kspace.sh (c-98-207-191-243.hsd1.ca.comcast.net. [98.207.191.243])
        by smtp.googlemail.com with ESMTPSA id y15-20020a655b0f000000b0040d75537824sm4735325pgq.86.2022.07.11.16.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 16:02:12 -0700 (PDT)
Date:   Mon, 11 Jul 2022 16:02:11 -0700
From:   Mohamed Khalfella <mkhalfella@purestorage.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     stable@vger.kernel.org, Meeta Saggi <msaggi@purestorage.com>,
        Eric Badger <ebadger@purestorage.com>,
        Russell Currey <ruscur@russell.cc>,
        Oliver O'Halloran <oohall@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI ENHANCED ERROR HANDLING (EEH) FOR POWERPC" 
        <linuxppc-dev@lists.ozlabs.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI/AER: Iterate over error counters instead of error
 strings
Message-ID: <20220711230211.GD3182270@medusa>
References: <20220509181441.31884-1-mkhalfella@purestorage.com>
 <20220711225437.GA703490@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711225437.GA703490@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022-07-11 17:54:37 -0500, Bjorn Helgaas wrote:
> On Mon, May 09, 2022 at 06:14:41PM +0000, Mohamed Khalfella wrote:
> > PCI AER stats counters sysfs attributes need to iterate over
> > stats counters instead of stats names. Also, added a build
> > time check to make sure all counters have entries in strings
> > array.
> > 
> > Fixes: 0678e3109a3c ("PCI/AER: Simplify __aer_print_error()")
> > Cc: stable@vger.kernel.org
> > Reported-by: Meeta Saggi <msaggi@purestorage.com>
> > Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> > Reviewed-by: Meeta Saggi <msaggi@purestorage.com>
> > Reviewed-by: Eric Badger <ebadger@purestorage.com>
> 
> I added some info about why we need this to the commit log and applied
> to pci/err for v5.20.  Thank you!
That is good news! Thank you for helping out.
> 
> > ---
> >  drivers/pci/pcie/aer.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index 9fa1f97e5b27..ce99a6d44786 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -533,7 +533,7 @@ static const char *aer_agent_string[] = {
> >  	u64 *stats = pdev->aer_stats->stats_array;			\
> >  	size_t len = 0;							\
> >  									\
> > -	for (i = 0; i < ARRAY_SIZE(strings_array); i++) {		\
> > +	for (i = 0; i < ARRAY_SIZE(pdev->aer_stats->stats_array); i++) {\
> >  		if (strings_array[i])					\
> >  			len += sysfs_emit_at(buf, len, "%s %llu\n",	\
> >  					     strings_array[i],		\
> > @@ -1342,6 +1342,11 @@ static int aer_probe(struct pcie_device *dev)
> >  	struct device *device = &dev->device;
> >  	struct pci_dev *port = dev->port;
> >  
> > +	BUILD_BUG_ON(ARRAY_SIZE(aer_correctable_error_string) <
> > +		     AER_MAX_TYPEOF_COR_ERRS);
> > +	BUILD_BUG_ON(ARRAY_SIZE(aer_uncorrectable_error_string) <
> > +		     AER_MAX_TYPEOF_UNCOR_ERRS);
> > +
> >  	/* Limit to Root Ports or Root Complex Event Collectors */
> >  	if ((pci_pcie_type(port) != PCI_EXP_TYPE_RC_EC) &&
> >  	    (pci_pcie_type(port) != PCI_EXP_TYPE_ROOT_PORT))
> > -- 
> > 2.29.0
> > 
