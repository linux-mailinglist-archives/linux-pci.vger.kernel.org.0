Return-Path: <linux-pci+bounces-16480-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAE89C472A
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 21:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B371A283D31
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 20:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BD91A2846;
	Mon, 11 Nov 2024 20:51:02 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D9E189BBB
	for <linux-pci@vger.kernel.org>; Mon, 11 Nov 2024 20:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731358262; cv=none; b=fY5OpLHaTPDkgLsjozShVFUfsTZEKCNuzyYapm7FJSsB16V4dO5Nnx2XL839BAxYn0PRMx/2hgQXTyvenxMf4mU+wM+BJVMQvehPU0eInrmm4KvOqbHFQi6/Yw9bXn2e0OCNG5f9FsV2OmtAhUlTyDxpuPp2bOC6ynPaudw+8GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731358262; c=relaxed/simple;
	bh=1qS9Y3CzN/LkgchqkYBxY9I0EW8oXeKIBjRV2/LNZwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/ZZjIbADdN4AyDxpFPf0WUrBrjXtDNK75zuLStVSkpPz9t1l2iCVdjv9OeSFYEd7QVjgy6a8YLAAWZkxjn6j1PLD3B6fH17Gsouz2fNrf8PA8VhdtD/yamlD84lnX/nUU2oRO/N4smnVCslz49bHqqWkDdE6XrvVvFT15X8u4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d4fd00574so2754865f8f.0
        for <linux-pci@vger.kernel.org>; Mon, 11 Nov 2024 12:51:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731358259; x=1731963059;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+5VWwbB1UtqHZQTUXJe7QozJ+gC2rLz0dXbhMGbfyYs=;
        b=YPNn5tudd6pvd9RhLMegqm3HVZbgEAs+GpLrTUBXRNsD+OW45xyMXPWugCqCZOkuGt
         X7tVutLzZG5xr4NcHJhKnqCYETPKYVm0hdD3WEo+0YiSNzCW2AqPtgJl88BjfEfE0pH3
         VmQFhVxYFtWN0I9a/wxWgaxJmdqkt2MD6DxbHitg1Pg/WyY4Crvua3dgDOG6FTfcqE5r
         PZ7QsZ+RPWoJzyOAmc0kF7Jqf/Bj2Cl7gimevW2QWKMfPK8QoJqNjPSr5adEkARoH91g
         H4BETgUZiyswXxHsWKoTGLBXdv7ghq+WSfiblbr1KYfs0fOsHyokIwDik6fsCJsiC3vM
         JqrQ==
X-Gm-Message-State: AOJu0YwO2R7soHdVLsnQjNu/2Al/7/ni3N/tm2jlCSH4TGIVTCw1XI0j
	Q4fUwrUNtfs2cJgPRNCtCpOSP0NC4rxMZncbiTSqYF9hHsyVIpJb
X-Google-Smtp-Source: AGHT+IEGCpXh/qBfE5Y+HEHxPK8jx1udkCZIqC5t+6+SKm/PJQx/XJrvN0nzk2qQs5l8DJzWyXQcmg==
X-Received: by 2002:a05:6000:1fa9:b0:374:c7cd:8818 with SMTP id ffacd0b85a97d-381f0f7f365mr12762211f8f.22.1731358258746;
        Mon, 11 Nov 2024 12:50:58 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed9ea4c5sm13967826f8f.76.2024.11.11.12.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 12:50:58 -0800 (PST)
Date: Tue, 12 Nov 2024 05:50:55 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
	Tal Gilboa <talgi@mellanox.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: Drop duplicate pcie_get_speed_cap(),
 pcie_get_width_cap() declarations
Message-ID: <20241111205055.GA2294222@rocinante>
References: <20241111203624.1817328-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241111203624.1817328-1-helgaas@kernel.org>

Hello,

> 6cf57be0f78e ("PCI: Add pcie_get_speed_cap() to find max supported link
> speed") and c70b65fb7f12 ("PCI: Add pcie_get_width_cap() to find max
> supported link width") added declarations to drivers/pci/pci.h.
> 
> 576c7218a154 ("PCI: Export pcie_get_speed_cap and pcie_get_width_cap")
> subsequently added duplicates to include/linux/pci.h.
> 
> Remove the originals from drivers/pci/pci.h.  Both interfaces are used by
> amdgpu, so they must be in include/linux/pci.h.

Acked-by: Krzysztof Wilczyński <kw@linux.com>

Thank you for the clean-up!

	Krzysztof

