Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D597930F01A
	for <lists+linux-pci@lfdr.de>; Thu,  4 Feb 2021 11:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235218AbhBDKCd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Feb 2021 05:02:33 -0500
Received: from foss.arm.com ([217.140.110.172]:55172 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235271AbhBDKCb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Feb 2021 05:02:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F8B111D4;
        Thu,  4 Feb 2021 02:01:45 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.48.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 81BFE3F719;
        Thu,  4 Feb 2021 02:01:43 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Shradha Todi <shradha.t@samsung.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        gustavo.pimentel@synopsys.com, niyas.ahmed@samsung.com,
        pankaj.dubey@samsung.com, p.rajanbabu@samsung.com,
        jingoohan1@gmail.com, l.mehra@samsung.com, sriram.dash@samsung.com,
        robh@kernel.org, hari.tv@samsung.com, bhelgaas@google.com
Subject: Re: [PATCH v3] PCI: dwc: Add upper limit address for outbound iATU
Date:   Thu,  4 Feb 2021 10:01:38 +0000
Message-Id: <161243287471.5221.2180903144037812285.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <1612250918-19610-1-git-send-email-shradha.t@samsung.com>
References: <CGME20210202072903epcas5p43dd06fede21ea3a31961b811507fb7f7@epcas5p4.samsung.com> <1612250918-19610-1-git-send-email-shradha.t@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2 Feb 2021 12:58:38 +0530, Shradha Todi wrote:
> The size parameter is unsigned long type which can accept size > 4GB. In
> that case, the upper limit address must be programmed. Add support to
> program the upper limit address and set INCREASE_REGION_SIZE in case size >
> 4GB.

Applied to pci/dwc, thanks!

[1/1] PCI: dwc: Add upper limit address for outbound iATU
      https://git.kernel.org/lpieralisi/pci/c/13662a07fd

Thanks,
Lorenzo
