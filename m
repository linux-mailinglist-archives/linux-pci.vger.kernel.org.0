Return-Path: <linux-pci+bounces-16692-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 068799C7D1D
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 21:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36D2CB22F9E
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 20:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACE92071EF;
	Wed, 13 Nov 2024 20:48:10 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34552206E93;
	Wed, 13 Nov 2024 20:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731530890; cv=none; b=Gp/lGGIFDBtohDxWzEFdISZZZSIZPKY8u0llxlpbAQeNI4uApY6ZVSEhAjRAhL8W1vz4ZFLl1zLwaLdnjaRGselyaGKVFIKnhA9W8SuNODXYzodgQ/ihH/dmO4HhfJbMQc+EZ277Xbqk4e6prD4bPwLrwYJ8UyWA7udyZlXOZU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731530890; c=relaxed/simple;
	bh=t9LFE6gGSsWCAXWlakpDOe/+qgFxvm1pqlkkHoevah4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIQ95vXHbWwtq549i2AQMahpNLxtKX8wTdXuQO4Lj0HCvPIwWJ43X1UXL7MIS9fHt/Qq6P91e2U1CRH9ayEsgtlFt5uEo6Tq2DIjVKkIC8Em8LwqMTkkdPmLcV1FhyKomsWHtTQaC+xmSGEpjC0BC67PHxK6zXUXSvlAwMuEhjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20c7ee8fe6bso73291405ad.2;
        Wed, 13 Nov 2024 12:48:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731530888; x=1732135688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFZ6aVrJwPr/r54Pxj5f9+WKsNsiZPlSqhmF8MVtdF8=;
        b=vFGPdj2JCH3sF3lvU87dy6ScztFnxTh1G3QlMlUBOuIXZDQW4HRVNqbVi7rHvFvjpq
         Om4UrO8oDCuFy4mtE44D1hN179uHTYCYayVYojWLqg3yWhFUocw3CW6uO5KLgHI6gZAq
         e2xHnJx4Cj84PNAWFUNTQHctwu1MAughp5NLCM/wL4nCwnyEj6B8igZNMITRtkxcY9HY
         fzcS0fZQTe3WSudu6DPhnUXawcdhtWwHePTdWGVLVJOtb8rT5oZKYap+8llQyqXgZX74
         bGtP2tnot4r89G1pY+oBemdqY+8so4Xrd06m3/fsUAHNu4V199MJ9iPjNutC4EG2p2zF
         dBDw==
X-Forwarded-Encrypted: i=1; AJvYcCWee4kldX09JM7rS8/4zwHXcl6vTFKpszLu+7YSHe+sHuu4BXD7ZkSi78M3ZB0I2BrgvmvRtAHvv7js@vger.kernel.org, AJvYcCX+uKfLLsA6zd+BcRlLN/omWIA7Eb0McqfH1bTywU2FqS9p7tZFvlBJD3atzMxS/WUb52niH3jh0Lm462I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrKcPbp2RU2wG7dC5r44FTLTbh3Ae7Q4DdFAIzbLlSBPitwyyc
	BdWjoJhZDnYxTaLiO33o85njDT0kM3SjvoU+3dP37H+0VBJ6pYNd
X-Google-Smtp-Source: AGHT+IE4SFFdqE7quzIP53a7Z4Xh58mjz9HcfQ2pKKg18djVUPRipg0e38rwM3+8OCOS+krPJ/cQ1Q==
X-Received: by 2002:a17:902:d2c3:b0:20c:3d9e:5f2b with SMTP id d9443c01a7336-21183e709bfmr244382675ad.57.1731530888399;
        Wed, 13 Nov 2024 12:48:08 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e458b2sm114028355ad.167.2024.11.13.12.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 12:48:07 -0800 (PST)
Date: Thu, 14 Nov 2024 05:48:06 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Bartosz Wawrzyniak <bwawrzyn@cisco.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	xe-linux-external@cisco.com, Daniel Walker <danielwa@cisco.com>,
	Bartosz Stania <sbartosz@cisco.com>
Subject: Re: [PATCH] PCI: cadence: Lower severity of message when phy-names
 property is absent in DTS
Message-ID: <20241113204806.GB1138879@rocinante>
References: <20241018113045.2050295-1-bwawrzyn@cisco.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018113045.2050295-1-bwawrzyn@cisco.com>

Hello,

> The phy-names property is optional, so the message indicating its absence
> during the probe should be of 'info' severity rather than 'error' severity.

Applied to controller/cadence, thank you!

[01/01] PCI: cadence: Lower severity of message when phy-names property is absent in DTS
        https://git.kernel.org/pci/pci/c/e3e309b2bea8

	Krzysztof

