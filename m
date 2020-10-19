Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D072E292F26
	for <lists+linux-pci@lfdr.de>; Mon, 19 Oct 2020 22:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbgJSUHz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Oct 2020 16:07:55 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35496 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbgJSUHz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Oct 2020 16:07:55 -0400
Received: by mail-oi1-f193.google.com with SMTP id w141so1373836oia.2;
        Mon, 19 Oct 2020 13:07:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=22K4eTas0BJ7J9uGzGzaZteEURxGE4VcHw+8CKvhgqw=;
        b=EolNcHy6xB3q5Iv0oQzOgxRdoWZVo+V1E2UgAmQ6UCUkCrtjrpA7yvyqcpGzItS8+W
         0Raw3R7UdcAASklROPuTg6mpXor+O7dUgd2xy+YivW7mIcAFeq9iFTB92ICU2ElcucjM
         Iu22JwHTrJWxm7IbKA2JdTWn7ttRysptmJalDZM8OEsCofZfjjeZQtSokLE5ipufln65
         EBdvrEnAMwY7mIlZhcKn7q6gCBlwTH80CtUkRFEXPnDGJ63Pmn5/vNa31patCSFRecOG
         4MqH/UhA9yWGPtQDdIOGXiesWeOur/MyGPAhQpOuuqFiDxWTSCdwume/D1Q3gVwJopcl
         D+rQ==
X-Gm-Message-State: AOAM530LgBYgDcSq+Mf8XtFCm6JT7U0cuF9jledK/TJVWp10BU97zBTz
        X8t2NZLTieAXJBupgFQnYQ==
X-Google-Smtp-Source: ABdhPJyqxqRlhym9OJfINJldAu5slGwuzgZv7U9BAMNz8EWFeNoX0yh9zCGJZGpHlqH5aIDUhJLHxw==
X-Received: by 2002:aca:c410:: with SMTP id u16mr786432oif.65.1603138074506;
        Mon, 19 Oct 2020 13:07:54 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s21sm176722otr.77.2020.10.19.13.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 13:07:53 -0700 (PDT)
Received: (nullmailer pid 3521721 invoked by uid 1000);
        Mon, 19 Oct 2020 20:07:52 -0000
Date:   Mon, 19 Oct 2020 15:07:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-samsung-soc@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 1/6] Documetation: dt-bindings: drop
 samsung,exynos5440-pcie binding
Message-ID: <20201019200752.GA3513040@bogus>
References: <20201019094715.15343-1-m.szyprowski@samsung.com>
 <CGME20201019094738eucas1p29b377b561089cfc3eba1755d475125b9@eucas1p2.samsung.com>
 <20201019094715.15343-2-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019094715.15343-2-m.szyprowski@samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 19, 2020 at 11:47:10AM +0200, Marek Szyprowski wrote:
> Exynos5440 SoC support has been dropped since commit 8c83315da1cf ("ARM:
> dts: exynos: Remove Exynos5440"). Drop the obsolete bindings for
> exynos5440-pcie.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  .../bindings/pci/samsung,exynos5440-pcie.txt  | 58 -------------------
>  1 file changed, 58 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/samsung,exynos5440-pcie.txt

Reviewed-by: Rob Herring <robh@kernel.org>
