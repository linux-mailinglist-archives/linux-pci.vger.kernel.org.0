Return-Path: <linux-pci+bounces-33237-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0769DB1713A
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 14:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CF6B5874F5
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 12:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A622C17A8;
	Thu, 31 Jul 2025 12:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HNfjI489"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9350C2C08DB
	for <linux-pci@vger.kernel.org>; Thu, 31 Jul 2025 12:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753964917; cv=none; b=T4eb34hD5oVp8TnwmlQTGqA412uW8w/QBIIwl9qHfXRMkRXxs7VScCl6dUHA1NfZhQNnZjuU/13IwgPGFDkNiSCctcJYpO8+wPnS5+a+itrYN0ROGKFtZGoowx+pu9SkAgwqMwy56iS08+O6OZnZvrEoOI3aVwMuTSkJLem2pYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753964917; c=relaxed/simple;
	bh=b7z5hjyg2X+VeoFo1PgyUE9sKzY0a5OOB4fYEBfffec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHw171guKZyIGC1BlJ/d55o8PHhceyje8gZK90c9yeJMPb6Xeowu2MGy+2KQp0WQilsZkflvRe+1eLWw37s6LzIEY8DQK4fo88elEecBOq4wsGBRZ+8D9PDIf2E3LagJTRhu5IXooA7MMtPbeIqN3I15Ud4vjydKowfNTOuLS3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HNfjI489; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7e6783335a2so32423485a.1
        for <linux-pci@vger.kernel.org>; Thu, 31 Jul 2025 05:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1753964914; x=1754569714; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OW/Iya9h0ABUEfHeAI61tqBJP6UR+IkHJ9+YZwygnb0=;
        b=HNfjI489w/nmm9v4KPmn2rIBwTUX56yvucBIsp8A+P2kHlMrpYC991fnyl2jPaPE1o
         YDGlknxsVwbDyt1Q01wRZxWKTsr0ViLyIAmUslu1NJ+orvOX1RU0Cha7ZIsUwJcyX8wh
         dK3OzA370jwxBE2ayFCWz9PVsw1lC27hld8Cvtgs1jX2sGipWDiwRMNQ0cFZblol9cBD
         R+kEgul4XexdcpbmDTQu9PE5SI0AWEYqCzNktzkjO4yYFV/BW+wvFc7UY407zpyInf57
         x3qkfP5Re09HMNKUjrvmYjjwDI+2/55SwlMNalLkpOpOmzHxFw9F0DF2VYdD8KuQwyYm
         QaMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753964914; x=1754569714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OW/Iya9h0ABUEfHeAI61tqBJP6UR+IkHJ9+YZwygnb0=;
        b=lksnd3fW7AKWxrRfz2mObJ6fJM5+wfIg1ej7C9UEP008oh2gnngHLrtYnDbEeCElmT
         BSrre0jTWHZO/wv2NJS+fX4luuBSSTNnuTY8S0NNG7pp9/KsZDqKGReN28bp+u6jojlg
         XLCbWj0Ht6/imjiCgVarryrqLa0lMHamvq7cW9Dn/Q8DYbgIeRe7Vqb3YloXMvJ2l5dc
         LDf8BhXuwqBgZbi18JAOHOcty+GmBa4lvvWAutvUrq4LDEp8JbnB15njLVDKkfgluDge
         x4WU6zlFYBp8bJ73TrO5NTTqRPhcLQpwECs0JqR+fNEamT1JXSRtSUTjwCSJJcqXLbQg
         LqUA==
X-Forwarded-Encrypted: i=1; AJvYcCWzpHC/WKot4nrJtQWmkBqt1HicBj28LtZ2UEKIYC94F8gZmVMoKvbJUan3AxaA2VmbAdpSN4X9CT0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzf0qehGMw/fCqj1iei7CTDpnHY2uS1K42NIIzacHeHhXi/XcI
	hrpOi31S1uaKevIgFedSMXahy4mXEGLH/PTsVOXB1qmbK4kgpv/zrpGpOkmWwhw5RgQ=
X-Gm-Gg: ASbGncssAcBetX6hha4WLXbjybQUxfxjRE2I2V+956k46dRqlxCmqo9m2mhmuUf6oOv
	WD3YE3L/FfH6RYwz7bH9/M1IRIz6LbBuJFoHzr9jYfwLvtIzfD/tC7wV/WetZ5on0fFue0SnWVx
	qR1w/lkpOV2Liazwnd5CsuhEgou6ZU+/Bx/yTaTYB0g26bgLmyuJHjkLs7TgZFRC+1Z++2CPntF
	ZxARoaSRQAgwPC+Yepv/BDGnddr1BZfCto6ppx2XtK5a/MnDPNVb0fRGvaXmkl8QmpaG/SpKX8O
	GFs98UuaGM//cVBUnp+6RZXeuUG1eBszCkiajaTicx5SVyK1YwUYxsAK8FzO2rdYiFubbJRQ5Sl
	U4ZBCs8rPOpaKAqXH4/pqEUWXugq2IkwFWAqiBRyzlSBeTrObju+SilgLS9AbbwS86TXw
X-Google-Smtp-Source: AGHT+IGB5rbfhCfpEBxYzQb9tShfBv5DP1x7P0EzX5XLP6rdIVy17VMQfI03BZoFiDbqj4lwUzglhg==
X-Received: by 2002:a05:620a:571:b0:7e3:5129:db49 with SMTP id af79cd13be357-7e66f3515edmr758031285a.45.1753964914155;
        Thu, 31 Jul 2025 05:28:34 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f702578sm77242785a.57.2025.07.31.05.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 05:28:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uhSOf-00000000oaS-0Yjj;
	Thu, 31 Jul 2025 09:28:33 -0300
Date: Thu, 31 Jul 2025 09:28:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	aik@amd.com, lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 14/38] coco: host: arm64: Device communication
 support
Message-ID: <20250731122833.GT26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-15-aneesh.kumar@kernel.org>
 <20250730145248.000043be@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730145248.000043be@huawei.com>

On Wed, Jul 30, 2025 at 02:52:48PM +0100, Jonathan Cameron wrote:
> > +static int init_dev_communication_buffers(struct cca_host_comm_data *comm_data)
> > +{
> > +	int ret = -ENOMEM;
> > +
> > +	comm_data->io_params = (struct rmi_dev_comm_data *)get_zeroed_page(GFP_KERNEL);
> 
> Hmm. There isn't a DEFINE_FREE() yet for free_page().  Maybe time to add one.
> If we did then we'd use local variables until all allocations succeed then
> assign with no_free_ptr()

Maybe think carefully if you really need a "page".

What would prevent just using kzalloc(PAGE_SIZE)? Under the covers it
is almost the same thing.

Jason

