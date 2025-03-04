Return-Path: <linux-pci+bounces-22873-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30256A4E6CA
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 17:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDE7D19C7C8D
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 16:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2084259C86;
	Tue,  4 Mar 2025 16:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7RDrHec"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9AD25524C
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 16:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105216; cv=none; b=OoEI5M5C6fy+pxwN7yc9rqUHZkU7bPYPW7Rc6UIRmQqAHfxEyujDPEYkqS7FrPmqfZzYySGWoyZVhmKVOwfsPlfsJYEDEnuAv04TYM4u2vfAK2nqoWMzI6YlRaxzFMmhT7wahM1gqN6Ti9/M9pkMOKEOiiAu/9KVNrogXYZyHWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105216; c=relaxed/simple;
	bh=l0INVYe89U1Jq/3pQ28WNljfKLbMDC9V378xs4iHKNA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=G71zDAoJnG7pd9V0NBUazQnUp7ALkR3YJoYKd4FhRcJYTDLsLsQDfZecpA1QA3DTtUursHInWQsBgshEyqpBn/4/Sorb5Z0rdKYi2E6mfrEp5x9XJ+QATW9515AocleelW1Nl3gXM6uF3Xtev9n4pymJgqcxh5LICmUffsMtIkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7RDrHec; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C71C4CEE5;
	Tue,  4 Mar 2025 16:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741105216;
	bh=l0INVYe89U1Jq/3pQ28WNljfKLbMDC9V378xs4iHKNA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=k7RDrHecCL//Uv1dyrgCdDKniIf+LftFdRUsiWSFnKIYW1kdm7Stpf0QcXAdcvpde
	 9skuv+jI4GWedU9PX4QF2r4Mnf6yIqTr6Feqck5U//HW4wfFaqfO3BlxyrxTthubPR
	 tVYi39CwbVJfZ1q9WtcNkvmg0Tit/JK76mgBS2hzOPftH2XrNJuhruAlAzjuRVmfcg
	 bJInN7qP6Ypp/VF8GqYiyvtlvCKFTp5ffdYxxMH/GTKQ/eufT7+87RtVNARZlvId6h
	 +2vYUQ/tNfAw0bmugasJvb2PY+2QSnrHCuIfVutbjIbVdQxmKeX3VYPj7e8UOYk2oL
	 8eWBCRrw0mqaA==
Date: Tue, 4 Mar 2025 10:20:14 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: Fix typos
Message-ID: <20250304162014.GA227956@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250304085722.GC2615015@rocinante>

On Tue, Mar 04, 2025 at 05:57:22PM +0900, Krzysztof Wilczyński wrote:
> Hello,
> 
> > Fix typos and whitespace errors.
> 
> Oh nice!  Thank you for doing this!
> 
> While we are at this...  I wonder if we could also see about some things
> that I often see in the code, too.  For example:
> 
>   - "pci" or "pcie" instead of "PCI" and "PCIe"
>   - "PCIE", PCI-E" or "PCI-Express" over "PCIe" and "PCI Express", etc.
>   - "aer" over "AER"
>   - "translateable" over "translatable"
>   - "SPCIFIC" over "SPECIFIC"
>   - "OVERIDE" over "OVERRIDE"
>   - "Root port" or "Root complex" over "Root Port", etc.
>   - "dbi" over "DBI"
>   - "requestor" vs "requester"
>   - "fom" over "from"
>   - "reserv" over "reserved"
> 
> Would be nice to get these also fixed up nicely since we are already
> cleaning things up.

Locally fixed these:

  translateable -> translatable
  SPCIFIC -> SPECIFIC
  OVERIDE -> OVERRIDE
  fom -> from

