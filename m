Return-Path: <linux-pci+bounces-17350-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E8D9D9858
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 14:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E83C282DAF
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 13:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95EE1D2B22;
	Tue, 26 Nov 2024 13:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mK2YVYUt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408631D27BB
	for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2024 13:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732627237; cv=none; b=jazzjGdAVqbfnvVJASX652BmURLhaevM0Vd7hkvZsLrdAyVGm0hDpSMDy1lSbMEOBvTWgpNNztxvmdmh1RhdDegQEhNvEcaqben8Pn9I4byT+mzwW0wbQjwLIym0HxnlxsntzVqcNzUtrIBoAoI8zEm/ttZ4q81i+yM4gCzBc6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732627237; c=relaxed/simple;
	bh=KDm+Mq0a5lEfnpK/IGyKQJoyOpf9PXCVAPk6aBEyMRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fqqdp53HUx/6871YhP+DzruM+8nJhBgFAjbdsELuMINlrlcxIFMwpPBb/nCOTc92Fj92LxHv4CS7haXRK0lKz+c92Gfz7AEAHcfz03LE2S4J0Ci6goNA9hbOmIecJOy0dnFvdOWCIejOZPQyahfpwHMHILkklRyr3czKe4lDILs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mK2YVYUt; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7fc41dab8e3so724934a12.3
        for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2024 05:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732627235; x=1733232035; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7ZAZjsTcG8rmGX1lmOUx9+9I9EDjkqjr8nVDzMoOc8s=;
        b=mK2YVYUtB6MXCFQFDN/n/2B833x7m9XiEty3ZTbc/xeNcG8sTckXG4xqslOpoqtxfK
         7EtHp1SfWV3vemCXRseEFMQd3TURZ6JZbsR3ezlhl5W+zANaBumtDb8NGp9hHN0BDJ4G
         yIu8o/+UVmfnIbSw73bIjo2Wfwx4lVsYEW6hRzrX7DJ2e7xeayr/vRNe1Vb49YqLSJpA
         Q3Hm4mQEYVWW0D7K93WX3rc8Bz3CKjbI+252jOgrqRvxG1o7rWeR06wpxiZZFSi4PKEY
         LuNOKERp4xMYUY10DSxpmgDVLS+lrfMLQE0ZR23PKlBK5C79LgI2G2w832Zv4SnrrF1A
         EBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732627235; x=1733232035;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ZAZjsTcG8rmGX1lmOUx9+9I9EDjkqjr8nVDzMoOc8s=;
        b=ndHEA38g8BJ67pOZApwHSQDMVA5W8t9JbB8gD/HfxUc0Xr8+fDzOicRXp0JLjOSZM1
         r6EEMnvL5VWDoIIiQcEorntqKMcl0Gx0mkRSaT9Ogt20O9rvBML2iujw86xCCwQQYRd4
         z3mpoKrz7qU1erG6nV7CeTgsPcs5nSWfeYwJ3BzcqBP+K+Tc/NBo4UMofZC2yNXMRlQt
         eXkSAW+e9dQeiytoR8bdps69ClDkG5cNTR/xqo27bIwCs2NnRSNdQumcI/johlw3G/zY
         pmR+5E0a2fZf4lnNJP7wGFnlees805biLdTFCDOKWnN8KXMIQDuqaWz3LwfQy8EcrxGE
         hERg==
X-Forwarded-Encrypted: i=1; AJvYcCV/pJNVd+YfZ0BVPHY+zf1RLPcO+734aisxKwulYbdh1QhYjKsPy1uUsrXt0zNuENYsSlUSHubJ0xQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhC5CTsDuNjjtAohNr2olE5DooCaQWkebI4CNdEz9bC7jNHteE
	Uyk8sG2R9oUUXTKGs2ClDsmf+hhTrlKCb3sda7BXLKAUoKywZibGvIHtQ8lFgA==
X-Gm-Gg: ASbGncsAgxJvD0u4C9iXSTU/Mp1htCUFiPRian23Hteoa9roNwD4ReqatHxYdXa8u87
	jj6HnXgXnRfsSZAaBstZF/sIxAR3havyJji+PlKiI0Xspk5gNdvRZRAdUEO/ydF/Zj6yht7WmXt
	8xp/VCklT8D2xeLjVpz/EWtsk5YiL2ggNvLGOV5Wv1dRAK9XUoW8i7Xr1FBXdorQkq/9RIulynx
	DLMrPYRKgo3e2cr+b+tkdwoHbH0lJT06OeU6GKQbDKFJi575xaeTxOosEyu
X-Google-Smtp-Source: AGHT+IET0RgL1Oz/nFQSi7koI3C7X3ynD6Kn5BZCjzR9y5l02OedHw0Xt/TC1lpUE205Y9sZghFmkw==
X-Received: by 2002:a17:90b:3b48:b0:2ea:4c8d:c7ad with SMTP id 98e67ed59e1d1-2eb0e8854d0mr21594882a91.35.1732627235499;
        Tue, 26 Nov 2024 05:20:35 -0800 (PST)
Received: from thinkpad ([120.60.136.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eb0d048e94sm8758055a91.40.2024.11.26.05.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 05:20:35 -0800 (PST)
Date: Tue, 26 Nov 2024 18:50:20 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 0/2] PCI endpoint test: Add support for capabilities
Message-ID: <20241126132020.efpyad6ldvvwfaki@thinkpad>
References: <20241121152318.2888179-4-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241121152318.2888179-4-cassel@kernel.org>

On Thu, Nov 21, 2024 at 04:23:19PM +0100, Niklas Cassel wrote:
> Hello all,
> 
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

I don't agree with the idea of testing the endpoint internal API behavior with
the pci_endpoint_test driver. The driver is supposed to test the functionality
of the endpoint, which it already does. By adding these kind of checks, we are
just going to make the driver bloat.

I suppose if the API behavior is wrong, then it should be caught in the existing
READ/WRITE tests, no?

> However, since not all EPC drivers have implemented the .align_addr
> callback, add support for capabilities in pci-epf-test, and if the
> EPC driver implements the .align_addr callback, set a new
> CAP_UNALIGNED_ACCESS capability. If CAP_UNALIGNED_ACCESS is set, do not
> allocate overly sized buffers on the host side.
> 

This also feels wrong to me. The host driver should care about the alignment
restrictions of the endpoint and then allocate the buffers accordingly, not the
other way.

That being said, I really like to get rid of the hardcoded
'pci_endpoint_test_data::alignment' field and make the driver learn about it
dynamically. I'm just thinking out loud here.

- Mani
 
-- 
மணிவண்ணன் சதாசிவம்

