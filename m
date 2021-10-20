Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD0C2434C4A
	for <lists+linux-pci@lfdr.de>; Wed, 20 Oct 2021 15:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhJTNom (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Oct 2021 09:44:42 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:45039 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbhJTNom (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Oct 2021 09:44:42 -0400
Received: by mail-oi1-f175.google.com with SMTP id y207so9648522oia.11;
        Wed, 20 Oct 2021 06:42:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C3zm8nKj/VABcyLNvlJFABEEbLCD2W5bXoiX6pdtUtw=;
        b=0OSSiWrcURMGdYQcZWNf2AAWvQ6xL7LsH/JU57BzATJAKUldenOQemaNC0dm3MugPu
         sGYrfU2gJonTAppQcW8DpUBqPNBj1hLY3YLG3WOb/V4hHaz+YghsvZEod7n1cX+WdLQ7
         UQTIs8+kZwIvGzIbr+7pY6MTGUQ3+2k2ensfhDo3KITmvGoNSXc1c3lnOYLH9nbyRR67
         E8tIy41Q+PlK+XqYMruumDhJm6slsiv89K6BIPENwnrok6Hjw9Xf/6xN7BfsVZ0IKcGS
         lRVYGyGpFBKt73sRlRT7qxCU4nOZUwI5+vehXey1Eye4BcFmkJKeo0Sxp9oL8zCdilXx
         vtdA==
X-Gm-Message-State: AOAM5325bDdG/R7n6LaTT42tQOCHAxptATzsdTseuWBVmT4N+Dh7fgZ4
        FE5S/ed/qa/E575d1ahhdi6TI0n/hQ==
X-Google-Smtp-Source: ABdhPJy8z4v0lJpsQMD8Slg1JZ9MvgPFDcFKsDrCYO60tYePf2Ras0QIpJseUJhBtzS/Z/i4z8BVYQ==
X-Received: by 2002:aca:3c87:: with SMTP id j129mr9607754oia.157.1634737347723;
        Wed, 20 Oct 2021 06:42:27 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id k4sm436183oic.48.2021.10.20.06.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 06:42:27 -0700 (PDT)
Received: (nullmailer pid 2248211 invoked by uid 1000);
        Wed, 20 Oct 2021 13:42:26 -0000
Date:   Wed, 20 Oct 2021 08:42:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Naveen Naidu <naveennaidu479@gmail.com>
Cc:     bhelgaas@google.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/24] PCI: Remove redundant error fabrication when
 device read fails
Message-ID: <YXAcws0S2xBvjsDb@robh.at.kernel.org>
References: <cover.1634306198.git.naveennaidu479@gmail.com>
 <0114a4a44ceacfbd6a7859d8613ca5942f5b35d7.1634306198.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0114a4a44ceacfbd6a7859d8613ca5942f5b35d7.1634306198.git.naveennaidu479@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 15, 2021 at 08:08:45PM +0530, Naveen Naidu wrote:
> An MMIO read from a PCI device that doesn't exist or doesn't respond
> causes a PCI error. There's no real data to return to satisfy the
> CPU read, so most hardware fabricates ~0 data.
> 
> The host controller drivers sets the error response values (~0) and
> returns an error when faulty hardware read occurs. But the error
> response value (~0) is already being set in PCI_OP_READ and
> PCI_USER_READ_CONFIG whenever a read by host controller driver fails.
> 
> Thus, it's no longer necessary for the host controller drivers to
> fabricate any error response.
> 
> This helps unify PCI error response checking and make error check
> consistent and easier to find.
> 
> Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
> ---
>  drivers/pci/access.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
