Return-Path: <linux-pci+bounces-24452-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C83A6CEEA
	for <lists+linux-pci@lfdr.de>; Sun, 23 Mar 2025 12:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 437F73AB9C1
	for <lists+linux-pci@lfdr.de>; Sun, 23 Mar 2025 11:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E161D95B4;
	Sun, 23 Mar 2025 11:34:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51BA35947
	for <linux-pci@vger.kernel.org>; Sun, 23 Mar 2025 11:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742729694; cv=none; b=fi/+mlv+IIPWBeO2Iq6ADyCBj11/CLkowBoRwrEPCh1JBWao96eFABS92UfO37PmTHrMdQ3myu1rYlgRkCWesOHs9+yaQ+FcpK/c2o2PiMDnx4U7EAjHBlxRpn1JaTZzrJDKXf3jVQcljIwE0K9pR1MEjuJKiWUtCA3yJeUBtJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742729694; c=relaxed/simple;
	bh=HWnCCPJ/Lcl4ww6XEiDCap0VAwJCN71Jk8F78CSZiz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nl2FxH+PS7Qs1z8HETNLcGe9cWae23NhJSF6PwTRlndnYXE+dQuY20rb2Q6yJYKyAhN8L59mafJ7DmGDa+4uKRngG/fLK1/1fGRmpa1qOGeOgQrPSTW0RezJ8vtxDhUvXRrDSyLt3PW7IvwQ5KmTLYFNkXuIibgI1A/3QdcLYkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22438c356c8so65142645ad.1
        for <linux-pci@vger.kernel.org>; Sun, 23 Mar 2025 04:34:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742729692; x=1743334492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tOHj0GW1GZJENpVSJnRo2ruIc2opdrEDVyTAPixSrq4=;
        b=k4UfMTn9CCJSBQ9PqfABVu8CipU9eNEUUb0mzXQz20UgMW7Cs5A122Gpn6pTIWXmqx
         MCzRXmrTCQR/TtBGIeART0LTOp2hzIwu3Vkkk9t/pv0cbpjdzg6pW6tuajvvajKWgYc+
         dL1gR4+vG/F1ad3Ujh/0qZZpspXYn11R8MdXOcR/kNKzOdHkdSVSQ7X975+hKNKf9WdS
         V3FUpHnQEW2QozWuyqdtzmBTHi+LndblrgmzQOVgrlSgaJNWHb7F7h8jjRkkY1iK4WzT
         GyJWbNjK8ksLzeokofb4FpvuaaEH7XwOOtHWH7NSHC/foLo60NFF2sLdvgxF7USYfIy5
         ENwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyv1K8RoycQqR9Q8lquO6LoJrATS7LNixvk848fuXi6twnrVTOjK4jqGdhDVGQ7gy5cLCRo7VWvKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwExPWqzqGyz5p5troWVSARUujMJLVlLz3jXYrSp3DV0QyHwQ8u
	0uX3dKV6yeq7llCYeSBJ9tmoLQVA7lVwyE1QAnsNf5c/M5vfLCkO
X-Gm-Gg: ASbGncu+ro8JKvxCD8nxslD2jraIAwngwXH32yFZZt0u0ogWRXGnxCtalhl0mqwpjoH
	ccFqhiNBLJmwfoWMmTBTv3DCwlxNQ4amdGYqr2fVu/X5o3OGfAqfuL2/U+BtcjtPZjGXlBYjkW/
	sAS4b/B5szkBeHYVT7qxjyYHpi6Omp7s4TUZIm2AcPeJOpvgBEtr0jWlFwlEfxytTr5/lsc+wcx
	4tJNZGpDuY/7KzOxx0b8a9BuChXuS/xRFq6ChU49TDYnhjTb1biP7v2cjtP6EgSd+jizU1Uundc
	DYg3FkQWlPQdgCFL5x22nrIVaiBN3ncRKYSkyUDgEugowQ3/3UqUVpws+O1rx0/cIAiihgyZeEL
	pxeSYaagnVWATmA==
X-Google-Smtp-Source: AGHT+IEYwobMAlsfv2BpqlvW54X4UJx/BPVYNiiH6+DpUEdN0BSadhenVbTUtxQCgQrsIPKaOguAWA==
X-Received: by 2002:a05:6a20:d807:b0:1f5:58be:b1e9 with SMTP id adf61e73a8af0-1fe42f2a289mr14717492637.4.1742729691972;
        Sun, 23 Mar 2025 04:34:51 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-af8a2a479c1sm5059286a12.70.2025.03.23.04.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 04:34:51 -0700 (PDT)
Date: Sun, 23 Mar 2025 20:34:49 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH 3/4] misc: pci_endpoint_test: Let
 PCITEST_{READ,WRITE,COPY} set IRQ type automatically
Message-ID: <20250323113449.GB1902347@rocinante>
References: <20250318103330.1840678-6-cassel@kernel.org>
 <20250318103330.1840678-9-cassel@kernel.org>
 <20250320152732.l346sbaioubb5qut@thinkpad>
 <Z91pRhf50ErRt5jD@x1-carbon>
 <20250322022450.jn2ea4dastonv36v@thinkpad>
 <2D76B56E-00A1-4AC1-B7B5-4ABEA53267CF@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2D76B56E-00A1-4AC1-B7B5-4ABEA53267CF@kernel.org>

Hello,

> >> I'm really (honestly) happy with whatever solution, as long as we, once again,
> >> handle EPCs that only support INTx, or only support MSI-X.
> >> 
> >
> >We will keep your old series as it is.
> >
> >> (Because ever since your patch series that migrated pcitest to selftests,
> >> READ_TEST / WRITE_TEST / COPY_TEST test cases unconditionally use MSI, which
> >> is a regression for EPCs that only support INTx, or only support MSI-X,
> >> which is the whole reason why I wrote this series.)
> >> 
> >
> >IMO, the regression could be simply fixed if you have removed the ASSERT_EQ from
> >READ/WRITE/COPY testcases.
> >
> >But anyway, all good now. Thanks a lot for your patience in educating me :)
> >Really appreciated.
> 
> Don't say it like that :)
> 
> I understand where you were coming from.
> I think if we designed the API today, we would have kept it as one ioctl, and user space could have provided the IRQ type (and/or auto) as a struct member in the struct supplied in the ioctl.

Nobody would object to a refactor, I believe.  Especially, where it makes
sense to fix some old technical debt.

[...]
> I still need to send a patch that fixes the kdoc.

Feel free to let me know what kernel-doc you want added there.  I will, in
the mean time, go ahead and add something.

Thank you!

	Krzysztof

