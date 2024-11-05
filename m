Return-Path: <linux-pci+bounces-16066-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1A69BD391
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 18:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 404181F23549
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 17:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B05B1E285D;
	Tue,  5 Nov 2024 17:38:51 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AB21E282C;
	Tue,  5 Nov 2024 17:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730828330; cv=none; b=h0Si992cCl7jnCoaB1vEV7nk+eLZun7lVZEpik+bxnqzsG7kgXj39Y/2pYQtt/Z9+pIrdFWO1V1WLi8ztA9Bi9/T/gp2VauKdEMtyQdo5NTPABvpcjOG9f9CPgcm+9rjyvgOfQkFy69ko2WzSdRh5giy7grOQ+phD5xEiMPygTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730828330; c=relaxed/simple;
	bh=4lVqMlvbVeIaLRC8JY24fuipuiQcsU90cbAOjOhbmfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KlYA9Sj6MIER7Jp7TW2qk94qA7Q1+KVxvzk4Q7+DKcxxAxzSIWk71Hh0BAeeBatMYlJMDMfIiG69Mn3rOz4HbvFEnfuDNI45B82tbPRfhLlrllMLalb724+2oImRQx5Z9IXz8C/GR+GGIVw2By2/wnPFS4paDJlFwko7e0azS+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e4244fdc6so4558995b3a.0;
        Tue, 05 Nov 2024 09:38:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730828329; x=1731433129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PD7THQBIWGT0uMZ+0fdmv+Bq/KO1hinbqgfjxdPvwIM=;
        b=m7Zf8j769mUlbBGtxbcQKZewZdw5xUrSpY2jtE2IDYtwmv/8bO2p2rOcoci/MOMC9q
         RG3JHlRcGBAloJtEqz1uK1obXk0lDkCaKjq5yFiqIcte6lSe8pjxQnAEtfx5xAFd75vR
         leyqe81x/75IZ8aLFdmb8wx+oVWd2w8x/r8DTn8DiTlVoonf0rW5Ym/ivthFm7AfLtC3
         FuqhgMDgzxZb7LgNEONDUmafAyKCtGnODSDAfCGwcbFnu3ouJQCfItU8XnamghU2dA6v
         U/mXF0leSBw9eB5+qz2LI3JsEfia87u2uk/H5pVGwZSFhG2t34Xzoc6Z2PuYs8fDn0OB
         b0yA==
X-Forwarded-Encrypted: i=1; AJvYcCVjq8nCuM9S5MHaNqTsWEeZdV7G8MnOCMyWa454hkV6WSBvhzVqExMQYfzjb3H443S3B6es6u03BOds@vger.kernel.org, AJvYcCX7JIyIQfNA4s9oOsbAKi4vmtma8tCRysZfj02p3oW9ssS21R3CjULNz0GqLHXeSAP2qUrZQ06LW4oXqn8r@vger.kernel.org, AJvYcCXXO8sOqEeBAfENtRHEwEPVZNVsRInDw0zQrN9VWm/WxlP3CjjKYYrGcskL7piJftEMMC93HqvB97sU1bRY@vger.kernel.org
X-Gm-Message-State: AOJu0YzTjs0q7ewtcfUqxXNuN0swTqt/EkJ926siUok5pAcA3/61Rf1E
	oNUDT4NES2xD4HAUe9zyeDxwYaw0SQaAqQrsYJkIseXVptlCNfbe
X-Google-Smtp-Source: AGHT+IG+ht2m85l7VwQoVcTgAteAcpdGNxxC01z797LcY7Qet5QMRhqLO5vLNbROnpbC+W9JL8/TXw==
X-Received: by 2002:a05:6a20:7351:b0:1db:ec7f:609e with SMTP id adf61e73a8af0-1dbec801b78mr6496376637.41.1730828328809;
        Tue, 05 Nov 2024 09:38:48 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee45296c97sm9294730a12.14.2024.11.05.09.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 09:38:48 -0800 (PST)
Date: Wed, 6 Nov 2024 02:38:46 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Zhongqiu Han <quic_zhonhan@quicinc.com>
Cc: manivannan.sadhasivam@linaro.org, kishon@kernel.org,
	bhelgaas@google.com, lpieralisi@kernel.org, dlemoal@kernel.org,
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: epf-mhi: Fix potential NULL dereference in
 pci_epf_mhi_bind()
Message-ID: <20241105173846.GB448500@rocinante>
References: <20241105120735.1240728-1-quic_zhonhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105120735.1240728-1-quic_zhonhan@quicinc.com>

Hello,

> If platform_get_resource_byname() fails and returns NULL, dereferencing
> res->start will cause a NULL pointer access. Add a check to prevent it.

Applied to endpoint, thank you!

[01/01] PCI: endpoint: epf-mhi: Fix potential NULL dereference in pci_epf_mhi_bind()
        https://git.kernel.org/pci/pci/c/ff977d1bf478

	Krzysztof

