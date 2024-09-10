Return-Path: <linux-pci+bounces-13013-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E36ED97433A
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 21:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A39F6289B92
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 19:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971C219412D;
	Tue, 10 Sep 2024 19:12:10 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D7A1A38C1;
	Tue, 10 Sep 2024 19:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725995530; cv=none; b=en1NaNbwcA/ruSlXiNWcWcIs+lVR1QQ1cTA8aoyq2M1xzW7Q5D2eDfgyDCu06XOsY2Li0B2DorrQFtGoskrozH63Zd2maGMWXrdLq/Ebwqh2qKjbPLwSyTVNjkYNuLPczmxNvcLJ0p1WF+PNNEX3lenqBEtq7dQex51oMKm/ppE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725995530; c=relaxed/simple;
	bh=EJ9PTyPobNaDxnlgarj3OJ8NarmtEiCZ3lIrhA0Bn5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S33KMdM2r+DllD20NVwMm7FlLLBBIgv2z0H4CuZFe7cf33zGBfqsRYAOgWtMDJffGZbbYderkUVWA25Evc69i43OG8bDf96cmi8npGpX1uDhkKtUFXg+i8g+1wFKOnNArXEJYv53fEAgB9MutAP3bovzqDBZnIescGUk+BFBQNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-205909afad3so13558845ad.2;
        Tue, 10 Sep 2024 12:12:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725995528; x=1726600328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mA8frEtKE7zCA4BMrK1977CzL1f+kX5NxZ2Qw/chQng=;
        b=E26owXWRZe3nCoU4YvdWA9on8QWb+7Z+/+p0TasfmictyuVHMJPDuTyUUq2Q01r7Xd
         i84/swM+Y0RUYjoKYvFcXcDb9MMXKvR7VJAvxgkO16xLSlIJzvp+dl7A0BcAqWNCFT9o
         Hks7+/pEDbx9iZfohdPjvQ0GQS/E8CPLNFBhyc3VTV8zJb+KuNRi+OUMQ6lQodcqKF8N
         E8/hnVUdidRkcnh551B630nZbPWA0YfMhCbX4EXQTIjoGJLRLdW+dfWXWajlGYGkHp+y
         RcaIKg0tSvMBpXnNt4cUZZywbHQRzHtoXllk/av1+rcyeDKYXFQwa69MhPcDZHivYHva
         dVGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVW/AzEwDHrAbQ4GrxOISMuB1iRHNfdfVBhkE1mQX7aLZUBCsMrt9LSTPQbE2CgK0/36ROdOSkhsbI7@vger.kernel.org, AJvYcCXB7VTGhkxG8CE0hiyei8LhdVbx5PzePUjTPbTxQCaU6ernnoezfw0I/4UMK1SI5jUPAUj+LR4ArWEHS24=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/c0ctLrqNC4HDWZC4jYSQAqBltZVF/lxy9SHTngWOU+7eMlwk
	sZV7KzELRqaLONULF/3Wo6/09qW7pQoPxl9+KS97CnISojoCh5Ee
X-Google-Smtp-Source: AGHT+IF4QUAsjy0839f72lUloSdY+hgfitwkQkZT39RLiIEPplPvYqH9nKPvZTIhSpT8Rk+k/D0Z2w==
X-Received: by 2002:a17:902:d2cb:b0:206:ac4b:8157 with SMTP id d9443c01a7336-207521aa78bmr7545195ad.31.1725995528134;
        Tue, 10 Sep 2024 12:12:08 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710f3121fsm51942635ad.257.2024.09.10.12.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 12:12:07 -0700 (PDT)
Date: Wed, 11 Sep 2024 04:12:06 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, joyce.ooi@intel.com,
	lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org,
	robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] PCI: altera: Replace TLP_REQ_ID() with macro
 PCI_DEVID()
Message-ID: <20240910191206.GB2136712@rocinante>
References: <20240828104202.3683491-1-ruanjinjie@huawei.com>
 <20240910003029.GA554499@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910003029.GA554499@bhelgaas>

Hello,

[...]
> >  #define TLP_READ_TAG			0x1d
> >  #define TLP_WRITE_TAG			0x10
> >  #define RP_DEVFN			0
> > -#define TLP_REQ_ID(bus, devfn)		(((bus) << 8) | (devfn))
> >  #define TLP_CFG_DW0(pcie, cfg)		\
> >  		(((cfg) << 24) |	\
> >  		  TLP_PAYLOAD_SIZE)
> >  #define TLP_CFG_DW1(pcie, tag, be)	\
> > -	(((TLP_REQ_ID(pcie->root_bus_nr,  RP_DEVFN)) << 16) | (tag << 8) | (be))
> > +	(((PCI_DEVID(pcie->root_bus_nr,  RP_DEVFN)) << 16) | (tag << 8) | (be))
> 
> This doesn't cause a problem per se, but PCI_DEVID() is defined
> basically as a PCI core convenience without any particular connection
> to the PCIe Requester ID format, so I don't think this is an
> improvement.

I will drop this patch based on feedback from Bjorn.

	Krzysztof

