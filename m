Return-Path: <linux-pci+bounces-2127-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D09782C694
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 22:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBE3D281B6B
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 21:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E0515E9B;
	Fri, 12 Jan 2024 21:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1mDpHkA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C324168B9
	for <linux-pci@vger.kernel.org>; Fri, 12 Jan 2024 21:20:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C41C433C7;
	Fri, 12 Jan 2024 21:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705094400;
	bh=FmizbOvzfwzg9i+CxRAHwxkelMW9Pbx0+VF4aNLhL+4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=F1mDpHkAC2kB85+1sN0QEmuGU7dFq+7ZdaZOWpP4bczrA+M6YjBYjezIWmLZ+q5Jo
	 ET7f/xc+FH+PV3Bav75KisoQ7LAeN0MFq9ClruFuPY7XWcl+XCVt/tKL7jPNE2mr5l
	 hGeFIkgyYPjUglNjigkRD/14x0EbCZbRKiZZSnqV1Z/voakOyu8XyWuPU2v2Yw/60Q
	 lHIMdHk4jx2z+5LX1rw6xEpxly9tcXBAXBAA8YUFvmMe0+4OYtwnntSAKXGj11ckao
	 I9+s3nwnuVRKPD/OyfodKafpXxd3nAEgGKFpMpDpQVFfqgcu/t0HeIYzONV1Eryig0
	 LYcykKV9gTyCA==
Date: Fri, 12 Jan 2024 15:19:59 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: linux-pci@vger.kernel.org, Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH pciutils 2/2] pciutils: Add decode support for IDE
 Extended Capability
Message-ID: <20240112211959.GA2282480@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231230124239.310927-3-aik@amd.com>

On Sat, Dec 30, 2023 at 11:42:39PM +1100, Alexey Kardashevskiy wrote:
> IDE (Integrity & Data Encryption) Extended Capability defined in [1]
> implements control of the PCI link encryption.
> 
> The example output is:
> 
> Capabilities: [830 v1] IDE

Possibly expand "IDE"?  Many other Capabilities are spelled out:

  Capabilities: [c0] Express Downstream Port (Slot+), MSI 00
  Capabilities: [100] Device Serial Number 5f-2f-9d-40-30-f1-0c-00
  Capabilities: [200] Advanced Error Reporting
  Capabilities: [300] Virtual Channel
  Capabilities: [400] Power Budgeting <?>
  Capabilities: [500] Vendor Specific Information: ID=1234 Rev=1 Len=0d8 <?>
  Capabilities: [700] Secondary PCI Express

