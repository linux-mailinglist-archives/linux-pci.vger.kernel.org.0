Return-Path: <linux-pci+bounces-11657-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 243DD950DEA
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 22:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57DD61C20E7F
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 20:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2651A7042;
	Tue, 13 Aug 2024 20:27:46 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D5C5588E;
	Tue, 13 Aug 2024 20:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723580866; cv=none; b=RYoFvNvcTlbr8foEIHeQETmmGGoBVoxhZmhDQI8ab0LPmaS+UNlaI10Jwy7UbLAc4BoO+RL33/2UVvdoAOW1c60fukmT0uBHxDGSFumeYE3pUnUqmF4+b26YjUEbl5i1u/+9e+hOtDPdGrXfycwC5DbpkTbYMOB+LwnEtB8TZLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723580866; c=relaxed/simple;
	bh=wIy6hQHxspI+wcpnPtoI8TfqxEpDh9hvlQKiAdVbkdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHf8E1/kesQkrj2YCpOl2c3WuiVgV99N4FoytO9Gr1evkoBZ3rW3JEkskPB0OztYloKTfQY46+hAgbtnkSoyLOukpOYSKKCOebpJI1sIJ/+eJNst5m6YjNXHg+kNxg0cZxnspgvADuxkND3kZzTxaAs6dmapeMmQtHS/iDsRfiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7a1be7b7bb5so4276941a12.0;
        Tue, 13 Aug 2024 13:27:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723580864; x=1724185664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNPi+Cpzin8dakwAyUxxHZPROQtJHgSY7+Fd1TdbD60=;
        b=Ry6UaG4sLcU0H5s6WBJl5FFCT04zKdkJ40LnadE54zPrJrlf1AD9fSeNo8HRpLvC+t
         lozEq8hfl7qr4WixBnLOGOIMaEL8bVt1GVVCKK190+Ls5gzy8s1q1C8Z6W6uNa2Q2F5E
         YJaSVNl7nSgRP1ITRFHwpcqWZyKauNSuHfm486BZo/XMx4T9E6aCZwOvp2fCPr9/GOj7
         RL+6GcDpQT1DwW7viwtyB7441s2MwTRDyodktgvkVlLSjsF9+0LgJzY/pnAkryUrzLD0
         /krv3K0GMQbidk74oICFYejmHhjQpzFX45xN80l2CHY0Okaxi1/UWAiVli0QTmjELKJv
         Px2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUnSA891mXtQ1N7ndLQD+OOAPRCiP0d1dobk/9io1NwkFjOnXCl0QfHM7IFjUAkavV4ONaNFtck/kawKfdcCyp+e2NwRryIuTgvBa9x4ZajOqCZFElGtBCW2PxGWygAzxeAMUQtjlXERUOqRx/80eZxrTsiOXAJI0OiKK/GjJDK86Uj2ekHZw==
X-Gm-Message-State: AOJu0YyE9fFtf4TFM3YRPOOlhF3ftyfVQCZmg0tMAJFz3xv/MMxp31Nm
	TBpHWEqjTxSOyRUXISu8mDUJFhEGWXOkmhnAMIQ+lOyHmQswbp4K
X-Google-Smtp-Source: AGHT+IHLjWCyQm6vs7ZbrVQjCv3bW2BI7tHz/nq0hQhOZlzsoMFv6rBfiw9WfNOKGpA/yz2nK2FjpA==
X-Received: by 2002:a17:903:1c9:b0:1fc:2ee3:d46f with SMTP id d9443c01a7336-201d638d797mr10262175ad.11.1723580863988;
        Tue, 13 Aug 2024 13:27:43 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1bd7dfsm17580695ad.232.2024.08.13.13.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 13:27:43 -0700 (PDT)
Date: Wed, 14 Aug 2024 05:27:41 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, lpieralisi@kernel.org,
	robh@kernel.org, bhelgaas@google.com, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom-ep: Do not enable resources during probe()
Message-ID: <20240813202741.GD1922056@rocinante>
References: <20240727090604.24646-1-manivannan.sadhasivam@linaro.org>
 <uk7ooezo3c3jiz2ayvfqatudpvzx6ofooc2vtpgzbembpg4y66@7tuow5vkxf55>
 <20240813170247.GA26796@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813170247.GA26796@thinkpad>

Hello,

[...]
> > > So there is no need to enable the endpoint resources (like clk, regulators,
> > > PHY) during probe(). Hence, remove the call to qcom_pcie_enable_resources()
> > > helper from probe(). This was added earlier because dw_pcie_ep_init() was
> > > doing DBI access, which is not done now.
> > 
> > ... moreover his makes PCIe EP fail on some of the platforms as powering
> > on PHY requires refclk from the RC side, which is not enabled at the
> > probe time.
> > 
> 
> Yeah. I hope Bjorn/Krzysztof could add this to the commit message while
> applying.

No worries. Added to the commit log.

	Krzysztof

