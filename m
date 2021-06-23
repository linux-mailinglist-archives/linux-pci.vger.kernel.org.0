Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F693B1C20
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jun 2021 16:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhFWONL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Jun 2021 10:13:11 -0400
Received: from foss.arm.com ([217.140.110.172]:36130 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231157AbhFWONK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Jun 2021 10:13:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17CB9ED1;
        Wed, 23 Jun 2021 07:10:53 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.46.124])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C7D63F718;
        Wed, 23 Jun 2021 07:10:51 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-pci@vger.kernel.org, robh@kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH] PCI: dwc/intel-gw: Fix enabling the legacy PCI interrupt lines
Date:   Wed, 23 Jun 2021 15:10:41 +0100
Message-Id: <162445735726.18490.16882264115917693915.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210106135540.48420-1-martin.blumenstingl@googlemail.com>
References: <20210106135540.48420-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 6 Jan 2021 14:55:40 +0100, Martin Blumenstingl wrote:
> The legacy PCI interrupt lines need to be enabled using PCIE_APP_IRNEN
> bits 13 (INTA), 14 (INTB), 15 (INTC) and 16 (INTD). The old code however
> was taking (for example) "13" as raw value instead of taking BIT(13).
> Define the legacy PCI interrupt bits using the BIT() macro and then use
> these in PCIE_APP_IRN_INT.

Applied to pci/dwc, thanks!

[1/1] PCI: dwc/intel-gw: Fix enabling the legacy PCI interrupt lines
      https://git.kernel.org/lpieralisi/pci/c/263dcd1abf

Thanks,
Lorenzo
