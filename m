Return-Path: <linux-pci+bounces-40597-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB79C4150A
	for <lists+linux-pci@lfdr.de>; Fri, 07 Nov 2025 19:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC49A3A917D
	for <lists+linux-pci@lfdr.de>; Fri,  7 Nov 2025 18:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11F533B97A;
	Fri,  7 Nov 2025 18:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjPnec1E"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8285033858E;
	Fri,  7 Nov 2025 18:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762540953; cv=none; b=HcWN/4HubQlhATw5vyGu6TWH8CgapHw70z0btYN27MQBjWR3oWIssOvUydN9S71cqIsuaq5PRcAIb5xfbdG+i8lk6v+LBZcKKgDFBz6V1c2yXEJX+byzrT0ebb87ud6B1nwsDv/QycJ4YzMXpD/x1HtexgfStopXU0C/N65ROxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762540953; c=relaxed/simple;
	bh=8e9r71ILje2MFL5Wix8wnYUE8Y/g4bcrvhisRr1k58Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WKONj54p1ywqSpYef7weVq7uj0xWidtZeoH2QNXlh+4yi76tWBas6DWK8ptkE/dMRkqZcWtUlyZ6m1fOop2f/om7j6yEtvGZizVff2UNM4/cxc0QH2//CFvEmMGLe9JKSatldEHtU+UfZwF9MAjU/LfBtfXGVPr3QMEHLiooh5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjPnec1E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 291CFC4CEF7;
	Fri,  7 Nov 2025 18:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762540953;
	bh=8e9r71ILje2MFL5Wix8wnYUE8Y/g4bcrvhisRr1k58Y=;
	h=From:To:Cc:Subject:Date:From;
	b=YjPnec1EEFQx5cL7vkV+lOAv8ziaJZKIfwp8zjmRmeC2NGgX8PDarSvDT+rnKTQsN
	 hta+v1910ti3fxwuV8xSvABh/Y2Jhixjhp99TgWyW7cQ1FNC07MjFrlZstpFoIImG5
	 YxfrtJ/RXXf2t85qgeVq6vcMQwHgDTUSPYGqOY5KEhv9mmO87sG5Vr3HT3GCz3+wtf
	 +bLqdkjvJjQyc7x45tbUoLxlSKY/6zDvoYQQKK3hAMbOlDWJjtZCcDpxbPz0noINCh
	 A79Cno0JWseiLA7KiYxzY2CWyBS6JkvdeHOXnHOJ65bRYoSb/HKIq46p8IeYjMaby2
	 GT96+SJmLPaKw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Takashi Iwai <tiwai@suse.de>,
 LKML <linux-kernel@vger.kernel.org>, Zhang Qilong <zhangqilong3@huawei.com>,
 Frank Li <Frank.Li@nxp.com>, Dhruva Gole <d-gole@ti.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v1 0/3] PM: runtime: Wrapper macros for usage counter guards
Date: Fri, 07 Nov 2025 19:35:09 +0100
Message-ID: <13883374.uLZWGnKmhe@rafael.j.wysocki>
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

The runtime PM usage counter guards introduced recently:

https://lore.kernel.org/linux-pm/6196611.lOV4Wx5bFT@rafael.j.wysocki/

and then fixed:

https://lore.kernel.org/linux-pm/5943878.DvuYhMxLoT@rafael.j.wysocki/

should generally work, but using them feels sort of arcane and cryptic
even though the underlying concept is relatively straightforward.

For this reason, runtime PM wrapper macros around ACQUIRE() and
ACQUIRE_ERR() involving the new guards are introduced in this series
(patch [1/3]) and then used in the code already using the guards (patches
[2/3] and [3/3]) to make it look more straightforward.

Thanks!




