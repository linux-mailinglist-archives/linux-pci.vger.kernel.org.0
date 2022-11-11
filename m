Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3D86258FD
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 12:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbiKKLBh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 06:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbiKKLBf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 06:01:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E9D1EEDD
        for <linux-pci@vger.kernel.org>; Fri, 11 Nov 2022 03:01:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E236261F70
        for <linux-pci@vger.kernel.org>; Fri, 11 Nov 2022 11:01:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65879C433C1;
        Fri, 11 Nov 2022 11:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668164492;
        bh=t1Wsq8qQI5fgAj4CmUn5cyppdE4undjmcH8oCPL3XMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T5kHf8WJDrEf0hJIyVSx4GoE++aLOPpVJanG1zsLaLRkGSkRB3i2P1fFqV6WxuMq3
         LtJUkyqbFxvQpikYUQYnE65wWs5ZcQMlcXmQyD6RgQYcuhrrVUfNuw9sinGwINLrHw
         iR9G5iENkIoOqVqeKgeq3iys+B0UBblhD1Odrdg9y8cnxv1rtYzdrVKDwVh+R22dqC
         +yJ7iB2cV9xTcEm5Va2MXEavjmM0bH8SY6pSEQfqoKxhcINkT0nC78k+zp0X+lyArf
         yG0DpZFTB94gh+tGn7Di6rpYtJWn9DtOnPLIBFwwdCb/TRR0K9qZxS7IFCpKcgf69p
         W10mdApXEzneA==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Nirmal Patel <nirmal.patel@linux.intel.com>,
        linux-pci@vger.kernel.org
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        acelan.kao@canonical.com, Liang_Xiao1@Dell.com,
        Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>
Subject: Re: [PATCH v2] PCI: vmd: Disable MSI remapping after suspend
Date:   Fri, 11 Nov 2022 12:01:27 +0100
Message-Id: <166816447125.204404.14576437175253719672.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221109142652.450998-1-nirmal.patel@linux.intel.com>
References: <20221109142652.450998-1-nirmal.patel@linux.intel.com>
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

On Wed, 9 Nov 2022 07:26:52 -0700, Nirmal Patel wrote:
> MSI remapping is disabled by VMD driver for Intel's Icelake and
> newer systems in order to improve performance by setting
> VMCONFIG_MSI_REMAP. By design VMCONFIG_MSI_REMAP register is cleared
> by firmware during boot. The same register gets cleared when system
> is put in S3 power state. VMD driver needs to set this register again
> in order to avoid interrupt issues with devices behind VMD if MSI
> remapping was disabled before.
> 
> [...]

Applied to pci/vmd, thanks!

[1/1] PCI: vmd: Disable MSI remapping after suspend
      https://git.kernel.org/lpieralisi/pci/c/d899aa668498

Thanks,
Lorenzo
