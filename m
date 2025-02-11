Return-Path: <linux-pci+bounces-21143-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE21AA30446
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 08:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81B603A472A
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 07:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361961E9B22;
	Tue, 11 Feb 2025 07:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MHjd2KUf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F611D88C3
	for <linux-pci@vger.kernel.org>; Tue, 11 Feb 2025 07:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739258185; cv=none; b=ub3ziGfXkBl1DF6DUP8+VxpeHRPaAhoA4p2cAKK1WAl1tzhqSEzXgsa9zYi7t8DbnBvE4FU4e+C4YsMZXWsm6MPpryWOQHQaIElKl1SdAcaM55TMOsq6J6pxV7EYW6D8aTz8jNIgzLe7boHKQJYFLkRa0nLnKej0DvWmJtfzow0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739258185; c=relaxed/simple;
	bh=23JQ36TVEhIJuxcYkYMPQZyAemXD+2LxuN6tIHqHeuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mg6v31JQwlhLkFEUc/0HXU10PL9+NwXvp1jCXp2Ej6fhJnMWkMLOS12uRxtowpq2jReYRUQMPBzL5rD9xt+IOBpYZ/I4CWsJtTBnhfAymuNC6BIkQRJIneTrbxjmSm6iBrX+X/pOxX8rBijrQbr6pUbKaCcKOMez7ZLLU60Y5Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MHjd2KUf; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-47182317174so27916621cf.2
        for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 23:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739258182; x=1739862982; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=23JQ36TVEhIJuxcYkYMPQZyAemXD+2LxuN6tIHqHeuw=;
        b=MHjd2KUfFNbWR0MOWEmwm3jNE1dmwb2BVr95kMq66UKtF8jq9jN9DIXO+IfxnGvw2t
         pfqmfABTMgcuLRw2TBvUWlag9SE0cpod9nXnlGMm99kQEBy0HrNP+4IjrCLM7OBe2bPf
         kznG08IefdkYUEoh75AGmxdiiQfXUMtUy5KieHZ7SYgc26687pk9gxVBmHxnnmA8udj6
         U8v+d0j2Mjt105lj6c5OxXTdxTi9T5Y/G88OPR/7UQkVE3xS2qtu6OjRaCeJiC4OAil/
         nVW7mhLicZzFhGh+hNLXRoWgQ9M5oV28BZ5ZRUjarSNKSDkzlOus8hitlp4lOBH0YIKK
         WaLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739258182; x=1739862982;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=23JQ36TVEhIJuxcYkYMPQZyAemXD+2LxuN6tIHqHeuw=;
        b=k65O5pYbkQb6Cgk57zdio0/EmAPS5AK5teaG/p3JpTGTMYUrztb+aHBNQn8qw/UHKP
         Fszoy85aJMJN0unQ93mvtbaNKySqpv/AuyJRtMsdyGrToVFszZ0Y3JLlovdHKpex76z9
         3YtffCLkoC2Sc2gI7TW4qocT8uDor7O/zlGS4ZhWOQz7FtpCsWuin69S+dBiwTMMcQXJ
         LVS5HdvUpiDfGc0XgON9ki7prqvbMgOKBOgadfvr806lNxAA16pgWx4GJEImskKwGjYc
         cR30lGnsnWi+QgZ3d3V4/MkemYgdT4naIQJ/98fsuSeTjKzBBMqjXRuD1rS/zFDnE9/6
         LDGQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3wlHDtBIPJu60Yep+uxXlp0hKY4V88+EOqMEM9Z1tfOAm1N9zrq61xZk8LK+kj4AJTI0u8G9Xijo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgIt/kUJOG4r7epZ7njHcUeS9o/TJ52pBGAcLwfWQrtPoCQ+88
	KcowFsTnDQJj4qlXWD3/zyB4qCbK/DD64z9tFdBwiIHBPmKfx7Oe2DkLuA/otLdNUXpmVPKYb5t
	YvVqbzwjJ+Js2VOI5sCF7TT9GsOEkKOqri+9+
X-Gm-Gg: ASbGncuaJg+JJ6mukIzTtaVoEJfPfZ8xe0Fs2i38hJh1u8WJNMG02kmP7eSchIT9V3a
	enbywmKTd29o05wehW2A5ixvPXaThHHPuZX85mloQkmnhkrErxR71hUfSRNffR8UnCu3BaXCVax
	1Bzm3+xGlrJ2AInme+Z9UakqWnBA==
X-Google-Smtp-Source: AGHT+IHGJPzBLfMfDX4rbjVVZRKe1gCvuxI6/egZcKvHi1KXQknI4CJxOBXzuYlsb/XmKGOe30PHCm77sfgEIOzVzoM=
X-Received: by 2002:a05:622a:256:b0:467:7109:c783 with SMTP id
 d75a77b69052e-4716798aeedmr222129971cf.3.1739258182428; Mon, 10 Feb 2025
 23:16:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115083215.2781310-1-danielsftsai@google.com> <20250127100740.fqvg2bflu4fpqbr5@thinkpad>
In-Reply-To: <20250127100740.fqvg2bflu4fpqbr5@thinkpad>
From: Tsai Sung-Fu <danielsftsai@google.com>
Date: Tue, 11 Feb 2025 15:16:11 +0800
X-Gm-Features: AWEUYZl232hOKZ2tswFY4HYWA2Qv1XdtRdfve0UUFTJlcDtsd4-LzE1Mvg4OYWY
Message-ID: <CAK7fddC6eivmD0-CbK5bbwCUGUKv2m9a75=iL3db=CRZy+A5sg@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc: Separate MSI out to different controller
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brian Norris <briannorris@google.com>, 
	Andrew Chant <achant@google.com>, Sajid Dalvi <sdalvi@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi Mani and Bjorn,

Sorry for the late reply, we just found out some problems in the patch
we are trying to upstream here, and figuring out it might not be a
good idea to keep this process going, so I would drop this patch
submission, and come back once we figure it out a better way.

BTW, May I ask why upstream chose to flag this driver with
MSI_FLAG_NO_AFFINITY and remove the function dw_pci_msi_set_affinity
implementation ?

Thanks

