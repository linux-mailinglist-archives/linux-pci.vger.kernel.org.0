Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 046434F0EF
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2019 01:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbfFUXBO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jun 2019 19:01:14 -0400
Received: from gate.crashing.org ([63.228.1.57]:38964 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbfFUXBO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Jun 2019 19:01:14 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5LN0o4V028115;
        Fri, 21 Jun 2019 18:00:52 -0500
Message-ID: <43b27f7fc83a90dc3d1345ee3771fcce337f6bb8.camel@kernel.crashing.org>
Subject: Re: [PATCH 1/4] arm64: pci: acpi: Use
 pci_assign_unassigned_root_bus_resources()
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sinan Kaya <okaya@kernel.org>, Ali Saidi <alisaidi@amazon.com>,
        Zeev Zilberman <zeev@amazon.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Date:   Sat, 22 Jun 2019 09:00:50 +1000
In-Reply-To: <20190621204839.GF127746@google.com>
References: <20190615002359.29577-1-benh@kernel.crashing.org>
         <20190621204839.GF127746@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

BTW...

You probably want to swap those 2:

2 hours	PCI/ACPI: Evaluate PCI Boot Configuration _DSM	Benjamin Herrenschmidt	3	-3/+18
2 hours	PCI: Don't auto-realloc if we're preserving firmware config

As "Don't auto-realloc..." tests a flag that is only created by "Evaluate PCI Boot..."

Cheers,
Ben.


