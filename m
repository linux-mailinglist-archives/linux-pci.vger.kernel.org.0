Return-Path: <linux-pci+bounces-15019-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF719AB25C
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 17:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D47D328503B
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 15:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DB219DF52;
	Tue, 22 Oct 2024 15:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNaDCW2m"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EF459B71
	for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 15:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729611884; cv=none; b=WxuwUV5BaZAYHbh0MN3CK5m49EAzVo08B8U1lEGAVUsiY/1XJk9x7AtOMdCS9wXoNYOMNbQZ7dkFg/ak88kzoSSdeyKzgjUx6IUNz+qLzLsLpw5DU/W4jsdW+MieweEBkoDLQoauZAhROQdtX4bYaIyV2k1O+LbJhW14asyBGLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729611884; c=relaxed/simple;
	bh=uR9ad+DtyZCkBBKOJPg35sMwgIb8DXPirdF1vH3y4ko=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uyXVLuCTx/0adW25l0X1UAWfzBcjXfEQhjyGlqx1olnDF05x+S9OWY3M/H6iDsICzprmmCG/pkackHaLaalo0kVeiCWjHSlX3KUzYjRzx7PgeIOqEvEu6vA4fMJPM0tbtKF/ckfYvvZkDyxGPcXCsWmBGRshiOrtGUF2ROlUv9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rNaDCW2m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480A0C4CEC7;
	Tue, 22 Oct 2024 15:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729611884;
	bh=uR9ad+DtyZCkBBKOJPg35sMwgIb8DXPirdF1vH3y4ko=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rNaDCW2mgj9bQRw8GklVzA/hTOYVzE58yFY+++Z/yYOOXVRC7e+PHRscf3NT1djXZ
	 ZRCUiP5AqPqFr+1/jGilNfB9xgiDu/51PJJ+J7zh6UOIlG4BJderGW5xiIBbTRuE5k
	 +sNg3J4XiG908V3vtpEEUFkE4upc78c6PibTDzPw0qLKMsTEHNmA9GpED/l5n6O1Oe
	 Wq01dDvigUAWt/24ncj1K4JC5QDqsHQtfWNHPv8Dz0AxxmS99ELUNQGccE18BCFJhr
	 BimTXrK6pawoqA8tTSDr7ISFBmjUoPGCTiwoyLE9cEs9komrrv4fT0aqWT+KTN/owO
	 KMt+lcYHMrIYA==
Date: Tue, 22 Oct 2024 10:44:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] PCI: optimize proc sequential file read
Message-ID: <20241022154443.GA880326@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018054728.116519-1-kanie@linux.alibaba.com>

[+cc Greg]

On Fri, Oct 18, 2024 at 01:47:28PM +0800, Guixin Liu wrote:
> PCI driver will traverse pci device list in pci_seq_start in every
> sequential file reading, use xarry to store all pci devices to
> accelerate finding the start.

>  /* iterator */
>  static void *pci_seq_start(struct seq_file *m, loff_t *pos)
>  {
> -	struct pci_dev *dev = NULL;
> +	struct pci_dev *dev;
>  	loff_t n = *pos;
>  
> -	for_each_pci_dev(dev) {
> -		if (!n--)
> -			break;
> -	}

Maybe another approach would be to use pci_get_device() directly
instead of for_each_pci_dev().

pci_get_device() takes a "from" starting point, so instead of keeping
track of the index "n", you could keep track of the current pci_dev.

