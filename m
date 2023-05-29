Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669FC714C98
	for <lists+linux-pci@lfdr.de>; Mon, 29 May 2023 17:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjE2PAU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 May 2023 11:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjE2PAT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 May 2023 11:00:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB86BAD;
        Mon, 29 May 2023 08:00:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B7A4625CE;
        Mon, 29 May 2023 15:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA694C433D2;
        Mon, 29 May 2023 15:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685372417;
        bh=lVDRAf6QVQvSLPG7uzGuZT2D9Be4b0c84XTraRYujrU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FIhn4MaVJB0juH17iIxIRDLuj8UbyhK2zm1ddWzmLLxZzbQqfS1yoOAzttgsJ9yxY
         Y9aHx0dNXktyCc2do62u7lyNHvc53g6byEYL9IRF+NKHhzeydZ3zhtpyx/t0EQrOlr
         CeEqGlRQCZkRTzCbZ3ifAEUn6jow58H9txEQt2XP/btZg0JfKeI+AWjziXowUuu+ID
         ZCoZ04XgkXn1xdTsQeddnUoZO9H4H8aa1KwBdoHo8iAarEuKLY3b+dm5FYBdDGMjqP
         C5kw6WrKo1q1Wm7cAMtV0d1QkVC3BfzuSCbbDtUqHTITjk6zzMmen1Jb7Jq90f9zSw
         NkAcIwjCk1HcA==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: rcar-host: Remove unused static pcie_base and pcie_dev
Date:   Mon, 29 May 2023 17:00:10 +0200
Message-Id: <168537239013.35582.673223230397559685.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <f29a8c37bd906dfbe23208cc2b089da17e339a75.1684857051.git.geert+renesas@glider.be>
References: <f29a8c37bd906dfbe23208cc2b089da17e339a75.1684857051.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 23 May 2023 17:52:44 +0200, Geert Uytterhoeven wrote:
> After the L1 link state transition exception handler rework, the static
> copies of the remapped PCIe controller address and the PCIe device
> pointer became unused.  Remove them.
> 
> 

Applied to controller/rcar, thanks!

[1/1] PCI: rcar-host: Remove unused static pcie_base and pcie_dev
      https://git.kernel.org/pci/pci/c/56ad9b211069

Thanks,
Lorenzo
