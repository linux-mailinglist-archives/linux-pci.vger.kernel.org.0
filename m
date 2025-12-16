Return-Path: <linux-pci+bounces-43148-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E14CC5155
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 21:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D8E530378A0
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 20:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48992F362D;
	Tue, 16 Dec 2025 20:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QP2eiHw5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A70263F52;
	Tue, 16 Dec 2025 20:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765916342; cv=none; b=MSxPwBOdGnXZuF7TyT8EEwVq8hjvyd4nWOU/YLg1Xya/wIdkCT8CPnp1ILak0meI4Lib1koiydczu8G691oYIxDwIjkCD+o0+0dmWsOGpwLlt3lG8m8qIamED84oqiv94wFdceoTlwgEmr9yojJBfGfz2rmc/pvr1rVwZVjYm+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765916342; c=relaxed/simple;
	bh=LMochKQTfRhgFAfE0enCos5C4dlpZ5n0Zl0nq/fJS2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o3x5XaaF6K8tEErA6KaEvSPdCqFjlIqK+ObhYvhKqBUlfEIrkNH3KzFOJThrbW7KDHBy/s5Q1XjWlNoy+Jqnj9tZuUudwAdqsGoz0TDlrvn/k3oSzaycMXrMn5jK7NdaQNwZnlD84ChxyTdOjMFG1eW8LxEFI9ZS3lHOye14KcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QP2eiHw5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B36C4CEF1;
	Tue, 16 Dec 2025 20:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765916341;
	bh=LMochKQTfRhgFAfE0enCos5C4dlpZ5n0Zl0nq/fJS2o=;
	h=From:To:Cc:Subject:Date:From;
	b=QP2eiHw5vljJFWYCkhqRTZMexs4sMFhf7CbCaaNaXL7mugkvlST0dk4h58OcK0Anq
	 X1ptBAIs6OP9+Zsk2v02aQCfVONROLFPanNCZ6Yr9q2KVEOmNt1lPV5w4yDexzSOlZ
	 wZLABN5gmcODsrpGwzc/bcRteFUzXPNrtKp8mm57D7fLHqfYEK0CUZzLFuie0nsEmH
	 gJ9Cntn05JS4auxzR0nRElHGEDFCvASfrgKWB8MdSvJRo2+G3V1d2M86bHiPBhO5fA
	 HwwTDWSuUPs22wSS2CDkwMvDTpXXhFk3TOA4EQQire0KPhQS4x+cqap+BLs4gJ/inN
	 qjfw/LuM5S/RQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v1 0/2] ACPI: bus: Adjustments related to \_SB._OSC
Date: Tue, 16 Dec 2025 21:15:34 +0100
Message-ID: <12803663.O9o76ZdvQC@rafael.j.wysocki>
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

The first patch works around a platform firmware issue causing
acpi_run_osc() to return an error when run with "query enable" bit
clear after negotiating the supported feature mask.

The second one is a cleanup on top of the first one.

Thanks!




