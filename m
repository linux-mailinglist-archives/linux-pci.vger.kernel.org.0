Return-Path: <linux-pci+bounces-29968-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2377ADDBE2
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 20:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82A5D4A1583
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 18:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A252E8DF8;
	Tue, 17 Jun 2025 18:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="euA4OHN6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF402E54A8
	for <linux-pci@vger.kernel.org>; Tue, 17 Jun 2025 18:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750186780; cv=none; b=T+w8/6ESDKrXtowQ1WWtZNfETiG62HX4hT836l07x+Lde144Fu2gWfnxR3ZH2MJcRFqLsjKUfmHEngNSFA0Eyoz4WK6vzlXATr2ojIso7D1VAZG08a+xY5uMp8El3qxc2Xq8XRWfNUEP/MnOstwmW6dPN0iKU5EVnMCcVnVFzHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750186780; c=relaxed/simple;
	bh=DrjDUxk1I0pEkzX5HcfjVvEoGhAUe5U8k5gYodt7V7M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gB98AUnrXkf3U1GYtiqUJbuX0dciMc1H4WuyUHIsfHzsrSb/FP6sSwMnRt7IIQ5pple/ZKFJy0k5tcAiciewmck0HFKL0w9PgqdkMVpefKQGnTdOy859KMz5K91/dyL3aeacEzuPCXnlkjFZY+Bw1r5B2aQya3KQnaEGovGz9V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=euA4OHN6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98693C4CEE3;
	Tue, 17 Jun 2025 18:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750186779;
	bh=DrjDUxk1I0pEkzX5HcfjVvEoGhAUe5U8k5gYodt7V7M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=euA4OHN61spdhSXxQDhd4n2dyEQlu/2GbfciRytCX+fLJOM/V+O6wppLIu48IK/WS
	 rW5HjASlnOG6cl9eLN1tVG+YZ0gGtHzbb6vK8MFBUyphCQiAy7elfc1hhRvQ/ejR7X
	 wxUtC4OtIfJItTQWvbP3yT2wGRfx+j+migAs+gxwWJ0vBo4F3IowoSkgBDygAAKIRQ
	 QHaMd4KTB0fSPTohaikEYvUuZ8SCxtxW2ggz1W9ENzzkPafgl9udBy6dUUtzSNz677
	 hjY3rsLk0dnAZgNgJpImcBdWgOpcOnOnFN6zXuBWFl15Cs+FYhlqYNuIWea0jd6z8X
	 VqIJlThnq4RGA==
Date: Tue, 17 Jun 2025 13:59:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Timothy Pearson <tpearson@raptorengineering.com>
Cc: linux-pci <linux-pci@vger.kernel.org>, mahesh <mahesh@linux.ibm.com>,
	Oliver <oohall@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v10] PCI: Add pcie_link_is_active() function
Message-ID: <20250617185938.GA1144445@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2085066023.1309071.1750176650554.JavaMail.zimbra@raptorengineeringinc.com>

On Tue, Jun 17, 2025 at 11:10:50AM -0500, Timothy Pearson wrote:
> ----- Original Message -----
> > From: "Bjorn Helgaas" <helgaas@kernel.org>
> > To: "Timothy Pearson" <tpearson@raptorengineering.com>
> > Cc: "linux-pci" <linux-pci@vger.kernel.org>, "mahesh" <mahesh@linux.ibm.com>, "Oliver" <oohall@gmail.com>, "Madhavan
> > Srinivasan" <maddy@linux.ibm.com>, "Michael Ellerman" <mpe@ellerman.id.au>, "Lukas Wunner" <lukas@wunner.de>
> > Sent: Tuesday, June 17, 2025 11:04:28 AM
> > Subject: Re: [PATCH v10] PCI: Add pcie_link_is_active() function
> 
> > On Tue, Jun 17, 2025 at 10:41:58AM -0500, Timothy Pearson wrote:
> >> Add pcie_link_is_active() function to check if the physical PCIe link is
> >> active, replacing duplicate code in multiple locations.

> Will do in the future.  There is some urgency on this overall
> patchset as we have had hotplug support broken for many years now,
> and it's causing continued problems on customer deployed machines.
> While we can continue to point customers at the patchset and have
> them compile their own kernels, patience from our customer side is
> wearing a bit thin for that.  I will continue to try to push this
> forward (along with the associated ppc patch set) at a more
> reasonable pace.

Apparently this got pulled out of a series where the urgency might
have been obvious.  As a standalone patch, AFAICT it's a cleanup that
doesn't actually fix any problems.

Bjorn

