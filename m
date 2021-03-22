Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B27C7344D37
	for <lists+linux-pci@lfdr.de>; Mon, 22 Mar 2021 18:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbhCVR0J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Mar 2021 13:26:09 -0400
Received: from foss.arm.com ([217.140.110.172]:35830 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230215AbhCVRZq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Mar 2021 13:25:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A738C113E;
        Mon, 22 Mar 2021 10:25:45 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.49.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3233B3F719;
        Mon, 22 Mar 2021 10:25:43 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        Mingkai Hu <mingkai.hu@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Zheng Yongjun <zhengyongjun3@huawei.com>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        linuxppc-dev@lists.ozlabs.org, Roy Zang <roy.zang@nxp.com>
Subject: Re: [PATCH] PCI: layerscape: Correct syntax by changing comma to semicolon
Date:   Mon, 22 Mar 2021 17:25:36 +0000
Message-Id: <161643390998.3356.13620693007705866206.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210311033745.1547044-1-kw@linux.com>
References: <20210311033745.1547044-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 11 Mar 2021 03:37:45 +0000, Krzysztof Wilczyński wrote:
> Replace command with a semicolon to correct syntax and to prevent
> potential unspecified behaviour and/or unintended side effects.
> 
> Related:
>   https://lore.kernel.org/linux-pci/20201216131944.14990-1-zhengyongjun3@huawei.com/

Applied to pci/layerscape, thanks!

[1/1] PCI: layerscape: Correct syntax by changing comma to semicolon
      https://git.kernel.org/lpieralisi/pci/c/1b7996a528

Thanks,
Lorenzo
