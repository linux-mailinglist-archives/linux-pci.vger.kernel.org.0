Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99081425691
	for <lists+linux-pci@lfdr.de>; Thu,  7 Oct 2021 17:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbhJGPbk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Oct 2021 11:31:40 -0400
Received: from foss.arm.com ([217.140.110.172]:32786 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230410AbhJGPbk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Oct 2021 11:31:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D9AF1FB;
        Thu,  7 Oct 2021 08:29:46 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.53.143])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CEF823F66F;
        Thu,  7 Oct 2021 08:29:43 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     bhelgaas@google.com, robh@kernel.org,
        brookxu <brookxu.cn@gmail.com>, jonathan.derrick@intel.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, helgaas@kernel.org,
        linux-pci@vger.kernel.org, kw@linux.com
Subject: Re: [PATCH v4] PCI: vmd: Assign a number to each VMD controller
Date:   Thu,  7 Oct 2021 16:29:38 +0100
Message-Id: <163362056400.23598.4839753526203041343.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <1631884404-24141-1-git-send-email-brookxu.cn@gmail.com>
References: <1631884404-24141-1-git-send-email-brookxu.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 17 Sep 2021 21:13:24 +0800, brookxu wrote:
> From: Chunguang Xu <brookxu@tencent.com>
> 
> If the system has multiple VMD controllers, the driver does not assign
> a number to each controller, so when analyzing the interrupt through
> /proc/interrupts, the names of all controllers are the same, which is
> not very convenient for problem analysis. Here, try to assign a number
> to each VMD controller.
> 
> [...]

Applied to pci/vmd, thanks!

[1/1] PCI: vmd: Assign a number to each VMD controller
      https://git.kernel.org/lpieralisi/pci/c/42da7911b8

Thanks,
Lorenzo
