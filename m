Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3FC6902BD
	for <lists+linux-pci@lfdr.de>; Thu,  9 Feb 2023 10:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjBIJCl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Feb 2023 04:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjBIJCk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Feb 2023 04:02:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB86EC4B
        for <linux-pci@vger.kernel.org>; Thu,  9 Feb 2023 01:02:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE499B8202D
        for <linux-pci@vger.kernel.org>; Thu,  9 Feb 2023 09:02:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29EB8C433EF;
        Thu,  9 Feb 2023 09:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675933355;
        bh=l+Jht6cceUBFPaZOeTbxbifv9v0mBLIjMpqWTtdeXCc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oNCYSyHM/CCE0+qCrXN/8SVW0Z9iUzD3Y3rl6y5fZExlmxvyScpXleUmBYAXZ3Pew
         OpMBNZOo5VQXY2J0EMjH7ByegkC9YauSrgC4xbnrFF+cCTDcvTtygxMj2Xq3D80DO0
         G8e1GfbjJ7+fhanlWTxG+qoMv2c9N4fhWGGc0YSLrErpELhR4dcQFD4ciycFqIo5Bo
         ABFFWqUiRPWYBSSr5sdXMMcptMy5P8cz5I7X6wiNbI1gX+yrxMrRKkWIFARWfidSFt
         LVje7yzk6gamKBkzfDUM3lDUdLYwsJwte7YBHYTu+z6/J459v3CZKA4zSPitjogzaS
         s+D7B+kn0FSjg==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: mvebu: Mark driver as BROKEN
Date:   Thu,  9 Feb 2023 10:02:30 +0100
Message-Id: <167593333227.921423.9909826198970334059.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230114164125.1298-1-pali@kernel.org>
References: <20230114164125.1298-1-pali@kernel.org>
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

On Sat, 14 Jan 2023 17:41:25 +0100, Pali Rohár wrote:
> People are reporting that pci-mvebu.c driver does not work with recent
> mainline kernel. There are more bugs which prevents its for daily usage.
> So lets mark it as broken for now, until somebody would be able to fix it
> in mainline kernel.
> 
> 

Applied to pci/controller/mvebu, thanks!

[1/1] PCI: mvebu: Mark driver as BROKEN
      https://git.kernel.org/pci/pci/c/b3574f579ece

Thanks,
Lorenzo
