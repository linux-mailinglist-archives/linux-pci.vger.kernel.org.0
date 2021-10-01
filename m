Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF36D41EFFC
	for <lists+linux-pci@lfdr.de>; Fri,  1 Oct 2021 16:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhJAOxD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Oct 2021 10:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbhJAOxD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Oct 2021 10:53:03 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E817C061775
        for <linux-pci@vger.kernel.org>; Fri,  1 Oct 2021 07:51:19 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id d12-20020a05683025cc00b0054d8486c6b8so11859381otu.0
        for <linux-pci@vger.kernel.org>; Fri, 01 Oct 2021 07:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=pI21qB/pQXParW0juqBdZHeaeuvWOc5OGghxmRD/HQE=;
        b=gt1rgkcESxxoRF2CFHddv++q0jWtItmolNdJbUTV/aKkdvapxWiQLAORWE00u26al1
         KhvxFN6Xoyv1WMT6BgCvvwyT89G1dvJefq1JaqB1jTH0dkUDeuEWm322FPz9kxky8Ord
         TGv3m3FhU5UQETt7nB1R+sB2XWecrudvMvKOtz3bGnEys8qu9/6vgPGbCy8UX+gOpVqK
         Z5AbeH2kdooX3tUPukBp5nOhJb+VD8i7a9Be1wt1UatDyG4j1bJ+1qtaN0077V8Q8J4G
         wq/akhVplhH4iN12xAWHaL4Gwkr7R77VENulIRu7zTnwRE8rgvHWrKaqTYn9ueSy1haC
         lnZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=pI21qB/pQXParW0juqBdZHeaeuvWOc5OGghxmRD/HQE=;
        b=3sVRjtN9ufv+XCYI/hVT0Rmi//HzIt/BqBlMqlQwobr3rC51TceOYMRBlVoAwGkAAV
         W6XqPWnqCss1Y+bSUB8LpTKtl0T3Fn7iSvUJ91Cs8CxmVDSHHi1bMmxOmkErVwTWdEMx
         aRUEghY2AAvsm1DPLScA1jcOQtlGVJ+eAnfagBpsCyJSUUuHR4vLKCD9X95m6zKjAWdq
         XQJRHibmRwvA/ad1v6mWTHjHKHs7T2tcWkHhh7jXqkyvg0fV6gPF0UWOpjnOuaoWixCG
         qqMZklAm0M4FuSPAcsQ4DafLxDnTQeldSSgYcm1aOQKQ2okWPz8jQn0CKE3V91aKkNA8
         uUZA==
X-Gm-Message-State: AOAM5313VePOTcymCowCgdhKCOk3oWJtCNzFNfcbZC4vu1D4xdSgnooU
        rjIOjfULEevPGy4jx9/6mUqKpoYZ0IJv39oduSXxamslbGk=
X-Google-Smtp-Source: ABdhPJypGVVPS6r3/LM+1icMEfLetZpCwF+rK+UV5ki8PrAVwOKVda9qf1W0qHM4kZyxtoFAE7nBZ08uOIhChRvPrXc=
X-Received: by 2002:a05:6830:1653:: with SMTP id h19mr11080095otr.162.1633099878073;
 Fri, 01 Oct 2021 07:51:18 -0700 (PDT)
MIME-Version: 1.0
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Fri, 1 Oct 2021 20:21:06 +0530
Message-ID: <CAHP4M8UqzA4ET2bDVuucQYMJk9Lk4WqRr-9xX8=6YWXFOBBNzw@mail.gmail.com>
Subject: None of the virtual/physical/bus address matches the (base) BAR-0 register
To:     linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi All.

I have a SD/MMC reader over PCI, which displays the following (amongst
others) when we do "lspci -vv" :

#########################################################
Region 0: Memory at e2c20000 (32-bit, non-prefetchable) [size=512]
#########################################################

Above shows that e2c20000 is the physical (base-)address of BAR0.



Now, in the device driver, I do the following :

########################################################
.....
struct pci_dev *ptr;
void __iomem *bar0_ptr;
......

......
pci_request_region(ptr, 0, "ajay_sd_mmc_BAR0_region");
bar0_ptr = pci_iomap(ptr, 0, pci_resource_len(ptr, 0));

printk("Base virtual-address = [%p]\n", bar0_ptr);
printk("Base physical-address = [%p]\n", virt_to_phys(bar0_ptr));
printk("Base bus-address = [%p]\n", virt_to_bus(bar0_ptr));
....
########################################################


I have removed error-checking, but I confirm that pci_request_region()
and pci_iomap calls are successful.

Now, in the 3 printk's, none of the value is printed as e2c20000.
I was expecting that the 2nd result, of virt_to_phys() translation,
would be equal to the base-address of BAR0 register, as reported by
lspci.


What am I missing?
Will be grateful for pointers.


Thanks and Regards,
Ajay
