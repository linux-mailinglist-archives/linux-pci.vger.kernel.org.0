Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F608B2230
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2019 16:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730756AbfIMOgV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Sep 2019 10:36:21 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36855 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730648AbfIMOgV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Sep 2019 10:36:21 -0400
Received: by mail-oi1-f195.google.com with SMTP id k20so2820268oih.3;
        Fri, 13 Sep 2019 07:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:cc:cc:to;
        bh=YbpiQzIM3eQL4XQ34vYEddsWeG9VMivV31FLcj+hIuc=;
        b=svixVnZ7CKZWaP7JBaG/glH2tHA25Lb4bBiq2GIUrE7gYRVXEJSvCZsOHHBm2u1Qwp
         5eKjDEdZTF7aNAZRT8VozO3zC5oW+w9d034K0tH9vbUyRqUmaH2Hz802U26mi6exDWD4
         bWa0kg/C37GsvdQW/UYflW9sVwoBMsFSx8xI+RsVkht+fjUim7NR0VXmaDY8A5qmMB8/
         tY3k+cfjTdKCL4uwpRuwRxmt3DsJrpTK/lxqXK+53YeQ0PdOciCexreIZmuj09J7opKv
         ZYe5rU6KFjcWFRUYpdNSjmcU36nlUrxSmpZYupZQlqCmxfSYa8Wy3/XuA6FIjoerhDEs
         eJBg==
X-Gm-Message-State: APjAAAXALwTREIL+yb6sFZVqHyDCXgAyb8FpqPiq4BKPvYveFzTHMTBe
        fWlAMUJiBR1t6yz+NQ+B/Q==
X-Google-Smtp-Source: APXvYqyjj6rIVWDuqKwqqDB6O49ywBjZD3PZQ4+xjM00i6c2gbMnanfPNY4AfSDhsOstHiycfTtKVQ==
X-Received: by 2002:aca:ed0a:: with SMTP id l10mr3624662oih.83.1568385380257;
        Fri, 13 Sep 2019 07:36:20 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h20sm4239119otj.81.2019.09.13.07.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 07:36:19 -0700 (PDT)
Message-ID: <5d7ba963.1c69fb81.4869.eb19@mx.google.com>
Date:   Fri, 13 Sep 2019 15:36:18 +0100
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/6] dt-bindings: pci: amlogic,meson-pcie: Add G12A bindings
References: <1567950178-4466-1-git-send-email-narmstrong@baylibre.com> <1567950178-4466-2-git-send-email-narmstrong@baylibre.com>
In-Reply-To: <1567950178-4466-2-git-send-email-narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, yue.wang@Amlogic.com, kishon@ti.com,
        devicetree@vger.kernel.org
Cc:     repk@triplefau.lt, Neil Armstrong <narmstrong@baylibre.com>,
        maz@kernel.org, linux-amlogic@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
To:     Neil Armstrong <narmstrong@baylibre.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun,  8 Sep 2019 13:42:53 +0000, Neil Armstrong wrote:
> Add PCIE bindings for the Amlogic G12A SoC, the support is the same
> but the PHY is shared with USB3 to control the differential lines.
> 
> Thus this adds a phy phandle to control the PHY, and sets invalid
> MIPI clock as optional for G12A.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../devicetree/bindings/pci/amlogic,meson-pcie.txt   | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

