Return-Path: <linux-pci+bounces-27633-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CDCAB533B
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 12:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E21933A46A0
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 10:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4716A284B37;
	Tue, 13 May 2025 10:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KIaZlVGy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6DA1E501C
	for <linux-pci@vger.kernel.org>; Tue, 13 May 2025 10:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747133616; cv=none; b=UJ0EGwsSe2PkZ/MZiTZDVu6Am0AMO18DOjiCKQSJ5JkRR8H40435qOW06WEZ3s6QwFSDYsM0eFzf96qttjzrqSFcnpA4ZVQtRC7FwohBnflAtHbpICIfDfHndR+qpkBvsSOwOw0HMv7VlQqd0ZPlLoKWSWCsAXPDpqnNEHoDwUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747133616; c=relaxed/simple;
	bh=z1aLvvW60GQF/e5ODd16orkn/crYxMuD2y2vSiI133g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9GFOV/Xf+8M7YQUPvx6mQ2D302AtO8t7U5fjc19LRbZxPmZ2jzieaPfYHJJ9KzHwC4LU86jCbDbJ8VVuSIEj2MXmYzRCZ66DBI74hdMCrc2K8qcNOG8dYA9L8WNfBfVJSpCJuRbwuLoO7M2ZE57tDYyxi01Y4t+aJ1DZ+bELrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KIaZlVGy; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-441c99459e9so36832985e9.3
        for <linux-pci@vger.kernel.org>; Tue, 13 May 2025 03:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747133613; x=1747738413; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E5XqWRuALq+1KPuNnLLJTpIo8i27168N3j9dyvRLwpM=;
        b=KIaZlVGyBOwMIRZfwIWCoFQ3jksS3hrQ4G4CPCfIfWSEtTgjt2VaS8kele6Ov7/1lv
         mj2R+HDC04baAG5MW1TeHXI8qYzkW5OMLFUZP07wLsjpewn4KbTetq62dWuCZ5AnNGWW
         6bsiovql03dWxwwL9uKnrN8ZrGanp0BkF+T3+WNvv/P1+HEZUl2XI6FvuMeUYl9kEZSp
         b/VMgPTsDqY4y7zh68r/OhHLkjFOyg4F4uegD8dzaxSjiTGHAPmx6FXEMuOwiqPLgmve
         hvby9CDw+2arr9KTDkDjXIbBiq/568UYj2Ft5M39a807gx0N3pI3vVOwCpU0GzVRIY0M
         HXOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747133613; x=1747738413;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E5XqWRuALq+1KPuNnLLJTpIo8i27168N3j9dyvRLwpM=;
        b=wGAhTEc1RNXCmMrd4YO6ykTK6o2McPAkzpdO9J4GanTsYVIRIvJuqbmh5ZT2PpwBJb
         Z1w2cwqCHPxqEkBiqywzzfjB6mvFC3M/rLJOAiH2XgHz2mST+OJ9QrdK5+uHqyrCHC0h
         +ZCpJNA8jts44aphblS1yiDd+kDMWtgtLz8AvfoXGH3CQ/06N7iC+KRxXAH2MzYTD4UB
         UTg0rAPUro+1wryZXstWs34Kr0yP4DNOk6AlD5aFPW6KIW0XmCrOObbkB3ge+A3aNwvN
         1SU6jf+LMEus1hmLRgjNxHpfiW1xRIh2gIUSdqwUBot6KiYAMU8NDVtS+EPqK7Kml99o
         kFxA==
X-Forwarded-Encrypted: i=1; AJvYcCWNQp0oLkD64FRa8RXTgjAF/gmGiQNE4nxDxGwLJTwL0cT/heqtvwcu8cTfIa6h5MSfOF8mm6ixEMc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgnmscx2z9j4ny9zSHnqUcLAljAFzmVdKk19B6Dxem1MH23vWh
	KpsJpzxTw+u/1FrbJuKvsraeW14RQGIf5kMB6WDXWFkrtgcEoeDWvP+7HydnmA==
