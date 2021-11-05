Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB79445DAC
	for <lists+linux-pci@lfdr.de>; Fri,  5 Nov 2021 02:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbhKEB75 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Nov 2021 21:59:57 -0400
Received: from mail-pl1-f178.google.com ([209.85.214.178]:42568 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbhKEB75 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Nov 2021 21:59:57 -0400
Received: by mail-pl1-f178.google.com with SMTP id u17so10124791plg.9;
        Thu, 04 Nov 2021 18:57:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=96WX6/US4LcMNKbP8rKG9nQdk70oEI+cgp7sotVClCk=;
        b=42fgUMMktag4DxRByW3Qt2ApISri6+Up2aLcYE0Tj03D7ioVH4dcXTKWquDsuMZNfK
         A6+IjyT3qqx8rgOKQyQvQLY3Ze2nV2TkpssLDGVT6AtWZvzzdehkC6lYBBTwXlk77lNk
         03KzqL8L0X+YaVJ3xKrmkl0x9GALqSUoqY9LZbLsRaHa7HDMIthy7MrSZEH9VCRDjQ3C
         CBhEpMgdIKA6NGS6y+dmNKIMutzie2IbuMSBNdgIDX5gjDDhxgf/wKhCZT9+Ix9heRzi
         bxUmwzgK/T1yGhfoAFAF+VOsu9Dl7WrEEqmH5MQu42JvkuL6MIyivtMBgMdfdTCt00iM
         D5UA==
X-Gm-Message-State: AOAM531NJDnO5iNnR6Gsy2RXG7mnurnRCDQzh6D8PD2gOrsXQ8Q25x7Y
        cy+7QlANbbzahFm4wiiizWM=
X-Google-Smtp-Source: ABdhPJyPNvQW04siPU6SnZ8iGFq/FSToZtACsOx4KEawhAt5b+vDpFHXnP0kDfoA+Y0Wagi1Wxf77g==
X-Received: by 2002:a17:902:ec8f:b0:142:11aa:3974 with SMTP id x15-20020a170902ec8f00b0014211aa3974mr18585933plg.30.1636077438297;
        Thu, 04 Nov 2021 18:57:18 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id n11sm4764492pgm.74.2021.11.04.18.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 18:57:17 -0700 (PDT)
Date:   Fri, 5 Nov 2021 02:57:04 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Xuesong Chen <xuesong.chen@linux.alibaba.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, catalin.marinas@arm.com,
        lorenzo.pieralisi@arm.com, james.morse@arm.com, will@kernel.org,
        rafael@kernel.org, tony.luck@intel.com, bp@alien8.de,
        mingo@kernel.org, bhelgaas@google.com, ying.huang@intel.com,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/4] PCI MCFG consolidation and APEI resource filtering
Message-ID: <YYSPb8+9zcEZ5tLs@rocinante>
References: <20211104150053.GA774800@bhelgaas>
 <e1a6fa17-106d-6b0b-8974-5a96bb33086e@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e1a6fa17-106d-6b0b-8974-5a96bb33086e@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

[...]
> > Thanks.  I see this and will look at it after getting the v5.16
> > changes merged.
> 
> Ah, Bjorn, I also notice this series is in your patchwork now, hmmm, I don't know why
> the previous iterations are not there either, seems something doesn't work as expected
> in my side. Probably my fault for the unpeaceful interlude :-)
[...]

You can check your previous submissions using the following:

  https://patchwork.kernel.org/project/linux-pci/list/?submitter=201963&archive=both&state=*

This changes the default filters to include everything you submitted.

	Krzysztof
