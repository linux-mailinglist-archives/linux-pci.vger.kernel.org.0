Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9027A4367D4
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 18:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbhJUQd4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Oct 2021 12:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJUQd4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Oct 2021 12:33:56 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DB8C0613B9;
        Thu, 21 Oct 2021 09:31:39 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id e5-20020a17090a804500b001a116ad95caso950388pjw.2;
        Thu, 21 Oct 2021 09:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IQdbcLoiSTUVND1y3yU1tj63RV90osj4TBuWtLbjx9w=;
        b=YQjnOjoxdmAAAhECuj0KPEKt27H/wOxmKMev/Jh3JFVzpa0cOV5dXDMot1AjIrEG5o
         wOgYSn95J/UqizuILvkc6+g5OAsT+ytgws2SQSx86fqrfx1zMQ8ub37GSDr+YFHAQWu7
         AiWqL+msiWD7SYSJShRzFd0h2Q5F/ABIdful5MVcYO6wioowEDKbPy6e7Sm+06weThUK
         Xui6felse6F+NGA1x77OkV/oukWj2d4a0wErt7nwUKfhe9DAWWStrAp+/vnrkZACqZG9
         zRSQApaprEZtWr6+t2qcRju9au7ZSuNDzMcfd3rLEbaYobAayt/iGBCC+2VoAJJnu/RG
         t0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IQdbcLoiSTUVND1y3yU1tj63RV90osj4TBuWtLbjx9w=;
        b=DuBO0ru+JFtRft70Awie4GLk7iauwOlujXQGh6b0m5kRSfgxgDk3PbJk/G/yI0e0zV
         fbVlAUs3uGiTFu9H+2KQRgw/yJLGLWOwEcLZvPVPvKYL0yoFGLCasMThMwMkJVzwSQYr
         1SuT6k+wk2+BmLuIstuUiH1taMAG5NpXDdK+HsoTQNz3ly27Rg2v38bTTavLYTnYWFGu
         NX0KLPhZINCUi7qbQuNPyrBa4J7/wtgPLficNmelVU3EZG/TjalkDtyWvW8ztXu0o42z
         cmnJJmKXItEmBMhS8IXXTPuHXk+fmvLdtYjR0O3Ly+1YHCB3Kp3kQTS94QmM7VAyjXOh
         QlEg==
X-Gm-Message-State: AOAM533686LGdN1PdBD4Zz4jgckRHZv4N9yrAeC/72d6hZopKLxWlHF9
        +V4NuTtOgusBwOad4ooIEfE=
X-Google-Smtp-Source: ABdhPJy79KDoQD2rK1TbZ1HD9yKVRke6nSbvrV7cMQ1pA2KVnMKpIrwtRe7TAmT4oeznWwGCwsdqBw==
X-Received: by 2002:a17:90b:4a47:: with SMTP id lb7mr7615497pjb.192.1634833899480;
        Thu, 21 Oct 2021 09:31:39 -0700 (PDT)
Received: from theprophet ([2406:7400:63:29a4:d874:a949:6890:f95f])
        by smtp.gmail.com with ESMTPSA id c9sm5669933pgq.58.2021.10.21.09.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 09:31:39 -0700 (PDT)
Date:   Thu, 21 Oct 2021 22:01:28 +0530
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v4 3/8] PCI/DPC: Initialize info->id in
 dpc_process_error()
Message-ID: <20211021163128.rud3fv3jtnbi3ifp@theprophet>
References: <5ebe87f18339d7567c1d91203e7c5d31f4e65c52.1633453452.git.naveennaidu479@gmail.com>
 <20211021012800.GA2656128@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021012800.GA2656128@bhelgaas>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 20/10, Bjorn Helgaas wrote:
> On Tue, Oct 05, 2021 at 10:48:10PM +0530, Naveen Naidu wrote:
> > In the dpc_process_error() path, info->id isn't initialized before being
> > passed to aer_print_error(). In the corresponding AER path, it is
> > initialized in aer_isr_one_error().
> > 
> > The error message shown during Coverity Scan is:
> > 
> >   Coverity #1461602
> >   CID 1461602 (#1 of 1): Uninitialized scalar variable (UNINIT)
> >   8. uninit_use_in_call: Using uninitialized value info.id when calling aer_print_error.
> > 
> > Initialize the "info->id" before passing it to aer_print_error()
> > 
> > Fixes: 8aefa9b0d910 ("PCI/DPC: Print AER status in DPC event handling")
> > Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
> > ---
> >  drivers/pci/pcie/dpc.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> > index c556e7beafe3..df3f3a10f8bc 100644
> > --- a/drivers/pci/pcie/dpc.c
> > +++ b/drivers/pci/pcie/dpc.c
> > @@ -262,14 +262,14 @@ static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
> >  
> >  void dpc_process_error(struct pci_dev *pdev)
> >  {
> > -	u16 cap = pdev->dpc_cap, status, source, reason, ext_reason;
> > +	u16 cap = pdev->dpc_cap, status, reason, ext_reason;
> >  	struct aer_err_info info;
> >  
> >  	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
> > -	pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID, &source);
> > +	pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID, &info.id);
> >  
> >  	pci_info(pdev, "containment event, status:%#06x source:%#06x\n",
> > -		 status, source);
> > +		 status, info.id);
> >  
> >  	reason = (status & PCI_EXP_DPC_STATUS_TRIGGER_RSN) >> 1;
> 
> Per PCIe r5.0, sec 7.9.15.5, the Source ID is defined only when the
> Trigger Reason indicates ERR_NONFATAL or ERR_FATAL.  So I think we
> need to extract this reason before reading PCI_EXP_DPC_SOURCE_ID,
> e.g.,
> 
>   reason = (status & PCI_EXP_DPC_STATUS_TRIGGER_RSN) >> 1;
>   if (reason == 1 || reason == 2)
>     pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID, &info.id);
>   else
>     info.id = 0;
>

Thank you for the review, I'll make this change when I send a v5 for the
patch series.

> >  	ext_reason = (status & PCI_EXP_DPC_STATUS_TRIGGER_RSN_EXT) >> 5;
> > -- 
> > 2.25.1
> > 
> > _______________________________________________
> > Linux-kernel-mentees mailing list
> > Linux-kernel-mentees@lists.linuxfoundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/linux-kernel-mentees
