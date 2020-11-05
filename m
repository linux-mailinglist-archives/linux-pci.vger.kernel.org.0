Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6092A86D7
	for <lists+linux-pci@lfdr.de>; Thu,  5 Nov 2020 20:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbgKETOH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Nov 2020 14:14:07 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37045 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgKETOH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Nov 2020 14:14:07 -0500
Received: by mail-ed1-f67.google.com with SMTP id o18so2737278edq.4;
        Thu, 05 Nov 2020 11:14:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9uvURPvj7B5P83nYrPUSyxNV6gQLGlu0kUqoJCS5FWM=;
        b=pxyq7RhC4xVTOqpeV0mQYZAjktLYVx1F6c/cDYCcIJK6QrQiiS4D5+WNGUflRHcq+S
         FDu3LjTkB9Ptbzr5kcXRMnjzbE7S+qFT9rAOMGhKJPy/IBOGZ/jvUrHxfGedTihKnYNv
         +3JLqyMNHVOEhRhRTfTpEmx0sJrZ41kVG+BUX+w8sIFkkBxQXlIeCzeTs7N2KTsLsl8f
         Z/Apcu69QH+mjZ4uNJkIhv/yDmgOwnwMpjIYQK0d7kWTjGS4XxYmrvzbKGyxMdJw9xG8
         5D+7vyegsBmnU7otHLRrbYm8zSnHsbqaGHAUIIMJwvRlgU9jxgiEqCqlaDgv6l1ICoiy
         +Nng==
X-Gm-Message-State: AOAM532pXSQu2Qc6Hl2x48u5ubKkwoUSHvAHmIkh3CUajuUoXE3bbqZu
        XM25JSudt6gvsDJAfsLVyE/WF8GAEEXKWw==
X-Google-Smtp-Source: ABdhPJwNugFlHE/GYqtajRIiVNoCiM3JB/yB1rVTLLTc7FECViAmctzwBfFiDKmLpt3kslUkP/Oaow==
X-Received: by 2002:a50:8a88:: with SMTP id j8mr4223450edj.179.1604603643447;
        Thu, 05 Nov 2020 11:14:03 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id c8sm1478949edr.29.2020.11.05.11.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 11:14:02 -0800 (PST)
Date:   Thu, 5 Nov 2020 20:14:00 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-samsung-soc@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 6/6] arm64: dts: exynos: add the WiFi/PCIe support to
 TM2(e) boards
Message-ID: <20201105191400.GB226037@kozik-lap>
References: <20201029134017.27400-1-m.szyprowski@samsung.com>
 <CGME20201029134040eucas1p2a8958b44842a8a4647e3aa4521c75725@eucas1p2.samsung.com>
 <20201029134017.27400-7-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201029134017.27400-7-m.szyprowski@samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 29, 2020 at 02:40:17PM +0100, Marek Szyprowski wrote:
> From: Jaehoon Chung <jh80.chung@samsung.com>
> 
> Add the nodes relevant to PCIe PHY and PCIe support. PCIe is used for the
> WiFi interface (Broadcom Limited BCM4358 802.11ac Wireless LAN SoC).
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> [mszyprow: rewrote commit message, reworked board/generic dts/dtsi split]
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  .../boot/dts/exynos/exynos5433-pinctrl.dtsi   |  2 +-
>  .../dts/exynos/exynos5433-tm2-common.dtsi     | 24 ++++++++++++-
>  arch/arm64/boot/dts/exynos/exynos5433.dtsi    | 36 +++++++++++++++++++

Thanks, applied.

Best regards,
Krzysztof

