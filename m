Return-Path: <linux-pci+bounces-23184-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4231BA57B4C
	for <lists+linux-pci@lfdr.de>; Sat,  8 Mar 2025 15:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1CFC188FDC6
	for <lists+linux-pci@lfdr.de>; Sat,  8 Mar 2025 14:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D19D1DC19F;
	Sat,  8 Mar 2025 14:58:07 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F96D10F4;
	Sat,  8 Mar 2025 14:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741445887; cv=none; b=Kzqm6gY+TIZ8sJbRVf+udNkgVgPPMm1c8FR0ZgYE64kQKUYezJYbrOgjnnf4N0qBfTGVLHdDqOgcq3Lu9ANhXjgBBAaOwY1nDULHtyelipCQj8Oz0rtMxGIbOOJ2Z5iksZMFpsgwFzmpWRC1KtFbc7JUqTnn3ECl9rl+N09X7oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741445887; c=relaxed/simple;
	bh=hMDlrsxv5N1HhsTBGniC6IAMAhMKkBOp/z2a3zXv6EM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpHiQbmFwBUN6NoiBxuoy4qVdMEMiMB3W2Rb9ul7ZWFlB3MRny/nIWl3xIEhpxvdhVhXvIQL/VoybQrESkV/TOBvceACAwKi1ZRQC6Xls3jNbrehNrIQypzKK0zx0JcV5ZQikUH3XdhkFnK8qoumFqhi3nZAVzzcg/PtH8m7UEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-223fb0f619dso56208545ad.1;
        Sat, 08 Mar 2025 06:58:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741445885; x=1742050685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0KDrEoyP4jGfL5KBLDfRqPR/7suUQU11UZUvsVsBe/g=;
        b=sm/TZDTnMa4qT12vB26GijVV4xCw3UYjEi/b+AktbgSqYGXhMJf0YhL59c6aAcGAna
         6Yh3BqOGQsE1wHC0fAl6Y2/cecrl9lqaZzZonyolJlZkoA78UWlBQd0qlbhT2Ke+Wb8a
         iM4VCLSqz9lN/hKIOaF2QEWGq0mkMcE+SKYarviXt55Ay8aWbAfArC6mcOTAHEjRRJmi
         yHQtS45Nf5S/RupyTuGbu9Q+tdUyrc7aC2bCUrBNH5RC+YuzkBKH0JmwzChj3RkLsgWR
         5iHag5fPBHGNYDeFiQXob976pFPk86oILgE/o4lDUz9Bud0IfPHgn0ZtFQArV+0gR7wu
         QZpA==
X-Forwarded-Encrypted: i=1; AJvYcCVoKyI+9O3JL7ccvMsbHMGChXWcgBTW118WYfPPfiz0bG+sPpHbfy0R5JhPOs4KwWKxqtXkpzGQD59H7wS9@vger.kernel.org, AJvYcCWnAEfxutFUmlbc2ZpyIEy+RAcHNwMnvLprQ6pHaQj7TNw1yesiRAV2N+ghu6j3qvZScN8QlpHLninZ@vger.kernel.org, AJvYcCXSwEAVOkZvDeQG6EtreupGDRbvaWI5kkPbQ/gJ3ykBTS/HPWrpW8QLRxWY2Rg/HIJpnV0DJsC+UPEc@vger.kernel.org
X-Gm-Message-State: AOJu0YyjknVm8G6dzjUK3UO92vws76Ckvc8C9IkmpAmCDLw1z2YE7yBb
	Br/jrqs4k5ngbtfa8JjII4j0IGFXsewk1HeGtH5o0JW58Pueh5Kl
X-Gm-Gg: ASbGncv0nEtF7YJq5V6X4dD1XUizOaIPGpyJgPav7rw2dT8T81aGjBh0MEvBQEIWuEN
	Gg3SnxnvsIxskeBxB9xhUUoB9SHmpbK+hdu+iKhzI+aIkcgwZ9JGZwrJEnbV5sol8rx89iPLWaR
	tV+Wo8ip6mEXISd3OYWDMOXnkX1rgvwb5e1hs9VJoO1H/y3H8AWzAUczQCU9A637WmpZl0nM6Ey
	UmtJmyM7efR+3qqPP7QSgjI58zInnb7aEyZ83bZflytFdqRTpq0bFFs1zzMp7dyMmKe7cC8Od1G
	CKaj9Gdi4Bl5N0gHWzQcNuk68IzFRGpUMPj/b7ss/QjRTG9veALmQfNth7lkRAXh6bd4wsEegrD
	YfQE=
X-Google-Smtp-Source: AGHT+IFrki4JZBZlTOdD9wNIdmnZOMDK+QF1rINfsxHIZ8KiUTgx72Vi+I+qLYVyzk80DV0WCZDW6g==
X-Received: by 2002:a05:6a21:6d96:b0:1ee:c7c8:ca4 with SMTP id adf61e73a8af0-1f544c92b65mr15412514637.36.1741445884819;
        Sat, 08 Mar 2025 06:58:04 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73698514f58sm5236020b3a.133.2025.03.08.06.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 06:58:04 -0800 (PST)
Date: Sat, 8 Mar 2025 23:58:02 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: PCI: fsl,layerscape-pcie-ep: Drop
 deprecated windows
Message-ID: <20250308145802.GA482803@rocinante>
References: <20250307081327.35153-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307081327.35153-1-krzysztof.kozlowski@linaro.org>

Hello,

> The example DTS uses 'num-ib-windows' and 'num-ob-windows' properties
> but these are not defined in the binding.  Binding also does not
> reference snps,dw-pcie-common.yaml, probably because it is quite
> different even though the device is based on Synopsys controller.
> 
> The properties are actually deprecated, so simply drop them from the
> example.

Applied to dt-bindings, thank you!

	Krzysztof

