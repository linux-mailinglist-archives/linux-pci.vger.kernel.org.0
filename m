Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC7973120D
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jun 2023 10:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244309AbjFOIXM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Jun 2023 04:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244319AbjFOIXK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Jun 2023 04:23:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1B61FEF;
        Thu, 15 Jun 2023 01:23:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E06B62CE8;
        Thu, 15 Jun 2023 08:23:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA3DC433C8;
        Thu, 15 Jun 2023 08:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686817388;
        bh=oKnnEN/3/0K5S/IpaxAfeYE2ONcRBKAWQT5d6KIBaXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qa3eBkRpoPV5/zSaZAhXK77OULHOsalfQeVCwd9BXonl+gc1Eh/BVABziJfkUv+nx
         1QZCLtWPDLV4T9J6qSo2hwl8ZNyfnFx4JLKCcFyBU0XYyLnQS2DRByurPNr6vj/0aB
         37DNzEHyEbvVpzm34seGCJiESvBlG5o0xjP/k0EV9WwzQCUYssPzd4uo4Hj9dewCbm
         LZrb385bG2vFYQGFmZxljKrKBxFCznEo4bCCH3T7Fsa1pBc+D6+fKbHWLZPzpYaF75
         OKBUz7WapFMrtuJqkZzC3EzMQGiGds6vkozCptg7uUUMO1hRebRkXgaL+o6YX88MON
         ZHuaYQ7DSiMCw==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Frank Li <Frank.Li@nxp.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v4 1/1] PCI: layerscape: Add the endpoint linkup notifier support
Date:   Thu, 15 Jun 2023 10:23:01 +0200
Message-Id: <168681736632.249392.2955088102759301523.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230515151049.2797105-1-Frank.Li@nxp.com>
References: <20230515151049.2797105-1-Frank.Li@nxp.com>
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

On Mon, 15 May 2023 11:10:49 -0400, Frank Li wrote:
> Layerscape has PME interrupt, which can be used as linkup notifier.
> Set CFG_READY bit of PEX_PF0_CONFIG to enable accesses from root complex
> when linkup detected.
> 
> 

Applied to controller/endpoint, thanks!

[1/1] PCI: layerscape: Add the endpoint linkup notifier support
      https://git.kernel.org/pci/pci/c/71d9ca28015c

Thanks,
Lorenzo
