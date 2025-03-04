Return-Path: <linux-pci+bounces-22899-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D06BEA4EC8C
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 19:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE6F1188FC96
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 18:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692CB209F57;
	Tue,  4 Mar 2025 18:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcGp/ifr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4578B1EE7AD
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 18:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741114752; cv=none; b=sLTd8HIUHzWSG163tf8YwyHn5sqdVm3L7xrHROgu43C257baYNB4I+5YwHU/JioZEJLEfoHNUhCoTh0rbF0yulBzjv+Vh66SyFpD4WRmI7208keMBUZIrvKVfk2dSsbF68rO9R1MKt9ye2YjcoTZcnXOx+UYP0ICVAqkpDGcR7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741114752; c=relaxed/simple;
	bh=wUgcZ+CSDwZdsbW/1vulox4KPFlqgQLM/5tbf4czpak=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ST5bEN7QXUBCw+nc7tm68q51Zyx9bLljq+tsfvqQepu7zXPlzVRGY/qWuyZ2amq664c9PEqQ47Q4m0OgwWYIeq4y2rygP1XgsKX7GDMGvwpAmhprmLczmTeugBpeQFOdHtleri35RubULQ/ul9R05QckzTaWzwdA0BhJdj/Xslg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcGp/ifr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB101C4CEE5;
	Tue,  4 Mar 2025 18:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741114752;
	bh=wUgcZ+CSDwZdsbW/1vulox4KPFlqgQLM/5tbf4czpak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VcGp/ifrYBIHmxRQyo4jIJqe8kNJM9OH9gQ9XVfg8W6vYnEpHVRxWB+71dl+od6Tb
	 S29KgZhqb2REs28UTnUgffbSKa85X1mtX0YMHIC+igHA1CEo4O8xbqWF7L7GyrBgxd
	 ALIm+eWDCvwxuNHXyWR+KAxDX82kZlxQWX99/xar3ADLYNJKlCnr6PsP0ew7VzJ9Uc
	 81MOPOFU0xD0k0cZGYw7O+iWik8xN/LvzQVLYZEpimgxgmKBqm6iqf7x4wgwJUz1A8
	 Q5PZ3vsZho0Hfkb0QZRsMCnUeyy8e52DHXfEPr8d2UByTlbskbynrc8H9ValDCjZXd
	 s5febDEECtWag==
Date: Tue, 4 Mar 2025 12:59:10 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jon Pan-Doh <pandoh@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	linux-pci@vger.kernel.org,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 2/8] PCI/AER: Use the same log level for all messages
Message-ID: <20250304185910.GA251792@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214023543.992372-3-pandoh@google.com>

On Thu, Feb 13, 2025 at 06:35:37PM -0800, Jon Pan-Doh wrote:
> From: Karolina Stolarek <karolina.stolarek@oracle.com>
> 
> When reporting an AER error, we check its type multiple times
> to determine the log level for each message. Do this check only
> in the top-level function and propagate the result down the call
> chain. Make aer_print_port_info output to match the level of the
> reported error.

Can you mention the top-level function name?  I guess it's
aer_isr_one_error()?  Nit: add "()" after function names.

It *might* be possible to split this into two patches:

  - Check level once and propagate down.  This would include the
    changes to aer_isr_one_error(), aer_process_err_devices(),
    aer_print_error(), __aer_print_error(), and probably
    dpc_process_error().  It looks like this wouldn't change the
    levels of any messages.

  - Change log levels.  It looks like the main place is
    pci_print_aer(), which previously always used pci_err() and would
    now use either KERN_WARNING or KERN_ERR.

pcie_print_tlp_log() also always uses pci_err().  Maybe that's only
used for Uncorrectable errors?  I'm not sure what the rules are for
the Header Log.

Bjorn

