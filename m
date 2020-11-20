Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A252BB14E
	for <lists+linux-pci@lfdr.de>; Fri, 20 Nov 2020 18:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbgKTRUl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Nov 2020 12:20:41 -0500
Received: from foss.arm.com ([217.140.110.172]:52674 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727281AbgKTRUl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Nov 2020 12:20:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BD091042;
        Fri, 20 Nov 2020 09:20:40 -0800 (PST)
Received: from red-moon.arm.com (unknown [10.57.59.104])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE8103F70D;
        Fri, 20 Nov 2020 09:20:38 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        robh+dt@kernel.org, marek.vasut+renesas@gmail.com,
        bhelgaas@google.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-pci@vger.kernel.org, prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [PATCH v3 0/3] dt-bindings: PCI: rcar-pci-host: Convert bindings to json-schema
Date:   Fri, 20 Nov 2020 17:20:32 +0000
Message-Id: <160589281011.7698.914867341349617347.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <1604455096-13923-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1604455096-13923-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 4 Nov 2020 10:58:13 +0900, Yoshihiro Shimoda wrote:
> Convert bindings of rcar-pci.txt to json-schema. Also, document
> r8a77965 and r8a774e1 to the yaml file.
> 
> Changes from v2:
>  - Fix the subjects of all patches which Bjorn pointed it out:
>  https://patchwork.kernel.org/project/linux-renesas-soc/cover/1604035745-22095-1-git-send-email-yoshihiro.shimoda.uh@renesas.com/#23734117
>  - Minor fix the description in the patch 3/3.
>  https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=373695
> 
> [...]

Applied to pci/rcar, thanks!

[1/3] dt-bindings: PCI: rcar-pci-host: Convert bindings to json-schema
      https://git.kernel.org/lpieralisi/pci/c/0d69ce3c2c
[2/3] dt-bindings: PCI: rcar-pci-host: Document r8a77965 bindings
      https://git.kernel.org/lpieralisi/pci/c/2228af8093
[3/3] dt-bindings: PCI: rcar-pci-host: Document r8a774e1 bindings
      https://git.kernel.org/lpieralisi/pci/c/64fc0a0309

Thanks,
Lorenzo
