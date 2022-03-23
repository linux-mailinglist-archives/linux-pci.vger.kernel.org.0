Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41EC4E5B20
	for <lists+linux-pci@lfdr.de>; Wed, 23 Mar 2022 23:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345182AbiCWWQl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Mar 2022 18:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241243AbiCWWQk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Mar 2022 18:16:40 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB6A8FE46
        for <linux-pci@vger.kernel.org>; Wed, 23 Mar 2022 15:15:09 -0700 (PDT)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9E6353F1E0
        for <linux-pci@vger.kernel.org>; Wed, 23 Mar 2022 22:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1648073707;
        bh=dReMzwCuA7DzR3YY7V/dxHTfz3+PzXUF3Uux3SdiUmI=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=ORMAxMXYx/809Tb9hd0Oz5e7cBj2ilZvVfG/BhPLLFeA4OEuKuCaaOqjT2/Wlz5cf
         AMCXD8Bi2vvxhivQ9HWUwGT8XSxD1r+bhXbSqSfJhu10Zv2tB+G+4zZE8jpdLcFirk
         uqv8tsueYfMlQclbUajpKcrNChw7XhhfdmimfoFGpugPlhamIax6Lut5R2RGu3Hd4F
         kSf65m9aKQ9AvhYfXWfYEOB5TLmWWyVWJq9E8/2umAhdNnfk30T7mByggxQHSVMTnt
         6lBjt+Bnh1bjp4Uye8tLG0MmaFTzPrSLARjruLjE3n5Gxq8fxW8kahN0Al6UWwvQFj
         cD2tqXwL1Hgkw==
Received: by mail-il1-f199.google.com with SMTP id h13-20020a056e021d8d00b002c7fb1ec601so1698259ila.6
        for <linux-pci@vger.kernel.org>; Wed, 23 Mar 2022 15:15:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dReMzwCuA7DzR3YY7V/dxHTfz3+PzXUF3Uux3SdiUmI=;
        b=ikYu/37V6EF1mUJtMhLj37cgGX2PpMUNAM1MRJMuvJQqlBoH8KCfw6Emay2De+ZPPX
         OZPzGDsgA6E2ghVxg8SkeYS6lutgMAowk0P/QCd/mVraiDn691w4aBsONNNj80ut59ry
         sPrmFnTkGAIFjXFBsFlXBJmANr094w3fQXe8jkRJOwXE+QY9cHXHZVj33tFY4zM+fhEf
         oiVqCI5d/Z5u76xDzXzAUjKNKfcMQyC5glbgNGQZLELCfgIk1kSD9mM9rPoZ0VIqtu0z
         CeBQ+F0ssQWrVlE70Wcnjs6LUo+kedIXeeGnOSt0sQ+YJ/XzGC39/I33DbNOqyiOZP6G
         +UKA==
X-Gm-Message-State: AOAM532FoYJl7UaZpfYyAo1fnZ7W6eIvs8sQ26n6CnAiPQMpDc3Wx/fW
        ku6Qf53ik1W9vHBusoXsxbTQAqOb571YMyZXqE/nWpwVcp5LjM1BCOvnOhn2i5BmvnlQ+OTjOn2
        nWNyVBIyPI0YMGjeMckZay+yeHqyINl3ScFIIxQ==
X-Received: by 2002:a5e:a80a:0:b0:645:b477:bc23 with SMTP id c10-20020a5ea80a000000b00645b477bc23mr1117707ioa.191.1648073706601;
        Wed, 23 Mar 2022 15:15:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+6tp9O8ufnlxk71fZyefoiD5uwhUdp8quxvaa4yYGqMyrpN0FkBtdLritCC8OWbVnRtSNug==
X-Received: by 2002:a5e:a80a:0:b0:645:b477:bc23 with SMTP id c10-20020a5ea80a000000b00645b477bc23mr1117696ioa.191.1648073706394;
        Wed, 23 Mar 2022 15:15:06 -0700 (PDT)
Received: from xps13.dannf (c-73-14-97-161.hsd1.co.comcast.net. [73.14.97.161])
        by smtp.gmail.com with ESMTPSA id n7-20020a056e021ba700b002c63098855csm588677ili.23.2022.03.23.15.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 15:15:05 -0700 (PDT)
Date:   Wed, 23 Mar 2022 16:15:03 -0600
From:   dann frazier <dann.frazier@canonical.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        will@kernel.org, iommu@lists.linux-foundation.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org, robh@kernel.org
Subject: Re: [PATCH] iommu/dma: Explicitly sort PCI DMA windows
Message-ID: <Yjub51Ct3esuNA9B@xps13.dannf>
References: <65657c5370fa0161739ba094ea948afdfa711b8a.1647967875.git.robin.murphy@arm.com>
 <874k3pxalr.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874k3pxalr.wl-maz@kernel.org>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 23, 2022 at 09:49:04AM +0000, Marc Zyngier wrote:
> On Tue, 22 Mar 2022 17:27:36 +0000,
> Robin Murphy <robin.murphy@arm.com> wrote:
> > 
> > Originally, creating the dma_ranges resource list in pre-sorted fashion
> > was the simplest and most efficient way to enforce the order required by
> > iova_reserve_pci_windows(). However since then at least one PCI host
> > driver is now re-sorting the list for its own probe-time processing,
> > which doesn't seem entirely unreasonable, so that basic assumption no
> > longer holds. Make iommu-dma robust and get the sort order it needs by
> > explicitly sorting, which means we can also save the effort at creation
> > time and just build the list in whatever natural order the DT had.
> > 
> > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > ---
> > 
> > Looking at this area off the back of the XGene thread[1] made me realise
> > that we need to do it anyway, regardless of whether it might also happen
> > to restore the previous XGene behaviour or not. Presumably nobody's
> > tried to use pcie-cadence-host behind an IOMMU yet...
> 
> This definitely restores PCIe functionality on my Mustang (XGene-1).
> Hopefully dann can comment on whether this addresses his own issue, as
> his firmware is significantly different.

Robin, Marc,

Adding just this patch on top of v5.17 (w/ vendor dtb) isn't enough to
fix m400 networking:

  https://paste.ubuntu.com/p/H5ZNbRvP8V/

  -dann
