Return-Path: <linux-pci+bounces-21965-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BFFA3EC82
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 07:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19476176549
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 06:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5EF1FBC9F;
	Fri, 21 Feb 2025 06:05:29 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F93C1F7561;
	Fri, 21 Feb 2025 06:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740117929; cv=none; b=gXO8ox1m0hK7E1J29nbGVUxhFWnNWATO+eGZkFz40DBGnwP7VdLAcaYFrFqEq09R+GFftFjmHSKErWPkcU8oeRpzFOGR2F3M+KWFskp95F0sRSUwRoqPXLPUlVIknXbPBL+g4oLGL/y1SRJDQ6U2lck5q2yxKZlLINEiBkg3Dsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740117929; c=relaxed/simple;
	bh=iapny+DICfxkuP2xrLzKx2ZNOS7arlU/6EskcKL+UPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BsOUX2LjMbXCvZLOIVxnMX6VVQcaE933GSVFqbQuP4UhjtegAa7vc+xJzDMxgUSfxgSO2fkaub5Syg3I7QgZWwdHO8js55eHHykOkcMwcYDcH0zWdSACVHjXHKw9O8Xh4rCY4OwcEs0SebJ1clNkg7/2huxBXQPrKMtAnRPaFfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21f2339dcfdso30534115ad.1;
        Thu, 20 Feb 2025 22:05:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740117927; x=1740722727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbKqhD/TtkBjNOkbjBJzYaQIabf25yHhmzgDtWdw50g=;
        b=gVuNEGBtAsuBLrpTmLZ7Bl5VHJzrIKxorVy8YYgfccSal+TtkVB8h8p0oy6DuhAbs2
         5DAedguW+kyaMuF180pjsPdiUXqQ855vYIImOiRKvzsZPNyLaXC3vAwEKHVV+tWhGL10
         1quDE31OU6RkN1dox8ISi0w2YrVPCjvR3vOvSpzKafqY0zJ+uZMB4JfL3GUrnScYeJyM
         YFkwJdRdEfKN9ASq+lwhuATM9q/FzH21s9mCbmN4bdRUuHLQx7Q7lJbCHfDdctRtWfUa
         c4DCiocbCdrQtjEpOcG+S9mBDyX88Fv8RM/w3HYWueNPcVd5UVOYJgvP6ORHleauFJGm
         jIRw==
X-Forwarded-Encrypted: i=1; AJvYcCU0lRaCpTzhUYaERgq9xXVygjsfjNEs41cQ7au1AbK1XGQvWTc/tlAdGoV9Avx1VCdCjIu7vaQxMbgz@vger.kernel.org, AJvYcCUSVxh/08zmcsLtr63qrRgYG4gVKb3TbP/3xXl5fI1Z0xpFLUyIn02iNEMMHM7WAIYtd22tMrEMHhC3oFsJ@vger.kernel.org, AJvYcCWjtxKUZUfuznoUbawS7O9w+fvkcrVAdM6kT65hqHEQcuFKahhHro3jJZH11s13d90yBzi5V+pjsTRXo/4V@vger.kernel.org
X-Gm-Message-State: AOJu0Yysa46tNEnN4GopRXvdpbAvOdEIbAsSNl/cfWhSrFDFRthtHTMi
	iY/UkOdLNcS+EPSRcEqtQ5dxZgL9hbXPja+RecbZAIFVsOwec+NG
X-Gm-Gg: ASbGnctmY7IT4pViCOg/6KLwoIZkTLXhMbYEvZ2E4BC7Jy0siwpVqMONcvEPyeMyjFB
	gu94nnDs6NJEKa5ZaBoD56s0/aE/TVEi8UqzRkA+jpLnmWEqNvdoWfe862ANtlrIHUSDg1xNgxA
	vSsHU0Pasg2luD4sOy0MucqJ5NQq4hL/PQRNs/x2nNtZ2qtwY5pH+QhoO0WupsG8/ZcsOSqHJ1k
	sxZWVLqF3MPmFq1HA2SImgeDcY0Gdkmws/q/cVNkdrD9lOhTBolVg/+qPQ9wcKav4bDVhx7Qups
	Q/nGIpzhXUO05XP22B5E6qWqjQlq1xwUVjrXIwl3lIzozGp2uNz2O4WucYiW
X-Google-Smtp-Source: AGHT+IFYL+UM5bLfryPJyWCRV7+vSZj4kkwUOAfJ9P+FhLEIS4Uiy1EC9ZLdem8DWs9oatRIJcNkuQ==
X-Received: by 2002:a17:902:c94d:b0:220:fbde:5d70 with SMTP id d9443c01a7336-2218c7637a0mr101240735ad.21.1740117927239;
        Thu, 20 Feb 2025 22:05:27 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d5364589sm129639515ad.84.2025.02.20.22.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 22:05:25 -0800 (PST)
Date: Fri, 21 Feb 2025 15:05:22 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc: manivannan.sadhasivam@linaro.org, quic_shazhuss@quicinc.com,
	quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
	quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
	quic_nitegupt@quicinc.com,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Slark Xiao <slark_xiao@163.com>, Qiang Yu <quic_qianyu@quicinc.com>,
	Mank Wang <mank.wang@netprisma.us>,
	Johan Hovold <johan+linaro@kernel.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Fabio Porcedda <fabio.porcedda@gmail.com>, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 0/2] pci_generic: Add supoprt for SA8775P target
Message-ID: <20250221060522.GB1376787@rocinante>
References: <20241205065422.2515086-1-quic_msarkar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205065422.2515086-1-quic_msarkar@quicinc.com>

Hello,

> This patch series add separate MHI host configuration to enable
> only IP_SW channel for SA8775P target.
> 
> And also update the proper device id for SA8775P endpoint.

Applied to epf-mhi, thank you!

	Krzysztof

