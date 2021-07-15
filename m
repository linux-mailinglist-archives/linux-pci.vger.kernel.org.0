Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 800FA3CAF83
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jul 2021 01:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhGOXLJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Jul 2021 19:11:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44905 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229624AbhGOXLJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Jul 2021 19:11:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626390494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NDvlZA6sH6t+PDQTAEwSEmzaewUHs6lt6k+86E9mQKk=;
        b=II/Nw8xJloTa3TdWd4HPxNAAJOiMtJtTfj8dnPp9FLIahEM8CGQEQ/2wBQIsF8VhiWWl2t
        0fNOoeKzM9aWHr4PK9AkPO8o3DdTWfHKB6+aClYPLP5msxSZNKuZMaGVRrIh0OLkpIF+zs
        4lcUmRxdkNH5ufus08IQu2y5NBpwFB8=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-D4NsFODxO-OCIUqrYjhUfA-1; Thu, 15 Jul 2021 19:08:13 -0400
X-MC-Unique: D4NsFODxO-OCIUqrYjhUfA-1
Received: by mail-ot1-f69.google.com with SMTP id c1-20020a9d67c10000b02904bbe06f4bb9so5733502otn.8
        for <linux-pci@vger.kernel.org>; Thu, 15 Jul 2021 16:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NDvlZA6sH6t+PDQTAEwSEmzaewUHs6lt6k+86E9mQKk=;
        b=GFnUzqQkV3rvOt2U74tN2IYFcTN9FjzskZsIqcf41SziLKSKhB5UIkGOT577qveetb
         NGAnJY2JG89Z/O7t9NHHbB7TqLxchF74LhLfw8vjVUjVMEjsXkS2U6VA0Y81T7utWqe8
         9c7uGs43YoRYmlJTGyJfwnpTSKxOls3+nzIAiThEfInuS1n9CdAWx2Ak+b2fv09TyNpW
         Rrg107HfVJA8jha2vRHK8rkV0NHsuikoJcXYnUh0dvPcre5r9lIbGJSj6Y+51b4HJrrP
         MrfjZiq/1H43oTvKDhePB5IuUYSXAO70g9B4QNyGzF5idw5MlZZ1bTyLHtLcjP3QzwAj
         4jNA==
X-Gm-Message-State: AOAM530QgmGcVz2zlf00FjxpdvdHmmuIK/F04kQxyTTmqI5pw5ItLZgF
        70QnzZVeKY8lJKe4aeWKfMknTULxTEIIXcoaj0AXXL61f7yazRf8104bWrfEi/+DAbzmOiXe9o+
        tYu9cLPSaHR2xjv2PZlEV
X-Received: by 2002:a9d:7985:: with SMTP id h5mr5948683otm.283.1626390492898;
        Thu, 15 Jul 2021 16:08:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCtw5QxDN1znZeqnHIFCxqPxt72n1/Qe+HNrenBmvDr9baMjgAhJs01U+/xM/FOKa+0OqZzQ==
X-Received: by 2002:a9d:7985:: with SMTP id h5mr5948669otm.283.1626390492701;
        Thu, 15 Jul 2021 16:08:12 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id t137sm1345851oie.20.2021.07.15.16.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 16:08:12 -0700 (PDT)
Date:   Thu, 15 Jul 2021 17:08:11 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Ruben <rubenbryon@gmail.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [question]: BAR allocation failing
Message-ID: <20210715170811.5f4f793a.alex.williamson@redhat.com>
In-Reply-To: <20210715230506.GA2014923@bjorn-Precision-5520>
References: <CALdZjm6iDnCR7OWzfCuKOALAtN-FoVvTdxUB=XcAFqHg5Aumpw@mail.gmail.com>
        <20210715230506.GA2014923@bjorn-Precision-5520>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 15 Jul 2021 18:05:06 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Thu, Jul 15, 2021 at 11:39:54PM +0300, Ruben wrote:
> > Thanks for the response, here's a link to the entire dmesg log:
> > https://drive.google.com/file/d/1Uau0cgd2ymYGDXNr1mA9X_UdLoMH_Azn/view
> > 
> > Some entries that might be of interest:  
> 
> ACPI tells us the host bridge windows are:
> 
>   acpi PNP0A08:00: host bridge window [mem 0x000a0000-0x000bffff window] (ignored)
>   acpi PNP0A08:00: host bridge window [mem 0x80000000-0xafffffff window] (ignored)
>   acpi PNP0A08:00: host bridge window [mem 0xc0000000-0xfebfffff window] (ignored)
>   acpi PNP0A08:00: host bridge window [mem 0x800000000-0xfffffffff window] (ignored)
> 
> The 0xc0000000 window is about 1GB and is below 4GB.
> The 0x800000000 window looks like 32GB.
> 
> But "pci=nocrs" means we ignore these windows ...
> 
> > pci_bus 0000:00: root bus resource [mem 0x00000000-0xffffffffff]  
> 
> and instead use this 1TB of address space, from which DRAM is
> excluded.  I think this is basically everything the CPU can address,
> and I *think* it comes from this in setup_arch():
> 
>   iomem_resource.end = (1ULL << boot_cpu_data.x86_phys_bits) - 1;
> 
> But you have 8 GPUs, each of which needs 128GB + 32MB + 16MB, so you
> need 1TB + 384MB to map them all, and the CPU can't address that much.
> 
> Since you're running this on qemu, I assume x86_phys_bits is telling
> us about the capabilities of the CPU qemu is emulating.  Maybe there's
> a way to tell qemu to emulate a CPU with more address bits?

"-cpu host" perhaps

