Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F8E644836
	for <lists+linux-pci@lfdr.de>; Tue,  6 Dec 2022 16:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbiLFPnD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Dec 2022 10:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbiLFPnC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Dec 2022 10:43:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B2A63DD;
        Tue,  6 Dec 2022 07:43:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C163B81AA6;
        Tue,  6 Dec 2022 15:43:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C8EC433C1;
        Tue,  6 Dec 2022 15:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670341378;
        bh=b/5+AO9U5t+K6P2Qc72IGGvfLNBkWTdkKVJBlGbBbqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XW9NlZ0DGcOT577Q6XkL82z2pzFS61TaxTo/2qp6umxKWHM6XNBhYzrHaFgT72Cvi
         JheV2qBoLC7xlJ4qQ6LhUSM5adgmQKarz+bAunznpmmJbVkTMKeIL/T8aB13Sgi4LL
         JLwV6hJTkvwgy+k1Am6y5D0TyVOerx6Nl3+Z79cCbdwZ5n2d5NhKDDdQu5/43r5UMy
         IhXw+wURveFx3VJCleJw02tutPVpaGfi+smUHIP7+dRTSQGAs+ro2m+1QHH2AkNMxk
         wsu2CxraTZdSMWFKs6fPzuOHQlVkYn/DnYQSPufrEidZ0QMLGhn3WHSx53tV0Vp49s
         xf1PAFhIlnhaw==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Frank Wunderlich <frank-w@public-files.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-kernel@vger.kernel.org,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        linux-pci@vger.kernel.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Rob Herring <robh@kernel.org>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ryder Lee <ryder.lee@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: (subset) [next v7 0/8] Add BananaPi R3
Date:   Tue,  6 Dec 2022 16:42:50 +0100
Message-Id: <167034135386.88271.140848740488398853.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221127114142.156573-1-linux@fw-web.de>
References: <20221127114142.156573-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 27 Nov 2022 12:41:34 +0100, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> This Series adds some Nodes to mt7986 devicetree and the BananaPi R3
> 
> This version is rebased on linux next from 2022/11/27.
> 
> i included sams series for mt7986 DTS with small changes
> https://patchwork.kernel.org/project/linux-mediatek/cover/20220427124741.18245->
> 
> [...]

Applied to pci/dt, thanks!

[3/8] dt-bindings: PCI: mediatek-gen3: add SoC based clock config
      https://git.kernel.org/lpieralisi/pci/c/ec9eaf68c1dc
[4/8] dt-bindings: PCI: mediatek-gen3: add support for mt7986
      https://git.kernel.org/lpieralisi/pci/c/d3fd0ee7a4a1

Thanks,
Lorenzo
