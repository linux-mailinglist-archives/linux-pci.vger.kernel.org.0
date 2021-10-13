Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C457842C283
	for <lists+linux-pci@lfdr.de>; Wed, 13 Oct 2021 16:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhJMOPQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Oct 2021 10:15:16 -0400
Received: from foss.arm.com ([217.140.110.172]:39894 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234469AbhJMOPP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Oct 2021 10:15:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C5AAD6E;
        Wed, 13 Oct 2021 07:13:12 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.53.207])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4ED093F694;
        Wed, 13 Oct 2021 07:13:11 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-pci@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-um@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] PCI: vmd: depend on !UML
Date:   Wed, 13 Oct 2021 15:13:04 +0100
Message-Id: <163413437431.14367.12294124839040027341.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210811162530.affe26231bc3.I131b3c1e67e3d2ead6e98addd256c835fbef9a3e@changeid>
References: <20210811162530.affe26231bc3.I131b3c1e67e3d2ead6e98addd256c835fbef9a3e@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 11 Aug 2021 16:25:30 +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> With UML having enabled (simulated) PCI on UML, VMD breaks
> allyesconfig/allmodconfig compilation because it assumes
> it's running on X86_64 bare metal, and has hardcoded API
> use of ARCH=x86. Make it depend on !UML to fix this.
> 
> [...]

Applied to pci/vmd, thanks!

[1/1] PCI: vmd: depend on !UML
      https://git.kernel.org/lpieralisi/pci/c/42cf2a633d

Thanks,
Lorenzo
