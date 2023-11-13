Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAAE97EA55E
	for <lists+linux-pci@lfdr.de>; Mon, 13 Nov 2023 22:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjKMVQC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Nov 2023 16:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKMVQB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Nov 2023 16:16:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6544D5E
        for <linux-pci@vger.kernel.org>; Mon, 13 Nov 2023 13:15:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18439C433C7;
        Mon, 13 Nov 2023 21:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699910158;
        bh=iES6Wa4OTa3BOz9ifmiukt3Ro9uNzh92I63NrZuLsWk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rA0j5ETYCH5NdzFwt+6VCPnyx09X25CSjXqHPedbcMYRuFQKznqjDMAGz8tmHq7Z8
         Gp8lQz1TnWQl42VQ48+SidFLfNpW4oinV5uxD8DShkMuZo37sGA/Zuz5KKrio1KJi1
         YMdWBIcqocGLvhx9FQoU4Vv4iNoY32FhVUhua4R9sjgElXew8CFpI4CRZ+ofTD3xJt
         mReUPgDOxRcjlGGpuemRqkBL+yFjgebr0xVuh1ah1neXYrTfOxFIo0tzoYv6sYyOEI
         3oZB3caCDqQx+GK+UKxrUZAYtYTeOk7M9Or+k90cgCOM8gL6oGsj3UMk0SYVhPbt82
         b/OLul2YfUE8g==
Date:   Mon, 13 Nov 2023 15:15:56 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ajay Garg <ajaygargnsit@gmail.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: Queries on pci address-ranges
Message-ID: <20231113211556.GA641950@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHP4M8U=yiC4bOrZ28Zx7-_Ho2-2kKWt4Y3O7nLdm7gNBwiL9w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Nov 12, 2023 at 09:36:23AM +0530, Ajay Garg wrote:
> Hi everyone.
> 
> I had written a (hello-world) PCI-driver couple of years back, and was
> able to read/write from/to BARs.
> I might have a requirement of writing more drivers, so was revisiting
> the concepts.
> 
> I have some queries (we can assume no IOMMU is in the picture) :
> 
> 0.
> Assertion : During PCI-enumeration, the physical-memory assigned to a
> BAR is always contiguous. (Yes/No)?

Yes, a BAR defines only a base address and a size, so the region is
always contiguous in the PCI bus address space.  If there's no IOMMU,
it is also contiguous in the CPU physical address space.

If there *is* an IOMMU, it is still be contiguous in the PCI bus
address space but could be discontiguous in CPU physical address
space.

> 1.
> During ioremap() of BAR-physical memory, does the (mapped)
> kernel-virtual-memory correspond to
> 
>              * one used in vmalloc(), wherein the
> kernel-virtual-address => physical-address
>                goes through page-tables?
>              * one used in kmalloc(), wherein the
> kernel-virtual-address => physical-address
>                *in all likelihood* requires only adding an offset?

ioremap(), kmalloc(), and vmalloc() all return kernel virtual
addresses, and the regions are all virtually contiguous.  Space from
kmalloc() will be physically contiguous.  Space from vmalloc() may not
be physically contiguous, and I don't think you can assume ioremap()
space is physically contiguous either, although it will be contiguous
in the *bus* address space.

> 2.
> On a related front, how does ioremap() differ from kmap()?

kmap() is for highmem (see Documentation/mm/highmem.rst) and has
nothing to do with I/O mappings like ioremap().  Very few drivers use
it, and I doubt you should use it either.

Bjorn
