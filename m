Return-Path: <linux-pci+bounces-23001-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C95A5091E
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 19:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 093C13A3E3B
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 18:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCB719ABA3;
	Wed,  5 Mar 2025 18:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Y+QJv0BN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD6A24CEE3
	for <linux-pci@vger.kernel.org>; Wed,  5 Mar 2025 18:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198480; cv=none; b=iA0GNrs+wCm18P0EZA3nqvTGCpdIFSoqNmxIpEhwogiTDqiPUjjLozwYpqM+4o4xagwWjmK+itY3Nrml496laBqJyQqw39qpdMvuw6jlkB8N3R4r0YdzoRHVcon8ZxWrQCq+bJ+Ca4ybi4zTipaRj1UKLGygOQw81K3G0Qr39nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198480; c=relaxed/simple;
	bh=lDGktsrrvusw3EwyIKgqSW+1nB/A4uH5GaWgGqTDi+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVfXBxgrQHo6jJsvPIs2rA6+m7nwgM/mxji6/2pbD4BuMwzscHx3ZLkmE7DfBy1Ehx3KRML/mZW6oQKtQpIY4a4HCjYz7qUGIwWz9BWbh+bqTxsU2A0RVWaaf72fugmr4N67L7FZnAfTZNCsF/gHHNSICWRsqGUf67ClYuBoESg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Y+QJv0BN; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c3cf3afc2bso213348285a.0
        for <linux-pci@vger.kernel.org>; Wed, 05 Mar 2025 10:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1741198476; x=1741803276; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BM3nl1PDUv3g4PwFQ23XNaGdtMsSR0uMk4FDd4zSWU0=;
        b=Y+QJv0BNv1h50k0q6lHIhHKtGAX+jzCkhA1/+Fi0IVupW6xrJv3OUj+z42+l3i7QIu
         oaDWLn3lWMRe8hwvUtTfNmmO9msLSIN8fG4TVsbL9DhGNHfX+9MLs6+BxHXsMvOwBQ32
         88FUxHbsgqGoHXBYtg8CzakkX0IPm1PiUty6cEBOHpdshKu5FDgCcdByE5gAvvv6YJHv
         1K7LjoyXYa5Hu2uugJuoSoefYNQCZYTtkFLeHueHKm+yk64X4R43xkqy98SKUTaFCWcH
         BUGqUV1XafFjeDkinPilRsDPn5w/4zJkfMrfqv2nH5S57cg2WnTU/25CvNdEcEukPtY/
         KfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741198476; x=1741803276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BM3nl1PDUv3g4PwFQ23XNaGdtMsSR0uMk4FDd4zSWU0=;
        b=DOedr+t5ZlAjg1iqtlxeXPaN+rMxvppFHxQTj3ucGt9aDIrWDnEZ+ZSTDaiXgOYOkn
         0oTQnbCJ/XkkMfJ1xr9JxKcx45EGDc7TbiLDQ8FeDvU7xVxogZ/IkVnGVjQu4xnOYFYp
         LzARL+0H+UuUvsM68Qj08ChW40ROzSs7s/iUhrhZU1fWMbKWQVQcZuVS0AdYBNJnhxUB
         a4VXS9FIo/2LdTEpqEts3l7owtiUxD8B7myph9IYt8mjzdm5+PKdReekD+o+nzXZd/aP
         US7BgyhjDc/hkOhka87l3EyybrquKplGsjmGYPTS9bAxhbubakCCOPXukZKlF1q254QW
         aE3w==
X-Forwarded-Encrypted: i=1; AJvYcCWDquaOAAEFQYks4JldLPLLIfs9clEnJRz1YbcV8TrZ7Dazgf7Gz8hcxckQ7rxeBUTfuw3NOBNLNVY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5LoO4Q6Df1EYVbOM2LYif6KVx24rAqNuCunzrg07Eg/SSxTxT
	E57nmUFqIZRgGs5rJ+yeyUJSyxvMWeQIgJMa+9WWf4plV+F7+FHsAE9jr80FXU8=
X-Gm-Gg: ASbGncv8XYvgB07Vm0kLPYPd0qj1oVL6ifp7aQ3HwpkjGsw+rN37k0FTfC1neIFkuZu
	9VNA3WeOnwZywsnSFTnGXVILYvX9dQKXGPMs4jWO65uLi06TDKj5KxNWLiXhIlNxIPTHer0nkGU
	u6/xE2tle0FBz+/hxUev1aSIoGuqEbx3o9Ae13uO3ullMEVoWcjX1/L3vu5nQhgCqES5nJJxm8s
	JAD/CzF2YNUmxQ5CnODEJdLqxIqd+Wwmiws6r7+pm/nECqVGKofurHBzNdFsbmn1Td4eUzJmB8g
	4szyvFgKoBwkNxvaFR0=
X-Google-Smtp-Source: AGHT+IGBXOlCQEjAXivcZONN7HD211rRxB+Amwcgf4SScDXv9d/J0SEM3NN6sEdvhUlnOiPXZLnHzQ==
X-Received: by 2002:a05:620a:2b44:b0:7c3:c077:fbf2 with SMTP id af79cd13be357-7c3d8ee8505mr677678685a.45.1741198476550;
        Wed, 05 Mar 2025 10:14:36 -0800 (PST)
Received: from ziepe.ca ([130.41.10.206])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976da283sm81577696d6.111.2025.03.05.10.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 10:14:35 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tptGN-00000001U2f-0a3P;
	Wed, 05 Mar 2025 14:14:35 -0400
Date: Wed, 5 Mar 2025 14:14:35 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Stuart Yoder <stuyoder@gmail.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Charan Teja Kalla <quic_charante@quicinc.com>
Subject: Re: [PATCH v2 3/4] iommu: Keep dev->iommu state consistent
Message-ID: <20250305181435.GJ5011@ziepe.ca>
References: <cover.1740753261.git.robin.murphy@arm.com>
 <d219663a3f23001f23d520a883ac622d70b4e642.1740753261.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d219663a3f23001f23d520a883ac622d70b4e642.1740753261.git.robin.murphy@arm.com>

On Fri, Feb 28, 2025 at 03:46:32PM +0000, Robin Murphy wrote:
> @@ -127,6 +128,7 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
>  		mutex_unlock(&iommu_probe_device_lock);
>  		return 0;
>  	}
> +	dev_iommu_present = dev->iommu;

I feel like this deserves a comment..

Maybe it is:

/*
 * If of_iommu_configure is called outside the iommu probe path
 * dev->iommu should be NULL and it needs to remain as NULL
 * If it is called within the probe path then the dev->iommu
 * was setup by iommu_init_device() and must not be changed.
 */

And I think the commit message should explain what consistent
means.. AFAICT you are going for !dev->iommu means no probe has
succeed / dev->iommu means a probe is ongoing in this call chain or
it has succeeded?

Otherwise:

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

