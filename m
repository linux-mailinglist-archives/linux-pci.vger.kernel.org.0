Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 001503446F7
	for <lists+linux-pci@lfdr.de>; Mon, 22 Mar 2021 15:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbhCVOTz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Mar 2021 10:19:55 -0400
Received: from foss.arm.com ([217.140.110.172]:32796 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229871AbhCVOTa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Mar 2021 10:19:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5606F1042;
        Mon, 22 Mar 2021 07:19:30 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.55.31])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 436293F719;
        Mon, 22 Mar 2021 07:19:28 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Ray Jui <ray.jui@broadcom.com>,
        Rob Herring <robh@kernel.org>,
        Sandor Bodo-Merle <sbodomerle@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: iproc: Fix return value of iproc_msi_irq_domain_alloc()
Date:   Mon, 22 Mar 2021 14:19:21 +0000
Message-Id: <161642273922.7027.4912447673502111570.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210303142202.25780-1-pali@kernel.org>
References: <20210303142202.25780-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 3 Mar 2021 15:22:02 +0100, Pali Rohár wrote:
> IRQ domain alloc function should return zero on success. Non-zero value
> indicates failure.

Applied to pci/iproc, thanks!

[1/1] PCI: iproc: Fix return value of iproc_msi_irq_domain_alloc()
      https://git.kernel.org/lpieralisi/pci/c/1e83130f01

Thanks,
Lorenzo
