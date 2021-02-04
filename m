Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2BD630FFB0
	for <lists+linux-pci@lfdr.de>; Thu,  4 Feb 2021 22:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhBDVvO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Feb 2021 16:51:14 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:46206 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhBDVuo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Feb 2021 16:50:44 -0500
Received: by mail-wr1-f45.google.com with SMTP id q7so5267344wre.13;
        Thu, 04 Feb 2021 13:50:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=teRE6eGwXoeBL8LsCaE2nFvmjdHWwf0/CDf55awZ0Wk=;
        b=kAXGAmHpq3aQFeETq+l+4tXLCgr/EqqNstYCKJRnUqPRS+ST6hdK7+A9nPhbdk06S+
         BqpXv10lIFfhhLbMrhagy8mEW6NVvf6MdgWXrBFKucwunVL1dxQV4KmEo1KzhdGoxoKF
         if+LvcUiy+/ISRYaAV40+wmREHzo8jd4DREIcggH1EAc0KbWadv9vdZ2O3Dbq+UBiOVp
         TgU2i+GmixonMhdA4LwVpcJM+yKTDY5ADZ1zScYf5gq+/8o1gKu3w9jZrOcRx1++eELo
         U7fDsqMvFgaKFOtmU/qCXoc1zHEutDbJFcvY5aSQz0dgsNg6LcknGkgYexSiQ4HZJr/x
         N/1Q==
X-Gm-Message-State: AOAM532ZeMMzFj18EuZ42BrY5zPVHz+4r51wrSqzYBVWnsLRGlub9VVH
        OCcCOPCHk99lpuAil0In/0U=
X-Google-Smtp-Source: ABdhPJw0QWQyxWgLhowu8T564mJ+zSHPEMlNg9ZsnrGHRHRfgO+wGWLViyVgFk8yCK6XRamzexFP4w==
X-Received: by 2002:a5d:4206:: with SMTP id n6mr1430877wrq.213.1612475402735;
        Thu, 04 Feb 2021 13:50:02 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id e16sm9607844wrp.24.2021.02.04.13.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 13:50:02 -0800 (PST)
Date:   Thu, 4 Feb 2021 22:50:00 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Xiaofei Tan <tanxiaofei@huawei.com>
Cc:     helgaas@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        sean.v.kelley@intel.com, Jonathan.Cameron@huawei.com,
        refactormyself@gmail.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH 1/1] PCI/AER: Change to use helper pcie_aer_is_native()
 in some places
Message-ID: <YBxsCPEFe0lxhDMO@rocinante>
References: <1612420127-6447-1-git-send-email-tanxiaofei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1612420127-6447-1-git-send-email-tanxiaofei@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Tan,

This is very nice!  Thank you for this.

[...]
>  	if (dev->aer_cap && pci_aer_available() &&
> -	    (pcie_ports_native || host->native_aer)) {
> +	    pcie_aer_is_native(dev)) {
>  		services |= PCIE_PORT_SERVICE_AER;
[...]

A suggestion.  You could improve this even further, for example:

  if (pci_aer_available() && pcie_aer_is_native(dev)) {

This is because the pcie_aer_is_native() function performs the
dev->aer_cap check internally, so we could rely on it, and avoid
checking the same thing twice.

What do you think?

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

Krzysztof
