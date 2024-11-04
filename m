Return-Path: <linux-pci+bounces-15972-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5839BB864
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 15:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D076D282275
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 14:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6D21BBBD7;
	Mon,  4 Nov 2024 14:59:48 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1603070805;
	Mon,  4 Nov 2024 14:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730732388; cv=none; b=muVkjs/e4Dabuo/CirQdjwJC9mReG+s7Kq05qSJCSRJXlLy44QnEU5HUyKrOw/uJFkCvdO8SBOejsxYETDyz5LcrnsEhahZjg8X/XwM1xNoVr/FiCfHpSi50muxC1StZ/3ploqrMhhDMQtaqffwDq4/QyBOnIA6v78ae5ooPaMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730732388; c=relaxed/simple;
	bh=1Sy0ZXGI8HYgecnlEyVv6+id8MQ+9YEfT6rW799nGCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9qUZ08eRvAr/z1D6ruRlY/g/1nS3TvZ4acPn505LVIeOjG7p1MGNJcg7wSEab/G3mvXZGbVPlBSatrccsUQAIrl02/1hzxWUh3sWWb7IOu7EXLH96vM5TG2eEF6moQ1M/zmYFpExU8oyQv1Yus0vTLs8DPU5I0k6EG4JIy5Hho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20c9978a221so44082265ad.1;
        Mon, 04 Nov 2024 06:59:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730732386; x=1731337186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gr0jtS7zZ2oj1cd2PLPMdaTzBHzgs6RxpDJFvPE4aGg=;
        b=EMhLtndt2kdcLVCCc9Bma0J7B/dYiHZ1tPt1coFxHxjKJy/y4a8HjVnslRalw30RWv
         PaFw/JSRo/kVI3W8r6hd/wFPBsR0q2CQLTCV94h+mfUWDCTJAxhtUbLWZ997NXSbWjHw
         AA2r/a79RtAQ9yo58JAwbtnab8qb8DgBKDH2R3tYJC1QqxsnOWsXThxQtjjZ1m3Xf3fW
         rcSc1QrJzjzCJ5YKHEPCJGR7DsAKSMp7cUzjCtg16VpN2YTNMVmV0QyRqjZGpwYe/sWC
         oY68qtGkYMv28Tr0RirPu4BQq7Ng5w0/nxifh/rapAfGwaXngKu6xNRDtF+2MJ7Uc4CA
         t08A==
X-Forwarded-Encrypted: i=1; AJvYcCUzXPErE97JKof94Xai513BSbrV3mtOkM14JrSXY90rcYWtJ2mB0gRCZEtimevs0dnmYRkgqRNnYKuK@vger.kernel.org, AJvYcCW+IRBGtEqJRed40HnOd4vN8mVp9ry6eBp0zJit6KtT8ZEqukK1x2TXq+VM303TTOvAD/qEHBKHd5ZR@vger.kernel.org, AJvYcCWHSoTos68xiTEczwQ5oYBKir4w12Jz2FW7Sjco9S5Ogls+9P/1zOiN9SRShht3MwPq8yuBiDWQxFF+lv9M@vger.kernel.org, AJvYcCWrjziTA3Wj0HLh/G6pDuZqZ5/fIJ97X7KEbGaPVpNEfSMgedntEBoVo49US1FMprH6TfGyl7YvgCZy@vger.kernel.org, AJvYcCXUAeA0Kiqj862nOvK/KYtIVk7gJo7N99z0kEUosZCY0U39RyXV/boDkHeaAVrsFg0j5u8UaXZOoPzpayjGgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRE1vqDIvt2h4H/Kc5A51E+0YA+fBNPYg/KW/wSb7ScEun/9fR
	fu1iifBhlp3xq6OrQfmZQtqzscgPLD/PglgQHOUTEdUkt0QvxyAO
X-Google-Smtp-Source: AGHT+IEKFF2pf9+qnV3p/CBnMZS90cHheh2Db5OhuRxWOHUG2HFZZI9DUAkdR6mo4gHzv+NOdNUXyw==
X-Received: by 2002:a17:902:f691:b0:20c:dbff:b9e5 with SMTP id d9443c01a7336-210c6c0e54dmr431989415ad.33.1730732386346;
        Mon, 04 Nov 2024 06:59:46 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21105715434sm61769245ad.113.2024.11.04.06.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 06:59:45 -0800 (PST)
Date: Mon, 4 Nov 2024 23:59:44 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Johan Hovold <johan@kernel.org>
Cc: Qiang Yu <quic_qianyu@quicinc.com>, manivannan.sadhasivam@linaro.org,
	vkoul@kernel.org, kishon@kernel.org, robh@kernel.org,
	andersson@kernel.org, konradybcio@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
	abel.vesa@linaro.org, quic_msarkar@quicinc.com,
	quic_devipriy@quicinc.com, dmitry.baryshkov@linaro.org,
	lpieralisi@kernel.org, neil.armstrong@linaro.org,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	johan+linaro@kernel.org
Subject: Re: [PATCH v8 4/5] PCI: qcom: Disable ASPM L0s for X1E80100
Message-ID: <20241104145944.GB3230448@rocinante>
References: <20241101030902.579789-1-quic_qianyu@quicinc.com>
 <20241101030902.579789-5-quic_qianyu@quicinc.com>
 <ZyjaPtGtRlsIO64b@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyjaPtGtRlsIO64b@hovoldconsulting.com>

Hello,

[...]
> This one should also have been marked for backporting:
> 
> Fixes: 6d0c39324c5f ("PCI: qcom: Add X1E80100 PCIe support")
> Cc: stable@vger.kernel.org	# 6.9

Added.

> Looks much better now either way:
> 
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Also added.  Thank you!

	Krzysztof

