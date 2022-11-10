Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA6A624621
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 16:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbiKJPke (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Nov 2022 10:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiKJPkd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 10:40:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3ED35FE7;
        Thu, 10 Nov 2022 07:40:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98ACEB82224;
        Thu, 10 Nov 2022 15:40:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D831C433D7;
        Thu, 10 Nov 2022 15:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668094830;
        bh=D+sx0yIJEz1EzJtqEh3SEP6pSWxP1kmuySPftMaVv+k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bzr91BPweMjGUIa/o7d6nZawYpSe8+bFc4Jt5XhUmMQzcvtNQryggWnS+q3jLrLsE
         gLJZxi9V8EkG7xMxqwARNCJzY3P2IfcEe+E3ooCwi3bxv3t0zm1nntgGDFeLJUfQQF
         oJAimVtIPWuBCnmlq3Wz60NRU+fTlRD0aeSrZl1lChi3YDNsQV1WyYrod4cOUrHmQV
         UF4iUQXC9HgZhrPJffBxfcXvA1b4P2Dpiqq5gfOKz7Fynx2fxawJ1j/ic2HhzUJIlc
         LVbcFb9NQC6QIylfTIziLkn+mZws7YeGV1VpgGj8jro7PybUdy5BY8O/fqwYgjdL0i
         8Vtry+JdAeTEA==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     gustavo.pimentel@synopsys.com, robh@kernel.org,
        bhelgaas@google.com, jonathanh@nvidia.com,
        Vidya Sagar <vidyas@nvidia.com>, treding@nvidia.com,
        kw@linux.com, jingoohan1@gmail.com
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>, kthota@nvidia.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V1] PCI: dwc: Use dev_info for PCIe link down event logging
Date:   Thu, 10 Nov 2022 16:40:21 +0100
Message-Id: <166809473524.144027.18040336809193553161.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220913101237.4337-1-vidyas@nvidia.com>
References: <20220913101237.4337-1-vidyas@nvidia.com>
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

On Tue, 13 Sep 2022 15:42:37 +0530, Vidya Sagar wrote:
> Some of the platforms (like Tegra194 and Tegra234) have open slots and
> not having an endpoint connected to the slot is not an error.
> So, changing the macro from dev_err to dev_info to log the event.
> 
> 

Applied to pci/dwc, thanks!

[1/1] PCI: dwc: Use dev_info for PCIe link down event logging
      https://git.kernel.org/lpieralisi/pci/c/8405d8f0956d

Thanks,
Lorenzo
