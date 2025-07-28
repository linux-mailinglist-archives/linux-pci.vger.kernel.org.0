Return-Path: <linux-pci+bounces-33073-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFC0B13CC5
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 16:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDD324E3C9D
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 14:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE78C26F443;
	Mon, 28 Jul 2025 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="U70SHfsp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE5126E179
	for <linux-pci@vger.kernel.org>; Mon, 28 Jul 2025 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753711830; cv=none; b=gtx8D/Mb5g05K8oLkL4PgUztFcwzqXnIvSiuFpNI5qF+S6/6Jc0eAa9LpzK3Byc8EQ3NC0AHZEEDbPlYEzooVhRBX3ISe44vn32xIBG2rulLG5i7pUIhzKEXntMURF+ZbqyAM4+6aoaNeChCBvnzDEccVPVr73VudQsE8LoPcFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753711830; c=relaxed/simple;
	bh=I9ZeIDzhsLC+Rw6BB2ZpsuLCUCI15ECbtPmeNUTuSxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXNQUQZARz+rVpK5/R1+ZrAm2FMtoOtYnVPD5fNDt4cRChnZ9BkKVD6LuzhREkTT6rsbXBlux9oOlkNTKgo6Fmh+/U0w+1Plk4cCHamKe9+bmdka1WTQGDctYn6BnlWb3in/8XUJ8XQXKcRX7OGhwolJ8wzrJDymJ27RurOYX+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=U70SHfsp; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7e32c5a174cso405775085a.1
        for <linux-pci@vger.kernel.org>; Mon, 28 Jul 2025 07:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1753711828; x=1754316628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+eqiZhyg+ZCBOtjufQJyy2X2RHAGHLhNx9NLb+2h7ug=;
        b=U70SHfsphcpkruUSqVSMksVKeHdqxCAPC4Ho1iOgUMBrD+lRcdYNMI6FQXeZpU+pl8
         nTiCsAjxH7z4XuRtcx3xkyB7EzmbaDhZLhsW1rpDPUimcM/v16BPgyqlpSRnInQRSxdZ
         zDXwOweDBJJmxY6jnFA/wy6xxJ7OYJ/cUr32W6C1y1D4dSAEJCg3jOmqHhvEQhbOw7Eu
         kUQGe5laXS/2MEEBRWbhlUREEdWyyT6L1SrmjPJiLaXBhYtDQUOpGfMASIRUD//HApx+
         acBQBaQidkPaTAiRQl6XmprhaaCIxNOBw8yDdyfk+bmS3ALuvr2KJp9Lu71w9I07Xw5H
         TgCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753711828; x=1754316628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+eqiZhyg+ZCBOtjufQJyy2X2RHAGHLhNx9NLb+2h7ug=;
        b=eVeF6gzrNAPAeU3eq2kAna1qq1irgKikqjZvPBdYei5YjexKri42EmM7kRqWpbDK/B
         xTAsEam/5+X3pvCUto0alqdDyQTpsm40aZdnqlts+JpgEmD/25K8zy14SBvDs49L4lft
         +uSrg8cab1sAZzeqU2pyk3cePa5axKcEGiv4ZDLcB4IOXgXVbeYCq2bnmqhQrj288zPn
         h89tQRx5i7vFSOvDdrBaty37MPgSzXv/btUAjrHdV+Pr3WRfz8tbXYzbQ6+LLRwCHdIR
         +as6f1HWSD/TBPbEqV8mLfrDqFpA4ZFfnVfB7Y+kI5ChDD8Fu9P8Y5eMOZp46sRCpBCx
         lJAA==
X-Forwarded-Encrypted: i=1; AJvYcCXztCclcUvAQjlmUddrojjHQdOlDyk4LFZbHjulxKRMCVGDk6PDvgaB97T6HLp0XvcYif5YTzZlKtA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxco6A/6J6W+QsqWspVMykxYAdyhOu5IkEaxK3csf8dEJ/hfGBQ
	AsnAe0Ys1RbkOYn9vzUqzoPc0kOz8aCqb50TcHvzg08bTy95hpXZHrAD9hfgQxbrUfxJPoAhuo+
	vzAsm
X-Gm-Gg: ASbGncszNjTrVZcmb+IcSmzdX+NZlERKxTzHRQtSQ/rn6YI8+syZIStoYl2czwy+S+c
	6YR5w0AX3mKNsBhdMnCdmB2QlytK2Kr15pp8fn8VvpvfEFVMyJGITkM9jCWouw+/ov7MdYZKnXc
	b63yNpCq771PQWK0N8+qcQ2xfmrwmmD6en8crfbgoTNVTaNYM58IteQtBPmrHeeq6e7azEla2v6
	h4n5mnvvgWmyUF0e7AMqIp3jZH0IN5OkhyPFij1okL80RRn2s+jikmHjHkfNFKGY4fdmoZ9X7lu
	M0d6aM1x//LSXXYdHqxRdKeQapAJ8PGQUwpvZpEdmYqgd31Kj371GWdwB1UbQW4+zf+61BAuTVM
	MNmVFsn4LV70sTX8acWqCofxSAF9CfvImipzrXHUL43Hnx04tQI/4i7/J4qArFkFn2e5b
X-Google-Smtp-Source: AGHT+IG4AMn3fFLDW2xb11IBx2YQ2BaQYNWmVWPx/pnTmFR/H2yiwHIFP+BF1HqcDvdzFfnmN7sa7w==
X-Received: by 2002:a05:620a:2a11:b0:7e6:3c25:b69b with SMTP id af79cd13be357-7e63c25b6bbmr1410127285a.13.1753711827688;
        Mon, 28 Jul 2025 07:10:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e64327b33csm296288885a.3.2025.07.28.07.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 07:10:27 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ugOYc-00000000AQN-25tk;
	Mon, 28 Jul 2025 11:10:26 -0300
Date: Mon, 28 Jul 2025 11:10:26 -0300
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
Subject: Re: [RFC PATCH v1 07/38] iommufd/viommu: Add support to associate
 viommu with kvm instance
Message-ID: <20250728141026.GB26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-8-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728135216.48084-8-aneesh.kumar@kernel.org>

On Mon, Jul 28, 2025 at 07:21:44PM +0530, Aneesh Kumar K.V (Arm) wrote:

> +#if IS_ENABLED(CONFIG_KVM)
> +#include <linux/kvm_host.h>
> +
> +static int viommu_get_kvm(struct iommufd_viommu *viommu, int kvm_vm_fd)
> +{
> +	int rc = -EBADF;
> +	struct file *filp;
> +
> +	filp = fget(kvm_vm_fd);
> +
> +	if (!file_is_kvm(filp))
> +		goto err_out;
> +
> +	/* hold the kvm reference via file descriptor */
> +	viommu->kvm_filp = filp;
> +	return 0;
> +err_out:
> +	viommu->kvm_filp = NULL;
> +	fput(filp);
> +	return rc;
> +}
> +
> +static void viommu_put_kvm(struct iommufd_viommu *viommu)
> +{
> +	fput(viommu->kvm_filp);
> +	viommu->kvm_filp = NULL;
> +}
> +#endif

Missing stub functions for !CONFIG_KVM?

Looks like an OK design otherwise

> @@ -1057,6 +1068,7 @@ struct iommu_viommu_alloc {
>  	__u32 data_len;
>  	__u32 __reserved;
>  	__aligned_u64 data_uptr;
> +	__u32 kvm_vm_fd;

fds are __s32, they are signed numbers.

Jason

