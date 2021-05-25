Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05246390C7F
	for <lists+linux-pci@lfdr.de>; Wed, 26 May 2021 00:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbhEYW40 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 May 2021 18:56:26 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:38808 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhEYW40 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 May 2021 18:56:26 -0400
Received: by mail-pf1-f180.google.com with SMTP id e17so14163855pfl.5
        for <linux-pci@vger.kernel.org>; Tue, 25 May 2021 15:54:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hz+p+DEmTbVhwYalwH2/EzkvyaTFJcEXfrL+lCUIu3M=;
        b=cx8R+eOBpbJpMYJmf2F2cJr1Ly+7Q4ksa42tXlylu9nW9jdu+yllIwBYIa8U/MEJPS
         LT8ZjVzmoHDEQmDnOaJMBH/L392VDtdjb0Cj/jIrUiGN4jappwtmqYHAPzLD/wcjYvhn
         MDthyfefNuLaMN1AOSg0q5/OUXOKCdeXJZVNZmKAp9r923MvOGfvajHQ+YPkUzv1Wg1u
         MmGJQTm7vEj/Uc0MJ7jhly8UkVuiKcRAkRxVMDzV49JCpW+hzgBhF9HnvqIXUszBNdqY
         F0+AIhgrupnL5eifo6xzA2xyC3MBvjjeEAJu68WsJ3SdgXf5Y7KciPKEcjhtDxIgXtJO
         go7Q==
X-Gm-Message-State: AOAM531P2NMiqzGNG1PzcTp0bjbrGtyXJ+eLIaTIF/JaD+fSn6wpuGyw
        NZQNcbelMYLejhyH/czyrd8=
X-Google-Smtp-Source: ABdhPJxO6t9AT12xiQgLu5NjxDZQB32yH127yu39+ABjvhAt33e6CeyLz03RToqUhMvVerI3luQwAw==
X-Received: by 2002:a63:fd44:: with SMTP id m4mr21932966pgj.396.1621983295002;
        Tue, 25 May 2021 15:54:55 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id p6sm13223581pfh.166.2021.05.25.15.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 15:54:54 -0700 (PDT)
Date:   Wed, 26 May 2021 00:54:45 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Slivka, Danijel" <Danijel.Slivka@amd.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: Fix accessing freed memory in
 pci_remove_resource_files
Message-ID: <20210525225445.GA108348@rocinante.localdomain>
References: <5d5f4f33c3f34830b37cbd70e421023b@amd.com>
 <20210510225733.GA2307664@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210510225733.GA2307664@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Bjorn and Danijel,

Sorry for late reply!

[...]
> Krzysztof did some really nice work in v5.13-rc1 that removes a lot of
> the explicit sysfs file management.  I think he's planning similar
> work for pdev->res_attr[], and I suspect that will solve this problem
> nicely.  But there are some wrinkles to work out before that's ready.

Yes, the idea is to completely retire the late_initcall() and in the
process the pci_create_resource_files() and pci_create_legacy_files()
that are currently called from the pci_sysfs_init() function.

This will in turn allow for the removal of the "sysfs_initialized"
global variable that was, and most likely still is, responsible for the
race condition we have seen on some platforms, see:

  https://lore.kernel.org/linux-pci/20200716110423.xtfyb3n6tn5ixedh@pali/

> Any ideas here, Krzysztof?  IIRC some of the wrinkles have to do with
> Alpha, which has its own pci_create_resource_files() implementation.

Correct, Alpha support is something we have to address as one of the
outstanding problems to resolve.

To be more precise, there are two problems left to solve before we can
finally retire the late_initcall, and these would be:

  - pci_create_resource_files()
  - pci_create_legacy_files() 

The pci_create_resource_files() can be overridden on certain platforms
through a weak linkage which then allows for alternative implementations
to be provided - and this is true for Alpha as it provides a complete
implementation of the original function with all the platform-specific
changes it requires.

Similarly, an auxiliary function called pci_adjust_legacy_attr() can
also be overridden on some platforms again through a weak linkage
offering a way to adjust properties of some of the sysfs objects to be
added, and Alpha is also the platform that uses this for some custom
adjustments.

Having said that, aside of some dependency Alpha has on the functions we
are trying to retire, both of them have a larger challenge to overcome,
and which is related to the following commits:

- 3234ac664a87 ("/dev/mem: Revoke mappings when a driver claims the region")
- 636b21b50152 ("PCI: Revoke mappings like devmem")

Following these two changes, functions pci_create_attr() (called internally
from the pci_create_resource_files()) and pci_create_legacy_files() have
since a dependency on the iomem_get_mapping() function - which in turn also
creates an implicit dependency on the VFS and fs_initcall.

This dependency on iomem_get_mapping() stops us from retiring the
late_initcall at the moment as when we convert dynamically added sysfs
objects (that are primarily added in the pci_create_resource_files() and
pci_create_legacy_files() functions), these attributes are added before
the VFS completes its initialisation, and since most of the PCI devices
are typically enumerated in subsys_initcall this leads to a failure and
an Oops related to iomem_get_mapping() access.

See relevant conversations:

  https://lore.kernel.org/linux-pci/20210204165831.2703772-1-daniel.vetter@ffwll.ch/
  https://lore.kernel.org/linux-pci/20210313215747.GA2394467@bjorn-Precision-5520/

After some deliberation on a potential solution, we have settled on
changing the order when PCI sub-system and relevant device drivers are
initialised so that PCI will come after the VFS but before ACPI, thus
allowing for the iomem_get_mapping() to work without issues.

And this initialisation order change is what I am currently working on
towards.

Hopefully once this is done, and nothing breaks, we would be able to
retire the late_initcall and pci_sysfs_init(), and move everything to
static sysfs object.  This in turn would definitely solve the problem
Danijel stumbled upon in regards to module unloading.

> If you have any work-in-progress that works on x86, I'd be curious to
> see if it would solve Danijel's problem.
[...]

Nothing as of yet.  But I will focus on this now, so that we can finish
this work a lot sooner.

	Krzysztof
