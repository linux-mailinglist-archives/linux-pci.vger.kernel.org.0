Return-Path: <linux-pci+bounces-23713-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA7AA60A31
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 08:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D269F16A5D8
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 07:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D8E185E4A;
	Fri, 14 Mar 2025 07:42:48 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30B91519B0
	for <linux-pci@vger.kernel.org>; Fri, 14 Mar 2025 07:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741938168; cv=none; b=hyUb7V5+RJ0KUbxpQTeRvy25UMWnhSd4ylIniwdoFsCfQS3kM5jePUJ/5G1X9imTfnraZRZhdskOE54QrbX72+zTN9UPD7MPDBIdDEGMuTd9i7S6fDSjAWc7SltxhoXAYJuGWnwp/EOElsArWK1kNxTXn64zKIp95XPwWfolV5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741938168; c=relaxed/simple;
	bh=GegKs5cB6rEP5RXjACoaxSKxCsPA+a5CEkUU45D6q88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LUXyxKCfANKpTmkHJV/uZ4A1spAZKaSmUMt2W4qeFyn4LF0q2Cw+9R4A+0wS5QdLr6w1GAsagC13XBMVBFLEMFMJsnkRVqU1VNATGWVvxN65MjDItnat0mn10nFnS9EIzthaMjwhjrSebJd9IxCz8YwTGXVE/ajrD46gqrUNNqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-223594b3c6dso35747065ad.2
        for <linux-pci@vger.kernel.org>; Fri, 14 Mar 2025 00:42:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741938166; x=1742542966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRgjO2BIUZBSivLl6NeuN4w5VSf79WUc7xlXdm/Meg4=;
        b=iXWWT+PQJQIDDceuRyW5PO24DwDY6BHbRR20Dp/4+1NYjoL4JTv7SwG0yJ90qhwKlJ
         tQkswA+jKOwfYqZwH4PSFUSVJgimZKHWlxiwLTlbF/VHkBt5U/W1dbQEfA3tk+Akx3km
         MQHIM5+7qjD0/LsCKNLsLkQjuNwN1nOQRUnl3K6/dg89ZkfgRmu/JhyvuH7qjT01T8qs
         Ob4abXiJcwFl3WeNRsDypO6ISPGhYHvyJY5CDfLURN7iQtt19CvMErN5gNF0L1lVLkAq
         d/FJy+5I7ZUcOetKnVOOsBvpiTYcjUPl1l8abg5sr8+eYxDm4BA94VYJrKvSgc3eaNYD
         QXDA==
X-Forwarded-Encrypted: i=1; AJvYcCVoGwsNsAuoHboEwa262QHSjnNrlCJd/kYl9pBXkLP2xQ9oZuXw8NFsE+AxFtboJAkhpUTOg2skcX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP9ceL5w/P174w8bn1mqQDKXQjTpzoj8GmrKSLvwPY2K7xQec9
	DVeZlAossTs0lV+ae3efxpaL3Z6J7vUb7EU29Tb4uxqnhkHCofks
X-Gm-Gg: ASbGncth2kMMAa6lRbEOnbwTDIJwaHDtxpWif7ZrBZF7kx4V7dKybKuhH8VaBm76Yhs
	6wxDGdGDzavsbsSG04YXkNWjGn6tyBO+fUGEhGLxwp5tEKh66VwoBX5GKBuC295YNO04pk2JRNj
	RXouYHY9yCpNx1THlv6DnTtMl0cV1hktg5YNOw0Xk1rAc/pSeydKyytZ9CNg1Tn8WT6sdQLaHur
	WdebtIywtIzvHQ8AdpUTCgwf5ipju0OSjIA4FCwMr2Amvq2ujMGIKeGgcv/JFV4smhZXfeaw4zT
	q8UsnDF9incHwz8ZgluDx9n8MZVjre1vXr44OJgb52v83VlKGH9rgsQlPhf+CZEeaFfJKWdSZ4e
	Rzp8=
X-Google-Smtp-Source: AGHT+IFMosdQqzJMfplyxY0dp1bYJt8xdM1zl0ikoM6bb9JGR8ja9dovQk0/9fXocpUpVfobamHH6w==
X-Received: by 2002:a05:6a00:4b05:b0:736:ff65:3fcc with SMTP id d2e1a72fcca58-737223ed33bmr1854674b3a.16.1741938165983;
        Fri, 14 Mar 2025 00:42:45 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-737115293f6sm2523949b3a.14.2025.03.14.00.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 00:42:45 -0700 (PDT)
Date: Fri, 14 Mar 2025 16:42:43 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: declare quirk_huawei_pcie_sva as FIXUP_HEADER
Message-ID: <20250314074243.GA234496@rocinante>
References: <20250314071058.6713-1-zhangfei.gao@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314071058.6713-1-zhangfei.gao@linaro.org>

Hello,

> "bcb81ac6ae3c iommu: Get DT/ACPI parsing into the proper probe path"
> changes arm_smmu_probe_device sequence.
> 
> From
> pci_bus_add_device(virtfn)
> -> pci_fixup_device(pci_fixup_final, dev)
> -> arm_smmu_probe_device
> 
> To
> pci_device_add(virtfn, virtfn->bus)
> -> pci_fixup_device(pci_fixup_header, dev)
> -> arm_smmu_probe_device
> 
> So declare the fixup as pci_fixup_header to take effect
> before arm_smmu_probe_device.

Applied to quirks, thank you!

	Krzysztof

