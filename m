Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F4D4AF6ED
	for <lists+linux-pci@lfdr.de>; Wed,  9 Feb 2022 17:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237225AbiBIQi6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Feb 2022 11:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbiBIQi5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Feb 2022 11:38:57 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5379BC0613C9;
        Wed,  9 Feb 2022 08:39:00 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD302ED1;
        Wed,  9 Feb 2022 08:38:59 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.40.175])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 155163F70D;
        Wed,  9 Feb 2022 08:38:57 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>, kishon@ti.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] PCI: endpoint: Fix alignment fault error in copy tests
Date:   Wed,  9 Feb 2022 16:38:50 +0000
Message-Id: <164442471484.32537.8057098991529121924.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211217094708.28678-1-Zhiqiang.Hou@nxp.com>
References: <20211217094708.28678-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 17 Dec 2021 17:47:08 +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> In the copy tests, it uses the memcpy() to copy data between
> IO memory space. This can cause the alignment fualt error
> (pasted the error logs below) due to the memcpy() may use
> unaligned accesses.
> 
> [...]

Applied to pci/endpoint, thanks!

[1/1] PCI: endpoint: Fix alignment fault error in copy tests
      https://git.kernel.org/lpieralisi/pci/c/829cc0e2ea

Thanks,
Lorenzo
