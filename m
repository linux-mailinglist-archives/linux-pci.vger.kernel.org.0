Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F277F2097
	for <lists+linux-pci@lfdr.de>; Mon, 20 Nov 2023 23:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjKTWsu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Nov 2023 17:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbjKTWss (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Nov 2023 17:48:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED743FA;
        Mon, 20 Nov 2023 14:48:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 372C0C433C8;
        Mon, 20 Nov 2023 22:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700520524;
        bh=VlSwC7INYV0MD5bu1t5fzz7nDtrOMKpkNzdL56rwJKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m1cGj+w+V+v/ghqhDtCoBfECsxSNR5HRbI3vmTKGnML6iw1osyOBRlg9jCEW079Dk
         bw2plJyKCCh+hVsQFIBS2yEpHaxjaFiY0DsuLuJK1rAAiGpAJTfs/stgKbmM+8k/0i
         3BEEIK4LDOfy9z+Jf7JJeenqebZpQ5+jibpqbiMKG7wnowmnqc5GDQksinahBVYvUz
         eLXKE4Bt2F0DGCWQuiQFv2+RxjahSi3ROUevDxaCAIxRM/NnFhvv9wMVmChUIxcY86
         QZ9cORIPaQlMXeE9eSAXBWLc3TUaOPnp+Kfa5b7B6rm5W4BVC+QJY1UuTEnje4Tdcs
         EsBl1ykGMiXKA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jonas Gorski <jonas.gorski@gmail.com>
Subject: Re: [PATCH v1 1/1] PCI: Avoid potential out-of-bounds read in pci_dev_for_each_resource()
Date:   Mon, 20 Nov 2023 16:48:41 -0600
Message-Id: <170052045488.221134.10607846623065848997.b4-ty@google.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030114218.2752236-1-andriy.shevchenko@linux.intel.com>
References: <20231030114218.2752236-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>


On Mon, 30 Oct 2023 13:42:18 +0200, Andy Shevchenko wrote:
> Coverity complains that pointer in the pci_dev_for_each_resource()
> may be wrong, i.e. mighe be used for the out-of-bounds read.
> 
> There is no actual issue right now, because we have another check
> afterwards and the out-of-bounds read is not being performed. In any
> case it's better code with this get fixed, hence the proposed change.
> 
> [...]

Applied to "resource" for v6.8, thanks!

[1/1] PCI: Avoid potential out-of-bounds read in pci_dev_for_each_resource()
      commit: 3171e46d677a668eed3086da78671f1e4f5b8405

Best regards,
-- 
Bjorn Helgaas <bhelgaas@google.com>
