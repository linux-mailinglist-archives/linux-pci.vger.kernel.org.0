Return-Path: <linux-pci+bounces-22895-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C706A4ECC8
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 20:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CFE08E044C
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 18:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1705205E1C;
	Tue,  4 Mar 2025 17:55:01 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DB01EDA1F;
	Tue,  4 Mar 2025 17:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741110901; cv=none; b=c1cPXyZI2LHFQ7ZNAHzGelmVuQ4cBi/u8c000RvElfd6/Vld538/Y3c7IGJDer8H9YwX/ioK3Adu7OSgKl9ZzSpS8YVTr/zC/plIDPMEfgunfrIhbPxF+9FrF8++6C+lThIen3lpufD2wmYNPj6oi0p7fi7tgYbNHBrfq3WiWsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741110901; c=relaxed/simple;
	bh=DUjiYTnLxlhv8wDbjX4gEl2kqFYHHOYRD6BpYAzTA+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p97WLbYQ2RxLP0WgzV+2ISVip7N4OhA2XXU2p8oyxEjgqQlj6iMd+/+z2uXu5cJdqrDQdz+9V7an6ofGxmsvMH2d7ADDKZCg1/ow7+56AawOrlv8/Smwo34DLQueaClH8ojAJye0YVayoCAyeq3VkacmSyfScMk/Q/ye3RDl/YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2232aead377so116857885ad.0;
        Tue, 04 Mar 2025 09:55:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741110899; x=1741715699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awHUw86wmAjtFZl9KswCDV7V33b+lKzle+H1DTBoaPk=;
        b=C7/bNEtNGE4vvKbma0bNWkEOMHxAboBCso+dDxhcNppU2wxewOLStGesdNwk+X05ZS
         G0AMs3tDAXxK/OM3RKVBRzI088/p43gU22XVRKTjDA11UUAbRTewJEOxqNHkJGwKHJr/
         5fnZnyMcuPdXh99nFjlr0C5dHVrz9FoStMITCt7M4+tMsrGM0QslT152yBMArbXr6q5g
         4JxzrY5dvH/x9D/xT+SgaYLMU5CrNGnmIRFzUO47YI9I0LphyHl2jjg+mqQcExyjnSvJ
         M6SQr+Zjy68J26nVrRPS0NWeZ6pfL1jn+XLjifp5gana54sw9wgIv5/g3McI+X8rNNuY
         qwCA==
X-Forwarded-Encrypted: i=1; AJvYcCUcQcu5ayjaCSHU32mUXfZM8Ao7hI/DMIB8+qETXHVLKGqNZDJzIhgMDiYigwbNArs5jnvgF8ZbQqhS@vger.kernel.org, AJvYcCXILnSiHNEfCXlPgodYDlswn30fzEfayy8IEe6tzZUPlfnU4zWH4+Nd+psHIikL7oIObPEv4//ntCAYnF0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydp4nPQDRsSNAbkZNHdR5ekUA7oXGPHeKL0FDL8/oQotPqXccf
	ddGYRbFay/eDcD2oOMMFe3BKhFnQBFJB68Fhnec7WuJsK8PPWO4iwRnl4HIea2A=
X-Gm-Gg: ASbGncto+Kmid4+JZn9ET54yXVC5rQZkTFd/g36VJdzWeX0+ce4pBB1kj4lml6gRiXj
	+jSeCPQyuerTILTD9NIQx4eDZhAnmpCfIn2V1fkHdt6qkgomF6f9qhmRHdvbANw985Chm6NU10c
	fKDH7Lq8DcQQcEVQHxwPki/i4Kc2PjWJ8Vj8nhdV/TNshlTFygVRHFCtSmpawX6kK7FWYTdA19F
	UiItYaoHhmpk16Ok+wlKDyijKzCYvzyzivZ/Y6+H2vxlZFPA8wRhfM9GeUx0gbxSTUW0TfyryDR
	fua5lJEisj8B9GclKZ3MfkYuIknLrzzGEroFq5WJtdUt5ug0sotM1wQutN4NkBc0YFgnkPpLZ84
	mqME=
X-Google-Smtp-Source: AGHT+IEdCgobHmMRJKN0C7hzvDFvHPwBM5qCFaLu9E/6AX2zBtm2N5q46Y1Zm54WVl2Vdqx2ZXH2sQ==
X-Received: by 2002:a05:6a00:a1e:b0:730:8ed8:6cd0 with SMTP id d2e1a72fcca58-734ac42ed49mr28645877b3a.16.1741110899547;
        Tue, 04 Mar 2025 09:54:59 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73659b81cb1sm3982091b3a.169.2025.03.04.09.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 09:54:58 -0800 (PST)
Date: Wed, 5 Mar 2025 02:54:56 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/8] PCI: brcmstb: Fix error path upon call of
 regulator_bulk_get()
Message-ID: <20250304175456.GE2310180@rocinante>
References: <20250214173944.47506-1-james.quinlan@broadcom.com>
 <20250214173944.47506-5-james.quinlan@broadcom.com>
 <20250304150313.ey4fky35bu6dbtxd@thinkpad>
 <CA+-6iNyuQskVNjAuX1QcLTPetbfhogGYUTOA01QwNw9YcwAdNQ@mail.gmail.com>
 <20250304170735.x25c65azfpd7xmwv@thinkpad>
 <CA+-6iNzvqnZB=7kRqUm5ie6245AM5ObeVmMNQ_S4AtMLD0jKQw@mail.gmail.com>
 <20250304173209.bq2lpijsea7aufpu@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304173209.bq2lpijsea7aufpu@thinkpad>

Hello,

[...]
> > > > > > -                     dev_info(dev, "No regulators for downstream device\n");
> > > > > > +                     dev_info(dev, "Did not get regulators; err=%d\n", ret);
> > > > >
> > > > > Why is this dev_info() instead of dev_err()?
> > > >
> > > > I will change this.

I can update this directly on the branch if you want.

> > > > >
> > > > > > +                     pcie->sr = NULL;
> > > > >
> > > > > Why can't you set 'pcie->sr' after successfull regulator_bulk_get()?
> > > >
> > > > Not sure I understand -- it is already set before a  successful
> > > > regulator_bulk_get() call.
> > >
> > > Didn't I say 'after'?
> > 
> > Sorry, I misinterpreted your question.  I can change it but it would
> > just be churn because a new commit is going to refactor this function.
> > However,
> > I can set  pcie->num_regulators "after" in the new commit.
> > 
> 
> If a new patch is going to change the beahvior, then I'm fine with it for now.
> After all, this series is already merged.

There is still time if a follow-up patch would be of benefit there.

Same goes for

	Krzysztof

