Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD193DF516
	for <lists+linux-pci@lfdr.de>; Tue,  3 Aug 2021 21:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237860AbhHCTAV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Aug 2021 15:00:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46593 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238764AbhHCTAU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Aug 2021 15:00:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628017200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l5USzdXQ9euxrl7NB3ZGmWIS9cg5EG63KnUhySjS41U=;
        b=AFNyrJqo5r3/AVi5o5BERluPQp/YZaCgtEd5kIDHHYIF3O6OFpnmSKNP1aos9WY4FqQXwp
        P/XfKpIii+lpl1KT10HtoN9OCwZXQY1Rl5gSssSmLc3Rj5PHiY06+vKocR7h+AiQpl2kTY
        tN6RXCkGto3UIZ95SM/nUkteXlXKo9A=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-B27bgSL2MA24hwI-5F-mKA-1; Tue, 03 Aug 2021 14:59:59 -0400
X-MC-Unique: B27bgSL2MA24hwI-5F-mKA-1
Received: by mail-ot1-f70.google.com with SMTP id m19-20020a9d6ad30000b02904b7c1fa2d7cso10204069otq.16
        for <linux-pci@vger.kernel.org>; Tue, 03 Aug 2021 11:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l5USzdXQ9euxrl7NB3ZGmWIS9cg5EG63KnUhySjS41U=;
        b=Q2xL+s9IrDTB6whahBv0If7aTOvepADSITbw27CUcmANPfIECbY/RaJaDgNkt0EDM9
         4JnpLQslqse5Q/1il6ZAHHch3BH8Pqwoj8+wQwDM9oSRwlRxSQgGkueAnv9L+H1FP8e0
         meXHmTThOSZr9py/lSqBdTRlgE/X34g0ppIhiGzPbMdIjBFqpvovSHnIHuYssVPaUKHp
         L3z2jGMMJb3qGzv2upX54/DSdniNa7fmex21MVhVHhSm9JaVSaa7AfZEgNov1LzDood3
         GGpB82hJwtkOvPPyRJ4valvJTbMaieF9sHYSEtkQu6NPPybttZwvn88k2sb2K4QpUynY
         xJ2Q==
X-Gm-Message-State: AOAM531n0mmS0MVxioaEDc+LeKetJhW2wW4yEWQg4ZWRJYZhiK4GDwlZ
        n9VSvKXOYw1Y0JLZA60+H+517LjEc976YjswghLq4CECphzHXHvW3iuU49zD+nqRfeHyz0e+8qn
        FaPOi1ZBJsh0kt8kS7RSk
X-Received: by 2002:a9d:64d9:: with SMTP id n25mr16237709otl.174.1628017198338;
        Tue, 03 Aug 2021 11:59:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtgrBaRd2X5njqX/Ru2B488M5h/QFnB3bHOr+H6V+E3tjpQSXOdgVKAE+2iD0E591AyC/uFA==
X-Received: by 2002:a9d:64d9:: with SMTP id n25mr16237702otl.174.1628017198208;
        Tue, 03 Aug 2021 11:59:58 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id u126sm2448781ooa.23.2021.08.03.11.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 11:59:57 -0700 (PDT)
Date:   Tue, 3 Aug 2021 12:59:56 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2] PCI: Make saved capability state private to core
Message-ID: <20210803125956.2b0188f0.alex.williamson@redhat.com>
In-Reply-To: <20210802221728.1469304-1-helgaas@kernel.org>
References: <20210802221728.1469304-1-helgaas@kernel.org>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon,  2 Aug 2021 17:17:28 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Interfaces and structs for saving and restoring PCI Capability state were
> declared in include/linux/pci.h, but aren't needed outside drivers/pci/.
> 
> Move these to drivers/pci/pci.h:
> 
>   struct pci_cap_saved_data
>   struct pci_cap_saved_state
>   void pci_allocate_cap_save_buffers()
>   void pci_free_cap_save_buffers()
>   int pci_add_cap_save_buffer()
>   int pci_add_ext_cap_save_buffer()
>   struct pci_cap_saved_state *pci_find_saved_cap()
>   struct pci_cap_saved_state *pci_find_saved_ext_cap()
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pci.h   | 23 +++++++++++++++++++++--
>  include/linux/pci.h | 18 ------------------
>  2 files changed, 21 insertions(+), 20 deletions(-)

LGTM

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>

