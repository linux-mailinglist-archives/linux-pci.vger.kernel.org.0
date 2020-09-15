Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCCF2269AFC
	for <lists+linux-pci@lfdr.de>; Tue, 15 Sep 2020 03:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgIOBTs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 21:19:48 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41324 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgIOBTr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2020 21:19:47 -0400
Received: by mail-io1-f68.google.com with SMTP id z13so2255394iom.8;
        Mon, 14 Sep 2020 18:19:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U/KfCPDjFCIAzOKsECXjfLg/rGaPwkyiJrML0T5nV+4=;
        b=isSzZg6gHGsxrZRByc2g/MVra+O6gassuUqF9Ad6hMSmZecRn8s/H6zBklKmmvnT50
         OY1KjT6Vltn83fFf9P7X+5u23oku387/7EzHD2RNjxYnU/YJsaQaqfFucB2y3U7lCdp8
         kVHuO1Yr82lby/lLgmSHmMHFm49VxVwm3UMN18xVkUGm9qZyGXzagD65CrlqyPc2Wk3/
         zVVLsE8j64z4LPdyH9S/t3URJRaLV9AA37FZ3aOEtBRSIUc+iD/yoQPHvkbJdGENPQv3
         NrkF2GvenQ8B3yQIsobFAQqYA9DzUradJNADs3cCQ4oWHkr5NYX0KuAf+zlkvMJtY8b9
         AQGw==
X-Gm-Message-State: AOAM53120wzftyNzb6gnujfJZEUPqxPd5A2xpmzPCDeMMP9yeOymmNDo
        q5pClPUFJ+X1SphR4YFyf8kw06eq0Z9S
X-Google-Smtp-Source: ABdhPJzsMeo/xrJbwQkYxVif/skFCUSOvRRXThWyYMapAtRXXwil0Nb0ZYEq1vdIf9GrfCCo8bNRaw==
X-Received: by 2002:a02:6995:: with SMTP id e143mr15232305jac.78.1600132786287;
        Mon, 14 Sep 2020 18:19:46 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id i14sm8106717ilb.28.2020.09.14.18.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 18:19:45 -0700 (PDT)
Received: (nullmailer pid 650334 invoked by uid 1000);
        Tue, 15 Sep 2020 01:19:44 -0000
Date:   Mon, 14 Sep 2020 19:19:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        shawnguo@kernel.org, leoyang.li@nxp.com, lorenzo.pieralisi@arm.com,
        gustavo.pimentel@synopsys.com, minghuan.Lian@nxp.com,
        mingkai.hu@nxp.com, roy.zang@nxp.com
Subject: Re: [PATCH 2/7] PCI: layerscape: Change to use the DWC common
 link-up check function
Message-ID: <20200915011944.GB640859@bogus>
References: <20200907053801.22149-1-Zhiqiang.Hou@nxp.com>
 <20200907053801.22149-3-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907053801.22149-3-Zhiqiang.Hou@nxp.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 07, 2020 at 01:37:56PM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> The current Layerscape PCIe driver directly uses the physical layer
> LTSSM code to check the link-up state, which treats the > L0 states
> as link-up. This is not correct, since there is not explicit map
> between link-up state and LTSSM. So this patch changes to use the
> DWC common link-up check function.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-layerscape.c | 141 ++------------------
>  1 file changed, 10 insertions(+), 131 deletions(-)

IIRC, the common function uses a debug register. I've been wondering do 
the common PCIe config space registers not work on DWC? If you have an 
answer, that would be great for some potential additional cleanups.

Either way,

Reviewed-by: Rob Herring <robh@kernel.org>
