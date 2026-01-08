Return-Path: <linux-pci+bounces-44268-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AA4D01E34
	for <lists+linux-pci@lfdr.de>; Thu, 08 Jan 2026 10:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CADE30478D0
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jan 2026 09:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AFD409FB3;
	Thu,  8 Jan 2026 09:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X3y7hVJl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C1E409FBF;
	Thu,  8 Jan 2026 09:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767863469; cv=none; b=a975g5/RoF7Hf/xUIsPozYoJI9MR8ueWLEzXrSXRlnPR70/IzgbvK9GNkW1nxtzuJ/3kFRkW5Fa/rZuPKdG5bt3p3xsDU19g9malAgfqfuQtn7Og0OEoYeAIWcYGmO6sHum8IKRJq9nPe+gJytU77LX62umzbRmEhFTidQzkD0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767863469; c=relaxed/simple;
	bh=brQlqAxdFJ5PNSMKJaLHNe5XLsvQOGfR1Xqoi37Edzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+NHypBe6ZxgxTk8BnA3pUW9/d82gMHzDJOxz94TsoPquDGbGAZakIPNXKPkebb3J7pUSs7o2xsfvvsHUWLsZduK/9KzQmTpzbQhhGGi+i6/v8Co47GMB99Qfve+agmtSWShfZpLOmPfxhiMzlN1bWycVyPzAWH5EMqeekKPHrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X3y7hVJl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0EBC116C6;
	Thu,  8 Jan 2026 09:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767863465;
	bh=brQlqAxdFJ5PNSMKJaLHNe5XLsvQOGfR1Xqoi37Edzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X3y7hVJlHu0gq3HvGzBssXAqiCqlb74605jyeVO8oyECFZfwFIIIYfyKwnMmzNhCK
	 SNo/UM2rOO3QH1re2HqG/k7JOWym7sKcHZijYpevRw5XjQj/wsITRBHoay437R3Eja
	 wuNu08XO+TYea/sd3woNhx4hWuL8en5NCvjHgJyY=
Date: Thu, 8 Jan 2026 10:11:02 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Lukas Wunner <lukas@wunner.de>, Dave Jiang <dave.jiang@intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Feng Tang <feng.tang@linux.alibaba.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH v3] PCI/portdev: Disable AER for Titan Ridge 4C 2018
Message-ID: <2026010852-parabola-circulate-e4ec@gregkh>
References: <20260108081904.2881-1-atharvatiwarilinuxdev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108081904.2881-1-atharvatiwarilinuxdev@gmail.com>

On Thu, Jan 08, 2026 at 08:18:53AM +0000, Atharva Tiwari wrote:
> Changes since v1:
> 	Transferred log

This goes below the --- line please.

thanks,

greg k-h

