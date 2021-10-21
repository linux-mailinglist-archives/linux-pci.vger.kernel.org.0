Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5ED9436865
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 18:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbhJUQz7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Oct 2021 12:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbhJUQz7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Oct 2021 12:55:59 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15646C061764;
        Thu, 21 Oct 2021 09:53:43 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id j190so903839pgd.0;
        Thu, 21 Oct 2021 09:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OlNOkFhzU3j5XM9ZPcyVDkeJMjH142Uqr0gwlxi3bRA=;
        b=F5RVO766FluIl4AToZJDQXmFsz16TOfeR7UbrhvTAIJUkO7hxlIfOQUoMjb75kUCJF
         MVbV3rFlfwOn1fWzB0kel2RZgGB/ug+w5h+EIcUOPxTxWZ6XhPPcT1fUzRqdTP0sc3YH
         pa7f0k1fokCzZ2ATX4pPZcjGocYjRUCljb0rUvMrEEP8CTZZalHAsXJDfsPhKUaWF74f
         U/m1gMCbv69Ob6kvEGgWZg/gweXrLoUpz06n9Y/VbKNdLNh3WueHuiokW2ubnPnkiyem
         AoyYHComkiqxLJRMIz0fXglYOOTvJArUNTKaoNTd2PWGFggTyJ0Iq1UVo3kqPVowRlMS
         Sing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OlNOkFhzU3j5XM9ZPcyVDkeJMjH142Uqr0gwlxi3bRA=;
        b=yTEsW9X+O5Hx2jPib44Sr3f5FiaVoBdZE18JfZIGqgUiUkjrTOzGzQdMfZVDgczB8i
         yzM19z0ftelBHfH2Xqk5WJpsWQgQDb20eEV8DFfAgNgHrM8HArTCc/frONz6JyPuZ8k/
         hKoEJ11ONeIUqs/PKvlgNF4QPC30Vam7HbX8FrOVpYj0leVA3aTtfL7f0gvZOmle+Kkv
         M2dj8Vnwj3bmvjiEaCT8j8dxj72H7L2YBY89NS+1U+gz4rdBYAu9veL/sD/dE1i/EQYW
         K+SyYKKsM1xsW5pQ0t/MSdWCGEagz86SNdSrgrAy1gxxtcsX+BCIwHUH53dmEBO28FNX
         D2JA==
X-Gm-Message-State: AOAM532cmCOukPEfByKDumeGUQ+KZywefz06UqfXUC4024wbAP7JZqQy
        +3WWmmf7AK2khPIl92cV1TA=
X-Google-Smtp-Source: ABdhPJzmj35HHVG/6CI1U59JcAVVWqK32Kb2AQrdfLKvvjhRvJ2S69LK41LYA5SFNSc3yXRLlJ4kTQ==
X-Received: by 2002:a63:b007:: with SMTP id h7mr5193594pgf.443.1634835222405;
        Thu, 21 Oct 2021 09:53:42 -0700 (PDT)
Received: from theprophet ([2406:7400:63:29a4:d874:a949:6890:f95f])
        by smtp.gmail.com with ESMTPSA id r31sm10005050pjg.28.2021.10.21.09.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 09:53:41 -0700 (PDT)
Date:   Thu, 21 Oct 2021 22:23:30 +0530
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Keith Busch <kbusch@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>
Subject: Re: [PATCH v4 5/8] PCI/DPC: Converge EDR and DPC Path of clearing
 AER registers
Message-ID: <20211021165330.lcqajtwej4s7oadt@theprophet>
References: <0a443323ab64ba8c0fc6caa03ca56ecd4d038ea3.1633453452.git.naveennaidu479@gmail.com>
 <20211021020934.GA2658296@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021020934.GA2658296@bhelgaas>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 20/10, Bjorn Helgaas wrote:
