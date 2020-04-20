Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB721B14F5
	for <lists+linux-pci@lfdr.de>; Mon, 20 Apr 2020 20:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgDTSoF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Apr 2020 14:44:05 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33053 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgDTSoF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Apr 2020 14:44:05 -0400
Received: by mail-ot1-f65.google.com with SMTP id j26so9061985ots.0;
        Mon, 20 Apr 2020 11:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AjTIxQ8I+Qkr8ilLvfcljNmqyjlrey4KznqBzKKGdKQ=;
        b=pTiYWagye9GlQPM6ZRwiqCv4hce3gmK3U7rTPdjUsn9v01FyRiEJmb6b1fqKayFVYV
         jMwwibpsRqWWXj1puB1TbFE9I/Bm2ZNzpnjGNC7cciz/NQaviLTI969uf2grZKxL59m0
         GYN1u8/cGSF4rmdnTNOKmQBzf4G5ZTffr+vTxhue5tTIHu5XzlSp93nKBN5+BxVVhD9W
         2KnNLnWaGN3ayE5+Tv9+KGzPnRSNSv0x5Srv8lsE0lVeplKkoDNEGDpd/MYDXxAAa66f
         koZVH8T03FAiUWT0Bm6Yz7dLS4vkKMUgZIvdaVog5JRWht7gXc6QBiln4fAlgOp2loFP
         oFNw==
X-Gm-Message-State: AGi0PuZVAGULaCsJTJKowciU3SKZhySEPFeJgwVIsTRRpaJx+aXfRB7m
        rNNyl1na/sEf6ckCDRidGw==
X-Google-Smtp-Source: APiQypKArsUevn5DTv5qxS+88LlVRsJwChYKR6jnMpJeLT+Ro5Cq2r0ARUCHlIFEHGVpENGwQITM0A==
X-Received: by 2002:a9d:4e3:: with SMTP id 90mr10933399otm.261.1587408243271;
        Mon, 20 Apr 2020 11:44:03 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n184sm42631oih.58.2020.04.20.11.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 11:44:02 -0700 (PDT)
Received: (nullmailer pid 23488 invoked by uid 1000);
        Mon, 20 Apr 2020 18:44:01 -0000
Date:   Mon, 20 Apr 2020 13:44:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH] dt-bindings: pci: rcar: add r8a77961 support
Message-ID: <20200420184401.GA23436@bogus>
References: <1586511020-31833-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586511020-31833-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 10 Apr 2020 18:30:20 +0900, Yoshihiro Shimoda wrote:
> Add support for r8a77961 (R-Car M3-W+).
> 
> To avoid confusion between R-Car M3-W (R8A77960) and R-Car M3-W+
> (R8A77961), this patch also updates the comment of
> "renesas,pcie-r8a7796".
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  Documentation/devicetree/bindings/pci/rcar-pci.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
