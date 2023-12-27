Return-Path: <linux-pci+bounces-1440-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C8F81EF1E
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 14:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12FF11C2195C
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 13:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59F144C83;
	Wed, 27 Dec 2023 13:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uizpsKnv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F91446B3;
	Wed, 27 Dec 2023 13:11:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8576C433C7;
	Wed, 27 Dec 2023 13:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703682713;
	bh=BQ+I77CwuE08Ql7Mc3SjL10xeGTHrjHTtpJSRVbFe4U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=uizpsKnve1YO07Fcubg9jv+P486oSPwJnY5wkW1UV20ysjluTSr0kkRqXSirVM1Pe
	 aPzR8O6qmpJtvFYkRna7JbeArbYaPR1as+aSf8EZmojxAkTQIEV3xiexi4QmL4gLjg
	 1gb8/dapdsfUtnDLSMVmVnnnH/D1qm6udjnPtR51ApqLYHuCq1FpuFKiJ1P/Xm3PE6
	 lIV30SKqnHjfOrpD6LO9Lu985CS7lMzSnb1VpWgyaV7glQJCK+8lL7cKe2/Dx8rQM6
	 X0bT72tTPU4CkrKmHpLX6K9ZNw9FUzxDlLBlzTA++Li/1J9QqoSXEKTgbx9nx5h7qO
	 AHMKSE9COJ6CQ==
Date: Wed, 27 Dec 2023 07:11:51 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ethan Zhao <haifeng.zhao@linux.intel.com>
Cc: bhelgaas@google.com, baolu.lu@linux.intel.com, dwmw2@infradead.org,
	will@kernel.org, robin.murphy@arm.com, lukas@wunner.de,
	linux-pci@vger.kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v8 4/5] iommu/vt-d: don't issue device-TLB invalidate
 request when device is disconnected
Message-ID: <20231227131151.GA1499234@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231227025923.536148-5-haifeng.zhao@linux.intel.com>

I suggest using "ATS Invalidate Request" in the subject as well.
Otherwise we have to figure out whether "device-TLB invalidate
request" is the same as "ATS Invalidate Request".

If they are the same, just use the same words.

On Tue, Dec 26, 2023 at 09:59:22PM -0500, Ethan Zhao wrote:
> Except those aggressive hotplug cases - surprise remove a hotplug device
> while its safe removal is requested and handled in process by:
> 
> 1. pull it out directly.
> 2. turn off its power.
> 3. bring the link down.
> 4. just died there that moment.
> 
> etc, in a word, 'gone' or 'disconnected'.
> 
> Mostly are regular normal safe removal and surprise removal unplug.
> these hot unplug handling process could be optimized for fix the ATS
> invalidation hang issue by calling pci_dev_is_disconnected() in function
> devtlb_invalidation_with_pasid() to check target device state to avoid
> sending meaningless ATS invalidation request to iommu when device is gone.
> (see IMPLEMENTATION NOTE in PCIe spec r6.1 section 10.3.1)

Suggest "ATS Invalidate Request", capitalized exactly that way so we
know it's a specific name of something defined in the PCIe spec.

> For safe removal, device wouldn't be removed untill the whole software
> handling process is done, it wouldn't trigger the hard lock up issue
> caused by too long ATS invalidation timeout wait. in safe removal path,

Ditto.

Capitalize "In the safe removal ..." since it starts a new sentence.

> device state isn't set to pci_channel_io_perm_failure in
> pciehp_unconfigure_device() by checking 'presence' parameter, calling
> pci_dev_is_disconnected() in devtlb_invalidation_with_pasid() will return
> false there, wouldn't break the function.
> 
> For surprise removal, device state is set to pci_channel_io_perm_failure in
> pciehp_unconfigure_device(), means device is already gone (disconnected)
> call pci_dev_is_disconnected() in devtlb_invalidation_with_pasid() will
> return true to break the function not to send ATS invalidation request to

Ditto.

> the disconnected device blindly, thus avoid the further long time waiting
> triggers the hard lockup.
> 
> safe removal & surprise removal
> 
> pciehp_ist()
>    pciehp_handle_presence_or_link_change()
>      pciehp_disable_slot()
>        remove_board()
>          pciehp_unconfigure_device(presence)

