Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F22429950
	for <lists+linux-pci@lfdr.de>; Tue, 12 Oct 2021 00:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235498AbhJKWIA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Oct 2021 18:08:00 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:39678 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235500AbhJKWH5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Oct 2021 18:07:57 -0400
Received: by mail-oi1-f177.google.com with SMTP id m67so421352oif.6;
        Mon, 11 Oct 2021 15:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oINn+ngnlK0guwerLyEgPMWYZbLevit1wsPrwjvEJcs=;
        b=dA5O1vCmuQ0EIJ3iZnZytsA8iEXfCNiC4heD7O99Km1XthjiYQJIwKma/TyZFJXD3P
         FpIZPuaKdVDXYdrSKkG0pmNVH3VS8o3axfbnMNkh6CiRiOUN103ZbDiAIKIbPUUfixBd
         4XRFIuXmaWMFQMnxtyYNELP7MGAci83PY26Qc8Ibx7K6jDa/EazFpwf5s1SFfRFuna+s
         FDyPqIpC1LSQ2tmpzpZp7sC7z1pqi8qvjmmjOTkOywjDmL1qaRK6BTRPsm8nHB4DgKEW
         d57kG9KyR/7FW19m1DYnuQbJ59ub4eZUaLbaHaD/vj2a4l6QygHes+O5Jf+p2C8KdpgG
         YmYw==
X-Gm-Message-State: AOAM530qqqWgBIuoWwzgikglFFQFTsMvmJqWOCDt1wDv3P0oajjmG0bM
        xak/g5LY2dfcd8+03AXTBe8JzLw9MA==
X-Google-Smtp-Source: ABdhPJz5Z2csSZa8MPZspzTrKP3JpclGaxTPGaD8wytGzZiZJm1+c9S+z/zVEDMJwCE9KuliaxI/cQ==
X-Received: by 2002:aca:3606:: with SMTP id d6mr1092094oia.35.1633989956086;
        Mon, 11 Oct 2021 15:05:56 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e2sm1733601ooh.40.2021.10.11.15.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 15:05:55 -0700 (PDT)
Received: (nullmailer pid 1251528 invoked by uid 1000);
        Mon, 11 Oct 2021 22:05:54 -0000
Date:   Mon, 11 Oct 2021 17:05:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Naveen Naidu <naveennaidu479@gmail.com>
Cc:     bhelgaas@google.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/22] PCI: Unify PCI error response checking
Message-ID: <YWS1QtNJh7vPCftH@robh.at.kernel.org>
References: <cover.1633972263.git.naveennaidu479@gmail.com>
 <c632b07eb1b08cc7d4346455a55641436a379abd.1633972263.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c632b07eb1b08cc7d4346455a55641436a379abd.1633972263.git.naveennaidu479@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 11, 2021 at 11:08:32PM +0530, Naveen Naidu wrote:
> An MMIO read from a PCI device that doesn't exist or doesn't respond
> causes a PCI error.  There's no real data to return to satisfy the
> CPU read, so most hardware fabricates ~0 data.
> 
> Use SET_PCI_ERROR_RESPONSE() to set the error response and
> RESPONSE_IS_PCI_ERROR() to check the error response during hardware
> read.
> 
> These definitions make error checks consistent and easier to find.
> 
> Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
> ---
>  drivers/pci/access.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index 46935695cfb9..e1954bbbd137 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -81,7 +81,7 @@ int pci_generic_config_read(struct pci_bus *bus, unsigned int devfn,
>  
>  	addr = bus->ops->map_bus(bus, devfn, where);
>  	if (!addr) {
> -		*val = ~0;
> +		SET_PCI_ERROR_RESPONSE(val);

This to me doesn't look like kernel style. I'd rather see a define 
replace just '~0', but I defer to Bjorn.

>  		return PCIBIOS_DEVICE_NOT_FOUND;

Neither does this using custom error codes rather than standard Linux 
errno. I point this out as I that's were I'd start with the config 
accessors. Though there are lots of occurrences so we'd need a way to do 
this in manageable steps.

Can't we make PCI_OP_READ and PCI_USER_READ_CONFIG set the data value 
and delete the drivers all doing this? Then we have 2 copies (in source) 
rather than the many this series modifies. Though I'm not sure if there 
are other cases of calling pci_bus.ops.read() which expect to get ~0.

Rob
