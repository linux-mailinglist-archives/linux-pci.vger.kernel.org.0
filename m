Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B885A57F2
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2019 15:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730996AbfIBNix (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Sep 2019 09:38:53 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36441 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730986AbfIBNiw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Sep 2019 09:38:52 -0400
Received: by mail-wm1-f67.google.com with SMTP id p13so14702839wmh.1;
        Mon, 02 Sep 2019 06:38:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:cc:cc:to;
        bh=0G2XADeynFuPjiLzfSNxzmGMI3r/vAlX0cOg51TMaCc=;
        b=X2QMol6wsBvmurUROVC/9p7obrk9iNJLwijy5r0X9UVkuhBdrhnsoNEg5NPyg+cKCo
         f/A4FEVoLJ+bk2XzZDPLfUBKFAn1SHMuONo8agLlxR2F8o6jqJmkqHZ/2WOOY0bj0sjd
         xghLR6HI0JVHXEQHttmTL2fhPduPG25x/srTiKnk1nVo3zHsNhnMfqNHsUtNVVxYJIkz
         pmmMGH5w3iAMw7jP4GNC1aq1HvRCwSCvWj99zoV6mOQ3Q30vXkp0w/tIeBltK7XUIa03
         9YHSaDFfvGNj1lnEKjdrX+3k1vCcCE+gDTFQ5Rn7ip6Fxbm4svojaTTox2MofpSjau3V
         VoUg==
X-Gm-Message-State: APjAAAXZ2B+K8vnCByO3irtphOn29OdzVg5RubP3o00b5tUI2AtSFPAZ
        N2LXEO3hYVHN2lAoxB+sEw==
X-Google-Smtp-Source: APXvYqx1e5Zkxsk3Ce3KB0Mb7arC+lP6QY5ByoQI4X1nqKl5ANCYgQFP9ZkUgXnplhcziaRlN7UGYg==
X-Received: by 2002:a7b:c407:: with SMTP id k7mr10252310wmi.151.1567431530772;
        Mon, 02 Sep 2019 06:38:50 -0700 (PDT)
Received: from localhost ([212.187.182.166])
        by smtp.gmail.com with ESMTPSA id e30sm22061341wra.48.2019.09.02.06.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 06:38:50 -0700 (PDT)
Message-ID: <5d6d1b6a.1c69fb81.73f8d.ac61@mx.google.com>
Date:   Mon, 02 Sep 2019 14:38:49 +0100
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V3 1/6] dt-bindings: PCI: tegra: Add sideband pins configuration entries
References: <20190828172850.19871-1-vidyas@nvidia.com> <20190828172850.19871-2-vidyas@nvidia.com>
In-Reply-To: <20190828172850.19871-2-vidyas@nvidia.com>
Content-Type: text/plain
Cc:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <andrew.murray@arm.com>
CC:     <kishon@ti.com>, <gustavo.pimentel@synopsys.com>,
        <digetx@gmail.com>, <mperttunen@nvidia.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 28 Aug 2019 22:58:45 +0530, Vidya Sagar wrote:
> Add optional bindings "pinctrl-names" and "pinctrl-0" to describe pin
> configuration information of a particular PCIe controller.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V3:
> * None
> 
> V2:
> * None
> 
>  .../devicetree/bindings/pci/nvidia,tegra194-pcie.txt      | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

