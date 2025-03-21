Return-Path: <linux-pci+bounces-24344-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8914DA6BB6C
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 14:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9A2B7A3D6A
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 13:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92ABD226D07;
	Fri, 21 Mar 2025 13:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rvBHStLz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161791F8F09
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 13:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742562416; cv=none; b=pfke8Ex/tkfuS2TE2udGOCPEB4+dAkPcpAKaPRSduyIoCieFksspbQPetx/Bna2aHBmRkKfPD42MXefmHXn2eVe0efWef12L2W749m7uqloa+S5PoiQZ2VliaPDZvL9P5JjpXPtrFQvdy+3vxfucgqT8Tm/hK/II5H8h0Z+YkSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742562416; c=relaxed/simple;
	bh=N961mCDJ0wLdSjt3jDEsJ0osU/dLY7z6XBOnf3+WqMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOE496rNRuyPYl4iPHb9gSFII9MMP5WqVFVc+jn0LaVwicg0SpVTda6gB/1i2mpf39aQFKwtE/n3XTgWtyWuE+vO7I2mzOUU59LCj3ZKr25GgZnajSLH3nhoBDKRh2hu11pyE9VwJDzjvvawD8uauh2+12YgngFfrWb8bab83t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rvBHStLz; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-225a28a511eso41127605ad.1
        for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 06:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742562414; x=1743167214; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SZz5tqMQorycUyLjU9gel+R49TVR6ql3QYksmVM9sAM=;
        b=rvBHStLzZk4EqiN63IMH54BsxulK/M5o1nJXRdFxoezzXTeJ8Sb3+9N4IHvKK9TBad
         xHkY8eIOLIKr1huYMMMEKRVexGMKWe5XI/ClQhww64PQoBlu8pzS1+j3DdyTZfHyEGAx
         I0TI1VtYOhuOPITsL9SUnlFHomBtHkmQaBGckGQmLss8jOnbFk2RxkzZZbFK2UQj2IF3
         YKqNq8KzywVhj3jy2M9uV/bmlF4NhhTpKOMSxYIxzuwH+9auT/RBw0A6h7d1PcdktVrN
         bUdk4aK3oPld5FSsP6y1tu9OT1EV+oEaHrzjRvBts/HVRl4fmiQjPuuXHfdtUUPRNGQv
         P2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742562414; x=1743167214;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SZz5tqMQorycUyLjU9gel+R49TVR6ql3QYksmVM9sAM=;
        b=SkGNoO0jN3Cgm6U/l5j+DYc0vVpsx4S5Apj2f+T1QpXKN4szIlaEVic+XEdvT07vpv
         18nDQKi3zwm71Lud+DigcL2Zh5YvnZUOFxM16DHqWS9iahBXFvSyYzX7n0N3gPPN3B3M
         iSVWEGnrFXwj5NkY9u9cOV4Fftm0nFQLjhER8J5mGT11PQ8WK4JY8dwx8oox8RGg4aC9
         YtJXw60I72YaApIeXUvueLw7p5lg/eAdvi3rmbTz7wBcyib9Rin9ZTmTFqvQORKHNruX
         CTScYMOXhR4wQidM8F/ywf7yDdnpDEBA/8wPdEOXA5U8NUC0ZdVqe+qgKE6cHD8jsrYY
         ySzQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9y7JgnKaGBWSTHAK5q/T4NfWFa81iu9oWANZUKZLnpLEwtuzGL5zq3/rLmk/nAgChmFTZ8rR407Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyILVwP+bruZ28NzBZ+o8dNDmBc+BubI7/lSTAExUhhOxQlKoST
	EI1NTROzoexZHFT2MgjnptYrXHvZieJLOiQ7R4RClcbY/t10ipKAaTDJ9CD6Tg==
X-Gm-Gg: ASbGncuQeUqdcPdQypsED47zofwNguKhDGS4BipYwzN2UgOHv1JvtgZ5und1uiFTr1W
	xOsG/3IMC+XryGR9Ecr/a4yrjeMl2LKVQS4MMR82GwWwYt7YXoW4OZ2VYs/DQylQUwaX+dQzXzi
	QLgdtiRguwId5UujfImXLJnLmpmY80Pf8a81wxbeYT723HJNTd6aHCaJVIIBZILe+svZikeEI8x
	kpwOHtbgWK/iTPLSikFI9CxRUxEI/6/mDv89cF+oZUy5QzDz00HP46EZgVvjXyJkYRD8OHifsnq
	VzfzucX77uZOiFcKgj/iugutxv/2BuDYclj0lpp5SgLpD3uDWv/RcXXaFA==
X-Google-Smtp-Source: AGHT+IF8vjx1b265u8EJjsRVZDEZZx94LHHYElIFcS4N4HsB3Zg9vHVzHwt/gANp8P/yU223Q4VzVg==
X-Received: by 2002:a17:902:d4c5:b0:216:53fa:634f with SMTP id d9443c01a7336-22780e206a3mr53111775ad.48.1742562414202;
        Fri, 21 Mar 2025 06:06:54 -0700 (PDT)
Received: from thinkpad ([2409:40f4:22:5799:90ea:bfc4:b1d2:dda2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811b2b1fsm15655045ad.144.2025.03.21.06.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 06:06:53 -0700 (PDT)
Date: Fri, 21 Mar 2025 18:36:48 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, jingoohan1@gmail.com,
	thomas.richard@bootlin.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [v4 3/4] PCI: cadence: Add configuration space capability search
 API
Message-ID: <20250321130648.bnwf57qqsi7kkdby@thinkpad>
References: <20250321101710.371480-1-18255117159@163.com>
 <20250321101710.371480-4-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250321101710.371480-4-18255117159@163.com>

On Fri, Mar 21, 2025 at 06:17:09PM +0800, Hans Zhang wrote:
> Add configuration space capability search API using struct cdns_pcie*
> pointer.
> 

Please reuse the subject and description I provided in previous patch.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

