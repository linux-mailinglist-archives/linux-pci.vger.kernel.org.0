Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4BDD1DC0E5
	for <lists+linux-pci@lfdr.de>; Wed, 20 May 2020 23:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgETVGK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 17:06:10 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35071 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbgETVGJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2020 17:06:09 -0400
Received: by mail-io1-f68.google.com with SMTP id 79so4958610iou.2;
        Wed, 20 May 2020 14:06:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=09WBBiNg8+91WX/1ofp/cbQVZYmY4/wJ7S0gDVoiaZk=;
        b=fRvpHPjLpveR7b3o/g6KER6z2RT8mpKX+WGNVXPwldKJpm9pSYq5qmmAayHiZAtHk9
         SsuKs0tyy2tj+p6QK9hp4D+3ovZf8Qy3ap4pn2rLEI+UVlCjSiaazbbkNNhOlSWzMp1h
         +JgEbYezLHZ07ZimTJcu/TLSb9sX6WHMZ8tnylb0wHppVvIOkCJaucnrEQ+h1aUcEfH2
         NhfGqpib7KUC0HtNzSFnqSELeCg75pfh0z6mRJJFqjx6Zu57y/TEEutGcNMlg6kbjxly
         Wy49RBdawLMRBH2LxMqgSGdJSYYTH2YT1nkGargr5LmoPbCHGRX8Rlk03feS8h2V3keM
         i6Tw==
X-Gm-Message-State: AOAM532TuZbSA9Ftvw/BwMVo6R0+NraRzrmqyOecmLWniPINdv7Uw/tN
        x24wyjyx9WlxuEQdMZO4Y3JdMVg=
X-Google-Smtp-Source: ABdhPJzagkFCHWiZjW5SLGpSt8Lquwvefwmka684NQTnQdAmOG8QYT+tbPEiButaZUh++R9xb/u2hg==
X-Received: by 2002:a02:c00e:: with SMTP id y14mr938022jai.15.1590008767247;
        Wed, 20 May 2020 14:06:07 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id t18sm1953577ili.24.2020.05.20.14.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 14:06:06 -0700 (PDT)
Received: (nullmailer pid 583652 invoked by uid 1000);
        Wed, 20 May 2020 21:06:05 -0000
Date:   Wed, 20 May 2020 15:06:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        Tom Joseph <tjoseph@cadence.com>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 04/14] PCI: cadence: Add support to start link and
 verify link status
Message-ID: <20200520210605.GA583572@bogus>
References: <20200506151429.12255-1-kishon@ti.com>
 <20200506151429.12255-5-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506151429.12255-5-kishon@ti.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 6 May 2020 20:44:19 +0530, Kishon Vijay Abraham I wrote:
> Add cdns_pcie_ops to start link and verify link status. The registers
> to start link and to check link status is in Platform specific PCIe
> wrapper. Add support for platform specific drivers to add callback
> functions for the PCIe Cadence core to start link and verify link status.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../pci/controller/cadence/pcie-cadence-ep.c  |  8 +++++
>  .../controller/cadence/pcie-cadence-host.c    | 28 +++++++++++++++++
>  drivers/pci/controller/cadence/pcie-cadence.h | 30 +++++++++++++++++++
>  3 files changed, 66 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
