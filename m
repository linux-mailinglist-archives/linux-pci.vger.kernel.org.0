Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B80F434BFD
	for <lists+linux-pci@lfdr.de>; Wed, 20 Oct 2021 15:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbhJTN0q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Oct 2021 09:26:46 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:46735 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbhJTN0q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Oct 2021 09:26:46 -0400
Received: by mail-ot1-f49.google.com with SMTP id x27-20020a9d459b000000b0055303520cc4so8158617ote.13;
        Wed, 20 Oct 2021 06:24:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RNWWP9bTOkCgW0tcCeT8WC0sybKGetWwgWvpGMhElmI=;
        b=zMkxnps66cebgIuaa1c8X5LCCkbzZeSCVswtvPshAC1FBrABfrZ9/zHrWFcrkYmelK
         AunibEHExD85LM8ncPEEsN1Ex2CX4KEXgYp5slXP3eZOUOi3Y4K9gfSX1SiNMx+MzOgE
         t+cbk+nuFNwt0yRwGCtB7x94+OzqfgqWejJZDKXWASDo1s/em4VT6i3VHQMinibUCz6j
         0aSp9+9An7FQaFtYZqXK6XT8GgcmFdUQqS5tm766kvhUq8x19qv8eWX1SLpvwZ2Nrwrx
         3HEXcm437ik2tCQVvWe1Kd1bqN0/LEGV3f5vALz4v68b3/cOvxhcYOjNJImjX0MOWxae
         06fw==
X-Gm-Message-State: AOAM532d7FkWB/Qv1WivOmSdlGQnDELSYoqZtPXlV0+ALhvA/5cg1iT5
        ZRgiLGhReEFPHbhJqKuf/vTIy7l5Tg==
X-Google-Smtp-Source: ABdhPJzLB3PDzuaVVTWKIo94MOknTyjcODSHeAoxM/rtWZy+oDjpMr99UBRFJbGqlHrtrpiwAtmyXA==
X-Received: by 2002:a9d:3e5c:: with SMTP id h28mr10960461otg.50.1634736271605;
        Wed, 20 Oct 2021 06:24:31 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id i13sm442681oig.35.2021.10.20.06.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 06:24:30 -0700 (PDT)
Received: (nullmailer pid 2224276 invoked by uid 1000);
        Wed, 20 Oct 2021 13:24:30 -0000
Date:   Wed, 20 Oct 2021 08:24:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Naveen Naidu <naveennaidu479@gmail.com>
Cc:     bhelgaas@google.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/24] PCI: Add PCI_ERROR_RESPONSE and it's related
 definitions
Message-ID: <YXAYjkLyS53Bod3j@robh.at.kernel.org>
References: <cover.1634306198.git.naveennaidu479@gmail.com>
 <4516b02d3c0fe3593a1a9f59bab47e99cdb65f02.1634306198.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4516b02d3c0fe3593a1a9f59bab47e99cdb65f02.1634306198.git.naveennaidu479@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 15, 2021 at 07:58:16PM +0530, Naveen Naidu wrote:
> An MMIO read from a PCI device that doesn't exist or doesn't respond
> causes a PCI error.  There's no real data to return to satisfy the
> CPU read, so most hardware fabricates ~0 data.
> 
> Add a PCI_ERROR_RESPONSE definition for that and use it where
> appropriate to make these checks consistent and easier to find.
> 
> Also add helper definitions SET_PCI_ERROR_RESPONSE and
> RESPONSE_IS_PCI_ERROR to make the code more readable.
> 
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
> ---
>  include/linux/pci.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index cd8aa6fce204..928c589bb5c4 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -154,6 +154,15 @@ enum pci_interrupt_pin {
>  /* The number of legacy PCI INTx interrupts */
>  #define PCI_NUM_INTX	4
>  
> +/*
> + * Reading from a device that doesn't respond typically returns ~0.  A
> + * successful read from a device may also return ~0, so you need additional
> + * information to reliably identify errors.
> + */
> +#define PCI_ERROR_RESPONSE			(~0ULL)
> +#define SET_PCI_ERROR_RESPONSE(val)	(*val = ((typeof(*val)) PCI_ERROR_RESPONSE))
> +#define RESPONSE_IS_PCI_ERROR(val)	(*val == ((typeof(*val)) PCI_ERROR_RESPONSE))

No reason for val to be a pointer.

Also, macro parameters need () around them. val could be an expression 
like 'ptr + 1' which would blow up for example.

> +
>  /*
>   * pci_power_t values must match the bits in the Capabilities PME_Support
>   * and Control/Status PowerState fields in the Power Management capability.
> -- 
> 2.25.1
> 
> 
