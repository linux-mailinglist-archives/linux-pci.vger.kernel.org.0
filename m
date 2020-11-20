Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D3E2BB15D
	for <lists+linux-pci@lfdr.de>; Fri, 20 Nov 2020 18:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbgKTRYh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Nov 2020 12:24:37 -0500
Received: from foss.arm.com ([217.140.110.172]:52724 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbgKTRYg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Nov 2020 12:24:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 449501042;
        Fri, 20 Nov 2020 09:24:36 -0800 (PST)
Received: from red-moon.arm.com (unknown [10.57.59.104])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 530213F70D;
        Fri, 20 Nov 2020 09:24:34 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: Make "cdns,max-outbound-regions" optional DT property
Date:   Fri, 20 Nov 2020 17:24:28 +0000
Message-Id: <160589305028.9644.11702297245351250409.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20201106151107.3987-1-kishon@ti.com>
References: <20201106151107.3987-1-kishon@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 6 Nov 2020 20:41:05 +0530, Kishon Vijay Abraham I wrote:
> Make "cdns,max-outbound-regions" optional DT property in all the
> platforms using Cadence PCIe core.
> 
> Kishon Vijay Abraham I (2):
>   dt-bindings: PCI: Make "cdns,max-outbound-regions" optional property
>   PCI: cadence: Do not error if "cdns,max-outbound-regions" is not found
> 
> [...]

Applied to pci/cadence, thanks!

[1/2] dt-bindings: PCI: Make "cdns,max-outbound-regions" optional property
      https://git.kernel.org/lpieralisi/pci/c/4a2b9125c9
[2/2] PCI: cadence: Do not error if "cdns,max-outbound-regions" is not found
      https://git.kernel.org/lpieralisi/pci/c/e87d17ca6a

Thanks,
Lorenzo
