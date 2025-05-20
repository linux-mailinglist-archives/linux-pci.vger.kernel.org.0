Return-Path: <linux-pci+bounces-28138-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5440ABE400
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 21:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63B3E4C5C43
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 19:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F16248F75;
	Tue, 20 May 2025 19:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJeCd7ed"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE611157487;
	Tue, 20 May 2025 19:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747770523; cv=none; b=MBzkwFcCvODdaAFRdh6Lv73KTVfXZKJnRnubXfA7IZdk9jjE6DdRDCLDHz4zFmrFlGX0I+L1AHzOu6+34fxYIgL2/YFqjXY65xVbZtgrbPv4VUlhdzH/2FDmzfAPumwsIxmZn5rr4zXyl2bPorks7+6Ap42i8gQ82q3FGEyIt1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747770523; c=relaxed/simple;
	bh=rJ1NiSRfc8gpNdAqLlhzaGL9WlXqzxBGZtEhkpBNqWo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Mi7ajJjz4Y2reS3R/wb7+Pan5d3QGixWmAmRJE7VM8QM1cCI9VYvzBtAdV7uobYqMGknA5GYYBVoEqRD/GLFTdgRU/N8o+see/Dxb0Xzd0gxeEKI50rbNFehPf7E2/z+pyUwhBpr7AngnGudeDkO/Q+OHX0cE0RU/tKqD05rXz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJeCd7ed; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F9BC4CEEF;
	Tue, 20 May 2025 19:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747770523;
	bh=rJ1NiSRfc8gpNdAqLlhzaGL9WlXqzxBGZtEhkpBNqWo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=vJeCd7ed0I5OQT/nS2fBITuRrAGtfXaxPS/EEjWf5+++YkUUyHEUnd5QyhRwccQoJ
	 cHSsMu18hMq3i+PlKGWx4XKZo4KUcxqztv1/L+w7bEPHrGFpVeCJjS8xESkhBVH2w3
	 PlZs6mxDe8tRcyDXDdCdaz9kJeHftHaUQh7O7m72pGJuJJxJ9BPssncTR8B26gTDZ8
	 JTt0/aQPbhIa8mCfxxsjwK+OICMFJONwprmU/lYq4bhtpUXJzAxBq/EAuQUlLULnOT
	 QhARHJa7o73VRZeaNEalCseBqxtE8T8I8chDLtShaCgkJPNlrhhncTIxrT0eI/Q+en
	 Qm/orCRlfQpHQ==
Date: Tue, 20 May 2025 14:48:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Jon Pan-Doh <pandoh@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sargun Dhillon <sargun@meta.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Keith Busch <kbusch@kernel.org>, Robert Richter <rrichter@amd.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v6 15/16] PCI/AER: Add ratelimits to PCI AER Documentation
Message-ID: <20250520194841.GA1322094@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75a3749b-36d9-467c-80a7-7e4a42e2f9b1@linux.intel.com>

On Mon, May 19, 2025 at 10:01:09PM -0700, Sathyanarayanan Kuppuswamy wrote:
> 
> On 5/19/25 2:35 PM, Bjorn Helgaas wrote:
> > From: Jon Pan-Doh <pandoh@google.com>
> > 
> > Add ratelimits section for rationale and defaults.

> > +AER Ratelimits
> > +--------------
> > +
> > +Since error messages can be generated for each transaction, we may see
> > +large volumes of errors reported. To prevent spammy devices from flooding
> > +the console/stalling execution, messages are throttled by device and error
> > +type (correctable vs. uncorrectable).
> 
> Can we list exceptions like DPC and FATAL errors (if added) ?

Like this?

  +... messages are throttled by device and error
  +type (correctable vs. non-fatal uncorrectable).  Fatal errors, including
  +DPC errors, are not ratelimited.

DPC is currently only triggered for fatal errors.

