Return-Path: <linux-pci+bounces-25129-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE37A7894A
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 09:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56BE27A19D6
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 07:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49543233728;
	Wed,  2 Apr 2025 07:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t4hzO+GY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A750A232373
	for <linux-pci@vger.kernel.org>; Wed,  2 Apr 2025 07:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743580673; cv=none; b=tKDelleBw7RUvCeNm++qgY0wmmYm1dChbUIvqgbvK4UnF9FHrWoOnd9/ovjDCBjEls0Edexl82e0pPUZBY+oLTbNHoUa5dWpnBBsWkAyaBKWzBeqOIESgA3eyJOihCGjtdCtAVPumnw4QesrFWHA3obar1mYirsypfltK7i7ew8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743580673; c=relaxed/simple;
	bh=R8qBaOqxCr4dyXpWM04sX/GCqchZ6RKNVr5LsTtixVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHpDTQ6Ouq+FLDo0XPoA+Ve9Jf8c78l5lpSBSk2WRSqKA7H8feGn237E9USGt4QvSoQs6f3/fqtoK9e94ib3STyFq4ecuH6TMzG4e+67+tUjOdzgUBx+cvVyV0hingD5hAAus2OpbPJpE9nfWNFRkqfzklSVoRR9GfSKL4sNCPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t4hzO+GY; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-224171d6826so104009925ad.3
        for <linux-pci@vger.kernel.org>; Wed, 02 Apr 2025 00:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743580671; x=1744185471; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dRSyCnFP0grZIfNQwckuEKAPhgRGKFDaBXM6ybS+yQY=;
        b=t4hzO+GYXoh0PpTM8q8nImq9wzJoofnjFSnBjfABxN0E/paZ0WUUxTzzRXyxqooWLr
         11Y6kyVU6iRt+/zIVbHrwqE2gWH0JrGeQQYRHS8hQQ+lLCt8HUKWDA285n0IaTBAJJsR
         4OCaAKbqB1Kozkxl+C+k8OlsnKhkSr5Y3a3wJOImrcnhjZ8o5HdfMPWR3CoLKX0h2svr
         2zXaP4OPfM93GQAetiwoWcQouXyPtLqdjNVfyu1ZQdCEq/S/w5DO9GmqZpgP9jlIGU/c
         HCGkD4W4dzmgE1xgzjg0qY4B/C1mC576Y92wptYNCk6vTED0ytfOhi27BQ0L5djVbogF
         L2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743580671; x=1744185471;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dRSyCnFP0grZIfNQwckuEKAPhgRGKFDaBXM6ybS+yQY=;
        b=Ev5Jim8GY8qu3rsUFw97pbFeKC6oCY/YSCZiBV8DbauTx1kIC51EUNNcEBJY7dPy7n
         sGLY2WENvfQG9V3VbCwjh29hOrV6b83o/1RmU2iqF38ekb9lmYPb4/4WvspL1O/B46Vp
         7RxQ5WYmvj/6jh6IgAQu4oRxnqcIZhz1UfqKcHzbZ7cZplv9C34J/BfOwUc/Gjbcg7cG
         XBak9u9e4Pg9QmT+rL1uroX+4vjkBSN4fQ8qNCZlE6mdQNSExR0baPh94fY3WJ5IefTo
         aeu3jpxBcxQ081mScMmN/vWMWa767kEMrIvUanaI5LxqzM+JhJxJy2QrU2TUSeY8wxab
         qCGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqpa9q6PYv8zykk8t8FVVWn6Fq89ZuYmDJp5ToPaJr4ZQhoY7VstO711Of7cz6uFEqCtyWDvF5RVY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1Zu5MXATjh9529y44jGzYx+K0NsVc7QPOkw8YnHUa2Sa+yowo
	5FDIVW1PGK7+xZpODowXb+kv4BiFeQg0hBbE0WzM9qMjl6glzl838gnhfprRnQ==
