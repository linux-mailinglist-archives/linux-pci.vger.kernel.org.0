Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F4071463F
	for <lists+linux-pci@lfdr.de>; Mon, 29 May 2023 10:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjE2IYy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 May 2023 04:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjE2IYw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 May 2023 04:24:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4E0B8;
        Mon, 29 May 2023 01:24:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 195FC611F8;
        Mon, 29 May 2023 08:24:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87D8C433EF;
        Mon, 29 May 2023 08:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685348690;
        bh=t3LHcunv3aalM1DAr6XNRqACjGfoDGh5zZQVzoGfsHs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tE2puyAe6dCGrXtDt/6w+8wAE55P6Xaq5F2hFDqQBvFRmOomeIFIUGMXN4/1PHTkW
         juOXQmPhvRc0Qdm7zhG4FIJmckiSDwIorcVDxRev1JeBPXbLjLQ3jCFgd1aiRk8oYD
         4qaTzehfU/3YtZteS6Q8GTMW01nSpYLFNejzXeEfs+NrxZolqedoyAlpX/KYRSxGY6
         TE1sNJgD19kUWvo/OJ/HbBE4nLy9TaVrOmMp9m9251tfGkRrzhwTFLRdBQpyd8Wpce
         z5iBA/M/a/Y3Hh15tqdrZk9MoNQMnrDF00Lt5Pf07GB5Zg4s+NZJOmW9/jcOTVeOz2
         U7xi/9+lW8Y1A==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Junyan Ye <yejunyan@hust.edu.cn>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] pci: controller: pci-ftpci100: Release the clock resources
Date:   Mon, 29 May 2023 10:24:42 +0200
Message-Id: <168534865675.10610.11781973164480184341.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230508043641.23807-1-yejunyan@hust.edu.cn>
References: <20230508043641.23807-1-yejunyan@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 08 May 2023 12:36:41 +0800, Junyan Ye wrote:
> Smatch reported:
> 1. drivers/pci/controller/pci-ftpci100.c:526 faraday_pci_probe() warn:
> 'clk' from clk_prepare_enable() not released on lines: 442,451,462,478,512,517.
> 2. drivers/pci/controller/pci-ftpci100.c:526 faraday_pci_probe() warn:
> 'p->bus_clk' from clk_prepare_enable() not released on lines: 451,462,478,512,517.
> 
> The clock resource is obtained by devm_clk_get(), and then
> clk_prepare_enable() makes the clock resource ready for use. After that,
> clk_disable_unprepare() should be called to release the clock resource
> when it is no longer needed. However, while doing some error handling
> in faraday_pci_probe(), clk_disable_unprepare() is not called to release
> clk and p->bus_clk before returning. These return lines are exactly 442,
> 451, 462, 478, 512, 517.
> 
> [...]

Applied to pci/ftpci100, thanks!

[1/1] pci: controller: pci-ftpci100: Release the clock resources
      https://git.kernel.org/pci/pci/c/c60738de85f4

Thanks,
Lorenzo
