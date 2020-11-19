Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E0D2B9061
	for <lists+linux-pci@lfdr.de>; Thu, 19 Nov 2020 11:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgKSKrr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Nov 2020 05:47:47 -0500
Received: from foss.arm.com ([217.140.110.172]:52772 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbgKSKrr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Nov 2020 05:47:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 620E31396;
        Thu, 19 Nov 2020 02:47:46 -0800 (PST)
Received: from red-moon.arm.com (unknown [10.57.62.135])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0E7D3F718;
        Thu, 19 Nov 2020 02:47:42 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Alex Dewar <alex.dewar90@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        linux-riscv@lists.infradead.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, linux-pci@vger.kernel.org,
        Vidya Sagar <vidyas@nvidia.com>,
        Dilip Kota <eswara.kota@linux.intel.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Thierry Reding <treding@nvidia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH v2] PCI: keystone: Enable compile-testing on !ARM
Date:   Thu, 19 Nov 2020 10:47:37 +0000
Message-Id: <160578283808.28676.5654476395812766238.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200906195128.279342-1-alex.dewar90@gmail.com>
References: <20200906194850.63glbnehjcuw356k@lenovo-laptop> <20200906195128.279342-1-alex.dewar90@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 6 Sep 2020 20:51:27 +0100, Alex Dewar wrote:
> Currently the Keystone driver can only be compile-tested on ARM, but
> this restriction seems unnecessary. Get rid of it to increase test
> coverage.
> 
> Build-tested with allyesconfig on x86, ppc, mips and riscv.

Applied to pci/keystone, thanks!

[1/1] PCI: keystone: Enable compile-testing on !ARM
      https://git.kernel.org/lpieralisi/pci/c/476b70b4d1

Thanks,
Lorenzo
