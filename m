Return-Path: <linux-pci+bounces-25460-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C20A7F03D
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 00:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B79083AC72F
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 22:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425631F4199;
	Mon,  7 Apr 2025 22:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXxN0y2B"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1343618E743;
	Mon,  7 Apr 2025 22:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744064537; cv=none; b=N0EoEEvLfX6m0c6zKrlAFwwB6oHegnrQXUAaYZ1zMJb/9ptA1lUkaD7GUHIGOtyO8vui3DB5hJd2o1BXP1Mgs6Jxx+ZbOJw3SuQbdmhlUTyKPJEMhusBEDp0wrmvYgu2e0jIgfpEgkXD8rExi12vFaXPTWHg8WsDFzhYfZtXZsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744064537; c=relaxed/simple;
	bh=Qbr5F8RaLt4BsGe+R2HawfHCgZ7qW7CDs6Mf/m1Ffaw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qG0K8OO14HllUeem4FS+OcgkGDZOkAu170RlRUDstTsHhSKIx5zlWy5tkEXlsyX0q9enUjwIttKgPx09xJRDCNqmSy8de2xlot/ozOOk156rxQXRzZogh80pHMcso+Uk4tTbkpN0iHaPoKnGjUwH99l8dp4dbOkYIm0n8FN0dSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXxN0y2B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B60BC4CEDD;
	Mon,  7 Apr 2025 22:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744064536;
	bh=Qbr5F8RaLt4BsGe+R2HawfHCgZ7qW7CDs6Mf/m1Ffaw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=kXxN0y2BhzjZaHDvsi/NwsAmlYkOIDnfhmqeYyDtXHq0fucuJoVLN6Hi6iNkkrwHQ
	 1ILN7T2kdZInG9IjsK0hDUQsKlRNejU5PaUSUm9amZdp/S5h6klGsojJxD3bd60IN3
	 K5Ow9/AGEMstbMs2UHUF9ZMwj/w9Ikqpm63/9biC2U9TQ4PGrYIuPUwHpyFt7xaYKn
	 jaRzRICdLww3xlHfsJJw9IOt/nE8kjfMHtOBWgOd5wgc01HI5lh8uxoAQ1Dy54/CKZ
	 XuvaRRsWE7rh/irz9+0nhTkzBgo+Js78Dg0upa8WUUajzXyx7ggfW/MoJNIqeT+akV
	 b+Ey9bHwhaIwQ==
Date: Mon, 7 Apr 2025 17:22:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Michael Chan <mchan@broadcom.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: PCI VPD checksum ambiguity
Message-ID: <20250407222214.GA204460@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALs4sv3awP3oA3-mvjSUmHCk=KZjF5F75SnnaE79ZUGqDC=orw@mail.gmail.com>

On Wed, Apr 02, 2025 at 04:03:42PM +0530, Pavan Chebbi wrote:
> > > >
> > > > Any idea how devices in the field populate their VPD?
> 
> I took a quick look at our manufacturing tool, and it does look like
> the computation simply starts at address 0.
> 
> > > > Can you share any VPD dumps from devices that include an RV keyword
> > > > item?
> 
> A couple of devices I could find: hope it helps..
> 000100: 822f0042 726f6164 636f6d20 4e657458 7472656d 65204769 67616269 74204574
> 000120: 6865726e 65742043 6f6e7472 6f6c6c65 7200904b 00504e08 42434d39 35373230
> 000140: 45430931 30363637 392d3135 534e0a30 31323334 35363738 394d4e04 31346534
> 000160: 52561d1d 00000000 00000000 00000000 000000
> 
> 000100: 822f0042 726f6164 636f6d20 4e657458 7472656d 65204769 67616269 74204574
> 000120: 6865726e 65742043 6f6e7472 6f6c6c65 7200904b 00504e08 42434d39 35373139
> 000140: 45430931 30363637 392d3135 534e0a30 31323334 35363738 394d4e04 31346534
> 000160: 52561d15 00000000 00000000 00000000 00000000 00000000 00000000 00000000

Thanks a lot for this!

I put each of these in a file ("vpd.txt") and computed the checksum
with this:

  addr=0; sum=0; xxd -r -c 32 vpd.txt | xxd -p -g1 -c1 x.bin | while read X; do sum=$(($sum + "0x$X")); printf "addr 0x%04x: 0x%02x sum 0x%02x\n" $addr "0x$X" $(($sum % 256)); addr=$(($addr + 1)); done

In both cases the sum came out to 0x00 as it should.

So it looks like Broadcom interpreted the spec the same way Linux
pci_vpd_check_csum() does: the checksum includes all bytes from the
beginning of VPD up to and including the RV checksum byte, not just
the VPD-R list.

These dumps start at 0x100 (not 0), which seems a little weird.  But
"xxd -r" assumes zeros for the 0-0xff range, so it doesn't affect the
checksum.

I manually decoded the first one, which looked like this.  Nothing
surprising here:

  00000100: 822f 0042 726f 6164 636f 6d20 4e65 7458  ./.Broadcom NetX
  00000110: 7472 656d 6520 4769 6761 6269 7420 4574  treme Gigabit Et
  00000120: 6865 726e 6574 2043 6f6e 7472 6f6c 6c65  hernet Controlle
  00000130: 7200                                     r.

    82 == large resource tag 0x02 (Identifier String), data item length 0x2f
      "Broadcom NetXtreme Gigabit Ethernet Controller"

  00000132:      904b 0050 4e08 4243 4d39 3537 3230    .K.PN.BCM95720
  00000140: 4543 0931 3036 3637 392d 3135 534e 0a30  EC.106679-15SN.0
  00000150: 3132 3334 3536 3738 394d 4e04 3134 6534  123456789MN.14e4
  00000160: 5256 1d1d 0000 0000 0000 0000 0000 0000  RV..............
  00000170: 0000 00                                  ...

    90 == large resource tag 1_0000b (0x10, VPD-R), data item length 0x4b
    50 4e PN keyword, length 0x08: 4243 4d39 3537 3230:       "BCM95720"
    45 43 EC keyword, length 0x09: 31 3036 3637 392d 3135:    "106679-15"
    53 4e SN keyword, length 0x0a: 30 3132 3334 3536 3738 39: "0123456789"
    4d 4e MN keyword, length 0x04: 3134 6534:                 "14e4"
    52 56 RV keyword, length 0x1d: 1d
      (last byte of VPD-R is 0x162 + 0x1d == 0x17f)

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/vpd.c?id=v6.14#n520

