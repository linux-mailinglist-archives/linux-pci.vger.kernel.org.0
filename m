Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6207B30AFD0
	for <lists+linux-pci@lfdr.de>; Mon,  1 Feb 2021 19:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhBASy7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Feb 2021 13:54:59 -0500
Received: from foss.arm.com ([217.140.110.172]:36522 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229996AbhBASy6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Feb 2021 13:54:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C73D3147A;
        Mon,  1 Feb 2021 10:54:12 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.48.13])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CFDE63F71A;
        Mon,  1 Feb 2021 10:54:10 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Shradha Todi <shradha.t@samsung.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        pankaj.dubey@samsung.com, bhelgaas@google.com,
        p.rajanbabu@samsung.com, niyas.ahmed@samsung.com, robh@kernel.org,
        jingoohan1@gmail.com, hari.tv@samsung.com, sriram.dash@samsung.com,
        l.mehra@samsung.com, gustavo.pimentel@synopsys.com
Subject: Re: [PATCH v2] PCI: dwc: Change size to u64 for EP outbound iATU
Date:   Mon,  1 Feb 2021 18:53:56 +0000
Message-Id: <161220559963.22650.18120544443650114813.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <1609929900-19082-1-git-send-email-shradha.t@samsung.com>
References: <CGME20210106104514epcas5p37d8e3a88aefdf109f7fb4157d4a1f07a@epcas5p3.samsung.com> <1609929900-19082-1-git-send-email-shradha.t@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 6 Jan 2021 16:15:00 +0530, Shradha Todi wrote:
> Since outbound iATU permits size to be greater than 4GB for which the
> support is also available, allow EP function to send u64 size instead of
> truncating to u32.

Applied to pci/dwc, thanks!

[1/1] PCI: dwc: Change size to u64 for EP outbound iATU
      https://git.kernel.org/lpieralisi/pci/c/95a3472255

Thanks,
Lorenzo
