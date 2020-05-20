Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B43651DA80F
	for <lists+linux-pci@lfdr.de>; Wed, 20 May 2020 04:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgETCdN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 May 2020 22:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgETCdM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 May 2020 22:33:12 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF22C061A0E;
        Tue, 19 May 2020 19:33:12 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id z15so1808987pjb.0;
        Tue, 19 May 2020 19:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BwDIrBXiNjaNz3sG9XWNN0+BTSmsf3erXnkyJQzGLzI=;
        b=Z8f6KuRo4EWgcL3PMTyVvvSNgU0tmmvrMjN6uxyXU2nszwe3HCzMMtkOxiYzfzoK4Y
         3fdPzf6RukbQKC7WTlixVM2LfcZhISfWGUjwAquCrxgZC6LDBvGYB3LGMNi5Rg7ZiB6U
         GrLEeUzKkE5ev6tNquiHmTN7M4BuyTNf49Hz5e3IcQ1/Qkau4XkEUpWqRyWqNKofauoZ
         w5wcJ4kwIEV35b0gObCkDtLRF1jp+vIwpBY14Y23OHyu9CW8HWGP0BrfhkbYyLRIAe51
         Jygd3bVaGiaKpKrqjW69KscBv0vhYwcVYEzJ4pGRDm+Bzc1OHEE+oizovEAVAg8X8Lit
         t9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BwDIrBXiNjaNz3sG9XWNN0+BTSmsf3erXnkyJQzGLzI=;
        b=DDiI2LrLjeznnr+2XhwWJK01XbgkVs+cBNumn40atajKdAna4fBpL2HTSL66TD+nXV
         wp8h0/GXld9Pow+jg9aAtNJaM09AREUw9g1hSiw4nvGpYLHtB6kuYNSTWbaWRqH60Izp
         CV7xAaE/WI6Di9S+8nzY0HHnlVDyF3E/Ch+VWFb5M2SAY0o6y1WlUNRZ6ESpMkgv+P08
         dlLIvujqLxEEErlghpMBygn2ObjSLvu7K5LyGMHQYWfAn4eC6AWG9AdHyIfRjgV/e+vz
         jvUkKml/G38HPkpQbvt/dlXkX1fKon0a//WvchJggowwVbH9+MiRl0wAQhLC/AkvyTrf
         HVug==
X-Gm-Message-State: AOAM533lZEsNt5fytIcroDiqRjQ3TJ3nUZUXgnpVsHqDimEcPwGwKt6c
        ZDUMl7NO6fmNThEeHtF6YyM=
X-Google-Smtp-Source: ABdhPJxLssJreMhxQDprWZeb6hHopnxv+jYg4bnwEbtDXeRJ+cFIy9AaD/D2G1zU3jzWNUFJVhTaZw==
X-Received: by 2002:a17:90a:8918:: with SMTP id u24mr2625764pjn.71.1589941990928;
        Tue, 19 May 2020 19:33:10 -0700 (PDT)
Received: from localhost.localdomain (c-73-170-106-24.hsd1.ca.comcast.net. [73.170.106.24])
        by smtp.gmail.com with ESMTPSA id k24sm651418pfk.134.2020.05.19.19.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 19:33:10 -0700 (PDT)
From:   Alan Mikhak <alanmikhak@gmail.com>
X-Google-Original-From: Alan Mikhak <amikhak@wirelessfabric.com>
To:     gustavo.pimentel@synopsys.com
Cc:     alan.mikhak@sifive.com, amurray@thegoodpenguin.co.uk,
        bhelgaas@google.com, helgaas@kernel.org, jingoohan1@gmail.com,
        jonathanh@nvidia.com, kthota@nvidia.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, mmaddireddy@nvidia.com,
        sagar.tv@gmail.com, thierry.reding@gmail.com, vidyas@nvidia.com,
        Alan Mikhak <amikhak@wirelessfabric.com>
Subject: Re: PCI: dwc: Warn only for non-prefetchable memory resource size >4GB
Date:   Tue, 19 May 2020 19:33:04 -0700
Message-Id: <20200520023304.14348-1-amikhak@wirelessfabric.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <DM5PR12MB1276C836FEE46B113112FA92DAB90@DM5PR12MB1276.namprd12.prod.outlook.com>
References: <DM5PR12MB1276C836FEE46B113112FA92DAB90@DM5PR12MB1276.namprd12.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

I came across this issue when implementing a Linux NVMe endpoint function
driver under the Linux PCI Endpoint Framework:
https://lwn.net/Articles/804369/

I needed to map up to 128GB of host memory using a single ATU window
from the endpoint side because NVMe PRPs can be scattered all over host
memory. In the process, I came across this 4GB limitation where the
maximum size of memory that can be mapped is limited by what a u32 value
can represent.

I submitted a separate patch to fix an undefined behavior that may also
happen in dw_pcie_prog_outbound_atu_unroll() under some circumstances
when the size of the memory being mapped is greater than what a u32 value
can represent.
https://patchwork.kernel.org/patch/11469701/

The above patch has been accepted. However, the variable pp->mem_size
in dw_pcie_host_init() is still a u32 whereas the value returned by
resource_size() is u64. If the resource size has non-zero upper 32-bits,
those upper 32-bits will be lost when assigning:
 pp->mem_size = resource_size(pp->mem).

Since current callers seem happy with the existing 4GB implementation
and fixing the u32 limit is beyond my available resources and has a long
high-impact tail, a warning seemed to be a good choice to highlight
this issue in case someone else decides to map a MEM region that is
greater than 4GB.

Removing the warning will avoid such discussions. Without this warning,
this limitation will go unnoticed and will only impact whoever has to
deal with it. It cost me time to figure it out when I had an application
that needed a region larger than 4GB. I figured the most I could do about
it is to raise the issue by adding a warning.

Regards,
Alan






