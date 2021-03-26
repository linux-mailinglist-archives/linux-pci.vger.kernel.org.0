Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A968A349E6B
	for <lists+linux-pci@lfdr.de>; Fri, 26 Mar 2021 02:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhCZBHl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Mar 2021 21:07:41 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:34306 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbhCZBH2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Mar 2021 21:07:28 -0400
Received: by mail-lf1-f49.google.com with SMTP id i26so5262280lfl.1;
        Thu, 25 Mar 2021 18:07:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9eLjWVT8hPiDtc1t+jEPlM4wV/caxcgGLiKcEJS4Ka8=;
        b=lT/qYEZVwCpBKpmj1psLipDJaWzGnZienRtEQ76KE+mYMsbU7vk+ImJ7XDF9HhpCD9
         HMPdzyUPa9eYc0Vo+er2ULvVQ+5oHeipPUgcOs8rJgH3YpNPQKIz4uYQ2iq85CB3OUzI
         aXJr9+TDyLflot0BCi5nK5xJEK/wlxPv+Lb6rX+0qheAWlFzCKFSdXxRdqJ3vrHp87mh
         XTuRdUjULr9//NY7Iz414TlScpxRrrYiNr4KNLVXi9iLdaqCrBw0BLEY5RPzu8uUo7Ni
         PRx4WBSEsgOykJvvfy3Yy0HspLM8Z0lZUpA6W1Woak6SWhdtaD1/fqkvoGpTMMMq6QBL
         kidg==
X-Gm-Message-State: AOAM532WpwvG8zgryH70zjK6DvimPECds0qWBewGMf50FF/vr+RD/xWU
        WLTBOORZDbBpMzk0NI2hILw=
X-Google-Smtp-Source: ABdhPJxDqg8f8Sh3Q7LZP8/jDuT/gYmz27wVS9UDMznUpXBeFTFs0zt4yr/qTUJYO5Ad4QZBDSk/4A==
X-Received: by 2002:ac2:4883:: with SMTP id x3mr6344687lfc.419.1616720847133;
        Thu, 25 Mar 2021 18:07:27 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id l12sm696423lfc.248.2021.03.25.18.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 18:07:26 -0700 (PDT)
Date:   Fri, 26 Mar 2021 02:07:25 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     bhelgaas@google.com, rjw@rjwysocki.net, ruscur@russell.cc,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] PCI: Correct function names in the header
Message-ID: <YF0zzabwhiKYRq/f@rocinante>
References: <20210325075144.180030-1-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210325075144.180030-1-wangxiongfeng2@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

[...]
>   PCI: acpi_pcihp: Correct acpi_pci_check_ejectable() function name in
>     the header
>   PCI/AER: Correct function names in the header
>   PCI/PME: Correct pcie_pme_init() function name in the header
>   PCI/ATS: Correct pci_max_pasids() function name in header
[...]

All of this has already been fixed in the following series:

  https://lore.kernel.org/linux-pci/20210311001724.423356-1-kw@linux.com/

Krzysztof
