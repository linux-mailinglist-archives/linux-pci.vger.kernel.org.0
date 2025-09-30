Return-Path: <linux-pci+bounces-37281-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F08A6BAE114
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 18:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F15A1944A5A
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 16:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992B023D7F7;
	Tue, 30 Sep 2025 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QXDWdEhq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECBD23AB9F
	for <linux-pci@vger.kernel.org>; Tue, 30 Sep 2025 16:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759250256; cv=none; b=RPnS8ILdQF4nlFKU+S7jJPknxHdl4S9hyXE6vXz+lLhGmpRUc9KAZ7cUDg5ZLTpMgt1FB5R0M5IGPsxN/kLmH8r+XDp37QgbGoFhNuuv//1C71pen6zU13HnAZzgTVnG/wXBcT2tVKQ8Qe5Jc7a6YuwOW0V534WylcfNnhCx3Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759250256; c=relaxed/simple;
	bh=wZlnhLVWjCo/EoZ8rwJ+2WNDjewuk+/wknr5aB3MEkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADDQV9I6eFzZZsY9Jji6aFU6B0mpnujC9tAxHVEVFmeTbiiwS5MO27/jsNd1A5y5MNpcTzZHRd0vK1UR2YsinbKnhADM1VGFBvxRBoIMmA94h6CnJcjqvpiKSGv/ikUY/OGYXVjGB+AiHUOKSqJfKen8RmouydRybNNHIIrLUCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=QXDWdEhq; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-7ea50f94045so642126d6.1
        for <linux-pci@vger.kernel.org>; Tue, 30 Sep 2025 09:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759250254; x=1759855054; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wZlnhLVWjCo/EoZ8rwJ+2WNDjewuk+/wknr5aB3MEkU=;
        b=QXDWdEhq6DrEERhYXLsV8N2u8lhNdFUKfN8/cQK5terzImXnW+c1KYzeNEIrcu6r9a
         TGXDMnJGDgaqn/+1ZZJR6eJtflG+y+ULwaeQMlVMtRknJLEpbJg1lUcm5ynEWvDjJKye
         O4apiuqGYsjUrhwhNeq01OHMy0TC1Xw4xluczD39vGkXSA3BiiVQMtYd6RKtI7Y0geji
         mXkar18DiCFacXLx42+pZU/mZvibP01gvp0tmUfNezH6mSJ5r9fDjHePGhIvcylzJy42
         beBP2C8wWvZZBgxhGV2ytQMyIvnvWJIlry90DAgF9jz3Ab0fGAb4Dvxu2myyCbWCf259
         2I9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759250254; x=1759855054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZlnhLVWjCo/EoZ8rwJ+2WNDjewuk+/wknr5aB3MEkU=;
        b=DvXV0yb3ZhBgh1w/x1WC8D6BkeSfcu5t7t5cOwoq7V8g9v5MwlfmSuCqN5Tf/DPpw/
         uPS3fRukrRzUT5pxPn2C2Ac73zodiCK/lDozmc9/itf05zRl8WkBwzTRsMxRycPz5V/u
         QvAFyqV5WZbmpZDkg8VaEwsBzfDZkMybz1oxisZ8d49JQolagLLrgrUmYG7dHpY8449w
         Q7WTmOPMwJAyfw6nlWJSGZWybFP/f8jAkZsgR69S7ZmE1ap4DGp+Wp3AkLKX5ZXFnihe
         prUJkt4foG8MQGHaSd9siLIoosxTX7oLWYOIRW6S/4P4ZfO8lfOjXeNdSINMGFjBljRU
         gS9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWBt9G/kKeR6z0TdbbiahMqr0nrYJmbFU+AFGifA9DpA3SQjoU0cP6/jT/jMTBTyrd1XtWm4ko+yQc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn5tiWprxNPrV9wnboLdRUgqleZxgFtiTZ3KiJAwSvZKSuuI57
	3j8xG0X22yGV0oyP4AQGwsIEviN9VJoG7geaBHyd54aona7wlny6oE0PetnLJj4XwSk=
X-Gm-Gg: ASbGncv3H+ynOtWk3k08uJumft4jmMqgt/B8dUc0XAoPIeHElfOvRCKACGUMx0WFYDM
	5YR/qb5HP1db+bOkMI07H/OVtYRVoJTtbYpqDKMEX5jm57a9b30FKP5lXI6cKtShRsBPizlnJec
	uyCmI6yKt1PwN5rtHpmGytTD4qdnTvghBRhYKxNZCsunSuwhxarqr7Aq8q5+jJ3Pn+izJcX31of
	wHzVO6gmqQWdevit7tx86R3RlX6dohIbziayHaJJKgmt5WBNx5otZEoN+ATg+AA2XPZ8+RjbFGQ
	YIhlZ6WqY02sEzwXbwJ1XWa2zqdha0+9Awk63fxF8OULT6EtjmMtf7I2+ZLnKLalhYebu7KFg2t
	QNMrP832NEplPISJhQREcMpXc3dNwAOo=
X-Google-Smtp-Source: AGHT+IFTUouLZO/CN3csdEu5i5OdgDUNjmGvNmvgmP5gfS05E7lB9xEJ9dOZVQrm6wg7EiUAZUUmJg==
X-Received: by 2002:a05:6214:c83:b0:7a7:b219:635f with SMTP id 6a1803df08f44-8737bbfd4ddmr7502266d6.16.1759250253744;
        Tue, 30 Sep 2025 09:37:33 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-801351c328esm99532066d6.9.2025.09.30.09.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 09:37:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v3dM4-0000000CbmJ-21fb;
	Tue, 30 Sep 2025 13:37:32 -0300
Date: Tue, 30 Sep 2025 13:37:32 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Chris Li <chrisl@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, David Matlack <dmatlack@google.com>,
	Pasha Tatashin <tatashin@google.com>,
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v2 06/10] PCI/LUO: Save and restore driver name
Message-ID: <20250930163732.GP2695987@ziepe.ca>
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-6-c494053c3c08@kernel.org>
 <20250929175704.GK2695987@ziepe.ca>
 <CAF8kJuNfCG08FU=BmLtoh6+Z4V5vPHOMew9NMyCWQxJ=2MLfxg@mail.gmail.com>
 <CA+CK2bBFZn7EGOJakvQs3SX3i-b_YiTLf5_RhW_B4pLjm2WBuw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bBFZn7EGOJakvQs3SX3i-b_YiTLf5_RhW_B4pLjm2WBuw@mail.gmail.com>

On Tue, Sep 30, 2025 at 09:02:44AM -0400, Pasha Tatashin wrote:
> The kernel's PCI core would perform an extra check before falling back
> to the standard PCI ID matching.

This still seems very complex just to solve the VFIO case.

As I said, I would punt all of this to the initrd and let the initrd
explicitly bind drivers.

The only behavior we need from the kernel is to not autobind some
drivers so userspace can control it, and in a LUO type environment
userspace should well know what drivers go where - or can get it from
a preceeding kernel from a memfd.

This is broadly the same thing we need for Confidential Compute anyhow.

Jason

