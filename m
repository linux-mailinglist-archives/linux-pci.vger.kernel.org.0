Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5AABD23F
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2019 20:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730736AbfIXS7Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Sep 2019 14:59:24 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37913 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbfIXS7Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Sep 2019 14:59:24 -0400
Received: by mail-pg1-f194.google.com with SMTP id x10so1804396pgi.5
        for <linux-pci@vger.kernel.org>; Tue, 24 Sep 2019 11:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=S+NemDcyACE9qaE3AzZLyHri3U+LN0BbGdBBWP83xAQ=;
        b=C6+uN6EFptObBbReMx4otiZx5Z/xanbuyya/+Ka+EGaS1zvrzaICMGr1kf+Ke7gRpV
         PfQEj9G8xcA/t+Lqa7K71ZZ2bZOFxa7t6+gjOcc7MLayuBgYzbf/NUPAdFUEPH6PGn7n
         zpMaKwedE7HVNxymY+ZW7OR99yVBPJAXmjiR4xd4zHCObJuFL6e1foJNWo39kraazHHo
         fBoSH0k/r1oAbb3XqOfsq/2CUhpHAs47LcxEahsSFrCYlWrm6ICUE8YNl9ZJfU/IDm1Q
         v2N5MmSucHAsNvjrf9ivzpewivzKVtxO9zL+AbUZdMfpQUqTr1zU4YbYltuFYNLCh4R9
         pYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=S+NemDcyACE9qaE3AzZLyHri3U+LN0BbGdBBWP83xAQ=;
        b=WwDkMFoAM4pj8RzOSruMvLVDKdj3aSaWryZ7dvkn3tPzq85aqn63uK1+/KfgHE1bHK
         pY6XfI+GY5Ul9bqWBQ3m98JVpPEHJO2xTJoW078+3Kkx1jSfR3SpZijQtXziuCS49lPW
         e84kpEAEc8PQgNa8Sqv9N4ElZwsVb7Vi25ijp/5G0FyXwy4IGughEhhimEpOH17dRl6I
         wZ8lcqvx5UksXUFMFhp8B/ze7lbJonxzG9AZEtEKM1/Q+YGpDxrSU5DhWvNvVK8y8ACG
         IIM5Gp5EYm3v0nes2tgdFN3r0mL/I8JtV/yfY6GgcGCGA0Np2ZA4gLdwwzpQaIM0l3Ow
         RZDw==
X-Gm-Message-State: APjAAAVrXQPNKIJ2ZhVTwn//r4+VeUXwmc5H9NzB7WuU/F/cPLMktbco
        huebFESbnbBdPYDCDMGC2lGsdQ==
X-Google-Smtp-Source: APXvYqwBoEwDBTyuhiKLpoZslSVm3448hn+4VMKYnLGOo9+/IWR6JjsrRaebH1qxvZxp8hANK6Y9FQ==
X-Received: by 2002:aa7:8e55:: with SMTP id d21mr4895272pfr.241.1569351563237;
        Tue, 24 Sep 2019 11:59:23 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id 69sm3370025pfb.145.2019.09.24.11.59.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Sep 2019 11:59:22 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        lorenzo.pieralisi@arm.com, kishon@ti.com, bhelgaas@google.com,
        andrew.murray@arm.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        yue.wang@Amlogic.com, maz@kernel.org, repk@triplefau.lt,
        nick@khadas.com, gouwa@khadas.com
Subject: Re: [PATCH v2 0/6] arm64: dts: meson-g12: add support for PCIe
In-Reply-To: <20190916125022.10754-1-narmstrong@baylibre.com>
References: <20190916125022.10754-1-narmstrong@baylibre.com>
Date:   Tue, 24 Sep 2019 11:59:21 -0700
Message-ID: <7h4l117c6u.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> This patchset :
> - updates the Amlogic PCI bindings for G12A
> - reworks the Amlogic PCIe driver to make use of the
> G12a USB3+PCIe Combo PHY instead of directly writing in
> the PHY register
> - adds the necessary operations to the G12a USB3+PCIe Combo PHY driver
> - adds the PCIe Node for G12A, G12B and SM1 SoCs
> - adds the commented support for the S922X, A311D and S905D3 based
> VIM3 boards.
>
> The VIM3 schematic can be found at [1].
>
> This patchset is dependent on Remi's "Fix reset assertion via gpio descriptor"
> patch at [2].
>
> This patchset has been tested in a A311D VIM3 and S905D3 VIM3L using a
> 128Go TS128GMTE110S NVMe PCIe module.
>
> For indication, here is a bonnie++ run as ext4 formatted on the VIM3:
>      ------Sequential Output------ --Sequential Input- --Random-
>      -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
> Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP /sec %CP
>   4G 93865  99 312837  96 194487  23 102808  97 415501 21 +++++ +++
>
> and the S905D3 VIM3L version:
>      ------Sequential Output------ --Sequential Input- --Random-
>      -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
> Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
>   4G 52144  95 71766  21 47302  10 57078  98 415469  44 +++++ +++
>
> Changes since v1 at [3]:
>  - Collected Andrew's and Rob's Reviewed-by tags
>  - Added missing calls to phy_init/phy_exit
>  - Fixes has_shared_phy handling for MIPI clock
>  - Add comment in the DT concerning firmware setting the right properties
>  - Added SM1 Power Domain to PCIe node
>
> [1] https://docs.khadas.com/vim3/HardwareDocs.html
> [2] https://patchwork.kernel.org/patch/11125261/
> [3] https://patchwork.kernel.org/cover/11136927/
>
> Neil Armstrong (6):
>   dt-bindings: pci: amlogic,meson-pcie: Add G12A bindings
>   PCI: amlogic: Fix probed clock names
>   PCI: amlogic: meson: Add support for G12A
>   phy: meson-g12a-usb3-pcie: Add support for PCIe mode
>   arm64: dts: meson-g12a: Add PCIe node
>   arm64: dts: khadas-vim3: add commented support for PCIe

Queued the "arm64: dts" patches for v5.5,

Kevin
