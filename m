Return-Path: <linux-pci+bounces-35958-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC85DB53F37
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 01:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E0D53AEF85
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 23:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4C02F532A;
	Thu, 11 Sep 2025 23:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iV9GvsvY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E812F530A;
	Thu, 11 Sep 2025 23:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757634113; cv=none; b=EPWQ/1fdA+oiWZvdHktFhzrAUkzsHERPvlzUirlTa18vOlWV/Du0e1IdeVxgx36DSEuV8zRIQpGI3aFe93x6K2T1LrTOxEmx3sESlxvDbS0tu1eo9g1v98HF46kBBVWWVQ04rZG+Q0G9YW2D8H9GTqo6FaYngNIprDNx8/DsfJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757634113; c=relaxed/simple;
	bh=DQD93jM5hLlaAKaCjIrnWOXXTTrKJoX2wFhzmsThdaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hnMNHMd26/yw5Nnb5da11GAryfnqv1gl8nwQkKKPjUf+RgfG8TH6cYXXgc4TPr1xeoXFspgOP+cWw0IiWq4yMcITIYim9xHq1KktbPcp4GIn2m9X5AP8FAMpxbL8pevop+ZFy7HVc5XvjjkEV2XNAEin7WIUl5QdUL6DQvhPNhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iV9GvsvY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17220C4CEF0;
	Thu, 11 Sep 2025 23:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757634112;
	bh=DQD93jM5hLlaAKaCjIrnWOXXTTrKJoX2wFhzmsThdaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iV9GvsvYOgiktqrfpfVkGvm1Vxt267Fr6jnDO3liYSIjN187mdA56yiqXB8xYP9JN
	 CSJ4SXd00YvZ3TbH2Aij7xG6xFlaefX2TUHO8GQ3N3fs3J+sdhvm0+FTdGW/nE/uP2
	 7RGA/TIEuu6ehQh1EL8t9agDEyvSvQvOf8bZKL701zR6c9Lb7/aO+p1+DhiJOVKIt8
	 tmr8MuIACNe0dCjnMIm29YShTZ9VXjEp3bnvKzqWfvywtfMGmOJQUc5B/S7KYK2ykw
	 eNoeXYPwanry9hHff6nR+a/kXrvbQ34vdOFt3c3QjHcpf595+nyLzrBZ8GdyLI21g6
	 b5imPfFMNtivg==
Date: Thu, 11 Sep 2025 19:41:48 -0400
From: Keith Busch <kbusch@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Vernon Yang <vernon2gm@gmail.com>, mahesh@linux.ibm.com,
	bhelgaas@google.com, oohall@gmail.com,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Vernon Yang <yanglincheng@kylinos.cn>,
	Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>, linux-cxl@vger.kernel.org,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	Dongdong Liu <liudongdong3@huawei.com>
Subject: Re: [PATCH] PCI/AER: Fix NULL pointer access by aer_info
Message-ID: <aMNePLmIkz3LE6EP@kbusch-mbp>
References: <20250904182527.67371-1-vernon2gm@gmail.com>
 <20250911225457.GA1596803@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911225457.GA1596803@bhelgaas>

On Thu, Sep 11, 2025 at 05:54:57PM -0500, Bjorn Helgaas wrote:
> [+cc Terry, Robert, CXL list, Smita, Dongdong]
> 
> On Fri, Sep 05, 2025 at 02:25:27AM +0800, Vernon Yang wrote:
> > From: Vernon Yang <yanglincheng@kylinos.cn>
> > 
> > The kzalloc(GFP_KERNEL) may return NULL, so all accesses to
> > aer_info->xxx will result in kernel panic. Fix it.
> > 
> > Signed-off-by: Vernon Yang <yanglincheng@kylinos.cn>
> 
> Applied to pci/aer for v6.18, thanks, Vernon!
> 
> Not directly related to this patch, but I'm concerned about some users
> of dev->aer_cap.

pci_aer_init is called pretty early during boot. If we can't malloc a
few hundred bytes at that point, the aer_cap users will be the least of
your concerns. :)

