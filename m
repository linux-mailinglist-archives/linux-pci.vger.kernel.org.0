Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A3946C681
	for <lists+linux-pci@lfdr.de>; Tue,  7 Dec 2021 22:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241745AbhLGVSc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Dec 2021 16:18:32 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:39698 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbhLGVSb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Dec 2021 16:18:31 -0500
Received: by mail-ot1-f51.google.com with SMTP id r10-20020a056830080a00b0055c8fd2cebdso541620ots.6;
        Tue, 07 Dec 2021 13:15:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hMPp8eJ3HT7AMdS1OWA3UkDt9m8fr4GHA3WgnRyiBfs=;
        b=6YWUs8aHokgKSA5/aew9hi+LpA0ice40TOUnh/4msS3mWLrY4TduFU3VdkUrle0ot2
         e+t21WYn5XJD+dPmZqDB05GxIvx5oCa37WAO14OCuTDzYFhgH1VzKP3yoUujlXzNm3mq
         F8t9Y4v9V9QBx/IcMl07WwkRtJ25D6W9f1h4EhOE3Nfug2x4DC14dM+UOapxNwFePaNT
         W3oAA4pdpGTVP4d2XsnsjsqQoUBBhPYJS8BXCT1kFVlEPTCkCcMow1PpDWLVEsEnTMLi
         kph0D1ziTzTYpbp9g3jK3p7EqjKGdphqqCyc+4lF6kgo7Zfd6XR1Di92zlw4xe6Kz+NA
         b3XA==
X-Gm-Message-State: AOAM533fGWsWp4c9df4AFZ+73chfwIM42MGnqe6WDZuXNUDKCtzkq0hl
        B1Lm+hEtO49W7jc1F9fukw==
X-Google-Smtp-Source: ABdhPJwtobr2zojieZAaxXmv84EbWPbJBl9tEuCOl38THFgPPcTLJ44tmtR4FSAuONqNaUdvsZxXOQ==
X-Received: by 2002:a05:6830:40b1:: with SMTP id x49mr37582035ott.234.1638911700839;
        Tue, 07 Dec 2021 13:15:00 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v2sm132279oto.3.2021.12.07.13.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 13:15:00 -0800 (PST)
Received: (nullmailer pid 843333 invoked by uid 1000);
        Tue, 07 Dec 2021 21:14:59 -0000
Date:   Tue, 7 Dec 2021 15:14:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v2] dt-bindings: PCI: ti,j721e: Add device id for J721S2
Message-ID: <Ya/O0+F6V3YUDmWm@robh.at.kernel.org>
References: <20211130035608.13492-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130035608.13492-1-a-govindraju@ti.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 30 Nov 2021 09:26:07 +0530, Aswath Govindraju wrote:
> Document the device id of J721S2 SoC.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
> 
> changes since v1:
> - changed (oneOf, items) into enum
> 
>  .../devicetree/bindings/pci/ti,j721e-pci-host.yaml   | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
