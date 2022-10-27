Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7C260F201
	for <lists+linux-pci@lfdr.de>; Thu, 27 Oct 2022 10:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbiJ0IP6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Oct 2022 04:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234677AbiJ0IP4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Oct 2022 04:15:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE68537FA;
        Thu, 27 Oct 2022 01:15:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EEF7621EA;
        Thu, 27 Oct 2022 08:15:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1DBEC433D6;
        Thu, 27 Oct 2022 08:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666858554;
        bh=N+KAGYM62QTPT5UqFTX5Pm3IpggH83LeQWT2jAiJ9Rc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qacvEILjY0gdHgj4LIe9hQCZf3N7LfI382BuHRdTeAKZPFuWMptPTPxFbTAokN6XT
         fejAzuQXK9OeTf3ggXwpsrXYZtZUjgxFqWDzNUlEpmSnoizTiHqwssjJ3CpsyDN787
         A0a1zZ61i+ZUzoTyJKO+Lg4wx0MQudRMuQyR7/hf8whmFt6YX8mZZ64N49xMHtEXWj
         Q6TheD9xAw7ISzPJp+dleyxGDSuZGgCwjybmn4tE4NIgLlXVhZ1IDJJzXBOVKIIN9Y
         RaLrNTq28PqVCe8T7V4fVLQy6+YZPe+sht2N5uApqsSowPKi7XxjVI6lkYU97AV6Re
         cE68xe1HlgEPA==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     robh@kernel.org, jingoohan1@gmail.com,
        Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com,
        kw@linux.com, gustavo.pimentel@synopsys.com
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V2] PCI: dwc: Fix n_fts[] array overrun
Date:   Thu, 27 Oct 2022 10:15:48 +0200
Message-Id: <166685852840.815518.9765633266103182046.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926111923.22487-1-vidyas@nvidia.com>
References: <20220919143123.28250-1-vidyas@nvidia.com> <20220926111923.22487-1-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 26 Sep 2022 16:49:23 +0530, Vidya Sagar wrote:
> commit aeaa0bfe89654 ("PCI: dwc: Move N_FTS setup to common setup")
> incorrectly uses pci->link_gen in deriving the index to the
> n_fts[] array also introducing the issue of accessing beyond the
> boundaries of array for greater than Gen-2 speeds. This change fixes
> that issue.
> 
> 
> [...]

Applied to pci/dwc, thanks!

[1/1] PCI: dwc: Fix n_fts[] array overrun
      https://git.kernel.org/lpieralisi/pci/c/66110361281b

Thanks,
Lorenzo
