Return-Path: <linux-pci+bounces-18950-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 636E19FAA1C
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 07:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3404164F09
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 06:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFA7156C6A;
	Mon, 23 Dec 2024 06:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V0DecFj6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FA52F3E
	for <linux-pci@vger.kernel.org>; Mon, 23 Dec 2024 06:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734933654; cv=none; b=XiuhiFYH3gxVKV7IDQ1RFaKcjZX9mIip0r+yd7QsxDIEk0Z/725Q9fqBZ6eknnv1fvpUwUo63x/lnnVfz4c3HoNUsV3xRC8wGrgc2v7Nz9XOPEm52Z/CnBWCdztec89LT1myPy3VJX9VPoF57VFRcBeJHQeeD1dKg/6E6mNR8QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734933654; c=relaxed/simple;
	bh=O9amh1hKvcjOZVuMgnOIhs8mEea8gctL4Tmi6vxEoHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhX3ILu61hrLaoFc/bwVCs3487Ku5tyLlJc2maZJTDvRIQ2MHsoq6/N/C0OqlVu7b80/y7G2mUfjQAJ5yina22OEH7uJA/kfwjjxpEJW1ke2Cj5Btckc7lnY/WuLbVdTE9sdy7cXuQ3pgjoBaePA/rrTq/Jn58SIh4VsM9sCyvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V0DecFj6; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-728f1e66418so3090383b3a.2
        for <linux-pci@vger.kernel.org>; Sun, 22 Dec 2024 22:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734933651; x=1735538451; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZKcQgz1pvN7VtoXag8ASypTXkQf62mHyYLX2dWorKN0=;
        b=V0DecFj6ZE1mYS4vso2ARAS5bLijdYbQhQiEy9RM3VipBNPR9oKPCfl1O3p4DxhUQL
         E614thFgNsiRYGQBFTCQslRzaXedlnl75CDcbk2Mh2iByGwQApy46PW49Wo9qN+93YfQ
         t00ip1ADSTwevzYxfz/peoPZJYeF+hjvXEpmVLCrNRx+JeRHkDb1T72Opn5mQMy6hCeD
         4l1QEgUfCQQZCP1kEqqPCWOJI/ZobvQOfY3LXFKyxNQbS1hQCelCiapye9Y98XTTy/fl
         3W2lcDU/U4tVpzfUp4AWYUkW6YaM7rRKIXZoWUoL08c9GM1bfERUqtcHrWJ9+Gwg7oAp
         O76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734933651; x=1735538451;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKcQgz1pvN7VtoXag8ASypTXkQf62mHyYLX2dWorKN0=;
        b=LNUCiL1ZJprJve7VWA1Mci4pPHkerIzYDA10Yn8MRCZWw5ME+i++lRgUb4GgEKmBlj
         WPJrAs0/0MZywC0IL/8+yynOvoDeksxc7Dk43dTOoYVOoHjbBBG4q7WA/JUgle6BZDrc
         E6WqB4A5sHOjUwbZ+ABZZ4wk+iNRerDy95NvdczVgWnxQMJNP39oOZgMDUuUc6iHW1WL
         SeF5XAG9GS224eoQcaCsh1p78k2QFWc3wfL8cjqxdHElvbt0KM21AZ43Mqo5d2/wM8wS
         Z39RjBXCQZJCWN+mM6nGPef7dGtl3o8wjIQz7fRa+Bk91AQTa9/X04vWVANQU/urSYgN
         hl2A==
X-Forwarded-Encrypted: i=1; AJvYcCXsOMvYfiPFjlS0TLgyiLELSe0ZHs31iwQhs+x0O74MSd/JllTZMM6U/VFZ0u6muRBatq/EYsI1yrU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw92RqlzTA5X3KosJppK+wlPH76CHDSkHOHsBr8pX3l2yG2uMk3
	qClRJhMU0/MUQSmN1hlxB+MdCkOte5NEvkmcPGoxMoskQsnoovVNH1VZrkXNlg==
X-Gm-Gg: ASbGncvtBnWWZGCBVM2uqw3uZ9Ovn5Pa5VJ7LvcnD9KSZChApGde664gNgPEFeuxwhc
	IKWMI+HuRQwm0kJEMK5AFqzv5wkSxyXVAOmSuis1FqnswWyUHDmC5qIGnQKEaEKeI0Kv0WyAArJ
	j+acdjeKY5zdxxgndH/YiMu2Vuo4KpRiNWPSrLupllU84WQl5V20+rasLIrg44VVzLF/t1gqE8Z
	lblTObnKoaGrLsxFyPp9Fqmst+ZVUetfzaZ2W6wenvFhcls+Q3hyLFFubWil9k3AxPtZg==
X-Google-Smtp-Source: AGHT+IERaNb+diJOrMJS3kJCheBXP7A+vgDiiATXj9Yhh4r5dUjBeEQNITExnSiIEs5tsr6QTyh1dg==
X-Received: by 2002:a05:6a00:410a:b0:725:df1a:273 with SMTP id d2e1a72fcca58-72abdedde94mr17676087b3a.26.1734933650659;
        Sun, 22 Dec 2024 22:00:50 -0800 (PST)
Received: from thinkpad ([220.158.156.175])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8dbbebsm7056173b3a.114.2024.12.22.22.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2024 22:00:50 -0800 (PST)
Date: Mon, 23 Dec 2024 11:30:44 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Rob Herring <robh@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: mediatek-gen3: Enable async probe by default
Message-ID: <20241223060044.4dux3xym7gjyd3pl@thinkpad>
References: <20241220145205.1.Ibf2563896c3b1fc133bb46d3fc96ad0041763922@changeid>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241220145205.1.Ibf2563896c3b1fc133bb46d3fc96ad0041763922@changeid>

On Fri, Dec 20, 2024 at 02:52:05PM -0800, Douglas Anderson wrote:
> Like other PCIe drivers, the mediatek-gen3 driver has a fairly slow
> probe. Turn on async probe since there's no reason to block the rest
> of the system.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> 
>  drivers/pci/controller/pcie-mediatek-gen3.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index be52e3a123ab..49512786d5e4 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -1301,6 +1301,7 @@ static struct platform_driver mtk_pcie_driver = {
>  		.name = "mtk-pcie-gen3",
>  		.of_match_table = mtk_pcie_of_match,
>  		.pm = &mtk_pcie_pm_ops,
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>  	},
>  };
>  
> -- 
> 2.47.1.613.gc27f4b7a9f-goog
> 

-- 
மணிவண்ணன் சதாசிவம்

