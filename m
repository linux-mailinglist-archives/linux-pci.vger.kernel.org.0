Return-Path: <linux-pci+bounces-24873-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA8BA73A40
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 18:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 235E718889D8
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 17:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75341ACEDE;
	Thu, 27 Mar 2025 17:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LcAL2u8O"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A994E2114;
	Thu, 27 Mar 2025 17:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743095769; cv=none; b=berhiizhWu0BavRaYPlDQf7WENpGXMnyLB5/7qZyJbtvv1l5rJ8Zo8zRHvq15q+qROnRTasnuchqMmGM5BtceEe1icAwKqJXVg/v2QQ2M6+SByqEGL9gSi84VMNcUOFTM0re4PZFiCVkHPSC9Y59UidaC3+kxqWJHNcIWAdaa9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743095769; c=relaxed/simple;
	bh=D/GArJMFUaztVB7e1aYL7GgN5RaYoFOJr/wtN/htcFU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fhOaWWG4z60bHkscTJuAKy1O85kJ185V9WN+WEG9RIcnGHhdy/6EEF2IzZT8cU6Xprsy8Nju/XPYoYs+t2p+faqQ4Jg/e9JFf2CI9HX6g6eDLFsohTdvfG9Z7vkcyjU2JFDv13gDnLEdg98yDfk614Am6oO3LjHGQf7NqClmgiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LcAL2u8O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4B2C4CEDD;
	Thu, 27 Mar 2025 17:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743095769;
	bh=D/GArJMFUaztVB7e1aYL7GgN5RaYoFOJr/wtN/htcFU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=LcAL2u8OcbdL3w024jCClgDMsKfwVMrbmy03bvHKX3uAXr1ryFi2vpkaAFuZvlENp
	 X2suD5mO0nTXKWOHOu48bi34mcST9ys3ju3V5k6l9z57mFVv7yd0xfpMkmUosZ9BRx
	 CsEGYxl1MBDFiiaqWttP2Fb6HCC5AVxZVA6v98iuu4vFRCrKpBarOQzKE/BYtDIrbl
	 D2lZTK64aBXOC0rDYahbKgn9qPLvPl8dK+o/WqGjaBc0JmtxwDWzVWu1t8I5wJ21F5
	 apr+ZxY5CZXhvPmEU5xX/E1/NE8rgbyzr/AQTPjb0CeFG6b9K6zZDhMpVy4pU+cskM
	 vVvbkh1bXp7lw==
Date: Thu, 27 Mar 2025 12:16:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Terry Bowman <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
	ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
	rrichter@amd.com, nathan.fontenot@amd.com,
	Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
	ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
Subject: Re: [PATCH v8 00/16] Enable CXL PCIe port protocol error handling
 and logging
Message-ID: <20250327171607.GA1434835@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327014717.2988633-1-terry.bowman@amd.com>

On Wed, Mar 26, 2025 at 08:47:01PM -0500, Terry Bowman wrote:
> ...

> Terry Bowman (16):
>   PCI/CXL: Introduce PCIe helper function pcie_is_cxl()

Something like "Add pcie_is_cxl()" is probably enough.

>   PCI/AER: Modify AER driver logging to report CXL or PCIe bus error
>     type

No need to repeat "AER" in the subject.  Could start with "Report" or
"Distinguish" since "modify AER driver logging" is kind of low-value
information.

>   CXL/AER: Introduce Kfifo for forwarding CXL errors

>   cxl/aer: AER service driver forwards CXL error to CXL driver
>   PCI/AER: CXL driver dequeues CXL error forwarded from AER service
>     driver

Both should say what the patch changes.  "AER service driver forwards"
and "CXL driver dequeues" could be descriptions of existing behavior
or something else.  Starting with a verb will help make this clearer.

Maybe don't need to repeat "AER" in "CXL/AER: AER ..."

>   CXL/PCI: Introduce CXL uncorrectable protocol error 'recovery'
>   cxl/pci: Move existing CXL RAS initialization to CXL's cxl_port driver

Drop "existing" and at least one "CXL" to increase information density
in subject.

>   cxl/pci: Map CXL Endpoint Port and CXL Switch Port RAS registers
>   cxl/pci: Update RAS handler interfaces to also support CXL PCIe Ports
>   cxl/pci: Add log message if RAS registers are not mapped
>   cxl/pci: Unifi CXL trace logging for CXL Endpoints and CXL Ports

s/Unifi/Unify/

>   cxl/pci: Assign CXL Port protocol error handlers
>   cxl/pci: Assign CXL Endpoint protocol error handlers
>   cxl/pci: Remove unnecessary CXL Endpoint handling helper functions
>   CXL/PCI: Enable CXL protocol errors during CXL Port probe
>   CXL/PCI: Disable CXL protocol errors during CXL Port cleanup

Don't repost just for any of this, but it looks like there are some
kernel test robot warnings that need to be addressed.  When you do,
tidy up these subject lines so they are capitalized consistently.

