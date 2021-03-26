Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7348034A1F5
	for <lists+linux-pci@lfdr.de>; Fri, 26 Mar 2021 07:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhCZGkx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Mar 2021 02:40:53 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:39893 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhCZGkd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Mar 2021 02:40:33 -0400
Received: by mail-lj1-f178.google.com with SMTP id u4so6151894ljo.6;
        Thu, 25 Mar 2021 23:40:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fdQdV3bMG38vgbmXObqpukYud0D9FCxWQbMgrCbUnVM=;
        b=g5fZAP6ou0g8EY4tuSF4f6B1TOnoCuxu7YvH6VDuMQOo+7d/fDc8Jf6h1ydt2RQTaP
         rNOTe2YYZyjds44h1k4adtlNPL6cXjK+kNynG/7oFvdxMDrHStWa5z6cJ7Qd2jn+T9sD
         xDXBrNPpdeXH+BJWjFhdWXPdAP6PWhWR98vNlDpbON7Dyr3vDHD4QPNmgVQvsNuSoEVd
         v3EzmRgm2GZtNP529S9dJZ3hWo1jQhkgzTlgbmYxhY7staYixcRMrahwDiWDz1B/Vbub
         ynU7ndJEo9tfLom4EXINQHhfC5iSE0PxT1jbCv71CqB8/qeoWA26Kqc8oe8x+HQGcCG3
         s4hw==
X-Gm-Message-State: AOAM533XLExQHBnMzooSjxdM2UM57ARYWuWbkYQQVeOnfqf3ypgLLVQV
        6QHC7Y4bP58VseLlQ08ABSq/DsF79L0=
X-Google-Smtp-Source: ABdhPJyzgbT3NtjtGw4cQQRoCcYLEvNS/O7J68ShVOIhCeygLm8bCSiF7Hh2ZBmzI1c5oXdLsu1M7A==
X-Received: by 2002:a2e:878c:: with SMTP id n12mr8403022lji.58.1616740831631;
        Thu, 25 Mar 2021 23:40:31 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id j22sm767239lfr.37.2021.03.25.23.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 23:40:31 -0700 (PDT)
Date:   Fri, 26 Mar 2021 07:40:29 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Box <david.e.box@linux.intel.com>
Subject: Re: [PATCH] PCI: ACPI: PM: Fix debug message in
 acpi_pci_set_power_state()
Message-ID: <YF2B3cfeDe3Dj/aR@rocinante>
References: <4319486.LvFx2qVVIh@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4319486.LvFx2qVVIh@kreacher>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

[...]
> To address this issue, modify the debug message in question to print
> the current power state of the target PCI device's ACPI companion
> instead of printing the target power state which may not reflect
> the real final power state of the device.
[...]

Thank you!

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

Krzysztof
