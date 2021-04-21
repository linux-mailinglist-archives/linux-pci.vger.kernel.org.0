Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C463670A8
	for <lists+linux-pci@lfdr.de>; Wed, 21 Apr 2021 18:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbhDUQy7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Apr 2021 12:54:59 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:42723 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236426AbhDUQy6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Apr 2021 12:54:58 -0400
Received: by mail-ed1-f49.google.com with SMTP id d21so30083378edv.9;
        Wed, 21 Apr 2021 09:54:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LwXhMkGUMNYwRKRStEL04Gs6Tphs7NzMu5XYeJimgo8=;
        b=uJRhbTSULmzlqgrkJy4ph5/So8zPjpSW1EeMWWLxvbYDZ+E50W9Dfl+Dve3OOOJeXy
         hX3T3RofsHTvSrKKL74SmThBZ7zmY7p/jcyYX8pQmei4R4fRk9lQ1Rzto1FDjddZyxSU
         WMnltyNR/VU3MOUal0kkRjbQp8aB91nAdeAYDEj0fMyvhGmv0raI/J1lqSJoIdEuI4Z/
         WKS1ysjkBehptsEkfhsBdzIf5BPIVA2/zrCEAXK+it4iN0ex5OjdxZoU2MfINNNip+b6
         tI6IhBCULbWABwdnsPMzxTSXw7EGO+tyaFM1WqV1/TIaXfPYUSYDcM43o6iGwtB4fRrO
         8+AQ==
X-Gm-Message-State: AOAM531nFZ2eq0kNCbmXLFoCR7yPsPcCkNY7O7wcGJzTbugtryCfvadN
        /LFZjDCyBBdJcAqnRp9ms2w=
X-Google-Smtp-Source: ABdhPJyGCcVU826RHHkW/QBdZ6r/MsN4F0wdJSbV7FA19XAFP1HUc+Rq8MpQnk2kKxg3ciJEek9I1w==
X-Received: by 2002:a05:6402:6da:: with SMTP id n26mr26868699edy.203.1619024061980;
        Wed, 21 Apr 2021 09:54:21 -0700 (PDT)
Received: from client-192-168-1-100.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id q6sm55200ejt.51.2021.04.21.09.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 09:54:21 -0700 (PDT)
Date:   Wed, 21 Apr 2021 18:54:20 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/VPD: fix unused pci_vpd_set_size function warning
Message-ID: <YIBYvJV0Hr7pt/T1@client-192-168-1-100.lan>
References: <20210421140334.3847155-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210421140334.3847155-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Arnd,

> The only user of this function is now in an #ifdef, causing
> a warning when that symbol is not defined:
> 
> drivers/pci/vpd.c:289:13: error: 'pci_vpd_set_size' defined but not used [-Werror=unused-function]
>   289 | static void pci_vpd_set_size(struct pci_dev *dev, size_t len)
> 
> Move the function into that #ifdef block.
[...]

Thank you!

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

Krzysztof
