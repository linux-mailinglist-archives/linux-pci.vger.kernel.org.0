Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDE41EB18A
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jun 2020 00:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbgFAWN2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Jun 2020 18:13:28 -0400
Received: from mail-il1-f169.google.com ([209.85.166.169]:40150 "EHLO
        mail-il1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbgFAWN2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Jun 2020 18:13:28 -0400
Received: by mail-il1-f169.google.com with SMTP id t8so10421384ilm.7;
        Mon, 01 Jun 2020 15:13:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u/K0WP1l+S2GcJnU0hImQFyJlJg7afttDd6dL6wNR0s=;
        b=Fi9Mng/R0dlQb5Ztlueshh2UUDWomTkfdpPect48lAiWmv9N7fJvaGgoJp/0XFJ0L5
         AA+NqO/9pp8kUxW34cBn0OZIiUpp7bsj9xwfzHEN3sHybb+CAPe1Y7UgjM26YVkzB1xn
         FCjJ04qBigSXBF4YoNDcfDLO1/0ZsAY7r3Q8zR9RAxUmqayydSwl4MS4vWHpn5hBgAsv
         4Fzrnahbt+DRStQLLAufcu2NzExCPBYB8AB5U+6r5MtsxjR7p1R8EKXF+4i3dnlbOUSY
         7vS9PUDkl0lUzOLcNCBgmZIozRSy8kEx9citSgkERjNIphhWdxCIMM343hXijgqFny/z
         NPCQ==
X-Gm-Message-State: AOAM532WBQ4XHuf9ljXt5gZj02nI3pZceHQsQB1YNu/BZAMEjgIC+l+l
        EqQTEuxbMwjeLuBj/g+G7w==
X-Google-Smtp-Source: ABdhPJw7TTct/NTs7/1Xtdll5C5FrVfNlSwqolhiKMR2OuZ39yvyQUpvMY03HJxl5RvUc47lC/fNEA==
X-Received: by 2002:a92:778b:: with SMTP id s133mr20588388ilc.99.1591049607389;
        Mon, 01 Jun 2020 15:13:27 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id f26sm265694ion.23.2020.06.01.15.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 15:13:26 -0700 (PDT)
Received: (nullmailer pid 1602852 invoked by uid 1000);
        Mon, 01 Jun 2020 22:13:25 -0000
Date:   Mon, 1 Jun 2020 16:13:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dejin Zheng <zhengdejin5@gmail.com>
Cc:     thomas.petazzoni@bootlin.com, bhelgaas@google.com,
        pratyush.anand@gmail.com, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, tjoseph@cadence.com, jonnyc@amazon.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] PCI: controller: Remove duplicate error message
Message-ID: <20200601221325.GA1602793@bogus>
References: <20200526150954.4729-1-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526150954.4729-1-zhengdejin5@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 26 May 2020 23:09:54 +0800, Dejin Zheng wrote:
> It will print an error message by itself when
> devm_pci_remap_cfg_resource() goes wrong. so remove the duplicate
> error message.
> 
> Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
> ---
>  drivers/pci/controller/cadence/pcie-cadence-host.c |  4 +---
>  drivers/pci/controller/dwc/pcie-al.c               | 13 +++----------
>  drivers/pci/controller/dwc/pcie-armada8k.c         |  1 -
>  drivers/pci/controller/dwc/pcie-spear13xx.c        |  1 -
>  4 files changed, 4 insertions(+), 15 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
