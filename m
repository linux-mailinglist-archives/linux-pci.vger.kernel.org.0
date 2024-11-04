Return-Path: <linux-pci+bounces-15923-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D94BE9BAF5C
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 10:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 090A71C2471C
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 09:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE941AB6F1;
	Mon,  4 Nov 2024 09:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iPAliAyp"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E21514B06C
	for <linux-pci@vger.kernel.org>; Mon,  4 Nov 2024 09:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730711679; cv=none; b=VuK1PKYCrjqQYfAkTJZvzoaaqAd9nt+3yGSj6GiQVQTxxCIhDu+IZi2amyeAZpmXeHDUacv3D4HPl/dMR4G0vjNFYNOOdK1Py0dXtvKKykcOT6gwqSnqm39jreWGogVWR0XYVR4yueTPc4ssXUCPl5nTN/paLtAlz1zNvMZwxXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730711679; c=relaxed/simple;
	bh=hiHsPauRi7s7KPRKqYRrT/HM9VquDPkYW1yuB7BDXOQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ilotW268OzGISduG4XwZM5Gg1s52MStEnoyRkSEMF0KQnpl1CDMX7J/tr4BQf8PjuPQ7bacf/qT5y+2WgG4MqTUKuwFTBvZPWI0ut2mjXwZnJRXUr0ceTvqeROXOgI32eC1VJc/Qb8g2jdEoFTgrF89jDTU93hvpOK9EYNilD0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iPAliAyp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730711675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NtE4zaC+EvvYENi1cZzK3nZQgfkXnUy5NNza5i8H9P4=;
	b=iPAliAypOtF8lencyKAO9eMAXqSkBIBRRz2UPM/dq/+0fH8jQh97djRijqboRmtx3ZsfX7
	5KQznTzEJrUiA9W8w/XnYYtiAw/wjP3ftxJKQp6CZX1mlbMo1CXdHAmD+6IGSfImf8LAxV
	PwVmBNTzvp6I8ZeBogEbD5iCNNYpLoE=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-q80zzFl4NOeNcdWo8M_FZg-1; Mon, 04 Nov 2024 04:14:32 -0500
X-MC-Unique: q80zzFl4NOeNcdWo8M_FZg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-539e4cd976dso2290326e87.0
        for <linux-pci@vger.kernel.org>; Mon, 04 Nov 2024 01:14:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730711671; x=1731316471;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NtE4zaC+EvvYENi1cZzK3nZQgfkXnUy5NNza5i8H9P4=;
        b=dDa4zptA15wGGQRT8e/3+yQQcpq6oBf4vgPMwBtABKuI44bY8EWChj8aCN9/823qcl
         FbFy79+u4U0/C2GEbmqFB0CsNO5f8PqBlzKuHbU4NIfah3Hy/fjuLJDZQX5GITnKKgeR
         Sz6EZHxYMxn+n6Wmwz94CLOEizCOZocciNGb263sKrZKO6X1/kVJ659IGuZHvgA2XC6H
         5oMOHjbwmtZHM84RxBsc4dwAEARUCE+cB1pcoY/0e77hFdgsFMKUlUqoMcq5crKN8NUs
         oFtJ8De0NfnHpDt90gvrTPLCe4aljz9rAD0jMfk7Nm9vGNwzlZysND7Rtw69oax0++v8
         Nj+A==
X-Gm-Message-State: AOJu0YxHCAiu4EabYH3AVWiVdlgXYKKmvtx7N+drLHjAbhK0H5cyoiji
	sN7WFqV2hIiJMD6wUw5XRW5s6GkzgcxpniQKzyUEG2aAeyW76MrXIc1mD7wG972UcCMIE8U6nr1
	5/F4qTjN6qpfMhu0wURjFCDLc7ftos2JgBDhS7Mm/uJBSNBsIaKxa6pfT8JNya8fKkA==
X-Received: by 2002:a05:6512:2396:b0:53b:4899:9be9 with SMTP id 2adb3069b0e04-53b8903e4b4mr9227370e87.59.1730711670853;
        Mon, 04 Nov 2024 01:14:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHwE8PfdjYGs1eURMRKPA4hivs/ziQVbeixVH0+VkgT93/eTPTzRsRq2A2vaf12NdpQdoUvgw==
X-Received: by 2002:a05:6512:2396:b0:53b:4899:9be9 with SMTP id 2adb3069b0e04-53b8903e4b4mr9227351e87.59.1730711670400;
        Mon, 04 Nov 2024 01:14:30 -0800 (PST)
