Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C056B875E
	for <lists+linux-pci@lfdr.de>; Tue, 14 Mar 2023 02:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjCNBE1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Mar 2023 21:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCNBE0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Mar 2023 21:04:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5BB498A8;
        Mon, 13 Mar 2023 18:04:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA31BB81690;
        Tue, 14 Mar 2023 01:04:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F08C433EF;
        Tue, 14 Mar 2023 01:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678755863;
        bh=cvS2ARvwbz05CS1zvBhjzpdTHSJtvIpNjq+oVikH1nE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VNb6BC5GUruLKknZ8+wdNtqPW6Ef2PBz0l4FinUSYBXrz9zeSUu+pwDJIweMf6sKN
         I8CG92wGqwfQrm+0GDX2pmKLkysNc8a4YLjWeBxeotDX+mo+kOJya9yTWYtsEGU4MX
         5qAx9bWYENzMfBrAdol0OFg1XujDgxI4GQdHg23bHxOaNpS4+a/262mMnwaHBr0iUn
         Eb324yKfpNwCrl794qPsq8uHSY8rUYv+QIHG7v65W8qzmml9h3C2Rxj05tNh/hUWIp
         zv6tmO1GHBJyeBS2nIo8CjPtxDvLu7twPkwFfRFxGR0m7yBRBBGaV/zXclCfkzPX78
         5BINBxWpY8UVA==
Date:   Tue, 14 Mar 2023 09:04:15 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        l.stach@pengutronix.de, lorenzo.pieralisi@arm.com,
        peng.fan@nxp.com, marex@denx.de, marcel.ziswiler@toradex.com,
        tharvey@gateworks.com, frank.li@nxp.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: Re: [PATCH DTS RESEND v10 0/4] Add i.MX PCIe EP mode support
Message-ID: <20230314010415.GX143566@dragon>
References: <1676441915-1394-1-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1676441915-1394-1-git-send-email-hongxing.zhu@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 15, 2023 at 02:18:31PM +0800, Richard Zhu wrote:
> [RESEND v10 1/4] dt-bindings: imx6q-pcie: Restruct i.MX PCIe schema
> [RESEND v10 2/4] arm64: dts: Add i.MX8MM PCIe EP support
> [RESEND v10 3/4] arm64: dts: Add i.MX8MQ PCIe EP support
> [RESEND v10 4/4] arm64: dts: Add i.MX8MP PCIe EP support

Applied 2 ~ 4, thanks!
