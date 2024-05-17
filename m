Return-Path: <linux-pci+bounces-7636-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 224DF8C8AD3
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 19:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D23B6285ED0
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 17:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B1813DBBC;
	Fri, 17 May 2024 17:21:02 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A75813DB83;
	Fri, 17 May 2024 17:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715966462; cv=none; b=pTUrc2tWjw6tbCJVQcBGKZkLr4m1kbQbPevk9Q35HmuLTTXUe91TszNdP47zbVV9/LZFcFs3gkTFlOHP3gavdFfklToFmyboJ3zJbIskGPhmNknZLf37aw4yjZN/x6eYvQJWhbSDUqlkxEpMR5PxplNAlNlB5cp8n/T//mPSnsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715966462; c=relaxed/simple;
	bh=fMjJ5ykGwjuj+QrcfpHGXIV9gMb7nPlUVQoNTDn4zeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWo8nOV1LaqsplhFwFsiWtzjrnl3WfJ+Htmv/IxMuNd1+KDIWruFRDcPEsrW0NYce7TZol1t8wr7t80R12JmkGewe5NHKzHFsK81kyaYxXrRpkolqsn5/pAEmAV0JgkUhRMIj9k/H76EGfd/mMz+xI7oisqBkIqjkkKFbipsgTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f08442b7bcso16339295ad.1;
        Fri, 17 May 2024 10:21:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715966461; x=1716571261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hcxp65px+yMhJZwfEsL9d70Gww0JahltMqAcpNPCl20=;
        b=MTvZ8IUYbivKZCaoHp7VRyxb5NXvmGq5GPC3qPdPoYAvDHTJuo6Iso68yqnpT3Bm8Y
         p26UajLCEheb5/gOlUpvBWcv7eR1eH+cAPK9xDFu4WdtJjXJEE6xbHeviIEMnhablyYY
         /28exEV80+T27jKtwI2q7nGT6NpYNdbgOizjdGb6mi19rt5HDP+pZmuLPNLonoQcB1ip
         6yIs5kc34Cxc/P3TaXJe7/hEGBhTi2Vhl75JzkXWiljZ9OhX71Ew+JqrntTXrAYdbzwz
         Yj41R/YvHaRKk6HB+iPP9J+S7fXsPROOB01LztD+2Gs62Z8UVEfvAGFVH30JW5L1cvtF
         52Qw==
X-Forwarded-Encrypted: i=1; AJvYcCV90pV9XLAASQDd9pVeDZiNMdGjPChS5OyUHc86AMQWTPzLkNh3+/8v2ICKb0r0c6dLyra8Q88AF3qkRgzD5SMgwDMfVONhmQqU3aVcRXjJOc+y4eiV4OFMrXojoMKvXZrrNazFiN1OiBAaG5q5hUwocU5LATO0ozF1DC2RGSMIqvK9Re6Jx57OBG/3OlAyWzV/AcJISx56UuUWfHAWyRRreLg=
X-Gm-Message-State: AOJu0YxDnZn0KJV966GX5Awl4xwArNUUecOrWSprb1FUv9sr7gKOXV3N
	aB29ad8j3Jjs82M4om/ytwZzxhSRdP+RkQdAHNuEswzsLbF+tyGV
X-Google-Smtp-Source: AGHT+IHcZjQGzBsaB72mWx+DZGIw9V125r2LT1HI6JyhdqM0v7pzKz5CQXzZh5f1PtBDVk2RrEipRA==
X-Received: by 2002:a17:90a:cf90:b0:2b3:2a3b:e4a0 with SMTP id 98e67ed59e1d1-2b6ccc730f9mr21761839a91.32.1715966460782;
        Fri, 17 May 2024 10:21:00 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bc9bce16d6sm3062061a91.19.2024.05.17.10.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 10:21:00 -0700 (PDT)
Date: Sat, 18 May 2024 02:20:58 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc: andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, konrad.dybcio@linaro.org,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
	quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
	quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
	quic_schintav@quicinc.com,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 0/3] arm64: qcom: sa8775p: add cache coherency support
 for SA8775P
Message-ID: <20240517172058.GJ1947919@rocinante>
References: <1710166298-27144-1-git-send-email-quic_msarkar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1710166298-27144-1-git-send-email-quic_msarkar@quicinc.com>

Hello,

> Due to some hardware changes, SA8775P has set the NO_SNOOP attribute
> in its TLP for all the PCIe controllers. NO_SNOOP attribute when set,
> the requester is indicating that no cache coherency issues exist for
> the addressed memory on the host i.e., memory is not cached. But in
> reality, requester cannot assume this unless there is a complete
> control/visibility over the addressed memory on the host.
> 
> And worst case, if the memory is cached on the host, it may lead to
> memory corruption issues. It should be noted that the caching of memory
> on the host is not solely dependent on the NO_SNOOP attribute in TLP.
> 
> So to avoid the corruption, this patch overrides the NO_SNOOP attribute
> by setting the PCIE_PARF_NO_SNOOP_OVERIDE register. This patch is not
> needed for other upstream supported platforms since they do not set
> NO_SNOOP attribute by default.
> 
> This series is to enable cache snooping logic in both RC and EP driver
> and add the "dma-coherent" property in dtsi to support cache coherency
> in SA8775P platform.
> 
> Dependency
> ----------
> 
> Depends on:
> https://lore.kernel.org/all/1701432377-16899-1-git-send-email-quic_msarkar@quicinc.com/
> https://lore.kernel.org/all/20240306-dw-hdma-v4-4-9fed506e95be@linaro.org/ [1]

Applied to qcom, thank you!

[01/02] PCI: qcom: Override NO_SNOOP attribute for SA8775P RC
        https://git.kernel.org/pci/pci/c/a51da87be9db
[02/02] PCI: qcom-ep: Override NO_SNOOP attribute for SA8775P EP
        https://git.kernel.org/pci/pci/c/ce38ead6a0ed

	Krzysztof

