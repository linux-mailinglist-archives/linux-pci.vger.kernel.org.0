Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53A672A0D6F
	for <lists+linux-pci@lfdr.de>; Fri, 30 Oct 2020 19:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgJ3Scd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Oct 2020 14:32:33 -0400
Received: from mail-oo1-f66.google.com ([209.85.161.66]:37825 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbgJ3Scb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Oct 2020 14:32:31 -0400
Received: by mail-oo1-f66.google.com with SMTP id f25so1820619oou.4;
        Fri, 30 Oct 2020 11:31:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JL7tBQPFa/wNgOqpZzofCb+/SCrLWucF9tNzz58UpHE=;
        b=tsF2Sy8A/WyVgknYAHDxsswG4oosZ/0GQNFSTGg4z6gnlZgmdELg3DSeT2GuNavCnX
         FLD2FyZGAujMWrUVTckpbXvpvjF99klWB/BQlIRLL15RF1ApQocZu20WbGYcL7lkygkT
         ILeFuo0TUsm/fJa3e+++4v66iUjfOR2oW2gU13dEWmraznni9hjzuEw2c7WvgsvgMunr
         Pf5SgqmpuRoavIN7VTUCn2ddBp2CY+YbKfcuJjdq3uITEPDiQkk2ZQu4jZ0TYWOfTphI
         YMj5pKyfj0TWQKkJCtXS2d6rMyXkN7HmEBijLd0vMfOV949whtqO3/ZO4iYIb2v/TWos
         vSFg==
X-Gm-Message-State: AOAM531L7ktVqkwBf8U7mWHWaPGI+hSaaKsbpUjRknAWdxEYdstS/Q/s
        EKX3kT6YSE0FVZwIZZ3X6g==
X-Google-Smtp-Source: ABdhPJzk4MpgRkuoEicJMKEsUPr6GWrKKzg2550RpTAlbzDGLLzCnUX7KQH8myvUGN0/AMM2FMPofw==
X-Received: by 2002:a4a:d104:: with SMTP id k4mr3040292oor.0.1604082709416;
        Fri, 30 Oct 2020 11:31:49 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t20sm1590416oic.1.2020.10.30.11.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 11:31:48 -0700 (PDT)
Received: (nullmailer pid 4110275 invoked by uid 1000);
        Fri, 30 Oct 2020 18:31:47 -0000
Date:   Fri, 30 Oct 2020 13:31:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc:     mingkai.hu@nxp.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        minghuan.Lian@nxp.com, linux-kernel@vger.kernel.org,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com, roy.zang@nxp.com
Subject: Re: [PATCH 1/2] dt-bindings: pci: layerscape-pci: Add compatible
 strings for LX2160A rev2
Message-ID: <20201030183147.GA4110222@bogus>
References: <20201026051448.1913-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026051448.1913-1-Zhiqiang.Hou@nxp.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 26 Oct 2020 13:14:47 +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Add PCIe Endpoint mode compatible string "fsl,lx2160ar2-pcie-ep"
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
>  Documentation/devicetree/bindings/pci/layerscape-pci.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
