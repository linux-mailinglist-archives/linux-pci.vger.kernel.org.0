Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5905C712295
	for <lists+linux-pci@lfdr.de>; Fri, 26 May 2023 10:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236911AbjEZIqc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 May 2023 04:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236628AbjEZIqa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 May 2023 04:46:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E27E99
        for <linux-pci@vger.kernel.org>; Fri, 26 May 2023 01:46:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2EDC64DD2
        for <linux-pci@vger.kernel.org>; Fri, 26 May 2023 08:46:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF95FC433EF;
        Fri, 26 May 2023 08:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685090788;
        bh=JmNrnz4ycjGv0qHOQ25z547dw+Goux1xgW4eGfd6U/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eO2uWAkS/XTgW20eTG9sMtxTMj7XdS6zB+tz6wEP56U6Kdv59JCqrzwO+S4k00wHV
         JivoiQdaNHCZhaJr1/nNYWVRTo2eBJZGrSO07M7mnq0+aXc25ozaPJe44/LzsF3N3e
         TV1bQcPHcfKUMN3ToJBa2O8B4QgwLciaY2P2ggKc8ldC91boq4RB4EfEyPRpe6Veew
         BjqN6o6Nf5J9c0N9cD/Sy3IsLaay2hwvK052DNYQTyc+ZT43+fG208qx0qYd5Y0pup
         Zww9PSamwz9gDlw7Fl0miRyCdIUe8SABhNVmzYGYVmAeB+jbVK9tT3U+8YCXhZfuMa
         Foturj42ep0WA==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Nikhil Devshatwar <nikhilnd@google.com>,
        Manu Gautam <manugautam@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sajid Dalvi <sdalvi@google.com>,
        William McVicker <willmcvicker@google.com>,
        Ajay Agarwal <ajayagarwal@google.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v4] PCI: dwc: Wait for link up only if link is started
Date:   Fri, 26 May 2023 10:46:19 +0200
Message-Id: <168509076553.135117.7288121992217982937.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230412093425.3659088-1-ajayagarwal@google.com>
References: <20230412093425.3659088-1-ajayagarwal@google.com>
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

On Wed, 12 Apr 2023 15:04:25 +0530, Ajay Agarwal wrote:
> In dw_pcie_host_init() regardless of whether the link has been
> started or not, the code waits for the link to come up. Even in
> cases where start_link() is not defined the code ends up spinning
> in a loop for 1 second. Since in some systems dw_pcie_host_init()
> gets called during probe, this one second loop for each pcie
> interface instance ends up extending the boot time.
> 
> [...]

Applied to controller/dwc, thanks!

[1/1] PCI: dwc: Wait for link up only if link is started
      https://git.kernel.org/pci/pci/c/da56a1bfbab5

Thanks,
Lorenzo
