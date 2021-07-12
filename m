Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 330C53C6660
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jul 2021 00:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbhGLWci (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Jul 2021 18:32:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25562 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230030AbhGLWch (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Jul 2021 18:32:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626128988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oqwnxhFQeQ65Qf2gqGF6dVcU4wyYdloL+ALXZBg9iZw=;
        b=XJV2UxeVwlHhXCbfUZs4tvyhZbOD61dbAHjWCd/V0wXuCfgECNFl0276oJVMBuc/B2CzjG
        roZApXRaH2wblVxmzqqTt8g9uCT61bdPwywxmavwdQIdfOvvF/1e+YH71nnP9y9kq1AwWW
        0dSJk0AYbq3Q0WVhx3ihH5HFl9OASmM=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-dSCbzzYCMX-ljwtTa6sOdA-1; Mon, 12 Jul 2021 18:29:47 -0400
X-MC-Unique: dSCbzzYCMX-ljwtTa6sOdA-1
Received: by mail-ot1-f69.google.com with SMTP id l44-20020a9d1b2f0000b029048596759dfcso14155020otl.2
        for <linux-pci@vger.kernel.org>; Mon, 12 Jul 2021 15:29:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oqwnxhFQeQ65Qf2gqGF6dVcU4wyYdloL+ALXZBg9iZw=;
        b=ge43+kdMaAOIuQBTJpfBdv6+5aGFUrJ5fJgEzEs08xzAxOvH5w4TefnabgbdoYOF/L
         rISVKQ05Igru75j4ZTLOVp2p/VmsECJ0vJWhX82t//k9tne3kzoo/gY/kOVr7ijTNw/0
         Vj8Zbva8QAPCgh+OCZ/UjYSx8+rKZ5Ian+sfpjs82waLrjv2LxH65QaKHaIJwdoFblOD
         uYXZoFHk0iT/VSNZw3wliy7PPqh3BAhccApzcbUZV/K8Ec+j6VfmRk+V74OqmsI7wxx6
         PU+RDKKzShSzc99nynzPmrFaKem9q57DYcctU6Yb4EQbS6s1RETn3OcQA4sitU4uaEov
         MaGA==
X-Gm-Message-State: AOAM533QQ9uwzCxtVrt4qym2nB3SwVWlOa58IP1f4VrnCuydJRmRnFt7
        1/Jeik22LBtlWPBxXI7s/tXpNGepU+oSBfrkGwu/RVaaRQDXqHSHm969UwpEWW1WmA9cJhzCbRN
        JAiDzzmZFYkpWDz6183st
X-Received: by 2002:a05:6808:144c:: with SMTP id x12mr731359oiv.167.1626128986818;
        Mon, 12 Jul 2021 15:29:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyPrLezc2SstkxbEIw+obAYlT8e4FWRHpPJn0hdQ48gdtgupKwx0cOXBonRhFt1kHN+69DRVg==
X-Received: by 2002:a05:6808:144c:: with SMTP id x12mr731347oiv.167.1626128986704;
        Mon, 12 Jul 2021 15:29:46 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id l2sm3422223otl.27.2021.07.12.15.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 15:29:46 -0700 (PDT)
Date:   Mon, 12 Jul 2021 16:29:45 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v10 5/8] PCI: Define a function to set ACPI_COMPANION in
 pci_dev
Message-ID: <20210712162945.4a6090de.alex.williamson@redhat.com>
In-Reply-To: <20210709123813.8700-6-ameynarkhede03@gmail.com>
References: <20210709123813.8700-1-ameynarkhede03@gmail.com>
        <20210709123813.8700-6-ameynarkhede03@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri,  9 Jul 2021 18:08:10 +0530
Amey Narkhede <ameynarkhede03@gmail.com> wrote:

> From: Shanker Donthineni <sdonthineni@nvidia.com>
> 
> Move the existing code logic from acpi_pci_bridge_d3() to a separate
> function pci_set_acpi_fwnode() to set the ACPI fwnode.
> 
> No functional change with this patch.
> 
> Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
> ---
>  drivers/pci/pci-acpi.c | 12 ++++++++----
>  drivers/pci/pci.h      |  2 ++
>  2 files changed, 10 insertions(+), 4 deletions(-)

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>

