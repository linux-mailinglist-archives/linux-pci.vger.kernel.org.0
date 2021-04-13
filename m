Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA7035DC94
	for <lists+linux-pci@lfdr.de>; Tue, 13 Apr 2021 12:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhDMKmV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Apr 2021 06:42:21 -0400
Received: from foss.arm.com ([217.140.110.172]:40104 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229686AbhDMKmU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Apr 2021 06:42:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F933106F;
        Tue, 13 Apr 2021 03:42:01 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.59.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 110233F73B;
        Tue, 13 Apr 2021 03:41:59 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Colin King <colin.king@canonical.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: remove redundant initialization of pointer dev
Date:   Tue, 13 Apr 2021 11:41:54 +0100
Message-Id: <161831050129.2159.13173655949716032262.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210326190909.622369-1-colin.king@canonical.com>
References: <20210326190909.622369-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 26 Mar 2021 19:09:09 +0000, Colin King wrote:
> The pointer dev is being initialized with a value that is
> never read and it is being updated later with a new value.  The
> initialization is redundant and can be removed.

Applied to pci/endpoint, thanks!

[1/1] PCI: endpoint: Remove redundant initialization of pointer dev
      https://git.kernel.org/lpieralisi/pci/c/80c253bd7f

Thanks,
Lorenzo
