Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D80F1E3332
	for <lists+linux-pci@lfdr.de>; Wed, 27 May 2020 00:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392283AbgEZWxG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 May 2020 18:53:06 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42446 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390428AbgEZWxG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 May 2020 18:53:06 -0400
Received: by mail-io1-f65.google.com with SMTP id d5so14404184ios.9;
        Tue, 26 May 2020 15:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kF+vRBfnhOkmQvA5KLQ4cDaPOVZ28rGc0O0qwy5RLx8=;
        b=P32b7cIs61bWGQKO+vQfRMx78GBXXufAz5+lymJb8v/BLQiAw3GLKhroiWOh7g6vKJ
         ICdZbXcu62p6ev8/3dXEwFcfmwj9mRoCzBd0+a58xQBN8C7S8vYCPmGHdimDigWb3h9D
         fM2K38PLu4zAqEJJrmWoDfhzhGwfF8Hv1ZC0tWnoLFRQfgmVyAGY4jIjHR/NluUL80YH
         IyKjL8lOFZZTkrpdTjzGiBGlfRKhoG4Lb3gTDe1jhC7vk4pn5yYMIJlDws6H2yBUy/sP
         bmGTrlE/WvCW5ojFM1YX21Yc3WFwPzfMV1j11qwU/L2CfWNyZOscVyks2AmwHkebHWix
         qdcw==
X-Gm-Message-State: AOAM530ySfiiCluWycmTP3K8+2WJUnOwNWRAZQB4zlwp0Rpe/qi7cTbJ
        rOq8Y4/3GdT2/wp7p3rLCw==
X-Google-Smtp-Source: ABdhPJyeoVtuZCUkjCMNR8Y6ccXH320ipxK5P3DJiUPsweubOQS/CFyKLVhwUqzve4pZavKBpEp3dg==
X-Received: by 2002:a02:93a1:: with SMTP id z30mr3149527jah.25.1590533583588;
        Tue, 26 May 2020 15:53:03 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id p1sm632821ilq.67.2020.05.26.15.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 15:53:03 -0700 (PDT)
Received: (nullmailer pid 538555 invoked by uid 1000);
        Tue, 26 May 2020 22:53:02 -0000
Date:   Tue, 26 May 2020 16:53:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tom Joseph <tjoseph@cadence.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH v5 06/14] dt-bindings: PCI: cadence: Remove "mem" from
 reg binding
Message-ID: <20200526225302.GA538495@bogus>
References: <20200522033631.32574-1-kishon@ti.com>
 <20200522033631.32574-7-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522033631.32574-7-kishon@ti.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 22 May 2020 09:06:23 +0530, Kishon Vijay Abraham I wrote:
> "mem" is not a memory resource and it overlaps with PCIe config space
> and memory region. Removve "mem" from reg binding.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../devicetree/bindings/pci/cdns,cdns-pcie-host.yaml      | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
