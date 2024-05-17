Return-Path: <linux-pci+bounces-7605-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E11308C853A
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 13:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BDC52829C6
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 11:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8DE3B1AE;
	Fri, 17 May 2024 11:06:43 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2489D3BB20;
	Fri, 17 May 2024 11:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715944003; cv=none; b=TaKy0S6jQntza95fYCaGHK6RZRxAQYoOS2zfWUc4qDNBb5Rcay/cbTkGRJU5lLNdjd7Mxkoev3uS1nTUCQmizE6DDJbj0dxmpgEVkCgghW0BBESptsFfuDxSf96N/g6PBmxNTR8DVsc/RxfUuhpHTSuC3J/F2yi98OLxDpFLCeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715944003; c=relaxed/simple;
	bh=6YKYu+nwgoHIhxuCcyfKEm/0MyLgoLFDAQc26AajwQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2V3I376Sf/h9gGx2OJebqpgbrT83nzqpIPVlGIvLpyH1zmQFkivkqCDbLguLqMGiZPGo5aEfER9d9cpNSFFvSpr0Y+EmJ3uRTX9aYylGZOf9rkpJqzG/d34yUCNe1iXq+nOm0abi01hnl7qwqMtDujxAhktf4e0bVkl/iSPG5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ec92e355bfso5152785ad.3;
        Fri, 17 May 2024 04:06:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715944001; x=1716548801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p83S38X1HgQAB74fAqntKRjS6xpoQ6Z5CQG1AzBL1YY=;
        b=i6T93F2DR7pGHiicUazUWdhTLVoCwexdqKHzhGr1PR3+ZOLWrL+loyAVXR3xbmnf5P
         AyCpF8bJezXhO3tI9f6QWvMGaPUfggrSNLlKabjYEeOY/ZcMPBz9Wjk6CYHu33x49iim
         RjP2QN3uNckOqkfI9kMrxgmK+uTeMVMMg3PFdwqJ0e3IXItwjIWcrTEJjPau4Tgstsir
         yYWShxqjmG3+/OAgpqqCzQFWpBTv4jmQNJoal9U1HjGztGzCWaeL4W1ITzsiFif8qK+j
         IwrvlamI3f8uFa+3qTe1W5aTZgI2nzyMjZ96oUmC3RJ7bHzkuciFCX1jyqAsHdvrAsCm
         j84g==
X-Forwarded-Encrypted: i=1; AJvYcCWbNaNRH06MEt0N6J1T6DGtjrOFFyY0mK4nRlQGvpx3I3QVAQiA51b4fWHZsZo4KCQVeY9pr9OJS33JPoiN6O09EuNsAgLsgxzI7G9GEeVr5t3Nl5CdMyRvVpliBZXFFDWoqBN6Cqji
X-Gm-Message-State: AOJu0Yx/C1KXD9UKFxSXU0K3wHlqNJV3t12DMt7a2prREZV/Opl+2zCt
	92mk9kpWt9M5vtt3inhBIlXixFLE6wEGYteQMv4ZFFYyY4Dn/9io
X-Google-Smtp-Source: AGHT+IEszwTbkdrCv4IxKsGy4hC7XFyuCqVlF7lLlDq2IPmKr14GiWBtDXkUNI3atfnXUf/nb6k/Qg==
X-Received: by 2002:a17:903:2d1:b0:1f2:e14b:3d91 with SMTP id d9443c01a7336-1f2e14b3fc6mr19558985ad.59.1715944001348;
        Fri, 17 May 2024 04:06:41 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f09363ac7dsm50255295ad.93.2024.05.17.04.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 04:06:40 -0700 (PDT)
Date: Fri, 17 May 2024 20:06:38 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH v2 1/2] PCI: endpoint: pci-epf-test: Make use of cached
 'epc_features' in pci_epf_test_core_init()
Message-ID: <20240517110638.GM202520@rocinante>
References: <20240418-pci-epf-test-fix-v2-0-eacd54831444@linaro.org>
 <20240418-pci-epf-test-fix-v2-1-eacd54831444@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418-pci-epf-test-fix-v2-1-eacd54831444@linaro.org>

Hello,

> Instead of getting the epc_features from pci_epc_get_features() API, use
> the cached pci_epf_test::epc_features value to avoid the NULL check. Since
> the NULL check is already performed in pci_epf_test_bind(), having one more
> check in pci_epf_test_core_init() is redundant and it is not possible to
> hit the NULL pointer dereference.
> 
> Also with commit a01e7214bef9 ("PCI: endpoint: Remove "core_init_notifier"
> flag"), 'epc_features' got dereferenced without the NULL check, leading to
> the following false positive smatch warning:
> 
> drivers/pci/endpoint/functions/pci-epf-test.c:784 pci_epf_test_core_init()
> error: we previously assumed 'epc_features' could be null (see line 747)
> 
> So let's remove the redundant NULL check and also use the epc_features::
> {msix_capable/msi_capable} flags directly to avoid local variables.

Applied to endpoint, thank you!

[01/02] PCI: endpoint: pci-epf-test: Make use of cached 'epc_features' in pci_epf_test_core_init()
        https://git.kernel.org/pci/pci/c/3acb072c2433
[02/02] PCI: endpoint: pci-epf-test: Use 'msix_capable' flag directly in pci_epf_test_alloc_space()
        https://git.kernel.org/pci/pci/c/e79d1b1eb626

	Krzysztof