Received: from ?IPv6:2001:16b8:2d7f:e400:7f8:722c:bb2e:bb7f? (200116b82d7fe40007f8722cbb2ebb7f.dip.versatel-1u1.de. [2001:16b8:2d7f:e400:7f8:722c:bb2e:bb7f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113e5d6sm12631719f8f.76.2024.11.04.01.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 01:14:29 -0800 (PST)
Message-ID: <61ef07331f843c25b19e5a6f68419e0a607a1b0b.camel@redhat.com>
Subject: Re: [PATCH v2] PCI: Restore the original INTX_DISABLE bit by
 pcim_intx()
From: Philipp Stanner <pstanner@redhat.com>
To: Takashi Iwai <tiwai@suse.de>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 04 Nov 2024 10:14:28 +0100
In-Reply-To: <20241031134300.10296-1-tiwai@suse.de>
References: <20241031134300.10296-1-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-10-31 at 14:42 +0100, Takashi Iwai wrote:
> pcim_intx() tries to restore the INTx bit at removal via devres, but
> there is a chance that it restores a wrong value.
> Because the value to be restored is blindly assumed to be the
> negative
> of the enable argument, when a driver calls pcim_intx() unnecessarily
> for the already enabled state, it'll restore to the disabled state in
> turn.=C2=A0 That is, the function assumes the case like:
>=20
> =C2=A0 // INTx =3D=3D 1
> =C2=A0 pcim_intx(pdev, 0); // old INTx value assumed to be 1 -> correct
>=20
> but it might be like the following, too:
>=20
> =C2=A0 // INTx =3D=3D 0
> =C2=A0 pcim_intx(pdev, 0); // old INTx value assumed to be 1 -> wrong
>=20
> Also, when a driver calls pcim_intx() multiple times with different
> enable argument values, the last one will win no matter what value it
> is.=C2=A0 This can lead to inconsistency, e.g.
>=20
> =C2=A0 // INTx =3D=3D 1
> =C2=A0 pcim_intx(pdev, 0); // OK
> =C2=A0 ...
> =C2=A0 pcim_intx(pdev, 1); // now old INTx wrongly assumed to be 0
>=20
> This patch addresses those inconsistencies by saving the original
> INTx state at the first pcim_intx() call.=C2=A0 For that,
> get_or_create_intx_devres() is folded into pcim_intx() caller side;
> it allows us to simply check the already allocated devres and record
> the original INTx along with the devres_alloc() call.
>=20
> Fixes: 25216afc9db5 ("PCI: Add managed pcim_intx()")
> Cc: stable@vger.kernel.org=C2=A0# 6.11+
> Link: https://lore.kernel.org/87v7xk2ps5.wl-tiwai@suse.de
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Reviewed-by: Philipp Stanner <pstanner@redhat.com>

Nice!

> ---
> v1->v2: refactoring, fold get_or_create_intx_devres() into the caller
> instead of retrieving the original INTx there.
> Also add comments and improve the patch description.
>=20
> =C2=A0drivers/pci/devres.c | 34 +++++++++++++++++++---------------
> =C2=A01 file changed, 19 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
> index b133967faef8..c93d4d4499a0 100644
> --- a/drivers/pci/devres.c
> +++ b/drivers/pci/devres.c
> @@ -438,19 +438,12 @@ static void pcim_intx_restore(struct device
> *dev, void *data)
> =C2=A0	__pcim_intx(pdev, res->orig_intx);
> =C2=A0}
> =C2=A0
> -static struct pcim_intx_devres *get_or_create_intx_devres(struct
> device *dev)
> +static void save_orig_intx(struct pci_dev *pdev, struct
> pcim_intx_devres *res)
> =C2=A0{
> -	struct pcim_intx_devres *res;
> +	u16 pci_command;
> =C2=A0
> -	res =3D devres_find(dev, pcim_intx_restore, NULL, NULL);
> -	if (res)
> -		return res;
> -
> -	res =3D devres_alloc(pcim_intx_restore, sizeof(*res),
> GFP_KERNEL);
> -	if (res)
> -		devres_add(dev, res);
> -
> -	return res;
> +	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
> +	res->orig_intx =3D !(pci_command & PCI_COMMAND_INTX_DISABLE);
> =C2=A0}
> =C2=A0
> =C2=A0/**
> @@ -466,12 +459,23 @@ static struct pcim_intx_devres
> *get_or_create_intx_devres(struct device *dev)
> =C2=A0int pcim_intx(struct pci_dev *pdev, int enable)
> =C2=A0{
> =C2=A0	struct pcim_intx_devres *res;
> +	struct device *dev =3D &pdev->dev;
> =C2=A0
> -	res =3D get_or_create_intx_devres(&pdev->dev);
> -	if (!res)
> -		return -ENOMEM;
> +	/*
> +	 * pcim_intx() must only restore the INTx value that existed
> before the
> +	 * driver was loaded, i.e., before it called pcim_intx() for
> the
> +	 * first time.
> +	 */
> +	res =3D devres_find(dev, pcim_intx_restore, NULL, NULL);
> +	if (!res) {
> +		res =3D devres_alloc(pcim_intx_restore, sizeof(*res),
> GFP_KERNEL);
> +		if (!res)
> +			return -ENOMEM;
> +
> +		save_orig_intx(pdev, res);
> +		devres_add(dev, res);
> +	}
> =C2=A0
> -	res->orig_intx =3D !enable;
> =C2=A0	__pcim_intx(pdev, enable);
> =C2=A0
> =C2=A0	return 0;


