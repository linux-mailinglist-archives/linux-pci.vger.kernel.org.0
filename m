Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCEA2461680
	for <lists+linux-pci@lfdr.de>; Mon, 29 Nov 2021 14:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236167AbhK2Ngj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 08:36:39 -0500
Received: from foss.arm.com ([217.140.110.172]:39516 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243004AbhK2Neh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Nov 2021 08:34:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF86D1042;
        Mon, 29 Nov 2021 05:31:19 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.34.225])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E9C6F3F766;
        Mon, 29 Nov 2021 05:31:17 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     kw@linux.com, bhelgaas@google.com, swboyd@chromium.org,
        robh@kernel.org, svarbanov@mm-sol.com, agross@kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        pmaliset@codeaurora.org, bjorn.andersson@linaro.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Fix an error handling path in 'qcom_pcie_probe()'
Date:   Mon, 29 Nov 2021 13:30:55 +0000
Message-Id: <163819262283.21004.1141413014119592076.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <4d03c636193f64907c8dacb17fa71ed05fd5f60c.1636220582.git.christophe.jaillet@wanadoo.fr>
References: <4d03c636193f64907c8dacb17fa71ed05fd5f60c.1636220582.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 6 Nov 2021 18:44:52 +0100, Christophe JAILLET wrote:
> If 'of_device_get_match_data()' fails, previous 'pm_runtime_get_sync()/
> pm_runtime_enable()' should be undone.
> 
> To fix it, the easiest is to move this block of code before the memory
> allocations and the pm_runtime_xxx calls.
> 
> 
> [...]

Applied to pci/qcom, thanks!

[1/1] PCI: qcom: Fix an error handling path in 'qcom_pcie_probe()'
      https://git.kernel.org/lpieralisi/pci/c/4e0e90539b

Thanks,
Lorenzo