X-Gm-Gg: ASbGncv2m6grDKS91F5YhnQFH756yezU1iwBfs5Z8LbKFyySHPIEMkxW5KHE3veTNuT
	itIK+lGqM+hNu61AtQXoZtfZsm/kZMv2V2LpjU0lxPLwpo40V4W60rOZ0dh2TfooTEfv8mUIPm8
	CQfkp7eTXHc90jDrxnHZYALborRuba4p8ce8Z8PFRmsGGTc1lHqQbAofzXFm/hFge1h1r9zJpSq
	Ivf7elh5tchkaX+qOr9hdS9aj+4LNg/IhbJSJFfZgyK8JCCONPW2k1DTDNSbzKDUU5sPyTdRrfB
	gf3fPfbLm1/GzeqrWsYoAxrfb8IfE+RscGwZpPjqzra7wirhbgakvmJG
X-Google-Smtp-Source: AGHT+IEzlbEBgFvDc2I1WYI+e0N/2YEc5vy2uJFcQHdCufTOfWQZ8Vjaelsgo3YFEKjff3mKRuYO+w==
X-Received: by 2002:a17:902:f652:b0:216:3c36:69a7 with SMTP id d9443c01a7336-2292f9f7a8emr221580805ad.45.1743580670960;
        Wed, 02 Apr 2025 00:57:50 -0700 (PDT)
Received: from thinkpad ([120.56.205.103])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1dee5dsm101582755ad.189.2025.04.02.00.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 00:57:50 -0700 (PDT)
Date: Wed, 2 Apr 2025 13:27:44 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, quic_mrana@quicinc.com, quic_vbadigan@quicinc.com
Subject: Re: [PATCH v9 4/5] PCI: Add lane equalization register offsets
Message-ID: <mi7rmrbx5yjzznabjc6kpafskhmxdi4hgx6vaerxzqkp4hdixy@ky4dckgngrnd>
References: <20250328-preset_v6-v9-0-22cfa0490518@oss.qualcomm.com>
 <20250328-preset_v6-v9-4-22cfa0490518@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250328-preset_v6-v9-4-22cfa0490518@oss.qualcomm.com>

On Fri, Mar 28, 2025 at 03:58:32PM +0530, Krishna Chaitanya Chundru wrote:
> As per PCIe spec 6.0.1, add PCIe lane equalization register offset for
> data rates 8.0 GT/s, 32.0 GT/s and 64.0 GT/s.
> 
> Add macro for defining data rate 64.0 GT/s physical layer capability ID.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  include/uapi/linux/pci_regs.h | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 3445c4970e4d..0dcd9aba584d 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -749,7 +749,8 @@
>  #define PCI_EXT_CAP_ID_NPEM	0x29	/* Native PCIe Enclosure Management */
>  #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
>  #define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
> -#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_DOE
> +#define PCI_EXT_CAP_ID_PL_64GT	0x31	/* Physical Layer 64.0 GT/s */
> +#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PL_64GT
>  
>  #define PCI_EXT_CAP_DSN_SIZEOF	12
>  #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
> @@ -1140,12 +1141,21 @@
>  #define PCI_DLF_CAP		0x04	/* Capabilities Register */
>  #define  PCI_DLF_EXCHANGE_ENABLE	0x80000000  /* Data Link Feature Exchange Enable */
>  
> +/* Secondary PCIe Capability 8.0 GT/s */
> +#define PCI_SECPCI_LE_CTRL	0x0c /* Lane Equalization Control Register */
> +
>  /* Physical Layer 16.0 GT/s */
>  #define PCI_PL_16GT_LE_CTRL	0x20	/* Lane Equalization Control Register */
>  #define  PCI_PL_16GT_LE_CTRL_DSP_TX_PRESET_MASK		0x0000000F
>  #define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_MASK		0x000000F0
>  #define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_SHIFT	4
>  
> +/* Physical Layer 32.0 GT/s */
> +#define PCI_PL_32GT_LE_CTRL	0x20	/* Lane Equalization Control Register */
> +
> +/* Physical Layer 64.0 GT/s */
> +#define PCI_PL_64GT_LE_CTRL	0x20	/* Lane Equalization Control Register */
> +
>  /* Native PCIe Enclosure Management */
>  #define PCI_NPEM_CAP     0x04 /* NPEM capability register */
>  #define  PCI_NPEM_CAP_CAPABLE     0x00000001 /* NPEM Capable */
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

