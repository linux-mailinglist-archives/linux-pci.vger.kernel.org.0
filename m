Return-Path: <linux-pci+bounces-22806-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8467A4D417
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 07:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCFF7162B74
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 06:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212071F4735;
	Tue,  4 Mar 2025 06:50:06 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A54C13C67C;
	Tue,  4 Mar 2025 06:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741071006; cv=none; b=svUy4UO3WnFb/CbYOJ+7GGbLBXcAnfWJD7jJqTplMEnAF37wtXt4URoq+w9PBn/no7Ty8WW7gnONpI+8DmZ+QWXvUTtB/h6VB4dKf31epkqYD7mISJhoncZkLO8jt7kXcsoIsvl+8oKfXjnhEo3af8EDSXzmnqdiVMYMPqIxlbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741071006; c=relaxed/simple;
	bh=xKkQdbXWEuT09IaRYhW1OQKL5RSJXdUnAd1yXKspPdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AbS7iQtsbCkOiG7zLD+QBagmE6Q5WH1fL+jnV6WnjASwdf2qGdax0IeSeU1F2HCkuXUEvfu5GJaHM2zdP5E7oK/bgpEJrxe7nLK/zJIArhFOKBQ5byuLYx6IcDIQ0ba/xFAupAgfZRcF8IOI+yQgHBWGnO0ReKXlEE/1ItSWNbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22355618fd9so89754665ad.3;
        Mon, 03 Mar 2025 22:50:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741071004; x=1741675804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wdiYB6hv/Q3Efvv78nZapqYNYn3PY60w2vwZzb6NEH4=;
        b=j+HQ9POuA7SNB6pcvSuH37F32ewhyhqHBro+VQ01ujrKbkc95ZycV/iTwmv3muKpQV
         w14YoIFdJbrPeGZrKeq4Qaz6ptHjor7JV+JI0UnEay5J+O30ra+kCsrwyPa2wPcwJXvI
         RM5tKZ5GPqBHZsxYLlPoUhUibL2cqDtbJJt+QN6/rq+7AXhQJkpJMCgeaeQJ4+SZksph
         FFFbe4apdFtsuAPy70Qanp9obK2r0CiU/8cd3jVp+XVQ30PcJgCYNIGHRLt7M/gbMuj6
         ecT4RwvVGbOevXBGQvwwK8QSWuUJNd8BamC6mb52RpGnvt2rw2TVFng+CQAwMXAfJf57
         3dWg==
X-Forwarded-Encrypted: i=1; AJvYcCXHMjCil5r+eAbxiCiMtTf8UuD5fMyg8mVafNQsEUsS6pHZoo71mwCfir9k5OUrXpIjPYMStgDZZhw=@vger.kernel.org, AJvYcCXNmt63B9bnLxjU6CGb0gjNhz+Fx4Guk9vHn7c4IDw9GgJxPZRIGy5lUDyS1/Au1oh9fTa42oQ2hYRybWql5/tBgg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2u7FA4zjM/52gavp7s2MFNp35PqgW+33FGy75QsRJgn1Ubnct
	PSCigWW308iDK20ficT9nRpuHxwtqdPRWY5hyEjjjlMBibZiMSktxS0q2eBcrmA=
X-Gm-Gg: ASbGncupyqa9DXHQTqhJvGkbSiCxXrMolb/cHjJbkLmHUOmgbfpXqeZQ1N8jiVUu/JA
	ZyX//8UkXV37fcJRD+Cts6HLdpeTkk6rWuuEQ8oLgEzPUISW8tOhIc6Ki7+pvjcl60JkFEUc3aJ
	NxN/Ut6QYaUGe+6r/ujH5y69DJVcgGHWg528QD7OPlmHQQa1GV99CU/qJuNn3MUwBq6Xd/CHjvv
	NCRk/td5eWRapIRcngOfGMPMQi1zG6eLkrL4wTIPneyUmyD0xcwj3H0E9ddT/nsAGrDxRvExZoE
	nyE2daBzvsPYfVT6TToCdKSJ2wyoI51MTzixin9CTzs7pnNoMMpF2T+568oWz0AZ+Bgd8hwCq7F
	Wu6s=
X-Google-Smtp-Source: AGHT+IGcV4aYk/OpEVH73Ug+c1C0USAo6FdZmKpOcH30W1Dx1DXHv8XdmGwDQ56GkfHpVhuZmtZPUA==
X-Received: by 2002:a17:902:ea0c:b0:21f:136a:a374 with SMTP id d9443c01a7336-22369268794mr260988655ad.43.1741071003728;
        Mon, 03 Mar 2025 22:50:03 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-223501f9dc2sm87929895ad.61.2025.03.03.22.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 22:50:03 -0800 (PST)
Date: Tue, 4 Mar 2025 15:50:00 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, manivannan.sadhasivam@linaro.org,
	lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	jingoohan1@gmail.com, Jonathan.Cameron@huawei.com,
	fan.ni@samsung.com, nifan.cxl@gmail.com, a.manzanares@samsung.com,
	pankaj.dubey@samsung.com, cassel@kernel.org, 18255117159@163.com,
	xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	will@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH v7 4/5] Add debugfs based error injection support in DWC
Message-ID: <20250304065000.GB2615015@rocinante>
References: <20250221131548.59616-1-shradha.t@samsung.com>
 <CGME20250221132039epcas5p31913eab0acec1eb5e7874897a084c725@epcas5p3.samsung.com>
 <20250221131548.59616-5-shradha.t@samsung.com>
 <20250303095200.GB1065658@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303095200.GB1065658@rocinante>

Hello,

[...]
> > +		29) Generates duplicate TLPs - duplicate_dllp
> > +		30) Generates Nullified TLPs - nullified_tlp
> 
> Would the above field called "duplicate_dllp" for duplicate TLPs be
> a potential typo?  Perhaps this should be called "duplicate_tlp"?
> 
> I wanted to make sure we have the correct field name.

Fan or Shradha, any thoughts on this?

Would the problem be with the name of the property of the description?

Thank you!

	Krzysztof

