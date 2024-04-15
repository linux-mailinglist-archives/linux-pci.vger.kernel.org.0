Return-Path: <linux-pci+bounces-6256-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3E98A57C0
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 18:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 649D01F22A18
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 16:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9AC80BFF;
	Mon, 15 Apr 2024 16:29:39 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C8C2E40F;
	Mon, 15 Apr 2024 16:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713198579; cv=none; b=iSRm1VXpzowxJQJN3GkOY031QnQ06IWRnw8Wo/Zq/ANzDErdo3rj6wdJhY8c8JxeuQ6RrNAiaEPxbWN8eXIj9vVDbOvoce6NXpO+F1YOFOvsug8uLsnGAx2towXDMtUQP+a16Dt7yl+d+81Z3Z1txx6up7gGy8pvsdWp0NaGomY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713198579; c=relaxed/simple;
	bh=0d4mUTktj6a/nMXxUroqj2dPrXs/QRAOPXoexv5bCYk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QtFC4FNogk1OgmkZWj7TyOTMHsuo7AzMrHCVlIKZwgo7wh6uKzHmZzunF1YICyNvbGT7Lxy60UfgBWEo2fDyZyw4Ip+dNKjoVEzZDk6CUS/918p0Nl/Qpk/I4Tgyx/kY8eQLZdz9e9OwDCtBu1TzpyW8nztHie3rl7/UrCv4bTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id ECEA4A060C;
	Mon, 15 Apr 2024 16:20:02 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf12.hostedemail.com (Postfix) with ESMTPA id 25AC719;
	Mon, 15 Apr 2024 16:20:00 +0000 (UTC)
Message-ID: <03f357e6c16d13924b705513446e4eac37e38a99.camel@perches.com>
Subject: Re: [PATCH] PCI/AER: Print error message as per the TODO
From: Joe Perches <joe@perches.com>
To: Abhinav Jain <jain.abhinav177@gmail.com>, mahesh@linux.ibm.com, 
	oohall@gmail.com, bhelgaas@google.com, linuxppc-dev@lists.ozlabs.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com
Date: Mon, 15 Apr 2024 09:19:59 -0700
In-Reply-To: <20240415161055.8316-1-jain.abhinav177@gmail.com>
References: <20240415161055.8316-1-jain.abhinav177@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 25AC719
X-Stat-Signature: 77e1p4uka3bqt7e7ii1uor3ehdgef6hp
X-Rspamd-Server: rspamout05
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+mInIM+0CNX9KiE6s0STSXDV9arJlA+oo=
X-HE-Tag: 1713198000-709223
X-HE-Meta: U2FsdGVkX18fRK6pvB4sqjrD+Hoi7VifTu0b/kmK1fLRq+6B3315wuHjJaVxwsG3ryHMye27wG92hwxaE84zKznFV1zdpaNmTJ2xB8DEbZshNqhjvOu22m9mjY8RFR1Hka4ZE9kfGrep6llNfaDZ9WmRCRfYMRWqkhV3SuYQsPxaG+BJVarT1Q4Du+CM6d08EhHIODww0VeyqdEAvD4KUqWuL47rgeAgHsM15SJy/OWPpDQS+3/c45vgN9oMm8wPJ87a9a82vl2KAfLVrGD/kgMIuNwILrYGNmJ6/e7U5TwlI43oa3xcOPtGoMKVLmhX

On Mon, 2024-04-15 at 16:10 +0000, Abhinav Jain wrote:
> Add a pr_err() to print the add device error in find_device_iter()
[]
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
[]
> @@ -885,7 +885,8 @@ static int find_device_iter(struct pci_dev *dev, void=
 *data)
>  		/* List this device */
>  		if (add_error_device(e_info, dev)) {
>  			/* We cannot handle more... Stop iteration */
> -			/* TODO: Should print error message here? */
> +			pr_err("find_device_iter: Cannot handle more devices.
> +					Stopping iteration");

You are adding unnecessary whitespace after the period.
String concatenation keeps _all_ the whitespace.

The format is fine on a single line too.

Something like:

		pr_notice("%s: Cannot handle more devices - iteration stopped\n",
			  __func__);


