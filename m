Return-Path: <linux-pci+bounces-25634-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C59A84973
	for <lists+linux-pci@lfdr.de>; Thu, 10 Apr 2025 18:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA96217C31B
	for <lists+linux-pci@lfdr.de>; Thu, 10 Apr 2025 16:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7362C1EDA12;
	Thu, 10 Apr 2025 16:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axey5ek3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458421D5CE8;
	Thu, 10 Apr 2025 16:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744302119; cv=none; b=Wx2WN2VN4g/eyvWoqFDouDlvZERlWsm7SbN4w6cWMWZmTEVUjmJ2j4NycXTblRxXLOCpIGV4PwVIcCbjavVgjCMaoSxIuSh46a800foDg8lTCgPUyuHTi7TJsz1m6XJrZPRR90Tl0sVqxkqVdpzP1RlVBR4IKukRDTYwddEZm+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744302119; c=relaxed/simple;
	bh=xE5n6B+MNRMKtpObrYG84EMMt9mli5Pp21a1M9jmvY8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BXZia38I6JsvfJ2sy8WsoLfY0rYbEsfUISaAzSK4cOSsJ7pj0rAKVu5pfLQcP0cpJzjMvyZKWBezDYLDXF7XhJjCD572EjhsPpIIi1qR6mvkzmzs/pub76Ag9jxptCP+65tHt4gDrOZw1jSGgg9UPdGoflQKD0xTVjbHBUxy4So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axey5ek3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78860C4CEDD;
	Thu, 10 Apr 2025 16:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744302118;
	bh=xE5n6B+MNRMKtpObrYG84EMMt9mli5Pp21a1M9jmvY8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=axey5ek338ZhZvIs+yMX5kJJ3aG2naqpdsmvWwGPjBGv+2dxL32lP+Vxln2MY+k3x
	 MV4GVEcky/bUOisI26LOF/2Z/m1S3jF8g9b9MPn84WLS1zL+pdrtYZ5rTAQfKG9Vtn
	 GqcA+Vh07HiUFEm+rXfyIMwmaUN9LKvcY1RhZswB/xfyJVWi0TgDN0Ydh0WhRWA24p
	 4yUDO4dLScMrqsNpmS97PrnbyyqtdRYkD/x8dzkEiZAxyYC7aodlsk9NEIPBV6xHGA
	 Mac99+oKtMf8TjP3Wjca6IE2hR74/rWcbHuf1Tr8ryKRm/nFzKE7kvZy0j0jfrug0s
	 Y/Q2MzxToNdYQ==
Date: Thu, 10 Apr 2025 11:21:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Michael Chan <mchan@broadcom.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Leon Romanovsky <leon@kernel.org>
Cc: netdev@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: PCI VPD checksum ambiguity
Message-ID: <20250410162157.GA328195@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401205544.GA1620308@bhelgaas>

On Tue, Apr 01, 2025 at 03:55:44PM -0500, Bjorn Helgaas wrote:
> Hi,
> 
> The PCIe spec is ambiguous about how the VPD checksum should be
> computed, and resolving this ambiguity might break drivers.

Any more input on this?  It would be great to have more information
about how vendors compute the checksum on their devices.

There is a proposed PCIe spec change to resolve the ambiguity, and the
intent is to make a change that reflects what vendors have actually
implemented.

The only concrete data I've seen so far is from Pavan at Broadcom
(thank you very much for that), where the checksum starts at the
beginning of VPD, not at the beginning of VPD-R.

If you can collect VPD data from devices, you can use something like
this to compute the checksum from the beginning of VPD:

  addr=0; sum=0; xxd -r -c 32 vpd.txt | xxd -p -g1 -c1 x.bin | while read X; do sum=$(($sum + "0x$X")); printf "addr 0x%04x: 0x%02x sum 0x%02x\n" $addr "0x$X" $(($sum % 256)); addr=$(($addr + 1)); done

(You still have to figure out manually where the RV item is so you
don't include the writable VPD-W part.)

> PCIe r6.0 sec 6.27 says only the VPD-R list should be included in the
> checksum:
> 
>   One VPD-R (10h) tag is used as a header for the read-only keywords.
>   The VPD-R list (including tag and length) must checksum to zero.
> 
> But sec 6.27.2.2 says "all bytes in VPD ... up to the checksum byte":
> 
>   RV   The first byte of this item is a checksum byte. The checksum is
>        correct if the sum of all bytes in VPD (from VPD address 0 up
>        to and including this byte) is zero.
> 
> These are obviously different unless VPD-R happens to be the first
> item in VPD.  But sec 6.27 and 6.27.2.1 suggest that the Identifier
> String item should be the first item, preceding the VPD-R list:
> 
>   The first VPD tag is the Identifier String (02h) and provides the
>   product name of the device. [6.27]
> 
>   Large resource type Identifier String (02h)
> 
>     This tag is the first item in the VPD storage component. It
>     contains the name of the add-in card in alphanumeric characters.
>     [6.27.2.1, Table 6-23]
> 
> I think pci_vpd_check_csum() follows sec 6.27.2.2: it sums all the
> bytes in the buffer up to and including the checksum byte of the RV
> keyword.  The range starts at 0, not at the beginning of the VPD-R
> read-only list, so it likely includes the Identifier String.
> 
> As far as I can tell, only the broadcom/tg3 and chelsio/cxgb4/t4
> drivers use pci_vpd_check_csum().  Of course, other drivers might
> compute the checksum themselves.
> 
> Any thoughts on how this spec ambiguity should be resolved?
> 
> Any idea how devices in the field populate their VPD?
> 
> Can you share any VPD dumps from devices that include an RV keyword
> item?
> 
> Bjorn

