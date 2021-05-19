Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE06389978
	for <lists+linux-pci@lfdr.de>; Thu, 20 May 2021 00:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhESWuc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 May 2021 18:50:32 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:37744 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhESWub (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 May 2021 18:50:31 -0400
Received: by mail-wm1-f41.google.com with SMTP id f19-20020a05600c1553b02901794fafcfefso3637264wmg.2
        for <linux-pci@vger.kernel.org>; Wed, 19 May 2021 15:49:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0CaTOf83E6W/vr9C4g97RwC3pF79Es1qTa32MdRuStU=;
        b=fwIB8yA/BVvO7oLn+wKB78WIo+9TN7I5PXMWYzbkMeNXFCtlDCEoCeccp1eyYUzj3m
         kemc+UihTkObBYskzxbWZ6dTiUTH0l0+MzoFkZQX53qxNYQlM5N2WJvI1GwPLrkxyDfl
         xThmDgaHQ+VNp7vetSPM0vmzCTnR8w0OJHvRgAI8lWAKSg+O5Whjuzox3EZlxvnwOaxr
         MakyOX5b43k/9Zltepto8U+YfmwG1ZCLY8ERiVeP/0J1sTCONWcpP1Z8INgtCDnD2Bex
         3VgqXdo+7jVq757RJf+uXJ919ZFZSvoCEC/8GGtS3VJnbW0210ap+wFVO4eubDsqLC85
         +NgQ==
X-Gm-Message-State: AOAM5321dXCfUAHDG65NVcBasAsQoPZIKp5XYFRwamIZfsOwrE39luJF
        s0lV2gyPKGBbzKmCn+m3S2M=
X-Google-Smtp-Source: ABdhPJyaKtqHMsyyydxX5QGXFWs6pOh3vu3JdJ3ws0X10kgDQ/p7egAXlEfaz9h2vdL0hTuOnSFuAg==
X-Received: by 2002:a1c:b6d5:: with SMTP id g204mr1269426wmf.106.1621464550755;
        Wed, 19 May 2021 15:49:10 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id f20sm780379wmh.41.2021.05.19.15.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 15:49:10 -0700 (PDT)
Date:   Thu, 20 May 2021 00:49:08 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Ray Jui <rjui@broadcom.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] PCI: iproc: Fix a non-compliant kernel-doc
Message-ID: <20210519224908.GA616654@rocinante.localdomain>
References: <20210519183829.165982-1-kw@linux.com>
 <3623373c-b95c-344f-63c3-3eeeda623e90@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3623373c-b95c-344f-63c3-3eeeda623e90@infradead.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

> This is a really good cleanup, but there is still one kernel-doc
> warning remaining after this patch is applied. Please see below.
[...]
> > - * iProc PCIe inbound mapping type
> > + * enum iproc_pcie_ib_map_type - iProc PCIe inbound mapping type.
[...]
> 
> The above gives me this:
> 
> pcie-iproc.c:151: warning: Enum value 'IPROC_PCIE_IB_MAP_MEM' not described in enum 'iproc_pcie_ib_map_type'
> pcie-iproc.c:151: warning: Enum value 'IPROC_PCIE_IB_MAP_IO' not described in enum 'iproc_pcie_ib_map_type'
> pcie-iproc.c:151: warning: Enum value 'IPROC_PCIE_IB_MAP_INVALID' not described in enum 'iproc_pcie_ib_map_type'
> 
> 
> If you could fix that, it would be Nice. :)
> 
> Even if not, it's a good cleanup. Thanks.

Doh!  Apologies!  This is my bad - correcting the format of the
kernel-doc made the parser go and check for the fields to be properly
documented, thus this new warning.  I need to also take care about this
too, a very good point!

Thank you for catching this!  I will update everything accordingly.

Krzysztof
