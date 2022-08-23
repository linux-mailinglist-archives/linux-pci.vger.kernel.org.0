Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE2F59E74E
	for <lists+linux-pci@lfdr.de>; Tue, 23 Aug 2022 18:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241070AbiHWQbl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Aug 2022 12:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244941AbiHWQaf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Aug 2022 12:30:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F606152;
        Tue, 23 Aug 2022 06:00:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0F9AB81D46;
        Tue, 23 Aug 2022 13:00:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B39EC433D7;
        Tue, 23 Aug 2022 13:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661259610;
        bh=vFYiXo/P9K/4JU1QhwwFk5O85O6WmJkkrgsVcBQli/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qESWTLeRSSaxMmItsSzL6/p8MEOxyEJ0hZSoJajH9L6X9Trnt1jeca3kAE3HRcm3q
         7LOpt2l+Y4UCV6geAcu+6BlTOLRgUy4Gg8jBHvfgfbyfaNvQ5836Ufg0P6KsOSrvA7
         UPPlMtR6rzOgPBcoP3LF6qCfFOaY2Duu4xjyYw6i/1oc4T0lSrL+HhaFC9umHSnns3
         E1X8h7iypVxoPsGVT7WAdpryn/lQAJSuFZ7AG/tB5UL4I+gG3ljrRQlwBu7CdavUMw
         7SkZzpdILB8BsHZpBhqWf3If3EDg9J2GDpDHs2qdpZciv5hnYgv2BBcDXyzZce73xZ
         EnW8kmObstBHA==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Ryder Lee <ryder.lee@mediatek.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Felix Fietkau <nbd@nbd.name>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v4] PCI: mediatek-gen3: Change driver name to mtk-pcie-gen3
Date:   Tue, 23 Aug 2022 15:00:03 +0200
Message-Id: <166125958529.60702.17839683437013330997.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220505083907.86598-1-nbd@nbd.name>
References: <20220505083907.86598-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 5 May 2022 10:39:07 +0200, Felix Fietkau wrote:
> driver_register() will refuse to register another driver with the same name.
> This change allows pcie-mediatek-gen3 to coexist with pcie-mediatek built into
> the kernel.
> 
> 

Applied to pci/mediatek, thanks!

[1/1] PCI: mediatek-gen3: Change driver name to mtk-pcie-gen3
      https://git.kernel.org/lpieralisi/pci/c/034fdac01fe5

Thanks,
Lorenzo
