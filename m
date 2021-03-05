Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5F532F698
	for <lists+linux-pci@lfdr.de>; Sat,  6 Mar 2021 00:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbhCEX3C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Mar 2021 18:29:02 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:33993 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhCEX2e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Mar 2021 18:28:34 -0500
Received: by mail-ot1-f53.google.com with SMTP id h10so3485212otm.1;
        Fri, 05 Mar 2021 15:28:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SW4WNCIu9yLm24mAmkqpsJ6yNb9tL725pjfX6N25lMU=;
        b=FVKqFN0KAdjqvbC/3ltim+e2W6zNBVAToPLpeL28BECc6kZZEE2jJW2spMFALKX5/G
         q/qfZLuBuPdawBDuq0aswyHpX+K81EiA3j637SkbN0Py0mReP/CBNdwB4bjrmwU/ysk9
         /MI8MLVM9kmLgYxLCWjplRtIdluo1+czZIJf8n+pgxs0kdFzK/htWUVrZGuwSCek8uxN
         obU0PiCyzwON3lIpw3bIYxviBM6cpSsKfutu7u5FFRoMN2Q6J/4F7cQD+NUKBkRe+u+k
         fadSFaxZUhSSgUOZM6NwmCOII/wgrXS/2fQfUcKPLCZxr9/2cihgVhzNqTiPGhSWIuO3
         bC0w==
X-Gm-Message-State: AOAM530R+cKYzlFtn+m5l4AXApKdf7n9B6Cb3GnbDWf9SUuZtivQwWwV
        fhXkD+gLe1jIvH6n/h4imA==
X-Google-Smtp-Source: ABdhPJwWpklmREezIFpS8xK75h8ciQVtt/CHNPtluSE/ToE1AO22d1/4WBU03Q4be3DDfwJ6mEaebg==
X-Received: by 2002:a9d:12a4:: with SMTP id g33mr9957312otg.308.1614986913596;
        Fri, 05 Mar 2021 15:28:33 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w7sm864560oie.7.2021.03.05.15.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 15:28:32 -0800 (PST)
Received: (nullmailer pid 838458 invoked by uid 1000);
        Fri, 05 Mar 2021 23:28:31 -0000
Date:   Fri, 5 Mar 2021 17:28:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tom Joseph <tjoseph@cadence.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] dt-bindings: PCI: ti, j721e: Add host mode
 dt-bindings for TI's AM64 SoC
Message-ID: <20210305232831.GA838405@robh.at.kernel.org>
References: <20210222114030.26445-1-kishon@ti.com>
 <20210222114030.26445-3-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210222114030.26445-3-kishon@ti.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 22 Feb 2021 17:10:28 +0530, Kishon Vijay Abraham I wrote:
> Add host mode dt-bindings for TI's AM64 SoC. This is the same IP used in
> J7200, however AM64 is a non-coherent architecture.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../devicetree/bindings/pci/ti,j721e-pci-host.yaml    | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
