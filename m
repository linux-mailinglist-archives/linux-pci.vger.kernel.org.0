Return-Path: <linux-pci+bounces-11659-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C50E0950DF7
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 22:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86819283E83
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 20:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1893C1A4F3A;
	Tue, 13 Aug 2024 20:30:01 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58151A4F2E;
	Tue, 13 Aug 2024 20:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723581001; cv=none; b=W1N0J5YKj4WBwo9Ri4Fb661B2TABn/QkY0L7rXnHQy2bHpNOH/7S88LY8MxlBYdqoRTGl7No86YFSGhhMHBmoPuFIziA7LfWupFZMoz25XFwDVq2gQ4CSh19U3hde4vv4WvTEH65844OLqQuEaptb/Ib68uqnJbw7q1Gyb7wBeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723581001; c=relaxed/simple;
	bh=nnCRZFhNFyJdrxn7G+FPAE1Qvrfl7PoclG9BIUzAVZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHXTL/4Lxp7LSV0IZ1Dd2he3ybDeahjNKuDqpex65sNexglzefosGFtUS5uiP/Vn6bvXubrMQE0/LehH4/kdnUpm4rSEXjIZKRvcL3C71VlI3gy0ThEzjpvjeNfGifRXgOYPLaUoVUU4uV5UXBKweT1a5QhcxwiABSskRgOwVos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fc692abba4so50634175ad.2;
        Tue, 13 Aug 2024 13:29:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723580999; x=1724185799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwmHR8v2FwUUZ/ACYRGyY1TboTT+F96kdzyjFZTBRkk=;
        b=vUuO10mF0Hl9FHWwUZKW1EYPCFd16T0KxBsAH41HLSqkjRtFgAeLv27I4pKnx2Ef1F
         7ZH07McBGhtUOUtGCXLu3NmcjjhNgZf2N1AxnWG2KXALL4+DDt4OEQ+xsjbOo9u8nYt2
         zRBAfe6KHMwK2dmrgTJm4qwbLQdh3RuKVLJHl4VshJizagvhWWrnTGrcdKsnQr3sNBso
         gxdm+Jwh8Aivtbk6rA1OaQr0K9zTYj5NRXz6jTaFMCJ0QvxRUl+yx+4q6lDpkblvztY1
         Sv7xiMrTNo9+lXIJqtHgVmuzfu9drhwcpkChjabeQltAbBdQGxOySAqEIQ3OwLsHtUMA
         UsxA==
X-Forwarded-Encrypted: i=1; AJvYcCVqp2AO5NJmtT3j72Lr8qKCQwQVoomGpxHQP1RBLYUkFzlQNEMvFNnEq32DFY4oTAWUBo5ydt6UAz5iv4RCNCpJSRDNNYSHXKblxBHwrNXNpDFbL03Mp9PWtTJ0qex5HuwR8cw3J+0g9dD/ns+JtGy3TcyUq1kEp3C4KHv4yKlAQv+pVuyBlw==
X-Gm-Message-State: AOJu0YzIvecQHtEznJ3igxEFwTxX1RLWFIEn7ZPaleErHcHPu3EbNqcX
	RwLZfjKFfY+Tojeji4HA5t4NS5NDxQI/xM9jZm5fZiTdnrFXhPNsa6+WvA==
X-Google-Smtp-Source: AGHT+IHG6PIaZKqE5JqrZrRaBOS1+lYKLuqANi2F39jHzapWkVwd86EBGc2iZrDVR7PqeiqMNZgmFA==
X-Received: by 2002:a17:903:191:b0:1f8:44f8:a364 with SMTP id d9443c01a7336-201d65201c9mr7203435ad.48.1723580998862;
        Tue, 13 Aug 2024 13:29:58 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1c430fsm17568825ad.242.2024.08.13.13.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 13:29:58 -0700 (PDT)
Date: Wed, 14 Aug 2024 05:29:56 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom-ep: Disable MHI RAM data parity error
 interrupt for SA8775P SoC
Message-ID: <20240813202956.GF1922056@rocinante>
References: <20240808063057.7394-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808063057.7394-1-manivannan.sadhasivam@linaro.org>

Hello,

> SA8775P SoC has support for the hardware parity check feature on the MHI
> RAM (entity that holds MHI registers etc...). But due to a hardware bug in
> the parity check logic, the data parity error interrupt is getting
> generated all the time when using MHI. So the hardware team has suggested
> disabling the parity check error to workaround the hardware bug.
> 
> So let's mask the parity error interrupt in PARF_INT_ALL_5_MASK register.

Applied to controller/qcom, thank you!

[1/1] PCI: qcom-ep: Disable MHI RAM data parity error interrupt for SA8775P SoC
      https://git.kernel.org/pci/pci/c/6d27436b41d4

	Krzysztof

