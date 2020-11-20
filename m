Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A152BB12D
	for <lists+linux-pci@lfdr.de>; Fri, 20 Nov 2020 18:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730306AbgKTRHW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Nov 2020 12:07:22 -0500
Received: from foss.arm.com ([217.140.110.172]:52580 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729976AbgKTRHV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Nov 2020 12:07:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CA5B1042;
        Fri, 20 Nov 2020 09:07:21 -0800 (PST)
Received: from red-moon.arm.com (unknown [10.57.59.104])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 68C893F70D;
        Fri, 20 Nov 2020 09:07:18 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        open list <linux-kernel@vger.kernel.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH v1] PCI: brcmstb: variable is missing proper initialization
Date:   Fri, 20 Nov 2020 17:07:12 +0000
Message-Id: <160589201520.1295.14447752492499400941.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20201102205712.23332-1-james.quinlan@broadcom.com>
References: <20201102205712.23332-1-james.quinlan@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2 Nov 2020 15:57:12 -0500, Jim Quinlan wrote:
> The variable 'tmp' is used multiple times in the brcm_pcie_setup()
> function.  One such usage did not initialize 'tmp' to the current value of
> the target register.  By luck the mistake does not currently affect
> behavior;  regardless 'tmp' is now initialized properly.

Applied to pci/brcmstb, thanks!

[1/1] PCI: brcmstb: Initialize "tmp" before use
      https://git.kernel.org/lpieralisi/pci/c/ddaff0af65

Thanks,
Lorenzo
