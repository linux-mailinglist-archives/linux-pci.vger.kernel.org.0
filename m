Return-Path: <linux-pci+bounces-38230-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A67BDEEF0
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 16:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3370A3B312E
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 14:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFC3254B18;
	Wed, 15 Oct 2025 14:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADkYFgIV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF7B25487B;
	Wed, 15 Oct 2025 14:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760537129; cv=none; b=NKe/xhm0KF4NQDLw6WX9V5TKejwbn2YQGXymH960t9EN7PkZGAAfTahVRWSPsegi6DdqK9B2z48ItiPR71CuQCbp4/jp1RYX+I9+F20J+2qA68g2zbskXEHDg0/yLof1o7q+/OUPwAcPKWgDLDWX/MwcKZfC+kiCsl/kXRtbxfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760537129; c=relaxed/simple;
	bh=vmlYb0g+8Bco2x8DuZ7wv9Yxt/D7mnkuiu2npAVRBXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QrCp78GK1Td7+RWcuU1qUN0rth4EmV8nBZ11Q1+LlZZdejok7EglH6ryLuszkts5ZqU9pewdjgOyo55+QuxZer/CuYhXEbYhk0OYyRnEjl6SKcDhuuk4n8eovRdyh+BixiTm7XIK4cMv0YvvYPGE+t59kTwrfQYeUS6H0wWPTLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADkYFgIV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8642BC4CEFB;
	Wed, 15 Oct 2025 14:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760537129;
	bh=vmlYb0g+8Bco2x8DuZ7wv9Yxt/D7mnkuiu2npAVRBXI=;
	h=From:To:Cc:Subject:Date:From;
	b=ADkYFgIVWWX1zfKViU2vKx02y/WaRMhIz4kdl937KEp/Nv8dKiU4re62ORCqcJ3lu
	 YxRDRmIffUaPlBnCjc2KkusZAthJF4pNY3IHyXcovlLqjELAztczGD0byHcPFtG1Ap
	 MjSeNrBcZ+ufgK1+6I/zEcIaDLxP5qmcLxc5tJa8fbbdybSNoxMvjyOCgIH7R9HegU
	 AQ9VijTzCJLVW1QEjV2p0QN9ammE/QIjkaMWVy6gv1g2k1fqRc6TKjOeJe5tKsI7n8
	 69bwNQ+v2NauFdCls+QwA9bnYkL5LnGYVwCMvOJno8bTMVB5HTaLcsf/VlhAxFyJVr
	 fParbeerFKZDA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Takashi Iwai <tiwai@suse.de>, LKML <linux-kernel@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Zhang Qilong <zhangqilong3@huawei.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Frank Li <Frank.Li@nxp.com>,
 Dhruva Gole <d-gole@ti.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Subject:
 [PATCH v1 0/3] PM: runtimePCI/ACPI: TAD: Auto-cleanup macros for runtime PM
Date: Wed, 15 Oct 2025 15:59:48 +0200
Message-ID: <3925484.kQq0lBPeGt@rafael.j.wysocki>
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

This series introduces a helper macro on top of the recently added runtime PM
usage counter guard definitions, uses it in the PCI sysfs code (patch [1/3])
and modifies the runtime PM usage counter handling in the ACPI TAD driver
with the help of it (patch [3/3]).  Patch [3/2] is a preparation for the
latter.

Thanks!




