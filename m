Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E16264D77
	for <lists+linux-pci@lfdr.de>; Thu, 10 Sep 2020 20:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgIJSnQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Sep 2020 14:43:16 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:44285 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgIJSSD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Sep 2020 14:18:03 -0400
Received: by mail-il1-f196.google.com with SMTP id h11so6563235ilj.11;
        Thu, 10 Sep 2020 11:18:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Km+ilfssoEe+/1p9cVPzW4JFS2R1ND0MVv0bL/RJ3KA=;
        b=Don4oH6oAOp/tlgJeGwCZCUutAuJsFfgbSasUuh9WPrbrCCB82IrespXJVuevda8F9
         DuaZcM5dQEZWvNFifMHL/NK3QGQUxr67bjCejHvUz85ouPpeUb4TndyZL3pU0zZtcIbN
         FpvPszLWPHgQCoZGWm131wEUpf+TNgPtF3+kPfcD1cPJ8l6cg/2bnOPC/mBWmP4I4MB2
         zdq68V24U6Yk7VEHwTutp9ljmS9dAhHGvagYmsrG4y7g3mIA5B8/t1iCnSO/rKX4KMSv
         HE3t/uZoixcSEpVzhETfPFrkparvXUKRvEhtRkJuX5DdgjpGWc1fVSeLIDlBOiLjOYUs
         N1MA==
X-Gm-Message-State: AOAM531tgbCFurahPzoI7wlHrjE416ifkW4UJf8X7WZBzQe3f7DFEri2
        J1PQZhZuV0TI6zZj/mNZ3w==
X-Google-Smtp-Source: ABdhPJy+jchPNAOwGP+KNIMYqdpVqnrsL4xX8ntPRCH549LF5iQzWhwqkjz2WczcZQva+Hj27kd1qg==
X-Received: by 2002:a92:9186:: with SMTP id e6mr8300661ill.278.1599761882138;
        Thu, 10 Sep 2020 11:18:02 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id y10sm3147009ioy.25.2020.09.10.11.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 11:18:01 -0700 (PDT)
Received: (nullmailer pid 622379 invoked by uid 1000);
        Thu, 10 Sep 2020 18:17:56 -0000
Date:   Thu, 10 Sep 2020 12:17:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc:     bhelgaas@google.com, shawnguo@kernel.org, minghuan.Lian@nxp.com,
        leoyang.li@nxp.com, linuxppc-dev@lists.ozlabs.org,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        roy.zang@nxp.com, andrew.murray@arm.com, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, gustavo.pimentel@synopsys.com,
        mingkai.hu@nxp.com, linux-kernel@vger.kernel.org,
        jingoohan1@gmail.com, kishon@ti.com, devicetree@vger.kernel.org
Subject: Re: [PATCHv7 12/12] misc: pci_endpoint_test: Add driver data for
 Layerscape PCIe controllers
Message-ID: <20200910181756.GA622331@bogus>
References: <20200811095441.7636-1-Zhiqiang.Hou@nxp.com>
 <20200811095441.7636-13-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811095441.7636-13-Zhiqiang.Hou@nxp.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 11 Aug 2020 17:54:41 +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> The commit 0a121f9bc3f5 ("misc: pci_endpoint_test: Use streaming DMA
> APIs for buffer allocation") changed to use streaming DMA APIs, however,
> dma_map_single() might not return a 4KB aligned address, so add the
> default_data as driver data for Layerscape PCIe controllers to make it
> 4KB aligned.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V7:
>  - New patch.
> 
>  drivers/misc/pci_endpoint_test.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
