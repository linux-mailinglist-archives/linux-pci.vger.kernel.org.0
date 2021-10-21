Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D564367FB
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 18:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbhJUQil (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Oct 2021 12:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhJUQij (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Oct 2021 12:38:39 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF30FC061764;
        Thu, 21 Oct 2021 09:36:23 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id v8so1104521pfu.11;
        Thu, 21 Oct 2021 09:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XNFBhpllu7nc0pkg33R5r5Fh+arwoYW9tTFMhQ1Vz/c=;
        b=eJoLRrDvU48OXdI618MEts9VQqMnTVB76rawrzqlvVDGPfrCSgIUDwEHOZ8QSxSWIv
         EaszjXlmCqa2H6DXfha+r226SxX5gFyR4qsqJB2WbKTaWkgnInRYHF64yFqPI2MzbmEI
         5W/n9GwIZmwg/eX2+cTXZCaCPtxIFHfxXxW9EDzgz9bWQ1EXXQK7TinoCr6eLWih3WPC
         lCbeVXY+rpVEt05S2vw3tSradrUM2PvQ0HGno8RAktXq9EKUyJ2rY41VedAVdueoZNFC
         9/a5Zlzv7pGcEYfJNEBoKGvGEyRyQ/briuUYMqUPB6glvIXjqzzKXbXAAJoNvmZm23no
         y8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XNFBhpllu7nc0pkg33R5r5Fh+arwoYW9tTFMhQ1Vz/c=;
        b=EJobdkEKfGy3qIuRxGlZ7yTl7ksJYTNd5e3rdvU546iibBnts8Wm1jn7SwWc8soVXc
         SAG3vgFBu2OZwgaMksebQ2v23EB8PTU0HAQx7O77MSNIPNLLNwMUxyAhBgzoQgCl5PMp
         6nxRQHRsrXhxXOJW8WYv1Shv0IENkjymlHPQYirUAPRs8fUBrbjNvpRc+lNAcNLj8P1b
         KJYaZtOclHKdoG/wv5tBJbXN5hvBLQv++y+9YcXpa6wY0qQaGDs+GPevWdmMFF3GeENS
         oGMuOdx8RVsmbqBwugiGI1B3arydlsk8xV7cX+ysqtj48pmfNhxPDpOAIOe8w6cK6KWT
         8hWA==
X-Gm-Message-State: AOAM532AFrtjc7QmZ7HosvVRFOacV/Uu/Vn/X7PcFZrZ48nvy3v4uhq/
        CQA4t26QAYnN+NZL9HXKq6o=
X-Google-Smtp-Source: ABdhPJzfdFTwCbjg+oVZZtmNG4pN1rAlF1kcmD/+Gu6plGnZ8j/KLnhiiXFySrksPZ8TcD1MU9P6vg==
X-Received: by 2002:aa7:8609:0:b0:44b:346a:7404 with SMTP id p9-20020aa78609000000b0044b346a7404mr6653842pfn.86.1634834183113;
        Thu, 21 Oct 2021 09:36:23 -0700 (PDT)
Received: from theprophet ([2406:7400:63:29a4:d874:a949:6890:f95f])
        by smtp.gmail.com with ESMTPSA id m186sm6769249pfb.165.2021.10.21.09.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 09:36:22 -0700 (PDT)
Date:   Thu, 21 Oct 2021 22:06:11 +0530
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v4 4/8] PCI/DPC: Use pci_aer_clear_status() in
 dpc_process_error()
Message-ID: <20211021163611.rsfmberxw6dqn5gx@theprophet>
References: <f0d301cb1245a8e2fd9565426b87c22a97aa6de7.1633453452.git.naveennaidu479@gmail.com>
 <20211021014029.GA2657684@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021014029.GA2657684@bhelgaas>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 20/10, Bjorn Helgaas wrote:
> On Tue, Oct 05, 2021 at 10:48:11PM +0530, Naveen Naidu wrote:
> > dpc_process_error() clears both AER fatal and non fatal status
> > registers. Instead of clearing each status registers via a different
> > function call use pci_aer_clear_status().
> > 
> > This helps clean up the code a bit.
> > 
> > Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
> > ---
> >  drivers/pci/pcie/dpc.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> > index df3f3a10f8bc..faf4a1e77fab 100644
> > --- a/drivers/pci/pcie/dpc.c
> > +++ b/drivers/pci/pcie/dpc.c
> > @@ -288,8 +288,7 @@ void dpc_process_error(struct pci_dev *pdev)
> >  		 dpc_get_aer_uncorrect_severity(pdev, &info) &&
> >  		 aer_get_device_error_info(pdev, &info)) {
> >  		aer_print_error(pdev, &info);
> > -		pci_aer_clear_nonfatal_status(pdev);
> > -		pci_aer_clear_fatal_status(pdev);
> > +		pci_aer_clear_status(pdev);
> 
> The commit log suggests that this is a simple cleanup that doesn't
> change any behavior, but that's not quite true:
> 
>   - The new code would clear PCI_ERR_ROOT_STATUS, but the old code
>     does not.
> 
>   - The old code masks the status bits with the severity bits before
>     clearing, but the new code does not.
> 
> The commit log needs to show why these changes are what we want.
>

Reading through the code again, I realize how wrong(stupid) I was when
making this patch. I was thinking that:

  pci_aer_clear_status() = pci_aer_clear_fatal_status() + pci_aer_clear_nonfatal_status()

Now I understand, that it is not at all the case. I apologize for the
mistake. I'll make sure to be meticulous while reading functions and not
just assume their behaviour just from their function names.

I'll drop this patch in the next version of the patch series I make.

Apologies again ^^'

> >  	}
> >  }
> >  
> > -- 
> > 2.25.1
> > 
> > _______________________________________________
> > Linux-kernel-mentees mailing list
> > Linux-kernel-mentees@lists.linuxfoundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/linux-kernel-mentees
