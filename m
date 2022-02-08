Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E976B4ADCA4
	for <lists+linux-pci@lfdr.de>; Tue,  8 Feb 2022 16:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344677AbiBHP3Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Feb 2022 10:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348422AbiBHP3Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Feb 2022 10:29:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DA2C061579;
        Tue,  8 Feb 2022 07:29:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44C65B81B9F;
        Tue,  8 Feb 2022 15:29:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE4EFC340E9;
        Tue,  8 Feb 2022 15:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644334153;
        bh=WjdgoUEM1gV6yZT3Temszu4m7lJiQ8Db+jN83dtZlDY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fpb3zddkq6EGTy3h1ah+A8DeDDBBFItiTbaUUbeOdxWz5J9rfIeirlXu0ur5Q0l2/
         L0wlmVG0aSFua0lDw9qIHCz13TWRVkmzIgC8sojkiaG4bD+TWLE6yOP51YHfADv82p
         len2cmFZL6yyi0xBi9f4HEK/mgtFGgf0g0zkKhh9VP5DDctJtTmoMRVkDWEAbXia9x
         IlgTYnyK+Yt29kouufgVxK7cKpBTYRYf/k3mlP26ZCC6f72XduaErrUaIoqX55ZHCj
         fzCJu9ifEItnHg/O7vVDDwnXNtDFAIO9KCm78VOUu4b3CfdfWmtsXYpXfAY9BaShJ9
         A63uN9q6Loy/w==
Date:   Tue, 8 Feb 2022 09:29:11 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     shawnguo@kernel.org, l.stach@pengutronix.de,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: Re: [PATCH] arm64: dts: imx8mq-evk: Add the second pcie port support
Message-ID: <20220208152911.GA477654@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644303749-4610-1-git-send-email-hongxing.zhu@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In subject:

s/Add the/Add/
s/pcie/PCIe/

On Tue, Feb 08, 2022 at 03:02:29PM +0800, Richard Zhu wrote:
> Enable the secone PCIe port support on i.MX8MQ EVK board.

s/secone/second/
