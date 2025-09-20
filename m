Return-Path: <linux-pci+bounces-36587-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B86B8C649
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 12:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CED0561F65
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 10:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F031C2FB61B;
	Sat, 20 Sep 2025 10:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxlhuy9E"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C565E2FB0BF;
	Sat, 20 Sep 2025 10:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758365833; cv=none; b=HVAxgvJuQQLmb0Q0ucFykL38qcfZN89l4F/8kUBdDy29YdwvZizYAHaz/iD4Vmw7/Y4gTt4O7ukxhnb2qnXwafxPeRv72tLXwauIpd8F+U3iLozN0nIXxl/Eartm+ygEnwOlCQ/ZvgUY6rd+FXbKz/l7ZyUtZx5REIfOioZVkKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758365833; c=relaxed/simple;
	bh=yYVMmJebjyvhAMI0vNOseGRqv1Zt8GB5Yr7JAjI8DM8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eyjR1Fe5VLLhsijdDHY99Zc/wxU4HAjktvqUp6dJSi5c1Vm2841ElgdUFpemR9ZoL/E/vLGpvDALpnBrc3a8uba2MS5MAMFQJL/B+QCXaDyEPLTOwlwxId6ixoOl7N5u0RsNac12ZKxSXG+UKQKgxAvN1BWicNW/hdLDa/ZpIKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxlhuy9E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E12C4CEEB;
	Sat, 20 Sep 2025 10:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758365832;
	bh=yYVMmJebjyvhAMI0vNOseGRqv1Zt8GB5Yr7JAjI8DM8=;
	h=From:To:Cc:Subject:Date:From;
	b=hxlhuy9EGkPu5DFPz7Ogitjzmw/lm5p4Qt6towc5r1Yzk8O1yTuppxKBi5voqQ5aI
	 GtfIZmXoHQzphbQEmv4rQARoFK8tti6V7HqMvefZjwbem0aUiS+1ZoZTST7t15p9ya
	 h03OtHFRz0rXMBspG1Y3+UltHHLtIsSgr612AWUixfEdbdmidINuxFmOzDcFw1z3Lf
	 55HRQxBSMP/ha4MajdmYCSQyYjtEsZbZH57NbMQF0SAuQoTnsK5RUSzSAwiJkuxLlE
	 K3+to1eFrsyFG9326rax5YZE2jDTCSFGkuMGc02aKd8SxPArjezm1fKNmBqqsPmG9+
	 SHTZe0EiFMBdQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Zhang Qilong <zhangqilong3@huawei.com>,
 Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 0/3] PM: runtime: Auto-cleanup macros for runtime PM
Date: Sat, 20 Sep 2025 12:49:20 +0200
Message-ID: <6204724.lOV4Wx5bFT@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi All,

This supersedes both

https://lore.kernel.org/linux-pm/5049058.31r3eYUQgx@rafael.j.wysocki/

and

https://lore.kernel.org/linux-pm/20250919163147.4743-1-tiwai@suse.de/

that were sent simultaneously by mistake and both made a mistake of
forgetting that __pm_runtime_suspend() returns an error code for devices
with runtime PM disabled.

The first patch in this series has been modified to provide additional
two macros for the cases in which runtime PM is expected to work
transparently if runtime PM has been disabled for the given device.
Also the names of the new classes defined in it and the new helper
static inline function have been changed.

The second patch has been updated to reflect the changes in the first patch.

The last patch is basically the same as before.

Thanks!




