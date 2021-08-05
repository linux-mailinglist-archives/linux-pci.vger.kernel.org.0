Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C113A3E11D2
	for <lists+linux-pci@lfdr.de>; Thu,  5 Aug 2021 12:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240009AbhHEKC6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Aug 2021 06:02:58 -0400
Received: from foss.arm.com ([217.140.110.172]:42156 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240008AbhHEKC6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Aug 2021 06:02:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D42311FB;
        Thu,  5 Aug 2021 03:02:43 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.41.33])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C4D2D3F719;
        Thu,  5 Aug 2021 03:02:41 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Shunyong Yang <yang.shunyong@gmail.com>, kw@linux.com,
        bhelgaas@google.com, kishon@ti.com, leon@kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] tools: PCI: Zero-initialize param
Date:   Thu,  5 Aug 2021 11:02:34 +0100
Message-Id: <162815774159.31264.15024656618785005472.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210714132331.5200-1-yang.shunyong@gmail.com>
References: <20210714132331.5200-1-yang.shunyong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 14 Jul 2021 21:23:31 +0800, Shunyong Yang wrote:
> The values in param may be random if they are not initialized, which
> may cause use_dma flag set even when "-d" option is not provided
> in command line. Initializing all members to 0 to solve this.

Applied to pci/tools, thanks!

[1/1] tools: PCI: Zero-initialize param
      https://git.kernel.org/lpieralisi/pci/c/224d8031e4

Thanks,
Lorenzo
