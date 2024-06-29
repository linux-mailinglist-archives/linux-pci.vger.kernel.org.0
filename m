Return-Path: <linux-pci+bounces-9454-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7975791CF0A
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 22:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 900311C20BE6
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 20:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1D112FB3F;
	Sat, 29 Jun 2024 20:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPZkwzXa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251772032B;
	Sat, 29 Jun 2024 20:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719693983; cv=none; b=A0nSXV0HNRuwHPsd6cGU/4hQNU1+myy/yrzMd3hVOZebyKF+NmjJYkCAOQdStAe5XuWXtyDwLAiPqy+yUEC/hd/4vBPxlZfYIJqhu0Jx/MkWR5gOq22SLAB/UPR781U9KWeSGwse4TVgPvzotDrkGYnbEr8EAAJ/DDIJUkCKlfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719693983; c=relaxed/simple;
	bh=hJ+yKYj4tmGvQUn1X5A2eW4wf5CnTjwpKQOkSiDBwhY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NT5MHtrTwLYFHmZNvtLKA3OnEaj1mWnJclQcBp0oWtCs97w8glV201ZM7YZtR6ONL94yJmiCe/negEX90tFF6HHYEv2jAH6/pzSYkFrBRKtyTbGzG8toKEDmPqbOSa1ot/uI6mGd9YSm7Bs+Up7JcuDeSrzluXSKH+3V0zZ7KSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPZkwzXa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C3BC2BBFC;
	Sat, 29 Jun 2024 20:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719693982;
	bh=hJ+yKYj4tmGvQUn1X5A2eW4wf5CnTjwpKQOkSiDBwhY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=TPZkwzXaYAl0EwSMDcPpDrKzisCGW46aF/NWy266pTIeD1xlTTkv6tAmV33b4wu0V
	 GPoyly2gHfMzL0Et7rMvZMHxTZtHhD++Yv7+1EX7dIiwR7WY0mO6MyoS6mTfkKKrev
	 Rt27xaFkGnCC/Byoi2DJ+TK5RKUDxB5aSJVVkeKF3PXvwxhVok+YIyrUncZQ6XsEdA
	 al/5X2IK2tiAWiBE1CocbbbaK81zgpEBIUAJCjzgZdRfvJbqTS5kNvxfPrcrSRO/Ok
	 FkcWQoDjrQ2KxwWSsRk3+an0vKpwD5CfMY3KOqxjB3I8e0TSR4gIOyElDnCzhnOLkW
	 7X35Tng1hDhYA==
Date: Sat, 29 Jun 2024 15:46:20 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	jingoohan1@gmail.com, mani@kernel.org,
	marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v9 0/5] PCI: rcar-gen4: Add R-Car V4H support
Message-ID: <20240629204620.GA1482128@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240629200650.GD2249818@rocinante>

On Sun, Jun 30, 2024 at 05:06:50AM +0900, Krzysztof Wilczyński wrote:
> Hello,
> 
> [...]
> > About the firmware binary, please refer to the following patch
> > descirption:
> >   PCI: rcar-gen4: Add support for r8a779g0
> 
> This quite a sad state of affairs, and usually would I oppose including
> drivers that rely on closed proprietary firmware blobs to operate.  That
> said, Renesas is not really setting any precedent here, so we will live
> with this.

What are the existing similar situations?  Just for curiosity, I'd
like to know what precedent we are relying on here.

