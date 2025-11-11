Return-Path: <linux-pci+bounces-40803-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C79C49D4F
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 01:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 66C5E4E16BA
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 00:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E9834D3A4;
	Tue, 11 Nov 2025 00:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="biO4cc1/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CDB34D39F
	for <linux-pci@vger.kernel.org>; Tue, 11 Nov 2025 00:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762819825; cv=none; b=F5e49NzlU7/nQtxHjtk74cgUrVFl3TWRwL4yzdn6nVaPoWMGV7F3L3og5XHm3SbvTAG+oRuxuumD/YKGTT2sv7B+iVZ5K95jjYOo8+r9EqywH4Rc/0l5VjL0az5T3v0dY7i+Qz9QRAwW6ydaIAjtEmx/H6zaDJJWd+vlPsLkTN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762819825; c=relaxed/simple;
	bh=rRvG0iQXm6FYRmMhVfK5QouUbTbjM7n4L41pEsa65Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nS6z9IFy1XzHmwmASxNn4jGUQwhZqXbmH8/zHGiJzAliT+RglsrRq34VsjwBnwopy9gWUvRQQMesvQzMPA5XAmtrbmkRG38GKITqiQDjzvqZUN5dLByRLTgZLcttl7IbqixzgwbcUYzlbCpD1itCDrkry14FDAOGnEN+b6wYXVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=biO4cc1/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D1DBC19421;
	Tue, 11 Nov 2025 00:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762819825;
	bh=rRvG0iQXm6FYRmMhVfK5QouUbTbjM7n4L41pEsa65Eo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=biO4cc1/MbfqNlQGa4A6IaA2sFCQrFyC7J7GvuBS9o3H8EqbPbod+MxtrQZ7okCI8
	 5IskJebU5at4RgApKNCL6eEmrSSgIy+pdd9B8iVJ3C/O0ntVacitnscw0X40RksuVw
	 OugTmqBZViVJZmPBv7/uUyXY9Q12098nLjim0I5uSE1fjlrLBrHf4y9ojb+HkpIGSh
	 aSjDXVt9qPBUT8IaLUzOf1xL2Y6dhoVrYJhtCs7Z2JTYoUBuIVmPnzLAI3eq6hcP+C
	 DOzD/9sDnBcuqEsLaPlt6m1XGbJAe8PnmqL3Z9pu4o0zsnz/ZMs+5j2zCIiec2VbP/
	 HWGyz43wQS4XA==
Date: Mon, 10 Nov 2025 18:10:23 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v3] PCI/PTM: Do not enable PTM solely based on the
 capability existense
Message-ID: <20251111001023.GA2143615@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031060959.GY2912318@black.igk.intel.com>

On Fri, Oct 31, 2025 at 07:09:59AM +0100, Mika Westerberg wrote:
> On Thu, Oct 30, 2025 at 03:59:37PM -0500, Bjorn Helgaas wrote:
> > On Thu, Oct 30, 2025 at 02:46:05PM +0100, Mika Westerberg wrote:
> > > It is not advisable to enable PTM solely based on the fact that the
> > > capability exists. Instead there are separate bits in the capability
> > > register that need to be set for the feature to be enabled for a given
> > > component (this is suggestion from Intel PCIe folks, and also shown in
> > > PCIe r7.0 sec 6.21.1 figure 6-21):
> > 
> > Can we start with a minimal statement of what's wrong?  Is the problem
> > that 01:00.0 sent a PTM Request Message that 00:07.0 detected as an
> > ACS violation?
> 
> The problem is that once the PCIe Switch is hotplugged we get tons of AER
> errors like below (here upstream port is 2b:00.0, in the previous example
> it was 01:00.0):
> 
> [  156.337979] pci 0000:2b:00.0: PTM enabled, 4ns granularity
> [  156.350822] pcieport 0000:00:07.1: AER: Multiple Uncorrectable (Non-Fatal) error message received from 0000:00:07.1
> [  156.361417] pcieport 0000:00:07.1: PCIe Bus Error: severity=Uncorrectable (Non-Fatal), type=Transaction Layer, (Receiver ID)
> [  156.372656] pcieport 0000:00:07.1:   device [8086:e44f] error status/mask=00200000/00000000
> [  156.381041] pcieport 0000:00:07.1:    [21] ACSViol                (First)
> [  156.387842] pcieport 0000:00:07.1: AER:   TLP Header: 0x34000000 0x00000052 0x00000000 0x00000000

If I read this right:

  0x34000000 is 0011 0100 0...0
    Fmt  001    4 DW header, no data (PCIe r7.0, sec 2.2.1.1)
    Type 10100  Message Request, Local - Terminate at Receiver (2.2.1.1, 2.2.8)

  0x00000052 is 0...0 0101 0010
    0x0000     Requester ID
    0101 0010  PTM Request (2.2.8.10)

The fact that the Request ID is 0x0000 and the error is an ACS
Violation looks like the implementation note in sec 6.12.1.1:

  Functions are permitted to transmit Upstream Messages before they
  have been assigned a Bus Number. Such messages will have a Requester
  ID with a Bus Number of 00h. If the Downstream Port has ACS Source
  Validation enabled, these Messages (see Table F-1, Section 2.2.8.2,
  and Section 6.22.1) will likely be detected as an ACS Violation
  error.

So I assume 2b:00.0 sent a PTM Request with Requester ID of 0, and
00:07.1 logged the ACS violation.  It's odd that 2b:00.0 would send a
PTM request if it doesn't advertise the PTM Requester role.  Also odd
that it doesn't seem to know its Bus Number.  It's supposed to capture
that from every config write request (sec 2.2.9.1), and I would think
it should have seen several by now including the one that enable PTM.

But I think your fix is right even if we don't understand exactly how
we got there.  Are you planning an update, or ...?  Just wanted to
make sure we're not waiting for each other.

Bjorn

