Return-Path: <linux-pci+bounces-43052-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92122CBE207
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 14:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 475FF303DD0C
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 13:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94E9330B3A;
	Mon, 15 Dec 2025 13:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYSI7xoI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF8C330B30;
	Mon, 15 Dec 2025 13:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765805834; cv=none; b=tAqSarLB0cONoWTxFMdoyzOOXs1jardMakEFhwXL6UAeauqDA26qK+00M91XC8EkhML58qm3H1g3b7JXt0Ql/3cZpd2WuZSMexNcS+eiEcdKIf5h4OzZEUKU89q+g03Hq9zYOn2yBVIrCLWZZICoOo3aZMZjvd+rS0aWksWbzJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765805834; c=relaxed/simple;
	bh=1uowNVZ5iB/Udkb1TEVTzDa5CfuL/s8RRv0FRXaqzik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nCJWo6FR+5PS78Ea2tYdNIAkYPKqUBnBhbIO9csuUaVqWNxTg7xQoiuiKhYlu+vcwdijSpLIOJlGHpy78+P6S3VH9tAWlcM50nv80x/dVrACyY465DneqaHmrt1hwvkPLyCQeQroHyMi0t5+ow7et9V+4jfAgeHrBMt6g8B6Dtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYSI7xoI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6516CC4CEFB;
	Mon, 15 Dec 2025 13:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765805834;
	bh=1uowNVZ5iB/Udkb1TEVTzDa5CfuL/s8RRv0FRXaqzik=;
	h=From:To:Cc:Subject:Date:From;
	b=oYSI7xoIlDImUl1WbelttW9wvwd6oj2VA5UV3aXlTAOrwjkzZlzPIW8vm+D1+UBCj
	 4jMeARx1CLbt2Y56ZV6GS22otFXc4dCsh/IgzMgrh3shnaVD/6iiYwB/FA+rnNZ3+5
	 GVFQ2EJlCTDa1W3QMzacNQg08XCaLaP7cZd680+Qmy/UgLPqvCRRxysRb9zFm0Env1
	 d7z62rnkFoGqj5z2xU8NoELFkEU5tG1fq8arF6TRNjaUs5abk6g9vjvRDSf5ge5ixw
	 /WJJDPZoFo3hihMDbmGgJGAluPM0wrS60qwr61Waft0V7RRr2fbuxWVfRxPx0tcsTt
	 IHHEfOAk8QIFw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Chen Yu <yu.c.chen@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Linux PCI <linux-pci@vger.kernel.org>, Alex Hung <alexhung@gmail.com>,
 Hans de Goede <hansg@kernel.org>,
 Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, AceLan Kao <acelan.kao@canonical.com>
Subject: [PATCH v1 0/4] ACPI: scan: Handle generic system devices directly
Date: Mon, 15 Dec 2025 14:31:53 +0100
Message-ID: <7888874.EvYhyI6sBW@rafael.j.wysocki>
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

As per the changelog of patch [1/4], there is a long-standing problem with ACPI
device enumeration that if the given device has a compatible ID which is one of
the generic system resource device IDs (PNP0C01 and PNP0C02), it will be claimed
by the PNP scan handler and it will not be represented as a platform device, so
it cannot be handled by a platform driver.

Obviously, PNP0C01 and PNP0C02 need to be removed from acpi_pnp_device_ids[] to
address this problem, but it cannot be done without making any other changes
due to the way the legacy PNP system driver works (see the changelog of patch
[1/4] for details) and the approach used in patch [1/4] is to reserve the
"motherboard resources" directly in the ACPI core without creating platform
devices for "system" devices (whose _HID is either PNP0C01 or PNP0C02).  The
new code doing works along the lines of the PNP system driver to avoid
regressions.

The remaining patches in the series are simplifications that can be done on
top of the first one.

Patches [2-3/4] remove platform device creation code from Intel HID and VBTN
drivers that don't need to worry about _CID including PNP0C02 any more.

Patch [4/4] drops acpi_nonpnp_device_ids[] that was added as a workaround for
the issue at hand in the first place.

Thanks!




