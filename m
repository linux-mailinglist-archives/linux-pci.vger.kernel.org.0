Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43D3644182
	for <lists+linux-pci@lfdr.de>; Tue,  6 Dec 2022 11:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbiLFKrr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Dec 2022 05:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbiLFKrm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Dec 2022 05:47:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1DDF19
        for <linux-pci@vger.kernel.org>; Tue,  6 Dec 2022 02:47:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D72D61640
        for <linux-pci@vger.kernel.org>; Tue,  6 Dec 2022 10:47:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D787C433D6;
        Tue,  6 Dec 2022 10:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670323659;
        bh=8FNYOvdxpEFWLrUy+T5+vlM/1n+kRYpKTSGnSkYQuhg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YAlQRqT3ZKQDp9t/+iEl+PFw5n0zW4YTuSTRnGTaSWj/Xh6iXNYpA3f5DuUdzhJQ6
         2eOA7xC9Qm9YPW8457p0hjK/ockgJsdrb5i3GgRj2Rx+/g0UMsLsL2Hi9Ubn8PUdoV
         yT5Ayej/FSMs54Lnh+Cp+9D1p+Rh39/LDixQ+ABbcwML2pU+QT5WtmUfOl8wGOJcrv
         Wv5jMYSb6DBOIr8HMqJwHSCwZ53w/l/72K416QLTyhwd2btb4RqdJqVIVgZZkZOfZW
         ffZzWT9VmZ9shG2iFHTZtPzpGJhVcTLk7x5OAAAaX5aF5ImpPE05xjzbfknt9PE5GL
         ZQMbiht2fCkRw==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     francisco.munoz.ruiz@linux.intel.com, myron.stowe@redhat.com,
        alex.williamson@redhat.com,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Nirmal Patel <nirmal.patel@linux.intel.com>,
        jonathan.derrick@linux.dev, helgaas@kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V4] PCI: vmd: Fix secondary bus reset for Intel bridges
Date:   Tue,  6 Dec 2022 11:47:33 +0100
Message-Id: <167032357239.59401.2641037185044333102.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221206001637.4744-1-francisco.munoz.ruiz@linux.intel.com>
References: <20221206001637.4744-1-francisco.munoz.ruiz@linux.intel.com>
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

On Mon, 5 Dec 2022 17:16:37 -0700, francisco.munoz.ruiz@linux.intel.com wrote:
> From: Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>
> 
> The reset was never applied in the current implementation because Intel
> Bridges owned by VMD are parentless. Internally, pci_reset_bus() applies
> a reset to the parent of the PCI device supplied as argument, but in this
> case it failed because there wasn't a parent.
> 
> [...]

Applied to pci/vmd, thanks!

[1/1] PCI: vmd: Fix secondary bus reset for Intel bridges
      https://git.kernel.org/lpieralisi/pci/c/0a584655ef89

Thanks,
Lorenzo