X-Gm-Gg: ASbGncvvSXHoDL0k3StxRgWwmnCDLcBwq6xjMKYYVZJ3PzQzcywz05/2rTPiueEAxtT
	rMdHi5FUbfPMiEzadvS0vjn4ls52TBkdr5Ziw77vnsy/ZXlG/aQzxl0bsRay1lx5wqrZz4jnFc5
	/Cw96dvEB994tL6nqBYrM4X6YJZhc1XW9ua4WgzCbOK32JUTwvfsKm/s7isTnrGhdxTQ6foYpYm
	hBSUYr5frGbskwF4f43axV/AQ8QuFVymNRKXSeXOYO4EpztRxZw6LdGjqQcJn2HuZxUUuY2LJGk
	reBsyesq5wHXNKQ0EZjI4MdWoJccKypJea17I9cPBd0YTvhzfXNhk6y2QyBIV8X+cRelGEf0P6+
	XavLhqfajncbYgQ==
X-Google-Smtp-Source: AGHT+IF4m8noQnB4eGSySi2oqV3PlKbLI8UICKwhBvvGk/TXUW4E0JigYf7vcXqZztR8zC1h2uVMZw==
X-Received: by 2002:a05:600c:34d5:b0:43c:fe5e:f040 with SMTP id 5b1f17b1804b1-442d6dd21bfmr124187975e9.23.1747133612718;
        Tue, 13 May 2025 03:53:32 -0700 (PDT)
Received: from thinkpad (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d67df5ecsm161692715e9.9.2025.05.13.03.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 03:53:32 -0700 (PDT)
Date: Tue, 13 May 2025 11:53:29 +0100
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Krishna chaitanya chundru <quic_krichai@quicinc.com>, Wilfred Mallawa <wilfred.mallawa@wdc.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Hans Zhang <18255117159@163.com>, 
	Laszlo Fiat <laszlo.fiat@proton.me>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 0/4] PCI: dwc: Link Up IRQ fixes
Message-ID: <7zcrjlv5aobb22q5tyexca236gnly6aqhmidx6yri6j7wowteh@mylkqbwehak7>
References: <20250506073934.433176-6-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250506073934.433176-6-cassel@kernel.org>

On Tue, May 06, 2025 at 09:39:35AM +0200, Niklas Cassel wrote:
> Hello there,
> 
> Commit 8d3bf19f1b58 ("PCI: dwc: Don't wait for link up if driver can detect
> Link Up event") added support for DWC to not wait for link up before
> enumerating the bus. However, we cannot simply enumerate the bus after
> receiving a Link Up IRQ, we still need to wait PCIE_T_RRS_READY_MS time
> to allow a device to become ready after deasserting PERST. To avoid
> bringing back an conditional delay during probe, perform the wait in the
> threaded IRQ handler instead.
> 

This wait time is a grey area in the spec tbh. If the Readiness Notification
(RN) is not supported, then the spec suggests waiting 1s for the device to
become 'configuration ready'. That's why we have the 1s delay in dwc driver.

Also, it has the below in r6.0, sec 6.6.1:

```
* On the completion of Link Training (entering the DL_Active state, see §
Section 3.2 ), a component must be able to receive and process TLPs and DLLPs.
* Following exit from a Conventional Reset of a device, within 1.0 s the device
must be able to receive a Configuration Request and return a Successful
Completion if the Request is valid. This period is independent of how quickly
Link training completes. If Readiness Notifications mechanisms are used (see
§ Section 6.22 .), this period may be shorter.
```

As per the first note, once link training is completed, the device should be
ready to accept configuration requests from the host. So no delay should be
required.

But the second note says that the 1s delay is independent of how quickly the
link training completes. This essentially contradicts with the above point.

So I think it is not required to add delay after completing the LTSSM, unless
someone sees any issue.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

