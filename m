Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D776B3F74
	for <lists+linux-pci@lfdr.de>; Fri, 10 Mar 2023 13:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjCJMhZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Mar 2023 07:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjCJMhL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Mar 2023 07:37:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D01110C72A;
        Fri, 10 Mar 2023 04:36:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9EEBB82289;
        Fri, 10 Mar 2023 12:36:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42DDC433D2;
        Fri, 10 Mar 2023 12:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678451796;
        bh=PWCVTsxCw26Cz18rQKUtN2MtA3+P6cbKGi9GO9ylpbY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gq85VTs8UU8E8IvynBgdr6eI3J2MbgjX/XPVexU4GKZbE2iZMln1k/EF35wc6+Fxs
         fWFWmDTT5HSN/pUGIkAt800H4Rq4xPJCdbddaUwRyGwqNMvpq+oEYaZxEKuLVCuTVt
         wobieWVxvIKtiXGHNsjkzysydfAiMolwCy7kT6P7M90+c//nQRJ6JAFUt9IRN71i9c
         F6gIorX3ZHWbTWLBOZojMu5N/K4RL5Z8LjTI9JyXc++76KyRpxv1A832IibdFVRmhQ
         eotnoCo7QxjAF/Q0GUtWeFsiS9MXtt7uUiyksk7LTEG2kFvZURIJlRjusB6NUUT5vD
         QhNOfs97rupAw==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: rcar: avoid defines prefixed with CONFIG
Date:   Fri, 10 Mar 2023 13:36:30 +0100
Message-Id: <167845177669.1223205.12603940242969013581.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230113084516.31888-1-lukas.bulwahn@gmail.com>
References: <20230113084516.31888-1-lukas.bulwahn@gmail.com>
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

On Fri, 13 Jan 2023 09:45:16 +0100, Lukas Bulwahn wrote:
> Defines prefixed with "CONFIG" should be limited to proper Kconfig options,
> that are introduced in a Kconfig file.
> 
> Here, a definition for a bitmask to configure the SEND_ENABLE mode is named
> CONFIG_SEND_ENABLE.
> 
> Rename this local definition to CONFIGURE_SEND_ENABLE to avoid defines
> prefixed with "CONFIG".
> 
> [...]

Applied to pci/rcar, thanks!

[1/1] PCI: rcar: avoid defines prefixed with CONFIG
      https://git.kernel.org/pci/pci/c/727de4c08768

Thanks,
Lorenzo
