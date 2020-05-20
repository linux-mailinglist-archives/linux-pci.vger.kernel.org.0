Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF741DC0D0
	for <lists+linux-pci@lfdr.de>; Wed, 20 May 2020 23:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgETVCr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 17:02:47 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:40911 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbgETVCq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2020 17:02:46 -0400
Received: by mail-il1-f196.google.com with SMTP id m6so4775686ilq.7;
        Wed, 20 May 2020 14:02:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tKXDCZ5gEz5aPjczgSqplV+XkA066a4YqfUj91jMyEc=;
        b=MIr4p5WBaqZnlWj5nKsjAScJMwxHjtd3b81F2kUYQHB5fVsa4sJ8hZSqDu5A4qa90t
         8+/GD5AWVfpWkfk/YYQUYBvi65sfb2ApXQo04c5Mu8j32GN+HL4k/NiCLhIznKddE0Ii
         7fn0TnCsq9VC0XKtet7jl2ThBuFQsryNgYIFcC/3AgAbxGPvpiah2BXMzIFVBfQoZjuu
         zPOTeP2iEbLGcTI17y/xOvtzmECsCMDwtDvvp4vGZpUfjEv9g7NJxlriLtJ22Hdxe65/
         27K4QjoenpQIpG1n0ssR1+yQKcDpfsGjASYBGf8lRV2+Si4odEUcIOI4bOgVg9HeDwoL
         vc2g==
X-Gm-Message-State: AOAM533Td+VyZxAbBAUK9vIGwDcrgwjw3td7OYJddtQ+wFQ/c/kl+qTb
        tE1d0LMOP6hj/8uCJI5E9A==
X-Google-Smtp-Source: ABdhPJw5G4Y3m7OOQfc/yaq+fGm0W7AyUUtUGpQ2t8/mZ5jJ9GW/M/76VDdwg5wcYV1Q8Yk09ay07g==
X-Received: by 2002:a05:6e02:1292:: with SMTP id y18mr5534871ilq.143.1590008565856;
        Wed, 20 May 2020 14:02:45 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id 4sm1565239ioy.43.2020.05.20.14.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 14:02:45 -0700 (PDT)
Received: (nullmailer pid 575316 invoked by uid 1000);
        Wed, 20 May 2020 21:02:44 -0000
Date:   Wed, 20 May 2020 15:02:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tom Joseph <tjoseph@cadence.com>,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v4 03/14] PCI: cadence: Add support to use custom read
 and write accessors
Message-ID: <20200520210244.GA575238@bogus>
References: <20200506151429.12255-1-kishon@ti.com>
 <20200506151429.12255-4-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506151429.12255-4-kishon@ti.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 6 May 2020 20:44:18 +0530, Kishon Vijay Abraham I wrote:
> Add support to use custom read and write accessors. Platforms that
> don't support half word or byte access or any other constraint
> while accessing registers can use this feature to populate custom
> read and write accessors. These custom accessors are used for both
> standard register access and configuration space register access of
> the PCIe host bridge.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/controller/cadence/pcie-cadence.h | 107 +++++++++++++++---
>  1 file changed, 94 insertions(+), 13 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
