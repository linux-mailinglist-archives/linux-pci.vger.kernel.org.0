Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5CCB3135CD
	for <lists+linux-pci@lfdr.de>; Mon,  8 Feb 2021 15:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbhBHO4a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Feb 2021 09:56:30 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:36525 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbhBHOzR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Feb 2021 09:55:17 -0500
Received: by mail-wm1-f45.google.com with SMTP id i9so13495002wmq.1;
        Mon, 08 Feb 2021 06:55:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AxdQBbqJYVsUNsjYxGRxYUR7gP2qcOt3EQH3Z3FcBds=;
        b=G2vpk9MYnLlrwB8sFROK6XI2j2+GfMNvFpIVt3KJK1tTEm6526OJf0P+Pg62rPO/Tc
         aUTcrfIkWM83TKLg1LGSycc4EO8EyaCOSts9ff8dxJUCOntJqHRnJj1ypSzuA+jr5P/U
         ghg2JDt7cb3tQaUTdVEbYtuM5AQh6o30yjllRzahuEeaTW/BU6T9x9HVhgDvjUuHFwn2
         68hAALDro+N45zeiAiArwNPIbNA3CpdMoF3RkBPWZwKG/ZKLwYCSAipEJskNuGXX6VCC
         2xQCAEpIEWfpe5zFTPL1vIUubmswBY4d27lCYI/1QG0LTZWNcCl09rtegGkHnLOleL23
         9+sQ==
X-Gm-Message-State: AOAM5306Nqf1wkxuNbF7BDOvhREZ8KD4HkiIKffFNepYdNaBDRG3Ux0t
        J87AxGViitIbKz4jOIZlQjE=
X-Google-Smtp-Source: ABdhPJyn5IEb5gwsuZ0f4CjT76Je3KF2T65Crsk4TI922p3mBD2mKGZByhB/qLXh8sQoT0c4nOV9QA==
X-Received: by 2002:a1c:1b12:: with SMTP id b18mr14588720wmb.157.1612796075872;
        Mon, 08 Feb 2021 06:54:35 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id f7sm15529814wrm.92.2021.02.08.06.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 06:54:34 -0800 (PST)
Date:   Mon, 8 Feb 2021 15:54:33 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Martin =?utf-8?Q?Hundeb=C3=B8ll?= <mhu@silicom.dk>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: add Silicom Denmark vendor id
Message-ID: <YCFQqSR3ABtDQBaL@rocinante>
References: <20210208132832.2833630-1-mhu@silicom.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210208132832.2833630-1-mhu@silicom.dk>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Martin,

Thank you for sending the patch over!

A few suggestions.  Try to keep the patch style aligned with previous
submissions, see the following for to format the subject line, etc.,
a few examples:

$ git log --oneline include/linux/pci_ids.h | grep -E 'Add.*ID' | head -n 10
8b7beaf9f185 PCI: Add Intel QuickAssist device IDs
a4e91825d7e1 x86/amd_nb: Add AMD family 17h model 60h PCI IDs
3375590623e4 PCI: Add Zhaoxin Vendor ID
9acb9fe18d86 PCI: Add Loongson vendor ID
b3f79ae45904 x86/amd_nb: Add Family 19h PCI IDs
4a36a60c34f4 PCI: Add Amazon's Annapurna Labs vendor ID
4460d68f0b2f PCI: Add Genesys Logic, Inc. Vendor ID
af4e1c5eca95 x86/amd_nb: Add PCI device IDs for family 17h, model 70h
1f418f46503d PCI: Add Synopsys endpoint EDDA Device ID
b8580e9de48b PCI: Add HXT vendor ID

If you have a moment, see [1] which you can use as a guide for patches
submissions against the PCI sub-system.

[...]
> Update pci_ids.h with the vendor id for Silicom Denmark.

It would be "ID" here.

[...
> +#define PCI_VENDOR_ID_SILICOM_DENMARK	0x1c2c

Are they any drivers for this new device already?

1. https://lore.kernel.org/linux-pci/20171026223701.GA25649@bhelgaas-glaptop.roam.corp.google.com/

Krzysztof
