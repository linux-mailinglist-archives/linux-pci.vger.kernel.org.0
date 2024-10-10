Return-Path: <linux-pci+bounces-14220-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F28AF999171
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 20:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 852D9B21E7D
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 18:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64BE1F1319;
	Thu, 10 Oct 2024 18:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SbJseFfK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDE91F12ED
	for <linux-pci@vger.kernel.org>; Thu, 10 Oct 2024 18:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728585301; cv=none; b=LuFpYzNrIt94F8oRm0PVRfJs1rChs4NHIcXnR+DXgeyN60i3o6UVYWk+Hf7NCxCH8zDxbzCgQoWKEaJ1/IfJ4wtY0I/GtRfYq7WMUT7kL2MNQe8o9L4uDUUOMyRBHJCRzSAahGNeHjmsteKqK0f9vpKuT+S/56SyTC9Qa7hme+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728585301; c=relaxed/simple;
	bh=5H0TXKb7vdMMBfioB1w565xsNdpUuNNsw5k1MJOU+qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bmzxj0FXZ9V6mwh872FfukrNJJ90PMnCtcGkuUSip9VjgIefU9z384C+Msv1SCvetVwtlw4KofpLqz6KMNegQppPivz7Q/kfoiJyUUa+KLaY4sqcIv6/tUcGelaf9jnVVCoL1eUHNAfwGMu6gJl0x7hmzschlgE7BFANbxBDnzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SbJseFfK; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43057f4a16eso10494715e9.1
        for <linux-pci@vger.kernel.org>; Thu, 10 Oct 2024 11:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728585297; x=1729190097; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ytCziD1c5I5FhCXF5EK5g0FeePvbLPZ6YQt0NDF0j9M=;
        b=SbJseFfKB5iTfiX6Q+huR0onyNzE3nj9ar6pMNaTyUeaj1Ukm2/6KVHBPIbpbhefdN
         FCaJnJ0XXcGNZb9WnyKF+dygNphBCMKUjYJKEVanq4IiL6QEjfOWDdVXXVgr7AhbHxkt
         shZ5Uc50rQp22ihdNjuzJaRvHxATDoi7NLjUeFKqN/3U+euQhEU3jnZ811Ah77r9RnhJ
         1r+5G7E0OWJNSNGAbZ/f9BkGV8BjrhCvo10KO/KeYVhyNgL0ZHw5vAP/6rLjJ2/bU4+c
         G9E772X9u7u1UVpu7ERvlJIKkuj5jpjSi2l6KrK3O+M4rqUnhpypLMlp/c2ADJlHdgMQ
         VBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728585297; x=1729190097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ytCziD1c5I5FhCXF5EK5g0FeePvbLPZ6YQt0NDF0j9M=;
        b=Hm9XvufCGRZyB9OTtq0NGg7wpTbRlnU8OutCd+YuYa7tv4L5Ru57tStfTDEriDDFs0
         wodRntjiUVhN7tLZNs0ycwhe6mOPnK4s7G/yRnB1N6HB+EaymMLvhx1ZLfaV6vSWkqnS
         ZjO6owebjN2B3wbamlkqiPJJ6/fVGp2ixchn/t6laUBe8A50T9RZSFE1CP9jMnwqtq7s
         6Tg0ojJQaOOR8u/g2JL3vSRa6mGcKpLQQqQ6UTFq2ExXF1ar6c6YJ9XfugOHlashu6Oz
         +QwEWcvIRz3rwtTIib4v4PNnt651IF+Q2nbeWD3A7Tx94Aw2aKOloBA1q9F93cH7uNjO
         TexQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoGASFTVMxtlApJH4RtPqCSjy4ofxaT7sreO4Nht+kcfQTlX31clHBGqHkNKg55FSJo3dE0GONITY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+V/JL6MTWd4bji1SyurTj8ldXJYoSIPcMdRKf3hQLfw4Hp9uH
	7PzFI9hEl6kk9cBWadOafTVTF0RGEUu1uClsKy1skDwzgLMy+V2naShh+l1PeVU=
X-Google-Smtp-Source: AGHT+IGrQtiU9KkPJvVdlsqZUQMKOCUeX11EZAgMHCeWVATX5aFzmtkTu4Efnh91V5tJdIM1vfefqw==
X-Received: by 2002:a05:600c:46c9:b0:42c:c401:6d86 with SMTP id 5b1f17b1804b1-431157e56e5mr37151355e9.27.1728585297410;
        Thu, 10 Oct 2024 11:34:57 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4311835696esm23005225e9.37.2024.10.10.11.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 11:34:56 -0700 (PDT)
Date: Thu, 10 Oct 2024 21:34:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Philipp Stanner <pstanner@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Basavaraj Natikar <basavaraj.natikar@amd.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alex Dubov <oakad@yahoo.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rasesh Mody <rmody@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
	Igor Mitsyanko <imitsyanko@quantenna.com>,
	Sergey Matyukevich <geomatsi@gmail.com>,
	Kalle Valo <kvalo@kernel.org>, Sanjay R Mehta <sanju.mehta@amd.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Chen Ni <nichen@iscas.ac.cn>, Ricky Wu <ricky_wu@realtek.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Breno Leitao <leitao@debian.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mostafa Saleh <smostafa@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hannes Reinecke <hare@suse.de>,
	John Garry <john.g.garry@oracle.com>,
	Soumya Negi <soumya.negi97@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Yi Liu <yi.l.liu@intel.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Christian Brauner <brauner@kernel.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Eric Auger <eric.auger@redhat.com>, Ye Bin <yebin10@huawei.com>,
	Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?= <marmarek@invisiblethingslab.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Rui Salvaterra <rsalvaterra@gmail.com>,
	Marc Zyngier <maz@kernel.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
	ntb@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-staging@lists.linux.dev, kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org, linux-sound@vger.kernel.org
Subject: Re: [RFC PATCH 13/13] Remove devres from pci_intx()
Message-ID: <0990d9f9-cab9-44c2-b2e3-bd8fa556cc02@stanley.mountain>
References: <20241009083519.10088-1-pstanner@redhat.com>
 <20241009083519.10088-14-pstanner@redhat.com>
 <7f624c83-115b-4045-b068-0813a18c8200@stanley.mountain>
 <f42bb5de4c9aca307a3431dd15ace4c9cade1cb9.camel@redhat.com>
 <20241010114314.296db535.alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010114314.296db535.alex.williamson@redhat.com>

On Thu, Oct 10, 2024 at 11:43:14AM -0600, Alex Williamson wrote:
> FWIW, I think pcim_intx() and pci_intx() align better to our naming
> convention for devres interfaces.  Would it be sufficient if pci_intx()
> triggered a WARN_ON if called for a pci_is_managed() device?  Thanks,
> 

To be honest, I also don't mind if you also just merge the patchset as-is.  I
was mostly just throwing out ideas.

regards,
dan carpenter

