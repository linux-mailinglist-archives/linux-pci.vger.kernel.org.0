Return-Path: <linux-pci+bounces-21442-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30341A35B09
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 11:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A773A188CE05
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 10:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED7F18A6D7;
	Fri, 14 Feb 2025 10:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iYxKT12p"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE0F186E40
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 10:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739527344; cv=none; b=ZxRNyq3D4y4AoFMYhp/GW2X3T7KdJckY5p23o6/Rr+ZPQqc/15VLORfEfPsAF0ycADRidkJy50+lYGcNiRoZNnST2ibHd25ttglW31uIYlbtYjIPAhNW7ALqErUe9HMj0ZSnNuuR3MBVakZAnQBBkV35xCs74EPZYEgNCJXmDRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739527344; c=relaxed/simple;
	bh=QDFyTLzokueKtnScqG4Vf6jGOIFVC4KSObwiHgztChQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrMe2fRx0eOE3fjUJ7c5vg4jk4nmJsT4lSKwSYX+DBD/ywS9lO1LY3SpINZJ53BxrKjK7zkkb0g1sz+Cfoq7LWNZVTby99u9nx1DsvbWP3f1rbU5ouffTUwA3QiADed3Optd51a+yptT4l+8Guf9r+zfVky7iV9NLkgNf08rWMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iYxKT12p; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220f4dd756eso4982595ad.3
        for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 02:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739527343; x=1740132143; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G+Urxp375gbyu0BXuGepJ24mxptPlrNnhk6YThOlY/c=;
        b=iYxKT12pxxf8iST5yUzBPeCWxGW5kvjv6YxP5ecJoV1X70AygJWMY7m6d2Z+j1ln6y
         gI3O51OjngMnsnUje1QTYlSXP0APGl98zs1fiKJkR+AVUVcLpFhQrfp3w9p3jUsrzzSc
         DgFBOF2gYtx41y5Nymbf/jIjKWkdGVjBxHnnc64LV3YTu4H7jm6iZEbQmmSw/l4jFZ33
         P/jlRYgYpcMuCYoov2lVXjshQ3o1qAC4pBAXMW3KNBFoILEVlXSUsPg1jKIxPd33Rclx
         QXSL1LIxyGu2tUdJxdRjgcD7qUwiTT+avOzhDzF9937/sGWHDJ4vHHY8pFvCQaMtfbbX
         8ZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739527343; x=1740132143;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G+Urxp375gbyu0BXuGepJ24mxptPlrNnhk6YThOlY/c=;
        b=gyN7/voLFdRU9SgN9yhAe8koDa3ln6xt5/ViN4Ee5jP7JfJqX3sQf0XkjPgA0Jjfff
         24IXRioMYVRPX0xJjor7ixjtM3SP192ZlA6rZe7d+jgiRjmQhVuxilSF0QDCJlrCy191
         hwNoKtt5AUIDIjBgU4Vf1hLPiceVjXDufDLTfAI1n+u7goKVg/etMyFj7QNdA7RpAo8R
         wcut9HWrcdMK0bmgZb6TDiTCBZkRQp5ewcnm6v4ZHFyenJJQEmCDVJGRoPPTPhFqdQ7T
         qjixawiE+M6EbOH1wGLd9evNGDjqvfCvo5Wcpa0BbuvALnSIPSXDNrUIi3X4h1U5bPKc
         m9dw==
X-Forwarded-Encrypted: i=1; AJvYcCVte5ElcXZFu3K7V7ryAHBnY9qwBVHIQQAKT3ThMiKHTihoEy8UNg2wIrLrF4jd+qL4M7wmBepq2GE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPkNJ3bW2cz21A+3FAiSCefM22GtFsY6sq2kGQobcIG6WB6xyL
	23dPWbVXkpogn5WuteKkigBB3xu4OPacC8Rizfvdn+bZwM1l1iFNmKFLfgfKgw==
