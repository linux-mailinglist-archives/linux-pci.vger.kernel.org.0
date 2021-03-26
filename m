Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F83634AB67
	for <lists+linux-pci@lfdr.de>; Fri, 26 Mar 2021 16:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhCZPXV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Mar 2021 11:23:21 -0400
Received: from foss.arm.com ([217.140.110.172]:35376 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230100AbhCZPXS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 Mar 2021 11:23:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FEBC1474;
        Fri, 26 Mar 2021 08:23:18 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.46.206])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DD9E3F792;
        Fri, 26 Mar 2021 08:23:15 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-kernel@vger.kernel.org, Shradha Todi <shradha.t@samsung.com>,
        linux-pci@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, hari.tv@samsung.com,
        p.rajanbabu@samsung.com, niyas.ahmed@samsung.com,
        bhelgaas@google.com, pankaj.dubey@samsung.com,
        Sriram Dash <dash.sriram@gmail.com>, l.mehra@samsung.com,
        kishon@ti.com
Subject: Re: [PATCH v5] PCI: endpoint: Fix NULL pointer dereference for ->get_features()
Date:   Fri, 26 Mar 2021 15:23:08 +0000
Message-Id: <161677217283.28772.11255664363565834754.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210324101609.79278-1-shradha.t@samsung.com>
References: <CGME20210324101555epcas5p1b5c8ff4d99b045b94f820c2151800127@epcas5p1.samsung.com> <20210324101609.79278-1-shradha.t@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 24 Mar 2021 15:46:09 +0530, Shradha Todi wrote:
> get_features ops of pci_epc_ops may return NULL, causing NULL pointer
> dereference in pci_epf_test_alloc_space function. Let us add a check for
> pci_epc_feature pointer in pci_epf_test_bind before we access it to avoid
> any such NULL pointer dereference and return -ENOTSUPP in case
> pci_epc_feature is not found.
> 
> When the patch is not applied and EPC features is not implemented in the
> platform driver, we see the following dump due to kernel NULL pointer
> dereference.
> 
> [...]

Applied to pci/endpoint, thanks!

[1/1] PCI: endpoint: Fix NULL pointer dereference for ->get_features()
      https://git.kernel.org/lpieralisi/pci/c/6613bc2301

Thanks,
Lorenzo
