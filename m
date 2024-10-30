Return-Path: <linux-pci+bounces-15661-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DBA9B6FA8
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 23:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB1DA284A16
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 22:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F381DD9A8;
	Wed, 30 Oct 2024 22:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pymgKQqx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C039E1DC1A2
	for <linux-pci@vger.kernel.org>; Wed, 30 Oct 2024 22:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730326060; cv=none; b=TYgvc4Vss0QUz4wrIt9wWAYBI7a9AReUfb5uWiUZxU4FfEjajCVY/szwOf42nAONc09gmEEIhhV1g93W9H1wBKJpZVAHyHH3UwwjHNXvmHU22BKepZl6BJRuqQETUe+XGLv0T+D94WPMD/PY9ZPzeOxuu5uUlUPutWQD2eHjbKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730326060; c=relaxed/simple;
	bh=FGBXaMTs0zoZtuIJw76pQkmdmDElPzZuxay8K6IRs+M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=iqRbLvLZzVteVHqIddt54FGSnTTIPHoGpgmzcnPUhVRz1FYZnUdLPGLHTfsUrumi7YpyhHtcZGROvGhjZ+uoiUlLE5YWpmG7tZL1rhFRRfnmLR1Ydaof7E8bUK1RG2h59mt2AtY8UkvVXXo7yxQis2S/z+g9NK8tV7+CbkZci3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pymgKQqx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2195DC4CECE;
	Wed, 30 Oct 2024 22:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730326060;
	bh=FGBXaMTs0zoZtuIJw76pQkmdmDElPzZuxay8K6IRs+M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=pymgKQqxDWszTJEoGeU8SOxQXzSUDVj057M2/sGjtLFYJttHMz/9aSEyG9uEWshEx
	 BZOsy13EfwLb3MxEWqHyDkKiERyJ7dN/vrGPYzUfkAIISMXHt65w6YgmNg3PWBRi3M
	 jo4aN5OxjQ9jf+Nqo3Dd6a3LL+gTrg4tYNFL/yNQjWtny7MhIoBc11YHSs4a8nXt0i
	 Ya2zIbvL8QOMwLzkZrrxkXkBLOLjS/gs0Ps8vu7HAzSG5YOAMfF5E11fIMtqnQGoDq
	 ugDndL4kZm7pvqCaoQAiBV9DY3wxrlMa/cHBqAqpxeNXoqMo5nlRXkwyB/BaYRXNlx
	 gwGxXiMQUL2yA==
Date: Wed, 30 Oct 2024 17:07:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] PCI/P2PDMA: Don't enforce ACS check for functions
 of same device
Message-ID: <20241030220738.GA1221922@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e146e2f-5d7c-4f28-b801-360795b4cae7@deltatee.com>

On Wed, Oct 30, 2024 at 03:20:02PM -0600, Logan Gunthorpe wrote:
> On 2024-10-30 12:46, Bjorn Helgaas wrote:
> > On Fri, Oct 25, 2024 at 06:57:37AM +0000, Kasireddy, Vivek wrote:
> > In the PCIe world, I don't think a TLP can "loop back" to another
> > function on the same device.
> 
> I'm not sure if the spec says anything that specifically denies this.

I'm not a hardware guy and I don't know if there's a direct statement
about it, but if a Downstream Port supports ACS, it must support ACS
P2P Request Redirect (PCIe r6.0, sec 6.12.1.1), which specifically
applies to peer-to-peer TLPs.

If peer-to-peer TLPs appear on the link, the Downstream Port will see
them and act on them, e.g., either route them upstream (if P2P Request
Redirect is enabled) or back downstream.  I don't think the VF could
act on them directly via a loopback path because that would lead to
duplicate writes and duplicate Completions for reads.

> But it seems to me that it would be possible for a multifunction device
> to handle a transfer to a neighbouring function internally and not
> actually involve the PCIe fabric. This seems like something we'd want to
> support if and when such a device were to be created.

If peer-to-peer transactions are handled internally, an SR-IOV device
other than an RCiEP is required to support ACS with P2P Egress Control
(sec 7.7.11) and P2P Request Redirect (sec 7.7.11.2).

Bjorn

