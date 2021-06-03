Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4FD39AA29
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jun 2021 20:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhFCSjo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Jun 2021 14:39:44 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:34320 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhFCSjo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Jun 2021 14:39:44 -0400
Received: by mail-lf1-f44.google.com with SMTP id f30so10334619lfj.1
        for <linux-pci@vger.kernel.org>; Thu, 03 Jun 2021 11:37:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=58fHnJjlesXYDlRNDU77IpAesCS0a6K2TRkbfzlmqRw=;
        b=XX6P2EhkhQMe+hH6meUrSRdt5/zT3tTvHJ+2IkCoIGzXE6ryXElg77zXdG4WITwtFS
         Qh+NrMlOgQEDwNHDjhc09EXPMB/s2ESvKqGWcT283ILRic9vj2hUKoRLLZmU8XIzYBx0
         AkXtjeUlb5Q474/AaNKC272OgXkpcnMsyv4t4ChCI0yJO9PfboMZGBIZyi7UMU6iVFUW
         E07t3eJ5BPGr8FhxnPhpXbcXkqISLAONdfu4hMcI1Fl0kIx3VIQfRjwx7tYtiDs9sjNt
         fHE4ZzH3fRijDv22YuhqZ868/XRMYvgmP8L8YFn2h0UfdgBGc0sqVZPfe2bpgI6d8Y7l
         +Z7g==
X-Gm-Message-State: AOAM53238EY8DHz0YPCj3THlyR5FLz9KnlM3wQbmYf6gzjRXBlEyJiv7
        9kOXZoA3/6LuR3iYb6K+OwI=
X-Google-Smtp-Source: ABdhPJxqKerQYkJMTnoxWSPAyolb1UDAewH4U+SuPI5ZyZnhNU76Bi0zsJCWI1Iv0GDOtdGuPI62jQ==
X-Received: by 2002:ac2:5084:: with SMTP id f4mr204255lfm.466.1622745478772;
        Thu, 03 Jun 2021 11:37:58 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id x19sm422043lfe.270.2021.06.03.11.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 11:37:58 -0700 (PDT)
Date:   Thu, 3 Jun 2021 20:37:57 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Slivka, Danijel" <Danijel.Slivka@amd.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: Fix accessing freed memory in
 pci_remove_resource_files
Message-ID: <20210603183757.GB375714@rocinante.localdomain>
References: <5d5f4f33c3f34830b37cbd70e421023b@amd.com>
 <20210510225733.GA2307664@bjorn-Precision-5520>
 <20210525225445.GA108348@rocinante.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210525225445.GA108348@rocinante.localdomain>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

[...]
> Having said that, aside of some dependency Alpha has on the functions we
> are trying to retire, both of them have a larger challenge to overcome,
> and which is related to the following commits:
> 
> - 3234ac664a87 ("/dev/mem: Revoke mappings when a driver claims the region")
> - 636b21b50152 ("PCI: Revoke mappings like devmem")
> 
> Following these two changes, functions pci_create_attr() (called internally
> from the pci_create_resource_files()) and pci_create_legacy_files() have
> since a dependency on the iomem_get_mapping() function - which in turn also
> creates an implicit dependency on the VFS and fs_initcall.
> 
> This dependency on iomem_get_mapping() stops us from retiring the
> late_initcall at the moment as when we convert dynamically added sysfs
> objects (that are primarily added in the pci_create_resource_files() and
> pci_create_legacy_files() functions), these attributes are added before
> the VFS completes its initialisation, and since most of the PCI devices
> are typically enumerated in subsys_initcall this leads to a failure and
> an Oops related to iomem_get_mapping() access.
> 
> See relevant conversations:
> 
>   https://lore.kernel.org/linux-pci/20210204165831.2703772-1-daniel.vetter@ffwll.ch/
>   https://lore.kernel.org/linux-pci/20210313215747.GA2394467@bjorn-Precision-5520/
> 
> After some deliberation on a potential solution, we have settled on
> changing the order when PCI sub-system and relevant device drivers are
> initialised so that PCI will come after the VFS but before ACPI, thus
> allowing for the iomem_get_mapping() to work without issues.
[...]

The conversation related to the iomem_get_mapping() and the dependency
on VFS has moved to the following thread:

  https://lore.kernel.org/linux-pci/20210527205845.GA1421476@bjorn-Precision-5520/

	Krzysztof
