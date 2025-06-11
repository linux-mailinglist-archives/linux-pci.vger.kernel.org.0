Return-Path: <linux-pci+bounces-29391-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FCCAD49DD
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 06:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1324C3A69CB
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 03:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9741C75E2;
	Wed, 11 Jun 2025 03:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AluZbev8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9170C8FE;
	Wed, 11 Jun 2025 03:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749614399; cv=none; b=oInLwA4/Hn4MHNHXYMElENngffNy2B1CemH2LW2uXeTx4NyWF+satmMk1LvZLHvA4yPCwSCs6OomXg+njyfhSJDD4zUI4CXFlRf2Lb2/QC7Ce0WUg33lZYiLo/ShwJ2W9lA4+hFsOKSFDRfSy7oYkHYH1tBHu1EjR/R+upls5Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749614399; c=relaxed/simple;
	bh=6Bv1xt+Ulsxs3ZANi+lB4WzocuIuNfvDq3Y/oLo/j/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPEJk88d0K4n00K5iA9ZJ42mAazhmElXPy3RGG04xuBJCWe9GLZOEVliYs2HWZAfzzvod+g4fU0wVLjhWxFb4VFMNoAG/uvVnkRYH5CMSDZTcq5CCxnXFoCg+1CladGgZGo7d4QQP1nHYL7dT6emIWTDmdnyn+Ge8UMTcL+iOrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AluZbev8; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5311cfb975aso311959e0c.1;
        Tue, 10 Jun 2025 20:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749614396; x=1750219196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pj6z2aRKvHtITq4Z+f1qO93pmK8lNGG0j4aMXrIWEqE=;
        b=AluZbev8p6LHon9Qi8g0JjsjoqMaio4KkXWWEOvLm+3dPNmNNDIDXXbrYVtRkMlSlI
         6eovcKpfloO/PZX6jvC7TJ+4Tb3YXUBpqOwLEtiBVfdlu6qAxOrcssDnTCuJFXs+ZSrC
         9hBlMhw25gxTpZYN0U17tlFADOdxfA+VffGsx3j5wiquURSKDFuRb+a60JDi+4ju3Kt9
         5TiafS5iPCe/GaRNWthVof8zHht76GMuOS0431JFazLjwGdMA1Gm7YZjfhYjHSK+BIIa
         a2KiMqZ3HSaXxZoRC2K0uYMa15inEfr2cq+SSN9jy7KHMxHtTsgIhaj+tjXGHEs7/QMe
         pufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749614396; x=1750219196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pj6z2aRKvHtITq4Z+f1qO93pmK8lNGG0j4aMXrIWEqE=;
        b=X/qghanupnh5YQFNMQBzRKC60w65zmAXqBsg56RVYHeDT/ccAQZJTC4al058FJUSJe
         lo6SrX9juEzJclTFPubamy83OsCib22xEkxA+8NuLyL4Q69/dbfoK/D7kEknun2suLiJ
         orMJY+kqWOdevDkK/7g/4/Cfg9rZbVL/KLMMGUy8LYSzpys+S4BqsGv+RcRzsZo2RV9C
         Lk98thJy8zSaqDxm/QhBCqE4F5T9F8urkayBgqG3wf0ruKLkuJXEKTaneAmPfk1F4Rqb
         5pUz7rtKERplnM88hdEjr2edZhBgRbqZJQpk0d+jjb6jeRddvhR4uTQWHa95rGpF2xWw
         6iAA==
X-Forwarded-Encrypted: i=1; AJvYcCV1veIsgzOZIYqfSJL6QiLttJKJFD+YQzwqKVS3WumeT0Z/uqPYrKagfjfds++n72Az87bZKmWuoROc6gg=@vger.kernel.org, AJvYcCVi/lus0nmY2/LuZYDzhQW0l0cdUegaiPuuF/a85qzLd/Om8li+oHJ0D8oxiURXZ3MC8ar07B5JLkzH@vger.kernel.org
X-Gm-Message-State: AOJu0YxmAkyvo6gT9e36XstEBy225u0OsspojkdG3wyeXjeAoPivdi/F
	6mALoSGTTqyTprjb6pWkvplUSI4f1VpKXFVp3aEdh8aSFDRwsoCaGXoL
X-Gm-Gg: ASbGnct2WW9s+pTkdzWJofwd6ZXT+P4x+9Obrzuv1rULD83kUiJhB9pjnbYGxbuqyMu
	enUSzai8jJWLAGwQcq4SZFPVyVvSHM572orlnqUUYfZ7wVVL6q+inLCmwz2miM7XjZ6Piw2TGRx
	3mJaz5G5ooxY3U+sP9p2wEjkD9QfbUxbKpuDFomClRv/ZSqd+29s/Kki5vJLge9LITYTUk3Rs4D
	Wbnu6ElpDY/z5OxvKsjR8O6rHzlbs8Qb/PFXR777IHw/SfXKTVXrXZBZMCpLMma8t9FjP3ZOwhg
	5qtD8qiz6idVGzq/1HlpOLGVqLj7IDGeeONUPajrYa+RGDgHDgT7kp+ih/V5
X-Google-Smtp-Source: AGHT+IGUDa7JtBq2dvoPFRpR8Ucsyx6ySznxILJ7IulGOvVCBM169/ICR1GV4mTL56zEZimS2JYQug==
X-Received: by 2002:a05:6122:119c:b0:52d:cc6f:81a2 with SMTP id 71dfb90a1353d-53121e8cdeamr1223105e0c.6.1749614396582;
        Tue, 10 Jun 2025 20:59:56 -0700 (PDT)
Received: from geday ([2804:7f2:800b:5f6a::dead:c001])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53113c0ee7fsm2411261e0c.41.2025.06.10.20.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 20:59:55 -0700 (PDT)
Date: Wed, 11 Jun 2025 00:59:48 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/4] PCI: pcie-rockchip: add bits for Target Link
 Speed in LCS_2
Message-ID: <aEj_NDgaFJT-oceR@geday>
References: <aEQb5kEOCJNQJMin@geday>
 <20250610200744.GA820589@bhelgaas>
 <aEj7-6fMGKSXQb3J@geday>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEj7-6fMGKSXQb3J@geday>

On Wed, Jun 11, 2025 at 12:46:10AM -0300, Geraldo Nascimento wrote:
> Hi again Bjorn,
> 
> Your message reminded me of something that may be important.
> 
> During my debugging I had the mild impression L0s capability is not
> being cleared from Link Capabilities Register in the presence of
> "aspm-no-l0s" DT property.
> 
> I can't confirm it right now but I might revisit this later on. From
> what I've seen it can only be cleared from inside the port init
> in pcie-rockchip.c and does nothing in present form.
> 
> Not a clear, confirmable report but something to watch out for...

Not correct. ASPM bit for L0s is being properly cleared according
to my printk's.

Should have checked before creating noise. Sorry.
Geraldo Nascimento

> 
> Regards,
> Geraldo Nascimento

