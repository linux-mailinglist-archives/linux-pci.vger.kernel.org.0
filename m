Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C7678519C
	for <lists+linux-pci@lfdr.de>; Wed, 23 Aug 2023 09:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbjHWHeb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Aug 2023 03:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbjHWHeb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2023 03:34:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22EFFB
        for <linux-pci@vger.kernel.org>; Wed, 23 Aug 2023 00:34:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7766F615B3
        for <linux-pci@vger.kernel.org>; Wed, 23 Aug 2023 07:34:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42ADBC433C7;
        Wed, 23 Aug 2023 07:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692776068;
        bh=sHktYZcnipIAz1DG5Eat0kbdC1HNjyjYX886Bz4WWUk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d2iyZkagvyHNy+WDH7upkbwlwJaR7eU+GZeCAl3UEjN5N33y/IN75b9gKkDCL46UR
         RZc17NHVpt/yesxoduwilGhyeeKiXLXeWw+pzGV9TCamLhmz4NR/qiENmksXS+MObk
         zjqxhde5F2PXdH36GBCBWhZLIJJrsXpufZktLQtLCmNyj5vWCsPLzOd+4QwvWGSfIw
         sHGSIbLHW69+xqS5qsWXu+co8vnPB305+hnAmq3VmmxlUxRzvxnAKxfx24aAfX85zF
         hpUTmuV2R9To1fuUQLy/rVVTnvte4fPjBA24TYAJibEUnH7HCYK50tqrF2EhY6OLrb
         ImV2R0X5MWVAg==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     linux-pci@vger.kernel.org,
        Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        paul.walmsley@sifive.com, greentime.hu@sifive.com, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, p.zabel@pengutronix.de,
        palmer@dabbelt.com, fancer.lancer@gmail.com, zong.li@sifive.com
Subject: Re: [PATCH v3] PCI: fu740: Set the number of MSI vectors
Date:   Wed, 23 Aug 2023 09:34:21 +0200
Message-Id: <169277604470.30911.15667199430574906551.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230807055621.2431-1-yongxuan.wang@sifive.com>
References: <20230807055621.2431-1-yongxuan.wang@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 07 Aug 2023 05:56:21 +0000, Yong-Xuan Wang wrote:
> The iMSI-RX module of the DW PCIe controller provides multiple sets of
> MSI_CTRL_INT_i_* registers, and each set is capable of handling 32 MSI
> interrupts. However, the fu740 PCIe controller driver only enabled one set
> of MSI_CTRL_INT_i_* registers, as the total number of supported interrupts
> was not specified.
> 
> Set the supported number of MSI vectors to enable all the MSI_CTRL_INT_i_*
> registers on the fu740 PCIe core, allowing the system to fully utilize the
> available MSI interrupts.
> 
> [...]

Applied to controller/fu740, thanks!

[1/1] PCI: fu740: Set the number of MSI vectors
      https://git.kernel.org/pci/pci/c/551a60e1225e

Thanks,
Lorenzo
