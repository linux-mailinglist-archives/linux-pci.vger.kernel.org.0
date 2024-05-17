Return-Path: <linux-pci+bounces-7606-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC9F8C8544
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 13:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 079F11C20C2C
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 11:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9463B78B;
	Fri, 17 May 2024 11:08:59 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AAD45007;
	Fri, 17 May 2024 11:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715944139; cv=none; b=PR0zRy5sCOEu2o3THVrVFmePNbO9clFT5/MvIvNNea3ffFFUXeQiy8H9n6/qza1jiHcBzlcgWMNnEUEVdPu1Rjdn6xhrw19BilCjGkYFfxpsrmkEwBOPuQbJoo/TrVaFtaOMqE46Bhs6QeBZ506EM826KzNDUGrdM86++Wr2Uj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715944139; c=relaxed/simple;
	bh=p6dfWuB4Whcj4xr75oZDNBWAzo6Em8ZoqSFzP5xF2y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rEe7ftw4c8apPwGz8ZXpCWj4M/n4kqAO+p2RBzon2Oe6HQ+Xd2vOcau76ldlQ0j1RHM6yfJ3VxAG4dLwVg4NpZSWYAeODCd7d/KeOoEc55Vyvcd2WPn7mTx1M4gq92dpV37PE13Lxl7Qrkw+oJn2YnOaj75+deoRUODNn6fG1oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6f4603237e0so32756b3a.0;
        Fri, 17 May 2024 04:08:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715944137; x=1716548937;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yht2LD80B28pJAQ4A9hUxuWsUKcbjheod3UZATHiu0E=;
        b=BQr0xqWu3ACndc5h/OlLFp4FrmofVVbDBkRUgwfnGtx3Mx8YMKX4ySNXakqpiFviPQ
         tbB3d+EuJkQXKlN4l3cERD90Hoiu2MKI6d3Z36YoAsj4oZjJ3T9r8VT1SKQtFgvhBC9s
         CGqwYIKNmo+I+ODizytVRUIdAjXgG6JVdXyXH+rXxEbuuZoNCu3NUzYJ/hVMcFecpGQc
         +hNc6wppWVUQSDtQ3PN2DqpnJskshM6oVreyzju2N8rVPXihQlHzXRKSZMoLCG80Gzt0
         tsNAghJPBpT1we+G0S/l6udWzI/lTNfpgq+Nw4y65eXhUeasS3gAka80+pa6ad3T7qF4
         Q6Zw==
X-Forwarded-Encrypted: i=1; AJvYcCVD8Y+qLPYw3td/vfTWLMrWEf23qoWS6i3YQIfPAN0catWz8ItInbnHyO2mukOgaN9sI6+W5GooY3InbNs3olp6B7WszkXrS4qVArVVla62mwBXmD/pxLh6a5qoMKKmJ8VxxL9Uu4YfbP7IF/TzqaQRQmH9t5sD+KSkwebTGNhH0scll92kezGO
X-Gm-Message-State: AOJu0YzYP8r0NCqXUB5yIYtkD/ZOsR7ctR47UUnQGyGppx8bIofp9R4T
	N6VpZJol0dv3tkZ6nyBmJIRIbexPmc+ajD/IW4KxwFVOfl2kG2DQK98lA9s2
X-Google-Smtp-Source: AGHT+IH+JTp6X4RZaUBISbRbfWD5tivOAWaQzIS4kHHzjX3fhR3zBIPTeH70nbLIGb+mbT98Di+vBA==
X-Received: by 2002:a05:6a00:23d3:b0:6ea:ed87:1348 with SMTP id d2e1a72fcca58-6f4df435c31mr31860502b3a.13.1715944137135;
        Fri, 17 May 2024 04:08:57 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a83d3dsm14567847b3a.65.2024.05.17.04.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 04:08:56 -0700 (PDT)
Date: Fri, 17 May 2024 20:08:54 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: Remove some unused fields in struct
 pci_epf_group
Message-ID: <20240517110854.GN202520@rocinante>
References: <6507d44b6c60a19af35a605e2d58050be8872ab6.1712341008.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6507d44b6c60a19af35a605e2d58050be8872ab6.1712341008.git.christophe.jaillet@wanadoo.fr>

Hello,

> In "struct pci_epf_group", the 'type_group' field is unused.
> 
> This was added, but already unused, by commit 70b3740f2c19 ("PCI: endpoint:
> Automatically create a function specific attributes group")
> 
> Remove it.
> 
> Found with cppcheck, unusedStructMember.

Applied to endpoint, thank you!

[1/1] PCI: endpoint: Remove unused field in struct pci_epf_group
      https://git.kernel.org/pci/pci/c/ddc66cc4e695

	Krzysztof

