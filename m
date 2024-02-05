Return-Path: <linux-pci+bounces-3127-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B7084AA58
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 00:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 492121F28E04
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 23:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495F2481AA;
	Mon,  5 Feb 2024 23:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bag10mqg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1475748799;
	Mon,  5 Feb 2024 23:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707174754; cv=none; b=O1xZNtu6qplEVR2DVnVbwfSCCzL21sRKelNZrxcRGF/uO8hDEOURk8DQqnXSZEeS73vBCsbra7tD3sogrNnN5TzqvTsbpLclBSjC4tmH2lMDwwLekCVB+NKn6An5e53KKS8efdt08SdNpnBgsqEKfy/nWbl03QJS1NruhuRYApI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707174754; c=relaxed/simple;
	bh=OqDQTVaTAC7P8L+gci1WqEUJDMaXntqkOBZoBUDrdLI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YBa9fGQ3Luxw19kfD3Ltf20xJJsHVVdT8b8muE9W8RwKSmNK39sW5DzXb1Y2kH3Az+eQEJtVexWDR2IHrOqqFyLoFI+dqt4jryY6PAsUPszbfR6qd8djYVhcOyeBm9ZxIAUB+4pPgcN9F9ou+E6yQyiHJ9a9GQOLX1GlKGxoTV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bag10mqg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C61C433C7;
	Mon,  5 Feb 2024 23:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707174753;
	bh=OqDQTVaTAC7P8L+gci1WqEUJDMaXntqkOBZoBUDrdLI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Bag10mqgJTqDDZ2nf/rhFKcRX46JasJnfMnqmkVPvxLV0Z9VtKH/VnN5cSPWYAUH1
	 vS9wtjSuSeG54Ovqhes4aNpS+JMvTymxRgkpM15XDK8WL8gNq69HF4DltQUt39KNHl
	 JmXk2S1NAMN5SDpCacdseKINzcA9VVg15H0Vkejx9uz5FcDhBqBN77cFIN5ucOyBFR
	 QGiB0godWa6MmqczYSOEzz/43UqpTUoTuCF/IX9UkSHRfP94WiQMGmhbfKMKeQmHYP
	 vZFqE4lHtwzWpRD1z1/w/GppnhyKJIz3o7b2WRFCrQctk1h1l6482/+QoFoHfiaGLj
	 mHo2ki2u8ezcg==
Date: Mon, 5 Feb 2024 17:12:31 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-acpi@vger.kernel.org, chao.p.peng@linux.intel.com,
	erwin.tsaur@intel.com, feiting.wanyan@intel.com,
	qingshun.wang@intel.com, "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Adam Preble <adam.c.preble@intel.com>, Li Yang <leoyang.li@nxp.com>,
	Lukas Wunner <lukas@wunner.de>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	Robert Richter <rrichter@amd.com>, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, linux-edac@vger.kernel.org
Subject: Re: [PATCH v2 1/4] PCI/AER: Store more information in aer_err_info
Message-ID: <20240205231231.GA830643@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125062802.50819-2-qingshun.wang@linux.intel.com>

On Thu, Jan 25, 2024 at 02:27:59PM +0800, Wang, Qingshun wrote:
> When Advisory Non-Fatal errors are raised, both correctable and
> uncorrectable error statuses will be set. The current kernel code cannot
> store both statuses at the same time, thus failing to handle ANFE properly.
> In addition, to avoid clearing UEs that are not ANFE by accident, UE
> severity and Device Status also need to be recorded: any fatal UE cannot
> be ANFE, and if Fatal/Non-Fatal Error Detected is set in Device Status, do
> not take any assumption and let UE handler to clear UE status.
> 
> Store status and mask of both correctable and uncorrectable errors in
> aer_err_info. The severity of UEs and the values of the Device Status
> register are also recorded, which will be used to determine UEs that should
> be handled by the ANFE handler. Refactor the rest of the code to use
> cor/uncor_status and cor/uncor_mask fields instead of status and mask
> fields.

There's a lot going on in this patch.  Could it possibly be split up a
bit, e.g., first tease apart aer_err_info.status/.mask into
.cor_status/mask and .uncor_status/mask, then add .uncor_severity,
then add the device_status bit separately?  If it could be split up, I
think the ANFE case would be easier to see.

Thanks a lot for working on this area!

Bjorn