> [+cc Keith, Sinan, Oza]
> 
> On Tue, Oct 05, 2021 at 10:48:12PM +0530, Naveen Naidu wrote:
> > In the EDR path, AER registers are cleared *after* DPC error event is
> > processed. The process stack in EDR is:
> > 
> >   edr_handle_event()
> >     dpc_process_error()
> >     pci_aer_raw_clear_status()
> >     pcie_do_recovery()
> > 
> > But in DPC path, AER status registers are cleared *while* processing
> > the error. The process stack in DPC is:
> > 
> >   dpc_handler()
> >     dpc_process_error()
> >       pci_aer_clear_status()
> >     pcie_do_recovery()
> 
> These are accurate but they both include dpc_process_error(), so we
> need a hint to show why the one here is different from the one in the
> EDR path, e.g.,
> 
>   dpc_handler
>     dpc_process_error
>       if (reason == 0)
>         pci_aer_clear_status    # uncorrectable errors only
>     pcie_do_recovery
> 
> > In EDR path, AER status registers are cleared irrespective of whether
> > the error was an RP PIO or unmasked uncorrectable error. But in DPC, the
> > AER status registers are cleared only when it's an unmasked uncorrectable
> > error.
> > 
> > This leads to two different behaviours for the same task (handling of
> > DPC errors) in FFS systems and when native OS has control.
> 
> FFS?
>

Firmware First Systems

> I'd really like to have a specific example of how a user would observe
> this difference.  I know you probably don't have two systems to
> compare like that, but maybe we can work it out manually.
> 

Apologies again! Reading through the code again and the specification, I
realize that my understanding was very incorrect at the time of making
this patch. I grossly oversimplified EDR and DPC when I was learning
about it.

I'll drop this patch when I send the v5 for the series.

Apologies again ^^'

> I guess you're saying the problem is in the native DPC handling, and
> we don't clear the AER status registers for ERR_NONFATAL,
> ERR_NONFATAL, etc., right?
> 

But yes, I did have this question though (I wasn't able to find the
answers to it when reading the spec). Why do we not clear the entire
ERR_NONFATAL and ERR_FATAL registers in the DPC path just like EDR does
using the pci_aer_raw_clear_status() before going to pcie_do_recovery()

I am sure I might have missed something in the spec. I guess I'll
look/re-read these bits again.

Thanks for the review :)

> I think the current behavior is from 8aefa9b0d910 ("PCI/DPC: Print AER
> status in DPC event handling"), where Keith explicitly mentions those
> cases.  The commit log here should connect back to that and explain
> whether something has changed.
> 
> I cc'd Keith and the reviewers of that change in case any of them have
> time to dig into this again.
> 
> > Bring the same semantics for clearing the AER status register in EDR
> > path and DPC path.
> > 
> > Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
> > ---
> >  drivers/pci/pcie/dpc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> > index faf4a1e77fab..68899a3db126 100644
> > --- a/drivers/pci/pcie/dpc.c
> > +++ b/drivers/pci/pcie/dpc.c
> > @@ -288,7 +288,6 @@ void dpc_process_error(struct pci_dev *pdev)
> >  		 dpc_get_aer_uncorrect_severity(pdev, &info) &&
> >  		 aer_get_device_error_info(pdev, &info)) {
> >  		aer_print_error(pdev, &info);
> > -		pci_aer_clear_status(pdev);
> >  	}
> >  }
> >  
> > @@ -297,6 +296,7 @@ static irqreturn_t dpc_handler(int irq, void *context)
> >  	struct pci_dev *pdev = context;
> >  
> >  	dpc_process_error(pdev);
> > +	pci_aer_clear_status(pdev);
> >  
> >  	/* We configure DPC so it only triggers on ERR_FATAL */
> >  	pcie_do_recovery(pdev, pci_channel_io_frozen, dpc_reset_link);
> > -- 
> > 2.25.1
> > 
> > _______________________________________________
> > Linux-kernel-mentees mailing list
> > Linux-kernel-mentees@lists.linuxfoundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/linux-kernel-mentees
