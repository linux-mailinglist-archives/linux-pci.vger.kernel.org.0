Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906EB53F1C5
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jun 2022 23:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiFFVdz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jun 2022 17:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234965AbiFFVdu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jun 2022 17:33:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B55C6E71;
        Mon,  6 Jun 2022 14:33:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B187B81BD4;
        Mon,  6 Jun 2022 21:33:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C84C341C4;
        Mon,  6 Jun 2022 21:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654551222;
        bh=4lwYtXk+4KNqnXm/SLQ7kW5r0PHmTjZ4GioeZ/31n5c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KZ6lawMZIlv5iYXXPpncFyh7qlTwHGAU9TSXnGn/rCm9JGb+gimGAWjSGYmapjRB1
         CTw7HRh/eh0F+Fmxv4r3WysZrFREJzB6OTf3z1ZgwSh3UF180X8YHAFUxqMV38csKL
         MMPhB19V9ymOR6LT4CZlh7Ah09lbtY65uUalD5054w+640LWRHmhyr0A4ofuQ0Evmv
         1087o137RfajV3IXk8e1TlqEkMDCIYQXclj4c9TXZiCOEHFttsJi/sXpWT9wmzGi+D
         jK2axiltoxoPiMa2Rh6Gk5zFX5iSPPPGtHEWQxWc0BrVrZXN3SkhnjEXv4jh09xTuJ
         cj0K+SboPFAAw==
Received: by mail-vk1-f180.google.com with SMTP id z17so795376vkb.13;
        Mon, 06 Jun 2022 14:33:42 -0700 (PDT)
X-Gm-Message-State: AOAM532M+MtpPY0XgUCJ6quYBSCT6UsoKUFZOONFN3FpQphuedLzFWg7
        LLd/n5PSDPWKA8huloGy//0dr2b6ueBj8gOjWA==
X-Google-Smtp-Source: ABdhPJz7B9SjuuJ/LcX9SZnE+gp0M1PXpZFb3AXX9LvPuOzOLmsuxSf7KuKtw6+ijxYCZ7ctPKQTofCx5GjKQgxEzO4=
X-Received: by 2002:a1f:a1c6:0:b0:35e:3f6a:b8b8 with SMTP id
 k189-20020a1fa1c6000000b0035e3f6ab8b8mr1953690vke.26.1654551221808; Mon, 06
 Jun 2022 14:33:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220603130849.38252-1-linmq006@gmail.com>
In-Reply-To: <20220603130849.38252-1-linmq006@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 6 Jun 2022 16:33:30 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+dhE-vf3+vjkKbbAtwAMEOUkVLesaVdzeSaedQrCoWjg@mail.gmail.com>
Message-ID: <CAL_Jsq+dhE-vf3+vjkKbbAtwAMEOUkVLesaVdzeSaedQrCoWjg@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: brcmstb: Fix refcount leak in brcm_pcie_probe
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 3, 2022 at 8:09 AM Miaoqian Lin <linmq006@gmail.com> wrote:
>
> of_parse_phandle() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> Add missing of_node_put() to avoid refcount leak.
>
> Fixes: 40ca1bf580ef ("PCI: brcmstb: Add MSI support")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
> changes in v2:
> - update Fixes tag.
> v1 Link: https://lore.kernel.org/r/20220602125003.10723-1-linmq006@gmail.com
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
