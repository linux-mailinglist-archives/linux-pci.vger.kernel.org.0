Return-Path: <linux-pci+bounces-25520-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3690A81939
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 01:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C9478A01C0
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 23:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CFC2566E4;
	Tue,  8 Apr 2025 23:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ew0ddOoZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB7D2566E3
	for <linux-pci@vger.kernel.org>; Tue,  8 Apr 2025 23:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744154329; cv=none; b=cd/Jo9gBZrVmWrTHM1A+dMGpiWgr4Qt5u1o9QxJdzOaDYGQVkwfOweET/ZLnXMqmtW/kLC0uPGM1a0twdGDP2erKlBw0LS6C1pY1j+OSiZVpFErtsS/Yur8d97t99ZWw4ecAcw3a8hmakXR0cVQ4xidkLX1EOSFWv7bLoRb9Ixc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744154329; c=relaxed/simple;
	bh=fnhn40nrzk5xfb8sWmFEl51rUqFCihOJRKjcab4ZksU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cgTEBSHzIEYjnuQon/BOBN7ATZFRVDSHDPL0uAHKspGl2tNm1faXcqABxRHIUnlvNSwW1vCMVESsnGsL0jzqi3DsE1WJQidFTm6gG+L1VaiskFiC80WQueqqwJVDlp7lzldcCNEaTK55iehAvxU7JM79wFUFNxUCVFo3PrRf4O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ew0ddOoZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3DBC4CEE5;
	Tue,  8 Apr 2025 23:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744154328;
	bh=fnhn40nrzk5xfb8sWmFEl51rUqFCihOJRKjcab4ZksU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ew0ddOoZACyY90BZ5V9pY/jecWYQG/+Vb6Z47vpNhVL0w0tZGrYOTBRP+b4iiUkmV
	 0TwE6zSESkDoLBuwuPCcIR4QvkV99nd06tVPT+KziAu9/lpxfRmpQIgLoHcy2ea9P3
	 Ov0NdsMnumicjCWhfFiwz8GzMaD45wkTxjxm004WueyaOzeBWVVBxWZQLN3wMvw8bI
	 fjVAOsgbPjjbnU4uUiSUonNjniMCdIqeJyOlkJkmdB9xKnzsbk4HknRjeONBunJrBO
	 M+Vr9O9WQZRKKxG99SrYFfPuLecM3u0uHI1KhwYWzV324i1dDr+tKXgeOAfyk0cpcn
	 sw7IREOQTvAUw==
Date: Tue, 8 Apr 2025 18:18:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sergey Dolgov <sergey.v.dolgov@gmail.com>
Cc: linux-pci@vger.kernel.org,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Artem S. Tashkinov" <aros@gmx.com>
Subject: Re: [Bug 219984] New: [BISECTED] High power usage since 'PCI/ASPM:
 Correct LTR_L1.2_THRESHOLD computation'
Message-ID: <20250408231846.GA253000@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAONYan8=q3b+hUJRRsa_cB20m3SFP6vR0SP4HyYhTk4sNJfAgw@mail.gmail.com>

On Tue, Apr 08, 2025 at 09:02:46PM +0100, Sergey Dolgov wrote:
> Dear Bjorn,
> 
> here are both dmesg from the kernels with your info patch.

Thanks again!  Here's the difference:

  - pre  7afeb84d14ea
  + post 7afeb84d14ea

   pci 0000:02:00.0: parent CMRT 0x28 child CMRT 0x00
   pci 0000:02:00.0: parent T_POWER_ON 0x2c usec (val 0x16 scale 0)
   pci 0000:02:00.0: child  T_POWER_ON 0x0a usec (val 0x5 scale 0)
   pci 0000:02:00.0: t_common_mode 0x28 t_power_on 0x2c l1_2_threshold 0x5a
  -pci 0000:02:00.0: encoded LTR_L1.2_THRESHOLD value 0x02 scale 3
  +pci 0000:02:00.0: encoded LTR_L1.2_THRESHOLD value 0x58 scale 2

We computed LTR_L1.2_THRESHOLD == 0x5a == 90 usec == 90000 nsec.

Prior to 7afeb84d14ea, we computed *scale = 3, *value = (90000 >> 15)
== 0x2.  But per PCIe r6.0, sec 6.18, this is a latency value of only
0x2 * 32768 == 65536 ns, which is less than the 90000 ns we requested.

After 7afeb84d14ea, we computed *scale = 2, *value =
roundup(threshold_ns, 1024) / 1024 == 0x58, which is a latency value
of 90112 ns, which is almost exactly what we requested.

In essence, before 7afeb84d14ea we tell the Root Port that it can
enter L1.2 and get back to L0 in 65536 ns or less, and after
7afeb84d14ea, we tell it that it may take up to 90112 ns.

It's possible that the calculation of LTR_L1.2_THRESHOLD itself in
aspm_calc_l12_info() is too conservative, and we don't actually need
90 usec, but I think the encoding done by 7afeb84d14ea itself is more
correct.  I don't have any information about how to improve 90 usec
estimate.  (If you happen to have Windows on that box, it would be
really interesting to see how it sets LTR_L1.2_THRESHOLD.)

If the device has sent LTR messages indicating a latency requirement
between 65536 ns and 90112 ns, the pre-7afeb84d14ea kernel would allow
L1.2 while post 7afeb84d14ea would not.  I don't think we can actually
see the LTR messages sent by the device, but my guess is they must be
in that range.  I don't know if that's enough to account for the major
difference in power consumption you're seeing.  

The AX200 at 6f:00.0 is in exactly the same situation as the
Thunderbolt bridge at 02:00.0 (LTR_L1.2_THRESHOLD 90 usec, RP set to
65536 ns before 7afeb84d14ea and 90112 ns after).

For the NVMe devices at 6d:00.0 and 6e:00.0, LTR_L1.2_THRESHOLD is
3206 usec (!), and we set the RP to 3145728 ns (slightly too small)
before, 3211264 ns after.

For the RTS525A at 70:00.0, LTR_L1.2_THRESHOLD is 126 usec, and we set
the RP to 98304 ns before, 126976 ns after.

Sorry, no real answers here yet, still puzzled.

Bjorn

