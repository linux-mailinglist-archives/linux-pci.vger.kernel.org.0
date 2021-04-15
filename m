Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B202360EA6
	for <lists+linux-pci@lfdr.de>; Thu, 15 Apr 2021 17:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235394AbhDOPS2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Apr 2021 11:18:28 -0400
Received: from foss.arm.com ([217.140.110.172]:48992 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234184AbhDOPRM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Apr 2021 11:17:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2531106F;
        Thu, 15 Apr 2021 08:16:48 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.59.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C10493FA35;
        Thu, 15 Apr 2021 08:16:47 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        bhelgaas@google.com, robh@kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: remove unused function
Date:   Thu, 15 Apr 2021 16:16:42 +0100
Message-Id: <161849979041.31936.12116669738493626455.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <1618475577-99198-1-git-send-email-jiapeng.chong@linux.alibaba.com>
References: <1618475577-99198-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 15 Apr 2021 16:32:57 +0800, Jiapeng Chong wrote:
> Fix the following clang warning:
> 
> drivers/pci/controller/dwc/pcie-intel-gw.c:84:19: warning: unused
> function 'pcie_app_rd' [-Wunused-function].

Applied to pci/dwc, thanks!

[1/1] PCI: dwc/intel-gw: Remove unused function
      https://git.kernel.org/lpieralisi/pci/c/9534286be3

Thanks,
Lorenzo
