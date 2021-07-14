Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 062A13C9117
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jul 2021 22:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241051AbhGNT5s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Jul 2021 15:57:48 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:41934 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240778AbhGNTuE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Jul 2021 15:50:04 -0400
Received: by mail-io1-f42.google.com with SMTP id z9so3538219iob.8;
        Wed, 14 Jul 2021 12:47:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3V8nZmi/KX6WV/3eY0dps9KX5cZgW01GINnuyCZFNQ8=;
        b=lkca+N7KzKC7iSwakJfi+XnZk2e2bROh/CchHE7/ukwkxM88OtsdEqbhShQem/EfeR
         KKtfAKxFVOJ6pKbKoW6GLStUmV10E0dhbaekDGFsZDSDl97vRIRu04elCsLShwVW7U2P
         NGBAs0GOTs85tggaob750INCz+MDFluvL6MO3QSzliA1DrxFI4YR11VYgkDOeoH8C32F
         PAgj/9LXS1hLW2v487PDwvKUy2Z0KbvNozidaLtvDmVhhLCJsZVUw/kpVak/dIzSxX2t
         KhEouHZNfKAD2WrXn1x2KyrQDiacvp/8coukg0xp02QmD64rGTRlSLfPLXfghOE0yimJ
         /bfQ==
X-Gm-Message-State: AOAM533FYnBx8qjpwINoqs4WYQlOaviEBf+PZ5Kt6pNilf5CgBOeXzNP
        x6Y5EgK/rmWEAsdBVB3Gtg==
X-Google-Smtp-Source: ABdhPJwpbtBXJYHQG5252lxL69KkSHkS5KRtgQnqEhEK/RRyDCmq/ly16p21u7NdLsnKBh1SpzA4dA==
X-Received: by 2002:a5d:87cc:: with SMTP id q12mr8285823ios.131.1626292031269;
        Wed, 14 Jul 2021 12:47:11 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id b3sm1594371ilm.73.2021.07.14.12.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 12:47:10 -0700 (PDT)
Received: (nullmailer pid 3236404 invoked by uid 1000);
        Wed, 14 Jul 2021 19:47:08 -0000
Date:   Wed, 14 Jul 2021 13:47:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     git@xilinx.com, monstr@monstr.eu, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        kw@linux.com, bharat.kumar.gogada@xilinx.com,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: pci: xilinx-nwl: Document optional
 clock property
Message-ID: <20210714194708.GA3236304@robh.at.kernel.org>
References: <cover.1624618100.git.michal.simek@xilinx.com>
 <67aa2c189337181bb2d7721fb616db5640587d2a.1624618100.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67aa2c189337181bb2d7721fb616db5640587d2a.1624618100.git.michal.simek@xilinx.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 25 Jun 2021 12:48:22 +0200, Michal Simek wrote:
> Clock property hasn't been documented in binding document but it is used
> for quite a long time where clock was specified by commit 9c8a47b484ed
> ("arm64: dts: xilinx: Add the clock nodes for zynqmp").
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> (no changes since v2)
> 
> Changes in v2:
> - new patch in this series because I found that it has never been sent
> 
> Bharat: Can you please start to work on converting it to yaml?
> 
> ---
>  Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
