Return-Path: <linux-pci+bounces-25114-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3990A78899
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 09:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A1503B03E4
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 07:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175A023370E;
	Wed,  2 Apr 2025 07:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yWOfaga9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90710233706
	for <linux-pci@vger.kernel.org>; Wed,  2 Apr 2025 07:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743577662; cv=none; b=dQHc/Cc+LFhYXEj88jXBg/mNCw4/M8cfOXhM1rw0Ue/1FS2ljdE3I7otndst1qB0ZLcTICZ5E+pM0Wi4UxhRGU89dk2KtbXtJTRftJuKfZLUmEJPf6ZY/byx8BmhPexBX/7qQJ8JuLrDcML7V8RDbMpXcxenyTXbP7DdpB/Hkz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743577662; c=relaxed/simple;
	bh=NnWGuHjIyJg5ukrQmVNz2nsRNWILWqsyGsXJg48Opm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+BKOzUWJFRE7DIWnZ6So9wGucW2lI/wm6rJVgbcueK1Dt+bb9oz8sHkFqLVgvU22xqD/W4V6GLRb8jfR4CXKkdAwVuqFcpYCEYYAWxf0+OTCapzQfBKyD9uw45dZBVU5zoe+SFw3zDZXK9eMUY/KJXYmkt75jmjZCVsdiA/AzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yWOfaga9; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3032aa1b764so8211518a91.1
        for <linux-pci@vger.kernel.org>; Wed, 02 Apr 2025 00:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743577660; x=1744182460; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IhuADULP2/DYR+/MqPtSI6Cci67OQxTxzfXSmiaFrjc=;
        b=yWOfaga96sPMKnoUq/D32CtFrXpWQpkvt3cee+Dec1xlVgHfB684xB4BxDOQCI46ma
         jLFWnAPGLTJmcoZSpxq5XDLQRKTo1R9IkoD+o5xxFNwfMj8gAmykjrVRHQTVI8he13jz
         lAJ6GbFt0mOK/OiwnrAHqiOEQjQP/WWg+1lQEViG8TIr0d+yIq67nynxR9xQq+tLq5uF
         UjjJ0+xxWHjUqbXcpmrefZ/PDpv6kagd1ck1EoYJbW/mWxM8nHBjkJhLHtv725SJRYuc
         vBZSjRJqZjvrK/se34oZTi9BNl4V0f4FQPNK3HmZSjHvOOoC/kwP8QZQgjEVO6AVmOhx
         exvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743577660; x=1744182460;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IhuADULP2/DYR+/MqPtSI6Cci67OQxTxzfXSmiaFrjc=;
        b=qH8orOZ4P7w8sl6LVd4UX+rTFKG3NsMmK+Gb5PMoSnOsPt7hjH1NunVKp0hV2+Jmzd
         RsE//lejks2E3vdYGK/LQD6NQgvorx/Sc0844Ydo/kvG+iXLeXj/7OWaAi2JsMzMkTkO
         G3vm+mzDSNUXvZByLtQr5J2ZuCLxKrDJMnA2+cy+Yz6VDMoTUk0zoqqAbm9BA0rJvutU
         J0g4zXAESWXdEu+269CFP13ydzosvI3AI4crwLQsLF+jOc7QstZ4EwF5edwMZzGlVE1w
         XtXo9U5BGVh4Y7fgRXh0AD18bPPhl5s+bZNxOJC4/xXt06qJGIM4njtO4fLFHws49zuu
         5d0A==
X-Forwarded-Encrypted: i=1; AJvYcCWh/wrps6QZbNY9icqtan9Hx1tqGiELhCU4a6f6i8UxJ/V6q3ojGSxbxixy5JDhaNDCmuE3Rypbh7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcyCHDChm6xZ5PXK1klQZxxn517q/Iql+DFLdSEwJcz13SsPdv
	C1H//YiRPZcfnKn79z/gK9wpc4Vgaq4U7jhxsjfv8pFesfL0M0ZJ3kiaAiudNw==
X-Gm-Gg: ASbGncu4BCR3ZLdwDChLDYPOWL/L74RLe4zUQlYejwViMIhX0otYg/O8z7DMljmV7F/
	dAsrGlh8lGcIK1UJ8NtZKAUiZU0uAIOOzbEs/KPRH1XSVcT/XZANYbj+MPCsdxZ1X6r5G2KPC4r
	T+iRHyUzIzI7mEDWOXkUH/O+TtajMseIjkzKWKphE7U9bmE8t93xa7gTnVBrlwVCpxjR4+4E48c
	E3q0GxVyciZLi2GniCPGbLYx22A5+a6Fxs2a65iwMG2vxprUJ4Zsyck1FrHaSt8SljiN48FiP+G
	GBAzK3xLRtHIBodrkIaimHRnJI3peHao6iGBcYHJUr45tbLuivwrYoHlhhZgFqw3jtE=
X-Google-Smtp-Source: AGHT+IE4wHP6J9GXf8X7N3O4gyhGdGcC+e9u9+l3c8VFMifgnYsypn4gjUxr5vUgHQch7GtGcGvLkQ==
X-Received: by 2002:a17:90b:4f4b:b0:2ee:c2b5:97a0 with SMTP id 98e67ed59e1d1-3053214596cmr20228761a91.25.1743577659803;
        Wed, 02 Apr 2025 00:07:39 -0700 (PDT)
Received: from thinkpad ([120.56.205.103])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291eec71besm101393275ad.14.2025.04.02.00.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 00:07:39 -0700 (PDT)
Date: Wed, 2 Apr 2025 12:37:34 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, 
	kw@linux.com, robh@kernel.org, bhelgaas@google.com, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] PCI: imx6: Workaround i.MX95 PCIe may not exit
 L23 ready
Message-ID: <ovaomfvo7b3uxoss3tzhrkgdy6cvxi4kr2zxmqsfjxds5qfohl@t6kc4rswq6gp>
References: <20250328030213.1650990-1-hongxing.zhu@nxp.com>
 <20250328030213.1650990-4-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250328030213.1650990-4-hongxing.zhu@nxp.com>

On Fri, Mar 28, 2025 at 11:02:10AM +0800, Richard Zhu wrote:
> ERR051624: The Controller Without Vaux Cannot Exit L23 Ready Through Beacon
> or PERST# De-assertion

Is it possible to share the link to the erratum?

> 
> When the auxiliary power is not available, the controller cannot exit from
> L23 Ready with beacon or PERST# de-assertion when main power is not
> removed.
> 

I don't understand how the presence of Vaux affects the controller. Same goes
for PERST# deassertion. How does that relate to Vaux? Is this erratum for
a specific endpoint behavior?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

