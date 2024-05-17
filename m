Return-Path: <linux-pci+bounces-7627-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F09308C8A83
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 19:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 936301F24A4F
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 17:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A1313D8AC;
	Fri, 17 May 2024 17:06:05 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F4F12F5A3;
	Fri, 17 May 2024 17:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715965564; cv=none; b=ArWpnm6BEjGiscrpXRC0Qfp5wEFwKmEG4jzDSUrCWQCCPzont84mQ4GZqsZLjxALncgWvFsCmWbcMxSlyEwI31NxRfBhl0Y+tIMVlDc/44WK156QKBDiVkybGCo4mdB1itko3q27liJwrvsEZsl+FXSh8WjoIRRzVfi1cfcmIl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715965564; c=relaxed/simple;
	bh=K2VnhU6ogrvxD5ir1zRQbmZRUAqElyzks1ABSMOc1YY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQ9R/J7HEdOEbI5DvbCFgVVmdXRkVD+8za4hkXXHbsT+jS2y4OkXXb5cVhJqDGWccBi3OW72mMfsA9lWVubtP6Hwhq8XbVM4IFJ718wAoORCtMO5YxZhFZDl9TLt3Br8RoIp+36DP1MyM8OxO2w0UZKJBQfVEqZVySIAn2ZduaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1edfc57ac0cso14536895ad.3;
        Fri, 17 May 2024 10:06:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715965563; x=1716570363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVvDZJ25CM7AvrtcNE+5/owwmFHIQhBFnMSMaajYoM0=;
        b=o44hNWZb4EQHoUSqgryBr04p2/0V7+E/CV5+Tf52SlKFb4YHo9ZeqPgC63r9WjEmRp
         1/bweXpAKJ1b5+dKynJdRMBkQ+yNNnst8hz3qhFi0zn+FN4OrYIcLL0BrfQRUdiDzkVb
         ZGjmgTiu5NWNa09/nF5+cCcYyayd5DxSC6CtKF6zTg2MXzJlKWggbdkrpz4cPV7uakgJ
         u/tqWVxaxkeDxOoIlRGcjhztjGmKr/C5TIF2yyJaNevDqczd27Mgtp6pU2ZoBkf1H6w4
         0yXLkXXDrKghXG5RcYpkpEvLygxlivhxtZzUHft9925LYYptbtNltkLceQLR7jod6gOm
         292g==
X-Forwarded-Encrypted: i=1; AJvYcCXCXu5UtVsDhP9HY2DACYbm+nRex+Fq9tNczvzLzJF9b4VsO/9KN+LyurMVbYKTzibctHABEWVvZvh9zwOgq/8JVEzO+fcDppY0Vd07WXrzOimwQM+7nylbNdqTvaif5QJ9F4izZGIZ
X-Gm-Message-State: AOJu0YzjF3QYzFSliSJk6QbE7aVhY5/SbntUouz2mgywgg11hZSR2UrD
	eFVDW5uAaeiVXlJR1BE1LHMWXqAzWuQuhiOR8/eKGS+jTfHbSDqZ
X-Google-Smtp-Source: AGHT+IEK8B9bO3TEZTRFI9v+3r5RwehSKwtSUCcOr4yO8cMjYZ3pyVTywuq/Cic+wlByOuqmyFqfaw==
X-Received: by 2002:a17:902:c246:b0:1ea:f9b1:8b13 with SMTP id d9443c01a7336-1ef43e2322emr190094445ad.31.1715965562832;
        Fri, 17 May 2024 10:06:02 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c264479sm159001365ad.292.2024.05.17.10.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 10:06:02 -0700 (PDT)
Date: Sat, 18 May 2024 02:06:00 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH v2] PCI: dwc: Use the correct sleep function in
 wait_for_link
Message-ID: <20240517170600.GB1947919@rocinante>
References: <20240215-topic-pci_sleep-v2-1-79334884546b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215-topic-pci_sleep-v2-1-79334884546b@linaro.org>

Hello,

> According to [1], msleep should be used for large sleeps, such as the
> 100-ish ms one in this function. Comply with the guide and use it.
> 
> [1] https://www.kernel.org/doc/Documentation/timers/timers-howto.txt

Applied to controller/dwc, thank you!

[1/1] PCI: dwc: Use msleep() in dw_pcie_wait_for_link()
      https://git.kernel.org/pci/pci/c/0189ae3b7f87

	Krzysztof

