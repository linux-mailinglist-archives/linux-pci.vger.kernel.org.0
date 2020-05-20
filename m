Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8391DC071
	for <lists+linux-pci@lfdr.de>; Wed, 20 May 2020 22:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgETUpz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 16:45:55 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:34794 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbgETUpz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2020 16:45:55 -0400
Received: by mail-il1-f194.google.com with SMTP id 4so4761179ilg.1;
        Wed, 20 May 2020 13:45:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PJPc6Xkos1JJWBSfHLuEWUb/ztU6JUGFozPRth5oI/s=;
        b=Qr6ImyGiMEYnMyB2AqmJClyKZVkfBVFm8SUmBFevqUGnXC3+WHZzGEUazL/htFV8m5
         OMbLPdWjFxJIFOoz6s9YzemCplhQvtWvazysxw0zZMThKE4WF7z7QU024EhP1goOI4Lv
         mwO1nB6iCd+JTly9E938UcdBMs+1n+ESr+Q+2/4wlYpRQAL0L667rw8cHK1H+SpXMWAR
         jVjXu4C/W1sXNYeD3JH4HQj1LXULVAo58kdDlM3pm8yaLlcfs8yWlccU1riEd262HZVB
         beQGGNHeaeyqOHWHw+S+jlvMRwfGOu7+QQub/zlIN//nm/xhI2pkXNr2kyREZrEyBW6L
         UIVQ==
X-Gm-Message-State: AOAM533FLUgAEEtcritQ+eyqC4zueewVdclzfk9Y2wmiMXCPW2s9LY3M
        Wh0g+HUxAaho/xvRIBZYyQ==
X-Google-Smtp-Source: ABdhPJzA/vi82RIXoD3jiTdlM1ikMFygzPsAvXo0y2Xvb7bHzqzrE2GznTbs47Fup0foDkFLalmioA==
X-Received: by 2002:a92:8946:: with SMTP id n67mr5278356ild.215.1590007554470;
        Wed, 20 May 2020 13:45:54 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id r8sm1531353iob.15.2020.05.20.13.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 13:45:54 -0700 (PDT)
Received: (nullmailer pid 535579 invoked by uid 1000);
        Wed, 20 May 2020 20:45:52 -0000
Date:   Wed, 20 May 2020 14:45:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Xiaowei Bao <xiaowei.bao@nxp.com>
Cc:     gustavo.pimentel@synopsys.com, linuxppc-dev@lists.ozlabs.org,
        kishon@ti.com, amurray@thegoodpenguin.co.uk, shawnguo@kernel.org,
        linux-kernel@vger.kernel.org, leoyang.li@nxp.com,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        devicetree@vger.kernel.org, roy.zang@nxp.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, Zhiqiang.Hou@nxp.com, jingoohan1@gmail.com,
        andrew.murray@arm.com, mingkai.hu@nxp.com, Minghuan.Lian@nxp.com
Subject: Re: [PATCH v6 07/11] PCI: layerscape: Modify the way of getting
 capability with different PEX
Message-ID: <20200520204552.GA535450@bogus>
References: <20200314033038.24844-1-xiaowei.bao@nxp.com>
 <20200314033038.24844-8-xiaowei.bao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200314033038.24844-8-xiaowei.bao@nxp.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 14 Mar 2020 11:30:34 +0800, Xiaowei Bao wrote:
> The different PCIe controller in one board may be have different
> capability of MSI or MSIX, so change the way of getting the MSI
> capability, make it more flexible.
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> ---
> v2:
>  - Remove the repeated assignment code.
> v3:
>  - Use ep_func msi_cap and msix_cap to decide the msi_capable and
>    msix_capable of pci_epc_features struct.
> v4:
>  - No change.
> v5:
>  - No change.
> v6:
>  - No change.
> 
>  drivers/pci/controller/dwc/pci-layerscape-ep.c | 31 +++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 8 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
