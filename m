Return-Path: <linux-pci+bounces-18941-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 586489FA835
	for <lists+linux-pci@lfdr.de>; Sun, 22 Dec 2024 21:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC9647A0593
	for <lists+linux-pci@lfdr.de>; Sun, 22 Dec 2024 20:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8B118A6D4;
	Sun, 22 Dec 2024 20:58:59 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8935B18870B
	for <linux-pci@vger.kernel.org>; Sun, 22 Dec 2024 20:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734901139; cv=none; b=csani52S8H/aDEKLvhi3KyJalXTlfh1CekHgxsgABt0dH6NoqZhzkAgXcXxoB6MS+9G6s29dwXXqUlBylcWQRR7Bjlft3UCCw9aiKXsk+5v/NbotWNlpEHXVMjMhOOSVB4mFA8mHCHdia5GycLQWaq3BQsu/N0xpIA7dzB6VBWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734901139; c=relaxed/simple;
	bh=QZrdi+2LHGiJfls3Hz7INCOQvn0C+QFV4ZK0ijCIwx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qF4zi6Rq6zFlqpizt7XssJrHX6qOJRYzgldZ9YNz7LOZ6UaitNIAX3XQy9zS9Bio2IXvuKIpgxyBbAZaXpQK4e2SRgoLfCAmxnQdIlNy7uCZrdsV/gmZEJHJDizXy/eGVCcmzFYZ1zZLV2E02zjWHnMLCDgvwaPVBqkGzVQG/M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2156e078563so30952285ad.2
        for <linux-pci@vger.kernel.org>; Sun, 22 Dec 2024 12:58:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734901137; x=1735505937;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lCvNysGXsppCB+xCq1UV9ou0iywkWDgVvZtuRJui+ns=;
        b=lTykVRHxT+NjrmEFQNycGEIetPuNnproDZrndQNL5IOrM0kY5yTtrDE0FJp9uDejoU
         KjTuN6NJAwjdn25p4yRijRQC9R7mmSJDW+IuIRtkzgMy2m4oHpCDCWO3IlmdeirpBvDg
         s6QbZm9qg7W2xiSqHzrq9xFQJS86C0od2H/7401E32Pw4z+urgW1czndZkDjPIQLuRNy
         Qiajrq8XAqlH572PoqJxqjd3X5jwJVgyTvEcLwTFv5t3e40rpgTQbJOJpF4DvLtMb34M
         LRKwr+ve044dGzTtDoKDCuoweN02mWLzejDY0afJMDVmcyWjqyb0zQV07xyFmgTTxDgB
         JMXw==
X-Forwarded-Encrypted: i=1; AJvYcCXy6DZzELkLfaRc4NHANdegIGfUC9ltayyj0czkIBIPrVJML6T2qWeyHh36RFdCVoqoQnJsVS+/i00=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUQ00w9xVvMjgg8kq0K2pwGg89AclPdJaUQ1SVkHwJYQKrCv/I
	9j3sMQ79KopmAYz7RaObgVqzkhPfc6f33VFJL/yfa1sTDk7SZoxx
X-Gm-Gg: ASbGncstxIab1DWmmMqElnrIrIleNsymmN7Z3sVDvpn+WDYE99JgEnlcax0MHBq+mrG
	m1jBE7yo11YvEdMiMwx4EJn3z0RkGLvoqC0syoVxy3U54Z7weJ9p/DuBNN5JBB2RExh9tCmDWP7
	n5Fx6gMPMA+7doS+yrt89TU5QbcN10b78/OUasjsTB5wi8QICaoJXEwHZwXwapPwD/n1wUPZRUv
	YrfQNZXCZQIsyvz9T+BiIPTAQYEQuUzNDG/bsilDp8kmI4C3Rx0Qxli+aVIQYgGDH7hqPNExMMr
	JvK38SbgH/o8mP4=
X-Google-Smtp-Source: AGHT+IFt3T8YAjr86BwDUWu60nhq4YEYfolG7TN4RHU2UPn6OdAJtEhF2mRNAaR47jXgJbU6gTBCWA==
X-Received: by 2002:a17:902:e846:b0:20c:fb47:5c1c with SMTP id d9443c01a7336-219e6e9a438mr135835695ad.14.1734901136701;
        Sun, 22 Dec 2024 12:58:56 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9d97casm60372085ad.138.2024.12.22.12.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2024 12:58:56 -0800 (PST)
Date: Mon, 23 Dec 2024 05:58:54 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v3 0/2] PCI endpoint test: Add support for capabilities
Message-ID: <20241222205854.GB3111282@rocinante>
References: <20241203063851.695733-4-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203063851.695733-4-cassel@kernel.org>

Hello,

> The pci-epf-test driver recently moved to the pci_epc_mem_map() API.
> This API call handle unaligned addresses seamlessly, if the EPC driver
> being used has implemented the .align_addr callback.
> 
> This means that pci-epf-test no longer need any special padding to the
> buffers that is allocated on the host side. (This was only done in order
> to satisfy the EPC's alignment requirements.)
> 
> In fact, to test that the pci_epc_mem_map() API is working as intended,
> it is important that the host side does not only provide buffers that
> are nicely aligned.
> 
> However, since not all EPC drivers have implemented the .align_addr
> callback, add support for capabilities in pci-epf-test, and if the
> EPC driver implements the .align_addr callback, set a new
> CAP_UNALIGNED_ACCESS capability. If CAP_UNALIGNED_ACCESS is set, do not
> allocate overly sized buffers on the host side.
> 
> For EPC drivers that have not implemented the .align_addr callback, this
> series will not introduce any functional changes.

Applied to endpoint, thank you!

[01/02] PCI: endpoint: pci-epf-test: Add support for capabilities
        https://git.kernel.org/pci/pci/c/15c4281440a5
[02/02] misc: pci_endpoint_test: Add support for capabilities
        https://git.kernel.org/pci/pci/c/a00ac0bc28ed

	Krzysztof

