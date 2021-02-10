Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2772316724
	for <lists+linux-pci@lfdr.de>; Wed, 10 Feb 2021 13:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbhBJMxf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Feb 2021 07:53:35 -0500
Received: from foss.arm.com ([217.140.110.172]:37112 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhBJMx1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Feb 2021 07:53:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59E34D6E;
        Wed, 10 Feb 2021 04:52:41 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.46.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 162763F73D;
        Wed, 10 Feb 2021 04:52:38 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     tjoseph@cadence.com, linux-pci@vger.kernel.org, kishon@ti.com,
        bhelgaas@google.com, robh@kernel.org, linux-kernel@vger.kernel.org,
        Nadeem Athani <nadeem@cadence.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, mparab@cadence.com,
        pthombar@cadence.com, sjakhade@cadence.com
Subject: Re: [PATCH v8 0/2] PCI: cadence: Retrain Link to work around Gen2
Date:   Wed, 10 Feb 2021 12:52:33 +0000
Message-Id: <161296139640.22133.12504586706777255696.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210209144622.26683-1-nadeem@cadence.com>
References: <20210209144622.26683-1-nadeem@cadence.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 9 Feb 2021 15:46:20 +0100, Nadeem Athani wrote:
> Cadence controller will not initiate autonomous speed change if strapped
> as Gen2. The Retrain Link bit is set as quirk to enable this speed change.
> Adding a quirk flag for defective IP. In future IP revisions this will not
> be applicable.
> 
> Version history:
> Changes in v8:
> - Adding a new function cdns_pcie_host_start_link().
> Changes in v7:
> - Changing the commit title of patch 1 in this series.
> - Added a return value for function cdns_pcie_retrain().
> Changes in v6:
> - Move the position of function cdns_pcie_host_wait_for_link to remove
>   compilation error. No changes in code. Separate patch for this.
> Changes in v5:
> - Remove the compatible string based setting of quirk flag.
> - Removed additional Link Up Check
> - Removed quirk from pcie-cadence-plat.c and added in pci-j721e.c
> Changes in v4:
> - Added a quirk flag based on a new compatible string.
> - Change of api for link up: cdns_pcie_host_wait_for_link().
> Changes in v3:
> - To set retrain link bit,checking device capability & link status.
> - 32bit read in place of 8bit.
> - Minor correction in patch comment.
> - Change in variable & macro name.
> Changes in v2:
> - 16bit read in place of 8bit.
> 
> [...]

Applied to pci/cadence, squashed two commits together since it makes
no sense to keep them separate. Also, please check:

git log --oneline

when writing patches to keep the changes uniform, I had to edit your
commit.

Thanks,
Lorenzo
