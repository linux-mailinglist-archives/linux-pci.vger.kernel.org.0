Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0782A57E6
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2019 15:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730916AbfIBNir (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Sep 2019 09:38:47 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38728 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730662AbfIBNir (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Sep 2019 09:38:47 -0400
Received: by mail-wm1-f66.google.com with SMTP id o184so14652741wme.3;
        Mon, 02 Sep 2019 06:38:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:cc:cc:to;
        bh=faCPHhQ5rgRAsdKZWiSwQZJyN/jDKt3kIUBJvduHWWk=;
        b=ZEtChirY8NRZkuyKv1mVzrtINRXYANYLEqIZHR9O3GOb1jXFRUs/DxWxvq1cveB/er
         jBUe/fQ3GO4MDExaX54kkWHmQoFlBEZ8+DnV6CVuzFT9YJfagpS9OF3lqR03McKh6bir
         oJ7AvOcyRiToINXtP2tzedq20qfueu6B3GbTf1QBvPzvsoW+43NoRRkADbonRE+Tyswm
         curtTnz4ZiGe/YuX5509sK84raqMB2VLghHi+0Tiraho2cAeXycLZiigKAPRoVtcjn3b
         WqHgUOzofxqALwQM1aCvsijlj5yz1s8UQBAmtTPxML5I27yb/Ab3YHlplfPkOIptEsFA
         6pXw==
X-Gm-Message-State: APjAAAVgavouDawtUeugVR9+i+gerq2SIYyArTJKUlEHD0L6k3uxA+Mc
        aMG6Gtgtz99ockCPjyt9ODwv/j+HVg==
X-Google-Smtp-Source: APXvYqxMiimKi1vQM/BUmHa7fcI+yEotranUAF4+pnmBN5r6CPbw9VKHVDVnILvqSYEeEWJ8vruglw==
X-Received: by 2002:a1c:8013:: with SMTP id b19mr17152619wmd.81.1567431524887;
        Mon, 02 Sep 2019 06:38:44 -0700 (PDT)
Received: from localhost ([212.187.182.166])
        by smtp.gmail.com with ESMTPSA id o129sm25062859wmb.41.2019.09.02.06.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 06:38:44 -0700 (PDT)
Message-ID: <5d6d1b64.1c69fb81.a5aa4.0864@mx.google.com>
Date:   Mon, 02 Sep 2019 14:38:43 +0100
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/6] dt-bindings: pci: Update iProc PCI binding for INTx support
References: <1566982488-9673-1-git-send-email-srinath.mannam@broadcom.com> <1566982488-9673-2-git-send-email-srinath.mannam@broadcom.com>
In-Reply-To: <1566982488-9673-2-git-send-email-srinath.mannam@broadcom.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Ray Jui <ray.jui@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 28 Aug 2019 14:24:43 +0530, Srinath Mannam wrote:
> From: Ray Jui <ray.jui@broadcom.com>
> 
> Update the iProc PCIe binding document for better modeling of the legacy
> interrupt (INTx) support
> 
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> ---
>  .../devicetree/bindings/pci/brcm,iproc-pcie.txt    | 48 ++++++++++++++++++----
>  1 file changed, 41 insertions(+), 7 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