X-Gm-Gg: ASbGncsp8YVHINAia3MQQixxwoMOe7htRIcD+KUybzCbwkEb4LKvqB70rw4dgJWoBzq
	XZgGPzjFVXyEfFNAcLvQ/5Alii37ggWk5l6+wZLPL3v2n3hVgpBU9wszl6nR4RsSoP8S+smHKs6
	JrKRXgf9DFMtTSyYqHVEJzogw81DSF7+g37JU6RtHX1xCUPyMU4w2/3hWwOQ2ToLn7vGqlZrSyP
	DavjTpF7NrkD19RU0enf6/JdbUrw4l5LNSIo57o6GAyYhHVvOLaxOGnBnO0ge20OztMJYxhm62v
	Zo6IQnipP0PYCSQ7lLK13Z+U+WTMk8S3uLo47EPk7DV7sOk/CrsXcBiIsg==
X-Google-Smtp-Source: AGHT+IHDjzRxEeMoGhgGdPvY9ojnF3WOZUPobhsgi9wDcnHIdF/FQRuaZQcNHl392P8ftMXIs+sZ2A==
X-Received: by 2002:a05:6a00:600d:b0:71e:21:d2d8 with SMTP id d2e1a72fcca58-7323c116d28mr8867334b3a.7.1739527342521;
        Fri, 14 Feb 2025 02:02:22 -0800 (PST)
Received: from google.com (49.156.143.34.bc.googleusercontent.com. [34.143.156.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242549d0csm2748222b3a.21.2025.02.14.02.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 02:02:22 -0800 (PST)
Date: Fri, 14 Feb 2025 15:32:13 +0530
From: Ajay Agarwal <ajayagarwal@google.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Johan Hovold <johan@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Manu Gautam <manugautam@google.com>,
	Doug Zobel <zobel@google.com>,
	William McVicker <willmcvicker@google.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org,
	Joao.Pinto@synopsys.com
Subject: Re: [PATCH v5] PCI: dwc: Wait for link up only if link is started
Message-ID: <Z68UpU0nofdUWddW@google.com>
References: <20240130183626.GE4218@thinkpad>
 <ZcC_xMhKdpK2G_AS@google.com>
 <20240206171043.GE8333@thinkpad>
 <ZdTikV__wg67dtn5@google.com>
 <20240228172951.GB21858@thinkpad>
 <Zeha9dCwyXH7C35j@google.com>
 <20240310135140.GF3390@thinkpad>
 <Z68JlygEqQBSDWPA@google.com>
 <Z68KYxSniCxdMMAg@hovoldconsulting.com>
 <20250214094255.jmfpkmzwqn5facsy@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250214094255.jmfpkmzwqn5facsy@thinkpad>

On Fri, Feb 14, 2025 at 03:12:55PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Feb 14, 2025 at 10:18:27AM +0100, Johan Hovold wrote:
> > On Fri, Feb 14, 2025 at 02:45:03PM +0530, Ajay Agarwal wrote:
> > 
> > > Restarting this discussion for skipping the 1 sec of wait time if a
> > > certain platform does not necessarily wish or expect to bring the link
> > > up during probe time. I discussed with William and we think that a
> > > module parameter can be added which if true, would lead to the skipping
> > > of the wait time. By default, this parameter would be false, thereby
> > > ensuring that the current behaviour to wait for the link is maintained.
> > > 
> > > Please let me know if this is worth exploring.
> > 
> > No, module parameters are a thing of the past (except possibly in vendor
> > kernels). The default behaviour should just work.
> > 
> 
> +1
> 
> Btw, you need to come up with a valid argument for not enabling the link during
The argument for the link to not come up during probe is simply that the
product does not need the link to be up during probe. The requirement is
that the PCIe RC SW structures be prepared for link-up later, when there
is a trigger from the userspace or the vendor kernel driver.

I am looking to treat this like USB, say. The USB DWC could be probed when
the cable is not connected. That does not fail the probe. Later when the
cable is connected, the USB link comes up and the enumeration is
performed.

> probe. Also, not waiting for link during probe is also not going to work across
> all platforms where the controller is used, unless your hardware supports
> hotplug or LINK_UP IRQ.
We do not necessarily need the hotplug or LINK_UP IRQ right? Once the
LTSSM training is enabled using the triggers I mentioned above, I can
then wait for the link to come up using `dw_pcie_wait_for_link`. IOW,
polling for the link, which is what the `dw_pcie_host_init` does.

> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்

