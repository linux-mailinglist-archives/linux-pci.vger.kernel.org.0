Return-Path: <linux-pci+bounces-12567-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B18C99678C8
	for <lists+linux-pci@lfdr.de>; Sun,  1 Sep 2024 18:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EBE228147C
	for <lists+linux-pci@lfdr.de>; Sun,  1 Sep 2024 16:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D5817E8EA;
	Sun,  1 Sep 2024 16:35:36 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CED31C68C;
	Sun,  1 Sep 2024 16:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725208535; cv=none; b=iviyQC2xqq1O5i7p45MlQBkfOiJUJsGh9Yx1jPkfZFl5GoIm+GnFHKe9GTDsRlYLCn35HRuLDgrVrPIQDfj08+JU+WpvpczHBK6GdPw4xjrymDJMgRhjpIlOIIRaLiDP4ybEgvLd4HOwhIYXtXMOEgnPhXekDflrdS/rbaGH3VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725208535; c=relaxed/simple;
	bh=cFygrlWX03Fc7DzVN3oG5eavHuzgxg1G8IXpcreIfBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YqNIB6nFZnjzyUOFMTYQc6zkCC3MqWLuCAgz5Cx3UTOckHTLoe5UyGiXDveqkDhSBdeGmyxTXlZIneEVmFC1wTKWgeopNow4OTlXcUa2lSLgmVTIv3skgizzX90EBmrqyPiH3HeSw5twTxzDwzTrVdjsR9FGIVVwiTHXuw2vBrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-39f540795afso3131945ab.0;
        Sun, 01 Sep 2024 09:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725208534; x=1725813334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTp58pLZILxilG/TSa0eywC/sXEwB1GPNx1xi4fjUmY=;
        b=KDUjc16YFHLjP4CL8z+RAKAt4vFK4RV95MN92axUj2fbWYe5cQZWkJgMi65gNZX9IO
         WhD9kq6fnoU4R3CchFytI9GicknppL+nL4cI53DNqJ+PjdBh11TeiS9LitrKrZ1m+0Ph
         xn/rJ4gkdKvqzYOi2KlshfQoiaCUmZjWFKYwT5jFS1hjNjL+/i9vSxC6+ObaQWGYf/Xt
         xUEp4fDcSzodVZAxeS4LJkzMAgssTKt05mxq/Oeuv5LYu7dLd+hrGXVzpL65TqFbFtmQ
         b5tbq3jWQtISslJ7ourzVe9dB0I5Z4rcfAbabT9DRqXlemI1bQD9R/WlA3eFJ9orkRBx
         t+pg==
X-Forwarded-Encrypted: i=1; AJvYcCUIP9xY/GP46QI/pq0YH5KYb6DtZlAT63w2nMn7VzQcmVTVjcXrYDMnd80h42fpAtLuVzVBCx4HSq+x4NBL@vger.kernel.org, AJvYcCWxbD80pBgM4fJPNo7NnVZ3j21oRI4w0rdZ3NhrnlAhE4iy7xpNaol8OdOHfurLRLOPTJfvgFPDc+E7@vger.kernel.org, AJvYcCXKTL4NWrxeEy0Xb9jyl+mK5iaoyLbKchHIalk1Komn4wThslsFn/1bmkJOVzdpp0+9wRKTyUOyA5EVv137@vger.kernel.org
X-Gm-Message-State: AOJu0YyW4tEYIPIeJaC3byivL5nPbIYw6xsJQ93Jg3jF7W98O4E+ZAzX
	L/iSvtWcn/UKncwz6A0Oq1VOOf6kO9D3SJbVVPwSyyQi3Ydcq+/P
X-Google-Smtp-Source: AGHT+IFoet5rnPXX7B0j81TfVz2mWqg2c16lfk/eZkL4ZNZx2r0KXkRL12ZSh1RoMgblFhdyL+yP4w==
X-Received: by 2002:a05:6e02:1a81:b0:39d:4cef:7958 with SMTP id e9e14a558f8ab-39f4f566f82mr63387375ab.24.1725208533596;
        Sun, 01 Sep 2024 09:35:33 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e742c8asm6092743a12.9.2024.09.01.09.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 09:35:33 -0700 (PDT)
Date: Mon, 2 Sep 2024 01:35:31 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom-ep: Move controller cleanups to
 qcom_pcie_perst_deassert()
Message-ID: <20240901163531.GC235729@rocinante>
References: <20240729122245.33410-1-manivannan.sadhasivam@linaro.org>
 <20240813202837.GE1922056@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813202837.GE1922056@rocinante>

Hello,

[...]
> Applied to controller/qcom, thank you!

Based on the conversation here, I removed this patch from the branch.

	Krzysztof

