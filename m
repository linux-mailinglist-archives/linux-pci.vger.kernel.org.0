Return-Path: <linux-pci+bounces-888-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF753811AE8
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 18:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD51B282A22
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 17:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F8F5677E;
	Wed, 13 Dec 2023 17:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J28pqTwY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2708651C31
	for <linux-pci@vger.kernel.org>; Wed, 13 Dec 2023 17:25:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22CFEC433C8;
	Wed, 13 Dec 2023 17:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702488333;
	bh=GtbLTnJw5rFoK0rP15arBSE3OgmfBkXPDeM9z0GJ5ys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J28pqTwYDp0mBb8bP1o+zNlpRsT0ReB4N8S1dSs/sWF2c0hgsUqyEK8guK2sofO96
	 XPPOra6u72Q7Vdg7gMFs9FxWAlHZa+ntotNiHJkARBPtCmzjWo6utPjF/rRhhi+VNT
	 MgNUgJ8AlU7lErNPupvGqDc1VRdincBPuxtpaJOMViD/QSTpIYArkPgStDObY2hcd/
	 jlKBjsEw/Xp0ch+VNHytq5HQEwhIZ8Tc4ysmtQV2JnSsE4AEjmmDN2Rk+JmRji4wu7
	 NUQ1C2Qy5u/tXu1SgWSzfNxURKCdgLnYIWi8+KreaR7hgRTqvV0dCbBSPxkLza/PC+
	 p3u2cl0f3WOrw==
From: Will Deacon <will@kernel.org>
To: yangyicong@huawei.com,
	Jonathan.Cameron@huawei.com,
	ilkka@os.amperecomputing.com,
	robin.murphy@arm.com,
	kaishen@linux.alibaba.com,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	helgaas@kernel.org,
	baolin.wang@linux.alibaba.com
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	chengyou@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	renyu.zj@linux.alibaba.com,
	zhuo.song@linux.alibaba.com,
	mark.rutland@arm.com,
	rdunlap@infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v12 0/5] drivers/perf: add Synopsys DesignWare PCIe PMU driver support
Date: Wed, 13 Dec 2023 17:25:20 +0000
Message-Id: <170247454282.4025634.10934949931800191482.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231208025652.87192-1-xueshuai@linux.alibaba.com>
References: <20231208025652.87192-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 8 Dec 2023 10:56:47 +0800, Shuai Xue wrote:
> Change Log
> ==========
> change sinces v11:
> - Fix uninitialized symbol 'now' (Per Dan and Will)
> - Pick up Reviewed-and-tested-by tag from Ilkka for Patch 4/5
> 
> change sinces v10:
> - Rename to pci_clear_and_set_config_dword() to retain the "config"
>   information and match the other accessors. (Per Bjorn)
> - Align pci_clear_and_set_config_dword() and its call site (Per Bjorn)
> - Polish commit log (Per Bjorn)
> - Simplify dwc_pcie_pmu_time_based_event_enable() with bool value (Per Ilkka)
> - Fix dwc_pcie_register_dev() return value (Per Ilkka)
> - Fix vesc capability discovery by pdev->vendor (Per Ilkka)
> - pick up Acked-by tag from Bjorn for Patch 3/5
> - pick up Tested-by tag from Ilkka for all patch set
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/5] docs: perf: Add description for Synopsys DesignWare PCIe PMU driver
      https://git.kernel.org/will/c/cae40614cdd6
[2/5] PCI: Add Alibaba Vendor ID to linux/pci_ids.h
      https://git.kernel.org/will/c/ad6534c626fe
[3/5] PCI: Move pci_clear_and_set_dword() helper to PCI header
      https://git.kernel.org/will/c/ac16087134b8
[4/5] drivers/perf: add DesignWare PCIe PMU driver
      https://git.kernel.org/will/c/af9597adc2f1
[5/5] MAINTAINERS: add maintainers for DesignWare PCIe PMU driver
      https://git.kernel.org/will/c/f56bb3de66bc

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

