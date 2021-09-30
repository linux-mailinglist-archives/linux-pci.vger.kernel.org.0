Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1275541D6AF
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 11:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349541AbhI3Jri (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 05:47:38 -0400
Received: from foss.arm.com ([217.140.110.172]:51276 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349538AbhI3Jrf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Sep 2021 05:47:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F5ACD6E;
        Thu, 30 Sep 2021 02:45:52 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.49.184])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2C463F793;
        Thu, 30 Sep 2021 02:45:49 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Toan Le <toan@os.amperecomputing.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: xgene: Use PCI_VENDOR_ID_AMCC macro
Date:   Thu, 30 Sep 2021 10:45:43 +0100
Message-Id: <163299512691.26235.11712454175054119458.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210927134356.11799-1-pali@kernel.org>
References: <20210927134356.11799-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 27 Sep 2021 15:43:56 +0200, Pali Rohár wrote:
> Header file linux/pci_ids.h defines AMCC vendor id (0x10e8) macro named
> PCI_VENDOR_ID_AMCC. So use this macro instead of driver custom macro.
> 
> 

Applied to pci/xgene, thanks!

[1/1] PCI: xgene: Use PCI_VENDOR_ID_AMCC macro
      https://git.kernel.org/lpieralisi/pci/c/894682f0a9

Thanks,
Lorenzo
