Return-Path: <linux-pci+bounces-29943-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F70BADD4DF
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 18:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43C3D3B1E68
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 16:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078AA21B9FC;
	Tue, 17 Jun 2025 16:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmrWDS2E"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F782F2371
	for <linux-pci@vger.kernel.org>; Tue, 17 Jun 2025 16:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176269; cv=none; b=QgXptYn3QsyWuSrqr3hvroCtz93ZHmD3McRbSEyG34z5ggBO6WnSPfD007RgHgSpoEpuL5VhrRvTt2V3RBvAxMnhtlIUC4ZtGgy7ZXwD/e8wqKPWDC9PSFkrjXaHKjKYwMAZ653JFrB5+tFTiYGsKXbIwPgKH5iM7wH/ACvdz/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176269; c=relaxed/simple;
	bh=8YBIT2UqU8LPcThvbvre37klhGGW81dJYs8ccD5IqP0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Ax/dhJFmX65sI4UJMuFlqz+080Dd1/n5YlilB8qHWogeqcZ/i3NOa4GeFXePBWmYOsJDi+dK8ngKF6T5qO9FyvoavkSDh3MkJ22Fqv+Lis9Rxt0NzxWSJCX0AVpFJ43AQ9kF/FoMGcJmBkZfn6nltYrYC9prvoC3vRQf1FbI76M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmrWDS2E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76879C4CEE3;
	Tue, 17 Jun 2025 16:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750176269;
	bh=8YBIT2UqU8LPcThvbvre37klhGGW81dJYs8ccD5IqP0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=DmrWDS2EzzpfRslSKWemJM5CyywgOJNezz/xB2mrEyLPDch4S91ph8IwvxZiiuhFG
	 QVUsZWGBuUKbz+rJw8CRAU1uscwqS2Dgc10xRQupsTOFjTQ2azn4QUewNGCLBXHq7H
	 NCPcIR+lD1snPs0/PtyR6Hoe27nH+ILMGTAnLorYbG9ZEDOAFMBc9KDcXuNr1L/b7J
	 BSzto1ENqPdqFcZHftC4ZZJQ/fNaUikFmcoM1co8Y4vaq8DMmrLDHdyrnSnleBqDg5
	 itWYxx/4glAgD7TDUNdOV8a0RugLoT62H5XOvKzj548UZ2ocnJ4rhDctBJH1IAP64z
	 Pr1GJMWRIRkwA==
Date: Tue, 17 Jun 2025 11:04:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Timothy Pearson <tpearson@raptorengineering.com>
Cc: linux-pci <linux-pci@vger.kernel.org>, mahesh <mahesh@linux.ibm.com>,
	Oliver <oohall@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v10] PCI: Add pcie_link_is_active() function
Message-ID: <20250617160428.GA1137986@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <988492931.1308196.1750174918075.JavaMail.zimbra@raptorengineeringinc.com>

On Tue, Jun 17, 2025 at 10:41:58AM -0500, Timothy Pearson wrote:
> Add pcie_link_is_active() function to check if the physical PCIe link is
> active, replacing duplicate code in multiple locations.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> Signed-off-by: Shawn Anastasio <sanastasio@raptorengineering.com>
> Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>

Whoa, whoa, slow down.  This doesn't address all the things I
mentioned (EXPORT_SYMBOL, for example).  But four postings in 90
minutes is way too much.  There's no hurry, everybody has other things
to do, and we can only assimilate a reposting every few days.  That
way others have a chance to respond with additional feedback, and you
can address it all at once.

When you do post an updated version, consider adding a brief changelog
(e.g., what changed between v8 and v9) below the "---" line so we know
what to look for.

> +EXPORT_SYMBOL(pcie_link_is_active);

