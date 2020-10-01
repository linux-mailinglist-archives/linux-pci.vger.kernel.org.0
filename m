Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 429E4280170
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 16:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732475AbgJAOjQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Oct 2020 10:39:16 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:45299 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732471AbgJAOjQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Oct 2020 10:39:16 -0400
Received: by mail-oi1-f181.google.com with SMTP id z26so5778374oih.12;
        Thu, 01 Oct 2020 07:39:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7zsBhn3AUhhWUevq6NpVFnpFVEwF4W7L8QTYWg530LM=;
        b=TeO8qGmPaWFw3gF+omM7SmUSU/zVUmuMeUQ8BGGUE5wBBGDgF9bTbCJlf13FgAO2d8
         3PWnPoGeiKIWEtezTZl2Er92wP4B0GZinN5XToqVN5TMf6fEzZqpLQW7QryYgVzF5pZO
         csIebPQ1/PxDXIBu/09Ai4VQSxjN1KV3dzLQ7tCebvLnvkMaUjZGTXTKH3iOhqxWjut9
         rZdAOVkCsVjKOfDZ7F/ZffB4u6v/6yLYXLhzi8sJtqvPBgot7i9c2FbbH8E7o0PwfRWC
         K5FsWyFQVpDteJDEFttpRY5zuIMzj+MQfqzssfR2D/b01KYdQy7XNlK+V/Dod7pjkKm6
         BJLA==
X-Gm-Message-State: AOAM530MTfuQZyMjjEO36VoR6dlX8PDBirMlNQMhXcBAgYmz304VuFTt
        t0q7BlDRnDgURP5gz+XphHwRiP+DU+Ho
X-Google-Smtp-Source: ABdhPJz/VBD+P0/RiJ1x36pULa8VCHGcm+E+nLlo8hCrgosG+zDd4B8/Tj3CaD9mHolRXdip/e5hbg==
X-Received: by 2002:aca:d693:: with SMTP id n141mr208057oig.26.1601563155022;
        Thu, 01 Oct 2020 07:39:15 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e30sm1227630otf.49.2020.10.01.07.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 07:39:14 -0700 (PDT)
Received: (nullmailer pid 704409 invoked by uid 1000);
        Thu, 01 Oct 2020 14:39:13 -0000
Date:   Thu, 1 Oct 2020 09:39:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH -next] PCI: loongson: simplify the return expression of
 loongson_pci_probe()
Message-ID: <20201001143913.GA704375@bogus>
References: <20200921131054.92797-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921131054.92797-1-miaoqinglang@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 21 Sep 2020 21:10:54 +0800, Qinglang Miao wrote:
> Simplify the return expression.
> 
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
>  drivers/pci/controller/pci-loongson.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
