Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A03E45484E
	for <lists+linux-pci@lfdr.de>; Wed, 17 Nov 2021 15:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238372AbhKQOSR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Nov 2021 09:18:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22036 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238270AbhKQOSJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Nov 2021 09:18:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637158510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NDuAh9ydG33nQ/5kdKqaUb4pA1g/jsmhAD4nowtB8q0=;
        b=dNdy4Mz31I46s5l+sggVpmAsEQyAOnEll6D9rk2qkC4Ov4ptBmSNK3NsomPSmpwGvnA3+m
        AtWWOl4tSl4cMcdhslXatFCsaYeO0hazQ82kucZ+90aeKBwELErXsnESMfVAMmTTwVKfE/
        Y6Fc7/dTrtAQeIqydZAdg+I1/083vVA=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-156-OIDfgtsSPtmkpu_561xXkQ-1; Wed, 17 Nov 2021 09:15:09 -0500
X-MC-Unique: OIDfgtsSPtmkpu_561xXkQ-1
Received: by mail-oo1-f72.google.com with SMTP id r22-20020a4ad4d6000000b002bb8cc2ea41so1829012oos.4
        for <linux-pci@vger.kernel.org>; Wed, 17 Nov 2021 06:15:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=NDuAh9ydG33nQ/5kdKqaUb4pA1g/jsmhAD4nowtB8q0=;
        b=ckq4p+W8wKQyafsg6KJAy1XQN8r1guhvARHTrcHurWMr0ga32HeooEYBt8dM+29fxG
         51gJT+uIRh7EgP7wugxjE+Tr8CTGFn5uXuhikZFyQF+B3OtSO8eCgMZl3wyv1puvNLIL
         JEBzGZgNPfONUeY0ea3ndwK2556ewo/Dt7CZZYAY100h7o9xX2uPGkhb9/y6FOThscSh
         JIYD/9sNxHg13pczrQrkjNAzZj3dFlAxOTYiy8n57dcb90JnJ7PCPc4F3/MZGWI9iwk3
         R4mF6kt6NVPd2rj841qmkTtyV5k+E6KqfrPPzLjEfvl+OMmJU+cLwXjfmmocYOuVT47S
         3mmg==
X-Gm-Message-State: AOAM530THsudkOTyio0yrttfXL+VucPcOHHRS1SleexqLQqNM1jK/iUO
        9NJEzceqE5jzxiqi9/Jd6RZWPjuD/6Cxlg0Gl7jK6ygNh5f4YeZc/TqrIRi3oJoMVhni8OHnVHY
        q3NtsiNJWlQAcVLWw6+5c
X-Received: by 2002:a05:6808:178d:: with SMTP id bg13mr14567849oib.171.1637158508616;
        Wed, 17 Nov 2021 06:15:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzIUkaPo+5JL68yqcgqUWzhvxOFFi1URuQME7OdHfDKEYHYLEe4Wuvsx7qhQJwyhWqct3Uphg==
X-Received: by 2002:a05:6808:178d:: with SMTP id bg13mr14567818oib.171.1637158508414;
        Wed, 17 Nov 2021 06:15:08 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id s17sm2319497ooj.42.2021.11.17.06.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 06:15:08 -0800 (PST)
Date:   Wed, 17 Nov 2021 07:15:07 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Yifeng Li <tomli@tomli.me>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Add func1 DMA quirk for Marvell 88SE9125 SATA
 controller
Message-ID: <20211117071507.775e12b8.alex.williamson@redhat.com>
In-Reply-To: <YZTVdOlEbMb0tv59@infradead.org>
References: <YZPA+gSsGWI6+xBP@work>
        <YZTVdOlEbMb0tv59@infradead.org>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 17 Nov 2021 02:12:04 -0800
Christoph Hellwig <hch@infradead.org> wrote:

> On Tue, Nov 16, 2021 at 02:32:26PM +0000, Yifeng Li wrote:
> > Like other SATA controller chips in the Marvell 88SE91xx series, the
> > Marvell 88SE9125 has the same DMA requester ID hardware bug that prevents
> > it from working under IOMMU. This patch adds its device ID 0x9125 to the
> > Function 1 DMA alias quirk list.  
> 
> Btw, do we need to prevent vfio assignment for all devices with this
> quirk?

No, the alias is taken into account with grouping and IOMMU
programming, it should work with vfio.  Thanks,

Alex

