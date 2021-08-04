Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB963E0304
	for <lists+linux-pci@lfdr.de>; Wed,  4 Aug 2021 16:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238701AbhHDOYC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Aug 2021 10:24:02 -0400
Received: from mail-il1-f179.google.com ([209.85.166.179]:47081 "EHLO
        mail-il1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238720AbhHDOYB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Aug 2021 10:24:01 -0400
Received: by mail-il1-f179.google.com with SMTP id r5so1806878ilc.13;
        Wed, 04 Aug 2021 07:23:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WdvC2QQZczkPPiRhwZ3H7jitYOKgBmLr9KfGV8jan3Q=;
        b=OaqUPg6nOtQsZ/+/XNsea3mE23aiPYAz05nsfTqxgkzV/yU0djdP7OF6hskDSZF/nh
         TUfSIXSXwiD+qKIjJ8pFC473uzLzLGRXw2WwL//z8o5xsHa4mZBQf9RO+vKSo7SnWNJS
         6yx269qvW1JDEtfWgtb163HbA83Rpm8Z3DF+iZcNARagxZZzwfyGI82Az/XjPQuFd8oG
         3TKdH7ISf6hB2XIop9o6AEQrLZXqzQtuA8IlDATiTOZzC1raKj/6e5ZZ2h3gF4F6AidG
         5UnojUkcr1yMtnuq8ECj00Zf5d4Y6MKNXlavWjW+j2unPXb7f481wN4sBv+x/Tl2lhys
         /vKQ==
X-Gm-Message-State: AOAM532FwWpFFUxSmqLpm4xjsyvqrG4JgW4ddgDf7pLR8aHG8+kGbUo2
        INwzfoDhyWpDUHv2cnRx8A==
X-Google-Smtp-Source: ABdhPJw7bx2dLsqyOwPlmzcPc3KiT6Lm13Sm8lE5O4HBavfxf6PXuWkVO1Ycb2M4SILiDsK6wQ4fNA==
X-Received: by 2002:a05:6e02:ec1:: with SMTP id i1mr3346361ilk.261.1628087027527;
        Wed, 04 Aug 2021 07:23:47 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id g11sm1152443ilc.83.2021.08.04.07.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 07:23:46 -0700 (PDT)
Received: (nullmailer pid 1149454 invoked by uid 1000);
        Wed, 04 Aug 2021 14:23:45 -0000
Date:   Wed, 4 Aug 2021 08:23:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxarm@huawei.com,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>, mauro.chehab@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] dt-bindings: PCI: kirin: Add support for Kirin970
Message-ID: <YQqi8ZkpdpYxM86s@robh.at.kernel.org>
References: <cover.1628061310.git.mchehab+huawei@kernel.org>
 <875a4571e253040d3885ee1f37467b0bade7361b.1628061310.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875a4571e253040d3885ee1f37467b0bade7361b.1628061310.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 04 Aug 2021 09:18:56 +0200, Mauro Carvalho Chehab wrote:
> Add a new compatible, plus the new bindings needed by
> HiKey970 board.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../bindings/pci/hisilicon,kirin-pcie.yaml    | 76 ++++++++++++++++++-
>  1 file changed, 75 insertions(+), 1 deletion(-)
> 

Applied, thanks!
