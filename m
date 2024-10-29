Return-Path: <linux-pci+bounces-15534-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5BD9B4CF8
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 16:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 973EFB234F3
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 15:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B36192B90;
	Tue, 29 Oct 2024 15:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtfCNJeu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B022818E379
	for <linux-pci@vger.kernel.org>; Tue, 29 Oct 2024 15:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730214372; cv=none; b=eUSd36Y2yacHh8oHjYgjq4X8lhLPNMbu/qLpSUAQZPf/X7PfaK4YaQ97QD74NC7NaDmmdgYXh7ON8HMw5YHv7ZJWkrbTnalix8UcGZx3s86FZepF8/XiZY5Fg4zjU37frbafExBPjfip+FmLn2fMWfLPyF0rprkZ79iG+iwSQxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730214372; c=relaxed/simple;
	bh=sgwuIi9pkI6sFt6SlEJxpez79bhCIsfYRZ6G8VZu35Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/BuRRI2I73l4aPFs36/fH08+kTfeGGxDUXnH1g4pfrlGtu90M7taDLrwd3wns7Fc1latNgN1FPc8oKArT4pLcHY7FBiBYnM6AxBMlvCOwdrnjpi7TwFLv8GtOOGYw1YzSrZMZxwzmXkWBcdhg1R8wyJ8WZUvpR5NXqEvvrV3Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JtfCNJeu; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9a1b71d7ffso831596366b.1
        for <linux-pci@vger.kernel.org>; Tue, 29 Oct 2024 08:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730214369; x=1730819169; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ocjrOsIhugZ8eY8LLhz0QOSVYV/AdAvwYxIUBczVPno=;
        b=JtfCNJeu0CSG0fVup/fji0n5jTzXZsjjiau0qcIqaVKLSNh2tHz51sW6zAtsHysg74
         uZorm8rOVyPwwlPHK/TB1719zd87aXRJEPPsMG2W5MRtqvXoMlAYLVPnQQLjBd0E+cMi
         tp9og0eojn2qPWcoNNjFgFaYWHHhiQijEgtwet2kw+srn1W2cHaKK0PuM2wTs89Pz4wI
         tZl/KZ10mwIfDhWte9XhVeRVED2fAlKbRd6RGFDvd4gN8/8teFBN/5uKnicxTnEdXBm/
         dBbsXbCQWl+lIXqDGsNB3l6y/oZ0K1qSA2f1p5+9pAHRVAehhsT4UOZ39ZeXvE/vTUz4
         X+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730214369; x=1730819169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocjrOsIhugZ8eY8LLhz0QOSVYV/AdAvwYxIUBczVPno=;
        b=L8JwmAWPtIZ9snNAAZ2j0VqORy3Q/EUr+LH105bA1MvMMqhAvAvvPiP6dnjgJ5JXuG
         Ih39yqkuuRARxOOiVNYnNGSdM4J8CNDznX4VTYFo7MGkEFSlLaA7QF020xxy7ILWaAmg
         mGNtjlALMu11DPjQZdOcBCTTwpRU4Nfe7O/VrmTldlGVJCrji6Dtyo0/HZOjqaWuiq0z
         H8geJjG2nPgZB8Fa97TkZBNLqPELmZdAvImve9aUxOIKGMargC2z94e7EPNOiAi7lbEN
         CU/jDzGaqZhBOCFqsUTU0J1+avTCRMEUNnciIDE/xgH1Bs6LyQNUEaShLkY7w6dUPe0s
         PWhg==
X-Gm-Message-State: AOJu0YzIirWQjCBAiqZKoW6CPdYpknfptX2n6xHBM0xyF8JC8hEDe8qm
	Q5mgSuwT2pRFMsxA3lEtKleVPvpomedSyKK9Stl6BQKrLV4L0vOG
X-Google-Smtp-Source: AGHT+IFEVpTuLnul52Nwvsf7oVoLFpIMmfncQ4L7RFTQ+8k8lelxphLO25lvMb6OTeThdpRWgLyi2w==
X-Received: by 2002:a17:907:1c88:b0:a99:f92a:7a66 with SMTP id a640c23a62f3a-a9e3a61dee0mr6198866b.30.1730214368984;
        Tue, 29 Oct 2024 08:06:08 -0700 (PDT)
Received: from 147dda9f5b00.ant.amazon.com (dynamic-089-014-183-103.89.14.pool.telefonica.de. [89.14.183.103])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f0697easm484662866b.94.2024.10.29.08.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 08:06:08 -0700 (PDT)
Date: Tue, 29 Oct 2024 16:06:07 +0100
From: ameynarkhede03 <ameynarkhede03@gmail.com>
To: Keith Busch <kbusch@meta.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, 
	alex.williamson@redhat.com, raphael.norwitz@nutanix.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 2/2] pci: warn if a running device is unaware of reset
Message-ID: <tq5f7joi6zqc6d4eymwtpbsrll4aujyhd4fbcvh7g3aswbajgc@bttdyllnftig>
References: <20241025222755.3756162-1-kbusch@meta.com>
 <20241025222755.3756162-2-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025222755.3756162-2-kbusch@meta.com>

On 24/10/25 03:27pm, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
>
> If a reset is issued to a running device with a driver that didn't
> register the notification callbacks, the driver may be unaware of this
> event and have an inconsistent view of the device's state. Log a warning
> of this event because there's nothing else indicating the event occured,
> which could be confusing when debugging such situations.
>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Amey Narkhede <ameynarkhede03@gmail.com>

> ---
>  drivers/pci/pci.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 338dfcd983f1e..bbf12d4998269 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5158,6 +5158,8 @@ static void pci_dev_save_and_disable(struct pci_dev *dev)
>  	 */
>  	if (err_handler && err_handler->reset_prepare)
>  		err_handler->reset_prepare(dev);
> +	else if (dev->driver)
> +		pci_warn(dev, "resetting");
>
>  	/*
>  	 * Wake-up device prior to save.  PM registers default to D0 after
> @@ -5191,6 +5193,8 @@ static void pci_dev_restore(struct pci_dev *dev)
>  	 */
>  	if (err_handler && err_handler->reset_done)
>  		err_handler->reset_done(dev);
> +	else if (dev->driver)
> +		pci_warn(dev, "reset done");
>  }
>
>  /* dev->reset_methods[] is a 0-terminated list of indices into this array */
> --
> 2.43.5
>

