Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5D828017D
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 16:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732147AbgJAOm4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Oct 2020 10:42:56 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43735 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732020AbgJAOm4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Oct 2020 10:42:56 -0400
Received: by mail-oi1-f196.google.com with SMTP id i17so5805194oig.10
        for <linux-pci@vger.kernel.org>; Thu, 01 Oct 2020 07:42:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0204NW6ER5exEU55fNd1mRlRwGnFW2TRYfVBPjMBJIE=;
        b=dop2KfegvQbt4BwVD/Fqy/F+7p0vjgcAx1SitT4OGIAH1dhe0Odgv0w2jELCiDFRJZ
         n0kzHykluKBwkZ/VXJ+Bgc2aMdagQGZv6gO7J89oLhQI+2y3/cN0h0jcG0NI5sDg9hDJ
         1zpCfqpDLwA8lxGHRABNxcav/0XKWWBT0VANvDLGicUQWCdK4iBI6elEkN1Mtry+gxPT
         ja/8H+nhGG0HDr9wO67TB5z31KILy6x99ZL2LZgriQnVCj1trPTywyz+hR0bpgLdfumY
         nywfgjcomWePaozJONNrueQd7B5U54w4oiFsdXCO7jmIxf4QwTP2shiMF0IW3nLOm/ub
         Iq0g==
X-Gm-Message-State: AOAM533tKl6oT6KcqUMnvpxH/04Z/Pd00biWHhamlEJ2333rna/l0q7Z
        E1q5yPXMJMZdxGY32Z8Fdg==
X-Google-Smtp-Source: ABdhPJzUHjqh43Bmrgr/HhR+8aqng4ADr49hmNuJ5ZQR4ufyX79gcbYCEnEZ3VeJu9yTgfbNy3bwkw==
X-Received: by 2002:aca:654b:: with SMTP id j11mr189497oiw.77.1601563375158;
        Thu, 01 Oct 2020 07:42:55 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 68sm298363otu.33.2020.10.01.07.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 07:42:54 -0700 (PDT)
Received: (nullmailer pid 709304 invoked by uid 1000);
        Thu, 01 Oct 2020 14:42:53 -0000
Date:   Thu, 1 Oct 2020 09:42:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        Duc Dang <dhdang@apm.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Toan Le <toan@os.amperecomputing.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] PCI: xgene: Remove unused assignment to variable msi_val
Message-ID: <20201001144253.GA709251@bogus>
References: <20200922030257.459898-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200922030257.459898-1-kw@linux.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 22 Sep 2020 03:02:57 +0000, Krzysztof Wilczyński wrote:
> The value assigned to msi_val after the inner loop finishes its run is
> never used for anything, and it is also immediately overridden in the
> line that follows with the return value from the xgene_msi_int_read()
> function.
> 
> Since the value of msi_val following the inner loop completion is never
> used in any meaningful way the assignment can be removed.
> 
> Addresses-Coverity-ID: 1437183 ("Unused value")
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
> ---
>  drivers/pci/controller/pci-xgene-msi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
