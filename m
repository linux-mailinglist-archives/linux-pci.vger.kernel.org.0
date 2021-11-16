Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F3D45365C
	for <lists+linux-pci@lfdr.de>; Tue, 16 Nov 2021 16:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238610AbhKPPxB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Nov 2021 10:53:01 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:36850 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238315AbhKPPwy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Nov 2021 10:52:54 -0500
Received: by mail-wr1-f52.google.com with SMTP id s13so38543760wrb.3;
        Tue, 16 Nov 2021 07:49:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nCgBiR9vUhtX7XcnvMRDbpeYdH3tPMJwSClwcRonSqk=;
        b=QwwbYc2ZnA8Cd4YjMZwMdE9lJLl2zw6W5OgzKywDEkeRNTc/1ho4Ol3228eHsLaBd7
         uOe7jDPDzmVNBOZHUVlxaudENb96VDIxTzdvcxRDzN9IwbjzO+Aw0hG9JK2QsG45i8im
         X38jza6Jel4vr1tWxKYAc7+wV1aWxXBAB45r2Z5cMLpyqkKTAEhf7p+RPNCR/IusAecS
         G2dQg7+bSYp54jKItcgR6DV04fimmXmbqSR+c8J4B8jKk/PPj1+bcp9RNQcmyko33l/F
         LUG3pZdIskZmUFdbqt36YuY3xQsotlOCv/EDyMrXrsgS7ZzPUVv+9A5RVLHUI7hxr5cZ
         MLkw==
X-Gm-Message-State: AOAM530Nc4vemPO1DIJ7w8w72sgoWmJNEHTxemGVMRCWFJemkBVQM/Kr
        ViDEWP/DMC08khiSPTpFEAU=
X-Google-Smtp-Source: ABdhPJzJCT0lf3p02QTe+lsbmXVDtD8y6vhM47jd4v2u35SCkebBwgJSwqYIDa7xcwYzfkSbdCJ21g==
X-Received: by 2002:a05:6000:1a88:: with SMTP id f8mr10578652wry.54.1637077796521;
        Tue, 16 Nov 2021 07:49:56 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id f15sm3691270wmg.30.2021.11.16.07.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 07:49:55 -0800 (PST)
Date:   Tue, 16 Nov 2021 16:49:54 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Yifeng Li <tomli@tomli.me>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Add func1 DMA quirk for Marvell 88SE9125 SATA
 controller
Message-ID: <YZPTIllU1KKPviHU@rocinante>
References: <YZPA+gSsGWI6+xBP@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YZPA+gSsGWI6+xBP@work>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Thank you for sending the patch over to fix this!

> Like other SATA controller chips in the Marvell 88SE91xx series, the
> Marvell 88SE9125 has the same DMA requester ID hardware bug that prevents
> it from working under IOMMU. This patch adds its device ID 0x9125 to the
> Function 1 DMA alias quirk list.

[...]
> Reported-by: sbingner <sam@bingner.com>
> Tested-by: sbingner <sam@bingner.com>

Both of these tags would require a proper full name, if possible, rather
than a name that is abbreviated and/or a username.

Reviewed-by: Krzysztof Wilczyński <kw@liunx.com>

	Krzysztof
