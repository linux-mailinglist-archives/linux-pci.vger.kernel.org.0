Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02121275C9A
	for <lists+linux-pci@lfdr.de>; Wed, 23 Sep 2020 17:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgIWP57 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Sep 2020 11:57:59 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:40739 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWP57 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Sep 2020 11:57:59 -0400
Received: by mail-il1-f196.google.com with SMTP id x18so75298ila.7;
        Wed, 23 Sep 2020 08:57:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=txDlgw5Bf9IwXnvVJljxpiAPXF0bdeBy+py2X0cNpxg=;
        b=dBnMJHCbc+vueyhADrWcC8diJM/Cck5Or1SlzG2t0KwUtHpdprTBJDX2OVOP3IZJ7X
         I5yY4R6jrXQm8l1KZd1aM04TeTkDxucxcmE37QBQpNThJ00EQwffP8/lp9gJYyBCk5+N
         2mKpmVyswmEz07ziFZxDfJHJV2RfXkq787HnfqDpmjfV3HxeAXr7Hh70RiUOXWoXW29+
         EwT2ANI8zpWAA6KbIAO2j9JYzM3SSL7VrF302V8+snzGzKGYBntR04EJ4GaOTl1nFpkP
         RNiITXfAzeMeTDgsreLuWnLqKdB/JSCJzGd0Br72Eh6mOpeO2kVRGReHBgXgURHblki5
         MZnw==
X-Gm-Message-State: AOAM532qsYlQNiJJ48JYHAWZR4jKkdRD1PvK5nMnRnmyzWiAPNrLUG5y
        gPeSr/I6At3lZZqV8WLGMw==
X-Google-Smtp-Source: ABdhPJyx9JiNIYrs6mKnVC7PC9GtC7DngQLljxmowj72q+fpoIOp/HOpV4MRkJ7w/RS7pUamvWtiBw==
X-Received: by 2002:a92:d5c5:: with SMTP id d5mr421091ilq.204.1600876677722;
        Wed, 23 Sep 2020 08:57:57 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id v24sm122415ioh.21.2020.09.23.08.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 08:57:57 -0700 (PDT)
Received: (nullmailer pid 827354 invoked by uid 1000);
        Wed, 23 Sep 2020 15:57:55 -0000
Date:   Wed, 23 Sep 2020 09:57:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] PCI: keystone: Remove iATU register mapping
Message-ID: <20200923155755.GB820801@bogus>
References: <1599814203-14441-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1599814203-14441-4-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599814203-14441-4-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 11, 2020 at 05:50:03PM +0900, Kunihiko Hayashi wrote:
> After applying "PCI: dwc: Add common iATU register support",
> there is no need to set own iATU in the Keystone driver itself.
> 
> Cc: Murali Karicheri <m-karicheri2@ti.com>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  drivers/pci/controller/dwc/pci-keystone.c | 20 ++++----------------
>  1 file changed, 4 insertions(+), 16 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
