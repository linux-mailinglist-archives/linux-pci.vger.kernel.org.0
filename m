Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB921513079
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 11:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbiD1KBV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Apr 2022 06:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbiD1KAr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 06:00:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB879B1AB8;
        Thu, 28 Apr 2022 02:48:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 259C81474;
        Thu, 28 Apr 2022 02:48:25 -0700 (PDT)
Received: from e123427-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 308463F774;
        Thu, 28 Apr 2022 02:48:23 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Colin Ian King <colin.i.king@gmail.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] PCI: versatile: Remove redundant variable retval
Date:   Thu, 28 Apr 2022 10:48:06 +0100
Message-Id: <165113925739.24331.3750415057440371912.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220418144416.86121-1-colin.i.king@gmail.com>
References: <20220418144416.86121-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 18 Apr 2022 15:44:16 +0100, Colin Ian King wrote:
> Variable retval is being assigned a value that is never read, the
> variable is redundant and can be removed.
> 
> Cleans up clang scan build warning:
> drivers/pci/controller/pci-versatile.c:37:10: warning: Although the value
> stored to 'retval' is used in the enclosing expression, the value is never
> actually read from 'retval' [deadcode.DeadStores]
> 
> [...]

Applied to pci/versatile, thanks!

[1/1] PCI: versatile: Remove redundant variable retval
      https://git.kernel.org/lpieralisi/pci/c/6086987bde

Thanks,
Lorenzo
