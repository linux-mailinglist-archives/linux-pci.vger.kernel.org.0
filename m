Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE6375C4C3
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jul 2023 12:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjGUKfx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jul 2023 06:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjGUKft (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jul 2023 06:35:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF341722;
        Fri, 21 Jul 2023 03:35:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2077560C7B;
        Fri, 21 Jul 2023 10:35:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC3BC433C8;
        Fri, 21 Jul 2023 10:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689935747;
        bh=Je4jmw2YnxTcTqTMRin9ETDHc7Fr+mZCpqJaYHv8iP4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gyMuAeO0YQpXeU6s8MvqxN/S4e//q0/WuTsV6KPiOB6q3EaZb1YO89ex/9EZUDHXv
         Vdnl7F5aan7jtnSZZDJNdWnKNaN70ScAFIc6evn7vnE4MkPYQy1GgxAUo5+RuZ1lNM
         bKgboN/zhpwU/oOvuoG/Y8GMV0wAVN6hawUXYSRxKTLwEkvNoLaetDgEuKj/A5NntF
         vrSwrubhoac6yD47ZsN51FOiZQPrgUMdnuOoLB7N+LzzS5W3JJb5CESRP+AYLOTa24
         fv9s/Pcyg4QVZ2PmBijcYnFi+xCtreVFtqhBKlpzqrtzYeor3KafUwdmxGo4s2tDss
         f+PUJjoE6wZuQ==
Date:   Fri, 21 Jul 2023 05:35:44 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Vidya Sagar <vidyas@nvidia.com>, lpieralisi@kernel.org,
        kw@linux.com, robh@kernel.org, bhelgaas@google.com,
        thierry.reding@gmail.com, Sergey.Semin@baikalelectronics.ru,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V4] Revert "PCI: tegra194: Enable support for 256 Byte
 payload"
Message-ID: <20230721103544.GA569300@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53d1bf79-4353-49b5-76b6-c2266535c778@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 21, 2023 at 09:23:01AM +0100, Jon Hunter wrote:
> ...

> I see a version of this patch here ...
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=controller/tegra194
> 
> However, I don't see this in -next yet. If you are happy with this latest
> version, could we get this into -next?

I'm on vacation until Tuesday; will build a new -next branch Tuesday
or Wednesday.
