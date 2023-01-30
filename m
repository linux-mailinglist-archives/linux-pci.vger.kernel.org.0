Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E13680F6B
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jan 2023 14:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjA3NxZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Jan 2023 08:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234171AbjA3NxY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Jan 2023 08:53:24 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E583FF30;
        Mon, 30 Jan 2023 05:53:22 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-16346330067so15054482fac.3;
        Mon, 30 Jan 2023 05:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+5GJJ8rF8aG9dI5EbSjlK95PxeFIXWfHHihmcthWAs=;
        b=YCRjwoQh8w55DxFX7ywSf15CQ/HLQvuQHgEbEu2QNTlg/Vku7oaRNt/rSHcoTg8QJ2
         /Wrvugdm/vWwL+ts1R0apxqa7C1QHD0JdtMTH6G5BKsikktGtFQ7F52nvB7CCyJSMOk0
         +2x4LcJO5Z2uQ+/kp9GB9MU/x1Edauk5zFGuqAQQFhvAo5YWNE4boX6U3HoxGy3U8Kqg
         DIaFqbYsC356z5nCO1/R6qHQ5OlECpOrkanzIk9eForSjPi9ABlxE9MzTneRzqLSANZl
         6Rl3wa16NjlLXKDWpUomoZBcHyG/GbTmK8stiUFNelFz/VTC1KDvQdfztV5zNWp2WED6
         nDew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y+5GJJ8rF8aG9dI5EbSjlK95PxeFIXWfHHihmcthWAs=;
        b=MOTAT92Y1Wy6wO8njRc6lCx/eTu54aughqw6Z4FiuuVr18FXH8+3bQY12Sis9QGmgT
         KFmBETkXkOklmIehyJFuulPfGZUV/i+SN8iZfoA88XCNxV7jc/yhjxp4RnaqA6yOQOO+
         /PcypDTeLs+tZpmXyA77U2DHNAhlu0Jxc9Lryjn3t2ukS7sNPO0qCt9qvmnYJlSv3CR3
         gax5WSvkWjDkLN4o/LR1oQnufivR9n1FKabNJqhfdej3+MzHufF3pm5FXR1ljyjAztRI
         NPj1Tx1isH/gPqSqa03TnuPxTf+U2+gvTRCANnYJlQjZBHXI4Z6K1qC7THBSI0v2WKNe
         RKBg==
X-Gm-Message-State: AO0yUKXVpLk6IqfY/B/KV6+kFWd7jbwEkpsROX0e9Efz1ykPI3HIAtPy
        SPY1p0/ZkGh/2mfkv/SGBAbggXbQJZoN7/+Rruo=
X-Google-Smtp-Source: AK7set8HEtjjr43uCKJQ7ULAJehzLK+fcnNTlwlz4cpiMXvVOL918RIGhn69NbrifIDqtfn9qnyHzlnC7A98A43mURo=
X-Received: by 2002:a05:6871:8a6:b0:163:9dc0:78f1 with SMTP id
 r38-20020a05687108a600b001639dc078f1mr726478oaq.265.1675086801813; Mon, 30
 Jan 2023 05:53:21 -0800 (PST)
MIME-Version: 1.0
References: <20230126135049.708524-1-rick.wertenbroek@gmail.com>
 <20230126135049.708524-6-rick.wertenbroek@gmail.com> <871ab2c5-5f11-5ed8-9e2f-500e0cbcdb19@oracle.com>
In-Reply-To: <871ab2c5-5f11-5ed8-9e2f-500e0cbcdb19@oracle.com>
From:   Rick Wertenbroek <rick.wertenbroek@gmail.com>
Date:   Mon, 30 Jan 2023 14:52:45 +0100
Message-ID: <CAAEEuhqjv2VyTsPyHN10JE=5c-Jjgb_wNR8C+g5UsKxAYtcKyw@mail.gmail.com>
Subject: Re: [PATCH 5/8] PCI: rockchip: Added dtsi entry for PCIe endpoint controller
To:     ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc:     alberto.dassatti@heig-vd.ch, xxm@rock-chips.com,
        wenrui.li@rock-chips.com, rick.wertenbroek@heig-vd.ch,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mikko Kovanen <mikko.kovanen@aavamobile.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 27, 2023 at 9:43 AM ALOK TIWARI <alok.a.tiwari@oracle.com> wrote:
>
>    DTC     arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dtb
> ../arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi:460.3-52: Warning
> (pci_device_reg): /pcie@f8000000/pcie@0,0:reg: PCI reg address is not
> configuration space
>    DTC arch/arm64/boot/dts/amlogic/meson-gxm-s912-libretech-pc.dtb
> ../arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi:460.3-52: Warning
> (pci_device_reg): /pcie@f8000000/pcie@0,0:reg: PCI reg address is not
> configuration space
>    HDRINST usr/include/linux/aio_abi.h
>    HDRINST usr/include/linux/am437x-vpfe.h
> ../arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi:460.3-52: Warning
> (pci_device_reg): /pcie@f8000000/pcie@0,0:reg: PCI reg address is not
> configuration space
>    DTC     arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dtb
>
>
> Thanks,
>
> Alok

These warnings are for the pcie (host controller), I did not touch that entry.
Plus they are for another file (arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi)
They are related to "pci_device_reg" warnings (can be suppressed with
"-Wno-pci_device_reg").

Sorry, but this does not seem to be related to my change and I don't know
how to fix this.

Rick
