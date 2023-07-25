Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6705762306
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jul 2023 22:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjGYUKE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jul 2023 16:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGYUKD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jul 2023 16:10:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBADE1BCC;
        Tue, 25 Jul 2023 13:10:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DE0E618D6;
        Tue, 25 Jul 2023 20:10:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E75C433C7;
        Tue, 25 Jul 2023 20:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690315801;
        bh=J0eBuKlg21wwA1iU58mxP3Den55kxl6CbES3s/IW5Wc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=WqNuGsQH1TZBy0LtRzSJ3Ib33oS7FqtfjuJdRQ4z21wAxq/+i1o2r/sXxpNonLeZZ
         FV3plt9BotaymibGzem3zbdNTDJ8eDkBLFZfeQshMV+RHfZb4pV9FmN8eteU6MhlF0
         COMNiAWDeinu3zU9A4xiHR4yh0M1IIa7wa31/M6ZPHu8Fl+GqFCC5VcH+VVZ41J5eT
         Jb4NHhYI4GmSmG3WOQ6DXtqNz1utZdEJ5YgYGqZwbepfpOXA4f2BVNlXRvxrNW7E5N
         9lVmot9z9m+Ajricxt1UJVFqq9t3OxUc8yOM12seA4wcjMgJTstU2VT9Wz67kQaMWh
         BFakA4bhclyHQ==
Date:   Tue, 25 Jul 2023 15:09:59 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ajay Agarwal <ajayagarwal@google.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Nikhil Devshatwar <nikhilnd@google.com>,
        Manu Gautam <manugautam@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sajid Dalvi <sdalvi@google.com>,
        William McVicker <willmcvicker@google.com>,
        linux-pci@vger.kernel.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v4] PCI: dwc: Wait for link up only if link is started
Message-ID: <20230725200959.GA663593@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMAJCmfixoZmjPVI@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 25, 2023 at 11:10:26PM +0530, Ajay Agarwal wrote:
> Hi Jon,
> This issue has been reported on a QCOM platform as well. The patch will
> get reverted:
> https://lore.kernel.org/all/20230706082610.26584-1-johan+linaro@kernel.org/.
> Once it gets merged, I will upload a version of my patch where I would
> not fail the probe if the start_link() is defined and the link still
> does not come up.
> 
> Johan, is your patch set to be picked in the next release?

I applied Johan's patch to for-linus, so it will appear in v6.5:
https://lore.kernel.org/linux-pci/20230725200515.GA663333@bhelgaas/

Bjorn
