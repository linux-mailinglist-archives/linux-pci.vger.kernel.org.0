Return-Path: <linux-pci+bounces-16137-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA8C9BEFBC
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 15:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D41B1F2170B
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 14:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0AD1D63DF;
	Wed,  6 Nov 2024 14:02:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E921898E9;
	Wed,  6 Nov 2024 14:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730901741; cv=none; b=XAVCg5ClIbLOzn/oIBpJKvd8VAkV+chGN0IEp59i3e5JjaV/cZeoy5BVSqDTz529YhO+NX2Ie60yS9cpprGR06b7Yk3UtJ7AzpJFDRF+/dpIiLBjZqkCOXTTK3r8bLMCpaYO1qJ3yWrTnGPVfiGzXE3OJad7hn8axrdIr1k0tcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730901741; c=relaxed/simple;
	bh=rxaw42WPUXxSwJnlFpumlGYhLFrkBeFmnvZdppt+3Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nn3JbrjJcAdHsaqfHtsNDRffdAsNCyKw7sjVtP/+UBX0cnUOywP7RMcB5QwAMpALYcQvy0FWhLSBf48v3jHJQhvKNU1yG1QrraS8wZq/N4pWlexlJBNmjxcSGHVgahikxHmwgTmD8cVoGZPqudDPkSzcv1ybTIJtFlPaBLyqvIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20e6981ca77so70054305ad.2;
        Wed, 06 Nov 2024 06:02:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730901739; x=1731506539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNTsaYFvcdTX0Wb0OiiTSdCFogGY84Psmg3dgcA2ZBU=;
        b=XZ5a2zJetVHxK/s5f3sILRb7U/nEgF524zIAPa0NRoEF37B+fgfR74XUxuUEQuny2/
         oMTrmw/boDtKIYf469bKqJg/aVFNgvRIni2GSN0+5dA0hM8IjJ1Xl+DWENVOXiuIgPsj
         iskz3Xxza9/Z4mJ1jD0G1AtNbHMlq7UZ37JSjmoZV6XnKvFcLKCIs3RurkO6hKtwGkjj
         585GL2/5SUgEgbb0Sg+WmiAMQZgvk1hdBD745yTDxaDtzotYKzNlnB/LTElHLnuu0UHB
         9sMEa4L4snGIW0CXC0oFdj4m7x4d+NvfoRacDhzrL/JK8uAHxISTkXW2IB6YqnS6MtgW
         EMOA==
X-Forwarded-Encrypted: i=1; AJvYcCWW/aZPILDI5qHORV7EpiWjolmzgr94yQYv6RHGyTq7QwQTZlN8hGax62hNCoHSbgGKYKv67bJtXyb47Lo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu7kvpYweEHkj9ny1BEMDADrP38KIKENDBDDnxq5d4NsPMp+tl
	dbVg0vaLLeBaC8m8lsZ70nWP8fSgQYVV4CKyhgp2TBAbhMZ1O9xu
X-Google-Smtp-Source: AGHT+IG0KnpOVHJ6+FPyEIHnirGzIJjQbRttLyC4hJlcGX6Aev5lMijV1T5yRMGkqHzmL80DPHdBew==
X-Received: by 2002:a17:903:2286:b0:20c:5fd7:d71 with SMTP id d9443c01a7336-21103ace2aemr335361755ad.22.1730901739340;
        Wed, 06 Nov 2024 06:02:19 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056ef5f6sm96699695ad.8.2024.11.06.06.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 06:02:18 -0800 (PST)
Date: Wed, 6 Nov 2024 23:02:17 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pci@vger.kernel.org, ryder.lee@mediatek.com,
	jianjun.wang@mediatek.com, lpieralisi@kernel.org, robh@kernel.org,
	bhelgaas@google.com, matthias.bgg@gmail.com,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
	fshao@chromium.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v4 2/2] PCI: mediatek-gen3: Add support for restricting
 link width
Message-ID: <20241106140217.GA2745640@rocinante>
References: <20241104114935.172908-1-angelogioacchino.delregno@collabora.com>
 <20241104114935.172908-3-angelogioacchino.delregno@collabora.com>
 <20241104132046.GA2504924@rocinante>
 <e2e41af9-ed09-4ac5-9481-e605d1340b3d@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2e41af9-ed09-4ac5-9481-e605d1340b3d@collabora.com>

Hello,

> > Does this make sense here?  Thoughts?
[...]
> There's a problem here: this property has to be optional - and if you change that
> to return like that, you're breaking compatibility with older device trees, which
> are not specifying any "num-lanes" property.

Makes sense.  I will keep your version.  Thank you!

	Krzysztof

