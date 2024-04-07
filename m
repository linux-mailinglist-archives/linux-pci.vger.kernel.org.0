Return-Path: <linux-pci+bounces-5846-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D91C89B4B4
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 01:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF6481C20A90
	for <lists+linux-pci@lfdr.de>; Sun,  7 Apr 2024 23:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CB643AAD;
	Sun,  7 Apr 2024 23:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIReazuM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FC547F48;
	Sun,  7 Apr 2024 23:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712533908; cv=none; b=IkiHc6xR3kHhwzB+fKtVPSSmLzUb3xJuxVEglYbTyNmOAZy1zJAnFdTq3ohJNlbOrmLL2Iqthk60sSOggyw7WHAFfUDItHyRZBkMZESMJnMqioH71QVBL3ORmO4jHxa56FaLIObYunccdCZffaW7wkgJib8P11SnR4LVhQVBDdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712533908; c=relaxed/simple;
	bh=c9AV06zEDRUY+STVK91qqsfok0ys+fFnMj1b/OQ26rM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQHWIfoTbt2Jt3XH2BqLy7SRv4SaxB3y7PhohP0L6laUGZGJlqyQAs+Reriawzg6Ux9MuX99Z4zhz2DtFOfLCdoIBQ8V6Mw4MjrtkbuP+PBRrSkZZSk7iLmWNc2UAnKuO4FuiTYDW7XYSMr2GycGLDJAuossvFT44a5hirrcOlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIReazuM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8822EC433C7;
	Sun,  7 Apr 2024 23:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712533907;
	bh=c9AV06zEDRUY+STVK91qqsfok0ys+fFnMj1b/OQ26rM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EIReazuMf6MdO3iR1+tKwywe+60c9OzkvrxOUMH6dPKrnbHe5g1lCdir4dO9DRjAE
	 nK3LX6TE1p5p9tUSPZ8Yb0BmO3q/fkmYw0B9N23mplDdLU8qYq/GTR/ncrNG2pM64e
	 pZWVH9DNCxJ0Sgz80B79fChTNAHE8PwtYNqzgBwWJzGmHJv8OMJ2QmHyJp/29IM8I6
	 rkiWfKFVjwMbtef5Is1CyBpyH+Uq8F+mkN+maRHScF8hPH9wD+b9FEyGwwHc+KWvHB
	 nPS+0EfWSGzhyBVD+ygmfO23/Zlfs4x1uVUf40iX0N8o4Y4smc0NuhMrwYw8QNvoHC
	 jmm/NXqGyrCxA==
Date: Sun, 7 Apr 2024 19:51:47 -0400
From: Sasha Levin <sashal@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Edmund Raile <edmund.raile@proton.me>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.6 52/75] PCI: Mark LSI FW643 to avoid bus reset
Message-ID: <ZhMxk4Sn4N0AAFSu@sashalap>
References: <20240329124330.3089520-52-sashal@kernel.org>
 <20240329151702.GA1643117@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240329151702.GA1643117@bhelgaas>

On Fri, Mar 29, 2024 at 10:17:02AM -0500, Bjorn Helgaas wrote:
>On Fri, Mar 29, 2024 at 08:42:33AM -0400, Sasha Levin wrote:
>> From: Edmund Raile <edmund.raile@proton.me>
>>
>> [ Upstream commit 29a43dc130ce65d365a8ea9e1cc4bc51005a353e ]
>>
>> Apparently the LSI / Agere FW643 can't recover after a Secondary Bus Reset
>> and requires a power-off or suspend/resume and rescan.
>>
>> VFIO resets a device before assigning it to a VM, and the FW643 doesn't
>> support any other reset methods, so this problem prevented assignment of
>> FW643 to VMs.
>>
>> Prevent use of Secondary Bus Reset for this device.
>>
>> With this change, the FW643 can be assigned to VMs with VFIO.  Note that it
>> will not be reset, resulting in leaking state between VMs and host.
>>
>> Link: https://lore.kernel.org/r/20240227131401.17913-1-edmund.raile@proton.me
>> Signed-off-by: Edmund Raile <edmund.raile@proton.me>
>> [bhelgaas: commit log, comment]
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>We're about to revert this upstream, so I wouldn't backport this to
>any stable trees:
>
>https://lore.kernel.org/r/20240328212302.1582483-1-helgaas@kernel.org

I'll drop it, thanks!

-- 
Thanks,
Sasha

