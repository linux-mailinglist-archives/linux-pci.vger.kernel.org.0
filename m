Return-Path: <linux-pci+bounces-33196-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8966B16408
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 18:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDD0D3AD8E3
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 16:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5932B2DAFB7;
	Wed, 30 Jul 2025 16:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mi/7/0nM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD90293B5E
	for <linux-pci@vger.kernel.org>; Wed, 30 Jul 2025 16:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753891411; cv=none; b=Du8pZKrvUJspO6b3UwZbV76N4nDNLFKOrikOi92z5zRj4E0uHBFFcXkeV+VQR3v//1sdL6716L25dZmk/7UBsXoiVmEMssZNRMlJhtz3SAdXfHscfrFwxwqVquHxZHPwm2CQb3MIgbXH2IO7kZjsDQD3BX2TEobsWK5AGZMahiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753891411; c=relaxed/simple;
	bh=JD/vxYw0vyKQComxP4E1Z53ndDUYTzU3hErVNH+AgZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JoKmHh9g0UlWege8q9+fOPZkSmf8HfZBWJQFGHLsYJsdJg0hQNTBDddbzf6uK4TQPKyU2Rzi8UGBngnFPWMhM1KyAwvWpwnfNR24DXdiwup2XBAGkS2HkyqFdyReEfCN0WfMFLpPQrs/by4gUGYh3Af/UPl9sLTmB+KC37Fwn48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mi/7/0nM; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-7074710a90bso28142686d6.0
        for <linux-pci@vger.kernel.org>; Wed, 30 Jul 2025 09:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1753891409; x=1754496209; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JD/vxYw0vyKQComxP4E1Z53ndDUYTzU3hErVNH+AgZo=;
        b=mi/7/0nMsNks/vscU7x4ar2dhvN3RihseppRPvnuMM14wAZyj/t4o2QEALtV8PgVFE
         bgKNfzCzg/oX7o2s52iiloUvDs5lNTSZAekum8ehKoqJhL9q+9lzbVDJ5II0Cw4qN8nA
         tQoO0xwyEeLCPfV9TjVJya1GfcL5rkRpt9F+YW0k9DnzMzIvCrTTzy0oIlkR/eLsAgQv
         A4Ng0v0K87NjfU7vD2BVAZUFSq/8270T0hWOaUYaWQa8l2GfLy8mK7EhRpBVLsl9o24x
         LvCAO+HTTULu6u2tA1y5VRZJ8IBT3Y1Y4FjYPhWywWUNIzwAxT2OrCL8NGjeI2vtsrz8
         LLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753891409; x=1754496209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JD/vxYw0vyKQComxP4E1Z53ndDUYTzU3hErVNH+AgZo=;
        b=HrBZYPLx6uGAf7AP3stRt9RxDUTKhdz+3VijxCqzx8coeeVlFB8LDXqA/asROal095
         R/IroD3evmDDyjID4lKMv9SnJiXAJIeMSSMz5hbuFefthM3JoCBneaAWwXAmaIiaTaxk
         4ZauSMFg2Am4lnQUYYXv9Vfh4EJbTKWeSPy1KjOQHIoUnIC7ekusFGltoFMqIroYCyU0
         ZqcAJ327o3RqL2pF/Uk7tj+W6QH/8zYNlbKyU9L/fwdN+jz14PlPYenlcfzWj6KhfY6q
         Qf9vYDk1Uzuh7tyw4yyMAq5Oit+S/MMN5nKW/xmHNew6B2ROOlebTWI6nqnPFmgZSZ7e
         Q4Jw==
X-Forwarded-Encrypted: i=1; AJvYcCVZNWEvsC8RwjUCOzzeRKj56Qof5H5QE13nLTbXmQN78fQSD8upHlo0DWi6wAVzirJUwgPZ2vkJFiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdQqSNg+LsXVzRglIo6kB+k5hk8hj9/WAsvyJyN8SHfL2TB0rb
	9sVOw8NRSxj9HYoWYBmnNXK+w8S46VUbEnzL/0JDwaK3aInL9rCQLhv+kmFYZpXNyLU=
X-Gm-Gg: ASbGnctmj31n8VE6FgfeyMkHYaF9Cj6mbPPrsbIUpV1aJtgnbI1njaKbTrhJZ/nMVSM
	BU0nFyPdSOlQObBrDJ9+rP9lIzyVhY9QitsLvf4u/hVnCxfyF6XQmOeS5txj4+W1OyDxjG2q6i7
	KWGQuQblKyIPXxlMDLMJuIjYuR/Ul3dKSyNAUB5ksKRR7S1Y7uGTbDWbJNSUXrNQEP4640Eubq1
	jqQPn4Mlva5LfpJMhUwn9lJnadwshqW6XmFV+yIOVBQwc0XMYnyJ8PiYz26jo6pgTnr9bXUhpYy
	GdV2ycsN8WqR7P8ZEK1TIHcifBKlqtrrbMva8GKRGX8oPSlTYjBERnFRFZ8P9XINpr8yFgxLIov
	tr6txMdE42emr0KKbpYI8wAwwx3K3mrRRchBZGLHa9z/KBFPQ4tZ5HKn8bgsNR+ufltcj
X-Google-Smtp-Source: AGHT+IELABFxJjSRVnbcoDgQoyF3DZZtzde7lxM9LhmXgjrOqotsrSt3Aw3+tn7CmcIoh22Vu+LWXA==
X-Received: by 2002:a05:6214:5296:b0:707:4825:ff41 with SMTP id 6a1803df08f44-707672d91b7mr47058816d6.42.1753891407540;
        Wed, 30 Jul 2025 09:03:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70742e70964sm47845006d6.23.2025.07.30.09.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 09:03:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uh9H4-00000000SCB-0SyY;
	Wed, 30 Jul 2025 13:03:26 -0300
Date: Wed, 30 Jul 2025 13:03:26 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	aik@amd.com, lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 00/38] ARM CCA Device Assignment support
Message-ID: <20250730160326.GN26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728135216.48084-1-aneesh.kumar@kernel.org>

On Mon, Jul 28, 2025 at 07:21:37PM +0530, Aneesh Kumar K.V (Arm) wrote:
> This patch series implements support for Device Assignment in the ARM CCA
> architecture. The code changes are based on Alp12 specification published here
> [1].

Robin and I were talking about CCA and DMA here:

https://lore.kernel.org/r/6c5fb9f0-c608-4e19-8c60-5d8cef3efbdf@arm.com

What do you think about pulling some of this out and trying to
independently push a series getting the DMA API layers ready for
device assignment?

I think there will be some discussion on these points, it would be
good to get started.

Jason

