Return-Path: <linux-pci+bounces-13168-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 576A5978075
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 14:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BD44283C45
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 12:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E231DA607;
	Fri, 13 Sep 2024 12:51:12 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE6B1D932A;
	Fri, 13 Sep 2024 12:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726231872; cv=none; b=LyyFXlQXTmMJDZCWCgTRdL1vGCzGxV45pD6kLhYpq7Fzk4aaY89dFdJNc7s9BScCq43fUb77Oe4jhJHzcLwSuuoPvYdNc2DI9q4v6ruJzsI7QKrFmfRogxtz1Ell8TVNQW6yzqhQJc4SVjALNa4G/2N1FF3QWsV1+0Ws4Xke23Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726231872; c=relaxed/simple;
	bh=0LPaUu5x8MBadWhHlLdNsEAYT7/cokc0hK8NodyyRm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IS/Bc3IV9/uaYIIq2BEx+aXvJaCnrWblEt4MAfLNmgS3hOhLOVMlq5RRNADfyxLJpDohUJilo4unQor78FrCuGU24UyjlkR82jpaC2bWZ25Xe/tW3SxpY0BKn2oqHmgVeHuzY76ifYOly7RW9ZdWrYutajv8fkau+hIE+cvRy0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71798a15ce5so2248328b3a.0;
        Fri, 13 Sep 2024 05:51:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726231870; x=1726836670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=az9LZKLKvqGpXpJsC4psjWXdanadCOEEk6UxUCZj28c=;
        b=dmRqmutnWnGnaSAs8HSIoxZx6gn+fDq8SIklJ59aO+SOQIHyf1lTYzjFLSuHEfO322
         Tlf06T0Q6hca+8iA9+DflczPOoKWaHBR0H1hLkC+A55zVE3eYIxN+55c9dZZv74rykEt
         lv1YtjPuhNUh8aumEsqBzZIHyPIyTjf3LKy4sj7qowkzoLr4Gd+G22wFEbifT9lq/p38
         v+RlW+hNktiSDW2XjCOYyX8fG3DyyLpDf1ubRt63iFIMB9g+4GxWSE4cbn3/LRS9Qh93
         1M34/XBoSAzk1LqqhsC7B5B/jRiUupwxSuMHJ98lMtY5bkzg9CrpODyaepzA/SzPBGv7
         d76Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/OXL6oIAtq3GJL6mBGbzWCIyfSP2PkoFBw5c5FglLQqTArIMA6fAlgXa95AUb5vEF2To9ZMYKcZn5@vger.kernel.org, AJvYcCXxESbfFc9gid+6ILXK26XH3TqDy0O+yiYibsCH2SLZW9yManWqaGl/Ddce+NauTLIq12DgvQs/3uZ6SKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxerixP4J98j5c9LirYiR4A5MmugJ96kRMZqiYzj05Cr0QxTj2s
	fKT3RDLPDzPr4l7yi3nqtl1iw/+TGaA5dRUA9mHHexeBKQAEhRrBFL1E+9vw8IA=
X-Google-Smtp-Source: AGHT+IFvDY8HsW6dPm18BZIKkQepmKQQRzZd7YstkeK+LVaQPXsOLIZhxJ7MozSPKGLyFs9IJhn6KQ==
X-Received: by 2002:a05:6a20:db0a:b0:1cc:d5d1:fe64 with SMTP id adf61e73a8af0-1cf75613f2dmr10631941637.14.1726231869636;
        Fri, 13 Sep 2024 05:51:09 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71908fcecb5sm6259033b3a.16.2024.09.13.05.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 05:51:09 -0700 (PDT)
Date: Fri, 13 Sep 2024 21:51:07 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: helgaas@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, delineshev@outlook.com
Subject: Re: [PATCH] PCI: Mark Creative Labs EMU20k2 INTx masking as broken
Message-ID: <20240913125107.GA964006@rocinante>
References: <20240912215331.839220-1-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912215331.839220-1-alex.williamson@redhat.com>

Hello,

> As reported in the link below, a user indicates this device generates
> spurious interrupts when used with vfio-pci unless DisINTx masking
> support is disabled.  Quirk the device to mark INTx masking as broken.

Applied to quirks, thank you!

[1/1] PCI: Mark Creative Labs EMU20k2 INTx masking as broken
      https://git.kernel.org/pci/pci/c/2910306655a7

	Krzysztof

