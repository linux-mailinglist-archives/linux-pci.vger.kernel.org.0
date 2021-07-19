Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE0D33CF269
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jul 2021 05:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244428AbhGTC1I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Jul 2021 22:27:08 -0400
Received: from mail-il1-f173.google.com ([209.85.166.173]:40502 "EHLO
        mail-il1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359658AbhGSVWA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jul 2021 17:22:00 -0400
Received: by mail-il1-f173.google.com with SMTP id b14so17411599ilf.7;
        Mon, 19 Jul 2021 15:02:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pxD+Cus6QToWUCkMrsmBw2UQ5ikpfGFz25k3lebVLec=;
        b=IZgNgi64+DPMqn/qD8WFtu+2ObaM434ktchd5W+Hzz44UfDYFpIeOzdsu9hQydsc9A
         LTf6OzJ/WiS04ZZBfHrMsKvRS7xyoS8n2WIsTY+PB6IzQzPVprxcbm/+6g/gSP6k9xSN
         Q7IdY4R9fGayfYDOXYYd1gQ3jZIvexRo7KHFfj95khnhVoMfoZ7W/2+o0dSN24KJTVC5
         pa+/J3xw7X1ztUg2A+2ah5r3yqshb/5T3EsMSa0g/GGxYIv3WQALwr+MrtYdBwx4ZS8F
         7XVhBNVhX5ksnux10Pa3Iq3e7jsp2NtM85WoZxkS0Zm9bPPCwClgJqxAet9MLkBnmMOZ
         oBcw==
X-Gm-Message-State: AOAM531S7kpWULSLGxBz8Q3J7jhnTcgA1tz6OqpFh1x2Espq/a8hWGdC
        gs9kefHpMdStal49jPwyvA==
X-Google-Smtp-Source: ABdhPJxj9rrfMRfCKDXsPGXrgyI2rNuALj8hbfDOvwGqlJHRW6z1ufZWYhiPBNUXqtmZAVzwpUfGtg==
X-Received: by 2002:a92:c54d:: with SMTP id a13mr6120613ilj.74.1626732158251;
        Mon, 19 Jul 2021 15:02:38 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id t24sm11481232ioh.24.2021.07.19.15.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 15:02:37 -0700 (PDT)
Received: (nullmailer pid 2677241 invoked by uid 1000);
        Mon, 19 Jul 2021 22:02:32 -0000
Date:   Mon, 19 Jul 2021 16:02:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linux-pci@vger.kernel.org, mauro.chehab@huawei.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linuxarm@huawei.com, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v5 4/5] dt-bindings: PCI: remove designware-pcie.txt
Message-ID: <20210719220232.GA2677156@robh.at.kernel.org>
References: <cover.1626608375.git.mchehab+huawei@kernel.org>
 <c93261b41f9ffe8d97d8c930f57b41aaf7de5264.1626608375.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c93261b41f9ffe8d97d8c930f57b41aaf7de5264.1626608375.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 18 Jul 2021 13:40:51 +0200, Mauro Carvalho Chehab wrote:
> Now that the properties defined there were converted to DT schema,
> and the other dt-bindings are pointing to the new schemas,
> drop it.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../bindings/pci/designware-pcie.txt          | 77 -------------------
>  MAINTAINERS                                   |  1 -
>  2 files changed, 78 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/designware-pcie.txt
> 

Applied, thanks!
