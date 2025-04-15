Return-Path: <linux-pci+bounces-25912-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AE2A8954C
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 09:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 432F2175CD4
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 07:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2189624292E;
	Tue, 15 Apr 2025 07:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g1FxBRCg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F16427A107
	for <linux-pci@vger.kernel.org>; Tue, 15 Apr 2025 07:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744702749; cv=none; b=iSi6l1n3sx3XyCoDkU9cB3T7iKLseQtFbQTRIOg9fbS7DKobQ4xpcNPOwwqYG5QkrKw+rUmMUGKha3QZDSHxIf+530gy+507uwmhswd7cDxHUgCFSqNzQH5BzREn1+8WE7+39/9gX56KG3PBQd+YDVCORF/+Y/1uj2VXdeMtpH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744702749; c=relaxed/simple;
	bh=coA5grQd3y/jbhzcHeYZ+ZELLUFIBztOc/cGelyrWGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hzndR7iQBa7O67e5H5WoVCkdMj7e4KGb99Tpf4cgyesOHOn28Hq6SBxcZXcl5a4yJe4WOCWqZP2ttzCUjNTe+mmXOerpwLLGECQoV4cDuQMcm1CZbhVLOE2FwR7zvmJtjmg2LaQ8E2QMISkWuh8VQIIFCTP9dc3Ot4BnePXjums=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g1FxBRCg; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-227b650504fso50113785ad.0
        for <linux-pci@vger.kernel.org>; Tue, 15 Apr 2025 00:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744702747; x=1745307547; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KMVqxq4kdB7NkpAdRlpNvoRHAP7rIXsRI0v6UU1I0eg=;
        b=g1FxBRCgqIYkEZToU/fBsZXyjiTvjFtxCa6X/SsPMF5Zu82At0HSbXMZVdOxyIgcFM
         rYVhtlS3js4PCzWYRVTRcPc5nWvpSd3Ncz8q6pTyVgSyQF16MXJkkaNdBod4FR0Xo6Q5
         s+Z4/zkIe1G+jDuK5gi/YzKVPxBvBT6+fhrpc3Um+S2Is/U+fMyq/MixfPSLkThCSRu1
         JRo81pfPYGA0Tg/nf9Uoy4YMbsmEHSvDchfrbPRVOyRmfWLoqz8ENPBjKgXbLrR/XxdX
         B5frW+poLxDox+NXgg+EzwFFHiGFEeKPSpxPyrs3Na5/wJyujCoVU8WCSLDLclaEk0eB
         Eb5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744702747; x=1745307547;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KMVqxq4kdB7NkpAdRlpNvoRHAP7rIXsRI0v6UU1I0eg=;
        b=VhGj3bAc1Z9Ooqe9/VXmhqEA72Lunt+BGuYwjrZADjKe6ncjUZjZC+ezhL+Un+0BLb
         OHS3IDjVzEjrJ/U6ProCzG7+h2mgSzOQMCKrrt1rzRhSx2WtWhrK2dsG475wVtLkc6KS
         cGof2umJhQK5CstX2xWLlstSD4Yz6E6TnI5cdn51q16LIqYpVXo3hAZvY+znU+iKWaxa
         KN3Qv2Cg235TS67hE5cZBQJxyfSo5g2xsIBNw/p5ysQJHBlx4DlfGVLoTLTijXTWsxQY
         GV6J5b3WygBKasG/2Ctm5gIhOVw4FpLINtbj7C/F1z14tDMY3i+FuCBUNueJUQ9/Rdv5
         4DpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcoZDKxqy3NrM7+7fLpoTh/0rxr4ThoV/mC/I6/cVHx6znMuwEyLt6GX0b41QamLnVMnPoWx1JD8M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3KkAq9KrRnK+UGHdplH+3ytkSZ348vgTOkr1NRogOmQw0k1Fy
	1zfQuryvgCPljFKJD0zeqfpdB0R7Kt0WFkENVi0Lckb/ssCdHqN7Q1ELVTdHUg==
X-Gm-Gg: ASbGncs+b2DzhEfRrINQzstdH+5fuuuVqapSzq9kHK6lAvqLyac7e4t8UJhPpq4FhbU
	ZuySCvjL/EBwczgVW6gE8NgMf+dJ/m7nt5ZlUujkbDk6kyq8R6wM8or1LY6lOUvkMov4ONB8lpf
	nj8LbWzUtqwXzWcz1xRzpqLoQ6gur8K8hvDre2DACAarn7L9sgYooaO0MW0zzhgNM39kLqljuWn
	zMBKVJzylo8zTCoZ8RGCcbKPiLXOQjXWyF1d0dl9WhH2nsop+RONluHelZUPdQqjMf7ZCuFRkVu
	ijqLRnOTeabLyn9i/YMPjEPFaopBq+RzG8PssecHh1LnhxlCoA==
X-Google-Smtp-Source: AGHT+IEHpiLa1qxpwWSUDM89uSChUDBqXG6QHK/dkH6ohvACOVduUY35hpQk6VZSxSq6hdZmbeAjVA==
X-Received: by 2002:a17:902:c952:b0:224:912:153 with SMTP id d9443c01a7336-22bea49590cmr237075775ad.5.1744702746719;
        Tue, 15 Apr 2025 00:39:06 -0700 (PDT)
Received: from thinkpad ([120.60.71.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b8b18esm111163075ad.82.2025.04.15.00.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 00:39:06 -0700 (PDT)
Date: Tue, 15 Apr 2025 13:09:00 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quic_mrana@quicinc.com, quic_vbadigan@quicinc.com, 
	quic_ramkri@quicinc.com, quic_vpernami@quicinc.com
Subject: Re: [PATCH] PCI: qcom: Implement shutdown() callback
Message-ID: <tb6kkyfgpemzacfwbg45otgcrg5ltj323y6ufjy3bw3rgri7uf@vrmmtueyg7su>
References: <20250401-shutdown-v1-1-f699859403ae@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250401-shutdown-v1-1-f699859403ae@oss.qualcomm.com>

On Tue, Apr 01, 2025 at 04:51:37PM +0530, Krishna Chaitanya Chundru wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> PCIe host controller drivers are supposed to properly remove the
> endpoint drivers and release the resources during host shutdown/reboot
> to avoid issues like smmu errors, NOC errors, etc.
> 
> So, stop and remove the root bus and its associated devices and release
> its resources during system shutdown to ensure a clean shutdown/reboot.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---

While reposting a patch, you should include what has changed in-between in the
changelog. Even if there are no changes, you should mention that and express
your intent to get this patch merged.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

